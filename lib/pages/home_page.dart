import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  GoogleSignInAccount? user;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        setState(() {
          user = account;
        });
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: user != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    appBar(),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Hello, ${user?.displayName}!',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )
              : Container(),
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FaIcon(
          FontAwesomeIcons.google,
          color: Colors.amber,
          size: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: Image.network(
                    user?.photoUrl ?? '',
                    height: 50,
                    width: 50,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35),
                  width: 13,
                  height: 13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      color: Colors.green[300],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/images/menu.png',
              width: 30,
              height: 30,
            )
          ],
        )
      ],
    );
  }
}

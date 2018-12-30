import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.co/api/people";
  List data;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "Success";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restrienve JSON via HTTP get"),
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext, int index) {
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Container(
                        child: Text(data[index]['name']),
                        padding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

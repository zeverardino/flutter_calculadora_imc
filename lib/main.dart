import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String _infoText = "Informe seus dados!";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }
  
  void _calculate(){
    print("Entrou Calculate");
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    double imc = peso / (altura * altura);
    print(imc);
    if(imc < 18.5){
      setState(() {
        _infoText = "abaixo do peso (${imc.toStringAsFixed(2)})";
      });
    } else if (imc >= 18.5 && imc < 24.9) {
      setState(() {
        _infoText = "Peso normal (${imc.toStringAsFixed(2)})";
      });
    } else if (imc >= 25 && imc < 29.9) {
      setState(() {
        _infoText = "Sobrepeso (${imc.toStringAsFixed(2)})";
      });
    } else if (imc >= 30 && imc < 34.9) {
      setState(() {
        _infoText = "Obesidade Grau I (${imc.toStringAsFixed(2)})";
      });
    } else if (imc >= 35 && imc < 39.9) {
      setState(() {
        _infoText = "Obesidade Grau II (${imc.toStringAsFixed(2)})";
      });
    } else {
      setState(() {
        _infoText = "Obesidade Grau III (${imc.toStringAsFixed(2)})";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _resetFields,
              icon: Icon(
                  Icons.refresh
              )
          )],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.green
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                  controller: pesoController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Informe o peso";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.green
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                  controller: alturaController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Informe a altura";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular?',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: EdgeInsets.all(10),
                          foregroundColor: Colors.teal
                      )
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 25
                  ),
                )
              ],
            ),
        )
      )
    );
  }
}

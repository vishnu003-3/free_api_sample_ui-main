import 'dart:math';
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_test/model/products_res_model.dart';
import 'package:token_test/utils/app_utils.dart';

class HomeScreenController with ChangeNotifier {
//create variable to store products list get from server
  List<ProductModel> productsList = [];

  Future<void> getProducts() async {
    // setup url
    final url = Uri.parse("https://freeapi.luminartechnohub.com/products-all/");
    try {
      // call api
      final response = await http.get(url, headers: {
        "Authorization": "Bearer ${await AppUtils.getStoredAccessToken()}"
      });

      // check statuscode
      if (response.statusCode == 200) {
        //convert data to model
        ProductsResModel resModel = productsResModelFromJson(response.body);
        // store data to variable
        productsList = resModel.data ?? [];
      }
    } catch (e) {}
  }
}

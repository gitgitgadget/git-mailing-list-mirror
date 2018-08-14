Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F5C1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeHOBQb (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:16:31 -0400
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:55008
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbeHOBQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPjHWW8a5kUQXgXmOvS0VAuXhFCh+0Eoi6ar5JS7huk=;
 b=mz/fzflfYUf/hFHf23R1x0gX+cA2SryQW+jRvEIaC315bkSbZ2KR7Pi1sCha18WF78Dd2uYKyAcuugnmKxq4wthEDBNdFR+McwyfBLn3+MrQBse8zXZYxnAg+RRAjgS1/bwKxW54SRFEnBZHAWFseEN7jdGnV4zcu6K/ylD8GMM=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0685.namprd10.prod.outlook.com (10.163.135.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Tue, 14 Aug 2018 22:27:11 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::488b:a298:2f2c:9855%4]) with mapi id 15.20.1038.025; Tue, 14 Aug 2018
 22:27:11 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git submodule: 3 modules same git repo?
Thread-Topic: git submodule: 3 modules same git repo?
Thread-Index: AQHUNB3xm096OkJ4qk2qTnVFkeQ2Fw==
Date:   Tue, 14 Aug 2018 22:27:11 +0000
Message-ID: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB0685;6:4TTWDhR+oI8LKYXH3B72MZPmIsY0JdbUsVAOZfQfpR9Xm//IXIBlZ7l3vlKgve7RamFJKdc1WgPWhPdFNGhPyDafrgqRQehHZTYpFP4JOwXspWWrTPLc7oLmN6I9UWeN4xXR59J6JSHeuAJHwuNu7JRF6HtdPpKXAa4QdFhF6BHrakdDIY5bbwNqKychTQulkC2SW3df3T/WrA7ksh+Z3gUH389QVKkOI8UkI22injnj47HSyTAbhweUF/Sq0kJipQW7UI+RL4KR4xriWuzr80Xq4Nry95frkD3E63gi+sWn2oGahlxMqgSiunInHYOi8Hh98HQQZWVCNoJN208u7FYD6uRPcpcvNErgsA95cqM6qHSJ+ThFFIt+vRuhpJk4iF/5V2fkdVGwmiN9B/gnlrR0mmsnmnL1CD6fQVghJk/uYPQKCI56hNHDXTXfSGMpVszaeJO6DaFhindJiT42aQ==;5:Sk1kVJw4LAvFdRd33ninsrCYRTre2sb6z8KpQN2SDqf/nvel9Mr8DPcBqLa4WGt1AmBstbAPvHwdqxa4rZfQ+IzDoyZ4k/IWeQg50NVwjvQ2LBl4cAoNqsih4rsXSdPsN+FUw36jRDcQC6lcCoL/epcC5hzD+qoQRmpwDMndNhI=;7:bYo+QrgoZkU2L40ImvhbMMYPRy6tcFeJ1W47IYvK9RIQVFUCCo5snaeQ+Vnq5ZPVjRmIgrngFg1DaabRlrd6Oo0tA4k4kfJWQEe8qoUakLN16PN5Nh9YZn0pDz9wQu56JL9qpQlQCRRxQMLxP4lBfJ57IT7JPUuw11fatIM6gly0FvhzLKOwsfTJLIdyk+hLD1aB/+xaPXMKg2mtAIzWV3WitaRlrcVEMR2NFVndR0gEInljFQYmXo1prhN9GTCJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d1d6f265-97c0-444d-69fb-08d60235141d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB0685;
x-ms-traffictypediagnostic: SN1PR10MB0685:
x-microsoft-antispam-prvs: <SN1PR10MB06850F3B912E3FAF4F2BA86FF4380@SN1PR10MB0685.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR10MB0685;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB0685;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(72206003)(2351001)(316002)(99286004)(5660300001)(6916009)(2900100001)(14454004)(478600001)(25786009)(106356001)(105586002)(36756003)(53936002)(8676002)(6506007)(186003)(1730700003)(68736007)(97736004)(118296001)(2501003)(305945005)(81166006)(66066001)(256004)(5250100002)(486006)(2906002)(6512007)(6486002)(476003)(6116002)(8936002)(6436002)(5640700003)(2616005)(86362001)(81156014)(7736002)(3846002)(102836004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB0685;H:SN1PR10MB0736.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f8QqwqigPO2hIAcQ6FA6V5BT7Sh0ICgycP6ZVHUKXYG+Mi9omt5lMqRZZR206kJ3W8dNMX73gIvx0VswAxwmlrBwW6hKgDih/gIGu7qhPAm7fV1V5OEKMg2B8c32i2+g7B+9lf//9VNOEwTeGoRxSnRMkFXuTFEBpl2HvxvIMMRpipS+yz/D444jkVzxmb5NqI5SAOT4Q8reJpMoiLErsBWBu+jnQL1OSurmZmaVVLwTByilzHlqiGumLjRBwwZs/CIB1SvOp65KZWHs3rH5q3wNM11XEiqcnmxDUjT+m6kWOxCqhhboTTCUoLj5GzxTj0EecSYi8PD1RbjCkzJl3nbKOdds7ucMtQJFk98A9NU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4D62A981FF3A8429449AE4D10DD2993@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d6f265-97c0-444d-69fb-08d60235141d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 22:27:11.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0685
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBhbSB0cnlpbmcgdG8gY3JlYXRlIDMgc3VibW9kdWxlcyBmcm9tIHRoZSBzYW1lIGdpdCByZXBv
LCBlYWNoIHBvaW50aW5nIHRvIGEgZGlmZmVyZW50IGJyYW5jaC4NClNpbmNlIHRoZSByZXBvIGlz
IHNvbWV3aGF0IGxhcmdlLCBJIGRvbid0IHdhbnQgdGhlIDMgc3VibW9kdWxlcyB0byBjbG9uZSB0
aGUgc2FtZSByZXBvIDMNCnRpbWVzLCBJIHdhbnQgb25lIGNsb25lIGFuZCB0aGVuIGhhdmUgdGhl
IDMgc3VibW9kdWxlcyB0byBwb2ludCB0byBkaWZmZXJlbnQgY29tbWl0cy4NCg0KSXMgdGhpcyBw
b3NzaWJsZT8gSWYgbm90LCBjb3VsZCBpdCBiZSBhZGRlZD8NCg0KICBKb2NrZQ0K

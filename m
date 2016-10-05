Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9190A1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbcJEQUN (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:20:13 -0400
Received: from mail-db5eur01on0119.outbound.protection.outlook.com ([104.47.2.119]:55617
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753900AbcJEQUM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:20:12 -0400
X-Greylist: delayed 25225 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Oct 2016 12:20:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lacroixelectronicsnet.onmicrosoft.com; s=selector1-sofrel-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8zCwj4xe1Ku6TxiqgG0l7z1XI1AbbDVLc8JRMxVBXGI=;
 b=KVEq3F9FFcmc2mndVKNWDrS15sr9S/WnsgzEMU4ckG5Om+sxXCrACplKgBUiSw7Co9VZCD1KTcjF+C+VELGnucT2wXUT6NdllmJ/yLxvGtYX1M2rVm6BWeWTJjie6AYcPOLWB6ZoTSlc/ey0Wy9V9eiRiw843mvcEHTFtNSRGTo=
Received: from HE1PR07MB0809.eurprd07.prod.outlook.com (10.162.24.148) by
 HE1PR07MB0809.eurprd07.prod.outlook.com (10.162.24.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Wed, 5 Oct 2016 08:45:56 +0000
Received: from HE1PR07MB0809.eurprd07.prod.outlook.com ([10.162.24.148]) by
 HE1PR07MB0809.eurprd07.prod.outlook.com ([10.162.24.148]) with mapi id
 15.01.0649.021; Wed, 5 Oct 2016 08:45:56 +0000
From:   GAUTHIER Geoffrey <g.gauthier@sofrel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: gitk and hook script
Thread-Topic: gitk and hook script
Thread-Index: AdIe5MW5MXfgf+4bSEGP3bnkwDcFtQ==
Date:   Wed, 5 Oct 2016 08:45:56 +0000
Message-ID: <HE1PR07MB080923D712AC680DC493E033ECC40@HE1PR07MB0809.eurprd07.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=g.gauthier@sofrel.com; 
x-originating-ip: [109.3.175.58]
x-ms-office365-filtering-correlation-id: 45710b7d-68a5-4ca2-e955-08d3ecfc05d5
x-microsoft-exchange-diagnostics: 1;HE1PR07MB0809;6:0o285G7j1L60krZT9ps8NHcvyincbMCB8HsVlx2v2jegd6M8TnYadr/g2GOq6AuQuZlkGRaPoicsqDfvrTp6l+K4pmAQV8YkTGisDbzEe2a+F//yiYZhDvojNWwam9QSiRy1p9MFER4vtf58rxm9B3hYCtLZekHbsSpeEYie9zQbPja1Xespve0Xn4yxNMzSiSN33pnoQNxNdrMw+nNDiD2lKeg1n1zw3kC5pzpFGqITTxzfQxjmODr99z7QFFcnhPpCdWZ4DCCxsBiGo1Od2G/Mvt2V9fIIBWYw/Thp2655IMy7IcTcVDTp5K3jNgeq;5:qfVEVnbdispmMNrYkFHYB72TfYSfkMO+6F0Po+eesvC9279ZDWVfi7Trqp5wSZnMD6SA9Kpd57K+doDptBIH6bbxxhbcNHfqnXib6jeCcKoPCyIJwNr/W9ab+SwoQFgmpdnVRi33obXEBt4B+vFjrevoFXNgsy2AmCv5kSyDR4M=;24:Sx5aF8s0OAEHFgOEXas4uiSbjulg/E2z/43MAocJ9jOkT5NJ5mmUJHlY+vC+FOHnILsXgmd42K2DM7yGozE9eAaTbMqjUrzqjOwFfKgJ5z0=;7:UplThkmYg6AGReLAw5tvyPuZOS0hZVD1oMG2fNNO8paJntw8J9abxbpKjv1jizcKTXDJNc8ZvhKjsa1NwAZ5vhZkgndYZFrS8emROpsEjyCxec5P3ErA4XNePwZrd6FMtfCLJQaGfnb/9q798trRe964AIZYJ8rLKGQw71PqxziJcdYKRtatmdQ5mc5Bdbsotu1tHQAmXxd9r5YEhMM9KxnXZrHNuQ3AOVASVSe4OVIE2LGZjH3DmyqSBcdGlXEZmioVKgBe1/ZFLIusP3IMBYgy8cn7HO4U/EvtQzzoDdTEcIGcVm01051c6tG6Vdr7X191znAGJF7ZOr7vP/8mcA==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB0809;
x-microsoft-antispam-prvs: <HE1PR07MB08095BCEAA4BD7D6C3538211ECC40@HE1PR07MB0809.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:HE1PR07MB0809;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB0809;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(189002)(199003)(2351001)(97736004)(229853001)(81166006)(2501003)(81156014)(101416001)(11100500001)(8936002)(86362001)(66066001)(189998001)(106356001)(9686002)(3280700002)(107886002)(105586002)(50986999)(3660700001)(5002640100001)(54356999)(2906002)(5890100001)(122556002)(10400500002)(110136003)(8676002)(74316002)(450100001)(3480700004)(68736007)(102836003)(7736002)(3846002)(92566002)(7846002)(6916009)(87936001)(305945005)(586003)(1730700003)(76576001)(33656002)(2900100001)(7696004)(5660300001)(6116002)(77096005)(140573001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB0809;H:HE1PR07MB0809.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
received-spf: None (protection.outlook.com: sofrel.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sofrel.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2016 08:45:56.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b2a8e75-023d-41d3-9093-f8eb539d2580
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB0809
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sDQoNCkkgd2FudCB0byBkZXBsb3kgYSBob29rIHNjcmlwdCB0byBjb250cm9sIGZvcm1h
dCBvZiBjb21taXQgbWVzc2FnZS4gRm9yIHRoaXMgSSB1c2UgdGhlIHByZXBhcmUtY29tbWl0LW1z
ZyBzY3JpcHQuDQoNCkkgd2FudCB0byBjaGVjayBpZiB0aGUgY29tbWl0IG1lc3NhZ2Ugc3RhcnRz
IHdpdGggYSBudW1iZXIgb2YgMyBkaWdpdHMuIElmIHRoaXMgaXMgdGhlIGNhc2UsIHRoZSBzY3Jp
cHQgcmV0dXJucyAwLCBvdGhlcndpc2UgMS4NCg0KSXQgd29ya3MgZmluZSBmb3IgYW4gdXRpbGlz
YXRpb24gd2l0aCB0aGUgZ2l0IGNvbW1hbmQsIGJ1dCBpdCBkb2Vzbid0IHdoZW4gdXNlZCB3aXRo
IGdpdGsuIFdoZW4gc2NyaXB0IHJldHVybnMgMSwgdGhlIGNvbW1pdCBpcyBub3QgYWJvcmRlZC4g
SSBkb24ndCBtYW5hZ2UgdG8gZGlzcGxheSBtZXNzYWdlIGVpdGhlciAoYW4gaW5mb3JtYXRpb24g
bWVzc2FnZSBleHBsYWluaW5nIHdoeSBjb21taXQgd2lsbCBiZSBhYm9ydCkuDQoNCklzIHRoZXJl
IGEgd2F5IHRvIHVzZSBob29rIHNjcmlwdCB3aXRoIGdpdGs/DQoNClRoYW5rcy4NCg0KUFM6IEkg
dXNlIGdpdCB2ZXJzaW9uIDEuOC41LjMNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQogVGhpcyBlbGVjdHJvbmljIG1lc3NhZ2UgYW5kIGl0cyBhdHRhY2htZW50cyBhcmUgY29uZmlk
ZW50aWFsIGFuZCB0cmFuc21pdHRlZCBmb3IgdGhlIGV4Y2x1c2l2ZSB1c2Ugb2YgdGhlaXIgYWRk
cmVzc2VlLiBTaG91bGQgeW91IHJlY2VpdmUgdGhpcyBtZXNzYWdlIGJ5IG1pc3Rha2UsIHlvdSBh
cmUgbm90IGF1dGhvcml6ZWQgdG8gdXNlIGl0IGZvciBhbnkgcHVycG9zZSB3aGF0c29ldmVyOyBw
bGVhc2UgZGVsZXRlIGl0IGFuZCBub3RpZnkgdGhlIHNlbmRlciBhdCBvbmNlLiBMQUNST0lYIHJl
c2VydmVzIHRoZSByaWdodCB0byBpbml0aWF0ZSBhbnkgbGVnYWwgcHJvY2VlZGluZ3MgYWdhaW5z
dCBhbnkgaW5kaXZpZHVhbCBhbmQgb3JnYW5pemF0aW9uIGluIGNhc2Ugb2YgdW5hdXRob3JpemVk
IHVzZSwgd2l0aG91dCBwcmVqdWRpY2UgdG8gcG9zc2libGUgY3JpbWluYWwgc2FuY3Rpb25zLg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiBDZSBtZXNzYWdlIGV0IHNlcyBwacOo
Y2VzIGpvaW50ZXMgc29udCBjb25maWRlbnRpZWxzIGV0IGV4Y2x1c2l2ZW1lbnQgdHJhbnNtaXMg
w6AgbCd1c2FnZSBkZSBsZXVyIGRlc3RpbmF0YWlyZS4gU2kgdm91cyByZWNldmV6IGNlIG1lc3Nh
Z2UgcGFyIGVycmV1ciwgdm91cyBu4oCZw6p0ZXMgcGFzIGF1dG9yaXPDqXMgw6AgZW4gZmFpcmUg
dW5lIHF1ZWxjb25xdWUgdXRpbGlzYXRpb24gOyBtZXJjaSBkZSBsZSBkw6l0cnVpcmUgZXQgZCdl
biBhdmVydGlyIGltbcOpZGlhdGVtZW50IGwnZXhww6lkaXRldXIuIExBQ1JPSVggc2UgcsOpc2Vy
dmUgbGUgZHJvaXQgZGUgcG91cnN1aXZyZSB0b3V0ZSBlbnRpdMOpLCBwZXJzb25uZSBwaHlzaXF1
ZSBvdSBtb3JhbGUgcXVpIGVuIGZlcmFpdCB1biB1c2FnZSBub24gYXV0b3Jpc8OpLCBzYW5zIHBy
w6lqdWRpY2UgZCfDqXZlbnR1ZWxsZXMgc2FuY3Rpb25zIHDDqW5hbGVzLg0K

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527591F454
	for <e@80x24.org>; Mon,  4 Nov 2019 15:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfKDPaR (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 10:30:17 -0500
Received: from smtppost.atos.net ([193.56.114.176]:7789 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDPaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 10:30:16 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 10:30:16 EST
IronPort-SDR: 2n3FnsoLXg+3nGDz5fXNh81SvmGuHBW73lScLTsNhUSmcIbUv/NhFia7C6pEyLsCq+cBodUZKT
 huLllbaCRbPHcycGPFjk0e7OJP6RfN9qDcuu7xGBA7ARlmBPkRW/Uc1XeQo8m7fKgtGp1nXhnH
 OmYesmGmSfmOO6ZeiFfe+27kQL/1tSegtGiCLkySfwxJSEdjsf8JgDBA0IC/1dkDCfNsDrjy8l
 6/gxdV3i11d9mz+Sys2lwHE0O/6AnrAQhJvl4lhuVnMjxfgTgIBbPpk9BAINJD7zVb+BFBRwi1
 c2Y=
X-IronPort-AV: E=Sophos;i="5.68,267,1569276000"; 
   d="scan'208";a="24561835"
Received: from mail3-ext.my-it-solutions.net ([217.115.65.14])
  by smtppost.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 16:23:07 +0100
Received: from mail1-int.my-it-solutions.net ([10.92.32.11])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id xA4FN7KO002187
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Nov 2019 16:23:07 +0100
Received: from DEFTHW99ETUMSX.ww931.my-it-solutions.net ([10.86.142.49])
        by mail1-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id xA4FN7XG007053
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Nov 2019 16:23:07 +0100
Received: from DEFTHW99ETQMSX.ww931.my-it-solutions.net (10.86.142.98) by
 DEFTHW99ETUMSX.ww931.my-it-solutions.net (10.86.142.49) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019 16:23:04 +0100
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.98) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 4 Nov 2019 16:23:02 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQp7c7JP4hAaCV2o6KnqPx/2xlLYxmLmjot1fM1NChHrF1gsLFsO/oGbSGVzgmn/McMywet/71W8wjA7nrCApsCNaaQt2H2tv2E4zh/d1PbawAazrrKaz8xe9eYlBeKCbm/AJmjrekUf4v26Kmn6SY04J+W1xehk0qhnVQZYRkN/H8o6XDYYzn5q4Juxfu0TW2XkNGU7/Oc59Wnw4gYyQta8lmLiHrFxihnGPHi8rjX9A7ZA8K41I5gK3KryCVWMuVf9X4WA5rC9K3t/lIwANRCpjfiLhAW/cUOs5xRELFZUEPheUhE7F+Scb36iBCSxZZJveZsBXsIfGKFeuNYZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBWUIRoFAsghpWg5qn343wxukM8kWN0vXXZXmBekc+I=;
 b=RACUYEqF526g7RzFuTLl/rTxBw8B0S1WXXGocJbNSXwcp57b7VI0hO5tg3w4ff+2EJEdE9QGW1b9suzeAj+ZunYnQ6a/qsUkcvdT4ndqpQeVBsMCg3msheWcwN3Lz/avjknfgf88a6Rm5+hbr1wupBUS920nVJuMzxiP8GgciX+3k17BQQ9V8O23UCLkZk0LWRWcCdBLmr2FBekOsDwFxGEznDvpyPhGPfhSPU2UXTVTbx2356gRrv0TUr05rt4H6yBbKdJQ6K8KKgFl+M7eEzAmhut866aOwLk3nQwRaaz8cYd/+5QeNSGCCk7bmJFPKVk0eTz/R78oQ05/GIq7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (52.134.80.141) by
 AM0PR02MB4498.eurprd02.prod.outlook.com (20.178.20.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:23:01 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::9c1d:6b9f:8a1e:4eb8]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::9c1d:6b9f:8a1e:4eb8%5]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:23:01 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Ingo Wolf <ingo.wolf@gmx.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: RE: Windows Git Status doesn't see files on WebDav, everything else
 do
Thread-Topic: Windows Git Status doesn't see files on WebDav, everything else
 do
Thread-Index: AQHVkoaYKdXCRLOqSEqoE0QAK/sqPqd68deAgAAfvACAAA+LsA==
Date:   Mon, 4 Nov 2019 15:23:01 +0000
Message-ID: <AM0PR02MB3715C3E485FD1FB0F0FD9E7B9C7F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
 <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
 <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
 <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
 <2883e199-bb7d-e323-d3eb-ed8da85cc54a@gmx.de>
In-Reply-To: <2883e199-bb7d-e323-d3eb-ed8da85cc54a@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [157.203.176.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d383f0d-9156-487e-a5b7-08d7613ae18d
x-ms-traffictypediagnostic: AM0PR02MB4498:
x-microsoft-antispam-prvs: <AM0PR02MB449884C135AC1CD55E292EFC9C7F0@AM0PR02MB4498.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(13464003)(478600001)(2906002)(7736002)(6116002)(3846002)(6436002)(71190400001)(71200400001)(316002)(99286004)(54906003)(81166006)(26005)(81156014)(74316002)(305945005)(66556008)(55016002)(9686003)(76116006)(66066001)(66946007)(229853002)(6506007)(476003)(11346002)(446003)(7696005)(64756008)(66446008)(186003)(66476007)(8676002)(486006)(110136005)(8936002)(6246003)(5660300002)(14444005)(256004)(86362001)(33656002)(14454004)(52536014)(76176011)(25786009)(102836004)(4744005)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4498;H:AM0PR02MB3715.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CGGcrsE13vJHPIMMz0pN3weejackj04UTMI57fqi1vPCtOD2egPBTwBVXxPPKCU1Vy4ZaWAugU1y8REKyjxF56r7dQ4t8IMoS4YePPVWcwoHXFztVvVZwGEGKl3mpmdxpf9RayYrATHY+2OYV4Iw3+IDrCGIpbfWOQcjAtn5Kua+h808pxVgUeb3lNHUeB0R+ZLq5YskszrA/2uabgjAlMjKgEZCxo2T2JRgDeXbcFirb2qatBC8wIYy4SOYgwn1nKT8+S9vgCt+py40ByurJtv1U5a2RAqpmzI1Ss+DzRd+Flod9Lz375vqhgZdfvKzDMFyUpkk3/OTGE1iwWlmLfeRBYHopbmPUOQGm+OB1vgzIu2pYHfS1q0cUBLqs8vsJIYtMy2eEdIInAfX0JtYfSD/xzMebhQF6xwaKClVgm9Lmplsv15r7bNID30/mJWI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d383f0d-9156-487e-a5b7-08d7613ae18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:23:01.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONyb7KumJy9w436ZpzDobQhhMgO9PytUJSpuaItcUYbogrEtX8HQSdZg5GCpheNY1bGnX3BEVNJhYGaNY4CKgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4498
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiANCj4gQW0gMDQuMTEuMjAxOSB1bSAxMzoy
OSBzY2hyaWViIEpvaGFubmVzIFNjaGluZGVsaW46DQo+ID4+IFNldHRpbmdzIHJlY29tbWVuZGVk
IGJ5IGJyaWFuIGhhdmVuJ3QgaGVscGVkIHlldC4NCj4gPiBUaGF0IGlzIGFuIF9hd2Z1bGx5XyBz
dWNjaW5jdCBhbnN3ZXIuIFRlcnNlLCBldmVuLg0KPiBXYXMgdGhhdCBhbiBhd2Z1bGwgYW5zd2Vy
Pw0KPiANCj4gSSBoYXZlIHRvIHRlbGwgSSdtIEdlcm1hbiBhbmQgbWF5IGJlIGhhdmUgbm8gZmVl
bCBmb3Igc29tZSBsYW5ndWFnZSBkZXRhaWxzLg0KPiANCj4gT3IgbWF5IGJlIGFzIGEgbWFuIGp1
c3QgaW4gZ2VuZXJhbC4NCg0KW1JLPl0gSXQncyBub3QgdGhhdCB5b3VyIGFuc3dlciB3YXMgYXdm
dWwsIHRoZSBwcm9ibGVtIHdhcyB0aGF0IGl0IHdhcyB0ZXJzZSAtIFRvbyB0ZXJzZSBmb3IgYW55
b25lIHRvIGdpdmUgYW55IGFkdmljZSBvbi4NCkkgdGhpbmsgdGhlIHJlcXVlc3QgaXMgYWN0dWFs
bHkgdGhhdCB5b3Ugc2hvdWxkIHNlbmQgdG8gdGhlIGxpc3QgdGhlIGNvbW1hbmRzL3NldHRpbmdz
IHRoYXQgeW91J3ZlIHRyaWVkIGFuZCB0aGUgcmVzdWx0cyB0aGF0IGhhdmUgYmVlbiByZXR1cm5l
ZCB0byB5b3UuDQoNCj4gRG8geW91IHJlYWQgdGhhdCBhbnN3ZXIgZGlmZmVyZW50IHRoZW4gSSd2
ZSB0cmllZCBicmlhbidzIHNldHRpbmdzLCBzdGlsbCBub3QNCj4gd29ya2luZywNCj4gDQo+IGRv
ZXMgc29tZWJvZHkga25vdyBvdGhlciBzZXR0aW5ncyBJIHN0aWxsIGNhbiB0cnk/DQo+IA0KDQpb
Uks+XSAoSSB0aGluayBKb2hhbm5lcyBpcyBhbHNvIEdlcm1hbiwgYW5kIGEgbWFuLCBzbyB0aGF0
J3Mgbm90IHJlYWxseSBhbiBleGN1c2UuLi4uKQ0KDQpSZWdhcmRzLA0KUmljaGFyZC4NCg0K

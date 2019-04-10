Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0D520248
	for <e@80x24.org>; Wed, 10 Apr 2019 18:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfDJS3z (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 14:29:55 -0400
Received: from mail-eopbgr790097.outbound.protection.outlook.com ([40.107.79.97]:26624
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfDJS3y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 14:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lbBZ3ooDtHk2PiHaobg7/MQV2VGvul+jcyyoeHQeAw=;
 b=DLd4R5k65kl5XsNWW0yiqLC356j/0FsYr3k0NLRkTgXO/DSVAwaCv3J8VeyuhEdXKriU3wv8VLM8Pl+XBM0Z4+TUN/YgDru+oeNAznK3fyYfssqtTluxHzggvi1jRpCaTz4WlmuoOuIoQuL4cZnjYdyI/sLpbycIssDiyAuabNc=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4283.namprd08.prod.outlook.com (20.176.82.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 18:29:51 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::6849:6be1:92ad:4577]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::6849:6be1:92ad:4577%4]) with mapi id 15.20.1771.021; Wed, 10 Apr 2019
 18:29:51 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "gitster@pobox.com" <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "ahippo@yandex.com" <ahippo@yandex.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "Mazo, Andrey" <amazo@checkvideo.com>
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
Thread-Topic: What's cooking in git.git (Apr 2019, #02; Wed, 10)
Thread-Index: AQHU7v81wvcMXSCz6kuZAmSXfR4nhKY1uIiA
Date:   Wed, 10 Apr 2019 18:29:51 +0000
Message-ID: <20190410182859.20511-1-amazo@checkvideo.com>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:404:4c::28) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf52e61b-c1de-4ddb-4f67-08d6bde284f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR08MB4283;
x-ms-traffictypediagnostic: DM6PR08MB4283:
x-microsoft-antispam-prvs: <DM6PR08MB4283771FAF8E2E3015FC8D93DA2E0@DM6PR08MB4283.namprd08.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(6486002)(50226002)(8676002)(71190400001)(81166006)(1730700003)(2351001)(3846002)(106356001)(99286004)(105586002)(6116002)(81156014)(5660300002)(256004)(446003)(14444005)(2616005)(6916009)(14454004)(11346002)(486006)(71200400001)(1076003)(6512007)(68736007)(386003)(86362001)(8936002)(5640700003)(6246003)(52116002)(2906002)(476003)(53936002)(36756003)(54906003)(6436002)(186003)(26005)(107886003)(478600001)(2501003)(66066001)(229853002)(6506007)(97736004)(25786009)(305945005)(316002)(4326008)(7736002)(76176011)(102836004)(325944009)(71610200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4283;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AFfgJYdSbFKHv0tKtn/CE+Bfp36BXai4R1qOYpBPMeMxADJ+jXzIpeKDc9nUfM7F4AKqS/z4S+27j+PXpPyRqYcMySct/wQn0wvLd225uk2I5ko6XQ3+vCIGxeGOUTmP0L8BzNo6dmnbl3MEtHcGN/E38AcnPr3lqVn8e50iDIQjLCUeAmSN5A3kD9D6kp8r/ww9K//yVzs5J7rENLWi+C1mbY4LWQmWSmBNlf/CL0fpeagOAoG5DC6EceAVuhnqz37qubFnPnA+I8SaOwNxz0nvszf0IinSjtZvgJLLo0Y6TSZwuCKLK9+sA+rb/ftxUDssgQyYPNZHbBfMEq9l6CcxapgmKA5gOEHvkDam5YB5ggkUQ903KMhrCssWfr4SlIpQI0kr8RiOvyqKY/Xm9DkT30JFzJfwD/l9epco2UE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf52e61b-c1de-4ddb-4f67-08d6bde284f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 18:29:51.4529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4283
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAqIGFtL3A0LWJyYW5jaGVzLWV4Y2x1ZGVzICgyMDE5LTA0LTAyKSA4IGNvbW1pdHMNCj4gIC0g
Z2l0LXA0OiByZXNwZWN0IGV4Y2x1ZGVkIHBhdGhzIHdoZW4gZGV0ZWN0aW5nIGJyYW5jaGVzDQo+
ICAtIGdpdC1wNDogYWRkIGZhaWxpbmcgdGVzdCBmb3IgImdpdC1wNDogcmVzcGVjdCBleGNsdWRl
ZCBwYXRocyB3aGVuIGRldGVjdGluZyBicmFuY2hlcyINCj4gIC0gZ2l0LXA0OiBkb24ndCBleGNs
dWRlIG90aGVyIGZpbGVzIHdpdGggc2FtZSBwcmVmaXgNCj4gIC0gZ2l0LXA0OiBhZGQgZmFpbGlu
ZyB0ZXN0IGZvciAiZG9uJ3QgZXhjbHVkZSBvdGhlciBmaWxlcyB3aXRoIHNhbWUgcHJlZml4Ig0K
PiAgLSBnaXQtcDQ6IGRvbid0IGdyb29tIGV4Y2x1ZGUgcGF0aCBsaXN0IG9uIGV2ZXJ5IGNvbW1p
dA0KPiAgLSBnaXQtcDQ6IG1hdGNoIGJyYW5jaGVzIGNhc2UgaW5zZW5zaXRpdmVseSBpZiBjb25m
aWd1cmVkDQo+ICAtIGdpdC1wNDogYWRkIGZhaWxpbmcgdGVzdCBmb3IgImdpdC1wNDogbWF0Y2gg
YnJhbmNoZXMgY2FzZSBpbnNlbnNpdGl2ZWx5IGlmIGNvbmZpZ3VyZWQiDQo+ICAtIGdpdC1wNDog
ZGV0ZWN0L3ByZXZlbnQgaW5maW5pdGUgbG9vcCBpbiBnaXRDb21taXRCeVA0Q2hhbmdlKCkNCj4g
DQo+ICAiZ2l0IHA0IiB1cGRhdGUuDQo+IA0KPiAgSXMgdGhpcyByZWFkeSBmb3IgJ25leHQnPw0K
Pg0KDQpBIGNvdXBsZSBvZiB3ZWVrcyBhZ28sIEx1a2Ugc2FpZCBoZSB3YXMgcXVpdGUgYnVzeSwN
CnNvIEkgd291bGQgZ3Vlc3MsIGhlIGRpZG4ndCBoYXZlIGEgY2hhbmNlIHRvIGxvb2sgYXQgdGhl
c2UgY2hhbmdlcyB5ZXQuDQoNCg0KV2hpbGUgd2UncmUgb24gdGhpcywgSSB3YW50ZWQgdG8gZGlz
Y3VzcyBhbm90aGVyIHRvcGljLg0KTXkgbGFzdCBkYXkgYXQgdGhlIGN1cnJlbnQgZW1wbG95ZXIs
IENoZWNrVmlkZW8sIGlzIEFwcmlsIDE5Lg0KQWZ0ZXIgdGhhdCwgSSdsbCBsb3NlIGFjY2VzcyB0
byBhbWF6b0BjaGVja3ZpZGVvLmNvbSBlbWFpbCBhZGRyZXNzLg0KSSBwbGFuIHRvIHN3aXRjaCB0
byBteSBwZXJzb25hbCBlbWFpbCAoYWhpcHBvQHlhbmRleC5jb20pIGZvciBnaXQtcDQtcmVsYXRl
ZCBkaXNjdXNzaW9ucyBzdGFydGluZyB0b21vcnJvdywgQXByaWwgMTEuDQoNClNob3VsZCBJIHJl
c2VuZCBteSBwYXRjaGVzIGZyb20gbXkgcGVyc29uYWwgYWRkcmVzcyBhbmQvb3IgYWRkIGFub3Ro
ZXIgcy1vLWI/DQpMaWtlDQoiIiINClNpZ25lZC1vZmYtYnk6IEFuZHJleSBNYXpvIDxhbWF6b0Bj
aGVja3ZpZGVvLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFuZHJleSBNYXpvIDxhaGlwcG9AeWFuZGV4
LmNvbT4NCiIiIg0KDQoNCkFsc28sIEkgd29uJ3QgaGF2ZSBhY2Nlc3MgdG8gYSBsYXJnZSBQZXJm
b3JjZSBzZXJ2ZXIgYWZ0ZXIgQXByaWwgMTksDQp3aGljaCB3YXMgZ29vZCBmb3IgdGVzdGluZy4N
Cg0KLS0NCkFuZHJleQ0K

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC17B1F462
	for <e@80x24.org>; Wed, 22 May 2019 15:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfEVP14 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 11:27:56 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:46246
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729583AbfEVP14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 11:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intenogroup.onmicrosoft.com; s=selector1-intenogroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYlbyzi5SX31c1ABj/c8ytiea/VQt/un9z/xSL1lH+4=;
 b=vHGAPGDsY0EZeKQ55CoqEn/9NJ3ZK/nfaIqoMPcfXL9hlmtuFrtQLcpaeX5Um9YxhlwH08Onixs/M90uwTQWHoYoz8JzdKiuQe9HrC5bFjHY48hFZUmvT896jmH6M+SWKfHmyf7JsGpVz4XpZwTanc5wUFO363PrL0WcpZl8Ld4=
Received: from VI1PR08MB3454.eurprd08.prod.outlook.com (20.177.59.20) by
 VI1PR08MB4573.eurprd08.prod.outlook.com (20.178.126.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 22 May 2019 15:27:53 +0000
Received: from VI1PR08MB3454.eurprd08.prod.outlook.com
 ([fe80::dc78:5268:40ff:dfd5]) by VI1PR08MB3454.eurprd08.prod.outlook.com
 ([fe80::dc78:5268:40ff:dfd5%3]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 15:27:53 +0000
From:   Oussama Ghorbel <oussama.ghorbel@iopsys.eu>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: strange behavior of git diff-index
Thread-Topic: strange behavior of git diff-index
Thread-Index: AQHVEITFUMiusrwMTUmKw6ax3XbKfaZ3O1qAgAAJcoA=
Date:   Wed, 22 May 2019 15:27:53 +0000
Message-ID: <1b86251f-1b64-dfdf-7e40-e8a0c1e42e55@iopsys.eu>
References: <VI1PR08MB3454100258C23CB1F2B709F5EB000@VI1PR08MB3454.eurprd08.prod.outlook.com>
 <nycvar.QRO.7.76.6.1905221651270.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905221651270.46@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::21) To VI1PR08MB3454.eurprd08.prod.outlook.com
 (2603:10a6:803:7c::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oussama.ghorbel@iopsys.eu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:9b0:1:3302:8a97:8e8e:d547:4f2c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d4ce928-2f1d-47eb-ba69-08d6deca0e8c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB4573;
x-ms-traffictypediagnostic: VI1PR08MB4573:
x-microsoft-antispam-prvs: <VI1PR08MB4573F25B058DC813AF4F2077EB000@VI1PR08MB4573.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39850400004)(136003)(199004)(189003)(86362001)(71200400001)(31686004)(71190400001)(6116002)(76176011)(486006)(53936002)(11346002)(25786009)(31696002)(446003)(476003)(36756003)(14454004)(186003)(68736007)(81156014)(2616005)(6436002)(52116002)(305945005)(8676002)(256004)(6486002)(44832011)(81166006)(73956011)(46003)(6246003)(7736002)(99286004)(316002)(8936002)(2906002)(4326008)(5660300002)(102836004)(74482002)(6916009)(66476007)(66946007)(229853002)(6506007)(386003)(53546011)(66446008)(478600001)(6512007)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4573;H:VI1PR08MB3454.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: iopsys.eu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pItYqkAAuMOihAZhhFjC7xc0ZAGSL59LgjsyFdq1rn5oUjvLAZybb9GEClDH2q8DL1CJkRnQXGRBqJwfJH/UizzVgKZbWUIKyiMesOpqoBW/2qMmZa0NU3GlI9CVyV0hqypCrR7xuPfX7Iom/xfFlLMNpUwEygritI8+15Z6h3UsO1d0HIAz67n5+vuEMss8ssm/1xIZf/VLqr6JxlV3ZkfUjIf6wWbVDz0EQJsKXS6zXR++WoE3nTG+yQm0hhmKHhALoB+kQumiHULCMU4/vyEHBICdB3gFulfOyk2nDJEYA2++gdulXy+BPtuEjLvf6rdngwcepxOpoD6othK3ZvlNLjdvZHxdtM+J9zbGsgQuEdfXuyB3MoJ0rektmzYYaWR9zbHzXVQ5nIcZCqltN8SGsZ2ASBsMm7Gz7W+n1JM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B93F87C393470C4086617C71EBA17ABD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4ce928-2f1d-47eb-ba69-08d6deca0e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 15:27:53.2629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4573
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSm9oYW5uZXMsDQoNClRoYW5rc8KgYSBsb3QgZm9yIHRoZSBjbGFyaWZpY2F0aW9uIQ0KDQpS
ZWdhcmRzLA0KT3Vzc2FtYQ0KT24gNS8yMi8xOSA0OjU0IFBNLCBKb2hhbm5lcyBTY2hpbmRlbGlu
IHdyb3RlOg0KPiBIaSBPdXNzYW1hLA0KPg0KPiBPbiBXZWQsIDIyIE1heSAyMDE5LCBPdXNzYW1h
IEdob3JiZWwgd3JvdGU6DQo+DQo+PiBnaXQgZGlmZi1pbmRleCBpcyBnaXZpbmcgbWUgaW5jb3Jy
ZWN0IGluZm9ybWF0aW9uLCBob3dldmVyIGlmIEkgcnVuIGdpdCBkaWZmLCB0aGVuIGdpdCBkaWZm
LWluZGV4IGFnYWluIGl0IHdpbGwgc2hvdyB0aGUgY29ycmVjdCBpbmZvcm1hdGlvbi4NCj4+IFRo
ZSBzdGVwcyBhcmUgdGhlIGZvbGxvd2luZzoNCj4+ICQgZ2l0IGRpZmYtaW5kZXggLS1uYW1lLW9u
bHkgSEVBRA0KPj4gZ2l0IGFwcGVhcnMgdG8gbGlzdCBhbGwgZmlsZXMgaW4gdGhlIHByb2plY3Qg
aXJyZXNwZWN0aXZlIGlmIHRoZXkgbW9kaWZpZWQgb3Igbm90DQo+PiAkIGdpdCBkaWZmDQo+PiAk
IGdpdCBkaWZmIC0tY2FjaGVkDQo+PiB3aWxsIHNob3cgbm90aGluZy4gU28gSSBkb24ndCBoYXZl
IGFueSBtb2RpZmljYXRpb24uDQo+PiBOb3cgc3RyYW5nZWx5IGlmIEkgcnVuIGdpdCBkaWZmLWlu
ZGV4LCBpdCB3aWxsIGFsc28gc2hvdyBub3RoaW5nIHdoaWNoIGlzIGNvcnJlY3Rpb24gYmVoYXZp
b3IuDQo+Pg0KPj4gbXkgZ2l0IHZlcnNpb24gaXMgMi43LjQNCj4+IEFueSBleHBsYW5hdGlvbj8N
Cj4gVGhlIGxvdy1sZXZlbCBgZGlmZi1pbmRleGAgY29tbWFuZCBpcyBtZWFudCB0byBiZSB1c2Vk
IGluIHNjcmlwdHMsIGFuZA0KPiBkb2VzIHNwZWNpZmljYWxseSAqbm90KiByZWZyZXNoIHRoZSBp
bmRleCBiZWZvcmUgcnVubmluZy4gTWVhbmluZyB0aGF0IGl0DQo+IGNvdWxkIHBvc3NpYmx5IG1p
c3Rha2UgYSBmaWxlIGZvciBiZWluZyBtb2RpZmllZCBldmVuIGlmIGl0IGlzIG5vdA0KPiBtb2Rp
ZmllZCwganVzdCBiZWNhdXNlIGl0IGlzIG1hcmtlZCAibW9kaWZpZWQiIGluIHRoZSBpbmRleCBb
KjEqXS4NCj4NCj4gU2hvcnQgYW5zd2VyOiB1c2UgdGhlIGhpZ2gtbGV2ZWwgY29tbWFuZCBgZ2l0
IGRpZmZgIHRoYXQgaXMgaW50ZW5kZWQgZm9yDQo+IGh1bWFuIGNvbnN1bXB0aW9uLg0KPg0KPiBD
aWFvLA0KPiBKb2hhbm5lcw0KPg0KPiBGb290bm90ZSAqMSo6IEl0IGlzIGFjdHVhbGx5IGEgYml0
IG1vcmUgY29tcGxpY2F0ZWQgdGhhbiB0aGF0OiB0aGUgaW5kZXgNCj4gc3RvcmVzIG1ldGFkYXRh
IHN1Y2ggYXMgbXRpbWUsIHNpemUsIHVpZCwgZXRjLCBhbmQgY29tcGFyZXMgdGhhdCB0byB0aGUN
Cj4gbWV0YWRhdGEgb24gZGlzay4gSWYgdGhlcmUgaXMgYW55IG1pc21hdGNoLCBvciBpZiBldmVy
eXRoaW5nIG1hdGNoZXMgYnV0DQo+IHRoZSBtdGltZSAqYWxzbyogbWF0Y2hlcyB0aGUgaW5kZXgg
ZmlsZSdzIGl0c2VsZiwgdGhlIGZpbGUgaXMgY29uc2lkZXJlZA0KPiBub3QgdXAgdG8gZGF0ZSwg
aS5lLiBtYXJrZWQgYXMgbW9kaWZpZWQuDQo=

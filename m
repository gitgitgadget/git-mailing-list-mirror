Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76F91F404
	for <e@80x24.org>; Tue, 28 Aug 2018 18:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeH1WYc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 18:24:32 -0400
Received: from mail-eopbgr680111.outbound.protection.outlook.com ([40.107.68.111]:42914
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726807AbeH1WYc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 18:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/ZXY2gda0NH9Q7aS1GT7dyqRcvpn4DHjdBLHpHoj0s=;
 b=cK7onhrBq87wx1Xs26T4pEdDgZ95zyWMAOncPylJw3a+VBX3dnje/4WpdcA7YPftMukgm+rBFVriYybcrgco3BS1B+zOTIucFOH/Km8J0Czdc+BuKyG0XprkAYPJbeE9L+GIK17nx/l1qdn9FQgZv05ZvntbtT8E6Et8t77tBm4=
Received: from MWHPR21MB0701.namprd21.prod.outlook.com (10.175.142.11) by
 MWHPR21MB0846.namprd21.prod.outlook.com (10.173.51.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Tue, 28 Aug 2018 18:29:56 +0000
Received: from MWHPR21MB0701.namprd21.prod.outlook.com
 ([fe80::211c:e997:6d2f:2dc2]) by MWHPR21MB0701.namprd21.prod.outlook.com
 ([fe80::211c:e997:6d2f:2dc2%7]) with mapi id 15.20.1122.000; Tue, 28 Aug 2018
 18:29:55 +0000
From:   Brennan Conroy <brecon@microsoft.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git clean removing tracked files semi-regularly
Thread-Topic: Git clean removing tracked files semi-regularly
Thread-Index: AdQ+OSCvyHcGJtFFTISUdCPT9MCWRAAMQwgAACSarQA=
Date:   Tue, 28 Aug 2018 18:29:55 +0000
Message-ID: <MWHPR21MB0701E9B53BC72CC33497AF45D60A0@MWHPR21MB0701.namprd21.prod.outlook.com>
References: <MWHPR21MB0701CD1D9653E82116E482ECD60B0@MWHPR21MB0701.namprd21.prod.outlook.com>
 <20180828005803.GB432229@genre.crustytoothpaste.net>
In-Reply-To: <20180828005803.GB432229@genre.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=brecon@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-28T18:29:53.4244007Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:3:883d:e5a3:ea29:dd51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0846;6:hL2vWxTxPvV6GPhnyOqJcIryQJivK8Plg6GoBlthqgPi1GMS/5x/QEmkhQIkghKJXbAzlb2RBl1afgzUqMDSysp7e1T8wW/cLQZvdNl0N3C6jplyLZLxk9D+8V4Voi8evBDRS5/25uTU+uvppzuV/GMOwIApFmKJHp0YPj/qE0VxQhPJ/f9wSHkCXSYGsTyb+vj7ui7m20OVnG233nVuf1dg4MT9/RCwJe7RpihONI1iNj7ERjlpmMHg0XgxL0DBdp7cRcYegmG57bWkh/rYN9mQy8xOpicOUPYJZcBgaPNyTB9oqQY9IHjotneZ/xYThwHIi3iQ6hzmKg6qXeo3pF97x4YNjytABBweX0bA6W3U10/PqSryBV4qDrk9ajfKrw+vjf0OmODhkA5YG5A/QZSKonJg+OdH4rB2H2Tco/sGZ4a4gV995AOir4IdFqwFwj0UADiit1LT648Mc8Ed6Q==;5:BSREm+kc3mOIthzNsOIxlJPwvl8fdfgo5R/PBLj69aV9X2wGp+6+mqmjqZKiz8+laDqHJCZXAB4h9rkBkmTc7/1FTMyIY2DQa757QQyNJ+BwaVPiQ2vLPdRzuBsXwyIibh4js5n1h1dzepwLBS6xF6hVNWYjYgp0RsKmXrZWU/w=;7:IZ8OUpiM7ATWQxKFEvpIpdzCgFJN49l0H/tlsp4j9+k6hAjTT79X15iKXmiN5bxsYhr1TLRQdRP0iCdSwMx45JHED/Rm2biZhVNDUWLixlM+XpF6d+fw2N8gENtc3xbjOXxZYj4i8yIbJisW1NZc07FQ7IOhQvbzwxF3qtvMfvRx7u4ZTOeUBZ2uRyAlJKP35rTMJSo7pUA8zYhe9s6O0/GU+tmKrNgqhp5sURn71HOkP3rhls+3AUNTv8iSZbnB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 78755171-1666-4fa2-2325-08d60d1440f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0846;
x-ms-traffictypediagnostic: MWHPR21MB0846:
x-microsoft-antispam-prvs: <MWHPR21MB08463C56AFB46A10D63644E7D60A0@MWHPR21MB0846.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231336)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:MWHPR21MB0846;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0846;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(13464003)(9686003)(55016002)(68736007)(14454004)(97736004)(2906002)(6306002)(8990500004)(478600001)(966005)(6246003)(99286004)(10290500003)(2900100001)(7696005)(5660300001)(76176011)(476003)(11346002)(446003)(46003)(106356001)(105586002)(486006)(81166006)(8676002)(102836004)(6116002)(53546011)(22452003)(10090500001)(316002)(33656002)(6506007)(86612001)(81156014)(74316002)(8936002)(53936002)(7736002)(5250100002)(86362001)(305945005)(186003)(6916009)(229853002)(6436002)(256004)(25786009)(14444005)(4326008)(6346003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0846;H:MWHPR21MB0701.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brecon@microsoft.com; 
x-microsoft-antispam-message-info: gHotPXN5zG7/ONPVU7ogvITX2a4vKhgVuknLsiY8rdesg5GzV+zRTWjYlXAGFsgrkW+Qj0/noSvN9iJrShZG4TgKRrZ3rqJm4HfnsOQV8yj5Iqu0kE10T3pGW3Ud3BYplIUEqa3npwy7T+PXM7/AtGJ95i3MndD7S4YbhZyZS5Y9UGtexPZKtwfM+bzKqUL9+9NyEyF7GpwxFO/AEQeqQ4mTc0gHY5D1ra6v57hOkaIMVuaOWlOjtqgbHviXC+mDujCsVU9VcAjXkS6ep9jRgTs6J4lpaYBMin9AqztktpBSKlECrjr8Naqw/rBXUISC+pG2bvtQ37s9GtJJjGoGU48NjrcV3dn7YZNtnHNGufI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78755171-1666-4fa2-2325-08d60d1440f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 18:29:55.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0846
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSdtIHVzaW5nIHdpbmRvd3MuIEhhdmUgaGFkIGl0IGhhcHBlbiBvbiA4LjEgYW5kIDEwLg0KDQoi
Z2l0IHN0YXR1cyIgc2hvd3MgIm5vdGhpbmcgdG8gY29tbWl0LCB3b3JraW5nIHRyZWUgY2xlYW4i
LiBJIGFtIHVzaW5nIGdpdCB2ZXJzaW9uIDIuMTcuMS53aW5kb3dzLjINCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNAY3J1c3R5dG9v
dGhwYXN0ZS5uZXQ+IA0KU2VudDogTW9uZGF5LCBBdWd1c3QgMjcsIDIwMTggNTo1OCBQTQ0KVG86
IEJyZW5uYW4gQ29ucm95IDxicmVjb25AbWljcm9zb2Z0LmNvbT4NCkNjOiBnaXRAdmdlci5rZXJu
ZWwub3JnDQpTdWJqZWN0OiBSZTogR2l0IGNsZWFuIHJlbW92aW5nIHRyYWNrZWQgZmlsZXMgc2Vt
aS1yZWd1bGFybHkNCg0KT24gTW9uLCBBdWcgMjcsIDIwMTggYXQgMDc6MDY6NTlQTSArMDAwMCwg
QnJlbm5hbiBDb25yb3kgd3JvdGU6DQo+IEhlbGxvLCBJIHdvcmsgb24gYSBwcm9qZWN0IHRoYXQg
dXNlcyBnaXQuICJnaXQgY2xlYW4gLXhkZiIgaXMgYSBjb21tb24gDQo+IGNvbW1hbmQgdG8gcnVu
IHRvIGNsZWFuIHVwIHRoZSBlbnZpcm9ubWVudCwgaG93ZXZlciBzb21ldGltZXMgdGhpcyANCj4g
Y29tbWFuZCBkZWxldGVzIHRoZSBlbnRpcmUgY29udGVudHMgb2YgdHdvIG9mIHRoZSBmb2xkZXJz
IGFuZCBhbGwgdGhlIA0KPiBmaWxlcyBpdCBkZWxldGVzIGFyZSBiZWluZyB0cmFja2VkIHdoaWNo
IGFjY29yZGluZyB0byB0aGUgDQo+IGRvY3VtZW50YXRpb24gc2hvdWxkIG5vdCBiZSBkZWxldGVk
Lg0KPiANCj4gVGhlIHByb2plY3QgaXMgbG9jYXRlZCBhdCBodHRwczovL2dpdGh1Yi5jb20vYXNw
bmV0L1NpZ25hbFIgYW5kIHRoZSANCj4gdHdvIGZvbGRlcnMgaXQgbGlrZXMgdG8gZGVsZXRlIGFy
ZSANCj4gaHR0cHM6Ly9naXRodWIuY29tL2FzcG5ldC9TaWduYWxSL3RyZWUvcmVsZWFzZS8yLjIv
Y2xpZW50cy90cy9zaWduYWxyLQ0KPiBwcm90b2NvbC1tc2dwYWNrIGFuZCANCj4gaHR0cHM6Ly9n
aXRodWIuY29tL2FzcG5ldC9TaWduYWxSL3RyZWUvcmVsZWFzZS8yLjIvY2xpZW50cy90cy9zaWdu
YWxyDQo+IA0KPiBJZiB5b3UgbmVlZCBtZSB0byBjb2xsZWN0IGdpdCBsb2dzIGV0Yy4gcGxlYXNl
IGRvbid0IGhlc2l0YXRlIHRvIGFzayENCg0KSXQgd291bGQgYmUgaGVscGZ1bCB0byBrbm93IG1v
cmUgYWJvdXQgeW91ciBlbnZpcm9ubWVudC4gIElzIHRoaXMgb25seSByZXByb2R1Y2libGUgb24g
Y2VydGFpbiBvcGVyYXRpbmcgc3lzdGVtcyAoZS5nLiBjYXNlLWluc2Vuc2l0aXZlIG9uZXMpPw0K
V2hhdCB2ZXJzaW9uIG9mIEdpdCBhcmUgeW91IHVzaW5nPyAgV2hhdCBkb2VzICJnaXQgc3RhdHVz
IiBzYXkgYmVmb3JlIHlvdSBydW4gZ2l0IGNsZWFuPw0KLS0NCmJyaWFuIG0uIGNhcmxzb246IEhv
dXN0b24sIFRleGFzLCBVUw0KT3BlblBHUDogaHR0cHM6Ly9rZXliYXNlLmlvL2JrMjIwNA0K

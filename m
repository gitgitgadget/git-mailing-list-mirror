Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B7D2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 16:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756060AbdIRQ2z (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 12:28:55 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:27712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754958AbdIRQ2y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 12:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xBpkwUh/PXTw/TXge82mGrfeJFiSZu4QVWiQ+MpYb88=;
 b=o9bCxckVs2zmTAlTFNKPd38UyAJ53JtdYCJUcYydqaXmQ45ZbtDahTPT7UBaBKRT7IqObX9KV7OJk0OZvvB2mQoiAz0a7WL4ZgtkvKi+xgkOnT59oNrm25/m0yLZNMkH3pIB7u8IZF+8BXhDU/pqv3cFpuzaJKbDan/Zrhvxoiw=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0190.namprd21.prod.outlook.com (10.173.52.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Mon, 18 Sep 2017 16:28:51 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0098.001; Mon, 18 Sep 2017 16:28:51 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        Ben Peart <peartben@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index
 extension
Thread-Topic: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index
 extension
Thread-Index: AQHTLlfX4EdaoMmwhkm8eIJw0xTKS6K4uf2ggAHwEICAACLvgIAACcWg
Date:   Mon, 18 Sep 2017 16:28:51 +0000
Message-ID: <MWHPR21MB0478E4671130AD9E19B77460F4630@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-9-benpeart@microsoft.com>
 <xmqqtw01u50j.fsf@gitster.mtv.corp.google.com>
 <5438765b-3119-ef15-8635-932b8cba08d3@gmail.com>
 <6f55efc4-96b2-7c53-7d54-ff5801697550@web.de>
In-Reply-To: <6f55efc4-96b2-7c53-7d54-ff5801697550@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-18T12:28:49.7087389-04:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0190;6:J62HGmrVjxDesf800AO+zjV4X6OTuwNhEYwHrw5BkqzUhlr23+1WwnZXAc7VlBVCJyDo4SUeyn9gdad8mQoOpxwro5gQbDRXrxeTwrPwrcjRSByb6nEzqLD5Cc2wB5PSbJlY3CQrBmSOuf0/JhvdvSaYMHtpeQKf7NHxuTmH0otPI5qaS5x+CYDpKgliNtS/GjxpSmEm54QaeBGR2UoVmBdzjbMzau9JAdzDsLm9PxAHZiHeoUIlDOy5w2Qp57AmmnfuF0WJtafYcKueNi697gkoctl079zQwFATAiStNwoqOukhL7LZbYk0tQ++RsxQ2DJXVPLVbhilV6aFqUvVcw==;5:ayNX2a1V50TkD2OobfRU2b6XaTtf/GT1Ndd9MIF+e4f6LZomSuvjK4p1Ufq5/rD8t0+xf4noYVTdNHCwoa8+WBPZKwRFyMU/z/+x/P+46fGbSmRYE98zy/gel2kn8T1JOk+dEEuHn7mRzzEDdQcDOQ==;24:4SeOO6Cg4Jj9DMy5oh6UkCeOOhB6fdJup6wZICESOyj1X5RLe0G8KA6lF2GLBeHoT6g3jQv2dSwvSLHCFV0rPQzGbceYaUVS6NPsEH6MZgc=;7:dPPc1C6ObLvholU1lSSNbOzgq7QGqkG7PtInpviZgtkmS+/Lt+3/jNSFDqgmLS07FeuuVabRE0D6E8nG/s+lRc7ox8cQ75O7RMBh5oewVmuq31nr1qNgp6ItCtmdDLGyXvp3TI98WovX3LYXJjR/l1jlKfgh7eW34Y9W+QE3ivPFyqLbYK6KXzZyfuNasLHboEJT4W/BaMGCbk3WGlAHLJkXAXG2qPAtjcS9usmMyac=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8a5c0706-5f76-4940-5904-08d4feb25912
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR21MB0190;
x-ms-traffictypediagnostic: MWHPR21MB0190:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(26323138287068)(89211679590171)(9452136761055)(245156298449039)(100324003535756);
x-microsoft-antispam-prvs: <MWHPR21MB019061DC98653E8CAC8CEB27F4630@MWHPR21MB0190.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0190;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0190;
x-forefront-prvs: 04347F8039
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(39860400002)(47760400005)(377424004)(13464003)(199003)(377454003)(24454002)(189002)(97736004)(316002)(8990500004)(7696004)(189998001)(10090500001)(74316002)(7736002)(305945005)(5660300001)(2900100001)(9686003)(53936002)(99286003)(53546010)(86612001)(106356001)(54906002)(3660700001)(2950100002)(105586002)(55016002)(8666007)(66066001)(2906002)(4326008)(8676002)(6436002)(14454004)(93886005)(81156014)(81166006)(68736007)(8656003)(6246003)(3280700002)(86362001)(39060400002)(33656002)(6506006)(101416001)(22452003)(8936002)(72206003)(229853002)(77096006)(7416002)(54356999)(10290500003)(102836003)(3846002)(76176999)(6116002)(50986999)(25786009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0190;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2017 16:28:51.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0190
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb3JzdGVuIELDtmdlcnNoYXVz
ZW4gW21haWx0bzp0Ym9lZ2lAd2ViLmRlXQ0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxOCwg
MjAxNyAxMTo0MyBBTQ0KPiBUbzogQmVuIFBlYXJ0IDxwZWFydGJlbkBnbWFpbC5jb20+OyBKdW5p
byBDIEhhbWFubw0KPiA8Z2l0c3RlckBwb2JveC5jb20+OyBCZW4gUGVhcnQgPEJlbi5QZWFydEBt
aWNyb3NvZnQuY29tPg0KPiBDYzogRGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbTsgYXZhcmFiQGdt
YWlsLmNvbTsNCj4gY2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb207IGdpdEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlOyBwY2xvdWRzQGdtYWlsLmNvbTsgcGVm
ZkBwZWZmLm5ldA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA4LzEyXSBmc21vbml0b3I6IGFk
ZCBhIHRlc3QgdG9vbCB0byBkdW1wIHRoZSBpbmRleA0KPiBleHRlbnNpb24NCj4gDQo+IE9uIDIw
MTctMDktMTggMTU6MzgsIEJlbiBQZWFydCB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24gOS8xNy8y
MDE3IDQ6MDIgQU0sIEp1bmlvIEMgSGFtYW5vIHdyb3RlOg0KPiA+PiBCZW4gUGVhcnQgPGJlbnBl
YXJ0QG1pY3Jvc29mdC5jb20+IHdyaXRlczoNCj4gPj4NCj4gPj4+IGRpZmYgLS1naXQgYS90L2hl
bHBlci90ZXN0LWR1bXAtZnNtb25pdG9yLmMNCj4gPj4+IGIvdC9oZWxwZXIvdGVzdC1kdW1wLWZz
bW9uaXRvci5jIG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4+PiAwMDAwMDAwMDAwLi40
ODJkNzQ5YmI5DQo+ID4+PiAtLS0gL2Rldi9udWxsDQo+ID4+PiArKysgYi90L2hlbHBlci90ZXN0
LWR1bXAtZnNtb25pdG9yLmMNCj4gPj4+IEBAIC0wLDAgKzEsMjEgQEANCj4gPj4+ICsjaW5jbHVk
ZSAiY2FjaGUuaCINCj4gPj4+ICsNCj4gPj4+ICtpbnQgY21kX21haW4oaW50IGFjLCBjb25zdCBj
aGFyICoqYXYpIHsNCj4gPj4+ICvCoMKgwqAgc3RydWN0IGluZGV4X3N0YXRlICppc3RhdGUgPSAm
dGhlX2luZGV4Ow0KPiA+Pj4gK8KgwqDCoCBpbnQgaTsNCj4gPj4+ICsNCj4gPj4+ICvCoMKgwqAg
c2V0dXBfZ2l0X2RpcmVjdG9yeSgpOw0KPiA+Pj4gK8KgwqDCoCBpZiAoZG9fcmVhZF9pbmRleChp
c3RhdGUsIGdldF9pbmRleF9maWxlKCksIDApIDwgMCkNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoCBk
aWUoInVuYWJsZSB0byByZWFkIGluZGV4IGZpbGUiKTsNCj4gPj4+ICvCoMKgwqAgaWYgKCFpc3Rh
dGUtPmZzbW9uaXRvcl9sYXN0X3VwZGF0ZSkgew0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIHByaW50
Zigibm8gZnNtb25pdG9yXG4iKTsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4g
Pj4+ICvCoMKgwqAgfQ0KPiA+Pj4gK8KgwqDCoCBwcmludGYoImZzbW9uaXRvciBsYXN0IHVwZGF0
ZSAlIlBSSXVNQVgiXG4iLA0KPiA+Pj4gaXN0YXRlLT5mc21vbml0b3JfbGFzdF91cGRhdGUpOw0K
PiA+Pg0KPiA+PiBBZnRlciBwdXNoaW5nIHRoaXMgb3V0IGFuZCBoYWQgVHJhdmlzIGNvbXBsYWlu
LCBJIHF1ZXVlZCBhIHNxdWFzaCBvbg0KPiA+PiB0b3Agb2YgdGhpcyB0byBjYXN0IHRoZSBhcmd1
bWVudCB0byAodWludG1heF90KSwgbGlrZSB5b3UgZGlkIGluIGFuDQo+ID4+IGVhcmxpZXIgc3Rl
cCAoSSB0aGluayBpdCB3YXMgW1BBVENIIDA0LzEyXSkuDQo+ID4+DQo+ID4NCj4gPiBUaGFua3Mu
IEknbGwgdXBkYXRlIHRoaXMgdG8gY2FzdCBpdCBhcyAodWludDY0X3QpIGFzIHRoYXQgaXMgd2hh
dA0KPiA+IGdldC9wdXRfYmU2NCB1c2UuwqAgQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhleSBib3Ro
IG1hcCB0byB0aGUgc2FtZQ0KPiA+IHRoaW5nICh1bnNpZ25lZCBsb25nIGxvbmcpIHNvIHRoZXJl
IGlzbid0IGZ1bmN0aW9uYWwgZGlmZmVyZW5jZS4NCj4gKEp1c3QgdG8gZG91YmxlLWNoZWNrKTog
VGhpcyBpcyB0aGUgd2F5IHRvIHByaW50ICJQUkl1TUFYIiBjb3JyZWN0bHkgIChvbiBhbGwNCj4g
cGxhdGZvcm1zKToNCj4gDQo+IHByaW50ZigiZnNtb25pdG9yIGxhc3QgdXBkYXRlICUiUFJJdU1B
WCJcbiIsICAodWludG1heF90KWlzdGF0ZS0NCj4gPmZzbW9uaXRvcl9sYXN0X3VwZGF0ZSk7DQo+
IA0KDQpTaG91bGQgSSBqdXN0IG1ha2UgdGhlIHZhcmlhYmxlIHR5cGUgaXRzZWxmIHVpbnRtYXhf
dCBhbmQgdGhlbiBqdXN0IHNraXANCnRoZSBjYXN0IGFsdG9nZXRoZXI/IEkgd2VudCB3aXRoIHVp
bnQ2NF90IGJlY2F1c2UgdGhhdCBpcyB3aGF0DQpnZXRuYW5vdGltZSByZXR1cm5lZC4NCg0K

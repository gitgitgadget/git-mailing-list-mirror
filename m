Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9BB1FD09
	for <e@80x24.org>; Wed, 31 May 2017 19:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbdEaTqy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 15:46:54 -0400
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:24547
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751029AbdEaTqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 15:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+K1HVaoIKr6BY546uBHm2fUbw7eXLUj1A1bprTt5JZ8=;
 b=Mc9+SAgZZ5tQGUr0pCJ3bxqVVzoeWRinebhnVl0tBEybULdeQCaWWUaimyOSbOq5HBhl7TZczXAedQ4n5eDMu8OIYzHYnmLaHogkwDrUfuCviyrTa4khgEpdI/mU9fGZwHdvcd9tY/ieby5MNWbfCXLTKOuOzbcdPks/8lcurG4=
Received: from SN2PR03MB2333.namprd03.prod.outlook.com (10.166.210.136) by
 SN2PR03MB2333.namprd03.prod.outlook.com (10.166.210.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1124.9; Wed, 31 May 2017 19:46:48 +0000
Received: from SN2PR03MB2333.namprd03.prod.outlook.com ([10.166.210.136]) by
 SN2PR03MB2333.namprd03.prod.outlook.com ([10.166.210.136]) with mapi id
 15.01.1124.020; Wed, 31 May 2017 19:46:48 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Stefan Beller <sbeller@google.com>,
        Kevin Willford <kcwillford@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH 2/2] rebase: turn on progress option by default for
 format-patch
Thread-Topic: [PATCH 2/2] rebase: turn on progress option by default for
 format-patch
Thread-Index: AQHS2h89LDXoT03xXUynvN6yWp+iq6IOzloAgAAGYVA=
Date:   Wed, 31 May 2017 19:46:48 +0000
Message-ID: <SN2PR03MB23331225571F62753E88572CB7F10@SN2PR03MB2333.namprd03.prod.outlook.com>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170531150427.7820-3-kewillf@microsoft.com>
 <CAGZ79kYns3CWS5acxGRk67mqdfBvPC=hngnNyovrOkjRRwhRCA@mail.gmail.com>
In-Reply-To: <CAGZ79kYns3CWS5acxGRk67mqdfBvPC=hngnNyovrOkjRRwhRCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetBy=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-05-31T13:46:53.4010075-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-originating-ip: [184.155.115.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR03MB2333;7:rW5WrwS6hjMX1bjqjivxM80pt2O+R/5ILlX+uPn4JGVdBuXsylrFPBCGvE78xlPJ+zZW6Uh+4WuFq5S+lboWn2GKbGDAOjI0GwdtXBw/q8x1vdjyJqJfnEQDQf1tFRkH91eTkFcH9q28T4uUwERoDIutSZazswDcoL37UlTVbC4FZg5/zS3XhwHtW9T2Qi+ErjiiGzWkQ/QFdp8uW5ODJCWE7jqcW1OR+89bUGEA4IhXKPVlr91y33oVu3STBODBRlF87qZahAvml5+GgKV7yVK/Nl+/4rpfpesUy1S+EvhNUl7PfVNHAx1fY3rl7G9xahvatGUfvI11n1dWh4WIEmdgD8N3tolfiPWvaFUQt74=
x-ms-traffictypediagnostic: SN2PR03MB2333:
x-ms-office365-filtering-correlation-id: ac4dd1a8-261a-40ca-deea-08d4a85dc6ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423075)(201703031133081)(201702281549075);SRVR:SN2PR03MB2333;
x-microsoft-antispam-prvs: <SN2PR03MB23334EC130CFB41294382E91B7F10@SN2PR03MB2333.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700073)(100105000095)(100000701073)(100105300095)(100000702073)(100105100095)(61425038)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(100000703073)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123558100)(6072148)(100000704073)(100105200095)(100000705073)(100105500095);SRVR:SN2PR03MB2333;BCL:0;PCL:0;RULEID:(100000800073)(100110000095)(100000801073)(100110300095)(100000802073)(100110100095)(100000803073)(100110400095)(100000804073)(100110200095)(100000805073)(100110500095);SRVR:SN2PR03MB2333;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39840400002)(39400400002)(39410400002)(39860400002)(39850400002)(39450400003)(13464003)(377454003)(24454002)(5660300001)(305945005)(74316002)(8990500004)(86362001)(7736002)(3280700002)(86612001)(66066001)(2906002)(3660700001)(5005710100001)(2900100001)(10090500001)(122556002)(478600001)(33656002)(10290500003)(53936002)(9686003)(189998001)(50986999)(25786009)(8936002)(8676002)(54906002)(2950100002)(54356999)(76176999)(81166006)(53546009)(8656002)(55016002)(7696004)(99286003)(6506006)(39060400002)(3846002)(77096006)(6436002)(229853002)(38730400002)(14454004)(6246003)(4326008)(102836003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2333;H:SN2PR03MB2333.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2017 19:46:48.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gQmVsbGVyIFttYWls
dG86c2JlbGxlckBnb29nbGUuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAzMSwgMjAxNyAx
OjA5IFBNDQo+IFRvOiBLZXZpbiBXaWxsZm9yZCA8a2N3aWxsZm9yZEBnbWFpbC5jb20+DQo+IENj
OiBnaXRAdmdlci5rZXJuZWwub3JnOyBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+
OyBLZXZpbg0KPiBXaWxsZm9yZCA8a2V3aWxsZkBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDIvMl0gcmViYXNlOiB0dXJuIG9uIHByb2dyZXNzIG9wdGlvbiBieSBkZWZhdWx0
IGZvcg0KPiBmb3JtYXQtcGF0Y2gNCj4gDQo+IE9uIFdlZCwgTWF5IDMxLCAyMDE3IGF0IDg6MDQg
QU0sIEtldmluIFdpbGxmb3JkIDxrY3dpbGxmb3JkQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4g
VGhpcyBjaGFuZ2UgcGFzc2VzIHRoZSBwcm9ncmVzcyBvcHRpb24gb2YgZm9ybWF0LXBhdGNoIGJ5
IGRlZmF1bHQgYW5kDQo+ID4gcGFzc2VzIHRoZSAtcSAtLXF1aWV0IG9wdGlvbiB0aHJvdWdoIHRv
IHRoZSBmb3JtYXQtcGF0Y2ggY2FsbCBzbyB0aGF0DQo+ID4gaXQgaXMgcmVzcGVjdGVkIGFzIHdl
bGwuDQo+IA0KPiBUaGlzIGlzIG5vdCBjb25mbGljdGluZyB3aXRoIEpvaGFubmVzIHJld3JpdGUg
b2YgcmViYXNlIGluIEM/DQo+IChyZWJhc2UgaXMgYSBodWdlIGJlYXN0IElJVUMpDQoNCkkgd2ls
bCBjaGVjayB3aXRoIEpvaGFubmVzIGFuZCBzZWUgd2hhdCBwb3NzaWJsZSBjb25mbGljdHMgdGhl
cmUgY291bGQgYmUuDQpTaW5jZSB0aGVzZSBhcmUgZmxhZ3MgdGhhdCBnZXQgcGFzc2VkIHRvIHRo
ZSBmb3JtYXQtcGF0Y2ggY29kZSwgaXQgc2hvdWxkbid0IHRha2UgbXVjaCB0byBwdXQgaXQgaW4g
dGhlIEMgY29kZSBhcyB3ZWxsLg0KDQo+IA0KPiBXaGVuIHBhc3NpbmcgdGhlIHByb2dyZXNzIG9w
dGlvbiBieSBkZWZhdWx0IHRvIGZvcm1hdHRpbmcgcGF0Y2hlcywgbWF5YmUNCj4gd2Ugc2hvdWxk
IHVzZSBzdGFydF9wcm9ncmVzc19kZWxheSBpbiB0aGUgcHJldmlvdXMgcGF0Y2ggaW5zdGVhZCB0
byBvbWl0DQo+IHRoZSBwcm9ncmVzcyBmb3Igc2hvcnQgbGl2ZWQgcGF0Y2ggZm9ybWF0dGluZyBz
ZXNzaW9ucz8NCj4gKHNheSBhIGRlbGF5IG9mIG9uZSBzZWNvbmQ/KQ0KPiANCg0KSSB0aG91Z2h0
IGFib3V0IHRoYXQgYW5kIGNlcnRhaW5seSBjb3VsZCBkbyBpdCBidXQgSSBoYXZlIGZvdW5kIGl0
IG5pY2UgdG8gaGF2ZSB0aGUgbnVtYmVyIG9mIHBhdGNoZXMgdGhhdCBhcmUgZ2VuZXJhdGVkIGlu
IHRoZSBvdXRwdXQgZXZlbiBmb3IgYSBzbWFsbCBudW1iZXIgb3IgY29tbWl0cy4gIEZvciBleGFt
cGxlIHdoZW4gSSBydW4gYSBgZ2l0IHJlYmFzZSBtYXN0ZXJgIGFuZCBleHBlY3QgdGhlcmUgdG8g
YmUgb25seSAyIGNvbW1pdHMsIHRoZSBtZXNzYWdlICJHZW5lcmF0aW5nIHBhdGNoOiAxMDAlICgy
LzIpLCBkb25lLiIgIEdpdmVzIG1lIHRoYXQgZ29vZCBmZWVsaW5nIHRoYXQgSSBkaWQgaXQgcmln
aHQgYW5kIGRpZG4ndCBtZXNzIHNvbWV0aGluZyB1cC4gIEknbSBnb29kIGVpdGhlciB3YXkgdGhv
dWdoLg0KDQo+IFRoYW5rcywNCj4gU3RlZmFuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
S2V2aW4gV2lsbGZvcmQgPGtld2lsbGZAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgZ2l0
LXJlYmFzZS0tYW0uc2ggfCA1ICsrKy0tDQo+ID4gIGdpdC1yZWJhc2Uuc2ggICAgIHwgMiArKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9naXQtcmViYXNlLS1hbS5zaCBiL2dpdC1yZWJhc2UtLWFtLnNo
IGluZGV4DQo+ID4gMzc1MjM5MzQxZi4uYWIyYmUzMGFiZiAxMDA2NDQNCj4gPiAtLS0gYS9naXQt
cmViYXNlLS1hbS5zaA0KPiA+ICsrKyBiL2dpdC1yZWJhc2UtLWFtLnNoDQo+ID4gQEAgLTUxLDgg
KzUxLDkgQEAgdGhlbg0KPiA+ICBlbHNlDQo+ID4gICAgICAgICBybSAtZiAiJEdJVF9ESVIvcmVi
YXNlZC1wYXRjaGVzIg0KPiA+DQo+ID4gLSAgICAgICBnaXQgZm9ybWF0LXBhdGNoIC1rIC0tc3Rk
b3V0IC0tZnVsbC1pbmRleCAtLWNoZXJyeS1waWNrIC0tcmlnaHQtb25seSBcDQo+ID4gLSAgICAg
ICAgICAgICAgIC0tc3JjLXByZWZpeD1hLyAtLWRzdC1wcmVmaXg9Yi8gLS1uby1yZW5hbWVzIC0t
bm8tY292ZXItbGV0dGVyIFwNCj4gPiArICAgICAgIGdpdCBmb3JtYXQtcGF0Y2ggJGdpdF9mb3Jt
YXRfcGF0Y2hfb3B0IC1rIC0tc3Rkb3V0IC0tZnVsbC1pbmRleCBcDQo+ID4gKyAgICAgICAgICAg
ICAgIC0tY2hlcnJ5LXBpY2sgLS1yaWdodC1vbmx5IC0tc3JjLXByZWZpeD1hLyAtLWRzdC1wcmVm
aXg9Yi8gXA0KPiA+ICsgICAgICAgICAgICAgICAtLW5vLXJlbmFtZXMgLS1uby1jb3Zlci1sZXR0
ZXIgLS1wcm9ncmVzcyBcDQo+ID4gICAgICAgICAgICAgICAgICIkcmV2aXNpb25zIiAke3Jlc3Ry
aWN0X3JldmlzaW9uK14kcmVzdHJpY3RfcmV2aXNpb259IFwNCj4gPiAgICAgICAgICAgICAgICAg
PiIkR0lUX0RJUi9yZWJhc2VkLXBhdGNoZXMiDQo+ID4gICAgICAgICByZXQ9JD8NCj4gPiBkaWZm
IC0tZ2l0IGEvZ2l0LXJlYmFzZS5zaCBiL2dpdC1yZWJhc2Uuc2ggaW5kZXgNCj4gPiBkYjFkZWVk
ODQ2Li5iNzJlMzE5YWM5IDEwMDc1NQ0KPiA+IC0tLSBhL2dpdC1yZWJhc2Uuc2gNCj4gPiArKysg
Yi9naXQtcmViYXNlLnNoDQo+ID4gQEAgLTczLDYgKzczLDcgQEAgdGVzdCAiJChnaXQgY29uZmln
IC0tYm9vbCByZWJhc2Uuc3RhdCkiID0gdHJ1ZSAmJg0KPiA+IGRpZmZzdGF0PXQgIGF1dG9zdGFz
aD0iJChnaXQgY29uZmlnIC0tYm9vbCByZWJhc2UuYXV0b3N0YXNoIHx8IGVjaG8gZmFsc2UpIg0K
PiA+ICBmb3JrX3BvaW50PWF1dG8NCj4gPiAgZ2l0X2FtX29wdD0NCj4gPiArZ2l0X2Zvcm1hdF9w
YXRjaF9vcHQ9DQo+ID4gIHJlYmFzZV9yb290PQ0KPiA+ICBmb3JjZV9yZWJhc2U9DQo+ID4gIGFs
bG93X3JlcmVyZV9hdXRvdXBkYXRlPQ0KPiA+IEBAIC0zMDgsNiArMzA5LDcgQEAgZG8NCj4gPiAg
ICAgICAgIC0tcXVpZXQpDQo+ID4gICAgICAgICAgICAgICAgIEdJVF9RVUlFVD10DQo+ID4gICAg
ICAgICAgICAgICAgIGdpdF9hbV9vcHQ9IiRnaXRfYW1fb3B0IC1xIg0KPiA+ICsgICAgICAgICAg
ICAgICBnaXRfZm9ybWF0X3BhdGNoX29wdD0iJGdpdF9mb3JtYXRfcGF0Y2hfb3B0IC1xIg0KPiA+
ICAgICAgICAgICAgICAgICB2ZXJib3NlPQ0KPiA+ICAgICAgICAgICAgICAgICBkaWZmc3RhdD0N
Cj4gPiAgICAgICAgICAgICAgICAgOzsNCj4gPiAtLQ0KPiA+IDIuMTMuMC45Mi5nNzNhNGNlNmE3
Nw0KPiA+DQo=

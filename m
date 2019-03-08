Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1912A20248
	for <e@80x24.org>; Fri,  8 Mar 2019 17:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCHRdq (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 12:33:46 -0500
Received: from mail-eopbgr140097.outbound.protection.outlook.com ([40.107.14.97]:46348
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbfCHRdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 12:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA5fslxTkKCfjm3y9ViweAqHThgZAoTRZ69yIB8SGE0=;
 b=B5dGb/n5cwJJoidBkjvTJyPZJcEgA1kMpvL67uKKBUCQdXWfchB3eMRhr2/kEgyrNjADY9JSs6ySZlxVSvgbsLpecYr2EGqctIcPOAU/zUCdpN9g3VycMpEhN5wQY+XPukJiaupAP6sfvKrC2K1hm+GFkQeDT7SftuEznd+KsJc=
Received: from DB6PR8303MB0069.EURPRD83.prod.outlook.com (129.75.139.20) by
 DB6PR8303MB0072.EURPRD83.prod.outlook.com (129.75.139.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Fri, 8 Mar 2019 17:33:40 +0000
Received: from DB6PR8303MB0069.EURPRD83.prod.outlook.com
 ([fe80::3938:6d2d:c2fb:7b27]) by DB6PR8303MB0069.EURPRD83.prod.outlook.com
 ([fe80::3938:6d2d:c2fb:7b27%8]) with mapi id 15.20.1730.000; Fri, 8 Mar 2019
 17:33:40 +0000
From:   Norbert Nemec <Norbert.Nemec@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: fast-import on existing branches
Thread-Topic: fast-import on existing branches
Thread-Index: AdTVnL4X4Jxw2/2tSNKV4QAkAn17vAAKIfkAAAMbPeA=
Date:   Fri, 8 Mar 2019 17:33:40 +0000
Message-ID: <DB6PR8303MB006927B6267629467F783F58FD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
References: <DB6PR8303MB0069AA4D630BFDF0EC72C47BFD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
 <CABPp-BF0PcdwpJR3NteCmQw0QhN3E0UAi22FvmjUc6SBr=UB_A@mail.gmail.com>
In-Reply-To: <CABPp-BF0PcdwpJR3NteCmQw0QhN3E0UAi22FvmjUc6SBr=UB_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=nonemec@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-08T17:33:38.5987318Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8a03e97-fa0a-41c9-ada4-eccbde395979;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2a01:110:8012:1010:f828:d50f:b3bd:df9b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16dc556e-8fa8-4424-67c5-08d6a3ec3489
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR8303MB0072;
x-ms-traffictypediagnostic: DB6PR8303MB0072:
x-microsoft-antispam-prvs: <DB6PR8303MB0072A2EAC761C62F170C83A5FD4D0@DB6PR8303MB0072.EURPRD83.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(376002)(39860400002)(52314003)(13464003)(199004)(189003)(2351001)(86612001)(14454004)(22452003)(86362001)(6436002)(229853002)(68736007)(2501003)(305945005)(5660300002)(97736004)(316002)(99286004)(6916009)(3480700005)(7736002)(186003)(7696005)(106356001)(25786009)(72206003)(105586002)(33656002)(76176011)(10090500001)(8936002)(2906002)(53546011)(6506007)(8990500004)(102836004)(11346002)(9686003)(476003)(81166006)(81156014)(1730700003)(10290500003)(71200400001)(446003)(478600001)(71190400001)(55016002)(486006)(6246003)(53936002)(256004)(14444005)(5640700003)(52536013)(46003)(74316002)(6346003)(8676002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR8303MB0072;H:DB6PR8303MB0069.EURPRD83.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Norbert.Nemec@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7mBviO8PPzH2/C6q63qM9iuruVpLB9x/ds3lVXEk56Gw0k/BrpkcKz0q8cMx5KYmDG3kf6mRMoahpVmsLH8zcyEV16m9exBfFmDXQqqm/Ix7CkUfvx4em/OdbSCbvjVqwhZXcyH0ZokOiOPsFG0+tHMd2biwJpR21UahCaChyZevNU0vZV2rkyqp+pnuSg6algiQFC+o6e07iRc5mDpBTfUOAGuKVqbi0Q0jH3ZVzY7a6J/FbNxme9TSICNeoQHOYGq41LHcq7k0PDnXyiwU9Hq23NIP1k0T+DilECRGSiAyIhvfkQ+JfGGVO7XdCXNdjcbGr7/GbyPMojPy3mM7z3byTFqexn4zCi23XoLOdNw8rpN57qlnikLM2ze97b/rm43ztIZaeFoYdFABWtQY25zaL7Y47Va/A4OorX2MaLc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dc556e-8fa8-4424-67c5-08d6a3ec3489
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 17:33:40.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR8303MB0072
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLCBFbGlqYWgsIEkgaGFkIGluZGVlZCBtaXNzZWQgdGhhdCBibG9jayBhYm91dCB0aGUg
XjAgaGFuZGxpbmcuDQoNCkkgc3RpbGwgZG9uJ3QgZ2V0IHdoeSB0aGlzIGF3a3dhcmQgd29ya2Fy
b3VuZCBpcyByZXF1aXJlZC4gV2h5IGlzbid0IHRoYXQgbG9va3VwIGRvbmUgYnkgZGVmYXVsdD8g
UGVyZm9ybWFuY2UgY2FuJ3QgYmUgdGhlIHJlYXNvbiwgc2luY2UgdGhlIHNhbWUgbG9va3VwIGlz
IGRvbmUgbGF0ZXJvbiBhbnl3YXksIGp1c3QgYXMgY29ycmVjdG5lc3MgY2hlY2suIFRoZSB3YXkg
SSByZWFkIHRoZSBkb2N1bWVudGF0aW9uLCBwcm92aWRpbmcgbm8gImZyb20iIHNob3VsZCBjb250
aW51ZSBjb21taXR0aW5nIHRvIGEgYnJhbmNoIGluIGFueSBjYXNlLiBJIHdvdWxkIG5ldmVyIGhh
dmUgc2VlbiB0aGUgY29udGludWF0aW9uIG9mIGFuIGluY3JlbWVudGFsIGltcG9ydCBhICJzcGVj
aWFsIGNhc2UiLiBUaGVyZSBpcyBhIG51bWJlciBvZiB0b29scyBhcm91bmQgdGhhdCBzeW5jIGEg
Z2l0IHJlcG8gZnJvbSBzb21lIG90aGVyIHNvdXJjZSBhbmQgd291bGQgcmVndWxhcmx5IG5lZWQg
dG8gY29udGludWUgYW4gZXhpc3RpbmcgYnJhbmNoLg0KDQpHcmVldGluZ3MsDQpOb3JiZXJ0DQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEVsaWphaCBOZXdyZW4gPG5ld3Jl
bkBnbWFpbC5jb20+IA0KU2VudDogRnJpZGF5LCBNYXJjaCA4LCAyMDE5IDQ6NDEgUE0NClRvOiBO
b3JiZXJ0IE5lbWVjIDxOb3JiZXJ0Lk5lbWVjQG1pY3Jvc29mdC5jb20+DQpDYzogZ2l0QHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogUmU6IGZhc3QtaW1wb3J0IG9uIGV4aXN0aW5nIGJyYW5jaGVz
DQoNCkhpIE5vcmJlcnQsDQoNCk9uIEZyaSwgTWFyIDgsIDIwMTkgYXQgMjo1MSBBTSBOb3JiZXJ0
IE5lbWVjIDxOb3JiZXJ0Lk5lbWVjQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPg0KPiBIaSB0aGVy
ZSwNCj4NCj4gSSd2ZSBzdHJ1Z2dsZWQgZm9yIHF1aXRlIHNvbWUgdGltZSB0byBzb3J0IG91dCBk
b2N1bWVudGVkLCBpbnRlbmRlZCBhbmQgYWN0dWFsIGJlaGF2aW9yIG9mIGdpdCBmYXN0LWltcG9y
dC4gVW5sZXNzIEknbSBjb21wbGV0ZWx5IG1pc3Rha2VuLCBpdCBzZWVtcyB0byBiZSBhIHN0cmFp
Z2h0Zm9yd2FyZCBidWcsIGJ1dCBpZiB0aGF0IGlzIHRoZSBjYXNlLCBJIGFtIHJlYWxseSBzdXJw
cmlzZWQgd2h5IG5vYm9keSBlbHNlIGhhcyBzdHVtYmxlZCBvdmVyIGl0IGJlZm9yZToNCj4NCj4g
SSBtYW5hZ2VkIHRvIHVzZSBmYXN0LWltcG9ydCBmb3IgYSBjaGFpbiBvZiBjb21taXRzIG9udG8g
YSBuZXcgYnJhbmNoIGludG8gYW4gZW1wdHkgcmVwb3NpdG9yeS4NCj4gSSBtYW5hZ2VkIHRvIHVz
ZSBmYXN0LWltcG9ydCB0byBjcmVhdGUgYSBuZXcgYnJhbmNoIHN0YXJ0aW5nIGZyb20gYW4gZXhp
c3RpbmcgcGFyZW50IHVzaW5nIHRoZSAnZnJvbScgY29tbWFuZCBhcyBkb2N1bWVudGVkLg0KPg0K
PiBXaGF0IEkgZmFpbGVkIHRvIGRvIGlzIHRvIGFkZCBjb21taXRzIG9uIHRvcCBvZiBhbiBleGlz
dGluZyBicmFuY2ggaW4gYSBuZXcgZmFzdC1pbXBvcnQgc3RyZWFtLiBBcyBpdCBzZWVtcywgdGhl
IHZhcmlhbnQgb2YgdXNpbmcgJ2NvbW1pdCcgd2l0aG91dCAnZnJvbScgb25seSB3b3JrcyBvbiBi
cmFuY2hlcyB0aGF0IHdlcmUgY3JlYXRlZCB3aXRoaW4gdGhlIHNhbWUgZmFzdC1pbXBvcnQgc3Ry
ZWFtIQ0KPg0KPiBUaGUgZGlmZmVyZW50IGFwcHJvYWNoZXMgSSB0cmllZCAoZWFjaCB3aXRoIG5l
dyBmYXN0LWltcG9ydCBzdHJlYW0gb24gDQo+IGV4aXN0aW5nIHJlcG8gd2l0aCBleGlzdGluZyBi
cmFuY2gpDQo+ICogJ2NvbW1pdCcgd2l0aG91dCAnZnJvbScNCj4gLT4gRXJyb3I6ICJOb3QgdXBk
YXRpbmcgPGJyYW5jaD4gKG5ldyB0aXAgPGhhc2g+IGRvZXMgbm90IGNvbnRhaW4gDQo+IC0+IDxo
YXNoPikNCj4gQW5kIGluZGVlZCBsb29raW5nIGludG8gdGhlIHJlcG8gYWZ0ZXJ3YXJkcywgYSBu
ZXcgY29tbWl0IGV4aXN0cyB3aXRob3V0IGFueSBwYXJlbnQuDQo+ICogJ2NvbW1pdCcgd2l0aCAn
ZnJvbScgYm90aCBuYW1pbmcgdGhlIHNhbWUgYnJhbmNoDQo+IC0+IEVycm9yOiAiQ2FuJ3QgY3Jl
YXRlIGEgYnJhbmNoIGZyb20gaXRzZWxmIg0KPiBUaGUgb25seSB3b3JrYXJvdW5kcyB0aGF0IEkg
Y291bGQgZmluZCBhcmUgdG8gZWl0aGVyIGV4cGxpY2l0bHkgbG9va2luZyB1cCB0aGUgdG9wIGNv
bW1pdCBvbiB0aGUgdGFyZ2V0IGJyYW5jaCBhbmQgaGFuZCB0aGF0IHRvIGZhc3QtaW1wb3J0IG9y
IGNyZWF0ZSBhIHRlbXBvcmFyeSBicmFuY2ggd2l0aCBhIGRpZmZlcmVudCBuYW1lLg0KDQpJIHdv
dWxkIGhhdmUganVzdCB1c2VkICJmcm9tIDxzaGExPiIgd2hlcmUgPHNoYTE+IGlzIHNvbWV0aGlu
ZyBJIGxvb2sgdXAgZnJvbSB0aGUgY3VycmVudCBicmFuY2ggSSB3YW50IHRvIHVwZGF0ZS4gIEJ1
dCwgcmUtbG9va2luZyBhdCB0aGUgZG9jcywgaXQgYXBwZWFycyBnaXQtZmFzdC1pbXBvcnQudHh0
IGNvdmVycyB0aGlzIGFscmVhZHkgd2l0aCBhIHBvc3NpYmx5IGVhc2llciBzeW50YXg6DQoNCiIi
Ig0KVGhlIHNwZWNpYWwgY2FzZSBvZiByZXN0YXJ0aW5nIGFuIGluY3JlbWVudGFsIGltcG9ydCBm
cm9tIHRoZSBjdXJyZW50IGJyYW5jaCB2YWx1ZSBzaG91bGQgYmUgd3JpdHRlbiBhczoNCi0tLS0N
CiAgICAgICAgZnJvbSByZWZzL2hlYWRzL2JyYW5jaF4wDQotLS0tDQpUaGUgYF4wYCBzdWZmaXgg
aXMgbmVjZXNzYXJ5IGFzIGZhc3QtaW1wb3J0IGRvZXMgbm90IHBlcm1pdCBhIGJyYW5jaCB0byBz
dGFydCBmcm9tIGl0c2VsZiwgYW5kIHRoZSBicmFuY2ggaXMgY3JlYXRlZCBpbiBtZW1vcnkgYmVm
b3JlIHRoZSBgZnJvbWAgY29tbWFuZCBpcyBldmVuIHJlYWQgZnJvbSB0aGUgaW5wdXQuICBBZGRp
bmcgYF4wYCB3aWxsIGZvcmNlIGZhc3QtaW1wb3J0IHRvIHJlc29sdmUgdGhlIGNvbW1pdCB0aHJv
dWdoIEdpdCdzIHJldmlzaW9uIHBhcnNpbmcgbGlicmFyeSwgcmF0aGVyIHRoYW4gaXRzIGludGVy
bmFsIGJyYW5jaCB0YWJsZSwgdGhlcmVieSBsb2FkaW5nIGluIHRoZSBleGlzdGluZyB2YWx1ZSBv
ZiB0aGUgYnJhbmNoLg0KIiIiDQoNClBlcmhhcHMgdHJ5IHRoYXQ/DQoNCj4gTG9va2luZyB0aHJv
dWdoIHRoZSBjb2RlIG9mIGZhc3QtaW1wb3J0LmMsIEkgY2FuIGluZGVlZCBsb29rdXBfYnJhbmNo
IGFuZCBuZXdfYnJhbmNoIG9ubHkgZGVhbCB3aXRoIGludGVybmFsIGRhdGEgc3RydWN0dXJlcyBh
bmQgdGhlIG9ubHkgcG9pbnQgd2VyZSByZWFkX3JlZiBpcyBjYWxsZWQgdG8gYWN0dWFsbHkgcmVh
ZCBleGlzdGluZyBicmFuY2hlcyBmcm9tIHRoZSByZXBvIGlzIGluIHVwZGF0ZV9icmFuY2ggdG8g
Y2hlY2sgd2hldGhlciB0aGUgcGFyZW50IHdhcyBzZXQgY29ycmVjdGx5LiBXaGF0IGlzIG1pc3Np
bmcgaXMgYSBjYWxsIHRvIHJlYWRfcmVmIGluIGVpdGhlciBsb29rdXBfYnJhbmNoIG9yIG5ld19i
cmFuY2ggKHByb2JhYmx5IGJvdGggaGF2ZSB0byBiZSByZXdvcmtlZCBpbiBzb21lIHdheSB0byBo
YW5kbGUgdGhpcyBjbGVhbmx5KS4gRnJvbSBhbGwgSSBjYW4gc2VlIGEgZml4IHNob3VsZCBiZSBm
YWlybHkgc3RyYWlnaHRmb3J3YXJkIHRvIGltcGxlbWVudCwgYnV0IEkgYW0gcmVhbGx5IG5vdCBz
dXJlIHdoZXRoZXIgSSBoYXZlIHRoZSBmdWxsIHBpY3R1cmUgb24gdGhpcy4NCj4NCj4gKEkgZm91
bmQgYWxsIG9mIHRoaXMgc3RydWdnbGluZyB3aXRoIGdpdC1wNC5weSB3aGljaCBhcHBlYXJzIHRv
IA0KPiBjb250YWlucyBhIGNvbXBsZXggYW5kIG5vdCBmdWxseSBjb3JyZWN0IG1lY2hhbmlzbSB0
byBkZXRlcm1pbmUgdGhlIA0KPiAnaW5pdGFsUGFyZW50JyB0aGF0IGFwcGVhcnMgdG8gaW1wbGVt
ZW50IGp1c3Qgc3VjaCBhIHdvcmthcm91bmQuKQ0KPg0KPiBJIHdvdWxkIGJlIGdyYXRlZnVsIGZv
ciBhbnkgaW5wdXQgb24gdGhpcyBpc3N1ZSEgR3JlZXRpbmdzLCBOb3JiZXJ0DQoNCkhvcGUgdGhh
dCBoZWxwcywNCkVsaWphaA0K

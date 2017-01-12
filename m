Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9121FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 19:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdALTGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 14:06:31 -0500
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:34283
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750814AbdALTG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 14:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JuYHO0f0Fiz663K4kamqWB7eZFI+hzdoWFuVawDIkn4=;
 b=d4Rpx3v8q5JWrqsVkChxa/PDR1NUoKHOjhRTtJakTcI4mayDcRCe+LyS1025C9a25oC47BSeP4G4x/MN2X5OA/pWoPiCQAcbaD3SX8aZBq0u8eoImPPGVlbu1+dbbaqScCzAXl1m75u3ZmPbhCEoivBmnmVO0hv/wl3BGaNQhLs=
Received: from BY2PR21MB0036.namprd21.prod.outlook.com (10.162.77.23) by
 BY2PR21MB0034.namprd21.prod.outlook.com (10.162.77.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.860.0; Thu, 12 Jan 2017 19:06:27 +0000
Received: from BY2PR21MB0036.namprd21.prod.outlook.com ([10.162.77.23]) by
 BY2PR21MB0036.namprd21.prod.outlook.com ([10.162.77.23]) with mapi id
 15.01.0860.000; Thu, 12 Jan 2017 19:06:27 +0000
From:   Matthew Wilcox <mawilcox@microsoft.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Matthew Wilcox <mawilcox@linuxonhyperv.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 1/2] mailinfo: Add support for keep_cr
Thread-Topic: [PATCH 1/2] mailinfo: Add support for keep_cr
Thread-Index: AQHSbKS/CdRw075KSUWT8HpmVmfjc6E1I2EAgAAPpZA=
Date:   Thu, 12 Jan 2017 19:06:27 +0000
Message-ID: <BY2PR21MB0036E89DDFC5EFC8F17CD77DCB790@BY2PR21MB0036.namprd21.prod.outlook.com>
References: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
 <8f2be1e9-9199-44af-9d57-41763cb4d666@google.com>
In-Reply-To: <8f2be1e9-9199-44af-9d57-41763cb4d666@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mawilcox@microsoft.com; 
x-originating-ip: [58.84.192.132]
x-ms-office365-filtering-correlation-id: f7fbb439-f20f-423f-b78d-08d43b1e1c38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BY2PR21MB0034;
x-microsoft-exchange-diagnostics: 1;BY2PR21MB0034;7:PcsxoEi/pSRFellcD9WhAzTYhBBwwzgai5grXinEJKjZ9NLg10exNczVp+V4N1l5uWliGXn7vPu7Twa0LuevJizPDGpsy2VJnj/J8eyWQD5q3+gr3kW4iwUG3mjp/cykSFCH/7awXRC0FTzf0MOFnYJWWi/6jdya3UvUnNXdf74GZycYkJXO72r3pSSXEb9NUw4L7jss1Tg2CwTKLNugF5MzoV9wwc7/bpIdo4Biy62/lCKDBVLO7UjJz/WmFXFt4DmnRQdyRLCSEBFSNBG8YutUTlVfiSPlRWYB3/xfDCjBl2XWxcxBIT9Ai4BxCY61PahtFid3qFEq2pwp00tIJAG6oQYlaU83YWT1rWBdI70hShUMEaZfV0XddFIjkCRNrYfhY8S11v+3Ho1TnmxVxMzqU/3hkdX1kbZolz+gT1SS64jZK14BWOHHGdopx3FQ3k1nHtasuMOoSgnliLoh2e04/SaOnCrboRdE2WIqYok=
x-microsoft-antispam-prvs: <BY2PR21MB0034ABB43C94DCFF89EF8C91CB790@BY2PR21MB0034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(20161123555025)(20161123564025)(6072148)(6042181);SRVR:BY2PR21MB0034;BCL:0;PCL:0;RULEID:;SRVR:BY2PR21MB0034;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(51914003)(199003)(24454002)(189002)(377454003)(2501003)(3280700002)(8936002)(229853002)(86362001)(50986999)(9686003)(25786008)(81156014)(33656002)(2906002)(106356001)(105586002)(74316002)(10090500001)(106116001)(66066001)(122556002)(3660700001)(5660300001)(5005710100001)(8990500004)(86612001)(6116002)(102836003)(38730400001)(54356999)(2900100001)(10290500002)(92566002)(97736004)(7736002)(7696004)(107886002)(189998001)(5001770100001)(6506006)(81166006)(6436002)(2950100002)(8676002)(305945005)(77096006)(68736007)(55016002)(3846002)(99286003)(101416001)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR21MB0034;H:BY2PR21MB0036.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2017 19:06:27.3525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR21MB0034
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RnJvbTogSm9uYXRoYW4gVGFuIFttYWlsdG86am9uYXRoYW50YW5teUBnb29nbGUuY29tXQ0KPiBP
biAwMS8xMi8yMDE3IDAxOjIwIEFNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gQSB0ZXN0IGV4
ZXJjaXNpbmcgdGhlIG5ldyBmdW5jdGlvbmFsaXR5IHdvdWxkIGJlIG5pY2UuDQoNClJvZ2VyLg0K
DQo+IEFsc28sIG1heWJlIGEgbW9yZSBkZXNjcmlwdGl2ZSB0aXRsZSBsaWtlICJtYWlsaW5mbzog
YWxzbyByZXNwZWN0DQo+IGtlZXBfY3IgYWZ0ZXIgYmFzZTY0IGRlY29kZSIgKDUwIGNoYXJhY3Rl
cnMpIGlzIGJldHRlci4NCg0KTm8gcHJvYmxlbS4NCg0KPiA+IEBAIC0xNDMsNiArMTQ0LDcgQEAg
c3RhdGljIHZvaWQgYW1fc3RhdGVfaW5pdChzdHJ1Y3QgYW1fc3RhdGUgKnN0YXRlLA0KPiBjb25z
dCBjaGFyICpkaXIpDQo+ID4NCj4gPiAgCW1lbXNldChzdGF0ZSwgMCwgc2l6ZW9mKCpzdGF0ZSkp
Ow0KPiA+DQo+ID4gKwlzdGF0ZS0+a2VlcF9jciA9IC0xOw0KPiANCj4gTWF5YmUgcXVlcnkgdGhl
IGdpdCBjb25maWcgaGVyZSAoaW5zdGVhZCBvZiBsYXRlcikgc28gdGhhdCB3ZSBuZXZlciBoYXZl
DQo+IHRvIHdvcnJ5IGFib3V0IHN0YXRlLT5rZWVwX2NyIGJlaW5nIG5laXRoZXIgMCBub3IgMT8g
VGhpcyBmdW5jdGlvbg0KPiBhbHJlYWR5IHF1ZXJpZXMgdGhlIGdpdCBjb25maWcgYW55d2F5Lg0K
DQpJIHdvbmRlcmVkIHdoeSB0aGUgZXhpc3RpbmcgY29kZSBkaWRuJ3QgZG8gdGhhdCwgYnV0IEkg
d2FudGVkIHRvIG1ha2UgYSBtaW5pbWFsIGNoYW5nZSByYXRoZXIgdGhhbiBjbGVhbiB1cCBhbiBv
bGRlciBtaXN0YWtlLiAgSSdtIGhhcHB5IHRvIGRvIGl0IHRoYXQgd2F5Lg0KDQo+ID4gZGlmZiAt
LWdpdCBhL21haWxpbmZvLmggYi9tYWlsaW5mby5oDQo+ID4gaW5kZXggMDRhMjUzNTFkLi45ZmRk
Y2Y2ODQgMTAwNjQ0DQo+ID4gLS0tIGEvbWFpbGluZm8uaA0KPiA+ICsrKyBiL21haWxpbmZvLmgN
Cj4gPiBAQCAtMTIsNiArMTIsNyBAQCBzdHJ1Y3QgbWFpbGluZm8gew0KPiA+ICAJc3RydWN0IHN0
cmJ1ZiBlbWFpbDsNCj4gPiAgCWludCBrZWVwX3N1YmplY3Q7DQo+ID4gIAlpbnQga2VlcF9ub25f
cGF0Y2hfYnJhY2tldHNfaW5fc3ViamVjdDsNCj4gPiArCWludCBrZWVwX2NyOw0KPiA+ICAJaW50
IGFkZF9tZXNzYWdlX2lkOw0KPiA+ICAJaW50IHVzZV9zY2lzc29yczsNCj4gPiAgCWludCB1c2Vf
aW5ib2R5X2hlYWRlcnM7DQo+IA0KPiBJIHBlcnNvbmFsbHkgd291bGQgd3JpdGUgInVuc2lnbmVk
IGtlZXBfY3IgOiAxIiB0byBmdXJ0aGVyIGVtcGhhc2l6ZQ0KPiB0aGF0IHRoaXMgY2FuIG9ubHkg
YmUgMCBvciAxLCBidXQgSSBkb24ndCBrbm93IGlmIGl0J3MgYmV0dGVyIHRvIGtlZXANCj4gd2l0
aCB0aGUgc3R5bGUgZXhpc3RpbmcgaW4gdGhlIGZpbGUgKHRoYXQgaXMsIHVzaW5nIGludCkuDQoN
ClByb2JhYmx5IGJlc3QgdG8gc3RpY2sgdG8gdGhlIGV4aXN0aW5nIGZpbGUgLi4uIHNvbWVvbmUg
Y2FuIGFsd2F5cyBkbyBhIGNsZWFudXAgcGF0Y2ggbGF0ZXIsIGFuZCBoYXZpbmcgdGhpcyBtYXRj
aCB0aGUgb3RoZXJzIHdpbGwgbWFrZSB0aGF0IGVhc2llciwgbm90IGhhcmRlci4NCg0KVGhhbmtz
IGZvciB0aGUgcmV2aWV3Lg0KDQo=

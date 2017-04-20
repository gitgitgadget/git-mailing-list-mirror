Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4384207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032295AbdDTUKn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:10:43 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:42617 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032188AbdDTUK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:10:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 2F25E100064;
        Thu, 20 Apr 2017 20:10:25 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eeLWEW4MfuMB; Thu, 20 Apr 2017 20:10:25 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 1C63D8002E;
        Thu, 20 Apr 2017 20:10:25 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 20 Apr 2017 20:10:24 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Thu, 20 Apr 2017 20:10:24 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: RE: [PATCH] repack: respect gc.pid lock
Thread-Topic: [PATCH] repack: respect gc.pid lock
Thread-Index: AQHStVYFs4jQpN8FG0CoCGa3r9IKNaHJsErwgADQfoCAAOKaQIAAAdOAgAAFm+CAAAL3gIADQ8Fg
Date:   Thu, 20 Apr 2017 20:10:24 +0000
Message-ID: <7e31f4ed5c0f4c31b2870fb58cf7110e@exmbdft7.ad.twosigma.com>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
 <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
 <2400e9cbfaff4838a8f3b23c4c2c5a22@exmbdft7.ad.twosigma.com>
 <20170418171930.zad5wrbu5rvdsmg5@sigill.intra.peff.net>
 <710ded65bb8843ab838d9c52cd796317@exmbdft7.ad.twosigma.com>
 <20170418175011.qx64luolrvqwwtpa@sigill.intra.peff.net>
In-Reply-To: <20170418175011.qx64luolrvqwwtpa@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEtpbmcgW21haWx0bzpw
ZWZmQHBlZmYubmV0XQ0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxOCwgMjAxNyAxOjUwIFBNDQo+
IFRvOiBEYXZpZCBUdXJuZXIgPERhdmlkLlR1cm5lckB0d29zaWdtYS5jb20+DQo+IENjOiBnaXRA
dmdlci5rZXJuZWwub3JnOyBjaHJpc3RpYW4uY291ZGVyQGdtYWlsLmNvbTsgbWZpY2tAY29kZWF1
cm9yYS5vcmc7DQo+IGphY29iLmtlbGxlckBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gcmVwYWNrOiByZXNwZWN0IGdjLnBpZCBsb2NrDQo+IA0KPiBPbiBUdWUsIEFwciAxOCwgMjAx
NyBhdCAwNTo0MzoyOVBNICswMDAwLCBEYXZpZCBUdXJuZXIgd3JvdGU6DQo+IA0KPiA+ID4gQSBs
b2NrIGNhbiBjYXRjaCB0aGUgcmFjeSBjYXNlcyB3aGVyZSBib3RoIHJ1biBhdCB0aGUgc2FtZSB0
aW1lLiBCdXQNCj4gPiA+IEkgdGhpbmsgdGhhdA0KPiA+ID4gZXZlbjoNCj4gPiA+DQo+ID4gPiAg
IGdpdCAtYyByZXBhY2sud3JpdGVCaXRtYXBzPXRydWUgcmVwYWNrIC1BZA0KPiA+ID4gICBbLi4u
d2FpdC4uLl0NCj4gPiA+ICAgZ2l0IGdjDQo+ID4gPg0KPiA+ID4gaXMgcXVlc3Rpb25hYmxlLCBi
ZWNhdXNlIHRoYXQgZ2Mgd2lsbCBlcmFzZSB5b3VyIGJpdG1hcHMuIEhvdyBkb2VzDQo+ID4gPiBn
aXQtZ2Mga25vdyB0aGF0IGl0J3MgZG9pbmcgYSBiYWQgdGhpbmcgYnkgcmVwYWNraW5nIHdpdGhv
dXQNCj4gPiA+IGJpdG1hcHMsIGFuZCB0aGF0IHlvdSBkaWRuJ3Qgc2ltcGx5IGNoYW5nZSB5b3Vy
IGNvbmZpZ3VyYXRpb24gb3Igd2FudCB0byBnZXQNCj4gcmlkIG9mIHRoZW0/DQo+ID4NCj4gPiBT
b3JyeSwgdGhlIGdjIGluIEdpdGxhYiBkb2VzIGtlZXAgYml0bWFwcy4gIFRoZSBvbmUgSSBxdW90
ZWQgaW4gYQ0KPiA+IHByZXZpb3VzIG1lc3NhZ2UgIGRvZXNuJ3QsIGJlY2F1c2UgdGhlIHBlcnNv
biB0eXBpbmcgdGhlIGNvbW1hbmQgd2FzDQo+ID4ganVzdCBkb2luZyBzb21lIG1hbnVhbCAgdGVz
dGluZyBhbmQgSSBndWVzcyBkaWRuJ3QgcmVhbGl6ZSB0aGF0DQo+ID4gYml0bWFwcyB3ZXJlIGlt
cG9ydGFudC4gIE9yIHBlcmhhcHMgaGUga25ldyB0aGF0IHJlcGFjay53cml0ZUJpdG1hcHMgd2Fz
DQo+IGFscmVhZHkgc2V0IGluIHRoZSBjb25maWcuDQo+IA0KPiBTdXJlLCBidXQgSSBndWVzcyBJ
J2QganVzdCB3b25kZXIgd2hhdCBfZWxzZV8gaXMgZGlmZmVyZW50IGJldHdlZW4gdGhlIGNvbW1h
bmRzDQo+IChhbmQgaWYgbm90aGluZywgd2h5IGFyZSBib3RoIHJ1bm5pbmcpLg0KDQpQcmVzdW1h
Ymx5LCByZXBhY2sgaXMgZmFzdGVyLCBhbmQgdGhleSdyZSBub3QgaW50ZW5kZWQgdG8gcnVuIGNv
bmN1cnJlbnRseSAoYnV0IA0KdGhlcmUncyBhIEdpdGxhYiBidWcgY2F1c2luZyB0aGVtIHRvIGRv
IHNvKS4gIEJ1dCB5b3UnbGwgaGF2ZSB0byBhc2sgdGhlIEdpdGxhYiANCmZvbGtzIGZvciBtb3Jl
IGRldGFpbHMuDQoNCj4gPiBTbyBnaXZlbiB0aGF0IHRoZSBsb2NrIHdpbGwgY2F0Y2ggdGhlIHJh
Y2VzLCBtaWdodCBpdCBiZSBhIGdvb2QgaWRlYQ0KPiA+IChpZiBJbXBsZW1lbnRlZCB0byBhdm9p
ZCBsb2NraW5nIG9uIHJlcGFjayAtZCk/DQo+IA0KPiBJJ20gbWlsZGx5IG5lZ2F0aXZlIGp1c3Qg
YmVjYXVzZSBpdCBpbmNyZWFzZXMgY29tcGxleGl0eSwgYW5kIEkgZG9uJ3QgdGhpbmsgaXQncw0K
PiBhY3R1YWxseSBidXlpbmcgdmVyeSBtdWNoLiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aGljaCBp
bnZvY2F0aW9ucyBvZiByZXBhY2sNCj4gd291bGQgd2FudCB0byBsb2NrIGFuZCB3aGljaCBvbmVz
IHdvdWxkbid0Lg0KPiANCj4gSXMgIi1hIiBvciAiLUEiIHRoZSBrZXkgZmFjdG9yPyBBcmUgdGhl
cmUgY3VycmVudCBjYWxsZXJzIHdobyBwcmVmZXIgdGhlIGN1cnJlbnQNCj4gYmVoYXZpb3Igb2Yg
InBvc3NpYmx5IGR1cGxpY2F0ZSBzb21lIHdvcmssIGJ1dCBuZXZlciByZXBvcnQgZmFpbHVyZSIg
dmVyc3VzICJkbw0KPiBub3QgZHVwbGljYXRlIHdvcmssIGJ1dCBzb21ldGltZXMgZmFpbCBkdWUg
dG8gbG9jayBjb250ZW50aW9uIj8NCg0KT25lIHByb2JsZW0gd2l0aCBmYWlsaW5nIGlzIHRoYXQg
aXQgY2FuIGxlYXZlIGEgdGVtcCBwYWNrIGJlaGluZC4NCg0KSSB0aGluayB0aGUgY29ycmVjdCBm
aXggaXMgdG8gY2hhbmdlIHRoZSBkZWZhdWx0IGNvZGUucGFja2VkR2l0TGltaXQgb24gNjQtYml0
IA0KbWFjaGluZXMgdG8gMzIgdGVyYWJ5dGVzICgyKio0NSBieXRlcykuICBUaGF0J3MgYmVjYXVz
ZSBvbiBtb2Rlcm4gSW50ZWwgDQpwcm9jZXNzb3JzLCB0aGVyZSBhcmUgNDggYml0cyBvZiBhZGRy
ZXNzIHNwYWNlIGFjdHVhbGx5IGF2YWlsYWJsZSwgYnV0IHRoZSBrZXJuZWwgDQppcyBnb2luZyB0
byBwcm9iYWJseSByZXNlcnZlIGEgZmV3IGJpdHMuICBNeSBtYWNoaW5lIGNsYWltcyB0byBoYXZl
IDIqKjQ2IGJ5dGVzIA0Kb2YgdmlydHVhbCBhZGRyZXNzIHNwYWNlIGF2YWlsYWJsZS4gIEl0J3Mg
YWxzbyBzZXZlcmFsIHRpbWVzIGJpZ2dlciB0aGFuIGFueSANCnJlcG8gdGhhdCBJIGtub3cgb2Yg
b3IgY2FuIGVhc2lseSBpbWFnaW5lLg0KDQpEb2VzIHRoYXQgc2VlbSByZWFzb25hYmxlIHRvIHlv
dT8NCg==

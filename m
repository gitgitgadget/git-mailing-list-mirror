Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6AB201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 17:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbdDRRnd (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:43:33 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:49602 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbdDRRnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:43:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id DFB541000D7;
        Tue, 18 Apr 2017 17:43:29 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7GA5WtNmGe7E; Tue, 18 Apr 2017 17:43:29 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id CF4AB8002E;
        Tue, 18 Apr 2017 17:43:29 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 18 Apr 2017 17:43:29 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Tue, 18 Apr 2017 17:43:29 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: RE: [PATCH] repack: respect gc.pid lock
Thread-Topic: [PATCH] repack: respect gc.pid lock
Thread-Index: AQHStVYFs4jQpN8FG0CoCGa3r9IKNaHJsErwgADQfoCAAOKaQIAAAdOAgAAFm+A=
Date:   Tue, 18 Apr 2017 17:43:29 +0000
Message-ID: <710ded65bb8843ab838d9c52cd796317@exmbdft7.ad.twosigma.com>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
 <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
 <2400e9cbfaff4838a8f3b23c4c2c5a22@exmbdft7.ad.twosigma.com>
 <20170418171930.zad5wrbu5rvdsmg5@sigill.intra.peff.net>
In-Reply-To: <20170418171930.zad5wrbu5rvdsmg5@sigill.intra.peff.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTgsIDIwMTcgMToyMCBQ
TQ0KPiBUbzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJuZXJAdHdvc2lnbWEuY29tPg0KPiBDYzog
Z2l0QHZnZXIua2VybmVsLm9yZzsgY2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb207IG1maWNrQGNv
ZGVhdXJvcmEub3JnOw0KPiBqYWNvYi5rZWxsZXJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHJlcGFjazogcmVzcGVjdCBnYy5waWQgbG9jaw0KPiANCj4gT24gVHVlLCBBcHIgMTgs
IDIwMTcgYXQgMDU6MTY6NTJQTSArMDAwMCwgRGF2aWQgVHVybmVyIHdyb3RlOg0KPiANCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKZWZmIEtpbmcgW21haWx0
bzpwZWZmQHBlZmYubmV0XQ0KPiA+ID4gU2VudDogTW9uZGF5LCBBcHJpbCAxNywgMjAxNyAxMTo0
MiBQTQ0KPiA+ID4gVG86IERhdmlkIFR1cm5lciA8RGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbT4N
Cj4gPiA+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnOyBjaHJpc3RpYW4uY291ZGVyQGdtYWlsLmNv
bTsNCj4gPiA+IG1maWNrQGNvZGVhdXJvcmEub3JnOyBqYWNvYi5rZWxsZXJAZ21haWwuY29tDQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSByZXBhY2s6IHJlc3BlY3QgZ2MucGlkIGxvY2sNCj4g
PiA+DQo+ID4gPiBPbiBNb24sIEFwciAxNywgMjAxNyBhdCAxMToyOToxOFBNICswMDAwLCBEYXZp
ZCBUdXJuZXIgd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBXZSBzYXcgdGhpcyBmYWlsdXJlIGluIHRo
ZSBsb2dzIG11bHRpcGxlICB0aW1lcyAod2l0aCB0aHJlZQ0KPiA+ID4gPiBkaWZmZXJlbnQgc2hh
cywgd2hpbGUgYSBnYyB3YXMgcnVubmluZyk6DQo+ID4gPiA+IEFwcmlsIDEyLCAyMDE3IDA2OjQ1
IC0+IEVSUk9SIC0+ICdnaXQgLWMgcmVwYWNrLndyaXRlQml0bWFwcz10cnVlDQo+ID4gPiA+IHJl
cGFjayAtQSAtZA0KPiA+ID4gLS1wYWNrLWtlcHQtb2JqZWN0cycgaW4gW3JlcG9dIGZhaWxlZDoN
Cj4gPiA+ID4gZmF0YWw6IHBhY2tmaWxlIC4vb2JqZWN0cy9wYWNrL3BhY2stW3NoYV0ucGFjayBj
YW5ub3QgYmUgYWNjZXNzZWQNCj4gPiA+ID4gUG9zc2libHkgc29tZSBvdGhlciByZXBhY2sgd2Fz
IGFsc28gcnVubmluZyBhdCB0aGUgdGltZSBhcyB3ZWxsLg0KPiA+ID4gPg0KPiA+ID4gPiBNeSBj
b2xsZWFndWUgYWxzbyBzYXcgaXQgd2hpbGUgbWFudWFsbHkgZG9pbmcgZ2MgKGFnYWluIHdoaWxl
DQo+ID4gPiA+IHJlcGFja3Mgd2VyZSBsaWtlbHkgdG8gYmUgcnVubmluZyk6DQo+ID4gPg0KPiA+
ID4gVGhpcyBpcyBzb3J0IG9mIGEgc2lkZSBxdWVzdGlvbiwgYnV0Li4ud2h5IGFyZSB5b3UgcnVu
bmluZyBvdGhlcg0KPiA+ID4gcmVwYWNrcyBhbG9uZ3NpZGUgZ2l0LWdjPyBJdCBzZWVtcyBsaWtl
IHlvdSBvdWdodCB0byBiZSBkb2luZyBvbmUgb3IgdGhlDQo+IG90aGVyLg0KPiA+DQo+ID4gQnV0
IGFjdHVhbGx5LCBpdCB3b3VsZCBiZSBraW5kIG9mIG5pY2UgaWYgZ2l0IHdvdWxkIGhlbHAgcHJv
dGVjdCB1cyBmcm9tIGRvaW5nDQo+IHRoaXM/DQo+IA0KPiBBIGxvY2sgY2FuIGNhdGNoIHRoZSBy
YWN5IGNhc2VzIHdoZXJlIGJvdGggcnVuIGF0IHRoZSBzYW1lIHRpbWUuIEJ1dCBJIHRoaW5rIHRo
YXQNCj4gZXZlbjoNCj4gDQo+ICAgZ2l0IC1jIHJlcGFjay53cml0ZUJpdG1hcHM9dHJ1ZSByZXBh
Y2sgLUFkDQo+ICAgWy4uLndhaXQuLi5dDQo+ICAgZ2l0IGdjDQo+IA0KPiBpcyBxdWVzdGlvbmFi
bGUsIGJlY2F1c2UgdGhhdCBnYyB3aWxsIGVyYXNlIHlvdXIgYml0bWFwcy4gSG93IGRvZXMgZ2l0
LWdjIGtub3cNCj4gdGhhdCBpdCdzIGRvaW5nIGEgYmFkIHRoaW5nIGJ5IHJlcGFja2luZyB3aXRo
b3V0IGJpdG1hcHMsIGFuZCB0aGF0IHlvdSBkaWRuJ3QNCj4gc2ltcGx5IGNoYW5nZSB5b3VyIGNv
bmZpZ3VyYXRpb24gb3Igd2FudCB0byBnZXQgcmlkIG9mIHRoZW0/DQoNClNvcnJ5LCB0aGUgZ2Mg
aW4gR2l0bGFiIGRvZXMga2VlcCBiaXRtYXBzLiAgVGhlIG9uZSBJIHF1b3RlZCBpbiBhIHByZXZp
b3VzIA0KbWVzc2FnZSAgZG9lc24ndCwgYmVjYXVzZSB0aGUgcGVyc29uIHR5cGluZyB0aGUgY29t
bWFuZCB3YXMganVzdCBkb2luZyBzb21lIA0KbWFudWFsICB0ZXN0aW5nIGFuZCBJIGd1ZXNzIGRp
ZG4ndCByZWFsaXplIHRoYXQgYml0bWFwcyB3ZXJlIGltcG9ydGFudC4gIE9yIA0KcGVyaGFwcyBo
ZSBrbmV3IHRoYXQgcmVwYWNrLndyaXRlQml0bWFwcyB3YXMgYWxyZWFkeSBzZXQgaW4gdGhlIGNv
bmZpZy4NCg0KU28gZ2l2ZW4gdGhhdCB0aGUgbG9jayB3aWxsIGNhdGNoIHRoZSByYWNlcywgbWln
aHQgaXQgYmUgYSBnb29kIGlkZWEgKGlmIA0KSW1wbGVtZW50ZWQgdG8gYXZvaWQgbG9ja2luZyBv
biByZXBhY2sgLWQpPw0K

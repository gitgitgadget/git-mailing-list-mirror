Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C0A207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbcI3XNB (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 19:13:01 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:34009 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbcI3XNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 19:13:00 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Sep 2016 19:12:59 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 176C5100052;
        Fri, 30 Sep 2016 23:07:19 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h1Fwel6K1i_Q; Fri, 30 Sep 2016 23:07:19 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 02E328002E;
        Fri, 30 Sep 2016 23:07:19 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Fri, 30 Sep 2016 23:07:11 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Fri, 30 Sep 2016 23:07:11 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 3/6] tmp-objdir: introduce API for temporary object
 directories
Thread-Topic: [PATCH 3/6] tmp-objdir: introduce API for temporary object
 directories
Thread-Index: AQHSG1pMQwb/ldXAYUWzW5NCDp/JCaCSh1nAgAAacwCAAAY0MA==
Date:   Fri, 30 Sep 2016 23:07:11 +0000
Message-ID: <b22eb24e64ee4026a04459dc02c27ff0@exmbdft7.ad.twosigma.com>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net>
 <b7136f0690244aee94ff2db726a7edce@exmbdft7.ad.twosigma.com>
 <20160930224450.zewgfqelljiwowh6@sigill.intra.peff.net>
In-Reply-To: <20160930224450.zewgfqelljiwowh6@sigill.intra.peff.net>
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

VGhhbmtzLiAgVGhlIHJlc3QgYWxsIGxvb2sgZ29vZCB0b28uDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWlsdG86cGVmZkBwZWZmLm5ldF0NCj4g
U2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMTYgNjo0NSBQTQ0KPiBUbzogRGF2aWQgVHVy
bmVyDQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy82
XSB0bXAtb2JqZGlyOiBpbnRyb2R1Y2UgQVBJIGZvciB0ZW1wb3Jhcnkgb2JqZWN0DQo+IGRpcmVj
dG9yaWVzDQo+IA0KPiBPbiBGcmksIFNlcCAzMCwgMjAxNiBhdCAwOTozMjowNFBNICswMDAwLCBE
YXZpZCBUdXJuZXIgd3JvdGU6DQo+IA0KPiA+ID4gK3N0YXRpYyB2b2lkIGVudl9hcHBlbmQoc3Ry
dWN0IGFyZ3ZfYXJyYXkgKmVudiwgY29uc3QgY2hhciAqa2V5LA0KPiA+ID4gK2NvbnN0IGNoYXIg
KnZhbCkgew0KPiA+ID4gKwljb25zdCBjaGFyICpvbGQgPSBnZXRlbnYoa2V5KTsNCj4gPiA+ICsN
Cj4gPiA+ICsJaWYgKCFvbGQpDQo+ID4gPiArCQlhcmd2X2FycmF5X3B1c2hmKGVudiwgIiVzPSVz
Iiwga2V5LCB2YWwpOw0KPiA+ID4gKwllbHNlDQo+ID4gPiArCQlhcmd2X2FycmF5X3B1c2hmKGVu
diwgIiVzPSVzJWMlcyIsIGtleSwgb2xkLCBQQVRIX1NFUCwNCj4gPiA+IHZhbCk7DQo+ID4gPit9
DQo+ID4NCj4gPiBJIHdvdWxkIGxpa2UgYSBjb21tZW50IGV4cGxhaW5pbmcgdGhpcyBmdW5jdGlv
bi4NCj4gDQo+IEknbGwgc3F1YXNoIGluOg0KPiANCj4gZGlmZiAtLWdpdCBhL3RtcC1vYmpkaXIu
YyBiL3RtcC1vYmpkaXIuYyBpbmRleCBjOTJlNmNjLi5hOThjMjQ2IDEwMDY0NA0KPiAtLS0gYS90
bXAtb2JqZGlyLmMNCj4gKysrIGIvdG1wLW9iamRpci5jDQo+IEBAIC03MCw2ICs3MCwxMyBAQCBz
dGF0aWMgdm9pZCByZW1vdmVfdG1wX29iamRpcl9vbl9zaWduYWwoaW50IHNpZ25vKQ0KPiAgCXJh
aXNlKHNpZ25vKTsNCj4gIH0NCj4gDQo+ICsvKg0KPiArICogVGhlc2UgZW52XyogZnVuY3Rpb25z
IGFyZSBmb3Igc2V0dGluZyB1cCB0aGUgY2hpbGQgZW52aXJvbm1lbnQ7IHRoZQ0KPiArICogInJl
cGxhY2UiIHZhcmlhbnQgb3ZlcnJpZGVzIHRoZSB2YWx1ZSBvZiBhbnkgZXhpc3RpbmcgdmFyaWFi
bGUgd2l0aA0KPiArdGhhdA0KPiArICogImtleSIuIFRoZSAiYXBwZW5kIiB2YXJpYW50IHB1dHMg
b3VyIG5ldyB2YWx1ZSBhdCB0aGUgZW5kIG9mIGEgbGlzdCwNCj4gKyAqIHNlcGFyYXRlZCBieSBQ
QVRIX1NFUCAod2hpY2ggaXMgd2hhdCBzZXBhcmF0ZSB2YWx1ZXMgaW4NCj4gKyAqIEdJVF9BTFRF
Uk5BVEVfT0JKRUNUX0RJUkVDVE9SSUVTKS4NCj4gKyAqLw0KPiAgc3RhdGljIHZvaWQgZW52X2Fw
cGVuZChzdHJ1Y3QgYXJndl9hcnJheSAqZW52LCBjb25zdCBjaGFyICprZXksIGNvbnN0IGNoYXIN
Cj4gKnZhbCkgIHsNCj4gIAljb25zdCBjaGFyICpvbGQgPSBnZXRlbnYoa2V5KTsNCj4gDQo+ID4g
PiArICogRmluYWxpemUgYSB0ZW1wb3Jhcnkgb2JqZWN0IGRpcmVjdG9yeSBieSBtaWdyYXRpbmcg
aXRzIG9iamVjdHMNCj4gPiA+ICtpbnRvIHRoZSBtYWluDQo+ID4gPiArICogb2JqZWN0IGRhdGFi
YXNlLg0KPiA+ID4gKyAqLw0KPiA+DQo+ID4gVGhpcyBzaG91bGQgbWVudGlvbiB0aGF0IGl0IGZy
ZWVzIGl0cyBhcmd1bWVudC4NCj4gDQo+IEFuZDoNCj4gDQo+IGRpZmYgLS1naXQgYS90bXAtb2Jq
ZGlyLmggYi90bXAtb2JqZGlyLmggaW5kZXggYWE0N2FhOS4uYjFlNDViNCAxMDA2NDQNCj4gLS0t
IGEvdG1wLW9iamRpci5oDQo+ICsrKyBiL3RtcC1vYmpkaXIuaA0KPiBAQCAtMzUsNyArMzUsOCBA
QCBjb25zdCBjaGFyICoqdG1wX29iamRpcl9lbnYoY29uc3Qgc3RydWN0IHRtcF9vYmpkaXINCj4g
Kik7DQo+IA0KPiAgLyoNCj4gICAqIEZpbmFsaXplIGEgdGVtcG9yYXJ5IG9iamVjdCBkaXJlY3Rv
cnkgYnkgbWlncmF0aW5nIGl0cyBvYmplY3RzIGludG8gdGhlIG1haW4NCj4gLSAqIG9iamVjdCBk
YXRhYmFzZS4NCj4gKyAqIG9iamVjdCBkYXRhYmFzZSwgcmVtb3ZpbmcgdGhlIHRlbXBvcmFyeSBk
aXJlY3RvcnksIGFuZCBmcmVlaW5nIGFueQ0KPiArICogYXNzb2NpYXRlZCByZXNvdXJjZXMuDQo+
ICAgKi8NCj4gIGludCB0bXBfb2JqZGlyX21pZ3JhdGUoc3RydWN0IHRtcF9vYmpkaXIgKik7DQo+
IA0KPiANCj4gLVBlZmYNCg==

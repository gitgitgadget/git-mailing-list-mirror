Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9842018E
	for <e@80x24.org>; Fri, 26 Aug 2016 18:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbcHZS2b (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 14:28:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:24637 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbcHZS2b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 14:28:31 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP; 26 Aug 2016 11:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,582,1464678000"; 
   d="scan'208";a="1599813"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2016 11:28:30 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.215]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.239]) with mapi id 14.03.0248.002;
 Fri, 26 Aug 2016 11:28:29 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "gitster@pobox.com" <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "j6t@kdbg.org" <j6t@kdbg.org>, "peff@peff.net" <peff@peff.net>,
        "stefanbeller@gmail.com" <stefanbeller@gmail.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH v11 5/8] allow do_submodule_path to work even if
 submodule isn't checked out
Thread-Topic: [PATCH v11 5/8] allow do_submodule_path to work even if
 submodule isn't checked out
Thread-Index: AQHR/8ZnP0x6iWKH20Olg6mvJqr6U6BcBRMA
Date:   Fri, 26 Aug 2016 18:28:29 +0000
Message-ID: <1472236108.28343.5.camel@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
         <20160825233243.30700-6-jacob.e.keller@intel.com>
         <xmqqshtrgzpi.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqshtrgzpi.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9726BE1F9DDF849B9BC4027884B9836@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gRnJpLCAyMDE2LTA4LTI2IGF0IDExOjE5IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gDQo+ID4gQ3VycmVudGx5LCBkb19zdWJtb2R1bGVfcGF0aCB3aWxsIGF0dGVtcHQgbG9jYXRp
bmcgdGhlIC5naXQNCj4gPiBkaXJlY3RvcnkgYnkNCj4gPiB1c2luZyByZWFkX2dpdGZpbGUgb24g
PHBhdGg+Ly5naXQuIElmIHRoaXMgZmFpbHMgaXQganVzdCBhc3N1bWVzDQo+ID4gdGhlDQo+ID4g
PHBhdGg+Ly5naXQgaXMgYWN0dWFsbHkgYSBnaXQgZGlyZWN0b3J5Lg0KPiA+IA0KPiA+IFRoaXMg
aXMgZ29vZCBiZWNhdXNlIGl0IGFsbG93cyBmb3IgaGFuZGxpbmcgc3VibW9kdWxlcyB3aGljaCB3
ZXJlDQo+ID4gY2xvbmVkDQo+ID4gaW4gYSByZWd1bGFyIG1hbm5lciBmaXJzdCBiZWZvcmUgYmVp
bmcgYWRkZWQgdG8gdGhlIHBhcmVudCBwcm9qZWN0Lg0KPiANCj4gcy9wYXJlbnQgcHJvamVjdC9z
dXBlcnByb2plY3QvOw0KPiANCg0KWWVwLg0KDQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVseSB0aGlz
IGZhaWxzIGlmIHRoZSA8cGF0aD4gaXMgbm90IGFjdHVhbGx5IGNoZWNrZWQgb3V0DQo+ID4gYW55
DQo+ID4gbG9uZ2VyLCBzdWNoIGFzIGJ5IHJlbW92aW5nIHRoZSBkaXJlY3RvcnkuDQo+ID4gDQo+
ID4gRml4IHRoaXMgYnkgY2hlY2tpbmcgaWYgdGhlIGRpcmVjdG9yeSB3ZSBmb3VuZCBpcyBhY3R1
YWxseSBhDQo+ID4gZ2l0ZGlyLiBJbg0KPiA+IHRoZSBjYXNlIGl0IGlzIG5vdCwgYXR0ZW1wdCB0
byBsb29rdXAgdGhlIHN1Ym1vZHVsZSBjb25maWd1cmF0aW9uDQo+ID4gYW5kDQo+ID4gZmluZCB0
aGUgbmFtZSBvZiB3aGVyZSBpdCBpcyBzdG9yZWQgaW4gdGhlIC5naXQvbW9kdWxlcy8gZm9sZGVy
IG9mDQo+ID4gdGhlDQo+ID4gcGFyZW50IHByb2plY3QuDQo+IA0KPiBBcyB5b3UgY29uc2lzdGVu
dGx5IHNheSAiZGlyZWN0b3J5IiBpbiB0aGUgZWFybGllciBwYXJ0IG9mIHRoZSBsb2cNCj4gbWVz
c2FnZSwNCj4gDQo+IHMvZm9sZGVyIG9mIHRoZSBwYXJlbnQgcHJvamVjdC9kaXJlY3Rvcnkgb2Yg
dGhlIHN1cGVycHJvamVjdC87DQo+IA0KPiBpcyBkZXNpcmVkLg0KPiANCg0KWWVwLg0KDQo+ID4g
DQo+ID4gDQo+ID4gSWYgd2UgY2FuJ3QgbG9jYXRlIHRoZSBzdWJtb2R1bGUgY29uZmlndXJhdGlv
biB0aGlzIG1pZ2h0IG9jY3VyDQo+ID4gYmVjYXVzZQ0KPiANCj4gSSBhZGRlZCBzL2NvbmZpZ3Vy
YXRpb24vJiwvIHRvIG1ha2UgaXQgYSBiaXQgZWFzaWVyIHRvIHJlYWQuDQo+IA0KDQpNYWtlcyBz
ZW5zZS4NCg0KPiA+IA0KPiA+IGZvciBleGFtcGxlIGEgc3VibW9kdWxlIGdpdGxpbmsgd2FzIGFk
ZGVkIGJ1dCB0aGUgY29ycmVzcG9uZGluZw0KPiA+IC5naXRtb2R1bGVzIGZpbGUgd2FzIG5vdCBw
cm9wZXJseSB1cGRhdGVkLiBBIGRpZSgpIGhlcmUgd291bGQgbm90DQo+ID4gYmUNCj4gPiBwbGVh
c2FudCB0byB0aGUgdXNlcnMgb2Ygc3VibW9kdWxlIGRpZmYgZm9ybWF0cywgc28gaW5zdGVhZCwg
bW9kaWZ5DQo+ID4gZG9fc3VibW9kdWxlX3BhdGggdG8gcmV0dXJuIGFuIGVycm9yIGNvZGUuIEZv
cg0KPiA+IGdpdF9wYXRoZHVwX3N1Ym1vZHVsZSwNCj4gPiBqdXN0IHJldHVybiBOVUxMIHdoZW4g
d2UgZmFpbCB0byBmaW5kIGEgcGF0aC4gRm9yDQo+ID4gc3RyYnVmX2dpdF9wYXRoX3N1Ym1vZHVs
ZQ0KPiA+IHByb3BhZ2F0ZSB0aGUgZXJyb3IgY29kZSB0byB0aGUgY2FsbGVyLg0KPiANCj4gU29t
ZWhvdyBJIGhhZCB0byByZWFkIHRoZSBsYXR0ZXIgaGFsZiBvZiB0aGlzIHBhcmFncmFwaCB0d2lj
ZSwNCj4gYmVmb3JlIEkgcmVhbGl6ZWQgdGhhdCB0aGUgbGFzdCB0d28gc2VudGVuY2UgdGFsa3Mg
YWJvdXQgaG93IHRoZXNlDQo+IHR3byBmdW5jdGlvbnMgZXhhY3RseSBkbyAidG8gcmV0dXJuIGFu
IGVycm9yIGNvZGUiLsKgwqBUZW50YXRpdmVseQ0KPiB3aGF0IEkgcXVldWVkIGhhczoNCj4gDQo+
IMKgwqDCoMKgLi4uIHNvIGluc3RlYWQsIG1vZGlmeSBkb19zdWJtb2R1bGVfcGF0aCgpIHRvIHJl
dHVybiBhbiBlcnJvcg0KPiBjb2RlOg0KPiANCj4gwqDCoMKgwqDCoC0gZ2l0X3BhdGhkdXBfc3Vi
bW9kdWxlKCkgcmV0dXJucyBOVUxMIHdoZW4gd2UgZmFpbCB0byBmaW5kIGENCj4gcGF0aC4NCj4g
wqDCoMKgwqDCoC0gc3RyYnVmX2dpdF9wYXRoX3N1Ym1vZHVsZSgpIHByb3BhZ2F0ZXMgdGhlIGVy
cm9yIGNvZGUgdG8gdGhlDQo+IMKgwqDCoMKgwqDCoMKgY2FsbGVyLg0KPiANCj4gaW5zdGVhZCwg
aG9waW5nIHRoYXQgd291bGQgYmUgZWFzaWVyIHRvIHVuZGVyc3RhbmQuDQo+IA0KDQpUaGF0J3Mg
bXVjaCBiZXR0ZXIgYW5kIG1vcmUgY2xlYXIuIFRoYW5rcyENCg0KPiA+IA0KPiA+IC1zdGF0aWMg
dm9pZCBkb19zdWJtb2R1bGVfcGF0aChzdHJ1Y3Qgc3RyYnVmICpidWYsIGNvbnN0IGNoYXINCj4g
PiAqcGF0aCwNCj4gPiAtCQkJwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqZm10LCB2YV9saXN0IGFy
Z3MpDQo+ID4gKy8qIFJldHVybnMgMCBvbiBzdWNjZXNzLCBub24temVybyBvbiBmYWlsdXJlLiAq
Lw0KPiANCj4gcy9ub24temVyby9uZWdhdGl2ZS87DQo+IA0KDQoNClRydWUuDQoNCj4gPiANCj4g
PiArI2RlZmluZSBTVUJNT0RVTEVfUEFUSF9FUlJfTk9UX0NPTkZJR1VSRUQgLTENCj4gPiArc3Rh
dGljIGludCBkb19zdWJtb2R1bGVfcGF0aChzdHJ1Y3Qgc3RyYnVmICpidWYsIGNvbnN0IGNoYXIg
KnBhdGgsDQo+ID4gKwkJCcKgwqDCoMKgwqBjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgYXJncykN
Cj4gPiDCoHsNCj4gDQo+IFRoaXMgNS84IGlzIHRoZSBvbmx5IGNoYW5nZWQgb25lIGluIHRoZSBl
bnRpcmUgc2VyaWVzIGZyb20gdGhlDQo+IHByZXZpb3VzIHJvdW5kLCBJIHRoaW5rLsKgwqBJJ2xs
IHJlcGxhY2Ugd2hhdCB3YXMgaW4gJ3B1JyBhbmQgd2FpdCBmb3INCj4gcmVzcG9uc2VzLg0KPiAN
Cj4gVGhhbmtzLg0KDQpZZXAsIHRoYXQncyBjb3JyZWN0Lg0KDQpSZWdhcmRzLA0KSmFrZQ==

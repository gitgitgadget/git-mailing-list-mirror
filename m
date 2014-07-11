From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 22:47:12 +0000
Message-ID: <1405118832.22963.60.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405114724-23829-1-git-send-email-jacob.e.keller@intel.com>
	 <xmqqwqbj1poi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jbF-0001qp-2K
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbaGKWrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:47:25 -0400
Received: from mga03.intel.com ([143.182.124.21]:54190 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbaGKWrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:47:24 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 11 Jul 2014 15:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,646,1400050800"; 
   d="scan'208";a="456083444"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by azsmga001.ch.intel.com with ESMTP; 11 Jul 2014 15:47:19 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX102.amr.corp.intel.com ([169.254.1.82]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 15:47:13 -0700
Thread-Topic: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Thread-Index: AQHPnVCINyCUQaeXj026uuV8JgV7wZubeLK2gAB2IQA=
In-Reply-To: <xmqqwqbj1poi.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <99A62883D3305E4F81C46E539C98B72D@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253343>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDE1OjQ0IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gRnJvbTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0Pg0KPiA+DQo+ID4gTWFrZSB0aGUgcGFy
c2luZyBvZiB0aGUgLS1zb3J0IHBhcmFtZXRlciBtb3JlIHJlYWRhYmxlIGJ5IGhhdmluZw0KPiA+
IHNraXBfcHJlZml4IGtlZXAgb3VyIHBvaW50ZXIgdXAgdG8gZGF0ZS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYnVp
bHRpbi90YWcuYyB8IDE0ICsrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2J1aWx0
aW4vdGFnLmMgYi9idWlsdGluL3RhZy5jDQo+ID4gaW5kZXggZWY3NjU1NjMzODhjLi43Y2NiNmYz
YzU4MWIgMTAwNjQ0DQo+ID4gLS0tIGEvYnVpbHRpbi90YWcuYw0KPiA+ICsrKyBiL2J1aWx0aW4v
dGFnLmMNCj4gPiBAQCAtNTI0LDE4ICs1MjQsMTIgQEAgc3RhdGljIGludCBwYXJzZV9vcHRfc29y
dChjb25zdCBzdHJ1Y3Qgb3B0aW9uICpvcHQsIGNvbnN0IGNoYXIgKmFyZywgaW50IHVuc2V0KQ0K
PiA+ICAJaW50ICpzb3J0ID0gb3B0LT52YWx1ZTsNCj4gPiAgCWludCBmbGFncyA9IDA7DQo+ID4g
IA0KPiA+IC0JaWYgKCphcmcgPT0gJy0nKSB7DQo+ID4gKwlpZiAoc2tpcF9wcmVmaXgoYXJnLCAi
LSIsICZhcmcpKQ0KPiA+ICAJCWZsYWdzIHw9IFJFVkVSU0VfU09SVDsNCj4gPiAtCQlhcmcrKzsN
Cj4gPiAtCX0NCj4gPiAtCWlmIChzdGFydHNfd2l0aChhcmcsICJ2ZXJzaW9uOiIpKSB7DQo+ID4g
Kw0KPiA+ICsJaWYgKHNraXBfcHJlZml4KGFyZywgInZlcnNpb246IiwgJmFyZykgfHwgc2tpcF9w
cmVmaXgoYXJnLCAidjoiLCAmYXJnKSkNCj4gPiAgCQkqc29ydCA9IFZFUkNNUF9TT1JUOw0KPiA+
IC0JCWFyZyArPSA4Ow0KPiA+IC0JfSBlbHNlIGlmIChzdGFydHNfd2l0aChhcmcsICJ2OiIpKSB7
DQo+ID4gLQkJKnNvcnQgPSBWRVJDTVBfU09SVDsNCj4gPiAtCQlhcmcgKz0gMjsNCj4gPiAtCX0g
ZWxzZQ0KPiA+IC0JCSpzb3J0ID0gU1RSQ01QX1NPUlQ7DQo+ID4gKw0KPiANCj4gQnkgbG9zaW5n
ICIqc29ydCA9IFNUUkNNUF9TT1JUIiwgdGhlIHZlcnNpb24gYWZ0ZXIgdGhpcyBwYXRjaCB3b3Vs
ZA0KPiBzdG9wIGNsZWFyaW5nIHdoYXQgaXMgcG9pbnRlZCBieSBvcHQtPnZhbHVlLCBzbw0KPiAN
Cj4gCWdpdCB0YWcgLS1zb3J0PXY6cmVmbmFtZSAtLXNvcnQ9cmVmbmFtZQ0KPiANCj4gd291bGQg
bm8gbG9uZ2VyIGltcGxlbWVudCB0aGUgImxhc3Qgb25lIHdpbnMiIHNlbWFudGljcywgbm8/DQo+
IA0KPiBBbSBJIG1pc3JlYWRpbmcgdGhlIHBhdGNoPyAgSSBzb21laG93IHRob3VnaHQgUGVmZidz
IG9yaWdpbmFsIHdhcw0KPiBjbGVhcmluZyB0aGUgdmFyaWFibGUuLi4NCj4gDQo+ID4gIAlpZiAo
c3RyY21wKGFyZywgInJlZm5hbWUiKSkNCj4gPiAgCQlkaWUoXygidW5zdXBwb3J0ZWQgc29ydCBz
cGVjaWZpY2F0aW9uICVzIiksIGFyZyk7DQo+ID4gIAkqc29ydCB8PSBmbGFnczsNCg0KSW5kZWVk
LiBNeSBwYXRjaCBmaXhlcyB0aGlzIHVwIGJ1dCBJIHdpbGwgcmUtd29yayB0aGlzIHNvIHdlIGRv
bid0DQppbnRyb2R1Y2UgYW4gaW5iZXR3ZWVuIGJ1ZyA6KQ0KDQpUaGFua3MsDQpKYWtlDQo=

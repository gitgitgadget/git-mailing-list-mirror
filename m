From: "Waskiewicz Jr, Peter P" <peter.p.waskiewicz.jr@intel.com>
Subject: Re: [StGit PATCH] Fix dirty index errors when resolving conflicts
Date: Wed, 17 Jul 2013 21:23:37 +0000
Message-ID: <1374096215.9814.3.camel@ppwaskie-mobl2.jf.intel.com>
References: <20130717135454.16504.69116.stgit@zbitter.fedora>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"catalin.marinas@gmail.com" <catalin.marinas@gmail.com>
To: Zane Bitter <zbitter@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 23:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZCN-0002IV-EM
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311Ab3GQVXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:23:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:36521 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754126Ab3GQVXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:23:42 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 17 Jul 2013 14:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,687,1367996400"; 
   d="scan'208";a="371942644"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2013 14:23:40 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Wed, 17 Jul 2013 14:23:39 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.2.244]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.142]) with mapi id 14.03.0123.003;
 Wed, 17 Jul 2013 14:23:38 -0700
Thread-Topic: [StGit PATCH] Fix dirty index errors when resolving conflicts
Thread-Index: AQHOgvWmNDxeC2GZAkWP6dJNRGJQg5lp1zeA
In-Reply-To: <20130717135454.16504.69116.stgit@zbitter.fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.152.228]
Content-ID: <12E26AE91783AA46B4B579D14323BB84@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230650>

T24gV2VkLCAyMDEzLTA3LTE3IGF0IDE1OjU3ICswMjAwLCBaYW5lIEJpdHRlciB3cm90ZToNCj4g
VGhlIHBhdGNoIDZlOGZkYzU4Yzc4NmE0NWQ3YTYzYzVlZGY5YzcwMmYxODc0YTdhMTkgY2F1c2Vz
IFN0R2l0IHRvIHJhaXNlDQo+ICJ3YXJuaW5ncyIgKGFjdHVhbGx5OiBlcnJvcnMpIGluIHRoZSBl
dmVudCB0aGF0IHRoZXJlIGFyZSBjaGFuZ2VzIHN0YWdlZCBpbg0KPiB0aGUgaW5kZXggYW5kIGEg
cmVmcmVzaCBpcyBwZXJmb3JtZWQgd2l0aG91dCBzcGVjaWZ5aW5nIGVpdGhlciAtLWluZGV4IG9y
DQo+IC0tZm9yY2UuIFRoaXMgaXMgZ3JlYXQgZm9yIHByZXZlbnRpbmcgYW4gZW50aXJlIGNsYXNz
IG9mIGNvbW1vbiBtaXN0YWtlcywNCj4gYnV0IGlzIGFsc28gYSBnaWFudCBwYWluIHdoZW4gcmVz
b2x2aW5nIGNvbmZsaWN0cyBhZnRlciBhIHB1bGwvcmViYXNlLg0KPiBEZXBlbmRpbmcgb24gdGhl
IHdvcmtmbG93IGluIHVzZSwgdGhpcyBtYXkgb2NjdXIgd2l0aCBhIGZyZXF1ZW5jeSBhbnl3aGVy
ZQ0KPiBiZXR3ZWVuICJuZXZlciIgYW5kICJtdWxpdHBsZSB0aW1lcyBvbiBldmVyeSBwdWxsIi4N
Cg0KSSBhY3R1YWxseSBoYWQgc29tZW9uZSBlbHNlIG1lbnRpb24gdGhpcyBwcm9ibGVtIHRvIG1l
IGxhc3Qgd2Vlay4gIFRoaXMNCmxvb2tzIGdvb2QsIEknbGwgYmUgYXBwbHlpbmcgdGhpcyBsYXRl
ciB0b2RheS4NCg0KQ2hlZXJzLA0KLVBKDQoNCj4gDQo+IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUg
cGFpbiBieToNCj4gIC0gUmVwb3J0aW5nIHVucmVzb2x2ZWQgY29uZmxpY3RzICpiZWZvcmUqIGNv
bXBsYWluaW5nIGFib3V0IHN0YWdlZA0KPiAgICBjaGFuZ2VzLCBzaW5jZSBpdCBnb2VzIHdpdGhv
dXQgc2F5aW5nIHRoYXQsIHdoZW4gcHJlc2VudCwgdGhlc2UgYXJlIHRoZQ0KPiAgICBtYWluIHBy
b2JsZW0uDQo+ICAtIE5vdCBjb21wbGFpbmluZyBhYm91dCBzdGFnZWQgY2hhbmdlcyBpZiB0aGVy
ZSBhcmUgbm8gdW5zdGFnZWQgY2hhbmdlcyBpbg0KPiAgICB0aGUgd29ya2luZyBkaXJlY3Rvcnks
IHNpbmNlIHRoZSBwcmVzZW5jZSBvZiAtLWluZGV4IGlzIGltbWF0ZXJpYWwgaW4NCj4gICAgdGhp
cyBjYXNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWmFuZSBCaXR0ZXIgPHpiaXR0ZXJAcmVkaGF0
LmNvbT4NCj4gLS0tDQo+ICBzdGdpdC9jb21tYW5kcy9yZWZyZXNoLnB5IHwgICAxMyArKysrKysr
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3N0Z2l0L2NvbW1hbmRzL3JlZnJlc2gucHkgYi9zdGdpdC9j
b21tYW5kcy9yZWZyZXNoLnB5DQo+IGluZGV4IGEyYmFiNDIuLjMzMWMxOGQgMTAwNjQ0DQo+IC0t
LSBhL3N0Z2l0L2NvbW1hbmRzL3JlZnJlc2gucHkNCj4gKysrIGIvc3RnaXQvY29tbWFuZHMvcmVm
cmVzaC5weQ0KPiBAQCAtMjQ3LDE4ICsyNDcsMTkgQEAgZGVmIGZ1bmMocGFyc2VyLCBvcHRpb25z
LCBhcmdzKToNCj4gICAgICBwYXRjaF9uYW1lID0gZ2V0X3BhdGNoKHN0YWNrLCBvcHRpb25zLnBh
dGNoKQ0KPiAgICAgIHBhdGhzID0gbGlzdF9maWxlcyhzdGFjaywgcGF0Y2hfbmFtZSwgYXJncywg
b3B0aW9ucy5pbmRleCwgb3B0aW9ucy51cGRhdGUpDQo+ICANCj4gLSAgICAjIE1ha2Ugc3VyZSB0
aGUgaW5kZXggaXMgY2xlYW4gYmVmb3JlIHBlcmZvcm1pbmcgYSBmdWxsIHJlZnJlc2gNCj4gLSAg
ICBpZiBub3Qgb3B0aW9ucy5pbmRleCBhbmQgbm90IG9wdGlvbnMuZm9yY2U6DQo+IC0gICAgICAg
IGlmIG5vdCBzdGFjay5yZXBvc2l0b3J5LmRlZmF1bHRfaW5kZXguaXNfY2xlYW4oc3RhY2suaGVh
ZCk6DQo+IC0gICAgICAgICAgICByYWlzZSBjb21tb24uQ21kRXhjZXB0aW9uKA0KPiAtICAgICAg
ICAgICAgICAgICdUaGUgaW5kZXggaXMgZGlydHkuIERpZCB5b3UgbWVhbiAtLWluZGV4PyBUbyBm
b3JjZSBhIGZ1bGwgcmVmcmVzaCB1c2UgLS1mb3JjZS4nKQ0KPiAtDQo+ICAgICAgIyBNYWtlIHN1
cmUgdGhlcmUgYXJlIG5vIGNvbmZsaWN0cyBpbiB0aGUgZmlsZXMgd2Ugd2FudCB0bw0KPiAgICAg
ICMgcmVmcmVzaC4NCj4gICAgICBpZiBzdGFjay5yZXBvc2l0b3J5LmRlZmF1bHRfaW5kZXguY29u
ZmxpY3RzKCkgJiBwYXRoczoNCj4gICAgICAgICAgcmFpc2UgY29tbW9uLkNtZEV4Y2VwdGlvbigN
Cj4gICAgICAgICAgICAgICdDYW5ub3QgcmVmcmVzaCAtLSByZXNvbHZlIGNvbmZsaWN0cyBmaXJz
dCcpDQo+ICANCj4gKyAgICAjIE1ha2Ugc3VyZSB0aGUgaW5kZXggaXMgY2xlYW4gYmVmb3JlIHBl
cmZvcm1pbmcgYSBmdWxsIHJlZnJlc2gNCj4gKyAgICBpZiBub3Qgb3B0aW9ucy5pbmRleCBhbmQg
bm90IG9wdGlvbnMuZm9yY2U6DQo+ICsgICAgICAgIGlmIG5vdCAoc3RhY2sucmVwb3NpdG9yeS5k
ZWZhdWx0X2luZGV4LmlzX2NsZWFuKHN0YWNrLmhlYWQpIG9yDQo+ICsgICAgICAgICAgICAgICAg
c3RhY2sucmVwb3NpdG9yeS5kZWZhdWx0X2l3Lndvcmt0cmVlX2NsZWFuKCkpOg0KPiArICAgICAg
ICAgICAgcmFpc2UgY29tbW9uLkNtZEV4Y2VwdGlvbigNCj4gKyAgICAgICAgICAgICAgICAnVGhl
IGluZGV4IGlzIGRpcnR5LiBEaWQgeW91IG1lYW4gLS1pbmRleD8gVG8gZm9yY2UgYSBmdWxsIHJl
ZnJlc2ggdXNlIC0tZm9yY2UuJykNCj4gKw0KPiAgICAgICMgQ29tbWl0IGluZGV4IHRvIHRlbXAg
cGF0Y2gsIGFuZCBhYnNvcmIgaXQgaW50byB0aGUgdGFyZ2V0IHBhdGNoLg0KPiAgICAgIHJldHZh
bCwgdGVtcF9uYW1lID0gbWFrZV90ZW1wX3BhdGNoKA0KPiAgICAgICAgICBzdGFjaywgcGF0Y2hf
bmFtZSwgcGF0aHMsIHRlbXBfaW5kZXggPSBwYXRoX2xpbWl0aW5nKQ0KPiANCg0K

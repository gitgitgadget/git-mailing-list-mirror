From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [StGit PATCH] Fix dirty index errors when resolving conflicts
Date: Wed, 17 Jul 2013 20:59:31 +0000
Message-ID: <02874ECE860811409154E81DA85FBB585658699B@ORSMSX104.amr.corp.intel.com>
References: <20130717135454.16504.69116.stgit@zbitter.fedora>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "Waskiewicz Jr, Peter P" <peter.p.waskiewicz.jr@intel.com>,
	"catalin.marinas@gmail.com" <catalin.marinas@gmail.com>
To: Zane Bitter <zbitter@redhat.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 17 22:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzYp6-00050A-00
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 22:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149Ab3GQU7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 16:59:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:57018 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab3GQU7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 16:59:39 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 17 Jul 2013 13:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,687,1367996400"; 
   d="scan'208";a="347313834"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2013 13:59:31 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.3.105]) by
 ORSMSX108.amr.corp.intel.com ([169.254.4.149]) with mapi id 14.03.0123.003;
 Wed, 17 Jul 2013 13:59:31 -0700
Thread-Topic: [StGit PATCH] Fix dirty index errors when resolving conflicts
Thread-Index: AQHOgvWm1VNUIcZE5U62n7THiwe5aZlpWuig
In-Reply-To: <20130717135454.16504.69116.stgit@zbitter.fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230649>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaYW5lIEJpdHRlciBbbWFpbHRv
OnpiaXR0ZXJAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE3LCAyMDEzIDY6
NTcgQU0NCj4gVG86IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEtlbGxlciwgSmFjb2IgRTsg
V2Fza2lld2ljeiBKciwgUGV0ZXIgUDsgY2F0YWxpbi5tYXJpbmFzQGdtYWlsLmNvbQ0KPiBTdWJq
ZWN0OiBbU3RHaXQgUEFUQ0hdIEZpeCBkaXJ0eSBpbmRleCBlcnJvcnMgd2hlbiByZXNvbHZpbmcg
Y29uZmxpY3RzDQo+IA0KPiBUaGUgcGF0Y2ggNmU4ZmRjNThjNzg2YTQ1ZDdhNjNjNWVkZjljNzAy
ZjE4NzRhN2ExOSBjYXVzZXMgU3RHaXQNCj4gdG8gcmFpc2UNCj4gIndhcm5pbmdzIiAoYWN0dWFs
bHk6IGVycm9ycykgaW4gdGhlIGV2ZW50IHRoYXQgdGhlcmUgYXJlIGNoYW5nZXMgc3RhZ2VkIGlu
DQo+IHRoZSBpbmRleCBhbmQgYSByZWZyZXNoIGlzIHBlcmZvcm1lZCB3aXRob3V0IHNwZWNpZnlp
bmcgZWl0aGVyIC0taW5kZXggb3INCj4gLS1mb3JjZS4gVGhpcyBpcyBncmVhdCBmb3IgcHJldmVu
dGluZyBhbiBlbnRpcmUgY2xhc3Mgb2YgY29tbW9uIG1pc3Rha2VzLA0KPiBidXQgaXMgYWxzbyBh
IGdpYW50IHBhaW4gd2hlbiByZXNvbHZpbmcgY29uZmxpY3RzIGFmdGVyIGEgcHVsbC9yZWJhc2Uu
DQo+IERlcGVuZGluZyBvbiB0aGUgd29ya2Zsb3cgaW4gdXNlLCB0aGlzIG1heSBvY2N1ciB3aXRo
IGEgZnJlcXVlbmN5DQo+IGFueXdoZXJlDQo+IGJldHdlZW4gIm5ldmVyIiBhbmQgIm11bGl0cGxl
IHRpbWVzIG9uIGV2ZXJ5IHB1bGwiLg0KPiANCj4gVGhpcyBwYXRjaCByZW1vdmVzIHRoZSBwYWlu
IGJ5Og0KPiAgLSBSZXBvcnRpbmcgdW5yZXNvbHZlZCBjb25mbGljdHMgKmJlZm9yZSogY29tcGxh
aW5pbmcgYWJvdXQgc3RhZ2VkDQo+ICAgIGNoYW5nZXMsIHNpbmNlIGl0IGdvZXMgd2l0aG91dCBz
YXlpbmcgdGhhdCwgd2hlbiBwcmVzZW50LCB0aGVzZSBhcmUgdGhlDQo+ICAgIG1haW4gcHJvYmxl
bS4NCj4gIC0gTm90IGNvbXBsYWluaW5nIGFib3V0IHN0YWdlZCBjaGFuZ2VzIGlmIHRoZXJlIGFy
ZSBubyB1bnN0YWdlZCBjaGFuZ2VzDQo+IGluDQo+ICAgIHRoZSB3b3JraW5nIGRpcmVjdG9yeSwg
c2luY2UgdGhlIHByZXNlbmNlIG9mIC0taW5kZXggaXMgaW1tYXRlcmlhbCBpbg0KPiAgICB0aGlz
IGNhc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaYW5lIEJpdHRlciA8emJpdHRlckByZWRoYXQu
Y29tPg0KPiAtLS0NCj4gIHN0Z2l0L2NvbW1hbmRzL3JlZnJlc2gucHkgfCAgIDEzICsrKysrKyst
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvc3RnaXQvY29tbWFuZHMvcmVmcmVzaC5weSBiL3N0Z2l0L2Nv
bW1hbmRzL3JlZnJlc2gucHkNCj4gaW5kZXggYTJiYWI0Mi4uMzMxYzE4ZCAxMDA2NDQNCj4gLS0t
IGEvc3RnaXQvY29tbWFuZHMvcmVmcmVzaC5weQ0KPiArKysgYi9zdGdpdC9jb21tYW5kcy9yZWZy
ZXNoLnB5DQo+IEBAIC0yNDcsMTggKzI0NywxOSBAQCBkZWYgZnVuYyhwYXJzZXIsIG9wdGlvbnMs
IGFyZ3MpOg0KPiAgICAgIHBhdGNoX25hbWUgPSBnZXRfcGF0Y2goc3RhY2ssIG9wdGlvbnMucGF0
Y2gpDQo+ICAgICAgcGF0aHMgPSBsaXN0X2ZpbGVzKHN0YWNrLCBwYXRjaF9uYW1lLCBhcmdzLCBv
cHRpb25zLmluZGV4LA0KPiBvcHRpb25zLnVwZGF0ZSkNCj4gDQo+IC0gICAgIyBNYWtlIHN1cmUg
dGhlIGluZGV4IGlzIGNsZWFuIGJlZm9yZSBwZXJmb3JtaW5nIGEgZnVsbCByZWZyZXNoDQo+IC0g
ICAgaWYgbm90IG9wdGlvbnMuaW5kZXggYW5kIG5vdCBvcHRpb25zLmZvcmNlOg0KPiAtICAgICAg
ICBpZiBub3Qgc3RhY2sucmVwb3NpdG9yeS5kZWZhdWx0X2luZGV4LmlzX2NsZWFuKHN0YWNrLmhl
YWQpOg0KPiAtICAgICAgICAgICAgcmFpc2UgY29tbW9uLkNtZEV4Y2VwdGlvbigNCj4gLSAgICAg
ICAgICAgICAgICAnVGhlIGluZGV4IGlzIGRpcnR5LiBEaWQgeW91IG1lYW4gLS1pbmRleD8gVG8g
Zm9yY2UgYSBmdWxsIHJlZnJlc2gNCj4gdXNlIC0tZm9yY2UuJykNCj4gLQ0KPiAgICAgICMgTWFr
ZSBzdXJlIHRoZXJlIGFyZSBubyBjb25mbGljdHMgaW4gdGhlIGZpbGVzIHdlIHdhbnQgdG8NCj4g
ICAgICAjIHJlZnJlc2guDQo+ICAgICAgaWYgc3RhY2sucmVwb3NpdG9yeS5kZWZhdWx0X2luZGV4
LmNvbmZsaWN0cygpICYgcGF0aHM6DQo+ICAgICAgICAgIHJhaXNlIGNvbW1vbi5DbWRFeGNlcHRp
b24oDQo+ICAgICAgICAgICAgICAnQ2Fubm90IHJlZnJlc2ggLS0gcmVzb2x2ZSBjb25mbGljdHMg
Zmlyc3QnKQ0KPiANCj4gKyAgICAjIE1ha2Ugc3VyZSB0aGUgaW5kZXggaXMgY2xlYW4gYmVmb3Jl
IHBlcmZvcm1pbmcgYSBmdWxsIHJlZnJlc2gNCj4gKyAgICBpZiBub3Qgb3B0aW9ucy5pbmRleCBh
bmQgbm90IG9wdGlvbnMuZm9yY2U6DQo+ICsgICAgICAgIGlmIG5vdCAoc3RhY2sucmVwb3NpdG9y
eS5kZWZhdWx0X2luZGV4LmlzX2NsZWFuKHN0YWNrLmhlYWQpIG9yDQo+ICsgICAgICAgICAgICAg
ICAgc3RhY2sucmVwb3NpdG9yeS5kZWZhdWx0X2l3Lndvcmt0cmVlX2NsZWFuKCkpOg0KPiArICAg
ICAgICAgICAgcmFpc2UgY29tbW9uLkNtZEV4Y2VwdGlvbigNCj4gKyAgICAgICAgICAgICAgICAn
VGhlIGluZGV4IGlzIGRpcnR5LiBEaWQgeW91IG1lYW4gLS1pbmRleD8gVG8gZm9yY2UgYSBmdWxs
IHJlZnJlc2gNCj4gdXNlIC0tZm9yY2UuJykNCj4gKw0KPiAgICAgICMgQ29tbWl0IGluZGV4IHRv
IHRlbXAgcGF0Y2gsIGFuZCBhYnNvcmIgaXQgaW50byB0aGUgdGFyZ2V0IHBhdGNoLg0KPiAgICAg
IHJldHZhbCwgdGVtcF9uYW1lID0gbWFrZV90ZW1wX3BhdGNoKA0KPiAgICAgICAgICBzdGFjaywg
cGF0Y2hfbmFtZSwgcGF0aHMsIHRlbXBfaW5kZXggPSBwYXRoX2xpbWl0aW5nKQ0KDQpBQ0suIFRo
aXMgbG9va3MgZ3JlYXQuIFRoYW5rcyBmb3Igbm90aWNpbmchDQoNCi0gSmFrZQ0KDQo=

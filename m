From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 9/9] Use timer_settime for new platforms
Date: Fri, 29 Aug 2014 18:09:54 +0000
Message-ID: <1409335794.18778.23.camel@jekeller-desk1.amr.corp.intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
	 <1409330561-11806-9-git-send-email-jacob.e.keller@intel.com>
	 <xmqqd2bj6uol.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sortie@maxsi.org" <sortie@maxsi.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNQct-0000PF-4t
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbaH2SKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:10:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:20986 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbaH2SKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:10:07 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 29 Aug 2014 11:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,425,1406617200"; 
   d="scan'208";a="565499091"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2014 11:09:55 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Fri, 29 Aug 2014 11:09:55 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.110]) with mapi id 14.03.0195.001;
 Fri, 29 Aug 2014 11:09:55 -0700
Thread-Topic: [PATCH 9/9] Use timer_settime for new platforms
Thread-Index: AQHPw7NfPIdGHCgt906U9sUxkuXoMJvoVs8A
In-Reply-To: <xmqqd2bj6uol.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <CEDBCA17CED0904B8523C1A0697D8B66@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256171>

T24gRnJpLCAyMDE0LTA4LTI5IGF0IDExOjAyIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gRnJvbTogSm9uYXMgJ1NvcnRpZScgVGVybWFuc2VuIDxzb3J0aWVAbWF4c2kub3JnPg0KPiA+
DQo+ID4gc2V0aXRpbWVyKCkgaXMgYW4gb2Jzb2xlc2NlbnQgWFNJIGludGVyZmFjZSBhbmQgbWF5
IGJlIHJlbW92ZWQgaW4gYQ0KPiA+IGZ1dHVyZSBzdGFuZGFyZC4gQXBwbGljYXRpb25zIHNob3Vs
ZCB1c2UgdGhlIGNvcmUgUE9TSVggdGltZXJfc2V0dGltZSgpDQo+ID4gaW5zdGVhZC4NCj4gPg0K
PiA+IEl0J3MgaW1wb3J0YW50IHRoYXQgY29kZSBkb2Vzbid0IHNpbXBseSBjaGVjayBpZiB0aW1l
cl9zZXR0aW1lIGlzDQo+ID4gYXZhaWxhYmxlIGFzIGl0IGNhbiBnaXZlIGZhbHNlIHBvc2l0aXZl
cy4gU29tZSBzeXN0ZW1zIGxpa2UgY29udGVtcG9yYXJ5DQo+ID4gT3BlbkJTRCBwcm92aWRlcyB0
aGUgZnVuY3Rpb24sIGJ1dCBpdCB1bmNvbmRpdGlvbmFsbHkgZmFpbHMgd2l0aCBFTk9TWVMNCj4g
PiBhdCBydW50aW1lLg0KPiANCj4gRG9lc24ndCB0aGlzIHBhcmFncmFwaCBuZWVkIHR3ZWFraW5n
PyAgSSB0aGluayB5b3UgbG9zdCAod2hpY2ggaXMgYQ0KPiBnb29kIHRoaW5nKSAibm90aWNlIHRo
YXQgdGltZXJfc2V0dGltZSgpIGNhbGwgZmFpbGVkIHdpdGggRU5PU1lTIGFuZA0KPiBzd2l0Y2gg
dG8gc2V0aXRpbWVyKCkiLCBubz8NCj4gDQo+ID4gQ2xlYW4gdXAgdGhlIHByb2dyZXNzIHJlcG9y
dGluZyBhbmQgY2hhbmdlIGl0IHRvIHVzZSB0aW1lcl9zZXR0aW1lLA0KPiA+IHdoaWNoIHdpbGwg
ZmFsbCBiYWNrIHRvIHNldGl0aW1lciBhdXRvbWF0aWNhbGx5IGlmIHRpbWVyX3NldHRpbWUgaXMg
bm90DQo+ID4gc3VwcG9ydGVkLiAoc2VlIGdpdC1jb21wYXQtdXRpbC5oIGZvciBob3cgaXQgZG9l
cyB0aGlzKS4gSWYgYm90aA0KPiA+IGZ1bmN0aW9ucyBhcmUgbm90IHByZXNlbnQsIHRoZW4gZ2l0
LWNvbXBhdC11dGlsLmggcHJvdmlkZXMgcmVwbGFjZW1lbnRzDQo+ID4gd2hpY2ggd2lsbCBhbHdh
eXMgZmFpbCB3aXRoIEVOT1NZUy4NCj4gDQo+IFdoaWxlIHRoaXMgcGFyYWdyYXBoIG1heSBiZSB0
cnVlIGlmIHBhdGNoIDhiIGFuZCA5IGFyZSB0YWtlbg0KPiB0b2dldGhlciwgaXNuJ3Qgd2hhdCBp
dCBkZXNjcmliZXMgbW9zdGx5IHdoYXQgOGIgZGlkLCBub3QgOT8NCj4gDQo+IEhlcmUgYnkgOGIg
SSBtZWFuIHRoZSBjaGFuZ2UgdG8gZ2l0LWNvbXBhdC11dGlsLmggaW4gODsgdGhlIHBhdGNoDQo+
IG1pZ2h0IHdhbnQgdG8gYmUgc3BsaXQgaW50byB0d28sIDhhIGZvciB0aGUgYXV0b2NvbmYgcGFy
dCB3aG9zZSBsb2cNCj4gbWVzc2FnZSBtYXkgYmVnaW4gd2l0aCAiVGhpcyBmdW5jdGlvbiB3YXMg
bm90IHByZXZpb3VzbHkgdXNlZCBieQ0KPiBnaXQuIiBhbmQgOGIgdGhhdCBhZGRzIGFuIGVtdWxh
dGlvbiBvZiB0aW1lcl9zZXR0aW1lKCkgQVBJIGluIHRlcm1zDQo+IG9mIHNldGl0aW1lcigpIEFQ
SSwgb3IgdGhlIG90aGVyIHdheSBhcm91bmQuDQo+IA0KPiBXaGF0IDkgZGlkIGlzIG9ubHkgIndl
IHVzZWQgdG8gdXNlIHRoZSBzZXRpdG1lcigpIEFQSSB0byBpbXBsZW1lbnQNCj4gdGhlIHByb2dy
ZXNzIHJlcG9ydGluZzsgbm93IHdlIHVzZSB0aW1lcl9zZXR0aW1lKCkgQVBJIiAoeWVzLCBpdCBp
cw0KPiB0aGFua3MgdG8gdGhlIGFic3RyYWN0aW9uIGdpdmVuIGJ5IDgsIGJ1dCB0aGUgImNhbGxl
cnMgaGFzIHRvIG9ubHkNCj4ga25vdyBhYm91dCBvbmUgQVBJLCBub3Qgd29ycnlpbmcgYWJvdXQg
dGhlIG90aGVyIEFQSSIgaXMgYSBtZXJpdA0KPiBhdHRyaWJ1dGFibGUgdG8gOGIsIG5vdCB0aGlz
IG9uZSkuDQo+IA0KDQpZb3UgYXJlIGNvcnJlY3QuIEkgY2FuIHJlLWJhc2UgdGhlc2UgcGF0Y2hl
cyBhbmQgc3BsaXQgdGhlbSBhcGFydCBhIGJpdA0KYmV0dGVyLg0KDQpSZWdhcmRzLA0KSmFrZQ0K
DQo+ID4gVGhlIGFwcHJvYWNoIHVzZWQgaGVyZSBlbmFibGVzIHVzIHRvIHVzZSBhIHNpbmdsZSBB
UEkgKHRpbWVyX3NldHRpbWUpDQo+ID4gd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgY2hl
Y2tpbmcgZm9yICNpZmRlZnMgb3IgaWYgYmxvY2tzIHdoaWNoDQo+ID4gbWFrZSBpdCBhbiB1bnJl
YWRhYmxlIG5pZ2h0bWFyZS4gVGhlIG1ham9yIGRvd25zaWRlIGlzIGZvciBzeXN0ZW1zDQo+ID4g
d2l0aG91dCB0aW1lcl9zZXR0aW1lIHN1cHBvcnQsIHRoZXkgbWF5IGZhbGwgYmFjayBvbiBhIHdy
YXBwZWQNCj4gPiBpbXBsZW1lbnRhdGlvbiB3aGljaCBjb3VsZCBoYXZlIHN1YnRsZSBkaWZmZXJl
bmNlcy4gVGhpcyBzaG91bGQgYmUgYQ0KPiA+IG1pbm9yIGlzc3VlIGFzIGFsbW9zdCBhbGwgbW9k
ZXJuIHN5c3RlbXMgcHJvdmlkZSB0aW1lcl9zZXR0aW1lIHN1cHBvcnQuDQo+IA0KPiBBcyB0aGlz
IHBhcmFncmFwaC4NCj4gDQo+ID4gTm90ZSB0aGF0IHRoaXMgY2hhbmdlIG1lYW5zIHRoYXQgZ2l0
IHNob3VsZCBuZXZlciB1c2Ugc2V0aXRpbWVyIG9uIGl0cw0KPiA+IG93biBub3csIGFzIHRoZSBm
YWxsYmFjayBpbXBsZW1lbnRhdGlvbiBvZiB0aW1lcl9zZXR0aW1lIGFzc3VtZXMgdGhhdCBpdA0K
PiA+IGlzIHRoZSBzb2xlIHVzZXIgb2YgSVRJTUVSX1JFQUwsIGFuZCB0aW1lcl9kZWxldGUgd2ls
bCByZXNldCB0aGUNCj4gPiBJVElNRVJfUkVBTC4NCj4gDQo+IEFuZCB0aGlzIG9uZS4NCj4gDQoN
Cg0K

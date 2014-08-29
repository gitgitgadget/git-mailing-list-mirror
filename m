From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 9/9] Use timer_settime for new platforms
Date: Fri, 29 Aug 2014 16:11:51 +0000
Message-ID: <1409328711.18778.12.camel@jekeller-desk1.amr.corp.intel.com>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
	 <1409187862-21257-10-git-send-email-sortie@maxsi.org>
	 <xmqq61hc9z94.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sortie@maxsi.org" <sortie@maxsi.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:12:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNOmp-0005p4-5G
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbaH2QMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:12:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:55234 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818AbaH2QMV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:12:21 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Aug 2014 09:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="378745560"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2014 09:07:33 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Fri, 29 Aug 2014 09:11:52 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX112.amr.corp.intel.com ([169.254.12.46]) with mapi id 14.03.0195.001;
 Fri, 29 Aug 2014 09:11:52 -0700
Thread-Topic: [PATCH 9/9] Use timer_settime for new platforms
Thread-Index: AQHPwvhHb3L7rNgxwEOgAx1Q6pyyLJvoN0qA
In-Reply-To: <xmqq61hc9z94.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <7FB0DC65BA46AF4996A3E74932EF81B5@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256152>

T24gVGh1LCAyMDE0LTA4LTI4IGF0IDEyOjQzIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSm9uYXMgJ1NvcnRpZScgVGVybWFuc2VuIDxzb3J0aWVAbWF4c2kub3JnPiB3cml0ZXM6DQo+
IA0KPiA+IHNldGl0aW1lcigpIGlzIGFuIG9ic29sZXNjZW50IFhTSSBpbnRlcmZhY2UgYW5kIG1h
eSBiZSByZW1vdmVkIGluIGENCj4gPiBmdXR1cmUgc3RhbmRhcmQuIEFwcGxpY2F0aW9ucyBzaG91
bGQgdXNlIHRoZSBjb3JlIFBPU0lYIHRpbWVyX3NldHRpbWUoKQ0KPiA+IGluc3RlYWQuDQo+ID4N
Cj4gPiBUaGlzIHBhdGNoIGNsZWFucyB1cCB0aGUgcHJvZ3Jlc3MgcmVwb3J0aW5nIGFuZCBjaGFu
Z2VzIGl0IHRvIHRyeSB1c2luZw0KPiA+IHRpbWVyX3NldHRpbWUsIG9yIGlmIHRoYXQgZmFpbHMs
IHNldGl0aW1lci4gSWYgZWl0aGVyIGZ1bmN0aW9uIGlzIG5vdA0KPiA+IHByb3ZpZGVkIGJ5IHRo
ZSBzeXN0ZW0sIHRoZW4gZ2l0LWNvbXBhdC11dGlsLmggcHJvdmlkZXMgcmVwbGFjZW1lbnRzDQo+
ID4gdGhhdCBhbHdheXMgZmFpbCB3aXRoIEVOT1NZUy4NCj4gPg0KPiA+IEl0J3MgaW1wb3J0YW50
IHRoYXQgY29kZSBkb2Vzbid0IHNpbXBseSBjaGVjayBpZiB0aW1lcl9zZXR0aW1lIGlzDQo+ID4g
YXZhaWxhYmxlIGFzIGl0IGNhbiBnaXZlIGZhbHNlIHBvc2l0aXZlcy4gU29tZSBzeXN0ZW1zIGxp
a2UgY29udGVtcG9yYXJ5DQo+ID4gT3BlbkJTRCBwcm92aWRlcyB0aGUgZnVuY3Rpb24sIGJ1dCBp
dCB1bmNvbmRpdGlvbmFsbHkgZmFpbHMgd2l0aCBFTk9TWVMNCj4gPiBhdCBydW50aW1lLg0KPiA+
DQo+ID4gVGhpcyBhcHByb2FjaCBhbGxvd3MgdGhlIGNvZGUgdXNpbmcgdGltZXJfc2V0dGltZSgp
IGFuZCBzZXRpdGltZXIoKSB0bw0KPiA+IGJlIHNpbXBsZSBhbmQgcmVhZGFibGUuIE15IGZpcnN0
IGF0dGVtcHQgdXNlZCAjaWZkZWYgYXJvdW5kIGVhY2ggdXNlIG9mDQo+ID4gdGltZXJfc2V0dGlt
ZSgpLCB0aGlzIHF1aWNrbHkgdHVybmVkIGEgaW50byB1bm1haW50YWluYWJsZSBtYXplIG9mDQo+
ID4gcHJlcHJvY2Vzc29yIGNvbmRpdGlvbmFscy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpv
bmFzICdTb3J0aWUnIFRlcm1hbnNlbiA8c29ydGllQG1heHNpLm9yZz4NCj4gPiAtLS0NCj4gPiAg
YnVpbHRpbi9sb2cuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tDQo+ID4gIHByb2dyZXNzLmMgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMTQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBZdWNrLiAgSSBkaWRuJ3QgbG9vayBhdCB0aGUgY2hhbmdlIHZl
cnkgY2FyZWZ1bGx5LCBidXQgYXJlIHRoZSB0d28NCj4gaW50ZXJmYWNlIHNvIHZhc3RseSBkaWZm
ZXJlbnQgdGhhdCB5b3UgY2Fubm90IGVtdWxhdGUgb25lIGluIHRlcm1zDQo+IG9mIHRoZSBvdGhl
ciwgYW5kIHVzZSBhIHNpbmdsZSBBUEkgYXQgdGhlIGNhbGxzaXRlcywgaXNvbGF0aW5nIHRoZQ0K
PiBrbm93bGVkZ2Ugb2Ygd2hpY2gga2luZCBvZiBBUEkgaXMgdXNlZCB0byBpbnRlcmFjdCB3aXRo
IHRoZSBzeXN0ZW0NCj4gdGltZXIgaW4gb25lIHBsYWNlIChwZXJoYXBzIGluIGNvbXBhdC9pdGlt
ZXIuYyk/DQo+IA0KPiBIYXZpbmcgdG8gc3ByaW5rbGUgImlmIChpc191c2luZ190aW1lcl9zZXR0
aW1lKSIgYXJvdW5kIG1lYW5zIHdlDQo+IG5lZWQgdG8gc3VwcG9ydCB0d28gQVBJcyBhdCBlYWNo
IGFuZCBldmVyeSBjYWxsc2l0ZSB0aGF0IHdhbnRzIHRpbWVyDQo+IGludGVycnVwdCBhY3Rpb25z
Lg0KPiANCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxp
bmUgInVuc3Vic2NyaWJlIGdpdCIgaW4NCj4gdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9y
ZG9tb0B2Z2VyLmtlcm5lbC5vcmcNCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3Zn
ZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQoNCkFncmVlZCEgVGhlIGJpZ2dlc3Qg
ZGlmZmVyZW5jZSBpcyB0aGF0IHRpbWVyX3NldHRpbWUoKSB1c2VzIG5hbm9zZWNvbmRzDQp2YWx1
ZSwgd2hpY2ggaXMgdmVyeSBlYXN5IHRvIGNvbnZlcnQgbWljcm9zZWNvbmRzIGludG8gbmFub3Nl
Y29uZHMuDQoNCkluIGZhY3QsIHlvdSBjb3VsZCBwcm9iYWJseSBlYXNpbHkgcHJvdmlkZSBhIHdy
YXBwZXIgZm9yIHRpbWVyX3NldHRpbWUNCnRoYXQgd29ya3MgZm9yIHNldHRpbWVyIGJ5IHNpbXBs
eSBjb252ZXJ0aW5nIGl0LiBUaGlzIGlzIGEgbXVjaCBiZXR0ZXINCmFwcHJvYWNoLiAodGhvdWdo
IHNldHRpbWVyICJjb3VsZCIgbG9zZSBzb21lIHByZWNpc2lvbiBzaW5jZSB5b3UgYWh2ZSB0bw0K
ZGl2aWRlIGJ5IDEwMDApLi4uDQoNClRoZSBvdGhlciBiaWcgZGlmZmVyZW5jZSBpcyBhYnN0cmFj
dGluZyBhd2F5IHRoZSB0aW1lcl9jcmVhdGUgYXNwZWN0DQp3aGljaCBpcyBvaywgc2luY2Ugd2Ug
d291bGQgYWx3YXlzIGNhbGwgdGltZXIgY3JlYXRlLCBhbmQgdXNlIHRoZQ0KY29ycmVjdCB0aW1l
ciwgYnV0IHdlIGp1c3QgZmFsbCBiYWNrIHRvIHNldGl0aW1lciB0byB1c2UgdGhlIGRlZmF1bHQN
CnRpbWVyLg0KDQpJJ2xsIHN1Ym1pdCBhIHBhdGNoIHNlcmllcyB3aGljaCBkb2VzIHdoYXQgSSB0
aGluayBzaG91bGQgd29yaywgYW5kIHdpbGwNCnJlc3VsdCBpbiBsZXNzIGlmIGNoZWNrcy4NCg0K
UmVnYXJkcywNCkpha2UNCg0KDQo=

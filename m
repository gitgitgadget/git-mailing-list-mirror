From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 10 Mar 2015 18:05:46 +0000
Message-ID: <E53D99DB-E894-4FA8-9351-39E23FFD677E@cisco.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
 <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
 <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
 <3E5DD2BE-1E44-4D0A-89A1-627A1239C72A@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 19:06:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVOXS-0003Sf-7T
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 19:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbCJSFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 14:05:50 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:35628 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbCJSFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 14:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2830; q=dns/txt; s=iport;
  t=1426010749; x=1427220349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gcS0WnHS+tuvScyp7jBhJr7rLvjsBPu5/SDBGjRXkj0=;
  b=Fgg1Bh+CY5/7Ju5W63q0vsTXnepUusAa4S5fR/q2itQRaz35XPZSuwOM
   KblOWoMotCS9G35IP8UlHL+aijBBwUPL21qCvvBGnqdwNK+cwcMz83QhS
   EjooGo1iNgjFOCwAhzsMOTzOeMIwjtlDM5AjL9czx0g/G0B/7f5MT3O5K
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0APCwCtMf9U/4wNJK1cgwZSWgSDBrojhX6FcAIcgRlNAQEBAQEBfIQPAQEBAwEjEUUFCwIBCBgCAhQSAgICMBUQAgQOBYgnCA2obZtuAQEBAQEBAQEBAQEBAQEBAQEBAQEBEwSBIYl2hClFBxiCUC+BFgWQD4NkhW8Bk3Mjg25vgUR/AQEB
X-IronPort-AV: E=Sophos;i="5.11,376,1422921600"; 
   d="scan'208";a="130687995"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-5.cisco.com with ESMTP; 10 Mar 2015 18:05:48 +0000
Received: from xhc-rcd-x04.cisco.com (xhc-rcd-x04.cisco.com [173.37.183.78])
	by alln-core-7.cisco.com (8.14.5/8.14.5) with ESMTP id t2AI5mS3012489
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 10 Mar 2015 18:05:48 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.151]) by
 xhc-rcd-x04.cisco.com ([173.37.183.78]) with mapi id 14.03.0195.001; Tue, 10
 Mar 2015 13:05:47 -0500
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQSwqcFAV48lOUvEGHDNPe7JHDHZz2+1uAgAHaeICAB+NbAIABkSyAgBQtCoA=
In-Reply-To: <3E5DD2BE-1E44-4D0A-89A1-627A1239C72A@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.100.213.51]
Content-ID: <7DBA389B8763F84495C17EFA260F90CA@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265252>

PiBPbiBGZWIgMjUsIDIwMTUsIGF0IDM6NTkgUE0sIERhbiBMYW5naWxsZSAoZGFsYW5naWwpIDxk
YWxhbmdpbEBjaXNjby5jb20+IHdyb3RlOg0KPiANCj4+IE9uIEZlYiAyNCwgMjAxNSwgYXQgNDow
MyBQTSwgRGFuIExhbmdpbGxlIChkYWxhbmdpbCkgPGRhbGFuZ2lsQGNpc2NvLmNvbT4gd3JvdGU6
DQo+PiANCj4+PiBPbiBGZWIgMTksIDIwMTUsIGF0IDM6MzUgUE0sIGJyaWFuIG0uIGNhcmxzb24g
PHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFdlZCwg
RmViIDE4LCAyMDE1IGF0IDA0OjE3OjQ2UE0gKzAwMDAsIERhbiBMYW5naWxsZSAoZGFsYW5naWwp
IHdyb3RlOg0KPj4+PiBJIGp1c3QgYnVpbHQgZnJvbSDigJhtYXN0ZXLigJksIG9uIEZyZWVCU0Qg
OS4zOg0KPj4+PiANCj4+Pj4gY2Qgfi9zcmMNCj4+Pj4gZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHVi
LmNvbS9naXQvZ2l0LmdpdA0KPj4+PiBjZCBnaXQNCj4+Pj4gZ21ha2UNCj4+Pj4gDQo+Pj4+IFRo
ZW4gdHJpZWQgfi9zcmMvZ2l0L2dpdCBjbG9uZSBodHRwczovL09VUl9SRVBPDQo+Pj4+IA0KPj4+
PiBJdCBjb3JlcyB0b28sIGFuZCBJIHNlZTogZ2l0LXJlbW90ZS1odHRwcy5jb3JlDQo+Pj4gDQo+
Pj4gQ2FuIHlvdSBjb21waWxlIHdpdGggZGVidWdnaW5nIHN5bWJvbHMgYW5kIHByb3ZpZGUgYSBi
YWNrdHJhY2U/ICBJJ20gbm90IA0KPj4+IHNlZWluZyBhbnkgc3VjaCBiZWhhdmlvciBvbiBteSBl
bmQsIGFuZCBJJ20gbm90IHN1cmUgd2hldGhlciBpdCdzIG15IA0KPj4+IHBhdGNoIG9yIHNvbWV0
aGluZyBlbHNlIHRoYXQgbWlnaHQgYmUgcHJlc2VudCBpbiBtYXN0ZXIuDQo+PiANCj4+IFRoZSBw
cm9ibGVtIG9yaWdpbmFsbHkgb2NjdXJyZWQgdW5kZXIgVk13YXJlIEZ1c2lvbiBhbmQgSeKAmW0g
dW5hYmxlIHRvIGdldCBhIGJhY2t0cmFjZSBmcm9tIGl0Lg0KPj4gSSBzdXNwZWN0IG1lbW9yeSBj
b25zdHJhaW50cyBhcmUgYSBmYWN0b3IuICBUaGVyZeKAmXMgb25seSA1R0IgUkFNIGF2YWlsYWJs
ZSB0byB0aGlzIFZNLg0KPj4gDQo+PiBJIGhhdmUgdHJpZWQgaW4gYW5vdGhlciBWTSBhbmQgdGhh
dCBzdWNjZWVkcy4gIEFsbCBnb29kIHRoZXJlLiBJdCBoYXMgNDBHQiBSQU0uDQo+PiANCj4+IEkg
YW0gZ29pbmcgdG8gdHJ5IHRoaXMgb24gYSB0aGlyZCBzeXN0ZW0uIEF0IHByZXNlbnQsIHdl4oCZ
cmUganVzdCA1MC81MCBvbiBzdWNjZXNzLg0KPiANCj4gDQo+IFdlIGhhdmUgbWFkZSBwcm9ncmVz
cyBJIHRoaW5rLg0KPiANCj4gV2l0aCBzdG9jayBnaXQ6DQo+IA0KPiB0bDtkcjogMSAtIHdpdGgg
YSB0aWNrZXQsIHlvdSBnZXQgcHJvbXB0ZWQsIGJ1dCBoaXR0aW5nIEVOVEVSIHN1Y2NlZWRzLg0K
PiAgICAgICAyIC0gd2l0aG91dCBhIHRpY2tldCwgbm90aGluZyB3b3Jrcw0KPiANCj4gDQo+IFdp
dGggcGF0Y2hlZCBnaXQ6DQo+IA0KPiB0bDtkcjogMSAtIHdpdGggYSB0aWNrZXQsICAgIGVudGVy
aW5nIGNyZWRlbnRpYWxzLCBTVUNDRUVEUzsganVzdCBoaXQgZW50ZXIsIGZhaWx1cmUNCg0KSWYg
SSBoYXZlIGEgdmFsaWQgdGlja2V0LCB3aHkgYW0gSSBiZWluZyBwcm9tcHRlZCBmb3IgY3JlZGVu
dGlhbHM/DQoNCkl0IGFwcGVhcnMgcGF0Y2hlZCBnaXQgYWx3YXlzIHdhbnRzIGNyZWRlbnRpYWxz
IGVudGVyZWQgYW5kIGlnbm9yZXMgdGhlIHZhbGlkIHRpY2tldC4NCg0KPiAgICAgICAyIC0gd2l0
aG91dCBhIHRpY2tldCwgZW50ZXJpbmcgY3JlZGVudGlhbHMsIFNVQ0NFRURTDQo+IA0KPiBIZXJl
IGlzIG15IHRlc3QsIHdpdGggYSB2YWxpZCBrZXJiZXJvcyB0aWNrZXQ6DQo+IA0KPiAkIGdpdCBj
bG9uZSBodHRwczovL2dpdC5leGFtcGxlLmNvbS9naXQvY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVy
DQo+IENsb25pbmcgaW50byAnY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVyJy4uLg0KPiBVc2VybmFt
ZSBmb3IgJ2h0dHBzOi8vZ2l0LmV4YW1wbGUuY29tJzogDQo+IFBhc3N3b3JkIGZvciAnaHR0cHM6
Ly9naXQuZXhhbXBsZS5jb20nOiANCj4gXkNtb3RlOiBDb3VudGluZyBvYmplY3RzOiAyMjQ1NDYg
ICANCj4gJA0KPiANCg0K

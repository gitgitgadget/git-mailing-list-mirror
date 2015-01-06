From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 6 Jan 2015 16:07:01 +0000
Message-ID: <AB98E028-8531-447B-959C-1DB385AB8578@cisco.com>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <F91CD1B2-262C-4ED6-AE46-31B1333E0350@cisco.com>
 <20150105235308.GC1025060@vauxhall.crustytoothpaste.net>
 <3FBC0B0E-BB54-4BD5-AE7D-C82BA9FBA1C1@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 17:08:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Wf3-0001lx-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 17:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbbAFQHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 11:07:06 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:6154 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbbAFQHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 11:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5256; q=dns/txt; s=iport;
  t=1420560425; x=1421770025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SxT8rMhPZDmvp3YD8Bj0miBzzocUE51yAL+T9lEgq10=;
  b=j6h6JKXUuUzSnHkLFI/UWHdQHvF6DYq537//RK027EfLDWr36LoTzpUE
   PlVEQyppJ6Xx6q/xxI95Wu2bwsDNeZg2fxfOh7VfKGSk19J75HLsnqIgx
   1aAy6vMs+2A8M1BCwlr3GMEDx351DzkVSr0suDWcel7czWFw1QcQBMu7z
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArUFABQHrFStJA2M/2dsb2JhbABcgwZSWASDAcM/hXMCHHIWAQEBAQF9hAwBAQEDASMRRQULAgEIFAQCAhQSAgICMBUQAgQOBYgkCA2tapN/AQEBAQEBAQEBAQEBAQEBAQEBAQEBF4EhjhIqGwcYglAugRMFjiCDQIU1gQ2NE4M5IoNub4FFfgEBAQ
X-IronPort-AV: E=Sophos;i="5.07,708,1413244800"; 
   d="scan'208";a="384759245"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-3.cisco.com with ESMTP; 06 Jan 2015 16:07:03 +0000
Received: from xhc-rcd-x01.cisco.com (xhc-rcd-x01.cisco.com [173.37.183.75])
	by alln-core-7.cisco.com (8.14.5/8.14.5) with ESMTP id t06G72uZ011013
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Jan 2015 16:07:03 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.219]) by
 xhc-rcd-x01.cisco.com ([173.37.183.75]) with mapi id 14.03.0195.001; Tue, 6
 Jan 2015 10:07:02 -0600
Thread-Topic: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQJf0bER2Pnky56Uqguh0whTd+7JyydFEAgAApzYCAAQYrgIAACeuA
In-Reply-To: <3FBC0B0E-BB54-4BD5-AE7D-C82BA9FBA1C1@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.241.248]
Content-ID: <F7312C9FFB3CA94BBECB30D8DC31895B@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262073>

PiBPbiBKYW4gNiwgMjAxNSwgYXQgMTA6MzEgQU0sIERhbiBMYW5naWxsZSAoZGFsYW5naWwpIDxk
YWxhbmdpbEBjaXNjby5jb20+IHdyb3RlOg0KPiANCj4gT24gSmFuIDUsIDIwMTUsIGF0IDY6NTMg
UE0sIGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3Rl
Og0KPj4gDQo+PiBPbiBNb24sIEphbiAwNSwgMjAxNSBhdCAwOToyMzozMlBNICswMDAwLCBEYW4g
TGFuZ2lsbGUgKGRhbGFuZ2lsKSB3cm90ZToNCj4+PiBJIGhhdmUgdHJpZWQgYm90aCBwYXRjaGVz
LiAgTmVpdGhlciBzdWNjZWVkcyBoZXJlLiAgSSBwYXRjaGVkIGdpdCB2ZXJzaW9uIDIuMi4xIGJ1
dCBJIGRvbuKAmXQgdGhpbmsgdGhhdCBhZmZlY3RzIHRoaXMuDQo+PiANCj4+IFlvdSBhcmUgcGF0
Y2hpbmcgdGhlIGNsaWVudCBzaWRlLCBjb3JyZWN0PyAgVGhhdCdzIHRoZSBzaWRlIHRoYXQgbmVl
ZHMgcGF0Y2hpbmcgaGVyZS4NCj4gDQo+IFllcywgSSBhbS4NCj4gDQo+PiBKdXN0IHNvIHRoZSBs
aXN0IGtub3dzLCBJIHdpbGwgYmUgc2VuZGluZyBhIHJlcm9sbCB0byB0aGUgZXhpc3RpbmcgcGF0
Y2gsIGJ1dCB0aGUgcGF0Y2hlcyBJJ3ZlIHBvc3RlZCBkbyBpbmRlZWQgd29yayBpbiBteSB0ZXN0
aW5nLg0KPiANCj4gSSBhcHByZWNpYXRlIHRoZSBwYXRjaGVzLiAgSSBibGFtZSBzb21ldGhpbmcg
aGVyZS4NCj4gDQo+IFRoZSBwYXRjaGVzIGRvbuKAmXQgdCBhcHBseSBjbGVhbmx5IHRvIGdpdC0y
LjIuMSBvciB0byB0aGUgbGF0ZXN0IGdpdCBzb3VyY2UgSSBqdXN0IGNsb25lZC4gIEkgaGFkIHRv
IGNvcHkvcGFzdGUgc29tZSB0d28gY2h1bmtzIGluIGh0dHAuYyBhbmQgZXZlcnl0aGluZyBpbiBy
ZW1vdGUtY3VybC5jLg0KDQpJIHRyaWVkIGFnYWluLCB3aXRoIGEgcHJvcGVyIGNvcHkgb2YgeW91
ciBwYXRjaC4gQ2xlYW5seSBwYXRjaGVkIHZlcnNpb25zIG9mIGdpdCAyLjIuMSBhbmQgZnJvbQ0K
YSByZWNlbnQgY2xvbmUgb2YgdGhlIHJlcG8gYm90aCBnaXZlICdBdXRoZW50aWNhdGlvbiBmYWls
ZWTigJkgd2hlbiBkb2luZyBhIGNsb25lIHdpdGhvdXQgYSB0aWNrZXQuDQoNCknigJltIHN1cmUg
dGhlcmXigJlzIHNvbWV0aGluZyBoZXJlIHdoaWNoIGlzIGF0IGZhdWx0Lg0KDQpIZXJlIGlzIHRo
ZSBjbGllbnQgc2lkZSBkZWJ1Z2dpbmcuICBJcyB0aGlzIHdoYXQgaXMgZXhwZWN0ZWQ/ICBUZXN0
ZWQgd2l0aCBhIGNsb25lIG9mIGdpdCBmcm9tIHRoaXMgbW9ybmluZy4NCg0KW2RhbkBwb3J0ZXI5
MyB+L3RtcC90bXBdJCB+L3NyYy9naXQvZ2l0IGNsb25lIGh0dHBzOi8vdXMuZXhhbXBsZS5vcmcv
Z2l0L2NsYW1hdi1ieXRlY29kZS1jb21waWxlcg0KQ2xvbmluZyBpbnRvICdjbGFtYXYtYnl0ZWNv
ZGUtY29tcGlsZXInLi4uDQp3YXJuaW5nOiB0ZW1wbGF0ZXMgbm90IGZvdW5kIC91c3IvaG9tZS9k
YW4vc2hhcmUvZ2l0LWNvcmUvdGVtcGxhdGVzDQoqIENvdWxkbid0IGZpbmQgaG9zdCB1cy5leGFt
cGxlLm9yZyBpbiB0aGUgLm5ldHJjIGZpbGU7IHVzaW5nIGRlZmF1bHRzDQoqIEhvc3RuYW1lIHdh
cyBOT1QgZm91bmQgaW4gRE5TIGNhY2hlDQoqICAgVHJ5aW5nIDEwLjAuMC4xLi4uDQoqIENvbm5l
Y3RlZCB0byB1cy5leGFtcGxlLm9yZyAoMTAuMC4wLjEpIHBvcnQgNDQzICgjMCkNCiogc3VjY2Vz
c2Z1bGx5IHNldCBjZXJ0aWZpY2F0ZSB2ZXJpZnkgbG9jYXRpb25zOg0KKiAgIENBZmlsZTogL3Vz
ci9sb2NhbC9zaGFyZS9jZXJ0cy9jYS1yb290LW5zcy5jcnQNCiAgQ0FwYXRoOiBub25lDQoqIFNT
TCBjb25uZWN0aW9uIHVzaW5nIFRMU3YxLjAgLyBESEUtUlNBLUNBTUVMTElBMjU2LVNIQQ0KKiBT
ZXJ2ZXIgY2VydGlmaWNhdGU6DQoqIAkgc3ViamVjdDogUkVEQUNURUQNCiogCSBzdGFydCBkYXRl
OiBSRURBQ1RFRA0KKiAJIGV4cGlyZSBkYXRlOiBSRURBQ1RFRA0KKiAJIGlzc3VlcjogUkVEQUNU
RUQNCiogCSBTU0wgY2VydGlmaWNhdGUgdmVyaWZ5IHJlc3VsdDogc2VsZiBzaWduZWQgY2VydGlm
aWNhdGUgaW4gY2VydGlmaWNhdGUgY2hhaW4gKDE5KSwgY29udGludWluZyBhbnl3YXkuDQo+IEdF
VCAvZ2l0L2NsYW1hdi1ieXRlY29kZS1jb21waWxlci9pbmZvL3JlZnM/c2VydmljZT1naXQtdXBs
b2FkLXBhY2sgSFRUUC8xLjENClVzZXItQWdlbnQ6IGdpdC8yLjIuMS4yMTIuZ2M1YjkyNTYuZGly
dHkNCkhvc3Q6IHVzLmV4YW1wbGUub3JnDQpBY2NlcHQ6ICovKg0KQWNjZXB0LUVuY29kaW5nOiBn
emlwDQpQcmFnbWE6IG5vLWNhY2hlDQoNCjwgSFRUUC8xLjEgNDAxIEF1dGhvcml6YXRpb24gUmVx
dWlyZWQNCjwgRGF0ZTogVHVlLCAwNiBKYW4gMjAxNSAxNjowMjozOCBHTVQNCjwgU2VydmVyOiBB
cGFjaGUNCjwgV1dXLUF1dGhlbnRpY2F0ZTogTmVnb3RpYXRlDQo8IENvbnRlbnQtTGVuZ3RoOiA0
MDENCjwgQ29udGVudC1UeXBlOiB0ZXh0L2h0bWw7IGNoYXJzZXQ9aXNvLTg4NTktMQ0KPCANCiog
Q29ubmVjdGlvbiAjMCB0byBob3N0IHVzLmV4YW1wbGUub3JnIGxlZnQgaW50YWN0DQpVc2VybmFt
ZSBmb3IgJ2h0dHBzOi8vdXMuZXhhbXBsZS5vcmcnOiANClBhc3N3b3JkIGZvciAnaHR0cHM6Ly9k
YW5AdXMuZXhhbXBsZS5vcmcnOiANCiogQ291bGRuJ3QgZmluZCBob3N0IHVzLmV4YW1wbGUub3Jn
IGluIHRoZSAubmV0cmMgZmlsZTsgdXNpbmcgZGVmYXVsdHMNCiogQ29ubmVjdGlvbiAwIHNlZW1z
IHRvIGJlIGRlYWQhDQoqIENsb3NpbmcgY29ubmVjdGlvbiAwDQoqIEhvc3RuYW1lIHdhcyBmb3Vu
ZCBpbiBETlMgY2FjaGUNCiogICBUcnlpbmcgMTAuMC4wLjEuLi4NCiogQ29ubmVjdGVkIHRvIHVz
LmV4YW1wbGUub3JnICgxMC4wLjAuMSkgcG9ydCA0NDMgKCMxKQ0KKiBzdWNjZXNzZnVsbHkgc2V0
IGNlcnRpZmljYXRlIHZlcmlmeSBsb2NhdGlvbnM6DQoqICAgQ0FmaWxlOiAvdXNyL2xvY2FsL3No
YXJlL2NlcnRzL2NhLXJvb3QtbnNzLmNydA0KICBDQXBhdGg6IG5vbmUNCiogU1NMIHJlLXVzaW5n
IHNlc3Npb24gSUQNCiogU1NMIGNvbm5lY3Rpb24gdXNpbmcgVExTdjEuMCAvIERIRS1SU0EtQ0FN
RUxMSUEyNTYtU0hBDQoqIFNlcnZlciBjZXJ0aWZpY2F0ZToNCiogCSBzdWJqZWN0OiBSRURBQ1RF
RA0KKiAJIHN0YXJ0IGRhdGU6IFJFREFDVEVEDQoqIAkgZXhwaXJlIGRhdGU6IFJFREFDVEVEDQoq
IAkgaXNzdWVyOiBSRURBQ1RFRA0KKiAJIFNTTCBjZXJ0aWZpY2F0ZSB2ZXJpZnkgcmVzdWx0OiBz
ZWxmIHNpZ25lZCBjZXJ0aWZpY2F0ZSBpbiBjZXJ0aWZpY2F0ZSBjaGFpbiAoMTkpLCBjb250aW51
aW5nIGFueXdheS4NCj4gR0VUIC9naXQvY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVyL2luZm8vcmVm
cz9zZXJ2aWNlPWdpdC11cGxvYWQtcGFjayBIVFRQLzEuMQ0KVXNlci1BZ2VudDogZ2l0LzIuMi4x
LjIxMi5nYzViOTI1Ni5kaXJ0eQ0KSG9zdDogdXMuZXhhbXBsZS5vcmcNCkFjY2VwdDogKi8qDQpB
Y2NlcHQtRW5jb2Rpbmc6IGd6aXANClByYWdtYTogbm8tY2FjaGUNCg0KPCBIVFRQLzEuMSA0MDEg
QXV0aG9yaXphdGlvbiBSZXF1aXJlZA0KPCBEYXRlOiBUdWUsIDA2IEphbiAyMDE1IDE2OjAyOjQ4
IEdNVA0KPCBTZXJ2ZXI6IEFwYWNoZQ0KPCBXV1ctQXV0aGVudGljYXRlOiBOZWdvdGlhdGUNCjwg
Q29udGVudC1MZW5ndGg6IDQwMQ0KPCBDb250ZW50LVR5cGU6IHRleHQvaHRtbDsgY2hhcnNldD1p
c28tODg1OS0xDQo8IA0KKiBDb25uZWN0aW9uICMxIHRvIGhvc3QgdXMuZXhhbXBsZS5vcmcgbGVm
dCBpbnRhY3QNCmZhdGFsOiBBdXRoZW50aWNhdGlvbiBmYWlsZWQgZm9yICdodHRwczovL3VzLmV4
YW1wbGUub3JnL2dpdC9jbGFtYXYtYnl0ZWNvZGUtY29tcGlsZXIvJw0KW2RhbkBwb3J0ZXI5MyB+
L3RtcC90bXBdJCANCg0KDQoNCg0K

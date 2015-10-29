From: Matt Glazar <strager@fb.com>
Subject: Re: git-fetch pulls already-pulled objects?
Date: Thu, 29 Oct 2015 19:52:27 +0000
Message-ID: <D257C4CB.1378A%strager@fb.com>
References: <D256A718.1373A%strager@fb.com>
 <xmqqd1vxshrd.fsf@gitster.mtv.corp.google.com>
 <D257AC36.1376F%strager@fb.com>
 <xmqqwpu5qzxs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 20:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrtFV-00034Q-73
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 20:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbbJ2Twd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 15:52:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11469 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752005AbbJ2Twc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2015 15:52:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id t9TJnMuP030286;
	Thu, 29 Oct 2015 12:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cqZoQwU0RRa1pC2jFTAUiXVDkU5V9Hd9DKiglLnqjas=;
 b=gSf34UJOdvmHn8U+HA57v5QeuaQ1XYqHgdSE1tz8RIvdg0dcdz8yWCrvagXnTqE13sW6
 A8LHwSVy1NMf7vy61GwM8DnZs7k8Uk4SPjlsNK63obgmJ6B6u62aNT0DFkWzbY7k/iwM
 YtTo3ucg6nhVCw6fkWE4AKA/jek9FnoiNGA= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1xuq4wgqy5-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 29 Oct 2015 12:52:29 -0700
Received: from PRN-MBX01-4.TheFacebook.com ([169.254.3.151]) by
 PRN-CHUB03.TheFacebook.com ([fe80::fd64:bd05:4514:bbad%12]) with mapi id
 14.03.0248.002; Thu, 29 Oct 2015 12:52:28 -0700
Thread-Topic: git-fetch pulls already-pulled objects?
Thread-Index: AQHREnmMt4Zi9tm5IkaAubrCKnEpKp6C4bgA
In-Reply-To: <xmqqwpu5qzxs.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.52.123]
Content-ID: <AEB8AAFBE5846547884952D2C7209CB4@fb.com>
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2015-10-29_13:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280457>

PiBJIGZvcmdvdCB0byBtZW50aW9uIHRoZSByZWNlbnQgInBhY2sgYml0bWFwIiBhZGRpdGlvbi4g
IEl0IG1ha2VzIHRoZQ0KPiBzZXQgb2YgImNhbiBiZSBjaGVhcGx5IHByb3ZlbiB0byBleGlzdCIg
YSBsb3QgbGFyZ2VyLg0KDQpDb29sISBJIHRyaWVkIHRoaXMgZmVhdHVyZSwgYW5kIGl0IHdvcmtl
ZCEgKEF0IGxlYXN0LCBpdCB3b3JrZWQgZm9yIG15DQpzbWFsbCB0ZXN0IGNhc2UuKQ0KDQpJIHJh
biBvbiB0aGUgc2VydmVyIChhZnRlciBwdXNoaW5nIHRoZSBvYmplY3RzKToNCg0KZ2l0IGNvbmZp
ZyByZXBhY2sud3JpdGVCaXRtYXBzIHRydWUNCmdpdCByZXBhY2sgLUFkDQoNCkFmdGVyIHRoaXMs
IHRoZSAnZ2l0IGZldGNoIG9yaWdpbiBtYXN0ZXIyJyB3YXMgc3VwZXIgcXVpY2suDQoNClRoYW5r
cyBmb3IgeW91ciBoZWxwIQ0KDQpBc2lkZTogVGhpcyB0ZXN0IGNhc2UgaXMgdXNpbmcgKG5vcm1h
bCwgQy9zaCkgR2l0LiBNeSBwcm9kdWN0aW9uDQplbnZpcm9ubWVudCB1c2VzIEpHaXQgb24gdGhl
IHNlcnZlci4gSSBoYXZlbid0IHRlc3RlZCB0aGlzIHdpdGggSkdpdC4NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4N
CkRhdGU6IFRodXJzZGF5LCBPY3RvYmVyIDI5LCAyMDE1IGF0IDExOjQyIEFNDQpUbzogTWF0dCBH
bGF6ZXIgPHN0cmFnZXJAZmIuY29tPg0KQ2M6ICJnaXRAdmdlci5rZXJuZWwub3JnIiA8Z2l0QHZn
ZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBnaXQtZmV0Y2ggcHVsbHMgYWxyZWFkeS1wdWxs
ZWQgb2JqZWN0cz8NCg0KPk1hdHQgR2xhemFyIDxzdHJhZ2VyQGZiLmNvbT4gd3JpdGVzOg0KPg0K
Pj4gV291bGQgbmVnb3RpYXRpbmcgdGhlIHRyZWUgb2JqZWN0IGhhc2hlcyBiZSBwb3NzaWJsZSBv
biB0aGUgY2xpZW50DQo+PndpdGhvdXQNCj4+IHNlcnZlciBjaGFuZ2VzPyBJcyB0aGUgcHJvdG9j
b2wgdGhhdCBmbGV4aWJsZT8NCj4NCj5UaGUgcHJvdG9jb2wgaXMgc3RyaWN0bHkgImZpbmQgY29t
bW9uIGFuY2VzdG9yIGluIHRoZSBjb21taXQNCj5oaXN0b3J5Ii4gIEV2ZXJ5dGhpbmcgZWxzZSBp
cyBkb25lIG9uIHRoZSBzZW5kZXIuDQo+DQo+Pj5UaGUgb2JqZWN0IHRyYW5zZmVyIGlzIGRvbmUg
YnkgZmlyc3QgZmluZGluZyB0aGUgY29tbW9uIGFuY2VzdG9yIG9mDQo+Pj5oaXN0b3JpZXMgb2Yg
dGhlIHNlbmRpbmcgYW5kIHRoZSByZWNlaXZpbmcgc2lkZXMsIHdoaWNoIGFsbG93cyB0aGUNCj4+
PnNlbmRlciB0byBlbnVtZXJhdGUgY29tbWl0cyB0aGF0IHRoZSBzZW5kZXIgaGFzIGJ1dCB0aGUg
cmVjZWl2ZXINCj4+PmRvZXNuJ3QuICBGcm9tIHRoZXJlLCBhbGwgb2JqZWN0cyBbKjEqXSB0aGF0
IGFyZSByZWZlcmVuY2VkIGJ5IHRoZXNlDQo+Pj5jb21taXRzIHRoYXQgbmVlZCB0byBiZSBzZW50
Lg0KPg0KPj4+W0Zvb3Rub3RlXQ0KPj4+DQo+Pj4qMSogVGhlcmUgaXMgYW4gb3B0aW1pemF0aW9u
IHRvIGV4Y2x1ZGUgdGhlIHRyZWVzIGFuZCBibG9icyB0aGF0IGNhbg0KPj4+YmUgY2hlYXBseSBw
cm92ZW4gdG8gZXhpc3Qgb24gdGhlIHJlY2VpdmluZyBlbmQuICBJZiB0aGUgcmVjZWl2aW5nDQo+
Pj5lbmQgaGFzIGEgY29tbWl0IHRoYXQgdGhlIHNlbmRpbmcgZW5kIGRvZXMgKm5vdCogaGF2ZSwg
YW5kIHRoYXQNCj4+PmNvbW1pdCBoYXBwZW5zIHRvIHJlY29yZCBhIHRyZWUgdGhlIHNlbmRpbmcg
ZW5kIG5lZWRzIHRvIHNlbmQsDQo+Pj5ob3dldmVyLCB0aGUgc2VuZGluZyBlbmQgY2Fubm90IHBy
b3ZlIHRoYXQgdGhlIHRyZWUgZG9lcyBub3QgaGF2ZSB0bw0KPj4+YmUgc2VudCB3aXRob3V0IGZp
cnN0IGZldGNoaW5nIHRoYXQgY29tbWl0IGZyb20gdGhlIHJlY2VpdmluZyBlbmQsDQo+Pj53aGlj
aCBmYWlscyAiY2FuIGJlIGNoZWFwbHkgcHJvdmVuIHRvIGV4aXN0IiB0ZXN0Lg0KPg0KPkkgZm9y
Z290IHRvIG1lbnRpb24gdGhlIHJlY2VudCAicGFjayBiaXRtYXAiIGFkZGl0aW9uLiAgSXQgbWFr
ZXMgdGhlDQo+c2V0IG9mICJjYW4gYmUgY2hlYXBseSBwcm92ZW4gdG8gZXhpc3QiIGEgbG90IGxh
cmdlci4NCj4NCj5JZiBmb3IgZXhhbXBsZSB0aGUgc2VuZGVyIG5lZWRzIHRvIHNlbmQgb25lIGNv
bW1pdCBDIGJlY2F1c2UgaXQNCj5kZXRlcm1pbmVkIHRoYXQgdGhlIHJlY2VpdmVyIGhhcyBoaXN0
b3J5IHVwIHRvIGNvbW1pdCBDfjEsIHdpdGhvdXQNCj50aGUgYml0bWFwLCBldmVuIHdoZW4gQ157
dHJlZX0gKGkuZS4gdGhlIHRyZWUgb2YgQykgaXMgaWRlbnRpY2FsIHRvDQo+Q34yXnt0cmVlfSAo
aS5lLiB0aGUgdHJlZSBvZiBDfjIpLCBpdCB3b3VsZCBoYXZlIHNlbnQgdGhhdCB0cmVlDQo+b2Jq
ZWN0IGJlY2F1c2UgInByb3ZpbmcgdGhhdCB0aGUgcmVjZWl2ZXIgYWxyZWFkeSBoYXMgaXQiIHdv
dWxkDQo+cmVxdWlyZSB0aGUgc2VuZGVyIHRvIGRpZyBpdHMgaGlzdG9yeSBiYWNrLCBzdGFydGlu
ZyBmcm9tIEN+MQ0KPihpLmUuIHRoZSBjb21taXQgdGhhdCBpcyBrbm93biB0byBleGlzdCBhdCB0
aGUgcmVjZWl2ZXIpLCB0bw0KPmVudW1lcmF0ZSB0aGUgb2JqZWN0cyBjb250YWluZWQgaW4gdGhl
IGNvbW1vbiBwYXJ0IG9mIHRoZSBoaXN0b3J5LA0KPndoaWNoIGZhaWxzIHRoZSAiY2FuIGJlIGNo
ZWFwbHkgcHJvdmVuIHRvIGV4aXN0IiB0ZXN0Lg0KPg0KPlRoZSAicGFjayBiaXRtYXAiIHByZS1j
b21wdXRlcyB3aGF0IGNvbW1pdHMsIHRyZWVzIGFuZCBibG9icyBzaG91bGQNCj5hbHJlYWR5IGV4
aXN0IGluIHRoZSByZXBvc2l0b3J5IGdpdmVuIGEgY29tbWl0IGZvciB3aGljaCBiaXRtYXANCj5l
eGlzdHMuICBVc2luZyB0aGUgYml0bWFwLCBmcm9tIEN+MSAoaS5lLiB0aGUgY29tbWl0IGtub3du
IHRvIGV4aXN0DQo+YXQgdGhlIHJlY2VpdmluZyBlbmQpLCBpdCBjYW4gYmUgcHJvdmVuIGNoZWFw
bHkgdGhhdCBDXnt0cmVlfSB0aGF0DQo+aGFwcGVucyB0byBiZSBpZGVudGljYWwgdG8gQ34yXnt0
cmVlfSBhbHJlYWR5IGV4aXN0cyBvdmVyIHRoZXJlLCBhbmQNCj50aGUgc2VuZGVyIGNhbiB1c2Ug
dGhpcyBrbm93bGVkZ2UgdG8gcmVkdWNlIHRoZSB0cmFuc2Zlci4NCj4NCj5UaGUgInBhY2sgYml0
bWFwIiBob3dldmVyIGRvZXMgbm90IGNoYW5nZSB0aGUgZnVuZGFtZW50YWwgc3RydWN0dXJlLg0K
PklmIHlvdXIgcmVjZWl2ZXIgaGFzIGEgY29tbWl0IHRoYXQgaXMgbm90IGtub3duIHRvIHRoZSBz
ZW5kZXIsIGFuZA0KPnRoYXQgY29tbWl0IGhhcHBlbnMgdG8gcmVjb3JkIHRoZSBzYW1lIHRyZWUg
cmVjb3JkZWQgaW4gdGhlIGNvbW1pdA0KPnRoYXQgbmVlZHMgdG8gYmUgc2VudCwgdGhlcmUgaXMg
bm8gd2F5IGZvciB0aGUgc2VuZGVyIHRvIGtub3cgdGhhdA0KPnRoZSByZWNlaXZlciBoYXMgaXQs
IGV4YWN0bHkgYmVjYXVzZSB0aGUgZXhjaGFuZ2UgYmV0d2VlbiB0aGVtIGlzDQo+cHVyZWx5ICJm
aW5kIGNvbW1vbiBhbmNlc3RvciBpbiBoaXN0b3J5Ii4NCg0K

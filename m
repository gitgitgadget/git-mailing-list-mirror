From: Matt Glazar <strager@fb.com>
Subject: Re: git-fetch pulls already-pulled objects?
Date: Thu, 29 Oct 2015 18:08:44 +0000
Message-ID: <D257AC36.1376F%strager@fb.com>
References: <D256A718.1373A%strager@fb.com>
 <xmqqd1vxshrd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:09:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrrdQ-0007OF-FK
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 19:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbJ2SI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 14:08:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34257 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751055AbbJ2SIz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2015 14:08:55 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id t9TI4qif012308;
	Thu, 29 Oct 2015 11:08:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zUBLnKrR3Y5Z8uxj7Owob/8PIp67HxXzQyUKVE47fTc=;
 b=OXduJaruIHwJSSAfm3hB5U/QvW0YfhtuA6wWjXMq+9sTgbMBCPKhj3dpTsMkQdsikqty
 L7tBZMcFHa3M64aq3AvaPrzjZ+DFSxqdNIQaWKe7XlrbYz2qpVTnia5UnkdzMnzGgOQK
 IU4dlzLx39BBvxSHY5J+6xu2gIYFyWYJB6k= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1xuq518byt-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 29 Oct 2015 11:08:46 -0700
Received: from PRN-MBX01-4.TheFacebook.com ([169.254.3.151]) by
 PRN-CHUB03.TheFacebook.com ([fe80::fd64:bd05:4514:bbad%12]) with mapi id
 14.03.0248.002; Thu, 29 Oct 2015 11:08:45 -0700
Thread-Topic: git-fetch pulls already-pulled objects?
Thread-Index: AQHREdhXt4Zi9tm5IkaAubrCKnEpKp6Cu8tzgAAKNYA=
In-Reply-To: <xmqqd1vxshrd.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.52.123]
Content-ID: <93834ABF06BA2945AFC1A6CFC4D59760@fb.com>
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2015-10-29_12:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280453>

PiBXaGF0IHlvdSBhcmUgZXhwZWN0aW5nIF9jb3VsZF8gYmUgaW1wbGVtZW50ZWQgYnkgZXhjaGFu
Z2luZyBhbGwNCj4gdHJlZSBhbmQgYmxvYiBvYmplY3RzIHNlbmRpbmcgYW5kIHJlY2VpdmluZyBz
aWRlcyBoYXZlIGFuZCBjb21wdXRpbmcNCj4gdGhlIHNldCBkaWZmZXJlbmNlLCBidXQgdGhlIHNl
bmRlciBhbmQgdGhlIHJlY2VpdmVyIGRvIG5vdCBleGNoYW5nZQ0KPiBzdWNoIGEgaHVnZSBsaXN0
Lg0KDQpJbiBteSBjYXNlLCBJIG9ubHkgd2FudCB0byBleGNoYW5nZSB0aGUgdHJlZSBvYmplY3Qg
aGFzaCBwb2ludGVkIGRpcmVjdGx5DQpieSB0aGUgY29tbWl0IG9iamVjdDsgSSBkb24ndCBjYXJl
IGFib3V0IGFsbCBzdWJ0cmVlcyBhbmQgYmxvYnMgcmVhY2hhYmxlDQpmcm9tIHRoZSBjb21taXQu
IEkgdGhpbmsgYSBuYWl2ZSBhcHByb2FjaCB3b3VsZCBvbmx5IGRvdWJsZSB0aGUgbnVtYmVyIG9m
DQpoYXNoZXMgc2VudCB3b3JzdCBjYXNlLg0KDQpXb3VsZCBuZWdvdGlhdGluZyB0aGUgdHJlZSBv
YmplY3QgaGFzaGVzIGJlIHBvc3NpYmxlIG9uIHRoZSBjbGllbnQgd2l0aG91dA0Kc2VydmVyIGNo
YW5nZXM/IElzIHRoZSBwcm90b2NvbCB0aGF0IGZsZXhpYmxlPw0KDQoNCklmIHdoYXQgSSB3YW50
IGlzICpub3QqIHBvc3NpYmxlLCBpcyBpdCBwb3NzaWJsZSB0byBleHBsaWNpdGx5IHB1dCBhIHRy
ZWUNCihhbmQgaXRzIGRlc2NlbmRhbnRzKSBpbnRvIGl0cyBvd24gcGFjaz8gSSB0aGluayB0aGF0
IHdpbGwgc3BlZWQgdXAgdGhlDQpnaXQtZmV0Y2ggYSBiaXQgYnkgZG9pbmcgdGhpcyBvbiB0aGUg
c2VydmVyLiAoSSBrbm93IHdoYXQgdHJlZXMvY29tbWl0cw0Kd2lsbCBiZSBzZW50IGFoZWFkIG9m
IHRpbWUuKSAoVGhlIHNlcnZlciBkb2VzIGxlc3Mgd29yayBwdWxsaW5nIHRoZQ0Kb2JqZWN0cyBv
dXQgb2YgYW4gZXhpc3RpbmcgcGFjayBhbmQgcmVwYWNraW5nIHRoZW0gZm9yIHRoZSBjbGllbnQu
IChPcg0KbWF5YmUgbXkgbWVudGFsIG1vZGVsIG9mIGdpdCBwYWNrcyBpcyB3cm9uZz8pKQ0KDQo+
IFRoZSBvYmplY3QgdHJhbnNmZXIgaXMgZG9uZSBieSBmaXJzdCBmaW5kaW5nIHRoZSBjb21tb24g
YW5jZXN0b3Igb2YNCj4gaGlzdG9yaWVzIG9mIHRoZSBzZW5kaW5nIGFuZCB0aGUgcmVjZWl2aW5n
IHNpZGVzLCB3aGljaCBhbGxvd3MgdGhlDQo+IHNlbmRlciB0byBlbnVtZXJhdGUgY29tbWl0cyB0
aGF0IHRoZSBzZW5kZXIgaGFzIGJ1dCB0aGUgcmVjZWl2ZXINCj4gZG9lc24ndC4gIEZyb20gdGhl
cmUsIGFsbCBvYmplY3RzIFsqMSpdIHRoYXQgYXJlIHJlZmVyZW5jZWQgYnkgdGhlc2UNCj4gY29t
bWl0cyB0aGF0IG5lZWQgdG8gYmUgc2VudC4NCg0KVGhhbmtzIGZvciBjbGFyaWZ5aW5nLg0KDQo+
ICoxKiBUaGVyZSBpcyBhbiBvcHRpbWl6YXRpb24gdG8gZXhjbHVkZSB0aGUgdHJlZXMgYW5kIGJs
b2JzIHRoYXQgY2FuDQo+IGJlIGNoZWFwbHkgcHJvdmVuIHRvIGV4aXN0IG9uIHRoZSByZWNlaXZp
bmcgZW5kLg0KDQpUaGF0IG1ha2VzIHNlbnNlIChlc3BlY2lhbGx5IGZvciAnZ2l0IHJldmVydCBI
RUFEJyBzaXR1YXRpb25zKS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LCBKdW5pby4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVy
QHBvYm94LmNvbT4NCkRhdGU6IFRodXJzZGF5LCBPY3RvYmVyIDI5LCAyMDE1IGF0IDEwOjMyIEFN
DQpUbzogTWF0dCBHbGF6ZXIgPHN0cmFnZXJAZmIuY29tPg0KQ2M6ICJnaXRAdmdlci5rZXJuZWwu
b3JnIiA8Z2l0QHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBnaXQtZmV0Y2ggcHVsbHMg
YWxyZWFkeS1wdWxsZWQgb2JqZWN0cz8NCg0KPk1hdHQgR2xhemFyIDxzdHJhZ2VyQGZiLmNvbT4g
d3JpdGVzOg0KPg0KPj4gT24gYSByZW1vdGUsIEkgaGF2ZSB0d28gR2l0IGNvbW1pdCBvYmplY3Rz
IHdoaWNoIHBvaW50IHRvIHRoZSBzYW1lIHRyZWUNCj4+IG9iamVjdCAoY3JlYXRlZCB3aXRoIGdp
dCBjb21taXQtdHJlZSkuDQo+DQo+V2hhdCB5b3UgYXJlIGV4cGVjdGluZyBfY291bGRfIGJlIGlt
cGxlbWVudGVkIGJ5IGV4Y2hhbmdpbmcgYWxsDQo+dHJlZSBhbmQgYmxvYiBvYmplY3RzIHNlbmRp
bmcgYW5kIHJlY2VpdmluZyBzaWRlcyBoYXZlIGFuZCBjb21wdXRpbmcNCj50aGUgc2V0IGRpZmZl
cmVuY2UsIGJ1dCB0aGUgc2VuZGVyIGFuZCB0aGUgcmVjZWl2ZXIgZG8gbm90IGV4Y2hhbmdlDQo+
c3VjaCBhIGh1Z2UgbGlzdC4NCj4NCj5UaGUgb2JqZWN0IHRyYW5zZmVyIGlzIGRvbmUgYnkgZmly
c3QgZmluZGluZyB0aGUgY29tbW9uIGFuY2VzdG9yIG9mDQo+aGlzdG9yaWVzIG9mIHRoZSBzZW5k
aW5nIGFuZCB0aGUgcmVjZWl2aW5nIHNpZGVzLCB3aGljaCBhbGxvd3MgdGhlDQo+c2VuZGVyIHRv
IGVudW1lcmF0ZSBjb21taXRzIHRoYXQgdGhlIHNlbmRlciBoYXMgYnV0IHRoZSByZWNlaXZlcg0K
PmRvZXNuJ3QuICBGcm9tIHRoZXJlLCBhbGwgb2JqZWN0cyBbKjEqXSB0aGF0IGFyZSByZWZlcmVu
Y2VkIGJ5IHRoZXNlDQo+Y29tbWl0cyB0aGF0IG5lZWQgdG8gYmUgc2VudC4NCj4NCj4NCj5bRm9v
dG5vdGVdDQo+DQo+KjEqIFRoZXJlIGlzIGFuIG9wdGltaXphdGlvbiB0byBleGNsdWRlIHRoZSB0
cmVlcyBhbmQgYmxvYnMgdGhhdCBjYW4NCj5iZSBjaGVhcGx5IHByb3ZlbiB0byBleGlzdCBvbiB0
aGUgcmVjZWl2aW5nIGVuZC4gIElmIHRoZSByZWNlaXZpbmcNCj5lbmQgaGFzIGEgY29tbWl0IHRo
YXQgdGhlIHNlbmRpbmcgZW5kIGRvZXMgKm5vdCogaGF2ZSwgYW5kIHRoYXQNCj5jb21taXQgaGFw
cGVucyB0byByZWNvcmQgYSB0cmVlIHRoZSBzZW5kaW5nIGVuZCBuZWVkcyB0byBzZW5kLA0KPmhv
d2V2ZXIsIHRoZSBzZW5kaW5nIGVuZCBjYW5ub3QgcHJvdmUgdGhhdCB0aGUgdHJlZSBkb2VzIG5v
dCBoYXZlIHRvDQo+YmUgc2VudCB3aXRob3V0IGZpcnN0IGZldGNoaW5nIHRoYXQgY29tbWl0IGZy
b20gdGhlIHJlY2VpdmluZyBlbmQsDQo+d2hpY2ggZmFpbHMgImNhbiBiZSBjaGVhcGx5IHByb3Zl
biB0byBleGlzdCIgdGVzdC4NCj4NCg0K

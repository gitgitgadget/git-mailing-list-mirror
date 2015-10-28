From: Matt Glazar <strager@fb.com>
Subject: git-fetch pulls already-pulled objects?
Date: Wed, 28 Oct 2015 23:28:24 +0000
Message-ID: <D256A718.1373A%strager@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 00:28:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra8z-0000CX-2h
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbbJ1X22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:28:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40962 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964911AbbJ1X21 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2015 19:28:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id t9SNOX0d032177
	for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:28:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : subject : date
 : message-id : content-type : content-id : content-transfer-encoding :
 mime-version; s=facebook; bh=CqIf0ttjusF++bOnWUWsuTWw7QtGjX9iBJxhik7jnj8=;
 b=FAVEofnzY7uNbfYwDWaQQ8suIkrRDT+vHB8xcnw4+oRlIqsPPsIjnlGDihM3FM3iMebd
 vfWPqlE6dISxWiEL2EcPToP5HhPDp0gG9isgCZjTLXb/CNOdmO6ruagKe1Rz7/+IFn8C
 Y1lO6y5Y7k3OzKxKidjmLd35N/dhrSaJpJQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1xtjx9nwku-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:28:26 -0700
Received: from PRN-MBX01-4.TheFacebook.com ([169.254.3.151]) by
 PRN-CHUB02.TheFacebook.com ([fe80::5de8:34:5a87:6990%12]) with mapi id
 14.03.0248.002; Wed, 28 Oct 2015 16:28:26 -0700
Thread-Topic: git-fetch pulls already-pulled objects?
Thread-Index: AQHREdhXt4Zi9tm5IkaAubrCKnEpKg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.52.123]
Content-ID: <DECE8CFC126218469A5A7B34A42A2797@fb.com>
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2015-10-29_01:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280431>

T24gYSByZW1vdGUsIEkgaGF2ZSB0d28gR2l0IGNvbW1pdCBvYmplY3RzIHdoaWNoIHBvaW50IHRv
IHRoZSBzYW1lIHRyZWUNCm9iamVjdCAoY3JlYXRlZCB3aXRoIGdpdCBjb21taXQtdHJlZSkuIElm
IEkgZmV0Y2ggb25lIG9mIHRoZSBjb21taXRzLCB0aGUNCmNvbW1pdCBvYmplY3QgKGluY2x1ZGlu
ZyB0aGUgdHJlZSBvYmplY3QpIGlzIGZldGNoZWQuIElmIEkgdGhlbiBmZXRjaCB0aGUNCm90aGVy
IGNvbW1pdCwgdGhlIHRyZWUgb2JqZWN0IChhbmQgaXRzIGRlcGVuZGVuY2llcykgaXMgZmV0Y2hl
ZCAqYWdhaW4qIChJDQp0aGluaykuIEkgZG9uJ3Qgd2F0Y2ggdGhlIHRyZWUgb2JqZWN0IGRvd25s
b2FkZWQgYWdhaW4sIGJlY2F1c2UgaXQgaXMNCmxhcmdlIChtdWx0aS1naWdhYnl0ZSkuIEJlY2F1
c2UgdGhlIHRyZWUgb2JqZWN0IGV4aXN0cyBsb2NhbGx5LCBJIHRoaW5rIGl0DQpzaG91bGQgbm90
IGJlIGRvd25sb2FkZWQuDQoNCklzIHRoaXMgYSBidWcgaW4gR2l0LCBvciBpcyB0aGlzIGJ5IGRl
c2lnbj8gSG93IGNhbiBJIGNvbmZpcm0gdGhhdCB0aGUNCnRyZWUgb2JqZWN0IChhbmQgZGVwZW5k
ZW5jaWVzKSBhcmUgZG93bmxvYWRlZCB0d2ljZT8gSXMgdGhlcmUgYXJlIG1vcmUNCmNvbXBsaWNh
dGVkIGdpdC1mZXRjaCAob3Igc2ltaWxhcikgY29tbWFuZCBJIGNhbiBleGVjdXRlIHRvIG5vdCBk
b3dubG9hZA0KdGhlIGFscmVhZHktZG93bmxvYWRlZCB0cmVlIG9iamVjdHM/IChJIGhhdmUgdGhl
IGhhc2ggb2YgdGhlIHRyZWUgb2JqZWN0DQp3aGljaCB3b3VsZCBiZSBwb3RlbnRpYWxseSByZS1k
b3dubG9hZGVkLCBpZiB0aGF0IGhlbHBzLikNCg0KU2VxdWVuY2Ugb2YgY29tbWFuZHMgdG8gcmVw
cm9kdWNlOg0KDQojIFJlcGxhY2UgdGhpcyB3aXRoIHRoZSBVUkwgdG8gYW4gZW1wdHkgR2l0IHJl
cG9zaXRvcnkuDQpyZW1vdGU9c3NoOi8vZm9vL2Jhci5naXQNCg0KIyBDcmVhdGUgc29tZSByYW5k
b20gZGF0YSB0byBleGFnZ2VyYXRlIGdpdC1mZXRjaCB0aW1lcy4NCiMgSWYgeW91IGhhdmUgYSBz
bG93IHJlbW90ZSwgcmVkdWNlICdjb3VudCcuDQpta2RpciBtaW5pbWFsDQpjZCBtaW5pbWFsDQpk
ZCBpZj0vZGV2L3VyYW5kb20gb2Y9cmFuZG9tIGJzPTY1NTM2IGNvdW50PTQwOTYNCg0KIyBDcmVh
dGUgb3VyIHR3byBjb21taXRzIChtYXN0ZXIgYW5kIG1hc3RlcjIpLg0KZ2l0IGluaXQNCmdpdCBh
ZGQgcmFuZG9tDQpnaXQgY29tbWl0IC1tICdSYW5kb20gZGF0YSAoY29tbWl0IDEpJw0KZ2l0IGJy
YW5jaCBtYXN0ZXIyIFwNCiAgIiQoZWNobyAnUmFuZG9tIGRhdGEgKGNvbW1pdCAyKScgXA0KICAg
IHwgZ2l0IGNvbW1pdC10cmVlICdIRUFEXnt0cmVlfScpIg0KDQojIFB1c2ggb3VyIGNvbW1pdHMu
IEV4cGVjdGVkIHRvIHRha2Ugc29tZSB0aW1lLg0KZ2l0IHJlbW90ZSBhZGQgb3JpZ2luICIke3Jl
bW90ZX0iDQpnaXQgcHVzaCBvcmlnaW4gXA0KICBtYXN0ZXI6cmVmcy9oZWFkcy9tYXN0ZXIgXA0K
ICBtYXN0ZXIyOnJlZnMvaGVhZHMvbWFzdGVyMg0KDQojIENsb25lIG1hc3Rlci4gRXhwZWN0ZWQg
dG8gdGFrZSBzb21lIHRpbWUuDQpjZCAuLg0KbWtkaXIgbWluaW1hbC1jbG9uZQ0KZ2l0IGNsb25l
IC0tc2luZ2xlLWJyYW5jaCAtLWJyYW5jaCBtYXN0ZXIgIiR7cmVtb3RlfSINCg0KIyBGZXRjaCBt
YXN0ZXIyLiBTaG91bGQgYmUgbmVhcmx5IGluc3RhbnQsIGJ1dCB0YWtlcyBzb21lDQojIHRpbWUu
IFNlZW1zIHRvIGJlIGRvd25sb2FkIGV2ZXJ5dGhpbmcgYWdhaW4uDQpjZCBtaW5pbWFsLWNsb25l
DQpnaXQgZmV0Y2ggb3JpZ2luIG1hc3RlcjINCg0KIyBUcnkgYWdhaW4uIGdpdC1mZXRjaCB0YWtl
cyBhIHdoaWxlLCBidXQgc2hvdWxkbid0Lg0Kcm0gLWYgLmdpdC9GRVRDSF9IRUFEDQpnaXQgZ2Mg
LS1wcnVuZT1hbGwNCmdpdCBmZXRjaCBvcmlnaW4gbWFzdGVyMg0KDQpJbmZvIGFib3V0IG15IHN5
c3RlbToNCg0KDQpMb2NhbCAocHVzaGVyKToNCk9TOiBPUyBYIDEwLjEwLjUNCmdpdDogZ2l0IHZl
cnNpb24gMi4wLjENCnNzaDogT3BlblNTSF82LjJwMiwgT1NTTFNoaW0gMC45LjhyIDggRGVjIDIw
MTENCg0KDQpSZW1vdGUgKHNlcnZlcik6DQpPUzogTGludXggNC4wLjkgKENlbnRPUyA2KQ0KZ2l0
OiBnaXQgdmVyc2lvbiAyLjQuNg0Kc3NoZDogT3BlblNTSF82LjdwMS1ocG4xNHY1LCBPcGVuU1NM
IDEuMC4xZS1maXBzIDExIEZlYiAyMDEzDQoNCg==

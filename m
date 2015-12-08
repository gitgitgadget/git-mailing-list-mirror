From: Daniel Koverman <dkoverman@predictiveTechnologies.com>
Subject: RE: Why does send-pack call pack-objects for all remote refs?
Date: Tue, 8 Dec 2015 17:34:43 +0000
Message-ID: <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
 <20151207225714.GA3785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 19:01:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6MZg-000554-35
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 19:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbbLHSBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 13:01:12 -0500
Received: from barracuda10.predictivetechnologies.com ([208.254.18.230]:42167
	"EHLO barracuda10.predictivetechnologies.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112AbbLHSBL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2015 13:01:11 -0500
X-Greylist: delayed 1583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2015 13:01:10 EST
Received: from pps.filterd (ProofpointMaster.arlington.predictivetechnologies.com [127.0.0.1])
	by ProofpointMaster.arlington.predictivetechnologies.com (8.15.0.59/8.15.0.59) with SMTP id tB8HXbLe011184;
	Tue, 8 Dec 2015 12:34:44 -0500
Received: from mail.predictivetechnologies.com (cas3u.uunet.arlington.predictivetechnologies.com [192.168.70.16] (may be forged))
	by ProofpointMaster.arlington.predictivetechnologies.com with ESMTP id 1yp37g814v-1
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 08 Dec 2015 12:34:44 -0500
Received: from EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 (192.168.70.16) by EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 (192.168.70.16) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Tue, 8 Dec
 2015 12:34:44 -0500
Received: from EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 ([fe80::5dc4:68de:a3ba:b43c]) by
 EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 ([fe80::5dc4:68de:a3ba:b43c%31]) with mapi id 15.00.1044.021; Tue, 8 Dec 2015
 12:34:44 -0500
Thread-Topic: Why does send-pack call pack-objects for all remote refs?
Thread-Index: AdExMorqL3V8CMb5RwSZLGZxKodLugADc/Z+AAsKvQAAHHq8gA==
In-Reply-To: <20151207225714.GA3785@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.196]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2015-12-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 kscore.is_bulkscore=0
 kscore.compositescore=1 compositescore=0.9 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 kscore.is_spamscore=0 rbsscore=0.9 spamscore=0
 urlsuspectscore=0.9 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1507310000 definitions=main-1512080303
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282169>

WW91ciBpbnRlcnByZXRhdGlvbiBvZiBteSBlbWFpbCB3YXMgY29ycmVjdC4gQXMgeW91IHBpY2tl
ZCB1cCBvbiwgSQ0KaGFkIGEgZnVuZGFtZW50YWwgbWlzdW5kZXJzdGFuZGluZyBvZiB3aGF0IHBh
Y2stb2JqZWN0cyB3YXMgZG9pbmcuDQpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbiwgSSBoYXZl
IGEgbXVjaCBiZXR0ZXIgaWRlYSBvZiB3aGF0IGlzDQpnb2luZyBvbiBub3cuDQoNCkdpdmVuIG15
IHVzZSBwYXR0ZXJuLCBpdCBtYXkgYmUgcmVhc29uYWJsZSBmb3IgbWUgdG8gcGF0Y2ggaW4gYW4N
Cm9wdGlvbiB0byBjb21wdXRlDQoNCiAgICBnaXQgcmV2LWxpc3QgLS1vYmplY3RzICRteV90b3Bp
YyAtLW5vdCAkc3Vic2V0X29mX3JlbW90ZV9yZWZzDQoNCmNhcGl0YWxpemluZyBvbiBteSBrbm93
bGVkZ2Ugb2YgdGhpcyBwYXJ0aWN1bGFyIHJlcG9zaXRvcnkgdG8gY29tZQ0KdXAgd2l0aCBoZXVy
aXN0aWNzIGZvciBwaWNraW5nIGEgcmVhc29uYWJsZSBzdWJzZXQuIFRoaXMgd2lsbA0KY29tZSB3
aXRoIHRoZSByaXNrIG9mIHNvbWV0aW1lcyBwcm9kdWNpbmcgYW4gdW5uZWNlc3NhcmlseSBsYXJn
ZQ0KKHBvdGVudGlhbGx5IGFuIG9ic2NlbmVseSBsYXJnZSkgcGFja2ZpbGUuIFlvdSBoYXZlIHRo
b3JvdWdobHkNCmNvbnZpbmNlZCBtZSB0aGF0IGFuIG9wdGlvbiBsaWtlIHRoYXQgd2lsbCBub3Qg
Z2VuZXJhbGl6ZSBhbmQgd291bGQNCmJlIHVuc3VpdGFibGUgZm9yIG1haW4gbGluZSBnaXQuDQoN
Ckl0IGlzIGFsc28gZ29vZCB0byBrbm93IHRoYXQgMjAwMCByZW1vdGUgcmVmcyBpcyBpbnNhbmUu
IFRoZSBsb3dlcg0KaGFuZ2luZyBmcnVpdCBoZXJlIHNvdW5kcyBsaWtlIHRyaW1taW5nIHRoYXQg
dG8gYSByZWFzb25hYmxlDQpudW1iZXIsIHNvIEknbGwgdHJ5IHRoYXQgYXBwcm9hY2ggZmlyc3Qu
DQoNClRoYW5rcyBhZ2FpbiwgSnVuaW8gYW5kIFBlZmYuDQoNCkRhbmllbA0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVmZiBLaW5nIFttYWlsdG86cGVmZkBwZWZmLm5ldF0g
DQpTZW50OiBNb25kYXksIERlY2VtYmVyIDA3LCAyMDE1IDU6NTcgUE0NClRvOiBEYW5pZWwgS292
ZXJtYW4NCkNjOiBKdW5pbyBDIEhhbWFubzsgZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDog
UmU6IFdoeSBkb2VzIHNlbmQtcGFjayBjYWxsIHBhY2stb2JqZWN0cyBmb3IgYWxsIHJlbW90ZSBy
ZWZzPw0KDQpPbiBNb24sIERlYyAwNywgMjAxNSBhdCAwMjo0MTowMFBNIC0wODAwLCBKdW5pbyBD
IEhhbWFubyB3cm90ZToNCg0KPiBBbHNvIGl0IHdhcyB1bmNsZWFyIGlmIHlvdSBhcmUgd29ya2lu
ZyB3aXRoIGEgc2hhbGxvdyByZXBvc2l0b3J5Lg0KPiBUaGUgcGVyZm9ybWFuY2UgdHJhZGUtb2Zm
IG1hZGUgYmV0d2VlbiB0aGUgcGFja3NpemUgYW5kIHRoZSBjeWNsZXMNCj4gaXMgc29tZXdoYXQg
ZGlmZmVyZW50IGJldHdlZW4gYSBub3JtYWwgYW5kIGEgc2hhbGxvdyByZXBvc2l0b3J5LA0KPiBl
LmcuIDJkYWNmMjZkIChwYWNrLW9iamVjdHM6IHVzZSAtLW9iamVjdHMtZWRnZS1hZ2dyZXNzaXZl
IGZvcg0KPiBzaGFsbG93IHJlcG9zLCAyMDE0LTEyLTI0KSBtaWdodCBiZSBhIGdvb2Qgc3RhcnRp
bmcgcG9pbnQgdG8gdGhpbmsNCj4gYWJvdXQgdGhpcyBpc3N1ZS4NCg0KQWxzbyBub3RlIHRoYXQg
Zm9yIGEgd2hpbGUgdGhlICJhZ2dyZXNzaXZlIiBmb3JtIHdhcyB1c2VkIGV2ZXJ5d2hlcmUuIEkN
CnRoaW5rIHRoYXQgc3RhcnRlZCBpbiBmYmQ0YTcwIChsaXN0LW9iamVjdHM6IG1hcmsgbW9yZSBj
b21taXRzIGFzIGVkZ2VzDQppbiBtYXJrX2VkZ2VzX3VuaW50ZXJlc3RpbmcgLSAyMDEzLTA4LTE2
KSwgYW5kIHdhcyBmaXhlZCBpbiAxNjg0YzFiDQoocmV2LWxpc3Q6IGFkZCBhbiBvcHRpb24gdG8g
bWFyayBmZXdlciBlZGdlcyBhcyB1bmludGVyZXN0aW5nLA0KMjAxNC0xMi0yNCkuDQoNClNvIGl0
IHdhcyBwcmVzZW50IGZyb20gdjEuOC40LjIgdXAgdG8gdjIuMy4wLg0KDQotUGVmZg0K

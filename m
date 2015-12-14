From: Daniel Koverman <dkoverman@predictiveTechnologies.com>
Subject: RE: Why does send-pack call pack-objects for all remote refs?
Date: Mon, 14 Dec 2015 13:47:39 +0000
Message-ID: <d0a39b03e49d41e685cf61398c0d1102@EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
 <20151207225714.GA3785@sigill.intra.peff.net>
 <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <20151210041941.GA4056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Nasser Grainawi <nasser@codeaurora.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 15:05:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Tke-00078G-5o
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 15:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbbLNOFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 09:05:13 -0500
Received: from barracuda10.predictivetechnologies.com ([208.254.18.230]:55890
	"EHLO barracuda10.predictivetechnologies.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568AbbLNOFM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 09:05:12 -0500
X-Greylist: delayed 1046 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2015 09:05:12 EST
Received: from pps.filterd (ProofpointMaster.arlington.predictivetechnologies.com [127.0.0.1])
	by ProofpointMaster.arlington.predictivetechnologies.com (8.15.0.59/8.15.0.59) with SMTP id tBEDihOa006239;
	Mon, 14 Dec 2015 08:47:41 -0500
Received: from mail.predictivetechnologies.com (cas3u.uunet.arlington.predictivetechnologies.com [192.168.70.16] (may be forged))
	by ProofpointMaster.arlington.predictivetechnologies.com with ESMTP id 1yrdgntges-1
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Dec 2015 08:47:41 -0500
Received: from EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com
 (192.168.70.11) by EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 (192.168.70.16) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Mon, 14 Dec
 2015 08:47:39 -0500
Received: from EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com
 ([fe80::9ccf:8b03:3d0:b0a]) by
 EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com
 ([fe80::9ccf:8b03:3d0:b0a%29]) with mapi id 15.00.1044.021; Mon, 14 Dec 2015
 08:47:39 -0500
Thread-Topic: Why does send-pack call pack-objects for all remote refs?
Thread-Index: AdExMorqL3V8CMb5RwSZLGZxKodLugADc/Z+AAsKvQAAHHq8gABTXYwAANF4esA=
In-Reply-To: <20151210041941.GA4056@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.196]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2015-12-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 kscore.is_bulkscore=0
 kscore.compositescore=1 compositescore=0.9 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 kscore.is_spamscore=0 rbsscore=0.9 spamscore=0
 urlsuspectscore=0.9 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1507310007 definitions=main-1512140232
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282356>

PiBZb3UgbWlnaHQgYWxzbyB0cnkgcmVwYWNraW5nIHdpdGggImdpdCByZXBhY2sgLWFkYiIsIHdo
aWNoIHdpbGwNCj4gYnVpbGQgcmVhY2hhYmlsaXR5IGJpdG1hcHMuIFBhY2stb2JqZWN0cyBjYW4g
dXNlIHRoZW0gdG8gY29tcHV0ZQ0KPiB0aGUgc2V0IG9mIHJlcXVpcmVkIG9iamVjdHMgbXVjaCBm
YXN0ZXIuDQoNClJ1bm5pbmcgImdpdCByZXBhY2sgLWFkYiIgY2F1c2VkIG15IHB1c2ggdGltZSB0
byBpbmNlYXNlIGJ5IGFib3V0IDV4Lg0KSSBtYWRlIHNvbWUgZnJlc2ggY2xvbmVzIGFuZCB0cmll
ZCBvdGhlciBvcHRpb25zIHdpdGggcmVwYWNrLCBhbmQNCmNvbnNpc3RlbnRseSBhbnl0aGluZyBJ
IHRyaWVkIHdpdGggLWIgY2F1c2VkIHRoZSBwdXNoIHRpbWUgdG8NCmluY3JlYXNlIGFib3V0IDV4
Lg0KDQpJIGRvbid0IGtub3cgbXVjaCBhYm91dCByZWFjaGFiaWxpdHkgYml0bWFwcywgYnV0IHBl
cmhhcHMgaXQgaXMNCmltcG9ydGFudCB0byBub3RlIHRoYXQgSSB0aW1lZCB0aGUgcHVzaGVzIGFm
dGVyIHJlcGFja2luZyBvbiBHaXQgZm9yDQpXaW5kb3dzLiBNeSBlYXJsaWVyIHRpbWluZ3Mgd2Vy
ZSBkb25lIG9uIGJvdGggTGludXggYW5kIFdpbmRvd3MgYW5kIEkNCmRpZCBub3Qgc2VlIGEgc2ln
bmlmaWNhbnQgZGlmZmVyZW5jZS4NCg0KPiBJdCdzIGRlZmluaXRlbHkgYSBsb3QsIGJ1dCBpdCdz
IG5vdCB1bmhlYXJkIG9mLiBUaGUgZ2l0IHByb2plY3QgaGFzDQo+IG92ZXIgNTAwIHRhZ3MuIFRo
YXQncyBub3QgMjAwMCwgYnV0IHlvdSdyZSB3aXRoaW4gYW4gb3JkZXIgb2YNCj4gbWFnbml0dWRl
Lg0KPg0KPiBJIGhhdmUgc2VlbiByZXBvc2l0b3JpZXMgd2l0aCAyMCwwMDArIHRhZ3MuIEkgY29u
c2lkZXIgdGhhdCBhIGJpdA0KPiBtb3JlIHJpZGljdWxvdXMsIGJ1dCBpdCBkb2VzIHdvcmsgaW4g
cHJhY3RpY2UuDQoNClRoYW5rcyBmb3IgdGhlIGV4dHJhIGNvbnRleHQuIEknbGwga2VlcCB0aGF0
IGluIG1pbmQgd2hpbGUgSSBkZWNpZGUNCmhvdyB0byBhcHByb2FjaCB0aGlzLg0KDQpEYW5pZWwN
Cg==

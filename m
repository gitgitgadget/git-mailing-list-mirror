From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Wed, 18 Feb 2015 16:17:46 +0000
Message-ID: <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 17:17:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO7Jx-0004oc-1S
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 17:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbbBRQRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 11:17:49 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:25301 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbBRQRs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 11:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2176; q=dns/txt; s=iport;
  t=1424276269; x=1425485869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DfuU5BndjVxf9Us0HZCcoGWyQMp3ZizWsLmxY1/ekzk=;
  b=ls//bfmRTLQiXXre49+YgO9Y10JZjxGtDCp/2qowsYZS73CNcHwMLe11
   mmaPos1SFjQs/eu/SWV00Mhjn0F5zwOdU9aTlvkam5rWQ85bmZt3BHBQ0
   YbIWZbzt9K5tPtTe+9fPdopvT52NsyMO9ScZ2uvAcCDsnC3W8efb+beyY
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0BkBQDnueRU/5NdJa1bgwZSWgSDBL9WhW8CHIECQwEBAQEBAXyEDQEBBCMRRRACAQgYAgImAgICMBUQAgQOBYgvDbpRmCoBAQEBAQEBAQEBAQEBAQEBAQEBAQETBIEhiW6EOzMHgmgugRQFj0ODWYVjgRmDD4Y+hG6DPiKCAhyBUG8FgT9/AQEB
X-IronPort-AV: E=Sophos;i="5.09,602,1418083200"; 
   d="scan'208";a="397163150"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-5.cisco.com with ESMTP; 18 Feb 2015 16:17:48 +0000
Received: from xhc-aln-x05.cisco.com (xhc-aln-x05.cisco.com [173.36.12.79])
	by rcdn-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id t1IGHkBi028336
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 18 Feb 2015 16:17:47 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.147]) by
 xhc-aln-x05.cisco.com ([173.36.12.79]) with mapi id 14.03.0195.001; Wed, 18
 Feb 2015 10:17:46 -0600
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQSwqcFAV48lOUvEGHDNPe7JHDHZz2+1uA
In-Reply-To: <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.100.213.245]
Content-ID: <6A0754146CEB1F4A90BAE3AF7BAE0E63@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264027>

T24gRmViIDE3LCAyMDE1LCBhdCA2OjM2IFBNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2Jv
eC5jb20+IHdyb3RlOg0KPiANCj4gIkRhbiBMYW5naWxsZSAoZGFsYW5naWwpIiA8ZGFsYW5naWxA
Y2lzY28uY29tPiB3cml0ZXM6DQo+IA0KPj4+IE9uIEphbiAyMCwgMjAxNSwgYXQgNzoyMiBQTSwg
SnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToNCj4+PiANCj4+PiAiRGFu
IExhbmdpbGxlIChkYWxhbmdpbCkiIDxkYWxhbmdpbEBjaXNjby5jb20+IHdyaXRlczoNCj4+PiAN
Cj4+Pj4gSSBkaWQgbm90IHRlc3QgdGhpcyBwYXRjaC4gIElzIHRoYXQgaG9sZGluZyB1cCBhIGNv
bW1pdD8NCj4+PiANCj4+PiBJIGFtIGhvcGluZyB0aGF0IHlvdSByZWJ1aWx0IHRoZSBHaXQgeW91
IHVzZSB3aXRoIHRoaXMgcGF0Y2ggYnkgdGhlDQo+Pj4gdGltZSB5b3Ugd3JvdGUgdGhlIG1lc3Nh
Z2UgSSBhbSByZXNwb25kaW5nIHRvIGFuZCBoYXZlIGJlZW4gdXNpbmcgaXQNCj4+PiBmb3IgeW91
ciBkYWlseSBHaXQgbmVlZHMgOy0pDQo+Pj4gDQo+Pj4gSSBiZWxpZXZlIGl0IGlzIHF1ZXVlZCBv
biB0aGUgJ25leHQnIGJyYW5jaCBzbyB0aGF0IG90aGVycyBsaWtlIHlvdQ0KPj4+IHdobyBuZWVk
IHRoZSBjaGFuZ2UgY2FuIHZlcmlmeSB0aGUgaW1wcm92ZW1lbnRzLCBhbmQgb3RoZXJzIHVubGlr
ZQ0KPj4+IHlvdSB3aG8gZG8gbm90IG5lZWQgdGhlIGNoYW5nZSBjYW4gbWFrZSBzdXJlIHRoZSBj
aGFuZ2UgZG9lcyBub3QNCj4+PiBjYXVzZSB1bmludGVuZGVkIGNvbnNlcXVlbmNlcy4NCj4+IA0K
Pj4gSXMgdGhpcyB0aGUgcGF0Y2ggaW4gcXVlc3Rpb24/DQo+PiANCj4+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9naXQvZ2l0L2NvbW1pdC80ZGJlNjY0NjRiNGZkNjk1YzU5ODljYzI3MmZhMGVkZDY0NzUw
MzdjDQo+PiANCj4+IEkgYXNrIGJlY2F1c2UgcHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIHBhdGNo
IGFjdGVkIGFnYWluc3QgaHR0cC5oIGFzDQo+PiB3ZWxsIGFuZCBteSBmYWlsdXJlIHdpdGggaXQu
DQo+PiANCj4+IENvdWxkIEkgZXhwZWN0IHRoYXQgcGF0Y2ggd29yayBhZ2FpbnN0IDIuMy4wPw0K
Pj4gDQo+PiBJdCBhcHBsaWVzIGNsZWFubHksIGNvbXBpbGVzLCBidXQgY29yZXMgd2hlbiBJIHRy
eSBhIOKAmGdpdCBjbG9uZeKAmS4NCj4+IFVubWF0Y2hlZCAyLjMuMCBzdWNjZWVkcy4NCj4gDQo+
IEl0IGFscmVhZHkgaXMgaW4gJ21hc3RlcicsIHNvIHBsZWFzZSBob2xsZXIgaWYgdGhpbmdzIGJy
ZWFrIHdpdGgNCj4gdGhhdCB2ZXJzaW9uLg0KDQoNCkkganVzdCBidWlsdCBmcm9tIOKAmG1hc3Rl
cuKAmSwgb24gRnJlZUJTRCA5LjM6DQoNCmNkIH4vc3JjDQpnaXQgY2xvbmUgaHR0cHM6Ly9naXRo
dWIuY29tL2dpdC9naXQuZ2l0DQpjZCBnaXQNCmdtYWtlDQoNClRoZW4gdHJpZWQgfi9zcmMvZ2l0
L2dpdCBjbG9uZSBodHRwczovL09VUl9SRVBPDQoNCiBJdCBjb3JlcyB0b28sIGFuZCBJIHNlZTog
Z2l0LXJlbW90ZS1odHRwcy5jb3JlDQoNCuKAlCANCkRhbiBMYW5naWxsZQ0KSW5mcmFzdHJ1Y3R1
cmUgJiBPcGVyYXRpb25zDQpUYWxvcyBHcm91cA0KU291cmNlZmlyZSwgSW5jLg0KDQo=

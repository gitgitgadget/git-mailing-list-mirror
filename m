From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Wed, 25 Feb 2015 20:59:19 +0000
Message-ID: <3E5DD2BE-1E44-4D0A-89A1-627A1239C72A@cisco.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
 <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
 <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 21:59:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQj3I-0001xo-6N
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 21:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbbBYU7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 15:59:24 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:27229 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbbBYU7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 15:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2390; q=dns/txt; s=iport;
  t=1424897964; x=1426107564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mGYnSmPgetadR4/z3GW1H4tJXalqPjDwrqTkpOWeRgI=;
  b=X/gu1UG2O9+zgE2+m0bjZv/v8J+wmS+eaAxY6nCogSOgyQ9U53giQwi2
   PaxTipfgbRgQGGhod0+BV1FUXlddH+xoKpzNsYsxjzoq8jCRUiA7pZsp2
   VkgWIQ1PBUfvlYDEiSoNxg/UJfav4uGvcxIN9PWxkYm2C5nIOOt540paL
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0AlBgC0Nu5U/49dJa1bgwJSWgSDBboohXKFcAIcgQ1DAQEBAQEBfIQPAQEBAwEjEUUFCwIBCBgCAhQSAgICMBUQAgQOBYgnCA28aJkqAQEBAQEBAQEBAQEBAQEBAQEBAQEBEwSBIYlyhCkSMwcYglAvgRQFjWmBc4NghWWTPiKDbm+BRH8BAQE
X-IronPort-AV: E=Sophos;i="5.09,647,1418083200"; 
   d="scan'208";a="399113156"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-5.cisco.com with ESMTP; 25 Feb 2015 20:59:23 +0000
Received: from xhc-rcd-x04.cisco.com (xhc-rcd-x04.cisco.com [173.37.183.78])
	by rcdn-core-7.cisco.com (8.14.5/8.14.5) with ESMTP id t1PKxLhL031357
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 25 Feb 2015 20:59:21 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.147]) by
 xhc-rcd-x04.cisco.com ([173.37.183.78]) with mapi id 14.03.0195.001; Wed, 25
 Feb 2015 14:59:21 -0600
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQSwqcFAV48lOUvEGHDNPe7JHDHZz2+1uAgAHaeICAB+NbAIABkSyA
In-Reply-To: <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.100.213.158]
Content-ID: <7F5A9E62BABD4F40ACB8DC72D1DF9F52@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264414>

PiBPbiBGZWIgMjQsIDIwMTUsIGF0IDQ6MDMgUE0sIERhbiBMYW5naWxsZSAoZGFsYW5naWwpIDxk
YWxhbmdpbEBjaXNjby5jb20+IHdyb3RlOg0KPiANCj4+IE9uIEZlYiAxOSwgMjAxNSwgYXQgMzoz
NSBQTSwgYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gd3Jv
dGU6DQo+PiANCj4+IE9uIFdlZCwgRmViIDE4LCAyMDE1IGF0IDA0OjE3OjQ2UE0gKzAwMDAsIERh
biBMYW5naWxsZSAoZGFsYW5naWwpIHdyb3RlOg0KPj4+IEkganVzdCBidWlsdCBmcm9tIOKAmG1h
c3RlcuKAmSwgb24gRnJlZUJTRCA5LjM6DQo+Pj4gDQo+Pj4gY2Qgfi9zcmMNCj4+PiBnaXQgY2xv
bmUgaHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQuZ2l0DQo+Pj4gY2QgZ2l0DQo+Pj4gZ21ha2UN
Cj4+PiANCj4+PiBUaGVuIHRyaWVkIH4vc3JjL2dpdC9naXQgY2xvbmUgaHR0cHM6Ly9PVVJfUkVQ
Tw0KPj4+IA0KPj4+IEl0IGNvcmVzIHRvbywgYW5kIEkgc2VlOiBnaXQtcmVtb3RlLWh0dHBzLmNv
cmUNCj4+IA0KPj4gQ2FuIHlvdSBjb21waWxlIHdpdGggZGVidWdnaW5nIHN5bWJvbHMgYW5kIHBy
b3ZpZGUgYSBiYWNrdHJhY2U/ICBJJ20gbm90IA0KPj4gc2VlaW5nIGFueSBzdWNoIGJlaGF2aW9y
IG9uIG15IGVuZCwgYW5kIEknbSBub3Qgc3VyZSB3aGV0aGVyIGl0J3MgbXkgDQo+PiBwYXRjaCBv
ciBzb21ldGhpbmcgZWxzZSB0aGF0IG1pZ2h0IGJlIHByZXNlbnQgaW4gbWFzdGVyLg0KPiANCj4g
VGhlIHByb2JsZW0gb3JpZ2luYWxseSBvY2N1cnJlZCB1bmRlciBWTXdhcmUgRnVzaW9uIGFuZCBJ
4oCZbSB1bmFibGUgdG8gZ2V0IGEgYmFja3RyYWNlIGZyb20gaXQuDQo+IEkgc3VzcGVjdCBtZW1v
cnkgY29uc3RyYWludHMgYXJlIGEgZmFjdG9yLiAgVGhlcmXigJlzIG9ubHkgNUdCIFJBTSBhdmFp
bGFibGUgdG8gdGhpcyBWTS4NCj4gDQo+IEkgaGF2ZSB0cmllZCBpbiBhbm90aGVyIFZNIGFuZCB0
aGF0IHN1Y2NlZWRzLiAgQWxsIGdvb2QgdGhlcmUuIEl0IGhhcyA0MEdCIFJBTS4NCj4gDQo+IEkg
YW0gZ29pbmcgdG8gdHJ5IHRoaXMgb24gYSB0aGlyZCBzeXN0ZW0uIEF0IHByZXNlbnQsIHdl4oCZ
cmUganVzdCA1MC81MCBvbiBzdWNjZXNzLg0KDQoNCldlIGhhdmUgbWFkZSBwcm9ncmVzcyBJIHRo
aW5rLg0KDQpXaXRoIHN0b2NrIGdpdDoNCg0KdGw7ZHI6IDEgLSB3aXRoIGEgdGlja2V0LCB5b3Ug
Z2V0IHByb21wdGVkLCBidXQgaGl0dGluZyBFTlRFUiBzdWNjZWVkcy4NCiAgICAgICAyIC0gd2l0
aG91dCBhIHRpY2tldCwgbm90aGluZyB3b3Jrcw0KDQoNCldpdGggcGF0Y2hlZCBnaXQ6DQoNCnRs
O2RyOiAxIC0gd2l0aCBhIHRpY2tldCwgICAgZW50ZXJpbmcgY3JlZGVudGlhbHMsIFNVQ0NFRURT
OyBqdXN0IGhpdCBlbnRlciwgZmFpbHVyZQ0KICAgICAgIDIgLSB3aXRob3V0IGEgdGlja2V0LCBl
bnRlcmluZyBjcmVkZW50aWFscywgU1VDQ0VFRFMNCg0KSGVyZSBpcyBteSB0ZXN0LCB3aXRoIGEg
dmFsaWQga2VyYmVyb3MgdGlja2V0Og0KDQokIGdpdCBjbG9uZSBodHRwczovL2dpdC5leGFtcGxl
LmNvbS9naXQvY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVyDQpDbG9uaW5nIGludG8gJ2NsYW1hdi1i
eXRlY29kZS1jb21waWxlcicuLi4NClVzZXJuYW1lIGZvciAnaHR0cHM6Ly9naXQuZXhhbXBsZS5j
b20nOiANClBhc3N3b3JkIGZvciAnaHR0cHM6Ly9naXQuZXhhbXBsZS5jb20nOiANCl5DbW90ZTog
Q291bnRpbmcgb2JqZWN0czogMjI0NTQ2ICAgDQokDQoNCg==

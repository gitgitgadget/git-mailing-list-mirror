From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 6 Jan 2015 15:41:20 +0000
Message-ID: <531A1350-22B9-4B64-BB8E-C627C545F4DA@cisco.com>
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
X-From: git-owner@vger.kernel.org Tue Jan 06 16:43:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8WG7-0003J6-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 16:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbbAFPlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 10:41:23 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:45624 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbAFPlW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 10:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1380; q=dns/txt; s=iport;
  t=1420558882; x=1421768482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=psDgm6XtUfZRJCBnSK7J4lmreOC399zqyqsWgZnhL4c=;
  b=bRyiOI8IkkaCMKTMLZYaO+HFVc9FMb3/EVq67DwW8QwGW7Rb3dRVkFMj
   6jDuFWjcM1hnk0ZRiU17po6nnwYRGrSXOdbUEmz1sgHKWU51VaO7kCvGY
   omDLAHUzi/3sDd4RAZSvMIudwRTE5lIVkefGt3J0I5khI+mm/f6AaA2PO
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArQFADEBrFStJA2H/2dsb2JhbABcgwZSWASDAckyAhxyFgEBAQEBfYQMAQEBAwEjEUUFCwIBCBgCAiYCAgIwFRACBA4FiCQIrgKUBAEBAQEBAQEBAQEBAQEBAQEBAQEBAReBIY4kMweCaC6BEwEEjiCIdZFZIoNub4FFfgEBAQ
X-IronPort-AV: E=Sophos;i="5.07,708,1413244800"; 
   d="scan'208";a="110752666"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-5.cisco.com with ESMTP; 06 Jan 2015 15:41:21 +0000
Received: from xhc-aln-x06.cisco.com (xhc-aln-x06.cisco.com [173.36.12.80])
	by alln-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id t06FfLxs025323
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Jan 2015 15:41:21 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.219]) by
 xhc-aln-x06.cisco.com ([173.36.12.80]) with mapi id 14.03.0195.001; Tue, 6
 Jan 2015 09:41:21 -0600
Thread-Topic: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQJf0bER2Pnky56Uqguh0whTd+7JyydFEAgAApzYCAAQYrgIAAAsAA
In-Reply-To: <3FBC0B0E-BB54-4BD5-AE7D-C82BA9FBA1C1@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.241.248]
Content-ID: <2EF40EBA0FDA924C8487B4BF0DCA89C6@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262071>

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
ZW1vdGUtY3VybC5jLg0KDQpOT1RFOiBJIG5vdyByZWFsaXplIHRoZXNlIHByb2JsZW1zIGFyZSBj
YXVzZWQgYnkgdGFicyBiZWluZyBjb252ZXJ0ZWQgdG8gc3BhY2VzIHdoZW4gZG93bmxvYWRpbmcg
dGhlIHBhdGNoLiAgSeKAmW0gZ29pbmcgdG8gdGVzdCBhZ2Fpbi4=

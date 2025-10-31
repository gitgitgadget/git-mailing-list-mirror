Received: from mail02.ukr.de (mail02.ukr.de [193.175.194.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A9330D42
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906533; cv=none; b=p5jWFbuzsUN/udJi4yXhzeQSmSFX18Zh9ZjDqNbLejheIkJ0M77Xlqm9jmH/yizBGoy4nBQq5eR3HLbK2j6UPNuHWZgaaiSzk9lyshh00LT0ng05ucj3KxNglHvZrVEpGH0cP/BMZcBdfv0PC9jlcukSvcz8lUonGH5bP6dCQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906533; c=relaxed/simple;
	bh=sAaXLRqFsdg+IBk98vPXcqCqBsz/od+ekim1iP91jI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O0qnKOCgo3piFTQg32lZoExzeIGwYFeVG/MuT040zer96gWgPYnLsN9IlBkDWWlAJJld5d2qKyI19Vtgtgts/4aiSWidJ1CPPGyWGQA6HciSF+w5u5UOUCeTPlvTBSadumMpoqi1+l8ZQ822HnUvDhvu1Xc0OYzAP5HJ1rCGIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: YMK/+rf8QIK9Ekt2xon1NQ==
X-CSE-MsgGUID: 2oRDXGO7S3+dYJhdYQle0w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="2192114"
X-IronPort-AV: E=Sophos;i="6.19,269,1754949600"; 
   d="scan'208";a="2192114"
Received: from unknown (HELO ukr-excmb08.ukr.local) ([172.24.2.108])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:28:48 +0100
Received: from ukr-excmb07.ukr.local (172.24.2.107) by ukr-excmb08.ukr.local
 (172.24.2.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 31 Oct
 2025 11:28:47 +0100
Received: from ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac]) by
 ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac%8]) with mapi id
 15.02.2562.029; Fri, 31 Oct 2025 11:28:47 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Phillip Wood
	<phillip.wood@dunelm.org.uk>
Subject: RE: [EXT] [PATCH v3 6/6] add-patch: reset "permitted" at loop start
Thread-Topic: [EXT] [PATCH v3 6/6] add-patch: reset "permitted" at loop start
Thread-Index: AQHcNuYTf6uLVgbyjUKRVfUaCOh9vrTcM1cA
Date: Fri, 31 Oct 2025 10:28:47 +0000
Message-ID: <77991a11c53f40b8b0a050a4d081809a@ukr.de>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
 <ed73a585-5074-4e36-9f41-228909513237@web.de>
In-Reply-To: <ed73a585-5074-4e36-9f41-228909513237@web.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: B7C0536985A8803C942E89B57D0EE8F8802E2B2B9B6EFB0F5E6C070901FC44F42000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SnVzdCBhIGNvbW1lbnQgb2YgcGVyc29uYWwgdGFzdGU6IEkgdGhpbmsgZGVjbGFyaW5nIGFuIGFu
b255bW91cyBlbnVtIGluc2lkZSBhIGxvb3AgaXMganVzdCBiYWQgc3R5bGUuIEkgdGhpbmsgdGhh
dCBnY2MgaXMgc21hcnQgZW5vdWdoIHRvIG9wdGltaXplIGlmICJwZXJtaXR0ZWQiIGlzIGRlY2xh
cmVkIG91dHNpZGUgdGhlIGxvb3AsIG9yIG1ha2UgdGhlICJwZXJtaXR0ZWQiIHVzZSBhIHR5cGVk
ZWYgZm9yIGEgIm5hbWVkIGVudW0iIChkZWNsYXJlZCBvdXRzaWRlIHRoZSBsb29wIHdoaWxlIHRo
ZSB2YXJpYWJsZSBtYXkgYmUgaW5zaWRlIHRoZSBsb29wKS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBSZW7DqSBTY2hhcmZlIDxsLnMuckB3ZWIuZGU+DQo+IFNlbnQ6
IE1vbmRheSwgT2N0b2JlciA2LCAyMDI1IDc6MjQgUE0NCj4gVG86IGdpdEB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IFdpbmRsLCBVbHJpY2ggPHUud2luZGxAdWtyLmRlPjsgSnVuaW8gQyBIYW1hbm8g
PGdpdHN0ZXJAcG9ib3guY29tPjsNCj4gUGhpbGxpcCBXb29kIDxwaGlsbGlwLndvb2RAZHVuZWxt
Lm9yZy51az4NCj4gU3ViamVjdDogW0VYVF0gW1BBVENIIHYzIDYvNl0gYWRkLXBhdGNoOiByZXNl
dCAicGVybWl0dGVkIiBhdCBsb29wIHN0YXJ0DQo+IA0KWy4uLl0gDQo+ICAJZm9yICg7Oykgew0K
PiArCQllbnVtIHsNCj4gKwkJCUFMTE9XX0dPVE9fUFJFVklPVVNfSFVOSyA9IDEgPDwgMCwNCj4g
KwkJCUFMTE9XX0dPVE9fUFJFVklPVVNfVU5ERUNJREVEX0hVTksgPSAxIDw8DQo+IDEsDQo+ICsJ
CQlBTExPV19HT1RPX05FWFRfSFVOSyA9IDEgPDwgMiwNCj4gKwkJCUFMTE9XX0dPVE9fTkVYVF9V
TkRFQ0lERURfSFVOSyA9IDEgPDwgMywNCj4gKwkJCUFMTE9XX1NFQVJDSF9BTkRfR09UTyA9IDEg
PDwgNCwNCj4gKwkJCUFMTE9XX1NQTElUID0gMSA8PCA1LA0KPiArCQkJQUxMT1dfRURJVCA9IDEg
PDwgNg0KPiArCQl9IHBlcm1pdHRlZCA9IDA7DQo+ICsNCj4gIAkJaWYgKGh1bmtfaW5kZXggPj0g
ZmlsZV9kaWZmLT5odW5rX25yKQ0KPiAgCQkJaHVua19pbmRleCA9IDA7DQo+ICAJCWh1bmsgPSBm
aWxlX2RpZmYtPmh1bmtfbnINCg0K

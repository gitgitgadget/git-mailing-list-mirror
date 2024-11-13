Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6D22611
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525867; cv=none; b=IzEptSC+5dm0r0Tax8TPHmqON28Lf/7nMnx2sxfzbMogvlOFxReqSSg9Ze3oTsE0qhvxAOXYWHaC1Ygd5e7vYqaYvs7JNUx9E6OwGhWP9SWKzy4dXxSSG1QcFPWgA4fMyaKNenfuCFkA8TUeT13aU0Ea7GrwB/q/KPbsyQqWFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525867; c=relaxed/simple;
	bh=bcMlSCsxSCrdKE0OSvigTY24zh3p1g7ARbePUZVQ0wA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oafdtMo6sEwzI1YnTnDdC6P1aRXY77eiGkly6zxhyze3CFiYSdYo2dBtE2/TDBeWqoE3NSa0lXIdrfqmrSpod4Sqr6BegemUaTmBdkvO+bm/RTxykYqGp4otUVeqH2GEnt9fs5MTMYdbCI25T5xbRIIO8xRYe9Mm7ht+6EUe2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name; spf=none smtp.mailfrom=mayhew.name; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iV69rUZf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mayhew.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mayhew.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iV69rUZf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90E2A1140201;
	Wed, 13 Nov 2024 14:24:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 14:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731525864; x=1731612264; bh=bcMlSCsxSCrdKE0OSvigTY24zh3p1g7ARbe
	PUZVQ0wA=; b=iV69rUZfEWD50piHD8biQYtLlDXgf+owngZB4FZdJX8Q3lKIJmk
	g+7iwzjfraDNP5TUM8gLLAxuJeG/qq1g8zxAGjB1Ybu3UrCvA3Ix29KY4ridlfTK
	Q3kuc4WaFQyYdQK20SNNGc6SDGNAD0UAGSzVy9a5Jd90VYVP5QR16h1y72xANLj9
	m0tWKUIxqoZu5kZb5t3S1m1749d4q6G6DXVyKh0I1Zs+zlIQhdWuLGoLm7jas/0w
	nvOZU90e4oJu1lMKV6VAzOtYg6MKeRGnGaOh6grqMAXX/ckxeWh0v+w3uli6gAzY
	VD9cj3/v8Lhsf4dkSNZDlsEmf/gy02zR21Q==
X-ME-Sender: <xms:6Pw0Zy6Hny8dktjL9_lVxVo7H0RcK4zdN0M_gC-RWhgeOQcB1LEWsw>
    <xme:6Pw0Z77-vWTuqyOiF-EhaP_8OIB1331K-g9gTaqtSMdnj7h9jdtTS59vRtcxOw-0H
    fO6WNOarV-mlhnqgL8>
X-ME-Received: <xmr:6Pw0ZxeDTCqbX_jdZNE8VCoI3OQ1wveBt3EBwwSBLc8C7ItsvDYoWwrA-0O-Ks3xgxRquIxGkOt2GpMD_DV1_FDoC9Lu_gTYegU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgesghdtreertddvjeen
    ucfhrhhomheppfgvihhlucforgihhhgvficuoehnvghilhesmhgrhihhvgifrdhnrghmvg
    eqnecuggftrfgrthhtvghrnhepudefteevleeigeffffetkeeuuddtleelgffgteekfeeh
    fffgvdeutdeuffeivdefnecuffhomhgrihhnpehfshgtkhhosghjvggtthhsrdhmhidpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepnhgvihhlsehmrgihhhgvfidrnhgrmhgvpdhnsggprhgtphhtthhopeegpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvugihvgesghhi
    thhhuhgsrdgtohhm
X-ME-Proxy: <xmx:6Pw0Z_LmcdCfG9Yav2dUUP77fTfCSBZMDOXlyelXKuoEqLzvwE931w>
    <xmx:6Pw0Z2KFWBV1TacTmuWK7T3GFvTTLW_x-AzfkE4T4x0TmO6C9ecI3w>
    <xmx:6Pw0ZwxzxRFv0z6B6qvbVUah67l4ZRPO8XaNGsjkm1uFQZFQwvgWjw>
    <xmx:6Pw0Z6JVHOAxN9F90go-j3uVztoX69Pyb99lCO4HfLcsArZ0w4zbQA>
    <xmx:6Pw0Zy2uTOf6zcFkyKAZ5OQywdQ-tH5RnBLOS4H-lCc1Vs45Os_UvkXn>
Feedback-ID: ibb8947ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 14:24:23 -0500 (EST)
Message-ID: <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
Date: Wed, 13 Nov 2024 12:24:21 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Mayhew <neil@mayhew.name>
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
To: Jeff King <peff@peff.net>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <20240110102338.GA16674@coredump.intra.peff.net>
Content-Language: en-GB
Autocrypt: addr=neil@mayhew.name;
 keydata= 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
In-Reply-To: <20240110102338.GA16674@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iJQD80HroPqF0VAJiYYpIXKr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iJQD80HroPqF0VAJiYYpIXKr
Content-Type: multipart/mixed; boundary="------------lIAW14w0c0xYEaYr8KwAQ7UR";
 protected-headers="v1"
From: Neil Mayhew <neil@mayhew.name>
To: Jeff King <peff@peff.net>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Message-ID: <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <20240110102338.GA16674@coredump.intra.peff.net>
In-Reply-To: <20240110102338.GA16674@coredump.intra.peff.net>

--------------lIAW14w0c0xYEaYr8KwAQ7UR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAgSmFuIDI0IDAzOjIzLCBKZWZmIEtpbmcgd3JvdGU6DQogPiBCeSBtYWtpbmcgaXQg
YW4gZnNjaw0KID4gY2hlY2ssIHRob3VnaCwgYW55IG1pc3Rha2VzIHRoYXQgYXJlIGVtYmVk
ZGVkIGluIGhpc3RvcnkgKGV2ZW4gaWYNCiA+IHRoZXkgYXJlIG5vdyBjb3JyZWN0ZWQpIHdp
bGwgbWFrZSBpdCBhIHBhaW4gdG8gdXNlIHRoZSByZXBvc2l0b3J5DQogPiB3aXRoIHNpdGVz
IHRoYXQgZW5hYmxlIHRyYW5zZmVyLmZzY2tPYmplY3RzLg0KID4NCiA+IE15IGd1dCBmZWVs
aW5nIGlzIHRoYXQgdGhpcyBpcyBwcm9iYWJseSBPSyBpbiBwcmFjdGljZS4gSWYgaXQgZG9l
cw0KID4gY2F1c2UgcGFpbiwgd2UgbWlnaHQgY29uc2lkZXIgbG9vc2VuaW5nIHRoZSBmc2Nr
LmdpdG1vZHVsZXNVcmwNCiA+IHNldmVyaXR5ICh1bmRlciB0aGUgbm90aW9uIGZyb20gYWJv
dmUgdGhhdCBpdCBpcyBubyBsb25nZXIgYQ0KID4gY3JpdGljYWwgc2VjdXJpdHkgY2hlY2sp
LiBCdXQgaWYgaXQgZG9lc24ndCBjYXVzZSByZWFsLXdvcmxkIHBhaW4sDQogPiBiZWluZyBw
aWNraWVyIGlzIHByb2JhYmx5IGJldHRlciAoaXQgbWF5IHNhdmUgdXMgZnJvbSBhDQogPiB2
dWxuZXJhYmlsaXR5IGRvd24gdGhlIHJvYWQpLg0KDQpUaGlzIHBhaW4gaXMgaGFwcGVuaW5n
IGluIA0KaHR0cHM6Ly9naXRodWIuY29tL0ludGVyc2VjdE1CTy9jYXJkYW5vLWxlZGdlci5n
aXQsIGEgbGFyZ2Ugb3Blbi1zb3VyY2UgDQpyZXBvLiBUaGVyZSB3YXMgYSBiYWQgZWRpdCB0
byAuZ2l0bW9kdWxlcyB3aGljaCB3YXMgaW1tZWRpYXRlbHkgDQpjb3JyZWN0ZWQgYnkgYW5v
dGhlciBjb21taXQuIEhvd2V2ZXIsIHRoZSBiYWQgY29tbWl0IGlzIHN0aWxsIGluIHRoZSAN
Cmhpc3RvcnkuIEl0IGhhcHBlbmVkIDYgeWVhcnMgYWdvLCBzbyB0aGVyZSdzIG5vIHBvc3Np
YmlsaXR5IG9mIHVzIA0KY2hhbmdpbmcgdGhlIGhpc3RvcnkuIFdlIGp1c3Qgc3BlbnQgdGlt
ZSBpbnZlc3RpZ2F0aW5nIGEgYnVnIHJlcG9ydCBmcm9tIA0Kc29tZW9uZSB3aG8gd2FzIHVu
YWJsZSB0byBjbG9uZSB0aGUgcmVwbywgYW5kIGV2ZW50dWFsbHkgd2UgZGlzY292ZXJlZCAN
CnRoYXQgdGhleSBoYWQgdHJhbnNmZXIuZnNja09iamVjdHMgZW5hYmxlZC4gRXZlbiB3aXRo
b3V0IHRoaXMgb3B0aW9uLCANCmhvd2V2ZXIsIHdlIHN0aWxsIHdhbnQgcGVvcGxlIHRvIGJl
IGFibGUgdG8gcnVuIGZzY2sgc3VjY2Vzc2Z1bGx5IG9uIHRoZSANCnJlcG8uDQoNCkl0J3Mg
YXdrd2FyZCB0aGF0IG91ciByZXBvIG5vdyB3b24ndCBwYXNzIGFuIGZzY2sgY2hlY2sgYW5k
IHdlIGhhdmUgbm8gDQp3YXkgdG8gY29ycmVjdCB0aGF0LiBJJ2QgcmVhbGx5IGxpa2Ugbm90
IHRvIGhhdmUgdG8gcHV0IGEgbm90ZSBpbiB0aGUgDQpSRUFETUUgd2FybmluZyBhYm91dCB0
aGlzLg0KDQpJcyB0aGVyZSBhbnkgcG9zc2liaWxpdHkgb2YgImxvb3NlbmluZyB0aGUgZnNj
ay5naXRtb2R1bGVzVXJsIHNldmVyaXR5IiwgDQphcyBKZWZmIHN1Z2dlc3RlZD8NCg0K

--------------lIAW14w0c0xYEaYr8KwAQ7UR--

--------------iJQD80HroPqF0VAJiYYpIXKr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEpcohaHbz7TQGgWVzxoMS3uGGmrMFAmc0/OYFAwAAAAAACgkQxoMS3uGGmrPv
Cg//U49mOC8D9InmlfFGuC13CcxEWx0Il/67LRbwAbV0nNwJqjakRQpbemwfvN93yhD//0AIUqZv
8rSz+20lFoZnqDJoDIwtxLtLpHCttP43bTYUYdg07Gx/ht4kNeJSo1mjs8vYvz/cQCv/z5RGF874
z4Esm33t5miNRvG1MlQxnDwQW8LODOc1GfnT1vTi0TSY2uIHaFdQHCDqRXadDyttbihXUF1/hf9P
3H2oJsV4SnoC0tKq+hSzsu+9Xs5jTLiaMqZM3MiWAx4ZtWzkiZq/1SZh9qR0LvsGkm88kAcQ+5E/
tC2mCVAqlo9q6jVZk1LreQoegiXLx2jAczd9cqCgAH9qbTHHrNkk4HBa+9M/Ss4GhygI0EzuJs+c
NDPSJwqAwvXqEZUe6keArqQSQvTzJOnTN5EXqbklAZn0fRG94OBj36isj1+1oIDwJyoQWHgIIAQJ
9+mgbXxnwlffk9fipyOPBqY+/U9jR1Ft4WJ0hmSQ1Md+QyDhSnEbyRur5j5x3cUTnP35KebUbWnv
g80uL4VAY8oaJH3k1zRpo2stvQJTGssuT/Fz1wBqsVQABc2QZixXNmyzuR9HQb3gzX1E94cxGxab
xrbmFdyERoKANGpkeU6jxuZ0fo7xqYea4AsJse4nDzKZauHSCWYGgAXIxBMkGfzs03vnZuuIGnz2
vOw=
=7ACi
-----END PGP SIGNATURE-----

--------------iJQD80HroPqF0VAJiYYpIXKr--

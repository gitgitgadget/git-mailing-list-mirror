Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1231770B
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734320; cv=none; b=jqjovRTRK/PVNBrEhjp6C3GzeGGyj7qREvaKgsy3EmBiDtWgqRKLfSrrRSQPNE1DmjwGdtZzzTGOmhFkzCybA34ksm/FfnZ2S5X85CV79YHH3BOVnutbLoi9zRqQZQHwr4HmU9ERtnB2/hsETn2zsVUIEPVzbjY0z3yzWc9Hv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734320; c=relaxed/simple;
	bh=qSHAfkmNAzV4Zklxm4i2qno4YYXO6tuoaVnrNpQeeJs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=JL/X8z+ZR2LC52Od8JyxiqLeV2LwYFBw9EZhAl8B9iFxEjpiVipryD6DFafZVswIOQobRlp7Sv6h3tCvZv1E6V8eNaFQeTlrggh6ZGX8IFlY5gQPPtnDZRtqoaQJ939AEYn72QZ6J4xru9b3eyyNmrdWWKzTz+d9UT5IZ1zINK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=UudZVsVt; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="UudZVsVt"
Message-ID: <0fdd4ba0-f2e2-487b-9da0-686645c426e2@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758734316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qSHAfkmNAzV4Zklxm4i2qno4YYXO6tuoaVnrNpQeeJs=;
	b=UudZVsVtHjrdAOs0Op0PT7mcTsU2AK2jmusuE0KWZe26N2A3bipdzDVbBwE1O93wiwy3F9
	Kcge4BxN3liDb3CKPJqSoX7KbuSyJaK28i0ocYG9FN6AsXuenR8NeFMF8FpXNM59kIvgHp
	i4TEThR8PRVj8RJydz+hv91SqfJdwbNqhBbzjqXROnTnEeKfvUoV0+PlSU7u4OQfkTZ0zu
	DJWPNoEBtIDYuySLI2p3vgjKxYqVSABju9TR9Fw+I1xIglwogaMb1+Hndg6ZT5KWGyWaE8
	XDCByOTeMfk7b980+WyGLgDpq5Dc0YRugGC/EWkga5j+TacBwbpAp8k4C9X7gw==
Date: Wed, 24 Sep 2025 13:18:29 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Subject: Re: 0-Based indexes for git log
To: git@vger.kernel.org
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Content-Language: en-US
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
In-Reply-To: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Oye0my02jJ0T1vCb2QqVUiBu"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Oye0my02jJ0T1vCb2QqVUiBu
Content-Type: multipart/mixed; boundary="------------Nglsb84iIqTQxSk6b2NGFkf0";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: git@vger.kernel.org
Message-ID: <0fdd4ba0-f2e2-487b-9da0-686645c426e2@velocifyer.com>
Subject: Re: 0-Based indexes for git log
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
In-Reply-To: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>

--------------Nglsb84iIqTQxSk6b2NGFkf0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

W3Jlc2VuZGluZyBiZWNhdXNlIGkgbWFkZSBhIHR5cG9dDQoNCj4gSW4gZ2l0IGxvZyBpdCB1
c2VzIGEgMS1iYXNlZCBpbmRleCBmb3IgdGhlIGRhdGUgaW5zdGVhZCBvZiBhIDAgYmFzZWQg
DQo+IGluZGV4LiBTbyBpdCBzYXlzICJGcmkgU2VwIDE5IDE0OjIzOjI0IDIwMjUgLTA0MDAi
IHdoZW4gaXQgc2hvdWxkIHNheSANCj4gIkZyaSBTZXAgMTggMTQ6MjM6MjQgMjAyNSAtMDQw
MCIgKG9yICJGcmlkYXkgMjAyNS04LTE4wqAxNDoyMzoyNCANCj4gKC00OjAwLjAwKSLCoCB0
byBnZXQgYSBiZXR0ZXIgZm9ybWF0KQ0KPg0KSSBzdWdnZXN0IGdpdCBhZGRzIGEgY29uZmln
IG9wdGlvbiBmb3IgMC1iYXNlZCBkYXRlIGFuZCBhdXRvbWF0aWNhbGx5IA0KdXNlcyAwLWJh
c2VkIGRhdGUgaWYgdGhlcmUgaXMgYSBmaWxlIGF0IA0KJEhPTUUvLmNvbmZpZy91c2UtMC1i
YXNlZC1pbmRleC1mb3ItZGF0ZSBvciAkVVNFLTAtQkFTRUQtSU5ERVgtRk9SLURBVEUgDQo9
PSB0cnVlDQoNCi0tIA0KR2VvcmdlIHRydWx5LCDwnZWN8J2VlvCdlZ3wnZWg8J2VlPCdlZrw
nZWX8J2VqvCdlZbwnZWjDQpUaGlzIGVtYWlsIGRvZXMgbm90IGNvbnN0aXR1dGUgYSBsZWdh
bGx5IGJpbmRpbmcgY29udHJhY3QNCg==

--------------Nglsb84iIqTQxSk6b2NGFkf0--

--------------Oye0my02jJ0T1vCb2QqVUiBu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNQn5QUDAAAAAAAKCRBjTr+HQMdIvlUJ
AQCJ6cC8Q+JDXY28Dd7dw4KwZV0JSva4srI/CbHsNSVNwQD+O6Rm7R4SkgkPzBC29bPA+JkqFinX
pQnFWcJgHydkDA4=
=fY7R
-----END PGP SIGNATURE-----

--------------Oye0my02jJ0T1vCb2QqVUiBu--

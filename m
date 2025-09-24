Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73618B0A
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721354; cv=none; b=YjPexWvVOjEoMqV0a8CUbFifDRJMBIewgOeAs45K34SPYpZQWCkqQ3OOP/9W+qZc/CKsx1HlvZUvhaAIoNuRYtVNKtGcVnR/0M/IwaN591sPiIf456HjHv/SCqutwpSCVRnm0qs4SBCpFhsNrCX8dT34ya5hcT0ypbmThKTY5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721354; c=relaxed/simple;
	bh=q/XnfY+kK1GUquNIOEiUhldW9ymf4dhrAb1HzpHeTrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv+4x+wJjFWd2a7PxXx1VsBfLzwUV6qb1lpXiiVhP7UOMsY/evn/k29ta6iTUiuV/fD52ikiOCBTATZALlC2dPBQza/ZLRir0KvGTqZmWTpZlI+n/tYukfscHqNM1GJ21loadFKziUTDXLPjMp1mCZULkwrHJkSbGbqQgzySvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=FnpgM51E; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="FnpgM51E"
Message-ID: <55e313f2-8ec3-4f6c-afe9-19d938e3a605@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758721347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q/XnfY+kK1GUquNIOEiUhldW9ymf4dhrAb1HzpHeTrg=;
	b=FnpgM51EAZ/x4S9wbUwU3J/sZAQ/OWm6y1zD5sLoF3Cs95+LVM6uFbK0HxFsNqCrjha15w
	6e1YWXOCrzhmy11+ZesO9gCk/mUAbWsCwZ+rIz0AfW+IuvXHfxka5vwibOucYn1s0+xSpE
	psflEoATY9a4Rs/PLN71BR1Q9SXxAjaJH3nQW/ajVBBLJ7m4zq2u2w2DD3S8RTJ4IMMBTG
	NVo4IZc651i7Wm9Btr0h0rpRG6YiMj784Hz48yzX019iur4m5x7WAgug6zLaf+rSrOlXLE
	u0/db9Xz4pjaWUZ5DWjrNtv8xdrPCz4hCatfGyMK4JK8BHA6HUwamcEJC5vK3A==
Date: Wed, 24 Sep 2025 09:42:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 0-Based indexes for git log
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <20250924052216.GB1173044@coredump.intra.peff.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
In-Reply-To: <20250924052216.GB1173044@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cOkuhBC9PShmipwLfE03d0sM"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cOkuhBC9PShmipwLfE03d0sM
Content-Type: multipart/mixed; boundary="------------OdmXxSrHR0OoPZQEUtIZebBx";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Message-ID: <55e313f2-8ec3-4f6c-afe9-19d938e3a605@velocifyer.com>
Subject: Re: 0-Based indexes for git log
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <20250924052216.GB1173044@coredump.intra.peff.net>
In-Reply-To: <20250924052216.GB1173044@coredump.intra.peff.net>

--------------OdmXxSrHR0OoPZQEUtIZebBx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

W3NlbnQgYWdhaW4gYmVjYXVzZSBpIGRpZG5gdCByZXBseSBhbGwNCj4gQXJlIHlvdSBwcm9w
b3NpbmcgdGhhdCB0aGUgZmlyc3QgZGF5IG9mIFNlcHRlbWJlciBpcyB0aGUgMHRoPyBZb3Ug
bWlnaHQNCj4gYmUgYWJsZSB0byBkbyB0aGF0IHdpdGggbG9jYWxlIHN1cHBvcnQgYW5kIHVz
aW5nIHN0cmZ0aW1lJ3MgJWMgb3B0aW9uLA0KPiBidXQgSSdtIG5vdCBzdXJlIGhvdyBwb3dl
cmZ1bCBsb2NhbGVzIGFyZSAob3IgaG93IG9uZSBldmVuIGRlZmluZXMNCj4gdGhlbSkuDQoN
Ck5vLCBpIGFtIHN1Z2VzdGluZyB0aGF0IGl0IGlzIHN0aWxsIHRoZSAxc3QgYnV0IGl0IGlz
IHNlcHRlbWJlciAwDQoNCi0tIA0KR2VvcmdlIHRydWx5LCDwnZWN8J2VlvCdlZ3wnZWg8J2V
lPCdlZrwnZWX8J2VqvCdlZbwnZWjDQpUaGlzIGVtYWlsIGRvZXMgbm90IGNvbnN0aXR1dGUg
YSBsZWdhbGx5IGJpbmRpbmcgY29udHJhY3QNClJlbWVtYmVyIHRvIHJlcGx5IGFsbCBvbiBt
YWlsaW5nIGxpc3RzICh0aGlzIGlzIGhlcmUgc28gaSBkb24ndCBmb3JnZXQgDQp0byB1c2Ug
cmVwbHkgYWxsKShJZiB5b3UgYXJlIHJlYWRpbmcgdGhpcyBpIGZvcmdvdCB0byByZW1vdmUg
aXQpDQo=

--------------OdmXxSrHR0OoPZQEUtIZebBx--

--------------cOkuhBC9PShmipwLfE03d0sM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNP1PgUDAAAAAAAKCRBjTr+HQMdIvoKS
AP99jrNrHEjNQ+nffuzyf+N5c9Fcfmm4r8rQULD1tEYYDgEAiKvZTcmXTKM8G1bmMQ1Of7BNktSs
5FU7GZZKfkGjygY=
=T/FD
-----END PGP SIGNATURE-----

--------------cOkuhBC9PShmipwLfE03d0sM--

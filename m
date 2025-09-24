Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8CCCA6F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721613; cv=none; b=uU7ZzBSYKxMFTgWXg0eshgJ+7/L+zy4/Ci/PMv6iJJBWZ9hR/gkk8HJW/aJaBzY6EsT/a/xagCa8z0YANquSN+HJugicIVnDZxRt852RSGHeb9hRN4VWLxXPJvr2hRwnjHYZdIddND6Mdsz8VHAf5RAzU4XrjLA5PQYm5rG/8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721613; c=relaxed/simple;
	bh=pgJCG3m7b7Tj1K8j01l/gUgFRg9BPrgOMvjpEbE6HuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aw0piRXB5pAOZS5rW8VWNhKl9dajlTtIICrEtI4K5w0eKuxQB1GWMo2Nh4TdRWYM7oVPHJAolG0TaYGRUVHTOkeFZ+baBAK7/3XxLbNesl4uHUBsq8vwxiKm0lT2bmRMFPswf8KnxrrG6kUPoQH3+49m4OfcEDmzje1Ce8A5Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=QM/C5Kt3; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="QM/C5Kt3"
Message-ID: <27456c8a-25f4-40f2-a791-efd35457d121@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758721609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pgJCG3m7b7Tj1K8j01l/gUgFRg9BPrgOMvjpEbE6HuE=;
	b=QM/C5Kt3Tj9DxPn6F299dY+X8FoSZc7wFZvOISbZKTeV2MtubGLvmP/EP3tolGbCYVAUJs
	mPS8VAX3Wu1YMo7W2JjdQ1Qc1OdOw6WSlQizKTwqCo1NFE7ihRy1DK9JmTCuJX+UODLMfR
	N+LR7M0zGGXCE8qNhMoTAthGLZUn9ztBP7lEc3qnpGTaeYrfOcA/L6fiC+bX9HqWs5cfdJ
	JpWGSaAWV/ytis5uEwQglODIlGI7U6w1aBl3LUjWMHNZC+LquzVAfwVwKqNE197kIi0Igt
	sKJ9y8vEk7segYdJie0/hRV6rtuMvT/t6DqFLGy+f8KQsLiKlx3jeGRFd6MKmg==
Date: Wed, 24 Sep 2025 09:46:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 0-Based indexes for git log
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <2FAD09B7-4776-483E-90F1-31B031DAC2CA@gmail.com>
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
In-Reply-To: <2FAD09B7-4776-483E-90F1-31B031DAC2CA@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nE4UeKlI4kCIxzu697LI2nx9"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nE4UeKlI4kCIxzu697LI2nx9
Content-Type: multipart/mixed; boundary="------------v0N0eDuVUPOnYqZK8WlQumTR";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <27456c8a-25f4-40f2-a791-efd35457d121@velocifyer.com>
Subject: Re: 0-Based indexes for git log
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <2FAD09B7-4776-483E-90F1-31B031DAC2CA@gmail.com>
In-Reply-To: <2FAD09B7-4776-483E-90F1-31B031DAC2CA@gmail.com>

--------------v0N0eDuVUPOnYqZK8WlQumTR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBBcmUgdGhlc2UgZGF0ZSBmb3JtYXRzIGxvY2FsZS1zcGVjaWZpYz8gSW4gYm90aCB0aGUg
VVMgRW5nbGlzaCBhbmQgRnJhbmNlIEZyZW5jaCBsb2NhbGVzIEkgdXNlIGNvbW1vbmx5LCB0
aGUgMTl0aCBvZiBTZXB0ZW1iZXIgaW4gMjAyNSBfaXNfIGEgRnJpZGF5LiBTaG93aW5nIDE4
IHdvdWxkIG9ubHkgYmUgY29uZnVzaW5nLg0KDQpTaG93aW5nIDE5IGNvbmZ1c2VzIG1lIGJl
Y2F1c2UgaSdtIHVzZWQgdG8gMC1iYXNlZCBpbmRleGVzIHdoZXJlIHRoZSANCjE5dGggaXMg
bGFiZWxkIGFzIDE4LiBTaG93aW5nIDE4IHdvdWxkIG5vdCBjdW5mdXNlIG1vc3QgcGVvcGxl
Lg0KDQotLSANCkdlb3JnZSB0cnVseSwg8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/Cd
larwnZWW8J2Vow0KVGhpcyBlbWFpbCBkb2VzIG5vdCBjb25zdGl0dXRlIGEgbGVnYWxseSBi
aW5kaW5nIGNvbnRyYWN0DQpSZW1lbWJlciB0byByZXBseSBhbGwgb24gbWFpbGluZyBsaXN0
cyAodGhpcyBpcyBoZXJlIHNvIGkgZG9uJ3QgZm9yZ2V0IA0KdG8gdXNlIHJlcGx5IGFsbCko
SWYgeW91IGFyZSByZWFkaW5nIHRoaXMgaSBmb3Jnb3QgdG8gcmVtb3ZlIGl0KQ0K

--------------v0N0eDuVUPOnYqZK8WlQumTR--

--------------nE4UeKlI4kCIxzu697LI2nx9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNP2RAUDAAAAAAAKCRBjTr+HQMdIvt8I
AQDZGvR/7TL4n23fQu4Icjk7p/lf7Q8Ukiga54D5d9c2QwEAjMHCF1vTTsfMHZ2fsJXPl7KhCMY2
d0erHCuwbBfkuQM=
=5WpA
-----END PGP SIGNATURE-----

--------------nE4UeKlI4kCIxzu697LI2nx9--

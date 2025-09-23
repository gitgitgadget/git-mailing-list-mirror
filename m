Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A66134CB
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662158; cv=none; b=DbOpAMvakAjyAXtd7WJBWqamQXBinlRZC1cLCgHYZ3z9KIE0RYV+8UL0+e5wGRGsPI0Z+fBFHe95sHyIrUgllwEIrPVg0vKck4uETJpj99Qt7nSP0NMHIfbTIVB5r25lAL5T7mH+sIMh1ywZKvO7HkNvWcmskWxuqRwCHLqY9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662158; c=relaxed/simple;
	bh=huFw1iTCvSy0hKmke1la4iyIflBoTHN4b+AOP5XyiT4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pGmGCRkj2njCYfVNzdfrgio2J9WQaWXuI3Z/A5I/MvM384TrwkJtSXtHXf6yoMkHjgfkIXSQ7ne1EqjYBjDaHCY1W0sdouyIllxP9h3gNfMpoZtTblFIJ5odR0QKt8hUsjSqqabPzzD93aK4yDD6azSXKbZc3T3/EczIxApGfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=TdAsq60s; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="TdAsq60s"
Message-ID: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758662153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=huFw1iTCvSy0hKmke1la4iyIflBoTHN4b+AOP5XyiT4=;
	b=TdAsq60sH8fJY3Ba/g0mtnMUiOd1Fajt8mPJEOg2fn864GdBeIELP/PqJBgf2BnrukY3Kt
	ttiTG4OwDmp/wrt1jZS5MYVD5M2Jo42OAqAhVHTnT7tr84p0CcO72RClC1Nj9Fh6nKt+Tz
	ZUfdPZEj5IdQD/5TiLOGVRBzxXkpDjVFLtErso1gPjSIw+hlvvNrrJmAkuTEZksAH51JVu
	B9JFYvLacC36fG/gfdrHnh8SSKahoZaooftrb54SQanqIhdew7U8x/JJaIw2d+TUlru0hs
	d+d+2lihJg/7MliB/aRcHDFtz8UhMRx3EE74yravQdnRHzNm9D3es2nr00USNw==
Date: Tue, 23 Sep 2025 17:15:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Subject: 0-Based indexes for git log
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------306qNC0bM6IFO6Mpid2H0odg"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------306qNC0bM6IFO6Mpid2H0odg
Content-Type: multipart/mixed; boundary="------------T2wQvsysiWCapWBO24HoHD0F";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: git@vger.kernel.org
Message-ID: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Subject: 0-Based indexes for git log

--------------T2wQvsysiWCapWBO24HoHD0F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SW4gZ2l0IGxvZyBpdCB1c2VzIGEgMS1iYXNlZCBpbmRleCBmb3IgdGhlIGRhdGUgaW5zdGVh
ZCBvZiBhIDAgYmFzZWQgDQppbmRleC4gU28gaXQgc2F5cyAiRnJpIFNlcCAxOSAxNDoyMzoy
NCAyMDI1IC0wNDAwIiB3aGVuIGl0IHNob3VsZCBzYXkgDQoiRnJpIFNlcCAxOCAxNDoyMzoy
NCAyMDI1IC0wNDAwIiAob3IgIkZyaWRheSAyMDI1LTgtMTjCoDE0OjIzOjI0IA0KKC00OjAw
LjAwKSLCoCB0byBnZXQgYSBiZXR0ZXIgZm9ybWF0KQ0KDQotLSANCkdlb3JnZSB0cnVseSwg
8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow0KVGhpcyBlbWFpbCBk
b2VzIG5vdCBjb25zdGl0dXRlIGEgbGVnYWxseSBiaW5kaW5nIGNvbnRyYWN0DQo=

--------------T2wQvsysiWCapWBO24HoHD0F--

--------------306qNC0bM6IFO6Mpid2H0odg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNMOAgUDAAAAAAAKCRBjTr+HQMdIvphH
AQCt0w14GB1fvxJ6I9GGmAtObbiWnjsS7oCoTLAFOjDGhQEAuktAvY5UN66mCxStyukOYF7ec/EP
NpkTCB5Xe1js/AM=
=5IZv
-----END PGP SIGNATURE-----

--------------306qNC0bM6IFO6Mpid2H0odg--

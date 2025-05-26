Received: from emitter-eu-f-2.smtp.sendamatic.net (emitter-eu-f-2.smtp.sendamatic.net [167.235.192.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466481AC8
	for <git@vger.kernel.org>; Mon, 26 May 2025 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.192.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223477; cv=none; b=lvTuLjSpsofZHdpdaaSF1AROdwel0wYyt6Ii+LJh7qEfPd1Gb62IyyrJF874qdlm4sp4Fv8d6+BuvtY6KR6cDShAdK0AVhkwgAOltBUnumdUahjkliXGaA6KNR0FcQWZObOz58eYzcLtz+AFv3KmFEqJnLp2KUPThJk+LsNU6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223477; c=relaxed/simple;
	bh=ED4CvLAL8amfyBOVIMViWQLztLE5KUKudKFGMjLmuCY=;
	h=Mime-Version:Content-Type:Cc:Subject:From:To:References:
	 In-Reply-To:Message-Id:Date; b=kziP9X5AQB/z7W6LCWz0awpYHymUIr7h3fHsQBjmC/Df/EOEJcorvGFRy+CtSaQ1p7POu0VhpOi9vEKrQ+HrgN9Sl2dY5T9fT7zJGBheLNshVvhMJnepl//x1p3kdw/k2+VYopxkwgRvHy28CyQenEvY1dM/WC2J48LQrPL130Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=mailout.ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=jDIjR+ae; dkim=pass (2048-bit key) header.d=sendamatic.net header.i=@sendamatic.net header.b=Xr1ewmwj; arc=none smtp.client-ip=167.235.192.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailout.ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="jDIjR+ae";
	dkim=pass (2048-bit key) header.d=sendamatic.net header.i=@sendamatic.net header.b="Xr1ewmwj"
Received: (Haraka outbound); Mon, 26 May 2025 01:36:40 +0000
Authentication-Results: emitter-eu-f-2.smtp.sendamatic.net;
	auth=pass (plain)
Received: from mx1.ddevault.org (prox-eu-n-1.smtp.sendamatic.net [195.201.21.105])
	by emitter-eu-f-2.smtp.sendamatic.net (Haraka/3.0.3) with ESMTPSA id 8830BDD2-5664-4F3C-B30F-8CD3A8FE199C.1
	envelope-from <drew@ddevault.org>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Mon, 26 May 2025 01:36:40 +0000
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id 16f6dfac; Mon, 26 May 2025 01:36:39 +0000
Received: by taiga (Postfix, from userid 1000)
	id EFA2CBA0020; Mon, 26 May 2025 10:36:37 +0900 (JST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5ab3921ba78714de3911ff825ddca3a55bd5546108e850799a3137d5db1a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: "Junio C Hamano" <gitster@pobox.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>, "Eric Sunshine" <sunshine@sunshineco.com>, "Julian
 Swagemakers" <julian@swagemakers.org>, "Jeff King" <peff@peff.net>, "Zi
 Yao" <ziyao@disroot.org>, "Rens Oliemans" <hallo@rensoliemans.nl>
Subject: Re: [PATCH RFC] send-mail: add support for Microsoft Graph API
From: "Drew DeVault" <drew@ddevault.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, "Aditya Garg"
 <gargaditya08@live.com>
X-Mailer: aerc 0.20.1
References: <20250525110621.64308-1-gargaditya08@live.com>
 <aDN8mYEJS0ARD1d7@tapette.crustytoothpaste.net>
In-Reply-To: <aDN8mYEJS0ARD1d7@tapette.crustytoothpaste.net>
Message-Id: <8830BDD2-5664-4F3C-B30F-8CD3A8FE199C.1@mx.sendamatic.net>
Date: Mon, 26 May 2025 01:36:40 +0000
CFBL-Address: fbl.007e3aff@mailout.ddevault.org; report=arf
DKIM-Signature: v=1;a=rsa-sha256;bh=ED4CvLAL8amfyBOVIMViWQLztLE5KUKudKFGMjLmuCY=;c=relaxed/simple;d=ddevault.org;h=from:subject:date:message-id:to:cc:mime-version:cfbl-address;s=107cfdf7af1af6e7f7a5-1;b=jDIjR+aelnBFANy0DWdBIH9tNlxWp+PnW9u25QD9iX5oDjsbTsPkHjWMZZbNFzRWBo2qxmxDIbXqi/3TXbjShqY7QgnT8jZSoovCeklUeg0eAnftdKEci9RktIVgk9DGe1JRG9WvUEDXNhFzSaFcFK1PBTVjHV2WqAs8BzNahfKvW8mk7pNUE0PLOFzTG2pIcyUqjpqNIZ0KM5G8cC1ulJQ3U1MW6SbDcm6mm8k6K6wzG2L/ScM8kqfa0auyRrpGqu4jULSi8lNk8Vl+Jo//cUtBZdYQqJ9zoLWIxXWmL+Pji+2Evv0gaxljvzSWaRdceBwwJiJVJQYA42A3fSMQlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=sendamatic.net; s=secondary-5bbc5d09f2;
	h=from:subject:date:message-id:to:cc:mime-version:cfbl-address;
	bh=ED4CvLAL8amfyBOVIMViWQLztLE5KUKudKFGMjLmuCY=;
	b=Xr1ewmwjEqU+s6Rm7JCg5C6QRobgKtbgX0fgP4M/PrvS40v8GATElzCobmAJNCqfcrXD8xkyuo
	HoJ166YyroB7U82Ug65XCNQJDD8uiCMyNOaFWNcErTZmTRyh8TYl9cdBTIQ+cIxYEWeQeadByUv8
	aowmuxJFEbEISU8zECCr4ORzVEdYdECIoH61OIR4UywckQ8tmn3HJkenZbg85CyXndmoLhkPov1P
	6HKFulJrPeGQNOw+8ZZyLqDy1i6t0oB3U+QBQnwnMFm9fCOYTq5e76vCSfSnrQ4PMQSoUtrXh1Ly
	RCE0FlQKV33FXw2coGnAO2c85SmcTOljmutvBqtA==

--5ab3921ba78714de3911ff825ddca3a55bd5546108e850799a3137d5db1a
Content-Type: multipart/mixed;
 boundary=5fa31f9f35bb3058eb8acec2cbf4b4534d4ec22e7451c4dc24d558e1ae3b

--5fa31f9f35bb3058eb8acec2cbf4b4534d4ec22e7451c4dc24d558e1ae3b
Content-Type: multipart/alternative;
 boundary=a8b42520d2d32434326267a8974bfee2fcf990ca73aee5345e881b0d9780

--a8b42520d2d32434326267a8974bfee2fcf990ca73aee5345e881b0d9780
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

I'm inclined to agree that it would be less than ideal to add
first-class support for proprietary protocols to git send-email. Some
kind of local SMTP =3D> Graph API bridge is probably a better solution,
assuming Microsoft won't listen to reason (nor your boss, when you ask
them to switch away from Outlook).

--a8b42520d2d32434326267a8974bfee2fcf990ca73aee5345e881b0d9780--

--5fa31f9f35bb3058eb8acec2cbf4b4534d4ec22e7451c4dc24d558e1ae3b
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=42F3F1862E3CC4B8.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptRE1FWjdZOWt4WUpLd1lCQkFI
YVJ3OEJBUWRBL3BQeTZYK25OTDVUMlFhSktFTTA4eE4vS3o3d0ZUQVpvSDVZCnJpVjl4MW0wSUVS
eVpYY2dSR1ZXWVhWc2RDQThaSEpsZDBCa1pHVjJZWFZzZEM1dmNtYytpSk1FRXhZS0FEc0MKR3dN
RkN3a0lCd0lDSWdJR0ZRb0pDQXNDQkJZQ0F3RUNIZ2NDRjRBV0lRU2Z0ZWMzM0NXeW5ZN3NScEZD
OC9HRwpManpFdUFVQ1o3WTl3d0FLQ1JCQzgvR0dManpFdU1FRUFQOURIKzFMZ3ZUcVpETFo4YmFi
QjVDZHA1eTBaVytRClR4NzhtaDFMOGpKZDZnRUFzc21nc0ltY3JadjRhZFAyVVc1UlU1QkhDZTlL
VWR4MER5VjgzUXdsRkFTNE9BUm4KdGoyVEVnb3JCZ0VFQVpkVkFRVUJBUWRBR0FIOWRsYUNPTm9Y
cG1RZ0hvUWdZSTJ0UytWTTNtelU4STJQeVZZUQoxR1VEQVFnSGlIZ0VHQllLQUNBQ0d3d1dJUVNm
dGVjMzNDV3luWTdzUnBGQzgvR0dManpFdUFVQ1o3WTkxZ0FLCkNSQkM4L0dHTGp6RXVIY25BUDR5
ak9pTTB5cWtTVDZ5WHpEVVd6ZTdCOUltMjRGOEhWeCt3TnFjRGFEdGNBRC8KZktRaHowU0NQaWJs
TzZsYzdNRlV2bGFPejJ2ODdVcFVZUmh6UGRnUXF3az0KPWVtcmIKLS0tLS1FTkQgUEdQIFBVQkxJ
QyBLRVkgQkxPQ0stLS0tLQo=
--5fa31f9f35bb3058eb8acec2cbf4b4534d4ec22e7451c4dc24d558e1ae3b--

--5ab3921ba78714de3911ff825ddca3a55bd5546108e850799a3137d5db1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaDPFpQAKCRBC8/GGLjzE
uHI7AP473v2ccrI69DXrLZ6+vOEp6eLBr5no9m5R1uJ05DCPTAD+LXK/a1HoSo6c
G+3TtMzimU5R7j8Nduil8rxUXzZ1DA4=
=oFDV
-----END PGP SIGNATURE-----

--5ab3921ba78714de3911ff825ddca3a55bd5546108e850799a3137d5db1a--

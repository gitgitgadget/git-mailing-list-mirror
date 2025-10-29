Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F056B81
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698216; cv=none; b=aSA4+TcbtgrILixQuziFt7FtExSMhdFFSLoMUW9OFDcq7uBLeJspZ8O3LPOUcbbAnf6HX1Q65fYJkVFeZ/0o1GMRWgO+zuRXy3zJshhn7oOQjoNa44K0vaJ0wv4hWbh6G5fX0DCTQB/Z2AWp+VXIxEQ8fUW4R5OmOKOEiqI9rVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698216; c=relaxed/simple;
	bh=0O89Ndh6+1aNQ2H6WyQ8ITenBObXYj7pvhArBwsz8Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlKDlTSRt956xskWOS3dmv/MfkTySCFUrP+93/rauhmGWdCh4mO1kldJm7qmAcKaPzi+VYFkQCWc37xicWa+8lFwfyGQkJyhmIAQW/RqWtgaOQmDO1uWBDjRB7whOk614NYAgPVLvil1t2y85CNamCEwXweTXy/HxbhzjowbbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JQuMMIZz; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JQuMMIZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761698213;
	bh=0O89Ndh6+1aNQ2H6WyQ8ITenBObXYj7pvhArBwsz8Xg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JQuMMIZzcviAqG6lfCJ8sHy9y9alAwc8gexFZxy1kRHZEC/nTvrNwsjc630WbLUrc
	 9cfNb/jAwR8TPKWRreApCf7MqefZooCNKEq8NJApgWMunuPZ89wvUnzPCMmwzmPpA1
	 wiaMd89UZRQ0lgsK9e9xmVsJICYgtQsD/kMpfnDZRuU60eqPgT5EfTZtsG2VoN2VwR
	 oOJ907gP1VdPt71YEAb6dFC+3QxRzupJ1JQFahw3RrQFhSZMFnFKk9WU2lqeoT8VL5
	 FbhhepBjuU1lkeZi4sNYomAoFp5PYNiuxMfoM9VajPeHLKa72ghImo8BsBk5XW3lyc
	 M5gfsZOVCwfUeOkXngstbkEVsI+kca3mPEaJRsG2+9+q7Zf81Yz2JiW628Snmlqeuw
	 YoaxGGO8CIn1XlzNa8vCmvwEbmqKsnjHZLrS4MM3lw4zxhef4Dq2i0vN4ZvVlnjGE8
	 SakOXm+sxlMKCW03Y9oQ/UeX/9BROp3J0UUgLtP39IjSwSEgF28
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B6C9A20036;
	Wed, 29 Oct 2025 00:36:53 +0000 (UTC)
Date: Wed, 29 Oct 2025 00:36:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
Message-ID: <aQFhpAinB6HLC-Tw@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-5-sandals@crustytoothpaste.net>
 <aQCKD--ZmKnwBWs9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mGbQF82JMCVyZxLX"
Content-Disposition: inline
In-Reply-To: <aQCKD--ZmKnwBWs9@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--mGbQF82JMCVyZxLX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 09:17:03, Patrick Steinhardt wrote:
> We typically don't have these headers for our C code, so why have it
> over here?

This is explained in the cover letter.

> An alternative to represent this type would be to use an enum:
>=20
>     pub enum ObjectID {
>         SHA1([u8; GIT_SHA1_RAWSZ]),
>         SHA256([u8; GIT_SHA256_RAWSZ]),
>     }
>=20
> That would give us some type safety going forward, but it might be
> harder to work with for us?

I agree that would be a nicer end state, but that can't be cast from C,
which we do later in the series.  The goal is to have a type that is
suitable for FFI between C and Rust and we will be able to switch once
we have no more C code using this type.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--mGbQF82JMCVyZxLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFhpAAKCRB8DEliiIei
gXgyAP0chbbqXpsVyFpGnmW0qt1D73qfUaxefWKqWQkyFZo1PAD/WegGIXwMQOjk
ZbmL4yaHr9tXnq03cHWAyClzhygTJgo=
=J32p
-----END PGP SIGNATURE-----

--mGbQF82JMCVyZxLX--

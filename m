Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE9254AE7
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524320; cv=none; b=kliBUZWqZ1lZjvvaWxsCwm4ZurpB0a9RYl6xUuU4jk43OrBjDYzVmxibm1l+IMMNFo+WTXHfqrbUgGwflwg300XgHWOnXOOeU64cN4k3qltgNJbPHlgvYvBqer7NwNrqND1nmdDSfLsseA1WdEWHM49mwDyfPvG2rcXDZ52Eh0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524320; c=relaxed/simple;
	bh=1gD8WK5zRNP/Kme9HTnQPY2HdU5+t1zfO0pX1HIzDwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWclb5yVQ7m3ZF3IYXCWepC1cNZ+3KylqAna615/xB5gM44QfXiuDl8D8kBGQPP2QSkKRrCpTQiRVA4jxbo0+P7vzEVjJ/nfp4SOrUUoFB4mwnogc5vgMLGtIW0zTI+0oFqEYyWBkLWo9pTV3ugO6zSl1st1R+xlPXV1s66VGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RswL4dDc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RswL4dDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759524310;
	bh=1gD8WK5zRNP/Kme9HTnQPY2HdU5+t1zfO0pX1HIzDwQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RswL4dDch93/HNLjXZSLSjPQBBQENFRzhQ67ysJyc25EcSy9SUR8LLPS3+7xhnEex
	 q4wpwjHmO/zVSEc2TdBzrX0zjcpU47ktALeBAvOVKtymZJFqCkTldcJQIjTx/ymy1M
	 Cqj6p9+8zc4cQ+Wng3+Amg21ZPzrU7G9fXesw8OmaHOsIx6pLGId80X2xBxbmzX0HU
	 2bHb2yFw3Ljp4oJ52N0ofCxW2efbGE7MM4Eh3fycAGm2z5q80vTHGrkotxerbgMRMQ
	 BFg3gR3IxyhUcLaaxqapAmQBdNPeYOkVhVMHrjq+XC942rUyNnFOEwJWz7Qt8jb0PZ
	 FGUta30/zzK3p8+SzGYzurct6SlEl1V3oz8YauFsX47SXLx4M/72PRpER8PBR0Ifv1
	 LrlE4thA86oU5QD2UrGtHJKwba9y1GZc6cu7fHHN497C5URWv39ApiDXKafdsT4zFW
	 W0SII/ez7i6ADGRw9BGROiYYgXoE86CRRNbtXeEzs9FUXgfJgMD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a85:b88c:5160:2148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AF57620119;
	Fri,  3 Oct 2025 20:45:10 +0000 (UTC)
Date: Fri, 3 Oct 2025 20:45:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 8/9] t: allow specifying compatibility hash
Message-ID: <aOA11cS_vuVwSbkr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-9-sandals@crustytoothpaste.net>
 <xmqqqzvjucuh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u6pzQAQAgMaC2Gie"
Content-Disposition: inline
In-Reply-To: <xmqqqzvjucuh.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--u6pzQAQAgMaC2Gie
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-03 at 17:14:30, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Finally, in this scenario, we can no longer rely on having broken
> > objects work since we lack compatibility mappings to rewrite objects in
> > the repository.  Add a prerequisite, BROKEN_OBJECTS, that we define in
> > terms of COMPAT_HASH and checks to see if creating deliberately broken
> > objects is possible, so that we can disable these tests if not.
>=20
> Thanks for an attention for this kind of details.

I appreciate the kind words.  To be fair, this is one of a few major
causes of testsuite failures when running in compatibility mode, so
addressing these is important to getting the testsuite to work properly
in such a mode.  Fortunately, they are relatively easy to spot and fix.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--u6pzQAQAgMaC2Gie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOA11AAKCRB8DEliiIei
gQPoAQDXCHkTo2u7bAraVn7YIQV05wN5bXVgYuSPgZxrTJuYyQEAv0w+jEbVPsea
N/w4eEr/FFJ4OGoGlCYdMLBd3MG9dAM=
=bRCk
-----END PGP SIGNATURE-----

--u6pzQAQAgMaC2Gie--

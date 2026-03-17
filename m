Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0863B7754
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748746; cv=none; b=J0/Xbh/Hz3ZjWltI4mtySGLeceiNFiJSDACWziwn7K6ixUboLwWtijYKPr/LnXbmbPEl6OQq22K8bJBfy5k5UnsnK3SlJcXP2To7VTQDDNhtgP4R6p3GrvB9nBXGY8rakF3fN35B+xpfw5YBAmkAZcq5wxo1dPnWdrb2LgVFWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748746; c=relaxed/simple;
	bh=aN07WaiGPTR9Q8XQi7etykz9v44nOrGIZO3C8g45QTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jppXbnjPO8qwBCWZhNN31dE9RNN/xNd4vO6gdgfunLheSN+lkSTpbVuXCKSZ/1DptRVeAbZO8WMwQGDFJInhF2eq/+surmoE+rzhHws5Fp1a42PvoRhcRYS909lWdyvZ9YawQyZudz2LRXYY9J1yS9XsDB765m1h16ZmVvqhZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hSCpsrnk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hSCpsrnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773748743;
	bh=aN07WaiGPTR9Q8XQi7etykz9v44nOrGIZO3C8g45QTM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hSCpsrnkrYtMLTy1T0HHFR6573o+RPgs2B0tuBSH0xvXiyIJSqosDE8WbMmvBoGYl
	 vgOuzfEPy90tznMHYZBl3+S9l/qnqR4MIqTPdtAhUKDrUmxWVP3/k97kilSZC6ULS+
	 WVW32b/HfcP1gXETQ/P7d09jbXvVdCi8HjJsk9nai4xo55s3K8wbNMXOdfsBIK73U4
	 SVavXutj3vcEfuA5WoFDp1Mtv36Mi5eIKtm+ezcim8kEJ8UO/xMBiP1Re4v6HJQNUi
	 HPHYkSciyM5N1moaQb3V5NzuP/sSiFyMTyYVvZT9BuQahweBvmj3nQrGHj2RSzTI5S
	 j0uDCSccupENFsQjaYO57U+gSrsaIgBVksS9ASRNVkIyskKzW9OAmg+w3LJmof0dvo
	 YvvJbeLOjrszqjOU98t8kbGyg8ZiHs8QCIX9xQnLdeAW2ZGfL9wWWYKnfwAetVgQWE
	 2JChXPvitTVdfJUgsrrr9fR4FnC7mlNmsHhJpETPoQP5+n2mtCy
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b013:e8d8:1645:32b1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 62AC620117;
	Tue, 17 Mar 2026 11:59:03 +0000 (UTC)
Date: Tue, 17 Mar 2026 11:59:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
Message-ID: <ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <xmqqcy13mgdk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2As2JWW1TDP8XQPj"
Content-Disposition: inline
In-Reply-To: <xmqqcy13mgdk.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--2As2JWW1TDP8XQPj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-17 at 00:47:19, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  parse-options.c               | 2 +-
> >  t/t1502-rev-parse-parseopt.sh | 9 +++++++--
> >  t/t1502/optionspec-neg.help   | 1 +
> >  t/t1502/optionspec.help       | 1 +
> >  4 files changed, 10 insertions(+), 3 deletions(-)
>=20
> Has t1517 passed for you?
>=20
> Queued directly on top of v2.53.0, I am seeing:
>=20
> >>>>>
> expecting success of 1517.169 ''git instaweb -h' outside a repository':
>                 test_expect_code 129 nongit git $cmd -h >usage &&
>                 test_grep "[Uu]sage: git $cmd " usage
>=20
> test_expect_code: command exited with 0, we wanted 129 nongit git instawe=
b -h
> not ok 169 - 'git instaweb -h' outside a repository
> <<<<<

I thought the tests passed, but I may have neglected to run them on the
latest revision.  Go ahead and drop this for now and I'll send out a v2
either tonight or later this week.  My apologies.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--2As2JWW1TDP8XQPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCablCBQAKCRB8DEliiIei
gXHXAP0SUrICFrZVk64IomtVzFy1jVdIcamOFsHkVnhH++OSSwEApJL0+Bt1cfcE
Rs0Cf8+vfhVJCLvQasL4907wHvnXnAw=
=g1d7
-----END PGP SIGNATURE-----

--2As2JWW1TDP8XQPj--

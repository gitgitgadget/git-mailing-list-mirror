Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787124113C
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770937402; cv=none; b=ktsMQdQr0KnnEtCRZGw+6ipOYoBb74uHEsEDPc0zthSU6J9Ahs0KUo1GXok0JgXv6Mya23p7yxGbBKqMiOe0lNarwFxuzjWSN8aZy2leqmVW1MAWCAgUuQ45+1ATA/URuS8LTiVNywibkVbQZ9+79+ovitW9CpiEgHsDkqv2GR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770937402; c=relaxed/simple;
	bh=f6fvKnLHiIoYtfPjmPeyn8P0U3UZAUMG1rizkU3ErA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGM1rV+H0bGUthXEHqOaCB80ZXf1fboUxZA19cUqdCCQE1FMX5T8/PrmhLeiJ2IAUiXiMBCb40kCr9+TuuoK1ya3Y0MLnCTzLG6CAbWd/9xGsYS7/D+IPPxhhAkA951bMK/xRs0snPAVMdkqXmfsX4LlF3O1taQc6mM5WWA8fcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=u4CMB/os; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="u4CMB/os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770937399;
	bh=f6fvKnLHiIoYtfPjmPeyn8P0U3UZAUMG1rizkU3ErA8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=u4CMB/osrKnRXXS83ThLMEHPVr2SIN6K+aanv5+cwGt6GTPx4rBekyacJmxLvVEDx
	 yBcqN2c3SMivhhkvKLsaeGMxhMkju+nupG6y8E4Bn4YyTMcfmEslh9qpaBKf01pyWN
	 s5hsye3Z4aIDiso4Jmxot15JBJFrvIhUGD04g3KDJqBuHkhC6XckOL00Ep5SlNNNgX
	 PKXEzjHAuaUagh0IBZYQ9HhtiDeCIo9q2gy5EhsODmVxd3irSHyhlA7IjT75nliZ9W
	 Pxb3eiTn0nd6edQG9+iFN6n9POQhEVr8ldNu9vxTvNqlxFtKzDXY2N+FSS3f74+qNV
	 3BwHE7FBnJ7zp06pzOUc0eTDP4zKNZKDspPQ9mPFz9bFKXt2FT1F9qGlVEEpgotekx
	 mDf6BcFgzgB6AxpqzEhW+36sk2OQz9sM+me0KW3NTehdWYEVbqO8KoJeS5Vhq6+ay3
	 s9EP8zEvOtzf5uP1fck/ABd8G+Hw9Jh3DXhR6ozSaNnAZTEACtd
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e298:762a:be2c:ed79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D5184200C7;
	Thu, 12 Feb 2026 23:03:19 +0000 (UTC)
Date: Thu, 12 Feb 2026 23:03:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] setup: fail if .git is not a file or directory
Message-ID: <aY5cNkxjzOOCGOow@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
References: <20260211182122.35352-1-a3205153416@gmail.com>
 <aY5Wid6eg1-LwZm8@fruit.crustytoothpaste.net>
 <xmqqy0kxlgy6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="58WHxKBUHVtv+USq"
Content-Disposition: inline
In-Reply-To: <xmqqy0kxlgy6.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--58WHxKBUHVtv+USq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-12 at 22:45:05, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > In general, we should allow people to use symlinks wherever they can use
> > a file or directory unless we can definitively prove that there's a
> > clear security or functionality problem that cannot be avoided.  Git was
> > originally written for Unix, after all.
>=20
> Is this also an obvlique reference to a separate potential security
> issue, I wonder.  It reminds me that I need to see if I have to ping
> the thread again.

It was intended to be a reference to the situation we had with, I
believe, `.gitmodules` or `.gitignore` or another file of that sort,
where symlinks were very much broken in that context.  I merely
mentioned security issues for completeness.

I believe it was bb6832d552 ("fsck: warn about symlinked dotfiles we'll
open with O_NOFOLLOW", 2021-05-03) that introduced that change and was
what I was thinking of.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--58WHxKBUHVtv+USq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaY5cNgAKCRB8DEliiIei
gf1WAQC0hyvnunicb5p8l4mU0npe+qWirMbVHS/LQ8ic/A8kZgD/Uu3RAzDRNclQ
1Yi41japi4kal+rAXdd4qBN9TuIgOgA=
=Xuvq
-----END PGP SIGNATURE-----

--58WHxKBUHVtv+USq--

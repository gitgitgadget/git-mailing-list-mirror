Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0A1D0B9E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054461; cv=none; b=BfchTKdu8CSMeAL25gcvkkXEl3XlaXOcnvcpcRupVqfm+xDDMZe5htPZ/3jaliiDJpoI4mtfvsvzK1xUhvvMcz6ZaOffU8jbD68INYXbP1hMoRpqryTm6Kv9QeM3oZqqDrqMnKWArkPAh8cC8w97PzcEW0WK10T+20pQa8ZuJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054461; c=relaxed/simple;
	bh=HWFQ33dpmQmSLRyWYkvDJVgB/UCcpjjawF7hISVZuzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaSPRCX0ArxHjvvGQfxAGx0NGLiyU4K/zTB0P5435DFqswsh1FbXH9lrtZRd1QsJZTl99d4J/NcVvOqbr7jowLteqWRoZ3+edmnQggwMWXu09nydVyCRb50xhqqPF5KsX2ypCYJdnGSSZxfCPNa+auZxswRKwLi+AjJ0sw6mJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GRZEmRIY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GRZEmRIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732054451;
	bh=HWFQ33dpmQmSLRyWYkvDJVgB/UCcpjjawF7hISVZuzg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GRZEmRIYerQ0cnDpU22V1S1QMDiMvfYxm+BhlRJYsBrC3InYV7DTMwSUGz+dAEdaM
	 91BCEUHMjEVt4qXifsdz6BCSQdC/dHDdhfEe/orW1+sAKRl60XbCzTLKOsnwSGiVhB
	 FWK+mBPqPuyrs/68coJ4UTme5Z7byWxx5Rwth0MpRK8zpGoC/6vHngrf+AlAgfQbYA
	 w7os0KUublc11hn2J7pkXJ54Mx8RTIoiXeZWKIQ6VYU4GwAsRZJb7mzzVuxdWQCB8V
	 k2h56LJLV9lsYDpv7eNuyDGfQdypC2tCexWLEY2hL6WT0StH+320dzHRDZmB9MIRjV
	 jiN5aSonPNt5/tcUbREObuIu+7mANi08XXZwmyVw2onHS2HWiSKxIK9T3m9Yde8+6x
	 3CK4fTQ212ZJmOsjvgtz23UHGHFA/04El8irN4eKNJuz9+l37naPqOcZD5Ogdk3I2i
	 Vi2e2FcxvXUZjUY3rF0isan3rlskJawnlCEDBNVtuiFUDwtZ0rJ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:d026:90f3:853d:a63c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 21364200C4;
	Tue, 19 Nov 2024 22:14:11 +0000 (UTC)
Date: Tue, 19 Nov 2024 22:14:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Niels =?utf-8?Q?M=C3=B6ller?= <nisse@glasklarteknik.se>
Cc: git@vger.kernel.org
Subject: Re: Unexpected effect of log.showSignature on tformat:%H.
Message-ID: <Zz0NsaM-KFRXzBp6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Niels =?utf-8?Q?M=C3=B6ller?= <nisse@glasklarteknik.se>,
	git@vger.kernel.org
References: <87cyirtweq.fsf@localhost>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vI/l2O6mwpTbwdAh"
Content-Disposition: inline
In-Reply-To: <87cyirtweq.fsf@localhost>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vI/l2O6mwpTbwdAh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-19 at 09:17:33, Niels M=C3=B6ller wrote:
> I had expected the output of git show -s --format=3D'tformat:%H' to be
> always the same, and was surprised to find that scripts using this
> construction started to fail after I set log.showSignature true.
>=20
> See filled out bugreport form below, including a repro script.
>=20
> Regards,
> /Niels M=C3=B6ller
>=20
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
>   git config --global log.showSignature true
>=20
>   I'm trying this out to get to see in git log which commits are
>   signed.
>=20
> What did you expect to happen? (Expected behavior)
>=20
>   That git show -s --format=3D'tformat:%H' SOME_COMMIT
>   should still output the commit hash and nothing more.

git show is a porcelain, and it can be affected by options, such as
`log.showSignature`.  If you want predictable behaviour, you need a
plumbing command, whose behaviour isn't affected by configuration in
this way.  The equivalent to what you've requested is this:

    git rev-list --no-commit-header -1 -s --format=3D'tformat:%H' SOME_COMM=
IT

I've confirmed that works correctly even if `log.showSignature` is set.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vI/l2O6mwpTbwdAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZz0NsAAKCRB8DEliiIei
gYp8AQDpAmderGd+VbarST9dEdutSNBO4wvMjYRtw8IswwmWewEAn0SIVEoNBoLp
x5/Lb9IFVDmj1CMqHwnrdkTw7EsanQ0=
=7L6C
-----END PGP SIGNATURE-----

--vI/l2O6mwpTbwdAh--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B819D8BE
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446930; cv=none; b=n3YxVz7jb0dXldrNNcMIe5dg053PSoyp/+VNAjyy5+gS+cz20HQ9skvDKR7rTxb7FTBHcM82J5KgPohC76viP6Zti0q2szp1mNiBdEk/spnuyGbSnSBxRazyNzuSxhBnzzkTiicDJEhhLGw90gAC1ud8zyzqv5kTgH8Ngkutnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446930; c=relaxed/simple;
	bh=Yp+QgZQ8lKr694t6T8kGnE1ayDsDtGBitsdgUQRf1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in53lor1St14kGOfRZv7CVvnCGsFpJy3TJ8smNAuI3VT5MdpzIV0Idr4FJ0WHhBiW2WMp+jYO9JoW+BLYd46suw4qEjnckKxRRGO3K0Dz/bI+5jn8qekemH9TPq1BP+/Nu/zEZ1sF5q8NEUjkZ2y48fsEiTvZF6ykbKvJv9Zzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=n46yoEk1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="n46yoEk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750446927;
	bh=Yp+QgZQ8lKr694t6T8kGnE1ayDsDtGBitsdgUQRf1ok=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=n46yoEk1GMyywtYoxyUYKww2muiU4XCokuK0ikzX4qWwhhNIpGCxeNotcs4g9qMlD
	 GToIkqSau2akt/vmAcIe0+JDcPQFlbRant8VHM/a0FI3RH1LHyJZWO8aV/oreCfYrn
	 cgGXj6Stgu6yRAR6mkDZZko1tWBsNAMDfB+1n8+b2PxkJW6gYZM1tU5F9pyV6zjHIe
	 Vayl2PiR+qkj7UR9rEvi6QtMGITFs7bIT6MdkfM5Z9oP9XVymf+FmRtHAF1ibs1XuJ
	 fd6+3Lc2HprzfYRnoAy3LEf6MVrz7T24GXLErOY8Ts7cax4C8v6gwNNnUSvvzszhvW
	 pH/7JbvKVkRKip2mMOOOnQnIDrJF2bPaHlu1/ykPwwJ+5r/mokBtSTx4xX+qImdMyY
	 XLo4wyvczr2KRR3nfOxzohEyx1GBOe96oC03MqRwB6ITw4/GAa+E0o+6ug4HYXOUXE
	 GmEBEdDoKfwWn9oLVZ79gnwIbJDLG+wULWWpZO1OHvafe8TnOJq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B6E2820069;
	Fri, 20 Jun 2025 19:15:27 +0000 (UTC)
Date: Fri, 20 Jun 2025 19:15:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
Message-ID: <aFWzTv5-AjUvXWsg@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-11-sandals@crustytoothpaste.net>
 <xmqqfrfu5ubo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X/ASCbc0uJJ9fOPC"
Content-Disposition: inline
In-Reply-To: <xmqqfrfu5ubo.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--X/ASCbc0uJJ9fOPC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-20 at 15:03:23, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Our document on breaking changes indicates that we intend to default to
> > SHA-256 in Git 3.0.  Since most people choose the default option, this
> > is an important security upgrade to our defaults.
> >
> > To allow people to test this case, when WITH_BREAKING_CHANGES is set in
> > the configuration, build Git with SHA-256 as the default hash.  Update
> > the testsuite to reflect this configuration so that the tests pass.
>=20
> Another thing that I suspect nobody wrote tests for, but we must be
> absolutely certain, is that the post-3.0 Git can still interoperate
> well with historical SHA-1 repositories (I am not talking about
> "fetch from SHA-1 into SHA-256", but "the binary does not lose
> ability to work in SHA-1 repositories or fetch/push between SHA-1
> repositories, only because the default is set to SHA-256"), even in
> old repositories people have been using for ages without the
> core.repositoryformatversion defined.

Yes, I have definitely tested that here before sending it out.  When Git
3.0 comes out, we can switch our GIT_TEST_DEFAULT_HASH test from sha256
to sha1 to continue to verify that those work.  As I learned when
writing the SHA-256 functionality and as I'm experiencing today writing
the interop code, if clones, fetches, and pushes do not work properly,
the testsuite is completely broken with at the very least fifty-some-odd
tests failing, so I feel confident that functionality will continue to
work for SHA-1 as long as we do run an appropriate test job.

Also, when we initialize a SHA-1 repository with the files ref backend,
we still use repository format version 0 without any extensions, so the
cases that cover older-style configs will still be adequately tested. We
also have some tests that even test that things work properly without a
config file, which caught a bug in this series (that I fixed before
sending it out).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--X/ASCbc0uJJ9fOPC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFWzTQAKCRB8DEliiIei
gXwyAQCyEGF+MFuyNaR4FnZJWrbe+JQvAlkCIX8WCq1RDkxE/AD8CMDcPwBLa/Kk
iCd3eV8/Q84dImlMaWrz/q/uqBa9SAI=
=GUHh
-----END PGP SIGNATURE-----

--X/ASCbc0uJJ9fOPC--

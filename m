Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32928399
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722115216; cv=none; b=l5cN+JWak99uCyutN208woZg9sN403ApR18wAwL/eNhN8Og8UxsDYfX1t0UUOFX4nn20YJFL37NJTPVpL5e+a40O9pFH1s0/P4hkEAO4wcymBIlDuG1mYcLmKPHFdzTNo30QwubwukeD1T+iajoABHqBN7CuMyCoc2rJvA+U2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722115216; c=relaxed/simple;
	bh=Lb/NgD+cSXbvSzy0XtNPW4LZGU+y1bCw3hYt45TzmfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/QuI/5Eq2X3mic0+Ci94l3QmmdGQDVU4n0NIGY5gSvJImpyht/hQqPgO9J9YL7DrWzkjrUI07Oppb1hjqSo9vzOpJmPCmsSJsAcwZR4sjT6G/7z0Q+/xVNLY1yyE9RB4GHxwZGIkOepG7UtOMVlH9Np8kVncYNdm8viHzCKh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=us9cy1OD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="us9cy1OD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722115211;
	bh=Lb/NgD+cSXbvSzy0XtNPW4LZGU+y1bCw3hYt45TzmfM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=us9cy1OD8Q2OuoiO+3f7LssuxO//RvasJh+dLvWXElNkLqqEk4YJAFKJ2r8gjqaqu
	 xEoMFLbPyl8lghK8g1qclBRUIumIHZbOKlfzSlWLdQjOCrYRw8GOm6vguyh1OrEwup
	 Bw2EM+VbmSRAOUxTwMARJkWg7JFF2515mEnIjn1fba1GY1ICw8m8QsBMbgZ4DOGsTq
	 7v5IFXJnIsuFx9kTP2bqc5VWK8x67lE3ylFJrPPM2eU2vkEPFt3byl7ChRWQNGEZgA
	 j2YS/maMtJFyEEjeBk8bbRAaxtu3JjyPgV95Eaz0/5UHeiWgBB5NEAG2mLdDeYSpVO
	 ZyQScToLhTzgEC7ofaoo/Fzg4ipZ9rJOPvJh/BxX3FFPmuirVeJDmvcx3GJzVSZqUy
	 NJdisNNRamI4Sgw21LphPCthgOje+1tEe2hA7NfteBi/9j2rUgppOz0DtGp0JbZGBo
	 2AdrNDJJJ7Mm3BVg087IDByAmmvdpCxtHVa3+JsEozyfUUOfpEp
Received: from tapette.crustytoothpaste.net (unknown [207.96.251.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A7701209B7;
	Sat, 27 Jul 2024 21:20:11 +0000 (UTC)
Date: Sat, 27 Jul 2024 21:20:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Bug with bash and OpenSSL usage on Windows
Message-ID: <ZqVkiaD6L_zdfTJV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
 <ZqUF0ANz9qX-wWEN@tapette.crustytoothpaste.net>
 <xmqqttgasufx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1c02v7bwhBkdb0r5"
Content-Disposition: inline
In-Reply-To: <xmqqttgasufx.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--1c02v7bwhBkdb0r5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-27 at 15:53:06, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > The Git project doesn't ship OpenSSL, or, for that matter, any binaries
> > at all.  All we ship is source versions of Git which various
> > distributors compile, sometimes with other binaries.
> >
> > It looks like you're probably using Git for Windows, which _does_ ship
> > OpenSSL, and so you probably want to contact them using their issue
> > tracker[0] once you've verified that it hasn't already been reported.
> >
> > [0] https://github.com/git-for-windows/git
>=20
> Thanks for giving a response like the above, tirelessly every time
> something similar pops out.
>=20
> I've been wondering if we can somehow reduce the occurrence of such
> an issue in the first place.  Elaborating a bit more in the
> "Reporting bugs" section of the documentation landing page is
> probably the 0-th step, and if people agree that it is going in the
> right direction, perhaps we would extend it to include something
> similar to the top of the "git bugreport" template, by futzing with
> the implementation of builtin/bugreport.c:get_bug_template(), and we
> can even encourage customizing it by distribution.
>=20
> Comments?

I think something like that would be valuable.  We of course want to
hear about useful bug reports, but there's nothing we can do in this
case and it would be very helpful both for us and the reporter if it
went to the right place at first (even if that were the case even just a
slightly higher percentage of the time).

It might be helpful to maybe add a note that the reporter should search
for a similar issue first before reporting it.  I feel like Dscho, as
well as the Debian and Ubuntu maintainers, will appreciate that, and I
know for Ubuntu at least the issue tracker actually keeps track of the
issues affecting the most people to help prioritize fixes.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--1c02v7bwhBkdb0r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqVkiAAKCRB8DEliiIei
gQKaAQD8u0AvrV7D8TuunvGs48oLhpAXPgM3YI0E7TEaxSnleQD9HF5jaNtrSmQC
BgfWIQJi2CuC0BsRhUqAeIwwa2D1SQ8=
=JpBP
-----END PGP SIGNATURE-----

--1c02v7bwhBkdb0r5--

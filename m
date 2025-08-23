Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193691E51D
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977078; cv=none; b=NXQEOm0GzXSc5TiphD7ymvuqK4tZQTBnx32NZ22YAuNM7UvO27oKWN6UoupvIzyVUF7HTmCGWoGQYU1ocpBLkEpedtTfoE+R37yKl/Ke/j6KlwZ+0FwLXDwwUGuliIqhUKc0A9Ht6soKd0UUgx4IXVioeGUgnY1a3qUSzVi0iLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977078; c=relaxed/simple;
	bh=+P3fFrqNE+/6Pfq6BlBwrLZ7xMA1Pr2G5oVtnG+A+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhsTeEJwBmDVDbS38Q5/yeFP+IUVnN2uaa4K27Fxy4ji6CXSCqqxkoH5wfPS2zo8tMv2AbiYiO+J6h+rSKTqqAkEXbCVRODze1g5oV8qvGNrqPgN2NkzofI3IIpcSiX6/4cji7wm3f/1l6dkGutK2yFBk1seHyfUZAYwjWlBKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=c07DDUib; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="c07DDUib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755977074;
	bh=+P3fFrqNE+/6Pfq6BlBwrLZ7xMA1Pr2G5oVtnG+A+6M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=c07DDUibDELyYirkPIBocUjhXbEPl6NckKE8t95J4fSgqX7kOcl6ylLXSUk6T+frO
	 LVXAQ6Tnp1zsEymbssB7jmbHob5Eoh7eOgy3QMH/tuCLirWgP5MN1COh9dpYgAsCPc
	 qoCbNn+w89zOjzYY7w1ogeR8t1AuHt5mRMUTlInarNPc4Lh+ewRzFK1BcQz14nk7Tt
	 tp3RL/vSFDgdWndLIyLKw8BUMlbHXr05I9v80PvbhKQYV4cJu0+whTVSxyfn8D9jvV
	 CQ3FfvtLmyruiOLhiXvSEvGezEYqUUbbJxFC9OBSslfAorAGf0JxpmO/k8jeQHSiZX
	 ia1cJiok55KMtQR792Q2vre9w6Rplu7NTGKgo+hSDV2Yfkb90I9NOsjQws/C9mycmv
	 AE8G5/bcwL8tm5KzAPeZxQeSXmOAcm0aORh3HzWLeN3y0QK8LOdpG8SXcmAbO1F1Pg
	 ZNdEepsmefQQOFoJIxd1nAGbpvV2Q/WMiu3x6+2c4eCmuN/10PI
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4bca:b344:de61:b896])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6C041200B4;
	Sat, 23 Aug 2025 19:24:34 +0000 (UTC)
Date: Sat, 23 Aug 2025 19:24:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Elijah Newren <newren@gmail.com>
Cc: rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
	Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aKoVcVexWi212pAl@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
	Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
 <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
 <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uVBnN1Km4Glj1vde"
Content-Disposition: inline
In-Reply-To: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--uVBnN1Km4Glj1vde
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-23 at 18:30:26, Elijah Newren wrote:
> I don't think that's fair.  A quick reminder on the history: There was
> lots of excitement about potentially introducing Rust two years ago at
> our virtual Git contributors conference.  Taylor formally proposed
> adopting it on the mailing list a year and a half ago.  And at Git
> Merge last year, among those in attendance, there was broad
> significant interest in adopting Rust with unanimous support for
> letting it move forward among those that were present (which, yes, we
> know wasn't everyone).  And there's the three rounds so far of this
> patch series.  At every discussion where you weren't present, someone
> else would always bring up you and NonStop, and point out how you've
> been a very positive long-term member of the Git community and how
> Rust adoption would likely negatively affect you, which would be
> regrettable.  We waited years to adopt Rust precisely (and I believe
> solely) because of your objections.  Josh and Calvin even went the
> route of making optional not-even-built-by-default Rust libraries
> (libgit-rs and libgit-sys) when they wanted to add some Rust bindings.
> If years of deference by other community members isn't considered
> taking you seriously, I don't know what is.
>=20
> I agree that it is disappointing that there isn't a clear way to both
> gain the compelling advantages of Rust while also retaining the full
> current extent of our widespread platform support.  It's doubly
> unfortunate since you're such a positive contributing member of the
> community.  But not allowing us to ever gain the advantages of Rust is
> problematic too.  So, a decision has to be made, one way or the other.

I think it's worth saying that I do appreciate your (Randall's) positive
contributions as well and I would love some way to continue to support
NonStop as we adopt Rust.  To be clear, I care deeply about portability:
I have owned PowerPC, UltraSPARC, MIPS, and ARM hardware, and I test
many of my personal projects on at least Linux, FreeBSD, and NetBSD.

There is an alternative Rust compiler, mrustc[0], which is written in
C++ and that I have played around with to see if it could meet our
needs.  I've been very busy lately and haven't had the time to test it
out fully, and although it will likely require some upstream changes for
static libraries and a compatibility wrapper because its minicargo is
very limited in functionality, it might be an option that we could
leverage.  There will necessarily be work on Rust upstream as well, but
I'm hoping that mrustc will at least open doors for us.

I also think that Rust is becoming a more and more common language in
technology because of its interoperability with C and its memory safety.
The support policy I wrote up explains why there is an increasing push
=66rom governments, security professionals, and the technology industry
for memory-safe languages.  If Git is to continue its success and broad
adoption, we don't want it to be labelled software that is using
security anti-patterns, and we also don't want it to be a CVE factory
like libxml2 or ImageMagick.  This is the reason I ultimately started
work on the SHA-256 project many years ago: I knew we'd need to do it
for security reasons and that without a more secure hash algorithm, Git
would eventually be dropped.

My hope is that NonStop can find some way to support Rust because I
think it's a compelling language and NonStop would greatly benefit from
the wider variety of software available.  My sense of previous
discussions was that we do very much want NonStop to continue to come
along as we support Rust in Git and that if there are ways we make it
easier for both, we'd want to do that.  That's certainly my view, at
least.

[0] https://github.com/thepowersgang/mrustc
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--uVBnN1Km4Glj1vde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKoVcAAKCRB8DEliiIei
gQxtAQC0GqtiT09QetoQG6mg76ld9bY/dWPFYDXigPV9V/o+6QD+Mg8tmnpODD1Z
VlBrrXLXnCpkQ6jnmuIfgoPUwfTZtQo=
=HpXW
-----END PGP SIGNATURE-----

--uVBnN1Km4Glj1vde--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B30272E51
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100880; cv=none; b=onW7X7LgnB787/E41L1aM6aWtXhVvHnV/rJg4tHLJW9Og5UXBGbIbOqkYo9tMVch0hUgsDWJJ2syKba7oiTtAops/fGC52zR4AzQZc4hYaiY4ZupqFYo10cQeuxZ0Uv2szXqBSX4/UPD2k009Xor20+twce2VS4N/V29voR0OYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100880; c=relaxed/simple;
	bh=IJg4h2/lVSSu/v6Xkhar0p06NHkceiyQiDei2LwcAWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfd4xbxo9uS84AQBhv/946pNMT9NkxHa7rkrHQNnk2F9NF+CUP2+GYEr6fWoIXh4Ldjfm4XVWl7R6P0YwqwJ3AZvapY/Uc7QthNOM2unlCp7LBskCFAqJxjwyjFQzS2nht9HjVvLt8rkvWylJ+IZ7NHGUuVD57zj549iSkaJ0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lfak7DIC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lfak7DIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757100876;
	bh=IJg4h2/lVSSu/v6Xkhar0p06NHkceiyQiDei2LwcAWU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lfak7DICdwjU21a4i5RwM3aOzM6PV/bgpBN14+LHTzCK6lkb1BWRU2sYS5AfFBMux
	 WRcJ1M4gAmV00n5YgFRaPwT1DusehY+4t0/RHBPLDIhYV1/xo9gK2NXjYfObI99qSK
	 zXB7Rzcv2BIZVNBSuGEyrNPHaQA27hcwMABs3cw7DoZ+riO9qIiQJUBvoXoMDX66oG
	 +fFaiO6GrpSDV6dpg8HRsMmr1RdD1476WqLleXyIF7apeKrsH+cEqwB9Wm7akoH/6o
	 EuwMYBmb10kD3QQ5oyEqowbWwz9ema4e9GynJa2BzywkLX/v6d8YLuKWPh2fEQ5CTz
	 qvas3NdI4xMnmLPmN4L44fzFrAsHD/+sn7LRt+Hto9uXr2nv4p9X0vKwNEfRjeXBq5
	 zzPz0Em+BFPjzXcDZxDs1K+MBcFL46IN7CeSmjbje8hTOF+CZY3TVDPrTVcKaAE81g
	 tF9okeLD6G06p5uceIZcyxtYoeajkR3ASQ95Sk8uB2XjrYEcMNs
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f8f0:4bbe:8989:f575])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C516C20100;
	Fri,  5 Sep 2025 19:34:36 +0000 (UTC)
Date: Fri, 5 Sep 2025 19:34:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aLs7SwT-Gd6hXuvH@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <11394b17-905a-4888-981c-c5b4a7f8cd62@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="84Xj+shCT3GcNPxB"
Content-Disposition: inline
In-Reply-To: <11394b17-905a-4888-981c-c5b4a7f8cd62@gentoo.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--84Xj+shCT3GcNPxB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-05 at 14:32:49, Eli Schwartz wrote:
> LLVM is theoretically an open source project. So is Rust. We can ask
> people on those platforms how successful they have been at the political
> side of convincing the Rust project to allowlist the platforms inside
> low-level case statements of platform-specific defines, in order to
> attempt the first round of "try running make, see what breaks and start
> fixing it".
>=20
> Hint: it did not go well, in the sense that the rust maintainers even
> accepted the validity of making a proposal in the first place.
>=20
> LLVM is easier to work with, at least in that sense. But not all
> platforms are supported by LLVM either, and you do need a stable release
> of LLVM to support the platform before you can begin work on rust at all.

It is possible to build with a custom LLVM because all of the
distributions do it, so it is possible to build the work out of tree and
then add it when everything is ready.  I mentioned elsewhere in the
discussions that LLVM upstream said that work on IA-64 could continue
out of tree and then it could be re-added if there was sufficient
maintenance and support, so this is at least in theory a viable option.

If LLVM and Rust upstreams are just completely unreasonable and won't
accept certain platforms at all (which I doubt), then distros can carry
patches.  It's not pretty and it's a bunch of hassle, but it's common.

I'll also say that LLVM is a pretty useful piece of software that most
distros will want to have.  It provides clangd, which is one of the the
major C and C++ LSPs; it's used by Doxygen, which is a major
documentation generator; and it's used by Mesa and PostgreSQL, which are
pieces of software people will want to use.  And, as well, it provides a
complete compiler toolchain.  So I think there are compelling reasons
why porting LLVM is valuable functionality to have anyway, in addition
to the fact that it also gets you most of the way towards Rust (and a
variety of other, less common languages).

> That is the advantage of GCC-rs -- it has much broader platform support,
> so if the rust frontend works at all, it will likely also work on the
> specific platform you care about (and the GCC developers usually don't
> bite, even if you want to enable experimental support for new platforms).

I agree gccrs is a great project and of course I want it to succeed.
Clearly having multiple independent implementations makes it easier to
find bugs and increases portability.  And if it means that we get better
platform support, fantastic.

However, if your complaint is that Rust upstream will not allow
platform-specific defines and other incremental work without support in
LLVM or other core toolchain components, then I don't see how gccrs is
going to convince them otherwise.  I also pointed out elsewhere that the
compiler is but one part of the equation and that libstd and libcore,
which are shared between the implementations, plus their dependencies,
are absolutely required for Rust to work on any platform.  If Rust
upstream doesn't allow support for the standard libraries, then distros
will have to carry patches, gccrs or not.

To be clear, I do support this kind of incremental work since it's a
valuable way to do large projects (and it's what I did for SHA-256 in
Git and am doing for SHA-1/SHA-256 interop), but saying, "brian and
other Git contributors say this is a good idea" may not be more
convincing.  To the extent I can encourage this kind of thing, I am
happy to do so, though.

> > Do we want to commit to promising support until gccrs is ready? What if
> > gccrs ends up abandoned? Or takes an unexpectedly long time to reach a
> > stage where it can build Git? It might make sense to give this LTS
> > release a time limit instead, or in addidtion.

I think a two-year limit is reasonable.  As anyone who speaks Spanish
will tell you, there's a degree of uncertainty when speculating about
the future, so we cannot guarantee that gccrs, however promising it
might currently appear, will be usable or viable in that time.  We
cannot agree to backport patches forever if gccrs doesn't materialize,
so a time limit seems like a good idea.

_However_, I will state that I am interested in seeing if we can get
mrustc to build Git's Rust code.  I understand that it is not intended
to do that (it's intended primarily to bootstrap Rust) and it definitely
will require some patches to get working, but I think it's at least a
possibility and it seems like a much lower effort way to solve the
problem.  It will probably involve some inconvenience on our part
because it's very limited in its toolchain and fake cargo, but I would
be willing to deal with said inconvenience for the purposes of
portability.  And it works now and is (for its limited purpose) actively
maintained.

> Well, that will one way or another mean users of such platforms cannot
> use git at all, not even old versions, lest they be hacked. Bit of a
> problem for an application that mainly exists for the purpose of
> communicating over the network. I suppose such platforms can finally
> leave the world of DVCSes, given:
>=20
> - jj, breezy, and mercurial all use rust already
> - bitkeeper and monotone are dead
> - darcs is written in GHC (haskell) which is far less available than
>   rust

There are other Git-compatible options.  There's Game of Trees, which
uses Git repositories and is being designed by OpenBSD.  It isn't
drop-in compatible, since it's designed to meet the OpenBSD team's
needs, but it appears to be basically functional (and is shipped in
Debian, no less).

There's also libgit2 and Dulwich, which also implement Git repositories.

So there are options for people who want to use Git on platforms that
don't support Rust.  I suspect that the lack of Git on certain platforms
will actually be more of a problem for those platforms than for Git,
though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--84Xj+shCT3GcNPxB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLs7SwAKCRB8DEliiIei
gWXsAP914QKYHV5EBgB2MAqV0OdqPsXZdeeFkmeh2oAno+Z7HAEA54rT26brEXF0
MUN0Ty8/NTsYDOvZLVd23o+eciBIAAc=
=dlaf
-----END PGP SIGNATURE-----

--84Xj+shCT3GcNPxB--

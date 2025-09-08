Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD917E0
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370174; cv=none; b=daFVmT+vUn84rNRK75075XQl7OSV+MFOoSuV/xQe8a62ghC0M5hUhg8w+4picKIlqsIEN0Cs6aIbiyN5jOy2sAvncJN7fUdchscMn0pS6XXetdCkZ610g4IpgOfHGUBq0kZeIJh4gEFSVmBWd7yWUfN0HEPCh4xtD24Cm1WXyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370174; c=relaxed/simple;
	bh=LyX/Tet2B49m2qxdrEv1n5r6JNSvI61gDHyWbGRz5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK1/iPyT8aFeO2DVWEu6l8RaroabYYK5ECbfuneoaBqDRep5a3ZxAv9YN65W3rfwL1pTetPZAJ+ONR7vtNlqlzjxlQJC186VxZOsPbUx571CI0YkjqpKIhrSblYtygfujYzJEW7uwNvhZMcWPrKxJ2JGmbtU8v/TwoF0rhyOtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Jue8EHUR; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Jue8EHUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757370171;
	bh=LyX/Tet2B49m2qxdrEv1n5r6JNSvI61gDHyWbGRz5NI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Jue8EHURmeFZX2KF8xNzxhpX8hVkOKYoGja6Y/Qy6tUfAurM0tp7AoF7rMLtDJF4l
	 jxrvrlLLYWYnZNWgMh6/dG0qup6JQ6ZHDBQS3Bk24w47gQ8Pz+Q1QH7kQvJcGeQy7H
	 wG9QODgkE3E4AxCoImZW/Dn4oa19G//WC96sTxw5mjVwUZtIh864LpZYi468/EI46J
	 8RE2127VpU+0VjeyrGS6cl0Y8QJyfoTCr5nLpQk2325co9vDIawqG4FqGRXcNTGbJ9
	 ZeZgWx61gdGq2QDvKGpwruukSSSlDZv12r8zOYc1SMxxl15LnMC3/x0D22N3YIiPqt
	 JfGkPRvoeGHNxKQjpodLBe+0mxSPy7Q4cN16gt0BQGHJPC+pxzJKQnsz3M+QYzasTF
	 PAgV6gcZDDXvAnfzMptnHhNAs4Bwkg2+pwQoTY7FsOx1B1iADISFH/Ih66vCTNVyPG
	 4PH4x4de8V8meE90qXIWkREfozHEC5T4KvrsQ/Y4oraSanZuvGV
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:91aa:86f1:d85a:ac64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 66D60200C9;
	Mon,  8 Sep 2025 22:22:51 +0000 (UTC)
Date: Mon, 8 Sep 2025 22:22:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v3 5/8] rust: implement a test balloon via the
 "varint" subsystem
Message-ID: <aL9XOj1sVmHGjDRn@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
 <20250908-b4-pks-rust-breaking-change-v3-5-1cd7189fed3b@pks.im>
 <CAH=ZcbA_8JM1hdUAfFe3ho0ShuniguEpV1308S0nCkCHOCsmmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3YL+FeSJvzt9t60"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbA_8JM1hdUAfFe3ho0ShuniguEpV1308S0nCkCHOCsmmg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--u3YL+FeSJvzt9t60
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-08 at 17:19:20, Ezekiel Newren wrote:
> On Mon, Sep 8, 2025 at 8:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > +use std::os::raw::c_int;
> > +use std::os::raw::c_uchar;
>=20
> I'd really rather avoid using C types in Rust, in favor of using Rust
> types in C. I have written a commit that talks about why C should use
> Rust primitive types and why Rust should avoid using C types, here:
> https://lore.kernel.org/git/2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.1757=
274320.git.gitgitgadget@gmail.com/.
> In my opinion, the type c_void is the only appropriate C type that
> should be used on the Rust side, and should be used sparingly.
>=20
> The std::os::raw::c_* directly inherits the problems of core::ffi,
> which changes over time and seems to make a best guess at the correct
> definition for a given platform/target. This probably isn't a problem
> for all platforms that Rust supports currently, but can anyone say
> that Rust got it right for all C compilers of all platforms/targets?

It also poses problems because if we use `c_ulong` and it's 64 bit, then
trying to do a `.into()` to convert it to a `u64` will cause the
compiler and linters to complain, even if it does compile successfully.
But on 32-bit systems or Windows, `c_ulong` will be `u32` and it will be
required to convert, since Rust doesn't allow automatic conversion
between types.  I have some personal Rust code which works with
`mode_t`, which on some Unix systems is 16 bits and on some systems is
32 bits and it has made me want to scream quite a bit.  It gets even
worse if the types differ in signedness.

It would be better to do `usize` and `u8` on the Rust side here and
`size_t` and `uint8_t` on the C side.  I think `unsigned char` and `u8`
is also fine, since we are not targeting systems where `unsigned char`
is not 8 bits in size.

I don't know how you plan to deal with the fact that Rust doesn't expose
`uintmax_t`, but I think that's 64-bit on all known systems (because
making it 128-bit would break ABI and nobody wants to bump libc's
SONAME), so you could try `u64` and `uint64_t` for the value instead.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--u3YL+FeSJvzt9t60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL9XOQAKCRB8DEliiIei
gYloAQD8Oy/Cq3i21t4oZWYcZWk4w/BbFZ2Blmk3o5afICyvLQD+KRXOOu7xjLD7
n4i3IkmwVAf78H6z0z081/8rFEtWZwI=
=gvmq
-----END PGP SIGNATURE-----

--u3YL+FeSJvzt9t60--

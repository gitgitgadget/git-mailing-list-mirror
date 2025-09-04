Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073429D0E
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947457; cv=none; b=EyqSR0xLCw5K79w/E4g0fvqgPzDw6N3DfL8jNTbp2EZUW09tjcFqjYcNpATcT5uf85qm+Ksjn6pO/ajePEedPMRe94JLTR8iIs6gPQGf4LnBsOypm8uLXmqmXvQFO6L0367nd6NykfhNXNxdpUGdSpjnwQ3u/DJlDdPlbNbZKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947457; c=relaxed/simple;
	bh=9sgX+jkn/DEr96g2Q5taafOQ4xBtjpBFG7avhbHjlak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp2newJyno7m+RCawqtEzf9gecNht8HKRpfOzvCvRLNi1W+Wp3gHbMS0aMHS4PypMO116AmlCc8Ffaqbt0gQZ3ScszIf1Got6kBCowSW2Q6BN6dvUOsqU6YlKHuCkjSl3o/dn30f4p4YBQ32nPViEncwM2vCtHiRld0ogdj5LXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=08xKwg8m; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="08xKwg8m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756947447;
	bh=9sgX+jkn/DEr96g2Q5taafOQ4xBtjpBFG7avhbHjlak=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=08xKwg8mXC+gs+Z72DMw4UPF8nP9Kc3YPh31ixjHjvujs+i+bCfSlIf5ju5spq1tN
	 uVAytBrMVK/pYVEzNGI1/qc8N09G3E3BSe8PKEJkSa/kViWupXLk4KQyqJErTGQLYy
	 3O/6bMuhRQMSjUSFnxFhVvLVLBqCNylVJL70hpj5h7+zDVC0Fq69xrsFYQWwwrANA4
	 vYK5rlxP8txLsRGIvsRMDCjeBgdhFlvBj/7d3KTzvhWs97e2FwtuoHwUGj9SVt5gj2
	 CkCZF9TC6iRkiyjcL1oPa/JEdf8Y11TVksllCCWXW51/F6YHEP5E+kSDIDFXB7lJnD
	 LBorhdWEc43xN9Q6JBmF34YJWnM1D8DqXEaDtZeWTlwPpWpihnjl+EE0jkz8ER0kmV
	 tyWdYjDAIrDzsUpoCffY37z2PxNY+8VSxGTkfuxj1RHQAn3o72QZMxIRmRXH81DDMp
	 JmEzNSPvcgmfxAj2fwJO+cT5J6MwTgNPv8o+i8M9kz2EA88HM+b
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1aba:9cb7:e067:aab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F20A2200BC;
	Thu,  4 Sep 2025 00:57:26 +0000 (UTC)
Date: Thu, 4 Sep 2025 00:57:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
	'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
References: <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ShMUcROelNfeRgMR"
Content-Disposition: inline
In-Reply-To: <aLfU5sEa-RE3X4G2@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ShMUcROelNfeRgMR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-03 at 05:40:54, Patrick Steinhardt wrote:
> If I had the choice, I'd much rather adopt an ancient version of Rust if
> it means that more platforms can support it.

I think you may be assuming that gccrs targeting Rust 1.49 will
magically make it work on more platforms than upstream Rust will.
That's not the case.

gccrs targeting Rust 1.49 will use libstd (the standard library) and
libcore (the library for freestanding implementations) from Rust 1.49
and that means it will only support those platforms that Rust 1.49 did.
For instance, Rust added support for Apache NuttX relatively recently.
Even if it has stellar support in GCC, it won't work with that version
of gccrs because the underlying libraries don't support any of those
platforms.  The only thing you can target that you couldn't before are
systems that use neither libstd nor libcore=E2=80=94which essentially means=
 the
Linux kernel.  It's like using a glibc from 2009 and expecting to work
on RISC-V=E2=80=94it simply won't[0].

If you need support for new platforms, that requires a much _newer_
version of Rust.  Thus, to be able to use gccrs, porters need to use the
existing gcc codegen backend and get that code in immediately so that
when gccrs is out and supports Rust 1.91, the standard library will work
with those platforms.  The fastest way to getting platforms supported is
to port LLVM and then add them to upstream Rust that way.

I know there has been much complaint about the six-week lifespan of Rust
releases.  I myself dislike that.  But the situation is that LTS
releases require extensive amounts of work and nobody has stepped up to
do that or pay for it to be done.  Without dedicated staffing, it's not
going to happen.  That also means that individual projects decide what
versions of Rust they do and don't want to support.

We're already supporting the version in Debian stable for a year after
the new release comes out, so we're already far behind what everyone
else is doing.  For comparison, Rust 1.48 is in Debian 11, so we'd be
supporting an effectively five-year-old compiler instead of a
three-year-old compiler.

Requiring Rust 1.49 instead of Rust 1.63 makes it harder to use tools
like bindgen and cbindgen, which exist to automatically create types and
functions in one language in the other.  That, in turn, will hinder our
ability to effectively write code that crosses the boundary and
introduce hard-to-find bugs, since we'll have to do that work manually.
My experience is that these kinds of bugs tend to actually show up more
frequently on less common platforms, like big-endian systems, so we'll
be worsening the platform experience for those systems.

For context, when we ported a core service from C to Rust at work, we
used bindgen to generate C struct definitions, which made the process
much easier and avoided random crashes.  As a result, nobody noticed the
fact that we ported it incrementally over a couple of years.  If we
hadn't used bindgen, we probably would have had lots of random segfaults
due to failing to maintain compatibility between Rust and C definitions
of the same structures, which users would not have appreciated and would
not have helped our goal of making our software more reliable and easier
to maintain.

> The gccrs maintainers are actively working on that backend, and as far
> as I understand the main difference between LLVM and gccrs is that the
> latter doesn't have to be ported over to every single platform
> individually.

I don't think that's the case.  gccrs has to be compiled for every
platform just like LLVM does.  LLVM is actually easier to support
because it can cross-compile from any platform to any platform without
recompilation.  For instance, I can target riscv64gc-unknown-openbsd on
my Debian amd64 laptop assuming I can provide the necessary libraries
for OpenBSD when compiling, but GCC requires me to specifically compile
a compiler for that platform.

In any event, any portability changes will also likely need to go into
libstd and libcore, which is used identically with both compilers.

It is, however, the case that GCC supports more architectures (and
possibly more architecture/OS combinations) than LLVM.  For instance,
DEC Alpha and IA64 are only supported by GCC at the moment.

> I think adopting Rust as a mandatory dependency out of nowhere would not
> be playing nice. It may require significant effort from distros to adapt
> to the new reality, so we should give them time to do so.

We've actually had this discussion on the list several times where we've
proposed the inclusion of Rust.  This is not the first time it's come
up, or the second.  It was explicitly mentioned a year ago on the list
that we wanted to adopt Rust in the notes from the Contributor Summit.

There has been plenty of notice that this is coming down the line.  It's
not accurate to claim it's "out of nowhere" nor to claim that people
have not had plenty of time to port their systems.

Distros and porters should not be insensible to the increasing use of
Rust or the need for them to get their systems working.  For instance,
you cannot run a GNOME or MATE desktop environment without librsvg2,
which is written in Rust.  Python's cryptography package adopted Rust
over four years ago and there was the same gnashing of teeth[1], yet
little progress has been made by porters on the same affected
architectures since that time.  In that time, Debian has bootstrapped
and released an entire RISC-V port, complete with Rust.

I want to be clear I'm not opposed to supporting less common operating
systems or architectures.  For many years, my laptop was a PowerPC Mac,
and I've owned UltraSPARC, MIPS, and ARM hardware.  For personal code, I
try to test it in CI on at least Linux, macOS, FreeBSD, and NetBSD.  But
also, when a Debian package has not worked properly on PowerPC or
UltraSPARC, I've stepped up and fixed it.  My requests to other projects
when porting have been things like asking to write valid C or C++ (by
not making unaligned accesses or avoiding endianness assumptions, for
instance) and not to refrain from adding new languages or features.

It should be stated that there is a very easy way to get Rust working,
and that's to port LLVM to the platform in question.  IA-64 was removed
in 2009, but it might be possible to resurrect that out of tree if
there's interest and maybe even get it re-accepted upstream.  I'll point
out that AIX, Solaris, and QNX have done the necessary porting work to
get LLVM and Rust working over the past couple years, so it's not out of
the question for other platforms to do so as well.  And, for the
avoidance of doubt, I would be absolutely delighted if we were able to
support additional platforms with Rust as well.

Also, the approach of making it an optional component directly
contradicts the proposed policy I wrote up.  That's a recipe for
additional burdensome work maintaining two implementations, when we
actually want to make it easier for people to contribute functionality.
It also doesn't provide any of the memory safety benefits or address any
of the concerns from governments, security professionals, and other
parties about the real and substantial risks of continuing to develop in
C.

For example, there is zero chance I will implement any of the
SHA-1/SHA-256 compatibility code twice.  I'm already doing that in my
free time without any compensation at all and it's unreasonable to
expect me to do it twice or even to #ifdef out all the places it would
need to go.  I am happy to let someone else take responsibility for the
project instead, however, if they would like to do those things.

> It would be a shame, but right now it's a risky bet to build anything on
> top of Rust given that we don't officially accept it in Git yet. We need
> to first make the decision whether or not we want to have it right now,
> and if so how that's supposed to look like.

I think we had made the decision at the 2024 Contributor's Summit that
we wanted to adopt Rust in Git, so it was more of a matter of sending
the patches than actually making that decision.  As I recall, the
decision was unanimous.

[0] RISC-V was developed in 2010.
[1] https://www.reddit.com/r/rust/comments/lfysy9/pythons_cryptography_pack=
age_introduced_build/
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ShMUcROelNfeRgMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLjj9AAKCRB8DEliiIei
gU06AP9+XJ3f8HyHg5MSM5CxQ/1FUOquffM+D6DN+3yPOIaUgAD/XAaGN0kjaPO5
oL5PdXUrvtfvql5uWzdgOglwYx918Ao=
=TbzZ
-----END PGP SIGNATURE-----

--ShMUcROelNfeRgMR--

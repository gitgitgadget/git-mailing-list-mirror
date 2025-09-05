Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834E2D77E6
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082778; cv=none; b=ukVN3YqbmlVYMOgYW+KiN4z7hq7Tv2PIlIBa2L9tPPjsvC12nX0aK9xRySPTQBCmuuBI9d0mTZacawvn1P03M3v9U7bx6GK80dPLXrRnDIcfaqHp6wzfs/nLCcjIShUVrRO4yWMFUpyiRjLSXf15buBdfKKXVYRLwae90KkrQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082778; c=relaxed/simple;
	bh=J9/G1mK+Ql2k2KxVOD6W8AVFaHRpRKVeJjSocnY5l4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJIL+oiHrEfJ0gepvhZHAGxdXol+LLArItCtblZusIBHklwglJ4KSbQmnjtbbpzPk9ZU5KFPMu656cEnJzqDggD3kunv1+Fe1F/fgAOMtuUOLqjVNWyYafmgoA0u5KfhEIryQKSj/SKM21RLJ8vmqymiuOXzSbv+F+ve/WbG7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:cf90::12ac] (unknown [IPv6:2603:6011:3f0:cf90::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 56F9C340DC8;
	Fri, 05 Sep 2025 14:32:52 +0000 (UTC)
Message-ID: <11394b17-905a-4888-981c-c5b4a7f8cd62@gentoo.org>
Date: Fri, 5 Sep 2025 10:32:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Yp1AOEJkGWZL567piF7dQnUY"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Yp1AOEJkGWZL567piF7dQnUY
Content-Type: multipart/mixed; boundary="------------yUxWKq6ABLV0GX7Tlb0ppxU4";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Message-ID: <11394b17-905a-4888-981c-c5b4a7f8cd62@gentoo.org>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>

--------------yUxWKq6ABLV0GX7Tlb0ppxU4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/5/25 8:45 AM, Matthias A=C3=9Fhauer wrote:
>=20
>=20
> On Fri, 5 Sep 2025, Patrick Steinhardt wrote:
>=20
>> Over the last couple of years the appetite for bringin Rust into the
>> codebase has grown significantly across the developer base. Introducin=
g
>> Rust is a major change though and has ramifications for the whole
>> ecosystem:
>>
>> =C2=A0- Some platforms haven't yet been able to implement a Rust toolc=
hain,
>> =C2=A0=C2=A0 even though it is possible in theory.
>>
>> =C2=A0- Some platforms don't have any support for Rust at all.
>=20
> What's the difference between these two kinds of platform? It should be=

> theoretically possible to build rust tooling for all of them, right?


LLVM is theoretically an open source project. So is Rust. We can ask
people on those platforms how successful they have been at the political
side of convincing the Rust project to allowlist the platforms inside
low-level case statements of platform-specific defines, in order to
attempt the first round of "try running make, see what breaks and start
fixing it".

Hint: it did not go well, in the sense that the rust maintainers even
accepted the validity of making a proposal in the first place.

LLVM is easier to work with, at least in that sense. But not all
platforms are supported by LLVM either, and you do need a stable release
of LLVM to support the platform before you can begin work on rust at all.=


That is the advantage of GCC-rs -- it has much broader platform support,
so if the rust frontend works at all, it will likely also work on the
specific platform you care about (and the GCC developers usually don't
bite, even if you want to enable experimental support for new platforms).=




>> +The Git project will declare the last version before Git 3.0 to be a
>> long-term
>> +support release that is maintained until alternate Rust backends like=

>> gcc-rs are
>> +able to build Git. The Git project may need to rely on distributions
>> to help
>=20
> Do we want to commit to promising support until gccrs is ready? What if=

> gccrs ends up abandoned? Or takes an unexpectedly long time to reach a
> stage where it can build Git? It might make sense to give this LTS
> release a time limit instead, or in addidtion.


Well, that will one way or another mean users of such platforms cannot
use git at all, not even old versions, lest they be hacked. Bit of a
problem for an application that mainly exists for the purpose of
communicating over the network. I suppose such platforms can finally
leave the world of DVCSes, given:

- jj, breezy, and mercurial all use rust already
- bitkeeper and monotone are dead
- darcs is written in GHC (haskell) which is far less available than
  rust

Maybe it will be the great subversion renaissance.

=2E..

At any rate I do not expect GCC-rs to be abandoned, huge effort has been
put into it, many people are interested, they have funding to work on
it, and projects such as the Linux kernel want to see it exist because
they depend on GCC for their C code, want to have Rust code, and the
kernel security mitigations depend in part on being able to use the same
bytecode format for all code, to enable LTO and CFI visibility across
languages.

It is quite *unreasonable* to assume that interest will fade. No more
than to assume that *Git*s interest in Rust will fade. The chances of it
being *abandoned* without https://github.com/rust-lang/rust itself
supporting at least all interesting Linux Kernel architectures including
use of GCC as an alternative codegen backend, are... very low, in my
opinion.

Obviously, lacking the ability to prophesize the future, no one can know
if it will "takes an unexpectedly long time". Although again,
significant interest and all that. Not sure that would be my biggest
worry. They seem to be making reasonably effective use of their time
projections so far, though I will be happy to take correction if someone
knows something I've missed...


--=20
Eli Schwartz

--------------yUxWKq6ABLV0GX7Tlb0ppxU4--

--------------Yp1AOEJkGWZL567piF7dQnUY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaLr0kQUDAAAAAAAKCRCEp9ErcA0vVz0c
AP9gvNT67WF27GiSJDMu8huRq/mhngBIAslgTVh7ZHkQAgD+NG75mHHIL+OybAI6RHr7No3dlG6O
rvoiF2wHj1Lt7AA=
=3NCu
-----END PGP SIGNATURE-----

--------------Yp1AOEJkGWZL567piF7dQnUY--

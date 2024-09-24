Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A631DFED
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186398; cv=none; b=iH/FwGDeq86Qv7VENQBmSZE/HECbAnudbDHO466/vPa1eYNE7dtjRwzc7UpbsIIGAnFV2WNFH+hUW/2DtzLQ3aGuGbHh+oCMAqtUtaEXkIRVRy4JhmTInGIPAfXPkAcbxUMkWl82JxANrVzAEXZim5CB7iyc/eG37jXbFtCoSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186398; c=relaxed/simple;
	bh=ivN9a0jFqSxH+csYI3lB9hfvUdlZ6/URfaUC/mO0dk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSf65KWkNpowzQ1Ek25GbVyJsYpEDlUoqHizpJ5LURBNV0MijcL6TtkzgWr/Z4JkdtH7DAmi2VA4OCfYiRmfnLrM6oBBdlM3sQX479FioaJFT+inb4dS7jHbH4c48tWXcCCUZaO4BrKslITtMpAj6+dudoP2v3gic76iw26O1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
Date: Tue, 24 Sep 2024 09:59:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im>
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
In-Reply-To: <ZvKsH1Ct-YwBPA_f@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d1q0qSpkAIA8dyu0D0jXGiyN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d1q0qSpkAIA8dyu0D0jXGiyN
Content-Type: multipart/mixed; boundary="------------xnI8c6q08VefNfw0x9O4c0bQ";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im>
In-Reply-To: <ZvKsH1Ct-YwBPA_f@pks.im>

--------------xnI8c6q08VefNfw0x9O4c0bQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/24/24 8:10 AM, Patrick Steinhardt wrote:

Thanks for the CC to this interesting thread. :)


> On Wed, Sep 18, 2024 at 03:39:13PM -0700, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> We seem to get fairly regular bug reports about the configure script,=

>>> presumably because most contributors are using the Makefile. It would=

>>> certainly be nice if we could get the CMake support into a state wher=
e
>>> we could consider dropping the configure script.
>>
>> While I would agree that two is better than having to support three
>> build procedures, I am not sure how improvement of CMake support
>> needs to be a prerequisite for removal of autoconf.
>=20
> I'm mostly coming from the angle that autoconf is likely used by system=
s
> that are not perfectly supported by our current, static configuration. =
I
> don't want to make the life of such system integrators harder by having=

> to figure out what kind of arcane functions they have to set manually
> now to make things build on their platform again.
>=20
> I'm not really sure whether distros _do_ actually use autoconf. Checkin=
g
> a few distros:
>=20
>   - Arch doesn't.
>   - Cygwin uses autoconf.
>   - Debian doesn't.
>   - FreeBSD uses autoconf.
>   - Gentoo doesn't.
>   - NixOS uses autoconf.
>   - OpenBSD uses autoconf.
>   - Ubuntu doesn't.
>=20
> So basically, we'd be making the life harder of anybody who doesn't
> conform to the "standard" way of doing things in Linux, which I think i=
s
> not exactly a nice thing to do.


I think we'd probably like to use the configure script rather than the
raw Makefile, if the configure script was supported.

It would fix things like git failing to cross-compile because
curl-config doesn't work for that, assuming that --

Oh yeah, the configure script isn't maintained well and doesn't use
pkg-config. :)

See e.g. https://bugs.gentoo.org/738218 which mentions pkg-config, even.


> And that's why I think we should have an alternative way to configure
> and build Git that can act as a replacement for autoconf, with my vote
> going to either CMake or Meson. They are a proper replacement for
> autoconf that makes the downstream maintainer's jobs easier while also
> bringing additional features to the table that we don't currently have.=



Let's say, rather, that they are an alternative for autoconf. And one of
the good qualities of them as an alternative for autoconf is that you
can actually build on Windows, without needing a mingw toolchain to run
a shell script.

An actually maintained autoconf script makes the downstream maintainer's
job easier in all cases...

=2E.. and also makes the upstream maintainer's job easier in some ways an=
d
harder in other ways, because autoconf is hard/annoying to get right as
a maintainer. This is due to the complexities of m4 and mixing that
inline into "m4sh" -- which was a logical tradeoff in the past, when
Windows wasn't as relevant and the GNU project wanted to design a build
system that maximized the benefits for end users, including "do not need
to install any software to run ./configure", even if that sometimes
meant making maintainers' jobs harder. I've never seen a project with a
*well-maintained, correctly written* autotools build system where the
*unix* end users had complaints about the use of autotools. The
complaint is inevitably that autotools wasn't correctly used

Still I would prefer meson over autotools any day of the week. I'd also
prefer autotools over cmake, mind you.


> Eli makes a couple of good remarks in [1] about things that both CMake
> and Meson bring to the table in addition to that, while also mentioning=

> some of the benefits of Meson over CMake.
>=20
> I would be okay to make Git work with such a build system myself. The
> current CMake build instructions can be used to _build_ Git, but AFAIU
> they cannot yet run the Git test suite. Dscho pointed me to a couple of=

> patches from =C3=86var that work into this direction, and I'd be happy =
to
> revive them. I'd also be okay with picking Meson over CMake if that is
> what people want. But my ultimate goal would then be that we have at
> least one CI job build and test against such a build system and give it=

> the "official blessing" as an alternative way to build Git.


Like, erm, many people :D I spend vast portions of my day inside git. I
am not very good at C, though -- and the likelihood of git being
completely rewritten in python is quite low -- so I generally do not try
very hard to repay that by getting involved in git development (I have
some humble patches consisting of a single patch series, which I do feel
pretty proud of since it enabled a very useful workflow, but still:
ultimately amounts to a one-off event).

I do know build systems pretty well though! :) And I'd be happy to
collaborate on Meson and help maintain the build system support in the
long term, assuming the consensus is that people think it would be a
neat idea to add meson support (regardless of whether it serves as a
primary or secondary build system).


Although I'm uninterested in personally working on cmake, as you
probably predicted.


--=20
Eli Schwartz
Gentoo Developer and Meson Build maintainer

--------------xnI8c6q08VefNfw0x9O4c0bQ--

--------------d1q0qSpkAIA8dyu0D0jXGiyN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZvLF2AUDAAAAAAAKCRCEp9ErcA0vV8N8
AQD6hCR64TqjDocK+oGe5eFYljuM//ESuBCTCDHSwXauFAD/ZxN0tHv//h+cqkk++R4Cw1GLUXFR
1RmZDQqpIOWFWg0=
=OVJ7
-----END PGP SIGNATURE-----

--------------d1q0qSpkAIA8dyu0D0jXGiyN--

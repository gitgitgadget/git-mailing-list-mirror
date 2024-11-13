Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11B7E111
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509858; cv=none; b=RHfAAoHkW5i96w34MoYDPsaLhG24rGk2uoNwwAuuHMW6w6Meq903zNz8PBB2lBAHzA3ofR8+ntqeTRxvq7uK26ePkHajOzD8DtsAHT/oQYDM+Oi5DSzyxQCSygePu15sO2lT3uD5OO8ouLZHxK91ZlQcJswmc1WBFKf8xXnOXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509858; c=relaxed/simple;
	bh=TFAAfCWwbjLjKZIdTeerniz8pM4V3AztIpHU72jcYVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbnRaTmxi8zXtvU0IR6U0j4XuiDP9BgVy5anNV80f9BaBC+Dcs+iHIdxu1ID1b0k5E7O/gGP5ksXzCPwzMtH8mlETXe8fFW4u+E/AS4Q+QB9YoKX9zB/QFFy3NW3vtPWA2PJQc1JexngYDXtA77cV1lr0sKj4kN96FWran///+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <e94b2d97-a2fe-45b0-a5b4-89c8140b5e4b@gentoo.org>
Date: Wed, 13 Nov 2024 09:57:32 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: David Aguilar <davvid@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Jeff King <peff@peff.net>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im> <ZzRvsOeLsq3dJbGw@gmail.com>
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
In-Reply-To: <ZzRvsOeLsq3dJbGw@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AfXMVdIpziZZxH2ErPIdxATg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AfXMVdIpziZZxH2ErPIdxATg
Content-Type: multipart/mixed; boundary="------------6GsASb0zmyLs9vmWKmhqFSMf";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: David Aguilar <davvid@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Jeff King <peff@peff.net>
Message-ID: <e94b2d97-a2fe-45b0-a5b4-89c8140b5e4b@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im> <ZzRvsOeLsq3dJbGw@gmail.com>
In-Reply-To: <ZzRvsOeLsq3dJbGw@gmail.com>

--------------6GsASb0zmyLs9vmWKmhqFSMf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/13/24 4:21 AM, David Aguilar wrote:
> As to why I consider Python a liability ~ this is more of a concern for=

> Meson and it doesn't really matter for end users, but Python has a
> proven track record of making breaking changes.
>=20
> If you're building everything from scratch with new versions of
> compilers and tools then the C++ project is the one that's going to
> build just fine a decade from now with little to minimal effort.
> Python doesn't have that track record.
>=20
> Even though CMake is written in C++ (which is unacceptable for some
> projects), this is subjectively one advantage that CMake seems to have.=

> This is a moot point, though, and perhaps Python will eventually reach
> this same level of respect for not introducing breaking changes.
>=20
> Furthermore, I suspect that most contributors are simply going to
> "apt install meson" or "brew install meson" so it's not really that muc=
h
> of an issue in practice for the majority of users/contributors.


For what it's worth, meson is aware that python breaking changes are a
potential issue. Although the general python ecosystem is fairly lax
about this -- on *all* points across:

- cpython itself being backwards incompatible

- projects making breaking changes in a micro release

- projects deciding to only support the latest, or 2 most recent,
  versions of cpython

meson pedantically avoids non-standard-library dependencies both for
bootstrappability and for points 2 & 3.

Regarding point 1, meson can't do a lot other than adapt. But the latest
version of meson will always support *all* non-EOL versions of python,
we do prerelease testing of cpython betas, and we do not drop support
even for EOL versions of cpython unless, having carefully evaluated the
benefits and negatives, we decide that the advantages of relying on a
new version outweigh the downside of preventing people on older systems
with older cpython from upgrading meson.

Currently that means we still support 7 different versions of cpython,
including 2 versions that are EOL (and 4 versions that built with c89,
before the migration to c11).

Of course, as you say it's a bit of a moot point given that muon exists.
But I just wanted to clarify that meson does take this concern seriously
and we try to do everything we can to make that work -- even when some
meson maintainers are unhappy and feel that being unable to depend on
unpredictable third-party modules cramps their style.

We know that we are core FOSS infrastructure, and are used by other core
FOSS infrastructure projects such as init systems (both systemd and
openrc), graphics stacks (mesa, libdrm, both xorg and wayland), desktops
(gnome has an official directive to use meson), and a variety of
freedesktop projects, many of which need to keep building on LTS
versions of Debian oldoldstable (not a typo) and oftentimes on even more
surprising platforms.

And in some cases we've been a bit influential in getting cpython to
revert breaking changes :) e.g. python 3.13 reverted the removal of the
importlib.resources "Functional API".



--=20
Eli Schwartz

--------------6GsASb0zmyLs9vmWKmhqFSMf--

--------------AfXMVdIpziZZxH2ErPIdxATg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzS+XAUDAAAAAAAKCRCEp9ErcA0vVxkb
AQCiqxLPMfRsz+vcQXot1Ucd3sp8o5L/G/rRPNlltCv1IwD+OPoQ0kCPV/C9101MFZrWm5dFGbJf
+s8lhdaiE0l/5A0=
=UdsS
-----END PGP SIGNATURE-----

--------------AfXMVdIpziZZxH2ErPIdxATg--

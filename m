Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999205;
	b=FhP90ZGo0mLkUXZ8T1VAXx9l/rdNEG+JnPhRjTf5PNgqNyzEhWcGRhO5t4p5HMWKdwR5
	 lC9R096ihBdCS6kSZUPu1zE89AjOr/WjzJSHMvBAG6BAEx/SgFc2rvRBdDLHwj7hOuI+B
	 KHgyBOLeIwcDa6t2w7oBuEwEtCqrB00ey2qG2S2QtIE61dGNrssNTIlViDGTlWlo/uk4i
	 1FSN+PTOgM5s2Pc0Or0NCGTznxYUXfZ5XcP1MAtL5VydAhPBw51995Gus4cWC74gAJECj
	 RrGriEjdGtHio8CNAOv6aKfvI0r2PUkyBgis0Q9jvPhD8Ygch/nRok+wgyK1b4GgmNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999205;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bZDEg8tB1Swi+2NcFNFuIlvA/E2v3YSIpH3jbgeOi44=;
	b=ISEOHIDjV3IUc9qqZbxthWXdhNjkKMMHrmGUDViUHN1swO/8tZ4wYgXgqVgpoWqmTvfX
	 6F3RLnwtBp0py04FEncG/SOHaujnmVqVLfdp6ayYQEXdEH2ZbS1bjgBrv7Q6x5HiISs85
	 MHYOqAiqCtPkSkg53Xwo85kX8B9BJQAP+vRVt9j6DDmvkeodO+glwdE/dWcOsp4fHXbuI
	 UnDs1TaR/+p+bjXMhUYOjqYiDpP0BHI5Lw0cESoj/5ohYqcYZ/v8fyQthMU0FyWCpLYye
	 UDXJ5CVjkpJYvH/WgjV78SkgBvoE9hVGcb3NY/uPITgVfUOGGmgVvZfHw3HV7/+V1ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZrUzxpn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FB606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZrUzxpn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0131F0089F;
	Fri,  6 Nov 2026 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999205;
	bh=bZDEg8tB1Swi+2NcFNFuIlvA/E2v3YSIpH3jbgeOi44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MZrUzxpnOhN/Pd8oYzlvMwFbsBligQtCCOIJGUh8KNDqC2Pje5gdK4rs2xagPqU4E
	 /p3RsjFTmS7SS/RanebdAvhJapHPMq7L37qxrQ8dkwQK9r1Vo0C78gVpHUBFWhjwVe
	 w/R9o4JZ4UIqdw5dBAbJfjCuWloCsbef0veroZA1gMcsHmyXwk7mbLat50oqk527Ca
	 gmmXzhBq/yTFRptS5u5I0Tsm66Xn8Zp05rWiCXULVrWqpmeXLMC09J2rmSfeGxPGfZ
	 wMPA1oUWfniSy2keJGyO0QDAtD7OaYZt6F+lGbSuRBx7QmZIsQrw8vK6vFjX+ooqWj
	 0uM9QRSBdBcLQ==
Date: Fri, 6 Nov 2026 22:06:38 +0100
From: Alejandro Colomar <alx+git@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, git@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: git-ls-files(1) avoiding symlinks
Message-ID: <au49oFqexVxPUm-2@debian>
References: <au3lu4jYwZ5hBZSy@devuan>
 <AE63992D-7BEA-413D-A372-78708CFA8F6F@gmail.com>
 <au4rmQRjRtIv1Oru@debian>
 <xmqqeccxhg0f.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mq5maq4vgfxettg"
Content-Disposition: inline
In-Reply-To: <xmqqeccxhg0f.fsf@gitster.g>


--2mq5maq4vgfxettg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+git@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, git@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: git-ls-files(1) avoiding symlinks
Message-ID: <au49oFqexVxPUm-2@debian>
References: <au3lu4jYwZ5hBZSy@devuan>
 <AE63992D-7BEA-413D-A372-78708CFA8F6F@gmail.com>
 <au4rmQRjRtIv1Oru@debian>
 <xmqqeccxhg0f.fsf@gitster.g>
MIME-Version: 1.0
In-Reply-To: <xmqqeccxhg0f.fsf@gitster.g>

Hi Junio,

> Date: 2026-11-06 12:16:48-0800
> From: Junio C Hamano <gitster@pobox.com>
>
> Alejandro Colomar <alx+git@kernel.org> writes:
>=20
> >> > With -z it becomes a bit tedious:
> >> >=20
> >> >    $ git ls-files -z --format=3D'%(objectmode) %(path)' \
> >> >    | grep -zv ^120000 \
> >> >    | sed -z 's/^.* //' \
> >> >    | grep -z '\.[ch]$' \
> >> >    | xargs -0 grepc creat;
>=20
> Shouldn't the grep|sed|grep be doable with a single sed invocation?
>=20
> >> > I expect git-ls-files(1) could make this much simpler, though:
> >> >=20
> >> >    $ git ls-files --type f \
> >> >    | grep '\.[ch]$' \
> >> >    | xargs grepc creat;
>=20
> Not really.  Why is "--type" have to be so special?  What would the
> next person ask for?  --size?

Indeed.  While looking at the implementation of git-ls-files(1), I
realized it wasn't easy to decide how to implement this, as it has other
types (objecttype, which is blob/commit/...).  I thought perhaps
--objectmode, but then I'm not inderested in searching specific modes,
but rather filtering out some.  Perhaps in this case it's more
appropriate to have my own local command 'git-find' that does what
I want.

I've ended up doing this, and now don't think a flag in git-ls-files(1)
would make much sense.

	$ cat $(which git-find)
	#!/bin/bash
	# Copyright 2026, Alejandro Colomar <alx@kernel.org>
	# SPDX-License-Identifier: GPL-3.0-or-later

	set -Eeufo pipefail;

	git ls-files --format=3D'%(objectmode) %(path)' \
	| grep -v '^120000' \
	| sed 's/^.* //';

And will eventually add a -z flag for this command when I find I need
it.

> The "ls-files" plumbing command is designed as a component to build
> your own pipeline with.  Don't throw in random unrelated features to
> it.  In the longer run, it is not a good substitute for improving
> the skill to construct a good pipeline.

Indeed.

> Learn the tools available to you that you already have heard of, so
> that you can make better uses of them (in this case "sed").  If you
> squash the grep|sed|grep pipeline into a single sed
>=20
>     git ls-files -z -s "*.[ch]" |
>     sed -z -n -e '/^120000/d' -e '/^.* 0	/s///p' |
>     xargs -r -0 ls -ld
>=20
> the result does not look too bad.

I find it simpler to have a simple grep -v rejecting the lines I don't
want, and then sed(1) getting rid of the stuff.  The command above seems
interesting for performance, but compared to the tool using the file
names, that's probably negligible.

About git-ls-files(1)'s -s, I think it's easier to parse with the
%(objectmode) in the format, as I don't need all the other information
printed by -s.

>=20
> One unrelated tip for better readability is to end, not begin, your
> lines with the "|" pipe characters.  That way you do not have to
> sprinkle so many unsightly backslashes ;-).

I like to have them at the front of the line because it shows more
clearly whether I'm piping a command or starting a new pipeline.  I got
used to the backslashes.  After all, the first few characters of a line
are all aligned, and the most significant ones.  Stuff to the right I
tend to ignore it as noise.  :)

>=20
> HTH.

Yup!  Thanks!


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--2mq5maq4vgfxettg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmruQVgACgkQ64mZXMKQ
wqm3xQ//d/4pFbXvmYPJ/BU4a15hj16T4g7t8WAm0uimhuN5U6Mj13bna6r/UTuf
UOYvH5Bq8NCyZaLJR2pCHHR6Ag6P2L/NsLrWrAaqh/HQRDsEKKRdqjZspSlSc0qg
H6UZCtfPfRS4xZIzCQab4hDxj578Ygj+OZVL4QpjVUr3LZYqpiU5lZq0SThTw7KW
ImtOmJ2i5OFMGBGIaBstq6qMgN4dccFLswmI+vlWgiPznzb0qsJE3AMznVbkHAcI
gDLiD7YjRiFWSAA5xTK7z4YCkJ0yfrsaGHkwH2/puIFvxbpFNtY2ONMOf1KJCQcX
VguahWCNQ8MdqFionX6teJ7ZNwL+7VzGVYM76hjn9SiOIZ/6C+uAzi8gEAUYw/iO
PLZ0rGsbxierBNmfdxTGuvBz48eM9fXNd8wMwzz5VpS8qkXKKgk78+plpra0Fk8w
C5NX911xdkF+RU00ZM5cNyxQr9eKQAPH6WWrUNCYdXOygckd6tfg1x+EFPNiERil
t1Hpt7tqu+A3N5VQvhljfa00FNZGSVA2rS8viorN9CblslB2OLxNg5+SY3Y+kYn3
C+5hjgsg5KKux+iGZYBMo26QtVrue/2zlnaTgLA+oxS9OxXGQ3A86y8BvrDuwaSl
f25agyJS6Obzu4c+cheHMHK0MDPYn9rYZIvhpV08EtuCPcZq36I=
=njVY
-----END PGP SIGNATURE-----

--2mq5maq4vgfxettg--

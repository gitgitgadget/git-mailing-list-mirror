Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE946C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6466206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oyKtAZMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBVSDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:03:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38978 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgBVSDZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 13:03:25 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 119D26079A;
        Sat, 22 Feb 2020 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582394604;
        bh=Uq3tRzZfDmRLHw2+72/KwhAKIu250DAb2Z6SX5oNxEg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oyKtAZMNng8gBxy53eQpnIicq4BAy6TFS9YJwchOsXnuAeF+7iN7KfgaJSai3biya
         qJmBxGU3XvXfDidB6y8UvP+suO51ktNvGQ5WcZVIIa1GpGCqfkOwa4JU1cs6XS+fCy
         qHmXTAr7ynZouqL1OvJJN7+CTEoN8Q2+ZFJTmAoSgR+XGLOms1kRstru2TRKE2R77R
         OefjcXtmM2Fw+N4ibpEJVhktRlhYUCSne/wXZpSw0QIAZfYcvGcYyNQp3b6hbH9UUD
         CB3ZcozMel3dJSylEYiLb9Wf950jNylYK5MUwrljjCo4WMUvjYni0VktZ9Z+B6u+Tg
         Mi7IhT63hGG2qiSV7rChJWO7McnvrD5SueOYMNp83Qwyv21ic/NpZ8LLBQ57iB+4Mi
         hU4Z4ryknk3nEFTF+eakhutIr7VjwPU5V870JiKwEnk0VLfvcSRgGvzhpBFTAf38aq
         6vAKi1WUVm/3TLYQYYowcvF4FnhRWJUOxVnsGNeH/rocmQzuIYc
Date:   Sat, 22 Feb 2020 18:03:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rasmus Jonsson <wasmus@zom.bi>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/1] t1050: clean up checks for file existence
Message-ID: <20200222180317.GF6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Rasmus Jonsson <wasmus@zom.bi>,
        git@vger.kernel.org
References: <20200222071335.27292-1-wasmus@zom.bi>
 <20200222071335.27292-2-wasmus@zom.bi>
 <xmqqtv3i5xhx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline
In-Reply-To: <xmqqtv3i5xhx.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-22 at 17:43:06, Junio C Hamano wrote:
> > @@ -65,7 +66,7 @@ test_expect_success 'add a large file or two' '
> >  	test $cnt =3D 2 &&
> >  	for l in .git/objects/??/??????????????????????????????????????
>=20
> It is totally an unrelated tangent, but brian, are the lines of this
> kind on your radar?  The object names in SHA-256 world would not be
> caught with the pattern right?  The fix probably belongs to next to
> where OID_REGEX is defined in test-lib.sh (this is a glob and not a
> regex, though).  Perhaps the original should have been written like
>=20
> 	# somewhere in test-lib.sh
> 	HEXGLOB=3D'[0-9a-f]'
> 	HEXGLOB38=3D$HEXGLOB$HEXGLOB$HEXGLOB$HEXGLOB$HEXGLOB$HEXGLOB ;# 6
> 	HEXGLOB38=3D$HEXGLOB38$HEXGLOB38$HEXGLOB38$HEXGLOB38$HEXGLOB38$HEXGLOB38=
 ;# 36
> 	HEXGLOB38=3D$HEXGLOB$HEXGLOB$HEXGLOB38
>=20
> 	OBJFANOUTGLOB=3D$HEXGLOB$HEXGLOB
> 	OBJFILEGLOB=3D$HEXGLOB38
>=20
> 	...
>=20
> 	for l in .git/objects/$OBJFANOUTGLOB/$OBJFILEGLOB
>=20
> and then SHA-256 series would just update OBJFANOUTGLOB and
> OBJFILEGLOB patterns, or something like that?

I actually just saw that particular file the other day, but had not yet
written a patch.  I think we could write a pattern for that which would
be useful.

We do have test_oid_to_path, which takes an object ID and inserts a
slash after the first two characters, so we could do something like
this:

  for l in .git/objects/$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]=
/g')

That's not very readable, though.  I'll try to find something a little
better, or hide it somewhere behind a variable in the test setup code
with a comment.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5RbOUACgkQv1NdgR9S
9ovKfw/7BG+pk+665hr04YPD2qQa0mBhBEMmK9azyjxRy5YM4s+cSI4fnFepfFqD
LHZH1CG1+5ChGTG7vnq68E/5iQ14Xr1A1AEiwTneQC7mxebL8hOradVK3B8F9jdg
2WUUFUvVWK1pRem0waGUtUFzT1v5THeK54gJroiETW57Vx+eFCESvCwfI+Lj6oYE
XH211BD3K/D8k1DYBACb+wTw+VWTW3dqbAjHee2Oq9u5JdaHRxdnQXoc7S31wM++
3WHZe1H701fc2cRnBIP+UfJPtcrT8deBoeh+MekJjEdd4YzYYKOqoOvj+2lqgEjM
i9X2K0zf1o5QQL8bzxTLHHhyazxmGFMcMZz0rvR8bHAA33OW49TCINSZFpE4TEyj
w9CTpcbE8zQtHuAQA3y8maLt7td/ZZ8N+6K0NTGK1pbN4sZoEakZaUBJUEzGkSi4
Nt/hdcc5LAlIpHvzwDDxY0OWmhm/hoIb9fdAHfbbDiFK5BIaVLFlonFpIZkpTw5s
lHNpcUWaPUhKm4nzitcUoczK4AxzRDVUxBggj0JGmVJ/7I+Z2xhF/dfyL0cEljuG
wUI8rWyo78kw/zkLvAxxyHvfEQ1I5ElEKrjGDAf1+zh+FwyP11PxUEGQNrzM6Z1H
W1rEOVG24GGJWEC0y3WDmI2+4GH24QDpFBcIBoXTiJe4IlAacIw=
=rQuZ
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--

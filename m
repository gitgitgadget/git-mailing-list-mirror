Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59991C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F13B6112E
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhKNTKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 14:10:35 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:42750 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 14:10:22 -0500
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Nov 2021 14:10:22 EST
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0DB9C5D403;
        Sun, 14 Nov 2021 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636916247;
        bh=qFh9MM5chIWXlLoouU5amlXIowu9MAscbJkza4R8nQU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Od+IeSOI2vdQNuJ+VI+p3kLd+OCAYVEG4WzWDeAGcBujBciTzMlsSS8faLitX2ZNV
         6X4MkZkJI66/cCtfq12JWmdMUdkIPCRgOeyYxdRmkFabcjXhaNH97WmZRrRI+BO8mU
         wXjXj2Kr2obfJ+nv5zk9dOCaOa9ml1+W37T7DBhPADtQY/Fno6jufOhGjsGpDeuO5O
         xEvkOTEllHylaqCvkrtMnPeSuKHPBzOoSBWccdvVRZKQrDYuAlSdtl3Vv55z3AkKlf
         qhxQIBzT06vcmaEh66NuQoxW4hLQIOJX3er6JpdVjh04i3foqv8hEIt6wb06OIExn0
         S+yBMusyr/Wi4moS2+OqbH+laI8WI91IgMRY++cki8AtLmUZshdtWJ5ezR/Sdf5LWt
         LuAyttHu5I6sGweRbO3xzClQGLpkXpE5/0AFGz+8toAlcUI+e7QEgtv9PdH3KTvWjb
         FfdqUmL1PPf7JZMvGAD1CLumJ7pXId2SQuDnT8QPvjAY2rmUIsM
Date:   Sun, 14 Nov 2021 18:57:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Is 'for (int i = [...]' bad for C STD compliance reasons?
Message-ID: <YZFa3YDe1/a6uZod@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g>
 <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g>
 <211114.86zgq6si94.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XuXDoLDWz82yHmpu"
Content-Disposition: inline
In-Reply-To: <211114.86zgq6si94.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XuXDoLDWz82yHmpu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-14 at 18:25:31, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> The issue on CentOS 6 isn't one of incompatibility with C99, but that
> the version of GCC refuses to compile C99 code without -std=3Dc99 or
> -std=3Dgnu99. See [1] downthread of one of your links.
>=20
> But yes, it would be the first C99 feature where we have a known
> compiler that needs an opt-in -std=3D* option to support the C99 feature,
> I think.

Yeah, as I've mentioned in the past, the impediment to C99 features is
MSVC.  All Unix compilers support it because it's obligatory for POSIX
1003.1-2001, and they have for some time, even if it's not the default
behavior.

MSVC recently learned C11, but I haven't fooled around with our CI
enough recently to see if I can get it to use C11.  I'll try to play
around some more.

I should also point out that CentOS 6 is now EOL and not receiving
security updates, and as such it shouldn't be a consideration in what we
do and don't support.  I think providing 10 years of support for an OS
in our project is already exceedingly generous, and most other projects
don't do so.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XuXDoLDWz82yHmpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZFcFQAKCRB8DEliiIei
gQJiAP9Mme007RrSOr8DyQjqtGeggChDu5NuygpoU7ghsvjJnAEA3xcrOL50SWqh
tJwUD4D/1+uKk6vUhTwgyTuz3nfwFwk=
=Oboh
-----END PGP SIGNATURE-----

--XuXDoLDWz82yHmpu--

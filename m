Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB861F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeKMJRh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:17:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbeKMJRg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Nov 2018 04:17:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8578D6045B;
        Mon, 12 Nov 2018 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542064935;
        bh=z5cJq5tuTWS3jvPBGf6Rdfiu8aGmNEPzCDLUXFbOnnw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=a5+9WKfT2wpu3xouejYSoXXWCjevDRK56rNn++SkMghRk+JgM9IghFiPsNua37Ibv
         NbqMuPlk8W3peg628nkMRkzvuI1bh4u/k7A8lyORvlyQhnUbgi3Oqnr9xh32911oxp
         yasoAFmy8CZa4y8X+O7PrqBVzYP8Nys7v8Z+s/mJVKL7eOsVWvi7rpa7doWIDfcqoE
         gko8inLS6cB0TNak0lbTulQ9ZZ0mpYKCgUTIP0cQO6jUnoGb2TaApJ0tQQDP42cn4f
         NM6bvE/3E6pKoZ9X1pfHE6w+fiz5PJyofjFE56gX2rwEs388r9a2hnOFMMC8PbaDDc
         TDHMsI32gMqgYDcuvZf2CP4/DtX5mRxm7mc8Pj+JpsnUmfHiTM2h5/bocsOJAViMbi
         rwRhT0Kl5EegEYRUluthKatH0dq5+Z8ENPXEqxVrR+hGSUalvs6u3YPiFW3XvUK4yl
         c9tbQUIWd1zkn1KKSJCuELyCQkJ+r9kaovnSTqzM8CWCobvX2om
Date:   Mon, 12 Nov 2018 23:22:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Message-ID: <20181112232209.GK890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>, Kevin Ballard <kevin@sb.org>
References: <20181111095254.30473-1-pclouds@gmail.com>
 <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rex5+51txc1ort/q"
Content-Disposition: inline
In-Reply-To: <871s7r4wuv.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Rex5+51txc1ort/q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2018 at 01:33:44PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> The users who need protection against git deleting their files the most
> are exactly the sort of users who aren't expert-level enough to
> understand the nuances of how the semantics of .gitignore and "precious"
> are going to interact before git eats their data.
>=20
> This is pretty apparent from the bug reports we're getting about
> this. None of them are:
>=20
>     "Hey, I 100% understood .gitignore semantics including this one part
>     of the docs where you say you'll do this, but just forgot one day
>     and deleted my work. Can we get some more safety?"
>=20
> But rather (with some hyperbole for effect):
>=20
>     "ZOMG git deleted my file! Is this a bug??"
>=20
> So I think we should have the inverse of this "precious"
> attribute". Just a change to the docs to say that .gitignore doesn't
> imply these eager deletion semantics on tree unpacking anymore, and if
> users want it back they can define a "garbage" attribute
> (s/precious/garbage/).
>=20
> That will lose no data, and in the very rare cases where a checkout of
> tracked files would overwrite an ignored pattern, we can just error out
> (as we do with the "Ok to overwrite" branch removed) and tell the user
> to delete the files to proceed.

This is going to totally hose automation.  My last job had files which
might move from tracked to untracked (a file that had become generated),
and long-running CI and build systems would need to be able to check out
one status and switch to the other.  Your proposed change will prevent
those systems from working, whereas they previously did.

I agree that your proposal would have been a better design originally,
but breaking the way automated systems currently work is probably going
to be a dealbreaker.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Rex5+51txc1ort/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvqCyAACgkQv1NdgR9S
9ouDOBAArRgQLxLa8rTe2TJTUaWOGVX7Y3xPG+d5n2gTBok3HVzHliW3PItLn1t0
vphsTvixnCJt/SdhByht0x8xisLxh6Sui3QAGLMuRd8LhfdZm8QTr6DAjFjx+EF0
AtP3QHfzL/12z598wmTcsVybTTRvEye0VXlPSql2lRiGgW69v0hZDF0Sg+bHgm78
/o2dO7JOMH4CGjuUyXGFVCGKiTBCx1W3/w3qC8QiVri8wPo7zfewqs6DhZWAEmQ+
Khnot0/RB8vAFecos4KvTKGfD8Gd2WqUUL042wIlqsGoOS5HqWo+rAHmD+GNdO+7
rScTdEIVC+Yrtn8wC8XF/KUSDyUnCNtvm3dUodHXoK1R1xfmcLJyxsRAGICzdccY
rAI50HJVK+n4HD4zDa9N0qk/sO76J5Mh0T93F63oIE9TtyFTfrDLUEkDF+0tJsOy
M/HVgLoU4GQmESVECg/1JaKczcnAiph4V+S1LtmjZQ3O1noMAbss7WeHMWVIF5++
9HDaWQNl25O84bgSByANuKT+U0ZxypTNk/W+QLWOpHIz0X2Q2qEXJF8fffBkEhfP
86JO5qWsSX6LpTJqEmm/PAxu2ZM7cDqINnU0ls0okCzzQET9n5YwSXDn5zhuKqv/
tPBwcL0c3/EpUrZk9DFSPFvImK04auaLUs074g3bGJw8UjpOAWE=
=1PeL
-----END PGP SIGNATURE-----

--Rex5+51txc1ort/q--

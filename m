Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F6C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DA820855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ycAvzjK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKUAsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:48:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUAsk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Nov 2019 19:48:40 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB24C60458;
        Thu, 21 Nov 2019 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574297319;
        bh=rI3tXgK3AcCfVwNVa5TDtP+j+cvO+607UGmlncwW4wQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ycAvzjK7lC56TwmdBpr7tUSB7Y8laKLD75nIRLeviBgIz8qk/D7DLIaJzHKdNPZPJ
         BVb4Gq0XXY5bSczVa77/olykf2uKG0k75sl6GNvgyHQXV/oAAjV9qfEYtUzUJZnbKQ
         zsbvRPyfRywQbaWFGe8OIXk3Ekr/bMxEhwfhktEBJ9XR9fZhQwlAmV7ud2QSus+/tg
         QnN8IcUVylo56qb6MuN17G5K58M8jJKddomigNT1UkiAja/AziLVP0R5gK6i1qPBlD
         8SwJ/KOC1TbHxqrGRpYtqO8kGmzNKxU53hl3tLalS1ZHXrb2ZKF398/qT/ARH+zEc3
         JEXilBTx+X8s/22gUHrkHYG13nqDCV4J0uObyoY85caPZwlUKC/HATgarc5pAeWzes
         aKcUR1YTfNjcvLhUPTb83J2A0lOmbQwcfG25cKkQtVBasxl9lWhKefnD9L+aVf3GyF
         3FBKoErLM/hvJk4JSaE85dNBhDcNUpyy10Sr83xdtoVlRbvRlOZ
Date:   Thu, 21 Nov 2019 00:48:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Commit signing and pinentry problems
Message-ID: <20191121004831.GB6430@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8n+ta4BSAE4rEfhKxe3T9poVdc94HvSk=6PEA4YbmwVyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <CAH8yC8n+ta4BSAE4rEfhKxe3T9poVdc94HvSk=6PEA4YbmwVyA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-20 at 12:41:23, Jeffrey Walton wrote:
> Hi Everyone,
>=20
> I'm having an annoying problem that I can't figure out. I hope Git has
> a setting to fix it.
>=20
> I have a desktop workstation where I sit at the keyboard about 1/3 of
> the time. Git signing works as expected. About 2/3 of the time I SSH
> into the machine. Git signing does not work when SSH'd in.
>=20
> When Git signing fails over SSH an error looks like:
>=20
>    $ git commit -S log.h -m "Remove unneeded header"
>    error: gpg failed to sign the data
>    fatal: failed to write commit object
>=20
> I just noticed this today (but it makes sense)...
>=20
>     - Go to desktop workstation, log in
>     - Go to remote machine, log in
>     - Sign at remote machine over SSH
>       - Desktop workstation will open GUI password prompt
>       - Remote machine sign operation will hang until GUI prompt times-out

This isn't really a Git problem, so much as a GnuPG one.
You probably want to use the curses pinentry input instead of the GUI
one.  If you're using Ubuntu, you can set "pinentry-program
/usr/bin/pinentry-curses" in ~/.gnupg/gpg-agent.conf, kill all of the
gpg-agent processes, and then attempt to sign again.

You may also need to set GPG_TTY and/or kill the gpg-agent process when
logging in remotely.  See gpg-agent(1) for details on configuration and
use.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3V3t8ACgkQv1NdgR9S
9ouEVxAAlyNKAsIvcsfPN73qN5JFoPzJGUzbp16Vc6hyVnt7BvimV64Nx1Lg0s7m
+Ja5gQpmL4qlU7EvK8XUB5hf2pBSEeGo0yQPOxf5eesfefLj1hJ0NaX3RjpZTsjP
l7r2ePihkkWBD8fkleFtgkdCH4qlUc0Z7Dxvb79V05RQSra3jYpMF8tDdxVjJcU+
iEv7J3BDGXjeCONLvl2CGM4hSbcv6TNznOvrfGqqC/1Ji0HiBT710YsUenIsBf+3
Vxas6HS/U83k5sMThFe+tZ9s+X149jX2IDNfyDL0sBfNrI43wBMCTvDrAaSHwNQr
/i1FWR4tTSzvuiKOpMdI/NkyFUUUZP81gJyyqeP09fNAco6OV5uwavHm6RQ+DzpT
WO18X1L7SsEX5bSxB50G3ngecyU+bRCoxSMUGEYvOyU1ZqZj5s5oHIJ96RxzvluK
nmJgEWzoy8rjDoc46hgDOQxpEwNUVrsWTS84n0cI8dtkPo4560LYYpBupdMtGYkl
L9/PD2pVO68Ss6kehBjmx4dP8ELjzP1RQTvJnUgPsteGEG8Zzo45J9EOediWsFo3
f8jibWKi5KCknwOI9vrH7ZZZAx2fWpHhXVNdZxBWqYI1vj8pl6rlCSr1Yhl/O+3x
YGJt3DhZt2LOaIPRE0gL2j8D0AzMeIlBp5tei44MVs16xKOmtQY=
=L4Yn
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

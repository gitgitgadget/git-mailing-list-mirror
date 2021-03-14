Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B2CC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5CF64E6B
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhCNUVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:21:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40502 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233634AbhCNUVQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Mar 2021 16:21:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C23CF6046C;
        Sun, 14 Mar 2021 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615753244;
        bh=b7U+dfD5ubOhGbnQucYFoCZEg6MfKMQXGwGV0Qh1+GY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FpzA5Wpm+IP7WAv1cV+HvaRnPv73b0TCMBHYr/YOcBCjHq0mILRQXYD/VRAqRgJwf
         aU3rRgu+OZncyE5jAqYsHGZVDidv/Ci7xFn51r3XF0wPJZ0a4mxgYTfGhd0r6uvAs5
         8VoKWpEAEzRR3NIJ0s9ma33ybnn3PxdoSSvIMgCK9MMUVaIziyPU+z+0Bp6vGZgGHX
         CjByvezmhZ7byIt91gP3y/sCs3DJTaKZFJl4w2X9OSzwzquWH1VUt9lVNicewmhJ9G
         cnrChqZMmavnwyK6NvImAyEdQ6ChX7LCVpoWXSGPwJpH5pJhMZFrc3bEXIHpvkqg+S
         YLQfjhZVGGb0PzAJmE3bsAJSkpbUoj+rzPzhFUfUaxoJdvd4XEf5wMbFqR7oIE49Sn
         +BEMitq04YnlN9eNI7rCQCUWWjl0SlNc2A4VJTpoXUqGLIf8budeD7e3OXjcsV8n6f
         UNGM4yJNtRRf3xjo71on7cgkW/Dj9KdVnTghh51jByA0acTgBaP
Date:   Sun, 14 Mar 2021 20:20:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christian Strasser <christian@avr-fun.de>
Cc:     git@vger.kernel.org
Subject: Re: Git install crashed nearly whole System
Message-ID: <YE5wFxE5RPew5zrJ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Strasser <christian@avr-fun.de>, git@vger.kernel.org
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8l1AoHVoLyrqrj54"
Content-Disposition: inline
In-Reply-To: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8l1AoHVoLyrqrj54
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-14 at 18:23:40, Christian Strasser wrote:
> Hello all,
>=20
> I installed Git yesterday on my system. For that I used =E2=80=9Csudo apt=
-get
> install git-all=E2=80=9D.  During the installation a lot of very important
> packages got removed! It was horrible, and I couldn=E2=80=99t use my gnome
> desktop environment at all! A lot off dependencies got lost!
> Fortunately, I could save my system through read out the information
> about removed packages from the apt history.
>=20
> Today I totally removed git and tried to install everything again with
> the same instruction. The same misbehavior did happen!

This is best reported to Debian because it's a packaging problem, but
I'll tell you what's happening.

By default, Debian installs recommends.  When you specified git-all, you
also asked to install git-daemon-run or git-daemon-sysvinit, and the
former is the preferred option.  So that causes systemd to be
uninstalled and sysvinit to replace it instead, and because GNOME on
Debian is configured to require systemd and not to work with sysvinit,
GNOME gets removed.

There are a couple problems here.

First, you don't want to install git-all as a package because it has
this behavior, and git-all should not be configured such that installing
it causes your init system to be changed.  That is a serious packaging
problem.

Second, GNOME should gracefully work with whatever init system is on the
system, so that users can pick the one that's right for them.  Non-Linux
systems don't even have systemd, so GNOME should be appropriately
packaged so it doesn't have this problem.

None of this has anything to do with Git the project, which provides
source tarballs only and relies on distributors to build binary
packages.  All of these are Debian packaging problems and should be
reported in a series of bugs to Debian (usually via reportbug).

In the meantime, you should install the git and git-man packages if you
want to use core Git, and optionally git-email, git-svn, or git-cvs if
you want various other parts.  You don't really want to run git-daemon
outside of a controlled environment because the Git protocol provides no
authentication or encryption and you shouldn't expose such services
publicly.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--8l1AoHVoLyrqrj54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYE5wFQAKCRB8DEliiIei
gbgUAP9uqaAhMLbo0UrqpVaTAT39Ff4Utv3SCXbfn2kSTU0ZiAEA9zQp7BFrOI/D
wZwtQSYLrGZaMU7dvOKx6dekqP9zZA0=
=5Tn8
-----END PGP SIGNATURE-----

--8l1AoHVoLyrqrj54--

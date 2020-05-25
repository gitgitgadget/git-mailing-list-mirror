Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E34C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9D820723
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="v8fQOWZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389133AbgEYRxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 13:53:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38656 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388621AbgEYRxS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 13:53:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D795A60482;
        Mon, 25 May 2020 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590429197;
        bh=RA9JnQSxZ2B7whHCrSQPrWs8pS+K/y0CXC4AsOsbagw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=v8fQOWZLsGiR6TusmtFICu/s01v6DTsqW2xfivKyPU17X2v8bgCk46O9Ra6THzBce
         GhydwlGhEOWFV9v64ayaqMdpM5+uNlr+scoWhTrkqLiTtMoovE5vCBIPhyTcTgyhYG
         p+HB3vtsSqFdpONMzs/B6Y3DyC8cEQ3ta90QQthqeI5EHC63zCB9PDKRnutegF69XD
         By7YneHaG/VIXogAreEiEo6uYXNotyYAq++A8t+u3GkIH2SmTo47wtyIqzS6Gm4y8k
         rywi8H4l6xSN6+mDpUHeDQ/lB65zE5OH2ZEipmEXNLK717U/E7vnmlvlVyO6wC67Xy
         5LIdgkYEUzEztMer2RqTHAvKHVWQAT7MbuVdfD/ZsoxNKbw+fU/mPdHbYZxKYOMQzn
         rMcaS9M8vnEYD3mQLSg82VBAR7K4MKtPHEm1n2xq38+TrzqLGPyVarP4rwpoOxOgEW
         AeVOFL5bOqCRTTekUNR1EUT4PZRVpS22rc1r3p+Ka2W1g4GzJ6C
Date:   Mon, 25 May 2020 17:53:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #08; Sun, 24)
Message-ID: <20200525175309.GD1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
 <20200525172708.GT6611@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20200525172708.GT6611@pobox.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-25 at 17:27:08, Todd Zullinger wrote:
> Hi,
>=20
> Junio C Hamano wrote:
> > Git 2.27-rc2 will be tagged soon, but most of the topics planned for
> > it are already in 'master'.
>=20
> There's a minor issue in the ss/faq-ignore topic which
> breaks the doc build on CentOS/ RHEL 6 that was mentioned by
> Son Luong Ngoc=C2=B9.  The "." in the anchor text causes an issue
> for the older doc toolchain on these systems.
>=20
> I included a simple patch for that in a reply=C2=B2.  I haven't
> seen any discussion on it one way or another.  At the risk
> of pestering, I thought I'd mention it in case it had just
> flown under everyone's radar during this busy time.
>=20
> On one hand, the doc build toolchain on CentOS / RHEL 6 is
> old and those systems will be EOL at the end of November.
> So we might find it acceptable to stop supporting the doc
> build there.
>=20
> On the other hand, the fix/workaround is quite trivial and
> nearly imperceptible to readers of the documentation.  The
> problematic "." in ".gitiginore" only appears in the anchor
> link for HTML viewers or in the plain text for readers of
> the .txt file:
>=20
>     [[files-in-.gitignore-are-tracked]]
>=20
> vs.
>=20
>     [[files-in-gitignore-are-tracked]]
>=20
> I'm not sure there's enough value in keeping the "." in this
> case to justify breaking the doc build for users stuck on an
> old CentOS / RHEL 6 system.
>=20
> I think the risk of applying the patch is sufficiently low
> that it would be worth including in 2.27.0.  That is, unless
> there is a strong opinion that the "." is quite useful or
> that even low effort isn't worth taking to support such an
> old doc toolchain.

I think since this is an anchor link it's just fine to change for
compatibility.  People are already used to slugs in fragments and
elsewhere that don't include every possible component, and I think it
would be better to produce more compatible ones over more precise ones.
The burden of the change is very small, and the benefit is much greater.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXswGBQAKCRB8DEliiIei
gd12AQCz0wDU1rrrXqk1MnyF0XrYXCYEbRBtJzrX46QWsmx5iwEA0dtvKnLG/l9J
I7aE4gjxUecR02ESLW+HG1vl99/Vdws=
=Kn04
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

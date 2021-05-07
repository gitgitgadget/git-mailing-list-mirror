Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C1BC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 20:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B219461261
	for <git@archiver.kernel.org>; Fri,  7 May 2021 20:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEGU0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 16:26:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49748 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhEGU0m (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 16:26:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 51FBD6042E;
        Fri,  7 May 2021 20:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620419141;
        bh=Z9/OGljVDlELGNuRMDSQIO2keSembuicgqL4jj+YOec=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZaAIndl+QfEKnn6Et5GUUS7tUwWFc/1CG9iHNv4tWR25Q/JT96gmZYuCA5gQBGvuC
         l27x9c+/ZpjVqJmisHlxQaW21TKFjuJLvV4VjSJZ9JA4o8mMb3gkT21SN99EbBnuMV
         kyrAaWkAABgdOvlcfdsB3DoTHtu+6P0ecwb789OM+ZxDH/VE9yYv7RlEts/IjhwesI
         qzeBLDuFDDL36+Z6Z6g2rUxDxeB2GSSUlc0Bhj470jqx6MCZLxKxMZP9JWrBdbb6ge
         OZSBoc3QEx9k5czTjZVj16Uy2W1Qn/vxgl8yBCPuapc6m3Gqa4E5DSsYyQQjQ+QxgB
         Gh1nCShU9HBRGQ+FNKwiXswy9cchAf7Nvxyry7X2oIxqblPyVbgC3aCXUQ/xK4ZfhU
         FcDwW1NBGHLbN084FwOXvlWtNtBK1Y7aWP6H/iB0xk0jRe81eBuSurQkJDkVIEuoGK
         OZSEqvNsMLBDXouK3qFBXXotZNCnq3UMKbe17oCJZTo1OUn9lru
Date:   Fri, 7 May 2021 20:25:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4/QrDivbfw71kzzY"
Content-Disposition: inline
In-Reply-To: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4/QrDivbfw71kzzY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-07 at 06:06:31, Bagas Sanjaya wrote:
> Hi,
>=20
> Asciidoctor has support for directly generating manpage, see [1].
>=20
> We support using Asciidoctor as drop-in replacement for original
> Asciidoc, but currently we need to use xmlto together with Asciidoc(tor)
> to produce manpages. However, most users don't inclined to install
> xmlto toolchain, partly because they had to download more than 300 MB
> of data just to install xmlto and its dependencies (including dblatex
> and texlive).

If you're installing on Debian, you want to install with
--no-install-recommends to avoid the dependency on dblatex or fop,
libpaper-utils, and zip.  That should avoid the large downloads.

> So completely migrating to Asciidoctor can eliminate xmlto requirement
> for generating manpage.
>=20
> What do you think about above?

I didn't do this because it makes things very complicated in the
Makefile and my goal was to minimize the needed changes and divergence.
I'm not opposed to someone else doing it, but I expect it will be a
bunch of work.

It also doesn't help if you're generating more than just the manual
pages, since generating the PDFs will definitely require xmlto and
either dblatex or fop.  I personally prefer fop over dblatex, but folks
have different opinions.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--4/QrDivbfw71kzzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJWiPwAKCRB8DEliiIei
gaq/AP9YCwsc1BUC+QnkDn1lCI3thb3DpLGDuzQissQVRvBIDQD/YXAaHG5/4ccR
Am83Kh4enkd2XYjoYWvb/dx7M6Uv0QI=
=K+AM
-----END PGP SIGNATURE-----

--4/QrDivbfw71kzzY--

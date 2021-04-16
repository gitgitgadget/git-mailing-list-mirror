Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB3DC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7253C6101C
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhDPXVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:21:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34804 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhDPXVN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Apr 2021 19:21:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A88C960744;
        Fri, 16 Apr 2021 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618615247;
        bh=8iO1mm8EEOkSZ56dH64InL/lcMqn7Nu9v4dGK+w3K44=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hfEAM2W7Lb04YfX3VLkBcWu3zlLfV39aYxOyL5jTSot9F298za0T0QrHC1BZYZz3m
         A6T6PN9YRsGfrgNoHWhbYN2g1K6rkSb3daain+JjdjoJwvjZbpBbZ8l9BGp/zCalp5
         e8BRisYX0cAYGS4z8VSKLGcc2AtfH4q6cVfVe2NOG2tHb8nO9tzgmT5Ya+WjA8pQJe
         fMj84IvSZvKwVdSiwG7Ef9q+6pl941CkgftaIgl9D4FILGYB//tu8Ddtc5fym5uqzi
         io9ig1IeGTq7qrBn1yEu3R6Qaqd4SgeB7ypryTrgOAdu9CQpe/7HgjEYRD+ZPHS4UU
         7lOTPWLfcz8C86dB1wUuvqTtj7QcvCaCMIjyP4CbAXb8CMoMKwQxi03bikVYl4rn7L
         B6tXu+SLKUPrD55Ktr0f9zjUNQXXyb0iSvY5I7dnFmWba9paixMGLSRV4js8qsebyI
         QMBmxXCjAQGGfqLpvEaNWub1yq1UeVb5y21pGP1aqFHMjoACO/h
Date:   Fri, 16 Apr 2021 23:20:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lars Kiesow <lkiesow@uos.de>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: gitk unable to handle Unicode properly
Message-ID: <YHobypuPjLTdjHIJ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Kiesow <lkiesow@uos.de>, git@vger.kernel.org
References: <20210416182121.3c824c87@pc.home.lkiesow.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LhEkD2ddcekjV0Au"
Content-Disposition: inline
In-Reply-To: <20210416182121.3c824c87@pc.home.lkiesow.io>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LhEkD2ddcekjV0Au
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-16 at 16:21:21, Lars Kiesow wrote:
> Hi everyone,
> while fixing some Unicode problems in a project, I noticed that gitk
> will not display Unicode characters correctly and may even crash if the
> branch name consists of Unicode characters.
>=20
> I'ts certainly not the end of the world (who is crazy enough to use =F0=
=9F=96=A4
> as a branch name) but could still cause problems.

I don't use gitk, but I decided to try to reproduce this nevertheless,
and I'm having a bit of trouble.

> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> - Create a git branch named with a multi-byte Unicode character like:
>=20
>         git checkout -b =F0=9F=96=A4
>=20
> - Launch gitk
>     - Crash (see below)

I don't see a crash.

> - Switch to another branch
>=20
>         git checkout xy
>=20
> - Launch gitk
>     - Branch names are not displayed properly

I do see the emoji displayed properly.

> What did you expect to happen? (Expected behavior)
>=20
> - Launching gitk, it should not crash and names like =E2=80=9C=F0=9F=96=
=A4=E2=80=9D should be
>   displayed correctly

This is the behavior I see.  I'm using the Debian experimental packages
of gitk 1:2.31.0+next.20210315-1 and Debian unstable's tk 8.6.11+1.

Is it possible your version of Tcl or Tk is not properly set up for this
case?  I know nothing about either of those; Tcl is one of the few
reasonably common languages I have never worked with.

> What happened instead? (Actual behavior)
>=20
> - Launching while on the branch =E2=80=9C=F0=9F=96=A4=E2=80=9D crashed gi=
tk.
>   The reported error is:
>=20
>         X Error of failed request:  BadLength (poly request too large or =
internal Xlib length error)
>           Major opcode of failed request:  139 (RENDER)
>           Minor opcode of failed request:  20 (RenderAddGlyphs)
>           Serial number of failed request:  5225
>           Current serial number in output stream:  5263
>=20
> - Launching while on another branch but with the branch =E2=80=9C=F0=9F=
=96=A4=E2=80=9D makes that
>   branch appear as =E2=8C=B7=E2=8C=B7

Can you tell us about your locale settings?  On most Linux systems,
running the program "locale" should show them.  I would expect something
bad might happen if you were not in a UTF-8 locale.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--LhEkD2ddcekjV0Au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHobyQAKCRB8DEliiIei
gXAUAP9ZCV4AA6AQvfS9NYxQkVAJw5+/0Krcy3AQYa4rzCbEtgEAt5LalYu/EHLs
S5hu8Jw6tAbV3FbGqODGjAJFdR9lSgk=
=vZ16
-----END PGP SIGNATURE-----

--LhEkD2ddcekjV0Au--

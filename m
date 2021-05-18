Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03729C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D970561354
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhERBan (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 21:30:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47272 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238142AbhERBal (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 May 2021 21:30:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3781960751;
        Tue, 18 May 2021 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621301333;
        bh=3DTbMoTPtBmPsMk9BkdvKWhY1AjWsr6CrScb0AXb9NU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hmOgFiSO/Q32vZXDgLT1lbAYNXDhvWCSRX0Z4NKqLxwmt8M/RjOk+fqvXziCzwVOl
         4BRVomYpl20hx/h+TFgMjOEjGH8ucheou6OUsq0fgTHlCoTKQmIALpMfiNNS04uKNZ
         JJK6RPDs3b+eXV5uyiZqfIh9auljvc9umtISyGtvCST0nzWYF1ieAdodcPTnasPBDh
         FEA1ZC1tHNy7Z2yImaDjR0Eqd4GGt8aQxA59xyNLTh+Z7i9MgxHV8FL1jkLvG4lK6s
         9b6rpb5i3zAPND9kLbvcLyCiVjuJQ9pUo30SwaGNTW8Cun4qUapdrqWgzmVnrEJ1pS
         R8IA/yQNCgC6pgjOz+TVFHZmLfeXuNivRppow1SfhpVPENrSGKcZ1M6KQ51LF72T97
         OxWNS3q4NjdfX+Nz1rABtP9B1BnPLJ1Y3Fr5vjUiIQZgyG5hO3g8Pp3Cq9uNQg9oF2
         ti8awACXt2QIjJj5dqpP/SmRpflkiurgmjp41/jUhVMCY65b+Gj
Date:   Tue, 18 May 2021 01:28:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: Man pages have colors? A deep dive into groff
Message-ID: <YKMYUUVVVJMWH7xi@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4A8hw63DMK2RbkL4"
Content-Disposition: inline
In-Reply-To: <87tun1qp91.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4A8hw63DMK2RbkL4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-17 at 16:48:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This looks much better.
>=20
> I wonder a good follow-up (hint, hint! :) would be to have
> exec_man_man() and exec_man_cmd() in builtin/help.c set this depending
> on color.ui (so we'd do it by default with "auto").
>=20
> Then e.g. "git help git" would look prettier than "man git".

As I mentioned on the patch itself, I'd prefer if Git didn't do this.  I
have my own colors configured and don't want Git to render its man
output differently from what I have.  Even if I didn't, I wouldn't want
Git to change the output of man(1) to be different from what's on the
system.

I should point out that I have my shell configuration set up to use
different colors depending on the capability of the terminal, such as
using a 256-color palette when that's supported and a 16-color palette
when it's not, so there is literally no configuration that Git can
provide here that matches my existing settings.

Additionally, colors tend to pose accessibility problems for a lot of
people.  I have normal color vision, but because I use a transparent
background which renders as grey, the standard terminal red is nearly
illegible for me.  I also know people with colorblindness who have
problems with various colors or any colors at all.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--4A8hw63DMK2RbkL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKMYUQAKCRB8DEliiIei
gberAQChEKmIzKBuymLVkB69E85zjfvfEwGqDmQhXQ5m0zxPXQD/fQNnw1DdS2jw
ihRdUSrk4eHIiTyV/r1nVlBWCM5TaQo=
=Or84
-----END PGP SIGNATURE-----

--4A8hw63DMK2RbkL4--

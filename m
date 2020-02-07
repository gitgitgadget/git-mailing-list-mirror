Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323DC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BAC21741
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 23:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="S7A6tWKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgBGXqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 18:46:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbgBGXqZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Feb 2020 18:46:25 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 138FD60479;
        Fri,  7 Feb 2020 23:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581119183;
        bh=566YGElJ45MIM2CmaEs996YdUV1+tRIsTZjOfSEHnvc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S7A6tWKc9/HEKidjhOFniRHHZ75FnCR367ts7lNxOvOvB4AIn6AdnF/H1Fxb2L6v2
         9XM8qScbyvE0QncfrOnNEUS0ar4dEf3/AzkAVW6kuZms+f5K+dnak6cENBH6jHquvD
         gdJ/3HoxhbR2CHS5UEv8pHa/wwyb/+WMuwttINp3lnp1WVfdzMCovo6+G/Npv5gtHg
         uZxedJMo7MaqemsiYhrkoIseNGZ1hs1mLg2W8wllo6dc/lwaNNyio1R1jWVwU88HaT
         5Z0ZbnFEhbzywQ4tYCL9wMEk4SUFE7aRgTfq7ljowDUTS5k5asue8DiTjJnfaGyCyp
         bVPRm+BsPUSp2LlaKsO2UcEx58jxcsvUbN7fedAplVF0VI7iKBIYAdnVa7PZQx9t1o
         tauJmo2qfNNnFHTO8XZEZYD59EDsDSVa5wLBptTQNhtA0a1HqUdTnYaQYakxrBfIot
         Nk2x/sW/19N8o+BdawiIgB/Hufb4f9ZZ2W76r3P8Fp53NcBpAYy
Date:   Fri, 7 Feb 2020 23:46:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     paul@pauldsmith.org.uk
Cc:     git@vger.kernel.org
Subject: Re: Support 'help' for custom/alias commands
Message-ID: <20200207234618.GH6573@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        paul@pauldsmith.org.uk, git@vger.kernel.org
References: <VI1P192MB025548BB0508125DF9B5852DC81C0@VI1P192MB0255.EURP192.PROD.OUTLOOK.COM>
 <005001d5dda3$5bc12510$13436f30$@pauldsmith.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <005001d5dda3$5bc12510$13436f30$@pauldsmith.org.uk>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-07 at 10:42:56, paul@pauldsmith.org.uk wrote:
> Adding a custom comment (let=E2=80=99s call is =E2=80=98foolish=E2=80=99)=
 is easy but then you
> someone types =E2=80=98git help foolish=E2=80=99, they get some strange m=
essage about help
> not being found.
>=20
> There are two problems with this:
>=20
> 1. It=E2=80=99s hard for users to create good documentation in the same f=
ormat as
> the core git product 2. The git =E2=80=98help=E2=80=99 processing current=
ly looks in one,
> and one place only and that location is often =E2=80=98locked down=E2=80=
=99 meaning that
> mere users cannot add their custom help to this directory.

It is possible to extend the set of locations that one can use for man
by setting MANPATH.  If you do so, something like "git foolish --help"
does indeed work.

> I propose that #1 be solved by creating a command/tool and documentation
> that explains how to mimic the input to the standard Git help files and h=
ave
> them processed to create the HTML/HTML5/MAN help normally produced.=C2=A0=
 Ideally
> it would do exactly the same processing as the core tools (perhaps even
> having their docs built using this tool now) and use exactly the same
> template files that core git uses.

There is such a tool, and it's called Asciidoctor.  However, it's
written in Ruby, and not all users will want to install Ruby as part of
their Git installation.  It does work nicely, though, and I use it for
my own custom Git subcommands.

Also, if a user prefers to use a different tool for creating manual
pages or HTML documentation, they can certainly do so.

> I propose that #2 be solved by allowing a new set of =E2=80=98git config=
=E2=80=99 fields.
> The layout should be sensible and should users to be able to set a git
> variable which then means that the core git help finds their help text.
> Possible we want to force
>=20
> <where I installed my tool>/docs/man, or html, or html5
>=20
> And the git config variable be something like
> =E2=80=9Chelp.custom.foolish=3D<where-foolish-is-installed>/docs=E2=80=9D

I think specifying a single location may be a problem because different
types of documentation live in different locations.  On Debian, man
pages live in /usr/share/man, but HTML documentation lives in
/usr/share/doc.

We could theoretically add support for this if we did help.foolish.man
and help.foolish.html, though.

I don't feel strongly enough about this to implement it, but if you're
interested, I could review a patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl499soACgkQv1NdgR9S
9ovbKQ//YlQE26zfBAWsjBjm0n2KOQcMMr08CvZLuOFvVBfxngmcDyYXPWqmwrpA
lb57LP3N92JoEOUljujiYDz/NHpZhhAClQp231BDE7rfqQEAA8XSDBmQqe2JPw/Q
7Q37dvu/s1zcubBQV9LHo3muntzEZMHkDhzXSxnPhgxYPNGUppvl00JD6FEmh5z8
CD/DkAu1dh4hKCp6B/8CgU4gy1FloEa8xRU3HzMY+JoPrJ6tYGN26llmn3tfrPPL
1Ne9DXUWD34W1JkIO8Bj4Ckg8Gh8KgQhC9f7M6DfI0Eq2/9wR5L766ZMbYSXR2nQ
PDHof2/40qXBfdoXnrhRg07IeZzDAjn0/E3TqRO47M3Hlmz3OcMyr6JAy1dmlZBn
33I/MDIT6xSUwv83MwUHidAMvzmrijZK+/xbNThfe9cBM/Ujf5/wvp7Y2RvySAqZ
tB1cPEyg6oK4t2HCik6xLCRtt4rp2qp1djgeIRTs8pPHBdqJp/Vss3Gau8Q9xZRt
jalWYt44UldkDCk1zOvtVXyb6NeopClNF+uOwtHvWrBP2vSH/KwUlvw6kH2oljau
fxfJsdI3H+MpD2U1NB1q7v2e/tSZZzsZHCQGhFf/x2LrnyiYUGySFDo+v9uk4V6Z
UwOxgx/6WMQ+umRGFrsyjHIMU618qpgTVmrduVTTsKo/PDNlOrk=
=pdxx
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

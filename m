Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC36CC0044D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 00:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A312074D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 00:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h8r2bYPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgCLADX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:03:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51940 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbgCLADX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 20:03:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2553C6077C;
        Thu, 12 Mar 2020 00:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583971402;
        bh=aB5ZTZxDxhnpfvKmXRLEoWEyQJooqUqaYf8JpHZN78E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=h8r2bYPTfbF7iyzkQxi9JIWI0OPcuDHJfshidigkwtaorTWGSLalaIO7ZCZz25BPa
         4DXKzUI3OmJ/6RAg8FeNgk/SW0ltoxgQ4EP1b3/m4YLanP5H36HfkBgQiWweeUfocD
         oN5yFIvkoq6ke8ytQkKArV1kxcN3evhw1RAQwVB+QOX7IJdaaqt75dyhGDKcMwofjY
         h4lpIJxERaigMh8/MuHgVw1pbxFYJNaOHey7NPO8pXJLt0yE0eUPegQ0U2sTglVMbC
         aujoT1nw71oJwDJCgaK7sCco4s7O2Fjrl12MjSb7pCpDWKddSTnTzsGL+ZRVLf/wXZ
         xEAUshRl92l1CqOV00ntBZBNL1KV8XoRjb78QA80mfsSMvud402htLfZJ+AV/PjJX3
         JoCVlh1/aDuXsBxtZjSpE1fiCWebIJy8ZYdiHF9jfLUfWOWpnbbTbbmZbIo+fFDtwx
         o0E3FRXEr4nrW/SkWjaNpcuZCOVBAHDOWBFksI77l4bWsISAJe3
Date:   Thu, 12 Mar 2020 00:03:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [Breakage] t0410 - subtests report unable to remove non-existent
 file.
Message-ID: <20200312000316.GB6198@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <010b01d5ee87$09be74d0$1d3b5e70$@nexbridge.com>
 <20200310110008.GA3122@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20200310110008.GA3122@szeder.dev>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-10 at 11:00:08, SZEDER G=C3=A1bor wrote:
> Note, however, that 'ksh' is not utterly wrong in doing so, because
> POSIX does allow this behavior: POSIX 2.12 Shell Execution Environment,
> the last paragraph of the section:
>=20
>   "each command of a multi-command pipeline is in a subshell
>    environment; as an extension, however, any or all commands in a
>    pipeline may be executed in the current environment."
>=20
>    https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_12
>=20
> So apparently 'ksh' implements this extension.

In my experience, trying to fix this is not productive in our test
suite.  zsh does the same thing and many of our tests fail with it for
that reason.  In the zsh case, I sent a patch to make it not do that
when emulating sh.  It got lost on their list, but I'll resend it.

There are many, many other pieces of software that are broken in such a
case, such that trying to use zsh (or any other shell that does this) as
/bin/sh (or a POSIX sh) will result in widespread breakage.  My goal in
fixing zsh is that it's a candidate for /bin/sh in macOS Catalina, and
I'd like to avoid users seeing breakage if they run in that
configuration.

My reading of the allowance for this as an extension is that zsh and ksh
can do this when invoked as zsh or ksh, but they cannot when invoked as
sh, because in that mode they are supposed to strictly conform to POSIX.
POSIX states the following:

  Non-standard extensions, when used, may change the behavior of
  utilities, functions, or facilities defined by POSIX.1-2017. The
  conformance document shall define an environment in which an
  application can be run with the behavior specified by POSIX.1-2017.

> The trivial fix would be to mark $HASH as 'local' in both helper
> functions, but this would not help 'ksh', of course, as it doesn't
> support 'local'.  However, since we use more and more 'local's in our
> testsuite, 'ksh' might be considered a lost cause anyway.

If this is the AT&T ksh, then yeah, it's a lost cause.  It's possible to
emulate local with typeset, but that only works in ksh-style functions,
not POSIX-style functions.  It also has the issue we were discussing
above.

pdksh and mksh both do the right thing with local and the last item in a
pipeline, and both are suitable for a POSIX (or Debian) /bin/sh.  I
believe OpenBSD's ksh is also fine, since it is also used as /bin/sh
there and it does support local.

I should point out that Debian has a reasonably restricted set of
requirements[0] on /bin/sh that allow a wide variety of shells to be
used, and which we may want to consider:

* /bin/sh must implement the POSIX.1-2017 shell command language.
* echo -n, if implemented as shell built-in, must not generate a
  newline.
* test must support -o and -a.
* local to create a scoped variable must be supported, including
  multiple variables and included assignments.
* kill -N where N is an integer must be supported with certain signal
  numbers.
* trap must work with certain numeric signals.

The latter two are already required by the XSI extension to POSIX.  I
personally don't see the utility in the second or third, and the first
is supported in almost every modern shell anyway (possibly with the
exception of command -v).

Of course, ksh is not included in the set of supported shells for the
two reasons outlined above.

[0] https://www.debian.org/doc/debian-policy/ch-files.html#scripts
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXml8RAAKCRB8DEliiIei
gcTIAQDkUzuZKGdL8UH7zNXbCY8rzKdk7eScT2Ftk3Pn67cVsQD+IC0fJ2uOyGQY
nQc9IQzLK/wqUjrs5geX1uWAbosU+gY=
=Cd4w
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

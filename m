Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AE5C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6329220784
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ip8xGg0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgELX7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:59:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38080 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731873AbgELX7b (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 19:59:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AFFE260427;
        Tue, 12 May 2020 23:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589327969;
        bh=shpp1dm+i5caQUR38KjrQcH3gTsvwJAkxP3DpVt1RSM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ip8xGg0FYSwYE0XQQOc2SY+T84UtfXns0GPb4xNQc5dQip8WDhoSzDlOgbVmOzccW
         6fzObYPoefrDMEQiCEWBqotT7tCdpxDrI0hOvpncyfubA1zW31k9LCy7I8A6kG+pdJ
         cMXOcTJ2BB2lZf8wNfYJ86I1fBpt/2uRmbg8CP9IoJDqPkM5KyUUzr/suyQSR3HYTu
         6xzDcVn0z/7Gt8gK38HrSfDZze8Cboxv0gb2fQfAlrzl/HXCDE5aHy5JjqYdkFwtre
         Lz9jYz5nYPYoUhizVc9vt2ig20NT5KMKIE2UGMdqX+3Zj4vtS519Ez126RBxg1CLq6
         5Gc4Jiwd/YzvH0y1p4Fr4jJwqAhl3vNZREQFOzNrTAtC+IqnXCxmuR1iEXbmY/Sf/U
         GxkbmW7yY8lSj7HIKNVlFOw5KEqkl7TeAOkqIMBYkol8D1zHBIi2Q7yXIqyOE6ECc2
         cBCkNAbbE0liHZU1LZQpaqQ2D+PLYW6wn05jAl407J5CIVMdZty
Date:   Tue, 12 May 2020 23:59:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] help: add shell-path to --build-options
Message-ID: <20200512235924.GC6605@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200512234213.63651-1-emilyshaffer@google.com>
 <20200512234213.63651-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20200512234213.63651-2-emilyshaffer@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-12 at 23:42:12, Emily Shaffer wrote:
> It may be useful to know which shell Git was built to try to point to,
> in the event that shell-based Git commands are failing. $SHELL_PATH is
> set during the build and used to launch the manpage viewer, as well as
> by git-compat-util.h, and it's used during tests. 'git version
> --build-options' is encouraged for use in bug reports, so it makes sense
> to include this information there.
>=20
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  help.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/help.c b/help.c
> index 1de9c0d589..44cee69c11 100644
> --- a/help.c
> +++ b/help.c
> @@ -641,6 +641,7 @@ void get_version_info(struct strbuf *buf, int show_bu=
ild_options)
>  			strbuf_addstr(buf, "no commit associated with this build\n");
>  		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
>  		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
> +		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
>  	}
>  }

This seems straightforward and logical (as does the rest of the series),
but I wondered if it might be a good idea to try to interrogate the
shell for more information.  The reason I mention it is that Debian
permits any shell that meets certain standards to be /bin/sh, and all
programs that invoke /bin/sh must depend on only those features.  The
default is dash, but people could use bash, which is more featureful, or
posh, which is intentionally designed to provide the bare minimum
/bin/sh experience[0], among others.  A value of "/bin/sh" doesn't
necessarily tell us very much on Debian (or on macOS, for that matter).

Now, that of course does mean that we have to have some way to
distinguish between shells, and that is the hard part, so I'm completely
fine with us leaving it out until we have a good way to do it (or until
we decide we need it, which may be never).  I just wanted to mention it
as a potential approach for the future.  I'm happy with this series as
it stands right now.

[0] Quite literally, in that it's supposed to be a tool for testing
compatibility with the policy requirements.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrs4XAAKCRB8DEliiIei
gYppAQDvtg+xtYNkk1wpBUJzQXOAJwEUjY5wB12ihw6AUbsjiAEA/4NpVRnJp+Ou
PM8cZC+HZcwcVhXCvV6ra9wDghI9wAM=
=XPse
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--

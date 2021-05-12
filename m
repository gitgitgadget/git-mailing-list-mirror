Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5AFC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3560061919
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhELACf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:02:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52374 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhELACd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 20:02:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B3C1A60459;
        Wed, 12 May 2021 00:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620777656;
        bh=nJFPmh46xuZ1PKYuQ0TK0FDLr8fotl8hRlVvAApjUwE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rEQuxAKkmN4uSdISXO0mMkFCm+a3zzUBySaFhVfth+ubTj15vU13Knwbg2FbV1PDy
         E1V7NQngu3jiH+l/EgYuwIXm4ojZ2o5t/kcNjevpvU3qDU+sjiVt2gk+7TqS/EGmBn
         2HIFuSQEmWDVjvjFc9uF5rLqN34qJgzEUg86HaK3WOG8I65RYgQ1xdqf/aTZmVCq1I
         pSVv/tapA0nqhx4u/SsSw3wbhvUUOOLNKiko6XcjcQo82DGW31yefkVgF1T9q2fXdG
         mw5wRO63gPIW9EA1kQ96nqlTbRZIdOFs4/nWPcfFknsJJIg3lUGanys25cLOwIlicn
         lV//D++Ph9/QBLOT67DNWMd8XgOOtXBaM6fbLla8ypkYGLMvwb+II4wrGyQIDcT98y
         W4xmYL+lAew/Kg7Ol4I6CxX7F1fgmrDg1Qe1CI9UZkHtb4Ki3F/4wjkHH37QVX2fYR
         KlCH6e+nHGZP2l1BNclygZxddWFD+mBXlxZ1/tIlLH7Z5QZRw7O
Date:   Wed, 12 May 2021 00:00:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJsas0d4XPsYYpI7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gregory Anders <greg@gpanders.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20210511204044.69047-1-greg@gpanders.com>
 <20210511234935.65147-1-greg@gpanders.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GIJRtmHsYlW9v0cj"
Content-Disposition: inline
In-Reply-To: <20210511234935.65147-1-greg@gpanders.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GIJRtmHsYlW9v0cj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-11 at 23:49:35, Gregory Anders wrote:
> The sendemail.smtpServer configuration option and the '--smtp-server'
> command line option can name a program to use by providing an absolute
> path to the program. However, an absolute path is not always portable
> and it is often preferable to simply specify a program name and have
> 'git-send-email' find that program on $PATH.
>=20
> For example, if a user wishes to use msmtp to send emails, they might
> be able to simply use
>=20
>     [sendemail]
>             smtpServer =3D !msmtp
>=20
> instead of using the full path. This is particularly useful when a
> common git config file is used across multiple systems where the
> absolute path to a given program may differ.
>=20
> To that end, this patch allows both the configuration and command line
> options to be prefixed with a '!' character to indicate that the
> specified command should be found on $PATH, as if the user had entered
> it directly on the command line.

I think the idea of providing a way to invoke a sendmail-compatible mail
server is a good idea.

> Signed-off-by: Gregory Anders <greg@gpanders.com>
> ---
> Diff from v4:
>=20
> * Update the test with suggestions from Jeff King (this should fix=20
>   erroneous test failures caused by patch files being deleted by earlier=
=20
>   tests)
> * Reword the commit message with feedback from Jeff King and Junio=20
>   Hamano
>=20
>  Documentation/git-send-email.txt | 13 +++++++------
>  git-send-email.perl              |  7 +++++--
>  t/t9001-send-email.sh            | 12 ++++++++++++
>  3 files changed, 24 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
> index 93708aefea..418e66c703 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -212,12 +212,13 @@ a password is obtained using 'git-credential'.
>  --smtp-server=3D<host>::
>  	If set, specifies the outgoing SMTP server to use (e.g.
>  	`smtp.example.com` or a raw IP address).  Alternatively it can
> -	specify a full pathname of a sendmail-like program instead;
> -	the program must support the `-i` option.  Default value can
> -	be specified by the `sendemail.smtpServer` configuration
> -	option; the built-in default is to search for `sendmail` in
> -	`/usr/sbin`, `/usr/lib` and $PATH if such program is
> -	available, falling back to `localhost` otherwise.
> +	specify a sendmail-like program instead, either by a full
> +	path-name or by prefixing the program name with `!`.  The
> +	program must support the `-i` option.  Default value can be
> +	specified by the `sendemail.smtpServer` configuration option;
> +	the built-in default is to search for `sendmail` in `/usr/sbin`,
> +	`/usr/lib` and $PATH if such program is available, falling back
> +	to `localhost` otherwise.

Elsewhere we use the ! syntax we invoke the shell, and I would suggest
that we do the same here.  That means we'll get PATH functionality by
default and we'll let people do a modicum of scripting if they like.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--GIJRtmHsYlW9v0cj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJsaswAKCRB8DEliiIei
gY89AQC2Eibywn9uik+BMUT6FDfg/NGV9/NrK2GbAYrtBtYmvgD/ZzqXWQOrZxHr
a4X80+PNGCvowp5b7kYL2EJ2rJZrtgo=
=xKbH
-----END PGP SIGNATURE-----

--GIJRtmHsYlW9v0cj--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478051F516
	for <e@80x24.org>; Mon,  2 Jul 2018 01:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeGBBw1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 21:52:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49898 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932102AbeGBBw0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jul 2018 21:52:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7872:b1da:4747:5087])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3CD2560431;
        Mon,  2 Jul 2018 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530496342;
        bh=ekOvKhtCVwpnaELB62tq6A50/z93R9H4XYIWOr1jxT8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FkuclyjmCkyC1BIZgLeM2Rb7Vi/1Y3luLyr8uJf6bEPAwvTGaxP4AdbEKdDR2em/D
         cCuYSVjOnD2GY0RB5HHWXdr0aYO5Qpq/7jsvQmrm13q44sPwe4wyRsPW+3KOBCwGvz
         wVWcqnZH/2vop+9qrpaTHfXNFO6s1zgF8DEQFWuf3s5/7wuuwdg//VgExhhGFCCIlg
         O131DgdWp2Xky6H2DSDZ7Y3RZmrbgyTD+Qg7Ar4Cp0X7qWmXLMyay0GDXClFns1Cso
         jnG1Aq3k6mQdNzLoEI8mIxpKzkxVkQ3QYCMYZNgLsv4TXiPXV/1DwAZq8fwfXiA5VF
         86PvikA1nlMm8bB8PW45keGc2nH1ilvd7RRawlFn1WYajuDmFapT1rrbw4H39Kp0W5
         XbPysOacJnaztbEK10XsbPauiTvcwSApf1EdBC+we89UuD0ohv6E2m1nbNAvgf8WzY
         MAFiOcLDI4Jcf00zHQb2q7yykinv2pc3JVqAy1Tzzr80cKu34lM
Date:   Mon, 2 Jul 2018 01:52:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, contact@emersion.fr
Subject: Re: send-email: change the default value of sendmail.validate
Message-ID: <20180702015216.GA627376@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org,
        contact@emersion.fr
References: <20180629190751.GA2559@miku>
 <20180701181546.GD7965@genre.crustytoothpaste.net>
 <20180702001753.GA30086@homura.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20180702001753.GA30086@homura.localdomain>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2018 at 08:17:53PM -0400, Drew DeVault wrote:
> On 2018-07-01  6:15 PM, brian m. carlson wrote:
> > Are you suggesting that we not limit lines to 998 octets?  I've seen
> > lots of mail servers that do reject mail over 998 octets.  I've
> > configured Postfix to do so because being strict on mail standards is a
> > great way to stop spam.
>=20
> Yes, that's what I'm suggesting. We should error out later when the SMTP
> server rejects the mail.

I don't think it's a good idea to continue when we know we're going to
send invalid data.  If you really want to send the email and you know
it's safe in your environment, use --no-validate.

> Also, Extended SMTP is a standard. RFC 1869.

ESMTP doesn't lift the 998-octet limit.  RFC 5321 specifies ESMTP and is
silent about line length.  RFC 5322, which defines the email message
format, limits lines in an email message to 998 octets.  The limit is in
the email format, rather than the ESMTP protocol.

> > If that's the issue you're seeing, it might be better to either
> > automatically encode those patches as binary patches or teach git
> > send-email and git am how to automatically handle quoted-printable.
>=20
> I'm really not fond of quoted-printable. Extended SMTP has been
> standardized for over 20 years. Assuming people don't blithly disable it
> on their servers, we can expect it to be present on almost all mail
> servers.

I'm not bothered if we don't support pre-ESMTP servers.  I do care
whether we produce properly formatted email messages.  Long lines
require wrapping, and that means either base64 or quoted-printable.  For
plain text data, quoted-printable is less likely to be filtered as spam
than base64.  It's also easier to read with plain text tools such as
less.

I'd be willing to implement quoted-printable formatting at some point if
that's the direction we want to go.

> I don't think I've ever seen a spam email that would have been stopped
> because it contained 998 lines. Approaches like SpamAssassin,
> greylisting, DNSBLs, SPF/DKIM, these are much more effective.

It is actually extremely effective.  Most spam-ware produces invalid
messages, and IME almost all malformed messages are spam.  I use a
variety of techniques, including this one and most of the others you've
mentioned.  Other people do so as well.

Regardless, a default mail server configuration on Debian rejects overly
long lines, and there are various other systems that do so as well, so
"just send it" isn't a viable solution.  Fixing Git so it produces valid
data in this case seems more robust.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls5hVAACgkQv1NdgR9S
9ov+Ng//d69Ev8I0UXFcZ+IM3WW9dklrmFgBvbO5Tvh702DoxepH20kYHkBm4jKh
33BglRV9pd92cczQ7be3Hjr3AOqxEybY+p9xd5WnxXhPZFuZ3DxOZYcoc2ofJK8+
f0qA6We54che80oXXk+dnj7WSHqGhcJaTrWo4eA+wOYvHEDjXygTfC4cIgKTgKsW
FdhuUO07QmufWmURxgQRmGXAcw7APvW1AZY/PqgnfyntJ+52I9Y+ggJjhD2t6FTX
3nxZK/PgA4hmUnm0y0cNjHd3tIJNvJ/zZdHXUKdeiUOzeCx3kCezGH4r5zDSl9Hf
Z2WJgtKecSANu/f1y6kOCkozqpzXFN0InHt2Jw98VrAUAMnJTtAwbcJjfPQz4tq5
v5hcyJlN9eZlfWyXs1cuVNAFZXI5WmQ7XZvobcij/rEw+Kfsd2AJ4IBrkawE8Zt3
ptGf7QIcNhEi1Qk0tz8abAKDsjpF1BF4YGvS2k+xALrxbmu8G5cHqV4CnaUa9EO2
CacUARbnwI+/7AeilMhnTcnakRMbWdD+h8d0e8SNQDIa7AohFYRZAyhVPdAzNWz/
0NZ3PHk2jFG+9lywMS4Oq/xZUcQSASlcd4D+aDuW7/0IHDaiVpJF8H34pPgi/Mp9
TASThNOAfX3/KeD2Md2uj4+UZxPYuF/hohijwkzP/WI+WNJ7YUw=
=w2kB
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

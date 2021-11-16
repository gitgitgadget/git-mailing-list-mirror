Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F3C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 04:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2451F60F22
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 04:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbhKPEvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 23:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245485AbhKPEuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 23:50:55 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1462EC09FC42
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 17:53:55 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E86195B462;
        Tue, 16 Nov 2021 01:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637027635;
        bh=MX70dHWi9FCF79t0XoTokBYimHIXCPyxzUZChvxFjX4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ETcyuN3VpPPvqsZ4XF/1+sJWksJFkGc3AtOmoif5ljj36Sd1hyeu4JHxhsbaM2rIv
         2veKswG+2slfYTLtIVk08EtlHCB69wOD8G1XmmrgImO53VGy/IJbXRRl7/Pf4epXau
         vCSh7xJrHYzUElRjOdbJ54DP2Y6y1CjDRBmWmCYVy0G62LmieOYNf86NwbyhCnCtpa
         h89rFupblKLTg9Zjwlwz8d0V3QD3wew0EUdmM84iqx3MaKPPzPZfwQ+n9UQIZKopF7
         SCWcqxnyVElF6tyI91bQ8R2m8NAWLUklEF39/M/ETQAQzobnJBr181Rz2usu/RA5rn
         fl64N9VFAGYV759QS4Ck12YWYTGy3rp45pYSRW/byin2dkuXO/KW5ljf2nNzb7gbZP
         NE9igAVFLwwreHJYZN1QI3snkoxCBtHFi6+pME+4/1dHv9S3fI8DKLR0B23e/5Afjh
         8hSv5Z3RnUQaY6rzALdFBKAl+g+axU7gVqYMjYc/L9HkuMfegiv
Date:   Tue, 16 Nov 2021 01:53:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
Message-ID: <YZMPMFiQmtgfp15H@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211114212437.1466695-2-sandals@crustytoothpaste.net>
 <CAPig+cTAfOor11SDWG0N-eeZZ=4hsmkMVAdcmiiJ+jXz3BAQVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dy+nowyl0MLff8Yf"
Content-Disposition: inline
In-Reply-To: <CAPig+cTAfOor11SDWG0N-eeZZ=4hsmkMVAdcmiiJ+jXz3BAQVQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dy+nowyl0MLff8Yf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-15 at 03:16:02, Eric Sunshine wrote:
> On Sun, Nov 14, 2021 at 4:27 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > +#if __STDC_VERSION__ - 0 < 199901L
> > +/*
> > + * Git is in a testing period for mandatory C99 support in the compile=
r.  If
> > + * your compiler is reasonably recent, you can try to enable C99 suppo=
rt (or,
> > + * for MSVC, C11 support).  If you encounter a problem and can't enabl=
e C99
> > + * support with your compiler and don't have access to one with this s=
upport,
> > + * such as GCC or Clang, you can remove this #if directive, but please=
 report
> > + * the details of your system to git@vger.kernel.org.
> > + */
> > +#error "Required C99 support is in a test phase.  Please see git-compa=
t-util.h for more details."
>=20
> You don't need to encapsulate the #error message in double quotes.

Technically, I believe in this case you are correct.  The C standard
specifies this as pp-tokens, which means one or more preprocessing
tokens, and from my brief overview of the draft standard, it appears
that this meets that definition.  (I could be wrong, though.)

_However_, there are some cases where quoting is required, such as when
apostrophes appear, and although we don't have that case here, there are
some compilers which are very strict about what they do or don't allow
in an #error statement, or which are just broken, and as such, in my
experience, it is safer and more portable to always quote it.  I
definitely don't want us to have the problem that we break an otherwise
functional compiler by causing it to choke on the #error directive it
doesn't need to execute.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Dy+nowyl0MLff8Yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZMPLgAKCRB8DEliiIei
gathAQDzJVP8WHFYyrzvgwE8+RuOtVfrAlGTfUSzkmvg74BnPAD+KPwUDDOdOEAc
n7mPhVGVRdezs94MRDL/0mUzuVcHnw0=
=5Hvm
-----END PGP SIGNATURE-----

--Dy+nowyl0MLff8Yf--

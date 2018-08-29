Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C5D1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 23:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeH3Di3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 23:38:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38412 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbeH3Di3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 23:38:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 358E660428;
        Wed, 29 Aug 2018 23:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535585949;
        bh=gIA9pIFm0XoHx2S7lGCLu/EOE8m3og1kEDUr0dgtz8Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mmzPyX0p2Rg1SLYCiGzmC1/1Grv7QO1wZGr2ybysIPKwsDhcn+hwpVDLDNS7HMAIU
         +BCRTUBo/JHjVbRNXWi5LtU4fv5/3/GpFiZ+Nlw4ZXVjxBKnF4/aajcTIG9cGCPhtL
         a5A0e9hF+EH1r9ft0/YhN6Nvor4AtIKyyuVCdv3aTAklDVpaJIK1YLGU8q5s11mLV6
         xCXaD95vv8TaW3O2sA/MosmtBewyE7MzNmk6YV6//fr0fHIUAZin9LRHxCPMgYJhXL
         oVo+7hznHQMCN2R2DWufoOZqBqiaxP9dX+Y1SQFg/xFXK7XHl8b+t9nCoabqp9dAql
         VcVDEtKV23IElXzME1dWNKOKDlRuHj7LT+BgyAupSNySnYkLp9NNY2ayZO0nevPW+o
         8TNErWdwoMfdR9rTsUmv6CcyoM7xiz9XxuceybNoK2J49KjpjvUZN7JsZVwDawcbrL
         02z5qbMMVFNB26ZHWndQcoBRGP9uTcPtdx4w4o/Zzm7vqyjIXzt
Date:   Wed, 29 Aug 2018 23:39:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 10/12] sha256: add an SHA-256 implementation using
 libgcrypt
Message-ID: <20180829233904.GG432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <20180829005857.980820-11-sandals@crustytoothpaste.net>
 <878t4peeqa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <878t4peeqa.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 10:53:01AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> On Wed, Aug 29 2018, brian m. carlson wrote:
>=20
> > Generally, one gets better performance out of cryptographic routines
> > written in assembly than C, and this is also true for SHA-256
>=20
> It makes sense to have a libgcrypt implementation...
>=20
> > In addition, most Linux distributions cannot distribute Git linked
> > against OpenSSL for licensing reasons.
>=20
> ...but I'm curious to know what licensing reasons these are, e.g. Debian
> who's usually the most strict about these things distributes git linked
> to OpenSSL:

On my Debian system, that's linked to libgnutls.

The reason is section 3 of the GPLv2 (emphasis mine):

  3. You may copy and distribute the Program (or a work based on it,
  under Section 2) in object code or executable form **under the terms
  of Sections 1 and 2 above** provided that you also do one of the
  following:

  [provide source somehow]

  The source code for a work means the preferred form of the work for
  making modifications to it.  For an executable work, complete source
  code means all the source code for all modules it contains, plus any
  associated interface definition files, plus the scripts used to
  control compilation and installation of the executable.  **However, as
  a special exception, the source code distributed need not include
  anything that is normally distributed (in either source or binary
  form) with the major components (compiler, kernel, and so on) of the
  operating system on which the executable runs, unless that component
  itself accompanies the executable.**

Basically, you can only distribute binary versions of Git under the
terms of the GPLv2, and you have to distribute source for the entire
thing under those terms.  OpenSSL is licensed incompatibly with the
GPLv2, so you can't legally comply with that part, but if you use the
system OpenSSL and don't distribute that OpenSSL with Git, you're
exempt.  This is called the system library exception.

Debian (and Red Hat, and every other Linux distro) ships Git and OpenSSL
side by side on the same mirrors, and hence "that component [OpenSSL]
accompanies the executable."  Consequently, they can't take advantage of
the exception, and must link it to a GPLv2 compatible library.  Debian
uses GnuTLS for libcurl, and Red Hat uses NSS.

A more comprehensive explanation of the whole thing is here:
https://people.gnome.org/~markmc/openssl-and-the-gpl.html
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluHLpgACgkQv1NdgR9S
9ov2khAAkOuK92NSWQWDrLrQRLBhLcaddquhGCZum5+aevF+GdBJfjNi7BpbsOVJ
9jMQcLDLePHpHBIxJq8zTUZCzbqW9i+vFM1t2x6l8mW0fuvKF+dFqH6x8L9X9Rf8
lQMA1mcyDBnDWR+lboVh23DrKpU1cXalMoBmBMU2xLPlsy9QHY4qoajL24Yshsfv
VsJElzM3QDQK7SGuAyM9O6qploc+9dtkwYKzFJS5/xGkp6FEWllJimhdy9swFlXL
lm4rM1wJMyYblQWqjtLcNaX95AqnL4lxN9V1oi2z8z2cCWTG7z21oPZo5mE6VE1j
b59/H7HVSA0ExzCx8lOeAg/QdErIrSsVEkND8H8I8m89ZN2oGcNvronSfYdrZM6P
+QrMZPUDB6v4ywzFZ5Oarw7FYqjlGaX/rgXeQOZ3/MtBvE+EMFw0yVO5cLUmPyfl
hKTq2lkJXuo7H9nNJySQVqU/A/8aOUx48deGXXhFxDc5UoVj3jBe1Z7BzBhcVXzU
sF4/5nql2Z9B1bGv2SfhvT6YOt999DEN5LaRe+3J7GEXCaHPZ1pZa8v1qJHCkrxD
ZazkQ3z3WZgnCl4eJpMzei9E8nTyygKJL0LCLuxShfXjDlGpHz+/SISQ35CbqN7J
Rm8FaQehEjjSCi4g4FMHJR8iNxfR7K42kBA17M0iYWe8BGNJTtE=
=pxQ/
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--

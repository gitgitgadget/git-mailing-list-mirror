Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86BFC35DEE
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2BD20838
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q7+2BARA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgBYALV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:11:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbgBYALV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Feb 2020 19:11:21 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 43C8E60797;
        Tue, 25 Feb 2020 00:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582589480;
        bh=v7d0ZvLJcl5+tL4dzneFkg5YZ+ZlEzPkX1eaZSPlExI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=q7+2BARAIADS9d+O1ulfUpJG6n44EqCOxD6idKBgXjolzCdWSrzpf0Uuwd1oULxm+
         VSuqTRxteOJQwV4EaDWYijqOCrBBJa3Hi5gnJI6TK67voRpA3pTv8HNaBle4W8QO+v
         Ziuw0erbIlqZ2im+HnzdWyAq1pnL1/Jsg6lr1BL4AGEag9mezFpU1Y6B0MQsZWVpXp
         vWt6g7sxa5RftAqI7LqCk7hbVL7Pxe+IwAg03hSeCd4xV4RQVN9jawL9NkVW/ri0dc
         B/NQz47Vugm75qV7/JViB3vmhV9u7j0b9bYVpxyc95H6DTitWgo1OW6OFM/H8l1tfU
         7EnrSmlzaHWwJ1zDTst71oaTrq/HWP+2dIJCKF0pBucUpNR1RjbmrplZuljIAToBnI
         79yCGpxhNR7AADKf+ZGtR6/lx7/AhUEJSJHSJ/INxeujakJh8QtRHRDOay6p71oG1h
         zQFoWqMJYne77p0GG9SwZlUiMZwyu+cKgDKHcsdUDdeEeTyWMEj
Date:   Tue, 25 Feb 2020 00:11:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 13/24] builtin/init-db: allow specifying hash
 algorithm on command line
Message-ID: <20200225001116.GI6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-14-sandals@crustytoothpaste.net>
 <xmqqh7zfrgxi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1y6imfT/xHuCvpN0"
Content-Disposition: inline
In-Reply-To: <xmqqh7zfrgxi.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1y6imfT/xHuCvpN0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-24 at 18:14:33, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >  'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]
> > -	  [--separate-git-dir <git dir>]
> > +	  [--separate-git-dir <git dir>] [--object-format=3D<format]
>=20
> A missing closing ket> in <bra-ket> pair.

Good catch.

> > +#ifndef ENABLE_SHA256
> > +	if (fmt->hash_algo !=3D GIT_HASH_SHA1)
> > +		die(_("The hash algorithm %s is not supported in this build."), hash=
_algos[fmt->hash_algo].name);
>=20
> Could you fold the overlong line here?

Absolutely.

> >  int init_db(const char *git_dir, const char *real_git_dir,
> > -	    const char *template_dir, unsigned int flags)
> > +	    const char *template_dir, int hash, unsigned int flags)
>=20
> Perhaps rename "hash" to "hash_algo"?  I know that it is very
> unlikely for a variable whose name is 'hash' to be mistaken as a raw
> hash value when its type is "int" (as opposed to say char *), but
> still.  I wouldn't be saying this if its type were an "enum
> hash_algo" or something like that.

Sure, that's reasonable.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--1y6imfT/xHuCvpN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5UZiMACgkQv1NdgR9S
9ovfhA//U46u61aEnvJkOHT2+5MmicOoZCNi1QrDl0+OrxRcxaUZMXqNDcVHWSNk
fXDE5Is91Hrwl0vxz5TH9BffAiBfFYj6phcbg+h8dh7cMGP45CNcwzdbXfrTFgnJ
smTeUoz2b5m6m+YrtKMGAOKtS+AD3GH2hlP4ObpJxbq9YkhLL+ZAatIz51ORGZcH
o+w9R/Kh4ExiFYlLTFN6MktwoWwQJWO9aeKsDykHF1LL+aMcZt4CW8x2cq0gCSFP
dKmCv15yKeOAmGRvtftb7bapsYSyFyDeXx4jYsr2MXJepHe3SYHWMHgkSfd8jMIM
EMYQZ8OV3JnFSt9gutm3RfGluHKk15RvgatQeHYloNTZ0vDKhilKbvbLXJPlBA5q
ljrpN6eHd5H4evKl+PrdGKWzKIYjauu3gUpilJhP/VjaNWK8AOvG+KBfhSZ7W4uM
tS95y6YiGWpd2O6cCV6y7YIONb5UnLhREaIvXxGnaaELVD1f5px17qU33S5lgxZj
lZErQf/D4JrCVO4PA4dk2w0uaE+pKBTCHHU4pgonq4wa3JOqiyTK0FyXlTExzD47
Uizz555ToBohtevQsQJLqjPntuicqR8DgRpkrv6wgIfI5381qKrROXHmeC5ayNab
YGkWLQAPqoRL8qnWhLWmJYo0RGZB92k6mXkKpWYgJCF1C1uCvpI=
=RnPO
-----END PGP SIGNATURE-----

--1y6imfT/xHuCvpN0--

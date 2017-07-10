Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919A020357
	for <e@80x24.org>; Mon, 10 Jul 2017 23:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754964AbdGJXx1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 19:53:27 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57640 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754832AbdGJXx0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jul 2017 19:53:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2B1EB280AD;
        Mon, 10 Jul 2017 23:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499730805;
        bh=Ux4xLAOU+GpiCuXVS27dvfO5J7znM9CQ19Sr+17B0PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9A+GUn5sZAXVaLS4miyoeND1ai7qEbg4nLTKcxsePwhqnc159PQdpNilU4Gmb808
         1v/Qn1wfXp8kwGp8gDApnqwn2XxMY0ZaHoQSeYrO/qWo9JSfAdbiBwjr0Mg3nh8hcZ
         cbYyrqHcczdHuHRupVLIG4WA0+flRGQYumUKd7X2ySy7XwTVAHFk7VWrSBd55BjMNf
         q2h0FSuD6iQCRXzCDBtTI1fgJgE9Isv0o//xNhtR/so4v/HBIHwfJS0a9ND3DMZWHJ
         COh2OWts+jru8uZnh0yefaP7emJ12ESQyJEY8zQkqS7oYuJb2472n/JED/Vfh7zs9+
         M6j1RQmnYKIm8Ne6zV1B+8gERGWwfrF3QYrygyDVe0U7H1Zsiuw8nICvNSYisZaIDv
         /EhwCB2U1rzVS3BbDb9DgOyu/bEdetVx1VvJpjweLWX8bqnem2I+2m0bU19HlwnVAy
         uMIFu2PSlQKAFjXbz+rmhkHRweVEJQsbkpSSl1qFzCoJmpAmamP
Date:   Mon, 10 Jul 2017 23:53:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Steve Kallestad <kallestad@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug - Dirty submodule differences between OSX/Ubuntu
Message-ID: <20170710235321.m3xfx2lfsvyirzme@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steve Kallestad <kallestad@gmail.com>, git@vger.kernel.org
References: <CALs7=Px4nqr6LhOTEQY80WbahRRuaKut-Us5tP7Puda0kb5EdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jh4nrx5kipftrj6v"
Content-Disposition: inline
In-Reply-To: <CALs7=Px4nqr6LhOTEQY80WbahRRuaKut-Us5tP7Puda0kb5EdQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jh4nrx5kipftrj6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2017 at 01:42:47PM -0700, Steve Kallestad wrote:
> change into the submodule directory and run status
> cd python-mode.el
> git status
>=20
> On ubuntu:
> On branch master
> Your branch is up-to-date with 'origin/master'.
> nothing to commit, working directory clean
>=20
> On OSX:
> On branch master
> Your branch is up-to-date with 'origin/master'.
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working director=
y)
>=20
>     deleted:    EXTENSIONS
>=20
> no changes added to commit (use "git add" and/or "git commit -a")

This is an artifact of using a case-insensitive file system.  There is a
directory called "extensions" and so git has not checked out the file
"EXTENSIONS", as there's already a file system object.  It therefore
sees it as deleted, since git tracks only files (and not really
directories, but trees of files).

This repository is always going to show as modified on a
case-insensitive file system.  You can either ask the maintainers to
change it, or reformat your disk with a case-sensitive file system.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--jh4nrx5kipftrj6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllkE3EACgkQv1NdgR9S
9ouIbxAAm0iaInlEfAM5Qp9iMyuzVU9Wt0I/sj9aWTe2Jy0HkyC8q4yAk9g1WZI6
7CLhFYfaZ+6Ra/mpYBTwn/+CsoOls+mZrJFCtB8R6X/QIpImoxJA0lOwxlxIpj9d
dtQRpPr2vlJApwc7209/a4Dpmm+fTza5nYGHVwz4/tQZJbFXZqqd7Bedq40w94ih
rTgdMEt7a+EYjWt12lABZ4y9xKLsPVPCR1fvmqDLSEoCO8oM01vFGzaoeObarron
GHB4X3w8HCQIZSM03mLILUNc0L3WZBravBDUi8Yb1EwEADHFq6dGgZlRGgMycMZ5
mr3osIaeS2QBmiLFar4M3CU5KsfGSHFLqgvxW9+bJ8esyt0ApR77ir1OTMmmG6ZV
TXPmMQspMOwn/96MKng+NIXtH282tFBbef66wV6d2gH6x9TKhZ44xymmRcMc9rLR
OQEqkDmxRubw98TS7wPLMHmnQVdbj+HKdXIGJjJeMvJO+nV8T63FFHTKDAKkMm28
neCwV7r7l3fK5k9Kxgw0mp3Lnwop/KHpjBnvnZ7sBMhcS8vmQ/946apL+hX/k+yv
/ex15V/5Ayc2udUC1c6A+bkS1PfNPikCZXXt8k16G6+aafUUE29+cjL7hU9lSQsG
DFfYjanNAuVoXEY0Z1U53kq7+D4F/iXZ8UWlEw+0HtduIlPnBmc=
=nFWN
-----END PGP SIGNATURE-----

--jh4nrx5kipftrj6v--

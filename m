Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE2AC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF8E206D9
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BK/niDAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFJXyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:54:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39230 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbgFJXyO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jun 2020 19:54:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D658E6048D;
        Wed, 10 Jun 2020 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591833223;
        bh=BIJKuH7tsYTYv8NHCsyo5sc/F4EVqtgnklv8vH7P4iQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BK/niDAGElj+bgeIg/R5DNkpuBJD0YJKGtApG2bV1L+FY3MM+I+A6jDkH5wTxEkTh
         WzEL8mS2DeIkrLOaqbp1mMq9MjfKpMZu7too70JrZyqApyvGBiToTIhUHZnglyCbY1
         IRJMNlCgmARcpd1wL12SXB2xQqSCP0P/B12ClZuS/9ECiOiEH932o5+6EkYEgRgIzq
         Xmr+r/PCxCw+fwarYPK8z76iOznMwOEB3Mu7E3PiAUahR4DAqNhKmlMEiTquHp+Xjk
         kH/XJ9kUe575lhAsgTuXJ37AusGwQOpvdEvMyjiIyBX5jrf/zTQY0CS6h3vN07bsGW
         NfECxE6j8eudQUDIBslr3RDogNUnS6v3guM567v1BuJeNRCy6DnO3TsYFMNITRsM9t
         IzH9yr9xWj2vDitJI4K/O/JXAUw/XpVRVwQeo1DDqW0JmaaPLQwL39jMu6aj6LLZ2g
         /3XTED1q7ZRXb/gqHxVlbaxRjsz/IjBGrRKpZdaynk1C9Zq9EuK
Date:   Wed, 10 Jun 2020 23:53:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: osx autocrlf sanity?
Message-ID: <20200610235337.GW6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
 <20200609231336.GQ6569@camp.crustytoothpaste.net>
 <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
 <20200610000358.GR6569@camp.crustytoothpaste.net>
 <CACPiFCKEGXK+TJtQiPub3dW6dYKJ7a=mXL+UCDP57N-3XtRYLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KH9S6eoVXLBawpUJ"
Content-Disposition: inline
In-Reply-To: <CACPiFCKEGXK+TJtQiPub3dW6dYKJ7a=mXL+UCDP57N-3XtRYLg@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KH9S6eoVXLBawpUJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-10 at 13:55:12, Martin Langhoff wrote:
> On Tue, Jun 9, 2020 at 8:04 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2020-06-09 at 23:31:23, Martin Langhoff wrote:
> > > good question! There is a .gitattributes file, all the files affected
> > > have these attributes
> > >
> > > *.py     text diff=3Dpython
> >
> > By default, Git will check out files with the text attribute with the
> > native line ending, and it will check them in with LF endings.  That can
> > be controlled by core.eol and core.autocrlf
>=20
> Why is core.autocrlf false not working for me?

core.autocrlf to false means that it is disabled and has no effect.
core.eol defaults to "lf" on Unix systems and "crlf" on Windows, and is
used even when core.autocrlf is disabled.

> I want to work on a repo that has a mix of newlines. I'd like git to
> completely ignore them. Treat all files as a bag'o'bytes.

Then you need to use plumbing commands like git cat-file.  You could
also write a .git/info/attributes file that contains the following:

    *.py !text

or

    * !text

which will override the file in the repository.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KH9S6eoVXLBawpUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuFygQAKCRB8DEliiIei
gaOlAQCwlbnLeMU6K9PmKFRVIlVbUyyz6uwsHAYTefBEwYbLwAD/X1BL////0yoX
cdH4cqcKiqLnHoFz49iLpijE6lLxwgc=
=lcxv
-----END PGP SIGNATURE-----

--KH9S6eoVXLBawpUJ--

Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575DCC38A30
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 03:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D94B206F4
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 03:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OOhCF1L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDVDPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 23:15:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgDVDPb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 23:15:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9870D6088E;
        Wed, 22 Apr 2020 03:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587525299;
        bh=yMM3qTdjHt6ny9DPUH7kB5b9P5dnLYLn0RDlGIreT2Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OOhCF1L3flrtYGDhxoMpbCEEkHGukGiK4M7V1xvZJK9o+pp3jxTlUhdbo2Xrc6ETy
         KC193iOoDJipXlH8Jdmb5BRCuJXMBziS9GSHLoFl5L2T+smGYEPoTALIeS2AgHKvYx
         g8Rk+gD1hvsTYXq9CujnQSy77ty5pAcNta4wV/+QsSZ1tpJyrpBmxmOK+dEZZEZn/7
         /GPK2b0qxsHS9oPd1FZQ0Mak3n1Qf1sRYACtXxLyULt7sX4vfdw154++VM5Ylm20NL
         4zSwODSDnFqXCqm96IaGckJ9DpzkbiDX6xF++d642SwkJfqR+Qzk/w4dpJ/xWfj1mP
         kOYchLR/Wi9DVm+YnLLALYIeUGF065gWfIrMnl5K1oJysHzyK1rcNTaLR9ICiO06pe
         Qq73nFN4H6hZ6l+ZVwYlFo3dn1bm/4zORwxsT4T68eXKM06Wo8IWjo1qd7sejzPDcR
         JTzFaAJVtaI3qC6eSziteSklkyAJiQqNcEyan5hIdAvRjCx6p+P
Date:   Wed, 22 Apr 2020 03:14:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mikhail Strelnikov <mikhail.strelnikov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Multiple pushurls, different 'objects\info\packs'
Message-ID: <20200422031455.GG6465@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mikhail Strelnikov <mikhail.strelnikov@gmail.com>,
        git@vger.kernel.org
References: <CAAihzVJTN5V3o_aFeUuJH_8+nqZrKHJww3vFQ9K5W0DtbeM14w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <CAAihzVJTN5V3o_aFeUuJH_8+nqZrKHJww3vFQ9K5W0DtbeM14w@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-21 at 18:07:42, Mikhail Strelnikov wrote:
> Hi,
>=20
> I have a repo with two pushurls configured like this:
>=20
>=20
> C:\folder\1>git init --bare
> Initialized empty Git repository in C:/folder/1/
>=20
> C:\folder\2>git init --bare
> Initialized empty Git repository in C:/folder/2/
>=20
> C:\folder\w>git init
> Initialized empty Git repository in C:/folder/w/.git/
>=20
> C:\folder\w>git add work.txt
>=20
> C:\folder\w>git commit -m "Initial commit"
> [master (root-commit) 1b314f3] Initial commit
> 1 file changed, 1 insertion(+)
> create mode 100644 work.txt
>=20
> C:\folder\w>git remote add origin C:\folder\1
>=20
> C:\folder\w>git remote set-url origin --push --add C:\folder\1
>=20
> C:\folder\w>git remote set-url origin --push --add C:\folder\2
>=20
> C:\folder\w>git push --set-upstream origin master
>=20
>=20
> I would expect those two folders (C:\folder\1 and C:\folder\2) to
> contain exactly the same bytes. And they did for quite some time. But
> now there is a difference in 'objects\info\packs' (and some of
> objects\pack\pack-*.idx/pack are also different).
>=20
> (all the commits are the same in both and all my data is also the same
> and 'fast-export --all' yields the same result)
>=20
> I'd like to know what might have caused this nondeterminism and if
> there is something to do to prevent that.

You can get nondeterminism because the push to each repository happens
independently and delta compression is multithreaded.  You can therefore
compute different packs on push and get different packs in the result.

You could try to avoid it by disabling threading for pushes, but that
has to be done on each client that pushes to them.  In general, this is
not worth worrying about as long as the data is intact (that is, it
passes git fsck) and the refs are identical.  It is also not especially
easy to avoid, since determinism of pack files is not considered a goal
of Git.

Maybe if you tell us a little more about your reason for wanting
bit-for-bit identical replicas we can provide some assistance in helping
you achieve your goals.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXp+2rQAKCRB8DEliiIei
gd9IAQC0gSuPAhJMxWMQ99GJPJB2Ht99KL+toF0VtFOqIQ5n8QD9G8J8ZQHxnfa8
wRCZkK0DA/IybT+TZqJbP4adcSCOdAM=
=royZ
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--

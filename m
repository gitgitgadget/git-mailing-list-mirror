Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1661AC4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 15:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C3D61206
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 15:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhHVPes (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 11:34:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48434 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhHVPer (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Aug 2021 11:34:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B7A560448;
        Sun, 22 Aug 2021 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1629646416;
        bh=eCz8iGvxrcZAo7fFL7n9VY61mdrDJlYi2FSdyX2EoDU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bJDw+pAKYQaoe9MDrStmWiaEuN7mdwxcwQGSrUBO+Bq5x89oul0UdJpmKloow1AL/
         5zXWpGT3hEorlG1umvRgSU6FFSxzrFqxlqASx4o3EmlfF1U+wJQe3EbaESA9LPmGin
         vFbaXQRNEd4dywHL41Hm0+E1NEJ6t/gdEsmC8nQIWzoR5ND8PGdp+jLnVmO/txgJ3S
         NxPkqbKvcT+i47s3mzm7dGa40lyzg4kYZch2dZxwuK2iuqE7CgWH2aDDQRiUu8HnVD
         Wy+HqdSxx2tZUwRNI66iap45Gqc3FDhbIYv8+DoOAg0apiX53lZDJeGOhVL5VFfj/o
         e9kfB71VdWWng2WmC93ECRi85wyZFanEuYbQM38YypC0xQZDUWvYj68gMGtyQuRx9S
         SRZcx9sjVXvT2gug8eUWw0yPwNWAQL149m8ySyYuqtD5wWN0DjQMEpffjlnwLacvKJ
         O0YdHeUN6g7DhTYYOvQOc+IHBQqfptw2kMcmSkOi5rK8hFUEyfO
Date:   Sun, 22 Aug 2021 15:33:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Daniel P." <danpltile@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git is removing . from the last part of user.name
Message-ID: <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Daniel P." <danpltile@gmail.com>, git@vger.kernel.org
References: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G+W8Thq4CVNvzsEa"
Content-Disposition: inline
In-Reply-To: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G+W8Thq4CVNvzsEa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-22 at 14:19:33, Daniel P. wrote:
> If user.name's  value has a . as the last character of the last part
> of the name, git is removing it from commit operations. But git-config
> shows the .
>=20
> example:
>=20
> in .gitconfig:
>=20
> [user]
>     name =3D Daniel P.
>=20
>=20
> `git config user.name`:
>=20
> user.name=3DDaniel P.
>=20
>=20
> from `git show`:
>=20
> Author: Daniel P <danpltile@gmail.com>

Yes, it does appear we do that.  We consider a period to be "crud" and
strip off trailing crud.  I think we should probably change that, since
in some places people write their family name first, and so a name like
=E2=80=9Ccarlson brian m.=E2=80=9D might be a thing people might want to wr=
ite, in
addition to this particular case.

In any event, it's not very polite to "correct" people's names for them.
I myself have certainly run into that often enough.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--G+W8Thq4CVNvzsEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYSJuSwAKCRB8DEliiIei
gS3bAP4prp3RK5GI7h4H6XcbHHFj8VjDkUuofBlIJnxsR3MkmQEAh07AZvxNnftM
4CCcZgVFMFLW7zyr2LGDJ7IaGNpU7A0=
=pp5R
-----END PGP SIGNATURE-----

--G+W8Thq4CVNvzsEa--

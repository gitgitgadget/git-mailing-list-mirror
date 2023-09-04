Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B52C83F33
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 20:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjIDU1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 16:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDU1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 16:27:02 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83036184
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 13:26:58 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 91C2F5A2FC;
        Mon,  4 Sep 2023 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1693859217;
        bh=dVwoJ0Z8i4/fC12SsFUydP50tHHL3Hz6bwOwwBJ06OA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CyY+ImOryFMrsWQ4n23FmtMSHCJy9Wmzz+88wPiOeGguGrPowXi+oHJEMKpcEeKwK
         deZr23+wiLrjnEvV3PSRnhlw6dfza7v/HIq9o69M831OSXdfPA6qVZnMC3sCwQBIrD
         vN5vpENYdOW6jUXgU7PMHjGAqALH304oiFiGxn3QqdgLZkvW79syU4syxiujwDTbSw
         Dgzww5t2F+qnLZUEmeaLx9WRAML8Pg2bGW7LV/r6mHBEusCO1bPOXmKal5a9PRpajY
         Y3w1QctdFmgPgJB6VGmmKELHcgfkMUmsDd0Z8uXBnMetVHYfONYHo53wxyyFnQX4Em
         ZtJB+UAHVgdxt9fZhZy2qc33EjZM25RM63DnqgOYhlTR34r6gLi0Hh+YqRLDGWUk9W
         EjJHPJmnp4H2OKX2w5for9nj0X/C+pa/q32cgjaWL2PdfwIEk8SpOZKx0Hp2ZC61Ij
         Ss+VLzTJVy/jo7GHq4Vhftwd6UXEeMGSIkNuawbMwwnRmLfEacD
Date:   Mon, 4 Sep 2023 20:26:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] var: avoid a segmentation fault when `HOME` is unset
Message-ID: <ZPY9j0XDt/VVMnhG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1580.git.1693808487058.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vk6NxI33Atv9ARs6"
Content-Disposition: inline
In-Reply-To: <pull.1580.git.1693808487058.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vk6NxI33Atv9ARs6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-04 at 06:21:26, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> The code introduced in 576a37fccbf (var: add attributes files locations,
> 2023-06-27) paid careful attention to use `xstrdup()` for pointers known
> never to be `NULL`, and `xstrdup_or_null()` otherwise.
>=20
> One spot was missed, though: `git_attr_global_file()` can return `NULL`,
> when the `HOME` variable is not set (and neither `XDG_CONFIG_HOME`), a
> scenario not too uncommon in certain server scenarios.
>=20
> Fix this, and add a test case to avoid future regressions.

Looks good to me.  Thanks for the patch, and my apologies for the
oversight.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vk6NxI33Atv9ARs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZPY9jwAKCRB8DEliiIei
gT3vAQDCt6tjcu4ypI7Hrrx+dRZw3+lynGW2lXTxlRMLNlhQIQD/Sefyu12xzF+M
KNBYcFsTX/e55dPQtin8fH3b6lKFUwI=
=AVgA
-----END PGP SIGNATURE-----

--vk6NxI33Atv9ARs6--

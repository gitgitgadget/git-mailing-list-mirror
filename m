Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AB6C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjFBUUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjFBUUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 16:20:11 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACCB1BE
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 13:20:10 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 625D55A210;
        Fri,  2 Jun 2023 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1685737209;
        bh=MSk6sJS0++cwbwic/mkYsqc0peGdwZsLdZqHwpL9C1s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HhQ86JCFpjQJiYO85FYBfbolwicuHm1kL98rnEWlx2pvl4L1R3SEcA1IPlQBl4Cud
         PyLo6JXkjXLCXDryrPazqDF3HYDJjeKkfMIvCITMyfhfgJN6nY5GQBLjPmhz4jXEP/
         yBJO8B1965gndZ+UW5AOhOl17hd5kkH1vedZFbqBD0d+GRXTsjVxP0TvE7Bb/3lEtm
         HV1hZjIz/FCLbuEjh8UVcczXqig1dsrNPJ5fIZOgR+FcxI2fguaMU8wnHg/MP7i/Jt
         6xAuMTVKFmOQ5mTdnbnx2fN9nxjlN++vt02YYMf2Ul5Gbyterz4ynM60j25EsNd0kT
         Y7COn1gPuJU6k9TfHxEyHTr3qOoyfhOm5Z3oxfRxuK2I76yCW//vGDqb4K7sJEtLPD
         seyn6/plGXUQ/V6tyyKDC8ijc9sQ3fZuEJYv34oX6Hra8ZcT48t0OiooSZmeq5xpDc
         c76Og0Cvs6dvD5sYSVGU1FeAkoKB9Bs66ac6et3QBMa05kjVYem
Date:   Fri, 2 Jun 2023 20:20:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Priedhorsky, Reid" <reidpr@lanl.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug? subprocesses can use wrong Git if $PATH is unset
Message-ID: <ZHpO9/4RSbeTy0HJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Priedhorsky, Reid" <reidpr@lanl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <E7D87B07-C416-4A58-8726-CCDA0907AC66@lanl.gov>
 <ZHk5V6U9gfkuwErH@tapette.crustytoothpaste.net>
 <412E82B5-79C0-4AAD-8219-AA7664E9EE1E@lanl.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q+1meq7PItSVluIG"
Content-Disposition: inline
In-Reply-To: <412E82B5-79C0-4AAD-8219-AA7664E9EE1E@lanl.gov>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q+1meq7PItSVluIG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-02 at 16:14:47, Priedhorsky, Reid wrote:
> Hello Brian,
>=20
> I do wonder if the behavior would be worth documenting, e.g. at
> https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables,
> where Git=E2=80=99s relationship to $HOME is also documented. I would be =
happy
> to submit a pull request.

I don't think it's necessary, since it's expected behaviour for me, but
I am not the only person on this list, and perhaps others would
appreciate a patch.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Q+1meq7PItSVluIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZHpO9wAKCRB8DEliiIei
gXxNAP4s77sZ7qdSVXm25tmu1293a8xcl9sL4eB/CYe4nuGV+gD/T6/YE6OUxKhm
h9RLzb5lZP+9oaNX+GyHpBMjaxuQUAU=
=Blzf
-----END PGP SIGNATURE-----

--Q+1meq7PItSVluIG--

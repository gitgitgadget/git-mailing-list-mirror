Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF28C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 20:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775F722AAD
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 20:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405959AbgLMUj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 15:39:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59856 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgLMUj6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Dec 2020 15:39:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D3F6E60769;
        Sun, 13 Dec 2020 20:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607891927;
        bh=bypcX/xfS/QyOr7YI/hzC8uS7R+C+YW6MA+QghoGHqg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZlUi33CGzoM/DNJaXELHCX+rprfDPxT94Q78T37QmVep9kw+71ffDhWmFFL+DPQ9v
         DRJeo8ZLeWvSE2OakxyQWwo/Ww8lJLpqEvd73QSd8aSxBuktoO3ekeaCG91zu863P1
         XGxu2cOhc7LRjzJrX/Y1zHhY6ZkJztEHorVDp9zyQ4KVPLh6rHfM3+TWgFdnG2y3VW
         qDLU7ayPRJboiHTwqaSJP3/x+fyi4ZrBNxzbO7vQpeR5NW5gxHD4+r2+nQKCMfL3Uu
         nFi1toQOCm9vytEI6GdIb91aLoOPB4RqlDfK+bZe0d19MtRCnzT6HK1SRDiG2GWTU2
         pKa3jvPRF7P2phQ4Jvyn5w+kiCwOZXj8hWS0ideSVPqWIPL7r2Nbgd1qq0HZK4I7jZ
         3nYN3WeyqgRM2ERDceGjh6bLyegSSBasO4dvfiuQVYprLtZIjrDtQ1lIna3wEkhWeI
         SJAZl0HYEC8qIAM39feRphCwlo1JuM8HOh12oFlBS0xGnskcvBs
Date:   Sun, 13 Dec 2020 20:38:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] mailmap: support hashed entries in mailmaps
Message-ID: <X9Z70aNc0cWcohNm@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <20201213010539.544101-2-sandals@crustytoothpaste.net>
 <2cc4925f-3661-1dfb-2668-5f56edcb8455@kdbg.org>
 <b297b843-99e1-152d-aed1-20371af42d42@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bNJkR0HLIrxRuDwo"
Content-Disposition: inline
In-Reply-To: <b297b843-99e1-152d-aed1-20371af42d42@kdbg.org>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bNJkR0HLIrxRuDwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-13 at 09:45:58, Johannes Sixt wrote:
> Am 13.12.20 um 10:34 schrieb Johannes Sixt:
> > I don't understand the concept. A mailmap entry of the form
> >=20
> >    A <a@b> <x@y>
> >=20
> > tells that the former address <x@y>, which is recorded in old project
> > history, should be replaced by A <a@b> when a commit is displayed. I am
> > assuming that the idea is that old <x@y> should be the "banned" address.
> > How does a hashed entry help when the hashed value appears at the right
> > side of a mailmap entry and that literal string never appears anywhere
> > in the history?
>=20
> Never mind, I got it: A wants to be disassociated from <x@y>, but not
> from their contributions whose authorship was recorded as <x@y>.
> Therefore, Git must always compute the hash of all of <x@y>, <a@b>, etc,
> just in case that the hashed form appears anywhere in the mailmap file.

Yup, exactly.  You can't specify the hashed one on the new side
because it has to map to it, but you can on the old side.  Sorry if
that wasn't clear.

Come to think of it, this probably needs documentation as well, so I'll
wait for any other feedback and then reroll with that in there.
Hopefully that will clear up any potential confusion.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--bNJkR0HLIrxRuDwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9Z70AAKCRB8DEliiIei
gTnAAQD+1+dhEMrA8+fFqI2+8XDVk6ml/Z3WVX0hKEsLCmATowD/WEM0sDEV5Ym/
g2LPvIXvGBd2BHaY9hHD/6mx/nvTkw4=
=L4O4
-----END PGP SIGNATURE-----

--bNJkR0HLIrxRuDwo--

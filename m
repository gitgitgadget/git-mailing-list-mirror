Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21EC1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfG1Wtw (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 18:49:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57190 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbfG1Wtw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jul 2019 18:49:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:2120:88a3:41cd:c920])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D85B76047B;
        Sun, 28 Jul 2019 22:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564354189;
        bh=14mI9OS88fLspCaxBj8I9L9w4P+wiCUxko79OuAO+Kw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wmcqJEgPckhJQu93cj5yghgFpLI9XHRDhJYohJ7MrIQURW6UfZ/hPcxbVBiQkUSPM
         1HP1qZHIwWqvJbEdXrRey7WHALoRX3yDy7JAE8JSWKbRpanI6RqiNjOPclXaaUu0Go
         TrzJrtXZ3/D6d6KH2zrxAjeepknVIZl8YknYkpuREbVDDcAM8ORpdA1YvjqmzRPBLo
         3Gnp/LVnOgpg2o+FE7CRaK0ZbINhtA11WFaCStNiUsei359smBxlSpjYbqmBdrpL+C
         u7BkDC+sf9D9EB8wQEE07YbUWBEC4GEjQuxA0rWiYqT2hbhHL++Pk775W/3O6Qh/vM
         Pqs1I3WzL5OVD4XVugQGqDnrdD+sjdId4CSJ2zRdbCSHPAU28WHLjp9K51dCIqRfeo
         mPXpjuhZ/HMCx8Psa8u/tQ1OHoP+2ssIkLZtPs8J+G19sw9x8vZ9n7fhWEoM812tLu
         kcvcUuOwwogYleLh/HzkQENQbAUDXWQMjTDn+PC65Pfr4Y+g1EU
Date:   Sun, 28 Jul 2019 22:49:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
Message-ID: <20190728224943.GC162590@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pratyush Yadav <me@yadavpratyush.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.0.0-trunk-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-28 at 22:10:29, Pratyush Yadav wrote:
> The function is not documented, and I only started spelunking the code a
> couple days back, so I'll try to answer with what I know. It might not be
> the full picture.
>=20
> Running git-gui --trace, these commands are executed during a rescan:
>=20
> /usr/lib/git-core/git-rev-parse --verify HEAD
> /usr/lib/git-core/git-update-index -q --unmerged --ignore-missing --refre=
sh
>=20
> Since I'm not too familiar with the details of these, I'll let you be the
> judge on how expensive these operations are. But I'll add that rescans are
> pretty fast on my relatively slow hard disk.

These are probably pretty cheap on all but the largest repositories. I
was worried we were enumerating all refs or all history or something
like that.

> ui_do_rescan changes the focus to the first diff. It is executed when you
> press F5 or choose Rescan from the menu. do_rescan does not do that.
>=20
> Resetting to first diff on focus change will get annoying when you are in
> the middle of looking at some other file. do_rescan just updates the
> software state without changing what file you are looking at or where in
> that file you are looking at.

Yeah, this definitely seems like the right move.

> I'm never too sure what I should put in the commit message, so I took the
> conservative route. I'll add more details in the v2 patch.

Great. This sounds like a well-reasoned change. I'll let other folks who
use git-gui more chime in to see what they think as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0+JocACgkQv1NdgR9S
9ovwlBAAkMS2yJkMn4R6P9Caix9bKYU9DndvaK7JbP9ACiOwh+dqkbo8UmNoT+nA
3NU5U3zOYdahVq11j/y1Vre2qqizAyE+Iy/L3K8mnUeb9417/6wVEdnWqVrrGTSt
ePWi+Vn0P3iSfWAZPefQ4tOEMNi8grIhkpVQh6wjv6bmDnfOnTdZRXZuPvUsVhXh
IAJai9P9s1v6mvbp1I32il/yaYbD/qwGbob2FrUlx5yBhkLQYkuufa2v4q6Y6T3B
hriQ/erwCT5MVH+s0XPSvel/iHaw6aDVdHcM1CU3s399S6HCHTw2sMnrGCI1SVx6
pKPef5uXtSEGymnrTmrBHrWkEVwwuvcQZOC355GOFPPUs37k0WAD0rjkVJlLPacs
oGGbTcIXXddasdBXaijVJErjtgTl6d7fLIxhrYelEOMXqx+RGp+t4zkP8a3awrFr
JYDV+DMqmWh/MDPjgcBtJO8d5bDN3lWawHHH9qHJAw4mMX5tvoijmnMScR7DTbx/
A5NHAfNFZtHwPD9hfdirHexeaI7qzO6uGlYGjnxD2ete9SQUytAsEcfnVWLpu3EM
7KrGoyhclKhulVt0x8dKKL5RSc0kyhz/hUSbXWardCRhgo0bNzsAyyxKFn7N+Pk7
AhuOGCBGwidw4CJAARATCiAUuaiH0Lpa0ZDQlhtMtO1qmYz2KtM=
=cmom
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

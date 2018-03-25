Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622F01F404
	for <e@80x24.org>; Sun, 25 Mar 2018 15:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbeCYPUc (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 11:20:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42358 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753321AbeCYPUb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 11:20:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8F7CC60428;
        Sun, 25 Mar 2018 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1521991229;
        bh=RYDn8wYrY9IDUf0Mv8ROVwMmK8RgjmtDMInH0oomJmA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mK1bGxFA13lwY/gFeIMoICp9zM+EiJai9XddknP/xZohPTot+4wYqZqchiz/UzCBR
         FH7E9W8ta/B+aEnJaPHEKrCLPpCR/kF3V46+SVmgm+wI590q9Fc0tQ2zKubjjaTms2
         /whqF2jNo36d5/EKyGdx4eKu1nMfSN4fe/N8ZEab+7q6bmXVze/WBGGSRkc9Y4O51x
         JcD38KNBwnoub48Po03MEtvc1IPCfZBY/r5+D6K1jQrK2pm1heEXOhMycWnXifnvl4
         GRQv8yIDHesbqro4vTLuf3B45V8SmK8SfeEh0ZlDoMdGl0uz0fYEAnDv6lkxQDW1pj
         wrGuqliE/ID9yE0aQAKG3wcSFi9vI8oLXxId2BAAcFIH1BgxtPpigp4bxceBGywHFs
         oK3sGgYs3WtEdI7OymvCAhvrnW9onnzRzoqT5YBzmmI1IOezCtP6H/6vqfigDAlmuo
         QRMtlHvKFmIpXOnTdjh4uvNoSFhwR7mdHXwMtRbfGIj98F9o8yO
Date:   Sun, 25 Mar 2018 15:20:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: use oid_to_hex() for converting object_id hashes
 to hex strings
Message-ID: <20180325152022.GD74743@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <9839073c-84ca-f00e-d0e1-801e521ef29e@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <9839073c-84ca-f00e-d0e1-801e521ef29e@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-rc5-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 25, 2018 at 12:57:36PM +0200, Ren=C3=A9 Scharfe wrote:
> Patch generated with Coccinelle and contrib/coccinelle/object_id.cocci.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This is a belated follow-up to f0a6068a9f (bisect: debug: convert struct
> object to object_id).

This looks good to me.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlq3vjYACgkQv1NdgR9S
9ovwDA//XG+NcCVxli5NBwlZSvzsjmOb4bsR/ncsBcekYavC75GZUtmqy5j+IeAX
Oa3mAEP1qAKNXM43ahRz0SBJON8jYBp4N4+UmVajRrpovf5woMtEc7WTwf43pLfo
z1cS4oB8fD8Gg/1XParaoKf9D3oMkm7JnJNoK1/5xgeUwllOwolIgzp1yekCWW2L
SQLbSWpK5lHoapaWqE0Bh5yhsPocsNCjbc2YKYhL5elSOjQK+jLhmAkm9t1W6eFm
vMM+ZO0nJ/Rxzo4DpJRwsWrFGyVDEnAIBhi0SpcmQpat0cGrZr8Gti3nCzNIHd61
ACg7jLIxxXkGHPva4Dy0GjxynBQjuk+dpk6rQurckJnGA0c7nsOhoYOL9UEI1FVB
zx/yUbPMXLHM7sGE0egalc6J3Y+Le/Xv6DS0gPV2OIDHHyH63Hj4wR4RacVZqEea
l9vR8cZGxE80o4Tehxl+WUjE1NqUgMqcikm2CfvXuKnALWW4mZdu/TLEW0chWHsR
u6ik+n5UewhDAaSU+ErTQOLTj/T12jmXNKvxaz/dirKVM4WBv0WyqTZwGpW1kIAl
4iJUtqeePNc4EzMCYenrJQtJcRDas/LFNjhUyLhkIY2QyDnabdZyamZrXK2IGsTv
ohjl1JckAEdJCbYwS5MR1hGXhBDsjD2xsLWv9GPEzxHwRqqnZ/U=
=90Ec
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

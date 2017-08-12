Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A35208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 15:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdHLP7O (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 11:59:14 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:51392 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750851AbdHLP7N (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 11:59:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1542F280AD;
        Sat, 12 Aug 2017 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1502553553;
        bh=VHluxrXUS5478mCubWLTDR+E0BeDy2EwJzgfNVuOjEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEpbjLJSSBMUEsorct5Obr5OZYQnmJ+kczbnTIFthpdWxO6T/da9cJRFM0CFlgCwg
         LBaOooL2YVNhTo29v0oJs46DdU8rbgRmPWsl9TN2zsvtfIbT8HKIAXqLS+CdD3daHm
         DJ55/oOPV7C6c2TmOIRP/vujJ8VrKBkWhOHfKDk718A/oxtG1Gi2nJUv8yZVgLmntL
         shW3X7QgqftXOT7zHCl9n6fynxUXD+rFRWJ4MjcTFfaBRlbsondR6jBRbb+GQCujp3
         a5MF9A31e3zGu6LiVjTuzsAXhKz19PmoiGSNC2M8f6sXM1Xmv+RvFlYPtCxs+6l9cU
         9DbKWHnfRTq5X8zZBRAteCShvDg4Sc7P2ibCf5P/KajFsMb/0ka297ylCchPReSvA/
         nVXW5CSurfVOt+Wl8GMGVgVQcn85/J9ArgwVhdxDGR/1n9haJ1iHX3IGh2cRwEQPJ/
         f8YdiNLY+x5ChAAIeZL9DJnndtuarwzlA2j83MUBMd2z1Z3anwm
Date:   Sat, 12 Aug 2017 15:59:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Subject: Re: Error: Permition denied. git should not try to access root
 account if I work under common user
Message-ID: <20170812155908.yadkqwfjrxsgmljp@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        KES <kes-kes@yandex.ru>, git <git@vger.kernel.org>
References: <273951502544128@web54o.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6mcy4rqqwvkwlxfz"
Content-Disposition: inline
In-Reply-To: <273951502544128@web54o.yandex.ru>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6mcy4rqqwvkwlxfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2017 at 04:22:08PM +0300, KES wrote:
> Hi.
>=20
> When I use `git pull -v --rebase` command under user I got this error:
>=20
> POST git-upload-pack (947 bytes)
> POST git-upload-pack (452 bytes)
> remote: warning: unable to access '/root/.config/git/attributes': Permiss=
ion denied
> remote: Counting objects: 4, done.
> remote: Compressing objects: 100% (4/4), done.
> remote: Total 4 (delta 3), reused 0 (delta 0)

These messages are from the remote side (the machine you're pulling
=66rom).  Something there is telling git that /root is the proper home
directory, and it's trying to read that file.

You should find out whoever is running that remote server and tell them
that their server is misconfigured.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--6mcy4rqqwvkwlxfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.22 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmPJcwACgkQv1NdgR9S
9ovWqw//RQf5rzeE3gqg3okbUGJDAFuxvLNtFToiAhlFwgAUzhURIwRHXN2flmdI
Rten9Safw6EjrV4gZ8ZYrQvSPG/zj6+gbEqTtlja2D44lhSvsDYbvDgXymdlq2HA
o02njcKZdSwEUZgijGuxyITMSajTKoUz8x17oXtQD7+Wsj4LnXalkKHvGiwlhkH/
cqXxNnKWUvYDpNMrd7JwayvLui4mQcv5SGpatiCnrzZfu4qtd17EdxFMdz1YWMci
ElJxqZHpR8it2BqcmXMUseYxay2wG3viB0Z5jfGwC4wJO1t1yOlbwn9RgNbplKYE
h4X4SRS2LYqoJ234VaMBHk4P3P3f4Mpd9yrYtX0EImlYGPwg6t80tqFdh7/w0oqQ
1/TvXbPoy4R4cfYXe1W59po22JuEWp7cTL7cdDfM4KJCv91cmCZCiDC6jtvC5FFV
YMiHY87NSerZxh7V96a7INMTrT/n3Ou1aK74asHnBXhGcOKeX2LjXQRrtLLV4FuD
sxfEPI4TK6MAiXREiZcmdjSbWGwxOWwLunGE1LnZHMxYcMfh6B/g5AgCt2hLoafw
WcUdJ4EKg+IsLVcl7M/eizojqNKWUTF4nZRXVCp2eKufazY5c4kBWypy4nmhbQu6
PF1Q8XSm3DZy/6qAiXOLx6302adWF9faBfmFx0i3dVJmKNjoFnk=
=0HcB
-----END PGP SIGNATURE-----

--6mcy4rqqwvkwlxfz--

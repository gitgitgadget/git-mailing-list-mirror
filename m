Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652D31F403
	for <e@80x24.org>; Sun,  3 Jun 2018 23:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeFCXhx (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 19:37:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751412AbeFCXhw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 19:37:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6369B6073C;
        Sun,  3 Jun 2018 23:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528069071;
        bh=jsfl5LUikOjJVDckMxWosXE0BHDI8L9DRf1FNMYE39A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=aSPd46BUxL9yMSW63WhadaZPdgqiLvAite2rmyfudxOJfUfc/4lOP0dI3u0h9QwNH
         da9vtILwr4YngAfcx5OswPRgmklann6FKzoqkMNPQkFfnCderJbu7QTaIO8MQnAPA0
         6chnafjK6+/NsoEKe0xuWb6SevBC91Z6QCp6UG3VkwJOv6hKwHVdlnjrhSE63OpGr8
         HhlkR3E5eR3rvgR0ZpG0uJJ/+GjCLKK/uJTiOkCQCpN4mtscfNBqdZNoGbGZaUkJBA
         oMaR6UMIbwWGqc+A0htkG1CRGxXty5qg6OIlzil6bHbs3Amw9QBi9Z1atH9xQhp+zG
         Ub4m7793ihvqkEKSrBmG3FCEwluZa4d1P5aZ8MMrRlSjg8Ah/DPAqMnAghwQyNvVWF
         pYsg7HXM+SCfnWkn1y/pX6lcCphtFVpdhAEexm/ie3Nk5CFbxLIk8jRk1+DWu6Mi/O
         b58KjNqOkXQdBkPRYeQ92dACeWidIs0gSTTSYvUS/+1egoRu/Q1
Date:   Sun, 3 Jun 2018 23:37:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 4/7] merge-recursive: fix assumption that head tree
 being merged is HEAD
Message-ID: <20180603233747.GB288937@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        jrnieder@gmail.com
References: <20180603065810.23841-1-newren@gmail.com>
 <20180603065810.23841-5-newren@gmail.com>
 <d8f9f7a4-16c7-8258-1210-ad3d32f3d57b@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <d8f9f7a4-16c7-8258-1210-ad3d32f3d57b@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2018 at 02:52:12PM +0100, Ramsay Jones wrote:
> On 03/06/18 07:58, Elijah Newren wrote:
> > I'm really unsure where the index_has_changes() declaration should go;
> > I stuck it in tree.h, but is there a better spot?
>=20
> Err, leave it where it is and '#include "tree.h"' ? :-D

Or leave it where it is and use a forward structure declaration?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsUe8oACgkQv1NdgR9S
9ouY4g/+P0pTv+/jEDjRWPzEp8ju4dBPG0VYvs9Hzfx4DpokzsAdDEL1tHk1EURM
ni1VqLbq+M7r1qeIKBAClbm7cOUNjQiNZm4ou/gTZ3+Hq3u1Z6KQacQlO/9cZdQx
CzbSehf2YHzL10se5emJXIELp6HNXjTfIRkfdwazvv5+PpsmGCDuevRNh2QoiI2d
B1GwQKWLP0bG7+W2SM9djQ4KRZNNf1iDnbZOHjqd4+yqzbYHaqc6iVKkN9nmWboC
e4pzpFna8tmw9wWP9pCv44r9//YVtzDNF4u1T9XcIaaDjNKJDHSveaZPTiD9NcqS
mQ3dlK9O0TzZ89eCas4S2N0iYUFsOoEX1qbGK72TuGaxe8cAhdFHntVilZmB2nKu
ZsiAQ6ReoD+rH/ahYVeGUBvPadKYfgbYWRPxK3PVSVxbIACZ5cAEUJfJEZdlgFYS
sAgRJk3ufrNtJQfu9PJTEdkREv001fFQW82Bue2cq8CnBFsMy2RSMkXC9exnwVc1
G+eXpox/PQ2L6fPXTTB52hzXv48xFzzp77PhmOYcHov6LEty9XwQeoyJ4kOG7UEA
gQop5vbGfxPySrL+4YPu2vkWTswZCcTnEw8oqIgYYiVaDKoD+L0ODfQ9+HvPGB5F
2J6ocy+1NcwKI/biRlLKro1iSgtGB+k4l1MnyYetpzlXcC2JOMc=
=H3PU
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--

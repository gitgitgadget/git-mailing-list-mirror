Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13B3208CD
	for <e@80x24.org>; Tue, 22 Aug 2017 02:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbdHVCLb (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 22:11:31 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57778 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754353AbdHVCLa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Aug 2017 22:11:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 89C68280AD;
        Tue, 22 Aug 2017 02:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503367888;
        bh=85XV1QgYGe/sbKd/HztXC5OcEXMOxjLKKHI86fybyaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifVZWxh6DcwUV8UsBMplqCcJCrOa/a/Np6/jtuD/qzhuqP2W98B4QokReC6D2b3if
         zezC0INbM27dq67ZhEqtt+Qnymw3Mx349+z5+zdXV5MeWnq/xv//Is9vhUSfjZ1GCr
         GAZNvAI2SmYY1/7ff4TwUwg++DzIBJfPo/25plX2CJ3zislR63rAzPVkWLyCb+o4f9
         kWZd6rgE0Jx4Kd8UxUt69bJ46Cr9W9b4/I+ISt3un9HH1Q7Yl9HXCg27rvI2n5ARFZ
         /sLnA1QR70QHwRMapDjdTq8ABmbVlVIIf27HmXqU9KoLalA5MqvBzU2BjeEpWt0Qqu
         bn0W2kHEzOXHVIMYw7uKVdwGNtYYvXy0cjPwbtf2WafYcEh9Bww7sdAU85PlDY1xic
         8FMyxXAZkS4oZtRdjVhHb365bQFqXvIbSaiBbop43e/+onxaRBxVlqjF1wlQWjBl/D
         Y9LdsW/c1vKoXWEOg/VsjVn9Jb9l6u0UasH4iVyO1v681++IA4t
Date:   Tue, 22 Aug 2017 02:11:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] repository: fix a sparse 'using integer a NULL pointer'
 warning
Message-ID: <20170822021124.4bmlzpdocgheo55b@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <91150cfc-3271-16b0-33d3-9a4e149dc9fe@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcs3v4p3zx5ezjlz"
Content-Disposition: inline
In-Reply-To: <91150cfc-3271-16b0-33d3-9a4e149dc9fe@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rcs3v4p3zx5ezjlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 04:48:42PM +0100, Ramsay Jones wrote:
>=20
> Commit 67a9dfcc00 ("hash-algo: integrate hash algorithm support with
> repo setup", 21-08-2017) added a 'const struct git_hash_algo *hash_algo'
> field to the repository structure, without modifying the initializer
> of the 'the_repo' variable. This does not actually introduce a bug,
> since the '0' initializer for the 'ignore_env:1' bit-field is
> interpreted as a NULL pointer (hence the warning), and the final field
> (now with no initializer) receives a default '0'.
>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>=20
> Hi Brian,
>=20
> If you need to re-roll your 'bc/hash-algo' branch, could you please
> squash this into the relevant patch.

Of course, thanks.  I'll almost certainly be doing a reroll since it's
an RFC series and I expect to get more feedback on it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rcs3v4p3zx5ezjlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.23 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmbkswACgkQv1NdgR9S
9osEZg/+Il0LJBKZ69hK8mgE4eYopVngd9uFi9TlsfC0vAynczgdlJX+lMJJ980P
WeIqa/YnbI7RtJIyfbl2lpah/l1XIPbAvvaZaqA5HM7wbzCvJMz46mWUtTsdY+bi
FbnWAVMIqzM/51yzWpy/7M4Ji4uEFfbgbp+v7BLBYUO62iaHpuJYgqaVs8QsfwgK
BO+h+7LHuJingExQ//PfSOaodN33SxuFokzMW5h9o8zP6EUqNfG1hag9eWpNP/Rd
q6SEeH3zUsslVfGSqQLsUK8mpeNhdqk28jB/Jz9TZf7tdU5k8sA2riWyDRfVqwjt
98Z6hGOXs7b2IjW+p6eV5KG9+52R8x+08KexQESjEB9S5FCLqzQW2F3TktDxOA8t
Xb1pnWnp5yeLTaZL6yvDM75Y5I8Oe0QqtLsPaDo1uTy7UHMhjDYVdIbWg0lrhWM5
wR7rdlBqTNA56/U+fDtf+7bzCa/hqe6UWdeN/IycMnviXaIoo1qZXc6TesfSm4Br
emPlrm7a3YlqMqnzIc2uxwdQxT9TU+uyVa0uEuxm/JDxYkgPXbqj7dTDTrKY/+4c
rT/Qfk5fhOJSEJ3ZZBi2wRAWmaqCpK/wiF9pVAmjGbutYcobRqI56q4pStzrbOwW
rKaSUJvQQyOHl+DxHCypKk+S9x4bnFyjziJxhrv589luE0tgrlQ=
=1sLL
-----END PGP SIGNATURE-----

--rcs3v4p3zx5ezjlz--

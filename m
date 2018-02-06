Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04ACE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 02:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeBFCUl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 21:20:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58730 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752187AbeBFCUj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 21:20:39 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C93C6042C;
        Tue,  6 Feb 2018 02:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517883638;
        bh=2u/0nzvoCzLjzBcGSFMjlq9VZOhMVLu7iDpd2hjxsr8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=z61BBLSGNmfesM6eZx4o5N18bnu1UDfozTSwtlSKHKPfdy9jVTtiMyVoYwrJbcv0m
         WM3DtvXP24ybDq+9ckk4+j5cmGAE0n4CMuv+9iHKgT/IsLrYlTQCqxtcPzk6F9bgC1
         Oh+YpK5tPwtIgXWG4FnJAzDO77fl8q8NL5gyjKBE+wzpcCGilhDfJJo8LqJH06bgGv
         Kgk7Q5PJE8s33DdIjyX/BNANfmx2sBKiXOUjKAeVQwMVYDSJ7MVG2SJ32sywJWD2Ui
         wQXk7BaVckQggzd7mxHpfwreY7uZqjm5o1Xnk7Ea3EI74p/fE0Ik3bVqJwYQLtZPDZ
         gD7C0oIowZ6K1kxxlInFp7MZbMN81mONfdtoOey2dkA7bObCSrXNYKj9tucFg0m04x
         LS3FWuQ1gefMvq3zsfinxRLOUQ4Owc6eRKXj1+cYsl2wliYXnGSR/UrzXnDb5rjobk
         QZvtME45MnkHqQsPOW273w2r3Q3+ftGfM+yYZCQoYwF0/tgJtKD
Date:   Tue, 6 Feb 2018 02:20:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 076/194] push: add test showing bad interaction of
 replace refs and submodules
Message-ID: <20180206022033.GG7904@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-56-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <20180205235735.216710-56-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 03:55:37PM -0800, Stefan Beller wrote:
> The ref subsystem has not been migrated yet to access the object store
> via passed in repository objects. As a result replace when the object sto=
re
> tries to access replace refs in a repository other than the_repository
> it produces errors:
>=20
>   error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not p=
oint to a valid object!
>=20
> Add a test demonstrating this failure.
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
>=20
> squash! push: add test showing bad interaction of replace refs and submod=
ules
>=20
> replace-objects: evaluate replacement refs without using the object store
>=20
> Pass DO_FOR_EACH_INCLUDE_BROKEN when iterating over replacement refs
> so that the iteration does not require opening the named objects from
> the object store. This avoids a dependency cycle between object access
> and replace ref iteration.
>=20
> Moreover the ref subsystem has not been migrated yet to access the object
> store via passed in repository objects.  As a result, without this patch
> when the object store tries to access replace refs in a repository other
> than the_repository it produces errors:
>=20
>    error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not =
point to a valid object!
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>

It appears you have multiple independent commit messages here.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp5EPEACgkQv1NdgR9S
9osOIBAAuqxWJhc/Qbsop6KFt/CjatuXeFBsVaAtKHyDIzJzJXis2B8peervg4CM
AlmBVLMhqz4NtYyLSCRRQjQdG+GrXP3JqImRQZyYio1E6gAVxI3hlFyr2/g5H4KE
6weFJYBxiN0MGI/riHqmr+3uM4Gsm1BZeGs1m+cgtzmupZRcAS8Rj7S8Sl932/G1
fkc1r2AEYUIKo/nImzamVQZ1cuboGBOViHXpJ3V5OQYoF+K4+PJGsdPwtY4tgTSq
8PsIZehMsH8lDGYJRTwV5XyARmiAOFtgMniw5y3p546zIWw1QAgGtqlWCijMP3Sl
x7KiTQ77YcPtCTx9GzlDNNR/wRk1hmyHEdUo9/tqPgmMNgcxsKlXUsxATZXxx1xh
LhIYphb/+Orrb3Ud9BHB3khL9Bvsrh7P0gS/TGOEazAE2IED/G4I2EocVuDbKqSX
5zBLcGFI2b729WiABdJL3LrzaR+M9VdZaq6jG1qN0vchfq9ZNyELW4jEPEv5zRwN
fP0bwhRwia4ATYMqYqlBri19EqC0W23RngOLpiRBFZcsYEpE0lDNXWU0Y1d1O9cz
diGA5tIREzsu58tcalDYk251872unXIeR9F8RHNSN9TC+ZEoOwUfKJ+eFnwXCERL
Go+YWodeeVgwR/c5cIiYBXiGNRBpz39CQEclZJXqgvR56TSYLY8=
=V9Mt
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--

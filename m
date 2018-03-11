Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B791F404
	for <e@80x24.org>; Sun, 11 Mar 2018 17:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeCKRVx (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 13:21:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34242 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932167AbeCKRVv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 13:21:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 458D76042D;
        Sun, 11 Mar 2018 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520788909;
        bh=TVM1Lt8EQkZvmXy/KruaOn5Fd86EEj5SLdvib/2TZRg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tyX8tct05PhBQ+UAa32Zs0FML/8G1b2az+5rOpoeYwO5TrzGcwNFJ6JlPZ1mAF8bF
         QobXMzumH1aBBII6CodakWcJYfa82nS/KCKT6UWhJcDHGG9RhvdpUClluZqyJ7UFVC
         54qUDKfDHx7zzvCmsCsTs/FrGrlcehw5ClKwuDu4FSKVCaL7K27DOdNwM6An+CHC8K
         PNue9Vf5ILpzOoV3eUolbvtX96slbdZaQO8xYnqZXcDpk1A9XYm+7ZNf/ycoFkNdz7
         1JO2l7wsLlzBcDC71PxpAGRL/iCLxbZCvSoDHH+az4i7E388P/1I2vGEert/aShugv
         cdQqzYdx+RvnlQwfsv0w1N2PudAWBnyMdNWNzk6ETLBx6WMHUlkXKLzxHu/Mchhv0v
         t/nN2LBc25xf51DL4H9rNnU69YEwAYgwHcNVdmyoR6/86F/pcHMknTX2ibURwAYbxQ
         Qpy/1RZLXWzo3Ph988KU5lzvIC+02Ly9xq2P0jHUvmFl/mj9QeP
Date:   Sun, 11 Mar 2018 17:21:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "NELSON, JOSHUA Y" <jynelson@email.sc.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] Add config option to gpgsign IFF key is present
Message-ID: <20180311172142.GA249931@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "NELSON, JOSHUA Y" <jynelson@email.sc.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CY1PR02MB13991271133B3A6BD334328DF4DD0@CY1PR02MB1399.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <CY1PR02MB13991271133B3A6BD334328DF4DD0@CY1PR02MB1399.namprd02.prod.outlook.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 10, 2018 at 03:28:43PM +0000, NELSON, JOSHUA Y wrote:
> Currently, `commit.gpgsign` allows you to give either 'true' or 'false' a=
s a value. If the key is not present, commits will fail:
>=20
> ```sh
> $ git commit -m "example"
> error: gpg failed to sign the data
> fatal: failed to write commit object
> ```
>=20
> I like to reuse my config file across several machines, some of which do =
not have my GPG key. Would it be possible to add an option to sign the comm=
it only if the private key for `user.signingkey` is present? It could be na=
med something like `commit.gpgsign=3Ddefault-yes`.

Unfortunately, this isn't always possible.  You can forward the Unix
socket for the agent over an SSH connection, at which point the remote
machine has the ability to sign, but the gpg client doesn't list those
as existing secret keys in its output (because technically, those keys
don't exist on the remote system).  I use this technique at work, for
example, to sign things on my development VM.

It might be possible to make the failure of the signing operation not be
fatal in this case, although that could cause people to fail to sign due
to transient failures even when the key is present on the system.

I usually handle this by storing my main configuration in ~/.gitconfig
and on machines where I have a key, additionally having a
~/.config/git/config file that contains the commit.gpgsign entry.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqlZaYACgkQv1NdgR9S
9oufcBAAqZPbFKixYV/jTefJLNvlFXaSiFYO6eFfLKs4P8hXItF9+EJu8SlmqwUP
VnfToY7Xs/2fYYMWGLANrb5dOAYcviv9A0VOAV4+av1j1BExTOVEcUnUG9F3Els7
BpWdABvnVCeYZX/8SCdYyw9EfI1pCF8gAXuucfdlrIOKb/oOsU6pJD45A2bq5EqT
yuijc545LYBAzoZnuEJ3PjHFeRLqAMNRbooxih0MAs7o3ckMiEp8gohOVQwW9ZFm
tFxZ925AQWE8GK0GrDTssgKk6sda+ThL1HBEYj94DZojkrzJ139m+7aupRILwYoW
xERbwVgy+D60F/KyAnkvx/F5df/rjU+ZBfk7VOT2YrsHbLkfSxUpspIW5v8HPV/x
ZP7AoS9WhmxZvOccREotxNZwlioCJ74/nLUmDuK6nC90Rl8oorO/GBUb1Zu/Xj1x
KPjnLEp5eucqBAJ1vxBDA3TqW/bUMB0U4EiEsrktc//Ra5wVs9dxs9KypdRYIs6n
3Yi/yMWfdfx5OgjIJiQyVdnT0aTwmyiAuwuRl0ZsZFWIMlAdehrI3G3GnkdNZ+eu
l6553m3CxbMbR9Czc7JyXPOR4cB3rGCSrjFTQ4duZHXfIbvXt+Ut4H/aAJXu46Zx
veLdsGf41RMCnLLi7cOXV3TrBVpgLR8mByc1w/3P7eyR48MDbKQ=
=057a
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

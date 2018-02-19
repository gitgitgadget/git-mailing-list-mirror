Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03891F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeBSWhB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:37:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33258 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932171AbeBSWhA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:37:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8F3B46096E;
        Mon, 19 Feb 2018 22:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519079818;
        bh=1n1+Xgs8wUbMxpqKjsnCiG0ckgJIK94v9tz/TPQN6Cs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SWcB50Kac/xu2cbjcuY9fKZjqcVFpq8gdTuis4BYBn3TTmsLE9/6Xcp5Pr3sekxQH
         Tpy8jG/R/FFcsxYzWSby6qVeGijFkYifC+BpB3Ot8Nmkf6GGw01nlMZmUrTL/sJbsB
         D4fVaPTMcv8vCM3Td4pEu/KvKjUBvDkU5m7jvR7X0Lf5KpeiR5LFaP0BpDSEJpOpuh
         I64TRPECgUBsR3PMPmtI/VQnWTuyQWAbsvsSkd15zM/Dkvix85tw4yaph6cAtY0Owb
         X+T7eQQ9+rIBljml5rwsE3qZBmSwEjov7kmKPPfMS8W8J/G7CVGP/qxrn7q/5rbh2+
         DP7mgB3JeMezKlS/HqdKgCPpq56cn47fL6mzhiKyspafEmDYgBOvd+BRb6ZpjPiOeG
         eMQw5Z9XnzZCxutz37B9y6Mk9ISu0QVNntE9kYobK6qIH2SBFYQhsUPDyPtMiVQCld
         zw/1or6imx7iKZXIG1rGoayXwFBdNLkDYanOBLxBZJETHyKfQ0E
Date:   Mon, 19 Feb 2018 22:36:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Is there any way to "interrupt" a rebase?
Message-ID: <20180219223653.GE6619@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
In-Reply-To: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 11:35:25AM -0800, Hilco Wijbenga wrote:
> So a scenario like this:
>=20
> my-branch : X -> A -> B -> C -> D -> E -> F -> G
> base-branch : X -> Y
>=20
> git rebase --onto base-branch HEAD~7
> commit A --> conflicts
> ... lots of work ...
> commit B --> conflicts
> ... lots of work ...
> commit C (Git handles conflicts)
> commit D (no conflict)
> commit E --> conflicts
> ... er, that should have been fixed in commit C
>=20
> How do I keep all the work I did for commits A and B? I get the
> impression that rerere does not help here because I did not finish the
> rebase succesfully (and that makes perfect sense, of course). Is there
> a way at this point in the rebase to "go back" to commit C (so without
> "git rebase --abort")?

What I do in this case is I unstage all the changes from the index, make
the change that should have gone into commit C, use git commit --fixup
(or --squash), and then restage the rest of the changes and continue
with the rebase.  I can then use git rebase -i --autosquash afterwards
to insert the commit into the right place.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqLUYQACgkQv1NdgR9S
9ou2OQ//dIe6BwSsLzrAZeQrCdQAG7TOrC66icp080Ol5GVbho2dEmvapaDveFF0
n/+uWKxyMBA9MSCS/YbRYD6KfNqdn5gOOYqDgm/KOOQf/GHrBN2gH6DMpFqVN1F6
hIheq6OSlizInikFro6XlnLZxBpLLw75xJYEg3exAw4VX4NQQTnak22LnlAnlyiS
OGZoqNIQxNvz4THkyoXPaHh3FPeWSViZ/7/xzyQ4ulsQ4Ied4brF39CTtcfOYPY/
LdJwt4F2IqgQNH3uPqvNTkzugZEQs+FIyabYtBnQK2hVdkl3t8JWy/RGNw2pk1f/
fNA//1EqlFJTnvehfaoB7TdLtGaNRY+RnzB/zj+ljvl0FinlQ7U9ec7Se1FCIjqk
9JRQSWtsnGOsPAUKbmV67LKQu29rpgHOtLeQmTO5oFxmFOSPVCNN9l8xKmyi6rJI
fTTd2qo8mFdpvKWZ0Gae13M5l9cKspSSXpeFVh0S+cEM2jRh25C3QtwroTwOOiuL
lgWsYUZix+2B3FVFuBcLzq5zvghGbDf2mY7qvIbN9JZAo+THLzfADI2IlJKgQvIc
aLdSg7Ll4rvjIeq9Mxl/R0q8dtt5dsOxKaJ4/5kqIwhDxwbFWNFe7ES3ih+Dz5Hm
ecJAClm7IKtPHm5iZWt6RF2tIvEu/fx8RWHF/kk9JxJjHIfZw50=
=8Dsg
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--

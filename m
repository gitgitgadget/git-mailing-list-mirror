Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0475CC6FA82
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 20:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIBUQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 16:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiIBUQf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 16:16:35 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B389C889B
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 13:16:33 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 785515A0EA;
        Fri,  2 Sep 2022 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1662149792;
        bh=ViwQyKL6SzSGEjnFFlJGy9D56W6eqK0X8ru2k6DbFGY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0ddLW1n7dc2mHHU1DJTxJdcsWdUHc4WMVjT3j2lcaFi3EDX+BBz1YIoZZrYQQlQni
         S0HqDGpVcQpU3sTvcsiT+ubxklXgNflUe3yv03c7nAlFooIbTwuJZrWOb1WCU6Eovc
         /8cKYBBcl+CvGoaLx/ECsR/lljBm5kXAXfr9T9v7nSje8W4o2QMDMdeC3J/HNZ/0WY
         qD6Hc1CvdFQ6F48l0mMQIijODG6GsqqFrCIbb7DY1yzMzqQZQWaz2lqOiGvLLo9qBs
         mmvsmCM9eQ2bnkwXNm/DpqalrPAQQT3PB3IYYgJ032DNZsRduzsBEyl9xFaKMTeQPJ
         4hvMjRI6Aa5OrM15E3E0u9DbxfaDou0nwnjnvikmjtwNHqPazNWer/IYB/G6zgoooD
         +umNAAM3h1DBfjnWZkgaeOjHgVHpieDlzsRM0FBw8AAp9rvnKz+szSGHxvTcLAfgu3
         4TAdk/zWsy+pxhup1CI8eTOLDACm7HHcbm8UnWiig5H6u5p9fld
Date:   Fri, 2 Sep 2022 20:16:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <YxJkn7K3zRm1u3Vn@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lana Deere <lana.deere@gmail.com>, git@vger.kernel.org
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YgTCBxlfWiDBwFpy"
Content-Disposition: inline
In-Reply-To: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YgTCBxlfWiDBwFpy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-02 at 19:27:55, Lana Deere wrote:
> I'm testing an upgrade to git 2.37.2 from the current version we're
> using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> gives me an error but 2.18.0 things all is fine:
>=20
> $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> Your configuration specifies to merge with the ref
> 'refs/heads/feature/switch-to-qt5'
> from the remote, but no such ref was fetched.
>=20
> $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> From http://githost:7990/scm/dp/sw
>  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> Already up to date.
>=20
> Anyone have any ideas about this?  All I could find on google was a
> suggestion that the "no such ref" message indicates the remote branch
> was deleted, but that's not the case here.

Can you provide the output of `git ls-remote origin` (assuming that's
the remote you're using) and `git config -l` (the latter with both
versions)?  I don't know of any reason why Git 2.37 should be broken in
this regard, but I suspect that there's a difference in configuration
between the two leading to this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--YgTCBxlfWiDBwFpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYxJknwAKCRB8DEliiIei
gR3zAQCio0a4LqNbIwjRz5BaX9gVfUMze3wXKauyCcXE37fXhgD/avwmXEbU4j/q
IIIpdIC9sHZP+i268Wg9yIJgbW/myAY=
=Isew
-----END PGP SIGNATURE-----

--YgTCBxlfWiDBwFpy--

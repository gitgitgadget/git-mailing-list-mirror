Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD201C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9E32077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WIeCZmcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgDWX02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:26:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37604 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbgDWX02 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 19:26:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C550560443;
        Thu, 23 Apr 2020 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587684387;
        bh=hgjpC/LGXoYxCWTSZbVPO5tUGJqsEa+8tNWAI9dJ+Eo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WIeCZmcOxYtjm8mVy33GEBo/rjyRx0GyDtOOiXlVogoxTBukd+LJmAJNcmZT087uH
         4mnkhPWkyVLJoqguGhv9vySL/kmXm/NBZVknapgOxzwhkBDh50YUvJFHz1Tr812qsG
         fr2tVaMqB22NS7J3Wg3IvPg1y41JxbNk6WSW1l8/bKHO0xQ/NzS9yX51LwbRtmW1vk
         OA+Npk9afSHkydIAvJArFHtW21lCLK+lBRxueZijAy/IMzEbXNNhWD9JPg44q6kzXH
         50cMAwHIHPDDrJehUWOu4Jq9euf0lc0BloCRPJot0hbZrTXZ/j0rIChT/Pjs9Q8Qu5
         Q+sA2YO61Pb3E5Bao/0ZJtraFmFbk9ZAhwSPZVPefWp75qKQDqHe4Ew7rz1gwh69FK
         jnFbco5KM7M+qK39DJkVH58YyT8Q3wb8o3EBGNTWt/Inp6sKKkNTCSrIyiesQA7u51
         taDh1Wq9gliTxLXBsKRPH2TnPEM9swz18WUWHkiDGj9Rv43QKke
Date:   Thu, 23 Apr 2020 23:26:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Victor Porton <porton@narod.ru>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] Misleading error message when run in a non-Git directory
Message-ID: <20200423232622.GK6465@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Victor Porton <porton@narod.ru>, git@vger.kernel.org
References: <c0e916fb-7b0e-1192-e71d-ea6449863e9b@narod.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <c0e916fb-7b0e-1192-e71d-ea6449863e9b@narod.ru>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-23 at 22:42:25, Victor Porton wrote:
> git remote add origin ...
>=20
> produces the error
>=20
> fatal: remote origin already exists.
>=20
> when run in the directory which is not initialized by Git (has no .git
> folder).
>=20
> This error message is misleading.

I don't see this, using a reasonably up-to-date version of next.  What I
see is the following:

  $ git remote add origin foo
  fatal: not a git repository (or any of the parent directories): .git

Are you running this in a directory under your home directory?  If so,
is your home directory a repository?

If not, can you tell us what running "git rev-parse --show-toplevel" in
that directory prints?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqIkHgAKCRB8DEliiIei
gSH7AP4tl74Dv0U9+CLf8Ebp6TOLDZmSCAXthWElkMtAfLmyJAD+NfjuYW4YIuf6
Mdgdo5/xh2mgmSiU6Os+woV39FPoFQA=
=30eC
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--

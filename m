Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D611EC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45C561073
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhJYWmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:42:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41294 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhJYWmE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Oct 2021 18:42:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C02660434;
        Mon, 25 Oct 2021 22:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1635201580;
        bh=A+HDVhu2DsT9Iwkl+we4tkeYXIKyj5bxEqSTG9Wp/2Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LF8XX7Pj+9lwAcrbylyGryrYnCl2OdHP11EpPwsN1PGZ25/X4sCdVh5h9III45R/l
         ImgiEwysyvdcBE6xgIfA/nApLNkASJNlotcMdYL0+B+XK3FAOSqedJa2broTKkYYit
         1AsY2pWTd1/SmSZQE+fstHKhLZBRRuUUFZnQZN4Q5JXXgG/J3MbD/mSKDRefhEZcRJ
         kfMJtCPSInd6UdC9gZlybd41Sa1npHBINzoAtBWjTqp6NgFpjh/WPBEiBhznK4iyJW
         qDzAxloIbZVq1r35qrZ1LkwDS4AMRbVZ2flJAGclVjI/A9T3YGMvLl3n9MmN9PuHKZ
         DnbXt+GUhlNZweXmGs7jcHsA2LPLxyKInIIcICGkVlVlSyAmMVCqxDpLH7z2emlLms
         8rN/aUViN3KO/FjoIeLf4pRm9lvElPo35egnluecTBMsi17dcHhZJFJFxhNidPo54A
         pZdvJ+YuCou4vVzZz7973L9zNat8GalXRgf4iBEUq7BhVBo11Ci
Date:   Mon, 25 Oct 2021 22:39:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Subject: Re: [PATCH 2/2] color: support "default" to restore fg/bg color
Message-ID: <YXcyJBmRvIEVSiaM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
References: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
 <504da32a95bd4a1e4368aca68b609387316ea671.1635201156.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UeYSTWyMMhzNCULz"
Content-Disposition: inline
In-Reply-To: <504da32a95bd4a1e4368aca68b609387316ea671.1635201156.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UeYSTWyMMhzNCULz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-25 at 22:32:36, Robert Estelle via GitGitGadget wrote:
> From: Robert Estelle <robertestelle@gmail.com>
>=20
> The name "default" can now be used in foreground or background colors,
> and means to use the terminal's default color, discarding any
> explicitly-set color without affecting the other attributes. On many
> modern terminals, this is *not* the same as specifying "white" or
> "black".
>=20
> Although attributes could previously be cleared like "no-bold", there
> had not been a similar mechanism available for colors, other than a full
> "reset", which cannot currently be combined with other settings.
>=20
> Note that this is *not* the same as the existing name "normal", which is
> a no-op placeholder to permit setting the background without changing
> the foreground. (i.e. what is currently called "normal" might have been
> more descriptively named "inherit", "none", "pass" or similar).

I can't speak to whether this is correct, although you did mention the
standard, so I assume it is, but I do think this is a good feature to
have and the patch seems sane to me.  Patch 2 also looked good here.

For an example of why this differs from white on black, let me mention
that I use a semi-transparent terminal, where a black background is
opaque black, and the default is semi-transparent.  I assume other
possibilities include patterned backgrounds (Enlightenment, anyone?).
Whether you want to include something to this effect in the commit
message is up to you, but I provide it for the interested reader.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UeYSTWyMMhzNCULz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXcyIwAKCRB8DEliiIei
gXwDAQCZHJ/YAnpn9fI/YHsB5bqaXUZU3VpuCDpyljRD3bDqkwEA7d7GeqMTC9C3
pyXiOkPHqnhgim02nd8EL6g7mnm9fg0=
=XHgm
-----END PGP SIGNATURE-----

--UeYSTWyMMhzNCULz--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B5C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbiATWVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:21:02 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:36304 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiATWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:21:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A95355B227;
        Thu, 20 Jan 2022 22:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642717260;
        bh=W+27akZFrv9qNIxm0TfuvA5Dxcqf5PR2ocnE9PpzyRY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hcacFSXWTv4rJhTel7QqWL1xqTksJN3AYxE1GyWEZJ2cYhf/6g5wqLGN9r4zZBhER
         nrrDesMyAeJbv+vVnnwbjka8PLw2Y6T73O+7834vtXDkeC8Wq8XPFNgU9XB7Sl3NoY
         Kf+UnDCvy5MW9vLD0uCHIBmp1aR/x0f+/31GeUVSAkfPRUEJ5qMO0oSIz3fHEeMgNX
         j58ei0sGNxRutT016iCUlfIBgHL4Xijmdwmtn4HS+FGLOu0fk8rfMFLPEm1TEWwUe1
         dRst87xd0U4MBY4sR6BxzFx02wCBaSIZlhvJqEPDC8geQAeCovFfKUQr5l7Y1I7Im1
         rvTj6SBoPNNvt8OneM2fcNt89Pi3XU4oOQJUJjPxg/afPH8+4craTNEaA5zOclBkOz
         C3dBezZHsbzcb9WxXuT3l2z59sxStkAQ6afMR0lRZ5zo97OSzrqBNcVaJ9dyjofaNg
         MVtYF4DRNTQNB0/QP8/Ic1xlZuok6tqoDnHSfajn84dAzKa2iVg
Date:   Thu, 20 Jan 2022 22:20:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Herrmann <michael@herrmann.io>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
Message-ID: <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Herrmann <michael@herrmann.io>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>
 <xmqqilufl5cv.fsf@gitster.g>
 <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LTm6K4QdPXUojrrX"
Content-Disposition: inline
In-Reply-To: <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LTm6K4QdPXUojrrX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-20 at 08:59:02, Michael Herrmann wrote:
> Thank you for your replies. Is there a way to tell Git not to sever
> hard links as highlighted by my example?

No, there isn't.  If you need to deal with files that should be linked
and stored in a Git repository, your best bet is symlinks.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--LTm6K4QdPXUojrrX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYengSQAKCRB8DEliiIei
gVT9AQDykx4eVKrs5rVqukMRsHTq/FquRNBDt0bo1QicvjI36wEA9VmfKDlF+8O6
m3qhXxGXNHtk/4mcZFvI/GdxigHL4A4=
=VGTG
-----END PGP SIGNATURE-----

--LTm6K4QdPXUojrrX--

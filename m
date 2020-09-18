Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179BAC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB32D2076D
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIRVfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:35:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33970 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgIRVfm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Sep 2020 17:35:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6C7D460459;
        Fri, 18 Sep 2020 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600464911;
        bh=QFmR9dhgwmeJJn/OFD1fyOuV1o4815iHC8OuSmS2OXI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Fjbkez+KcF1xYbtDvBCRJsYyKL3fNEtuV5fbnXi1AJ/o6fbhuTuLbPnOGAJAuc788
         JXokaHjCMcacTgQHPZqKQQ9L77XbCgrpzO9XARoLY5XD2CLPEyma4A9wZKYv6GlaCI
         oPa3SGcQRY43bbcW+OQ5/UdcHnj4rIxr0YnPw5MltsGbieMp8ybuTXVdqfhNTDjDU+
         MvkfPogLNsKUhyKI2l776xB/ad+RV30jI7rTy5QOgmREeoBPpJ/yl6oXRP0sKu5rZZ
         PouYf7Z65nSWHg77sn2wnDX01gwVQ1uZfZFF9SnP1M+uCKlGgP16id1lidAV/2kfpP
         A9JtmdSLrcjliSaGOJd0EeNwnLTaryAQwmLBcXzqo/H8qQ1PEcDiYpUh5XwY6kfsWQ
         d1U8ThUJAmpJel1WtaScqlXZSYyYxDkpZMivIy2fWFZ/ItsITY1MdVqT3GFMblNmnn
         r8O/KbuDckE3pbc/elX3StSNawu2rk1ru2S2p3IiG0MytKbFE6Z
Date:   Fri, 18 Sep 2020 21:35:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] sample hooks: become hash agnostic
Message-ID: <20200918213507.GD67496@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <cover.1600427894.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <cover.1600427894.git.liu.denton@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-18 at 11:19:01, Denton Liu wrote:
> There are currently two hooks that have hardcoded 40 zeros as the null
> OID and, thus, are not hash-agnostic. Rewrite these to use the newly
> introduced `git rev-parse --null-oid` so that they become hash-agnostic.

I've looked over this series and I fully agree that the scripts should
be hash agnostic.  I offered an alternative which you may find simpler
and more appealing (or not), but with the constraint that if we add
--null-oid, it should accept an argument, I have no comments beyond what
other folks have added.
--=20
brian m. carlson: Houston, Texas, US

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2UoCwAKCRB8DEliiIei
gZ2TAP9qtvHn0yQmzO0g9KaIPW/EmvA3xk1hXqGAo6t/0xzoKgEAi7DEQhq+zJwi
7ZctdxE9P9PZi6vVB+5vnD7LFolp2QA=
=Jxom
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

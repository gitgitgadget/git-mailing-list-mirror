Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20154C4332D
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD72D650B6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 22:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCEV7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:59:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34750 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhCEV7D (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Mar 2021 16:59:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6418C60DF4;
        Fri,  5 Mar 2021 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614981542;
        bh=vwoiPHWcxF8lJrgp3xFtZ5pXaO6e2N4p5N4Jub+y3sY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wZ6GBMx1up/77DjMhbflIbD+MfAL06DtmYR5VVoUOjJPIJCp6ZiuR4iTpWG6+HQ5R
         cPjFKrE2dHtBRyZC8sr31VRWwCzQpiEOFMlUnCTTRclESHkjS0WTHxelMiaGyGbzEy
         5x6fwlqiVEU2w41Wi2LzSvDGHcnuuCQckuTDJCEFc7AXywUlYczJjKtEJFjlApiD3o
         6nonLue8MsgKbifIOeyvH/x92iwbr6hzZi5lyhJlAa4sLAmvIPT9S+GluoKVlWv7VS
         wAF9wefo9ZtlGvIXSOQXlag5g3TqAAIsmOP5mL7iPtQmTzd3GhSLwDbjRKyTTaR7gt
         Ta0PdbDyFg0gqchaNaoZeC16HJDMPhNgT/fGlTfuNnPTOv3hvb7HSkDmKUHwDsfh9w
         ZuumJ4yLtfhdYEq/IFS74lEKubx0oefJ4RdZCjPhtwAQ1KYi558/pom2JwHRhsq5KJ
         DlhL62cswG1D4PiR/5+v9sNiEDTVOcaiW5FmFht+NtMupA0ndVq
Date:   Fri, 5 Mar 2021 21:58:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Soni L." <fakedme+git@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cross-signing commits
Message-ID: <YEKpoiy//SR5Nt3q@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Soni L." <fakedme+git@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <355bb5d1-f661-4ac2-d536-d1c56ec5e408@gmail.com>
 <YEKmVWHJchUhxZmn@camp.crustytoothpaste.net>
 <537258e7-fcf4-814c-c7c1-95c8d525f34a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YnLUKgbskzUz+ohy"
Content-Disposition: inline
In-Reply-To: <537258e7-fcf4-814c-c7c1-95c8d525f34a@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YnLUKgbskzUz+ohy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-05 at 21:53:14, Soni L. wrote:
>=20
>=20
> On 2021-03-05 6:44 p.m., brian m. carlson wrote:
> > Can you explain what you mean by "cross-signing"?  Are you proposing a
> > situation where two parties sign the same commit?
>=20
> Yep. See, the repos enforce signing, but they can also be forks. If someo=
ne
> wants to track upstream in one of their branches they just can't. Would be
> cool if they could just say they trust the commits by signing the relevant
> commits with their own key instead - on the assumption that they actually
> reviewed said commits.

Git doesn't natively support having multiple signatures in a commit,
although it is of course possible to do, since OpenPGP supports it.
However, as you noted, changing the signature changes the object ID, so
if you re-sign a commit for any reason, that changes the commit ID.
There isn't any way around this at all; that's just how it works.

So you can either re-sign or have an unchanged commit ID, but not both
at the same time.

You can use additional empty signed commits or signed tags, or you can
use some sort of external system that keeps track of additional
signatures or approvals if you want.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--YnLUKgbskzUz+ohy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEKpogAKCRB8DEliiIei
gc/cAQDp2n4uGgwhjK6MiEJyOCLDyed64AmblgYfD6u2YkeKlQEAuMAfyMQ9YARg
TPQNNcNpRgP2cs17mWPHv8zJL1kc2wY=
=1wnv
-----END PGP SIGNATURE-----

--YnLUKgbskzUz+ohy--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF6C3F6B0
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbiHRQzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbiHRQzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:55:25 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62175C6EB5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:55:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [104.129.158.24])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4C5975A29B;
        Thu, 18 Aug 2022 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1660841720;
        bh=8gJQl9UgCP5OaC1bZ+dLmLUmdUMTpRDOlSyGZA8I0jI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dD3Vo3TnhjSGmHkaPRodf7F2a/J/wgisRN+llgESEWXkcwmuZCiIE62APMueJAP8h
         vQ4rKBeneI8KWfce5NjGWWmLg9UGJJeBHar89ZWfWKtbPnZREfZSun10OWLED7Utet
         lf44Ffe9efGui8PCzqOM3OymzOxeRN4KgHN7hQtHbWcC7+P8G8AoobPkCcTUPPJlAd
         UB1WcgWn0UD6o8Y/q5YOPe8E0OwG3JEGsRH0aiR5l0j4Z2TBRJzPCDHqRnjXUeQbqD
         qfYNoSADfzgkEWf77QcCs1QX71PW3Sw1YU/U/xdGMCd/YdzznVH4taN48aL7z8TME8
         mLK4a3HmIB4DmZxdJL6lXcjCDY06FRf0eCELjlh/ooSyFmjT4o5QrfcLz7cYhiLpyN
         sarMss1eN8Ok7/K5BFgTnPz8ShOi1Li0YAbTx9eOYJ4zFTEnsG2F0bfvzY3v5VIHJR
         dy62ospI8xusUy4JwfecfcKdoBOVqNuwrvEtbHU7eT0sSLYrmoc
Date:   Thu, 18 Aug 2022 16:55:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sergio via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sergei Krivonos <sergeikrivonos@gmail.com>
Subject: Re: [PATCH 1/2] Make rebase.autostash default
Message-ID: <Yv5u9ApnKDSjSW8O@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sergio via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sergei Krivonos <sergeikrivonos@gmail.com>
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
 <c48fbf984ea42e7c13d56db015dc63c2495f5f5f.1660831231.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rVHvZudXJZZNWUNo"
Content-Disposition: inline
In-Reply-To: <c48fbf984ea42e7c13d56db015dc63c2495f5f5f.1660831231.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rVHvZudXJZZNWUNo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-08-18 at 14:00:30, Sergio via GitGitGadget wrote:
> From: Sergio <sergeikrivonos@gmail.com>
>=20
> Signed-off-by: Sergio <sergeikrivonos@gmail.com>

Typically you'll want to explain in the commit message why this is a
valuable change. For example, I don't have this option set and don't use
it, and I always stash my changes manually before rebasing.  You should
tell me why the user will benefit from this setting defaulting to
enabled, since I personally don't see a need for it.

You may also want to discuss why any pitfalls of stash, such as unadded
changes being added after a stash pop, are not problematic here and why
this behaviour won't be more surprising or annoying to experienced users
who are used to seeing an error message instead.

This isn't to say that the change is bad or we shouldn't accept it, only
that I (and others) need help understanding why it's a good change to make.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--rVHvZudXJZZNWUNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYv5u9AAKCRB8DEliiIei
gcg9AQCdmTcyRr1Voj3ueuZ0HKH0RaKAmpBWlZi3aw2CNYnmBgEA0c70nkRbVVN0
zK+ds4i2oeBj+XWEoe6sWkeVqZrSTQ8=
=C9PJ
-----END PGP SIGNATURE-----

--rVHvZudXJZZNWUNo--

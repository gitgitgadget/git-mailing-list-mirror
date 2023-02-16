Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2CC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 01:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBPB3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 20:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPB3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 20:29:49 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4E1A487
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 17:29:48 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 17B1D5A331
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1676510987;
        bh=4yCxSf+5RhyNmJ/8zcsgncNlu9Hbr1MXctygMkzLfHo=;
        h=Date:From:Cc:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pdWQyxwknp9O+CAodLjiTAKIfJ02DScy/ZnzB16Z8WbY+vrr2ZmzzzBUg39S4/Sgs
         CHHCfC7CHAHzAtT1vGhV1wLzxnC/qGSJCS/QueRxVWYZmi/ezgyqgLuNoDiVw8Vl9x
         oB4TiBWkoFxDwx7HAjTrw0C+YUL43Ge0HHQlgdK3WMKTnxiDnMkOwAli7R6wDra3iB
         LZ+ft/n9JY4S0vhTXzkPCee8AjrMoYBVQWcnvCB7TqvTQf82cVaHv7SVbOQT5qQi2E
         p4LBWlBVoVDH76fotWCwv6VnSLpgQK+oZqMC2AUGDeiwsEJaN+cPunHLaoXP6K1/4Z
         M9+IWL1viyG208B14M+sVwvUcN9SqaPwUbKZBocY7YagLQW7Wv9NZU1BHtaeVsf/d4
         KbWt0u67H1UXGHKzv6e9bRhep9aEB5bE6Cq4eBE2Gr1uUTWu9/TFrvN4ZjYa/UapO9
         TZJ0RDF0K6FTlrFzOr0466Jg5lJPACiX6dEp/omXv9A723ViziI
Date:   Thu, 16 Feb 2023 01:29:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: manual option --inline --no-attach override required for
 format.attachg
Message-ID: <Y+2HCa5kqfVZ0Coq@tapette.crustytoothpaste.net>
References: <20230215215112.62559-1-Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yLJlFge8hXvnRnYY"
Content-Disposition: inline
In-Reply-To: <20230215215112.62559-1-Brian.Inglis@Shaw.ca>
User-Agent: Mutt/2.2.9 (2022-11-12)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yLJlFge8hXvnRnYY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-15 at 21:51:13, Brian Inglis wrote:
> Anything else you want to add:
> initially found format.attach set in /etc/gitconfig and no way to override
> would be great if linux-man maintainer could set repo config format.inlin=
e format.attach=3Dno

I think Junio has responded to the rest of this and is more familiar
with it than I am, but we don't allow repository configuration to be
shipped in the repo.  That's because in general configuration can
contain programs or shell commands and thus execute arbitrary code, so
doing so would be a security problem.

Experiences with Vim modelines have shown that embedding configuration,
even when highly restricted, can be the cause of lots of security
vulnerabilities, and we've seen this with config used by submodules in
the past.  For that and many other reasons, including the fact that
users may not care what upstream's preferred settings are, it's
extremely unlikely that we'll add any automatic way to ship
configuration in the repository.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--yLJlFge8hXvnRnYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY+2HCQAKCRB8DEliiIei
gbG+AQCaZJQJaohYZjjkjY7XKYcu7tgy4FRIfvD2k77wkRQRCwD9G9TcbN97Qu+R
f2MrmpJOGEz2xm4Kmr0z1VvHw9knYAU=
=9DoL
-----END PGP SIGNATURE-----

--yLJlFge8hXvnRnYY--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75564C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 22:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D9A60F51
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhHMW54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 18:57:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42190 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235029AbhHMW54 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Aug 2021 18:57:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 84A1860101;
        Fri, 13 Aug 2021 22:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1628895418;
        bh=iey5eiHTtLA/MVluBEnKQNi0BNhilDTuMg/BE5U5yrc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=T8ouGn+b5WyF8DLkUGOtebHwqLo6TLN2V11H2eZLBQfaGWjHLkgE7HVFpZL0F0t47
         z2Dm+2Kv3u7GU23XDOi00cE3ZhLcZBO6jmyPOBPJMfgj10IJcK//Fa2Nlp27vog77e
         DfgYHJGsrOBh/nJJ8NjoXK9okXshPLLLlwHefXjFFKDERae2q/TxAZwXQFrK8fjrmG
         LP/jTBSUNYN2CHSsJv2KTvqiYV0D0S+WEkE7viKrDiYSxTau4s80XG21w9GIdKjv+G
         Z3kqyDF1ag6TvsqCO35xH1GB6C6UG0vjreNRaIF13jkL7QN4ulf8UIOcxaGQLVMgfV
         zSq4BPfFoNJR6gJUADgWBGyptC8QnBtPMFBl0txnq348GSAbCmv6PbK9iN14tFO78t
         7dehm03N64DMq9ENcpof8A+7GyebP2DBc/ukuJf72FuiBNSz+AKESy1HNzPH+hcFl+
         uqs8WS37ZarX9bM4wdtyp5cwwalrGudA1jUINGXfucdtmiLbdbA
Date:   Fri, 13 Aug 2021 22:56:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [QUESTION]Is it possible that git would support two-factor
 authentication?
Message-ID: <YRb4tkINrABgaHGu@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>
 <20210811135055.tqdblurgk3vw5lgm@nitro.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UjgaMzPqej/G9sC1"
Content-Disposition: inline
In-Reply-To: <20210811135055.tqdblurgk3vw5lgm@nitro.local>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UjgaMzPqej/G9sC1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-11 at 13:50:55, Konstantin Ryabitsev wrote:
> 2-factor authentication does not make sense in the first three cases (you
> already have access to all the objects with 1 and 2, and the git:// proto=
col
> is public and anonymous by design). For the ssh/https scheme, 2fa is alre=
ady
> supported by the underlying protocol, so it does not make sense for git to
> implement it again on the application level.

To expand on this a little bit, you can absolutely set up a Git server
with OpenSSH and require 2FA with OpenSSH.  That should work just fine.
You could also leverage a custom credential helper for HTTPS to require
a 2FA code, send it to a server, which would issue a one-time token for
Basic auth.  All of this is achievable with existing tooling that we
have today or tooling that can be easily built.

One note here is that as a practical matter, many people require
automated cloning of repositories, such as to use their CI systems.
Those systems generally cannot practically use 2FA and the security
would not be improved if they did, so some solution that allows for that
to work is going to be required.

Also, in workflows that require many repositories to be cloned, it can
be kind of a hassle to wait for one clone to complete, enter the 2FA
code (or touch the YubiKey) for the second clone, wait for it to
complete, do 2FA for the third clone, and so on.  So while you can do
this, it's important to keep in mind that there are some user experience
tradeoffs here that need to be considered as well.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UjgaMzPqej/G9sC1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYRb4tgAKCRB8DEliiIei
geq4AP40fZCJieDFvoa9XYqv+dUPJhzIPa7X/72XvbY9xACongEA3VXs5gm7GHCy
SpCG90nSi3CHoGDzqWWYn9krTafvJgc=
=ldbl
-----END PGP SIGNATURE-----

--UjgaMzPqej/G9sC1--

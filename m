Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E05C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D567560E52
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhHKX2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:28:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41138 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232664AbhHKX2O (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Aug 2021 19:28:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D060860752;
        Wed, 11 Aug 2021 23:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1628724439;
        bh=j9ieDAeyq3/lS2wNNMUjyrMb3sqQvO0GKlFne4EGGaQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=venbsypPozpg4NpHNMbFDn1wrlxh91b7eiJpL7TeB7FF7bOEP5x4ImmfLZEuDy18w
         EY6qxDHU0uVHmxYHmGoqFHEj6XsyRetZVflHFZjRhHzhUIPnthfuxKjmJcKdbKLj5k
         cbPAgxk52AT3nwm0fMlPu3tis5dVEoYIwZ+sVDovzF/kPFWI0BycNZ1pt5mIxmlu62
         NoxzANiF38ujHj/uLspYbeFFy4GM3/a7OLOu52UMUAy99QshwXb7O+vgsYr8EhGvB5
         GpiJTi3GSQL7xbGdWV52h34oWxX8gv43tXCmKh7dvlD0ih3TXt1kknz39VLsTY+E9/
         VnArvTHa7Fiw1DQ4qYHiEkBPxf6qKNl8T2zM0XoJ8ha3PNKzMZEg/lFOb2U2x8+gS7
         5KNV8jpq2jlcgWuSLhxORo4MAVhJswx1aMjV9qYrdZ3JSw2h2kmxqcXmEFiI/3v4qQ
         TIY2bPoyK4ycnH47vkFCdQMeRe8MLEno24o+5BvSnGcX26BqbFJ
Date:   Wed, 11 Aug 2021 23:27:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Joel Klinghed <the_jk@spawned.biz>
Cc:     Jeff King <peff@peff.net>,
        Joel Klinghed via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] commit: restore --edit when combined with --fixup
Message-ID: <YRRc1PDpSOmd4sEY@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joel Klinghed <the_jk@spawned.biz>, Jeff King <peff@peff.net>,
        Joel Klinghed via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
 <YRQx/jXdydxMGBmS@coredump.intra.peff.net>
 <127626db-302e-426c-a158-35f46205e1d6@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hz7kgiVFAz3pEq5c"
Content-Disposition: inline
In-Reply-To: <127626db-302e-426c-a158-35f46205e1d6@www.fastmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Hz7kgiVFAz3pEq5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-11 at 22:10:28, Joel Klinghed wrote:
> At my work we use "fixup!" when pushing fixes to a review, using
> the modified body to outline what issue the commit is addressing,
> helping the reviewers to see intent and not just the end result.
> All "fixup!" are then ofc. squashed before integration.
> Same can be achieved with -m but --edit is generally
> easier to work with in my experience.

Yeah, I do exactly the same thing.  I want to write a nice explanation
of the change I made for the reviewer, but I don't want to preserve it
for the future.

I recently had a series that was 33 commits after squashing but with 117
before squashing, thanks to a series of very thorough and thoughtful
reviews, so in this kind of scenario, it can really be kind to the
reviewer to help them match up the change with their comment.

> I've also once or twice used it to avoid a "fixup!" of a "fixup!" instead
> of looking up the original target commit hash but that's just me being
> lazy.
>=20
> I'll add a test to check for previous behavior.

Thanks for catching this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Hz7kgiVFAz3pEq5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYRRc0wAKCRB8DEliiIei
gZMgAQCfDZGhg2loHzSkUhznHjk6IgtStI1JcRgpQVG3Z4WyMQD9GLIiaydebmlP
RT0tKMy1xrKi82zWxP9cEo2Vsg6KLA8=
=Xrax
-----END PGP SIGNATURE-----

--Hz7kgiVFAz3pEq5c--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6101DC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 02:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF909246B5
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 02:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgKSCLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 21:11:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgKSCLW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Nov 2020 21:11:22 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BCFBE60743;
        Thu, 19 Nov 2020 02:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605751881;
        bh=3Z30+LjoGBHpxL8jU+GVEJIBfqpoWZr7kjzJE5lg7nk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tpb/k822UPJKsUjmJPv4lQaY8gPJoLoowkpcl6yqwNqQ2WBp64f3O94svzdWHc7HC
         GTQiqzdIr9fLfPr3w54l1neBO9NJejpAenko8CKpCyggHiJiUM26YsRYsEsxNwQpBt
         HJjap+ENoJrLMFSQ2cvv9GniRk+ETbHUu3ocs5KAF9NhDGyVsTe3KbmxYuqpK9S6if
         2m2eI9Vuc9cl/TwOVWvq+qybMQq6W9Yj52QzwvpYV+OFtpO8/86w1p5gNuLm37fCAL
         3fMh2JqNiH7MhdlwjJrK3g6QUTZYcGG9Q0AjuXxgO0ON5iKLV779okjTThZ1yy1PGa
         ttooF8CszZQ40JcQpe4zm1GBKBBs0YrzdZ9J4ziArzO1Y9aNCQ35Rfors+y035VYUC
         iCopzhTpjZ4d6eounwUiUryQ/08sg8Qi5UtXmGMnz71eOwLNoEk/Oz7LaNBz+6vMCW
         axQjLYmmC25tX4bEVBDnGROH+rT4GrC+wupBL1n9MpmbDBJB6yI
Date:   Thu, 19 Nov 2020 02:11:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <20201119021116.GE389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
 <20201118005014.GC389879@camp.crustytoothpaste.net>
 <20201118015907.GD650959@coredump.intra.peff.net>
 <20201118022532.GD389879@camp.crustytoothpaste.net>
 <X7THfjaP91+GV//V@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline
In-Reply-To: <X7THfjaP91+GV//V@ncase>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-18 at 07:04:30, Patrick Steinhardt wrote:
> On Wed, Nov 18, 2020 at 02:25:32AM +0000, brian m. carlson wrote:
> > Sure, that could be an option.  It's the simplest, and we already know
> > how to handle config this way.  People will be able to figure out how to
> > use it pretty easily.
>=20
> At first, this idea sounds quite interesting. But only until one
> realizes that it's got the exact same problem which I'm trying to solve:
> there's still a point in time where one can observe config values via
> the command line, even though that moment now is a lot shorter compared
> to running the "real" git command with those keys.

I don't think that's the case.  This command:

  git --env-config a.b.c=3DENV_VAR

would be equivalent to this shell command:

  git -c "a.b.c=3D$ENV_VAR"

In other words, ENV_VAR is the _name_ of a environment variable to read
for the config value.  Subprocesses would inherit it using the
undocumented GIT_CONFIG_PARAMETERS.

Or are you trying to hide the configuration key as well?
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7XURAAKCRB8DEliiIei
gQY5AP9YkpU8OMRktVXBbSwD34y/UKdj3xYGbdWlDiMGF81F2gD+OSablTqVI3ek
vjDdq4mw+q7Vk1qr5Uon1n6pw1mGtAc=
=sO4k
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--

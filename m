Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115AC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 03:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D842078A
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 03:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394012AbgJPDSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 23:18:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50736 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394007AbgJPDSl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Oct 2020 23:18:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 524126048E;
        Fri, 16 Oct 2020 03:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602818320;
        bh=zNXrpav1d97WPsOyFXwai9lmcynxJFrEb88IvukW8hU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JZfXVA+Tr4i6MIjKuLis1HLiYl40Mx8p1qSUz9UAaRbTp+3hBJ0yy/02yrdfH9sEH
         RnStqYXRoSX76hb1sp268ct4AeurBJhN8y+bIVegZfMHxY3PLjY28d4jnETFn+1o+Q
         HdDS+J3xjK8NV1daI7VhaOnboB/AnYdO7GSV1jhKZEdzVwT/y0Kg8eGrPUfGINoaLk
         QoZnhs8t1XdcDaPCEWT5r0UbrsAnCZQAFB9zpPUqfKUZ2umtCzNCaqVXzPx6EEmZxl
         zpVFNkuV/CixA+Qi2PZgqJxTGRvuoklvupBaj/mjPUby6gioxfaDk+XcBR48DvCa+z
         apQSgrFatHZSgRKjzimQ+4SX8y7rjkWjUGeewvArb/2H/Z/eSahO1rHCMbpNwZ8Zuf
         pjSTpjK5Z1PoKJ9IpmhtOH0UEr0LZCKw4NdgEVN06IMrZEcaEOYHgvGiLIDNAcMHVC
         eSgVh5qcCF2DkYv/mIkGKzItM5gS1GEK5Ra56keTTxGfG8wOmu+
Date:   Fri, 16 Oct 2020 03:18:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
Message-ID: <20201016031834.GE490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        git@vger.kernel.org
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
 <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
 <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
 <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
 <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
 <20201015190532.GB1108210@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <20201015190532.GB1108210@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-15 at 19:05:32, Jeff King wrote:
> On Thu, Oct 15, 2020 at 11:35:28AM -0700, Junio C Hamano wrote:
>=20
> > For this particular case, what we need is a functioning
> > patch tracker *and* people who pay attention to patches in the "came
> > very close to conclusion but no final patch in the tree" state.  We
> > need people who can volunteer their eyeballs and attention to nudge,
> > prod and help patches to perfection, and that won't be me.
>=20
> Usually I'd expect this to be the responsibility of the patch submitter
> to make sure their stuff gets merged (and if not, to figure out why).

Normally I try to keep up with what's cooking emails, but I remember the
original bug report came in on a day when I had some other event and I
probably got distracted with whatever else I was doing later and forgot
about keeping up with the patch.

It would be very convenient if we did have a functioning patch tracker
which could be looked up by user, because then it'd be easier to monitor
one's own series.

> Personally I make a branch for almost every patch/series I submit, no
> matter how trivial[1]. And then part of my daily ritual is seeing which
> ones have been merged, and dropping them. You can use git-cherry for
> that, though it's not 100% perfect (sometimes patches are munged as they
> are applied). I use a combination of that and aggressively rebasing
> patches forward (and eventually they rebase down into nothing when
> they've been fully merged).

I'm really terrible at deleting data, so I have (exactly) 256 branches
in my local repository.  Some of them are merged, and some are not.
This would be a viable approach if I were better about deleting old
series (and completing and sending in the prototypes I've built), or if
I sent in series that were smaller so rebasing them were not so big of a
time commitment.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX4kRCQAKCRB8DEliiIei
gVJmAQC6QPSUB/kJ37oKNKUkeKpkBOhMRzKISLXZpp714+9lzwD+Mb68PDGEPGvO
+eFOr06cmp9By51tNNSyJlUz7sKXuA8=
=eiBP
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--

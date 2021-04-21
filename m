Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08293C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 01:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C959F61409
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 01:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhDUBFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 21:05:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38178 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234379AbhDUBFR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Apr 2021 21:05:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A23656044F;
        Wed, 21 Apr 2021 01:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618967054;
        bh=zJ8IVFATBCJf4VWsK7rqtOYGPKydl6SRZtGgccOK2hw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fXZkpxH97H8TtwrohHD/Gc1n8sW8qBmA2tnW9UDZ3o9ui0CSn9KxhOCiPSAqt2MYp
         Ex+HYwvJRPf7YeVhp/VrE5/8D9u3YSbviYuW3GKO56tXBmog+FASkVSND5T6kX7bOl
         Xe5ABExMYiLU0V0QDolb1syNc+IXcu+LuAS3gVRzu4PygXRzle5OE9dWnUTPVlWu/5
         Ma03+peDBuezfQPaaD088Vx46sGntXuGqRU2Egk+6ZKpYST4e4AWRfj5CmcrGyZrd7
         W73pdEvsbbqpqskW8PTvyGweZrww9Dvn7zwis/gUb+/TPDHJTlmaiM3vQ8co8AAUA0
         WPz6PFVjArBJvgd+vuGTrOQn4HO1JyGS59k1e1d9u4OV2hEp3/VPWDEkibuc31qbZp
         T8SbyQ97/Lh9wsk1iM4uAW1IDjfquFPIfxmqwvirp2SnzVAvcZi5ggkKVL4hL9/Nmd
         x1JRslHaJsiNQEjy7bi6bU3zXS50+gtSgB7xoq7eTHUx7mlF6k/
Date:   Wed, 21 Apr 2021 01:04:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 04/28] hash.h: provide constants for the hash IDs
Message-ID: <YH96CcJhZt4CTPWD@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
 <f0216ae20b6988514bdb60d8fff96e18c2ce9f1d.1618832277.git.gitgitgadget@gmail.com>
 <xmqqlf9c68iy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ULv/vCNLeaML0F2V"
Content-Disposition: inline
In-Reply-To: <xmqqlf9c68iy.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ULv/vCNLeaML0F2V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-20 at 19:49:41, Junio C Hamano wrote:
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This will simplify referencing them from code that is not deeply integr=
ated with
> > Git, in particular, the reftable library.
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  hash.h        | 6 ++++++
> >  object-file.c | 6 ++----
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/hash.h b/hash.h
> > index 3fb0c3d4005a..b17fb2927711 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -161,12 +161,18 @@ static inline int hash_algo_by_ptr(const struct g=
it_hash_algo *p)
> >  	return p - hash_algos;
> >  }
> > =20
> > +/* "sha1", big-endian */
> > +#define GIT_SHA1_HASH_ID 0x73686131
> > +
> >  /* The length in bytes and in hex digits of an object name (SHA-1 valu=
e). */
> >  #define GIT_SHA1_RAWSZ 20
> >  #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
> >  /* The block size of SHA-1. */
> >  #define GIT_SHA1_BLKSZ 64
> > =20
> > +/* "s256", big-endian */
> > +#define GIT_SHA256_HASH_ID 0x73323536
>=20
> I agree that it makes sense to have symbolic constants defined in
> this file.  These are values that fit in the ".format_id" member of
> "struct git_hash_algo", and it is preferrable to make sure that the
> names align (if I were designing in void, I would have called the
> member "algo_id" and made the constants GIT_(SHA1|SHA256)_ALGO_ID).
>=20
> Brian?  What's your preference ("I am fine to store HASH_ID in the
> '.format_id' member" is perfectly an acceptable answer).

I slightly prefer FORMAT_ID because it's consistent (and for that reason
only), but if HASH_ID is more convenient, that's fine; I don't have a
strong opinion at all.  Definitely don't reroll the series because of my
slight preference.  Either way, I think these are fine things to have as
constants, and I appreciate you hoisting the comments here.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ULv/vCNLeaML0F2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH96CQAKCRB8DEliiIei
gbxOAQCypJKWGnyA+/dDNzyHng2A8p+uhVxCvUoShwdtU0dY5QEA1lm7g2dMCYBj
Z22JYkTpydTB/dguSYPPRBnlhGo4bAU=
=hg1L
-----END PGP SIGNATURE-----

--ULv/vCNLeaML0F2V--

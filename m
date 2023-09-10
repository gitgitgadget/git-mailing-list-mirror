Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02882EE57DF
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 15:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbjIJPiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 11:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbjIJPim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 11:38:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2ECD7
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 08:38:33 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1A5525A1A8;
        Sun, 10 Sep 2023 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1694360313;
        bh=ruevNoN1CePcZ+BE5y2KuIyRw5/6XK3oRYCYNrep89g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=n2gYM9yanpxPwuDT0h2m8ztexepPxNoLvM2X4v1aMry4mmHBoLFJr0HiE/HMI4IU+
         5OochlMWutOPuN9LTIx58ujGZPjCDpY86YwCSUo/If0n0p0cI+vE2fMc9RbiPxkKNA
         6ly6BwX97+aekhTpGT6gOhZHfDjkbKzX5BxiWdM+vKS4GtHoc+3JjwIs7TFvGYjt3R
         N+cuSi+7o1FTq1PTMSm1WtnWaOGcym8sY7QIVZCabbWRaoa9D2T91qucpF+r36H9s/
         YphGBeWEc8Gh8tjjLDdcRkpIWN3boJh1yF2r49in40Lb43+LtU7XYK+h7LRi5awgrA
         fmuvIhZH3WpW2/n/AnM6ck9tvZgxq2UHpAlSwrBBplNja0HLB3WV2SHbKUUVw+i1mw
         5gYIiVvdeBd27ys+u03mOJjb0A9G0wEuHPvrqrKyMOUTBFy3Pb2ELLUlJJXszK4ABC
         8l1DFl+J+i9mDBqbG9viXUlatsVj6qbPrJNU8XEUTQBVGF/zWcj
Date:   Sun, 10 Sep 2023 15:38:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
Message-ID: <ZP3i9WdpDKlsWuNP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i/edm2qyPaYJP179"
Content-Disposition: inline
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i/edm2qyPaYJP179
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-08 at 23:05:52, Eric W. Biederman wrote:
>=20
> I would like to see the SHA256 transition happen so I started playing
> with the k2204-transition-interop branch of brian m. carlson's tree.
>=20
> Before I go farther I need to some other folks to look at this and see
> if this is a general direction that the git project can stand.

I'm really excited to see this and I think it's a great way forward.
I've taken a brief look at each patch, and I don't see anything that
should be a dealbreaker.  I left a few comments, although I think your
mailserver is blocking mine at the moment, so you may not have received
them (hopefully you can read them on the list in the interim).

You may also feel free to simply adjust the commit message for the
patches of mine you've modified without needing to document that you've
changed them.  I expect that you will have changed them when you submit
them, if only to resolve conflicts.  After all, Junio does so all the
time.

> This patchset is not complete it does not implement converting a
> received pack of the compatibility hash into the hash function of the
> repository, nor have I written any automated tests.  Both need to happen
> before this is finalized.

Speaking of tests, one set of tests I had intended to write and think
should be written, but had not yet implemented, is tests for
round-tripping objects.  That is, the SHA-1 value we get for a revision
in a pure SHA-1 repository should obviously be the same as the SHA-1
value we get in a SHA-256 repository in interop mode, and we should be
able to use the `test_oid_cache` functionality to hard-code the desired
objects.  I think it would be also helpful to do this for fixed objects
that are doubly-signed (with both algorithms) as well, since that's a
tricky edge case that we'll want to avoid breaking.  Other edge cases
will include things like merge commits, including octopus merges.

But overall, I think this is a great improvement, and I'm very excited
to see someone picking up some of this work and moving it forward.
Thanks for doing so.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--i/edm2qyPaYJP179
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZP3i9QAKCRB8DEliiIei
gauwAQDki4S1BOstGF3FRz4KPM/EOz6oW+DfRG7pGvvXGwKjFgD/dkfmN/hV89wn
OrtLES2XiFskzR7ST1xz4bE6kV52tA8=
=Yzop
-----END PGP SIGNATURE-----

--i/edm2qyPaYJP179--

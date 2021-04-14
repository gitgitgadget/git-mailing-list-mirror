Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4681C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 01:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD74613B6
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 01:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhDNBJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 21:09:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60952 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhDNBJx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 21:09:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9B80F6041F;
        Wed, 14 Apr 2021 01:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618362540;
        bh=5ylezJpoOuHVSD/ysDcU2q/IANLbl4Y47bpIdV8brb4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e2C1lYV8NEqqq8MVRqhqb+BW1gg/Dv4Jc1TBpEOd11KVySYaa+WnhOdBG4EwTyljH
         dUKzSbEUJUp4lFmBfUq/fq8TkplctsZFaUVYIrrNATYeFC9iRm6t3dDg4NhZcBHu8L
         8137Ay3F919+DSROFI/GKT49AWK6MLzKgH3xWzGx+fhcRoapiQzeHoj8TDnEf7biBv
         nrYhLIYEmg34ZGmM5Si4/0LbBKvQwYpGsjJq42v+uXPBDNBybxuoiVEW2GBbS0jCnT
         t1FuZiHMVmzDU2J6LGMy7TSrZ/T+Em5OKo1HJvnyby6OoRI/pr+0Zkkyep06aJkZgi
         jo2fqG1suOLxuQowpnGgsTEGXrpOKUMEmCk6Kic/4H3xlPe1Dqrg8R9mvb8n5j7Sf3
         GF3r2FBdHEU03yy6PrWUS4VRXIc71UdBuCyFarNGBwUOmv2l0P2+cyq32yVXRRo8CV
         1I4z3NpVeZNfERQgi/yUGOdAtAUU9tuJ5ycLkuDIlxMawx0yULO
Date:   Wed, 14 Apr 2021 01:08:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/15] cache: add an algo member to struct object_id
Message-ID: <YHZApIpPBhpmwscP@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-4-sandals@crustytoothpaste.net>
 <38f48634-077b-6351-5285-f8ecc6f552d0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A/xDrurJfiqNVyri"
Content-Disposition: inline
In-Reply-To: <38f48634-077b-6351-5285-f8ecc6f552d0@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--A/xDrurJfiqNVyri
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-13 at 12:12:21, Derrick Stolee wrote:
> On 4/10/2021 11:21 AM, brian m. carlson wrote:
> > Now that we're working with multiple hash algorithms in the same repo,
> > it's best if we label each object ID with its algorithm so we can
> > determine how to format a given object ID. Add a member called algo to
> > struct object_id.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  hash.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hash.h b/hash.h
> > index 3fb0c3d400..dafdcb3335 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -181,6 +181,7 @@ static inline int hash_algo_by_ptr(const struct git=
_hash_algo *p)
> > =20
> >  struct object_id {
> >  	unsigned char hash[GIT_MAX_RAWSZ];
> > +	int algo;
> >  };
>=20
> What are the performance implications of adding this single bit
> (that actually costs us 4 to 8 bytes, based on alignment)? Later
> in the series you add longer hash comparisons, too. These seem
> like they will affect performance for existing SHA-1 repos, and
> it would be nice to know how much we are paying for this support.

I will do some performance numbers on these patches, but it will likely
be the weekend before I can get to it.  I think this will add 4 bytes on
most platforms, since int is typically 32 bits, and the alignment
requirement would be for the most strictly aligned member, which is the
int, so a 4-byte alignment.  I don't think the alignment requirements
are especially onerous here.

> I assume that we already checked what happened when GIT_MAX_RAWSZ
> increased, but that seemed worth the cost so we could have SHA-256
> at all. I find the justification for this interoperability mode to
> be less significant, and potentially adding too much of a tax onto
> both SHA-1 repos that will never upgrade, and SHA-256 repos that
> upgrade all at once (or start as SHA-256).

The entire goal of the interoperability is to let people seamlessly and
transparently move from SHA-1 to SHA-256.  Currently, the only way
people can move a SHA-1 repository to a SHA-256 repository is with
fast-import and fast-export, which loses all digital signatures and tags
to blobs.  This also requires a flag day.

SHA-1 can now be attacked for USD 45,000.  That means it is within the
budget of a dedicated professional and virtually all medium or large
corporations, including even most municipal governments, to create a
SHA-1 collision.  Unfortunately, the way we deal with this is to die, so
as soon as this happens, the repository fails closed.  While an attacker
cannot make use of the collisions to spread malicious objects, because
of the way Git works, they can effectively DoS a repository, which is in
itself a security issue.  Fixing this requires major surgery.

We need the interoperability code to let people transition their
repositories away from SHA-1, even if it has some performance impact,
because without that most SHA-1 repositories will never transition.
That's what's outlined in the transition plan, and why that approach was
proposed, even though it would be nicer to avoid having to implement it
at all.

I will endeavor to make the performance impact as small as possible, of
course, and ideally there will be none.  I am sensitive to the fact that
people do run absurdly large workloads on Git, as we both know, and I do
want to support that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--A/xDrurJfiqNVyri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHZAogAKCRB8DEliiIei
gTFxAP9Aj3j+VQyywlx9nIxQrad3sx3/4fz0SwuipLeeAolDMwEAwL5ucCKRF2is
amrlAzGFP5zAsE6cHFSIN+Duk5inTwE=
=2zlt
-----END PGP SIGNATURE-----

--A/xDrurJfiqNVyri--

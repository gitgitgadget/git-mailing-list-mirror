Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD6AC54E49
	for <git@archiver.kernel.org>; Wed,  6 May 2020 23:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A54206D5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 23:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f7Durc34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEFXN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 19:13:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgEFXN6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 19:13:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7ECEB6044D;
        Wed,  6 May 2020 23:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588806807;
        bh=HCnTfwLma3SplJVeZSjQx4GRP5HYnQ5LY3+OBSRrAtM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=f7Durc3451dfZ1jbZxjxGw3g2WUUmNOv+c9ZP2SDH2mfOGkjAB+61BVFoEn6y2KtL
         NDuaYCoj8Yuv5VD+zuTuIMxVt1I0ho0ZafakUR+dHzPcECgRcYxOtgWtCqldbdXvSo
         K3+8ji9VLtSwWz/7JK9Gy7vikjnyykXjNwesIVyUrjaFwoixoZwokHPT5UxqXdo2Ri
         uFS2cpPdQaJElm7QuL6aWqlovuRSpxyoNL4msDwIU4dVPEMkJxV4HpACfKPQ6a39s/
         wS9nS7583yC9A7KUUj11aBTLKg+h9KtMMdI4BoGeT4XsuETi7/vZcyLL5Nz+0j1C6b
         cgo4JM+cW15Ml/Ft8WVcOXHQidJEzawJkdf8SLZAd6MLqlHs9oJ4mSPU9P3l973YgY
         HknhrfQL95DiWjGH1SwuJEwaNqUZpaX/3cFN7rHg+iN4FUcXfGwyh92Avqo9tkbJb7
         FKujQY8k3plk1uQhNUR5P/DrVhW8KLaSh9kX2MB7rjsbnZo9QrG
Date:   Wed, 6 May 2020 23:13:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] doc: propose hooks managed by the config
Message-ID: <20200506231316.GA7234@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200420235310.94493-1-emilyshaffer@google.com>
 <20200425205727.GB6421@camp.crustytoothpaste.net>
 <20200506213354.GG77802@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20200506213354.GG77802@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-06 at 21:33:54, Emily Shaffer wrote:
> On Sat, Apr 25, 2020 at 08:57:27PM +0000, brian m. carlson wrote:
> >=20
> > On 2020-04-20 at 23:53:10, Emily Shaffer wrote:
> > > +=3D=3D Caveats
> > > +
> > > +=3D=3D=3D Security and repo config
> > > +
> > > +Part of the motivation behind this refactor is to mitigate hooks as =
an attack
> > > +vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@=
aiede.mtv.corp.google.com/]
> > > +however, as the design stands, users can still provide hooks in the =
repo-level
> > > +config, which is included when a repo is zipped and sent elsewhere. =
 The
> > > +security of the repo-level config is still under discussion; this de=
sign
> > > +generally assumes the repo-level config is secure, which is not true=
 yet. The
> > > +goal is to avoid an overcomplicated design to work around a problem =
which has
> > > +ceased to exist.
> >=20
> > I want to be clear that I'm very much opposed to trying to "secure" the
> > config as a whole.  I believe that it's going to ultimately lead to a
> > variety of new and interesting attack vectors and will lead to Git
> > becoming a CVE factory.  Vim has this problem with modelines, for
> > example.
>=20
> I'm really interested to hear more - it seems like security and config
> efforts will end up on my plate before the end of the year, so I'd like
> to know what is on your mind.

In general, having untrusted configuration is enormously difficult and
is typically only possible as a designed-in feature with extremely
limited options.  We have not designed that feature in from the
beginning and our config parsing is far too ad-hoc to support any
reasonable security posture.  We've also written a program entirely in
C, which has all of the fun memory safety problems.

If we try to secure the config and allow people to use untrusted
repositories securely, we've changed the security posture of the project
very significantly.  The number of keys we can safely trust come down to
probably core.repositoryformatversion and extensions.objectformat, and
I'm not even sure that the latter can be trusted because there are all
sorts of fun behaviors one can produce by setting the wrong hash
algorithm.

That's just one example of a potential source of security problems, but
I anticipate people can use other options as well.  Setting the rename
limit can be a DoS.  Changing the colors of diff or log output could be
used to hide malicious code from inspection.  We obviously can't trust
anything containing a URL, since an attacker could try to make "git pull
origin" point to their server instead, which means having remotes is out
of the question.  Most of our recent security issues have involved the
=2Egitmodules file, which, despite being extremely limited, is indeed an
untrusted config file.

The scope of potential vulnerabilities explodes as you allow users to
have untrusted config.  I don't think there's any reasonable set of
useful configuration we can have on a per-repo basis that doesn't open
us up to a whole set of security vulnerabilities.  It seems to me that
we're setting ourselves up to either have a feature so limited nobody
uses it or a massive, never-ending set of CVEs as everybody finds new
ways to attack things.  I just don't think promising that feature to
users is honest because I don't think we can practically achieve it in
Git.  Most projects don't even try it as an option.

On the other hand, what we promise now, which is to restrict untrusted
repositories to cloning and fetching, while surprising to users,
dramatically reduces the scope because it's basically what we promise
over the network.  The interface is highly restricted, well known, and
reasonably secure.  We've also limited attack surface to a much smaller
number of binaries.

So while I think the intention is good and the idea, if implementable,
would be beneficial to users, I think it's practically going to be
unachievable.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrNEjAAKCRB8DEliiIei
gQLHAP9AJ+gYreDPXFAF2UBVP91dP+OvznuvxypSZK0T0UeYjAEApazQd9rzMZV4
JnXmTiOHZBjk/ObMLe1TykHFTCebxwc=
=LUd8
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

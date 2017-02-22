Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7DB201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbdBVXcV (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:32:21 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40232 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933861AbdBVXcS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 18:32:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 76789280AD;
        Wed, 22 Feb 2017 23:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487805739;
        bh=o8WxgSRCT+i2qEXHO2ODeG039Nbk0pbgptqV6yi4Jo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGby0IEh2GIfgSjwQ4EUzx5j5SKhHmjUkqXMfeHshuHNVURlhCrFc/bW73DQg5fz3
         dmiIyXxNr+4GiA1etXxj+i91rXPMQY6aIq2FaYIFfU5mKlR8yixUzp/MKBPkthHFLN
         w8iSSB3LR0lvToyUVI7ug4rGF4P+Q0ni6wBBWamIUCxxgiwgq/Z6f7byO/TMVfNUr/
         hWLzZWBufGby2Zi3Agdq26ndFPclhSP5ag3j+RY/BHr+t0mIQQpMrmJoA8taSZoXCp
         R2LUyuJQNwjP9UrVarkFMFWG8m0z/r4xxgC647RVhwTuAS2PEZavGGOu8HyityAhN8
         owXrTLBxsOQlZkNlirbHvBFdxt9yR3gQesLk0K0q/2LiOOXCEiyvrAhrep33IHf5Ed
         V2enYq+KohG3FriFgIs3Io95YTMTVwBKT/DSV/et0BpNb1rsaSqdNkwdoWkJSeoLd0
         mByPBBO2pORMeOF4EsSvuzTOfHqWRvWHH0TxmS7aWdoJcQGOMeg
Date:   Wed, 22 Feb 2017 23:22:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 03/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170222232215.u2agozagwsyy2ooe@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
 <20170221234737.894681-4-sandals@crustytoothpaste.net>
 <xmqqy3wyawlu.fsf@gitster.mtv.corp.google.com>
 <20170222191641.o2rtt2ymtb4h2yqe@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oz5mbbjh65kebzgw"
Content-Disposition: inline
In-Reply-To: <20170222191641.o2rtt2ymtb4h2yqe@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oz5mbbjh65kebzgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 02:16:42PM -0500, Jeff King wrote:
> On Wed, Feb 22, 2017 at 10:50:21AM -0800, Junio C Hamano wrote:
>=20
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >=20
> > > Convert most leaf functions to struct object_id.  Change several
> > > hardcoded numbers to uses of parse_oid_hex.  In doing so, verify that=
 we
> > > when we want two trees, we have exactly two trees.
> > >
> > > Finally, in stdin_diff_commit, avoid accessing the byte after the NUL.
> > > This will be a NUL as well, since the first NUL was a newline we
> > > overwrote.  However, with parse_oid_hex, we no longer need to increme=
nt
> > > the pointer directly, and can simply increment it as part of our check
> > > for the space character.
> >=20
> > After reading the pre- and post-image twice, I think I convinced
> > myself that this is a faithful conersion and they do the same thing.
>=20
> I think this is correct, too (but then, I think it largely comes from
> the patch I wrote the other night. So I did look at it carefully, but
> it's not exactly an independent review).

I did take that part, as well as other parts, from your patch.

I have a test, which I'll send in a minute, that verifies that they do
the same thing.  At first I introduced a segfault, and the test caught
it, so I feel confident that the patch does indeed function as the old
code did.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--oz5mbbjh65kebzgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliuHScACgkQv1NdgR9S
9otZVA//aCJ4aqR2XRuFQpz1Jm1TgcMpO7TjwQzdUTdOaWyLvZpDcCxaf8l3/Ldz
CfjRgVC75sY/xUaayDh02f0zL9hG/30EDCvnBpwaKd94s+20cs2W2nk7RmIMmmIS
jlJchc4fPRj9izp4mT/dd2Vi/3Rg9XXMFqOVocGM9alXoqHzPM7wk+W3fkkxVY6E
Qq+JVlb/anweIM1EXy8QUJRof3cQnSCLNrgqe11+4UvKcSpkRAxw7x0z9D2UgKdO
sylr0Nxp4hOXU70601Qu1NlfoXYcqVHu/hbl7fTkV0zjPWi5iKS4k0GmdSbDWTIj
f/2tS527UuIXafXTgfg2oN8SwGcqfswtE/HymGk7F5ULboFFlG/0UXQ7py+l+NII
3G+1uT1snh+zuNFqRIMX8BygmPHn75AAYoWrDyATopWQUviT4N3WCdoXuf00F9Oa
JswDGQol1rBM7Jf7HAwNQW8oXM2rb7jSW0vOvjYJDSdIBOQBVjUEvW0UsPTegn8r
W5/OyOoZJzhDN9WW+Vzz0wPfMekk8pppvYDEzSL4/IjP/RNGzj6sqLsY0aMQdY3O
XOu0/vgOxvhpD6fiztjgWqlgNLNPcyxdWtzNZ5EzQUpcPlYS0w94FHxzMtRyyst/
HAC5oYUESiXvRlSRevWNIN85cb63a+9dXjmGjCl/af0n6l4yAtE=
=XDIZ
-----END PGP SIGNATURE-----

--oz5mbbjh65kebzgw--

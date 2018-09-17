Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2481F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeIQWYq (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:24:46 -0400
Received: from kitenet.net ([66.228.36.95]:46332 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQWYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:24:46 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 18:24:45 EDT
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1537202825; bh=eIB3b93qGBd1wQ2M+9YZV+ld7+QNB66zK6L9c1hKTUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xfw8QetnOAfg8nJY6jl1gg9M06OZaPiBCccXrpbXvUCEUcgDW3RgH1k4KNXMgJnpu
         d/K27Lv0VRvt31+K2pI+pwi+a2R8WQyFuOcSCFQeH8/8jd+X1+N3KUyfIMs4ShwYcR
         LG+IFaikDBBF17kk2sQBVX6ab2PbeqZvXhDiErJY=
Date:   Mon, 17 Sep 2018 12:47:05 -0400
From:   Joey Hess <id@joeyh.name>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        John Austin <john@astrangergravity.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, larsxschneider@gmail.com,
        pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180917164705.GA28056@kitenet.net>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
 <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl>
 <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl>
 <874leokw3p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <874leokw3p.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> There's surely other aspects of that square peg of large file tracking
> not fitting the round hole of file locking, the point of my write-up was
> not that *that* solution is perfect, but there's prior art here that's
> very easily adopted to distributed locking if someone wanted to scratch
> that itch, since the notion of keeping a log of who has/hasn't gotten a
> file is very similar to a log of who has/hasn't locked some file(s) in
> the tree.

Actually they are fundamentally very different. git-annex's tracking of
locations of files is eventually consistent, which of course means that
at any given point in time it may be currently inconsistent. That is
fine for tracking locations of files, but not for locking.

When git-annex needs to do an operation that relies on someone else's
copy of a file actually being present, it uses real locking. That
locking is not centralized, instead it relies on the connections between
git repositories. That turns out to be sufficient for git-annex's own
locking needs, but it would not be sufficient to avoid file edit
conflict problems in eg a split brain situation.

--=20
see shy jo

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAluf2okACgkQ2xLbD/Bf
jzi+Fg//T2Dhg4BQFWMuM18s+wQwVkznBtdCsefFLQUoYfhs4PfZ72vfmOFYUKbO
6LjRBh8+PGaQJWygGgcNHQdgpweC7i8hBBDiFpAK0jBLt4wDPYapiP2u7CtMuvr1
wMh109OsVOIAPca6TT+2MiwvqWJ2xgb42/nS/U0bntRWHgHkQ5QWZTrIEFrm6Pu+
ye6LYdDy+OeMFJ/ayVba1yONBGLsOTmfW01+dI8TqTARfQ+Snzp4SEe4BDuge8zx
ugp6e0VL/4l6FnaEsRgYdwN7Kgp55EPYxUEa8tNzLQMqrRA9iNVkLHuP5/DzT+Ub
y/rHV3t6fryRUOvymG+Xk0O0Ph2y93mrarHA3DMPvVr0SXG/VF7X7ftfYok8ykiO
deNlKcclQSmG8ey+q3HEvegcuCrwMSTCkg4cX+zwTtzJeYD1Wxh2p3rQSMYuWJLw
YImQbRDZfU7k4sxA+b8UcXSkyzIN+6NOJJUpv9n9lpCRf4yOGsY4lmshsTkOmQyl
XfvM8p+39G7nAzsLN4Lag9PTN6q2pANoUlJfnKPQsr9HqOqcuRDyiwEygcFG44Lw
wEql/3HMvfAfo8Gs6+Uxt14u1anZu98aSQCAWEd6UrayWZn/SbO4OI4XfocurIf7
LQgWY1OWNsb2qheXb2I73voYieiYJeZmulrSxjMbPa6EXEy8yY4=
=s6kP
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

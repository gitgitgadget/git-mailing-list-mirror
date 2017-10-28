Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A052055E
	for <e@80x24.org>; Sat, 28 Oct 2017 22:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdJ1WbO (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 18:31:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751304AbdJ1WbN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 18:31:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D58F6044A;
        Sat, 28 Oct 2017 22:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509229870;
        bh=2zq/h9AOOXSJaDdv8upvwyvV3R76L9mWSZQ1XjYWNMs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BJ7oVkOILbwbiSIehBq/fjIvd1wM4zNlBnKs8sK4chZ1S5oELCtXuSCxz3nAKqR3l
         E5HNZZY7rN8IO8BycmLKhbhQyGsvnYFwKWmrMqbNjE3J9s2Ef5D/nwvYOZYFnw+sko
         jpgviXipUmKsu4v2WHiejUpuGCfo/Osc3J1NRLAYi5iBWvcK3pjW6lhC+4FEFkKzRX
         84dy+RmqSrf2V4FB5ghQC4TfnMJgrcLyGVEAFp5NnCEONGgepnU+9Tr3a2GxECD+Nm
         GyIt0Gyof43JPaIIsRmh3LyEOuJu1HD9VlCjto9A+FLNrAS6aE98XazNStlE0r3hi6
         mPA4QeY5W123FDYplt+2u9/st/S4wEhI4IDO5/4bNqGvVkxHViQYOCjbr+4FhKbffm
         25Kj3+e4FV9tJRALseHaPRG1Agyxa0BBxuAPfE1CVvkCfdjkNqvW2XnJie0sJ4bR5K
         YfCI57mDXw4J7HccQPvyoFeqjMb0bIWv3dbBQgn36OTCNGoD4cm
Date:   Sat, 28 Oct 2017 22:31:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christopher Jefferson <caj21@st-andrews.ac.uk>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rm VERY slow for directories with many files.
Message-ID: <20171028223103.wevq5zf4rjl7ietd@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christopher Jefferson <caj21@st-andrews.ac.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BEEA4A16-5433-4E6C-A7D7-956C85F27DF3@st-andrews.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cft6c5tlx2jeupt5"
Content-Disposition: inline
In-Reply-To: <BEEA4A16-5433-4E6C-A7D7-956C85F27DF3@st-andrews.ac.uk>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cft6c5tlx2jeupt5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2017 at 05:02:02PM +0000, Christopher Jefferson wrote:
> I stupidly added a directory with many files ( ~450,000 ) to git, and wan=
t to delete them =E2=80=94 later I plan to rebase/squash various commits to=
 remove the files from the history altogether.
>=20
> However, =E2=80=98git rm=E2=80=99 is VERY slow. For example, in a directo=
ry with 10,000 files (on a Mac), git v2.14.2
>=20
> Git add . : 5.95 secs
> Git commit : 1.29 secs
> Git rm -r : 22 secs
>=20
> 50,000 files
>=20
> Git add . : 25 secs
> Git commit : 11 secs
> Git rm : After 20 minutes, I killed it.
>=20
> Looking at an optimized profile, all the time seems to be spent in =E2=80=
=9Cget_tree_entry=E2=80=9D =E2=80=94 I assume there is some huge object rep=
resenting the directory which is being re-expanded for each file?

Yes, there's a tree object that represents each directory.

> Is there any way I can speed up removing this directory?

First, make sure your working directory is clean with no changes.  Then,
remove the directory (by hand) or move it somewhere else.  Then, run
"git add -u".

That should allow you to commit the removal of those files quickly.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--cft6c5tlx2jeupt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln1BScACgkQv1NdgR9S
9oum5Q//fBuDByXKxcNpJkbhir24iO/evPr2ILXZA5SIaHWVzZxCb+Dy+H0hanlG
LuJH2L+if93beJ9PETgofEkKpUIk7X5Nco/C9smyi4I6BqvVCSzotlSZIaNsY0Ho
0GlMW17XFTNta8Zy0ak2PJk9ateACf1Aw/MdSS1Qqw4b5jSCFamTImGKbS1ct025
o+HxBNNybsPDvumNfTiFGRDcIocXVcqeoOSWyRzAu3Ih+1FRdk9ygERzqNHVEzUJ
ahcpUSriQWaECewOKFOAlWnQFb09GLxceCIAqKvqB34UxX9P/FvQ5ElJ4FVQ2UuD
6ErYCr9nqxZR9pp/m432gSDA2DTKWZqYrj5+F8hYlRAt/V03/U8hQypyPo1Jq3JS
YadVHWYITeNb1ca+ioPsM9rdgO3D4YXHZSedyAAWTLP5IWFuM9Oiol9zLHwBx84i
CntvLNeyHIfleuo46UwdZfrgNcOIJ3tedrJzVOl0jMKxzx7NVrylETRPJCvp2y3c
dI1urLVbqCo7xIGk5wAfcC2i3b5BUh1GrjEhywX9jarJySV9g0AjExGrO27ZVOYy
r/nfYStYGyKnB1yyC97KQ26y+OszLZFpvBsAlFJcUxQG4Ls0uNFRaRDfuezbmeoF
GrJzyZXZ5SxkHq+jQsrn6o+RMoLRGtDoSjD+r0Ji649n/9P248I=
=vl2F
-----END PGP SIGNATURE-----

--cft6c5tlx2jeupt5--

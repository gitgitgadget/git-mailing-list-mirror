Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366432018B
	for <e@80x24.org>; Wed, 20 Jul 2016 06:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbcGTGl0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 02:41:26 -0400
Received: from vpn.foo.tf ([195.154.43.236]:47598 "EHLO mail.foo.tf"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbcGTGlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 02:41:25 -0400
Received: from localhost (unknown [192.168.97.19])
	by mail.foo.tf (Postfix) with ESMTPSA id 88AFF39B64B;
	Wed, 20 Jul 2016 06:41:21 +0000 (UTC)
Date:	Wed, 20 Jul 2016 08:41:20 +0200
From:	Antoine Tenart <antoine.tenart@ack.tf>
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Antoine Tenart <antoine.tenart@ack.tf>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
Message-ID: <20160720064120.GE28551@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf>
 <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <CAPig+cQ5eGoNFa90__ay+Y7AMP5Zd1VUDXWFCfU1-XX3oEYAkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ5eGoNFa90__ay+Y7AMP5Zd1VUDXWFCfU1-XX3oEYAkg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, Jul 19, 2016 at 02:52:42PM -0400, Eric Sunshine wrote:
> On Tue, Jul 19, 2016 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Antoine Tenart <antoine.tenart@ack.tf> writes:
> >> Adds a --name option allowing to specify the name of a worktree when
> >> creating it. This allows to have multiple worktrees in directories
> >> having the same name (e.g. project0/foo, project1/foo etc...). This
> >> commit keeps the previous behaviour by making it the default value, i.=
e.
> >> by using $(basename <path>) as the worktree name when the --name option
> >> isn't used.
> >
> > Hmm, is this related to an earlier discussion
> >
> >     https://public-inbox.org/git/20160625051548.95564-1-barret%40brenni=
e.ca/
> >
> > in any way, or is it an independent invention?
> >
> > The conclusion of that discussion thread was roughly "users
> > shouldn't even _care_ about the name, and if they have to use name
> > to identify the worktrees to do certain things right now, reducing
> > the need for such 'certain things', not making it easy to give a
> > user-defined name to a worktree, is the way to go", IIRC.
>=20
> Yes, that's correct. The discussion wandered a bit before starting to
> converge at [1] and concluding at [2].
>=20
> [1]: https://public-inbox.org/git/CAPig%2BcRNUZZBw%3DF-Q2f3Ehc-8T2iBp4kvD=
usNRGv4ea5nihQVQ%40mail.gmail.com/
> [2]: https://public-inbox.org/git/CAPig%2BcSEwib1iFyWE5h8-qTbsAC%2BzsaSDS=
YQnv6otWoOOjWAeA%40mail.gmail.com/

Thanks for the links, I've had a look at the discussion. The problem
that raised it was a bit different: it was about reorganizing projects
and directory trees, no about creating a new worktree with the same
basename as an existing one. I've also had a look at 080739b,
introducing find_worktree(), but I don't think that would solve the
issue either.

So we've left with two solutions: being able to specify the worktree
name or having an arbitrary ID (plus some modifications to `git worktree
list`) as you proposed. I guess you prefer the later solution. Is there
any plan to do this, or anything in progress?

Thanks,

--=20
Antoine

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXjx0NAAoJEFxNi8it27zYJIsQAIgFyllm7tCTm0BltTRDhT78
K4Xkw3IJ5L8StzwxhcnzhDP9VfYhgWKFQRlUOvJHL12zVyqQ8DnRXfowgYr/lYGc
eEUpGA+U0bUt83Br0joq7coScdoNPEzcIHLCCss2lf1/y0MKgntvSjh3AjEmh25e
SMPMGoWJ8xjnTlhKL4YSKBn6iueGdJEYb2mPTgGkLZDGwKApDH2KGagXu/l7xTJY
x4Drh44gVXw+2vpc4Dotzos3hUAwGvkA+apdCW6Yu+mkYq7FUAsPTMvHRHJgD6Bq
6258S7J4l6cKDFLWPbFcLFf1AwCunFiyvakDLxYCjhCguYK+n4fViHAz++UlEWNO
hx9t07l4/J0jvRr4sY7Hc1Xlx6MO+qsjj2lwnCS5n0nuSkbxBP/wNJaf3kuolehJ
1chnt9f/TA+L6krjpJDb2/ufAevDn4w57YbcT3NZtzHNPGNCwfSXO1t85KcA7tMl
9Bq4NJdMY80BIsckXVxG5yaoYK9l3n/l1wBBQw+B3qOI4268TDm4aqoWyGSwaw4f
BHnqExwZVf1mOwlAUYVjt0Fwpyr52sNJN02dhzDAht/V6NGGO4gCsXLxuKOV1jEF
d1DI22YW6+DahCW5d6ofh2eN8BmHCFCmLf1nwicmDrQned8gg4QrxWQKKZRhYEVP
hZovK/+fo6BwdngIvP0g
=5vdz
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--

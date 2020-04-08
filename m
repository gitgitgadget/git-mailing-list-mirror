Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C73C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F302054F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J4Slh//c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDHAB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:01:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51680 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgDHABz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Apr 2020 20:01:55 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EFC8A60734;
        Wed,  8 Apr 2020 00:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586304114;
        bh=Ndqcj+OtYwG99nYAyj4gBupbs+yA5ij6LccLBnD9ZCM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=J4Slh//cYMyLBebVkxItYeNk1CXMmcfiFy6Jk9SqfuU5teRqfD/XRRfx7uQBkiKPL
         h9T43zi7Hb7TsMOk0IuI90KrtJWu5tvT9IWnuYhZyGFno6niynkmNZWsdWeQYO4Dgc
         Ds8t6Qw8U4vZGTzcSZOlhqJ/vucg1adqbaiLnEAc3w12lpdj8tTGvH8I5SaTJwInNA
         PUaEBElaGhsbGbliyWZ6HaGnWNmGiXUZL8InRuP2e6r1233fuQqcUxVJymESeQIo0X
         c66dAXsVJVHmkgYYrCHZ28iIxNpV3SHpvh+qx7EhybjPEAha8T18dXESIhUaTBUOrN
         8cvGF15HgaK5xfgrbkupl7WFrnz3PZaquECPGFueyZcBrXqhA7FD9AF9t5ydDPKQZz
         Nrs6FE1Wai4vust2Hd7d3u8cnTFn24NmjXBtuoqyN+2jvB59fiypb+mlYXIumoJ594
         bvGH48bL4nb691n5vK2vw6a1OCo48PZXZaMWkcK9YS+aFAMnsuR
Date:   Wed, 8 Apr 2020 00:01:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Message-ID: <20200408000149.GN6369@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
 <20200407014829.GL6369@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AA9g+nFNFPYNJKiL"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AA9g+nFNFPYNJKiL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On 2020-04-07 at 22:23:43, Johannes Schindelin wrote:
> > If there are periodic tasks that should be done, even if only on large
> > repos, then let's have a git gc --periodic that does them.  I'm not sure
> > that fetch should be in that set, but nothing prevents users from doing
> > "git fetch origin && git gc --periodic".
>=20
> Hmm. Who says that maintenance tasks are essentially only `gc`? With
> _maaaaaybe_ a `fetch` thrown in?

What I'm saying is that we have a tool to run maintenance tasks on the
repository.  If we need to perform additional maintenance tasks, let's
put them in the same place as the ones we have now.  I realize "gc" may
become a less accurate name, but oh, well.

> > Let's make it as simple and straightforward as possible.
>=20
> I get the impression, however, that many reviewers here seem to favor the
> goal of making the _patches_ as simple and straightforward as possible,
> however, at the expense of the original goal. Like, totally sacrificing
> the ease of use in return for "just use a shell script" advice.

I think we can have both.  They are not mutually exclusive, and I've
proposed a suggestion for both.

> > As for handling multiple repositories, the tool to do that could be as
> > simple as a shell script which reads from ~/.config/git/repo-maintenance
> > (or whatever) and runs the same command on all of the repos it finds
> > there, possibly with a subcommand to add and remove repos.
>=20
> Sure, that is flexible.
>=20
> And it requires a ton of Git expertise to know what to put into those
> scripts. And Git updates cannot deliver more value to those scripts.

Perhaps I was unclear what I thought could be the design of this.  My
proposal is something like the following:

  git schedule-gc add [--period=3DTIME] [--fetch=3DREMOTE | --fetch-all] RE=
PO
  git schedule-gc remove REPO

The actual command invoked by the system scheduler would be something
like the following:

  git schedule-gc run

It would work as I proposed under the hood, but it would be relatively
straightforward to use.

> > I'm not opposed to seeing a tool that can schedule periodic maintenance
> > jobs, perhaps in contrib, depending on whether other people think it
> > should go.  However, I think running periodic jobs is best handled on
> > Unix with cron or anacron and not a custom tool or a command in Git.
>=20
> Okay, here is a challenge for you: design this such that the Windows
> experience does _not_ feel like a 3rd-class citizen. Go ahead. Yes, there
> is a scheduler. Yep, it does not do cron-like things. Precisely: you have
> to feed it an XML to make use of the "advanced" features. Yeah, I also
> cannot remember what the semantics are regarding missed jobs due to
> shutdown cycles. Nope, you cannot rely on the XML being an option, that
> would require Windows 10. The list goes on.

I will freely admit that I know next to nothing about Windows.  I have
used it only incidentally, if at all, for at least two decades.  It is
not a platform I generally have an interest in developing for, although
I try to make it work as well as possible when I am working on a project
which supports it.

It is, in general, my assumption, based on its wide usage, that it is a
powerful and robust operating system with many features, but I have
little actual knowledge about how it functions or the exact features it
provides.

I want a solution that builds on the existing Unix tools for Unix,
because that is least surprising to users and it is how Unix tools are
supposed to work.  I think we can agree that Git was designed with the
Unix philosophy in mind.

I also want a solution that works on Windows.  Ideally that solution
would build on existing components that are part of Windows, because it
reduces the maintenance burden on all of us.  But unfortunately, I know
next to nothing about how to build such a solution.

> > I've dealt with systems that implemented periodic tasks without using
> > the existing tools for doing that, and I've found that usually that's a
> > mistake.  Despite seeming straightforward, there are a lot of tricky
> > edge cases to deal with and it's easy to get wrong.
>=20
> But maybe you found one of those issues in Stolee's patches? If so, please
> do contribute your experience there to point out those issues, so that
> they can be addressed.

One of the benefits of using anacron on Unix is that it can skip running
tasks when the user is on battery.  This is not anything we can portably
do across systems, nor is it something that Git should need to know
about.

> > We also don't have to reimplement all the features in the system
> > scheduler and can let expert users use a different tool of their choice
> > instead if cron (or the Windows equivalent) is not to their liking.
>=20
> Do we really want to start relying on `cron`, when the major platform used
> by the target audience (enterprise software engineers who deal with rather
> larger repositories than git.git or linux.git) quite obviously _lacks_
> support for that?

Unix users will be unhappy with us if we use our own scheduling system
when cron is available.  They will expect us to reimplement those
features and they will complain if we do not.  While I cannot name
names, there are a nontrivial number of large, enterprise monorepos that
run only on macOS and Linux.

That doesn't prevent us from building tooling that does the scheduling
on Windows if we can't use the system scheduler, but it would be nice to
try to present a relatively unified interface across the two platforms.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AA9g+nFNFPYNJKiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXo0UbQAKCRB8DEliiIei
gatrAP4gX7U/4gDJuE+pCpTtJyjVZjJ4kw69zWadDMEqxc5yPwEAm2isBudwBllJ
N1ZI7c74KwTtei5xNYU2t/AT5iliuQo=
=axED
-----END PGP SIGNATURE-----

--AA9g+nFNFPYNJKiL--

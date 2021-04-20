Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51243C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA5061419
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhDTXIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:08:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38068 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDTXIS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Apr 2021 19:08:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5BD660422;
        Tue, 20 Apr 2021 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618960036;
        bh=xVJN01nXswio/aSG81KEBujg8W7gR2UZ3BGfWBztFlA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Hxljtr/ACvViu0GZ6Xm3hTCnAoffnGLHhtjQXBUS3kQ6pPEXpXecuerz6lqNlfsVd
         61z0QMw9AWNzpsgKGTOKof2PFE08YNDQsAiopqSAPtZr3J6bFzM3H60qneeI891j1w
         WMHmCnlwbrIc57TPhPGIh1vsfCHNyYjT6Qt9ui3I6L6t49hS+MxLQjM6QFztAWw9db
         /nKTKcOvf7dVIQ3sMyndvgfEH+J8qvo0EqTHGOBbG40J0mxFmh4q8vesvG4SA9h+Ut
         wIlv9HzNslHGpyfu5xRY3Fr2qOg614oOyDrNsLC9hCoDKQ1WY3oI/YbmBoOt4e9J0u
         6aoB/jLDZdeRvE4rTxQJffduBO/fJmt4qdowG+QdEZJql0MWHhNLzn5b0tafcjfeW/
         jkLB9CAC2loy6RpEIaiFlsicqCr4fVr2FzoS7/X8FP4sGxxgahf4SGSAY0ry8XAcuA
         zER0N4JtQDYwTLQf2BsEZaafn/hpKFBoeBJ8eUvTDtuht2zVpOr
Date:   Tue, 20 Apr 2021 23:07:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] fast-export, fast-import: implement signed-commits
Message-ID: <YH9enUedtHjE87ET@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Luke Shumaker <lukeshu@lukeshu.com>, git@vger.kernel.org,
        Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
 <20210419225441.3139048-4-lukeshu@lukeshu.com>
 <YH4xY/oSwYIUmJyL@camp.crustytoothpaste.net>
 <87tuo0q3ma.wl-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="woXG7bxl1QoR6QNR"
Content-Disposition: inline
In-Reply-To: <87tuo0q3ma.wl-lukeshu@lukeshu.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--woXG7bxl1QoR6QNR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-20 at 17:15:25, Luke Shumaker wrote:
> On Mon, 19 Apr 2021 19:41:55 -0600,
> brian m. carlson wrote:
> > I would appreciate it if we did in fact implement it.  I would like to
> > use this functionality to round-trip objects between SHA-1 and SHA-256,
> > and it would be nice if both worked.
> >=20
> > The situation with tags is different: the signature using the current
> > algorithm is always trailing, and the signature for the other algorithm
> > is in the header.  That wasn't how we intended it to be, but that's how
> > it ended up being.
> >=20
> > As a result, tag output can support SHA-256 data,
>=20
> I don't believe that's true?  With SHA-1-signed tags, the signature
> gets included in the fast-import stream as part of the tag message
> (the `data` line in the BNF).  Since SHA-256-signed tags have their
> signature as a header (rather than just appending it to the message),
> we'd have to add a 'gpgsig' sub-command to the 'tag' top-level-command
> (like I've done to the 'commit' top-level-command).

If you're using a repository that's SHA-1, then the tag signature that's
part of the message is a signature over the SHA-1 contents of the
object, and the gpgsig-sha256 header is a signature over the SHA-256
contents of the object.  If you're using a repository that's SHA-256,
it's reversed: the signature at the end of the message covers the
SHA-256 contents of the object and the gpgsig header covers the SHA-1
contents.

It isn't currently possible to create objects with both signatures in
place, but that will be possible in the future.

> >                                                   but with your
> > proposal, SHA-256 commits wouldn't work at all.  Considering SHA-1 is
> > wildly insecure and therefore signing SHA-1 commits adds very little
> > security, whereas SHA-256 is presently considered strong, I'd argue that
> > only supporting SHA-1 isn't the right move here.
>=20
> The main reason I didn't implement SHA-256 support (well, besides that
> the repo I'm working on turned out to not have any SHA-256-signed
> commits in it) is that I had questions about SHA-256 that I didn't
> know/couldn't find the answers to.

Currently, repositories using SHA-256 currently don't interoperate with
SHA-1 repositories.  However, if you want to create a test repo, you can
do so with "git init --object-format=3Dsha256" in an empty directory.

If you want to run the testsuite in SHA-256 mode, set
GIT_TEST_DEFAULT_HASH=3Dsha256, and all the repositories created will use
SHA-256.

That should be sufficient to get this series such that it will work with
simple SHA-256 repos.  If you have more questions about this work or how
to get things working, I'm happy to answer them.

> However, looking again, I see a few of the answers in
> t7510-signed-commit.sh, so I'll have a go at it.  If I get stuck, I'll
> go ahead and implement the below "gpgsig sha1" suggestion, and leave
> the sha256 implementation to someone else.

Not implementing this means the CI will fail when the testsuite is run
in SHA-256 mode, so your patch probably won't be accepted.

> > Provided we do that and the test suite passes under both algorithms, I'm
> > strongly in favor of this feature.  In fact, I had been thinking about
> > implementing this feature myself just the other day, so I'm delighted
> > you decided to do it.
>=20
> That's one of the big reasons I didn't implement both--I wasn't sure
> how to test sha256 (within the test harness, `git commit -S` gives a
> sha1 signature).
>=20
> I see that t7510-signed-commit.sh 'verify-commit verifies multiply
> signed commits' tests sha256 by hard-coding a raw commit object in the
> test itself, and feeding that to `git hash-object`.  I'd prefer to
> figure out how to get `git commit` itself to generate a sha256
> signature rather than a sha1 signature, so that I can _know_ that I'm
> getting the ordering of headers the same as `git commit`.  But I don't
> think that needs to be a blocker; if the test doesn't do the same
> ordering as `git commit`, I guess that can just be a bugfix later?

Yes, dual-signed objects have to manually created right now; there's no
tooling to create them because that code hasn't landed yet.  It's in my
tree and very broken.  But you can create SHA-256 repositories as I
mentioned above and test those, and the testsuite does run in that mode,
so it should be easy enough to check at least single-signed commits for
now, even if you don't implement dual-signed ones.  I think it's fine if
that comes later, and I can pick that up as part of a future series.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--woXG7bxl1QoR6QNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH9enQAKCRB8DEliiIei
gWPyAQCNJx45SlADUvoDdqbaFwE966ew1eLRDrML5Bdll08M1QEA8u9quJb2AV7I
ynTrdOxCc78kuukpMWlPvV648Wy1DA4=
=fmPJ
-----END PGP SIGNATURE-----

--woXG7bxl1QoR6QNR--

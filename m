Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9611C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiDMVfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiDMVfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:35:36 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266F710FD
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:33:14 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4776B5A0CA;
        Wed, 13 Apr 2022 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649885593;
        bh=73yAG2onjiJdc+AzJmmNsUb538nWNq/QDH0vQBgg+vQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sqh7WF4nyvUQ0ebvJZFIuBzP7zHVrCPy0pm3Yke3QEIw9o6r7Gcfh02idH/CEWjeF
         HFDxt9Ee5V9Qvh33A9G/RrTlMDdvYvc1ORrssTsiASZmzSSKuG9fLSV+8qu1vKQZMO
         uFhWk7GdejRbgSPWlotw6lSyBdi1oj6PIKetUvNVzWIQPmbUA61fr5uGXc59zUGIGt
         GAdepe3cGwdm6YxmgM8iJ9HAhqeXoxTHoEc8/4t1ZTnQhwzLIYOscB0xQgEhmwVvLL
         +iEbMP/aeNGCA8at9xPi1QqBq+2jxa75RTaE2M8L/YZkj+PTskX4O07NE1WvvsbcEX
         ZKd0KhdpYdSQtNN94GAMAyfSyJiEY1iNW00dz7qW1rttJLe10fwT76mHW8P8mWF88h
         wDyg3cb0m+2GJtpYjAZpwa+WfEAjRc+fq5xgkybkTlSZXOrhqtP5KORJK95BMEtTss
         nqxByxMeS/FQxnJ6uCtcDKYrCWNt4oeeFcxKXbG90oTjOkIdJQC
Date:   Wed, 13 Apr 2022 21:33:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <YldBlydglKkBhR9y@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
 <20220412201435.803424-1-jonathantanmy@google.com>
 <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net>
 <xmqqzgko7nj4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qqFTGLn3XgYUmvoP"
Content-Disposition: inline
In-Reply-To: <xmqqzgko7nj4.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qqFTGLn3XgYUmvoP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-13 at 20:10:07, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2022-04-12 at 20:14:34, Jonathan Tan wrote:
> >> This seems like you're using the commit message as the reflog message -
> >> is this necessary? For what it's worth, all tests still pass if I
> >> replace "msg" with "NULL".
> >
> > I think that's what the existing stash code does, and so I did the same
> > here.  It's not strictly necessary, but it's a nice to have.
> >
> > I didn't think it worth testing, because I don't think we test it
> > elsewhere, either.
> >
> >> It might be worth adding tests that check that the exported stashes are
> >> in the expected format (to ensure that we can read stashes exported fr=
om
> >> another Git version) but I don't think that has to block the submission
> >> of this patch set.
> >
> > There's a tiny patch for that for the base commit, but you're right that
> > some more tests wouldn't hurt.  I can send a followup patch or two as
> > part of a new series.
>=20
> Is this about the log messages recorded in the throw-away commits
> that are only used to form a single backbone chain, to which the
> commits used to represent stash entries are linked to?

My response to the first paragraph was talking about the messages in the
reflog.  When we create a reflog entry, we add a message, which I've set
to the commit message of the stash entry, like the existing code does.
I don't think that's an important detail, but I did it to be consistent.
I think it's better to put something useful there, at least, rather than
not put any message at all.

The log messages recorded in the chain of throwaway commits are
identical to the corresponding stash commit's message with a prefix of
"git stash: ".  There's currently a test for the base commit having a
certain fixed value, but not the contents of the other commits.

> Are these messages meant to be used in any way?  I do not think
> these messages contribute anything to the end result (they are just
> discarded once they serve their purpose of transferring the
> underlying stash entries, if I recall the design discussion
> correctly), so I am not sure if we would even want to cast in stone
> what they would say.
>=20
> If on the other hand they are meant to be read by something (either
> programs or end-user humans), it does make sense to ensure that we
> are recording what we think we are recording.

The log (not reflog) messages are valuable because since these message
are pushed as refs, someone may look at them (e.g., on GitHub or with
git log) and it is helpful to provide something that tells the user
what's going on.

For example, since our throwaway commits are empty, it would seem
bizarre to users that someone pushed a commit with an empty tree, but if
they see that the commits are stash commits, that may help them have
useful context.

I'm happy to add a few more tests for this in a followup series.  I'll
likely get to it this weekend and can include some checks for the commit
message and some improved verification of commits in the testsuite.  I
don't think this should hold up the rest of the series, however.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--qqFTGLn3XgYUmvoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYldBlwAKCRB8DEliiIei
gWRZAQCjpiQfZ2w7fISV7vyKGgWVTTkk2P+iES5mla1QaaIUcwEAgRrCZGQKUEOe
KEBZqLhICGEgXpvH4er2h41u5vSrdA0=
=xWhM
-----END PGP SIGNATURE-----

--qqFTGLn3XgYUmvoP--

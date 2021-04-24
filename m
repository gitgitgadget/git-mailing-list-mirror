Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA88C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 17:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AB66128C
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 17:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhDXRjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 13:39:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40928 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhDXRjR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Apr 2021 13:39:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1DEA66041F;
        Sat, 24 Apr 2021 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619285888;
        bh=gF1MJR/VaDHOopDLm8T4qkVI0uU5w0CoCF3HLZuCfMA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S3U+cm8NTAl6gGrlVwbD8wTH16EhjDV3qnzxpWibEoeULKefZC4H7lPdrSg6yU5yq
         QP1qU0nywTq3KCavC0Y8ku9uKbOytGuU7hEJ0EnEvur37v8IpzT13yK0yjFyeJsTVB
         dfXmzLAerNjKOh9wqQJa3GiAhYvB4m07cNxPDUO+IE/AcjI49Bcs7UFJtGR6ZqKlBz
         G67DwbDa4hy/dzMoo+2flVZrv3MO/8yTBoXs16WiWxx9s8S6VADMQTJ9ngRfWA3gPn
         AEUcb+EqymFpamLzknIZrtAzTtyAIAJoB6MG29XDF6MPKivaBWYwU8ake5wQ8tYl5D
         021T7zqsrt7662cgkX81IT/73Upws7XUfqPNGLHG1HMQX7Gkiz8yBXHyqy/Fl6TNQ2
         xn13lFaRuwVnMZQnk0Qy5PCVxN5FRf0zef3qf+S/ygC+9x5LYeluh1vUQllnQBBGt0
         XULnxtjm0TMi6r03BHtDcjkCixUCOtegiKXdi8OWvg7jvzG4l7E
Date:   Sat, 24 Apr 2021 17:38:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: how to rename remote branches, the long way
Message-ID: <YIRXem9ApAsqgl6D@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        git@vger.kernel.org
References: <87mttofs5t.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2bkr+CfkOPqjtMWl"
Content-Disposition: inline
In-Reply-To: <87mttofs5t.fsf@angela.anarc.at>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2bkr+CfkOPqjtMWl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-24 at 00:22:06, Antoine Beaupr=C3=A9 wrote:
> For local branches, that doesn't matter much: no "links" should point
> there. But git repos are, nowadays, living web sites on web servers like
> GitHub, GitLab, cgit, or whatever. You have no way of telling those
> sites "I am renaming a branch", so they don't have an opportunity of
> fixing broken links (and, incidentally, bypassing branch protection,
> although I actually use the GitLab API to workaround that problem).
>=20
> So I wonder: could git remote branch renames as an operation on remotes?
> How would that look? Is that something that the git project should work
> on? Or is this something strictly reserved to the API space of git
> forges? In that case, how do I tell my gitolite server that it's okay
> to rename a branch since it doesn't have an API? :)

I think the ability to rename a branch, and to update the HEAD reference
(and other symrefs) would be a nice protocol extension to add.  I've
considered doing this in the past, but have never gotten around to it.
It's definitely a feature I'd like to see.

> Or, maybe, should this script be sent as a [PATCH] instead and just be
> merged into git itself? Maybe in contrib/? I do see some Python in
> there, so I don't feel too much like an heretic... Obviously, it could
> be rewritten in C, but it would feel such a pain in the back to me... I
> already rewrote it from this shell script, which is still available
> here:

In general, Git tries to remain neutral on forges and therefore we're
probably not super likely to adopt tooling that's specific to a set of
forges.  I do, of course, think this script has utility and serves a
particular need for users, even though it's not likely that Git will
host it itself.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--2bkr+CfkOPqjtMWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYIRXeQAKCRB8DEliiIei
gUWJAQDZ8Jw8EZ1U3Gp3hHhAwivyM98dfcHBSbSaAWwXcebmeAD/RRLHJLtOB9T1
3i6N5uGBqUb+J5nKV5BbOn/YvjzUGQM=
=AoZk
-----END PGP SIGNATURE-----

--2bkr+CfkOPqjtMWl--

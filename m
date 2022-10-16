Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E817FC4332F
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 23:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJPXVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 19:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJPXVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 19:21:12 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD7B20196
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 16:21:11 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E90425A560;
        Sun, 16 Oct 2022 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665962470;
        bh=ZgLHxFWbXgiGAw+J+04SV/2H8+XQxNnwf318IINpKvw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DvFFqcY3j2Cyh0HXGv8B76/n2I9wXAE5bv7DwnumuKQP0nknFRf1rN067WIJS5QVZ
         zg+3B1COOML1ql5dC7iTIxao5+yTxqO8zdnwEveZZ5A2HUQE5i4/j6xjGmDtS+2JzW
         mKfL+rO+nkBVU5MAvr8qWl7z0DrjEsSb226inmjkssOYpMgqCXVFG3IPJ95i8U9d7S
         +NRZQ0FEBng8ednhsZw2Kb9KC4JaA8iH3fJ8nErMT0rqtRQXpw0N02lGCMpd+tDmJq
         fkov5fZL4Yt3S2q4Tfh/wRPpIkpPnwnT3tZGtrR3MLUJ7CyjL0RC/t3vlwIt5j6O1C
         yVIPR2UvC7FWILvwm6OpweRrocqXN/Y9QqLGnlabLz72CQKKbwnkGMnUIS4eUoT89M
         B4fh6sxEgmBhlCNc2Gqrk3SW78m0FXGHJtu7qyRJUk1Rhb5GnRyZ24qYRJ+02IXupv
         vg8dNolYba8y5M0W/8CLSL4yaCeZxX6Za4ZT7e7V0qAuL5+et5s
Date:   Sun, 16 Oct 2022 23:21:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     kpcyrd <kpcyrd@archlinux.org>
Cc:     rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de
Subject: Re: git 2.38.0: Change in `git archive` output
Message-ID: <Y0yR5dPJyh8aetZA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        kpcyrd <kpcyrd@archlinux.org>,
        rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de
References: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LtmOvCZr5R6CMQHI"
Content-Disposition: inline
In-Reply-To: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LtmOvCZr5R6CMQHI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-16 at 21:57:40, kpcyrd wrote:
> hello,

Hey,

> multiple people in Arch Linux noticed the output of our `git archive`
> command doesn't match the tarball served by github anymore.
>=20
> First I suspected an update in our gzip package until I found this line in
> the git 2.38.0 release notes:
>=20
> > * Teach "git archive" to (optionally and then by default) avoid
> >   spawning an external "gzip" process when creating ".tar.gz" (and
> >   ".tgz") archives.
>=20
> I've then found this commit that could be considered a breaking change in
> `git archive`:
>=20
> https://github.com/git/git/commit/4f4be00d302bc52d0d9d5a3d4738bb525066c710
>=20
> I don't know if there's some kind of gzip standard that could be used to
> align the git internal gzip implementation with gnu gzip.
>=20
> I'm not saying this is necessarily a bug or regression but it makes it
> harder to reproduce github tar balls from a git repository. Just sharing
> what I've debugged. :)

This isn't a bug, because Git doesn't guarantee that archives produced
by different versions will be bit-for-bit identical.  It does guarantee
that an archive of the same commit or tree using the same version of Git
and associated tools running with the same configuration and environment
will be consistent (that is, a given version of Git produces
deterministic archives).

I will also point out that GitHub also doesn't guarantee bit-for-bit
identical archives.  It does currently use git archive under the hood,
but that could change at any moment without notice.

Zip files also contain two sets of timestamps: local and UTC, and
therefore there's an additional element in which archives can differ
depending on the time zone.  In addition, using the export-subst
functionality can result in short object IDs of different lengths
depending on the number of objects in the repository, so archive can
differ for that reason as well.

So it's not the case that you can expect identical archives from Git and
GitHub.  If you need to compute a hash over an archive, you need to
store the archive somewhere (on GitHub, that would be as a release
asset).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--LtmOvCZr5R6CMQHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0yR5QAKCRB8DEliiIei
gZmFAP9XPLOZF5N3s6XyLm8RMZkYu/MQld/bMBKSWUy2SQIBKwD6A0Bhjrr3TnoI
xdR3NphPL1uBpdsW0/C1Twb1nTz43As=
=wLBW
-----END PGP SIGNATURE-----

--LtmOvCZr5R6CMQHI--

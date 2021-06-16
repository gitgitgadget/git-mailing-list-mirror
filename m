Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766FFC48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B8960FE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhFPAyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:54:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49534 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230507AbhFPAyT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Jun 2021 20:54:19 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 48F2460479;
        Wed, 16 Jun 2021 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623804704;
        bh=V+v5C71BOxA2OxuBgRx20+KGReq7MU3o53QS2K+TD/Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i5dLSgChk0inHS5ZPV8v2eYWYneGSvMDnKh6abEMSL9wc4FqULnuHeRBC7CIvXght
         rR2xkWLaUde3P5+WrNSrw0YB1NcEzgoUJOxrmqqe9D31HOzYMPnqJ3JQQxaV7IW1ST
         j5K48D3ARjsww67HC0gAMWj49RquBZ3L5EA2o/sres+tARL0GZC/k7qVtDp7fwWhPy
         YJTfe/YdJsqBJfE9D12e/sR3EYgY59hZGU4VCmw/RuDPMUMhT+XUqkBK7wVuDrSDAv
         Q0R7SJYSpgc/rJjHB4nGnQsBRhjWTl/e0RU0WCJCJOEQ8KujO2VtQScAA8TESaRWBF
         G/QZEkUJnhSB7eJ90BxWnv69y2gUqWCAKudgvL2XBnbzm8hn0JDh8NATsan+0RvsaC
         Q0X7ldaHlkeDXMlYge6xv0D9+1gHIPiG67b+uqNwag6cx5UgHIk9UAIQyavRtGSbpP
         XZFZaT4s9Ldj7VHQ9MbEnSrgqPR1dx3SGRCXRiFpYg++KRhC93X
Date:   Wed, 16 Jun 2021 00:51:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Rose Kunkel <rose@rosekunkel.me>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
Message-ID: <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h79N+Mru61Vw5ddF"
Content-Disposition: inline
In-Reply-To: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h79N+Mru61Vw5ddF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-16 at 00:16:06, Rose Kunkel wrote:
> # What did you do before the bug happened? (Steps to reproduce your issue)
> 1. Clone a git repository that sets `update =3D none` in .gitmodules:
> $ git clone --recurse-submodules https://github.com/ubolonton/tree-sitter=
-langs
>=20
> 2. Perform a hard reset:
> $ cd tree-sitter-langs
> $ git reset --hard
>=20
> # What did you expect to happen? (Expected behavior)
> The reset should succeed and do nothing.

I think we're in agreement on this.  This should be a fresh clone and so
a hard reset should change nothing.

> # What happened instead? (Actual behavior)
> The reset command fails with
> ```
> fatal: not a git repository: ../../.git/modules/repos/agda
> fatal: could not reset submodule index
> ```

Hmmm, I can't reproduce this behavior.  What I see is this:

  $ git reset --hard
  HEAD is now at 5d362ce Release 0.10.0

I'm running git version 2.32.0.272.g935e593368 on Debian sid (with the
experimental packages).

Can you try the clone and run a "git status" command in the repository
to see if anything is modified after your clone?  Are the submodules
checked out when you perform the clone?  In my case, I see lines like
this:

  Skipping submodule 'repos/agda'

If you're seeing something different, then that might contribute to the
different behavior we're seeing.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--h79N+Mru61Vw5ddF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMlLGQAKCRB8DEliiIei
gRlOAP9zj7mgh2cM3EEhZJuo5jEM311yIIfoZV5J0lWXll6ddQEAvUp52HIkrkj9
d2qXJDwhap3D9brAhYb6iSLUFimixQM=
=D9oG
-----END PGP SIGNATURE-----

--h79N+Mru61Vw5ddF--

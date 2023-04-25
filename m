Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906CC7618E
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 00:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjDYAlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDYAlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 20:41:00 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB94AD19
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:40:58 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id ACA575A35F;
        Tue, 25 Apr 2023 00:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682383257;
        bh=D001Q8+CW4Z/GN8Mi2wrVA6HgZrIGqE71Kg6C1kOKbg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HEr5IvFpIwVU3oSncbXbK4huUj9KL2lAKnnoLuIiUeOZn0MREIR7aYGG24st87JeP
         Zte1WIIxPYre9epT080T1J3BA3ZgnnbwisBOldMrhWCT1dXK2cUWLtlPRSl8JbGXZG
         Oc8QGqUNdshRdN5YXWNk3U9tQMwL5iq9qjbpn+vd/FJ9G6f9bWZJzE7RxmBxyTv7J1
         5Dl80CmWZeQy4xYioozmdd3ZX1PmihKvJSfhasB6MzxbFUSH4Q2mseljXAD9atcW7l
         VZg9HgqbmjylUtM4ydwvLxlwk79t3sVwsUC2aVR5AN1mpq5848LBSbi/aCMYhNPC33
         bnv68bQDsu1+kTbEnFsbEM4VhpNrCZn3I0ekQGZrFN1DmzesHq24Xi2EETQMuL3RKb
         KumujcVSjiICNWQvI53W5YwYsWGZtWzRXR82QE+srgVaR6UhTnaeFjEhDG3BBfxvJB
         eKdikMaiSwzcBNWMVg1Rk8FGYc9z2nYeyhZU5USEFENnopR1YU7
Date:   Tue, 25 Apr 2023 00:40:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Blyxyas <blyxyas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Inconsistent names in `git shortlog`
Message-ID: <ZEchmO/7/KdLhsLg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Blyxyas <blyxyas@gmail.com>, git@vger.kernel.org
References: <CAGeanHfxL9e_OHPFzBjLjgVU=QLvwYS9QVCGHC1JHSkApRAwgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xPqMTiqvMS8K+gc6"
Content-Disposition: inline
In-Reply-To: <CAGeanHfxL9e_OHPFzBjLjgVU=QLvwYS9QVCGHC1JHSkApRAwgQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xPqMTiqvMS8K+gc6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-25 at 00:00:27, Blyxyas wrote:
> `git shortlog` (specifically talking about `git shortlog -sn`, but
> applies to the whole subcommand) produces a list of names based on the
> contributors to a Git repository.
> But it turns out that the output of the shortlog is very inconsistent
> in that sometimes it uses the username and other times the full name.
> This can happen even in the same repo.

I don't think `git shortlog` considers anything but what's in the author
name field, as far as I can tell.  It may be that some people have
placed a username in that field, which is contrary to the intention that
it be a personal name, but we can't force people to use a particular
name.

git-commit(1) documents this:

  The author and committer names are by convention some form of a
  personal name (that is, the name by which other humans refer to you),
  although Git does not enforce or require any particular form.
  Arbitrary Unicode may be used, subject to the constraints listed above
  [which I have elided here]. This name has no effect on authentication;
  for that, see the credential.username variable in git-config(1).

I added this documentation because many people _do_ think it has
something to do with authentication and thus put a username there under
that mistaken impression.  I suspect that's what's happened in the
situation you mention.

> There should be a convention established. I would personally prefer
> using usernames, as the huge impact of Github would mean that it's
> easier to go to their profile just by copy-pasting their shortlog
> name. Maybe add a `--realname` / `-r` flag to the command to show the
> real names and show usernames by default?

There are many Git users who don't use GitHub, and the documented
intention is that it be a personal name, so I'd recommend that people
use that.  Regardless, we don't know what a person's GitHub username is
or if they have one, and Git wouldn't want to prioritize one particular
forge over another, so we wouldn't add any sort of API requests to
GitHub in particular.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--xPqMTiqvMS8K+gc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZEchmAAKCRB8DEliiIei
gXZQAP9/pFIyeKIaVkQ23gBm+EeDUkUtjeWZn7KZ2W9c/WB1lwD+NlA/EiH3AMiJ
zabnH/ZRoeqj1QbtLJUjfe9f35lvIQ4=
=8DZ2
-----END PGP SIGNATURE-----

--xPqMTiqvMS8K+gc6--

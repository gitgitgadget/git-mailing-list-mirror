Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1A0C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 00:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355402AbiFVAaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 20:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355393AbiFVAaD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 20:30:03 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBE62F3AA
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 17:30:01 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 24E0F5A1ED;
        Wed, 22 Jun 2022 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1655857801;
        bh=zDkuFchBbMvLUuezH5r0VszGFRfuam+tPRC7jqDK+fA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=T7XYw+gHU5ZUZAgwBnJU1BE/pSILTyde6rIRIpEFVsMTMb9RJmO+JFWGrnvox0ZNF
         e5vvagV29GxeEtl80GKfEYUmguBaYsa5x5kDbulWk3WETEq8/BXEQasJdy8w/iG31l
         MIWDQV60Mi0bQbVwXWYp8YHhKqpkDK/9tDgWux6AL3rGnEI4OFMz6uIkafnVqBtNV7
         tWFyxH9J53WqOaSV/ezjLK6yhDkvnJ19zP/fcb21Jv2BEUZvRIATrlNhtgwqhWEU5f
         D0jiaqkABvvykKPdw2RmpHh39F+NW8fo5FG6+8OOZSogo2nTGoIkCHr6sE4RMPFJ98
         012JB+AXMlScD4uV5118+VI6AUjjLHZOsOktwLI/Er4KjQo41ynsyZQjv4UJvhJcMM
         tJ8tXmU66DZRME4hrljv+liAQ/wy40J8aIAPj4w8VRKQV3xIIiofBp8bCKNsf1zAHg
         xST1LFxTO8ZRQQ4LaPxMtFthxdCwVOHMiwbTSh8GDuTEt/34y9I
Date:   Wed, 22 Jun 2022 00:29:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.org>
Subject: Re: SHA-256 transition
Message-ID: <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.org>
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AUEKJQmhSQSM0SOr"
Content-Disposition: inline
In-Reply-To: <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AUEKJQmhSQSM0SOr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-21 at 10:25:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> But the reason I'd still say "no" on the technical/UX side is:
>=20
>  * The inter-op between SHA-256 and SHA-1 repositories is still
>    nonexistent, except for a one-off import. I.e. we don't have any
>    graceful way to migrate an existing repository.

True, but that doesn't meant that new repositories couldn't use SHA-256.

>  * For new repositories I think you'll probably want to eventually push
>    it to one of the online git hosting providers, none of which (as far
>    as I'm aware) support SHA-256 repos.

This, in my view, is the only compelling reason not to use it for new
repositories.

>  * Even if not, any local git tooling that's not part of git.git is
>    likely to break, often for trivial reasons like expecting SHA-1 sized
>    hashes in the output, but if you start using it for your repositories
>    and use such tools you're very likely to be the first person to run
>    into bugs in those areas.

It's my hope to see libgit2 working on SHA-256 repositories in the
relatively near future.

> But more importantly (and note that these views are definitely *not*
> shared by some other project members, so take it with a grain of salt):
> There just isn't any compelling selling point to migrate to SHA-256 in
> the near or foreseeable future for a given individual user of git.

I wholly disagree.  SHA-1 is obsolete, and as soon as hosting providers
support SHA-256, all new repositories should be SHA-256.  There is no
other defensible reason to continue to use SHA-1 today.

> The reason we started the SHA-1 -> $newhash (it wasn't known that it
> would be SHA-256 at the time) was in response to https://shattered.io;
> Although it had been discussed before, e.g. the thread starting at [1]
> in 2012.
>=20
> We've since migrated our default hash function from SHA-1 to SHA-1DC
> (except on vanilla OSX, see [2]). It's a variant SHA-1 that detects the
> SHAttered attack implemented by the same researchers. I'm not aware of a
> current viable SHA-1 collision against the variant of SHA-1 that we
> actually use these days.

That's true, but that still doesn't let you store the data.  There is
some data that you can't store in a SHA-1 repository, and SHA-1DC is
extremely slow.  Using SHA-256 can make things like indexing packs
substantially faster.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--AUEKJQmhSQSM0SOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrJihwAKCRB8DEliiIei
gftKAP9oyEtwQ9yQoet986+QeoJjvf+w6gbNri0vmhFXQlN+XwEAvcU3UUO5FEvP
cAoKE9Y2gxjCGnarkGkKUJok0PF38A0=
=kpYh
-----END PGP SIGNATURE-----

--AUEKJQmhSQSM0SOr--

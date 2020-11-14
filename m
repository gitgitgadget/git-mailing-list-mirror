Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A3C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAB222263
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 19:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKNTPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 14:15:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40918 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgKNTPj (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Nov 2020 14:15:39 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A749F6044F;
        Sat, 14 Nov 2020 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605381337;
        bh=nHjN65+/JR9NSDt+mPDYu3XRv4I/GvoAcEsImVzKtdY=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mO7H4fpnkEchYeirwmBKZDyrbWeFIWuCSjwGqQw2CJoL1S0j2h3QOuVSgZjDkqJpZ
         pV0Xrn91LfeeSZCdwEzN0fFyPUX9xbLgWw398qIr8mHIzhRqdIW4zNBUauQop0jLBP
         aBSIOLvUItwqu62Lv008CqVuDQAi+xn0sfOuFCqNCDxR2onEaI1ZQ9/UFwdSJGwWUX
         w2EGg9gMtnnyoB6326NOTlPDy2HfK6s3hm+kQxB7ZlxPLfl2Z0gfBhFaMMkWWoaC2a
         Ii//3bgfQDb8Ecm0NpKbYNBbre1bcPP9vhG9YI1UVz2xFZsgO4RUnFsnN9jaPR3Oba
         ZCb5DIjqW58idZj1qgtEel4EICrWt3nnPJxoZ3IEO+iMMsTVtmyTBoQNnIXPa3gwgx
         h8qy8TkC5gogBXsk2nA0jnoZ15kv6y+svT/N2au0IiLrYDVpJYwhZLjvtM2iKXqnmB
         vKyLlQddS/C5HBeQhc4JAbVWJh6WzneUJLYd3c2asuByPVIMrF9
Date:   Sat, 14 Nov 2020 19:15:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alireza <rezaxm@gmail.com>, git@vger.kernel.org
Subject: Re: Why Git LFS is not a built-in feature
Message-ID: <20201114191531.GO6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>, git@vger.kernel.org
References: <CAD9n_qjKyxNjtd1YrcHzshLg0-vbwXkHRwMveXHAWSOXMWLKAg@mail.gmail.com>
 <20201114002902.GN6252@camp.crustytoothpaste.net>
 <20201114162700.cvmxzcs4sdhsxpak@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
Content-Disposition: inline
In-Reply-To: <20201114162700.cvmxzcs4sdhsxpak@chatter.i7.local>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-14 at 16:27:00, Konstantin Ryabitsev wrote:
> On Sat, Nov 14, 2020 at 12:29:02AM +0000, brian m. carlson wrote:
> > Additionally, in many cases, projects can avoid the need for storing
> > large files at all by using repository best practices, like not storing
> > build products or binary dependencies in the repository and instead
> > using an artifact server or a standard packaging system.  If possible,
> > that will almost always provide a better experience than any solution
> > for storing large files in the repository.
>=20
> Well, I would argue that if the goal is ongoing archival and easy
> replication, then storing objects in a repository like git makes a lot
> more sense than keeping them on a central server that may or may not be
> there a few years down the line. Having large file support native in git
> is a laudable goal and I quite often wish that it existed.

Sure, and I think that's a different goal than the typical source code
or writing project (documentation, book, etc.) repository.  For example,
one can use Git repositories to do backups using the tool bup, which
actually works quite well but isn't a traditional use of Git.

The typical use case is that the user wants to store some reasonably
sized project on their local system and possibly also collaborate with
others for that, and with that goal, it makes sense to make the
repository not be absurdly large, since most developer systems don't
have tons of storage.  As =C3=86var and I mentioned, there are built-in
options for large files that make this use case more palatable with
native Git tooling.  But for this particular use case, it doesn't
logically make sense to store build assets, whether they're yours or
others', in this project repository.

If your goal is archival and replication, then a tool like bup might
meet your needs, or simply a large repository with many objects.  But in
that context, you'll likely have more storage, CPU, and memory available
to you and the need for large file support will look different (e.g.,
core.bigFileThreshold) or not be present at all.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--KM+e2hnYAO+MCJ5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7As0gAKCRB8DEliiIei
gTQYAQDpE1ATAKzjNUcrb79Mton/RjpqJ9mCWUQoeGKsSTedawD+I3TFzA6V7OIL
yY2HMaLEoSq+s6CKf3g8MsYOIqlR5QM=
=FULO
-----END PGP SIGNATURE-----

--KM+e2hnYAO+MCJ5e--

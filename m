Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40648C55ABD
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011C12225B
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKNA3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:29:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40432 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgKNA3K (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 19:29:10 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7B70760752;
        Sat, 14 Nov 2020 00:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605313748;
        bh=NqdimiXV/i/syxxkgt/imUNY0gZAWMQqRzOLnnqd7dM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=prRkFzuA9T1lavKCXVc79kBUGpLYkTFPXuVPN6MBnbeScy7k7A3WyX/BdQx6KFuqE
         ZPKOENMn5J1u0tlqvUm1MXCvogHQh8OxYbDiJKBEMH+Gjirb6qbRiDkVEeWbvrr+q/
         MhR9D00ZC10CDl16ov1RYHgqOma6ZMl8rz8mmGy9lTUzHvGhMxZxk+tLnsd2XUeUGw
         Lx8YSS/cHNORX6QUAp+3hoh3vOc79LMDqBSHcKQvunmc/sfcjLrRKtjaGv+RAIXPeQ
         GMaY5/QCKnQbgQXZdHNfYTJ3DTqRc318zpdiqGtsf4E3gTifzSuUAEq8vYtBxqrnPr
         qWeHnWhPpXV1mUzuQXh0Zsd3TOX0ejd4HMMyDYgmc/+Qynyi83Kkz24aC+4a1CTyW+
         vOniq9ShHF44/cGBgDsZbA1Zrz2fGre4qmxiq5fwOgFGqjaNpWW8+Zz579Qu+aObYm
         OwphYL68eiQb0qP9ugKkNKWbrwNb5Wz00ppmGnSCRVzEKxJAwvr
Date:   Sat, 14 Nov 2020 00:29:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alireza <rezaxm@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why Git LFS is not a built-in feature
Message-ID: <20201114002902.GN6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>, git@vger.kernel.org
References: <CAD9n_qjKyxNjtd1YrcHzshLg0-vbwXkHRwMveXHAWSOXMWLKAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6vqABX3nJKXLk01"
Content-Disposition: inline
In-Reply-To: <CAD9n_qjKyxNjtd1YrcHzshLg0-vbwXkHRwMveXHAWSOXMWLKAg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i6vqABX3nJKXLk01
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-13 at 09:45:52, Alireza wrote:
> Currently, having to set up git-lfs in each client and checking server
> compatibility is a huge barrier for using it in the first place,
> whilst it is generally a good practice to store large files in lfs.
>=20
> As a consequence a lot of repos are not using it when they should.
>=20
> Is there any reason that we don't have built-in support for such an
> important feature?

There are a couple reasons that it's not a built-in feature:

* First, there are several options in this space.  Git LFS is one,
  git-annex is another, and some people prefer to store large objects in
  the repository and use partial clone.  Git, as a project, tries to be
  flexible and meet the needs of various kinds of users without
  privileging one or another external tool.
* Git LFS is a complicated piece of software and it's currently written
  in Go, which is different from most of Git.  Re-implementing it in C
  would be burdensome, and there's little interest in maintaining Go
  software in the Git project.
* Git LFS uses a different protocol from Git, requiring additional
  configuration and a separate server-side component.
* The smudge and clean filter approach has some limitations, among them
  that users who don't have the external filter installed can commit
  uncleaned objects that then result in the working tree consistently
  being modified, even after git reset --hard.

It's my hope that the built-in support for partial clone will mature
enough to the point where that's a clear win and the need for external
tools isn't as great, since I think that will ultimately provide a
better experience for users.  Some people are already using it.  So in
some sense, we do have this as a built-in feature, maybe just not the
one you were expecting.

Additionally, in many cases, projects can avoid the need for storing
large files at all by using repository best practices, like not storing
build products or binary dependencies in the repository and instead
using an artifact server or a standard packaging system.  If possible,
that will almost always provide a better experience than any solution
for storing large files in the repository.

Finally, if you do want to use an external tool like Git LFS, it's
reasonably straightforward to specify a script to install and configure
the required dependencies for your project on each system so that
everything just works.  One popular location for this kind of path is
script/bootstrap.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--i6vqABX3nJKXLk01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX68kzAAKCRB8DEliiIei
gTIaAP4hOgo2M6o4nE8K6umbrw51zt77xjoCzM3wiovvweonmQD8D9hmRzhIPKWB
j5Y98Gm/mFKXr8Kjfu9t7hgYKnZWYw0=
=Fgw6
-----END PGP SIGNATURE-----

--i6vqABX3nJKXLk01--

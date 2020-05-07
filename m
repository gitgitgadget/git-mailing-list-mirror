Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E587C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6762E208E4
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vnc+2d/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEGXrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:47:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37978 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgEGXrY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:47:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 05D296044D;
        Thu,  7 May 2020 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588895243;
        bh=CoECH4PPuFH0eFx60YquEReDHxRCwKwXKIwhnuMFzM8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vnc+2d/gwdtRpXd6/SLHnLpjUQZhDEECrDILeCgXwxwCpP5MEaCuJyHKGpMiplqhS
         FtQvqiQvRfYuhiTk6eyCcfkTEzohRu2mJNQGkZNH9Osmat8cALNWaYKLs5iZ1Brtfo
         y7hY/2AfcEwBLDsxIAxGRSt+j+kdktok3iConKYJhxMQm26q1pT2I3s/D+caau5auI
         Pe8P0n46mKkAPq7CSqvffJlrB02ax+VeWKP7g4BRbw8esaBFZI3lGV4kTj8/DdRa6d
         eQGpoJjwFLBtdsfYrYWk+r57OSw3DpJPBh2vDaqx9D6n3sCAS9j5F6bIJ/2G3FhLTz
         Glm9YRfVEEx3kxpJUwSln0o8l7+BqyA8W8Hzbid6aTbIuDck2DUkw+avtr2HS7LH8X
         N+4sTgaW5olkcZXNtFxZVsWy4+3fdZvKpWesD51ASxx3dNkGsEcWEnoTT+25fnOjuR
         9H+CsqI5Jpz3+jHSSUTDPJpVS2mHzKDnwYlvd4OL7CiDz0jfdNq
Date:   Thu, 7 May 2020 23:47:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: check if one branch contains another branch
Message-ID: <20200507234718.GC7234@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alexander Mills <alexander.d.mills@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
 <xmqq1rnv2vi2.fsf@gitster.c.googlers.com>
 <CA+KyZp6pvqqNnOOj0ap9ekPdv9mZg2u_NQuwFgMXfwfV17SrYQ@mail.gmail.com>
 <20200507232448.GB7234@camp.crustytoothpaste.net>
 <CA+KyZp4keGp8j0rzCtr0fEogZqkKwTNLvRBZ2QOUzjStP+V2uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <CA+KyZp4keGp8j0rzCtr0fEogZqkKwTNLvRBZ2QOUzjStP+V2uA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-07 at 23:28:40, Alexander Mills wrote:
> Thanks will check that out.
>=20
> This command does not seem to work :(
>=20
> > git branch --contains branchB
>=20
> I do this:
>=20
> git checkout branchB
> git commit --allow-empty -am 'empty commit message'
> git checkout dev
> git branch --contains branchB  =3D=3D> exit code 0
> git branch --contains $(git rev-parse branchB)  =3D=3D> exit code 0
>=20
> this seems like a bug or something.  Why wouldn't it exit with 1,
> since it obviously does not contain that commit?

Because that command operates differently.  From git-branch(1):

  With --contains, shows only the branches that contain the named commit
  (in other words, the branches whose tip commits are descendants of the
  named commit)=E2=80=A6..

git branch --contains branchB prints only branchB, because no other
branch contains it.  In other words, this asks to list the branches
which contain the specified commit, and as long as it has done so
successfully (even if that answer is "none of them"), it exits 0.  The
current branch has no effect on it because it's listing branches which
match a criterion, not comparing the specified revision to the current
branch.

Note that this is not a porcelain command (that is, it is not intended
for scripting) and need not be especially performant.  git merge-base
--is-ancestor is the better way if you want to script things or get a
more performant answer because it does less work, especially if there
are many branches.

> This kinda sucks tbh :(

Certainly it fails to do the thing you wanted to do with it, but since
that isn't what it's documented to do, I don't see that as a particular
problem.

Is the documentation unclear in some way or could it be more helpful?
If so, please tell us so we can improve it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrSeBgAKCRB8DEliiIei
gbJLAPwMnPmf/vSSyqVXtmLZd1D/tktxJWzz54Sb0JL2iRPz4AEAoW1NW94GJQCp
Jb+O2k+FX8v1hFJr957N2OBCwcrpSQU=
=mjc1
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCEEC47089
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 00:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiLCA0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 19:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLCA0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 19:26:38 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3DA8085
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 16:26:37 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 637E05A201;
        Sat,  3 Dec 2022 00:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1670027196;
        bh=ZxpJQrEGmNfLbEVe7qdVq0GxW+p4KoUStuIEPvbhiy4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iT3j5eBruZsjZH3ta4ZxxEJzC01kFBuZ2rBJdqqlRqK5AUr7DDed4cyXJO9QDVIJx
         dtguSqXt0c1gDhIynt68WfqMex6tmK8jZi1GYtMgwn19aqClHpL6T7/NnzY+ccazj2
         8wEcExszez2ukGHLPbedX58spa/kC2/0cta9gUv0+EMMbt16zsD04R5gHIOqra7+GR
         xQ860+L3dWu+ycAyjclBYOyV0eZ6KgXBPh5j5tFQ3D40L04muhv/viOZhVHhPd6+3w
         VJcFWUMOwQVw/XhQT6lbh8hYT7rLhQb1k9qjDIc0jZLjQpY8qM2CqbNLJC+yLWDHH/
         b543d5INTngLALBuFw8P18uSFTR2nefzsq1B+jwzVEBzP2fW/9uaN7k13+r8Khy7CA
         fGAJtRbFlwSGRbtXkyYxqugcCiBW7/3guxfefsIjNiCoTfIURFkhOjRbAZoyJXJFfE
         OHhSjZUpmFjJIyP0I5E/3FmVJgnZGxoyzstVrnkNmBgMd/ugIl0
Date:   Sat, 3 Dec 2022 00:26:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija <doremylover123@gmail.com>
Subject: Re: [PATCH] maintenance: compare output of pthread functions for
 inequality with 0
Message-ID: <Y4qXu5+0jP7+r4yl@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Seija <doremylover123@gmail.com>
References: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
 <221202.86k039fz7x.gmgdl@evledraar.gmail.com>
 <Y4pl5BzQnw0Fm+5S@tapette.crustytoothpaste.net>
 <221202.86y1rpe7ma.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NOKdno1CL8x0+DZc"
Content-Disposition: inline
In-Reply-To: <221202.86y1rpe7ma.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NOKdno1CL8x0+DZc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-02 at 22:46:25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Fri, Dec 02 2022, brian m. carlson wrote:
>=20
> > Yeah, I think we need to do this.  That's because unlike most other
> > functions, the pthread functions _don't_ set errno, and instead return
> > the error value.  That's why on a typical Unix system, we would have
> > never failed before this patch: because errno values are always
> > positive.
>=20
> I was skimming the POSIX docs earlier, which seem to indicate that
> you're not promised anyhting about "errno" being set, just the return
> value.

Technically true.  But POSIX says this:

  The value of errno shall be defined only after a call to a function
  for which it is explicitly stated to be set and until it is changed by
  the next function call or if the application assigns it a value. The
  value of errno should only be examined when it is indicated to be
  valid by a function's return value. Applications shall obtain the
  definition of errno by the inclusion of <errno.h>. No function in this
  volume of POSIX.1-2017 shall set errno to 0. The setting of errno
  after a successful call to a function is unspecified unless the
  description of that function specifies that errno shall not be
  modified.

So literally any function can set it and it is unspecified after a
pthread function call (which doesn't explicitly say it's set).  For
example, sync(2), which has no errors defined, could well set errno,
although its value would be unspecified (but it would not be zero unless
it already was before the call).

However, we don't care there, because POSIX doesn't allow returning
multiple errors (that's not very C), and it won't contain anything
useful.  I should have said instead that they return errors instead of
setting errno to indicate them.

> But at the same time I was reading glibc's pthread implementation, where
> a lot of the time (but not all the time!) you'll also get errno, just as
> an artifact of the library carrying forward an error from an internal
> API which failed while setting errno (e.g. malloc()).

And this is probably part of why POSIX has this policy.  I'm sure this
same thing is true for pretty much every libc.

> In any case, the best thing to do for our codebase is probably:
>=20
> 	if ((errno =3D pthread_create(...)))
>         	die_errno(...);

I agree that's probably fine to do here.  If folks feel setting errno
this way is too icky, we can also just call die with strerror.  I don't
have a strong feeling one way or the other.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--NOKdno1CL8x0+DZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY4qXugAKCRB8DEliiIei
gWa5AQCt1EBpxwGI1Lrrh8iriRqbyMI2+6FY9CUiD+v1ynoUQgD+Id+/sqZz7fuF
gAxR/euiQXeQX/2ubikNq9VAf8Es+Qc=
=U269
-----END PGP SIGNATURE-----

--NOKdno1CL8x0+DZc--

Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F2C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643222070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nnShigfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbgFWPag (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:30:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40116 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732950AbgFWPag (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Jun 2020 11:30:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 98FD160436;
        Tue, 23 Jun 2020 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592926235;
        bh=jxVVsTIUgp0G3FvPRvJ1nhtScTvdEufGeVeg5YNJTJE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nnShigfPvXIZUIPVJCje1aIGJ7lZthmYcnHDHkBxCAhNyxhKjXdYt+jnKaGtzI3gq
         yGs6X935dutEKZpzbCg3kmYT4LLEL5Vo8HBy+iCYDAt0IHsYBikIOFVFGf/UZzNqEM
         70zsBTp9Wh2FE2fd6gL/XIWQ5d7raqfnyuGO9OsmYe2ChIqORiwPEXl9aQieyKbqTX
         Y3TDJxIF66kQsk3mhN1Z1k0k078PKGVwTlemWFx29lxJ4YVuP9kUsXUA/GTGk6HklF
         X8HJ5DO2T3n867Y7b0+HaLTWj6vbF6tQ1ZhHIQaW6ZsIT1qf0C3IAIcfXenyRecpFb
         tRwuQh6AFXwSYbJzVeEIGFoYni2JAUSn+DSGgH72Dlu5hk73grWHy7Z8myjHl6s/gt
         B4vvUP1AVWAcgnUrt94DSbyW2e+IRlMJI4ouczp96Br15h8co3tzF5ksxtUVJ2oTCR
         Z9n4MPuILbPgn+xU985FgQHr+uSAHmUJkN6PgH9qeWxZezqac51
Date:   Tue, 23 Jun 2020 15:30:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Git 2 force commits but Git 1 doesn't
Message-ID: <20200623151951.GS6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
 <20200622210953.GQ6531@camp.crustytoothpaste.net>
 <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
 <20200623010519.GR6531@camp.crustytoothpaste.net>
 <09a7fa54-d7ae-772c-fb36-29dbd27bc626@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RlgFhasKO3bfRJ5j"
Content-Disposition: inline
In-Reply-To: <09a7fa54-d7ae-772c-fb36-29dbd27bc626@web.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RlgFhasKO3bfRJ5j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-23 at 08:59:28, Ren=C3=A9 Scharfe wrote:
> The following patch helps by avoiding a commit flag collision between
> http-push.c and commit-reach.c.  I don't know if it causes other
> collisions, though.

Nice catch.

I don't think it collides with other things because the other things
that overlap are either builtin code (which isn't used in git http-push)
or upload-pack.c, which would already be having problems before this
because it overlaps both before and after (and doesn't appear to be used
in http-push either).  Therefore, I feel confident in saying this
probably doesn't make anything worse.

> How could we possibly check that?  Perhaps by having a commit flag
> register (a global unsigned int) and having functions announce their
> bits in it.  Colliding announcements would BUG().

By my count, we have only 88 individual bits used.  If we moved all of
the builtin functions plus upload-pack (which shouldn't overlap) to a
single range, that would account for 53 bits, which would leave us 35
bits for all the rest of the code.  Since we need at most 27 bits for a
builtin command, if we used a 64-bit integer, we'd have space for all
the remaining bits not to overlap, plus bits for the type and flags
bits.

Since we'd be doing only bit operations on the flags variable, the
performance impact on 32-bit systems would be very minimal, although
we'd allocate an extra 4 bytes for struct object.  I don't know if
that's a problem.

Assuming we don't want to do that right now, may I have your sign-off
for the following code, Ren=C3=A9, so I can add it to a patch along with my
test?

> diff --git a/http-push.c b/http-push.c
> index 822f326599..99adbebdcf 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -70,10 +70,10 @@ enum XML_Status {
>  #define LOCK_REFRESH 30
>=20
>  /* Remember to update object flag allocation in object.h */
> -#define LOCAL    (1u<<16)
> -#define REMOTE   (1u<<17)
> -#define FETCHING (1u<<18)
> -#define PUSHING  (1u<<19)
> +#define LOCAL    (1u<<11)
> +#define REMOTE   (1u<<12)
> +#define FETCHING (1u<<13)
> +#define PUSHING  (1u<<14)
>=20
>  /* We allow "recursive" symbolic refs. Only within reason, though */
>  #define MAXDEPTH 5
> diff --git a/object.h b/object.h
> index b22328b838..a496d2e4e1 100644
> --- a/object.h
> +++ b/object.h
> @@ -67,7 +67,7 @@ struct object_array {
>   * builtin/blame.c:                        12-13
>   * bisect.c:                                        16
>   * bundle.c:                                        16
> - * http-push.c:                                     16-----19
> + * http-push.c:                          11-----14
>   * commit-graph.c:                                15
>   * commit-reach.c:                                  16-----19
>   * sha1-name.c:                                              20
>=20

--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--RlgFhasKO3bfRJ5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvIgFQAKCRB8DEliiIei
gRcGAP9ZVoNPaP7iyX04ahCI9qc1jY5mCX4jvWOBtsTFmJGmaAD/c3NqUz6onME0
2rGoFuSjH6ttPfqkzEuKVt/tgR0Avg8=
=4wLl
-----END PGP SIGNATURE-----

--RlgFhasKO3bfRJ5j--

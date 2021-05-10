Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBFCC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB01061581
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhEJWoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 18:44:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230271AbhEJWoR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 May 2021 18:44:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CADE60749;
        Mon, 10 May 2021 22:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620686561;
        bh=M9j7+eYDvsxbRA2cU9pfBjNjEQNOevNM9d++cO8XAjY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NzdXm86IWYqKJFcuhfYCGiAMdZn1o4zp0jP+qeoSPyTSlIF+G8IX5z8naGh6USMtY
         OAtcckwuOjeoB0sJPctVNWyup1OyF6xz7jttBEiBmBCbrvmfYYcKheSUAvkOUKAoGM
         kgIBUkwJmHgtoZtrgGvCpqijg1ETg8BYC81izkj5xBIplMJ+wPRTh9F0oliMP04ogA
         F/XfRXLbm6mm0+qVvheK98g7HCywt0mG814mDyi8H/qVb3j6lFxxmTZKreOzlmYCxo
         ZPzVE1I7XrZNMyg5CtIf6HA20tgVytkdqo6sRl6u0QQrJBQven30o5g0GXifp9jrz4
         zY9AJUyD42yavfLIoK27rOZC+GJca2o6zYNywcJ16CbfGd1L4ZeUyGtjqmLrqEx4CD
         mijgHok/AUOy69E9mXAdQ2WMGkKPhKabIFQGxU7XED+5F/2pzCfNfUQMuux3gwyEmG
         k+ubvIcOAtt1/vENaYB48LUAAwIA99x9DfeIC+pab+OMXgFpadn
Date:   Mon, 10 May 2021 22:42:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QIrZzv3WbGT+3KkE"
Content-Disposition: inline
In-Reply-To: <87lf8mu642.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QIrZzv3WbGT+3KkE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-10 at 12:22:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, May 09 2021, brian m. carlson wrote:
> > You can't do that.  SHA-256 repositories already exist and that would
> > break compatibility.
>=20
> From memory this is at least the second time you've brought up this
> point on-list.
>=20
> My feeling is that almost nobody's using sha256 currently, and we have a
> very prominent ALL CAPS warning saying the format is experimental and
> may change, see ff233d8dda1 (Documentation: mark
> `--object-format=3Dsha256` as experimental, 2020-08-16).

Yes, I agreed to such text because others thought it was a good idea in
case we needed to make a change.  However, we don't need to make an
incompatible change here, so we should avoid that if possible.

Almost nobody is using it because the main forges don't yet support it,
because it's going to be just as much work to support it there as it has
been in Git.  We won't be making it easier by making deliberately
incompatible changes when we don't have to.

> I agree with the docs as they stand, and don't think we should hold back
> on changing the object format for sha256 in general if there's a
> compelling reason to do so.

I am using it and I know of other people who are using it.  There are
people whose companies cannot use SHA-1 for compliance reasons and are
already making use of it.

The problem here is a chicken and egg: nobody's going to use SHA-256
support if it's experimental and their entire repo might end up totally
useless, and it's not going to become stable if nobody uses it.

> But it seems to me that if the main person pushing the sha256 effort
> disagrees with the content of
> Documentation/object-format-disclaimer.txt, we'd be better off at this
> point discussing a patch to change the wording there to something to the
> effect that we consider the format set in stone at this point.

I've been pretty clear up front that I thought the data was stable and
we should avoid making incompatible changes.  It may be that it is still
experimental and may change incompatibly, but if we can avoid that
problem, we should.

I don't personally intend to send a patch removing the note about it
being experimental until I've finished getting object interop done,
since that's the major issue where we might need to make an incompatible
change, but that work is moving slowly.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--QIrZzv3WbGT+3KkE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJm23AAKCRB8DEliiIei
gY88AP40+ny8NHs/MW720E/6aeUwlJn1ucviZ1h1Rgm0GZmOWwD/a+YK9XNp9jlF
hQFxBPSU3rOCWaU/mcl0O638ucfNtgA=
=t5vj
-----END PGP SIGNATURE-----

--QIrZzv3WbGT+3KkE--

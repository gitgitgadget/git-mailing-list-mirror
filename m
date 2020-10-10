Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209EC433DF
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 01:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DCA2222F
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 01:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgJJBl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 21:41:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729330AbgJJBL1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Oct 2020 21:11:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 65FEF6046C;
        Sat, 10 Oct 2020 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602292254;
        bh=pSUgJkK6t2ZCY4xc9qCvSqtnrL7goLEoJ+L2SxTOkg4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Uv/u7+NmxeeWkBHrcGT+mS1scB7tBHH7NuFDW4e8YNBCDwUubBZRCF4CZIOPoV7tu
         sXzsRfZdQsj0f8lg5ILR8CBFmReOkVuvITPjmfZt3OxQeO3JpvgRDZKZaq7vuf4ImZ
         4PwS922gVf8/drpo7JOnLUU6OPOhb7CH1UR6ga/bbiI8MZHDpV9Xn/gBYyZ2ZZQHAL
         o+aHre1Al0+wupbtwLcoF0EfxRw075aGyEt/th3D+g0i0jStVqoSLthsMBMLNwJhkZ
         VR04Xz8IhRuSzhM6N2Eb59UnQrV8/egosugdUHBLVtb10v6NUA6uKcpubrlucOpUIi
         zBb1NQFJ+OXgMw87ltnZrb/tV6DAAF+yPqt4u5t9cV/Luzs2Iq9tywSi1I3KZfK8EZ
         g0Sf9xqPm7FCDllLomDJ5UBxW5T+S+2NmuxIRPx+FkC8XrkZ+GUdmYJ8swEu0Sl5X4
         fdWt8b1h4RyDye6iykXgjgphKk1vdFD+DR9GY6aXC/lm+mugjI3
Date:   Sat, 10 Oct 2020 01:10:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] abspath: add a function to resolve paths with
 missing components
Message-ID: <20201010011048.GQ1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
 <20201009191511.267461-2-sandals@crustytoothpaste.net>
 <xmqqk0vzrtqr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zn4k3Q+N5puqXur4"
Content-Disposition: inline
In-Reply-To: <xmqqk0vzrtqr.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zn4k3Q+N5puqXur4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-09 at 21:10:04, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > We'd like to canonicalize paths such that we can preserve any number of
> > trailing components that may be missing.
>=20
> Sorry, but at least to me, the above gives no clue what kind of
> operation is desired to be done on paths.  How would one preserve
> what does not exist (i.e. are missing)?
>=20
> Do you mean some leading components in a path point at existing
> directories and after some point a component names a directory
> that does not exist, so everything after that does not yet exist
> until you "mkdir -p" them?
>=20
> I guess my confusion comes primarily from the fuzziness of the verb
> "canonicalize" in the sentence.  We want to handle a/b/../c/d and
> there are various combinations of missng and existing directories,
> e.g. a/b may not exist or a/b may but a/c may not, etc.  Is that
> what is going on?  Makes me wonder if it makes sense to canonicalize
> a/b/../c/d into a/c/d when a/b does not exist in the first place,
> though.

The behavior that I'm proposing is the realpath -m behavior.  If the
path we're canonicalizing doesn't exist, we find the closest parent that
does exist, canonicalize it (=C3=A0 la realpath(3)), and then append the
components that don't exist to the canonicalized portion.

> > Let's add a function to do
> > that that calls strbuf_realpath to find the canonical path for the
> > portion we do have and then append the missing part.  We adjust
> > strip_last_component to return us the component it has stripped and use
> > that to help us accumulate the missing part.
>=20
> OK, so if we have a/b/c/d and know a/b/c/d does not exist on the
> filesystem, we start by splitting it to a/b/c and d, see if a/b/c
> exists, and if not, do the same recursively to a/b/c to split it
> into a/b and c, and prefix the latter to 'd' that we split earlier
> (i.e. now we have a/b and c/d), until we have an existing directory
> on the first half?

Correct.

> > +/*
> > + * Like strbuf_realpath, but trailing components which do not exist ar=
e copied
> > + * through.
> > + */
> > +char *strbuf_realpath_missing(struct strbuf *resolved, const char *pat=
h)
> > +{
> > +	struct strbuf remaining =3D STRBUF_INIT;
> > +	struct strbuf trailing =3D STRBUF_INIT;
> > +	struct strbuf component =3D STRBUF_INIT;
> > +
> > +	strbuf_addstr(&remaining, path);
> > +
> > +	while (remaining.len) {
> > +		if (strbuf_realpath(resolved, remaining.buf, 0)) {
> > +			strbuf_addbuf(resolved, &trailing);
> > +
> > +			strbuf_release(&component);
> > +			strbuf_release(&remaining);
> > +			strbuf_release(&trailing);
> > +
> > +			return resolved->buf;
> > +		}
> > +		strip_last_component(&remaining, &component);
> > +		strbuf_insertstr(&trailing, 0, "/");
> > +		strbuf_insertstr(&trailing, 1, component.buf);
>=20
> I may be utterly confused, but is this where
>=20
>     - we started with a/b/c/d, pushed 'd' into trailing and decided
>       to redo with a/b/c
>=20
>     - now we split the a/b/c into a/b and c, and adjusting what is
>       in trailing from 'd' to 'c/d'
>=20
> happens place?  It's a bit sad that we need to repeatedly use
> insertstr to prepend in front, instead of appending.

Yes, that's true.  It really isn't avoidable, though, with the functions
the way that they are.  We can't use the original path and keep track of
the offset because it may contain multiple path separators and we don't
want to include those in the path.
--=20
brian m. carlson: Houston, Texas, US

--zn4k3Q+N5puqXur4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX4EKFwAKCRB8DEliiIei
gaDLAP9vv5puY4jSe7evglnh92hLzCe+ftMcUmxfSRDhVC2cXAEAjslLXUhcUGfo
DU6c+DIy/JRF5JvDlWc3zoT0w9GNowA=
=9jpM
-----END PGP SIGNATURE-----

--zn4k3Q+N5puqXur4--

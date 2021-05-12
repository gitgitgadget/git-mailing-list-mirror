Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93309C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EB36192A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELAwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:52:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52404 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhELAwR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 20:52:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A568760749;
        Wed, 12 May 2021 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620780670;
        bh=8wK9XmT+DzpFXz1nzZeQWuhDlow/HKEhjxuQKF2Xb60=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rtHUGzdq5K3IUhuKuy29/5Q/DdRKKxAsQ+ccZw6J3qiywq7c88FQDT6whkc0giRKy
         aX9qbbM0haJui5z2gMULl/SjyUHiMDYCJqKuRG8jnRHtjGFmdHXVj4+IoPGzcYHfe8
         5q+tkcOf4bA2rLlSa+J6LwFs2a97b1h+vL+yo3D+lT19VbFBooZnnWjNQ/JVfoCTrK
         Q3naJOadI5qIP6yQKMQ3L1CnFgl5PkQvRlPuLPYscdTc7CTLyCH1AW2WvYGH1COdx4
         ZiYx0ItdZw8sM9VHOfqiojWTfNQsesko8xtKgLsO0Sznod3ucO6z7xJCxxxLcFgR1U
         I3bTKuXXjda2AQI5g/8K44N28fkQhPInzXjDgewmgzn6/UXSMdAODO56kmcbU6kgDB
         iBrSV091IQnjrCGjG+gqZIPtGaY3Yk3eTXkoaCRSrfa8VUOFK6k1ltbMYRZzSdShpV
         MVguDs2HP6rCGKeG1wvyhSnO+DxxP/FWex1LFpumT9OVpD0gkMe
Date:   Wed, 12 May 2021 00:51:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJsmeOjxd5VIbjoM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Gregory Anders <greg@gpanders.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20210511204044.69047-1-greg@gpanders.com>
 <20210511234935.65147-1-greg@gpanders.com>
 <YJsas0d4XPsYYpI7@camp.crustytoothpaste.net>
 <YJsi1jbtNFDRKXmq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E33SAlTcEP5/RzcL"
Content-Disposition: inline
In-Reply-To: <YJsi1jbtNFDRKXmq@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--E33SAlTcEP5/RzcL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-12 at 00:35:34, Jeff King wrote:
> On Wed, May 12, 2021 at 12:00:51AM +0000, brian m. carlson wrote:
>=20
> > > +	specify a sendmail-like program instead, either by a full
> > > +	path-name or by prefixing the program name with `!`.  The
> > > +	program must support the `-i` option.  Default value can be
> > > +	specified by the `sendemail.smtpServer` configuration option;
> > > +	the built-in default is to search for `sendmail` in `/usr/sbin`,
> > > +	`/usr/lib` and $PATH if such program is available, falling back
> > > +	to `localhost` otherwise.
> >=20
> > Elsewhere we use the ! syntax we invoke the shell, and I would suggest
> > that we do the same here.  That means we'll get PATH functionality by
> > default and we'll let people do a modicum of scripting if they like.
>=20
> Thanks for bringing that up. I agree it makes things more consistent
> with other uses of "!", and certainly it's more flexible. It does
> introduce an inconsistency with the absolute-path form, as I mentioned
> in https://lore.kernel.org/git/YJsiKDNbKclFU00b@coredump.intra.peff.net/.
>=20
> I don't know if that's a show-stopper or not. Certainly the
> documentation can explain the difference, but it's nice to keep the
> rules as simple as possible.

I think the minor incompatibility here is okay.  It would have been
nicer to be able to avoid it, but hindsight is always 20/20.

> (My gut feeling is that consistency with other "!" places is more
> important than consistency with the absolute-path form).

Yeah, I think the shell here can be very useful, because it lets you
configure something once in .gitconfig and handle system
incompatibilities (a purely hypothetical example):

  !f() { if [ "$(uname -s)" =3D Darwin ]; then sendmail "$@"; else postfix =
"$@"; fi; };f

People use this functionality all the time in other places: credential
helpers, editors (use a fancy graphical editor if supported, otherwise
Vim), and various other places we allow this syntax.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--E33SAlTcEP5/RzcL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJsmdwAKCRB8DEliiIei
gYPqAQDE+PKTNKF3jiUymwVPUNUP6NLLU4B/RDxhPr4ISBCOWgEAukLr1j1uRbVh
R8MPQMgorpoQ4+bZ5GkNIsMFTB6jTgQ=
=HMz+
-----END PGP SIGNATURE-----

--E33SAlTcEP5/RzcL--

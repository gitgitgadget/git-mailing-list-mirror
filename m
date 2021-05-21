Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA001C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E1361176
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEUW3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:29:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47398 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229638AbhEUW3H (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 May 2021 18:29:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D38226043F;
        Fri, 21 May 2021 22:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621636033;
        bh=Cuz4tBy56m58uyG5jKq4gzMP8CieiuxkRaystnw3Pbs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RhX1je3P1sF/MTjtDWwiV2VNsqZbnlzRsJo8jXV60zCqpGq53MQcTBdr/l3B4FeD9
         VStTRMK3s/wYStbum2E9LhHkOh6rEBOk36hyrEpoTaWMdBjLFl/yk4XKB6/b6XDo67
         7Y2RWkvnPy6k0gk1PZBEqJmmJPeuLIPbEC2jmMK9yyAgj5EI/2idU1Yqg892jnG/mP
         GhbqREyBx+9K26pZ43DhvySmzaG8r4513rLJ11RNKvcDsBFNOqhMx2pQSJvNA/CS2f
         U9+x6gWklaH/xFqwz7Fn9mh8IDA3IHfJT46W3zLUOc+mXpY/OavZ2TEL8STFTI+IF0
         y5H9xfb/MEr+ZHrzpTk25RsbjkOIO4IFMuGv4F6mW8QRTeWzE1oM93thCQAxhIQiox
         +U97LkMOr7k2ymPnobTgLX2J6NWh4iTOViHI2ifjAPBQceg/sOJXEiNi2oD6KDQTzt
         coRRCOn3RKwkyaf8hRFcjUAthjIQoIt9Y5YGAsA7TpIxz1Js90Z
Date:   Fri, 21 May 2021 22:27:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not
 available in `exec-path`
Message-ID: <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Siavash <siavash.askari.nasr@gmail.com>,
        git@vger.kernel.org
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6RbVOcX+tYfy8ZyV"
Content-Disposition: inline
In-Reply-To: <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6RbVOcX+tYfy8ZyV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-21 at 10:04:53, Jeff King wrote:
> On Fri, May 21, 2021 at 01:55:32AM +0000, brian m. carlson wrote:
> > Things in contrib are not built by default because they don't
> > necessarily work everywhere.  For example, the osxkeychain credential
> > helper won't compile on Linux because the requisite shared libraries
> > are specific to macOS.  You'll need to compile them manually and install
> > them in a suitable location.
>=20
> I agree with this, but just following up with a bit of a devil's
> advocate: why not put osxkeychain into a regular "make install", but
> make it conditional via a Makefile knob, like we do for other
> platform-specific features?

Sure, let's do it.

For osxkeychain, it's probably pretty simple to always build it, since
macOS will always have the appropriate libraries if the compiler is
installed.  I would be in favor of also building by default on Linux and
having a Makefile knob to disable that, since the requisite libraries are
a part of nearly every distribution and doing so will spur distros to
ship it, which many do not.

> And yet, my impression is that basically every Git user on macOS is
> using it every day, because both Apple Git and homebrew build it by
> default (and I think at least in the case of Apple Git, it's hard-coded
> into the config). A little scary, but nobody seems to have complained. :)
>=20
> I wonder if we could build it and run it through t0303 as part of the
> mac CI process (though I recall at the time that it was really finicky
> for automated testing; it wouldn't even run over an ssh session).
>=20
> Likewise, we probably could be building and testing the libsecret ones
> via the Linux CI job (I don't use those either myself, but presumably
> they pass t0303).

Running the tests will be harder.  macOS, I believe, requires an
interactive session to have the keychain unlocked, and on Linux, you
require gnome-keyring or an equivalent daemon running, which practically
means that you need a desktop session.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--6RbVOcX+tYfy8ZyV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKgzuwAKCRB8DEliiIei
gQB5AQDaFN9AD5UWqkxlYk9yx1ps+uXwpsboKbPefRHFGUa8YAEAkFsCSp/dL9i+
N2jplbOUKGG9+9XLqHjUVYlNywWXago=
=/jIp
-----END PGP SIGNATURE-----

--6RbVOcX+tYfy8ZyV--

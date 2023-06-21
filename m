Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992CAEB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjFUKKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjFUKKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:10:18 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3191BEE
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:09:18 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 082C95A215;
        Wed, 21 Jun 2023 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687342157;
        bh=icdjoipnHg//O83wVSroz9TBvupMBW4fi5mQlYDwdUM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PGJPVGq82Img9V0SX0/Uuwh1imSOMc6ZaJGJ63O9/uO5rnbRFbCQHZBTOeEDOAtxq
         KcPp3PuYtvzj5PZAnuUVorhMhn3JYv4pNChXYASTSte8UEbTLx3IlXxiP464NtPya4
         NoqNx8/00H9POs8dB1Sm1+UYmXyExEFfdWW+aU68RKEWTnF/Jzk4TGlUlhSt7AYU3x
         KvHMJcc4hjHCLtLpfLHGz4kVEwq5sx7vTBt16Rk7RrD7gdWrqRjGDfVox1sxiN22IH
         R1MVr1C7ol3NuVzs6NhdFZRjMPpg1yBFeLZz9pY2NjnNJfm9IzeZCRcI9/ghBCE6BX
         LDfTI7aIr3kQjlU9eJDzxEX7ZVGctMEu3Q+OAfyj+3k+Sgm0K6fBtjnUfnCECiE+cQ
         m78c8pjwzKD3rTn4s7v9ZzlY60mLx0dy+c+RcjtOgbp3XqvPmeP/HDl0Pz7/q340qF
         UmggEdnKmampU/kMQNHmcG3r9gzWGI56SP76fj8J6TTr/P6kEci
Date:   Wed, 21 Jun 2023 10:09:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: Remembering which http remotes require authentication
Message-ID: <ZJLMSz6jp+rBwhTA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CAGJzqsnkH_dtv-CGsSFJ8K0kXKBf1+QQqy=MEw-Vq9XaEqr=AQ@mail.gmail.com>
 <ZIeMcyloOiyAJ8ak@tapette.crustytoothpaste.net>
 <CAGJzqsnMnJqed8ztiCAS9oDXNMmT73=8caXXsDKeYmxevsQMjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wm9KDGHHmIzhWxS6"
Content-Disposition: inline
In-Reply-To: <CAGJzqsnMnJqed8ztiCAS9oDXNMmT73=8caXXsDKeYmxevsQMjg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wm9KDGHHmIzhWxS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-21 at 06:30:33, M Hickford wrote:
> On Mon, 12 Jun 2023 at 22:22, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > What I would rather see instead is a way to indicate to Git that it
> > should always authenticate via a config option (probably something like
> > `http.*.alwaysAuth`).  I think this would work for your use case, but it
> > would also work for things like giving authenticated users higher rate
> > limits for public repositories.
>=20
> Interesting. Do you know any such hosts that rate limit unauthenticated
> users? Do their users prefer SSH which always authenticates?

At GitHub, we do this with the API, and because Git LFS uses Git's
credentials and is technically implemented as part of the API, it
applies there as well.  I don't know that we have any intention of doing
it for Git operations themselves, but the reason we typically prefer
authentication is that if there's a problem, it's much easier and a
better experience to contact user XYZ and ask them to be more gentle
than to block their IP.

This is particularly useful for internal users at GitHub (like the
automatic dependency updating service, Dependabot), where we'd like to
account for who's performing lots of operations in terms of rate
limiting, and the alternative is that people use http.extraHeader or a
token in the URL, neither of which we want to encourage.  I'd much
rather rate-limit an internal service which is using too many resources
than impact unrelated users, but if they're all anonymous, that's hard.

> > I intend to add this feature at some point relatively soon, but I need
> > to sneak in a feature first to specify the authentication scheme as part
> > of the credential protocol, since we won't have it as part of the HTTP
> > 401 response.
>=20
> Would it suffice to ask the user to specify the authentication scheme
> in the configuration? eg. `http.alwaysAuth=3Dbasic` or
> `http.alwaysAuth=3Ddigest`

That will probably work for most cases, but we may need to allow either
a scheme or a full WWW-Authenticate header, since in some cases there
may be parameters that are needed.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wm9KDGHHmIzhWxS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJLMSwAKCRB8DEliiIei
gX8TAP0VtiRcj2G26yGF752IJSwsX5JKZx+HbNZPld1kpZ5sHQEAoJ6VgEOdjUle
jmjAdc43IoFqIPhtaX2NXiVgPP8l3AA=
=j8Ss
-----END PGP SIGNATURE-----

--wm9KDGHHmIzhWxS6--

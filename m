Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE35C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5D72082F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ovrc3Rsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBOAOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:14:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33012 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbgBOAOD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 19:14:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 186DA6048E;
        Sat, 15 Feb 2020 00:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581725642;
        bh=DsXdgeol+uP27TAjnKartXWZqMlw3zIYwtfVvnwX1NQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ovrc3RspUtKqjfWiU0AnBMX/D13+n3Wfw86xU8aZRN9Vd578qi3GiRGBqhRYVK6lM
         Zzkc7XJiSrzpc7CCwug4xrMnmHdhNi9FTaW/aZ3DzurRaGWR4NhiTaWovhycCbBIpt
         2LO5DA/9JXsNFxS6L2vrxAvzQnecSxMvWWwKWFwM7YP7MDtz3/n2ySG57vZs70lxUY
         AuZdi2rKltjF/fHHLybCSi6gHIorfQPST2vOvK46PHpE9L2H2aMQpOxmuptW4nGa8m
         XKDlyDPT+MzXws+zKWTEB8cqQAjwUBaZJxe3ulclUfg/rStPi+oGQvoBTZr2o2qn/k
         p+drwh9neNNzjojPrF4JgHum7OI9+wzqOS+9L2Ux+suWpggStTP3UmCJtdQfMKdTgS
         hdH+wYFwdy6fThnkoGlMmDD1pb1TqAakziL7GA6d/uqK48jn6ZDtuEqsbfqUn1OIYa
         F0v4jpms7HTEc+jV6mGwv3mALI0AKCwH+z4TWYAuwo+HVve/KCg
Date:   Sat, 15 Feb 2020 00:13:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Wildcard matching for credentials
Message-ID: <20200215001357.GB6134@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <20200214225929.541306-1-sandals@crustytoothpaste.net>
 <20200214235822.GA11400@syl.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20200214235822.GA11400@syl.local>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-14 at 23:58:22, Taylor Blau wrote:
> Hi brian,
>=20
> On Fri, Feb 14, 2020 at 10:59:26PM +0000, brian m. carlson wrote:
> > This series introduces wildcard matching (that is, urlmatch support) for
> > credential config options, just like for the http options.  This is
> > helpful in corporate environments where custom credentials should be
> > used across a wide variety of subdomains.
> >
> > In addition, there's an additional test for urlmatch behavior with
> > multiple subdomains and a mailmap update for the email address used in
> > this series.
>=20
> I can imagine that this is perhaps for Git LFS, which I could see
> benefiting from this change. My review has nothing to do with my
> affiliation (or lack thereof) to LFS.

It was originally prompted by a discussion that someone started on the
Git LFS issue tracker, yes.  I pointed out that it's actually Git that
controls credential helper matching and so I sent a patch.

I've also worked somewhere with multiple internal Git servers, so I can
imagine this would also be valuable in such an environment.

> I gave your patches a review, and they all look quite good to me. Thanks
> especially for 2/3, which I would have suggested were it not already
> there ;-).

I think there was some discussion on the list about whether allowing
multiple wildcards and wildcards in any part of the domain name was
intentional or not, and it was decided that it was.  I promised to
follow up with a patch to the testsuite, and here I am, some time later.

> This looks good to me, so please have my:
>=20
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5HN8UACgkQv1NdgR9S
9otp1g//VYjhGbC8+ymskw/E7IEBahbq+n3CCwT9dBCvk/b7L7sGhSDX8BaalVZX
tRKpL4OZdfZatsoC7ksB0RHKamhaxZWvj3w5SYHDd9bw+Kdm9hvREOJXIuGFntQV
/WBcCnZ3g2yczLDNMVaIu3RNeWF9QnqqYAFtZRRlr6snAfYkiEpILp+FWIIAROvQ
vblEI7hVq78NVnMhqtGP4+hOvfXhcWd9eAX2ZLZItpn1/FiwdtyHoixsIHxNZndn
5Y4OPQOxZbRArrPYAKi9kc0jL0sS7EisPlP7wE/Mab+Nod50qAqK5I22vvZMDhaq
IX1pLOwAKsw4iwq5y2zPyuhadXZX5yvEhxsq3UxYBLDfAEiTzYqtnKnw/rkUxav7
yrxVnTxfXaNqbjbepZN7j2NoKQD0FUQXKZOGIkv0DNKO3fo2r2A6uDQuLxM8Jxxj
94/9bvgsBcRohSAFjjok7IFvxxlWYC/DHqcAcOatB2hP1YK+HhxbXOHgAM7xXNC0
i0WahmnGZ4cxaaH/YGMVwL4gBnwpB0MeHVSd9cn8JO7cAwLGxsLcaFOjoQwc0yXu
e9xsCvmJffRd4Qr8a4jwr0OYN9kwdr0qraZU0ek7T0+vRAun7ghFfeOrQt2mBZnX
LT09LihhFXQjptLh6wktAliEV2w6zRp4xSZi1cs/XzecKUgxLKg=
=aW24
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C6C2D0EB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 10:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DAF205ED
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 10:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ph5YI6Da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgC3KqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:46:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729290AbgC3KqN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 06:46:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 740DE6077B;
        Mon, 30 Mar 2020 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585565171;
        bh=gWKeDUwerHyeiDjegmBWYzn6gzKBSgvkau5DKAIAA14=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ph5YI6DaD1L3xVDOjm0GOlVoQZHGLvjxZ74H3leMLfBl/qVXctPPutVggyaKJVS73
         z4n5UdTf0y+HyN+NuXlvnV+Dlv5kvaz5kNcjQ0I2okDyETILVDCQes+RQU05zvI86b
         az14faxCpxGFwnS8w4iy925616JBDNYxStZ6EJF5Ku3+JBKjUF8DZ6igpZguGx7+yq
         T1V8mOM2pEFn4ChV2ure9/lIkKz6l2z9aZUTL5Lmwta3Nl03Uaw95VtLhtKk/7N96w
         JFzD+zZLswraihE0Y/gGTCwBzb1orngNi/2BCcsUSNZLhCdDhXIv7ofONtWlY80pZg
         lGLHMaIYplokEtWuwfbAXrnmquUuAdiRrYfFiZIPWIE/Dr3i3L0EwZidAeg3atmnb8
         5Py+jm0xflZIwgFraA4tIuWW3br2KkpaGon+aHdcyur1Z1C+wpajO1LGu4mVxNZWqF
         FkpYNP3BLVyWcOWZi26abH/6vXhUOG/EoDKi1eI1NrCtB70BEBL
Date:   Mon, 30 Mar 2020 10:46:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
Message-ID: <20200330104605.GA6595@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <cover.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-29 at 13:18:04, Martin =C3=85gren wrote:
> In the documentation Makefile and a few helper conf and xsl files, we
> carry various workarounds to make the docs build at all or to look
> better with older docbook-xsl versions. Let's see if we can't just drop
> that support. All of this seems to have been useful at one point, but I
> doubt that anyone needs this nowadays. This was also suggested in [1].
>=20
> The final commit in this series bumps the minimum required version of
> docbook-xsl to 1.74.0, which is from June 2008. The whole series should
> be a no-op unless you're on an older release than that. That said, I've
> only tested this with the version that comes with my OS, 1.79.1.
>=20
> After this series, user-manual.conf still refers to older docbook-xsl
> versions. The proper fix there might be to actually be a bit more
> aggressive and drop that hunk, making the rendered docs prettier.
> There's some history there, including mentions of texinfo, which is
> outside my comfort zone. I've got work in progress there, but I'd rather
> submit that separately from these "expected no-op" patches.

This seems sane to me and I'm all for dropping support for a
twelve-year-old version of the DocBook XSL stylesheets.  On the odd
chance that someone did need to download a newer version, this is a
dependency that's easy to set up and build.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXoHN7QAKCRB8DEliiIei
gavUAQDt+vMXbXnsc/rToT7zS+JWzv+vJ/mhDUCH1KvlwujkfwEAzYUQuDeKCjB5
UWL8Bk+SNnvt+G6rtd006/lVDJIvpQ4=
=Knma
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

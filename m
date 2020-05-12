Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C8CC2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B237020747
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WXpFSxL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgELXNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:13:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38060 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728220AbgELXNh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 19:13:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB38B60427;
        Tue, 12 May 2020 23:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589325216;
        bh=Sg14o08fQH9d7LZ94Rd+yENVD1qMkbBmp34y90H9vnU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WXpFSxL09ZVIq7+uclttXXcfkxANUAEUEYFB+AbfYXhH+ekw5cdAdDYNRmp7xd5No
         XJnb4ByVTmdpgpwIMs6vFVysK9PVE+XP4g4Om8ZP7okzKZvKxjjrhQjmuBlJIUAtIh
         h391P6RZRMPRhcFe9VrT0gtZU3suR8AfcxYS97BC7VTUlhnrKPOPoh/MD+F/49dgRK
         uuGf/sWrQ9CwRwguYClWBYCgq4t25GEKGZt22wcl2IVzXgxaSMyD+IIsDVLCUaSWyX
         rq2UQYtCv7j42vQKfHtZAlZwnYF+kFqkjGp2yFwo81NxM1zh0FG886j1IPrBq+xrhd
         +qYNax7lur8W7jW2KLNGjBB/3S/QDxMkX6BNzInY2dB1JwKYzU20+gsrsizb6k7MXq
         flz+x2IhFNlCO84uXTEiI/Tp7iFk8wKfvwLyJKXCbE3M75T1O4OPW5NP248Deb+1mF
         W5wWT4MIqmerz5Ro7nO1eS60WMXDqPdJHG/9FIOnMS/qoIA1Hx2
Date:   Tue, 12 May 2020 23:13:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
Message-ID: <20200512231331.GA6605@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1589218693.git.jonathantanmy@google.com>
 <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-11 at 17:43:10, Jonathan Tan wrote:
> Whenever GIT_CURL_VERBOSE is set, teach Git to behave as if
> GIT_TRACE_CURL=3D1 and GIT_TRACE_CURL_NO_DATA=3D1 is set, instead of sett=
ing
> CURLOPT_VERBOSE.
>=20
> This is to prevent inadvertent revelation of sensitive data. In
> particular, GIT_CURL_VERBOSE redacts neither the "Authorization" header
> nor any cookies specified by GIT_REDACT_COOKIES.

I actually use GIT_CURL_VERBOSE to debug authentication problems from
time to time, so I'd like to keep an option to produce full, unredacted
output.  Since everyone uses HTTPS, it's not possible to perform this
debugging using a tool like Wireshark unless you use a MITM CA cert,
which seems excessive.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrstmwAKCRB8DEliiIei
gRfpAP9nISaoCmEBqYj6jz0DmID9n+VWBPT8L8zZyak5WAtVEAD9Gf7t6lWDNlz9
bLB27ZLFAAnBiHKX4g1qadWvzq5/Wwc=
=+TVe
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

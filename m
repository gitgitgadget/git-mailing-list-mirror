Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E601F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbeH2ECR (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:02:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37132 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbeH2ECR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:02:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2D68A6046C;
        Wed, 29 Aug 2018 00:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535501291;
        bh=cxewVB87zRECDYYXV3CjcE2E0DGHRrx6dnOn/mMXxpg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jTE4FjGTBTWnLO69bz1ovk1Chwlch9lkSeVfYS52O55uNaagGYtwmrU1iLT1+mNRv
         NoN3oMw5VAaDVVZwzcUI6k+GJWGcJ9KUSsGhC/OI535T5wzZa62Ic4tf76xHRpzmnK
         6MowSzxjz0JYxkAEXszMTDqqcR9EUpFMz11mjgNwUNBEwsTeOUkrFAB3iBNTvBylWb
         fSJ5ATaZkmgnWEShbjBCsrRcL/wP8YcxiE1j/tPrHpvrVTbpp949o4pQT/z0k3QRRp
         QcvDt6e5U0HFbNdVl+4L6pA1AJ/r5LYaPXxeG4wIHL+pze1VPS7pMSlXL1ihShcLxw
         ilSIb7/8MKcN4DOn3EQeBTye9wM6noFejWBS/uc9UUTQcUmbFh2SctquGxXMqGrjf0
         nuUAU5UVlHQhqQ+dGwKnB9pCo+hTkxSd4d6jqIMMqEVT/asC0fDDkjwd7+O2mJr1Jk
         U0knAmT06e4Axa2Q2lcoIbZyPgy5Uiir+TGbGv8orXlGPhWbKEE
Date:   Wed, 29 Aug 2018 00:08:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/9] introducing oideq()
Message-ID: <20180829000806.GC432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180826205620.GC873448@genre.crustytoothpaste.net>
 <20180828212126.GA7039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 05:21:27PM -0400, Jeff King wrote:
> On Sun, Aug 26, 2018 at 08:56:21PM +0000, brian m. carlson wrote:
> > I would quite like to see this series picked up for v2.20.  If we want
> > to minimize performance regressions with the SHA-256 work, I think it's
> > important.
>=20
> Thanks. One of the things I was worried about was causing unnecessary
> conflicts with existing topics, including your work. But if everybody is
> on board, I'd be happy to see this go in early in the next release cycle
> (the longer we wait, the more annoying conflicts Junio has to resolve).

I can send out work that doesn't conflict with this while it makes its
way to master.  There are a lot of test fixes that can go in in the mean
time.

I will be sending out a series that actually implements SHA-256 as an
RFC soon, but I don't think there will be any conflicts (and it will
just be an RFC anyway).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluF4+UACgkQv1NdgR9S
9otozhAAuMRADILecbUzhBXd7pOEzlhApPieBHDCkehLwVuXT95LDPI2x3dLDG4V
EcRPrVH/nYHhU+1tXb/i2NsotEb1qyZv26k5YUjC3LDlMX+cNmodnb2//n+dyV94
+jG/wkls8MDKXth+LkNiaAyZnBbftCT3z2dacwgRg2It5Z8n9Ijqn8DkwY3pFm6K
1sWMyOkXCOXJCM9HEcuuVYPmnHh/zTbbk22bhwbAqdDIt5+ftc/lUvdozHsQoYhA
HEc8zBCGGsg0qP9TGmUPW5gQGTuqh/AHYN+SjxVCPMC9xvX3pb4l0jFY/+O7jRiV
QqWmsHsHkz7jBrm8V+jjfRtMLYAcLeVDDLurnX9kmLzoAigYt8tKsLLcl7piGopQ
QyPm9W6dGnry9FLGusw5glcxK5mqaA7DHyyewnd/JKBrXmnf25z8meU4Mzutzygo
EpAsREmAIpUfHXu3pDZbXP8Cbbp1PRyNILCuV0T/QWi7ykarpWBz9rKGnyY6M/Kr
dPAa+VMOvDLmb3F/RT83U6Hmprr1Y/oNT6CB6RaYLnzVGKQOGgwSN/jeFHnsi1pM
J1TgYNJ8apmivz+Esaxx+v+zQATEivUeF3UT4xjxqfj5VnsUe44xxRTdXwVxRVnM
XjPxmRvQ6HQbW+N8Wrw8lUwo5xL4mKH/CkJ1W4MM543m3vgiRFg=
=1b5d
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--

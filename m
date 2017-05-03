Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39927207F8
	for <e@80x24.org>; Wed,  3 May 2017 23:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbdECXl2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 19:41:28 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36854 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752476AbdECXl0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 May 2017 19:41:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 51E21280AD;
        Wed,  3 May 2017 23:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493854885;
        bh=Jl7TvCwwt4Hlo0brWt1c75zDtHJjIAc4CXE1YeBoxXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFkiEnEkFVQO22Dyxk/9/Gco6o+AIpoHW3JOX2ypGsgS6495jRbZcskhhax7wKcS3
         pgtVc8stm/FspTo5Jj64JYasfJ4yCfpT2ao25nXRNN1Yi6DfQprO/Uu/9MHe3TET0p
         Txlo2jmVhLxdDnKnQ1swPIQotJgDEGNS/JG2INu1CfWQQYFFaazbMXRs1VZStf7Hnt
         5qxylMy3/D1vwUW9Oi5ZQ0mMdPLH36GHO4xhQptT+fjnlfzDvXYnuvsM7RFlCS8Nlm
         12o+NJ17HWuRjV+DaMC2bxlERV/fJOvEdqJkc/dvywHbc+Yt8ni4UoTfQzh9BAzDZC
         ng0wcRkCaZHDOSqrcuzzIYEpHgavXD4R9tC/oyyIIQ1KQ01304ayS2GllOmwOrKAhS
         w26nwdXHkCoWBELZt0MRsSoMpgwcHr24IAcgnzZaW/xXehysfsoZ2ESPLH+67y8V0O
         Hcu8c2PkIgFflgHEDqRyR2jp7a69xastVUsv92rftdccrAFJdKC
Date:   Wed, 3 May 2017 23:41:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/53] Clean up outstanding object_id transforms.
Message-ID: <20170503234121.tkb5l2qgyilff4eq@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-3-sandals@crustytoothpaste.net>
 <20170502180514.GC181268@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v5vjn5rdfulwefwg"
Content-Disposition: inline
In-Reply-To: <20170502180514.GC181268@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v5vjn5rdfulwefwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 11:05:14AM -0700, Brandon Williams wrote:
> On 05/01, brian m. carlson wrote:
> > -	if (!logobj && commit_reflog->recno >=3D 0 && is_null_sha1(reflog->oo=
id.hash)) {
> > +	if (!logobj && commit_reflog->recno >=3D 0 && is_null_oid(&reflog->oo=
id)) {
>=20
> Not relevant to this series but I was confused for a second seeing
> 'ooid' as I have no clue what that means :)

These were originally nsha1 and osha1, now noid and ooid.  They are,
respectively, the new and old object IDs.  We've used those in various
places around the codebase.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--v5vjn5rdfulwefwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkKaqEACgkQv1NdgR9S
9otPhA/+LYWIjiGARHIUodhNFmatJrdZqJMrboLEL99ubVU0T8b6kt2bWw8Wbj3s
WsqQHVT59CZh0ZgFZHgC6EZKW0glwBEJUIotSAtM5FU+J+QqgpWVJMKogZkEgx6H
uWWwYL3b32zazbZ3K6s+qEgjezGWz+UZAGo+mkRsxHnoK5ejPQeYIPFVtWWf0IuG
OfWr9aNG/uWxQ7na5v9eRZcuDufZPJv2qmbh5ZsEAyL2kl5ON9EDPpzzGCiEiLxP
qwiZNUGrPSOiZS+nTN2YM2dz3wxN28qRvnAbaGojKIm1PrTm/U3Q39tUwpOwZ8AP
cPEgKoitDXCGpAB0bAmrmkxvMvgTlJidmosPBh2+rDNl7OusJ0kFGAlKBBKQMsaV
PtBFOd7f030LpnepPJ5BMAAAtyKXOEpYsQaPSilW/4tASEMkhoBqkAjvYjyBOYWW
IKCX3IcpUAIvQSbpLfbx1ogWh4Y+MJ+jshTtDav6w7ABaJ6w9KElBMIf5+VmjMdT
JsOxpeVaj0YXCFQ12Hefot9R8a2q8fBz/WJHZTCQB6H3NPyNui0FsN3yhcDB5w1n
hPgWJDdM/Ar+rEAjmuiHSXMNgykD5uZw60nBD/9lrAOYUpUnvYDfPYcqmjokMxlf
0JElRBaDU1s/ZbMraxahzV2febeTdiiMK2Kwy4N2JsHQPidJeSM=
=nt06
-----END PGP SIGNATURE-----

--v5vjn5rdfulwefwg--

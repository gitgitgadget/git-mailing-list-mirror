Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1625207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 23:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935044AbcI2Xx0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 19:53:26 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:49476 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934896AbcI2XxZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Sep 2016 19:53:25 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CA54B280AD;
        Thu, 29 Sep 2016 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1475193203;
        bh=vJel+T4NQoEDEDoTeSb5ls+Tkk5jNYDrj3mzPlLYE5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPB175BIgbiTNjmPSJboyC5Gm4fY1uWyjiHqqtyqWEqA76eSXiFjn2c9yRAM4/ajy
         fSANPMocQI0bGpUJfhQl2JbCy663qIBGyg7UK8oTAQTPyrl8NcDAwGRAwGkQI5IfLA
         Dke8AkXszY69VyWHPCAcv32mKXO8W5IbYX/6ZCDOvzoF1YeNhGaRakzWG9IF9SW7z3
         0qQ/10Jh2VEUZW8rQTb0uafUMZqGQrMpnHDXDTxgK/1Y9aIFr39a08IFcs/aU16R5+
         gwTvA5rhntW+HptyqUV/kPsi4+9Kgwogy/23rnTomaD66Mf127csrmw7M4nwovleoA
         GC8u3BlBt0u5a7wVAydkkz3+MrWu/Z30ubS6Q01otLmyCwdVNDjVTf+zx3CnOl3C3B
         pFE9yeMroWB/WDwpkWmteyQPHglZ+Kx+Nic9Ov4BOWaW+rljWJSbYrkkZEWFH2aMfV
         U+JQDrb3XCpiiGlnGlv6vnTXl0yDeRY0X3OFz+QGiuv/ROkDdhV
Date:   Thu, 29 Sep 2016 23:53:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Petr Stodulka <pstodulk@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] http: Control GSSAPI credential delegation.
Message-ID: <20160929235320.ur3t66kypckmq4wl@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Petr Stodulka <pstodulk@redhat.com>, git@vger.kernel.org
References: <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
 <1475085694-10056-1-git-send-email-pstodulk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jy2bep6fssfhgfy"
Content-Disposition: inline
In-Reply-To: <1475085694-10056-1-git-send-email-pstodulk@redhat.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20160916 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4jy2bep6fssfhgfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2016 at 08:01:34PM +0200, Petr Stodulka wrote:
> Delegation of credentials is disabled by default in libcurl since
> version 7.21.7 due to security vulnerability CVE-2011-2192. Which
> makes troubles with GSS/kerberos authentication when delegation
> of credentials is required. This can be changed with option
> CURLOPT_GSSAPI_DELEGATION in libcurl with set expected parameter
> since libcurl version 7.22.0.
>=20
> This patch provides new configuration variable http.delegation
> which corresponds to curl parameter "--delegation" (see man 1 curl).
>=20
> The following values are supported:
>=20
> * none (default).
> * policy
> * always

I don't personally use Kerberos delegation with Git, but I don't see any
problems with this patch.  It preserves the security properties of the
current behavior, and I think adding "policy" as an option to allow
per-realm configuration is a good idea.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4jy2bep6fssfhgfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIcBAABCgAGBQJX7alwAAoJEL9TXYEfUvaLTGUQAJyBC3Ei+W5cW10wCUUMgZho
9sWNL7Q5RK+ei96Uf9tf7NEWxZ8XtQjkgKV0gXqgd4h2N+oqwIZDfqTLmCwNxRPc
/h3L1YxqTyP3bouOcvEsO8nA433SPFzlBpO6bRCERsIj3CRTs1vT54/9MGiQvYLN
pyqKSHAi9cgU7eVZYO8XBpNqbaFLEjOx/DauY+/zghbYWUEH5hdIh/AQqiIleckS
MUyf/jN1Zy4X7Hhc2+4YDIeXIvzrJvLuFI4UCKfQbZ1oTC0gtLrp9BazhKk8O7E/
Ntun2Qk20cawmbREctHBOg+is0YWZRkCS5N0ikOrljjchllIDROyeAvYHvn/48Kh
gaj9FzoUyOPfUca1ft7RoEYxUf0PgSu/UdkT95O10IHhn1iC71jt129bq038FiLQ
F9Iq14jph/l61hIPATDjYS+JvtB5ExxIPgN+CGsiKXUL+3+O1EW7PNrXvBGK9zr1
iAl2wd4egXD1WlsG9eHD2TSSCgRAzWRHdPYK+r7nYrn53fV+eup2Xa01EvzgkCuh
Z0EXYuhtunszkG5TSly89l4vz/eiw362IOi4VvolWOs59itTVshH6yheoDTrt1MH
ueb7RetCztzrD4O1+vbTM1VBF/8tMCoIVArKWJT8uCk8WjirGccL5CDmRNSxMq9i
33Jy5xsV4Y7fVJYbboB+
=Y23H
-----END PGP SIGNATURE-----

--4jy2bep6fssfhgfy--

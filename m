Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E8E20951
	for <e@80x24.org>; Tue, 14 Mar 2017 23:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbdCNXrI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:47:08 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:45106 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750909AbdCNXrH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Mar 2017 19:47:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9DBC6280AD;
        Tue, 14 Mar 2017 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489535225;
        bh=kSWSd+Lq3lDxZ0u/PUE5eSD3voEuHh2PoaBccdZhXfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMAkAIB0diRZXRgo3DeW3Om/WgtP6GFEKDICwhG7/02Yheq6FrRmp9MpwjJ+gVSrS
         muQLpIk5xUYYTef33kG1PnvPAxXCoCPoILJlZ3qy+du2+Wkdc9bzy5+BWVTWb4NzsB
         XDOioY/u/yXbgNlcKz9PMYEhOLeQqQ0tpSB8PbPpvp7aCgsJ5z/rYy3E55Ud09P4S7
         5gxYd2ADvbcV9fyFlhNru9szHebw/QcWOCqeJuvnKAP0zNcfnIkZ0fHy9QdHA7Zpzc
         ECbeXVQplMOMqnNba96PijUu6aQ5wTZNSvZ2nWXCifZFXVvYgIyGOEkco7vHE0sXUZ
         MaGnrrLGggqZ0mqwnPdmzqx2cEW1EVPfmWzEVOiTIYNdxgxKt1taq73oRxb0LUHlBT
         Sb3Lr2B86FbcnP1qhBkCWU/GylbfcfcxsEF6Jfq83f6p1jzW/1J++Qx9QvIF5nQim9
         8lnPQ5vTXtX2AuJ8wOGDyf4/Ej5v63sd/B+1uvOR1KAehFpN1Y2
Date:   Tue, 14 Mar 2017 23:46:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170314234659.wamzgpqu2aikghci@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170314184126.GJ26789@aiede.mtv.corp.google.com>
 <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
 <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
 <1fce97df-7eb8-79d5-b96b-2086746bf19d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="egeayzs54z7ezjwe"
Content-Disposition: inline
In-Reply-To: <1fce97df-7eb8-79d5-b96b-2086746bf19d@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--egeayzs54z7ezjwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 11:42:20PM +0000, Ramsay Jones wrote:
>=20
>=20
> On 14/03/17 20:44, Junio C Hamano wrote:
> > OK, then I'll queue this.  The selection still goes to BASIC_CFLAGS
> > so the dependencies for re-compilation should be right, I'd think.
> >=20
> > -- >8 --
> > From: "brian m. carlson" <sandals@crustytoothpaste.net>
> > Date: Sat, 11 Mar 2017 22:28:18 +0000
> > Subject: [PATCH] hash.h: move SHA-1 implementation selection into a hea=
der file
> >=20
> > Many developers use functionality in their editors that allows for quick
> > syntax checks, including warning about questionable constructs.  This
> > functionality allows rapid development with fewer errors.  However, such
> > functionality generally does not allow the specification of
> > project-specific defines or command-line options.
> >=20
> > Since the SHA1_HEADER include is not defined in such a case, developers
> > see spurious errors when using these tools.  Furthermore, while using a
> > macro as the argument to #include is permitted by C11, it isn't
> > permitted by C89 and C99, and there are known implementations which
> > reject it.
>=20
> C99 certainly allows a macro argument to #include (see, 6.10.2-4; there
> is also an example in 6.10.2-8).
>=20
> I can't remember if it's allowed in C89/C90 (I think it is). I only
> have immediate access to the C99 and C11 standards (and I can't be
> bothered to search), so I can't say for sure.

You're right.  I only have access to N1124 (the C99 final draft), but it
does allow that.  I could have sworn it was new in C11.  I'm pretty
certain it isn't allowed in C89, but I don't have access to that
standard.

I know there have been reasonably standards-conforming compilers that
have rejected it in the past, but I can't remember which ones (I think
they were for proprietary Unices).

Junio, do you want to amend the commit message before you merge it?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--egeayzs54z7ezjwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljIgPMACgkQv1NdgR9S
9otquw//abzRp3IPOt0NSOcqIHZ0LU6M+AtOOkb8CMdEDFwEa+9f+I5tjqgORiPn
FUJt3uiByw0CdquO1a0rEQGEy6GQY72Dk/Im90TvmuM+DCmII2whAg7l/NdLiD6S
Cw7H/e7/PQVwKF8KS7jddGshgKI1yoQXHAYFB2mhDP+lL9dBvzXPOaBNSB9725G7
5O9dFr5Dlj5uXWxDaoPymwsoymlROjN9dn86t9uAsbJDhp1oCEYbtErx0XXNF/3v
OfIIHAW6h82p1Pz6wR64lo1dhQemrYlUqBRgyIHCubPVgufMGir7MN1okXMidwGp
qeJbgJtVfB+zffLbR2n9e14jrrKQ4rlTGz+dFEynPmnQlgaBy975VHe0IKWxrEa/
repHncBzKgVInGxtZVs7UgJl83/V3dmNwMp6Pc0wZUHWee2+pZXhanYBY37ccMz8
/12BWEGSWZ6NvZf5Taqr3vMsLAEdBsTDLtjy/9w1KVjwMIY2NoYNB0xPLZ98aUjg
x2OuSz6ORTM9QBAMUplOdhBBg2dv+bNE2Qxx7rlhsCMeNv372MXZB/4JhzEKmlP7
EnIIRmIQZtQh6bMXF2TC2NDJBAf+V8HVH06dMr/dfgB4r2ZHeq1u/HTzuTlwehfc
0NpsHgXcPtTa/h5Q66GCSkg1ASwfe1s066RijhMI+A+KVYzx678=
=u95c
-----END PGP SIGNATURE-----

--egeayzs54z7ezjwe--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B341F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 01:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeK1Mri (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 07:47:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56486 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbeK1Mrh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 07:47:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c029:e61c:1a0c:a1e6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC5C7603C6;
        Wed, 28 Nov 2018 01:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1543369666;
        bh=NB+XoKBlViTN8rzxAyzfvaw5AqB/I32j3EAewBUiUzA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lwoKmAiNcpMv1Rt3t3Dp99QrgQUOJ33Xdqu1kq809LeIxZyEoqTjOcj7z/khnTpdZ
         JGmS5ZIXLHlobzjINCp112C9ZW//rhwAUfJEt6Fo7SwOqYA0C0UuA5CF6wzAo5sotw
         s8eaWK3fmD+H4o4ceidfFN04ftSTVR5ci9wEGpPojUI8oHno4guXanzEaEtEaaW/pd
         BFE+oapn7UpAQntsHQgcS6cmifequTdSXDJeDjH1h7mazlpcwbp6i66me/Y9xITC4J
         Tmm+tSVC4b3bgFTZHxazIczMIs5Tj0+Prd3zUREm7wwh4FRqPc8Y5DSYEqhthxjblV
         T007Chu3bOolALip6oF77zsktehvE43Ggxe2lKm/VPngcgkaMNyzUaLNZfW4nEp+8Q
         vLApmO8MnewgYEMMdlDnexZCIm4FQA/QImpE4V75R/kD0bjS2vE6mq3uc3SC62LbeY
         HdY8lbiJejHyUYD58WuS0XtTWh37zOtEA+6J/2nsNV9LepEQSdS
Date:   Wed, 28 Nov 2018 01:47:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Haaris Mehmood <hsed@unimetic.com>
Subject: Re: [PATCH] tests: avoid syntax triggering old dash bug
Message-ID: <20181128014740.GU890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Haaris Mehmood <hsed@unimetic.com>
References: <20181127164253.9832-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UC+RhZhEc8lcmajv"
Content-Disposition: inline
In-Reply-To: <20181127164253.9832-1-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UC+RhZhEc8lcmajv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 05:42:53PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> Avoid a bug in dash that's been fixed ever since its
> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
> released with dash v0.5.7 in July 2011.
>=20
> This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other
> failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
> before URL encoding", 2016-02-09).

Are people still using such versions of Debian?  I only see wheezy (7)
on the mirrors, not squeeze (6) or lenny (5).  It might be better for us
to encourage users to upgrade to an OS that has security support rather
than work around bugs in obsolete OSes.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--UC+RhZhEc8lcmajv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlv987wACgkQv1NdgR9S
9oszjg/9FwwOT90x9lFiA4IMWKWunLp989s4f0mOIzZ2GHS4oGhRdQTmEOeYy50l
p0YsCPzVv6acyf+SG1tzwDZdIyYN72RnetxJ9kxv77YNk7rQ98ql3NS1i6kYcG1t
F9AkMWkeF8gwS1qCCdHfd5wxaJttTNymuQ6Cy1Av7dKpUFq/yWtRlzjo7kPvYRaY
ZFlqqpnJkYZI90RNnPCjI/FQh4b2TTP1TYqK8oEy/HlzwvCG3EVrZdSAKeNudUkJ
dd7OGXe5VTOsbHICuVNRoZPQ05drCvFYJH4QmOQ+U4OMQZFXFq0BUMh/Ei+hyXBt
5kDNhtBBxPvVy+lVTGeEfKemc5VLLxP9KY4Q/pL/IJdeLjSv3yGJsW87Pb0JPCH0
ZRe/kGUYLiYUzI+dRJPX6DcRhn6j+LwECo9sNwKMRIxP0qpweouWHd1Nm14Mkprw
ZAamgFBvq7VT1Awf9Q3TU2flAl+cKljmDJChf4DI5JMK4uBYtBL5Uku+t+adNf9A
JzgceJYcw7Adb1JV/+ArYDp6N4jqiW98+VBRI67jnkN3vSW0GO2GKLU27og3xU3a
Qtwfp9+eoGXN3f/Yj3dnpAbbdIKcQt4NS5gm7FZ9nxx96pdGcOJJ4bOHC8wAGP1w
L43zpzMTMO3lGXwNqM31EbumV0L9UXK4nzIQrkq6gv8AVK4EdzY=
=F6O6
-----END PGP SIGNATURE-----

--UC+RhZhEc8lcmajv--

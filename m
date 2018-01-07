Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8824E1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeAGVSi (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 16:18:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57966 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754557AbeAGVSh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Jan 2018 16:18:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D0BA760402;
        Sun,  7 Jan 2018 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1515359916;
        bh=b9kLEtRBg9HR2oHcKr/pE6KjYVHCbmNAKv+XdC8RkBQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ATWnblyCsjccnbmlSfmR29ddYd19rINE69WqYfMhlYOQW/QKhvDqpy1f7r2zerzGr
         1O9Dy6aeSdjh/d7sOBVRjia0iVJYJYzJHjFxJXTnH0JsnlHIIkDzeVgei5gDdT68wQ
         QhAnITobpIuraMJ5BiK+E/aK92sDN+9UyU/tH0JyYiLKnXfrltN99A7+AJuHsUiBrE
         4+fUatVGj6LipFQm1PVCRULYsWeMPUrpx/+WdFPMGSFuYWFs9PJpOJXTUu3C1nc09T
         DRDCReGXwj/W6Ya2KOvgxkj1bimWTDVeyKt6Gmm1MhIUFue0NmEF+rYjvkefZRLmID
         5OZKvCO+Q/37GIKJHBP4vCX6EieowPno8KtjJuzIJ4YYsd6/9m4XLrP3+gKvTtii7G
         zgqEzqKGHxmAETbRfcUC4D4s8oGHtzdi9FzcN2aupxv3KjmTMqO1xFpK+yNTi0gql0
         YNPdrs5BhyJ4qy7zKhZ37v/pKV4Xm/XgofVCa7HTqdTbbhu1Tsn
Date:   Sun, 7 Jan 2018 21:18:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'git mailing list' <git@vger.kernel.org>
Subject: Re: Request for Assist on Limits for Tests
Message-ID: <20180107211829.GA5946@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git mailing list' <git@vger.kernel.org>
References: <000d01d387fa$36a65300$a3f2f900$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <000d01d387fa$36a65300$a3f2f900$@nexbridge.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-5-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2018 at 03:57:59PM -0500, Randall S. Becker wrote:
> I'm looking for a proper (i.e. not sneaky) way to detect the platform I am
> on during testing so that some tests can be modified/skipped other than
> using the standard set of dependencies. In particular, the maximum path on
> current NonStop platforms is 8-bit 2048 bytes. It appears that there are
> some tests - at least from my preliminary "guessing" - that are beyond th=
at
> limit once all of the path segments are put together. I would rather have
> something in git that specifies a path size limit so nothing exceeds it, =
but
> that may be wishing.

The way we usually skip tests automatically is with a test prerequisite.
You might look at t/test-lib.sh for the test_set_prereq and
test_lazy_prereq calls and synthesize one (maybe LONG_PATHS) that meets
your needs.  You can then annotate those tests with the appropriate
prerequisite.

I expect that for long paths, you will hit a lot of the same issues as
occur on Windows, where PATH_MAX may be very small.  It might be
valuable to expose this information as a build option and then set an
appropriate variable in t/test-lib.sh.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpSjqUACgkQv1NdgR9S
9osbgQ//Sd7m/OSZ9yVB17RxgTDQEUyzYcQOi7fRBgwZGgZuk8AiV3fzdI+GZocw
z2FpktYrNz1djT/oRe+WBB1SHC98rwVTFZkowrSOqz+sYQ6bpyVAb/sRnmZDHLid
JpLOO2T8/3yHW9ew7HBpwMsQOViECYb4RBWRmxXQ2Xx5h5/MzBFdj/36lPdf1r++
QOBNyzyKOMpwujg3Szd6h0rSHM//3t88M/5bAoNszoNU7ixZrFTEC56qYVCAmzYM
2L8/0CtXR8yBab2+aMUo/ToB60aDLoTKwYg04MGNo7wja3CtIM48vLdDQRry7j+y
Q1i01/DgesfuGOdI9TD6md8yZ5wNmj4uxV3O5KitTUayNbCuppnozDBIxttKMniB
v0Z3fs88FjIRNDc3Texco0JKCmkZoJYktnzsOqlnn6s6rXuzAkb3TXwa/i9pJQMB
6NCGzwLlJNDiZ0sI6p0c5Yjl+LvhSBAhubUbSu/jbjJkBx5RPHniMcyfjjWoWMk0
zQbB90L4/GoYon4Wl2q285Fn7fxw8pmtLOc7QCNi9XY2nR3SJg3DCF9PWdUfKjWw
Ahd6g48vG4Lb1D0DvcaA42VwIpE8pcq4GzquAZ792v1TqnEV6k06nCHErg1nv8d9
tQuKr1MehyGYdh1sXYun4kzvm9ZHdKck7bCk5xVjYbFVizDcMDM=
=c6PK
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

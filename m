Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79425C433E0
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 00:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5372D20674
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 00:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OXYVal3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGKAyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:54:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40520 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbgGKAyu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jul 2020 20:54:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7A7C460424;
        Sat, 11 Jul 2020 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594428858;
        bh=b1tytgxzHxBOUdhFLPLwGwR2TCbsT8ok8T3dn95MgyA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OXYVal3otTWotvU9fZNzXC4Vte3FF/UsTrfE8g83kXQIcxoGVXhhxWAGjpNHoPrNr
         wpExqbOyV9sps0G3vH2nbdGHiIOkbz5CxvblCuKR/pkz/RYXeJfHs1MXvKqjTA7v+L
         WO0p0h6ssGX5jspKQBdeohF61HNaz8ClWEUooFyMDAgARNJxf3RRYCshlMF93ocfzw
         mZQZ7SDEGmOAz+dT3Wrhe8bK4g6Eb5yfGIElvGWHiIpaS9dlCn4Uj2wFMqyzAol+zf
         fdncOGouhJhawl/A3dtG1Xy10/5OOKrKKnDvQmdJ7+kA1jE6hx5xR61/e/X7p83Lv3
         hyrb8kOMOwThCV3FoZZmKHbFpGgLsxMrShFRPrjfKafXtahWfJIZOQ3xlGe9JzGv3w
         UCjhNNWdsinjYB7yhnvdcYsGDrABeMMsqV3YSnfObScufOHXT2NJsqqQlsPzz7XKxg
         xhj24+V06TXjJ+dFl3D8H0z7jO+gKxbHv+p/aQuKuZFGw10JwlT
Date:   Sat, 11 Jul 2020 00:54:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/38] t7063: make hash size independent
Message-ID: <20200711005407.GL9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
 <20200710024728.3100527-12-sandals@crustytoothpaste.net>
 <xmqqmu46rieb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucfHZChuBC0NsER/"
Content-Disposition: inline
In-Reply-To: <xmqqmu46rieb.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ucfHZChuBC0NsER/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-11 at 00:43:08, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Use test_oid instead of hard-coding a fixed size all-zeros object ID.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  t/t7063-status-untracked-cache.sh | 155 ++++++++++++++++--------------
> >  1 file changed, 83 insertions(+), 72 deletions(-)
>=20
> The stated objective does make sense, but ...
>=20
>=20
> > -info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
> > -core.excludesfile 0000000000000000000000000000000000000000
> > +info/exclude $(test_oid exclude)
> > +core.excludesfile $ZERO_OID
> >  exclude_per_dir .gitignore
> >  flags 00000006
> > -/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
> > -/done/ 0000000000000000000000000000000000000000 recurse valid
> > -/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
> > -/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
> > +/ $(test_oid root) recurse
> > +/done/ $ZERO_OID recurse valid
> > +/dthree/ $ZERO_OID recurse check_only valid
> > +/dtwo/ $ZERO_OID recurse check_only valid
> >  two
> >  EOF
> > -	test_cmp ../expect ../actual
> > +	test_might_fail test_cmp ../expect ../actual
>=20
> Any "cmd" that is run under test_might_fail that is *not* used for
> its side effect is suspect---e.g. "we would try to remove this file
> as the test may have created it, but it is OK if the file does not
> exist and removal fails" is sort-of understandable, but I am having
> a hard time imagining in what situation it makes sense for a test to
> say "these two files may have the same contents but it is OK if that
> is not the case".  There are a few others in this patch.
>=20
> Another topic in flight tightens the allowed usage of test_must_fail
> and test_might_fail helpers, and that is how I found this (because
> the tip of 'seen' does not pass the test), but regardless of that
> tightening, I am not sure what this "these two files may or may not
> be equal" is trying to achieve.

I agree this is suspect, and I'm not sure what I intended there.  The
patch is unfortunately over two years old, so I don't recall exactly,
but it may have been flaky (in general) at the time I was changing the
test and I may have accidentally squashed that into the patch at the
time.

The test passes without it, so clearly the right thing is to remove the
test_might_fail, which I agree is bizarre.  Feel free to do that when
picking it up, and I'll fix that in in the reroll.
--=20
brian m. carlson: Houston, Texas, US

--ucfHZChuBC0NsER/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXwkNrwAKCRB8DEliiIei
gYskAP4hlri9aP4FRSknTGPwdDW//YBXoJHRIVOdvyG1m50QUgEAtj6yG9ndbeb8
uISMrNwiQFHFulSYA/L84c+2xxVcEw4=
=EUtc
-----END PGP SIGNATURE-----

--ucfHZChuBC0NsER/--

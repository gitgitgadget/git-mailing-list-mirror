Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E01C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51B92077D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="glmYTewH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgDVSp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:45:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37568 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgDVSp5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 14:45:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4F7F66088E;
        Wed, 22 Apr 2020 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587581156;
        bh=PI7eVWWySaEEpIuveG0/tSBFWmmGBf/C1/TKqQdV2aI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=glmYTewHsGfSClVd991QTupMoSnw8Mt/oh/G/wfGrVHrr7N1qJdVFk6LzJmlzkI9v
         GtXk2Eajid+kGgCoLBfEtrQxLnSdOwxI6MmKYxbMIOx+eFosuWJDhVUoQLELgHp+A2
         p8CkNw8GbyOt7CjJYCglW69krZ7SCiNJD4Ah2Vte/djxJmvX5X6tkrr/w+3QXkmGzw
         CzIdOwu4ukmcvzJ5/zdiukoqjF20gURSWy//HTrvrStjFKY6+Gmz6ZZmWBcbHjHein
         40J8hfTc1jY1XQtCQCxBaVFgtlqDBGMQYzlGed1+z2NncmkTjRNr0WNvyJJ9nzG75g
         oijdyxDJjBvmNLdvnYlc3uEx2tv+QruwxTicjkcMSrEtxkPqPyskTt4GNLrTq3Lv17
         DT9h5bc5QK+zcvAp1/fMLg1+iP472nSy4xVQwekGUrYjkqjcD3cx9yfZi1Ep6xANv6
         5CNSk5cZ8M7Rcl4LkhCxrBNu2ZBPKPmEWtw3UkBZ5I4BlQLWNA8
Date:   Wed, 22 Apr 2020 18:45:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH] credential: fix matching URLs with multiple levels in
 path
Message-ID: <20200422184549.GH6465@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ilya Tretyakov <it@it3xl.ru>
References: <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422012344.2051103-1-sandals@crustytoothpaste.net>
 <20200422041614.GD3559880@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <20200422041614.GD3559880@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-22 at 04:16:14, Jeff King wrote:
> On Wed, Apr 22, 2020 at 01:23:44AM +0000, brian m. carlson wrote:
>=20
> > 46fd7b3900 ("credential: allow wildcard patterns when matching config",
> > 2020-02-20) introduced support for matching credential helpers using
> > urlmatch.  In doing so, it introduced code to percent-encode the paths
> > we get from the credential helper so that they could be effectively
> > matched by the urlmatch code.
> >=20
> > Unfortunately, that code had a bug: it percent-encoded the slashes in
> > the path, resulting in any URL path that contained multiple levels
> > (i.e., a directory component) not matching.
> >=20
> > We are currently the only caller of the percent-encoding code and could
> > simply change it not to encode slashes.  However, this would be
> > surprising to other potential users who might want to use it and might
> > result in unwanted slashes appearing in the encoded value.
> >=20
> > So instead, let's add a flag to skip encoding slashes, which is the
> > behavior we want here, and use it when calling the code in this case.
> > Add a test for credential helper URLs using multiple slashes in the
> > path, which our test suite previously lacked.
>=20
> Thanks for the quick turnaround. The explanation makes sense.
>=20
> The patch leaves me with one question, though...
>=20
> > diff --git a/credential.c b/credential.c
> > index 108d9e183a..f0e55a27ac 100644
> > --- a/credential.c
> > +++ b/credential.c
> > @@ -136,14 +136,14 @@ static void credential_format(struct credential *=
c, struct strbuf *out)
> >  		return;
> >  	strbuf_addf(out, "%s://", c->protocol);
> >  	if (c->username && *c->username) {
> > -		strbuf_add_percentencode(out, c->username);
> > +		strbuf_add_percentencode(out, c->username, STRBUF_PERCENTENCODE_PATH=
);
> >  		strbuf_addch(out, '@');
>=20
> Wouldn't we want to keep encoding slashes in the username?

Oh, you're right, we would.  That makes my commit message shorter, even.

> > diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> > index 5555a1524f..15eeef1dfd 100755
> > --- a/t/t0300-credentials.sh
> > +++ b/t/t0300-credentials.sh
> > @@ -510,6 +510,24 @@ test_expect_success 'helpers can abort the process=
' '
> >  	test_i18ncmp expect stderr
> >  '
> > =20
> > +test_expect_success 'helpers can fetch with multiple path components' '
> > +	test_unconfig credential.helper &&
> > +	test_config credential.https://example.com/foo/repo.git.helper "verba=
tim foo bar" &&
>=20
> OK, you can't just use an argument to "check" because you want to set a
> specific config option, not just credential.helper. Would this test make
> sense a little higher in the file, below "match percent-encoded values"
> perhaps?

I can hoist it, sure.

> > +	echo url=3Dhttps://example.com/foo/repo.git | git credential fill &&
>=20
> What's this line doing? It will just do the same "check fill" as
> below, but without the stdout checking. Is it leftover debugging cruft?

Yeah, it is.  I'll rip it out in v2.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqCQ3AAKCRB8DEliiIei
gYjSAP9a2fp41buxv9KMxqJDZoC5NFjpICP9YUH0RGXz2Fl6qgEAp48qctFsNr3w
VbdvIt2ljuycYySI+f7ZC4Bg5uFxSAo=
=4/Du
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--

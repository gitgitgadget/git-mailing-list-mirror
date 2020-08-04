Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C7C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F662076C
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YAjLSYFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHDAoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:44:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgHDAo3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Aug 2020 20:44:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 71A4160799;
        Tue,  4 Aug 2020 00:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596501868;
        bh=lMKzpHdUTkC0dHzuimX7JeanH14yvHFlhyusDKiFgmI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YAjLSYFSXiKyUbHkS9C3CZI5Mi0ZBQVMOQDhOEqghrDD3igeFFE6Dc8Ge5qFqD9gI
         w+0RBzqHJfC3sCKYFXIuVHtkb7Az3iz50QYsc9hHYYF6iAYUopA8IzrqJ9v1Wibycr
         BkKulAPRL61e0PvyxNEiRq+uKHWSrYN4U6l8GFzV5uvK2cWLQokT9nsTw8rWvcgxZl
         RfjTVxeADVd5FwbsPe4VB2uA0k4xoMlTiadgp80RcsFFLh70fap5ehhsBnp/T6RUw/
         sepTZ8DRCjwxNMlXED4aFlSbnVoc4/CKK5MrLIuFx9EzrwZ0RruloVgeom7RpMRibi
         +EUev6n58jRMFZgQuMrYslt9HUx8rQ7vTtkkDfyIeBUwAVJ48KEwkzWf430Hy2pCHu
         WThi25w+3Ke/bXSohDbNH1IH9QMejIAslfr9eVCaIZvXlakvnzh1lSWjEmN49SrIst
         NdZwH3/3QGTNYVz0jp06JX9JJBlzsttvHh9usBnyXP5ox3Thlnb
Date:   Tue, 4 Aug 2020 00:44:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] git-cvsexportcommit: port to SHA-256
Message-ID: <20200804004423.GO6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, Andreas Schwab <schwab@linux-m68k.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-15-sandals@crustytoothpaste.net>
 <87zh7bo9so.fsf@igel.home>
 <20200803235007.GN6540@camp.crustytoothpaste.net>
 <20200804001315.GA4899@dcvr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline
In-Reply-To: <20200804001315.GA4899@dcvr>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-04 at 00:13:26, Eric Wong wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> > On 2020-08-03 at 18:37:27, Andreas Schwab wrote:
> > > On Jun 22 2020, brian m. carlson wrote:
> > >=20
> > > > diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> > > > index fc00d5946a..6483d792d3 100755
> > > > --- a/git-cvsexportcommit.perl
> > > > +++ b/git-cvsexportcommit.perl
> > > > @@ -22,6 +22,10 @@
> > > >  my $repo =3D Git->repository();
> > > >  $opt_w =3D $repo->config('cvsexportcommit.cvsdir') unless defined =
$opt_w;
> > > > =20
> > > > +my $tmpdir =3D File::Temp->newdir;
> > >=20
> > > File::Temp in perl 5.10 doesn't have the newdir method.
> >=20
> > That method was added in File::Temp 0.19, which was added in 2007.  Does
>=20
> 5.10.0 doesn't have ->newdir, but 5.10.1 does.  I figure nobody
> used 5.10.0 anymore since 5.10.1 exists and (IIRC) fixed many
> things wrong in 5.10.0.

Technically we support 5.8.8, I believe, which means this probably does
need to be fixed.  I'll let Andreas verify the proposed solution works
for him, and then send a patch.

> > For the record, I plan to propose that we drop support for Perl versions
> > earlier than 5.14 on December 2, since CentOS 6 will be dead at that
> > point.  I think a ten-year lifespan for an OS is quite generous and
> > we're still considering Perl 5.8.8, which nobody is publicly supporting
> > anymore.
>=20
> That's probably fine.  I haven't looked at 5.12 and 5.14 changes
> enough to comment, but just moving rom 5.8 to 5.10.1 last year
> made my life considerably better (e.g. `//', `//=3D')

5.14 has nice things like s///r:

   # 5.12
   # We have to make a copy since s/// modifies its left side.
   my $foo =3D $ARGV[0];
   $foo =3D~ s/a/b/;

   # 5.14
   # Now we have non-destructive substitution.
   my $foo =3D $ARGV[0] =3D~ s/a/b/r;
--=20
brian m. carlson: Houston, Texas, US

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyivZgAKCRB8DEliiIei
gVRmAP9LpofWg9qUbYobBIHYsmV67hdGRUdy8LweRQVn3hVyhAEA0+y5pFm3CV47
/T1eZ+3IvvNlrFUI1YwvNUH63g6upgE=
=SKUn
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--

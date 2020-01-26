Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5EC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D268C2071E
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eL+3PI5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgAZW1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:27:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47628 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgAZW1D (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jan 2020 17:27:03 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A266360482;
        Sun, 26 Jan 2020 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580077623;
        bh=A6RY6I2GuZbAeNJf37aqBbo3job862t6IAY/V2lS0pI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eL+3PI5ark9V/FLnxAZhpaK2ppyaSiiXtib63BRiycqZi1K9Em3jbb8elTgNosKL0
         2C13HWPHP02/CxkhjlhS/o3Ot5OoWdHMy3I4wGdRoX63Io3GOsnHVXxvMftYc5sJhg
         fipkzKM7t0miCOPj65FyuP8fDdlt+Mn3/oiwYDs2+nOq4UFdWvh7khvIBbaJ73VDlR
         R+OVIIA2ncc7iF0HfbPZJqrbW8ViRIDB/Hed+4ArZ83mfvSrSq9ACMarscknYp+Bjh
         v7B0q8bKjeQeli2dazjTV4DoYXbyKk3HHrwlLOkrjwJk57gE+43ojVTskror8lsizX
         99eLxuHajL9z5fMicdB8gsy0ZYkfzsXt76lPXUkwAWyqWicvqk2szVOnXCvc/rHX+w
         RgIG1Zp/dJX02vx3574iweefNjmxVFDZl8KJmRnLzTu6fsJ3TwRJ1ZG4HApGAO7QwH
         0jBLw3ebke9B210G+sXLAlPEF47q6npunOHZgZzaFNhSKH25ahp
Date:   Sun, 26 Jan 2020 22:26:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/22] t4013: make test hash independent
Message-ID: <20200126222658.GG4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-9-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2001262303530.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001262303530.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-26 at 22:08:18, Johannes Schindelin wrote:
> > diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> > index 5ac94b390d..6f5f05c3a8 100755
> > --- a/t/t4013-diff-various.sh
> > +++ b/t/t4013-diff-various.sh
> > @@ -120,6 +120,30 @@ test_expect_success setup '
> >  +*++ [initial] Initial
> >  EOF
> >
> > +process_diffs () {
> > +	x04=3D"[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
> > +	x07=3D"$_x05[0-9a-f][0-9a-f]" &&
>=20
> Any reason not to stay with the convention, i.e. using `_x04` and `_x07`
> here (with leading underscores)?

None in particular.  I have a slight bias against initial underscores
=66rom C, where that has a specific meaning, but I agree consistency is
good, so I'll make that change.

> > +	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
> > +	    -e "s/From $_x40 /From $ZERO_OID /" \
> > +	    -e "s/from $_x40)/from $ZERO_OID)/" \
> > +	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
> > +	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
> > +	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
> > +	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
> > +	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
> > +	    -e "s/^$_x40 /$ZERO_OID /" \
> > +	    -e "s/^$_x40$/$ZERO_OID/" \
> > +	    -e "s/$x07\.\.$x07/fffffff..fffffff/g" \
> > +	    -e "s/$x07,$x07\.\.$x07/fffffff,fffffff..fffffff/g" \
> > +	    -e "s/$x07 $x07 $x07/fffffff fffffff fffffff/g" \
> > +	    -e "s/$x07 $x07 /fffffff fffffff /g" \
> > +	    -e "s/Merge: $x07 $x07/Merge: fffffff fffffff/g" \
> > +	    -e "s/$x07\.\.\./fffffff.../g" \
> > +	    -e "s/ $x04\.\.\./ ffff.../g" \
> > +	    -e "s/ $x04/ ffff/g" \
> > +	    "$1"
> > +}
> > +
> >  V=3D$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
> >  while read magic cmd
> >  do
> > @@ -158,13 +182,15 @@ do
> >  		} >"$actual" &&
> >  		if test -f "$expect"
> >  		then
> > +			process_diffs "$actual" >actual &&
> > +			process_diffs "$expect" >expect &&
> >  			case $cmd in
> >  			*format-patch* | *-stat*)
> > -				test_i18ncmp "$expect" "$actual";;
> > +				test_i18ncmp expect actual;;
> >  			*)
> > -				test_cmp "$expect" "$actual";;
> > +				test_cmp expect actual;;
> >  			esac &&
> > -			rm -f "$actual"
> > +			rm -f "$actual" actual expect
> >  		else
> >  			# this is to help developing new tests.
> >  			cp "$actual" "$expect"
> > @@ -383,16 +409,22 @@ test_expect_success 'log -S requires an argument'=
 '
> >  test_expect_success 'diff --cached on unborn branch' '
> >  	echo ref: refs/heads/unborn >.git/HEAD &&
> >  	git diff --cached >result &&
> > -	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached" result
> > +	process_diffs result >actual &&
> > +	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--cached" >expected &&
>=20
> I was about to suggest letting `process_diffs` work in-place, but this
> line makes that idea moot.

If I could have done that, I would.

> Another idea I had was to implement a `test_cmp_diff` that processes the
> diffs and then compares them, but I guess that would be _less_ concise
> than this patch.

Yeah, this is a tricky test to work with because it does so many
different things and trying to handle all of them in a tidy way is hard
(as one can intuit from the giant sed statement).  As part of the patch
you quoted above, we sometimes use test_i18ncmp and sometimes use
test_cmp here, so it's not easy hard to pick something that works for
all of these cases without some duplication.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4uEjEACgkQv1NdgR9S
9ouMrg//e0sshvY20FkUFgIrMkP68fCOkW7ROwnDp/r7fZIvd72fred86Oskk+Bm
xm/UBQf48lhxcO0CKxkUmGfuTdWqXjeT3e0pGdTDvDIH2yaJxal/d49rH4BsIY1U
E6UQ/EUnZWYHwbIVeuG/ERPaxTk0GFzRbNbQZKoYPZlL6tWK/8zQIYpKLytsy/pH
MD0xZWKc3f31IFmO6YDsisy9JPGiZCUaRgR6ChydAGZfvEURbmiqk0CvxLuhIgjs
lqy4v737Dzw7RjthrzHfaPa1GYwjkkn3jqxtURUqlc8XdpGxjUnLwbk8QkHgSls0
EhcvUGq99ja5NyCsb78HSYn16BZq5fA9Klbp726MLHVXt1p0651B3IcGqtVNICHI
AOQE4O4qNeZbLGmjNplWESPz3jCHoHyJ7dyvSitPHjPRhKLMvCEp27iNsxMZQ2Cg
gYAcIY/j5aU35jmX58dWro+AHRjsSe9r48Ecr3Np4/4x/GR5ZRvLCXckbtCpcSdI
zlCJdb+9cK8VI2rgop7HCfpKlmIXcY/QELTwJnCgr8VL+QC8Kbr0nHSejQpOZHAQ
CSbGtWNfarEloy6a5Xth8zx9jAAAuUyQ8Oa7edvUjtSmrYAE3zh9nKe37vfHXPNs
WR6yrurwk8GADK0KrjjqwUBwC4LY2qPdv5z2ALiYYScvo63Xfqk=
=+BoI
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--

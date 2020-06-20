Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2296DC433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1EF23B88
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 13:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lOZZXl6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgFTNT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 09:19:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39928 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728064AbgFTNTZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Jun 2020 09:19:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6B1106048A;
        Sat, 20 Jun 2020 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592659132;
        bh=1b2/ZwHxKPote5bF7hDo4qNc8lyV4uw3LKtqA1HnSlw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lOZZXl6i52wz3r1kXBMCvD36LGxOXfQttgV+3Qox0zsmqoGVPqna8vN533cjAn3IO
         Xk/bhvT57syuq44xZJ9ip/WLeCdYWp94uDaEHFM34dHGBLBqxJlOpyrLjE8qkHs2Cj
         YLsJcbN3gpiaZXURqzJqRwZTm20Vq3EIhVOJiakE55Bs57Pv5PedgpEJmHy18gVyJd
         VT+Uhs4IBTt6+v7blpW9zXtORFIzzQsdYcgnOpm4QQHoLR+SaCdLqykOdXjNpitkIl
         s7BJF0NtUKG6HvwNR6u5eOcznJEIc9Y7VphL51I6NvlcUhSIJdsE+oBV7Fu5xvEDda
         JjK1He5ULPt/wUrqdgyelcEe9T+QRoib+uqGDvmiDOle5pREdG8J3pC+i9vl1Of0m9
         HmzgQCfXXpZopDwExF+xqa9xrCsM+zPjMgJt8yEPhbOD6j2t2wyN/VVPbQzXFUyRa0
         km/6W5MV3FvdU6AkncD9GOAWNnSM7KFN6VV0dQIX0amF2F+20k7
Date:   Sat, 20 Jun 2020 13:18:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@google.com>,
        Eric Wong <e@80x24.org>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 07/14] t/lib-git-svn: make hash size independent
Message-ID: <20200620131846.GL6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
        Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200619223947.947067-8-sandals@crustytoothpaste.net>
 <87lfkinp02.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline
In-Reply-To: <87lfkinp02.fsf@linux-m68k.org>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-20 at 08:02:53, Andreas Schwab wrote:
> On Jun 19 2020, brian m. carlson wrote:
>=20
> > diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> > index 7d248e6588..4780b45337 100644
> > --- a/t/lib-git-svn.sh
> > +++ b/t/lib-git-svn.sh
> > @@ -78,29 +78,30 @@ maybe_start_httpd () {
> >  }
> > =20
> >  convert_to_rev_db () {
> > -	perl -w -- - "$@" <<\EOF
> > -use strict;
> > +	perl -w -e "use strict; my \$oidlen =3D $(test_oid rawsz);" -e '
>=20
> $(test_oid rawsz) could be passed as an additional argument.
>=20
> perl -w -- - "$(test_oid rawsz)" "$@" <<\EOF
> use strict;
> my $oidlen =3D shift;
> ...
> EOF

Sure, I could do that.  I originally tried to pass it through the
environment, but that didn't appear to work as I expected.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXu4MtQAKCRB8DEliiIei
gYwfAQCRvBj/6vxDfZma2ttkwuuIy9K18+7y3GJj12P03cdC6gD/agYHP0DMpW8N
SsG2pnc6LB8og/eg4yRB0YrT9PY/JQc=
=NtSC
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--

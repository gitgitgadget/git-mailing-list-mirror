Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFF4C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAD860F58
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhHPWUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:20:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232067AbhHPWUW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 18:20:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5CFCC6049C;
        Mon, 16 Aug 2021 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1629152389;
        bh=+84CoVx2YDke/xcijkax93/JIHuUd7aJgJnqH07C3z4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SXzNzWFafcAoe+YB5Q12rwyFJSKXxyH/PGcY7gZArN7YNIAmZXQ+uaheAaPdy+DEk
         AcRwxH42wZmY0gslc4UbibWAGd2KQu1rb0JDdVXe2mBZq3V9POi2ECWPOarVakFuxd
         oZZgubseWjSiPFoDkIsVZL7mDNgwRE6xvr6ynGk2Iv3m0Vxyo4yDTcWFYQs0wSXAZR
         Hmkh9qcnqvm9Y7spbQvZ1TobaQ7JvDGCdF5Q7Q1JazI9L3irMk37ZbaB6qFqHGw8KE
         a+VRM/1VreIJgpam3gRwN6ug5azYqFYbhGvZkjbo07LYDmXnZRxONNJ2DLNcyRZbxK
         k46AnXqySfp4ZNOhlv3VWaaY57CQANWwWKc98CFCyWwWA4gqXzczO5zF+rDrLuekn8
         TeO24GhrpVdo2PCEk3hgVlzZS6ZbTCx9Gi2G7TMSo6Yfr5R5Sx9pMvrzJOOTQe80R5
         FUwnwj0e1tFao3pmUpV12mcOEMvabBoTWJavqOpyr0dahBy0ZTt
Date:   Mon, 16 Aug 2021 22:19:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clone corrupts file.
Message-ID: <YRrkgQDRVT+O+4Ih@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Russell, Scott" <Scott.Russell2@ncr.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
 <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
 <YRrdq5VAp3o35+Fb@camp.crustytoothpaste.net>
 <BN6PR15MB1426DAA212EC5A9E89E19176CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sSCKaJ4+raA5Ldoi"
Content-Disposition: inline
In-Reply-To: <BN6PR15MB1426DAA212EC5A9E89E19176CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sSCKaJ4+raA5Ldoi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-16 at 22:04:20, Russell, Scott wrote:
> Thanks Brian,
>=20
> I appreciate the guidance.   All our .h files can call be converted to AN=
SI.   I don't know why we seemed to have just one saved as Unicode.
> But it was a wakeup, and led to discovery of other files not correct.
>=20
> Upon reading the help on .gitattributes, I was reminded that Windows Visu=
al Studio can save some .rc files as Unicode.
> I think that most all are ANSI but that leaves the possible result that a=
ny one saved as Unicode could unexpectedly fail compiling due to the conver=
sion.

I do want to specify a distinction here.  You're referring to "Unicode"
and "ANSI", which traditionally mean, on Windows, little-endian UTF-16
with BOM and Windows-1252.  You do not generally want Windows-1252, or
the encoding on which it's based, ISO-8859-1.  Those are obsolete and
have been for well over a decade.  It's unfortunate that many Windows
programs continue to use these terms, because neither "Unicode" nor
"ANSI" describe an actual character set according to IANA.

What is going to work best here is UTF-8 without a BOM.  Most Windows
programs can handle that these days, but some still don't.  If you try
to save things as "ANSI" without a working-tree-encoding and they aren't
completely ASCII files, then you will end up with some weird diff output
at the very least.

If the files are completely ASCII, then no working-tree-encoding is
necessary, because ASCII is a subset of UTF-8.

> We have a mix of *.ini files which are a mix of mostly ANSI and more than=
 a few others are Unicode.
> I don't know how to handle a mixture.
>=20
> Perhaps I will have to specify
>=20
> *.ini -text.
>=20
> Unless, does .gitattributes allow paths to be specified?  In effect use t=
he
>=20
> Path/path/path/*  text lf=3Dcrlf working-tree-encoding=3DUTF-16LE-BOM

Yes, this syntax is allowed.  See the gitattributes(5) manual page for
what's allowed.  You can even do this:

dir/sub/path/*.ini text eol=3Dcrlf working-tree-encoding=3DUTF-16LE-BOM

One thing I forgot to mention is that after modifying your
=2Egitattributes file, you'll want to run "git add --renormalize ." and
then commit both the .gitattributes file and any changes.  Otherwise,
you may end up with files that don't end up converted the way that you
want.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--sSCKaJ4+raA5Ldoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYRrkgAAKCRB8DEliiIei
gdSjAQCmFvbnkGu20tOXj3CrsCa0yP5O40qdKE+/KbkpUkcdXgEAmQg+PW0Ga4/P
hPYIQzFYLKYrBsoeUdU97AlUVt2s1QA=
=wBch
-----END PGP SIGNATURE-----

--sSCKaJ4+raA5Ldoi--

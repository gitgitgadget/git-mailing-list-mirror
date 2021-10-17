Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BCEC433EF
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB14C60EE9
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 21:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhJQVOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 17:14:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35424 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232561AbhJQVOI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Oct 2021 17:14:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 12DC860423;
        Sun, 17 Oct 2021 21:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634505118;
        bh=R5XOTHdiDL2xpV5+PV7pSBPYXiFE9mh+T8qJImNvoW4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KDhEj4XwfAjdQFgTwmz9iGzj/ZzdDvyGm5551PXmZN0L6+xz46m6/F/oHyHsQ6M+x
         bzUsERn8suW09pwnCqQs+GYlad3xnivDhkOO55l51kcEg5kgZFC98QXl4fug2RtXOT
         tMnHPTW60FxGgxgaSCC1aeve5EIWNuKvm8AZ+iZHeiVJFMRFdZNSPCV1pMGHM2+yzV
         uL4sZGAbqDBIzUCHWxMdk+1DKzJZh1Loiql0LgiAL+FpEGdlkVTAhJ40cTbVLwQuKT
         1R5My0FiK0LnI0oJCISox0xwcbUc4pY/iEpU8Hwt/M9pNS+t2r8+DVDRDXbAWcNr3C
         8ukDoJijDduprtUJXRL05CjRP7MIzt3pzWiZyunTXFQQqezbpYzDX3VaEbRRIwvgsY
         rvlpuiJjMJ/v6wCJlW9Bf/YAJWEwpm4YRVHsJ1DKaojoSx5j/QNXzlFcAyrCcHV9rJ
         kHBLcjaHka4gPwY2DhquuGMIoGQqYqIwKOBUPQt1Co+Ay89/GsJ
Date:   Sun, 17 Oct 2021 21:11:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     some-java-user-99206970363698485155@vodafonemail.de
Cc:     git@vger.kernel.org
Subject: Re: Suggestion: Allow .gitattributes to specify executable mode
Message-ID: <YWyRmT+ln6/p3DjF@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        some-java-user-99206970363698485155@vodafonemail.de,
        git@vger.kernel.org
References: <a5a41a53a50448a0829dc3bb8681f5bc@vodafonemail.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9OEwxB5Yy6nWcmtH"
Content-Disposition: inline
In-Reply-To: <a5a41a53a50448a0829dc3bb8681f5bc@vodafonemail.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9OEwxB5Yy6nWcmtH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-17 at 20:56:05, some-java-user-99206970363698485155@vodafonemail=
=2Ede wrote:
> Hello,
>=20
> some build systems have script files with certain specific names which ar=
e always intended to be executable.
> For example Gradle has a `gradlew` file, and Maven has a (currently unoff=
icial) `mvnw` file.
>=20
> For Windows users these script files often cause problems when checked in=
 with Git and used by a CI (continuous
> integration) system running Linux. The CI build usually fails because the=
 script files do not have the executable
> flag set (Windows does not have this concept).
>=20
> Would it be possible to extend the `.gitattributes` file to allow specify=
ing that files should automatically get
> the executable flag when added to the index? For example Gradle's `gradle=
 init` command already creates a
> `.gitattributes` file; it could then add such a default entry to ease dev=
elopment for Windows users to make sure
> they add the `gradlew` script file with the correct file mode.
>=20
> Assuming the flag is called `exec`, Gradle could then create the followin=
g `.gitattributes` entry:
> ```
> gradlew    text exec
> ```
>=20
> It might also help with questions such as https://stackoverflow.com/q/142=
67441.
>=20
> What do you think?

I think this might end up being duplicative on Unix systems, but you
could implement this with a pre-commit hook if you wanted.  Something
like this might work:

  #!/bin/sh
 =20
  files=3D$(git ls-files | git check-attr --stdin exec | grep 'exec: set$' =
| awk -F': ' '{print $1}')
  files=3D$(git ls-files -s $files | grep '^100644' | awk -F'\t' '{print $2=
}')
  git update-index --chmod=3D+x $files
  git add $files

This obviously doesn't handle filenames with spaces, so it would need
some improvements, but it might work for your case.

It may also be beneficial to actually check this in CI as a first sanity
check, although it sounds like this CI system does this implicitly.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9OEwxB5Yy6nWcmtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWyRmAAKCRB8DEliiIei
gcoPAQCjfP0yYQPRvvO+UBpSXlajXpIr2pNCWPQVARuP+7yzYAEA34/nzOLTo6ai
0z9KQNtvtgXYBxGI49OJn25lzCMRuQE=
=FFjG
-----END PGP SIGNATURE-----

--9OEwxB5Yy6nWcmtH--

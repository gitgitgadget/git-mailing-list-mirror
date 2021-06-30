Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A2EC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B56461454
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 20:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhF3UXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:23:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233847AbhF3UWx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jun 2021 16:22:53 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A090760DF2;
        Wed, 30 Jun 2021 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625084393;
        bh=ZxT0jQItfeYZERqW6u+9GpJ6X+aQWbl1ReP7Y7sLEik=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FLsNwNbEpL7q54XQgzPljZcvCBGC9Xt0XmTuyVjANPi38rfC35VfgM9wbBZG1kzPn
         1Da002/CpXCTZ3Ks/T31CiDyHNve2l1BpofPfc+oCMdtx+UKvfys/NlsF7Re8NMpuS
         jrDCz7g5OcX4MqU/Whpm1ALzWHacuKWfSgWtsK/alUBp8TmXRY9KfAe8UzDvqOy6RD
         VTc6yAES4NqbfJ/f4UFicPEuXIkecjSLlGnrm+NyjyyMXzBgZrd9v/LYOSmlRQesx4
         gnZhSetYKu4HHgM3/JMDlfQRP7Sq+Oyx4NqKjlKLd9lgv6Jf5RINIGjZEKp2gsSc1N
         5uSf0eoRwP5MBPomBsmWJ6uY3EGnXLi/dEWzwjhaBtRBqQFlBEbs/UV33nZOOHSwd+
         NmH787Bq5c1X9UhdPxxZYKISjiBI+G5mSCe/+7DfOTpPbs0VL88ev2+IeV0pQcXUK4
         bmc0YqZ5xBZeVqc07HjpTSmVIae8pIUJlckihRMG9IbJ5Aet1Vf
Date:   Wed, 30 Jun 2021 20:19:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Structured (ie: json) output for query commands?
Message-ID: <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
 <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbiiyf2LK/u+V22q"
Content-Disposition: inline
In-Reply-To: <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vbiiyf2LK/u+V22q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-30 at 17:59:43, Jeff King wrote:
> One complication we faced is that a lot of Git's data is bag-of-bytes,
> not utf8. And json technically requires utf8. I don't remember if we
> simply fudged that and output possibly non-utf8 sequences, or if we
> actually encode them.

I think we just emit invalid UTF-8 in that case, which is a problem.
That's why Git is not well suited to JSON output and why it isn't a good
choice for structured data here.  I'd like us not to do more JSON in our
codebase, since it's practically impossible for users to depend on our
output if we do that due to encoding issues[0].

We could emit data in a different format, such as YAML, which does have
encoding for arbitrary byte sequences.  However, in YAML, binary data is
always base64 encoded, which is less readable, although still
interchangeable.  CBOR is also a possibility, although it's not human
readable at all.

I'm personally fine with the ad-hoc approach we use now, which is
actually very convenient to script and, in my view, not to terrible to
parse in other tools and languages.  Your mileage may vary, though.

[0] I worked on a codebase for many years that exploited its JSON parser
not requiring UTF-8 and it was a colossal mess that I'd like us not to
repeat.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vbiiyf2LK/u+V22q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNzR5QAKCRB8DEliiIei
gUwfAP9wjJfvGL+8KXqNnt8VYSXgaFGzT27MeJ4k2oEhfsJUAAD/TnlGrX2q3970
BYv4leRX9Ghu4SlUZgsTDuY8KlBTZw0=
=XRdM
-----END PGP SIGNATURE-----

--vbiiyf2LK/u+V22q--

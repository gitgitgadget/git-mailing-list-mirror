Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE264C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A066C61B27
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbhKQXd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbhKQXd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:33:56 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C8C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:30:57 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 918905B463;
        Wed, 17 Nov 2021 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637191856;
        bh=/DssRP5WHyMmbcKsiWvZE55RLpBGB2Pw+fX6C6XXe/0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xs4ZZt0jxrg8lblThiDIqsk92DLHvPEj6V+vxILvk7sRlBdDSMOlDoecLTkr8C19R
         3GicychrOwjsc0LWyrZ1W0JcJ5Dvkni5FjgBwADlIhMGyDx6dABgTO0ZBCKmgfIfhh
         SRK6WzBYBJcp1uhgxjdAj0HGVSDBeOmaw4/j9/OkJ59Ih7RkCqYEauxQanZ0ZH8OV4
         VzkP9dCWD92O7AYbVq2z8iuV0gt5gDZV1u8WNofLXeIS/Ecfr9adDzj3txcXsXj0rB
         y4ne42Ad9kEb5yvaMw31ZUiNTwPBveoVDO/KmdBuzlL0o8SpKYGYq6aBbKzJIUuaz4
         1LXH9uyrhWPuOIwjnBTKDLRjXAJtCGyS3zFiyhH3vEUeF762CYb51cvTlrRQiZ3FXk
         d5Ey1G5OPUi8fA+GGVP7INovdXKdH58ERu5fiJDyP5sQJp+LKACXeb6PuNx/xtD9+m
         YbDWs/oUDxWAk8QmqhLQrGZv8s5x3+UN8B8BGLPHIrY34xuNFJM
Date:   Wed, 17 Nov 2021 23:30:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     rsbecker@nexbridge.com
Cc:     'Jeff King' <peff@peff.net>, 'Carlo Arenas' <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZWQroXwOKIi8Zs4@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
        'Carlo Arenas' <carenas@gmail.com>, git@vger.kernel.org
References: <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
 <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
 <00e001d7db40$985c61a0$c91524e0$@nexbridge.com>
 <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
 <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com>
 <YZRxOrv9JFt2oeSU@coredump.intra.peff.net>
 <CAPUEsphh-enSYS66mi7_XaS0n1bmUvGXRcgVp6iqhg94xSHVog@mail.gmail.com>
 <YZVfrhos+lZas7hk@coredump.intra.peff.net>
 <01a501d7dbf0$7c538000$74fa8000$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AZ6IJHrpUcz/8tyE"
Content-Disposition: inline
In-Reply-To: <01a501d7dbf0$7c538000$74fa8000$@nexbridge.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AZ6IJHrpUcz/8tyE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-17 at 20:19:49, rsbecker@nexbridge.com wrote:
> I missed this one... lrand48 is also not generally available. I don=E2=80=
=99t think it is even available on Windows.
>=20
> If we need a generalized solution, it probably needs to be abstracted in =
git-compat-util.h and compat/rand.[ch], so that the platform maintainers ca=
n plug in whatever decent platform randomization happens to be available, i=
f any. We know that rand() is vulnerable, but it might be the only generall=
y available fallback. Perhaps get the compat layer in place with a test sui=
te that exercises the implementation before getting into the general git co=
de base - maybe based on jitterentropy or sslrng. Agree on an interface, de=
cide on a period of time to implement, send the word out that this needs to=
 get done, and hope for the best. I have code that passes FIPS-140 for NonS=
top ia64 (-ish although not jitterentropy) and x86, and I'm happy to contri=
bute some of this.

I think in this case I'd like to try to stick with OpenSSL or other
standard interfaces if that's going to meet folks' needs.  I can write
an HMAC-DRBG, but getting entropy is the tricky part, and jitterentropy
approaches are controversial because it's not clear how unpredictable
they are.  I'm also specifically trying to avoid anything that's
architecture specific like RDRAND, since that means we have to carry
assembly code, and on some systems RDRAND is broken, which means that
you have to test for that and then pass the output into another CSPRNG.
I'm also not sure how maintainable such code is, since I don't think
there are many people on the list who would be familiar enough with
those algorithms to maintain it.  Plus there's always the rule, "Don't
write your own crypto."

Using OpenSSL or system-provided interfaces is much, much easier, it
means users can use Git in FIPS-certified environments, and it avoids us
ending up with subtly broken code in the future.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--AZ6IJHrpUcz/8tyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZWQrgAKCRB8DEliiIei
gdldAP4uQmpwhCJlwbCYOGeHUq985ZK6+IXF+3VuWQhVK4AiIAEAiYOZ0NwdsZ7V
phqS6R9gEE/LBkvVz90cH7lBJgfdgQk=
=zp/l
-----END PGP SIGNATURE-----

--AZ6IJHrpUcz/8tyE--

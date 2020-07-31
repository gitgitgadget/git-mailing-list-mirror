Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18D8C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C435220829
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KRJ50Wjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgGaBFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:05:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41276 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728080AbgGaBFr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Jul 2020 21:05:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1F44260479;
        Fri, 31 Jul 2020 01:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596157546;
        bh=Sh+pSRiAgwWraz5B+Zto92LVH4CBEQIKt2V79N75MAQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KRJ50Wjbw+/7OyS7lCjP62t5kx965DOwS7VU3VDuQFGATd7E4sDHHdpKEZAMzny3t
         8q+NqQ+k3fEA0Jg2/Xs/t5dkVCFI56+5PeuvTgrgtjBs8Jt2IVs2atLjcliDZK5qTG
         RitpFlCrDnJU5Pyl7JZ+pdM1DZ9qeSsijN+Zi1FzwruRXYaEuwEFlZr47ydUTiiMrX
         0kTZvUY25JzcFzNBWhTefabjGZ7WNnZI5qlMBkh3Bi+uDi5VITzIocyeOTfGSWKLxU
         e3idKIrTIJ5udMxE2MWJrOoinPKRjKC21sekyT+Lz5Dc1YicCieu37pSXirGP1XkNB
         YKySS4rzyyQ+YVrA2gzdLKkDjRIUjGaqz7hOr/a/rhsY+GZHkpofUyCc7qcQ+9ghEB
         GqAzMMBK2KjK1hi84RaoVdkCWMtXw+bNa78a+rgbHx3Su5geGzX3+nRhGGlJPp1c1T
         PWCvc0feYaOBniGX/CV4YRPyiiwAVx9GV9r10FzTT2MK/usQuNl
Date:   Fri, 31 Jul 2020 01:05:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bram Huenaerts <bramhuenaerts@me.com>
Cc:     git@vger.kernel.org
Subject: Re: Git union issue
Message-ID: <20200731010541.GI6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bram Huenaerts <bramhuenaerts@me.com>, git@vger.kernel.org
References: <A7C11212-1ECB-4D8D-B3B1-C7DB6673F3E6@me.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <A7C11212-1ECB-4D8D-B3B1-C7DB6673F3E6@me.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-30 at 18:29:10, Bram Huenaerts wrote:
> Goodafternoon,
>=20
> while trying to reduce conflicts on a changelog file, i tried
> eliminating conflicts using the .gitattributes with union defined for
> the CHANGELOG_UPCOMING.md file. I included the steps to come to this
> very strange issue. In the enclosed PDF, I tried to specify all the
> commands so it is easy to reproduce this strange issue which I hope is
> not a works as designed.

In general, folks on this list much prefer it if you include your text
in the body of the message as plain text instead of using PDFs.  You may
get more responses in the future if you include the text inline, since
folks will be more likely to read your message.  (I was personally
surprised to see the list accepted PDFs; I did not think it would.)

I'm not an expert on the merge machinery and especially not on the union
algorithm, but I believe what you're seeing here is due to using a
merge-based rebase.  In this case, your rebase is removing lines a and b
on one side, but the other side has y, a, and b.  Instead of a conflict,
you're getting the union: y, a, and b.  If you have an empty set of
feature lines on one side, and a set with some items on the other, then
the union is the latter set.

I agree this is not especially useful and probably not what you wanted.
The documentation does state, "Do not use this if you do not understand
the implications," implying that it's tricky to understand, so I'm not
surprised that it's confusing or has unexpected behavior.

Of course, someone with more familiarity with the merge machinery or
this option may have a better explanation for this than I do, or
possibly a patch if I've misunderstood and this option is broken.
Hopefully some such person will chime in.
--=20
brian m. carlson: Houston, Texas, US

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyNuYwAKCRB8DEliiIei
gR1mAP9oV527ojY8U2hGzvQj7a/0P5bGmKCu74SAOKzbok9x+AD9HHCe66LdkHJn
AHfYT2fD/tKpcMR4n8Q1cz8rAc6SfAc=
=Qja4
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--

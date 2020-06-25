Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E80C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 01:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D7E206EB
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 01:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L/eLz8ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbgFYBja (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 21:39:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40190 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388778AbgFYBj3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jun 2020 21:39:29 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7D7756048A;
        Thu, 25 Jun 2020 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1593049137;
        bh=DDHWKQ9RjUPvGFmimsOyfGdxb6rWaGV0L6NEhPzC0N0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=L/eLz8utcOhxo7DgrrSj3DBg43D762VeXS/dHEeHsRCfbuX/n69c1dccG9dL4p0Ys
         DR3VesRURMpJYUe38xKtdART5XUcLGhlJgMVH2OfXK5Rstr5Q+R2j231k8telJ5sc2
         Vf/C4BOTH69S1GGK10Iwjw4f8o3ieeNY1xdtb0AkFw7D5ytNtm1ja51xNh0TIRnXgF
         Cl5zq8UI4nf8pEVC1gUPrpp9u4WC1Shi/oHkmlBkNxY6ZM6cty5B+dp3voFrDaYZFC
         K7RFtAEZYz4LlyXf18eChIkAS/QufiCLSHu1DrOlB9PT92wevAE4VLLw2we1jaXPiv
         LmCPvi2OHjYgBThrXx9Pi/PEllr6/v/869CPVD/tHf1bFOS1vBvPtxHtPklBvowrzh
         07x6q06VeR5Kh1uJA6WWNddexJYrbJ/YyCFukm2OanlkQ0q7XEwGeDqOH6+V2GiRwB
         fuFKz8I766jA+1hRX16X9wHYk4AqhW5KYUF+aWjEI+tfmVLi923
Date:   Thu, 25 Jun 2020 01:38:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC] Thread safety in some low-level functions
Message-ID: <20200625013851.GA9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
References: <CAHd-oW5zh=BG29O0Z-M7R26Lgd=RHECMV2+qByF+vU6PmrEn_Q@mail.gmail.com>
 <CAHd-oW5jCWeWDcMhLU2Zf96uTtxLehVsM+StDC8LZga282cDjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <CAHd-oW5jCWeWDcMhLU2Zf96uTtxLehVsM+StDC8LZga282cDjw@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-24 at 22:52:58, Matheus Tavares Bernardino wrote:
> On Wed, Jun 24, 2020 at 7:29 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > - Regarding, oid_to_hex(), a patch from 2010 [1] proposed a solution
> > using thread-local storage and pthread_once(). But as Hannes pointed
> > out in this other thread [2] , implementing a Windows equivalence for
> > pthread_once() could be tricky and voluminous. Since this thread dates
> > from 7 years ago, I was wondering if we would be able to implement it
> > nowadays with InitOnceExecuteOnce() [3].
>=20
> I forgot to link it before, but here is a commit in libav.git which
> emulates pthread_once():
> https://git.libav.org/?p=3Dlibav.git;a=3Dcommitdiff;h=3Db22693b06d1e5d734=
54a65c203b4d31c1ca5b69a
>=20
> The patch is not so big, and if we consider only Vista+, it seems very
> straightforward. I'm not very familiar with Windows, though, and I'm
> not sure if this solution would work for us.

I believe Git for Windows dropped support for Windows XP some time back.
Regardless, since pretty much nobody using Windows XP (with the possible
exception of ATMs) is getting security support, I'm fine with ignoring
it either way.  I am also not a Windows person, so others may have more
insight.

As for the general idea, I'm mildly in favor of it.  While I don't plan
to work on the project myself (outside of cleaning up places I'm already
working), I'm definitely not opposed to seeing patches come in to
improve thread safety.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvQAKQAKCRB8DEliiIei
gUFjAP0SGKc84tFHx630cOK6Ql7VzhqQ3yEnsk2MwPxkRPiaVQEA+qD+J4EhJWTq
dLKPUdToDcAHtxLQUf7CFmyEZ6Ho1gQ=
=xTnX
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

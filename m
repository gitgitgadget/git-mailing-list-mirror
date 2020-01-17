Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC54C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E32022464
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uXVLPLh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgAQXji (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:39:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730117AbgAQXji (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Jan 2020 18:39:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D461B60426;
        Fri, 17 Jan 2020 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579304376;
        bh=gTqkSjj25bYXx+7E0XF520yli7+eLt0xIDmNJWjcwgU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uXVLPLh1KQGhbLLO7RsNJ1JRDo+OBA7bfBzJdyNpRswS2SuIac8rAOKZcOtzGN+lN
         PPVtbKF4S1nvvSpVuM6PbDrDaEeckOjt2qUY5Oo5PRGvcEWGqhgLBpHV/iBgQ4Mra2
         Z0lA8ErnrCGQlWTiVo7oan20LtjD0hDxse2CcaxL3eFyMBJV35ank39xhyIuFw5OOE
         h0th7r0akwZ8eVHVv+gHw+oQv8RMQPmwC9gCT72BJacK7WmEyykgHc3n296nYJAKza
         HrO74Waz+kVzldqyh2SPLsac3TkLdy8luz24+3gxjLnSyQxkJWU0uqq5FDryd3Ev5z
         XyVoZfmgXJPYDvY9qV7OOLWI01IuIQLWrn4Frmq5U4lcJ+8cNAJhZptP4gX15W2fX4
         gnuLf5RoS2VjbnQq1GqS+besVbH3TNXNq0MZl6B5835XOTHld5xs0/jlxECRbBBqy6
         xsgLxrWzj/y6nPcO6uaQMy1Pw6qOJ0BIR4DGGwdsE3hmcksPLfN
Date:   Fri, 17 Jan 2020 23:39:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: use compat regex with SANITIZE=address
Message-ID: <20200117233931.GB6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20200116175138.GA691238@coredump.intra.peff.net>
 <xmqqr1zydlwt.fsf@gitster-ct.c.googlers.com>
 <20200117174931.GA8958@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PLVMksexArUZ/iL3"
Content-Disposition: inline
In-Reply-To: <20200117174931.GA8958@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PLVMksexArUZ/iL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-17 at 17:49:31, Jeff King wrote:
> On Fri, Jan 17, 2020 at 09:37:22AM -0800, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > Recent versions of the gcc and clang Address Sanitizer produce test
> > > failures related to regexec(). This triggers with gcc-10 and clang-8
> > > (but not gcc-9 nor clang-7). Running:
> > >
> > >   make CC=3Dgcc-10 SANITIZE=3Daddress test
> > >
> > > results in failures in t4018, t3206, and t4062.
> > [...]
> > I guess we should treat this the same way as the recent vcproj "fix"
> > by Dscho, i.e. fast-track to 'maint' to ensure that all public
> > integration branches has it soonish?
>=20
> I don't think there's a huge rush. It only triggers ASan and recent
> compilers, so AFAIK nobody has been hitting this in CI. I occasionally
> test with whatever is the most recent compiler in Debian unstable to see
> if it turns up any interesting new warnings or errors (but gcc-9 is
> still the default there).

I've reported this as a bug to Debian on the clang-8 and libasan6
packages, along with a trivial test case.  Hopefully this will get fixed
soon.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--PLVMksexArUZ/iL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4iRbMACgkQv1NdgR9S
9ovgAg//UHHoO8Qhfc8swOWPUTsqv2SNAmRnjFdzYGFNckPCb0EeoJ9fa0x4Rf72
61lrbcsptIz2qF/s68ulpfQ1k9sNqEWdGGuzN8LcD36yBCkGipgV1FDvSjfBaQ+g
VGiuQlAs2Sr6QI0cItlJyPBYSaxLzO7bSuOHXrL/4Q4KsQgkN0PxN4QL+e0/TGeu
tzHFs2c0MsFqQ4Uqt3/Pkbns/XyG2+0FZwFVmZQfst0d3Q0qXN2Uvx4TjeOuo1i6
S1hOyWG6cO2Z2XU6sAsechgbIboAmEvURDCCh6H6BNYPfbLnGXdoIKgqkMvuEwPj
ajt/anQZ0pdSoJCA7BrsZGRrsZrYuBCkw1EEQtmun5RygFXlCKg6qdcGPEcVBEuy
iksrLQW3Hq25N37QYJt8gN/AG9jR6/jseKXgDhlEZjxksP0H0qRCtxi6la+WxPuM
Yedvk/LDurv4XQa5GAz4bkOm1mOvgHzBTkbJuqrWy04kdtvicIBHYZw5gnEs94r3
c4Wd951teJ8s68KD71UwQqEzEfOLNws+Wpf2xNAdwCRvTIsv3gSlYMwEhbrf+/iZ
kpfQsFNhI1btX4QP3K/g3lIoJFvctNfSGZfFpdbXCO4cTJMfl9SI+KZMC6huMUPR
VuKuT7gjTREonJ2PU93yvFfGflgIUM9yDePRDlQGOLuZTLfDHB4=
=l5IV
-----END PGP SIGNATURE-----

--PLVMksexArUZ/iL3--

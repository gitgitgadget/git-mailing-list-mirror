Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BA0C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 22:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B41207F9
	for <git@archiver.kernel.org>; Thu, 28 May 2020 22:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0QkQ/0Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437295AbgE1W5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 18:57:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38934 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437266AbgE1W5k (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 May 2020 18:57:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 690536045A;
        Thu, 28 May 2020 22:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590706658;
        bh=qs4d+qm3DU1jTR/femDBjY7ngS5MyHs8y8gxMyGfB+s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0QkQ/0AeMHSVVyMVHbA5OzWEtVjn86WSB24FSfqWpGq/TvP8I6EfVTutGzzalm+M7
         KeLvZSUmzZmEkzA6cDkpLY5FfNgoPqnMByzXAldB757kRnzmy5fcMANBtgO1NE3WK7
         PZaWd4ezBQO4xBZk5EIFp81apR77znU2bFXjmw1u21SuW58f6YjfDjOFYvTbB+XLuP
         LMADRmap3a7BFRl9ZpEj5rwLqrMfRcTwBuIKi3ui2GUnrM6ZcpPmQ4BznRBoydO/Ng
         5UFmUQG85mH167pmhowxrqkHtGLzj2mAbIwL6iOKVGN9503UQMQ/V/VaUXZjbWU1u8
         azH4ES/YmAOScNPePHP8NJnfy47o5VR/JQaBJP8BEp1AweE5gAn7uLs/1c0Xd1QWpM
         KpNwwmSQrV+gEw+XtQaoc8aM+XM3eE7hwTZdLoZcwINmmPukOhAdYqk+vTEK0Z4a1R
         LYS8HDG8NNh8YXLL7bJRgaAmrxpb2rnaNAFalu4BKgk+tCGqQSP
Date:   Thu, 28 May 2020 22:57:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
Subject: Re: [PATCH] completion: use native ZSH array pattern matching
Message-ID: <20200528225733.GI1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
References: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
 <20200526235834.GG1915090@camp.crustytoothpaste.net>
 <20200527061359.GB40564@Carlos-MBP>
 <20200528021727.GH1915090@camp.crustytoothpaste.net>
 <xmqqd06o3vhy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KZLWU/9q3evlN4nQ"
Content-Disposition: inline
In-Reply-To: <xmqqd06o3vhy.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KZLWU/9q3evlN4nQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-28 at 15:54:49, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > Yes, that is what I meant.  I'm glad to know my question has been
> > answered and things work.  I'm okay with the patch as it is in that
> > case, although I'd give bonus points for mentioning that this syntax
> > doesn't regress bash.
>=20
> True.  And we would want to also have tested-by on more recent
> versions of bash, no?

Sure, such testing would be welcome, but I believe those are tested with
our tests on most platforms.  macOS is special because it uses the last
GPLv2 version of bash, which is less capable in some ways.  I assumed
that bash would not be more likely to break here in newer versions, but
perhaps I shouldn't make that assumption.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KZLWU/9q3evlN4nQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtBB3AAKCRB8DEliiIei
gXWlAQCzMSJWA/YkyaNz5SDEA+UnEjL2TAK9I4eQ5MiytzprkAEArACuIbVhwep0
xaiiQ/f+LmzZ/cwbpp3jb+KYmC0tOA0=
=7snB
-----END PGP SIGNATURE-----

--KZLWU/9q3evlN4nQ--

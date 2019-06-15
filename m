Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0101F462
	for <e@80x24.org>; Sat, 15 Jun 2019 19:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFOTPV (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 15:15:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60084 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbfFOTPV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Jun 2019 15:15:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4429:e8a6:430:6b59])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EA35A60100;
        Sat, 15 Jun 2019 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560626119;
        bh=KY6f01F+ZjpWCQCdvKsauxXv0IRZ1gm0/dwPP2ne4Uo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LHa5t2d6HlbzQ67TM8UQB23QDesZwwNuXhUTxvYa17ySpNS2VtVIeFam5JkuQJ5Gr
         /rauLetqtrTybzQtOgPFW/OG0Wu2CETfrZL82pITlkSwwdiy9Bt9CqjQJ5totEr3a7
         GsRy6SV3YKcKukatbnrUpjpeblIiUJV9S3P/McrayOiNXRO8bPUhB9CHOHKWaPg++u
         hSa9fKhPIR9EdnW79VErr8ilUnJlMitYdQSCu1kwmvYTmWb9fhaKKT+fzTIvQKHbXJ
         Naf0PuOIRSs6vfn8Po9YNWBFKiBpDVxpOac7HNiWiAUoPhcfWAjXkCH8/kslRCCEF0
         Z40drmzgTnEOhlelhb373VpCw2E++sMv/O2bnJ3ub00mqlcp8eza6X8cm2Jf8jy2OT
         xqFCFSOjPOf26hUV8zJvlXJKTuW4Ost3YSEOOgzUvDNPE/9zBAEfnYpoSneJlI4pyb
         MM1vESDiHC+xv7Cz6SNf4UBC+Y3KBBNBIlTayLhbosqxyotcp51
Date:   Sat, 15 Jun 2019 19:15:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git-packagers@googlegroups.com
Subject: Re: Can we just get rid of kwset & obstack in favor of
 optimistically using PCRE v2 JIT?
Message-ID: <20190615191514.GD8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git-packagers@googlegroups.com
References: <pull.265.git.gitgitgadget@gmail.com>
 <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
 <87v9x793qi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ilsi/0vOxQ+fn9lZ"
Content-Disposition: inline
In-Reply-To: <87v9x793qi.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ilsi/0vOxQ+fn9lZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-14 at 22:55:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> It seems most packagers build with PCRE v2 now (CC:
> git-packagers@). I.e. we'd keep something like compile_fixed_regexp()
> (and as an aside just use PCRE's \Q...\E instead of our own escaping).
>=20
> We'd have performance regression for platforms that use kwset() now but
> don't build pcre2, or where pcre2 jit doesn't work. Does anyone care?

I know that there are people shipping newer versions of Git using CentOS
6, which IIRC doesn't ship PCRE 2[0]. Since having to ship your own PCRE
is a security maintenance nightmare, it's probably best to leave this at
least compatible with non-PCRE 2 systems until November 2020. At that
point, I'm happy to drop support for it.

If it would work but just be slower with PCRE 1, I'm not too terribly
concerned. Let that be an incentive to users to upgrade.

Also, as Carlos pointed out, not all platforms will have the JIT support
functional, such as OpenBSD, NetBSD, and PaX Linux systems. That may be
more of a blocker than the CentOS issue, especially since people run PaX
kernels with standard distros.

[0] I'm not certain because CentOS 6 Docker images segfault on newer
kernels and I'm too lazy to download a live CD image for testing.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Ilsi/0vOxQ+fn9lZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0FQ8IACgkQv1NdgR9S
9ovs5w/+NJhAjpfCjzba55zHh7CEcF1wV9JtriYR8fHchapnPbVC2GM/4zaCqFdB
5o0HibFHVHacSMSp5YTmbeAbmiIhF4n5Vaxk+v2uz0m/u0iuEehxlTEPtM0jZhSc
hxhiuGe9HYvnlKNjveWMGD1AWUG92jktgEwxK6qTXD/NB3RN0iFhOyJXP4XNXRrD
xeP5XzzsZO43P3heYJBpLTOTJZDsmwMP0nG/tt4chOfAzRIyzn8lLeO4e/Ko5cH2
SLvPC+Swlr8h+oF2KdGnm3VfgJO3xPGJ9k5hYUqKLfWKHsimgFTrRNzOMspzIgaZ
1wrRomX9Hpzi+3xbef1n2awCouq/mnX+9YGwKoOmgFOG6UiolS/Fa0zWEYiyjrl1
4RQO3Dqq9wHVDPa0hyGTWYIkg7JnvqflKObDn4ycrCM1qbpfwhYf4VLO9qgdaLlV
dtqcO1v1SqRT0Nm2/df8h9fH6eg3GMjT/RyqLvMCrcC3TwLSX4QVnpKzff3Ju+gu
SBY4y1Yy7LDxLHMYN34bvgB7s1XeVu+xoYRyyczS06NbrlEGL+67jePpUzUhje52
YE8CUMizGDzujRe9b4Vtrts5OqCNskeQsOzDsLLL2HhJJqhQJkgqMHzDKiCP8rI5
4Ri9Y1Xr3ByyMwQNzYBEpEKex49DjU8811IMDY1mKGV3ihoZoLk=
=Bc7G
-----END PGP SIGNATURE-----

--Ilsi/0vOxQ+fn9lZ--

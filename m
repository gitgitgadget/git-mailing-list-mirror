Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C949E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeHPAO1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:14:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40764 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeHPAO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:14:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so1001207plp.7
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version;
        bh=JtjddAipZs9Wm6CbCS3JEWmfoeIbByqYiCrjJ0z+y1c=;
        b=M1nk0gRRBcPnMaBjwuW1ufV98mIHiUyqEvrZsRs0Cyn97P0bmGA4CDw4fXaCFnpTlK
         Etv1cHIRHZv2QlgDImoEpkZD2K11IcLAZW5vmeGtSCy7YYd10fc/OiVfOyvTnL//VwuM
         kBJ5MCFHVAqC1uM5aIwnsC6TLYNuKhff22VBI0ZgCeZJ2qNPkBUF5F6Y3EdYS7Q6lnIr
         FLhH7HMC/AQ0MF///rwYtvUwLDgD8tNLPKOpICoSShMQ19jBQM46KIWmALm+6RBLnT1E
         44+B3r6EscYb+94jVqnFp074aY2jFZfLfyW9yapvoshIAXQI7o0fxhCUWZuRSYtxZ09f
         Gj9A==
X-Gm-Message-State: AOUpUlG5aJOe+73HbpzjpXFCmnBOh4e7B5rLowH/UJJRzwNrOF7k864E
        jBBsRIgikkG/sodcabiwX2QPsnyj
X-Google-Smtp-Source: AA+uWPw8pEpXLeJWZRtalzK4aDPDf/a+dXm+9pTupwwPKQNrmNrJfXrhKEHmcqlla0hTTIH8ymCPBw==
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr25735574plx.73.1534368032832;
        Wed, 15 Aug 2018 14:20:32 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a17-v6sm35340779pfg.106.2018.08.15.14.20.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 14:20:32 -0700 (PDT)
Received: by 2002:a6b:c8cc:0:0:0:0:0 with SMTP id y195-v6csp493226iof;
        Tue, 14 Aug 2018 23:43:47 -0700 (PDT)
X-Received: by 2002:a63:f206:: with SMTP id v6-v6mr23956317pgh.319.1534315427184;
        Tue, 14 Aug 2018 23:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1534315427; cv=none;
        d=google.com; s=arc-20160816;
        b=O8IVxIeJGzvZaFofEkEvhHIJG/1Kc+z/PXOViNSXoTS7Np+2m6Saia5S4bpyHFckfb
         PPCdb56/Ao1Ad7byqM+3rg8kdIvNw3hMNxpsJ3XmRQY8dVaONXFT78nZXHg765PjFIc8
         4k0NneiPtkZyVgBF2Uq0086UhYqKtCNevH6+ju8LzHkX7vfkzgyoQSpTRq2knPvNZ3tv
         p1+oFRyHJxpsrxq7Vh4jNtuIqhdbgSZ2tyTADgcIXrp8DKrRMy0Iq+DidpGVKJmUmByL
         GSlryHEaLkB+6vn62EBSjU5MFECkpamdY6dkcb0rffDLA8BW2JBDmqMiXw2EykLgACsT
         hMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:organization:references:in-reply-to:date:cc:to:from
         :subject:message-id:arc-authentication-results;
        bh=JtjddAipZs9Wm6CbCS3JEWmfoeIbByqYiCrjJ0z+y1c=;
        b=ce7oHby2ow2tAT11xDFG6W5TOThicglya4dBb8vpkVT/spo9TAdlEPdr1cF15SXfS8
         sJI80fGgFoFINEIeZsKgJ8lwjFoVZGwEtk02sU9QjROXBrmSmUEUT5yrKOOSqe8eAaNR
         meJVANe4fgn7xjGEauBsRoAhrbfWgG79/B1wVhqrMQS7q0hlSyauLlQIhVpFz5CjSfNn
         luxGcHy68X/fnpKsTzm2aX1QYNUOszMLesO5xoCY1fsNYES+8gAG0Ckv9H6ahExDtyKR
         jSBBW5dD0er9lDiHRrpMG/3BbqRETNnwgC0gAtdUm0wfnothegOzYcoararNkjNr5n4t
         Vrag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mgorny@gentoo.org designates 2001:470:ea4a:1:5054:ff:fec7:86e4 as permitted sender) smtp.mailfrom=mgorny@gentoo.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gentoo.org
Received: from smtp.gentoo.org (dev.gentoo.org. [2001:470:ea4a:1:5054:ff:fec7:86e4])
        by mx.google.com with ESMTPS id z4-v6si18038358plk.490.2018.08.14.23.43.46
        for <jrnieder@gmail.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 23:43:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of mgorny@gentoo.org designates 2001:470:ea4a:1:5054:ff:fec7:86e4 as permitted sender) client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4;
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 83711335CC6;
        Wed, 15 Aug 2018 06:43:45 +0000 (UTC)
Message-ID: <1534315421.1603.0.camel@gentoo.org>
Subject: Re: Potential vulnerability: 'mixed up' output when commit has
 multiple signatures
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git-security@googlegroups.com
Date:   Wed, 15 Aug 2018 08:43:41 +0200
In-Reply-To: <20180815053522.GI32543@aiede.svl.corp.google.com>
References: <1533898313.1249.36.camel@gentoo.org>
         <20180815053522.GI32543@aiede.svl.corp.google.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-8arD7AxPVnb6bsIHhzSh"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-8arD7AxPVnb6bsIHhzSh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-08-14 at 22:35 -0700, Jonathan Nieder wrote:
> Hi,
>=20
> Micha=C5=82 G=C3=B3rny wrote:
>=20
> > I've been testing the git signature verification a bit and I've
> > discovered a troubling behavior when the commit object contains
> > multiple signatures.
>=20
> Thanks for discovering this.  Do you mind if I take this conversation
> to the public mailing list?  (I'd bounce the existing thread there if
> that's okay with you.)
>=20

I've already asked somewhere else in the thread if you consider this
suitable for disclosure, and haven't received a reply yet.  In any case,
I don't mind it.  I can resend my patch there if necessary too.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-8arD7AxPVnb6bsIHhzSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAltzy51fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQoX2BAAyTuDuFdbXuCCGB6Ocng4PjO5nady/OMbD7oJ82RI5Bcf+Qv+neotJmS4
As9yeZRBYEn5g504GSx3WEw1i3W/NUQD8M9PQqaBPnisQlExC8CJqqeTLtZQNqHF
4i3idU8fbKuvMlBhAeTS1+YlbwFJCxTUBFuliZTBpjMM1932no3PtLZZoTZoYwRh
dK5CZTzELQxqTsKwvWTSE1SuYfeJ1DJdFdnEx3Vma2YGPPse7ngX8/4LiXQSPiss
vHFnkv6x0692NKIYjtJlcsdrM3GTtdcnmyMVWXf2kSAdGS+o1Efnlac2Vs2v6SsN
KVAnyE1BN5vK/Lm8Si3N1rGKTS7X42NYHtfcEIHoGCWmNNdJi+0spmUOKUKtUmB1
EBrF/GdMPBGhGbgGwMKVRnnoOJivGjA1MHwLoQNthgq10K86ndrBHFsFCWeoc5Cg
7Ddk4UEP2yHKMKtunOGGQsJFkoGeHqyIDRX6YyIk5W2C8fwokipZ9hhYuFQEVhiq
sBsDsOdDVmZNSo2LTwtzDgyBWrmtX6ldzQzT/KBZf7//PHL+GvBVXoi62vO7zJ92
zmQZn3Sa+INbl0kQ7Dt3klO6hRCJI1Vino7Fc2RX2QVAUsdOJx5ETccUwHYqcBWJ
iaDx+0K3EemPxHYv6rgVeEW6bRPcQ2tOZqL9EfnZCt+12YCVVHc=
=3ZtD
-----END PGP SIGNATURE-----

--=-8arD7AxPVnb6bsIHhzSh--


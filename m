Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16913C43381
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF37224B0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgLWUWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:22:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38374 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbgLWUWe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Dec 2020 15:22:34 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E8346076E;
        Wed, 23 Dec 2020 20:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1608754882;
        bh=pClzSxtMwwfHX6zzQUIoPN/3vrhngPEfM34Adyk6VRo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lTYjAkwLub1MyxyFm9MDcjrgV0jTr5nKezZ973trthzz/lXr8EPfFP+gN6VeFpdHM
         xEkJnvQx0PK4FGSUrMaCFiVXvmYE26qmXdB0KMK4svxwozbapAmGmw8cW4ec+hSlA9
         VJ01+AmHdMdfeMrbWXmYkLEEXIPcaMwBeJzq8fnDK+bZqmiujWSj1jecrH+5w2NtiF
         l3EpcT2YSmlFflxumd/nUVb+5kS1IKL9kMuIFOV3PQCZtgV24ib20rwwjkyCrnTl89
         YOESw8MAxcs8SWtD0sbZX8JGXva6PbM+jRIHdLX7SWKmuEwNAkEtK/uKeYuDDjHbgj
         9q7Pm5adtG4IM7tnOSVbPoHFdp7dCOA1Z+co39NJkrlu31omoFRzVR5vSDMRgQSGFn
         DByKfluZofj8TSDJ3D4RqaSlc9blLd6hTNjRxv7aAv3pAnhx6pMi8DTCWgIrzehb1R
         LCleApiFlzGt7jWXQIyBmhHkOzuZw7JpS5rBSGFhmDBa6tsRzTl
Date:   Wed, 23 Dec 2020 20:21:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
Message-ID: <X+OmuBDBHhdzHjzn@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>, Derrick Stolee <stolee@gmail.com>
References: <20200901074355.GA4498@dcvr>
 <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
 <20200901144323.GA14554@dcvr>
 <xmqqbleliq58.fsf@gitster.c.googlers.com>
 <20201222231702.GA17661@dcvr>
 <xmqqk0t9fmq6.fsf@gitster.c.googlers.com>
 <xmqq8s9pfkls.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wJZ+anNttNyxt+1G"
Content-Disposition: inline
In-Reply-To: <xmqq8s9pfkls.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wJZ+anNttNyxt+1G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-23 at 00:10:23, Junio C Hamano wrote:
> From: Eric Wong <e@80x24.org>
> Date: Tue, 1 Sep 2020 07:43:55 +0000
> Subject: [PATCH] core.abbrev=3Dno disables abbreviations
>=20
> These allows users to write hash-agnostic scripts and configs to
> disable abbreviations.  Using "-c core.abbrev=3D40" will be
> insufficient with SHA-256, and "-c core.abbrev=3D64" won't work
> with SHA-1 repos today.
>=20
> Signed-off-by: Eric Wong <e@80x24.org>
> [jc: tweaked implementation, added doc and a test]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I agree this looks good, and it's a feature I think is valuable.  Thanks
to everyone involved.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--wJZ+anNttNyxt+1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX+OmuAAKCRB8DEliiIei
gSdSAQDxK/OEjFNnHvrup4VAE28qerjmvk5l91vy8+m1P3GxEAD9EPEGuhNJv85S
btjGrKI1FcC+9imRRYFCNWBp+3sHWA0=
=382L
-----END PGP SIGNATURE-----

--wJZ+anNttNyxt+1G--

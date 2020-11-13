Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B6EC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809CD2225D
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKMXnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 18:43:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40408 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgKMXnZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 18:43:25 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C22206044F;
        Fri, 13 Nov 2020 23:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605311004;
        bh=f92lAnHL8JVglHw0XK134gkvQCwBR+Vj9MBCEuN1HUM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=O6OAnx7bmqFLgk35rHaAkbnxCyviwDQnkOJY8WuRMqhym/pSjNvhPOA0uBuT9FcoR
         /PKKfBtZZi31nQpXm1YUAL/hqV56ydjSrSlki+ta76lnLEBHqu050TEYoTS1mZQAEK
         zQiB3MzyvRrwonGuaImYiYxtrIIyz6cQAJhrpB/UBKGIJRHieBS/U18qBQL95Kb0Ad
         DL55SlWzKpus87KJo5cSajuLpFqL6f9WUpjZufcVxoGRJkCT+svyK+fgs6aFmnJsI0
         2LxB/4tr4ThUSIEKUPutkMnvfTj8k7SBgPCAd3mqBnbJYSxvQE93T0sRVG3mdJH8Ow
         1gighfOD8vILaQzAWJvjlMPmJT3cz6og1DF0HNmZyz9/FxK7D0a7OsI0sfsiFzOAE+
         0bUj1Kn312ZwwhwCBryqCJpUOtNTY+xTTsdgAUXcIn0EwFYTsn3xqTyrqC0bngm0s4
         OUvqJXyGtu9efLBrg7n3QQ1nIvAJAlMVftO+mPMm0A/jZq64qer
Date:   Fri, 13 Nov 2020 23:43:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
Message-ID: <20201113234319.GM6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20201113215307.20855-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q8dntDJTu318bll0"
Content-Disposition: inline
In-Reply-To: <20201113215307.20855-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--q8dntDJTu318bll0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-13 at 21:53:07, SZEDER G=C3=A1bor wrote:
> In 't5310-pack-bitmaps.sh' two tests make sure that our pack bitmaps
> are compatible with JGit's bitmaps.  Alas, not even the most recent
> JGit version (5.9.0.202009080501-r) supports SHA256 yet, so when this
> test script is run with GIT_TEST_DEFAULT_HASH=3Dsha256 on a setup with
> JGit installed in PATH, then these two tests fail.
>=20
> Protect these two tests with the SHA1 prereq in order to skip them
> when testing with SHA256.

Yeah, this seems like a reasonable thing to do.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--q8dntDJTu318bll0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX68aFgAKCRB8DEliiIei
gb0gAP4vkoW5ZM3IOQ6VQl3BPX99TvWccuauaoxRAZbR7dNRnQEA986Gm8U+wkYp
m+S1jlcD5hj+bVW1DQJEFtSxECMKRQY=
=jRrj
-----END PGP SIGNATURE-----

--q8dntDJTu318bll0--

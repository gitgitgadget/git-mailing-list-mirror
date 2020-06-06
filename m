Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB407C433DF
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBDF2076D
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WFzcdxwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgFFAcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:32:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39078 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgFFAcK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jun 2020 20:32:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2A49760756;
        Sat,  6 Jun 2020 00:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591403499;
        bh=6oc9J5OJxJEbUVY20eokE/jOZcvmgocd3zmjF2Fo/O0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WFzcdxwz10U72wRRZv0lbtbwiZFlE/3nMG7dQFEzJ6HWKhQg375hblnR98lshyay6
         lYMBMBW3FvalsRXEP9XiB3DkHMezYGEiUUtPNZ+W24Itd8IN6UTaxwvH7cLmyDXinC
         Yof8tkV7+FhKJ/jn0/JAJ/toLMK6t3T99VW+mXlofd5ohhWHwWcUHirZD0K0pyQieA
         VTwZwPDjfLhI35sEQKL67DQHP4xM86DtmbErry1I57emSvVXqAyaF9rEBq8VFm1G2X
         fsM2dvxqJxWQlVtCop8Oz6s1SHM5gi0VQc6NftrgXud2s0z/1MBem7hsozQmdB8PiB
         Lv/JtboK8O4BPBSQTk3KBi5nZkwLqi3ExlX9WEHOhnKhwqYECnV//JT0KxGFErKcdu
         H4/wwvY8U61qICH1SSwinjm9NgFrhw4p0oUeKdNxd0cpJ0RMrF1iriMBkbgFpubeuJ
         +3WUJVEa+PJ9O3IbxNXCumqKCWdkpQ1S0e5qLg9uoE7CU09M7Tk
Date:   Sat, 6 Jun 2020 00:31:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Billes Tibor <tbilles@gmx.com>
Subject: Re: [PATCH v2 0/1] Run pipeline command in subshell in sh mode
Message-ID: <20200606003134.GH6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Billes Tibor <tbilles@gmx.com>
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
 <20200606002241.1578150-1-sandals@crustytoothpaste.net>
 <20200606002241.1578150-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
In-Reply-To: <20200606002241.1578150-2-sandals@crustytoothpaste.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-06 at 00:22:40, brian m. carlson wrote:
> POSIX sh implementations run each command in a pipeline in a subshell,
> although zsh (and AT&T ksh) do not: instead, they run the final command
> in the main shell.  This leads to very different behavior when the final
> command is a shell function which modifies variables.

Sorry about this and the following patch.  I forgot to clean my patches
directory before sending, and accidentally sent some patches for zsh.
My apologies.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXtrj5gAKCRB8DEliiIei
gdqGAQD3T9LLRGrAkoknahuoTT4guxMI5/vXvCAqTlpvYIJQ0wEAxp+/6q/TW3py
zjWfgogPLQ/vpoa3BMky1jYvH/ctQQ8=
=C3jU
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--

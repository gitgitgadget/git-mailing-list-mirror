Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A0DC433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357C364E3A
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBGTKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:10:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43358 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhBGTKk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Feb 2021 14:10:40 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 992D660B19;
        Sun,  7 Feb 2021 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1612724969;
        bh=QczUHWJ4ONLmvwLnwQGff/R4bXl14ueV4Ul1NyNUfNY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DvEvJTmqFLYNxCNfYXeoAamO0wfDvMfeeEwsk5Q/jfpX00WYnGxyH6LEWl43bT3LS
         JxMIMfFByTMfataNgxPQ55qCaHoD2to5zMOmi0HlffRRv2HCNDo8K2wSD/toAGL9JB
         XCyypYO2+uQn0F8oKxzNbfWwdowfChkjWG9dgdAaWGgWZgHQPSScrScA8+d8luL4z1
         BjleefHxhC0f9e0MzqNEaJU9rpt/+a0lSJhse3E+W5fHgCCbOFq6LObuIxJUMNO+HZ
         Spnkg2gORE8yrdgS5Zxu/G1oUa3/RJts3QLUSQ4DTumHXc2mttxA5D3FYDGs5zJFgx
         dnX4PCI5fr8qdjOnq9+Xhb09uwFdLovX1SUteGCnSgdXxBQDiRycRkHiZm1to5gtB9
         RWeQilgpg3QDCytGjfjVMLMAcVlvyz2Jxpid/+A3G6+wiuJ1qI4FvYqfIDqaHRPy5H
         ZZHWHdVOXl+TD8Mv50oW/2JvqZGFFNylP9TlfdEbguhBSWlLZ3U
Date:   Sun, 7 Feb 2021 19:09:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>,
        git@vger.kernel.org
Subject: Re: default editor
Message-ID: <YCA64/coa/J5mBCl@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>,
        git@vger.kernel.org
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
 <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net>
 <xmqqlfbz927i.fsf@gitster.c.googlers.com>
 <YCAzcs1e08Qnk2wa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1vc0PYVKuvI3Y0lt"
Content-Disposition: inline
In-Reply-To: <YCAzcs1e08Qnk2wa@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1vc0PYVKuvI3Y0lt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-07 at 18:37:38, Jeff King wrote:
> There are lots of ways to make ed exit non-zero. Any invalid command
> during the session will do. E.g.:
>=20
>        $ echo bar >foo
>        $ ed foo
>  ed -> 4
>  me -> l
>  ed -> bar$
>  me -> 2l
>  ed -> ?
>  me -> q
>        $ echo $?
>        1
>=20
> The "2l" was bogus (there is no line 2). It seems likely that an
> interactive user might make at least one invalid command while editing.
> Some versions (like GNU ed) have a "-l" option to loosen the exit code.

I wasn't previously aware of this behavior, and it's not very helpful
unless you're scripting, since humans inevitably make mistakes.  ex
seems to have a more forgiving behavior; maybe it's similar enough that
it'd be a better choice?
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--1vc0PYVKuvI3Y0lt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYCA64QAKCRB8DEliiIei
gXEkAP0QvDymBap6Afmjq83US5upMSsGZCJWxwQe1rGXhG5uBgD/crUCmyS0pOcF
E0QZokE/7fnG/zD5bqwaStwW6jL2TQI=
=wDTZ
-----END PGP SIGNATURE-----

--1vc0PYVKuvI3Y0lt--

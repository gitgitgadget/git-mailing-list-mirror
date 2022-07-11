Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA70C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 22:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiGKWjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiGKWjV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 18:39:21 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7AF52884
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 15:39:20 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B2CA65A1BA;
        Mon, 11 Jul 2022 22:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657579159;
        bh=nLkjQOAYcCihOmsOKIXse6r+Gt2WY3lfi/DW/qpmXIk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A9MNc16vlxvYajlwwMxt+bWx8Zf0/dr2CYEF5o8if56K8gtq2xPiJFBd7hpFS8lgM
         lGOex1bMiTJ0xSY/gOtzXsRpfbMUCl3DO5JJQHIRG1xgA5TQ71MDFz2GKwg5Wb6iIB
         P8FL7cmoEBqYzfrpnAl7x4tPU8v60GWXNzkxLLr9T77JLkbVNNJAfgvrZYOuBoAOYc
         vQokHd2yc9p1rjbl51A5cl6ETnklm21mnjWf9fpv5J4eXvYy/xo49h2oCPSTabQlhr
         CTfcgbaxYUSTLiB053F63r5Q//gK2luon45ATgH+nmVpa+dInGnci0O1oQGudLp+Ix
         gWIAHuvhRmRxgYyfCUcJF8xKlOqUIqYGlkx7LfmSpIBmi4icR4tte9DZ4QZKfqA60T
         f1ZX7F27jnS8l2iYECqEl80x4Wf7aor6UsPMcIIPxR5SJcionD9mxAMYgEfNk/csWs
         rdCklCyFX+qGrO2tpDaBYCOq+4tvkgT//K9+Wkr1C7uVL7dNxEE
Date:   Mon, 11 Jul 2022 22:39:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/4] .clang-format: do not enforce a ColumnLimit
Message-ID: <YsymlrUviwwoKHZX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
 <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UoYkHW+qDWIC4MS/"
Content-Disposition: inline
In-Reply-To: <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UoYkHW+qDWIC4MS/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-11 at 11:37:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Our Documentation/CodingGuidelines mention that "We try to keep to at
> most 80 characters per line", but in reality we have a lot of code
> that runs afoul of that rule.
>=20
> Before & after this change running "make style-all-diff-apply" will
> yield:
>=20
> 	579 files changed, 32065 insertions(+), 29818 deletions(-)
> 	509 files changed, 13042 insertions(+), 12745 deletions(-)
>=20
> As with the preceding change what this leaves us with an unresolved
> question though, should we have some stricter version of "make
> style-all" that incorporates "ColumnLimit: 80", or perhaps apply it
> only on "make style", but then what if someone modifies code that
> happens to e.g. search/replace a line running afoul of the limit?
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

As mentioned upthread, I am fine with an 80-character limit.  It's a
reasonable choice and what's we've traditionally done.

However, I don't think we should drop a limit altogether unless we're
going to not bother people about this in code review.  I would say that
if people are going to want a limit on line length, then we should pick
one.

Now, we could well pick one that's longer than 80 characters.  132 is a
common terminal size and it would avoid needing to rewrap all of those
lines.  But sticking with 80 columns is also fine, and we'll just need
to send some patches accordingly.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UoYkHW+qDWIC4MS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYsymlgAKCRB8DEliiIei
gULJAQCiZIv2yu29QI3IkpwQc+KhwhfQJLXwmBTUGTV66QRbFQD/QpvIVXdr5WER
hbxvUWmEYNWPAwKa9ns/yzLdsDS99gk=
=rXzq
-----END PGP SIGNATURE-----

--UoYkHW+qDWIC4MS/--

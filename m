Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C7C47255
	for <git@archiver.kernel.org>; Sat,  9 May 2020 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63001208E4
	for <git@archiver.kernel.org>; Sat,  9 May 2020 22:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JefJxHlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEIWRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 18:17:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38028 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbgEIWRi (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 18:17:38 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C61CE6044D;
        Sat,  9 May 2020 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589062657;
        bh=3sum0Wp8se5zDV08FVCL73o6rGjLBuRACKTHLNhJVZc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JefJxHlFRlLSL60aCVfxr4glWFV2aqwRz1tmvpLSgPzezJpD38/SsSWWFWrKd/M0k
         mwbQZNsvGjU37gK2Uhl7T3X8Kyx7l2r9VAIOlKlT8rtgJ+8z8MEacBr5qiAJROL0K+
         Q8cQukNuoqLzI+XjexuD4ZGCqUsenwZR6uyUbvvFZn1rDaW5TuOFRsk0FwKP27OIKd
         hWAJ2FFTuQ5w8Qgein6D7dZrLKj7W7wLwfG74QwlE6oqCmn4vJsFxDYj+HHNKqlALg
         iTdCHLxbe/9mKJqlsmETCtAlDhT+75Xut1T5VCkQO9DRNX3P8H6A3SHBTzn0GLHcZK
         H/d+WF7LuGKRhjAqtlQTM2N9ylDbz9SVjopPYNYHP163/p4+zrRCJDowhF4e+MeYkY
         LfATEUjfX10x/A4W9p3u5wUPDolaQf8fYwpjOTXP8AA0mL2aMyqzVAj2Bmj8+pv40r
         ovuXKt2NaXghlx+dLrYGtRK4uP0ND/qmq2bKo+3zKC8f91Onjfn
Date:   Sat, 9 May 2020 22:17:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christopher Warrington via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
Message-ID: <20200509221730.GG7234@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
 <20200507222510.GA42822@coredump.intra.peff.net>
 <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
 <20200508130831.GB631018@coredump.intra.peff.net>
 <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
 <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
 <20200508171232.GA637136@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <20200508171232.GA637136@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-08 at 17:12:32, Jeff King wrote:
> On Fri, May 08, 2020 at 09:28:56AM -0700, Junio C Hamano wrote:
>=20
> > -- >8 --
> > From: Christopher Warrington <chwarr@microsoft.com>
> > Subject: [PATCH] bisect: allow CRLF line endings in "git bisect replay"=
 input
> >=20
> > We advertise that the bisect log can be corrected in your editor
> > before being fed to "git bisect replay", but some editors may
> > turn the line endings to CRLF.
> >=20
> > Update the parser of the input lines so that the CR at the end of
> > the line gets ignored.
>=20
> I'm a little surprised that bash "read" on Windows doesn't eat CRLFs
> already. But I often find myself confused by line ending decisions in
> general, as well as the difference between cygwin versus msys versus
> pure windows binaries, etc.

I was surprised by that as well, but I believe at least the bash in Git
for Windows is LF-only and doesn't do anything special with CR.  In fact,
ISTR it chokes on shell scripts with CR line endings just as every shell
on Unix does.  The commits from Dscho and Stolee to our current
=2Egitattributes file explain the situation quite well.

Cygwin allows configurable behavior for line endings, but I don't know
whether any configuration it allows handles CR in the shell.  I'm sure
Cygwin will do the right thing with LF only lines regardless, so it's
probably safe to just assume LF-only behavior in the shell.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrcr+AAKCRB8DEliiIei
gfzxAP4wPB3JkMYfs63hZ40oDgzJX7K3o9WYX6p8jTNSKaty6AD/bb3++xBIGpW7
RpLImdjsdF+Yys+dDxIWPDgWu4m+5gc=
=ZUe+
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--

Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F981C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 23:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C620A23A32
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 23:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI0X3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 19:29:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39632 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgI0X3g (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Sep 2020 19:29:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9B78D60457;
        Sun, 27 Sep 2020 23:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1601249344;
        bh=BavQ/pD1gQMUN/jj/FvmqnieopCGVA4Nlieth857x+4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EFl9wTYwBctex8WooYSs4ZiWAYI3H73qCGDOM3VSwAe2SDkVMYwtyKiA75sVPY5MS
         4rMC42dSmewjDjyemPSPbmt3wwnFROyqf6PmU8ShZSEeVdMBBBNqLAnVYIWnKnbH2h
         7ZX3RVKBFPW4NcvHfqVAKJocxGvidbvy2qdI5M0+8xIdTuYF1Patip6nDs1A9s1xyU
         7ECDit5XECk6fuIVHiBdKq2i4C0AsLzO4TRJsZRXFJsyxjsxbWvpK05R5d1+skelbP
         1h+HpfF/9T1PZ4hRXuzLQdq3bTFjli9qhOWXsudiIkG7oEALCHJ0U+RGzWZNFvU/1D
         Vc63qFsI3tJIhO3sipm2rEIJl9/qUBHFv15jzYnruuWDyg07r2bptmilgVu4+yUQIz
         2oP8xRP+fF1ZchQE4n41CnioDsYCpmV1Yu90JOVmJS0MMbpka2GYkrpxtYzX7PYJE0
         s1TDbS9aTLA3YBL9a//1N8z4dz8rnAqNE1oqEousSxhEds49FLf
Date:   Sun, 27 Sep 2020 23:28:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Hampton Moore <hamptonm@usc.edu>
Cc:     git@vger.kernel.org
Subject: Re: Git remote return custom error messages
Message-ID: <20200927232859.GF1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Hampton Moore <hamptonm@usc.edu>, git@vger.kernel.org
References: <CAOefx6Ro6ixiccDq_xH-UsjNWTcjKy=YQfCs7b0ZQkLjSb-0zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <CAOefx6Ro6ixiccDq_xH-UsjNWTcjKy=YQfCs7b0ZQkLjSb-0zQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-27 at 22:26:56, Hampton Moore wrote:
> Hello,
> I have a custom ssh server that is handling validating users
> permissions, is there a way for me to return custom text back to the
> git client that's running push and pull? When I just send an error
> like "NOT A DOMAIN" through STOUT the git client displays "fatal:
> protocol error: bad line length character: NOT". I looked and could
> not find any obvious documentation on how I could do this, or if it
> would even be possible. Does anyone have any ideas?

You haven't specified at what stage you're thinking about sending this
result, so it's not 100% clear what the right answer is, but depending
on the stage, you could try two things.

First, you can try sending an error packet:

  error-line     =3D  PKT-LINE("ERR" SP explanation-text)

That would usually be displayed to the user and it will be fatal.  If
you're in the middle of the protocol, and this is non-fatal, you can try
using standard error, since that's usually hooked up to the terminal via
the sideband.  It's possible some very old Git versions won't support
that, though.
--=20
brian m. carlson: Houston, Texas, US

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX3EgOwAKCRB8DEliiIei
gY/QAP0da7nOZp8FETZhxEtUhI6lXdfzj7MabL+WtDl/74FdAAD/WPKCgPeN4O8N
E3+AHEEqyPIP9ZoBAGYkq2w1BJNWTQ8=
=gk1c
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--

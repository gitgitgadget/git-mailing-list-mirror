Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43672C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD3720656
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1TiP6kmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgG2W3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:29:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41018 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgG2W3F (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 18:29:05 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 734D26077C;
        Wed, 29 Jul 2020 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596061714;
        bh=zDVBDYPF+UGQUKQdb/ewNresRQkjlnMtRz5dxpgwR1s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1TiP6kmz8PZDtrN9xO1+3emppRrld4YnzRHSjE83aeOItslZd7QPDdGJknMp4IYwI
         Rofgnqm7FHx+22XMZWpxrC465UVY3yGhByHZ2tu2zpnLCElRKWpkfJAgu+4JLCKFLe
         RQ95ev7RBw/ukcLVDFeh/KqV41KKXCd2oxU9pPwcbWuf+SDfMqLEydc96OybIikxog
         Hv4hoPhmQEG1UlS6JBMiaLwtupjwc1pkJ39Ue/opEwTugdrwVpydlZM7ESDP9LRXiq
         U4lGaKN+cDhR51/rw7FyUNhzBPr8rOyM5oM29njylsokeOjP6Unut1hf7zVInfrs/o
         sGzv5hQIxfeCSccS2zJnlAAlnUKjS0TjpEVg9DUqGo3mx0qmoeMKp+3NcLj80pCdYs
         esTg+KbLdBjsk4Fs/kU1DhuKor6X+NvFnvEW89cz8SiejgUdoDKQRotM3+KZmHrZFa
         EgmsrNwrRUMtEBN/XheudOhXQR18KdHxGYPRSgZbQI1AivzzCo4
Date:   Wed, 29 Jul 2020 22:28:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5 31/39] bundle: add new version for use with SHA-256
Message-ID: <20200729222829.GF6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200728233446.3066485-32-sandals@crustytoothpaste.net>
 <CAPig+cSJc9P6hdBDrH9QbkvARcqc3EygMMXXB8vbU=W43viLqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <CAPig+cSJc9P6hdBDrH9QbkvARcqc3EygMMXXB8vbU=W43viLqA@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-29 at 02:53:47, Eric Sunshine wrote:
> Moving the strbuf_rtrim() earlier in the loop, as suggested in my
> previous review, made the diff a lot noisier, uglier, and more
> difficult to read, however, the code itself ends up being easier to
> reason about than in the previous round. Good.

Yeah, I noticed that.  The code is much nicer, so thank you for that
suggestion.

> By the way (I didn't think of this in my previous review), but
> wouldn't it be better for this:
>=20
>     if (header->version =3D=3D 3 && *buf.buf =3D=3D '@') {
>=20
> to instead be written as:
>=20
>     if (header->version >=3D 3 && *buf.buf =3D=3D '@') {
>=20
> to future-proof it since versions beyond 3 will also almost certainly
> support "@foo" capabilities?

I think this will need to be dealt with by the author of bundle v4,
since currently bundle v4 will error out before we get here.  I don't
want to make too many assumptions about a future format.
--=20
brian m. carlson: Houston, Texas, US

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyH4DQAKCRB8DEliiIei
gR6iAQCO/wq+HqdYcDmZwzitlPORRyieZBFaHz1au6fxjOr7eQEA0Qy+dg/nN+cn
nzXOtTIMSAc+YI2w1j1uXuqF7vauWA4=
=Ko7G
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--

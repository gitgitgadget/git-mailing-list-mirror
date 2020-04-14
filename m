Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA3AC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 23:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4595920578
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 23:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ArsHXu9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634433AbgDNXuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:50:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2634390AbgDNXue (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 19:50:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AF7C96042C;
        Tue, 14 Apr 2020 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586908203;
        bh=Ymu2vP68uosHSaq8HdK+q2t2Uc9PW7gxNvJNK7B4nUw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ArsHXu9YyIemIRM6WqSTK/EdNkwO54BgLG6WEuLJE3rPHFLR8DdhkhS51ZDJ7kz+e
         3XMYatEUKfczH7i7QPJ+f2JgYz6tRFVkXvfQvCe2qEy1ifYKa2J/YUF5Ds6A88kwWs
         yexjAwnA1/ICZd77QXRer6unhAMxOkQNIHUGaSU/J9+2+C1N+ZPRkIu98zyPu6/s2T
         8atIEjOmBWbP+oOnmSGi4ocHU+0IQTHsZsfsaxBPyVSfQby3ROd4kCNUTzf9k7kXmJ
         F9BkEt/RuZ7uPpJl0Ig9g5gGkNgbVaZsHMHpRj3EV/XC5wbhXgXeu9j3hwhKbYxWU2
         AcZdpLwDRkLZ3XIjmDe+qpIJoxhl7Jn60ZNcd/JhfJhcIbsZ0rTQRkHQhnKMwU9PJu
         HGkhxi7j0SzwWj7peEqPoiKneOUwjsXU/FSgJ22Xfi3pJ74eEjWJ23zefZ87Pf3EBD
         15hUCVV2xBEXpxyegP7s4pNgW5xnxlzXDDLeDiQ3sLRf3EouGW7
Date:   Tue, 14 Apr 2020 23:49:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] date.c: allow fractional second part of ISO-8601
Message-ID: <20200414234958.GE2751707@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <45676f4a7d001dbd25bbae531cc2ae5fc53936bb.1586856398.git.congdanhqx@gmail.com>
 <20200414201733.GB1879688@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20200414201733.GB1879688@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-14 at 20:17:33, Jeff King wrote:
> On Tue, Apr 14, 2020 at 04:31:54PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
>=20
> > diff --git a/date.c b/date.c
> > index b0d9a8421d..2f37397beb 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -556,6 +556,8 @@ static int match_multi_number(timestamp_t num, char=
 c, const char *date,
> >  	case ':':
> >  		if (num3 < 0)
> >  			num3 =3D 0;
> > +		else if (*end =3D=3D '.' && isdigit(end[1]))
> > +			strtol(end + 1, &end, 10);
>=20
> This just throws away the fractional part. I doubt anybody cares much
> either way, but another option would be to round num3 up or down.

I'm happy with truncation.  It's simple and straightforward and will be
widely and intuitively understood by programmers, who are probably the
primary users of our ISO 8601 handling.

I do appreciate that you pointed this out, because it's a good point.

And overall, I agree that this seems like a good fix for the problem.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXpZMJgAKCRB8DEliiIei
gcnTAP9G5Kbo47S7TsrL8wDidfkpY1CjwJpxiMTuSfp2IcvOewD+JSNcAqi0oBlj
DxcMyqaqxPzipjdu0C7CrcShOxWfwQI=
=iAAU
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--

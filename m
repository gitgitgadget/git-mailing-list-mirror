Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6CA1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbfIMWUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 18:20:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58676 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390255AbfIMWUw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Sep 2019 18:20:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d92:edb:bada:18ab])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A46C46042C;
        Fri, 13 Sep 2019 22:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568413249;
        bh=4LFF/Q54FMzeXQnbnhKKlzfkNOM+PWTYu2YniHUNqwE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ap/QVpcXu8DQnmTuf/CfWxvmU2a/qZBwO19yOKTJRZbOP3Q98gjJ8vFjucKvaBY5G
         F8a//SXC9qVj5OdF3290mn0wXks6vUcmOAkF1jJ8u5WtW9hkgLDEtfuKRLNm8JJOIm
         HCq7cvcN+3EnLAINHeE+odk4EOiOkLfA1fRCEyr5Jx13NXHqcrYbsElOxma6dIfnc8
         0soYKd2AflcDt1C7YrWkPyz0MHKFB+I4CnfdlMrRH1tTBSXmubfBoPNI7ntxbGReC3
         UnDFCXBIb1nLnjJI0nDWeiQhS5tpKYw2igIzsCo9SuXNLvcE6btmT8AFP5bOECz5Hh
         AS4ctJ2Qh3RlstuIIkkWBgCY3pZVmq/7syjrDHOMsrdj5gTW9gNQ/Lb3Ocz9nYB6dj
         5SPbsPX3B+crIEgSp77Mo5qOmHqgAlYw8PkgAWdt7jTKMykZ5xToxEmqLz9Rcr7Jcs
         1k3D3usMyMvVAODRYIxfO1UM0AQus/TnNntNqmwIQpV3dd3kZqe
Date:   Fri, 13 Sep 2019 22:20:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Siddharth Chandrasekaran <siddharth@embedjournal.com>
Cc:     gitster <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: git-am fails for emails with UTF8 characters in email header
Message-ID: <20190913222044.GR11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siddharth Chandrasekaran <siddharth@embedjournal.com>,
        gitster <gitster@pobox.com>, git <git@vger.kernel.org>
References: <16d2c3ccc40.b3c71baf1200589.723645117669598677@embedjournal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="soWJpSPh+l8Y6Fy7"
Content-Disposition: inline
In-Reply-To: <16d2c3ccc40.b3c71baf1200589.723645117669598677@embedjournal.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--soWJpSPh+l8Y6Fy7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-13 at 20:07:24, Siddharth Chandrasekaran wrote:
> Hi Junio,
>=20
> My email server (zoho) puts leading UTF-8 non-breaking spaces ("\xC2\xA0")
> when folding long mail headers. Due to this, git-am is failing as it expe=
cts
> only '\t' or ' ' characters.
>=20
> RFC2822 [1] on page 7 states:
>=20
> > The general rule is that wherever this standard allows for folding white
> > space (not simply WSP characters), a CRLF may be inserted before any WS=
P.
>=20
> It appears the RFC isn't too strict about ASCII only headers (correct me =
if I'm
> wrong here); ergo, if the mail file is in UTF-8, isn't logical to expect =
UTF-8
> whitespace characters also to be allowed in the fold/unfold of headers?

RFC 5322 (the email specification) doesn't allow non-ASCII characters
anywhere in the header of an email.  RFC 6532, which allows UTF-8 in
header fields if the message is transported via SMTP using the SMTPUTF8
extension, doesn't allow UTF-8 characters to appear in the WSP
production, and therefore doesn't allow them as folding whitespace.
Only space and tab are permitted in WSP.

It appears that your mail server is broken, and it would probably be
best to get it fixed instead of trying to get git-am to work with it.
There are servers which reject messages which are malformed, and even if
your mail gets delivered, there are a bunch of mail clients which will
mishandle it.

> I was able to get git-am to work with modifications to read_one_header_li=
ne()
> in mailinfo.c need your view on whether a patch is necessary for this. If=
 so, I can
> send a patch for this.

I don't think such a patch would be a good idea.  I definitely think we
should support SMTPUTF8 and internationalized email, but this particular
issue isn't such a case.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--soWJpSPh+l8Y6Fy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl18FjsACgkQv1NdgR9S
9otHHQ/9FzvyEo7b7c2DYVjgkkuQXDJVB2FEiocn65aKq0pFHOun0I988WQONmYx
JIXkoqBvgYw4PkjgnSvJMIwMv1Ai4lx+JHskY8i4n3Mc9FXhUEhzm3iDXj7+6NVG
bme39MaYJ1YgP8DyKkxYyRidu6neybd7N4KKIQzCy4OlJzg34vFCzdH77zMGB/Sx
2eXhJj4joM2erPyijg6+zx7hb3y/MX109P+i1fB2Coj/xSUfCv7nBifzYdqIXgR4
eEt0tLIT7PTPOC41rlq957beaet6/dKc9Ws01ZuDN85MBqQNXNSx6lI6mo22i9UB
cPLRHk2CBA8B5CL3ObmzMUXTS/s7ZSyTIQvlgBv/UM/ffS1ppnNRz7SWWg6mKjnd
3nxcbrWhrWT6v+GncXS1dbWrl57NPPoWDVeFbdeqQr3ZAWwDYP1d9kv6WwkzJf5t
rWsUPCtaR47trWv9vPVvDni1AbeLDbkSvLRgl00PwsfxSqhYhOCt7NhjVpvvB+oc
9hEobfqyil6LXaZHCVLZmXCgkgLt30AqPIzm+7ESFwYY67X4uwCsSdbFrRXsEq93
BvygLalsAIz2G5KiBhuKzCmusgoZukONy53euS155J7S4bOJ19Zm+4crexqt23AS
nxiuT/U0C7Dx85XsAgis5ikZ2BH+vivxxXpeN/akDrmbj+hx70o=
=Ge5q
-----END PGP SIGNATURE-----

--soWJpSPh+l8Y6Fy7--

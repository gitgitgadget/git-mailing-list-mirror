Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB7121841
	for <e@80x24.org>; Mon, 30 Apr 2018 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeD3L7R (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 07:59:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36598 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751938AbeD3L7Q (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Apr 2018 07:59:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 44F8F60400;
        Mon, 30 Apr 2018 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525089555;
        bh=CRe1kWj1rhwD5eNNeiJweVT+c/+wxvGeqtpQprTl7X4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yqVSU6gYP92soEHfLfR3cIAFOGIrlMnTwH3xbDZTEK/+3GReXfbYCmHemDG4JXeIR
         2rW/jbYQm3+1mdnm7rriqXjgrYCK2wxyv+NDpDodpiyjV6ncASqPxu0C0TftL+rvgn
         O7HH1c7A8bqYWyjoz7iA2yUpkzQj2wUzw1nee3xi28wjGERcFIu+sbdKdEg3CzDZ/A
         0+nD03DuIRRRWtjdVTebcURyblQVVKkhJSvIia7vRMjlrScsU5gwIsSni+Yc0QnYtY
         4qyUjARDTJcEOsBXhnxpLMlyLc62APOkOCYEKw67V3w11Ol4Q+SIS2mtIYwm+JxNdQ
         8rsvrJXFpTGannOB7Zag3mtj+Z2tuIG0hGGnhiTaEOb5sU+Y02iphseqxUfMOv+M10
         bEpVfI4dEpiHJFi7meGxDhK9CXP6511nRh+g4rjtA7XiMGL85YMqermXRoUrUJ9Jd9
         IJjWYLqju0d5R/2yHiimlw666UKHi3iCZV0CIt03Zn76Oj/7GmU
Date:   Mon, 30 Apr 2018 11:59:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Hemmer <git@stormcloud9.net>, git@vger.kernel.org
Subject: Re: Bug: format-patch MIME boundary not added to cover letter when
 attach enabled
Message-ID: <20180430115909.GB13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>, git@vger.kernel.org
References: <5e409069-835f-3c85-f55e-c27f534dc9e2@stormcloud9.net>
 <20180430020930.GA13217@genre.crustytoothpaste.net>
 <xmqqzi1lxte6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <xmqqzi1lxte6.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 12:30:57PM +0900, Junio C Hamano wrote:
> Thanks.  It is true that the current output from the tool is corrupt
> mime multi-part, and we need to do something about it.
>=20
> I however have to wonder if it even makes sense for --cover to pay
> attention to --attach and produce the cover template that has "BLURB
> HERE" etc.  in a multi-part format.  Shouldn't we be making a simple
> plain text file instead?

I agree that multipart/mixed is not a useful content-type for only one
plain text part.  I have a patch to add the trailing boundary, but I
think you make a good argument that perhaps omitting the entire
multipart portion would be better.

I'll have to work on this after work, so expect a patch later today.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrnBQwACgkQv1NdgR9S
9osopQ/9GitRRKfUFH3WEnV6V6eRD/rrIRTXB9m1Pxq/YDnGqTyIXiZFCwTeV6/4
gqIk4Z1JXlP6gMqUUYRiMrFz32nHTTs36rnpvwWlzn7E+0O1/DS1iRK8HazTLOiq
66JsU7J0Enjyvc7i9i/klppTdvb7+wdUxv370VAwAxK6Jw8urwNPY0wnBLYei47c
5itL8Y0b5I5xWTEb/c0BJ+k9PyqahZhM9FZqRoLWztzuskvP0QJaVdNDF1MJgPcw
xNsEKfcq2OUXE1PUmzaEnzUMx62pwUBfpVpVH4G7uwhoq5S4AxCytW1UWTIyBBQu
UT4tGxoqc21rP564seB98KdqRD87TfKDKNC/TwhooryfAfKDPOWGiqJyRSocLs8c
v3rmf/fIu6rRtris5RpaBsvBKJZKYYwgxb4V0VWTUbvR9cLTbp0JnmzmqV27ekh7
4BSwtQDcdJ41VfhdGIDB/eFspJHFTagly/8WEqDSsmF9Ng2+XwPo5Fd5cvPF4AnH
ZT+PqgNHtLgxLl1rkxH7ANakYdBxHTRXisZXCJTRo7daaChQLQCF6YYISwdZKGim
gMXRazGdigoQ9FJEQxTJ9RYhXMAMRwvbQnbgMbNX2n3NiOtOPZw+ZVWTUdm4rhpo
VcvbpxEFS8HKGe/KV5Shb5YSmhdF0ZK+5dDuJiVZ+ngW7l3672E=
=FKA4
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F871FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 02:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbcLECcc (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 21:32:32 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:49482 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751241AbcLECcI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2016 21:32:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 86E85282B7;
        Mon,  5 Dec 2016 02:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1480905125;
        bh=3YDUDit7dsTJ4ngdE/CBsojqir5jLH6nHWNUP9MJELQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wlkWcR5sQdRODZuPLuvWvdF5+2y5muuw2Skzv2h6zEthRPH6hdd5Kk34dVaoIIE+o
         VfnY/Q8/E40ZAa35SPg54hsbqBJn4ieFIi67hWwdQD8gFXshPtyWYUgBxiW6ykAw+9
         w1bQ2JDPpVDRz4wCwvgF00cEXaeTDsbe+lHzVYVHeWSkn+h5E/N7Et2zmFGFHRhAR/
         sZFFAtQd5AJmSw4QjyeheCsc9SAUPCWwGykHHcF/Nbz6O0afL5NXKQPgKuwlWJGb3Z
         Y2bOWS6pIVew2EQFKBXxNhLMCSNmyh1AnRSKx1R+5L2onODsrKASJxh7+E5wpeRQ6+
         rPEJGybbd2C3kBTYuifTssQXHOya5tq9ydRw3Gc0nxTBhRPIOyG2jQgNoAJFSH+YmI
         9qdcarMRBQ+gaxodXVbG0yzMdZut/Fu2R1sP/o00zzjW2cSrwygH/qs78KoPG7WGv5
         Y7DlRHJ7mDMgc3+nPVcwI9byl/6SjbnfE2QwS6dxcL6k4JijX+7
Date:   Mon, 5 Dec 2016 02:31:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     ken edward <kedward777@gmail.com>, git@vger.kernel.org
Subject: Re: Where is Doc to configure Git + Apache + kerberos for Project
 level access in repo?
Message-ID: <20161205023159.gzkqtfg3e63odtgt@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, ken edward <kedward777@gmail.com>,
        git@vger.kernel.org
References: <CAAqgmoNG4vOqLnOqmrUvwTNJpqGBckfN-y=Fc99TrvjPhz7h0w@mail.gmail.com>
 <20161202222153.3j5i5rsacybwexg6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cshjp3bpqvs6dmzq"
Content-Disposition: inline
In-Reply-To: <20161202222153.3j5i5rsacybwexg6@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cshjp3bpqvs6dmzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 05:21:53PM -0500, Jeff King wrote:
> On Fri, Dec 02, 2016 at 01:15:02PM -0500, ken edward wrote:
>=20
> > Where is Doc to configure Git + Apache + kerberos for Project level
> > access in repo?
>=20
> I don't know about Kerberos, but all of the documentation in git for
> configuring Apache is found in "git help http-backend".

If you want to use Kerberos for authentication, it's really as simple as
just using "AuthType Kerberos" instead of "AuthType Basic", plus
whatever Kerberos parameters you want.

This is what my configuration looks like, but obviously you'll want to
modify it a bit:

  AuthType Kerberos
  AuthName "Kerberos Login"
  KrbMethodNegotiate on
  KrbMethodK5Passwd off
  KrbAuthRealms CRUSTYTOOTHPASTE.NET
  Krb5Keytab /etc/krb5.apache.keytab

You may also want to set http.emptyAuth on the client side.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--cshjp3bpqvs6dmzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlhE0Z8ACgkQv1NdgR9S
9osmdw/+LGVDpogigFNGSmPmcGPkdWIUajlxt3wmMip+f3qTkEkQmDlJIZlhKmNg
YZkrinQVilvZLzzmSWdgpeF9kA22+t/iFwKtK3hYxQUAZvH5SpJYJuYeJ4uEZ47i
rV1nFBX1Wzk4LA9pZ+LVIXHe319AGB04UcIynoioM8leQ6kT7sk8/9tRaBobg4q7
PNqVsITHgmFbgPQAbnTOgIgzS2ejn/34lNpp0ZkN41KsgiqlZJsDDfDM5AHXP+Ui
qcIpLBZfUGUJgCTHcMbocgv7ZTr5nUaI8QpKH58doUWEU9meIJwOSwoes16LxMZa
sM6LqGPawnOPipC398qAC8e3u0O4kc9UvVGmY+lD/HajqXpB1ieBf3R9CQjOZtEJ
mNqDEWZ2oI7xv1/r1MJwoBqxXj2gKKb1y5R+WGjfYvYoggR/ulAYz8QmKUwbwJGl
XePCsa1auDpf/7lGlHqq6RicvOqTB89y6GFquGAS/Z4P8NM6+KjFL37j3imks4bB
ngKEgLKy4ZFZgXlSJGusKet9sXEQCXuZhpljzc+P69buhMkUf2ph/7Bj5DkyBt9t
W3JvWWHAo3vWEK7gfqentL8wxPuHYJnEks0JwASnptkmH8JcxDa2aLQNtNv/9R/I
eJe4KJ032rFhbDEnU0OKyyflcdi7bHnUec7ARM+xesab3Mfyhps=
=3qU2
-----END PGP SIGNATURE-----

--cshjp3bpqvs6dmzq--

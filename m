Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A60020899
	for <e@80x24.org>; Sun, 30 Jul 2017 23:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbdG3XYd (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 19:24:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42972 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751266AbdG3XYc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Jul 2017 19:24:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7AB84280AD;
        Sun, 30 Jul 2017 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1501457071;
        bh=CZoiQYS5phkdpW7GU5NqImjNJwsOz8I5wFLx5H7rKQc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=S3CTEiGu/g8JLwzWjjMy9a2xK36dO9yIhC4R3lQ5YlnONcBpuH6sEEZPF9ot47Wmj
         82l9YLmsVOm7RvBqRdZcVzMSddEpza4Zxh9BSbyAstz2h0t/g/OEWtAov1685bD231
         AZWJfkWFN1UPHUmU/3f83zaocjTd1D6BG9by1TbXjG5Rq+hTXY5LIGOLBUkn5vq+7d
         AKCLMpnau0FsMJj8WWouCk4bK64wqEdpreRXKGbOkrkWt9QWIDd/3aGCIbD0Ly+sAJ
         YPnOHp/I2oPijxaT1NhIN2o0XbAHSktzmRow1luzhlBnkk7ETI185Q4+KrQzIwaQYi
         BmTojeinEF31243qgIHA03F25IzSm9+5W+wdxIBL4XQif1AjLDsdnIshZPdH9IVF+x
         FHtY2OwPjT12L1VI1aRr3dP3wYo8HsPt4DsLwCQxGWn5CtpO76GNQxwGmoeR/2bzUD
         Z7Ue1xKKg62nh4hhTtZt+5ws0mGGEgRlICJk3CpJLn2kP3+x5Uw
Date:   Sun, 30 Jul 2017 23:24:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
Message-ID: <20170730232427.vrqrrhlsap55ax7t@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170728171817.21458-1-sbeller@google.com>
 <20170728171817.21458-3-sbeller@google.com>
 <xmqq379gmco6.fsf@gitster.mtv.corp.google.com>
 <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
 <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com>
 <20170730230019.ch74ska6wgbrh7ql@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7pm6blj77jiniwwu"
Content-Disposition: inline
In-Reply-To: <20170730230019.ch74ska6wgbrh7ql@genre.crustytoothpaste.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7pm6blj77jiniwwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2017 at 11:00:19PM +0000, brian m. carlson wrote:
> Yes, basically, but a bit more generally.  There will always be cases in
> which we need to specify an object ID or an arbitrary string and the
> behavior will need to vary based on the hash.  That can be something
> like, in this case, the two blob contents that would have the similar
> prefix.
>=20
> So in this case, we pass the helper the string "263 410" and get back a
> value for either the hacked SHA-1 hash or the SHA-256 or whatever we're
> using.

I realize this was worded poorly.  So for my example, in this case, we'd
do:

test-helper-hash-string "263 410"

For SHA-1, we'd get "263 410".  For SHA-256, we'd get "313 481" (which,
as SHA-256 blobs, both start with "17" in their hex representation).
Presumably we'd read some environment variable to determine the proper
value.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--7pm6blj77jiniwwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAll+aqoACgkQv1NdgR9S
9osr9A//SyUt5Yqhd/r5wlKaTTbDJyXLNNQEzjzJjqJvRhYRXmFHITX6+5hs52GK
GaNW94kZsGnl3PyWPstnMPJXEGqJttDp5H9Vh7n/1vVqPDSwbJYqqZ8At2Or2qNI
QEfuUHvKFxQBUHCFcKqLsb0wjbWptcKzwIFgST6JAlmmrtoTj7KqbT4qVTZl3oiU
DLu/2mUXOBlC+MyqAysIQ81TyIG0vHhUhQBl+YvrOCNulLLd3vWswdqsEjy87v3T
pyHXdob/NkHHf9qVIPXQUsSJo6rBra6LOk78zteHugibpPxiF2nTA06R3y6YSgXZ
Bg0CaYyM1hBNnpgEOpG5DsM908yVT/HPuOcDvlfatgSNbLkEzfNn0J8aTQDnRMR0
tC/UIaAXT5EER/d7kV+p6e5sr6eeH+Qi42EmVx6rvyOxVjk8y8IWx4GfyPrxp8Xq
rkQwxCBM1Vqr2YIqvjLKi5NT285Lj5OYxdt3ngyVWrB3MbSCJc708OfnIywbYrFo
4bz/HlbYWuI3bnwdAYvdsAvHXhe8w/419WJq7FafqKbF19y6mdZi5gYzzUWq84lX
x5NvF/IOq0+c7rfz4XaEWZ+yJM6GdnIoTs8rDrHMo8aJOYf9kCXlujQ0j3Xju/wy
rUNBHTgdorULze+ANBs7dk6OLnOgmwgJC/WThrrFdIcI8XIpKwk=
=Xptk
-----END PGP SIGNATURE-----

--7pm6blj77jiniwwu--

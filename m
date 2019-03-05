Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263D020248
	for <e@80x24.org>; Tue,  5 Mar 2019 03:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfCEDfe (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 22:35:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35142 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbfCEDfe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Mar 2019 22:35:34 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc8e:9228:1f41:7177])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B31286042C;
        Tue,  5 Mar 2019 03:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1551756932;
        bh=0Qm4Iprfq4YvyKdtzgooRgZkH2hef5zI2U6SGdWgW74=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SuCf+/vZ5c5y5bnZFFuOo05tUGTF7mJz8I88VYvR5/oJ9EMO0eyn6vS2bdyTG7SZR
         6R7vix7sQoBmjq6OZayBpOCEg87zam7mI8N0wVN8VBkpsq/SmekwzPac+4WeK4mDR+
         DkDM2ClorU3PB3wQye9zlAhR4arXCtLT8LOmoVG8DcDMaZIzVGkUrCMMJCDbjodvdU
         SU2VitiFYaY4rRCmyns0+KXrfy4PemCZxYZxiO3elSIa0EEr/4csUmJJn8uHfX6GnR
         FuF7O8pK3W/hggFN566nujLQPiDvcqvTyV8R2WlOkw0/f4vz2B4/pCQ+idUdA1u1wA
         Zz8WIVHqE8TCjXDh/4cDZj/b4HPcuAxWYwLawd29oXp/oDUfarH/Oi/uXtLk+cTSiC
         summ1EORjqdOFOK0k5K0i/nxtTVCSQ2j6blPTBMq2oZgMg/LSgToH5GP6BHWOmNo7W
         fQWdNdKXk4dJH7HIjE7VpPfHEhF3D5EnJsvNIS0lLmz1kdyUcHj
Date:   Tue, 5 Mar 2019 03:35:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Large object issue (Windows)
Message-ID: <20190305033526.GH601925@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Hogg <phogg@novamoon.net>, git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAFOcBz=+XZtcxPxeE3j6dpHXA79R_BOyDCtNbwSu+nbBpPzGrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
In-Reply-To: <CAFOcBz=+XZtcxPxeE3j6dpHXA79R_BOyDCtNbwSu+nbBpPzGrw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 07:04:02PM -0500, Patrick Hogg wrote:
> Hi all,
>=20
> While investigating the last issue I reported (and fixed) I was trying
> to come up with a good test case for repos with large objects. In the
> process I found an issue on Windows with objects at least 4g large:
>=20
> git init test
> cd test
> echo "*.exe binary" > .gitattributes
> truncate -s 4g nullbytes.exe
> git stage .
> git commit -m "Test"
> # This will break, complaining that the object is corrupt.
> git fsck --full
> # This will also break, complaining that the object is corrupt.
> #git gc
>=20
> I did some investigation and I think that this is a porting issue.
> unpack_object_header_buffer in packfile.c uses an unsigned long for the
> size. On Linux this will be 64 bits (at least on the Linux systems I've
> tried) but on Windows it's 32 bits. The code then decides that the
> object header is bad and bombs. However, if I move the repo to a Linux
> machine it can handle the data just fine. (And ironically git generated
> the object header when storing the object!)
>=20
> Is there any reason not to switch the unsigned longs in
> unpack_object_header_buffer (and its callers, wherever that may lead)
> to uint64_t? (Or any potential pitfalls in doing so that I would need
> to look out for?)

It's known that there are several problems with this, affecting various
parts of the code. Patches to fix this are of course welcome.

I think we've chosen to specify size_t for values which are stored
entirely in memory, since a buffer can't be larger than this size, and
off_t for sizes which refer to files or object sizes. The latter will be
64-bit on 32-bit systems when compiled with _FILE_OFFSET_BITS set to 64,
while the former will be 32-bit.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.13 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlx97n4ACgkQv1NdgR9S
9oumKxAAu6Wrljsqx4XFIIE9L3eB/jQc21/nV79myyW1TJFcilVDRtm8T4GjRALR
/tmrwCqx1Tr4COysw3rGueJaDMPzNLtdJ8PnKDbQr39MUieliv2UZq609afw21or
sVcstztAxegQzGMlzC3LHRCQ0+LSEAQaJv7BsEOF5kxkV8eFSbecvngh02/cIeLW
JxxhbH9MqM2jlW9CcR5pBQUR/2aBUNU/vxBUXS43OgWzC/tLePxSjPxtoFPpPe4F
qO9m/lAOUtiRLbWn3lzE5wdLMGhZRjX2B5kmRDLQ9q4Rcv/w+ai+haswOfG5e0Sn
mCkXLaEzr+mA2R8lo1SmA1qmm1oUnfORdvaFwzUlW4h29RGkPxPADoxxdt5+dodC
iwNLTpJXsE/yqTtu9sUsxkEcNsfXfL902nNl9tBQpq7TZOgUUiiJ6fpXZ4snaEtu
K23bbQnuaF6B0oSsiOrZbOyrB5PWHdCZrT9HNBI+thZXZINPhGD52dgX+afY5oFw
IsklbrFvf0qqjZaM6D6cmQETXoUIs8btoQkrTm/xRoe37KSMT4kXmlDZV3gto/K3
DOsUpw4eK1YhBgIPoTq27A7rsM+oHF4Zl3Ri+rkDXb13yPyxCRd8GFan0Xglnszu
64ZBiOnQf1AlJ4Zey3pi6W1UMeB7ewyG5QaIgmK7xbx2FJorjFE=
=rjZt
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CB620323
	for <e@80x24.org>; Sun, 19 Mar 2017 13:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbdCSNSy (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 09:18:54 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46368 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751464AbdCSNSy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Mar 2017 09:18:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4F878280AD;
        Sun, 19 Mar 2017 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489929531;
        bh=zvTR+/4F5x7lkD40fu3FGTRamL+GXZiAfidEy/9rt1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2ZmtAdeE2iDsdsZ9zz3OWBG7KFzwvRx1gP675ZrDUF9chkLxjzF6+sKvbCTDZcP9
         tuna9uh9ukM8OMU8Ba9T7bSdlrPxRzHvRbWMBcXG6izOfePFdGlKrotmxpNG/YDLo7
         GwwdxE9QlLmdXTLqbPe8aGTkgl3VWITKeQczomIwZd3vvWhb41+t+/L83XSJRR/3Ak
         8vGffqzfc6U/K0x32tLe4KRDC8xb4kU8mBxHtxcCkeG5XSnhlSEwmL/AO/UzTTETb+
         LBSOEXhdtn5kS2AP7JUaeZMO0JsjtcAHBYFBsgFw4VrZiaMR+nMJazmYepPlki/2Q9
         rgkEZKqSARw+MP0Hu4kj0btQs3I5pMgyaSFmYMGADUeOmHa42jXhuejEHOfhJhPNJ+
         6NtCptiJjcm4HBZQmuwInHXuQZpTRYbnDSXmLSmvJ9KuYlxI2bclFVJiemOKI2PjCv
         FJm85eJBWtMkmqc+OHE2r7+FjxXhp5WHeLT7ft+W08889U7Erwd
Date:   Sun, 19 Mar 2017 13:18:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Add configuration options for some commonly used command-line
 options
Message-ID: <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nnavdzjtsa2vn64z"
Content-Disposition: inline
In-Reply-To: <vpqa88hlghm.fsf@anie.imag.fr>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nnavdzjtsa2vn64z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 19, 2017 at 11:15:33AM +0100, Matthieu Moy wrote:
> I think the main problem is indeed "stop the users from shooting
> themselves in the foot". Many command-line options change the behavior
> completely so allowing users to enable them by default means allowing
> the users to change Git in such a way that scripts calling it are
> broken.
>=20
> This also doesn't help when troublshouting an issue as these options are
> typically something set once and for all and which you forget about.
> This typically leads to discussion in Q&A forums like:
>=20
> A: Can you run "git foo"?
> B: Here's the result: ...
> A: I don't understand, I can't reproduce here.
>=20
> just because B has a CLI option enabled by default.
>=20
> This is the same reasoning that leads Git to forbid aliasing an existing
> command to something else.
>=20
> OTOH, we already have almost "enable such or such option by default"
> with aliases. People who always run "git am" with "-3" can write
>=20
> [alias]
>         a3 =3D am -3
>=20
> and just run "git a3".

I tend to agree here.  At work, we have code that wants git status
--porcelain to be empty.  If a user added -b to all of their git status
calls (to make -s output more helpful), that would break a lot of
tooling.  It's much better if they create an alias, since that doesn't
affect automated tools.

I expect developers of things such as fugitive would dislike such a
feature as well.  I get the impression our existing config file options
already make life difficult enough.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nnavdzjtsa2vn64z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljOhTUACgkQv1NdgR9S
9ovWAg/+JHhh0o1mB1LfFlXCjl8McdXfeQEyigwdNsIUGA9MRJc1hWWjYyXJnbA1
RzWyJJceM/sNq0jPoeDHmeHf8Pex3ESUQ+FtdvILz88sxKM7Qz2HaaXUlOK0d8H4
4OvQEAuHuhWtefyoI0iVDtFN5MbJtyox0txBOcd+3saA3xpZH9yHGyWKk3l1tjca
PU5SlAlca9nia+t8aPghndwnqIBqnxcmFAQBPJeSmcuM7P0R2C9cnP1U32Qnozci
V7k0dLSVNOHxFUpwx0JL3mTHVErLhyfsXUGZY7f7LmM3VBSxTsPADs/YUx0jfcYv
ZxWp9+ALbPsFg0L4f28d4opIoWg1WaT4lfRZh21HD3dqk4d+sw9YFYHIj2l1cpiH
72jh43odEuDhIlpYsK0ibNp9JQ9LiL71kDX1hU/h+ZpGrIg/RHSltsC492XDWLKE
e43Qp0/lp7DElcbIMixCXQVitr7vfRNjKwx6XMhe1a7QPLpzhbRSoBMctvX5Ybhk
MCM+gWXFTp0/dDsCwBDMt3NBm/EqmnfKickdbZMqzkcsF1hbIPz7vVr00K2xGAFt
3FPvxn+iX5aPofUnNw1w03r/TVhbiDKqxaRNBiZfQOE5rLApasm4VXAkGnfrmg4t
7ZsR0syNSlE8qB72lbm+5/mOxFaiyicLhIETz4PxE8aSYz+2kOY=
=W4b/
-----END PGP SIGNATURE-----

--nnavdzjtsa2vn64z--

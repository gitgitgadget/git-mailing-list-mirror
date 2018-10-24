Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676B31F453
	for <e@80x24.org>; Wed, 24 Oct 2018 02:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeJXLZq (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:25:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51952 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbeJXLZp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Oct 2018 07:25:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D36361B74;
        Wed, 24 Oct 2018 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540347629;
        bh=2IKY4J6BQWs8dRSnWg4RmuLEkilRU7290sWigiSfMiU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fXIFW0Nh1pZdDw/DsDV9ZcF9UIti7z7PBBXJayDjqCh6OxBG1CcymhennAxFxfC7l
         UUUy3B0P6feUou1bECxIsQFWYubeWJVgUsKKZBJg1egZ+0E7bmRi89fHvOhv21xa+g
         md5r8x4/Za0Job/6TNwX6NyWAspa0dHLM/+YxgO3XgTqXaEplmQetC3KlrtgqlGdF2
         FqxMiMzWqMakUGJOcyfTuMJlTViu9+b5eJ5ITERdR57dHy1EkAiGWA0kc68/Y+DlBb
         fOGl9iiarDm07LGC6EQVZnTepoWVbMibF0PzUdWlUOQQtAXI8cmTw6L8aCHgSVHThY
         cgzGcOWSMk/wx8uz5fS75MDgdxivbJMUs/of9R6BlPcLDt7UpExOXAT8txQPrEXBq+
         5QyPmdGOmvFeeajNR5OGXeBXNI3RAYeku9iQ5L1pUyCtM5o4fHXWFKpoik4esTGMSW
         Oi1d7L1hu6DSOi1exZGVrnqrYcTgGayTMSFUdKl55mBBvbCD3Kx
Date:   Wed, 24 Oct 2018 02:20:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 2/3] mingw: replace MSVCRT's fstat() with a Win32-based
 implementation
Message-ID: <20181024022024.GE6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
References: <pull.53.git.gitgitgadget@gmail.com>
 <f2ce9bdc01892b514f75c6c25c3393765593b1ca.1540290197.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <f2ce9bdc01892b514f75c6c25c3393765593b1ca.1540290197.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 03:23:21AM -0700, Karsten Blees via GitGitGadget wr=
ote:
> -	if (!get_file_info_by_handle(fh, buf))
> +	case FILE_TYPE_CHAR:
> +	case FILE_TYPE_PIPE:
> +		/* initialize stat fields */
> +		memset(buf, 0, sizeof(*buf));
> +		buf->st_nlink =3D 1;
> +
> +		if (type =3D=3D FILE_TYPE_CHAR) {
> +			buf->st_mode =3D _S_IFCHR;
> +		} else {
> +			buf->st_mode =3D _S_IFIFO;
> +			if (PeekNamedPipe(fh, NULL, 0, NULL, &avail, NULL))
> +				buf->st_size =3D avail;

These lines strike me as a bit odd.  As far as I'm aware, Unix systems
don't return anything useful in this field when calling fstat on a pipe.
Is there a reason we fill this in on Windows?  If so, could the commit
message explain what that is?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvP1ugACgkQv1NdgR9S
9ovAQQ/+J+/+Iz/NEieoyl9djUerjZY5tjYwGbP3OlZVVpCIoQsF7fZPzrrAV4ev
KWUwqYqOWK+UUOqQL4LTPzE8EizJBhgzbfrJgZuIjvDL30Z0ywswOt9k0NGTiESt
SS7rsOAoln7+78covQwxMJGqTQmwopAMtPA1IO94cmPXDnSuW2VdydUkJGxbAIZj
7S8Ucxji9gEggEDj15XFpcx0b3Lth0XJSXm31gxtymH/ym4PYJBh3PZj6aR7w7nq
UHqvO1MrkaEz7Az2BoIaMiUngY/IrLhgLK64ddr11AeJXk2LhYSH+5TxeTw1/ZHJ
lDZtYuke228DcgFminuPyG2xHE21uhd381Zsaxzo1gBO9m4bYXuBvN7iPInDpnc2
v7ZCmseasbM4mP0/royRE4RvZKi+56GmWB3IbPcjo7yqx/Kd0aB8/ptQ9n17ZSp+
8edNBp3CmNwJUrU8IH99zkzj6LdB14rpMlIVgoDrfw+YVelfi4NpsbfeQeiYmHId
V5ZezS1L98pQcdCmUBCnLPceZmJ44aUeQt6C4044ibJ/IrjhsvCjJDo4OQLj0gjO
4qxhWQgpaUrp61YGLvvl0jlsoUsTrjg/WAOF74M2wS5/yousJugBKxAybE3E6jFk
U9RlNUawCyCpFsfDqDN1hM7B86mwxzAHBrFC1kEnn48WWnH5anA=
=BCD+
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

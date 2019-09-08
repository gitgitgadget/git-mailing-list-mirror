Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A1E1F461
	for <e@80x24.org>; Sun,  8 Sep 2019 18:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfIHSEH (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 14:04:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58598 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbfIHSEH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Sep 2019 14:04:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:2895:5875:49cb:eb31])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7B00B60448;
        Sun,  8 Sep 2019 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567965844;
        bh=yFPwvmfkcsh+rY61VNd7xfocSg7oQMVsLUZETYkyIOU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XJz6J6QSRSP3B2ZeEwVX0odX04itzJg6jhqAy2aQm/eFvcO363lj0rXfbaOpdLsDX
         3lsZPcBxqFfwzwyjYa/ZntDGLf+SYdD7+Xp1z7U1S0c+vwRHoImHgdRos+OM9c5fbD
         5N2PPxfZdbKRpL5bVQQ8/9wbkTukSX+MoMViJRvpfpLpBjL6hb/biSJrKP7l25DkJL
         OfTvc+KlRFvzEj3SPxTId0BKK3jNDJfTZOQ9kIEQq+kytvb46O97KZ61f0AI2OAMOt
         tmRIjJx9gf0ziItxtq6fiPpo1iDG9nHNi6kLjmcsU0BuSVeY9ex5dp2j2D0FBCnPOf
         TaqSGhquvD+wW6a+x1Bg4z3uKjIwn4+Poc8rp+4+8moyXH7Yfskmxy8Qs88s5On8Jt
         1e+X7hFp2z/SWTp22vFvKKiZpesrmZDRAAIMONuhc7MU5/2AESw0RCRvlsxdgcTgd2
         NJnA9ZaUKsMAxXsGV5W9WKXsXxivRhnXyTqHQFVd6xTGrqqFXnc
Date:   Sun, 8 Sep 2019 18:04:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Warren He <pickydaemon@gmail.com>
Cc:     me@ttaylorr.com, gitster@pobox.com, git@vger.kernel.org,
        wh109@yahoo.com
Subject: Re: [PATCH] rebase: introduce --update-branches option
Message-ID: <20190908180400.GM11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Warren He <pickydaemon@gmail.com>, me@ttaylorr.com,
        gitster@pobox.com, git@vger.kernel.org, wh109@yahoo.com
References: <20190903013959.GA40029@syl.lan>
 <20190907234146.1473-1-wh109@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="00sTfE/IIAT5d2r5"
Content-Disposition: inline
In-Reply-To: <20190907234146.1473-1-wh109@yahoo.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--00sTfE/IIAT5d2r5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-07 at 23:41:46, Warren He wrote:
> Brian, thanks for looking. The only thing I can come up with to say about=
 having
> lots of refs is that at least that part of this isn't brand new code. The=
 part
> that collects ref info uses the same routines as `git log --decorate`. Do=
 you
> recall how long that took in the repository with 80,000 refs?

It worked, but some colleagues at the time turned it off because it was
at the threshold of annoying.  Overall, it didn't perform so badly that
I think it would be a huge problem here, considering this is usually an
interactive operation, and I'm fine with adopting this solution for now
and then focusing on optimizing a bit more in the future.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--00sTfE/IIAT5d2r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl11QpAACgkQv1NdgR9S
9ovt+w/+KqksraKwy/cmknQqugDJyX1eSo5FQk1c6MYDD0wI8Kd6tqL8+Jv/wIjT
h6Mb0xypoCCrl6oTMfLTlIeziFF3rEHJ8pLxdEUEwW5663Ran6u/LV6k0tKKSbCS
OPYPgIcPWms217tyrOgYUWTpSJB0rVPH93rQDJDMi/Esu6mTlXiV42WFadsaUI6T
MUhLkFkEGzITfZ0XwBZ6tcVrgwUtFXHTYFsQjflkIodBdAWon4HrIaxxF2IQvpIG
jX91nGYbhew0MP8o8bWVyqw5Y7UZkJEcOIQ/spk7BLU9bvV7KQpmmjCnXlVVPcc9
njtWA9ArnfKt54+TZTeh8Lf8D57Cdh+n7ZziFILP2fKRu16obDIpihYd1SgDxxAf
H5W/ZRaKCpcsomG/Sted1y2G1jwq7D0GAPXtM6wk6vmahGVjGMlIioPk60XOygBc
xu6/vi0eF2P9k11QT7XZyWUSDJS31hY3njmQB+MghGXLrNoXocGtBI8lralvYGhy
LbNIiU+feohfwjkiDf+8Kkm9JjolfqJHZLHqqXyXWi3o03Ylh+1gC003cKzPxjAm
2TGWCOJuhuysGq/rPw2JUd4vuV0iLE4ODqhTl8vEtuRx+1V5repQxaDGmeEPP7pX
fSuMhvZAkIYuqiteR2SkF8E4u3thQyE74eqh4kfq3z8NN57ysrQ=
=+gTS
-----END PGP SIGNATURE-----

--00sTfE/IIAT5d2r5--

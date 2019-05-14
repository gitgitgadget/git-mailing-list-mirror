Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD2F1F461
	for <e@80x24.org>; Tue, 14 May 2019 02:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfENCO1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 22:14:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36520 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbfENCO0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 22:14:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CFC9D60443;
        Tue, 14 May 2019 02:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557800064;
        bh=OW7Wjz2OEOm++2H7kydHPf3TRTEb3ZrwQCZelOGxnX8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gSON7Z6+9DqaA8lUpiKsfFlPJ8vGMF2DuuKnB7sa2DrmYsUMVoZIyncHqv98vAMi9
         UyrPu6MwB+3dtKwzX5hM/hP/ddPy8arEwK4LBYNmaBdfNQOWWRm9SBTkD8tbSrWnY2
         ZjIqHVkyfxeDRydnyTU+sqJx9gwCCHxsQ+zNd+FMI8bQPJYQOEYE54AE9j1oOSM1HC
         1YlO2L2sep6CArCtA6tjMCIY1o3lO0dNzjXRM7WFiVLIMwjI2TtN8a3LpFGTZdZZ8B
         Eu9VP67Ek3ksIZRJVNwF7rMlcMT0uwvx0Wh7komd57T1EX1J6arYuDosHVQ22/fkXi
         Yhjx4R57IeOn3CPlQxq1xP6E9xF3+i3fHtAa04Gx1kDSlBToe86qpFmdiDBO+3Tip8
         wETwGvVLJjQdssSagaJu81U8ZygzvR/eLqJER49A78qvrik6d7D3YawmR/t9/nsxOv
         So68+SUEgAopS9SJ/ct6xqp2lgBgSRVKDmM54h5NhzNIAx0Wukh
Date:   Tue, 14 May 2019 02:14:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
Message-ID: <20190514021419.GI7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
References: <20190514020520.GI3654@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
In-Reply-To: <20190514020520.GI3654@pobox.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 10:05:20PM -0400, Todd Zullinger wrote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 908ddb9c46..599fd70e14 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1522,7 +1522,7 @@ test_lazy_prereq NOT_ROOT '
>  '
> =20
>  test_lazy_prereq JGIT '
> -	type jgit
> +	jgit --version
>  '

I think this is an improvement, not only because of the reasons you
mentioned, but because we remove the use of "type", which is not
guaranteed to be present in a POSIX shell.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzaJHsACgkQv1NdgR9S
9otcYg//eRJxkMszEnffS/yw4w6Z96D11RwQkD3GsmjM1m1fJNPHcbS/eH3zgtPg
E9X2d0zHM8QC906yLMquxT9Est7zSy6yHiIbHXlPpXbYvuPjHla1jT2VK1iB6TEg
Fcqak12ffG9gnyyJL4FEZogfr+oqenRCKVde1XyighcSRutSLrO3F4JJGC7HDXC2
5tn92xGXs6cbWaXpisf0zuKnfaiibmpBz1w3lUAV7hHAiTRc6l3sefpj0fhghe6F
hXbRmXiXetpc2X0qzqArM6WwHgtG/T5vGx+0OLLdEQC6J2V+MjHR7vcxyi5Dif0E
+mHnRx/y1ZeUkFcoeeWjUltQF6spghatBQtLg+afMGJkxd0CYAXk6RPLSbC72G+n
zKUwostqO0gXCeS90IocBtjJ+mZA3QXKQbegihhJL92tj2aScDfwoVKnZhpP0rXp
1HQQmnda8l9dSjJRMcNrSSjdJEbGA8Miw3YfrwhN66mlIFzTGv4APsKzZPqQsa+E
rZeT/lFaH7pq43N3deNxU/ba7Z0YvWcC/lASY8PdVv61fHSKlQnsGkFG7Cu10N9P
1tY8qXOJZqAvEITAuBV9NbsLYbHdaoXOeUb7M4kzbpIq3CKQg9wzfOdFVqm9RWL5
iuJpVekDIjfgrZnwJyXT2wteYf2YaszIPaj0bM7zx4OeyKA2eac=
=yVgt
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31BC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 19:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJJToI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJToH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 15:44:07 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166195FF48
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:44:06 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2675F5A127;
        Mon, 10 Oct 2022 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665431045;
        bh=6KzXAr6/PNusS6EO2fRdOb1QMbcI59D3ZHH6TnNb6ug=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=I4T1AaTkt3UFt5vqZ5PKSBB4qr8REPWhxHoUL8nQkdT6Nsrfhwz/W2yjeHklFF+RC
         vcRL+wHryCQq+4oE+nl4Az0rHxaaPLZzZT+DIW95k88qkZo2usYqcLX5tgYmvQMW+w
         i9fYnC07iuNe2QEcfanzSIr9fKwB0e/opllwXq0wbDj1qjyoErgzZ0wrX3LHvnYUtv
         Rn4m+o52Oz2OaIe9HTRKEVk9MXAupfTpOly4D5mQyuQnMydHOeJOdZ7MtUzHCwJ7hM
         sq+H5PYQzpHcjE+z+42C+8YwqHjIKoLzt5pNYi/NsA7N4NIM4rvpe/Sx+HC+PLeY79
         Ik7v1Ge1TTx2eNr0V6oVRKtshQ3VNNenBOs47SLf8iMff1RN2cmRqRPU/l2sSjrm+T
         TOAwWc+LM/zmypmGsn42zrxrZBgmsSMlnrDHboVp6h44QKbjWV5zFQT/XI3yuKXfWU
         zI+66iPHgqMCVjXOcdgqhoRGmttUBu9jjsigxt/Wcix1WpAsQu5
Date:   Mon, 10 Oct 2022 19:44:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     sndanailov@wired4ever.net
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: git-send-email: difference between ssl and tls
 smtp-encryption
Message-ID: <Y0R2AwKuXAVMP5Ma@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        sndanailov@wired4ever.net, git@vger.kernel.org
References: <20221010172859.13832-1-sndanailov@wired4ever.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5L43PRpPGznpmG3f"
Content-Disposition: inline
In-Reply-To: <20221010172859.13832-1-sndanailov@wired4ever.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5L43PRpPGznpmG3f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-10 at 17:28:59, sndanailov@wired4ever.net wrote:
> From: Sotir Danailov <sndanailov@wired4ever.net>
>=20
> New explanation for the difference between these values.
> It's hard to understand what they do based only on the names.
>=20
> Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
> ---
>  Documentation/git-send-email.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
> index 3290043053..4db32f05f0 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -178,8 +178,11 @@ Sending
>  	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
> =20
>  --smtp-encryption=3D<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> +	Specify the encryption to use, either 'ssl' or 'tls'. Any other
> +	value reverts to plain SMTP. The difference between the two for Git is
> +	that 'ssl' uses implicit encryption and defaults to port 465, 'tls'
> +	uses explicit encryption and defaults to port 25. Other ports might be
> +	used by the SMTP server. Default is the value of
>  	`sendemail.smtpEncryption`.

This is a definite improvement, but maybe we'd want to say that 'tls' is
really STARTTLS, while 'ssl' is always-on encryption over a dedicated
port.  It might also be worth mentioning that the choice of name doesn't
affect the actual protocol and version used and the user is almost
certainly using TLS either way.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5L43PRpPGznpmG3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0R2AwAKCRB8DEliiIei
gTL6AP9ESQOtdQS1OJNWi+/VftaNxdsOHilodDPnJC0hXXSmYAD+O8Ugvnh8NCTY
SDzb2zV22x7mCzsjp3oqXWVSOuERGQU=
=YElH
-----END PGP SIGNATURE-----

--5L43PRpPGznpmG3f--

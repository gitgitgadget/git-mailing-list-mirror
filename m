Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6530C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 23:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861FF20767
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 23:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f8ACNmPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406061AbgFYXIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:08:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40214 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404729AbgFYXIa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Jun 2020 19:08:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C01060459;
        Thu, 25 Jun 2020 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1593126479;
        bh=A2iAhVL9x1CRMAbDEYvLqkSf/r49EpdQc3QByKtWprw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=f8ACNmPG0/bYuPzHomJ2YFGKU5Dt6lRp8O6frKmTRaGQpeYnVj8BTM9FXXyeStzUw
         pOONVeiOGr6GqBoEz/M3O0/9NKJfM6tTCDtQQdNTxW00nOp4g9hwGPfB7dyvXj0AsW
         vapSJ084fIS+6o8U0giMX+xG2LmFCIgDWg/a6haGTFbhRca7LvO1zW2QIabHakwMpB
         pvM8Z8ph/kPAFd1zWIO9X318poHHDoj3gCcXUzEx6MwWYHSqsX6ot8ZBrE6jbZES5X
         F+BFKwZ5MsixXVNG8rfMA7zCJ2WXc5jpoOrC5X/Gp7M1spuD0KoGqpHurmP6lXV5S4
         E3wqV999+4kww0VRuTH0yvs6UtNfXHBrRlmWi7lJSDEjGomMfpjhXz4h/9ODnhdlon
         8W4glZ9yaEsInWGynebOzlgFEEkeZ4PQPovebbRppcXrHSOWfmys76wXhj3LBA4HIC
         RVliiMRfLIH/3hqQa+QSJVzpUxP0hDnoE2j5bYhbYt1CV2Obxzg
Date:   Thu, 25 Jun 2020 23:07:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, j6t@kdbg.org, jonathantanmy@google.com,
        peff@peff.net, Johannes.Schindelin@gmx.de,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 2/2] hex: make hash_to_hex_algop() and friends thread-safe
Message-ID: <20200625230753.GB9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        j6t@kdbg.org, jonathantanmy@google.com, peff@peff.net,
        Johannes.Schindelin@gmx.de, Fredrik Kuivinen <frekui@gmail.com>
References: <cover.1593115455.git.matheus.bernardino@usp.br>
 <0104cd9c763aee220a2df357834c79b10695ee35.1593115455.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <0104cd9c763aee220a2df357834c79b10695ee35.1593115455.git.matheus.bernardino@usp.br>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-25 at 20:32:57, Matheus Tavares wrote:
> +#ifdef HAVE_THREADS
> +	void *value;
> +
> +	if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
> +		die(_("failed to initialize threads' key for hash to hex conversion"));
> +
> +	value =3D pthread_key_getspecific(&hexbuf_array_key);

I think the portable name for this is "pthread_getspecific".  That
appears to be what POSIX specifies and what our Windows pthread compat
code uses.

> +	if (value) {
> +		ha =3D (struct hexbuf_array *) value;
> +	} else {
> +		ha =3D xmalloc(sizeof(*ha));
> +		if (pthread_key_setspecific(&hexbuf_array_key, (void *)ha))

Same thing here.

> +			die(_("failed to set thread buffer for hash to hex conversion"));
> +	}
> +#else
> +	ha =3D &default_hexbuf_array;
> +#endif
> +
> +	ha->idx =3D (ha->idx + 1) % ARRAY_SIZE(ha->bufs);
> +	return hash_to_hex_algop_r(ha->bufs[ha->idx], hash, algop);
>  }
> =20
>  char *hash_to_hex(const unsigned char *hash)
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvUuSQAKCRB8DEliiIei
gcjEAP9GNXbuiec7HpSr2U5XZ0aOsVOjDnjIWs8YUVxEICIXegEAtyhtyWPbh9gi
2Vvr4fDm+Z10b25gLJmXnINjw77kFwg=
=I4lI
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

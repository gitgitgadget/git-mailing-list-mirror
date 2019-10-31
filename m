Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 216901F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 19:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfJaTvF (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 15:51:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57450 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727528AbfJaTvF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Oct 2019 15:51:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 515C860423;
        Thu, 31 Oct 2019 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572551463;
        bh=QSkP8nc6eg546wY+gDDzk1WbUMEe1rpaKzzl36NUi7I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bnKa7nItdbkN9ZwYnoJ/nlFKL92aGj0PaSB+tJv6rUWGn+rtf7IDg3+2OQ2yFYy0S
         UTwUeXJvIPH4JPOvgfRtVuh2e6d7zBh8jmoQzTEp+CPU9Un8C8x7vL20bEIV8U8dt3
         8em/g1J+/5DhQiltZCAYM9knJjsxnuWAuiRkSsCuE3DUw0bhZj/1h5o/3jiVVvJms3
         l3qQ+V6U7fhhOiUwCyOqp1UD5YttZbKdOGslDFxoi7UNc3DBl5SUwOKpKHDNGoiRvG
         htw8Vyk/hALM7eTVC4WGHdNvjn+LmMqo2l01d/1Ow0E0SsoXA5p3eIGwXF2u0eAgmR
         LvMJKBDocwKyyI+i4eJVyJOKdPlz4jWJi6+VbzVoI80UXkcXctpQufq9nmJeotQNfm
         IRl0NteVMvEvIfQGP7hFxx873GqAd6LKUJbnepIazmRsHgDAGTkFIJoOWYJUo5MgJX
         NKzDkSmypEmZfVL90Hp2wZ1XEeojoDpXSJdUYQQGr76Ns6FW2An
Date:   Thu, 31 Oct 2019 19:50:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] t0028: eliminate non-standard usage of printf
Message-ID: <20191031195058.prp6cpx6ivf57lz7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-2-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lvyyxu6nt3idem6"
Content-Disposition: inline
In-Reply-To: <20191031092618.29073-2-congdanhqx@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6lvyyxu6nt3idem6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-31 at 09:26:16, Doan Tran Cong Danh wrote:
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-enco=
ding.sh
> index 7aa0945d8d..bfc4fb9af5 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -17,7 +17,7 @@ test_lazy_prereq NO_UTF32_BOM '
>  write_utf16 () {
>  	if test_have_prereq NO_UTF16_BOM
>  	then
> -		printf '\xfe\xff'
> +		printf '\376\377'
>  	fi &&
>  	iconv -f UTF-8 -t UTF-16
>  }
> @@ -25,7 +25,7 @@ write_utf16 () {
>  write_utf32 () {
>  	if test_have_prereq NO_UTF32_BOM
>  	then
> -		printf '\x00\x00\xfe\xff'
> +		printf '\0\0\376\377'
>  	fi &&
>  	iconv -f UTF-8 -t UTF-32
>  }

Yeah, this patch looks obviously correct.  For some reason, I knew that
printf(1) didn't accept hex sequences and yet I still wrote them.

As Peff pointed out, this is because we only trigger this case on musl;
musl is the only known implementation of iconv that produces big-endian
data without a BOM for UTF-16 and UTF-32.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6lvyyxu6nt3idem6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl27OyIACgkQv1NdgR9S
9ovAGA/+Iig7qwVycIhaNOabBeZIGLKxOtkYMFnLjTmYHXUdPmWMre985TJoqKaQ
UEgecn0kZX4tIpQLBY2eaRtrYMPQEAgUUwf3hiOeagbFO3p2X8VpQlRFTX3ARdA5
EybNSG6db3H90EkqK+P8g/nSiY5n77Csg/fmeSTQIf/zP3ayfujP0W6clCUqfvF5
rP73Ct4bxs1s2KcI9zxYm3CCttaaQ+aqE4YBk4BpdK1tS0nKROFc/pLV4eU+Ztwu
rRBaP7et6glwj1AIjAjBl/sOHxzOqMKhmeguHZ3+QEwj9lpPfOe30y0P8hydfRdV
+lJ83KUx94SziljrRQ0TPLTtbIx8GMwu8809NPKFhWO1i5AErrIYoZU9xNGG8Zhn
CYyewfojeFxII0HB933Lkno4Yjr6cfZhNzaPanboieDRxU3LQysLY540YkQIjrT4
wfwDpSzaH5HyKCvyA/NxNK3/4vXZPgR+2k5QoNY0r4/fZYGd2BwbU05EykDSHWaf
xZewNPr6ZcUgAhDckMWSPAb65mf+zHBADcaDr3aWkiyXsvdc2gD2z7OYboVDga9B
MSC7z9D5uQU1nzegA6xmKfDnSqz8jnmHQE3yxxp88XSr1bTjWH9EY4ap3sb5kzX+
VhNP6pi0YfKAOGaV65EAgWnEpE+v/f8ri+1R60sYMyLqNg8uxiw=
=Vxl3
-----END PGP SIGNATURE-----

--6lvyyxu6nt3idem6--

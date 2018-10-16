Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5AD1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJQHgL (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:36:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbeJQHgL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 03:36:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3ED8061B72;
        Tue, 16 Oct 2018 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539733400;
        bh=hU5raW3a2MDj/NOmp5WVvPfAZEKuOlKK3gBHmcZKCnE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CzPPcegORKZeCoEv5Qspu6TDRXKoclfjR2wnWtONjK2tTjLzrRjF6rz6LlOlhI9Sj
         1CIb/AETgii+ryQ14jLnQ+OPiueEgprUmzpBbdiVc+VfobSxyPBpIV7BEyWJIeSeSQ
         vI4hPvkMbcx+EtcJwxXrQ8twjoj89TxmKnY5FCbtaqPRhrmlr7vmzZS1HIwo5u6E8E
         AQbNXZf6vabg4cLc38T1pV90PKzRSSqJAmG+IMuowvV/T1t305wpLgkr3eXMmdGfw5
         8FlGjyHXWD4VOv/qmqqe4pmEwYKrraHyy9fe3D8kyW+nDOeCSOi+UOI08NIzxxIDoA
         j4wHYfDOPfRxscXF2Q+C4SQEw7kguaKGuyXW3GKMlBxmehUUj2FF8n6R7I6Sk4BLNQ
         gdKKRhQzLLQ/zwVorQS8gLLRClIm2Ptzw5CL1SqcjpDzeKjwBe0UI9vWhxFn/mrwgs
         s81rXv6ILkOIaWQSXI5fFoTyDAICBGsv/BWcs6KXkD8uty7BViH
Date:   Tue, 16 Oct 2018 23:43:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] pack-objects (mingw): demonstrate a segmentation
 fault with large deltas
Message-ID: <20181016234315.GG432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.47.git.gitgitgadget@gmail.com>
 <eb6d10133ac9b1977db81ff9c243e77639226f85.1539723766.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZEJJ1/LkT8WyxxO+"
Content-Disposition: inline
In-Reply-To: <eb6d10133ac9b1977db81ff9c243e77639226f85.1539723766.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZEJJ1/LkT8WyxxO+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 02:02:50PM -0700, Johannes Schindelin via GitGitGad=
get wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> There is a problem in the way 9ac3f0e5b3e4 (pack-objects: fix
> performance issues on packing large deltas, 2018-07-22) initializes that
> mutex in the `packing_data` struct. The problem manifests in a
> segmentation fault on Windows, when a mutex (AKA critical section) is
> accessed without being initialized. (With pthreads, you apparently do
> not really have to initialize them?)

This is a good catch.  You do have to initialize a pthread mutex, but on
amd64 Linux the default initializer is all zeros, so since we use a
static variable, it happens to coincidentally have the right value, so
we don't notice.

Thanks for fixing this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZEJJ1/LkT8WyxxO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvGd5MACgkQv1NdgR9S
9oudEg/8CsQ+6KtSKH50pk9tBswuGCXGsxv1RJ0VK4im6rwFgVMEv+xWxN2B29l/
nJd7gR29wf8ytWEK1tJMLU6ws3wWPHk5yXPl+8R2ZrPq8+v6n/x+Iaci1rCfEa/7
euS7W4I6/LoZSiahccbLaxT/TdD/8IYTX5Qj/8a/sUFHekDVEiW6lYGPEptbiom7
vvlWl700T1eSRABgeEacwkPcxH4yEwEmHTH365JM+YmacP4lQrWMswFymfJjx4d9
oJ8SUZquX3PCF98ZCBu31WWu/K/PuDLbGqq8nxl+RhDjJUOC85P0/XJ9j983hRCm
KbVUV8jWRtrKRAG7u/RCc38lYcvc3eZ6/3pwlEpAdiMXK5zGz1f6fHK90QakGbFG
6p9XLFKzr4VUKQmtiVB93q8pguaKlKlO8CivFnu8FMWNea0CoMo8aWy+YquWwYJ7
wXlvKo0ANeHItuz34Oe1ze+3D0DVNCg4AOoRGjY9yprH4U4H8ldMtQjJECnkmw3K
YYsCpdWAcFU9x6Y7CAeabmQq5XkcxN71yWV+qWuvCL+LnryzX8+sh+IPhTjPExGR
UPqOXksN+QRa3fgJ3BIIxMzoaGDjnA2kT2uvtFp50mqmBT4hBRcuYPeTJhXgSbwp
c1KGdm4jyXNRml3wpHMAUiIQ0p+CqPrvEb7OCfmzKjFLaWpNs88=
=cL6H
-----END PGP SIGNATURE-----

--ZEJJ1/LkT8WyxxO+--

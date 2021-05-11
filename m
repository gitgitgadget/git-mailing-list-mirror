Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9747FC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600D8611BF
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKX2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:28:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52344 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhEKX2J (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 19:28:09 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D05260749;
        Tue, 11 May 2021 23:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620775613;
        bh=RES2D7e8HBMmbPU2nrkHjvoaJbxiTSB+Nd8frJXxfq8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iX3ZOE2w5PdW/yX9kW2ArJoYOosCLmWj5GqeJhNbnCX5u1NavSLNlxEVNFQnLXc/I
         2KxA354ivEHm7eRj5y3qA6KQLYh2jTjiCBVm/gc0KUXKoRSjuN/2F842iPFBuxaHqM
         juSY+VHDFw9ZMdQ35WMALZRGC73QbPzXdYbRIRMf3KArzjVY8ad1NTw3QlCqGKb+vm
         VZWs5rX7XYUYagm8KDnr8dzJ52FoGw6Ps63fn20cjaEd0VzwDKPWlbLjFInh2q+NaG
         JsjL8mSIEqnxC5J6/waUtB0BkpqzmmuTYW2ZXZJjYWMQcD7p4ZfcRE4Ry/vwq86S2w
         KJDZhm86DB6f6OENhm9omKHNHnXYzb12/ArAblWn5SHpG82GJ7QcXI3v8udODrbhdV
         wE5xrNIv/bF2lKgSF4OvIrwj++jFQLjAQ8bWf34fpgz/lSFVNo8iYvkIfBxX3aCFhF
         f4UfpN4qnNRAo5ApzVgeLCqB4mH6H1a2P5pRaWTqwl83XSDKDX4
Date:   Tue, 11 May 2021 23:26:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] doc: use asciidoctor to build man pages directly
Message-ID: <YJsSuAscwHwRo84R@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20210511222754.417371-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwTvG9GY1U/KIK4J"
Content-Disposition: inline
In-Reply-To: <20210511222754.417371-1-felipe.contreras@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rwTvG9GY1U/KIK4J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-11 at 22:27:54, Felipe Contreras wrote:
> There's no need to use xmlto to build the man pages when modern
> asciidoctor can do it by itself.
>=20
> This new mode will be active only when USE_ASCIIDOCTOR is set.
>=20
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2aae4c9cbb..0cfa88a92b 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -196,6 +196,7 @@ ASCIIDOC_EXTRA +=3D -alitdd=3D'&\#x2d;&\#x2d;'
>  DBLATEX_COMMON =3D
>  XMLTO_EXTRA +=3D --skip-validation
>  XMLTO_EXTRA +=3D -x manpage.xsl
> +TXT_TO_MAN =3D $(ASCIIDOC_COMMON) -b manpage
>  endif

As I mentioned elsewhere, this breaks the linkgit functionality since we
don't have a patch for the asciidoctor-extensions.rb file and it also
doesn't honor GNU_ROFF, which means that copying and pasting from manual
pages is problematic on systems which use groff.

I'd prefer if we put this behind an option so that just because someone
like me who builds with Asciidoctor doesn't have to get this behavior.
We may by default enable that option if the issues I mentioned above are
addressed, but it would still be nice to have an option to enable the
legacy behavior, if only for those people who may be using older
versions of Asciidoctor.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--rwTvG9GY1U/KIK4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJsSuAAKCRB8DEliiIei
gVUUAQDx3RxnXilaEw9i/aBURfu7xJAvkmMFV5ildgwoyDCuWwD/efUrArsJSw/r
5rPlpZdQKjJEorDVwRha+BIwKMvqmAY=
=llOL
-----END PGP SIGNATURE-----

--rwTvG9GY1U/KIK4J--

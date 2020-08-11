Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5CCC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478B32076B
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 10:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VyppIEmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHKKAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:00:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41456 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728265AbgHKKAT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Aug 2020 06:00:19 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6881F60129;
        Tue, 11 Aug 2020 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597139987;
        bh=ZimxW0DoTB/VSdFkKcZc8ftfg68Egc4Oc000teAV+Qs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VyppIEmTnVikYi3f3rFF12rAjSRXAZvU5Z/ZHOcAgtTbBsH3RC7qqAWBVe6SFo62E
         R+oToxb1BbDsMWeq2Xi2NEjF8JdlDfwo5I+3kIqY/Md3hk2L7TYpBahECPDv1zsfkP
         ss6igjO3OKPnxLa6OwGim8au5yFC63nxLuVvW6nSs2/yGGwBnCtm4x8VMDnIEaQILd
         J/Eil/F5WQxw1maAfquZK04kHWu5eF5bOC/WG8xi+x5ymy9azQDFx5CyiBhz148XgC
         NNcLoUzylES+HIUpqAQ5kadc3kQr7M9yUr7TJpgr8GfvPwR5oZcdI1PznfAAL8usB1
         Nv3/pznUWnFGm3KN5MvbX7lHT64AyF7gwZlV5pLW97W/+mtMSPPpWWtzZmb6XHM4Fx
         S258tgtTnPZt6e62jlj40/AM7r7PJqbaVs5DO26OieinSpK5acXDub3Y7VU2JXmiRi
         vjiLXBwfUIaxu2wcJ4R2bBhQW7C5k9e0JCZnXEEOmzkr90aaVts
Date:   Tue, 11 Aug 2020 09:59:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
Message-ID: <20200811095942.GG8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
 <20200811065347.GA1486938@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <20200811065347.GA1486938@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-11 at 06:53:47, Jeff King wrote:
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index d4d19194bf..f6e741c6c0 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -7,6 +7,7 @@ test_description=3D'reference transaction hooks'
>  test_expect_success setup '
>  	mkdir -p .git/hooks &&
>  	test_commit PRE &&
> +	PRE_OID=3D$(git rev-parse PRE) &&
>  	test_commit POST &&
>  	POST_OID=3D$(git rev-parse POST)
>  '
> @@ -120,10 +121,10 @@ test_expect_success 'interleaving hook calls succee=
d' '
>  	EOF
> =20
>  	cat >expect <<-EOF &&
> -		hooks/update refs/tags/PRE 0000000000000000000000000000000000000000 63=
ac8e7bcdb882293465435909f54a96de17d4f7
> +		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
>  		hooks/reference-transaction prepared
>  		hooks/reference-transaction committed
> -		hooks/update refs/tags/POST 0000000000000000000000000000000000000000 9=
9d53161c3a0a903b6561b9f6c0c665b3a476401
> +		hooks/update refs/tags/POST $ZERO_OID $POST_OID
>  		hooks/reference-transaction prepared
>  		hooks/reference-transaction committed
>  	EOF

Yeah, this looks reasonable.  I'm glad we've got CI working on the
SHA-256 code now to catch these kinds of things.
--=20
brian m. carlson: Houston, Texas, US

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzJsDQAKCRB8DEliiIei
gbSQAQDOJ+eSkhTHGWpPd8hj8a1nzyRYn4zE+u3x5qh0ttmuCwD/WEE5VzjGthC/
QDTcy2qhOytFSXzZWQo7Urxq/zpWygY=
=VAyJ
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--

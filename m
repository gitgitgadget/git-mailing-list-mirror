Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A8EC32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 21:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIUV1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIUV1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 17:27:03 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA106A5C7F
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 14:27:00 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 057005A1DF;
        Wed, 21 Sep 2022 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663795619;
        bh=Osb4eZ4PkGhhp6MAwtajvkP+YYTfVFPg+RNLTFLJXWc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s5wn9vwa408AYXY4WaS1UEFYpOUc5AfUaeVVDw8jNtHWzGrB7A1MfneoxXG4hXxNp
         AaoMiCcvStP/hmzHacg5KwTV+jfHDV13pL23uGoFeeFFArOoXk2Yn1VV4lkd/mCbxu
         moiOybK1RLOOvLUyrXqe9si8FqDssAuuZZ7wPLVpc1/VND4jj2Yg8xWaCv7DhMvQeY
         zVycdXUTrOAiFeJcJMKo8G/mkQPpvP/CqyXC+F0WIJ22BSUlPDEXgPoSCuPe4afECT
         JhRzuOFHwTjKP5k2YIvkDZQXaJ4lkerMEDIEVr47c5ZRG4t8E1hUPlLP637eEF431O
         64CLbMWLhMT6UecU5nU33deKVJRbk7G2dsyNTgcR68oAq28iI8ABbb8L7CjuRPsoZf
         puJdNkoRCBn+HXSK0lKLXH4oUDTzly7dbmsn+q6108Fbo2IP6Yb68U9y3RCYFg9BaI
         LgV5f6eU10TDAdKVbySemiAbnNv/deiwUoN2oehnnvIgUtCTFP8
Date:   Wed, 21 Sep 2022 21:26:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Marcin Wisnicki <mwisnicki@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Support SSL_CERT_DIR
Message-ID: <YyuBoU1ZPaHiSeiU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Marcin Wisnicki <mwisnicki@gmail.com>, git <git@vger.kernel.org>
References: <CAC9GOO8Y+5pXWPSPhxFdugT66MZj1rKkZ1Td=frPTF8vo73Nhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PrnzZzrXdLvhHto3"
Content-Disposition: inline
In-Reply-To: <CAC9GOO8Y+5pXWPSPhxFdugT66MZj1rKkZ1Td=frPTF8vo73Nhw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PrnzZzrXdLvhHto3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-20 at 22:00:11, Marcin Wisnicki wrote:
> Is there any good reason why git ignores well established SSL_CERT_DIR
> and uses only git-specific GIT_SSL_CAPATH?
> Why not fallback to the standard variable if git one isn't set?
> IMHO current behavior is bad UX.

It looks like that variable is specific to OpenSSL.  Git may use a
variety of TLS libraries, and typically on Linux distributions, which
cannot legally distribute both Git and OpenSSL linked together, the TLS
library isn't OpenSSL at all.

Personally, I've never heard of this environment variable before, so it
probably wasn't chosen because nobody else had heard of it, either. It's
possible if someone sent a patch to check it such a change might be
accepted (or not).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--PrnzZzrXdLvhHto3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYyuBoQAKCRB8DEliiIei
gTfuAP9HhnR71LbVp65OPC5n2AT5jEDkYmCp1NWWMmXLviG8UAD/Yq8w1VIGqIqr
YN9c4YTeMC7qMMbXVHZNwTrN2Lpnigk=
=IyEh
-----END PGP SIGNATURE-----

--PrnzZzrXdLvhHto3--

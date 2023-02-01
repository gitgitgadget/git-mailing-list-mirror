Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53313C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBAXS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAXSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:18:46 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448D244B3
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:18:41 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 59EE95A210;
        Wed,  1 Feb 2023 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675293520;
        bh=INP8wz/n9kyDvXxHhwtwa2Qn1SxsW7BtJC8/+keX814=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fHzWRhsQ3bRpNFyPjC5ZiKLw34RNyoyyOlbpQdgIafKm/8eq9+GiLtnzprIz05uCo
         U7X8iAxnfbVJv5QXp/K8KAxaJjLNQD7zw2VhhCuSjrLJknC4QEoiQwqAa6jxkqFKqn
         8RUhME539gZfKmQRZ2dKiT+G25oRxxINvzqduiSu0gMKWxM0Ywu3ZDlA4FhOHZaDwG
         2ESwVBP4wj1xhEEONv5YZT5EN88pV72lXhkg/VIqsUIZD5uGFFQzT1HQjUlMVdRnf7
         SqLzK2XGtcf4YRivKMtEmZQfyjd9WFI74xa650NXWbbHFjjpfrMXCkNFw5gekJ35sU
         9POASu63uFKz3C8vD4RBOn8+GIxaxmW1GFyA+3f7JYiYeIQ/CieM7se11cjc4LnFZn
         /Wbd/b6pWNqfqHXV2mV8sMM2DpdsweaoU7UFhyVL/0XV1knKFuOAKFXc8LkJLCq8PU
         FOUszzAHJsccWz7iKknSkzVA37CC0KmYgm4+Lwpb8Ju8URnlODR
Date:   Wed, 1 Feb 2023 23:18:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9rzT2r1rjhn+/HW@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <230201.86lelhr1wv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKwyT5c9i5N3rfvS"
Content-Disposition: inline
In-Reply-To: <230201.86lelhr1wv.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NKwyT5c9i5N3rfvS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-01 at 12:42:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, Jan 31 2023, brian m. carlson wrote:
>=20
> > Since then, I've been very opposed to us guaranteeing output format
> > consistency without explicitly doing so.  I had sent some patches before
> > that I don't think ever got picked up that documented this explicitly.
> > I very much don't want people to come to rely on our behaviour unless we
> > explicitly guarantee it.
>=20
> FWIW I think the reason that didn't get picked up (I went back and read
> the discussion) is that there was some feedback on the v1, [1] suggested
> (at least to me) that you'd re-roll it, but that re-roll never seems to
> have made it to the list.

That may very well have been the case.  As mentioned upthread, I have
very limited time to work on Git these days, and sometimes things just
fall through the cracks.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--NKwyT5c9i5N3rfvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9rzTwAKCRB8DEliiIei
gRW6APsF4+AhhQ2sFL0Iy8VPVJInB6NRUxQy7wLMz+u3J3mupQD+JFlFfjRF9QkM
BkTJIr1HShnvgKbSwI36XD91jxbuMw0=
=G3KK
-----END PGP SIGNATURE-----

--NKwyT5c9i5N3rfvS--

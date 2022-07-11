Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861AC433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 22:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiGKWmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiGKWmr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 18:42:47 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B3A52DF0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 15:42:45 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C8AD65A1BA;
        Mon, 11 Jul 2022 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657579364;
        bh=pxS21eVCjCAvlaGA3cscS8YJv+dpnW9xEb0tNtTQJ6g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qDPMcslWN4/2l0+pzvcU2cBzak2VSML5PsOwoI7aKHlEAHERnxD3bXLcJxyvVM1BZ
         Fy8cFkV43St2M+WOwI15L4ocU25JteX3iwu/ngOWd9aLHMH7TY8Y3Fr+6oeBGXVJ6S
         PzdvshEZ9mj9EFPJHzCcNxeTGpFNm73TNRwyAALa/4R5csUK8q9X81CPjbs+gdGEYO
         xsMPzC2oXO4KPdjfmsexIrhhtwiCXIVbqHI/oWVZQuADul7zmx49io1lDTXgrj1yLE
         39odo+23A9Va1ingCoHPKT8j5iDBX3lW4Da4CrNBMNBwEPz8JG6vU+pKbBollXy3q/
         s/wpIKk+wuo+FoqBTY2BbGuMUzq21nnmoHV8djCU3sqS0UNOvEVDpk8q/j5Sv53yIO
         SuZOwBhsOJbPXcQSMMi6yD0g/5cgASEIw1HaSA7PJ5ccOS3NOxV3KCHwe36XXbVdHi
         yjw8frY+9rpgtPKL16f/op8sXoh58W+ItdEozG4e37UAJ2qSq/z
Date:   Mon, 11 Jul 2022 22:42:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 2/4] .clang-format: Add a BitFieldColonSpacing=None
 rule
Message-ID: <YsynY24oV47q7YxU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
 <RFC-patch-2.4-cb69bfa0d0d-20220711T110019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X19kXap1bVp5Zzsa"
Content-Disposition: inline
In-Reply-To: <RFC-patch-2.4-cb69bfa0d0d-20220711T110019Z-avarab@gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X19kXap1bVp5Zzsa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-11 at 11:37:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Formatting bitfield as "unsigned foo:1" is the usual style in this
> project, not "unsigned foo : 1", which clang-format will use by
> default.
>=20
> Before & after this change running "make style-all-diff-apply" will
> yield:
>=20
> 	582 files changed, 32029 insertions(+), 29794 deletions(-)
> 	579 files changed, 32065 insertions(+), 29818 deletions(-)
>=20
> However this highlights a major limitation in this approach, because
> clang-format v12 or newer is required for this rule, but that version
> was only released in April 2021.

This isn't supported on Debian stable, which has clang 11.  I think we
should expect that to be a viable development target here, and I know
it's what some Git developers actually use.

I think for now we should drop this patch, and we can reconsider it in
the future.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--X19kXap1bVp5Zzsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYsynYwAKCRB8DEliiIei
gS9cAP9s0WUJ4cmAtxDDW8yCPEtUR0TUL+GHc9w3PgnxI1sQFgEA7lv0lJfP/Iec
U94kPFHUfchFmrW6KYXNfepaCaDFEgM=
=EkRu
-----END PGP SIGNATURE-----

--X19kXap1bVp5Zzsa--

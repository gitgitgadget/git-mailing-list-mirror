Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA55C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbiCIWLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiCIWLf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:11:35 -0500
X-Greylist: delayed 159605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 14:10:35 PST
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F1120E97
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:10:35 -0800 (PST)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A67B15A3C0;
        Wed,  9 Mar 2022 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646863834;
        bh=Br+EkZ1Z8fZ7uRw3TMOXG8jBO/PAsCMmCnUNgwYHXdk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tW7JjtagemoR//ihp4XjyLfNXKPP/RqMEUYphRThglodB6po1rRtaEIita6klWD+2
         8C4vWE94Rrf7WppGNgnLVGSNme9xmqyRIrFPrqFcMBPUL5mettxmD6Vn7UgNXWzL4x
         loe9Q9ygjGkBQHhft31izDUEzy7AHGtM9mHl/5e5WSO4Kngsm0LpuFVIHJrctyJaYN
         NJyJVVTIw09Wax/q7DmPK6ue29iHh73v58YhwBtG7UMdVdMjSrVK/W2UnkdJis0X3E
         uC+Ino4Vdk1Aa90qBMsFKfKUzqXQiYrSb12l5mHm2L1Vn44bNLPKM/IXymNiqTs0nO
         wk2Ih3QPgI36yQj9cYD86+/gJ+djz2N85Y6U03v4xKsjZsaRDYf4xrpocvb0SnP+LB
         kiNbGbWU8+5t/D3iHDOGs+XJp+ne9/M+QgI1gOjj6J6M7CMgXc4Bmug3t+WLZC9L6k
         ROJNGBE3zeZOgkibXgDWBRflNIj+oP7CA/pGqmxYUcT+83kmnrw
Date:   Wed, 9 Mar 2022 22:10:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] block-sha1: remove use of assembly
Message-ID: <Yikl2eGbc8sPsy5G@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
 <20220308022240.2809483-1-sandals@crustytoothpaste.net>
 <220308.864k48y35f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="usuLAtVvx/s5JbLy"
Content-Disposition: inline
In-Reply-To: <220308.864k48y35f.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--usuLAtVvx/s5JbLy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-08 at 13:38:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, Mar 08 2022, brian m. carlson wrote:
>=20
> I think the $subject of the patch needs updating. It's not removing all
> the assemply from the file, after this patch we still have the
> ARM-specific assembly.
>=20
> I don't have a box to test that on, but I wonder if that also triggers
> the pedantic mode?
>=20
> Perhaps:
>=20
>     block-sha1: remove superfluous i386 and x86-64 assembly

I suspect it has the same problem.  My inclination is to just remove it,
because my guess is that the compiler has gotten smarter between 2009
and now.

I honestly intend to just remove this code in a future version because
everyone not using SHA1DC has a security problem and we shouldn't offer
insecure options.

However, I think for now, I'm just going to reroll this with the new
title and then I can remove it in a future version unless somebody with
an ARM system can relatively quickly tell me whether it's necessary.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--usuLAtVvx/s5JbLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYikl1wAKCRB8DEliiIei
gUwGAP0TtoENvPYE3/BLwFc00y7gxQ8Xv4XOVmjRqS6NygM7owD/RPca9+4ecghN
RVIIeDzK+HP/xFj8RgG7++eZ4/npEQc=
=od8Z
-----END PGP SIGNATURE-----

--usuLAtVvx/s5JbLy--

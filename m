Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F28C35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 03:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54BF20836
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 03:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xeWdQZI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBXDnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:43:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40052 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbgBXDnI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Feb 2020 22:43:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3A0026048E;
        Mon, 24 Feb 2020 03:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582515786;
        bh=IjPq9acNMpFmvYOWTJBEKVdIwPG4ouswUhCO02Ghsak=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xeWdQZI627uLgnlRAVa35jxAunJvNK/Kf5FtE6lLrg3gfyheuRXJYn6HS4MpqC+8r
         tF4l3RCTO9xyCkbDTsWEmbg0yhVq2EezQ9DeVvwk77yLt1J0RMSynABmik6AeT1zds
         OXYLWo41JUFPL8sUlt9c7v8A1HC8R9TQSp9/6PFz2msABK4zg47TGZkt2BAXFFNKC8
         m2qsBNYpe9lwyJyPAxryz5is90dtTH6/IUfjLg60P7arMEMNXjUYrV3jxXoiga4mF1
         KsJvhm5yK+Sa6yvSRgChowH9cKbaHtctfIMaKnrYBvd/wmzgYumnDQ1EXeQ9Fxs3QD
         wMqEw2SnNtha1gNN2HykgdLRJu0NF/+byyG3P5zfxQnL64rGks+qfiJsH6xNdI7Vve
         XcHHdRi/aPWlFpYKlMdfk7N8LNPcRZIpoCPbAHGxtdvfxXi25DWqmXCmkqKvA/nWvw
         CKo+MD/v+lEVM35tb809XC+gnMcl8vUZc1LuJbiO1TO/ez8QdVx
Date:   Mon, 24 Feb 2020 03:42:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/24] builtin/pack-objects: make hash agnostic
Message-ID: <20200224034259.GG6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-2-sandals@crustytoothpaste.net>
 <20200223215759.GC564691@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <20200223215759.GC564691@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-23 at 21:57:59, Jeff King wrote:
> On Sat, Feb 22, 2020 at 08:17:26PM +0000, brian m. carlson wrote:
>=20
> > Avoid hard-coding a hash size, instead preferring to use the_hash_algo.
> > [...]
> > -			hashwrite(out, base_sha1, 20);
> > +			hashwrite(out, base_sha1, the_hash_algo->rawsz);
>=20
> Yeah, looks obviously correct (and I think this is new from the
> pack-reuse patches of mine that Christian sent recently).

I believe it is, which is why I CC'd you on it.

> The name "base_sha1" is clearly not great either. It could be changed
> trivially, but the real sin is that it comes from
> nth_packed_object_sha1(). It could be replaced with
> nth_packed_object_oid() at the cost of an extra hash copy, which isn't
> too bad.

I probably should send a series getting rid of the rest of the "sha1"
places in our code, because there are a lot of them, but I just haven't
gotten around to it yet.  And yeah, as you mentioned, there are still a
lot of places using nth_packed_object_sha1.

> It would be nice to get rid of that function entirely. In most cases,
> it's either free to do so (we end up copying the result into an oid
> anyway) or we pay for one extra hashcpy (out of the mmap into a local
> struct). But the one in pack-check.c:verify_packfile() is tricky; we
> store a pointer per object into the index mmap, and we'd have to switch
> to storing an oid per object. Given that the code isn't commonly run
> (and other operations like _generating_ the index in the first place are
> clearly OK with the extra memory hit), I think I'd be OK with that in
> the name of cleanliness.

Yeah, that's why I hadn't switched it out earlier.

> I think it would also be correct to cast the mmap'd bytes to a "struct
> object_id" given that the struct contains the hash bytes as the first
> member. I worry a little that we'd get no compiler warning of the
> breakage if that assumption changes, but it also seems unlikely to do
> so.

In the future, struct object_id will get a new member (an algorithm
value), but I think it's fine to make the assumption that the hash bytes
are first.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5TRkMACgkQv1NdgR9S
9oueug//SjTtST1rjVo2hEaI0siv0Xm+wtlek7wuE8qW6Woazw2ftMubWj3i27lK
GuAH9yY3+S9DJ1yZRHTL2KlPNo/mfbs8m8IX/Pkm4c6LkPCUuzLKReIonBlMa1bs
jcuPvkfN+rVCOt/AimPZJj9ZU2yGBjIGPNAGY4WAgrUiGdmRrNGfmYmEkImlzNxO
ZBqpXpC/IRurggNTzfLp2+uzZIY4vCydZO9dZIrSaaXFy/1rPVuON1qcMwJIgFb+
KdPNRkS/IPC/G5dBEt8uhm9aAsKsMP9E7Vbbdhj8ukCfwJmnLsfUZzK7NjYmuFPG
ZpsvcbodKstmozvlz52t/+nqArw/yHqno7lPyKVjQH/PNzcQFjYtqghfysacoAIk
g/lw+bnZm6980Z5wxWQjL0TIxWbtn/YIcUrb3PKsLBNlWw0/UhnAdvQ6B4MkDFHq
F+dCzZ3PwBK7YqMFxeBMEd1O8U9A8++DnzAtFsroA8BTJeNKtTkvPohOzBOOrGbg
9L7OWx+Q4Vr3Y6Tph7e7OfmA3EdxmvZdiMKntAtK9oEDmwISfBNYHTGqzGXiQirW
KbX89WjHc8atuVKErpN88GN4z2cC9m0nHnITW/ozBBWQHwXmhK9Ir8nX2DdOrNDg
zBrwzU8tXa0TuiNFEOaWO4c8MEjjQf+JIz0q5mgK/JnX/A5ur7E=
=Mm+9
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--

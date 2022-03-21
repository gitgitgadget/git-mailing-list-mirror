Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C108C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiCUVVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiCUVVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 17:21:53 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEAE192344
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 14:19:53 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9482B5A0C8;
        Mon, 21 Mar 2022 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647897591;
        bh=NtBk8SYM1Hjj//dhDjEfeamznc0l/vAx8WKXWd9FCpk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MWKXDAt/i4u14oC3r28UQU5IPe05RAUQDS8b2jl3vzlRIX7Jrw8QwCeHDS8EpMLgz
         Pc06SNOQydNIPT/1FyCCHZhTzMyAdGlodMsG+F3Iyf6BlUtE76pyEHL1RO6LeTu9QP
         lF4zahEC88NJ37QNHluSJTvOS+r+HS1iy9VE0Gh2OpPzScznjrLr/1JYowy9NCV5tT
         24ANMeQaxhReG72qJoI5fyVWX+xioj6DRd92NEeBHFPu242e/O2pjYJ02n/B+VeiyD
         DIb7nJA8HzLNDBUQtGEEnFwGpClMPhU8fOCwmjOufJ8YvpN1QLIiCW6kVEzHzOCzqj
         HynwK9bI7BZcW82iFXnmZgIigyiQN2BV2ulZ4/r+uB1mLLoTBaMZVAyp2MzxktY5Wk
         ky1Q/YzfuWixevv7jTpWG7487z+uwseM+KrvsnO/sC5h/RYMOcPKm4uFnBBGU11qLv
         BS3Jb/5XfXf0R4/9V25L6EbXbanNHzyPNPQXwFKLVodq4i5USHb
Date:   Mon, 21 Mar 2022 21:19:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Mike Hommey <mh@glandium.org>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] ppc: remove custom SHA-1 implementation
Message-ID: <Yjjr9fkybVmB53M7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Mike Hommey <mh@glandium.org>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <patch-1.1-05dcdca3877-20220319T005952Z-avarab@gmail.com>
 <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JiyWO78N0HaVYDHI"
Content-Disposition: inline
In-Reply-To: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JiyWO78N0HaVYDHI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-21 at 17:06:12, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Remove the PPC_SHA1 implementation added in a6ef3518f9a ([PATCH] PPC
> assembly implementation of SHA1, 2005-04-22). When this was added
> Apple consumer hardware used the PPC architecture, and the
> implementation was intended to improve SHA-1 speed there.
>=20
> Since it was added we've moved to DC_SHA1 by default, and anyone
> wanting hard-rolled non-DC SHA-1 implementation can use OpenSSL's via
> the OPENSSL_SHA1 knob.
>=20
> I'm unsure if this was ever supposed to work on 64-bit PPC. It clearly
> originally targeted 32 bit PPC, but there's some mailing list
> references to this being tried on G5 (PPC 970). I can't get it to do
> anything but segfault on the BE POWER8 machine in the GCC compile
> farm. Anyone caring about speed on PPC these days is likely to be
> using IBM's POWER, not PPC 970.
>=20
> There have been proposals to entirely remove non-DC_SHA1
> implementations from the tree[1]. I think per [2] that would be a bit
> overzealous. I.e. there are various set-ups git's speed is going to be
> more important than the relatively implausible SHA-1 collision attack,
> or where such attacks are entirely mitigated by other means (e.g. by
> incoming objects being checked with DC_SHA1).
>=20
> The main reason for doing so at this point is to simplify follow-up
> Makefile change. Since PPC_SHA1 included the only in-tree *.S assembly
> file we needed to keep around special support for building objects
> from it. By getting rid of it we know we'll always build *.o from *.c
> files, which makes the build process simpler.
>=20
> As an aside the code being removed here was also throwing warnings
> with the "-pedantic" flag, but let's remove it instead of fixing it,
> as 544d93bc3b4 (block-sha1: remove use of obsolete x86 assembly,
> 2022-03-10) did for block-sha1/*.

While I don't agree that we shouldn't remove the other non-DC SHA-1
implementations, I do agree that we should remove this one.  Given the
testing you've done and the fact that almost everyone desiring speed is
using a 64-bit machine these days, I think it's unlikely that anyone is
using this in the real world.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--JiyWO78N0HaVYDHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYjjr9AAKCRB8DEliiIei
gcmtAQDm5cGmnnH98i3lJWi7tcIf2+hase37QBQfAM9XkDvDUQEAwhq7X4mTSmvw
Sn6irZbnji2YfVlumNTQrd/1fL/T4wQ=
=Txe4
-----END PGP SIGNATURE-----

--JiyWO78N0HaVYDHI--

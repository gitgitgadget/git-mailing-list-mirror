Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA6C43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 15:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiFZPTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFZPTN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 11:19:13 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4A5FD1F
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 08:19:12 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D952C5A1E3;
        Sun, 26 Jun 2022 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1656256751;
        bh=5yGbbHZJAuebBLe6J8Lgwzz6D+HUCICm6LJJPL0Xapg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TGreMbaMThlZMj1heOkmAeXpJeySEtHrbUlbBG7teUVECpYvrUmYQ+nu+To37BlJj
         IFTvPwl2Oinz6um18ypN3PM8h6LOV78eoeYW8DHqs1ef/DdVosDljQthVHf4gQXsDM
         xqX+t/V4+49wwm7P6TVi8p1Xzh+EWOJ6T2hMziuXfyVRCVawrHJMaE+OFJrBwnRLkf
         OkWMcQCydqG+VvJmsM4rMPKr1JhoLvkGx2g4tthwyMfDoQp9HtaV0VaaYDZgCpkwo2
         JgYwGezMHgWQGD1DLzU47PM3h19TqcRWT1epq8O73Qfovmx91cJhPAIwCbfc8Q/u+D
         GSoj5dvfySqY4BpFVIuMjyPobG22ljJfDngPdcPiZ40ZsPkdh4JDlpfPi9bK0x353F
         hBjhjw+rQQgBsde+EbH9WbWNamjUzs7MfXDRx7kgu6UdvNRR5FAjU8TYZZgrxUIVZN
         WktifIRMMi4uqON8zn2O4i5we7CSmLz1BZ5RyklBJbIcHB+oyAo
Date:   Sun, 26 Jun 2022 15:19:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
Subject: Re: Plan for SHA-256 repos to support SHA-1?
Message-ID: <Yrh47mun9U9t0HpO@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
 <YrbNIUnftj+Ooumo@tapette.crustytoothpaste.net>
 <87czewxp2u.fsf_-_@email.froward.int.ebiederm.org>
 <CAPc5daVtRZ-Str_yCqRXZKT5+KKcXdnptFaer27XneUwj76KjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tb7SUudcLaKBnijh"
Content-Disposition: inline
In-Reply-To: <CAPc5daVtRZ-Str_yCqRXZKT5+KKcXdnptFaer27XneUwj76KjQ@mail.gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Tb7SUudcLaKBnijh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-26 at 00:27:57, Junio C Hamano wrote:
> On Sat, Jun 25, 2022 at 5:10 PM Eric W. Biederman <ebiederm@xmission.com>=
 wrote:
> > Is there at this point a solid plan for how SHA-256 repos will support
> > access SHA-1 only clients?
> >
> > I remember reading a discussion of having a table somewhere that would
> > translate SHA-256 to SHA-1 when needed.
>=20
> Documentation/technical/hash-function-transition.txt has flushed out
> the necessary details?

Yup.  The design there sounds very simple and it is, conceptually, but
practically implementing it is quite complex.

You can pull the in-progress work from transition-interop on my GitHub
remote to see where some of the complexity lies.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Tb7SUudcLaKBnijh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrh47gAKCRB8DEliiIei
gX5HAQCEcBQ/ZK5HJhzpLFRgiL58CGmHllSA3LG8ZCW0jUvlCgEAmMD8jyl+5dbA
Qq1tmrKsLEvfhXKEfXvi7wVZETtIzgc=
=qQ5o
-----END PGP SIGNATURE-----

--Tb7SUudcLaKBnijh--

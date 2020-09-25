Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE8DC4346E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 01:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40B720791
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 01:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIYBNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:13:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37784 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgIYBNy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Sep 2020 21:13:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F108860734;
        Fri, 25 Sep 2020 01:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600996433;
        bh=cDs3Bi6iPJo0ABo6pT9c2J8d1ctSw7UiUXxVx/Nfo8A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=g0g65Wfh7stSySXd2Ag+/JxMEoTq1SoPmrnUB/nJQ2nG4DVwEw4gP/GNbg8meZVp6
         b2zORGmIKXMwiXjBcltTbBwdlethv3TvMcMq0bn7Kg3NuHaDJ15wDNs+dXr2UcI/f6
         JuIy6+wMqzJXlKh1i5kbXXAccHp3UOxd5dBQ5XRV+hTnTocpW1w0oCjp3Rcf5ibE4P
         8v+IiYXmIwhv6mAvaa13ERRJUjSspavRN0WUVu6IbULbqIL14AlmOyCLaJC/rA9Gu3
         sOaclnG9PDKZOG4N+7r4ek/hoWU8dh8FOtS3Ru4+omXzOK9kLQfn3ikiPcajxQzlXW
         eovCpKa4llAnDvlSMBFRYHSLedPsmBDnOmuounV43R5mgLEb9PJcnTU3XRx0jsmrtv
         OjMUx6vj7vyJqXdf+Uc0nVr+0cFES5ONONaXfV0lc4n+NB15goezp2078fNtk2xM0O
         CuYWv3H7zGoOfAtGQLJDBJhx9s69G8c9FXyg0M1uYggi3rwSYIC
Date:   Fri, 25 Sep 2020 01:13:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/2] bswap.h: drop unaligned loads
Message-ID: <20200925011348.GA1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <20200924191638.GA2528003@coredump.intra.peff.net>
 <20200924192111.GA2528225@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20200924192111.GA2528225@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-24 at 19:21:11, Jeff King wrote:
> However, the unaligned loads were either not the useful part of that
> speedup, or perhaps compilers and processors have changed since then.
> Here are times for computing the sha1 of 4GB of random data, with and
> without -DNO_UNALIGNED_LOADS (and BLK_SHA1=3D1, of course). This is with
> gcc 10, -O2, and the processor is a Core i9-9880H.
>=20
>   [stock]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):      6.638 s =C2=B1  0.081 s    [User: 6.2=
69 s, System: 0.368 s]
>     Range (min =E2=80=A6 max):    6.550 s =E2=80=A6  6.841 s    10 runs
>=20
>   [-DNO_UNALIGNED_LOADS]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):      6.418 s =C2=B1  0.015 s    [User: 6.0=
58 s, System: 0.360 s]
>     Range (min =E2=80=A6 max):    6.394 s =E2=80=A6  6.447 s    10 runs
>=20
> And here's the same test run on an AMD A8-7600, using gcc 8.
>=20
>   [stock]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):     11.721 s =C2=B1  0.113 s    [User: 10.=
761 s, System: 0.951 s]
>     Range (min =E2=80=A6 max):   11.509 s =E2=80=A6 11.861 s    10 runs
>=20
>   [-DNO_UNALIGNED_LOADS]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):     11.744 s =C2=B1  0.066 s    [User: 10.=
807 s, System: 0.928 s]
>     Range (min =E2=80=A6 max):   11.637 s =E2=80=A6 11.863 s    10 runs

I think this is a fine and desirable change, both for performance and
correctness.  It is, as usual, well explained.

> So the unaligned loads don't seem to help much, and actually make things
> worse. It's possible there are platforms where they provide more
> benefit, but:
>=20
>   - the non-x86 platforms for which we use this code are old and obscure
>     (powerpc and s390).

I cannot speak for s390, since I have never owned one, but my
understanding on unaligned access is that typically there is a tiny
penalty on x86 (about a cycle) and a more significant penalty on
PowerPC, although that may have changed with newer POWER chips.  So my
gut tells me this is an improvement either way, although I no longer own
any such bootable hardware to measure for certain.

Anyway, as Ren=C3=A9 found, the latest versions of GCC already use the
peephole optimizer to recognize and optimize this on x86, so I expect
they'll do so on other architectures as well.  Byte swapping is a pretty
common operation.

>   - the main caller that cares about performance is block-sha1. But
>     these days it is rarely used anyway, in favor of sha1dc (which is
>     already much slower, and nobody seems to have cared that much).

I think block-sha256 uses it as well, but in any case, it's still faster
than sha1dc and people who care desperately about performance will use a
crypto library instead.
--=20
brian m. carlson: Houston, Texas, US

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX21ESwAKCRB8DEliiIei
gWmiAP9xWJniUxh0S9O+jD+wmAULawiNRhNB44zC9KyFxi/vwQEA5g0yWsL8aoXd
h3fO8fjzje0KNoVCiszXYhBHrQbyqg8=
=RW6U
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

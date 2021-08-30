Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24803C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D55260241
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbhH3WMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:12:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238896AbhH3WLb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Aug 2021 18:11:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D5E3260448;
        Mon, 30 Aug 2021 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1630361407;
        bh=E+q5ZKLEeL1XctPP0VQ7GDFOhm5cfGhk7y74Hzwz7B8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pRYHS0N4QYNCpJpLt/sMb876kBK59D9uB79DOKAFK6zq+hJ+O1gDo65uoSehDvYFJ
         CyoeAhsoku093tAe3FEqbmvoaDOsEWP0IL2jSw93e94gTnzHKHnbIjpY2y9p4laatR
         52+iVWuOZ5zs8MjvQe/ESqW3nY1Oqhkg0YSba/U1lF9gM9obAw13qGcbwOgDh9D3TR
         8UR3rrDtYXT+iT0zUsMSr0xxov2C/eRDnycjdd2q2U3Nek0+sH0Z6vAmZU17r9hnDn
         LxEZ6+CxOanwPF2kqAgtR4RacwafWM+iB+UL8fy77BG9bl1aiONp4FpkZQ01aKrPIh
         96r6CCUWv9M8gwhec6VIbRYIr4P6JDJF445OYwlXh+5boPYf73q4a5lWg//u9//rl7
         Dw4YlCliZzGjURybv57eifshQDY6KpeFLTaS0RvsQLawjXfA7/457eD6Kf4Uya1AAf
         fsjrmdN7ttHqkABykj+yEzXuyFbr8zFZmhLmvxeDi8W1x/iF8yv
Date:   Mon, 30 Aug 2021 22:10:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
References: <YSVjnSDaBXgXvT9W@nand.local>
 <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <xmqqfsur7otx.fsf@gitster.g>
 <YSwpsp/hQsPFnj+I@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BGUjUQqBJpCa8E4c"
Content-Disposition: inline
In-Reply-To: <YSwpsp/hQsPFnj+I@nand.local>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BGUjUQqBJpCa8E4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-30 at 00:43:30, Taylor Blau wrote:
> On Sun, Aug 29, 2021 at 05:34:18PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > now or later would affect this series. Even if we just disallow
> > > --object-dir pointing at a non-alternate repository, we would still h=
ave
> > > the issue of having alternate chains which don't all have the same
> > > object format.
> >
> > Exactly.  That is why I feel that it probably needs to be dealt with
> > before doing anything else.  The alternate mechanism pulling in an
> > object store that uses incompatible hash algo would break not just
> > the multi-pack-index but probably the basic object access layer as
> > well, which would be more grave problem, no?
>=20
> Yeah; it does. Maybe I'm holding it wrong (and brian, cc'd, can help
> me), but this is an easy way to see the problem:
>=20
>   git init repo
>   git init alternate
>=20
>   git -C repo commit --allow-empty -m foo
>   ( cd repo/.git/objects && pwd ) >alternate/.git/objects/info/alternates
>   git -C alternate rev-list --objects --alternate-refs
>=20
> which will produce:
>=20
>     $ git rev-list --objects --alternate-refs
>     warning: invalid line while parsing alternate refs: <sha256 id>
>=20
> But I don't know if I quite understand your "probably needs to be dealt
> with before doing anything else". I think we can proceed with this
> series and deal with the alternate object-format thing separately, no?

Yeah, this is a possible problem.  You can also see it when using git
index-pack outside of a repository with an incorrect --object-format
option.

I'm not sure how folks want to deal with that; I'm just fine saying,
"Well, don't do that," but other folks may have different opinions.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--BGUjUQqBJpCa8E4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYS1XNwAKCRB8DEliiIei
gb/bAQCYvCPD07G1+Pp6rbV0HWQyAezeg83sqEzWlOk4/IgbsgEAl88IJqFz3Lah
LOiUQRZQX7OGVR4lyyflVbs4dxbbLA8=
=yHHe
-----END PGP SIGNATURE-----

--BGUjUQqBJpCa8E4c--

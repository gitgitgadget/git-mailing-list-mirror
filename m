Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA6B20281
	for <e@80x24.org>; Tue,  3 Oct 2017 01:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdJCBYJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 21:24:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54372 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750869AbdJCBYI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Oct 2017 21:24:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E9A7760D8A;
        Tue,  3 Oct 2017 01:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506993845;
        bh=65fJnmXmFoYs8o+bLzzQab2lSmKEykBPlkcVhnZ4RAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyB1d2VP0poCQ1KjoA3P4c5lFxB8EkEjedVY4EGKn8VsI4hPfaM+j4DeNoj9MvR6R
         QQX3ZRFJA9LGKdXc4TibZOy3ay6bwoNcRdsCJ9qSPLD0MqDHiuuJV0eHIk4WxIrGfM
         dlbMOqPCcszi2AnR9HPM0bCR79VPHGmQbq9FZjffIw14da42QrOsRXr5MR1Wmt5rcA
         OKFP+vpGDUaJXNiYU4tUmVKa0NoKhKrHDX+Hu49xJdBVvpFJ6NwWCsWI9aMcqE8sDB
         9tnDArCPreJA1Q580U5xfvJdii+zTtqtyWkhN8rM8miqT1FSBEZQuhs7Q7nsD0SbVe
         hdSOv44ghu+xI3zH6nWyHAJyAEYeCjAU/lW6qlIPskUOuffuPoSv3o45KMf0OdHXMB
         yyf3/Lc9PPqpSeksuOYu8RcNw8ieZNJz0cz712VL29jm5oXsx7pHPk7jxzYamkbd9c
         zeB59XjrjMjoS6wo3/O0tSi4eAOt5OyZZ9pbum1JBdfRD7jyQby
Date:   Tue, 3 Oct 2017 01:23:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 04/24] refs: convert update_ref and refs_update_ref to
 use struct object_id
Message-ID: <20171003012359.x4llfbs2mgcn7yd4@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
 <20171001220831.214705-5-sandals@crustytoothpaste.net>
 <CAGZ79kaY36mo2bpohO8cknPShOBbZt_tpi_kjoxLHE=cFJ3ROw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dax3mh3yntrtmmss"
Content-Disposition: inline
In-Reply-To: <CAGZ79kaY36mo2bpohO8cknPShOBbZt_tpi_kjoxLHE=cFJ3ROw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dax3mh3yntrtmmss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 03:37:38PM -0700, Stefan Beller wrote:
> > diff --git a/bisect.c b/bisect.c
> > index 96beeb5d13..e8470a2e0f 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -685,11 +685,13 @@ static int bisect_checkout(const struct object_id=
 *bisect_rev, int no_checkout)
> >         char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
> >
> >         memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), GIT_SHA1_HEXSZ +=
 1);
> > -       update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev->hash, NULL,=
 0, UPDATE_REFS_DIE_ON_ERR);
> > +       update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0,
> > +                  UPDATE_REFS_DIE_ON_ERR);
>=20
> The number of characters decrease, yet the line gets an additional
> line break. While I don't mind this, the most interesting question that
> comes to mind is whether you tried the new clang formatting options
> in tree to adapt the indentation? ;)

I didn't.  Sometimes I use Coccinelle to convert part of a patch and fix
up the rest by hand, and it really likes to break lines at certain
points.  I expect that I'll do at least one reroll, so I'll fix this.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--dax3mh3yntrtmmss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnS5q4ACgkQv1NdgR9S
9ouNfw//WW8ThbJyX61nzU+8U4Jn1GKonOWTXW+vy82nv1zjBENR8WFk/h2bLtGa
/MJaV7/1aV0H94rwvKRzcRTw5a+7M+evGvTExc95QhpIIe2ltUdcg7iU3Izu6TPg
kqPT8GU031ze/pWfxqiD/8tGW60vm8WFdrQQ2+MlvGYQevFtEaWPtb3q9BkY6bEL
6eVhfTcNNJQXKm5LoF+lQSAymt61q+E5Y3WtVSPGmUHSr7AxHEG4+wvhglElavS/
Ip/4jCxrNnBef4sih8sVtXsoFNpZwkTSKV1AgAXtjdsJSMT8yEXEcr41MtTFM7Q4
0jvMSqhRWy8N2wpofohD3PeBnOSB0spoXe/4A0kmVLpmX9MJv3TvROc+mfiGmPD3
LNvfbISMmpoMpUm80MkmkrR9aqsPruwP5zc7tw+Exzg9T5i9hH7AwHZjqx4+3YJF
ZxZ9XK/wet4J/s70p0hiwr5gYHBAhvqS8XPnNJ49yd4aBuGTN6H2TyaAbwCBKxUI
mc2PL2Pe2vdHHIiV2j5j9fdRDAI9reDlmxUV2MJJFvqa7wm+9otoYHNCjE9CD78Y
2Uy7OdwcFGFcmdWmfN4z4yvmHl3Zs/wYFv/7MnveYQAdVt5qocq2/EeNJkGvyGq7
ktMU0DGM1/3RDYKCj8+JOxQqRBaGF8LBsVLo2x3GeeUe5Hb4Zok=
=MTt2
-----END PGP SIGNATURE-----

--dax3mh3yntrtmmss--

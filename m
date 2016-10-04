Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63072207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 00:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbcJDAHY (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 20:07:24 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50422 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751495AbcJDAHY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Oct 2016 20:07:24 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2089A280AD;
        Tue,  4 Oct 2016 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1475539641;
        bh=QhqJjR5UVBGBk8T+XYKSogq69jFPrC/9OVjzcYuDn0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+IcESavcazayYVg6gIRCsWbbxaQO6Z4OH6yVCCtDMVch2vNik9+0MP6rsXbUL4Cu
         b8u+KivrEPTJSReq9hn8sueUA5dILyjMegp2KAJpuE4iRQ11XRiJ02hWHE0q++7GhX
         hwGLqy4L5uERnvdfUfWynYDBTPqkEPqldXOXLDv2iEukEzC8jpMl3VCM/7l35ndNRZ
         LlchLIABpF34+XiyIbr0QnG/KD8gQoOfPKMRyiIo1edCBhTrs+VACUFdAVZKf9USDQ
         0qkik0Plgcp2QoJqdi5ngVKp2qp4VFD+1gRd6AjqjFYMZe79AmPq3EHw9FIkBMiLmS
         o2b0Maals/i9h16mSVeqWGwGPX6izv7gIwqhvGPdJuEKfiIh4oP8BWXERs6+MWyrtn
         ms1dkCp5F7UAsPzCA642HynWS02SLKqcdKX2NyBPW+O+7uBtRa+LOTZpsC9YBmmQz1
         LY9Rq61jPNQ9d2qzyqVBdZF1zYgvQeRtDdIhPFEycs6KCIWVUrT
Date:   Tue, 4 Oct 2016 00:07:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     'Jeff King' <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] http: http.emptyauth should allow empty (not just NULL)
 usernames
Message-ID: <20161004000714.kbawbnh5y3x7h54l@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>,
        'Jeff King' <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
 <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>
 <335996ca2642478386e94d9f3dc43223@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eguqufucy25uodsl"
Content-Disposition: inline
In-Reply-To: <335996ca2642478386e94d9f3dc43223@exmbdft7.ad.twosigma.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20160916 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eguqufucy25uodsl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 03, 2016 at 09:54:19PM +0000, David Turner wrote:
>=20
> > I dunno. The code path you are changing _only_ affects anything if the
> > http.emptyauth config is set. But I guess I just don't understand why y=
ou
> > would say "http://@gitserver" in the first place. Is that a common thin=
g?
> >=20
> > -Peff
>=20
> I have no idea if it is common.  I know that we do it.

I've never seen this.  RFC 3986 does seem to allow it:

  authority   =3D [ userinfo "@" ] host [ ":" port ]
  userinfo    =3D *( unreserved / pct-encoded / sub-delims / ":" )

I normally write it like one of these:

  https://bmc@git.crustytoothpaste.net/
  https://:@git.crustytoothpaste.net/

Of course, the username is ignored in the first one, but it serves a
documentary purpose for me.

> The reason we have a required-to-be-blank username/password is
> apparently Kerberos (or something about our particular Kerberos
> configuration), which I treat as inscrutable black magic.

The issue with git is usually that it uses libcurl, which won't do
authentication unless it has a username or password, even if those are
empty or ignored.  http.emptyAuth was designed for this case.

With Kerberos (at least in my experience), the username doesn't actually
get sent, since you send only ticket-related information over the
channel, and that has your principal name embedded.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--eguqufucy25uodsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIcBAABCgAGBQJX8vKyAAoJEL9TXYEfUvaLY2IQAKEf+4yEvoB5ISmUFwkxPq4O
Firr+1g9ECsinZJuwfaW8Ahyg9A3RQUiDRiL/Ao3jdjbZFoFeYcCIqcOTDxRSpH4
NVku+ltBcGebtkfBlELKijOANNUAZiMWziBFyJ37p49zuuu216eMA6t/A9/VU2DL
oKLgN1aXEXTappb1PU4dYldYX7KMCgLdSGH+B5unk/HoE0yfOlUew6hSCs5dANCj
OjEmLGAlgGXjZihEcQAcdvZb3sRjPrZFPZOHwQWQNdcoe16iPmrZf5LX4Shyebkn
DXGIyy6ZWMKe9KhcmaF18Tzj7N1YBls8IG4wsMd7UJG7gjp84U7ajQ+PvT25VK0b
cbpogbpZI8V9jytsk7a8sS8fJMzLD8mlbIckCFHoKhFWiQd1yLX1F141eoUIrfHH
aHgoAWfjvkvmlYXIpFO6/eX/+SMsrGGJlWZhk3i8A4YGhankhHUlw49fx9o/E8QI
vBdbSsLU8BPCgCX82QSVOvk6TrsE8OEd/bExvzPUuwZ8XuyCyfPQrZ6vp0DBEQun
aS8kim9w8iDDWUkrmPqqovRGOjMsbgp982O6j7ZsqbUhA4QZBQXpv7en0DOH2cb+
XknW8oHZKmCU2QuFYOF3qxITdvcDdbaitosvqR3aiC+Puea7Y8RGMtJi5pJDqTee
gssGJfnd7MqlXiNWWUgm
=0tXs
-----END PGP SIGNATURE-----

--eguqufucy25uodsl--

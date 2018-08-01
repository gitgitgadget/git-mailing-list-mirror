Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085D31F597
	for <e@80x24.org>; Wed,  1 Aug 2018 00:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbeHACCk (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 22:02:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40758 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732840AbeHACCk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Jul 2018 22:02:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b423:857:b27f:2f08])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 408C16073B;
        Wed,  1 Aug 2018 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533082788;
        bh=PQFN5ZpWAcUFgfEWA598THtcX/Gmo98fmC1JZzWBt3o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=N3JR7XxfxYxo2Gi95ttREPS3QAs5AYUIQjmEpH85v5Wg5o+dCzWrIoyuhFFh/BajD
         rZkmzZDBqRctPXYCSCLH/wjh5k0i1A0UZBBFQ4MQFhtU6VD1tQoDCwEOUjnMNDV7a6
         BuX9qp8LYaxKhtdu3R4t6xdI6R2Bh7KxuBfnvhJaTD/clyYf5zhTzGo0PP6vgKOS73
         kyQWrSWce2nxaVYkb/12f++J4uPDRWxOnfZaatNRoBaDF9XFsfDh02tfWc9s+D7gxB
         91xskz8tqozDZNT5uWo5E5F2CmW3GPUzakZc9C9igozfNVUmsGvQQ4LPGN/Lvm5gn1
         fRrUsfu3ekDomebncjlw0NMff7Rk+xt06rwlnMs4/Oj2RG2nj0iVNbZDo0KXxLK7mK
         hSiEqe5NXXY3VMEmBxkg3BsdnWQWM1DUYz6W1lxY3Rl3yVYcl4WNKkb8+fvqSZEx5r
         JO72JgAd/KRkugXWFpT3M5KX0RyjeoQMDt7XroAb575WUlfLrrR
Date:   Wed, 1 Aug 2018 00:19:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Vojtech Myslivec <vojtech.myslivec@nic.cz>
Cc:     git@vger.kernel.org, Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180801001942.GC45452@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 10:05:22PM +0200, Vojtech Myslivec wrote:
> Hello,
>=20
> me and my colleague are struggling with automation of verifying git
> repositories and we have encountered that git verify-commit and
> verify-tag accepts untrusted signatures and exit successfully.

I don't have strong feelings on your change one way or the other, but
for automation it may be useful to use the --raw flag, which gives you
the raw gpg output and much greater control.  For example, you can
require that a subkey is or is not used or require certain algorithms.

I will say that most signatures are untrusted in my experience, so
unless people are using TOFU mode or making local signatures, git will
exit nonzero for most signatures.  I think the current status is to exit
on a good signature, even if it isn't necessarily a valid signature.

I'm interested to hear others' thoughts on this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltg/J4ACgkQv1NdgR9S
9otRpxAAjPXNaXEUNtnKMRdTuS8H8fHDDDODLX4lIGjtUZSuJVLvm2QegSIdnXXE
dCapMtrBZ/8wXegjtpuKmcYcCVWuH5PbgZ8NtvcBvvaVKJGxiWT/OzxPi1LKjMJ7
rt3pH8+ZJOAWkisf8eytgaDEXfAheMuE2sI2Zm2MmLtwNkpHlwqFaDxfcW4ecEWd
sDy9TPRaIAzwlmfgN1psFVEeqcI46Gy5zbR09+OcKdXSuSEXHNJ5aQ9vHa3L0j1A
1k+v4dyllKO1vrKieGmdYWcN30SjWwrDtB7eFrvW5ZacewL9rCokpGRlMmZv6ySZ
GnT3yAoW1iYkXkf5X3a05cKjsyykDvxaoUYvWRsFMS5jzkjBD8iq0LWOzlsnBYXV
XUREX38atCagZe4laWAOvVFgek+lruMbRibthb+mmH407kRm0h/jedEC77LkIh+X
hUqyQfEqtZYz9cnQ+sBm5N0lWC6Zg9FEzqKOH+Dg/B4Uj8qQfzItzGdCBF4cXBXs
RzSKHMXIwU+A0Btl6AasGd+ZEYxYBv4u0Q5QhP7uyyVsMG4+Zl4rq/BpaszoHzaZ
hxK1qcbg8PnU1jPQNsGh20Dtsf1fA0rVr566WFAVDuV+7rYenQFnn1NHmU5GhsoS
5RNcM7HL6CwSkBtjXd8kwD18Nrwt5YhjP6g5THe5UaNFhWCDnJ8=
=cNfA
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

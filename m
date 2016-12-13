Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7905C206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 03:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbcLMD25 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 22:28:57 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38366 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752807AbcLMD24 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Dec 2016 22:28:56 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 24C70282B7;
        Tue, 13 Dec 2016 03:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1481599733;
        bh=SzBxMHwQFWY6kQfCAzH93fiFzF4GZ9jEf5pVbKnmbmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnRaIcjaxJdxS3kbVvgkt001tUYnACrmHGFrG+YhuBI/rITeaE+dOFNAuV6S9ctWY
         o1eBrlemWszCHK7BW+LS/jqfWXDh8Zx4UeBQL+zrI4+GlAsMEhstCq/iKYeAGbLy0r
         pmldKIjdMCOWtdtOHzOpi9DHyZ9zubYwwKJKQNB9HYSqcGhDZsJRcaql5JI67il/mR
         Y6TQvz/6y6GCpVjHzxo23T5pEWM4pVNxfGEzj8Pv+5wta4kdPrPJpHh+R5GUe8lQKA
         ZLKNByzEMvYQM5zMwCf1VrZdkqWoRwR7Wj7CEXGg1L4ttDXwDBp7L54ah+iaOlncZ2
         pWrgPL5RX/htDvT6w4WB5WHSa4lr0x2lCwdiCCTZkf0x2CTW/aXRXEMzw2z4o81bfO
         bn8IkYidR+8CmR9vBsw27x9l7MV6c6Iro4RaoUf0xjJOoqm1BNomEd3GFWY7J+QPZH
         cQbGoLLih3BRJMqrR15osGYeDoBbGQfWB7YUBW3+JDtSNuFpZNs
Date:   Tue, 13 Dec 2016 03:28:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, David.Turner@twosigma.com,
        bmwill@google.com
Subject: Re: [PATCH 6/6] rm: add absorb a submodules git dir before deletion
Message-ID: <20161213032848.4ps42jinix6fdgdc@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com
References: <20161213014055.14268-1-sbeller@google.com>
 <20161213014055.14268-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oda2kqshydvfnyxx"
Content-Disposition: inline
In-Reply-To: <20161213014055.14268-7-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oda2kqshydvfnyxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 05:40:55PM -0800, Stefan Beller wrote:
> When deleting a submodule we need to keep the actual git directory around,
> such that we do not lose local changes in there and at a later checkout
> of the submodule we don't need to clone it again.
>=20
> Implement `depopulate_submodule`, that migrates the git directory before
> deletion of a submodule and afterwards the equivalent of "rm -rf", which
> is already found in entry.c, so expose that and for clarity add a suffix
> "_or_dir" to it.

I think you might have meant "_or_die" here.

Other than that, I didn't see anything that stuck out to me in this
series as obviously wrong or broken, but this isn't an area of the code
I'm super familiar with.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--oda2kqshydvfnyxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlhPavAACgkQv1NdgR9S
9ot3Ug//YXQ34bAJxEE4+XvK9NXsUgcVG8V+va3V4XktZwS12nZyk5fzBwJNrUns
RNChfsfpkPUyTiwbkN3PyCFtxl+kjPir4KoW1gEDpPjtn0cXZ1BlD04HUjC9Z3Ev
rw6qMoS6gyiMJZ5MLtbYczkzPEsx0K81I1OWdr4o2p1StYKu7o9Hy1nHfkv6Yb4j
zLP2WKKaINvtz1FJnAngweRj6ed6QtNDgjbIDPJSR0sq0wUhsMaIPOO8OQPvcIeq
F7xetRS/Tfjt7bCKhEoUHr1qRanOGX4jfS/dUXKI5vwGd8hLXOgSbO5zllXDFTQF
NZCruCxdwfSg4pDysr0be1SDdB9WGVSyvYIMOvRftHeQQyCPh8cC+s3gRwBOrk7Q
7oCbjCBHWUxak4YyOiUKvM6rXV1CyhXz/Vbz0qDPEJYGdvgl3gyYf1Z/9ixpTLVX
UJ88duuCCzjsB9re8hZYW3T+/Pp2RPNIP2uhUJA7ynbm+lfcZLbg7Jpn+n+NJ7xE
GL6JB0Y8XUu6YSa/gUjhReljtluES2vYo+JRDoxMgP3yIIwNilXW0rLHAX8ylT1X
CFZs3o6LnTT4H6OKY/0ZEOepakniBlMHTMhdIIlsgSADT5rseoavlgVuDD3jg0b0
Mbgrwa2lrfvn+oIfS+8QJp7vVb+E04/7NwYh2BlLhYL7IsowXTQ=
=91SI
-----END PGP SIGNATURE-----

--oda2kqshydvfnyxx--

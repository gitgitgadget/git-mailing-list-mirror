Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E46A20958
	for <e@80x24.org>; Tue, 21 Mar 2017 00:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755241AbdCUAyZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:54:25 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46742 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755214AbdCUAyY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 20:54:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A0B96280AD;
        Tue, 21 Mar 2017 00:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490057662;
        bh=OzLHBp7MTA4uIELr89I8NArPzjotTtvS05J/1CBoqmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRrVtURl+izDDvdy7Z0gQLLGmHh2O11WLlS/1RZ8tGwDkxQYYvKOw+Th5MCBnsygm
         6YmqLYRSNCztKTY8o/60SSCI4wC1JboTatwAvsC5AIBR67FUqsozmxAIoBS01wE4pX
         w3YKUvSwNq6SoIIzhrhOFjMS0p9jRQgOumdbkf7lCFRzUJR4vwwgmDO0+Sz/7esi08
         9I6eXAWMnB9gWRIORFrX9iQU/vEIgSxX3/roctArXS5pO3e8fouTwe/PbmiAOrP9L9
         labt1Xryc4LReWZXFVzBOUrNdSAOgQY+Xc45BlJaNe0Ni3EKhRG3QMzhuZTEJBrFYs
         XBrV16uA+yKU3YgXC4UC9IFMxzmNto7dk4GTLWaEOIpfmUPGpPmSMQF2jj0vtFLptJ
         6nd7HjSwQCj0Xj6Qk4i7wI7XzPa90N7/LA6tm6S0InmG8p+Cy9XE0DeLIbMfkVbLvp
         Y7ZsYrmWYNXWn2DPMgwQVCFio/zPOReoNJEBypsdGaOwLDi+H8a
Date:   Tue, 21 Mar 2017 00:54:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 19/20] Rename sha1_array to oid_array
Message-ID: <20170321005416.l4c5sdbcnf5wm46h@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
 <20170318211954.564030-20-sandals@crustytoothpaste.net>
 <CACsJy8B1HhSWBMThoiy_F2s3T62nwNAO-Hd9E+d9k82Y=Ku+FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ahlinqnohyzsf77q"
Content-Disposition: inline
In-Reply-To: <CACsJy8B1HhSWBMThoiy_F2s3T62nwNAO-Hd9E+d9k82Y=Ku+FA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ahlinqnohyzsf77q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 07:25:25PM +0700, Duy Nguyen wrote:
> On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Since this structure handles an array of object IDs, rename it to struct
> > oid_array.  Also rename the accessor functions and the initialization
> > constant.
> >
> > This commit was produced mechanically by providing non-Documentation
> > files to the following Perl one-liners:
> >
> >     perl -pi -E 's/struct sha1_array/struct oid_array/g'
> >     perl -pi -E 's/\bsha1_array_/oid_array_/g'
> >     perl -pi -E 's/SHA1_ARRAY_INIT/OID_ARRAY_INIT/g'
> >
>=20
> I see a few multi-line function calls become unaligned because
> oid_array is one character shorter than sha1_array. But I'm ok with
> that, no need to manually align them. We can fix those when we touch
> neighbor code.

That's how I felt about the situation: basically, people would
appreciate the ease of review over the tidiness of the code.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ahlinqnohyzsf77q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljQebgACgkQv1NdgR9S
9ot6DRAAgHvAPC5ihl3v7t/yi+DXdqEzhJM1RrpxdzEr6srxWr6QaHiUGMJCIWTO
kPegp7vHUpGFo01oLppL7qWp08Ws6f6Z+9COvlybNX4muhrXmAQnHx5c5BAtRQ9r
w5fMYzEzEf/1qGK++Go643yPOR0vxGPmdSAXmRNE3ij3rO4dVUpxcBXH4hH/ZjEG
gJUyGiX2mdjIyldD+4cRpJoQTMi13/p6XBbNYOP4x7kCEuOTGa3jeLrqQam/1bQD
BgVP30QAOzesgL60UL9zwmee5VaiSg5WUbIbGgC89gbArCDBA/SOowRV8ouCSavw
qbbjQCqAtnkpn0dau0z+o50oznHc44sfauxPDCL0CZUnHX5gFjcH9hkDCbnLwhCt
J+Fw9k84w+4+wFNNUmaB5lQF0sX7UoQHxbN6bEKT1g/hsQrfNbJvbAzvOQBbda//
Y3T6OCdK1XwwDpLCgH2gsPnhrrPLJRDk0anTtET19he65glNok3UdW5hlZ1BNyrW
VC/R8nEXEt+bqVQmjh88V+xTbJ9hxwEP6dBrojVGYvy5qUyzAWL+BagWP9I5m19C
Rbt8dlnuJLSunPS/Jp8i5gWUHX1mfZq3ubW9EycM8tLdL5hEDxA5OegFRRUzypzm
RpIeqtyD0ABmZFUac7GBvRlZlFWLFth4L+jUW9tG3eVjWWFjMAE=
=r7uG
-----END PGP SIGNATURE-----

--ahlinqnohyzsf77q--

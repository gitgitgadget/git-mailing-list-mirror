Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C12F20958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755006AbdCUBZT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:25:19 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46756 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753724AbdCUBZT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 21:25:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1D59E280AD;
        Tue, 21 Mar 2017 01:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490058998;
        bh=kNztThGRbAss1FJxN12JsgdU5XJrEjPtbshim9ChkLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlS7H1xHM8ypcj1R6DWxFYQI3HPh5dRxg1qsJz2m2NHwvtLVcxa5Of8cE5QG/xKQR
         abukrJ1OrED38VScSs82/ZL43UYzepmBIFnPbj3i9aDo02fT8WHSJN8acDo/pbWX0y
         7MfTrj8VRgrRfyiv9l3EiSyLo5tJyS78YXU8fSZoYhYb9SiQFeDNNh5OwkYH/Mjenw
         +uryDotjf181SHOu3jqB4oZ3bs/k1LJ6NyD5D41t+HVRxKJMkBzEV0RfcFTYlZw1Pp
         6eaU8ZDJbyquw0aGhEueDk8XNFGAZRXwhjqUgyFF5BjPGzp/VsbovoQ9+LMN3w3K+V
         PMpIHVHxyLC2D/2BBZw/fgLdAd0sVfPfMPfJQvxldfZyTmDQMMyEatswIH9WF9dzPP
         X5yCLDdpKspesWm0VMnxO/U0GYk7lC29GpbU3SixdANmkpdiYTy+d0IPhHKAMNn16B
         /h2eOWkgIYOLf3vA2djuWNKlr+vwbrZUWykZ58okhkH/rxfB+HO
Date:   Tue, 21 Mar 2017 01:16:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/20] object_id part 7
Message-ID: <20170321011634.sa6sbygh5jiay66m@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
 <CACsJy8D1ZjO1pQJv2TmoYDyptyvhEfrcK=RMSeJE5VPG9=Jh0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="onbcewvyhbuowtzp"
Content-Disposition: inline
In-Reply-To: <CACsJy8D1ZjO1pQJv2TmoYDyptyvhEfrcK=RMSeJE5VPG9=Jh0A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--onbcewvyhbuowtzp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 08:14:20PM +0700, Duy Nguyen wrote:
> On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > This is part 7 in the continuing transition to use struct object_id.
>=20
> It feels very nice to see many ".hash" and "->hash" go away. Looking
> forward to seeing you kill sha1 in sha1_file.c, object.c and friends.
> That one (and read-cache) must be a battle.

Basically, the next few series look like this:

Part 7 (this one): sha1_array =E2=86=92 oid_array
Part 8: lookup_{commit,tree,blob,tag}* and parse_object* [0]
Part 9: get_sha1* =E2=86=92 get_oid*
Part 10: refs.c

As I go, I make note of which function calls I tend to modify a lot,
since those tend to be good places to look for future conversions.
sha1_file.c is looking like a good candidate for part 11.

> I'm not familiar with many parts that this series touches so I may
> have missed something subtle, but overall it looks good to me. Thank
> you for working on this.

I think git-contacts picked you because I touched a lot of the shallow
code.

> > I chose not to rename the sha1-array.[ch] files
>=20
> You'll have to rename sha1_file.c, sha1_name.c too and might start a
> code reorganization revolution by renaming sha1-array.[ch] ;-)

I tend to prefer dashes over underscores, so I fear other people may not
like my renaming decisions very much.  I think I'm going to stay out of
it and let someone who cares more make the controversial decisions.

Anyway, I've squashed in some changes and will wait another day or two
for other people to send in feedback before v2.

[0] Looking at it now, I can probably handle lookup_object, too, so I
might stuff that in.  That series is already 53 patches, though=E2=80=A6.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--onbcewvyhbuowtzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljQfvEACgkQv1NdgR9S
9ot2oA/+JmTBiUkWYqQvVuXiZ2BCHckFrCifdhe7QHnRx8EbYcd6RN3U2tEc9Mwu
BJfTRSMy1k2ptGUzp3ZYgxBfGJUI7hUk5Khcpr8xDIX77RCMaEKIoGjGMFjY5kOX
DwQ8+KVBzxlTO+OK5a0+edN1PQ1B4L88et+wiI1O+uZH9oxQq5HDJMvVCOBOcyjG
rmeqGx06aIY5DBjxqISbYXN+fWxoixfby+LKmyaATGfxWtc5L4eNsaZvuZwF8iJE
AJkqzEeXNRLZ7r1i88FzMEX+yvB1jxl33ueLg0rEaskzdqWWahlE/60g2f24Oip9
CgRw5kPKdFOrfUWJomvp364PjxSMU3Dw/LDfE8Q2/k0d858Et6EiRZJD4XJ1kgak
p+Ip+EbPqfteeDWP3klm4NWKhlZpHGgiud2qmB+5C9zMKUBDHoRH6O4qFqjtIV7L
hHzFQVZVqMOWKrseQe16XYd1fNvA3KQTGkZS2y7Z6P8/ikVg8TjpSb1LlJjwjyQf
ZJhiMkQVDQYJEv+AHdgnOYss+nDilI7OBjw1ogB8QN/KUy+E42OCrg0uf4P3usou
ip5q3c4xrQin0sbMBEtqKGWkweFU/4YsI7WpYp55+KC9tUKxtTTHv3wF/2wKBSMt
CiKMwi/ffpVWX2K/YgkJENkSoYVl0sI7MsFVAKI82N3rO6tEhtI=
=qaCk
-----END PGP SIGNATURE-----

--onbcewvyhbuowtzp--

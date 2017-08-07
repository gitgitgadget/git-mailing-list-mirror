Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDE31F991
	for <e@80x24.org>; Mon,  7 Aug 2017 01:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdHGBSk (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 21:18:40 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:47612 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751377AbdHGBSk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Aug 2017 21:18:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8E304280AD;
        Mon,  7 Aug 2017 01:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1502068718;
        bh=Xg1VkAsvwag8ZH5kqmHjVPLpXGtICJayr3+33LNMRhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTAnbWUm4jipYlwi4SKCc6dSheA4BNR/Eb19HeQ+xP9qQGiqT7jI8KgywOlQq2wVg
         Dh4ulnmR4cNY3sgg62vVztn+7mBSCy/awGdx+KkDeEuEZx1+7N4FWW9fv4sfungoQZ
         LtTOUpyxvM/8d2oaaY9jF3lU3ZCbYKazJeX4aZjIsdxM1KyJa/9Zh1KUJZA8q1ZJ96
         crUgeGiDQq8GnUeP+lurL7KArXQdB5WWSRMa6kDSmb+g4bp4ag/ScoLPAcMgzhqgNR
         VIVwDM2JOHQg3j6Ezmwy+qWI3mqz1wkVFkjO6zyeghFchYLeUkBXM4qaSf+IR+e7F7
         c7MJ0eyvhpoOLWyli00u3jdseCstWZd0P4sUrBvPJUpVG4NcmC4+qxC+wRckJ1wIlW
         6kDnXGo2ojyNLdSfSY8JZnocdhwkpD5UAQOw5ShJLZx5zLI/DH2dNZMCZrgSu9bBc/
         ileMs9/Vfpo3Jq/Il2m4vg7HvBu+s6SS+bU7k+oj9qjNVdY27R2
Date:   Mon, 7 Aug 2017 01:18:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] tests: don't give unportable ">" to "test" built-in, use
 -gt
Message-ID: <20170807011832.oy6lxf2ewkmzg65s@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20170806233850.14711-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u4j32rea55xubgmc"
Content-Disposition: inline
In-Reply-To: <20170806233850.14711-1-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u4j32rea55xubgmc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 06, 2017 at 11:38:50PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> Change an argument to test_line_count (which'll ultimately be turned
> into a "test" expression) to use "-gt" instead of ">" for an
> arithmetic test.
>=20
> This broken on e.g. OpenBSD as of v2.13.0 with my commit
> ac3f5a3468 ("ref-filter: add --no-contains option to
> tag/branch/for-each-ref", 2017-03-24).
>=20
> Upstream just worked around it by patching git and didn't tell us
> about it, I discovered this when reading various Git packaging
> implementations: https://github.com/openbsd/ports/commit/7e48bf88a20
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>=20
> David, it would be great to get a quick bug report to
> git@vger.kernel.org if you end up having to monkeypatch something
> we've done. We won't bite, promise :)
>=20
> As shown in that linked Github commit OpenBSD has another recent
> workaround in turning on DIR_HAS_BSD_GROUP_SEMANTICS and skipping a
> related test, maybe Ren=C3=A9 can make more sense of that?

I've confirmed using the NetBSD 7.1 man pages that NetBSD will also want
DIR_HAS_BSD_GROUP_SEMANTICS.  MirBSD will also, according to its man
pages.

As I understand it, the only consequence of not setting this flag on BSD
systems is that some directories will be setgid, which, while ugly and
useless, should have no negative effect.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--u4j32rea55xubgmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmHv+gACgkQv1NdgR9S
9os1tg/+Iop8H2X4/TKc7vecko90NhopupsR/WWDYW47th+o+pPJuBURW/3dP+5o
947GZkX98Q1AarnsKrpS+9bauxw9uYZ/vi+5ekQD8pwZdvsA84OXcSW+kD4kZxtu
ZJlXjW+1fbE8oxZ7vyc6rTjWAVWosHki80BUKE7nAa140wU4/KVzjsEOWzKXtnr+
eRwF7qwHoDCu/egqhzixqGcTEDfRdJDMsxb1wvFzkqmsPL57zNcRAqg0pb9qTQC2
05cX3r+4xOrT/N3rIRkqd1Ugx6zMJecOc7PZwknKMS1Jtgqtm8YDALPfuYTDhhVS
JdfHhymFW2buHu85Suv+7hirxYm6t7f1HCI1iOobXfXIkujQTcUnN4cSRQclHpso
69OsDnNtfRrFY6oFsf8nRz3kw9koIEJI8oENipbdTIZkLwSvTJSjciD+kUdr3ZWC
A179RqYjl+gD4GQTYv6BrMRdIKL+cAJp+6o1QPITlpIJkE6maPBa89y3hTlyMLww
ovCtrSNiteEbJRquoF5wYA1UZ6ygGE+7w3t/9Bu1XHzJZFdAuOADlvZtAiL03w2Q
JZ5BzVjCo+NX/cDHq3h54m28zDEONXzU1SWxxhMHzOskVtYNPVM4JRA2ayqzSUf8
u1l8wodGmnc6fesIQJ8tRoH0L0IGz/5cfjwZXlecYyIOMUqGC30=
=/O6d
-----END PGP SIGNATURE-----

--u4j32rea55xubgmc--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F88620357
	for <e@80x24.org>; Tue, 11 Jul 2017 00:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755085AbdGKAFq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 20:05:46 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57648 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754951AbdGKAFp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jul 2017 20:05:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3B707280AD;
        Tue, 11 Jul 2017 00:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499731544;
        bh=N3PndMfy77ni3nknJYrQdckUHulHl+G6RTNlH/P4wwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDUwL+7K5MUPswWovv2v5fA9DMt1eI9ivUYuiP5TluPvDftHKQkVf+p4Ob1UWhiQE
         qagNWMKLhP9gz76hmWH2AtWqoWRMcKUzaXU4Fy89+nKNPndzZqtB6STX1H6v7gtKgr
         A0SPQs+lNzrGuSB5/0OlQ+5whGrPvzss4gC1IjWTuDDRQXSyOzm7G66NLJy0bay+K5
         /OxDV+dsjXyU0G6RQsJYXHBRiYk42SPpoEqYfH9jjFgrfxtvFsuZJwRZ4IdJs9uQcg
         7fs/DDAmz2+Q/1C/tOOWxp2dNl7nmgkXoq47B0aCrFHyiNV81SYwz4wTV/9EkpEjed
         IyB5rbijWYbRKyfjChRKus7v3YpGsfL6DnGtI7zg6NsO3jk4Z8fOal5BpzSkxY5JI2
         dmuggAwXTRuh006dG7w6TQQ2EucY9XUgqgTGFZWMIpKm6+uVkIlFsaKa/1VxsJgdMO
         EzquhDTCzHDzRqLRga6bPGbqYM5smrtQD1bInsn+KWvG8Ns9BHb
Date:   Tue, 11 Jul 2017 00:05:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugjs6drwwn22w7in"
Content-Disposition: inline
In-Reply-To: <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ugjs6drwwn22w7in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 09:57:40PM +0200, Johannes Sixt wrote:
> It's a pity, though, that you do not suggest something even more useful,
> such as C++14.

I have tried compiling Git with a C++ compiler, so that I could test
whether that was a viable alternative for MSVC in case its C++ mode
supported features its C mode did not.  Let's just say that the
compilation aborted very quickly and I gave up after a few minutes.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ugjs6drwwn22w7in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllkFlQACgkQv1NdgR9S
9ovDjxAAxL5Y5t8ClRh+dnSv/SenQ2MBdlyefSgC+TZzh/xi30Uo/iPhzynZaE/c
JhjEBm14119jW2QiJN4QGrnle5EpjZl/SEqTlAyEar8MwiDIOpBRF4Kn3Bz4Umn9
vnelbRESji7Y1xsr3NKNZAg+h3TchNA2J+o/IFMw+C62JhI9Bgwm3DBsfybcIEjb
t4JIOwiHuVQY5N2x1vjZKnfVAuJ3xc+u971hDgkk7p/rYEYd1NWlKpQksjKkqQAd
9cK98Wwq6akrg4OA3DWq2AdmR+7PNzHI4zNfLq4KT6hIHXUJGQ0ayYyxPxPmj71f
0SWtNHDlOm5PCLzxTTkbYzPI2rJb2CONFyNRcyIUtkpkBOgIjxxkMlTaWf6GZr7h
itmaqE3AyOPKa5inOEQ1EGPQbr0AFGmJE6LHo6XLkSsO3demolJEsbLBnsZVplZY
jWs9VZSfM5H4JRLtRgFbhH8P9XlzsBfSrfRmxrIh924kDcGzfOvIKgpDAPGiSLCp
juuN98+fi7/oTfmQW74E4ajkT7J1sKTqY/esDmj+IXeU5yMjsAg/nR7kvG1KKvc8
DypMgltsm10H8HmLN9DO93ikXEbQarbK1BGWiseCt5KP/tpPVEulJLX/0kda1EuM
wLu8KUlQ+Fe7rt1oWtdGVkApp+VFMTOmkU5Wtw63bDZSKGfeHBo=
=AREN
-----END PGP SIGNATURE-----

--ugjs6drwwn22w7in--

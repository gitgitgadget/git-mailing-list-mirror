Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208DF1FE4E
	for <e@80x24.org>; Mon, 11 Jul 2016 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbcGKKhB (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 06:37:01 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57686 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752033AbcGKKhA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2016 06:37:00 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AC5C0282AF;
	Mon, 11 Jul 2016 10:36:57 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468233417;
	bh=ZF2nnh24UZD2cpXSlMgzCoSkqo8DdZu+DUBAgXoRZv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGUdfzKLKuQgdX+Q0Le+qX+TYViuCuyNPGu9TwX/80GkrqbarbuEuz/7dJ2u0ACzQ
	 67OGGqEdbHXpRl18quppFAKbXRk8/JsW2b/DMWIUJ6+3RBHzFESfJ/wunUJyUl548c
	 t5oE1hzJa51ZRu3RL4C24g8kROS9a7y9T8xmvfFARloCPu9lDQ8p1T7SXt+L4TL4pq
	 d8Fnb9HgaAyHoFre2wsR1i5EJL8TjeipYhNlgtluyxgKPB/5/53tY8dCbdxm/36440
	 N17PBkb/tpq2WFL9K/PnkzOvXTgVXMXosmNtmb42ujcFhb8b0piC7/86SGmWgZh2gn
	 zK7j+ZHb5TYPUJwiFD3HuFLFLq83n595fcwRRMZRb1KPeISunxjeQm2CD+ZJeh/efl
	 pF0mI/P0UNXc8k04R3JkVVEXNnnEMUps10Deiobc5y92ZDzbc9UyBW+zd5vdSoI1zO
	 ibZiuNXD7gBpOxbi7i1Ee8NiNvlYl9Nes+Azb+7jIS9TR2EiLg0
Date:	Mon, 11 Jul 2016 10:36:53 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Ronald Wampler <rdwampler@gmail.com>, git@vger.kernel.org,
	mackyle@gmail.com, reubenhwk@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH] config.mak.uname: define NEEDS_LIBRT under Linux, for now
Message-ID: <20160711103653.GA29598@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	Ronald Wampler <rdwampler@gmail.com>, git@vger.kernel.org,
	mackyle@gmail.com, reubenhwk@gmail.com, sunshine@sunshineco.com
References: <20160707204554.14961-1-rdwampler@gmail.com>
 <xmqqwpkxnoae.fsf@gitster.mtv.corp.google.com>
 <20160710221644.GA4927@whir>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20160710221644.GA4927@whir>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 10, 2016 at 10:16:44PM +0000, Eric Wong wrote:
> My Debian wheezy LTS system is still on glibc 2.13; and LTS
> distros may use older glibc, still, so lets not unnecessarily
> break things out-of-the-box.
>=20
> We seem to assume Linux is using glibc in our Makefiles anyways,
> so I don't think this will introduce new breakage for users of
> alternative libc implementations.

This is a good idea.  If it's broken with Debian wheezy, it will also be
broken for RHEL/CentOS 6.  People who really want the slimmest linkage
can use the -Wl,--as-needed flag.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXg3bFAAoJEL9TXYEfUvaLwZ4P/j8mp9iNK34FZOntP/G6avgd
JUiS6Znwe2Mj1bLtCiWHuhCUsconJ9nu+TsyJ3tBZ80EVyXjiDIn++mmhr9cCAZU
VU2wS10PHTVgk+tfqyycW0c+mC5XfVFokMFvwmr8rgnl2+ncMgQtWiPmRByXOI8M
f6lmYC+4Vpa6eaUkpqQQc0Qb2Yu0dAieqIIhlRZ6en/TD3Rlx6LVdfLsKodc4V7c
E3UyYcNGYGKjdE5gIg+j3Idt9+OY+svUxl7THThJ+TZbeBwE6qasym4wTg02YrOm
KZzAzssrm2bKrkhQU9RDbiqhX0VuA8tP7No3F5f6SP20eldO3DVmQvzW6KfK3jnO
hLkpLiIJGQCwxi+8GlKyG/Zfn0XnLi6a8mCwJI3YhoTtRfnbClu8NGSKUWw8SGfT
/Q8Fb7vjWS6wjXvwaXS0ofJx12ARaydIrHLgBpNKZIB2YYWaUF91WhSSe7KH7JEa
0o/7/+z1yC23lNdRc21Cl9LA9EsLJcGRwKsJVxwAT8iqF7hBtITQKozxkmIPqw9l
B6XTzsrDZiFSxaJvcHnhfZGTJb1SNVBsmxa++FotmF/s+eMvlZUO45m8aDO0yUaC
bRXN6tEnm83/8V1VPoI0dWsR4fna688neqwYK9cLFe8MBXa5jLB3d6FQKHrKVU9B
VQML3MwmLHlWbLqz8NiM
=EQPM
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

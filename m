Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED33535CC
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534559; cv=none; b=EBsF857XFxhLBciRZJOs+A3AuvuySqRPEx7JA1S135lsMhz5qeb5jvcQFcEmhRmX/kYW41X+cvR35ntxKoSLaX8P9s+ytRrEGBou+zy/I9gWw1ZMNNspRYdXR7XspnNkIUTuF0X6VQmsi1sFZdudVw/yYC/NHUa3B8Ya7wjbuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534559; c=relaxed/simple;
	bh=OJ+zFcV/taBR9mZ52tfyfY0LdEps49d/PxHUCi9Fj1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnv296JanifI9qTMvBaFD7fQHKCGFqhY3pD8wnFx0OFDwneHm/kOSt0o771CnmFzFwjPDBy/BgY2IgGjYySFBlHQ0/o0Plk74rpOO9l7PXGDlU3N68ijYsUbZpH8xPrQ0scRr3BoQehxjgx8Y8cViCCdqHSeggYiichD4a+lMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=q3HQcSiT; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q3HQcSiT"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id F3C475B3DF;
	Fri, 15 Mar 2024 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710534555;
	bh=OJ+zFcV/taBR9mZ52tfyfY0LdEps49d/PxHUCi9Fj1Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=q3HQcSiTtEpCBBlqotlaSeUOy4tf7Mv8JKJM6ZTFYu+KjxTq68Nd5O50uYiA/u2IF
	 qxr4XwDx8uqYQHnCppJnoErdN+ZYrUI6Snp3oMTastpam9nSbDk8ueAgH6yx6YjMMZ
	 UFuEJSYk7XciVfkkwOZ0WrOwhj0SPtNhfnr1EmsnbWB/hlflf0XeJqUC2TAoxz1qJg
	 BuC8E+Xbi4Dl8n40Tn5U27oRV+yINXs5W19jsf/Idefn4Jb6RBY5vseD7K+4S+/Fyc
	 qlKvKOjbv+sNvlfyzDzxCAz1MN0VzHU1CHHCY31Eve9UNlXud9vNGdd2HIuKQzhWsi
	 UKxBQS+mZljX5lT4GhZYLMyLCM7fl0xJHcJ1hfg99Y++Ka8+nhPuT4rx0M+yczk+Q/
	 h3tAaj1rhko5+5I+t6AB7EHL8NcGNaT26xmMZTmo6/K67+CWr8dtQhUo0bMxFwQ/u2
	 VSEyI/pnxv8Sj3Q7wFhmicufqFw9ZlcvfAaNphd0933/t1BAqWY
Date: Fri, 15 Mar 2024 20:29:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Message-ID: <ZfSvmOWrsT2dFnG5@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christopher Lindee <christopher.lindee@webpros.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g>
 <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
 <xmqqv85otmsb.fsf@gitster.g>
 <ZfOYxnRHwyFdU4Y3@tapette.crustytoothpaste.net>
 <SA1PR14MB46911007FDFE3FFADB4FB3A68D282@SA1PR14MB4691.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6DuJVdnaJuUUo6PY"
Content-Disposition: inline
In-Reply-To: <SA1PR14MB46911007FDFE3FFADB4FB3A68D282@SA1PR14MB4691.namprd14.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--6DuJVdnaJuUUo6PY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-15 at 08:58:35, Christopher Lindee wrote:
> Is this a potential avenue for DoS?

No, it's not.  In our implementation, there is a functional limit on ref
updates and if you exceed it, the operation fails.  We also have rate
limiting that estimates future cost based on the cost of previous
requests and delays or fails requests which are projected to exceed a
reasonable threshold.  (Thus, you can make many more cheap requests, or
fewer expensive ones, your choice.)  All of this is per-repository, so
generally only you (and maybe your colleagues or collaborators)
experience negative consequences if you attempt excessive use.

I can't speak to other implementations, but robust rate limits are
typically common.  I'm sure all major implementations open to the public
have some sort of rate limiting because otherwise they'd be down a lot.

The difference is that failing operations and even well-explained,
well-documented rate limits cause a poor user experience, user
frustration, and user inquiries (e.g., support requests), as well as
possibly noisy alerting and potentially pages for engineers.  Anytime a
user experiences rate limits, they have to make a change in their
behaviour, and people don't like change.

I'd prefer we left the default to do the cheap no-op because, as I said,
that scales much better, and thus we allow users to do the obvious thing
for much longer and it just works for them.  That, in turn, provides
everyone a better experience.

Certainly, if people start using this option by default, then it will be
a problem if they engage in excessive use and server implementations
will probably scale worse, but usually users don't use non-default
options unless they need them, so I don't think your new proposed option
is a problem.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--6DuJVdnaJuUUo6PY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfSvmAAKCRB8DEliiIei
gXBCAP463czqdZm254/AJgdfoeZj/qgk6AwpqSUm1B69x+0NPAEAuRBuJPzhFoa7
19kDDyKKyhgYgefFMEURiB9MESxqswM=
=yi8x
-----END PGP SIGNATURE-----

--6DuJVdnaJuUUo6PY--

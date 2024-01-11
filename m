Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E0D298
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r/YONp2R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xjmt/LRk"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 52ADF3200A94;
	Thu, 11 Jan 2024 02:17:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 02:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704957439; x=1705043839; bh=itGB+pD4LS
	M1etMMln9cM5WNQJPGoKbpUyoL6e0FPFw=; b=r/YONp2RnBihypF3cVwRV3DY2d
	X7iijW86RIzucnbm4x+zAVs3sfO5rikxStN2vV6MQVe88+7aFYT14TToUtytXz+j
	i8ITykC1g2We3jFx/4fYzKAmMZfrlC49pxuu92Bm0QtkWqrZ7DhSZ5+L/EgYlPlN
	E4/YVkGnSXbnF9YCYp+L+urSo1myEm5ohtyyhPO/UHerf5mnby+R0W8bYJ4Lf+uO
	Zkv8JI1Ex7ZqaVmsaAsJirocRcvjerJU6RnZ6sa/fxHxsI1cXsL5kEqidz1rAcjI
	laXP1GC+UwU81apGRKhxOSxSLfcmj4n1hdLC6wLP1pNWQQhp8HK8l0rQiLzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704957439; x=1705043839; bh=itGB+pD4LSM1etMMln9cM5WNQJPG
	oKbpUyoL6e0FPFw=; b=xjmt/LRkbVZeD7zNnBnt6fmQV08nPIbJSyVZp+hA81y5
	JaLH0mz0BCZ+zF3xEX/pBu7KZdlfRt3ZrzRVsvUuwXwMHiCPeMjbiwtJwvGYfk8d
	2Clo7yBEdJoO33s8TEfeNqxU86tt/aFdVGKcXqzJ2wyIC07xIz4af6a2sUB8Em5L
	K2aECpM6EOiWstfI1LbZDiHpVIgi/MZVEcm4r1ukkGeXozo5uSPOMOatEnfY38WN
	jwDKcubGyVAjXO7qHu2vJUOz4nAOJiHJUC3ae1DkUnTK4VsjJJX2yGj5U7k8NZA4
	RMdIehHmF4PeUd+nAbsL3zRWk1pJ/wmPPQgK94R46Q==
X-ME-Sender: <xms:_5WfZXfmKvqDKHttaG84nmpe6Alx-R7V_7g7raWSdE925Bew-b3f5g>
    <xme:_5WfZdMm_f4ouibdLwVKzmpK1xQc843F200hffA9jfj_Om9Ritao1YHFZbUY9mpCC
    z68z3J4UhCv3GGaQw>
X-ME-Received: <xmr:_5WfZQhyj77_9_dA31PMPNIGXgXyK-FZsXh_PEoEXMY_5Tg0A3z3-c_joLarOxxp6iR700C7JwyMFMyH3VWk_asv9Pli90XsXLYe6-HaDUNYhkcf2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_5WfZY8pylc_C3c8jpsJ5ZFrytgd8lEKtvVa6twua0DYmLo5RyDaBQ>
    <xmx:_5WfZTvwgZAE6Atn7p7JWZAdN4hgYadlXFcUHoq3miB3eeKBbx_47g>
    <xmx:_5WfZXHncmZEygQq91NLmMaAZRTW1BzYoBqr80Qj13HgkAi18i7ceg>
    <xmx:_5WfZcU34c6XxD1LDhy1pwtAS9GBxqCwa-QVVlxmQZNNevf0wGklrg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 02:17:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf95a75e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 07:14:34 +0000 (UTC)
Date: Thu, 11 Jan 2024 08:17:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Limited operations in unsafe repositories
Message-ID: <ZZ-V-vwnm2hOkrMC@tanuki>
References: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>
 <20240110120531.GA25541@coredump.intra.peff.net>
 <ZZ8pbAMNaBDFgf3G@tapette.crustytoothpaste.net>
 <20240111070114.GB48154@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Uzt9GYwDeV2oK8C"
Content-Disposition: inline
In-Reply-To: <20240111070114.GB48154@coredump.intra.peff.net>


--0Uzt9GYwDeV2oK8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 02:01:14AM -0500, Jeff King wrote:
> On Wed, Jan 10, 2024 at 11:34:04PM +0000, brian m. carlson wrote:
>=20
> > On 2024-01-10 at 12:05:31, Jeff King wrote:
> > > My thinking is to flip that around: run all code, but put protection =
in
> > > the spots that do unsafe things, like loading config or examining
> > > hooks. I.e., a patch like this:
> >=20
> > I think that's much what I had intended to do with not invoking binaries
> > at all, except that it was limited to rev-parse.  I wonder if perhaps we
> > could do something similar if we had the `--assume-unsafe` argument you
> > proposed, except that we would only allow the `git` binary and always
> > pass that argument to it in such a case.
>=20
> I'm not sure what you mean by "invoking binaries". I had assumed that
> meant just running other Git sub-processes. But if "--assume-unsafe" is
> just setting an environment variable, they'd automatically be protected.
>=20
> > I don't think reading config is intrinsically unsafe; it's more of what
> > we do with it, which is spawning external processes, that's the problem.
> > I suppose an argument could be made for injecting terminal sequences or
> > such, though.  Hooks, obviously, are definitely unsafe.
>=20
> Right, it's not config itself that's unsafe; it's that many options are.
> We could try to annotate them to say "it is OK to parse core.eol but not
> core.pager", presumably with an allow-known-good approach (since so many
> ard bad!). But that feels like an ongoing maintenance headache, and an
> easy way to make a mistake (your mention of terminal sequences makes me
> assume you're thinking of "color.diff.*", etc). A rule like "we do not
> read repo-level config at all" seems easier to explain (to me, anyway).

With the exemption of the repository format, I assume? We have to parse
things like `core.repositoryFormatVersion` and extensions in order to
figure out how a repository has to be accessed. So I agree that we
should not partition config based on safeness, which is going to be a
headache as you rightly point out. But we can partition based on whether
or not config is required in order to access the repository, where the
set of relevant config keys is a whole lot smaller.

Patrick

--0Uzt9GYwDeV2oK8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWflfkACgkQVbJhu7ck
PpRnsg//cf9KfODmUW5NiEJ4ma5GtgGwydbigfWf4LamR7Tw3MsJ3z26QoB8fdTV
r+Zeh/LE8qAQktoLCbHSHNsySiUv4iktlRcwZAxlUsvR6CKQZ05qgrqzDIcYSIkp
4IHUFn96pvyhn7iigQQPC1t6YB2PBEZiuyI8H8+uB15WUaWlb7mVyYL/ZScZ9zE5
0lVxUzOkoQ0hGrfTXHBRmOwAAgZDjgMhqZzF7QDIjJAweVOiQ9v5eGXcJLfYi0c4
LHOvmy5OAQgpdr4UIVZtWLvGS2B/A5MgZrcOxFAOCIQmpmNk1papFt8Lensun8fJ
Hujgg1WNtYkJSSJc7egvA7h6uKdUiM61sQbCKUKgWtsXensdBELY+Ps/2Rswvjmm
mU4cyksB+eUgEbEXW8Qb4AS/k6O6w6cVJuvKg/URt2e9OGIKlLkYbXLwUqn3PC7E
LtVEvFWQ5hY8HaGpN8MCr7BQKa2pU9JmLbj/LLKp96BtsyacfZB8U+vmpr5bOc+b
K8uHgvNtCjVMxZkhE2XLx1Dh/JTNIC1CC3TS4qq8ZHkD4BypZQPWss2D5qgly7nU
u7Et0tGQAORp83DpEqWekFIy/MrKBXip0i6r67TnmL46NZArhVt2J9jBDPailpPo
3o7+kJ/SyIekVlIZz+1HCBkhtrQDN9LVI2saR1MJCHczuQy1vtQ=
=LZxm
-----END PGP SIGNATURE-----

--0Uzt9GYwDeV2oK8C--

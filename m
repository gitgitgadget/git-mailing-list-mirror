Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nLxilvjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zPkFjsYy"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AF5110
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:14:44 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 7BA213200A84;
	Thu,  7 Dec 2023 03:14:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 03:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701936880; x=1702023280; bh=av
	0cYR9iGD1SX3iwbsl+mblu6pu9G7M27YMBd4GukKQ=; b=nLxilvjD8d0Jop3GnW
	xTB2qLrW30Cp+7RoYt2mmWbHD7107LuUY7BK82Jj7wPnHaXm1XM/2uML4iMm852k
	zB93TwNqHHCWnwyvZ8XwIz+fOaj+A30G1AaIu01869KN2ZezBz3XAPaEOck+wHpU
	gIE0RsT6K0dki+f7y+S5I1I6CJHiyMVhQkhbzlFiuLGFAZCUbZpIfVUfOlVno3UP
	ywMzENDcVki0ufmVNJpXHvBvvSZuddfAL/mqLZWtlOVoMGnYRcpwxrYuHAN+Qw4k
	tPeJfgdPOYDZaPEDK+Lpp2dFn+/Jh7x7QIol/sHgCgCKojN5OZqYtNUfsw4dZw0q
	4YBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701936880; x=1702023280; bh=av0cYR9iGD1SX
	3iwbsl+mblu6pu9G7M27YMBd4GukKQ=; b=zPkFjsYyFfYFo+cOSzi5fXDchsiLq
	we67W1x/DmO04FLbczdd2Y0ecO1AXgp5qxvp5i7pxResMH9TLJGxMQUpZZk+eH7b
	Os43g6p2KAWU4joh3QHSC68cho76INvax6sFtaV1AbDK4Gv5ohJq70TZ+lyVLMbC
	KAphKr5fNjh0fMkZgBwp5GQyobbP9EcRF4v6Wgc/CeVoMqE6ATI48ezkY1H+BH8S
	Lhu9SwYowQYzp1CXANFQrLmhWmM9aYRT3UC4ZzSEh7z6iXS1mZC54iqKilxP4S1y
	PSAI0Z4/gG2WgRCOfYXCB/54O6o7S07DoAKtgg2kdTfper/gj8lxTvCvA==
X-ME-Sender: <xms:8H5xZbmsKy9m0mzKjOwuz4Ft3eZIF-Y2eNoITvh9TzYpSGtqjgDotQ>
    <xme:8H5xZe3cSEM7Q2iXCyzZ1JqmlghvMTH3Zoliu_h0Fqh3iC1FwLDqpSNaXOijPNzTb
    a8qVzrFzC6aeg7GjQ>
X-ME-Received: <xmr:8H5xZRpXX0QzT5iIjQ4fNwjF4C_NCZ5ub0GP5yytyeWv9mBs3RgO0bs4jZrRmBxZcipIZhBLUjyP-gYa101RtIYa8hnv_Z0VA0DLVdjoPtWXOnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8H5xZTnetOEbGRi4tb0VPpLVcZAXG2MCeZOYdSdMjSji-UzmOTfV_w>
    <xmx:8H5xZZ2YeSCVBfYdn9AXNFuYwlLfllKrWOSWAhy8Qh2aL5IuHJ3Bvg>
    <xmx:8H5xZSulhWqFd556Ov6qWomhwC7TlolRtDdEpYAbK5W3bliSIQGOrQ>
    <xmx:8H5xZa8X6g7OK1Oq8flid4PIHwMMiTKIB-hlJCk5tOUvTTKY8IvIxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:14:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12cd67fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:13:10 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:14:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 0/7] fix segfaults with implicit-bool config
Message-ID: <ZXF-7AMZ_SBltplk@tanuki>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QtIgiS55PHYjulvp"
Content-Disposition: inline
In-Reply-To: <20231207071030.GA1275835@coredump.intra.peff.net>


--QtIgiS55PHYjulvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 02:10:30AM -0500, Jeff King wrote:
> Carlos reported to the security list a case where you can cause Git
> to segfault by using an implicit bool like:
>=20
>   [core]
>   someVariable
>=20
> when the parsing side for core.someVariable does not correctly check a
> NULL "value" string. This is mostly harmless, as anybody who can feed
> arbitrary config can already execute arbitrary code. There is one case
> of this when parsing .gitmodules (which we don't trust), but even there
> I don't think the security implications are that interesting. A
> malicious repo can get "clone --recurse-submodules" to segfault, but
> always with a strict NULL dereference, not any kind of controllable
> pointer. See patch 5 for more details.
>=20
> I audited the whole code base for instances of the problem. It was
> fairly manual, so it's possible I missed a spot, but I think this should
> cover everything.
>=20
> The first patch has vanilla cases, and the rest are instances where I
> thought it was worth calling out specific details.

Thanks for working on this topic! I've left a couple of comments, most
of which are about whether we should retain previous behaviour where we
generate a warning instead of raising an error for unknown values.

Patrick

>   [1/7]: config: handle NULL value when parsing non-bools
>   [2/7]: setup: handle NULL value when parsing extensions
>   [3/7]: trace2: handle NULL values in tr2_sysenv config callback
>   [4/7]: help: handle NULL value for alias.* config
>   [5/7]: submodule: handle NULL value when parsing submodule.*.branch
>   [6/7]: trailer: handle NULL value when parsing trailer-specific config
>   [7/7]: fsck: handle NULL value when parsing message config
>=20
>  builtin/blame.c        |  2 ++
>  builtin/checkout.c     |  2 ++
>  builtin/clone.c        |  2 ++
>  builtin/log.c          |  5 ++++-
>  builtin/pack-objects.c |  6 +++++-
>  builtin/receive-pack.c | 11 +++++++----
>  compat/mingw.c         |  2 ++
>  config.c               |  8 ++++++++
>  diff.c                 | 19 ++++++++++++++++---
>  fetch-pack.c           | 12 ++++++++----
>  fsck.c                 |  8 ++++++--
>  help.c                 |  5 ++++-
>  mailinfo.c             |  2 ++
>  notes-utils.c          |  2 ++
>  setup.c                |  2 ++
>  submodule-config.c     |  4 +++-
>  trace2/tr2_sysenv.c    |  2 ++
>  trailer.c              |  8 ++++++++
>  18 files changed, 85 insertions(+), 17 deletions(-)
>=20

--QtIgiS55PHYjulvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxfusACgkQVbJhu7ck
PpTwbw//XUro4Gdx4Lt44Ctt4pj+cwf0umwv7lOqvVTeTf9SW5TQOGJVRPRfXIrG
x2YOLIf8mNXnND8og0jQNBMHsaINw861znIoNT+1aMfkDYr0rwwlGZvvp5/oSubK
pkG37/QXH9xzMabyVqubILF0XwXOnPmLbljvDXuQVn4EZVPb/L4fs4CNLKZP42WW
zF6lL8gYpzf6k41DhiDqGs5JuG4eJZhhi/CiEOEnr7IyZsd1UEPugIOtH/bgo92M
pvsuf2NRVuFoR/NfeChuB50iTL3qJIBdNW8ziJFREoP3JNaJW7EvnD0+Rif1l8/1
DLoSp5PkHDUrbH5TgODdEmLqASzpYU2ppIBDrgw1BYoxUae+dS4jFbXd1v0stcXE
tHRIsLzFSIQO31BjXCVanG8SWGbZ/X74FTu2i6r3r9VpzejyVQz9/MviPm5YAmFI
881QmXtDMr9LeMkEKG/oWxpoFyfuZ6ZY5R6F1dXcYJ/0iEw8kscrZB/R3l37sngL
OySSk8Ixrj8mIXPKTy36vvpyfqG/xUJPuVH3uQhoKgjG8tV+WxSK+WdN3Fner8Qw
rrvsTbS/yext2c7dIBXCfxI2ls6rrznRnJBQpJgEgAUbS6ZK6rMQlbtwBke1UkQQ
UOI3S5WyEyg0t2D34/esNpx4UJTc0kJfpCQy1XFn/zF86lqOQN4=
=mxEp
-----END PGP SIGNATURE-----

--QtIgiS55PHYjulvp--

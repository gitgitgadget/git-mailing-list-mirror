Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879C182A4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KaVf4Yaf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7I19XNl"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A291
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:05:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 06C473200979;
	Tue, 31 Oct 2023 05:05:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 05:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743101; x=1698829501; bh=+z
	8YuG/jUwTGAh1ZCpIH0dHYmgGp07sh9tJvJ0CAWIo=; b=KaVf4YafHqZwAggX2+
	Bqp2msnR5XbaTMVGeqylJeJxrw8DAfwZJhgTay0t+GBZGkP0jdb2u+4+CbfAWX8k
	wEcrzLv+1d1lEeUkqrpZ2UjZjvZMoY0doC86wJ6529CbojL2rwne2ZftdWuaOE6A
	NYMuQchXdxVLiZAwage8V4SdNRVLwyPine8+zr6uwJF1Jb75Kzlr6fk+1XApMIs+
	mEFLrLNOU9zLbmEyT+rlA26KHtGGvkRYzWGhpQxaIyY5lcSukE29Dwh2GlbwDb0x
	LqVDz8WdrfGoFTDjxgKxfxoR05Zw/th2LZ7U10elH5qqMnwauAx39FS50ScwkaE5
	8lTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743101; x=1698829501; bh=+z8YuG/jUwTGA
	h1ZCpIH0dHYmgGp07sh9tJvJ0CAWIo=; b=R7I19XNlIlB5/sBUcPe9benh7Qs4C
	GowCa7quuIizg0Asrt9LSgg6bxYssKoT347jGM7Nq/fc9fYXJ/n81Gf1l3edRWBh
	M0DfeFAhBZpsfNTdPis110yqRgfRO0A6vtRnHWdd7vzEXDmk3084sx8a7rbeCFzm
	DJEczT0xrX9LrMOY6N+pjVNZnDlyhnOeGBnTwIjXqmAAlvMhhX59aEXfrwgHOSIJ
	+g+wL6BKTrN9wCByrsAAj35JbJCMxcCWB4jrUKZLSXeaqkG9NzpNAtg3OYUEeuPF
	VXUr5kh7+z65mewQLoQ5SKqHrZY7toeiNPg+9IYqp3IGq04l0voRF3I7w==
X-ME-Sender: <xms:PcNAZc7cH9TSvhCrNbAaOEPUasarSkBVosesIoovISQB9OuHweX-eQ>
    <xme:PcNAZd4z0Gt4VhKHbk3LqZ1LOkU1thT3D5Ow0heKlVws5aRLrMCBzrSHXO_f9b6sO
    vDRkYxfJ2Yg1W5-IA>
X-ME-Received: <xmr:PcNAZbfhR0LP14RmpIL_BGuxm4bzT0HxNuuaKJGqZ5J-720CJhUJJV5nux_hXqkJ2hlJL8aoMAxo0q893La8nHjbLBSxmEZqh_Hne_YAh54hdLW1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:PcNAZRLx_NgwhxXutzPgwMXk6FXJ6PbhfwS-hNX1AXWm2m_09rGaPQ>
    <xmx:PcNAZQKVJLni8REkUSyJia5Tkr6RaFNwvjyUXZN-B4rKLRxlKrrN1g>
    <xmx:PcNAZSzaMU3741xjJB2sqzG8I4ExcpX44lymnNKAfp5iLg2yejKGRQ>
    <xmx:PcNAZU3Z8qvBuvjBPvpzw2BapEyaVgPGTmggczz45N5kG_4-w-Gdfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:05:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e492443f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:04:52 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:04:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 5/8] ci: unify setup of some environment variables
Message-ID: <a64799b6e25d05e5d5fc7fe3c5602b5ce256d8b9.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tXtn69AWXjf5bjqK"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--tXtn69AWXjf5bjqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both GitHub Actions and Azue Pipelines set up the environment variables
GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
actually the same, the setup is completely duplicate. With the upcoming
support for GitLab CI this duplication would only extend even further.

Unify the setup of those environment variables so that only the uncommon
parts are separated. While at it, we also perform some additional small
improvements:

    - We now always pass `--state=3Dfailed,slow,save` via GIT_PROVE_OPTS.
      It doesn't hurt on platforms where we don't persist the state, so
      this further reduces boilerplate.

    - When running on Windows systems we set `--no-chain-lint` and
      `--no-bin-wrappers`. Interestingly though, we did so _after_
      already having exported the respective environment variables.

    - We stop using `export VAR=3Dvalue` syntax, which is a Bashism. It's
      not quite worth it as we still use this syntax all over the place,
      but it doesn't hurt readability either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 9ffdf743903..9a9b92c05b3 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -175,11 +175,7 @@ then
 	# among *all* phases)
 	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --write-junit-xml"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows_nt !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--write-junit-xml"
 elif test true =3D "$GITHUB_ACTIONS"
 then
 	CI_TYPE=3Dgithub-actions
@@ -198,17 +194,25 @@ then
=20
 	cache_dir=3D"$HOME/none"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --github-workflow-markup"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--github-workflow-markup"
 else
 	echo "Could not identify CI type" >&2
 	env >&2
 	exit 1
 fi
=20
+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
+GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
+
+GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
+if test windows =3D "$CI_OS_NAME"
+then
+	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
+fi
+
+export GIT_TEST_OPTS
+export GIT_PROVE_OPTS
+
 good_trees_file=3D"$cache_dir/good-trees"
=20
 mkdir -p "$cache_dir"
--=20
2.42.0


--tXtn69AWXjf5bjqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAwzkACgkQVbJhu7ck
PpQPTg/+LnJK9ronuPyOwoSW9vvvycKykeE3WvQYdjsXxffwY4zU1V9K5pNvOrXr
aC13wZc6sUIDhXmfy4aYdrwsB1wEETdzDEAxDBKwRluXb40HiMJFvMWnQvuebDEp
16qGjbAbA3wYArW/QDU7VvVJc38EF9JJQ85VI9epeEBjzRmprj0JOk9PSUNPJrTi
zTisvhd4WLyhOMRZqR8xBwRBO/Qk5pzpxF1c+DCT5HbeOD5bgd6WxguPaxz/tf1i
545B/2nAPXVgBIYQRvjqSZV154CsVKGZAcgy22n3GzQ8pli6rZmTOXr5LPEhZxka
A99bLPHO4TZjBPO3YjiUQrNCKT8xtRi803J5TX9JtS94XHsRVepiV3/VkFUg3skE
JK7ybwJrtQlcX3QyVV3YoHDOU9PV5EOzLbGp+YHSPsijmzZgQyMK/M1kwpiryC3l
4IcdWFwTEq3JRG4saGFCthXUvR9HjfNMjEGI6tkTJlMIGUjvcqvVVi5hWraWbiDX
nWfKsj7pkYFz+q6HnRFGerX4G9D8TLF7ykAxw8LGJ+U8vhRNGEWE3c8THxyQfPms
8sVsl6C3yzN9gU2vxZOMn+rKr9wNtb3uaibEMeDiBJBoNAdZg4mLETOb67UCeXT+
WtJ7pMguM0qZxgoeMpCdk8XCqMujOuhzNZHIQcb0WonN/kKOGjw=
=YoGZ
-----END PGP SIGNATURE-----

--tXtn69AWXjf5bjqK--

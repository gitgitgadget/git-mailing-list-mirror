Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF412E44
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vZpsxjdM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKCak9gF"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A2103
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:03:04 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 52E265C0429;
	Wed,  1 Nov 2023 09:03:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 09:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843784; x=1698930184; bh=38
	oBy1IBjhcoP6a36VWXeV9rcI0uvMGQM9wk0+CFs8Q=; b=vZpsxjdMCurDyiKsiW
	pAiWFKHE67VIvDEuQTcSIXN2ZEMKwvSauPKHyLdIIE28wnADFL9LdQffNyHQfsfJ
	RXJTwwONZg2oOHJC+VoNRKAETfmgArNQqYkUFeDEefU7rPXD3Hm0jPHETCFrd9B+
	rSRDSEhZpd5DZfVeyinUrigauOLdVQY/QYQhjJ5Vp0Lvsc/33n9yIr+JOn877WTg
	dn9iHMprPEGWzRfA/VOgQb/8QPFkgjI9WuP2k7r8hN6F9qYOWkfFoxO9eBZebCat
	X2nhYl6AzDBnhlvI3zqK17CgvyvWqJsIV2LD/UKQHo1iBCEmK7wcQcG36NB84soT
	Hpvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843784; x=1698930184; bh=38oBy1IBjhcoP
	6a36VWXeV9rcI0uvMGQM9wk0+CFs8Q=; b=bKCak9gFLr9vqC2wYbq1LWNlssLcU
	XSTdYVk1wi5qCuhbgJ1uuWL27/LyJkxK2sY9gjoHWV9kek9X67R50XbxCjFCwsBw
	Zer3pfttqx55rcpXD7TixsBKorWmVuRSdibpK6+mhWaxEDHllmNIU3jv9/oezWTW
	MiISXe7m/Wgswa9jw/0XKDQk3pcJh7W59jSpho+iWsx3huMAaUyF+74eMHJ2hipl
	Y5B2LJxpK4By/6Z9TIhaaDdMSuyYhVDIY7pcH+1G57ncIGrPhoVTvdauPwxtVYVM
	fYoQ87jo6W78aIfJHIJpGxgI74FcLayPxR3xItTrAzTV7EDP9yRwgxy+Q==
X-ME-Sender: <xms:h0xCZSzFwF3fb0uOkh8lyKuwrLZ5IGlELzUPzF0s5tbsNoTn4bBRLA>
    <xme:h0xCZeSXv1AWUuLfVyVZfhqLcmtmZpOhfMN3zSqBQn1TTqf3Fmg_hec4yQjVzgH4f
    xNGetLmte3AlZ14xA>
X-ME-Received: <xmr:h0xCZUXcmjlES_s5lE4jB-tqkufXaEHGa22Nzxb54W8UXhnvsVxe0xalsdNP9tg-yiutQNwjHXJq3g9B--65R4UNcRfS_8_yhQf5uKABPLS2sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:iExCZYgzVdMwWPCSSF3a9pMtTfoa9jR0YUD3g4OAcbMdDKzUqLaZIw>
    <xmx:iExCZUDlNjUFgX5MYkAz-7qjkfCJG-S-Y16QFCYEPP336LE31S6gqQ>
    <xmx:iExCZZK4PVJHNkRiq3DDJyOOXsKbvcuufoVOxV8yHGip1ofI8Ji3sg>
    <xmx:iExCZX-otvhntkykg2mSXJkIWpoUt_qAUEgORRsgCP3O7dwiVUWT_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:03:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a50feb2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:02:51 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:03:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 5/8] ci: unify setup of some environment variables
Message-ID: <6078aea246d874ba18bbd9ce2c0a7fb5c03e1564.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BfG0zR2ZTX3bGDXk"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--BfG0zR2ZTX3bGDXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both GitHub Actions and Azure Pipelines set up the environment variables
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 9ffdf743903..0b35da3cfdb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -175,11 +175,8 @@ then
 	# among *all* phases)
 	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --write-junit-xml"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows_nt !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--write-junit-xml"
+	JOBS=3D10
 elif test true =3D "$GITHUB_ACTIONS"
 then
 	CI_TYPE=3Dgithub-actions
@@ -198,17 +195,27 @@ then
=20
 	cache_dir=3D"$HOME/none"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --github-workflow-markup"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--github-workflow-markup"
+	JOBS=3D10
 else
 	echo "Could not identify CI type" >&2
 	env >&2
 	exit 1
 fi
=20
+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$JOBS"
+GIT_PROVE_OPTS=3D"--timer --jobs $JOBS --state=3Dfailed,slow,save"
+
+GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
+case "$CI_OS_NAME" in
+windows|windows_nt)
+	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
+	;;
+esac
+
+export GIT_TEST_OPTS
+export GIT_PROVE_OPTS
+
 good_trees_file=3D"$cache_dir/good-trees"
=20
 mkdir -p "$cache_dir"
--=20
2.42.0


--BfG0zR2ZTX3bGDXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTIMACgkQVbJhu7ck
PpQMDA//bP7k+JvH7ezkOQOsMFiU/ZEc2zR7swz7nscbkHCiSExgmQiE5dzS7MKX
PjhKvE8XFm22Jw3DKPugvS7UOEmDeDhRrXHHdvYQaOQngeCthadC/SNl7QMu9mWp
QFkTQxkhJM9FcsF/5nlT8RBqnPeLuID2Lpk1GFacW37sLQKIVCl6wZj/3ryUTkt/
zbNUbER0u1osgCDj61xFLDuMKF7TKxNcmj1zu3gN3IZfSG3DTZ3rsapnuRxDCch5
iTf0qpjC+hNMBQoYUoR6zAOuK5b+v7o/2lHzttHwwLcg87L7iC7b29eSu3W3ajPJ
QIWd4pVjrkpb4rP8bUkRROx5wIJ2xUrePFzYYoGc6Vvl4o8B5GdqyWvrNbpEIo9x
wBvMjR23iOKFiLjbcqLniqDFpI6y9ZOeYBGs1A2vNSXhGU0nJnZc4cnIGgV4XkOV
NQYFFs0LDVnNO9mc+NqHjcUoLAdaoMTBitkf0TVKnCRxLLF6rH8bXSGjoCK4EVcM
WfBsLy6oaYuWG4KSTF6FnRXhg6FoV1f7UO7aFEvsowa0sLBq6km3qWur3GVRW5Rz
qr4PCLQ8IWDJzoZNa7GZpnBPxUCzP0yioD45XMyI/rhw+CQVqHHKItMC/kIA576x
belt3nTjNxw5gLM5m4vpr2QFOSMV65gy6Q2EJsRGVjvA3X/hJGs=
=k/ww
-----END PGP SIGNATURE-----

--BfG0zR2ZTX3bGDXk--

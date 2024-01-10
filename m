Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70A3C466
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qbmjOmni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ruHdm2MB"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 5E2423200B44;
	Wed, 10 Jan 2024 04:01:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 04:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704877309; x=1704963709; bh=3pIX0sII2d
	L5B4G4hgysLOstEMigwsAfdygqpzpIMac=; b=qbmjOmni3zphENU0/adLVW6KCe
	dRY5H5eNtj4G1PNu93s/7G35unha+k9hhFId5+GW1Esw3EPNNF7xu7k6YeAokOKD
	BFziATWxq7bI/L/P0qNwnK5xcBheOpl9NZ7B82HGZ5WBskRJe++AV8P8Dv7hnp9r
	qb45eTPzgRdkJUQ/47rwt7/oJG9VxtIkQKaDZpk9727w9DL+tTmTbO1Dsc+WIYBc
	2rz6lZDFsdC35DF3aYMhUHdKC77qcelA5ob4Izf5PQfVrp3SFZKobfjSQXTV0XcE
	8HBp/1r/CJAswrgDhn8X5A6IHMQgNfl0qMfi0K5EI6EinvFiWuWAJC26iOdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704877309; x=1704963709; bh=3pIX0sII2dL5B4G4hgysLOstEMig
	wsAfdygqpzpIMac=; b=ruHdm2MBRCMbSQzmNeVZ5Kzi0oMwnQfN2u4Qbj/OEt2D
	u6u5jZbTgbLLydxBbXtjmLMf9wpjB955aCdGGFSGoP6jWypZ9Ay2RN4sn1rzUVPJ
	3H/xbHzVnHksDQJBEiGPVqh/lGAKDu3aM7RM3phs66uZU1pKIIgD7qKgAPM8KG12
	3GfignRTwKWJmjS3xHivv05+WL2CW4PdMyeZrnXICu8oDtyBaWz7yzUJl2wL0zKT
	267zcF+KUoOHczAJ4vjRPxygWak500PYxJBhSpjKsqu+pz46CKA8s7rH+4ozm0dj
	oPb8re8DFmuKjcfu5Ii1tEuCt7nG3keUBuiJWjJthg==
X-ME-Sender: <xms:_VyeZcoJ5t-430Cs77ElTBQ1s8uxBXu1tpy3_U677dHcJ4gxENMeEw>
    <xme:_VyeZSrD63sPF65MMSBuxt7W5smpfy4tE1gR7rO9dlhPftzuZKQfYPyUiEb2MiaNP
    Nyf6q7EACV4hjkiOQ>
X-ME-Received: <xmr:_VyeZRMt0uImWBuI9GYc5OxFzk85rxULyJECueDA1L1TZAuLTPLtuPgO14cQ4NCs8bKlNLD_aWvxDCXyOLnuYzNb0Knqlz6PAO4fTgmFCllC9QY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:_VyeZT6vY7RPXshFdStNdo6mZAsXFMnsAZ4aqpfxI0jLBhcJEmiPaQ>
    <xmx:_VyeZb4VT-tc4M0UhXnB-JsxZTG6X_u79tQBzAgj7jDukLwm3vvPmw>
    <xmx:_VyeZTiSQ44EwJVVBYbUDrr1RpLoD3hwRq-8XuAfBO4Vq7bqsiL7vg>
    <xmx:_VyeZVQk_hvFi1jf_gYSQfM1OnoVPNpn4-3j1b5KPi85tLeZnDK9FA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 04:01:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d20aad1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 08:59:09 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:01:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/6] t1302: make tests more robust with new extensions
Message-ID: <1284b70fab6dd85114cb24fc5c7b6c49e35eb135.1704877233.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YmIWIYuRlsDtzHl7"
Content-Disposition: inline
In-Reply-To: <cover.1704877233.git.ps@pks.im>


--YmIWIYuRlsDtzHl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1302 we exercise logic around "core.repositoryFormatVersion" and
extensions. These tests are not particularly robust against extensions
like the newly introduced "refStorage" extension.

Refactor the tests to be more robust:

  - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
    repository format version. This helps to ensure that we only need to
    update the prereq in a central place when new extensions are added.

  - Use a separate repository to rewrite ".git/config" to test
    combinations of the repository format version and extensions. This
    ensures that we don't break the main test repository.

  - Do not rewrite ".git/config" when exercising the "preciousObjects"
    extension.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1302-repo-version.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 179474fa65..7c680c91c4 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -28,7 +28,12 @@ test_expect_success 'setup' '
 '
=20
 test_expect_success 'gitdir selection on normal repos' '
-	test_oid version >expect &&
+	if test_have_prereq DEFAULT_REPO_FORMAT
+	then
+		echo 0
+	else
+		echo 1
+	fi >expect &&
 	git config core.repositoryformatversion >actual &&
 	git -C test config core.repositoryformatversion >actual2 &&
 	test_cmp expect actual &&
@@ -79,8 +84,13 @@ mkconfig () {
=20
 while read outcome version extensions; do
 	test_expect_success "$outcome version=3D$version $extensions" "
-		mkconfig $version $extensions >.git/config &&
-		check_${outcome}
+		test_when_finished 'rm -rf extensions' &&
+		git init extensions &&
+		(
+			cd extensions &&
+			mkconfig $version $extensions >.git/config &&
+			check_${outcome}
+		)
 	"
 done <<\EOF
 allow 0
@@ -94,7 +104,8 @@ allow 1 noop-v1
 EOF
=20
 test_expect_success 'precious-objects allowed' '
-	mkconfig 1 preciousObjects >.git/config &&
+	git config core.repositoryFormatVersion 1 &&
+	git config extensions.preciousObjects 1 &&
 	check_allow
 '
=20
--=20
2.43.GIT


--YmIWIYuRlsDtzHl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeXPoACgkQVbJhu7ck
PpTcEhAAkBIOBiF8IRtHw32izN9wcjzM/mM7jqD1NVnO8YjzBfl258FIuNDJ72mF
0WjHj7N7JY3Xu48OtFM0uWjGl7jVJuRsrA1e0z0HuSDx9KZ9KFBezMb+P08YzbWN
CefJbRb3mZe77r2ib7C1u+NleaF1Qt/2iH4nKb3gETrlbNgOhX1prEzsd+Oi8HNs
0FK6E3PIMPhHpZxLMVUcMOxujzmUmiaSoQfPAOcxRXAdeRk6d4G/rXdeKR1E+SXJ
miRApikxEXtnqF+JwSdD+OX8MB6EKpSabi6ns1bFV8Rw3IMl7pFXzkVstEpctEdm
v1AgJtCCkigB9dPvcoxfhtDOthq8ShM9dm16L+wAbpiZGs9SkgjjAn7cI/WyUctU
Tk+UC4UNe8x2fJ0Waa4uKI+vaEIPcPTQW9CLAq3hxZ4Lz6JSqceEB/IKj4xT/Kfe
LHwrypgWkc9k+28QkUEO+s4wg8txcVRmkUSOONcDRtGscP0DcbBJKwZYJvG0BGAn
IDemBqCmewow27gpiTCIEmUvdkcoUCFrNTysKKIMPgorFfQl1tzIwaoNhpadDilG
Mx+s11aYdu/RODaGyWCWqLM//jsHpORM+xx0DTkNEo029pJFaM1oHH2rVgy+NxCh
kW8PZO1PnAyzGZBvw22LedBpaidQbFYUIgkYV4mGj4ViTSXqLh4=
=A2BJ
-----END PGP SIGNATURE-----

--YmIWIYuRlsDtzHl7--

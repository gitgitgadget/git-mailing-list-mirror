Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA02C134A0
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DCtDHzwk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQvLYYSd"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F7FDC
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:03:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A79195C0269;
	Wed,  1 Nov 2023 09:02:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 09:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843779; x=1698930179; bh=TN
	gHE3eW3QgP29f/nRrshY84o6/TYHcWEg//ZXA83nc=; b=DCtDHzwkj6Z30MtDgg
	uYumjiykYxcpevdGoaLUW1LDPAiPWsVndTSs9mW8PdIzG9uD8sGWujJR5Kk6xopE
	3xCNcy+blXO4OeyTsjNCyxOA2dfNgJcwrvNK263a+/U2wJUuj9Q3/W97nE2wMngx
	ypgn6ewj+J3+SbB01Udhg+9+tjeZFyA7Tqf2CqmCFq1I0QT/6rP85Z9Y2/rw1E7r
	9OyzibJtnefc8Vcp/LlOlkd61q4eP7NQnL1155Kr3TVo0XfcnkQwykfFWJXymN+0
	lVujqi6JPtOeAIGxeullDtcNnZTorm1NMgCUuKc+wefN3AeROg01ZXegScz5aeVf
	/Bog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843779; x=1698930179; bh=TNgHE3eW3QgP2
	9f/nRrshY84o6/TYHcWEg//ZXA83nc=; b=kQvLYYSdTc0ir7CacVNTV0rBIOIOq
	DwHpp75w4+F9qZYileTGfgj9nPnj1DWuUUUsgemfkzUwI9GzBtECWdz5GF1LaB2w
	NLOjNK5LXLkkBHpvjhA10LrfFbIpdMnrE4IPfXxPKt+ewqAQlT0WkBxdfy4pjVRu
	WoB3sy5vnHI0/fRanNzv2UZNjyle86QpHTNCWsHntDgoE4rsXSTW6bXbIjxZ+NV1
	g43/4PLAuRuGknp5WAAOx6xjqpPUu7fzVFBqf3Iggl7ZjYI+hIVDrkkoD0WPkQAI
	yUAlWRFo2hVzChNxQqJYDHzPjKnYwv9/4Su438kl5GKz3PNltDLo6fZCw==
X-ME-Sender: <xms:g0xCZb4raKCVYYWTr1EbbpXQgtTkwAyE4xSDgBu4R6h48AzFs0OeKQ>
    <xme:g0xCZQ5wxUKQPsHx_-doLTCUKDglnlg_WYuYcBqPtGO1JnvGZ5A2SZB2-vRSZT6MP
    yCKhHtQR43mkmyDAw>
X-ME-Received: <xmr:g0xCZSeiBTmRCglqMeRG6OqRJoezcX-UihdIfKVEY14oKzkU7LVVM_uBJr8b0IPbefEUjzcDvyx0MGpKO_daSdsDPllKuzqMH6Hd7HjpG4DWng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:g0xCZcKA7OnWtDMa_qFocg3Val4c-6P68vNp9Of_Wscji5qc56rayA>
    <xmx:g0xCZfLifEB5PgNXtgDCrSFF7NFvAYKSTtSI3brdWybFzDmpIc-FyA>
    <xmx:g0xCZVypED3vo4wjr7NlnTd0CpNmLjVi1U_svz-z0quYg-eKYj8Yvw>
    <xmx:g0xCZcEoXlbtXJKMFHzAPJJig7fMsv95Jz0R1Gk8nPSSMkOseEr9nA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:02:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1987f110 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:02:47 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:02:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 4/8] ci: split out logic to set up failed test artifacts
Message-ID: <2182acf5bfce5abf00287b035d321a9cb5b18941.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkQaP7+Qm4TEUtRA"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--gkQaP7+Qm4TEUtRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some logic in place to create a directory with the output from
failed tests, which will then subsequently be uploaded as CI artifacts.
We're about to add support for GitLab CI, which will want to reuse the
logic.

Split the logic into a separate function so that it is reusable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b3411afae8e..9ffdf743903 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -131,6 +131,27 @@ handle_failed_tests () {
 	return 1
 }
=20
+create_failed_test_artifacts () {
+	mkdir -p t/failed-test-artifacts
+
+	for test_exit in t/test-results/*.exit
+	do
+		test 0 !=3D "$(cat "$test_exit")" || continue
+
+		test_name=3D"${test_exit%.exit}"
+		test_name=3D"${test_name##*/}"
+		printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m\=
\n"
+		echo "The full logs are in the 'print test failures' step below."
+		echo "See also the 'failed-tests-*' artifacts attached to this run."
+		cat "t/test-results/$test_name.markup"
+
+		trash_dir=3D"t/trash directory.$test_name"
+		cp "t/test-results/$test_name.out" t/failed-test-artifacts/
+		tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+	done
+	return 1
+}
+
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=3D${TERM:-dumb}
=20
@@ -171,25 +192,8 @@ then
 	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=3Dt
 	handle_failed_tests () {
-		mkdir -p t/failed-test-artifacts
 		echo "FAILED_TEST_ARTIFACTS=3Dt/failed-test-artifacts" >>$GITHUB_ENV
-
-		for test_exit in t/test-results/*.exit
-		do
-			test 0 !=3D "$(cat "$test_exit")" || continue
-
-			test_name=3D"${test_exit%.exit}"
-			test_name=3D"${test_name##*/}"
-			printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m=
\\n"
-			echo "The full logs are in the 'print test failures' step below."
-			echo "See also the 'failed-tests-*' artifacts attached to this run."
-			cat "t/test-results/$test_name.markup"
-
-			trash_dir=3D"t/trash directory.$test_name"
-			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
-			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
-		done
-		return 1
+		create_failed_test_artifacts
 	}
=20
 	cache_dir=3D"$HOME/none"
--=20
2.42.0


--gkQaP7+Qm4TEUtRA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTH8ACgkQVbJhu7ck
PpTPmg//c/eQy+3XyjTvBcSbmMJU/iFFXEMu7SIsyNcPBeNFSaiV//CWu9mtlehu
Dbr8MXKKtgL5Mx3xgJ02cqxCslGFR3ozQzSxiPF3FRSjka/8pDyBUZ1TewLSw4LV
aFK4E66bOuaVRlNAPjLM/sQnhTGiV7tA01ekHVBitw9KEVOs+MlFOovhAY3INRSe
mfSrkYw5QTOjra+a3OiyeiSxChW8e2J4lGtP8k5+k09hioke+piXY1O56+LHFRul
FjJhaBUH0UVmdnPCufar0VkOw1VuREyioP1g7Qp+ejfFp0Kke9GJVu7v438q+3pZ
vs5xNXggxia9LBaR8HKn+YcKdy1PwciLWA/vh9feoipkIVuinUSXDZg/3XMx1sZI
t8Y15+zU08QwRzxBENDuQwKCtTFuOCdoB81SNzfm3rDIDbwP3rBkDGxFbneEO57d
35GGx94rMq2sja/BoXx2IDp+QgqSyeA1myfchVYTr97CRlINOWtyyBayVH7qhwj7
qNY3pPLil5rFzVTb8gq52mFTQr79Qql9OhNxDEVTB0i3hII5TfwzjnddGrp8t6mA
ZLXicygFG+M3/hoeU1lWil9m7rlX4w7f02z9lO962u+bFhX3E82mZ85NJtsgz6j7
eLVN2vrQiB+poxVsl0ERDzn0lryupeGP4sA25aETQmGmgNt1+6g=
=T9lx
-----END PGP SIGNATURE-----

--gkQaP7+Qm4TEUtRA--

Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EB2C698
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jm/p8VLF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xBT96D3T"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A70B55C0116;
	Mon, 15 Jan 2024 05:36:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Jan 2024 05:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705314974; x=1705401374; bh=GLgfuGvyXf
	cNMjT/sr7AAB5ySabc4XXRsE4uYSqDCgo=; b=Jm/p8VLFlZxm0QouRyDryfPrwx
	fHfAuBJV1OSpcQsdl2GfkTyoZnNPyAyJ5g1CE5N3GNXGVMQv/cvyTyCAWyuWlY6u
	fEr5T+KnQiue8+YrsRaOrxldEorRPrvkMi8i+XmMCD8OOvjnkANbV66ovXkwRJL7
	yOzvQtJjEOil7xpnMu5g2E7FkXWvjYEfBmJeUZdeANXcBEGiRY4qjOrC5BIGK0ct
	0id65xEegKmy2qehUeNYUXzInCAl0Z9TFWtPPSQ4CdFq1sQsDvKN0PzKO7KyVgY8
	zAaz7K/1+9w9IyRv4128otMZJLTiYYSamzlvo3V5uCtA0eT6jC8T+mLm2cJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705314974; x=1705401374; bh=GLgfuGvyXfcNMjT/sr7AAB5ySabc
	4XXRsE4uYSqDCgo=; b=xBT96D3TlLEn3/ra+W7a0p5JMKfvncnk4wpOt4PfIG+A
	KJ9O9eWvd8vGhI4x9TanXdbcq5ThQbLhN1W/F5p72pPCxkIv7sgdwku7z3RDtVWF
	S9PGWURWMAlxm06uYb7xx4XRTUQ0rv3E31MLH7IlLQlqf4KW7e7wQNi+nzXO1X41
	1j+MxcUI+qRVrwsb0yols3w3pZKY2mB5Ke582+4KhUilQ5ZWRPCN+7RpS3b86cIG
	/zgs7ArSpZGw62x+cCBhBw9PaMHB7ts73xYhQcA5LNJxEB5Oc/rMQBfDIIJ13C8m
	BwH6yO354SsJySlrYUhAjhNzOrcXLOoBGHlyGw0tug==
X-ME-Sender: <xms:ngqlZe4-vREr2fuVkyFbSGiGS5TIdEI-d8Qm-3OllDxBu0YWSg1Low>
    <xme:ngqlZX67e0M_Ng6aEmt5FXbfVClrkJJSi5NX__s0q1UfES7y6LnsVmAFpvWgh6W8U
    zNb2kHkRw2k7cVMSA>
X-ME-Received: <xmr:ngqlZddgqvk6bY53ZmqiJHccsJ1ixXRPLrEGM0qnUla42DTUXM_zsSX9Zl9vGHaAHAAirSRb5nqJiHAqmhLTu67F68lp9qQKjZau8l5IeIy2dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ngqlZbLRo111coDcgP_DvrXBLKKnbTlSVMdUhu2ds2gz-8JfyvXAPw>
    <xmx:ngqlZSL5gfUHbT5W68itHmykeddU_FdcIdxxL0N8e5qm7xMBzbkVjQ>
    <xmx:ngqlZcw7avbam81H8xG43Lgtu8lXaXv-yiRmlntUTQzS2FXT41SaCQ>
    <xmx:ngqlZXGoVUfmtGAmWQW3Qgtud5hzjZaxn6GVOZksYV_upOMOZVGAOw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:36:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1fd6cda6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 10:33:23 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:36:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] completion: silence pseudoref existence check
Message-ID: <4de00121b24f31d21e54738a4645eefa3d283374.1705314554.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
 <cover.1705314554.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="id6UsyWv82FOc4Nh"
Content-Disposition: inline
In-Reply-To: <cover.1705314554.git.ps@pks.im>


--id6UsyWv82FOc4Nh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 44dbb3bf29 (completion: support pseudoref existence checks for
reftables, 2023-12-19), we have extended the Bash completion script to
support future ref backends better by using git-rev-parse(1) to check
for pseudo-ref existence. This conversion has introduced a bug, because
even though we pass `--quiet` to git-rev-parse(1) it would still output
the resolved object ID of the ref in question if it exists.

Fix this by redirecting its stdout to `/dev/null` and add a test that
catches this behaviour. Note that the test passes even without the fix
for the "files" backend because we parse pseudo refs via the filesystem
directly in that case. But the test will fail with the "reftable"
backend.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 31 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index d703e3e64f..54ce58f73d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -148,7 +148,7 @@ __git_pseudoref_exists ()
 	# platforms.
 	if __git_eread "$__git_repo_path/HEAD" head; then
 		if [ "$head" =3D=3D "ref: refs/heads/.invalid" ]; then
-			__git rev-parse --verify --quiet "$ref"
+			__git rev-parse --verify --quiet "$ref" >/dev/null
 			return $?
 		fi
 	fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 95ec762a74..56dc7343a2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1933,6 +1933,14 @@ test_expect_success 'git checkout - --orphan with br=
anch already provided comple
 	EOF
 '
=20
+test_expect_success 'git restore completes modified files' '
+	test_commit A a.file &&
+	echo B >a.file &&
+	test_completion "git restore a." <<-\EOF
+	a.file
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
@@ -2728,4 +2736,27 @@ test_expect_success '__git_complete' '
 	test_must_fail __git_complete ga missing
 '
=20
+test_expect_success '__git_pseudoref_exists' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		sane_unset __git_repo_path &&
+
+		# HEAD points to an existing branch, so it should exist.
+		test_commit A &&
+		__git_pseudoref_exists HEAD >output 2>&1 &&
+		test_must_be_empty output &&
+
+		# CHERRY_PICK_HEAD does not exist, so the existence check should fail.
+		! __git_pseudoref_exists CHERRY_PICK_HEAD >output 2>&1 &&
+		test_must_be_empty output &&
+
+		# CHERRY_PICK_HEAD points to a commit, so it should exist.
+		git update-ref CHERRY_PICK_HEAD A &&
+		__git_pseudoref_exists CHERRY_PICK_HEAD >output 2>&1 &&
+		test_must_be_empty output
+	)
+'
+
 test_done
--=20
2.43.GIT


--id6UsyWv82FOc4Nh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlCpoACgkQVbJhu7ck
PpREthAAjeRldARH2PqSj1antbDy8FBAf7U7ekVJ0iUw/q+fgPYLV6r6FlxQcBke
uR5prxJza+N3qR7L9q9GfLAzJnQqr+xPHUKziX749lJA5X3yeeBm4JShgXhh3dQf
nsh+ewJlehGZVYUqeltpOZ5iZtESUz4eHJ6EDznC8U8jbaWa7emt5FrZsfYHHuFl
m+rWwZwW5mpsVWbaRdpkTvZs6h/v4JvyOkHuKDmhLfchMbFiqUjkWz5QrgvhEXOY
bNyz5u77V5kEwsqSLjkEvXq7dNXBpryAOIyfj1pMnm5VHOs5tSw4cXOnh4yC3CEC
Qzl/LhDsEl7pr77M1OXbnpSVqvdsrtnMu+uFUgXr4wEyG2xQP4cQZ06oTVBjLdSg
tlc8PoNEhNPeNJk1Bwazdt0pyTXWE6bIUnmA2XOEU6kLsO2pAgdIQOmU+dqKyTF8
f3iag37XeuvkJX5REBxsa3RINCOp89IkrDj5j+TK223JwnMVMdBfGxxd5/nvM3Yt
cKIHssn5DqLYI1trBTTgxhV6tjPqZrlERop4oMbWV4wT4oT1Hniv5x/yA2GW2g6V
O2UzHUYUAMWeCN/nkoBJcgG7lhpzf2+roZazQr9jU02suZbIXajA4+wvg4ZZMJqQ
VAa38Goo6hxj557c/vxJRca8aegHqODDKfGCFS8tn0ppBk/dJrU=
=21nh
-----END PGP SIGNATURE-----

--id6UsyWv82FOc4Nh--

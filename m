Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4315EA8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BVMoqZ53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/yLXOLW"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8BDC9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:15:09 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 0C33A32009D3;
	Mon, 30 Oct 2023 08:15:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 30 Oct 2023 08:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668108; x=1698754508; bh=2F
	Xgdpt8/DxxQZM69ttlWZbcwXlSCeJ+FRpw58fMcxg=; b=BVMoqZ53jFb/DVUst0
	xESC33BC0Qspdlmgxv9s3QzTHlQrvlx5jyov3+THhkJMy1XmdN2RHIcWcdWmUwlQ
	nrnxBDuBokW177ZrJxT/SBSCFl64f0c4jH65DGC8VI61GwEQlhbnKQlBKHCCrjdY
	A8XWgvrzktuDCRbbNTzUAe2Cb4t+pSkcRx3AnZ1GKr3Rnq+uC+OWA9C6NjFPhv25
	JWZK9KXqRMCqatQNDpgeyT4+dEnvMunCUWbTaicJDNjOq0WSA/jdaeVf2iDpn01i
	0PeSSkjmtRx9Q+w66E1huj7OQOX0jU4jK3nIdoyFOIw/wy2v2eMhqNMpWzepy62v
	Mt5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668108; x=1698754508; bh=2FXgdpt8/DxxQ
	ZM69ttlWZbcwXlSCeJ+FRpw58fMcxg=; b=p/yLXOLW/CAUn3B9O+OItWWtEhhZ1
	vcf2TRS+mw6ZEGGpLZI136P8A3DfreFnutcQiRwHxwDQf8f9lRsH6UE50LZ+NJiL
	yH8qRcXyNG2pK3DXrhfsxbhTFHA8iK3xIoB0fS31KnBotRdPH7TLHX+WNO717YmZ
	LexJQBI99EEWZTzeP1CTdanC6iuQsMPMpYfVV3ZyPyL/xFB5LX8zwIJDpxr+V7Wm
	FCHiCUbDFwLOy1wKGY6XvcSi5CLQiHV+xqezX2rQWwRQYGXCx6mdaaSCjrddcihi
	cMtRZBEwZmRErJrDsGR7/l2IO6rJjrApDGZw+HkUcMjHv6ks0d70Xue/g==
X-ME-Sender: <xms:TJ4_ZbaBNNDvM810oUwgb3Sb5U3a2s9BTCUVKEpcErcZXSnyxB9HYQ>
    <xme:TJ4_ZabaooJG7h4Na-R1kpdr2atGFAe30GJCpnkEXCpSkSbM2UZKg9XXVucPZ9IKd
    SP3uCFEHU-qUlXByw>
X-ME-Received: <xmr:TJ4_Zd-UMGwK8mKXGGfDYRHnKxTSlTaovkxvWOckLP65rF31pBCEAT7OcAIuPkSuIgjabq6VP_Ags3_GEGkLMKfEiFztPyeDLiZDu34h5WLyfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TJ4_ZRop55rmN-ceEGlD76ldXTkvPjYp4qAuU-o_KJt8Rg-hyBsSCQ>
    <xmx:TJ4_ZWqglU_f6i-NbmoTo4s1oVHeQQ9XnVzejNhou12zqTa7nQcT4w>
    <xmx:TJ4_ZXQlc5_imLBbJNpLdPRJjYgIvP08lPYog7HFxPBFrILNb47-vA>
    <xmx:TJ4_Zd2QCPO64xtGE-r7K1-4fDM__Ab4moAwxjazL-h8Jwmtq9cr9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:15:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf1630b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:15:01 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:15:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 6/8] ci: squelch warnings when testing with unusable Git
 repo
Message-ID: <78d863bf24ea3190c87240fa0c2f6b42fdcde3c3.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vb22hKGgA17xwYMr"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--Vb22hKGgA17xwYMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our CI jobs that run on Docker also use mostly the same architecture to
build and test Git via the "ci/run-build-and-tests.sh" script. These
scripts also provide some functionality to massage the Git repository
we're supposedly operating in.

In our Docker-based infrastructure we may not even have a Git repository
available though, which leads to warnings when those functions execute.
Make the helpers exit gracefully in case either there is no Git in our
PATH, or when not running in a Git repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index c7a716a6e3f..c13b6527cac 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -69,10 +69,32 @@ skip_branch_tip_with_tag () {
 	fi
 }
=20
+# Check whether we can use the path passed via the first argument as Git
+# repository.
+is_usable_git_repository () {
+	# We require Git in our PATH, otherwise we cannot access repositories
+	# at all.
+	if ! command -v git >/dev/null
+	then
+		return 1
+	fi
+
+	# And the target directory needs to be a proper Git repository.
+	if ! git -C "$1" rev-parse 2>/dev/null
+	then
+		return 1
+	fi
+}
+
 # Save some info about the current commit's tree, so we can skip the build
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JO=
B_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
@@ -88,6 +110,11 @@ skip_good_tree () {
 		return
 	fi
=20
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	if ! good_tree_info=3D"$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$go=
od_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
@@ -119,6 +146,11 @@ skip_good_tree () {
 }
=20
 check_unignored_build_artifacts () {
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	! git ls-files --other --exclude-standard --error-unmatch \
 		-- ':/*' 2>/dev/null ||
 	{
--=20
2.42.0


--Vb22hKGgA17xwYMr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/nkgACgkQVbJhu7ck
PpSjlw/9GPEOLFKVmhPqq6B/nxuzItzDmLHbX7cVyYPz85886j69XcRzMnODaSot
ZlIHAA4QeUBOoN5yXv7jU7E6JvGMmsWx28DrwHGTRcq8xGhoIXJhsWTZumZtbwMm
7Q8S/Cms6x9jW6AmzWzUDGJkx3skbanqAY4znDsZvzU2mDt2mDBaAmi5qlrK64CV
PHp0xaje2kxI5ASV/g4sE3MvoXiw9KhsYkfQvhgrP0sO8PcnCeXRdZfOzBAc6xrb
z3lX0MZSX9yxZdpI20CAeI5N+Bp9Pt1FIhAGilKILP6dF8HjmcnKepKt0VfnZmJx
sNxglNgoI6Ehw44t92RxOo9QF8AgyCJGiZ4QvF0K+ptbeIGyJlgVaKS69KtblLTO
y+RnThokqk5+i3XX0+GhobjYEJfeqnpe4qZbKj/wl0L1Y5VYEJ1IN/WlZvx6rPV9
Ko0pCxybO5uBFORwLvFCfAI5aSNagECwe3Wl88Uk9f8+rLaLRYajNvSYxmvjsAUx
qWuh3YtPRm8mn4pZJgQx6KaFlloMY7XZv+CB8diQr4iezL6mc2Dvw7qaFRm3Lk42
8E4lgAK1JWzT7Oj8U5JqqX2ZCMh5Ultx9edtDT/nkTt3IKo6F18TiaI8NfGMAG3n
X5eFRFj/4tlGfuQrAYL9NilyVHtxB5pX4bsTqE6X6rcpafL4qIw=
=VsPE
-----END PGP SIGNATURE-----

--Vb22hKGgA17xwYMr--

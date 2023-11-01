Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD1134A3
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ci/2Pd6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iszsms5V"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5CA101
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:03:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id EF2A95C0489;
	Wed,  1 Nov 2023 09:03:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 09:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843787; x=1698930187; bh=AB
	G0fF0MuK5hQGlyyEvPA1vscbhIytN+V44Um6WKHw0=; b=ci/2Pd6r3kPMmCxbDF
	PXrPW4BV7oHrUV8GDxJX2C1hK6HP0xKXu4UKj7EByQIs92ExZOaj1fyk4cPsfhRc
	4cQj7COAq6Rsjy0f5sZstFOEroDYr+8Xr5d/KzbwfvQHMT71eexioS51ozlRgrq+
	9q/TNjFwxbyUsNerNZReXm2nDCKTEpxAsCa89ZweKdDymkjuKkMEWifGiOM6bmfT
	fJKn+4Jct1DjCQz4j60OCDBn2iaUbT1m4fKcxhZGdK50OQfdkpsCWEewspuVXb06
	jOS7WZ4zIjmGVv84q4Y17jHvO0pfcWLC6dOJbHLmR0i9qB8jPCJLuuIqALLNtLmb
	VGoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843787; x=1698930187; bh=ABG0fF0MuK5hQ
	GlyyEvPA1vscbhIytN+V44Um6WKHw0=; b=Iszsms5V02E++t9v6U2UqG8dws0xV
	dpKN/3LV1ZUguzxXVvyjCrskAO6eoCjCdQ/bHMCqod2PAZv/j5g6PXPFYdVJZpix
	Q7HARU9QFp2hSypg+EClBOYcnEelnyt39SZRICEyTMSwjjsEa9/APoCf479PY3Jr
	zlmhnT1CaHImJhAJqTrwgSQ1wf2tfhTfBvWuOMYw2+CBFvmV3H7hTpRo1ijvhAKi
	Gfqdzu51+TWCzDZfvBuEKeTTUMPD7g7E1dmcw+D8+ZZmABXEzhWnaAUxNzE32yrl
	wWti40i4tLFvWOb81LF0As4y8l9kGiPOJU7EWXr+Ufm+R7BnBFTfnuVCQ==
X-ME-Sender: <xms:i0xCZUp6uCKBd4PNm9iUOS3wYuv5n1svUm65IES1UBwP8VS_Y22zxg>
    <xme:i0xCZaqpmLYfePai-2m60eq9HuvoioIC_Hln8nH2M58V1z5u0VByNTstiocn0Ykdb
    hUNTcSvQXEy6NuCFQ>
X-ME-Received: <xmr:i0xCZZNRh7PBWBL6aSY5x6HAff8tiqp-ZE0w3XtslVn5KJflNqQULY3RvD9xHb1mhorsAb98-iYxZwAwOrBlk2SxgU36hNgsSDSJJkuckdnr7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:i0xCZb45T_b_1PivGYJgaNVDmHLwpkiJi5i9_bBR_n4oo8mbe3hLZw>
    <xmx:i0xCZT4OCEmBLFvsJh1DpQAvA1qm7jXChko3oZ1EOUurBSBjeivBKA>
    <xmx:i0xCZbhgSLuks-BbLTFEyDCemH9XR2xtM4jCuQtiOFy1V7d_GLlc4g>
    <xmx:i0xCZW18WCckIrZLKSKEWKzYod_eKxPuf-NuH1DFAKZ2yMFnjAWxuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:03:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18a295b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:02:56 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:03:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 6/8] ci: squelch warnings when testing with unusable Git
 repo
Message-ID: <d69bde92f2f30c87e8884873b20862aef10aee28.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7iM+9NJYY7QBv9On"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--7iM+9NJYY7QBv9On
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
index 0b35da3cfdb..f0a2f80f094 100755
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


--7iM+9NJYY7QBv9On
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTIcACgkQVbJhu7ck
PpSmeQ//YjKiI20lbw60iaK2ZpSpHurXVBzyBV/lPLUTj6d9386FulbXgd+LmUMi
O2PgwsGPCH2Mle19maW9g1EHX2lQ+CkCs5JcuMWvHvNqHC2wk3WUbe7ztYXskNdJ
WKupoO1h+RAgOr4qUWrJjGL5PZl66Q99DL/AwykaE0K7PI5SRdJdvE3wuNw18C/P
AMmg0Oh8emRr1L2NM7AIc5uCVD/YhvvLwVUQBOZ1klSCW2jSgBdPNOsX67Hv+m9j
Z5We78QO6J5ajlLuC6eWJFQwrlHsgiKg2IYSBNiDLiM452GfwmC8eIHogZXbkqc+
6CvPNfqP/GiG9+ZfmcKCPq2BEG8RUBzSusKE6z/XwXQTmW9/slfkjHd3dpaKp1a+
DHAglOITvE04mPg/snoYwPRCOXtbqJo3vSWAePF7AFbtdb9eHCmkCujkbjmeyUyX
eKDX/nnyst8/oxowoHvG3NoaxyfLbQVUEeYE5FPpitxhkhDPNrzjJLwMP2Brg2yt
VtkVIQiEB6V+ykfzGAR9vMEspjw3Judxx21O8DH/7AXZNo3hg2fJymBKbkRdD2yQ
6APhjBVEO0ElyWcdLWYr5qjmrnw+MuZySkfuo8CA2722OiSrFE/IZzywM/2bWsyL
nOWCvZz3KHW8OYUR7UQ3J8le1Qt3io0vPdESDDEHfsibPJ2+ITw=
=DFU4
-----END PGP SIGNATURE-----

--7iM+9NJYY7QBv9On--

Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084933BBB8
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582532; cv=none; b=XvdIIJC8ni9jQQn7CxWJmeeSC/28MJjEkXcAy3PAx3aUe9s653bm1QpioxMvGtguUaWptTIj6rwpJq4BQlW2miu72XfFssOtyMyLLwnoJ+XVZwHT8ew1qkdBFX/6oz5vcYMD8tRV5awvjZq1cauZ+nF8g6EROg60N+D+YnnJT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582532; c=relaxed/simple;
	bh=DV9pd+XEF1wVWHM80FDbkE1xlysTdKagdNbIsz3ObHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlMJZF1YOXhTL2CGDfKnTC1btkMVB5tQKQCYd5IUMO2/8PjOS0X5oLfG6PBV5TxsuhNzbwA80z9e1rpzPfYEKPstFWPmFUNJxnhxnFhGrq12mmssZAxXxtQGqvdjx21qGc4GDzip2AnT83QxflF08wi7aZ/FRBky1fuLWhj9GuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mwzIQxEb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yh6eUXb8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mwzIQxEb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yh6eUXb8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A90537A01CF;
	Fri, 20 Feb 2026 05:15:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 05:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582527;
	 x=1771668927; bh=k8Oa8ImRi8SNsQr1urWEc7BtetfKumTEN0A8Pbe5yPA=; b=
	mwzIQxEbY/07/IXq59r09MWh+vRbjIvhw+PKYA8Ol/h4FA336lxqt3Gei/pa0oNe
	6U6XlaFyqSa1vCYoRGDeteDMMQhKNLejNlXapdnxvaVu+IIl0G8JSE0UzgrhRYM+
	Xj0ZqA/3RP9ebBFMx879adrso6gAkoI1fbxKwVA21vJVhRZIqvVNBNgWDQMje7E4
	EwbeMe9iMUAPY691jlr51D9Gu8ewsi167TmVf7QgTgSUIaDrzyHE07pgQG6eYLF2
	tGOjjYT2T+esEbkEyAQ4xx0CPmOpbo0RBcy+Dm/swVoYrwgmR3FXx2ZC+gEItaN9
	rJ4jKh97qq+wVejF80iscg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582527; x=
	1771668927; bh=k8Oa8ImRi8SNsQr1urWEc7BtetfKumTEN0A8Pbe5yPA=; b=Y
	h6eUXb8J8WaMoAtX/lWT8UVuUJr/RTSNtZOOm8EWy8Khe7AtDgutdwV7w66LTtl3
	BOVyss67CFHikggtXE7yAs3cID1DweHDf12gi0vYKbF3xJh5EFJhwRfj6wzN6UO8
	saMlT91PufQAZ3KPhdrSxJ3Qbrxqvpqbj7Lod7oxH+qqYeKOWdnD0FIzdNeOKgS/
	9VvNPRo3zQKA4Q2hFd9ke/riPCaRrtKrnWxG7dFNe9iNnCV2+hsUPdTWXfw6Ilio
	Kf+WBKTkOP1/7KKnV6Y2Gu1MPo8TaeOUWNWUr5vBeh2cSFCJhlNnrqQ/XV1SoWyD
	JZDXNACfGPLztQ1xYtKLg==
X-ME-Sender: <xms:PzSYaYQwD3fTrApgf4GsDUd3i4mtscR9sf9UL7-hDZwmx8IsWsq8yg>
    <xme:PzSYadM3kDq6kNtCYJrl7eAcEHBq64KZqxhNs5xD-td6947j5-2M4e4-HGaH9tRK6
    bGWxP9Mv9GAorjUVZ275hls0dZlmLhyL38pwiSa5ii7WkzHeLO8Gg>
X-ME-Received: <xmr:PzSYaTNfkSZ0KFw5JugtLGYp-gzXxHl0izRGFJ-5fHirgLfN-QEQO5C1oo3xQa56Q_HKCrULeF70DDTMpkkn3qO5ygUpBwC3blnH0NZ_Z9ZN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PzSYaVveO-0smYNzh4oqD0bu1YM-_Gco28aerwcyM3jhsPjyBkLuQA>
    <xmx:PzSYaVXqiBw-JVVSCWNfuR-CcXP-IDUciQ-bHKuCcFr1brT8hnDdxQ>
    <xmx:PzSYaVulwe_kGFcUWzI1Fo_mn7HTLkeVbaZ8DWxw2AOKGFw_LDANYQ>
    <xmx:PzSYaZUzuteTobpc_iFURd-TwWDT1hkNlq5CAosU3D6-4UumAf7uDQ>
    <xmx:PzSYaeXs6puiyD8mLW4DwrnLMEK5DgLJFeH-aMYfc7qREjmmBcvVSpqZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2423e078 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:06 +0100
Subject: [PATCH 2/8] t: disable maintenance where we verify object database
 structure
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-2-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We have a couple of tests that explicitly verify the structure of the
object database. Naturally, this structure is dependent on whether or
not we run repository maintenance: if it decides to optimize the object
database the expected structure is likely to not materialize.

Explicitly disable auto-maintenance in such tests so that we are not
dependent on decisions made by our maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0081-find-pack.sh                    | 1 +
 t/t5316-pack-delta-depth.sh             | 1 +
 t/t5319-multi-pack-index.sh             | 1 +
 t/t5326-multi-pack-bitmaps.sh           | 3 ++-
 t/t5327-multi-pack-bitmaps-rev.sh       | 3 ++-
 t/t5331-pack-objects-stdin.sh           | 2 ++
 t/t5332-multi-pack-reuse.sh             | 1 +
 t/t5334-incremental-multi-pack-index.sh | 1 +
 t/t5500-fetch-pack.sh                   | 3 ++-
 t/t5616-partial-clone.sh                | 1 +
 t/t7700-repack.sh                       | 3 +++
 11 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index 5a628bf735..26f017422d 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -68,6 +68,7 @@ test_expect_success 'add more packfiles' '
 '
 
 test_expect_success 'add more commits (as loose objects)' '
+	test_config maintenance.auto false &&
 	test_commit six &&
 	test_commit seven &&
 
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 03dfb7a61e..8a067a45cb 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -48,6 +48,7 @@ test_description='pack-objects breaks long cross-pack delta chains'
 # repeatedly-modified file to generate the delta chain).
 
 test_expect_success 'create series of packs' '
+	test_config maintenance.auto false &&
 	test-tool genrandom foo 4096 >content &&
 	prev= &&
 	for i in $(test_seq 1 10)
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index faae98c7e7..7672d599d4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1315,6 +1315,7 @@ test_expect_success 'bitmapped packs are stored via the BTMP chunk' '
 	git init repo &&
 	(
 		cd repo &&
+		git config set maintenance.auto false &&
 
 		for i in 1 2 3 4 5
 		do
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 892aeb09e4..62bd973d92 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -93,7 +93,8 @@ test_midx_bitmap_cases () {
 	test_expect_success 'setup test_repository' '
 		rm -rf * .git &&
 		git init &&
-		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+		git config maintenance.auto false
 	'
 
 	midx_bitmap_core
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index 9cac03a94b..cfa12de2a8 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -30,7 +30,8 @@ test_midx_bitmap_rev () {
 	test_expect_success 'setup bitmap config' '
 		rm -rf * .git &&
 		git init &&
-		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+		git config maintenance.auto false
 	'
 
 	midx_bitmap_core rev
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index cd949025b9..b03f6be164 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -14,6 +14,7 @@ packed_objects () {
 
 test_expect_success 'setup for --stdin-packs tests' '
 	git init stdin-packs &&
+	git -C stdin-packs config set maintenance.auto false &&
 	(
 		cd stdin-packs &&
 
@@ -255,6 +256,7 @@ test_expect_success '--stdin-packs=follow walks into unknown packs' '
 	git init repo &&
 	(
 		cd repo &&
+		git config set maintenance.auto false &&
 
 		for c in A B C D
 		do
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 395d09444c..881ce668e1 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -59,6 +59,7 @@ test_pack_objects_reused () {
 
 test_expect_success 'preferred pack is reused for single-pack reuse' '
 	test_config pack.allowPackReuse single &&
+	git config set maintenance.auto false &&
 
 	for i in A B
 	do
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index d30d7253d6..99c7d44d8e 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -15,6 +15,7 @@ midx_chain=$midxdir/multi-pack-index-chain
 
 test_expect_success 'convert non-incremental MIDX to incremental' '
 	test_commit base &&
+	git config set maintenance.auto false &&
 	git repack -ad &&
 	git multi-pack-index write &&
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 4bb56c167a..0c88d04d0a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -154,7 +154,8 @@ test_expect_success 'clone shallow depth 1 with fsck' '
 '
 
 test_expect_success 'clone shallow' '
-	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
+	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow &&
+	git -C shallow config set maintenance.auto false
 '
 
 test_expect_success 'clone shallow depth count' '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index d62760eb92..1c2805acca 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -585,6 +585,7 @@ test_expect_success 'verify fetch downloads only one pack when updating refs' '
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
 	ls pack-test/.git/objects/pack/*pack >pack-list &&
 	test_line_count = 2 pack-list &&
+	test_config -C pack-test maintenance.auto false &&
 	for i in A B C
 	do
 		test_commit -C src $i &&
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 73b78bdd88..acc2589f21 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -217,6 +217,7 @@ test_expect_success 'repack --keep-pack' '
 		cd keep-pack &&
 		# avoid producing different packs due to delta/base choices
 		git config pack.window 0 &&
+		git config maintenance.auto false &&
 		P1=$(commit_and_pack 1) &&
 		P2=$(commit_and_pack 2) &&
 		P3=$(commit_and_pack 3) &&
@@ -260,6 +261,7 @@ test_expect_success 'repacking fails when missing .pack actually means missing o
 
 		# Avoid producing different packs due to delta/base choices
 		git config pack.window 0 &&
+		git config maintenance.auto false &&
 		P1=$(commit_and_pack 1) &&
 		P2=$(commit_and_pack 2) &&
 		P3=$(commit_and_pack 3) &&
@@ -534,6 +536,7 @@ test_expect_success 'setup for --write-midx tests' '
 	(
 		cd midx &&
 		git config core.multiPackIndex true &&
+		git config maintenance.auto false &&
 
 		test_commit base
 	)

-- 
2.53.0.414.gf7e9f6c205.dirty


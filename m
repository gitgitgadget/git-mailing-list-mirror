Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C249FC25B0F
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 17:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiHNRAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbiHNQ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D65DDF62
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so6640542wrh.3
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=HbVbbfV0XZun2uRwXAVRnrwH3J9jKCmHcoWiu3EahOI=;
        b=J6S3lAF1yF+Xnn76al7fNVO1zuOP5+FkDPUNEvL9duslML2sYeRr7wU45JSD/TS8uq
         4JovKKv79rqvrn2UdF/DQebbSIqjxY4hEvYLk5Z1nO/2QRAGZ19TO2867YHA+ytpJfzC
         dK7zzzzzQDbuNNnvpe/gLB6GUYDOy7AMR8VoKa8LLizUZNy6bDUEZbp/IptMYOXZQ2Le
         4qQsL18PO8tfUAU+c4b81DfVBthrNlxX5CmeEV4ppJ7oQE8bt8JtkILwwjjLFOk5rz7R
         EdYid+MUZ5QLWjC+YrHxFyVXN3q3QUEzJ4drzMtvi/Tcz0G2ArWvk8ohSKfNkjaLr6aH
         IQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=HbVbbfV0XZun2uRwXAVRnrwH3J9jKCmHcoWiu3EahOI=;
        b=HMsmtxbZgzbr/I6NxtrPl1bL2nrPpQBMrdWAdR67SD2paqXd7d/zJv8tuB0R1sadtC
         v3KNC/a+ypMvzliRoZosRy/KMXM8Tk8XB9pw3pHRoSzmS9ssSvNu17sujNp7G7Iz3HDg
         /mLgtkH5V5jeXpID5pWP2YIdPYT6giacsW4/mVEaBSIgV1q8nen1m0NMLVSEqWFtNVnb
         0j408XfId1VCN9bXyBYm+fny8O5RmoJvOaqkYLkLwdAoZEq+0ib5T3V5b69bXJWkh85s
         TTmTvMJRYItzWK/iWVgYD0Ngz8c3Cs7ZYSZgnb80Ndbi/cx12X0XzjpYbxqL9K2NJ0RG
         hDfQ==
X-Gm-Message-State: ACgBeo1YR9nt4Hjo5z9AQpAns1i/m2qV7F8Z/pWzlfU+YIF1FaZuBePy
        vhjvTUukfEdrOVc2wlaGA6vp+N1PkOY=
X-Google-Smtp-Source: AA6agR4lCtV94+EAqHIzBB4hIjDKbSepQ0gzSFG3OSi0uyF1h9MRabjwJDxcleDrGvlBozrVV9sLJQ==
X-Received: by 2002:a05:6000:697:b0:224:bfb3:dbca with SMTP id bo23-20020a056000069700b00224bfb3dbcamr3825140wrb.646.1660496121590;
        Sun, 14 Aug 2022 09:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9-20020adff509000000b0021efc75914esm4946525wro.79.2022.08.14.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 09:55:21 -0700 (PDT)
Message-Id: <b460516b306e6885cd1c0af1c3379fb953952de2.1660496112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
        <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Aug 2022 16:55:11 +0000
Subject: [PATCH v6 6/6] bitmap-lookup-table: add performance tests for lookup
 table
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Add performance tests to verify the performance of lookup table.
`p5310-pack-bitmaps.sh` contain tests with and without lookup table.
`p5312-pack-bitmaps-revs.sh` contain same tests with and without
lookup table but with `pack.writeReverseIndex` enabled.

Lookup table makes Git run faster in most of the cases. Below is the
result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
gives similar result. The repository used in the test is linux kernel.

Test                                                    this tree
-----------------------------------------------------------------------
5310.4: enable lookup table: false                    0.01(0.00+0.00)
5310.5: repack to disk                                320.89(230.20+23.45)
5310.6: simulated clone                               14.04(5.78+1.79)
5310.7: simulated fetch                               1.95(3.05+0.20)
5310.8: pack to file (bitmap)                         44.73(20.55+7.45)
5310.9: rev-list (commits)                            0.78(0.46+0.10)
5310.10: rev-list (objects)                           4.07(3.97+0.08)
5310.11: rev-list with tag negated via --not          0.06(0.02+0.03)
         --all (objects)
5310.12: rev-list with negative tag (objects)         0.21(0.15+0.05)
5310.13: rev-list count with blob:none                0.24(0.17+0.06)
5310.14: rev-list count with blob:limit=1k            7.07(5.92+0.48)
5310.15: rev-list count with tree:0                   0.25(0.17+0.07)
5310.16: simulated partial clone                      5.67(3.28+0.64)
5310.18: clone (partial bitmap)                       16.05(8.34+1.86)
5310.19: pack to file (partial bitmap)                59.76(27.22+7.43)
5310.20: rev-list with tree filter (partial bitmap)   0.90(0.18+0.16)
5310.24: enable lookup table: true                    0.01(0.00+0.00)
5310.25: repack to disk                               319.73(229.30+23.01)
5310.26: simulated clone                              13.69(5.72+1.78)
5310.27: simulated fetch                              1.84(3.02+0.16)
5310.28: pack to file (bitmap)                        45.63(20.67+7.50)
5310.29: rev-list (commits)                           0.56(0.39+0.8)
5310.30: rev-list (objects)                           3.77(3.74+0.08)
5310.31: rev-list with tag negated via --not          0.05(0.02+0.03)
         --all (objects)
5310.32: rev-list with negative tag (objects)         0.21(0.15+0.05)
5310.33: rev-list count with blob:none                0.23(0.17+0.05)
5310.34: rev-list count with blob:limit=1k            6.65(5.72+0.40)
5310.35: rev-list count with tree:0                   0.23(0.16+0.06)
5310.36: simulated partial clone                      5.57(3.26+0.59)
5310.38: clone (partial bitmap)                       15.89(8.39+1.84)
5310.39: pack to file (partial bitmap)                58.32(27.55+7.47)
5310.40: rev-list with tree filter (partial bitmap)   0.73(0.18+0.15)

Test 4-15 are tested without using lookup table. Same tests are
repeated in 16-30 (using lookup table).

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 t/perf/lib-bitmap.sh               |  31 +++++++++
 t/perf/p5310-pack-bitmaps.sh       |  78 +++++++++-------------
 t/perf/p5311-pack-bitmaps-fetch.sh |  74 ++++++++++++---------
 t/perf/p5312-pack-bitmaps-revs.sh  |  35 ++++++++++
 t/perf/p5326-multi-pack-bitmaps.sh | 103 +++++++++++++++++------------
 5 files changed, 199 insertions(+), 122 deletions(-)
 create mode 100755 t/perf/p5312-pack-bitmaps-revs.sh

diff --git a/t/perf/lib-bitmap.sh b/t/perf/lib-bitmap.sh
index 63d3bc7cece..55a8feb1dc4 100644
--- a/t/perf/lib-bitmap.sh
+++ b/t/perf/lib-bitmap.sh
@@ -67,3 +67,34 @@ test_partial_bitmap () {
 			--filter=tree:0 >/dev/null
 	'
 }
+
+test_pack_bitmap () {
+	test_perf "repack to disk" '
+		git repack -ad
+	'
+
+	test_full_bitmap
+
+	test_expect_success "create partial bitmap state" '
+		# pick a commit to represent the repo tip in the past
+		cutoff=$(git rev-list HEAD~100 -1) &&
+		orig_tip=$(git rev-parse HEAD) &&
+
+		# now kill off all of the refs and pretend we had
+		# just the one tip
+		rm -rf .git/logs .git/refs/* .git/packed-refs &&
+		git update-ref HEAD $cutoff &&
+
+		# and then repack, which will leave us with a nice
+		# big bitmap pack of the "old" history, and all of
+		# the new history will be loose, as if it had been pushed
+		# up incrementally and exploded via unpack-objects
+		git repack -Ad &&
+
+		# and now restore our original tip, as if the pushes
+		# had happened
+		git update-ref HEAD $orig_tip
+	'
+
+	test_partial_bitmap
+}
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 7ad4f237bc3..b1399f1007e 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -4,51 +4,37 @@ test_description='Tests pack performance using bitmaps'
 . ./perf-lib.sh
 . "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
 
-test_perf_large_repo
-
-# note that we do everything through config,
-# since we want to be able to compare bitmap-aware
-# git versus non-bitmap git
-#
-# We intentionally use the deprecated pack.writebitmaps
-# config so that we can test against older versions of git.
-test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true
-'
-
-# we need to create the tag up front such that it is covered by the repack and
-# thus by generated bitmaps.
-test_expect_success 'create tags' '
-	git tag --message="tag pointing to HEAD" perf-tag HEAD
-'
-
-test_perf 'repack to disk' '
-	git repack -ad
-'
-
-test_full_bitmap
-
-test_expect_success 'create partial bitmap state' '
-	# pick a commit to represent the repo tip in the past
-	cutoff=$(git rev-list HEAD~100 -1) &&
-	orig_tip=$(git rev-parse HEAD) &&
-
-	# now kill off all of the refs and pretend we had
-	# just the one tip
-	rm -rf .git/logs .git/refs/* .git/packed-refs &&
-	git update-ref HEAD $cutoff &&
-
-	# and then repack, which will leave us with a nice
-	# big bitmap pack of the "old" history, and all of
-	# the new history will be loose, as if it had been pushed
-	# up incrementally and exploded via unpack-objects
-	git repack -Ad &&
-
-	# and now restore our original tip, as if the pushes
-	# had happened
-	git update-ref HEAD $orig_tip
-'
-
-test_partial_bitmap
+test_lookup_pack_bitmap () {
+	test_expect_success 'start the test from scratch' '
+		rm -rf * .git
+	'
+
+	test_perf_large_repo
+
+	# note that we do everything through config,
+	# since we want to be able to compare bitmap-aware
+	# git versus non-bitmap git
+	#
+	# We intentionally use the deprecated pack.writebitmaps
+	# config so that we can test against older versions of git.
+	test_expect_success 'setup bitmap config' '
+		git config pack.writebitmaps true
+	'
+
+	# we need to create the tag up front such that it is covered by the repack and
+	# thus by generated bitmaps.
+	test_expect_success 'create tags' '
+		git tag --message="tag pointing to HEAD" perf-tag HEAD
+	'
+
+	test_perf "enable lookup table: $1" '
+		git config pack.writeBitmapLookupTable '"$1"'
+	'
+
+	test_pack_bitmap
+}
+
+test_lookup_pack_bitmap false
+test_lookup_pack_bitmap true
 
 test_done
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 47c3fd7581c..426fab87e32 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -3,42 +3,52 @@
 test_description='performance of fetches from bitmapped packs'
 . ./perf-lib.sh
 
-test_perf_default_repo
-
-test_expect_success 'create bitmapped server repo' '
-	git config pack.writebitmaps true &&
-	git repack -ad
-'
-
-# simulate a fetch from a repository that last fetched N days ago, for
-# various values of N. We do so by following the first-parent chain,
-# and assume the first entry in the chain that is N days older than the current
-# HEAD is where the HEAD would have been then.
-for days in 1 2 4 8 16 32 64 128; do
-	title=$(printf '%10s' "($days days)")
-	test_expect_success "setup revs from $days days ago" '
-		now=$(git log -1 --format=%ct HEAD) &&
-		then=$(($now - ($days * 86400))) &&
-		tip=$(git rev-list -1 --first-parent --until=$then HEAD) &&
-		{
-			echo HEAD &&
-			echo ^$tip
-		} >revs
+test_fetch_bitmaps () {
+	test_expect_success 'setup test directory' '
+		rm -fr * .git
 	'
 
-	test_perf "server $title" '
-		git pack-objects --stdout --revs \
-				 --thin --delta-base-offset \
-				 <revs >tmp.pack
-	'
+	test_perf_default_repo
 
-	test_size "size   $title" '
-		wc -c <tmp.pack
+	test_expect_success 'create bitmapped server repo' '
+		git config pack.writebitmaps true &&
+		git config pack.writeBitmapLookupTable '"$1"' &&
+		git repack -ad
 	'
 
-	test_perf "client $title" '
-		git index-pack --stdin --fix-thin <tmp.pack
-	'
-done
+	# simulate a fetch from a repository that last fetched N days ago, for
+	# various values of N. We do so by following the first-parent chain,
+	# and assume the first entry in the chain that is N days older than the current
+	# HEAD is where the HEAD would have been then.
+	for days in 1 2 4 8 16 32 64 128; do
+		title=$(printf '%10s' "($days days)")
+		test_expect_success "setup revs from $days days ago" '
+			now=$(git log -1 --format=%ct HEAD) &&
+			then=$(($now - ($days * 86400))) &&
+			tip=$(git rev-list -1 --first-parent --until=$then HEAD) &&
+			{
+				echo HEAD &&
+				echo ^$tip
+			} >revs
+		'
+
+		test_perf "server $title (lookup=$1)" '
+			git pack-objects --stdout --revs \
+					--thin --delta-base-offset \
+					<revs >tmp.pack
+		'
+
+		test_size "size   $title" '
+			wc -c <tmp.pack
+		'
+
+		test_perf "client $title (lookup=$1)" '
+			git index-pack --stdin --fix-thin <tmp.pack
+		'
+	done
+}
+
+test_fetch_bitmaps true
+test_fetch_bitmaps false
 
 test_done
diff --git a/t/perf/p5312-pack-bitmaps-revs.sh b/t/perf/p5312-pack-bitmaps-revs.sh
new file mode 100755
index 00000000000..0684b690af0
--- /dev/null
+++ b/t/perf/p5312-pack-bitmaps-revs.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps (rev index enabled)'
+. ./perf-lib.sh
+. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
+
+test_lookup_pack_bitmap () {
+	test_expect_success 'start the test from scratch' '
+		rm -rf * .git
+	'
+
+	test_perf_large_repo
+
+	test_expect_success 'setup bitmap config' '
+		git config pack.writebitmaps true &&
+		git config pack.writeReverseIndex true
+	'
+
+	# we need to create the tag up front such that it is covered by the repack and
+	# thus by generated bitmaps.
+	test_expect_success 'create tags' '
+		git tag --message="tag pointing to HEAD" perf-tag HEAD
+	'
+
+	test_perf "enable lookup table: $1" '
+		git config pack.writeBitmapLookupTable '"$1"'
+	'
+
+	test_pack_bitmap
+}
+
+test_lookup_pack_bitmap false
+test_lookup_pack_bitmap true
+
+test_done
diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index f2fa228f16a..d082e6cacbe 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -4,49 +4,64 @@ test_description='Tests performance using midx bitmaps'
 . ./perf-lib.sh
 . "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
 
-test_perf_large_repo
-
-# we need to create the tag up front such that it is covered by the repack and
-# thus by generated bitmaps.
-test_expect_success 'create tags' '
-	git tag --message="tag pointing to HEAD" perf-tag HEAD
-'
-
-test_expect_success 'start with bitmapped pack' '
-	git repack -adb
-'
-
-test_perf 'setup multi-pack index' '
-	git multi-pack-index write --bitmap
-'
-
-test_expect_success 'drop pack bitmap' '
-	rm -f .git/objects/pack/pack-*.bitmap
-'
-
-test_full_bitmap
-
-test_expect_success 'create partial bitmap state' '
-	# pick a commit to represent the repo tip in the past
-	cutoff=$(git rev-list HEAD~100 -1) &&
-	orig_tip=$(git rev-parse HEAD) &&
-
-	# now pretend we have just one tip
-	rm -rf .git/logs .git/refs/* .git/packed-refs &&
-	git update-ref HEAD $cutoff &&
-
-	# and then repack, which will leave us with a nice
-	# big bitmap pack of the "old" history, and all of
-	# the new history will be loose, as if it had been pushed
-	# up incrementally and exploded via unpack-objects
-	git repack -Ad &&
-	git multi-pack-index write --bitmap &&
-
-	# and now restore our original tip, as if the pushes
-	# had happened
-	git update-ref HEAD $orig_tip
-'
-
-test_partial_bitmap
+test_bitmap () {
+	local enabled="$1"
+
+	test_expect_success "remove existing repo (lookup=$enabled)" '
+		rm -fr * .git
+	'
+
+	test_perf_large_repo
+
+	# we need to create the tag up front such that it is covered by the repack and
+	# thus by generated bitmaps.
+	test_expect_success 'create tags' '
+		git tag --message="tag pointing to HEAD" perf-tag HEAD
+	'
+
+	test_expect_success "use lookup table: $enabled" '
+		git config pack.writeBitmapLookupTable '"$enabled"'
+	'
+
+	test_expect_success "start with bitmapped pack (lookup=$enabled)" '
+		git repack -adb
+	'
+
+	test_perf "setup multi-pack index (lookup=$enabled)" '
+		git multi-pack-index write --bitmap
+	'
+
+	test_expect_success "drop pack bitmap (lookup=$enabled)" '
+		rm -f .git/objects/pack/pack-*.bitmap
+	'
+
+	test_full_bitmap
+
+	test_expect_success "create partial bitmap state (lookup=$enabled)" '
+		# pick a commit to represent the repo tip in the past
+		cutoff=$(git rev-list HEAD~100 -1) &&
+		orig_tip=$(git rev-parse HEAD) &&
+
+		# now pretend we have just one tip
+		rm -rf .git/logs .git/refs/* .git/packed-refs &&
+		git update-ref HEAD $cutoff &&
+
+		# and then repack, which will leave us with a nice
+		# big bitmap pack of the "old" history, and all of
+		# the new history will be loose, as if it had been pushed
+		# up incrementally and exploded via unpack-objects
+		git repack -Ad &&
+		git multi-pack-index write --bitmap &&
+
+		# and now restore our original tip, as if the pushes
+		# had happened
+		git update-ref HEAD $orig_tip
+	'
+
+	test_partial_bitmap
+}
+
+test_bitmap false
+test_bitmap true
 
 test_done
-- 
gitgitgadget

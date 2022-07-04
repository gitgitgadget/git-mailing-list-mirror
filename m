Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD78C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiGDIqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiGDIqd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:46:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B99BC1B
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:46:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso5865083wms.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sjOzXnaSdNXg8j5NDLmAxHQPb9l1kvfjMGu2YnrkHk0=;
        b=f5D8engdFRGc0En5j7jTFJynlaa5dlZ8bHd182pH5G/1RcXuneqrYj6+xSt6tIQiZx
         /TUOLIT+vUpXeHO5VHO+AOpEVKEx4ww5SOClqWvsAaArgO54o4KnIxKbumoV9upOeLBe
         jdrz/Emo/7fREJP25fh4lIaoPDv0rIjsE+KK66tbSDHhn7qxF2uIsUkEoSXvVsej8eHO
         EEGWxsRN+zh3d8GMBBt3ODgN82IafJW5bsS0En91SDt4U8bgoTn+jPINqpJ5dwCk5AKP
         iV3U8niNspSiR3e1OWF64SaMrRL5eukxiL9KXM33zm6q5cfubNk/4L/osnuIqWxFbhG2
         ZIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sjOzXnaSdNXg8j5NDLmAxHQPb9l1kvfjMGu2YnrkHk0=;
        b=xmPiiSRssEpMZ7QY+JaqonTZfMvMNMZ1EAJvVBhjITla4tFuTBgbV+qugAuEgBT324
         ndoDWx5Umr93fKZP/bInJ83tIObz69LvXp6lHCAeR6Qb3b27+6sntM+ti6jOeXvJKuS1
         1zm+XJJQ60X9m9TT4mM2ki18PPwIEe/ThOM7H+ya2RyHWXhxDfZ0LvogI1ZWBPuntnJ8
         GFXL9tQNXU7EmHHgezpnmLTvzdyjNpGXBaxARuRAlnX6FxMsdaxcZGlNlFej2HqcDxOE
         SKEuU8uUgZRDWKbH5PoICQAvEE7SMIMCovCAVO5ULhC2TiIW0Lya9QoXWAIokRMBS1wx
         21iA==
X-Gm-Message-State: AJIora+q/YLxoUVrBxFkVZRe/+7gv6eXUxzgAZ3Bp52h8O0jSpt5oMZe
        63+sObGK0Tt2VFRluBurhGV04dVd7+w=
X-Google-Smtp-Source: AGRyM1vVoald7WyUkf5nTRBOfXIHl29V5ZMvJPMn9oPXh89O/Whkbr5Zc+ZRtkb/41UxG/0yhGjbPQ==
X-Received: by 2002:a05:600c:3d96:b0:3a1:8681:cc80 with SMTP id bi22-20020a05600c3d9600b003a18681cc80mr22452922wmb.192.1656924389499;
        Mon, 04 Jul 2022 01:46:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm14580899wms.14.2022.07.04.01.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:46:27 -0700 (PDT)
Message-Id: <a155c1e2ebacf54c451a069499325cdf280606fc.1656924376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
        <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jul 2022 08:46:15 +0000
Subject: [PATCH v3 5/6] bitmap-lookup-table: add performance tests for lookup
 table
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Add performance tests to verify the performance of lookup table with
`pack.writeReverseIndex` enabled. This is to check the performance
when the above configuration is set.

Lookup table makes Git run faster in most of the cases. Below is the
result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
gives similar result. The repository used in the test is linux kernel.

Test                                                      this tree
---------------------------------------------------------------------------
5310.4: repack to disk (lookup=false)                   296.55(256.53+14.52)
5310.5: simulated clone                                 15.64(8.88+1.39)
5310.6: simulated fetch                                 1.65(2.75+0.20)
5310.7: pack to file (bitmap)                           48.71(30.20+7.58)
5310.8: rev-list (commits)                              0.61(0.41+0.08)
5310.9: rev-list (objects)                              4.38(4.26+0.09)
5310.10: rev-list with tag negated via --not            0.07(0.02+0.04)
         --all (objects)
5310.11: rev-list with negative tag (objects)           0.05(0.01+0.03)
5310.12: rev-list count with blob:none                  0.08(0.03+0.04)
5310.13: rev-list count with blob:limit=1k              7.29(6.92+0.30)
5310.14: rev-list count with tree:0                     0.08(0.03+0.04)
5310.15: simulated partial clone                        9.45(8.12+0.41)
5310.19: repack to disk (lookup=true)                   255.92(188.13+20.47)
5310.20: simulated clone                                13.78(8.84+1.09)
5310.21: simulated fetch                                0.52(0.63+0.14)
5310.22: pack to file (bitmap)                          44.34(28.94+6.84)
5310.23: rev-list (commits)                             0.48(0.31+0.06)
5310.24: rev-list (objects)                             4.02(3.93+0.07)
5310.25: rev-list with tag negated via --not            0.04(0.00+0.03)
         --all (objects)
5310.26: rev-list with negative tag (objects)           0.04(0.00+0.03)
5310.27: rev-list count with blob:none                  0.04(0.01+0.03)
5310.28: rev-list count with blob:limit=1k              6.48(6.23+0.22)
5310.29: rev-list count with tree:0                     0.04(0.01+0.03)
5310.30: simulated partial clone                        8.30(7.21+0.36)

Test 4-15 are tested without using lookup table. Same tests are
repeated in 16-30 (using lookup table).

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 t/perf/p5310-pack-bitmaps.sh       | 66 ++++++++++++---------
 t/perf/p5326-multi-pack-bitmaps.sh | 93 ++++++++++++++++--------------
 2 files changed, 89 insertions(+), 70 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 7ad4f237bc3..1ad3c3f14c6 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -13,42 +13,52 @@ test_perf_large_repo
 # We intentionally use the deprecated pack.writebitmaps
 # config so that we can test against older versions of git.
 test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true
+	git config pack.writebitmaps true &&
+	git config pack.writeReverseIndex true
 '
 
-# we need to create the tag up front such that it is covered by the repack and
-# thus by generated bitmaps.
-test_expect_success 'create tags' '
-	git tag --message="tag pointing to HEAD" perf-tag HEAD
-'
+test_bitmap () {
+	local enabled="$1"
 
-test_perf 'repack to disk' '
-	git repack -ad
-'
+	# we need to create the tag up front such that it is covered by the repack and
+	# thus by generated bitmaps.
+	test_expect_success 'create tags' '
+		git tag --message="tag pointing to HEAD" perf-tag HEAD
+	'
 
-test_full_bitmap
+	test_expect_success "use lookup table: $enabled" '
+		git config pack.writeBitmapLookupTable '"$enabled"'
+	'
 
-test_expect_success 'create partial bitmap state' '
-	# pick a commit to represent the repo tip in the past
-	cutoff=$(git rev-list HEAD~100 -1) &&
-	orig_tip=$(git rev-parse HEAD) &&
+	test_perf "repack to disk (lookup=$enabled)" '
+		git repack -ad
+	'
 
-	# now kill off all of the refs and pretend we had
-	# just the one tip
-	rm -rf .git/logs .git/refs/* .git/packed-refs &&
-	git update-ref HEAD $cutoff &&
+	test_full_bitmap
 
-	# and then repack, which will leave us with a nice
-	# big bitmap pack of the "old" history, and all of
-	# the new history will be loose, as if it had been pushed
-	# up incrementally and exploded via unpack-objects
-	git repack -Ad &&
+	test_expect_success "create partial bitmap state (lookup=$enabled)" '
+		# pick a commit to represent the repo tip in the past
+		cutoff=$(git rev-list HEAD~100 -1) &&
+		orig_tip=$(git rev-parse HEAD) &&
 
-	# and now restore our original tip, as if the pushes
-	# had happened
-	git update-ref HEAD $orig_tip
-'
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
+}
 
-test_partial_bitmap
+test_bitmap false
+test_bitmap true
 
 test_done
diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index f2fa228f16a..c8cc68185a1 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -6,47 +6,56 @@ test_description='Tests performance using midx bitmaps'
 
 test_perf_large_repo
 
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
+}
+
+test_bitmap false
+test_bitmap true
 
 test_done
-- 
gitgitgadget


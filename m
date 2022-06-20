Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD00C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 12:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiFTMfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbiFTMd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A813D14
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g4so14452219wrh.11
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I1WccOGBcRQKSV7lB8p9fhYXV6oEGnh8EPVB1xQnH2Q=;
        b=emBK3En6Nzn8izcEx+piD65OrE7RFeO7ikZ0yi3AzspExdzkMk8AQQ1AFg4mI/SSCp
         BbKtX1CikMb0k6U17X7Fx79yRDX1rsz3nFZznBG2v4r5N3p8bIjZNBy377HuxgWvsM19
         KgdYwLt6Zv11sVnQ3RrV0cf/ysUR7xD+5F2IwsyYK59Ct2Ucvp4r5x5dYANhu9rVPcnu
         MwS+18zCz82A4FsdDf7dSHYVpE/D7o/z7NZOhAENIsvSb55GxsvqEu9cXuRbPCC47NkP
         +l9cI4Hm8MdxAORjod9ZSueG5H5XF8EgCUbFoRHr4KIw+3pS4V7BTWZ/Q+VIyDErsbNl
         sGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I1WccOGBcRQKSV7lB8p9fhYXV6oEGnh8EPVB1xQnH2Q=;
        b=FjzRjOVVqlANqzOMPT7OfcFbpgIUTZZ1TtxYqZ/ZNXZfB5Fm5Rr1aRotGepVyBdJvl
         fouUfyxFtvCLmVPtvq5o3iMF5mNqHtuQ6+05dIxCPihzEFtfn7CYxhvS2sOi3/F/U1xy
         fuVf1Ce1KKDgQUexuhuSl6n28Ijt99WqolnVtlKe28W4vP0lRbO7+8AR23fGdO2+lgO5
         GdjM5QYmBjR4tU3kk7IT8gBoq/3YF7w378ihtH8WbOgPSALLbvGg4sjDbnY5QewmoUVq
         Q4QGgXosvwm92BMdtuDAlxpyaLmGJXjfkvgl7qiidYVQZdtGeptEhzDnQLZ7VtT39RfB
         mXOA==
X-Gm-Message-State: AJIora+mw/orTksr3oGX20mG7jY6OsFcYRu9nN/SObrwaM4KwydhZs82
        nSxJN2hjXtDxdX9UBc6cRMMPakkdZkkrIA==
X-Google-Smtp-Source: AGRyM1sMXTXsv6WV1ayr35kwXLRpr7JTk8JmODzwcSQbf286GYdl/FBnSbT5/rnBgE2BFeDTuhpKGA==
X-Received: by 2002:a5d:5234:0:b0:21b:829c:3058 with SMTP id i20-20020a5d5234000000b0021b829c3058mr14292226wra.13.1655728404102;
        Mon, 20 Jun 2022 05:33:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6e91000000b0021a39f5ba3bsm12372258wrz.7.2022.06.20.05.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:33:23 -0700 (PDT)
Message-Id: <f5f725a3fe2ac0c93088c48ac520303a3df2c83d.1655728395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 12:33:14 +0000
Subject: [PATCH 6/6] bitmap-lookup-table: add performance tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Add performance tests for bitmap lookup table extension.

Mentored-by: Taylor Blau <ttaylorr@github.com>
Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 t/perf/p5310-pack-bitmaps.sh       | 60 +++++++++++++++++++-----------
 t/perf/p5326-multi-pack-bitmaps.sh | 55 +++++++++++++++++----------
 2 files changed, 73 insertions(+), 42 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 7ad4f237bc3..a8d9414de92 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -10,10 +10,11 @@ test_perf_large_repo
 # since we want to be able to compare bitmap-aware
 # git versus non-bitmap git
 #
-# We intentionally use the deprecated pack.writebitmaps
+# We intentionally use the deprecated pack.writeBitmaps
 # config so that we can test against older versions of git.
 test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true
+	git config pack.writeBitmaps true &&
+	git config pack.writeReverseIndex true
 '
 
 # we need to create the tag up front such that it is covered by the repack and
@@ -28,27 +29,42 @@ test_perf 'repack to disk' '
 
 test_full_bitmap
 
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
+test_perf 'use lookup table' '
+    git config pack.writeBitmapLookupTable true
 '
 
-test_partial_bitmap
+test_perf 'repack to disk (lookup table)' '
+    git repack -adb
+'
+
+test_full_bitmap
+
+for i in false true
+do
+	$i && lookup=" (lookup table)"
+	test_expect_success "create partial bitmap state$lookup" '
+		git config pack.writeBitmapLookupTable '"$i"' &&
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
+done
 
 test_done
diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index f2fa228f16a..9001eb4533e 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -26,27 +26,42 @@ test_expect_success 'drop pack bitmap' '
 
 test_full_bitmap
 
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
+test_expect_success 'use lookup table' '
+	git config pack.writeBitmapLookupTable true
 '
 
-test_partial_bitmap
+test_perf 'setup multi-pack-index (lookup table)' '
+	git multi-pack-index write --bitmap
+'
+
+test_full_bitmap
+
+for i in false true
+do
+	$i && lookup=" (lookup table)"
+	test_expect_success "create partial bitmap state$lookup" '
+		git config pack.writeBitmapLookupTable '"$i"' &&
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
+done
 
 test_done
-- 
gitgitgadget

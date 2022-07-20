Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5591C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiGTSjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiGTSiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:38:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466AE735B9
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so1817126wmj.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XjUJzE9yaJxw0bRYj+H2dvhx/HHTOWok2rfeh+O2nmc=;
        b=CkM8PyJWQYRd7FU91JRtzcmrAVEbmWMsIEELx4m+Jp1inK8R549aGnPKPrbC+1trOa
         nGaU6+TTLxBFqMFb0C+501s1Ux3XFE6dHLqNhhzTzDNyZ7GPb1ZC2KBeEHpKlUQaP1P1
         hn5MhQd+W3xwZaJRsA2q1zIVqnGRnhOY43NmXk5Vx3XyvA1xouk19ypQL13/8XtZ+CI4
         k2KcZ5HYI0+trrDBFrvGx2tx8KqYsl2FvE0FKNzY5b+xzjx2gc1/2tDd2jcU0eBb4QXc
         Pgc1gRDRpWeepJYzl6415MqWu82RQko2kwlOSaIkIqbA8uhORy2pTxPz8hlWKzs8morm
         bgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XjUJzE9yaJxw0bRYj+H2dvhx/HHTOWok2rfeh+O2nmc=;
        b=C9pKSSIYFrJgdwzFiJ7SMSXsy7Q3m38sk/Ku8Y5G2a8VDia1CRYNYCkT1F8vGtT07j
         ADwivy33ZCPt4KJdOMtYrWhCsjwr2TaEkvlhXXZU2aPI6I2pcCUnHeUKkYpvBETzvqru
         vxsutyKO2K26Jp0GAEN5A5PIdqRaHhq4RFV0seIFxwPMEZFZpL6ZNbNnyOPKEFytLsg4
         uCvG7T8QyXVf9vVSBgrlvpQ0ej+EizPfUFz970O1gSmCvSKL3SBjJTKaVKP6p8HKmVxW
         M8+L68lMuKaBfa53v986ToHCq1pB38vH5dd0HaoSVXo704YIf14NdbgziKToHg+2FFgF
         ZmMw==
X-Gm-Message-State: AJIora/oo5MiSdM0x2lypHabohzyRQrBo6Z0pefxd+xu4wjQIn4epMZd
        g0UNSA1POlnifjuNc/oVJgZnjEnuvkQ=
X-Google-Smtp-Source: AGRyM1tSKVxNRDJ9q6M0VzpVDPbmCDqpz2y1oN/kNs9PNtpUusVrGcyzJ+gGdqOlF6FBBtJD8SMjIw==
X-Received: by 2002:a1c:cc1a:0:b0:3a0:39b1:3408 with SMTP id h26-20020a1ccc1a000000b003a039b13408mr5006270wmb.157.1658342314127;
        Wed, 20 Jul 2022 11:38:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d45d1000000b0021e4536a948sm3748236wrs.79.2022.07.20.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:38:33 -0700 (PDT)
Message-Id: <6628001241d378c181564e6a27f7b6bc2fa5aa2e.1658342304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
        <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:38:24 +0000
Subject: [PATCH v5 6/6] bitmap-lookup-table: add performance tests for lookup
 table
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
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
5310.17: clone (partial bitmap)                         21.00(15.04+2.39)
5310.18: pack to file (partial bitmap)                  47.98(38.13+5.23)
5310.19: rev-list with tree filter (partial bitmap)     0.70(0.07+0.20)
5310.22: repack to disk (lookup=true)                   255.92(188.13+20.47)
5310.23: simulated clone                                13.78(8.84+1.09)
5310.24: simulated fetch                                0.52(0.63+0.14)
5310.25: pack to file (bitmap)                          44.34(28.94+6.84)
5310.26: rev-list (commits)                             0.48(0.31+0.06)
5310.27: rev-list (objects)                             4.02(3.93+0.07)
5310.28: rev-list with tag negated via --not            0.04(0.00+0.03)
         --all (objects)
5310.29: rev-list with negative tag (objects)           0.04(0.00+0.03)
5310.30: rev-list count with blob:none                  0.04(0.01+0.03)
5310.31: rev-list count with blob:limit=1k              6.48(6.23+0.22)
5310.32: rev-list count with tree:0                     0.04(0.01+0.03)
5310.33: simulated partial clone                        8.30(7.21+0.36)
5310.35: clone (partial bitmap)                         20.34(15.00+2.41)
5310.36: pack to file (partial bitmap)                  46.45(38.05+5.20)
5310.37: rev-list with tree filter (partial bitmap)     0.61(0.06+0.20)

Test 4-15 are tested without using lookup table. Same tests are
repeated in 16-30 (using lookup table).

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 t/perf/p5310-pack-bitmaps.sh       | 65 +++++++++++---------
 t/perf/p5326-multi-pack-bitmaps.sh | 95 +++++++++++++++++-------------
 2 files changed, 91 insertions(+), 69 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 6e8abcd5b21..adc753b6177 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -17,39 +17,50 @@ test_expect_success 'setup bitmap config' '
 	git config pack.writeReverseIndex true
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
+
+	test_partial_bitmap
+}
 
-test_partial_bitmap
+test_bitmap false
+test_bitmap true
 
 test_done
diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index f2fa228f16a..1f4c7103529 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -6,47 +6,58 @@ test_description='Tests performance using midx bitmaps'
 
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
+
+	test_partial_bitmap
+}
+
+test_bitmap false
+test_bitmap true
 
 test_done
-- 
gitgitgadget

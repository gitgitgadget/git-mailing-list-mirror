Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99215234964
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546816; cv=none; b=is08VRzq5LlBcHneBXcPwDKX/6FXVbAu80YOoJn/KeWKQMQCS/z3rCgvjzyBfnQQa6rEPFAe4SNHCPCOhq/M00nkq3gG4cYI375/d7H5GoJlFRFvGfTuI4L/kKAW0hSGt6xPuzh0uK/S9RjjU1DHZTO0ilmx9IKHvod/iIU5Wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546816; c=relaxed/simple;
	bh=yRYT7g5d7W0aDguTTZtMJhMG7i/CDJhhyIGRPeU/Vsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5EZvCVn2xcQmnONbIxbHDPaTsM0AHUpAzlBFMR3SrSyabvZFHlGOWciz5xn8ksKd/qB0k+ozpl3DP4RRIy6tjeXZGUQk22kL60Je47bVgj2rnvIc7cPXtD8GEqFvi/HxGSEJJ3CWa6ctNhJrAT9KDIMWWTxjujCYc2dtymJcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HSNk33mf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HSNk33mf"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bdec52f48dso68504947b3.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546812; x=1779151612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mCcJTYuBNvOoggES8Qq4ou3c+4Tt9Z5+NUl1ZcvoFA=;
        b=HSNk33mfNXTlzE29N9IgLjpR7gf7EQQXMmuJBXH0/AgqJZbPKkdw+WyfDdE9v6L5fx
         4v/adxLFDeDernlw5gyh5FDvAJL4w0mM7yAf8U95VaxAjO9b5gf3HkYABH3VxWxCJ+k2
         7ag7yxO7K+CtcoC3j3oXMFQlROhbOB2UyQ/x4iW77w1sgQ4t+ws9HTaCMVWz7zUfpiUz
         r0AM1Y9G88CoxqpFbtHCSdhQ4Hx0SH9mbP9ImcsLvln6g1MSIPmOoQC2KX5qqqoNOwrB
         wnI62VwNslqc7NwjSoBo5CHdQluJhjkKrsWfRimVeWJ8N5tA8VbmpU9brr42oO2C8fRn
         FNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546812; x=1779151612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mCcJTYuBNvOoggES8Qq4ou3c+4Tt9Z5+NUl1ZcvoFA=;
        b=E4Oar/hZupij6s6mSSJ5nE/oOJ+ScW+2YUPNxdKDl30B7Y5EGTBNpbZrKF2Q4C5tNt
         fM36m21VH7UdgV5K2AbJ4SOWmERg/3O8eVULnaf43tYDb3+n0LWiGqYcDVELxHW3+pXP
         sB7pswavYXuX2MZuM2quFLxFiTl6VOZbr/EzbEZSkcCF828YZNVdE41IxivPp5ZSO4/m
         vVDfe+tACnV4BPw3nPEXwevaNUxTk1N84GhyMTp92Ce9xMb2YPqEjl05mhzCx6VK8sq1
         +ExTiJLXc/4J9hbT2hg3pXEIvS8oa7piRo5p4cp2qYDvzrFFq8JHO60MCmj6Et4ZEFCe
         MKyw==
X-Gm-Message-State: AOJu0YzEsCSl9Ho87upsvxtu+L7XrP506U/hp/DEYE93OBJATLMIgZrv
	Q4nJ1gA+ujwPQ9k7a1vaPMbePE5gwvgpit6NKVEzjxHbo65Ei5ioVzJlKMyPFO8VVlCbluBfxs4
	N2U2sLIXEYg==
X-Gm-Gg: Acq92OGiBgDTQiE8pvlq5EPEWoGsapm/dRdru37Suuq/cbuzTkScVgl4aKDkHatqiJ9
	zmz8nwlMlBfV1Q6w2c16fPo5TCcZG17sDO9zhAw6h1swS9jUbTevjO7XLxjvIpM9jDC8I3RTWnC
	9xGhhSLjfQ9f1gCVbVLsnfHj7eXv0PkSa8oi4Jmpo/MT2HdjMciX8H/cqFzFK/oluIVUa7AND8y
	NSgihJIWXAE9tFLxx1hgaYw4f0ZwTF5nTBYhTEa+qWiCZ5tzuzwjkgLWojk0G6rJW0YJt2f3zkx
	EIfY35oQAtfoVBA1/aYN+nR192P45FTzV8DLrHS973JdyXbbL70OuWgeyVdpJdcXX9sUhcomSWV
	NwEZM70F3ZihZ46rRhRwjAufKljW6/7oftmUYO4KCEmY1XTgyp28U4R3jKCNKZWEOo5XlMEan8a
	ttxNj4mM0BuRuZNOUBZKSDN2Bi1bMOSKba5eVPlc8kv7CDrt70VfUEiCiegAKefJkjO8RxSK8E+
	D6OK2htqVjnqCDd1skP4rBQ2tMTdPB9x+adAjKYI+mfTMlKINoLjsBnvncEiEN/+rPpoJmAiWzg
	afBuuDSn9aU1wk8+
X-Received: by 2002:a05:690c:34c9:b0:7bd:6a98:58d3 with SMTP id 00721157ae682-7c50f7cdf32mr16773047b3.18.1778546812454;
        Mon, 11 May 2026 17:46:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6655f443sm160626147b3.19.2026.05.11.17.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:46:51 -0700 (PDT)
Date: Mon, 11 May 2026 20:46:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 2/9] t5333: demonstrate various pseudo-merge bugs
Message-ID: <d1ed4aadf7547a62f2442ee247dcfca3d8b4ca9f.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com>

Using the test helper introduced via the previous commit, add various
failing tests demonstrating bugs in the pseudo-merge implementation.

These are all marked as failing with one exception. The "sampleRate=0"
test describes a latent bug, which is only reachable through a code path
that is itself masked by a separate bug. A future commit will fix that
bug, and, in turn, cause the aforementioned test to fail. Accordingly,
that commit will mark the test as failing, and it will be re-marked as
passing in a separate commit which fixes the once-latent bug.

For the rest: the following commits will explain and fix the underlying
bugs in detail.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5333-pseudo-merge-bitmaps.sh | 198 ++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 1f7a5d82ee4..0e9638c31c3 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -462,4 +462,202 @@ test_expect_success 'use pseudo-merge in boundary traversal' '
 	)
 '
 
+test_expect_failure 'apply pseudo-merges during fill-in traversal' '
+	test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&
+	git init pseudo-merge-fill-in-traversal &&
+	(
+		cd pseudo-merge-fill-in-traversal &&
+
+		git config bitmapPseudoMerge.test.pattern refs/tags/ &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack=$(ls .git/objects/pack/pack-*.pack) &&
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 1 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
+	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
+	git init pseudo-merge-fill-in-multi &&
+	(
+		cd pseudo-merge-fill-in-multi &&
+
+		test_commit base &&
+		base=$(git rev-parse HEAD) &&
+
+		for side in left right
+		do
+			git checkout -B $side base &&
+
+			test_commit_bulk --id=$side 64 &&
+			git rev-list --no-object-names HEAD --not $base >in &&
+			while read oid
+			do
+				echo "create refs/group-$side/$oid $oid" || return 1
+			done <in | git update-ref --stdin || return 1
+		done &&
+
+		git checkout left &&
+		git merge right &&
+		git repack -ad &&
+
+		git config bitmapPseudoMerge.left.pattern "refs/group-left/" &&
+		git config bitmapPseudoMerge.left.maxMerges 1 &&
+		git config bitmapPseudoMerge.left.stableThreshold never &&
+
+		git config bitmapPseudoMerge.right.pattern "refs/group-right/" &&
+		git config bitmapPseudoMerge.right.maxMerges 1 &&
+		git config bitmapPseudoMerge.right.stableThreshold never &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+		git rev-parse "$base" >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'apply pseudo-merges with overlapping groups during fill-in' '
+	test_when_finished "rm -fr pseudo-merge-fill-in-overlap" &&
+	git init pseudo-merge-fill-in-overlap &&
+	(
+		cd pseudo-merge-fill-in-overlap &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		# Use two pseudo-merge group patterns that both match
+		# refs/tags/, so every tagged commit belongs to both
+		# groups. This exercises the extended lookup table
+		# path in apply_pseudo_merges_for_commit().
+		git config bitmapPseudoMerge.all.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.all.maxMerges 1 &&
+		git config bitmapPseudoMerge.all.stableThreshold never &&
+
+		git config bitmapPseudoMerge.tags.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.tags.maxMerges 1 &&
+		git config bitmapPseudoMerge.tags.stableThreshold never &&
+
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'pseudo-merge commits are correctly classified by date' '
+	test_when_finished "rm -fr pseudo-merge-date-classification" &&
+	git init pseudo-merge-date-classification &&
+	(
+		cd pseudo-merge-date-classification &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		# Configure two pseudo-merge groups: one that only
+		# matches "stable" refs (older than one month), and one
+		# that matches all refs. With 64 freshly-created tags
+		# (all younger than one month) the stable group should
+		# have zero pseudo-merges and the catch-all group should
+		# have one.
+		#
+		# Use GIT_TEST_DATE_NOW to align "now" (and therefore
+		# "1.month.ago") with the test_tick timestamps so that
+		# the commits are within the last month.
+		#
+		# This exercises the date-based classification in
+		# find_pseudo_merge_group_for_ref(), which requires
+		# that commits are parsed before inspecting their date.
+		git config bitmapPseudoMerge.stable.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.stable.maxMerges 64 &&
+		git config bitmapPseudoMerge.stable.stableThreshold never &&
+		git config bitmapPseudoMerge.stable.threshold 1.month.ago &&
+
+		git config bitmapPseudoMerge.all.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.all.maxMerges 1 &&
+		git config bitmapPseudoMerge.all.stableThreshold never &&
+		git config bitmapPseudoMerge.all.threshold now &&
+
+		git rev-parse HEAD~63 >in &&
+		GIT_TEST_DATE_NOW=$test_tick \
+			test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges
+	)
+'
+
+test_expect_success 'sampleRate=0 does not cause division by zero' '
+	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
+	git init pseudo-merge-sample-rate-zero &&
+	(
+		cd pseudo-merge-sample-rate-zero &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		git config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.sampleRate 0 &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in
+	)
+'
+
 test_done
-- 
2.54.0.76.g9b17dab2cf7


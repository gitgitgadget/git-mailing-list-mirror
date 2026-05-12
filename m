Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0723A984
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546827; cv=none; b=JzBrcX33X+uPq53AFojfHvGVyFWmLovu7ZKLLVubt7QVE7lKa44azCvWKLzNWz79sFSRNtEoo2ncrwshc3NqLEF7+GUHabKAUPXqmkIqjR9NE8v09ZKjW0YIi+d33wJ14h+kBCsgV8reKsVi3dsliYDK0MFFGp0ZbZmYEgj4LvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546827; c=relaxed/simple;
	bh=Kp9fka64so6JsgKoiWDC6wbfvXmQdUSKS4Vqklk16AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWs6cnci26akKBVePui9dJZOuaIWHjt295E6NGewwW4IQieQThmfktUI6Qx/k+4HwnABBYoLe70ASKDY5uLmeC64wSKuOGqLyotJlltIVRE8sV1bIMbDkx4OPKsvYs49vN8fCrgg9FdJJCNEfnYGcYUxtnlv46q34TfGKl/uHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EBavfIe+; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EBavfIe+"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651bc83e74aso5164048d50.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546825; x=1779151625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czxllPPUbWFJpqZ7vBJRIAZbVkxMXE9L3AWaG6Mwuj0=;
        b=EBavfIe+o0SlYrf0g4lvuzvGCUk1cTMJ7NQphbYx5R3MIks8qeUtHl4JVT2YJYSFvl
         k0x51olS9uEYNCnRLXUdUHSo7F7Nq+00Rw+Ytm1Sd5uamZDbwnvFtQKUq18TLqzsxuur
         2krEDRCBkkm87NruQunPyM8KHI4lVXErqLXvteirzOfqvK9Kwr/jUtFdSPw1dzat7uKI
         R5zPjNZ/acXg1wZGhThcj+tztj6Y+HvFyDtbjPApFzV6fY0RT5qGyJorJyC2Aj6cBsqV
         /H7WM1tdrQ9VaKk3gxnVLGpNYWsvqpZOrziaJ3TvvVrUfvz0Pv0QNcoYxBp0kYs0VPB5
         1fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546825; x=1779151625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czxllPPUbWFJpqZ7vBJRIAZbVkxMXE9L3AWaG6Mwuj0=;
        b=VFiOWZBeYQ+HLZrBG9YnMoaeI1aIggZfgHrT+DFVm+h9GYCpYgxvRap95u45cXjXvI
         F/MVzTXTtv0IjDQAln2kYJzlxrVbtbb+YCLDSrlJXEZF1m8Rzw73P/yAsc7w64yn3vTJ
         Dh4TfdD7I9ugpYIULhFNESsU+7JfMOdpwUha8NY/WM64xxBhAmPltNyC3ZRAcnq+9HMe
         q0BeaMBws2Rr6e73gYiUlemOwF/pINlhOViK4PP2i+ctpWylivYNkmIKb1c19wGAOSFt
         4kyifagNLfCU9KOJ4K5ui4sjycSZ08HA+cmiNFQ/rPDf7uJmVIUBDP5D91OtLNobynLe
         b5Wg==
X-Gm-Message-State: AOJu0YxZMJ1P2wIqgEI6OtGvRdnx3p0vMti622buGNNO/hVtx0Z084qy
	F1UHkpxiJwsqQ19UDU/ascAPOKQbzhp0J2goRFrZk/RYuIfHJBj67ebwJzay3cxg6sl+C95WJiB
	iT+27cjwBSA==
X-Gm-Gg: Acq92OGRU5VUfblSO14CmjZ+cUbO77ZnIm16lrbkOO9DDR/tWYr64j/q/vdWTayNlQL
	+X9q4yrwgQfhi615gcVb4VgJlg4LM8h9oX6DTB7a1eHXR1k6bXXMb/p2+Fiq9qW6XRdpBSgmL+8
	quJrik6UgJEokM0vfvEZe9XIvNUKHQulxgdMmuJol1GwAVost33rNasvcvV7XOUiurTRCl63Pmg
	b5ORUQIQ3oFrVGJLFDBLf5Nlr4HqYTjOfPJx2CYpyp4i4yorr7FYncGQKy4kDL2PEC0G+/A3BMs
	g48+1+xVS+792nMY+xtjR0GgmzO2jOCYCyb7Hb6GNZbivc7k6XLHKofODcbf2oLnv6VLUWXx5PR
	ErWvLQltHMa3nogUhxyCgRiWuWCAauSpjBw7KiAA3kOPNphnM0/wQUAciuSdU+2C+f3TmdvwRIe
	26NjLs0tknzKDE68w3cuKSisStPmG11jo2pDTJneJehiIgEqkyO9otVVSwhqr+k+NDJiUg9YH1g
	gde9l8BCKkviFDbR9sBvMEy26Y2VlA2yHNIENVpBcQWe2jyvmVaLlJpAikNBmRl9vnQybrSZ8HA
	v5AKwu536rCpB132
X-Received: by 2002:a05:690e:4287:20b0:654:63e0:d1e0 with SMTP id 956f58d0204a3-65c79dddf2fmr20273052d50.44.1778546824756;
        Mon, 11 May 2026 17:47:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96bf418bsm6254237d50.17.2026.05.11.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:47:04 -0700 (PDT)
Date: Mon, 11 May 2026 20:47:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 6/9] pack-bitmap: parse commits in
 `find_pseudo_merge_group_for_ref()`
Message-ID: <78cf7e6d80d0990f13a46515b12a6da342aa7e32.1778546804.git.me@ttaylorr.com>
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

`find_pseudo_merge_group_for_ref()` uses the commit's date to classify
it as either "stable" (older than the stable threshold) or "unstable"
(otherwise).

However, to find the relevant commit from a given OID, the function
`find_pseudo_merge_group_for_ref()` uses `lookup_commit()` which does
not parse commits.

Because an unparsed commit has its "date" set to zero, every candidate
is placed in the "stable" bucket regardless of its actual committer
timestamp. This means the `bitmapPseudoMerge.*.threshold` and
`stableThreshold` configuration options have no effect: the
stable/unstable split is always determined by comparing against zero
rather than the real commit date.

The net result is that pseudo-merge groups are partitioned by
`stableSize` instead of the intended decay-based sizing, and the
`sampleRate` knob (which only applies to the unstable path) is never
exercised.

Fix this by calling `repo_parse_commit()` after `lookup_commit()`,
bailing out of the callback if parsing fails.

The corresponding test configures two pseudo-merge groups that both
match all tags. The "stable" group uses `threshold=1.month.ago`, and the
"all" group uses `threshold=now`. The test use our custom
"GIT_TEST_DATE_NOW" environment variable by setting it to the value of
"$test_tick" to align Git's notion of "now" (and therefore
"1.month.ago") with the `test_tick` timestamps, so the commits appear to
be younger than one month: only the "all" group matches them, producing
exactly one pseudo-merge.

Without the fix every commit has `date == 0`, which satisfies `date <=
threshold` for both groups (since 0 is older than one month ago), and
the "stable" group erroneously matches as well.

Now that commits are correctly classified as "unstable", the bug
described in the test exercising the "sampleRate=0" test is reachable,
and the test is marked as failing. It will be fixed in a following
commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  |  2 ++
 t/t5333-pseudo-merge-bitmaps.sh | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 34e1da00b4e..d79e5fb649a 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -236,6 +236,8 @@ static int find_pseudo_merge_group_for_ref(const struct reference *ref, void *_d
 	c = lookup_commit(the_repository, maybe_peeled);
 	if (!c)
 		return 0;
+	if (repo_parse_commit(the_repository, c))
+		return 0;
 	if (!packlist_find(writer->to_pack, maybe_peeled))
 		return 0;
 
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 90459da5e63..0032a16606b 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -592,32 +592,34 @@ test_expect_success 'apply pseudo-merges with overlapping groups during fill-in'
 	)
 '
 
-test_expect_failure 'pseudo-merge commits are correctly classified by date' '
+test_expect_success 'pseudo-merge commits are correctly classified by date' '
 	test_when_finished "rm -fr pseudo-merge-date-classification" &&
 	git init pseudo-merge-date-classification &&
 	(
 		cd pseudo-merge-date-classification &&
 
 		test_commit_bulk 64 &&
+
 		tag_everything &&
 		git repack -ad &&
 
 		pack="$(ls .git/objects/pack/pack-*.pack)" &&
 
 		# Configure two pseudo-merge groups: one that only
-		# matches "stable" refs (older than one month), and one
-		# that matches all refs. With 64 freshly-created tags
-		# (all younger than one month) the stable group should
-		# have zero pseudo-merges and the catch-all group should
-		# have one.
+		# matches "stable" refs (older than one month), and
+		# one that matches all refs. With 64 tags whose
+		# commits are all younger than one month, the
+		# "stable" group should have zero pseudo-merges and
+		# the "all" group should have one.
 		#
 		# Use GIT_TEST_DATE_NOW to align "now" (and therefore
 		# "1.month.ago") with the test_tick timestamps so that
 		# the commits are within the last month.
 		#
-		# This exercises the date-based classification in
-		# find_pseudo_merge_group_for_ref(), which requires
-		# that commits are parsed before inspecting their date.
+		# Without parsing the commit, its date field would
+		# be zero, causing it to satisfy date <= threshold
+		# for the "stable" group as well, and both groups
+		# would produce pseudo-merges.
 		git config bitmapPseudoMerge.stable.pattern "refs/tags/" &&
 		git config bitmapPseudoMerge.stable.maxMerges 64 &&
 		git config bitmapPseudoMerge.stable.stableThreshold never &&
@@ -637,7 +639,7 @@ test_expect_failure 'pseudo-merge commits are correctly classified by date' '
 	)
 '
 
-test_expect_success 'sampleRate=0 does not cause division by zero' '
+test_expect_failure 'sampleRate=0 does not cause division by zero' '
 	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
 	git init pseudo-merge-sample-rate-zero &&
 	(
-- 
2.54.0.76.g9b17dab2cf7


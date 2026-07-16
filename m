Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC53D45E7
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198885; cv=none; b=hxuVclm2kjJZ3KwkE/N9jSeW4+hnoq4rs6zOpD3jzLFN18LMBzCKU8BTYbXz5QwmAJPDra1hr5rNzP5b2l2cwedJL8mCZ1lORWCUo0+8IyKwqj08P60qssmRvt2QCNc4BwIrY7euQpQX7V0I0zb2NQID4+z07iQ5mXsxpElsKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198885; c=relaxed/simple;
	bh=NwP1LfmB8rjiNk9W/leinJkABvZ+CGTOV3IsCMyo2UU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dTkocn9ExgczCvtcu8U5CsyYPd/JaK0Ms6C/XBXUbAYSU3KnD1sw4aJNa5dsNrFmXA61P8TWXgmus1DjirGIKVpXE2h8+6dKx8GhvjCpl1UyOrhnI1cF+iF4m3dfshxIwG0ixJGjTmuS7Us00QjZjeYBwG/M1evF2/PcNxYUUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT4NjB+B; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT4NjB+B"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-495b250b01cso2449799b6e.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198883; x=1784803683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N2pWP4TkNHrXjokrhT/6HJ4TFj8NeGYkguCzyS+9BB0=;
        b=DT4NjB+B6acYZTgT0KWHY/e+hfkvimg/tk9dnisKOjOyVatWBPFKrbAnHmmk+J/HHt
         sj2P2LouLCGorGixImS78BZZGbj4wdMsq1q3mPRoFXmF7qSoowk1vhtColT6yz08/38N
         Nb4cKbcHkYpryTFBVQJAmNll0TBvgPjDy0FLnCliKjHb+iGa/Tj7ygWn/u68f2hlDoCT
         CH7Z855ZhV/rjJlsL2iVIiRjrZ4p5p3M0pjxINTPWuELztgHOfv90yhBt/WDA0czhhgx
         EA1ug9A1QosImdRA+bIaGzZy8kIPX6GKNOlm8czNJL0MUBulQ4LP4QtcYZhDSgYFRLJm
         Fgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198883; x=1784803683;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N2pWP4TkNHrXjokrhT/6HJ4TFj8NeGYkguCzyS+9BB0=;
        b=BB+x94BEJtzeTWfCwz7BSjqThsf8nWZ0MxbI0nN/v0UsEEXvzqzvwbx9OCO1cFMNJl
         Gug+RuGbnm4Ocm9DYgzIrJqYIdR+t/xmfn6gjxAD+70ET0PpgViTR4Ak1ywe3i0NHnCd
         xVyO01l7gncTm1i5R/kLG3Ndk4JI4UT27ltZtBeO++Ta6lJsFOhU5GkUfvuBHDKFOAyz
         CEd5ZDVe12XQGrLjn3+JaneBKw0hXYiR0jyOfzY/6xPCRedO6jepBhift/BN5Z0PnHU5
         bPR6OmEJFRXoF1d4NyAUQecmdMWWOpCL1rM7hrv8bi0xHSlceQ+QnQtbJBqlLUXPp+Wt
         QVdA==
X-Gm-Message-State: AOJu0YxkFnjI/liOAbWCzZLW3/YGCt0SmFh90Wptq/Wvlz/xPOGtMvVC
	gwAbX2R6OpWVvOhfCK5ddiq6iiibDbeuqBX556By70NBNY1dmvXorpiSgzQv/Q==
X-Gm-Gg: AfdE7cmV/4vOkT8OqAxPIvcrAEPpCFL8Ta4gbaRGcfv2U/9/WaXWfO06KTGN5BfNrZr
	UGWkwvxnFEbNMiXyS0Rpfb/DMK8fRYwqgyw3sWtmxDtgVwJ/BiwH87J6y3DiE23y0x4pX2Be3Fz
	z8wtl7MEh5YzmYtXh7pyfy/D0qhy16htkcOkZfUGkbvt48VWHfldAng6IU2kQ6HpOz6h12rtEyx
	cKk815Vi/DsWa+5K84mVZm80E3+5BYxgnem0PPyoKVZveTSM8i/bZYU8AG7TNaK2rT6NmsNkWJ9
	NgH4p7R4CR5md6fdlaNyW0gtEP9LjV8IcBw7TtX6R5T6Q3UFtpQEoFvfkRhfFLz5okbFvqTNitu
	wDr6nc3e5CHg9QpzIgQEvyhRFkBB0gXy+cNLIbURIxEq7n1XA/mMLflu5DU5IQ/oTFIwzyIwuff
	CPG2JxUu+PkTDRA+UsdQ==
X-Received: by 2002:a05:6808:10ca:b0:497:ce6a:c1e3 with SMTP id 5614622812f47-4a42b00b1f7mr14953881b6e.31.1784198882745;
        Thu, 16 Jul 2026 03:48:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.165.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b01f1722sm18283863b6e.16.2026.07.16.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:48:01 -0700 (PDT)
Message-Id: <pull.2181.git.1784198879711.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 10:47:58 +0000
Subject: [PATCH] revision: fix --no-walk path filtering regression
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Peter Colberg <pcolberg@redhat.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Since dd4bc01c0a (revision: use priority queue for non-limited
streaming walks, 2026-05-27), "git rev-list --no-walk <commit>
-- <path>" ignores the path arguments and outputs all commits
regardless of whether they touch the given paths.

That commit introduced a REV_WALK_NO_WALK enum value to separate
--no-walk from the streaming walk in get_revision_1(). The new
case skips process_parents(), which is correct for not enqueuing
parents, but also skips try_to_simplify_commit() which
process_parents() calls to evaluate whether each commit touches
the given paths.

Add a call to try_to_simplify_commit() for the
REV_WALK_NO_WALK case, folding it into the existing
REV_WALK_REFLOG case which already does the same.

Add tests for --no-walk path filtering to t6017. The
"single commit, match" test is defensive and passes without
the fix, while the other two fail without it.

Reported-by: Peter Colberg <pcolberg@redhat.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    revision: fix --no-walk path filtering regression
    
    Fix for a regression reported by Peter Colberg [1] where git rev-list
    --no-walk <commit> -- <path> ignores path arguments since dd4bc01c0a.
    
    Verified against linux.git with the exact example from the report:
    
    git rev-list --topo-order v7.0..v7.1 -- drivers/gpu/drm/ |
    git rev-list --stdin --no-walk=unsorted -- ':!drivers/gpu/drm/'
    
    
    Without fix: 2026 commits (all pass through unfiltered) With fix: 146
    commits (correctly filtered)
    
    [1]
    https://lore.kernel.org/git/CAL71e4NjDTHbKR8z7pSrPpzDrX19JOTR04sArm7P=m5ivqkskA@mail.gmail.com/T/#u

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2181%2Fspkrka%2Fkk%2Fno-walk-pathspec-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2181/spkrka/kk/no-walk-pathspec-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2181

 revision.c                |  2 +-
 t/t6017-rev-list-stdin.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index ccbe2e03d1..e990e3f96b 100644
--- a/revision.c
+++ b/revision.c
@@ -4419,6 +4419,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 		switch (mode) {
 		case REV_WALK_REFLOG:
+		case REV_WALK_NO_WALK:
 			try_to_simplify_commit(revs, commit);
 			break;
 		case REV_WALK_TOPO:
@@ -4432,7 +4433,6 @@ static struct commit *get_revision_1(struct rev_info *revs)
 					    oid_to_hex(&commit->object.oid));
 			}
 			break;
-		case REV_WALK_NO_WALK:
 		case REV_WALK_LIMITED:
 			break;
 		}
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 4821b90e74..32284f1831 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -148,4 +148,22 @@ test_expect_success '--not via stdin does not influence revisions from command l
 	test_cmp expect actual
 '
 
+test_expect_success '--no-walk filters by path (single commit, match)' '
+	git rev-parse side-1 >expect &&
+	git rev-list --no-walk side-1 -- file-1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-walk filters by path (single commit, no match)' '
+	git rev-list --no-walk side-2 -- file-1 >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success '--no-walk with pathspec exclusion' '
+	git rev-parse side-3 side-2 >expect &&
+	git rev-parse side-1 side-2 side-3 >input &&
+	git rev-list --stdin --no-walk -- ":!file-1" <input >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
-- 
gitgitgadget

Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51119CCF5
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781420276; cv=none; b=ZJBRVZpw8jfIg2cZMQniCjNS24F/Dm4d6VRplJuVatIOq9iMjPyaJAJtY/ysUhAv9Kt8Uwh5uFCvGBhoqqcRogBoxNieEoSKhGErfCZ2mL4YrPBNj/+JQM2D5hLUbvf30oyYhOHfqDtNTMj4TivQjzGb+N0E997Nx5hCuxrxZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781420276; c=relaxed/simple;
	bh=KrBvZ67Jlq+i+oBQjCqHB0oe6OBFhOcre8biCf2tQog=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rMfsCAgP9txijS9k2Arekt+nbS/pszd6kbHWxOPdnTA2z9gUYedsCGZCpW6yincQzVZWcrUolLYpFaCcPljFd15rQ3V6jIjF0KpSFM4+JsAQ8CzGYCnLnGc+I/cB85uee94Qa5h7QT2nJMnkhV/NEHk3ATCootI0qCfIn7tbct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0KiaVOm; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0KiaVOm"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1384f8ee710so4292693c88.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781420274; x=1782025074; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=28XkFi86A0C3KfFkZrx6dUJGKktRYunVnguPItXBv7g=;
        b=W0KiaVOmFXvbxgmx36Nf6QeamttJN4nW2kXPhA0loD8sPQWCuS4fEA8U25SoEe+F75
         xl8bQf48NS93zBvXb2h3p9cCILS1E6EQ2gkzyV3fp3gP7s33UadCh0nHrCz/4pRGuWYT
         oqFFN2ON1fOs+aq3vWnmh7sUGIbH1MR5A/YuSkJhmYp32w7vYbNFTUUmm1r/hgxuex3S
         l0zNS4x53y2RkCew91OQ8oZVEw/il1v14KzcVijRymch0AP9d9bEnKHT9LQHNsDvy9C4
         Wt78H3gmofifMLbjRi0T7cA44446hLY35KDqGulvSxht+B0aeou58kfAHcDenmSuJT/J
         larA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781420274; x=1782025074;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28XkFi86A0C3KfFkZrx6dUJGKktRYunVnguPItXBv7g=;
        b=A1eXxZkLBJ4uRghD49Ug9XvsOzLE0G9A2HBtKB7xSqN5Ji0OG/109F0GVLC54/uigD
         zSh9j29BkhV2RkDYqGgXDKH0kCaUFW6zTXrRVVkCqpPkt0ZUpEYr/rgrxUeAt0TC57nM
         e1Ib2WXc96UkkOFdBCd9pGUL6hqHCYhrv73W5H39yi4TNDGn85TZg8TIH/4W5op4b9AN
         aHURnfIz1J+UdejjAEXdVwLqIwkrBbxl4s+LDbWTPJUIGnFCgQGX8WPh0LgT0W5SvFfz
         2YFOyQWs7iPDH6654nO+6C/D6rT3ZjCkSs3blXx3lRIh0Q9kQ6WsYQdCmgfVpb8seFQI
         IuwQ==
X-Gm-Message-State: AOJu0YyjWu3niftTE4aJm1jzzTweAUFRBQfI+XapOMCfBNBc0RG/uf3b
	XDBE/tCvhVJIlnZeZ4E+BZXkQa5XYzN11qS/FBzPeO0nka1wWtlIuJBxh0vlcA==
X-Gm-Gg: Acq92OGdC52vdnWA7WZIfU+D5IibroWF4CuAj1ix+iqclw3q7JInqm7xqNKLnMCfYm4
	jaKv62+E1ynVT92Hhmwgo82MZI85x+IqmvGk4qVnde2GwzgVHZJs3OUUf3wyjBSjO8PkZc/w23U
	Zv7CD8048HK7+ypWViFq5jJniKHc+fB1SnyeX78DlG4UFZVXs/jpjUT+xrOEIxOA6FaypFFh/x7
	T33RFPGAokD5Ov8QV4vsHltFmb1VK66fB0bkn4t+mHbvrKDFH6TKsmnUExkDEYI1GKMKnqc0Umf
	imBYMFtuxRP2keD5ao8/R9hlajuWEob47JGCo5l846JrEDKeEEJQOApsZAuz39hrly4rwu1VIBa
	CjkI0FSjEMNwr0BDvHQNE4ZYyi7DaMvScegjaTA43kbA2PnDgUVUQ7gEL2Ds0V/thZ/EwXMmg4k
	JwhiYu5FJ/tO407O+623TBCYFo
X-Received: by 2002:a05:7022:68a7:b0:136:90d9:f1f6 with SMTP id a92af1059eb24-1384bb7f102mr4949850c88.25.1781420273757;
        Sat, 13 Jun 2026 23:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.59.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm7156288c88.14.2026.06.13.23.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 23:57:52 -0700 (PDT)
Message-Id: <pull.2148.git.1781420271100.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 06:57:50 +0000
Subject: [PATCH] commit-graph: use timestamp_t for max parent generation
 accumulator
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

compute_reachable_generation_numbers() computes each commit's
generation as

    max(c->date, max(parent.generation)) + 1

by walking its parents and accumulating their generations into a
local

    uint32_t max_gen = 0;

while info->get_generation() returns timestamp_t and
compute_generation_from_max() already takes its max_gen parameter
as timestamp_t.  For v1 (topological levels) the narrowing is
harmless because GENERATION_NUMBER_V1_MAX is less than 2^30, but
for v2 (corrected committer dates) it silently truncates any
parent generation that does not fit in 32 bits, i.e. any parent
whose committer timestamp is at or beyond 2106-02-07 UTC
(>= 2^32).

The truncated max then causes child commits to end up with a
corrected committer date that matches the parent's instead of being
at least 1 higher.  The bad value gets written into the commit-graph
and causes problems later, and can be noticed by running `git
commit-graph verify`.

Widen the accumulator to timestamp_t.

This is solely an in-memory arithmetic fix with no on-disk format
change: the on-disk format already encodes timestamp_t values and
existing readers handle them unchanged.  This merely allows the code to
compute the correct value to write to disk.

The narrowing was introduced in 80c928d947c2 (commit-graph:
simplify compute_generation_numbers(), 2023-03-20), which rewired
v2 to use the shared compute_reachable_generation_numbers()
helper; the helper's local accumulator had been declared uint32_t
in the immediately preceding 368d19b0b7fa (commit-graph: refactor
compute_topological_levels(), 2023-03-20) when only v1 was using
it, where it was harmless.

Add a new test with a future-dated parent and a present-day child;
without the above fix, `git commit-graph verify` reports the
descendant's stored generation as below parent + 1.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    commit-graph: use timestamp_t for max parent generation accumulator
    
    We found a few repositories in the wild with commits whose authors were
    apparently on a computer in the year 2120 when they recorded their
    commits. Apparently, in a century from now, some folks are going to have
    a really weird timezone as well (-13068837), though the timezone doesn't
    factor into this patch at all.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2148%2Fnewren%2Fcommit-graph-fix-ccd-uint32-truncation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2148/newren/commit-graph-fix-ccd-uint32-truncation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2148

 commit-graph.c                     | 2 +-
 t/t5328-commit-graph-64bit-time.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9abe62bd5a..4b7156fd76 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1669,7 +1669,7 @@ static void compute_reachable_generation_numbers(
 			struct commit *current = list->item;
 			struct commit_list *parent;
 			int all_parents_computed = 1;
-			uint32_t max_gen = 0;
+			timestamp_t max_gen = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
 				repo_parse_commit(info->r, parent->item);
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index d8891e6a92..bc651b69de 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -74,6 +74,15 @@ test_expect_success 'single commit with generation data exceeding UINT32_MAX' '
 	git -C repo-uint32-max commit-graph verify
 '
 
+test_expect_success 'descendant of commit with date exceeding UINT32_MAX' '
+	git init repo-uint32-max-descendant &&
+	test_commit -C repo-uint32-max-descendant \
+		--date "@4294967300 +0000" future-parent &&
+	test_commit -C repo-uint32-max-descendant present-day-child &&
+	git -C repo-uint32-max-descendant commit-graph write --reachable &&
+	git -C repo-uint32-max-descendant commit-graph verify
+'
+
 test_expect_success PERL_TEST_HELPERS 'reader notices out-of-bounds generation overflow' '
 	graph=.git/objects/info/commit-graph &&
 	test_when_finished "rm -rf $graph" &&

base-commit: 600fe743028cbfb640855f659e9851522214bc0b
-- 
gitgitgadget

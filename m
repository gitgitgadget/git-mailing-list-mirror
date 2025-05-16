Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1B1A9B53
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407337; cv=none; b=EDx/YqfH5Q0EXOmRuVwfKupu+GFIC+aI/QjmMXfiv7h/ndw6ENP1uKDW232IGOtXFZr3SN5/RHZI+CZ8c1ZsREZhU/wqLEhCp7W9ezOIgnSgmuUW9yjjxjnXhGV4fe4SoGAoQx3X36q5aRpKzaHazXQcC2LU/BvhZSkHWlSdYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407337; c=relaxed/simple;
	bh=8SqWhoS+mXBDhIs7L1bhcIwSyXBA79Cak3bHSxl/5QU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GKE1MnuqCO+0mOJlytsJvPiIjLvMxL1tI8jQmPTMWgG8YqxNenAxgzlAieQdS1Qw7QO1WaH7VtB+GtmyGpJTKXtVbMf3uCEumDYwcCaVTwgXrwIfae9G/4+8taj1ocHS5CTFb+OJItu9SLZ9RpdOLsr0oyxrQnBP3illVI1JoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2FZAre1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2FZAre1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so11791475e9.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747407334; x=1748012134; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY/S2y+0QyoMc6kyodcL5r9LiaDP3bEc8vwg1PxTOGY=;
        b=M2FZAre1Se7ryiMLqL+aPxoRjJArWh2NuPqd50aaPB00R6ALgVEHu4n2i0cfIewVFh
         CqDPKEiI+zNpnnz+tzjkFfi337JOOxT+8IiZc61yOFZqQzq+x/wBAUUZheayB6CL2WxR
         4G6NsQAFKJsklnmwg8TV68zfEk+EzEUUGxf2Ij+k7i4hHXGdu3xuyUf98UzSUhHUMVGl
         0ZkVes9Ni1XNlWpULYOilH3lnlg8+goj/ZrXT4KSxWPGn3dMB9i8jfU5M069nyACDAyU
         5nSJT2Ao+5Q9bRhni2Crlh7LjA+8Q3n4g/JYnJGrRHTBcLIr9H/5xMArOVkxHKBZBX+f
         bgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407334; x=1748012134;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY/S2y+0QyoMc6kyodcL5r9LiaDP3bEc8vwg1PxTOGY=;
        b=pg7iWbf9xMUzXSkXN+9+ZbBcaKi+hy4r2bEdN0R8qPWVCL7obUcsHd6TD1jJRbBqZ3
         nScO46vMKg091ovpqJor6UbhzqMaVGSg3RPH/Nm6E46HVkHSOqxzCOZ1fAM0MCXQqpLh
         KHPzq6Zp7JSuBNNqt7HNhzyJwz+WkhcFhcbOpcKdExQvt929CtLwd91ZJUb6bchQAJ+S
         qEILGaZ9H99OcrV78Pi5K0VYZxlP/YXIpF0KzgV/ny+J4dpLvdDkJ+oZbViorPdXPBvX
         HBhY44agDX7AlRdsvKbyzS7iwulfOnhNYsLwjpU+NCud1nl55TQCstolwHjv2oTu8fPf
         u+rA==
X-Gm-Message-State: AOJu0YyUHO3LLraTkdY0jPtXCo7ZfD+7D362YIvHmg8hJR1J+uC+RL0C
	aolt+aVPOgQFb2rgdUAvEH0es3wO1OTckGvbvESzC5ZR0OnTFvC0MtdQSsVJOQ==
X-Gm-Gg: ASbGncsk8J0hCC1Z+aEixFbSD01dBuLCz4+rMIqBXh8Y2cbjVhVG1/7bEx8xEU7aE+J
	E7NFLtQcLuv0B7t5AwKAB+Ces9lWRH5r0uOemr/b0wKtm1ogmB1EilGrTWDeOaEoPtvFkMCsH46
	6aCweR0WHRhYAaXZZ2aeykV33A9OcOXr18A/2bFvHSBloEu+qDn75DJGjNUezPhhPb3nzL5PsIl
	c7QJ6fbHCy4yJFoIwKEJsVV82ysY2NOq8qCghAvykn58p+irLec7UcqiQb1+GxwpNu48dBUCjXS
	258KTXAN30MktaQczV0p8L5OuApNDGvqzTdn4XvbTg+dOJTT1SQi
X-Google-Smtp-Source: AGHT+IEG4FQbtKeK/Rhr8so1+I1IohwCLY5nFs87Ujh0eLNjGh8UVAclA/1B5Kq35Ap+bnBTGMXdzg==
X-Received: by 2002:a05:600c:1553:b0:43d:cc9:b09d with SMTP id 5b1f17b1804b1-442fd66f30cmr34881805e9.20.1747407333290;
        Fri, 16 May 2025 07:55:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3380539sm113443165e9.16.2025.05.16.07.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:55:32 -0700 (PDT)
Message-Id: <1adf81ecb2c45c2e90d9b5dcfb02c814ecce6d8d.1747407330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
	<pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 14:55:27 +0000
Subject: [PATCH v2 1/4] apply: integrate with the sparse index
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The sparse index allows storing directory entries in the index, marked
with the skip-wortkree bit and pointing to a tree object. This may be an
unexpected data shape for some implementation areas, so we are rolling
it out incrementally on a builtin-per-builtin basis.

This change enables the sparse index for 'git apply'. The main
motivation for this change is that 'git apply' is used as a child
process of 'git add -p' and expanding the sparse index for each of those
child processes can lead to significant performance issues.

The good news is that the actual index manipulation code used by 'git
apply' is already integrated with the sparse index, so the only product
change is to mark the builtin as allowing the sparse index so it isn't
inflated on read.

The more involved part of this change is around adding tests that verify
how 'git apply' behaves in a sparse-checkout environment and whether or
not the index expands in certain operations.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/apply.c                          |  7 +++-
 t/t1092-sparse-checkout-compatibility.sh | 53 ++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84f1863d3ac3..a1e20c593d09 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -12,7 +12,7 @@ static const char * const apply_usage[] = {
 int cmd_apply(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	int force_apply = 0;
 	int options = 0;
@@ -35,6 +35,11 @@ int cmd_apply(int argc,
 				   &state, &force_apply, &options,
 				   apply_usage);
 
+	if (repo) {
+		prepare_repo_settings(repo);
+		repo->settings.command_requires_full_index = 0;
+	}
+
 	if (check_apply_state(&state, force_apply))
 		exit(128);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f9b448792cb4..83353a7dbab4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1340,6 +1340,30 @@ test_expect_success 'submodule handling' '
 	grep "160000 $(git -C initial-repo rev-parse HEAD) 0	modules/sub" cache
 '
 
+test_expect_success 'git apply functionality' '
+	init_repos &&
+
+	test_all_match git checkout base &&
+
+	git -C full-checkout diff base..merge-right -- deep >patch-in-sparse &&
+	git -C full-checkout diff base..merge-right -- folder2 >patch-outside &&
+
+	# Apply a patch to a file inside the sparse definition
+	test_all_match git apply --index --stat ../patch-in-sparse &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Apply a patch to a file outside the sparse definition
+	test_sparse_match test_must_fail git apply ../patch-outside &&
+	grep "No such file or directory" sparse-checkout-err &&
+
+	# But it works with --index and --cached
+	test_all_match git apply --index --stat ../patch-outside &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git reset --hard &&
+	test_all_match git apply --cached --stat ../patch-outside &&
+	test_all_match git status --porcelain=v2
+'
+
 # When working with a sparse index, some commands will need to expand the
 # index to operate properly. If those commands also write the index back
 # to disk, they need to convert the index to sparse before writing.
@@ -2345,6 +2369,35 @@ test_expect_success 'sparse-index is not expanded: check-attr' '
 	ensure_not_expanded check-attr -a --cached -- folder1/a
 '
 
+test_expect_success 'sparse-index is not expanded: git apply' '
+	init_repos &&
+
+	git -C sparse-index checkout base &&
+	git -C full-checkout diff base..merge-right -- deep >patch-in-sparse &&
+	git -C full-checkout diff base..merge-right -- folder2 >patch-outside &&
+
+	# Apply a patch to a file inside the sparse definition
+	ensure_not_expanded apply --index --stat ../patch-in-sparse &&
+
+	# Apply a patch to a file outside the sparse definition
+	# Fails when caring about the worktree.
+	ensure_not_expanded ! apply ../patch-outside &&
+
+	# Expands when using --index.
+	ensure_expanded apply --index ../patch-outside &&
+
+	# Does not when index is partially expanded.
+	git -C sparse-index reset --hard &&
+	ensure_not_expanded apply --cached ../patch-outside &&
+
+	# Try again with a reset and collapsed index.
+	git -C sparse-index reset --hard &&
+	git -C sparse-index sparse-checkout reapply &&
+
+	# Expands when index is collapsed.
+	ensure_expanded apply --cached ../patch-outside
+'
+
 test_expect_success 'advice.sparseIndexExpanded' '
 	init_repos &&
 
-- 
gitgitgadget


Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12158EAF1
	for <git@vger.kernel.org>; Wed,  7 May 2025 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579326; cv=none; b=t5RpjFkppXguwcfwPe3Biy6D6sdZBgyqhtau+Xu0fbZuRzVcSbsYaC9CrkE7St0SuxN2ost1JefgbJeovZM4MIpak4NsYCdrDOXcWYSxRo5F9zf3FbrUXUJGosdLygEJ/Qbemw5PyV4z3SD61wW4q72ETMYlIYeEvkKQDmdVQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579326; c=relaxed/simple;
	bh=YdwCLdoE+K99fDeW6fRci/NBQx2gOKD2bWboB1ihYTQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uSacfU3dccjnVY1XiwGUEVo1c4pvJyaQyucbgXQpAhCoq+T9wfzCYqcUGW64z6/Xq7vPIPYdnmVFLjeqQAkR5G/xFK0Jd5TTo3EaeyNtavavdYXRQFoK3kHVlpq9HViZD/iA0HhV9ExWfVg/xX7mCKklhaKw87z5Cs23TSGLF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSrg/+s/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSrg/+s/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edb40f357so33128515e9.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746579323; x=1747184123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBDJIR4mobzLeqB1wSxGjEx+qfHbbt9Nd30jLpgYSVQ=;
        b=YSrg/+s/VeCZ5VYfxlVURZaA33q1SaNwKznM3qALOGIMChnkWJJsZMR0rQHFs0Sb4K
         dpUz11GxHWxO9YcCTUWPexHgjRQBdbQVU1YXPAwR2ZoqiTlBdfCdWABDmu1/YFD7bYPs
         Hmiq0ZZ/yI6KJsfJuYghfiMzUxrnBhZQC2AbIla7y9vgcRr3G/z0VYe+rYd7XQR25eHI
         tObDzcyzgWhCcJdCfqGmfvMfPp10EUjHPAVIi2OzQxhZOe/ycrPO6b03gqkGnm44WLuY
         ZimqRa9OuIqNIuqmTTX0rS1x/vkEb+BsbQTUWadL0Oie7xjF4HI9/9SOvqYOgrTroa0A
         +oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579323; x=1747184123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBDJIR4mobzLeqB1wSxGjEx+qfHbbt9Nd30jLpgYSVQ=;
        b=rb991Tq/HMWrQ9vDO2CWsi/dpCPBuaMHQ8A6DTXWvDtZslNKtJfZvW8J8XpqiRJ6Hb
         4ggCzgFfr+qTPghegLhw+gx4zv9/d3M1CUMUaCjAoUEMUPY41IBycGC/lfQLjNInqhcS
         1Ao+8e5E1hgtXRSeTfVQBlpmQvPauyKrP4FE5UXPBZFflStywkTqBYTfsasmllmwuNIB
         nGeCrP326+6R5m8HdMBPmlSDgeOv4wgwhjWxAuqj3xeixmkhcpe44RMDqd+sHyTlWfFX
         f093yMPqYi+UrZIlaKL+85R8mDe0YxTxB4t9mtyRl0EsRC8+4Ut1MTR8t3cLQvHAy6Ax
         +NIw==
X-Gm-Message-State: AOJu0YwwwdHst3bu752B1PXOU9eadpKbQvJDGJfWRqIHmCPjs4P+eLmC
	XTNlOuPTzz3CmB3DQwZUvm8eSw/5suNpDjtfrN7LgrwGw2VUD64MJdMV6g==
X-Gm-Gg: ASbGncsNh8/WAmVmAhLilUWFk008uPm7cMngwYf5X4iWtNHg9UifteYIwUnayB46do8
	xi2PC0KQbB4P8BXHXibLlEQV/UYbovS0GvxpkrHXKt3kHS1CvaIi0JyA+LcUS4aP3OIAEpZ5v96
	8+bpI26fJldFidQY+TdCYd5YwqZGlb315H9p2yE1mGZ57MiN1TFhSM9LYk0WJ/5APOoZmjpGUQq
	taf/V2kLUSa/Z14U0USQawle43CbSQ2otYe/yDbQ8QP5Qh++i7t52bip8rzAnZUafnPfZy3TvME
	t+JaW/Csuvk5b35r/OtQYXVm1o5+5CBaFPcI9h/lUA==
X-Google-Smtp-Source: AGHT+IEY2Z9JxZL/btkH0GpPr+3k/773um2FuRy6NVuO+vU4D5WcdpzMqVNuLx3x7M2EeCHCgDY/Iw==
X-Received: by 2002:a05:600c:1382:b0:440:68db:a045 with SMTP id 5b1f17b1804b1-441d44dbfc4mr6478925e9.26.1746579322592;
        Tue, 06 May 2025 17:55:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d433e9e4sm11569395e9.2.2025.05.06.17.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:55:22 -0700 (PDT)
Message-Id: <0e6e199cd19ef186fb10b192529269cafc47805a.1746579321.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 00:55:18 +0000
Subject: [PATCH 1/3] apply: integrate with the sparse index
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
 t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

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
index f9b448792cb4..ab8bd371eff3 100755
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
@@ -2345,6 +2369,28 @@ test_expect_success 'sparse-index is not expanded: check-attr' '
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
+	git -C sparse-index reset --hard &&
+
+	# Does not expand when using --cached.
+	ensure_not_expanded apply --cached ../patch-outside
+'
+
 test_expect_success 'advice.sparseIndexExpanded' '
 	init_repos &&
 
-- 
gitgitgadget


Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB77315D20
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572724; cv=none; b=TyWOUK4FKSqwj9Q6dq6vYnfqOsO9tMOgJr+Zsu8axCMX8fie5rf0AIZnIqDyH35Kej/W5W68KoWoQ7B1iSCL43Pol1d3tyUeMB+X0aqgHssw01+30sVTFHd7Ao32sHOncSt32ERpOtOXtkDLx9KKHM+tqZHpdkNuZ2aAXvpuV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572724; c=relaxed/simple;
	bh=Q/2P4LgGoxWgYrY/CreYpaAvIZNkVo2nKe2qul+zTxw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lvx53FrNfYT8hPUvrNQrNoJQZOpdUpcBTnN0dTsKItukBVvHaV4KsO7TuUlpFGhjWRNl95vZ0YeR/8WaVIgX5TtZDlD3V2+15CACLjRJ+saUNPkKd1GGIhR3ctALufhYIT+YK95phlcxVi7wPBL0FGGbtmj0etnYwpPN8bOBNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/Hdd5KY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Hdd5KY"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso440928185a.0
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766572721; x=1767177521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=f/Hdd5KYyjlrHTF7EcOO0Zsq+PW6Jl/h/WoMv2NzaPsVaTYHNXhgFKcAF1GHWGbbXF
         sQfjw/pUWXmZrDAp5ihjwK0CpCKK9JZIc3V/6Bd755mmaAwl4SrQAhaBcrMPoFExnOkv
         hmbDU5hP2eKpoNO9O035aZc+bW8qjNQx0uQS3D1qPMjU9bDqWKNnmJOC7J4l3CSNF0Jl
         /ufrhEVzBT6rY5gfUGdyDLZ5c+SX6vN1IqUqXnIcn/3b1wrOWbk/xDbDYsGuGdzBMydm
         JOk+wg+ry51uqqOFbuBR1RP8e6K8aUI1lotzgDbda8iP7QvytZdY2IyLEmfc7QyEgWpf
         M2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572721; x=1767177521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=PdNDXtYvoyCvIIGrrkWI4MDt5oVfZatgjOeKEC3r7jNQpdEMVHlSUB77K7NhUaoH/0
         2SDfBGb95ipBv5978T280rs0sJnld7aKgEkmZvUpiEbaqYJlwlYYLOPwuzhs8Rc8JayX
         ReRPM+Qh1hJXtoKLaqRqur+G0DIdGuM8GljXZId3njwUUaPYoBPZ/y6ufUN0vV99EWjy
         STDaMg3SURcrE7kz0s6tSRKLh4mO8938VQk4X6dtD3tIXJ7yuvtaIwZbrrpCF4juop+v
         T64xAReOArMLNnmQFbnw4IaMWeoNohHTglt+R4zV5K09eDWYUf5xdjOkaSreUvDopnNI
         4UqA==
X-Gm-Message-State: AOJu0Yz56juJ7laYpJ99GV921+AlAz9/6p0XkPIoShzru0Ytv4QMvm2v
	vsHsxi9i7RRe4vOHTEl30x2ZO7uk1yTO3tAe0qM+oiskyz77t2Ked6G56MTmQkoU
X-Gm-Gg: AY/fxX4spSmbFK1Dwn456KppKYs902c+uxGtE/Op1SlF51xcz5XYh6omcGjiK49mmG7
	4wGByiGPKEMZDfNb77VhfoCFIVtBqaLV/y7cbZf0LrM8MRuSsMRAJ/XcEGvEj0zXkOr+HZLgTXy
	/F3fJ/XxmSnaf9/0J8Jv9ej4Qx7FZW97GdBYcGQ0STbBkNOHq3G9n+agwBo424uhOAQfHQzOman
	UGGhdWgLHX0KpkayjvWXUwJcKabVFdePSDbutsX+z6SQQOjgX+8Ry9zftMsc2jcucNwI2iiOK8A
	Wbf/Fd0Z1ivujhXK9I2jHMHCVJ3cE9pKtagCNxuTVtTwsmrlnPCMIJpfl55z09OvRWetXb0exKo
	lMsnAQe0ZskEKL4Lf45nYcfzuI77/xHFEwnU+JJ8B69zmy6ZYRUgYvHQtxS3K3LIC1GnMNF4CKA
	bDpUiBOqV0p2IZXJ8O/b54MZo=
X-Google-Smtp-Source: AGHT+IGmFiYTXhOz3X8V5I6k7DMUuKHKmzL117CxvhDkkhPrbaPkUGaRSZxXS7+GJSAouvA6ZSofXA==
X-Received: by 2002:a05:620a:1a1f:b0:891:7008:f2e0 with SMTP id af79cd13be357-8bee670c2demr2901122385a.8.1766572720963;
        Wed, 24 Dec 2025 02:38:40 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ed98dsm1291200985a.31.2025.12.24.02.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:38:40 -0800 (PST)
Message-Id: <c9ec5d9610a024f18866683863127564d7d05a83.1766572715.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
References: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
	<pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:38:33 +0000
Subject: [PATCH v5 3/5] Use repo.settings.statusGoalBranch config for status
 comparison
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Replace hardcoded upstream/origin preference with configurable
repo.settings.statusGoalBranch setting. When unset, skip the
default branch comparison entirely.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 | 48 ++++++++++++++++-----------
 t/t6040-tracking-info.sh | 71 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 19 deletions(-)

diff --git a/remote.c b/remote.c
index f3831ef3be..edb6d374e7 100644
--- a/remote.c
+++ b/remote.c
@@ -2239,32 +2239,42 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 
 static char *get_default_remote_ref(char **full_ref_out)
 {
-	int flag;
+	const char *config_value;
 	const char *resolved;
-	static const char *remotes[] = { "upstream", "origin", NULL };
-	int i;
+	int flag;
+	struct strbuf ref_buf = STRBUF_INIT;
+	char *slash_pos;
+	char *ret = NULL;
 
-	for (i = 0; remotes[i]; i++) {
-		struct strbuf head_ref = STRBUF_INIT;
-		strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remotes[i]);
+	if (repo_config_get_value(the_repository, "repo.settings.statusGoalBranch", &config_value))
+		return NULL;
 
-		resolved = refs_resolve_ref_unsafe(
-			get_main_ref_store(the_repository),
-			head_ref.buf,
-			RESOLVE_REF_READING,
-			NULL, &flag);
+	if (!config_value || !*config_value)
+		return NULL;
 
-		strbuf_release(&head_ref);
+	slash_pos = strchr(config_value, '/');
+	if (!slash_pos || slash_pos == config_value || !slash_pos[1])
+		return NULL;
 
-		if (resolved && (flag & REF_ISSYMREF)) {
-			if (full_ref_out)
-				*full_ref_out = xstrdup(resolved);
-			return refs_shorten_unambiguous_ref(
-				get_main_ref_store(the_repository), resolved, 0);
-		}
+	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
+		    (int)(slash_pos - config_value), config_value,
+		    slash_pos + 1);
+
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		ref_buf.buf,
+		RESOLVE_REF_READING,
+		NULL, &flag);
+
+	if (resolved) {
+		if (full_ref_out)
+			*full_ref_out = xstrdup(resolved);
+		ret = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), resolved, 0);
 	}
 
-	return NULL;
+	strbuf_release(&ref_buf);
+	return ret;
 }
 
 static void format_default_branch_comparison(struct strbuf *sb,
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e2bd48f858..00dadc03e7 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -309,6 +309,7 @@ test_expect_success 'status shows ahead of both tracked branch and origin/main'
 	(
 		cd test &&
 		git checkout work >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
 		git status --long -b | head -5
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -325,6 +326,7 @@ test_expect_success 'checkout shows ahead of both tracked branch and origin/main
 	(
 		cd test &&
 		git checkout main >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
 		git checkout work 2>&1 | grep -E "(Switched|Your branch|Ahead of)" | head -3
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -364,6 +366,7 @@ test_expect_success 'status shows ahead of tracked and diverged from origin/main
 	(
 		cd test &&
 		git checkout work2 >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
 		git status --long -b | head -5
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -393,6 +396,7 @@ test_expect_success 'status shows diverged from tracked and behind origin/main'
 	(
 		cd test &&
 		git checkout work2b >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
 		git status --long -b | head -6
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -425,6 +429,7 @@ test_expect_success 'status shows behind tracked and ahead of origin/main' '
 	(
 		cd test &&
 		git checkout work3 >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
 		git status --long -b | head -5
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -450,6 +455,7 @@ test_expect_success 'status prefers upstream remote over origin for comparison'
 	(
 		cd test &&
 		git checkout work >/dev/null &&
+		git config repo.settings.statusGoalBranch upstream/main &&
 		git status --long -b | head -5
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -477,6 +483,7 @@ test_expect_success 'status shows up to date with tracked but diverged from defa
 	(
 		cd test &&
 		git checkout synced_feature >/dev/null &&
+		git config repo.settings.statusGoalBranch upstream/main &&
 		git status --long -b | head -4
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -504,6 +511,7 @@ test_expect_success 'status shows up to date with tracked but diverged from orig
 	(
 		cd test &&
 		git checkout synced_feature2 >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
 		git status --long -b | head -4
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -527,6 +535,7 @@ test_expect_success 'status shows up to date with tracked but shows default bran
 	(
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
 		git status --long -b | head -4
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -538,4 +547,66 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'status with repo.settings.statusGoalBranch unset shows no default comparison' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config --unset repo.settings.statusGoalBranch 2>/dev/null || true &&
+		git status --long -b | head -3
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with repo.settings.statusGoalBranch set uses configured branch' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/main &&
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with repo.settings.statusGoalBranch set to different remote/branch' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/feature &&
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with repo.settings.statusGoalBranch set to non-existent branch' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config repo.settings.statusGoalBranch origin/nonexistent &&
+		git status --long -b | head -3
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget


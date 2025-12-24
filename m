Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22898460
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568674; cv=none; b=JaC2UhpAXohQrk691xgTYIWZo2z17zTyUmTSyazaegcQx4WomRba1jqHliFy7avfOhoENp/N0QxP8de0W246qE4KkDCBTSoBqZg98ldSabC6jn+K0Vuro2Iiqky0IGvgROIGMxnnbnxZnBkvPSDumRfINtyL7iKVckfncNdAz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568674; c=relaxed/simple;
	bh=Q/2P4LgGoxWgYrY/CreYpaAvIZNkVo2nKe2qul+zTxw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lsog+Wfyue2uU29mGK41NgK+DRPtY1TPVPKOXhNyisGxVYmzUCVtTP9iwas6SkdsiIucI1BLeKX43HLP9R7fHgkOxboY7f/D8ERkQI9Ke+O08ncRJ0LL5H5zw1Q3OF0K53t3pY4fmtRP7JS++YzpvrbWOMR6be2r9P6JYgPhVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkKNVlXY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkKNVlXY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0833b5aeeso78364275ad.1
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766568671; x=1767173471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=BkKNVlXYm8A42UzJik8G63Hw6S8vwQ+I+TggAfj1JrtnO9mnhfuKq769qnMD30sZqq
         utqP6XHTNSh0RvggQyQ8j5rERqAvG4EbOVDZEJkJFy22oKzK6W9XLt77FU63K9lM02DP
         Q3prsXScGbOreXm648hGNYHuQJIOEQYAtM1DjoOpxkbob6ScFEXUus7AUGYlIbO5MPOB
         Ax76zHOIHI/N843O9+ZlQfhzViTM4IngK7ZBa704gk/CMfkWlwuY8eGxItQWGv9pzYBm
         /xDfb4jhzYegITanY3Qjv5WojnieRWVeQxTjMT11JAHg8fWBYLpw8Bfl8hIkWGc/peWS
         E9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766568671; x=1767173471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=UC/A6tfEcnaJ85CmwrkMXTSNE2dzbcpTnSbjdxVk2FwFKTZcxuNUoiTiZKHxWnmiiX
         urKdhQYKCrg4OPTSItJZsrthHHzhZ97ofVeuthzk4wIIx9lag/mmAT8o5cA5W42Pkmro
         7AtIihfedrLNOj8u734wzwDQKrz/ZeTakz6+LkeihyetzzPW1hxVt+JAiNTYSUNw5/mp
         ly2+V0h1iDjC8maePcymViQTqpKUBvhKgRrHpt5oX7Dcd80iBsmNRELLiB9LiASO9xkh
         Rfiuas98R3bjeIEiW7VpXLLlIjdrs26zDMp6MCNqCEjVZ+ZiXPZOOxdlIi63g5VGfSpv
         4AMw==
X-Gm-Message-State: AOJu0YxnfthSeOezamp31toXhCzAbM/ZZuf1C0Hx1p9KxWF51NCfwx4b
	cf6TKGK61NRWlgYUYQOokArDKrbxtnE61xZGSPwl0hVumr3zANjPejlQKUHuAruw
X-Gm-Gg: AY/fxX6Sbcnb9yZrK1OhacfQSuPmb0FI2AqmSuy9qA+D3Wj5F20Itpa7aLY4K79KULb
	xal3vrnoEru1LclckUWZOyceo+K1x7PUeUVawVRoOzzqh/81GxTamAaEzTqm0rCDmacaGUILIUH
	B4gJWpXCBmvnbbuTcaZSFsD2QzPOPAE2a1ZQ2jKXNw21wIIgPtVkpoWvoQ/RP9SDT5fJDYIsvDO
	yAlsmBgc9AISjciMSeH2xao+dhV6W8JiXXsJnohqhxj4q0FPECKrlCkMBwbgfb6G6ZkcFRIlGMj
	JoZ9v5guj7ox98evvdC7VKc2dFGGVowhGLOkSQPdn+Bn558TrQKkdRN0TmBvQEVf5Top77AM9m4
	I9odxb8CqCMyUjJgRU/5u4p/JFbBEidOrpm5aonBw0ghKC0rhTZJ9gzC7C5mk9ifUdm3DhxYhS9
	V3aXpeDu03Yrdl
X-Google-Smtp-Source: AGHT+IGrk+rVMYl9Npd/ExHNyAVDHWm9ITnY+yUAepV911D0XLKhKJ+SrRmEqecCC8Nl2r8dGKhjGw==
X-Received: by 2002:a05:7022:6887:b0:11b:a892:80b4 with SMTP id a92af1059eb24-121721ab83amr21812007c88.5.1766568671226;
        Wed, 24 Dec 2025 01:31:11 -0800 (PST)
Received: from [127.0.0.1] ([68.220.57.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm65977549c88.11.2025.12.24.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:31:10 -0800 (PST)
Message-Id: <c9ec5d9610a024f18866683863127564d7d05a83.1766568665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
References: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
	<pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 09:31:05 +0000
Subject: [PATCH v3 3/3] Use repo.settings.statusGoalBranch config for status
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

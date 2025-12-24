Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D0A30F939
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571596; cv=none; b=u/febFqWbSHCQ9+DkSLwFTuZ+GCXInpcdvuC+VLdAsw8UxWsydwCR9YGv2C0EdBANxHiPXVw6SqUqVZ9CBM6LVQLE5MhCxeNCrDx0BZWThZucY52MuDfeECC5tvq5HlZK/anemid3R4o71GARdFiO8C0mD8QuQf3ewSZbqU8DsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571596; c=relaxed/simple;
	bh=Q/2P4LgGoxWgYrY/CreYpaAvIZNkVo2nKe2qul+zTxw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j6r/gLxRsNIT3zYVVTApmPfa1RtlYda1VAk3+nLm7zDLgy7QuMSg2xbF4FHnpZltyZ3z0a1iTD4uxYG051hai1JTiQTxPYKr94vQi69MRuebDeeMArqtjhvG/vo2mp2rh9PRyLXgvqxZkIOXBL+JhhpZk7PwvNPnx0iFpKVkO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azNBxOaz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azNBxOaz"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so53146361cf.1
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766571592; x=1767176392; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=azNBxOaz1KKkjJzfhQzCFt2Bzfi9waghMwc4y8sbnlD26XpsPXo24uDYsiDwLc6PRL
         Pch987TnKGgZRnmP2CJalbKXW4CWHNxC6YEnNRnEU59jashjTy3Yj/eH8PGUHnqyF+d9
         vJt8x0oASa5BMCo2uheE9w55yG9vQeMcabFqveepaRqVHcfK+xuXbU+hfNpYOj7Mpdp9
         Q/MqTbLFadTKwRAML8ly6fAQboF2DGXf9RXJFtPKzfh4ZQz8mIOJmLul6TRuzDuQphSC
         JhnMM9cUcSXk5mxgxL0EcLeFGfjBRKzgSfGI2KZo1EYbVUEvrmGjoh3a1Q6SrAPo0M9e
         ki4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571592; x=1767176392;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=EMOSZkQVTsjj4szVW7QrOa1cFWC9v7aayLfMtajDtT36j1yChgWRDXRv35/fNWWPKM
         RMzaWv5pjR1HQpNDJBgtd6UgARei+LEJXqSqPFrw8K8l6zjNuBYTI6pX9pcsuNOR1aP+
         gqTvFAZQl3RYz8QwwoUhW6UR8t7/p7xrnkJ91cCZy9AcSV/UoIgrirkLT8ro24BOHQYi
         la5fi206YZ60jIJCN35pDU5xKeu5JU+2u72GMKpi+7G3GqMyyQhl9em0JyJkDSsVe23x
         gJPOCStdnkxFQeWVEMlp977IwfSHftjqKrWxTiyRtB33SReRUlkK2EcYKnLFgVzw7kbN
         3EpA==
X-Gm-Message-State: AOJu0YyV3FLOjVCBjsEyRcKB5tUVf5LL5Z+yehgZd8At930u33jFQByR
	T/7FJT086mxxidmeG/fmWHNnCsvzJPx0ShWCJY0oRjDI2kC/DiJiv8fdDpxxPg==
X-Gm-Gg: AY/fxX5M8FSo1nUHgGZcvC1IXuvFsbz2eX6svcN+QIPak5pqn25hc3ouChaMNOoduX4
	ENDVKT1yx8qQm/Z0Bf2aJStOzTfvyK0uAvqnqVunU9WwNoKWNrtyZ9rBJwS1J5yZtzGETKCvOfG
	vXgfesK6rdMOrEtLttVu0MMrxIeA8B5c28ieyVri408K93Q2SO3LgoIXfPlcI/wT1fC/j/11756
	MoUHLdAkBDQN3tjgiRa5En7oZR653LmWpTw/TX5dqqkitjknqsarsagdnQ35/KfuJ75Dmhjno8p
	wyBKm9UeFp3K5Cm6GNAj3sbgi5nzu5/N+vwOuuZn/vkYYMa7cjteDbrsvsd0Ue2m5xAT4yFNvCt
	JocUA8T9Bq6dNmWbzjdTovQODUUTQfwME1rz/ZucR6kF4GxPFMLo4FEYa8132m9MzwV3alU7Cst
	r64Gg2G0mTYehZUNPovMGbGud4
X-Google-Smtp-Source: AGHT+IHmna87jcIpjpvoIU8VcwVBQcgoySIxM1Q0KsD4A2hP/gnsklFXEltjCmYJGBap7uPA690Yow==
X-Received: by 2002:a05:622a:1352:b0:4ee:483:311f with SMTP id d75a77b69052e-4f4abd99a09mr258290541cf.54.1766571592556;
        Wed, 24 Dec 2025 02:19:52 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96ce3907sm121291206d6.18.2025.12.24.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:19:52 -0800 (PST)
Message-Id: <c9ec5d9610a024f18866683863127564d7d05a83.1766571587.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
References: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
	<pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:19:46 +0000
Subject: [PATCH v4 3/4] Use repo.settings.statusGoalBranch config for status
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


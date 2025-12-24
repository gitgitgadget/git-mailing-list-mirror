Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FF2D3A69
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619687; cv=none; b=YuwQ6Q9fsm/vvKNRd1sNk9TXmKcAHLPwtK4k5/fiLgSapUTU1ZC2yswjeWTizxTgLf8cdY/e71x8zKLlNyI6ZLgF+8czJMTkv3aL7DJUC5MpXfo+GqFuLbyFqT2n3yu2wwPs+VMx2dvtS6txl7rh7we0m0dDu3c717+ocYoiSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619687; c=relaxed/simple;
	bh=Q/2P4LgGoxWgYrY/CreYpaAvIZNkVo2nKe2qul+zTxw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m55ZWU1LPmJaOMJMxRtnllJzB/02yx4tvLLRdRfVC5Y9QmItQXtzXmvxNV0oi73IJKcMvvuGC9MCgFnxhkMA3VY3chHUi2m2Y6kP2LhuGJASpE5N0lRqRQ8GddvJCEjL/iO8/J4V6kySl9RubZf2rJb9xsksYAcMkS5cdR6CLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di26EiAB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di26EiAB"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b1e54aefc5so545552985a.1
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766619683; x=1767224483; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=di26EiABOfZ+oLwEXwSEumU4V+DkQU8W5YSuEvgZ3iV6hPua3HCTMJakCKIcEEZQW4
         R7bwXWSrSXSt3lKJCYmZTtJycioFx5uDKibYK3r3eUbWAn5AZenIYVIDNYRkzTusWYb6
         9tjWlCKGXs6tDdULVU/nhNYiBKXaFyIk6vHmuAFSc3MSWllrryk292yd/E2QKwp63IZR
         C60daXEwTEhGH+2I9aoL5kAt+yhvJsKH1UucXErNiinwY5c8RmX2ldMu4RPLMWpHyDk7
         Xh8SWufTQpazAiHPMsV6GyYdS+pfM8/EcJNUMRLoinAfyb5kmnBkE3NNuMvplEzlB2wi
         8DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766619683; x=1767224483;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHxh6LYHWT3iG2JbFInLEUDOOieEYM0H6Yen21azsto=;
        b=uOFwfib4fiAh9rO3I+qtWNdhqE2ZTG6bXVusVtFRYkzk5d3vnzDc7pkLsPJsqmqO0/
         vhFtfuWsT1Qw1xwtLHLg8tA6PNrmw/DEQ4l+AeZrCCOfaTDC0e7Jb1pA6Z6yG0AMAUHD
         wBG+v8FZ39KVKF8d+0KhTOWEUgGBc3pmitzId7xFTq2OGLpX1lxVyTZmTcp2mpvduqbg
         Tcfv2XEBX1IEvdLTwLVmhqgw6NkeBw5N8l6HtrGLVEzdOMoF9P4Q/cDy/79fWsTrlMIG
         0K1HyfyytDQxdTZkfLsKAq5yx72vCqnx/fz2B+iRxatRoAuqNt4dm6K1W8bGHyphntbm
         NQXA==
X-Gm-Message-State: AOJu0YwFmcLwA89ineVSdpujJMyRc/Qrq6bvg8LzoP4ZaHSZ8qOLJAVQ
	ScrR5EBMtvnhUENvg47nkhmzGIO1//rrMzHycjIV5GXbbKlzGuISuRR0H9bTzQ==
X-Gm-Gg: AY/fxX4i28T6/VbUJEFgzG9SPrXCmM+gy8toaN5bO/kjEfCl3nyowicN92lNjcuxf+z
	n8VTogwhKXpfqvBGAZPBEMx6/Bpn9ga90jwzHuRVVcNAFolzq/RRdK0RUFGJHMXGx43XLNV67pZ
	lhHhRMY+iPbLNe7DlnhTC12l0vqs6ANy9WA839AMIJrLRfawxllV2IcKK9PVyP+IEHfNRFjXvOT
	Z8P/JEBrtbjbchZG4Odv6z6l0UgO3MtMGRVaHFV43hXn39kpLvPDjh9bHLeMPa+XbMLAt+YllNT
	lBRSro/RKD+4yWLbRoCDjGjhKePi7ZqCQXTM/8ZXKx5FhXXPGqT8Osng4A+z5hSu+VPXti29U7D
	crjj0Uo3Fxsh7J6ti4p+9KX/CIIZzjVTDG65pBQYZh91zYycKjO6MzbZKSChZk4G2joGJw2fgts
	tqzEUHgViuf0FObBTKljllWX+z
X-Google-Smtp-Source: AGHT+IH0CEL+szhtyHBzN27L5G8VrXSVKUhPINIXShrAXndbBgvBdy5HpMSaw1BJSer/dioq7fPojw==
X-Received: by 2002:a05:620a:4509:b0:891:3606:7f3a with SMTP id af79cd13be357-8c08faa3e79mr2876386185a.45.1766619683383;
        Wed, 24 Dec 2025 15:41:23 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096a8c2ecsm1383892685a.23.2025.12.24.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:41:22 -0800 (PST)
Message-Id: <c9ec5d9610a024f18866683863127564d7d05a83.1766619672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
	<pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 23:41:09 +0000
Subject: [PATCH v6 3/6] Use repo.settings.statusGoalBranch config for status
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


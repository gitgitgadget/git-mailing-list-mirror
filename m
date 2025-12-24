Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5A2D3750
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619693; cv=none; b=TUuwU9KDOf/TiHM8GoC7iwigwS0+6GgZEpEKX5C0eNf27c9GKA+gXDPXDT/TbtDA0At5DZWJe9gyxfLfjuiaNKbERFCJMmzjZ01L/aWpJjL7MoQgI/7qVyWUyefkx2k/AKLoEnWEBRyc+9SjDnPY+yhYGTNgJ3BF52gQvJADeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619693; c=relaxed/simple;
	bh=+KdGDdzg8xZW+OgL+/jdPZ9vRSQ8bSMJqT9K/EBx5AE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PfqmPtJZds6UrZeWfIZccJuXAgJlQLjs5ZhcDfh9g6YY54RQ4X+YtS79c7rYgKnO/I1npBcDuwbYYfm40XUdddxGyKl/x4yNsg66h+9/9pDx6fhUWOAi6RT4D4oGUTQ3XD0+ujSxTT7+hyY586zgvauovFoB2XR8Jkp3llqqJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bax4W4gN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bax4W4gN"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so59818376d6.2
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 15:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766619690; x=1767224490; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV/HvnUM+uVU/3lmX+2rTmanCzc/XGXULFZkeIOmJho=;
        b=Bax4W4gNHZEZVT8ghW3kzscQZzygXqNDw5qQZrTAVURIfbqHwOuwMYsRuL31clmwD+
         TD3DYiay22KMFNn2H9XUrEc+VSg7Br46uDyo5sS46CNtEZCncoGNoxdEwFWNrrbpJP2E
         JdTGaTCmzXaQSN8SGBDYu9Zo3iXmACfhcNsSmqG6+v0/7FK2LU4/qkx3Vq/0ahLcuIXW
         BlSLHcs81/CreXlPNzkSEvp2YE95faR9PdDWJeKtRfZL3bP1luIhr/GZI9xEB2aU0B7n
         uiqgYewUyzA2ireY7OINfinkNvMWhY4gOn/fNytM4bSJEdcJkocGld7kD0rr9Q5SFXxF
         cLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766619690; x=1767224490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LV/HvnUM+uVU/3lmX+2rTmanCzc/XGXULFZkeIOmJho=;
        b=b4rVxtnbpC8yCpiMsR50cAsTnYvHGRJyKRKWxP+/Wjf/9RDN6FyW+Nc3tF8zLbDoJo
         dIQsLRoi9pBRkyeP5126Q1E4pTFb0FPCg4kPnavncw5RcLWp72c4KvYVyUzhte68xtWS
         C8gy+W7TDqPJaXrPj8F/tuqNlbJbE1HWwSx3oYH4zYxr3dZPkLmk7uIYJl5P/5pY1qKa
         Emeit472AvJBaU9Um6Q4VlJKrtaUcUD8d6T5GgKLoEaI+5RfD83z4Gpx+lEYxoMPHtyF
         GCOCCPcPf+PigwpJHUvkg12EPDJQza1QBW2i7LiL/0uRlBYzaZ10VU4gs3IbdSF0Ijnw
         yPJw==
X-Gm-Message-State: AOJu0YyJtX3jrA70mqP6Dfq+ggsMF2TBwyh3DEntrsN+nMUrd/+F+Xh/
	UA9dBg+RPiTvbceEscHhZjJ6c21zeIN9tlhe0mF+mRMWZ36cc8P9rzPPrpt6EQ==
X-Gm-Gg: AY/fxX4kti9AbRwRYPjSoNnO3PJHQK1EvkxmvRivYuao7gfVnLKXJtM5UvaLoxcsaSc
	SGKndk8O6Jug8+AUr/Zz4Fq+0WSOnB6S9QuPDtJgvmAIqMsU1CHEgqyeQhlTGXiujfViCkgtarB
	FAhklj+qH1cGsk4aL6ZsxyAW1/FDONXnDhhAo/GCLz7CN2KrFmo38NGPltnOUCpyBytn+2Z8LHv
	kJpYGzd2IW8Ag85feTxZYJgGFdR1ie4Z7+ohI61sFq4y4Lp9d9OG+LE3+Y7CW5eYs+9d7+lPfXc
	fQ5tiEsDKqhdXJ/IYxhqIyv+sQKV2Nqc2rPZA2L7o9en6wB2woC3Pl0YxHNeN8LNkEDAxyKqoAn
	vx0JxVqMuJwI/KChUHOC0OChhVelAYS8eS53R4MjxIqvO1pwQbPzNcqynaOohdaoUV7GoYTzT7X
	9Z4tQ04HZ/i+lU8g==
X-Google-Smtp-Source: AGHT+IFhYBi024rZz4iSKggpQGNWPdqNe1PyP8pSSw9oFyxbcFLI4By5jgVgF2mgiW1kErfiat5Ybw==
X-Received: by 2002:a05:6214:5702:b0:880:44ca:862a with SMTP id 6a1803df08f44-88d8166900bmr284173516d6.12.1766619690547;
        Wed, 24 Dec 2025 15:41:30 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783662sm1455096785a.5.2025.12.24.15.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:41:29 -0800 (PST)
Message-Id: <242dbbae449d769dd9e013fad142988a6fc7e414.1766619672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
	<pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 23:41:12 +0000
Subject: [PATCH v6 6/6] Change config key to status.compareBranch
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

Update from repo.settings.statusGoalBranch to follow standard
git config pattern status.compareBranch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 |  4 ++--
 t/t6040-tracking-info.sh | 34 +++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/remote.c b/remote.c
index 99c0e18df4..7e13c027b5 100644
--- a/remote.c
+++ b/remote.c
@@ -2246,7 +2246,7 @@ static char *get_goal_branch_ref(char **full_ref_out)
 	char *slash_pos;
 	char *ret = NULL;
 
-	if (repo_config_get_value(the_repository, "repo.settings.statusGoalBranch", &config_value))
+	if (repo_config_get_value(the_repository, "status.goalBranch", &config_value))
 		return NULL;
 
 	if (!config_value || !*config_value)
@@ -2254,7 +2254,7 @@ static char *get_goal_branch_ref(char **full_ref_out)
 
 	slash_pos = strchr(config_value, '/');
 	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
-		warning(_("invalid value for repo.settings.statusGoalBranch: '%s' (expected format: remote/branch)"),
+		warning(_("invalid value for status.goalBranch: '%s' (expected format: remote/branch)"),
 			config_value);
 		return NULL;
 	}
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 598dd89483..fe34ddf0ab 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -309,7 +309,7 @@ test_expect_success 'status shows ahead of both tracked branch and origin/main'
 	(
 		cd test &&
 		git checkout work >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -328,7 +328,7 @@ test_expect_success 'checkout shows ahead of both tracked branch and origin/main
 	(
 		cd test &&
 		git checkout main >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git checkout work 2>&1
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -370,7 +370,7 @@ test_expect_success 'status shows ahead of tracked and diverged from origin/main
 	(
 		cd test &&
 		git checkout work2 >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -402,7 +402,7 @@ test_expect_success 'status shows diverged from tracked and behind origin/main'
 	(
 		cd test &&
 		git checkout work2b >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -437,7 +437,7 @@ test_expect_success 'status shows behind tracked and ahead of origin/main' '
 	(
 		cd test &&
 		git checkout work3 >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -465,7 +465,7 @@ test_expect_success 'status prefers upstream remote over origin for comparison'
 	(
 		cd test &&
 		git checkout work >/dev/null &&
-		git config repo.settings.statusGoalBranch upstream/main &&
+		git config status.goalBranch upstream/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -495,7 +495,7 @@ test_expect_success 'status shows up to date with tracked but diverged from defa
 	(
 		cd test &&
 		git checkout synced_feature >/dev/null &&
-		git config repo.settings.statusGoalBranch upstream/main &&
+		git config status.goalBranch upstream/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -525,7 +525,7 @@ test_expect_success 'status shows up to date with tracked but diverged from orig
 	(
 		cd test &&
 		git checkout synced_feature2 >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -551,7 +551,7 @@ test_expect_success 'status shows up to date with tracked but shows default bran
 	(
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -565,11 +565,11 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'status with repo.settings.statusGoalBranch unset shows no default comparison' '
+test_expect_success 'status with status.goalBranch unset shows no default comparison' '
 	(
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
-		git config --unset repo.settings.statusGoalBranch 2>/dev/null || true &&
+		git config --unset status.goalBranch 2>/dev/null || true &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -581,11 +581,11 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'status with repo.settings.statusGoalBranch set uses configured branch' '
+test_expect_success 'status with status.goalBranch set uses configured branch' '
 	(
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/main &&
+		git config status.goalBranch origin/main &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -599,11 +599,11 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'status with repo.settings.statusGoalBranch set to different remote/branch' '
+test_expect_success 'status with status.goalBranch set to different remote/branch' '
 	(
 		cd test &&
 		git checkout work >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/feature &&
+		git config status.goalBranch origin/feature &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
@@ -616,11 +616,11 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'status with repo.settings.statusGoalBranch set to non-existent branch' '
+test_expect_success 'status with status.goalBranch set to non-existent branch' '
 	(
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
-		git config repo.settings.statusGoalBranch origin/nonexistent &&
+		git config status.goalBranch origin/nonexistent &&
 		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
-- 
gitgitgadget

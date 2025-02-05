Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703520C028
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725103; cv=none; b=rlg/Mga3MxI4k1zSIuRJM7cIxidjIjnAZdGW+fWHuEj+WgpvNffE/nCvu43pPG9zYHG5JtddhDl6hqjBKPAXBa9U+ilYR3YZA/og0aMlY36FGjePo/RusdynDrwlccUzRCNPsTRvzcPlScbx35bA/B+aLWRvQvWgazHJ73yC6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725103; c=relaxed/simple;
	bh=0HH1THeI/fpux0y//ZfvFjfTk+9RCZnqOgBUe315UJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1AUP90sD5iRLis0w5h6rA7isigIxJr8DMFbNQQgW9at6EYM9mlWiXLjr3T/EX9vrZwGsIVeyVom8BRWslZYFBH7bunNye9x8Pv/ydSgGGwNZ4X8b96Jvj5zzeDz64FBy+QFT1sHMHuhapicJxngFvMwzdNV4of5xekgXQco0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0MIxUa4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0MIxUa4"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467918c360aso73536981cf.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 19:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738725100; x=1739329900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DMrdxy3dX7KnwygN7qZC1OVLKXo5Xk9wV+b9S1AF2M0=;
        b=X0MIxUa4yVZyD19WxYaB2xNhbYnidjv/4g5C0YW0fGOrSNndmf+N3iUGCr7n84wKte
         SPGEunsVjzi2ERer3yB/8dV2sJzFnHFE/nsWvmPMhN3QKCIRk8lk/mH48uf9bWge96JB
         f4NT7LxAYGA5tay+b69yWQDXDyfhFuWHmpYtf7fGnQGTjbWYe9+A8X88Y4+IzQ+9jR/Z
         2GLcEX60RDpMuysmZFQL5s66z1dl3G3s9kvXAhZEgmbgfGs2pzIEHDsoMPz1NkWgj6Vj
         tJUzltn1HgPOprSOYH7MKZ9pwQ9VF+3j9MyCil20dhAWnzM18Xa4MXNNrCJGxKJFu4rz
         8d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738725100; x=1739329900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMrdxy3dX7KnwygN7qZC1OVLKXo5Xk9wV+b9S1AF2M0=;
        b=lDNxvkCCDIBYNE9nj2ZUbLqXf0p0FR2MyfFpiSEmgyqrULc6Dxl1rxkyR9szwpP2+P
         4mZW2sGyrEVlQkL/wnBOFJNtWSsm9vjbWN2Wq/w0qha6+uuZMeepisRwuTXr++545zFu
         R/eC6E5e05nCi1uzXArmmWY5FN3t/MvpsmfFcFrop8pAdwGooA6wuC3X6X6W+CQkljPd
         SOvedkRCzGFmD7BG49arcdxtXORnwDCB5TgRoAVoo8LwLFc2sFVPgJxfYMRdA2pLWHtc
         rI7sKRzDoHrPeW2Z9zs7og7xYpZhfOto5/7DWTEkPkcW7OtaJJehNeEC2fgwYeaNMUY9
         P1xg==
X-Gm-Message-State: AOJu0Yx2elvZOlsnN3tHjehuLKSO81DbLx73r8SHmleBVFi6BLFEwTaQ
	/aW4otn3EmTndQ4rr6Yr9Om5JWppSLpUSa8UmEVIRm2sP0eKE2LSfVuf6aUk
X-Gm-Gg: ASbGncv+izxLI1dVq/iXPNtoIspPQ4+5HIEL+78y/jxUfSGvBTYyho+UHE7meXkn8ym
	TU/GH4fzTeifu2d10+wbUeWgndYz9vSBGG6WyniPsNR6ITUmgH2Kp6dHXVUiMGg2seLLFI/DLhq
	yutuwh0Kc/IhetbDnxH26Ew09CnX0c0YNC7BiHmpDDNTAFUMji2aTeyTNnBtI2G/+hWLmB3E4i3
	j1VC0VBt6io84E2YfW2Jrrz0uXPJmDdaYYtA+YCgTAmiMs88U0/sfTyWAUl2RYiomQtyLlfuEZr
	MPPe9GLuzhDkYw+MGVnkUxAtjKGIonSyxF+5qu7299apwUpfkeE7SAJj
X-Google-Smtp-Source: AGHT+IGl5rF1Ns1nhWAEPIifrEuJOK7R6LLGxfIYAJR49cY/9w9dBK3ZtfuOJBhHqMR7dOYHnZEGxQ==
X-Received: by 2002:ac8:59cc:0:b0:45d:82a0:5028 with SMTP id d75a77b69052e-47028168d41mr20951671cf.1.1738725099662;
        Tue, 04 Feb 2025 19:11:39 -0800 (PST)
Received: from localhost.localdomain ([2601:5c1:8380:760:919d:4af2:9abc:5db])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf172734sm67802771cf.49.2025.02.04.19.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 19:11:38 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Alex Henrie <alexhenrie24@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
Date: Tue,  4 Feb 2025 22:06:28 -0500
Message-ID: <20250205030642.95252-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running "git pull" with the following configuration options, we
fail to merge divergent branches:

- pull.ff=only
- pull.rebase (unset)
- branch.<current_branch>.rebase=true

Yet it seems that the user intended to make rebase the default for the
current branch while using --ff-only for non-rebase pulls. Since this
case appears uncovered by existing tests, changing the behavior here
might be safe: it makes what was an error into a successful rebase.

Add a test for the behavior and make it pass: this requires knowing from
where the rebase was requested. Previous commits (e4dc25ed49 (pull:
since --ff-only overrides, handle it first, 2021-07-22), adc27d6a93
(pull: make --rebase and --no-rebase override pull.ff=only, 2021-07-22))
took care to differentiate that --rebase overrides pull.ff=only, but
don't distinguish which config setting requests the rebase. Split
config_get_rebase into 2 parts so that we know where the rebase comes
from, since we only want to allow branch-config to override pull.ff=only
(like --rebase does); pull.rebase should still be overridden by
pull.ff=only or --ff-only.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
Notes:
    - I also looked at ea1954af77 (pull: should be noop when already-up-to-date,
      2021-11-17) when trying to understand how some options override others,
      but it didnt' seem germane to the final version.
    - I think I've got the right test script, since it's the one that started
      failing before I added the "else" branch to the new code (which also
      confirms that it's necessary to preserve current behavior); the only new
      behavior should be the one mentioned by the new test.
    - A possible #leftoverbits: it would be good to document more clearly the
      interplay of --ff[-only], --rebase, pull.ff, pull.rebase, and
      branch.<name>.rebase, particularly when they override each other.
      Confusingly, branch.<name>.merge has nothing to do with whether pull will
      merge or rebase ;) lest you think I'd forgotten something that _looks_
      parallel to pull.rebase.

 builtin/pull.c               | 39 ++++++++++++++++++++++++++++--------
 t/t7601-merge-pull-config.sh |  8 ++++++++
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9c4a00620a..c30f233dcc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -326,13 +326,13 @@ static const char *config_get_ff(void)
 }
 
 /**
- * Returns the default configured value for --rebase. It first looks for the
+ * Returns the default configured value for --rebase. It looks for the
  * value of "branch.$curr_branch.rebase", where $curr_branch is the current
  * branch, and if HEAD is detached or the configuration key does not exist,
- * looks for the value of "pull.rebase". If both configuration keys do not
- * exist, returns REBASE_FALSE.
+ * considers the result unspecified. Follow up by checking
+ * config_get_rebase_pull.
  */
-static enum rebase_type config_get_rebase(int *rebase_unspecified)
+static enum rebase_type config_get_rebase_branch(int *rebase_unspecified)
 {
 	struct branch *curr_branch = branch_get("HEAD");
 	const char *value;
@@ -349,11 +349,22 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
 		free(key);
 	}
 
+	*rebase_unspecified = 1;
+	return REBASE_INVALID;
+}
+
+/*
+ * Looks for the value of "pull.rebase". If it does not exist, returns
+ * REBASE_FALSE.
+ */
+static enum rebase_type config_get_rebase_pull(int *rebase_unspecified)
+{
+	const char *value;
+
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
 	*rebase_unspecified = 1;
-
 	return REBASE_FALSE;
 }
 
@@ -1026,7 +1037,7 @@ int cmd_pull(int argc,
 		 * are relying on the next if-condition happening before
 		 * the config_get_rebase() call so that an explicit
 		 * "--rebase" can override a config setting of
-		 * pull.ff=only.
+		 * pull.ff=only. [continued…]
 		 */
 		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only")) {
 			free(opt_ff);
@@ -1034,8 +1045,20 @@ int cmd_pull(int argc,
 		}
 	}
 
-	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase(&rebase_unspecified);
+	if (opt_rebase < 0) {
+		/*
+		 * […continued] But, if the config requests rebase *for this
+		 * branch*, override --ff-only, which otherwise takes precedence
+		 * over pull.rebase=true.
+		 */
+		opt_rebase = config_get_rebase_branch(&rebase_unspecified);
+		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only")) {
+			free(opt_ff);
+			opt_ff = xstrdup("--ff");
+		} else {
+		    opt_rebase = config_get_rebase_pull(&rebase_unspecified);
+		}
+	}
 
 	if (repo_read_index_unmerged(the_repository))
 		die_resolve_conflict("pull");
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 199a1d5db3..fd99f46aad 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -113,6 +113,14 @@
 	test_grep ! "You have divergent branches" err
 '
 
+test_expect_success 'pull.rebase not set and pull.ff=only and branch.<name>.rebase=true (not-fast-forward)' '
+	git reset --hard c2 &&
+	test_config pull.ff only &&
+	git switch -c bc2 &&
+	test_config branch.bc2.rebase true &&
+	git pull . c1
+'
+
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-- 
2.47.0


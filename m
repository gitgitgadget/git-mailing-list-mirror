Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD012A149
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214222; cv=none; b=PeLU3tBYBlS8RHeRkPu/jXIxBLF4dK7nUvkY32rQDnhq/AdJsP8EUrhsNHO5W9IJj76YZF1Dc0jtwHH/bcBAQUIsJ52+G53Uye9V0No+zZw8yIUiHRfvTVFpHQihwWjN5251311oFTCf1BeNoEGAnVllLzdnk+rzJKf53dWyPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214222; c=relaxed/simple;
	bh=Ee0Q+e5DO2hcxbyNZXBH+q1uSA+yFE2Wostzwt8COjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ti/6alcecfCDAbAR5Bz8lynaiaqU1XyixuZgynk7wJJ+nAnYfEGNvMoB11A2iIhe0vjVrGI97V2EKzv3pOZ+tPoS9eXdr0M8mw6eUUcjbCQqHdG5/VsHa5l5LTSFH9paHNKxITWvk4fsqwLv56Zs5KOQKZI90YPnPne9jwH4EHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUyQ9aqM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUyQ9aqM"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dca1efad59so700059a12.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709214220; x=1709819020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJaqnqxam/eKOVo4pNx2lhsAG/d/HPP4lvt9ygHaaTY=;
        b=AUyQ9aqMqWrPVBRv4QP05ycueykCZCE1O2yv4WNH6+3qOneAj1JQNe4Dwo9uOb+svb
         p7/MBNOyem7uCjAJK/psJohCeqHbE6uK2dcg5ZT2WixAxtzJ+EzXdCmJwxdIm0sUCzMU
         3hx9gM/+mDEzzEq78ZMROaqzriDIWICLc2llVWmYRNSZBRjMrF05d2ibs1iaOn4LEIPW
         KvZXOpsEKebBvhVNyUHjxHEjiZ8dryeqs/R5uJrb6OYWt34MN86f+8J7lgzOEsICV9s8
         FBvKa3zbgLVVBv2hnjImGGxxMn130uzDkV1PgR82buK7uqlLyxKQXZh3N+63Y9Tk5/kA
         l4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214220; x=1709819020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJaqnqxam/eKOVo4pNx2lhsAG/d/HPP4lvt9ygHaaTY=;
        b=CLqbBrMCbmci1GfnTl4PIpwg6e2jPTO/fSZPAFLSTtMMSnzfGMbEdoORKN24D3f+Wu
         8+QZH2ILsAbP7bf2Oj+c1vQ6ZW99TJea2pWrr0vAhOzwTCmZoWu62M9kTGTe2eU6bsLk
         1vo1U30lOk0Q+4sGwqvnabf+81HX46OtMo+HTRjjFUNlMDNzycfxZ4AmxkzEg2OdbFr2
         6GdSvLG4diI7Q617lhSAxiOTFaVpdlsDvTpa9EeFnxnRQVKuhDztE5pjt8Zs8+HVPDay
         SgbnAbpvedrXV3js4XVihFPjnSxwLxu/A+GOIK9AF78Wfia7xhipZd7FMqdIE9IGWaFx
         YhyQ==
X-Gm-Message-State: AOJu0YxU+XbBCWyamNopqKB4kM4YH8zYuF6bnJbO7/uxQwpDm2vpdXSd
	CVdmbbbKyOP7jPDOhj+cglVJADYatKJbOq3/TmmTNL9T+Jtz8my2
X-Google-Smtp-Source: AGHT+IGXK9o5xmKUBDtWNAcjRoTDgdil3eBhMU0ldtdIQmGLrRBj0kPiIuHxWdS7ZM43bwNq4u0fUA==
X-Received: by 2002:a05:6a21:920d:b0:1a0:e234:bc78 with SMTP id tl13-20020a056a21920d00b001a0e234bc78mr3349052pzb.7.1709214220096;
        Thu, 29 Feb 2024 05:43:40 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id n4-20020a634d44000000b005cfbdf71baasm1268580pgl.47.2024.02.29.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:43:38 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: shyamthakkar001@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	johannes.schindelin@gmx.de,
	newren@gmail.com,
	christian.couder@gmail.com
Subject: [PATCH] setup: clarify TODO comment about ignoring core.bare
Date: Thu, 29 Feb 2024 19:11:15 +0530
Message-ID: <20240229134114.285393-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment suggested to heed core.bare from template config if no
command line override given. However, it was clarified by Junio that
such values are ignored by intention and does not make sense to
propagate it from template config to the repository config[1].

Therefore, remove the TODO tag and update the comment to add
additional context if such functionality is desired in the future.
Also update the relevant test cases to not expect failure and remove
one redundant testcase.

[1]: https://lore.kernel.org/git/xmqqjzonpy9l.fsf@gitster.g/

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 setup.c                  | 16 ++++++++++------
 t/t1301-shared-repo.sh   | 15 ++-------------
 t/t5606-clone-options.sh |  6 +++---
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/setup.c b/setup.c
index b69b1cbc2a..92e0c3a121 100644
--- a/setup.c
+++ b/setup.c
@@ -1997,16 +1997,20 @@ static int create_default_files(const char *template_path,
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
 	/*
-	 * TODO: heed core.bare from config file in templates if no
-	 *       command-line override given
+	 * Note: The below line simply checks the presence of worktree (the
+	 * simplification of which is given after the line) and core.bare from
+	 * config file is not taken into account when deciding if the worktree
+	 * should be created or not, even if no command line override given.
+	 * That is intentional. Therefore, if in future we want to heed
+	 * core.bare from config file, we should do it before we create any
+	 * subsequent directories for worktree or repo because until this point
+	 * they should already be created.
 	 */
 	is_bare_repository_cfg = prev_bare_repository || !work_tree;
-	/* TODO (continued):
+	/* Note (continued):
 	 *
-	 * Unfortunately, the line above is equivalent to
+	 * The line above is equivalent to
 	 *    is_bare_repository_cfg = !work_tree;
-	 * which ignores the config entirely even if no `--[no-]bare`
-	 * command line option was present.
 	 *
 	 * To see why, note that before this function, there was this call:
 	 *    prev_bare_repository = is_bare_repository()
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index b1eb5c01b8..29cf8a9661 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -52,7 +52,7 @@ test_expect_success 'shared=all' '
 	test 2 = $(git config core.sharedrepository)
 '
 
-test_expect_failure 'template can set core.bare' '
+test_expect_success 'template cannot set core.bare' '
 	test_when_finished "rm -rf subdir" &&
 	test_when_finished "rm -rf templates" &&
 	test_config core.bare true &&
@@ -60,18 +60,7 @@ test_expect_failure 'template can set core.bare' '
 	mkdir -p templates/ &&
 	cp .git/config templates/config &&
 	git init --template=templates subdir &&
-	test_path_exists subdir/HEAD
-'
-
-test_expect_success 'template can set core.bare but overridden by command line' '
-	test_when_finished "rm -rf subdir" &&
-	test_when_finished "rm -rf templates" &&
-	test_config core.bare true &&
-	umask 0022 &&
-	mkdir -p templates/ &&
-	cp .git/config templates/config &&
-	git init --no-bare --template=templates subdir &&
-	test_path_exists subdir/.git/HEAD
+	test_path_is_missing subdir/HEAD
 '
 
 test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository' '
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index a400bcca62..e93e0d0cc3 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -120,14 +120,14 @@ test_expect_success 'prefers -c config over --template config' '
 
 '
 
-test_expect_failure 'prefers --template config even for core.bare' '
+test_expect_success 'ignore --template config for core.bare' '
 
 	template="$TRASH_DIRECTORY/template-with-bare-config" &&
 	mkdir "$template" &&
 	git config --file "$template/config" core.bare true &&
 	git clone "--template=$template" parent clone-bare-config &&
-	test "$(git -C clone-bare-config config --local core.bare)" = "true" &&
-	test_path_is_file clone-bare-config/HEAD
+	test "$(git -C clone-bare-config config --local core.bare)" = "false" &&
+	test_path_is_missing clone-bare-config/HEAD
 '
 
 test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
-- 
2.44.0


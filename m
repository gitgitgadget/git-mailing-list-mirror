Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9B4C600
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565554; cv=none; b=dHyE7SFP8Hd+pTDsApKON4B0piYrAqhVVhKFRC285U0TZ6MoO916ya3NKK2BkxghmvTuWghPuACNekdxBZwj2O/MROYS57U+TrfHCeMhaqAHU3ylgWzf41uvxc9LDJq47RPs5qh9GNlAYorNW9AtoSV9Y27CuBxTeAZLbREt9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565554; c=relaxed/simple;
	bh=T7vwequKLTAPz3Z08I4XI8wK9qT48K3p4v0rMHb8koo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+UgYL5r73FhTCrzzqdrg2uWk7ee1wMPZkD/bNAvmaxCzWufGzGpjXTqbZ9nj4lPwRL6/B7zip7sWriYeuWlNo6ppIthYjlb6RACrBxTyzVCib+9kDurxZrtUSzpkgryhoXWxFZM3PyJa90OkHflds5TBjXY6+wjus9PWqr1KDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glvQzwQM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glvQzwQM"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so1676740b3a.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 07:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709565552; x=1710170352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/pS0j83tH4qL3uqnVqZqqSE07+nqFRnZFElS9FH3MI=;
        b=glvQzwQMF9Jl3FP4doBheYexH8WeQNII5PwQyzMoKiTndSyPfmvpW7egOvNJj0yUma
         9gnrFNL7O5GXtuhejaB27Zdr/sqWoQAvioMDc6dJsbMV05+aJoDSTH94Kbrz2DEeB875
         miA50aPdgQpBgqE0ElARH4Sh4lW2tZ1OXCxbNbCUPCWIJHDw60j8YbqAy3P7o+yKtv2E
         Q7Oylm7nKtC5Ol225ohZF5ImlmxVJtBMJj3XKwTp4gfReuidXVSVGyZid3bfdfhU2kZJ
         HgZxJmfyrCfwI5DS0KwKQ8IBjc7NAWxrUcJVGlf98LpVy+U28ZTMg5SB1MPSTW9VIDAy
         jH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709565552; x=1710170352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/pS0j83tH4qL3uqnVqZqqSE07+nqFRnZFElS9FH3MI=;
        b=ik+utteuUiFOEj/RaeA0U8KkqFW4+Q0HNnqNrZh8i4tPodZFTcblnkBE7gXG+TtodY
         yWp+I2RTPq0WLDgvIQhufOKCf9pAN6Ka+M9KmxQNXFsY+0Wl28HuYLGnwWMtr4Ow/Apf
         jnJ4PPTeYU7to+F+iLCzaEB3gHZ5XjcOdqod9KpNbY/ndaXjKlSHLUFLPo0fU5vLxqK3
         8s7m7d8l1Oo0crDo6t1/WIjkioy+KjzatsHVVseM0TfzuUN+Mm4jW1XmGpr9ubEncsRY
         2burYs9X0S7DsFDLDeAkYvu59sH7n+L0+6FU+7NmVZ9NUglE5V5Gg8kRNfHH12QvHV05
         9zPA==
X-Forwarded-Encrypted: i=1; AJvYcCV6iHyaXViL47hVfRp3G3GVJE31GzmFQs9ygY2KxJ79ZAWmYAoucEzRTWnLGKO/aYE+q1I4I8fEMrMaK/rXKdyPdKWX
X-Gm-Message-State: AOJu0YyESuSeMUsxe3Eoxva6Nmf3duwvKv8IX3frM1YzzYvxpbtFb/xr
	lBQeERKZ5eWNGf3uALM2ZY0eL6Y0osJKB8nVuyyIpWDcZxoFVlMd6KSUljEK
X-Google-Smtp-Source: AGHT+IFPyyZ0KiiP1TDWW6DxTsQ69hPjBgBx2M+6eXcFzk4aQR9QmfXdJYjifOVOm8wOembrXn6cKA==
X-Received: by 2002:aa7:9dc4:0:b0:6e4:68fa:f1f9 with SMTP id g4-20020aa79dc4000000b006e468faf1f9mr10070218pfq.2.1709565550541;
        Mon, 04 Mar 2024 07:19:10 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id fn24-20020a056a002fd800b006e4d42e218csm7347195pfb.41.2024.03.04.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:19:10 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: shyamthakkar001@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	johannes.schindelin@gmx.de,
	newren@gmail.com
Subject: [PATCH v2] setup: remove unnecessary variable
Date: Mon,  4 Mar 2024 20:48:11 +0530
Message-ID: <20240304151811.511780-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229134114.285393-2-shyamthakkar001@gmail.com>
References: <20240229134114.285393-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO comment suggested to heed core.bare from template config file
if no command line override given. And the prev_bare_repository
variable seems to have been placed for this sole purpose as it is not
used anywhere else.

However, it was clarified by Junio [1] that such values (including
core.bare) are ignored intentionally and does not make sense to
propagate them from template config to repository config. Also, the
directories for the worktree and repository are already created, and
therefore the bare/non-bare decision has already been made, by the
point we reach the codepath where the TODO comment is placed.
Therefore, prev_bare_repository does not have a usecase with/without
supporting core.bare from template. And the removal of
prev_bare_repository is safe as proved by the later part of the
comment:

    "Unfortunately, the line above is equivalent to
        is_bare_repository_cfg = !work_tree;
    which ignores the config entirely even if no `--[no-]bare`
    command line option was present.

    To see why, note that before this function, there was this call:
        prev_bare_repository = is_bare_repository()
    expanding the right hand side:
        = is_bare_repository_cfg && !get_git_work_tree()
        = is_bare_repository_cfg && !work_tree
    note that the last simplification above is valid because nothing
    calls repo_init() or set_git_work_tree() between any of the
    relevant calls in the code, and thus the !get_git_work_tree()
    calls will return the same result each time.  So, what we are
    interested in computing is the right hand side of the line of
    code just above this comment:
        prev_bare_repository || !work_tree
        = is_bare_repository_cfg && !work_tree || !work_tree
        = !work_tree
    because "A && !B || !B == !B" for all boolean values of A & B."

Therefore, remove the TODO comment and remove prev_bare_repository
variable. Also, update relevant testcases and remove one redundant
testcase.

[1]: https://lore.kernel.org/git/xmqqjzonpy9l.fsf@gitster.g/

Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 setup.c                  | 36 +++---------------------------------
 t/t1301-shared-repo.sh   | 15 ++-------------
 t/t5606-clone-options.sh |  6 +++---
 3 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/setup.c b/setup.c
index b69b1cbc2a..81accd1213 100644
--- a/setup.c
+++ b/setup.c
@@ -1961,7 +1961,6 @@ void create_reference_database(unsigned int ref_storage_format,
 static int create_default_files(const char *template_path,
 				const char *original_git_dir,
 				const struct repository_format *fmt,
-				int prev_bare_repository,
 				int init_shared_repository)
 {
 	struct stat st1;
@@ -1996,34 +1995,8 @@ static int create_default_files(const char *template_path,
 	 */
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
-	/*
-	 * TODO: heed core.bare from config file in templates if no
-	 *       command-line override given
-	 */
-	is_bare_repository_cfg = prev_bare_repository || !work_tree;
-	/* TODO (continued):
-	 *
-	 * Unfortunately, the line above is equivalent to
-	 *    is_bare_repository_cfg = !work_tree;
-	 * which ignores the config entirely even if no `--[no-]bare`
-	 * command line option was present.
-	 *
-	 * To see why, note that before this function, there was this call:
-	 *    prev_bare_repository = is_bare_repository()
-	 * expanding the right hand side:
-	 *                 = is_bare_repository_cfg && !get_git_work_tree()
-	 *                 = is_bare_repository_cfg && !work_tree
-	 * note that the last simplification above is valid because nothing
-	 * calls repo_init() or set_git_work_tree() between any of the
-	 * relevant calls in the code, and thus the !get_git_work_tree()
-	 * calls will return the same result each time.  So, what we are
-	 * interested in computing is the right hand side of the line of
-	 * code just above this comment:
-	 *     prev_bare_repository || !work_tree
-	 *        = is_bare_repository_cfg && !work_tree || !work_tree
-	 *        = !work_tree
-	 * because "A && !B || !B == !B" for all boolean values of A & B.
-	 */
+
+	is_bare_repository_cfg = !work_tree;
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -2175,7 +2148,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	int prev_bare_repository;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2201,7 +2173,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	safe_create_dir(git_dir, 0);
 
-	prev_bare_repository = is_bare_repository();
 
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
@@ -2214,8 +2185,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	validate_ref_storage_format(&repo_fmt, ref_storage_format);
 
 	reinit = create_default_files(template_dir, original_git_dir,
-				      &repo_fmt, prev_bare_repository,
-				      init_shared_repository);
+				      &repo_fmt, init_shared_repository);
 
 	/*
 	 * Now that we have set up both the hash algorithm and the ref storage
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


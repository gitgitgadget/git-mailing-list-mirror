Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A520B818
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299187; cv=none; b=QHHazdUDMqggOMmDKvoMIEJK3eNBUhrnexhlbZ18h24lDyRk3kFEXZUsthOD1ob6G11JMFEOnNoFj8fT/E4C2zCG3WrE8lf5S1htRMwuF4B+LsAXU6s/UUTyjzJ1rDmHmiYk4MCYr1xD2XaTUmSsgiH+x8BEGGdCeuIJQMDXIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299187; c=relaxed/simple;
	bh=TG99l56WB7uG4AXm/m6Glul8x/2FBo3QBSFbry78VAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtWp76kXThemHvaBG2bBlfT6KVmJmoo78pPpuflbLCjgUfRZbiYU3/4131p3vYh5zuR5Z4f5YNdXGzTGSLFyeK9NF3KrJ5p4cBNfpYKStF/qHbOYtvkfAIXEtg+E3NpnUgeuS2yncApEgMIItH0yKLV9Mx7Aq5Gi/HswLg+VBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGk2Jlsn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGk2Jlsn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2260c915749so30132005ad.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299185; x=1742903985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZagCCvp4BrHRFQq8PkN50cz/wHDlWnYErUpQ8WNHbY=;
        b=KGk2JlsnnvYYgt3FtMPKGiH4zYCXwU8UqL2bl7CVOocHmGl1OFa7Gn5U/ccUDnbro+
         x7ztkrIBcM5/n3t8YDrKsSbfMX4Jw9zDdi/8nLf8yQO03CPCEtgJnhpXlILx1vayj2Wq
         SHnBGuFHJEHJKuX5yp81PoY6Bsxrq1jNt5eD1LjtT9yzQ8esWr1Xqyz7wwemTrPZq2XY
         TIMKqoApqemHmmEy10/EW9q+GZQkEqkR6w+dQxrGFVdEldx9Q2uT/r7y9kqgmQk3jpII
         LNF4ucJGjfi1Od8TM1nkjHJzOfFIkAaFPwIfkcu/ncreLuMLV71TgzPNrw+WmFWaHpR4
         E+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299185; x=1742903985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZagCCvp4BrHRFQq8PkN50cz/wHDlWnYErUpQ8WNHbY=;
        b=s+XUxQIbClDT+Ne8o20lTiW7eVkdP6YKDXcC4ExTl63MzTqaGldpAFm+Yqnuuxa+GH
         aVOGk/7q0fo7Pn2VQtBiZGzSwcmPhK86DlhZbV7KC5sZEhSZOAKoV+3WS6L3yfrq1AVw
         0DxZjk98PtdbkEVMBoE9K6siurhtjN1gvdTZrOkPh4mZFYcoMm2bB2Yz6cllWygaiKkz
         KCHwGlUbhbvvgIfHAkXgz4b6+Xbgl1hBkKGH+V5ABdCTvUo5AUK3THrQS64mwkjVbSY/
         PYiY2OHCPgg2LjrkeJKB3C/gm20vkJf4Zg7qFVQThBbPqv6X6iD4goeR/X5aW85CdA1M
         RU7Q==
X-Gm-Message-State: AOJu0Yz7NH5xPQyBgIXRATK4a+d9RHnAx+75b5hGzAQxJnlfkSns3zV1
	jR7BnFlnbiYJ0wIUBN7ZBiTS517S5G6vyuBGL84Mv1CY7yWmjMWb6vzUQSwj
X-Gm-Gg: ASbGncss0M5k5h8JZaCnIClwVKFg9UMqquYE4JAqv3lv3S/+UjTIFRC8cjt/2AdEXd2
	4g2Ky7ASq3oaaWM2J2SBaKoUncbCcx4mFT6QGjmpsrKesHaFakUv1mELCLcQSGsKpLHhjzWxuE7
	X95vetCee/MxzAv0i/W1BjtaH3qDx4lQtimc2Z9ObwSaKvbFRo7pPn7+mNOvHCFMz/xazDnkt36
	isCWTPpdVeXbL7/nUjSMKQLAiSCsNGueiGTOcTTmoRWGBEszvogObETcLLx2xNsUcgxaGhej3Gw
	Y+zYYUnQ8FPEB96iq0r+qZ+g5eiArIBGi1iPXU/ESwbSTu7PFnsTy+UNvMpiLpwNM4xmGA==
X-Google-Smtp-Source: AGHT+IG+oLRNo7EyXmaQmxRZK4MvTz/0DjxU01mmN/to+gXfwyA7Z2YEjiWD1q8NULW36yrOXsym3g==
X-Received: by 2002:a17:902:f648:b0:220:d257:cdbd with SMTP id d9443c01a7336-225e0b2738emr249803455ad.48.1742299184653;
        Tue, 18 Mar 2025 04:59:44 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:44 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/9] builtin/checkout-index: stop using `the_repository`
Date: Tue, 18 Mar 2025 17:29:00 +0530
Message-ID: <20250318115912.2978992-9-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/checkout-index.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_checkout_index()` function with `repo`
set to NULL and then early in the function, `show_usage_with_options_if_asked()`
call will give the options help and exit.

Pass an instance of "struct index_state" available in the calling
context to both `checkout_all()` and `checkout_file()` to remove their
dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/checkout-index.c        | 43 ++++++++++++++++-----------------
 t/t2006-checkout-index-basic.sh |  7 ++++++
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index e30086c7d4..7f74bc702f 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -5,7 +5,6 @@
  *
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -68,10 +67,10 @@ static void write_tempfile_record(const char *name, const char *prefix)
 	}
 }
 
-static int checkout_file(const char *name, const char *prefix)
+static int checkout_file(struct index_state *index, const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
-	int pos = index_name_pos(the_repository->index, name, namelen);
+	int pos = index_name_pos(index, name, namelen);
 	int has_same_name = 0;
 	int is_file = 0;
 	int is_skipped = 1;
@@ -81,8 +80,8 @@ static int checkout_file(const char *name, const char *prefix)
 	if (pos < 0)
 		pos = -pos - 1;
 
-	while (pos <the_repository->index->cache_nr) {
-		struct cache_entry *ce =the_repository->index->cache[pos];
+	while (pos < index->cache_nr) {
+		struct cache_entry *ce = index->cache[pos];
 		if (ce_namelen(ce) != namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
@@ -137,13 +136,13 @@ static int checkout_file(const char *name, const char *prefix)
 	return -1;
 }
 
-static int checkout_all(const char *prefix, int prefix_length)
+static int checkout_all(struct index_state *index, const char *prefix, int prefix_length)
 {
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	for (i = 0; i < the_repository->index->cache_nr ; i++) {
-		struct cache_entry *ce = the_repository->index->cache[i];
+	for (i = 0; i < index->cache_nr ; i++) {
+		struct cache_entry *ce = index->cache[i];
 
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
 			if (!ce_skip_worktree(ce))
@@ -156,8 +155,8 @@ static int checkout_all(const char *prefix, int prefix_length)
 			 * first entry inside the expanded sparse directory).
 			 */
 			if (ignore_skip_worktree) {
-				ensure_full_index(the_repository->index);
-				ce = the_repository->index->cache[i];
+				ensure_full_index(index);
+				ce = index->cache[i];
 			}
 		}
 
@@ -213,7 +212,7 @@ static int option_parse_stage(const struct option *opt,
 int cmd_checkout_index(int argc,
 		       const char **argv,
 		       const char *prefix,
-		       struct repository *repo UNUSED)
+		       struct repository *repo)
 {
 	int i;
 	struct lock_file lock_file = LOCK_INIT;
@@ -253,19 +252,19 @@ int cmd_checkout_index(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_checkout_index_usage,
 					 builtin_checkout_index_options);
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
-	if (repo_read_index(the_repository) < 0) {
+	if (repo_read_index(repo) < 0) {
 		die("invalid cache");
 	}
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
-	state.istate = the_repository->index;
+	state.istate = repo->index;
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
@@ -285,8 +284,8 @@ int cmd_checkout_index(int argc,
 	 */
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
-		state.istate = the_repository->index;
-		repo_hold_locked_index(the_repository, &lock_file,
+		state.istate = repo->index;
+		repo_hold_locked_index(repo, &lock_file,
 				       LOCK_DIE_ON_ERROR);
 	}
 
@@ -304,7 +303,7 @@ int cmd_checkout_index(int argc,
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
-		err |= checkout_file(p, prefix);
+		err |= checkout_file(repo->index, p, prefix);
 		free(p);
 	}
 
@@ -326,7 +325,7 @@ int cmd_checkout_index(int argc,
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			err |= checkout_file(p, prefix);
+			err |= checkout_file(repo->index, p, prefix);
 			free(p);
 		}
 		strbuf_release(&unquoted);
@@ -334,7 +333,7 @@ int cmd_checkout_index(int argc,
 	}
 
 	if (all)
-		err |= checkout_all(prefix, prefix_length);
+		err |= checkout_all(repo->index, prefix, prefix_length);
 
 	if (pc_workers > 1)
 		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
@@ -344,7 +343,7 @@ int cmd_checkout_index(int argc,
 		return 1;
 
 	if (is_lock_file_locked(&lock_file) &&
-	    write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
+	    write_locked_index(repo->index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
 }
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index bac231b167..fedd2cc097 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -21,6 +21,13 @@ test_expect_success 'checkout-index -h in broken repository' '
 	test_grep "[Uu]sage" broken/usage
 '
 
+test_expect_success 'checkout-index does not crash with -h' '
+	test_expect_code 129 git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage &&
+	test_expect_code 129 nongit git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage
+'
+
 test_expect_success 'checkout-index reports errors (cmdline)' '
 	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
 	test_grep not.in.the.cache stderr
-- 
2.48.1


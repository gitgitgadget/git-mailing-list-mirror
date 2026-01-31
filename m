Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3537AA62
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895808; cv=none; b=Ydush9EtoEjSx2K7qFb3+aU6a3ciAdeFZiSNgEBInTNU9kuYs1zz+HpMZmRRXf4pf2t+yETNtJPwlnQyO8QWkaZYgVaxkHpZYa/8GMD4UEJgulWvzCkXZYlMo5m0J+iDYCqS5s46sufILVmeV4f69yszM117J6MAZSGcFpkVjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895808; c=relaxed/simple;
	bh=LAE07J1DiX/Ipr3lHCeozdevW603PfL1tl0K16bjkHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buBBW7sVXOINDpdwrJWG/9FdLfrWkUYNs+HJEzTBcCI0J+p1p0BFyu23pPhNi370onPMAEQywaiaVS1G3eqPQ/6EfzuOTsmu/vhirpNn+AqmOwgrxD3vEiGWGG08uwy1usq3AAjOvHfF7ir02lW/uS8Q4r+zD3Wxy42B865kjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlTYjUBR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlTYjUBR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c5265d06c3so445521985a.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769895801; x=1770500601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn3z7IBrrtId4sgnaHx3cbXXJrcdDWmJXGUO8Tibhl0=;
        b=FlTYjUBRQ/xA27MZRFDm/gGZrmX3wrLSvGz7XxdJh76D9GQNHiItzHxn6x6FoNzaX3
         vPOVVioaumFZrF4XFFFp5P4MYeTqbdyjsgb7AJlGvFXfivdjj4kt6QWhkF0xRDMhramF
         ICqmveF811KD3TzneAcb5e5+JARYh2stUJJE7Q87GTLa239K0NDYEgyPYwnkU9Nedjvz
         +EPda7CtvstSrpqAtJm9pTNzWqF14p2W9k1bgES/ef2cwzX3D+qjRZzbH2ZrleHgMOyR
         KtrvKXXDcuCHrsLxlXWGGMUrwGZY5SgI38VMJPJN0aL+8STwnsWciknmz7asLTMOr9FV
         TG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769895801; x=1770500601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cn3z7IBrrtId4sgnaHx3cbXXJrcdDWmJXGUO8Tibhl0=;
        b=mqZ4mhDgLFp6+4MKXvwToieH04UEgEszztS0jy5ecaEajinwC71iCEGiBCUoWjp2z/
         Y2KWoW1aymUAbMfNH0HyFlYkpSu+utE5EoiuIjkVH3p4Hbgfzg4TzGF1fH4jP7TWbgTj
         UnIZ83zLIqHllb9h9sYnb87MIribWZAmkeaI5U0zYD+Io10YvMwIErJ8M19Pwy3YStyR
         SyF+LfSlvdqGaeIZnRcf8flvThA48TQ88MC3UvN1+QEMwy0WeSrhTufMhDnfYFOK2BVs
         iKkZ8T4oE3yUieZXdWI+1nsOFK8QySpf9vK7bMy6NaCe3KeT65prsRjSskNjO3ugU0CL
         eiSQ==
X-Gm-Message-State: AOJu0YwmuxkWsmVb4mMCl9AvEBHQdaRXc2+B0930O7kuAWky0XBE3LFt
	RD75M2OTf1ygZ7mlr8mulByuTp17ZDfIfke1760xdV1DLchSrbuL3eK7Ju5IpauT
X-Gm-Gg: AZuq6aJrGEawBml4FVFoYGCR04lBysIHXBZ7j1wQq/k8pA+xWK0YULV5LStxwPOLoT/
	Mmr661qXdNuDQbCE1muha4GsdiCnmvShB8h9RewKNd+Dz79fKQT2Bkr8+hey2dXIEqgWwJONzlT
	1OqP6CQQKSoj2KJ820u7s1De+NhUeuyLv/LP1Eftg2Q02cJHBCSSAc3OaB7g0YiHFZJH6LN8APe
	ihg12JXzAC8BDfCb6knryxesVaoK9AEwF12R1hZIZEowcQ4LdPhj9TEO5DPf2Ld3HKl7sCp+WE+
	UwVGjuKTEHAMGvBMyFWRSvE9NkgvgQ75Nj8oRmKkZHR/CdfgaV7Fd79DPlDjFu56TD/Io4bSbtQ
	Aiuhl1WGV5o4TKwD4YG/bPTT86hjZ/vFX5ubDcU/l4+0lLneLhbwvwr8i7KPfOXYGhazQDlVn+7
	QqAnt2QyelnJs=
X-Received: by 2002:a05:620a:468e:b0:8c7:1316:b0eb with SMTP id af79cd13be357-8c9ebd3b040mr823226785a.8.1769895801249;
        Sat, 31 Jan 2026 13:43:21 -0800 (PST)
Received: from development.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm965368785a.18.2026.01.31.13.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 13:43:19 -0800 (PST)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: glencbz@gmail.com,
	avarab@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH 2/5] submodule: teach and plumb reverse-traversal behavior
Date: Sat, 31 Jan 2026 16:43:06 -0500
Message-ID: <20260131214309.1899376-3-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.53.0-rc0
In-Reply-To: <20260131214309.1899376-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --reverse-traversal flag to 'git submodule foreach' that reverses
the order in which submodules are traversed. When combined with
--recursive, this provides post-order traversal where nested submodules
are visited before their parents.

This is useful for operations that need to process dependencies before
dependents, such as building from leaves to root or cleaning up in
reverse dependency order.

Implementation:
 - Add reverse_traversal field to struct foreach_cb
 - Extend for_each_listed_submodule() with reverse parameter
 - Add post-order recursion block in runcommand_in_submodule_cb()
 - Parse --reverse-traversal in module_foreach() and git-submodule.sh

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 builtin/submodule--helper.c    | 60 +++++++++++++++++++++++++++-------
 git-submodule.sh               |  4 +++
 t/t7425-submodule-reversion.sh |  4 +--
 3 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..b1e202399e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -264,12 +264,18 @@ static char *get_up_path(const char *path)
 }
 
 static void for_each_listed_submodule(const struct module_list *list,
-				      each_submodule_fn fn, void *cb_data)
+				      each_submodule_fn fn, void *cb_data,
+				      int reverse)
 {
 	int i;
 
-	for (i = 0; i < list->nr; i++)
-		fn(list->entries[i], cb_data);
+	if (reverse) {
+		for (i = list->nr - 1; i >= 0; i--)
+			fn(list->entries[i], cb_data);
+	} else {
+		for (i = 0; i < list->nr; i++)
+			fn(list->entries[i], cb_data);
+	}
 }
 
 struct foreach_cb {
@@ -279,6 +285,7 @@ struct foreach_cb {
 	const char *super_prefix;
 	int quiet;
 	int recursive;
+	int reverse_traversal;
 };
 #define FOREACH_CB_INIT { 0 }
 
@@ -352,6 +359,33 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		strvec_pushv(&cp.args, info->argv);
 	}
 
+	/*
+	 * For --reverse-traversal, recurse into nested submodules first
+	 * (post-order traversal: children before parents).
+	 */
+	if (info->recursive && info->reverse_traversal) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = path;
+		prepare_submodule_repo_env(&cpr.env);
+
+		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
+			     "--reverse-traversal", NULL);
+		strvec_pushf(&cpr.args, "--super-prefix=%s/", displaypath);
+
+		if (info->quiet)
+			strvec_push(&cpr.args, "--quiet");
+
+		strvec_push(&cpr.args, "--");
+		strvec_pushv(&cpr.args, info->argv);
+
+		if (run_command(&cpr))
+			die(_("run_command returned non-zero status while "
+				"recursing in the nested submodules of %s\n."),
+				displaypath);
+	}
+
 	if (!info->quiet)
 		printf(_("Entering '%s'\n"), displaypath);
 
@@ -363,7 +397,8 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		child_process_clear(&cp);
 	}
 
-	if (info->recursive) {
+	/* For normal (pre-order) recursion, recurse after command execution. */
+	if (info->recursive && !info->reverse_traversal) {
 		struct child_process cpr = CHILD_PROCESS_INIT;
 
 		cpr.git_cmd = 1;
@@ -401,10 +436,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("recurse into nested submodules")),
+		OPT_BOOL(0, "reverse-traversal", &info.reverse_traversal,
+			 N_("traverse submodules in reverse order (post-order)")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--] <command>"),
 		NULL
 	};
 	int ret = 1;
@@ -419,7 +456,8 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	info.argv = argv;
 	info.prefix = prefix;
 
-	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
+	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info,
+				  info.reverse_traversal);
 
 	ret = 0;
 cleanup:
@@ -558,7 +596,7 @@ static int module_init(int argc, const char **argv, const char *prefix,
 	if (quiet)
 		info.flags |= OPT_QUIET;
 
-	for_each_listed_submodule(&list, init_submodule_cb, &info);
+	for_each_listed_submodule(&list, init_submodule_cb, &info, 0);
 
 	ret = 0;
 cleanup:
@@ -742,7 +780,7 @@ static int module_status(int argc, const char **argv, const char *prefix,
 	if (quiet)
 		info.flags |= OPT_QUIET;
 
-	for_each_listed_submodule(&list, status_submodule_cb, &info);
+	for_each_listed_submodule(&list, status_submodule_cb, &info, 0);
 
 	ret = 0;
 cleanup:
@@ -1345,7 +1383,7 @@ static int module_sync(int argc, const char **argv, const char *prefix,
 	if (recursive)
 		info.flags |= OPT_RECURSIVE;
 
-	for_each_listed_submodule(&list, sync_submodule_cb, &info);
+	for_each_listed_submodule(&list, sync_submodule_cb, &info, 0);
 
 	ret = 0;
 cleanup:
@@ -1501,7 +1539,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix,
 	if (force)
 		info.flags |= OPT_FORCE;
 
-	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
+	for_each_listed_submodule(&list, deinit_submodule_cb, &info, 0);
 
 	ret = 0;
 cleanup:
@@ -2885,7 +2923,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		if (opt.quiet)
 			info.flags |= OPT_QUIET;
 
-		for_each_listed_submodule(&list, init_submodule_cb, &info);
+		for_each_listed_submodule(&list, init_submodule_cb, &info, 0);
 		module_list_release(&list);
 	}
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 2999b31fad..49e9541a3d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -173,6 +173,9 @@ cmd_foreach()
 		--recursive)
 			recursive=$1
 			;;
+		--reverse-traversal)
+			reverse_traversal=$1
+			;;
 		-*)
 			usage
 			;;
@@ -186,6 +189,7 @@ cmd_foreach()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach \
 		$quiet \
 		$recursive \
+		$reverse_traversal \
 		-- \
 		"$@"
 }
diff --git a/t/t7425-submodule-reversion.sh b/t/t7425-submodule-reversion.sh
index 06c3ab6294..c6733234aa 100755
--- a/t/t7425-submodule-reversion.sh
+++ b/t/t7425-submodule-reversion.sh
@@ -138,14 +138,14 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '--recursive and --reverse-traversal parses' '
+test_expect_success '--recursive and --reverse-traversal parses' '
 	(
 		cd reversive/top &&
 		git submodule foreach --recursive --reverse-traversal "true"
 	)
 '
 
-test_expect_failure '--recursive and --reverse-traversal runs' '
+test_expect_success '--recursive and --reverse-traversal runs' '
 	(
 		cd reversive/top &&
 		git submodule --quiet foreach --recursive \
-- 
2.53.0-rc0


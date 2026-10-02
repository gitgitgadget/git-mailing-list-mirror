Received: from mail-dy2-f17.google.com (mail-dy2-f17.google.com [74.125.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8D471CF8
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939500; cv=none; b=DhYR65Fn7tVj/kf6/Q1k+9xLn1hZRN5Eg36dw9u2ghLLy2r/nwlWkvi/Ltw0WlPZH8Z+cGpQIbByzF4hgHze/vrgguH0VQz0029oFvQ/yA7rgllFEtsy3IOUzkc2VxwAe4eHTcGoItM4Sqazuo7nzzM+gGl4SYpcMDEKWNLGfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939500; c=relaxed/simple;
	bh=SDcjaBYeMIxbHtQgJebLANTMHtZe5+omCcPQsIyiCgA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=umqjcUnoSwHesgjWtiqbTCWaKkwd86BATiBvcBVUwFCvQvU0Rn5DjlDz+D3PZhs1i62yfXB25e5YBPcCaFsnWWm7kt44M9+qUkFBPvSXU+GvTRp5q3UwbYP6dniv7KRPsaogBDxEaf1wHcLBAkodbI05Oz2xh1hbYjsQIdQdyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXsOq8WF; arc=none smtp.client-ip=74.125.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXsOq8WF"
Received: by mail-dy2-f17.google.com with SMTP id 5a478bee46e88-34b48100af4so3185846eec.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790939497; x=1791544297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8mFBXqS5/nOj5HrfrrTR/uVWdzdV0dFM32IJoW8SuoU=;
        b=SXsOq8WFVSbLfhyPoRtJYmacMlwTsnCIuGjBU55pMoceVIfQeWQJWZJDHRVR9R3UcO
         3Wk5tplknKoDeavjOtD/YfvC9GJuenSPx4N6MylTB9qsAzUtC4HO1E6RaOWXlV5qOQb9
         5KW1CLYLK1UQawlROTS7cg8c9TihtQnBVetw4kncAyPmMg8jqU+5SlzbEI0TXBDfKedh
         KPhzE3NLqUsEKkoIfvcfUnLcFvDggc48k17Cb5JtREExvKavpTtmz1ZE/9TatBblHlfP
         kg4KJux3b6T2oByW1NjMZE5My3cVzHlodoeQ+mOpFU2esG/LQ8nBNLpVfXIs1xJYKP+x
         utDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939497; x=1791544297;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mFBXqS5/nOj5HrfrrTR/uVWdzdV0dFM32IJoW8SuoU=;
        b=VQ56rKBqJp4VGKkLujz7L5q30XnLLaZd/vqt3RGBUXc6yri659K9nyLMM6JsMLIDku
         o0TcAjDIYS/0PUsj5viqJ7qtoUmYmNxKrKnW/0aqF0yv0PbbbmlD9Ym8f167fmRRLw6J
         OVvN46A4gKj0ZfTpAS9s8AApftCw0owlhRjxNqdIEhMUVyiOJms6nKZ48lD6/2Xev2eR
         7UGe4MyDtkYPKsTeiuzeW8QgRDG/Y2zTqL1n2WSLeYHpK0zz+PQiuFZ5sUQlNRH1tz5v
         UNo9GDXozbnkehumKTQavstz0n+0h+E1UROjKzMkNxKSc7w0hOYrStcUUO4olb/rpahQ
         RoJA==
X-Gm-Message-State: AFq9FYI3tzvOkveWrcvOv44hMocYndOgRrmaawUTITp5yqUCdFfpQjTI
	jAj1O5626QcXlsLsSGhzoPAZ8e2MyQiCUgcazUhuM1ZqcecwZ2Dj5BbxcVPK4g==
X-Gm-Gg: AYBFou0YjhMT6126Nm0+Y+2eC42mDenRT2zdqLMRrfCQmid+WEqqUqaWzwQisDAsToI
	XCPQ7eh1MP4o+E4qW9uC7lcWX5rt0k/+FmWMvZx91Hg+5c1gl3QdIPSxrBrBJ8v5uIsKIYAtfNJ
	Of7vauSCCw49f362O1h/FnkJoY6/U+15Sj3PrZ23Rxxh2XIub07nWQq3YwGb6hgg38SS1XSBb/2
	+gXPzCMEbq93gyU9YoLB5ZHHb0ilniOfb3eSPymR4X99g6l55wf68MUmBdXiojyqrpIleGyClbn
	HYJx/UT3j+us/BKqMwWLBh0YIy245ZsevF5kgtVYEJMk6AxvlAx9LKVLAYtVzuFwv/z1LZ/rDRD
	Qy14jnkskrBglxvhRoEHicpGi6OPhaMOKmT5ZQC5f+LMyGlY/KwCry1qOXDVZv2UivT5ErkdwJo
	hf6vJJnYdFZP9LgDs1WEocop8qb/FMVlne61GJZu8kQUyryZhqZeGU6psKQ/6TyyvnjYxouOY=
X-Received: by 2002:a05:7300:80c6:b0:351:985:e716 with SMTP id 5a478bee46e88-35109953121mr876585eec.13.1790939497191;
        Fri, 02 Oct 2026 04:11:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.59.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm7996228eec.4.2026.10.02.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:11:36 -0700 (PDT)
Message-Id: <2ef141410a1508477976f9e57cec05f1a7603264.1790939492.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 11:11:31 +0000
Subject: [PATCH v6 2/3] rerere: add "gc --skip-locked" for auto maintenance
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Since the previous commit, "git rerere gc" waits for MERGE_RR.lock
like every other command that takes it, and fails only if the wait
times out. That suits a user who runs it by hand and wants to know
when nothing was pruned. But the user did not ask for the gc that auto
maintenance starts after a commit, and the next commit starts another
one.

So add "--skip-locked", with which "git rerere gc" quietly does
nothing while the lock is held, and pass it from
"git maintenance run --auto" and "git gc --auto". Only these two need
the option, so hide it and leave it undocumented, like the
"--skip-foreground-tasks" that "git maintenance run" passes to
"git gc". A run without it, from the command line or a maintenance
schedule, still waits for the lock and fails if the wait times out.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  4 +++-
 builtin/gc.c                     |  4 +++-
 builtin/rerere.c                 | 10 ++++++++--
 rerere.c                         | 22 +++++++++++++++++-----
 rerere.h                         |  4 +++-
 t/t4200-rerere.sh                | 21 +++++++++++++++++++++
 t/t7900-maintenance.sh           | 25 ++++++++++++++++++++++++-
 7 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 30e827f32b..80c38ee951 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -17,4 +17,6 @@ rerere.lockTimeout::
 	`git rerere gc`.  Value 0 means not to wait at all; -1 means
 	to wait indefinitely.  Default is 1000 (i.e., wait for 1
 	second).  When the time is up, the command fails as it does
-	for any other lock it cannot take.
+	for any other lock it cannot take.  A `git rerere gc` run by
+	`git maintenance run --auto` or `git gc --auto` does not wait
+	and does nothing while the lock is held.
diff --git a/builtin/gc.c b/builtin/gc.c
index 57a3520263..7ad3987b71 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -385,12 +385,14 @@ out:
 	return should_prune;
 }
 
-static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
+static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts,
 				      struct gc_config *cfg UNUSED)
 {
 	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	rerere_cmd.git_cmd = 1;
 	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
+	if (opts->auto_flag)
+		strvec_push(&rerere_cmd.args, "--skip-locked");
 	return run_command(&rerere_cmd);
 }
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index a056cb791b..445f1df032 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -56,16 +56,21 @@ int cmd_rerere(int argc,
 	       struct repository *repo UNUSED)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int autoupdate = -1, flags = 0;
+	int autoupdate = -1, skip_locked = 0, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
 			N_("register clean resolutions in index"), 1),
+		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
+			N_("skip gc while another process holds the lock")),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
 
+	if (skip_locked && (argc < 1 || strcmp(argv[0], "gc")))
+		die(_("the option '%s' requires '%s'"), "--skip-locked", "gc");
+
 	repo_config(the_repository, git_xmerge_config, NULL);
 
 	if (autoupdate == 1)
@@ -94,7 +99,8 @@ int cmd_rerere(int argc,
 	if (!strcmp(argv[0], "clear")) {
 		rerere_clear(the_repository, &merge_rr);
 	} else if (!strcmp(argv[0], "gc"))
-		rerere_gc(the_repository, &merge_rr);
+		rerere_gc(the_repository, &merge_rr,
+			  skip_locked ? RERERE_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status")) {
 		if (setup_rerere(the_repository, &merge_rr,
 				 flags | RERERE_READONLY) < 0)
diff --git a/rerere.c b/rerere.c
index 64fac07c71..43c8eb04db 100644
--- a/rerere.c
+++ b/rerere.c
@@ -887,18 +887,30 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
+	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
+		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
 	if (flags & RERERE_READONLY) {
 		fd = 0;
 	} else {
+		int lock_flags = LOCK_DIE_ON_ERROR;
+		int timeout_ms = rerere_lock_timeout_ms;
+
 		/*
 		 * Another process may hold the lock for a while, e.g.
 		 * "git rerere gc" while it prunes rr-cache, so wait for
-		 * it instead of dying right away.
+		 * it instead of dying right away.  The gc of an automatic
+		 * maintenance run does not wait, since skipping one of
+		 * its runs costs nothing.
 		 */
+		if (flags & RERERE_NOWAIT) {
+			lock_flags = 0;
+			timeout_ms = 0;
+		}
 		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
 							    git_path_merge_rr(r),
-							    LOCK_DIE_ON_ERROR,
-							    rerere_lock_timeout_ms);
+							    lock_flags, timeout_ms);
+		if (fd < 0)
+			return -1;
 	}
 	read_rr(r, merge_rr);
 	return fd;
@@ -1284,7 +1296,7 @@ out:
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr)
+void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
@@ -1294,7 +1306,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr, flags) < 0)
 		return;
 
 	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
diff --git a/rerere.h b/rerere.h
index feeb0e2c9f..d54c53d0d4 100644
--- a/rerere.h
+++ b/rerere.h
@@ -10,6 +10,8 @@ struct repository;
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 #define RERERE_READONLY     04
+/* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
+#define RERERE_NOWAIT       010
 
 /*
  * Marks paths that have been hand-resolved and added to the
@@ -37,7 +39,7 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *);
+void rerere_gc(struct repository *, struct string_list *, int);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7bd92235dc..28152bf456 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,27 @@ test_expect_success 'old records rest in peace' '
 	test_path_is_missing $rr2/preimage
 '
 
+test_expect_success 'gc --skip-locked does nothing while MERGE_RR is locked' '
+	mkdir -p $rr2 &&
+	echo Hello >$rr2/preimage &&
+	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
+
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	git rerere gc --skip-locked 2>err &&
+	test_must_be_empty err &&
+	test_path_is_file $rr2/preimage &&
+
+	rm .git/MERGE_RR.lock &&
+	git rerere gc --skip-locked &&
+	test_path_is_missing $rr2/preimage
+'
+
+test_expect_success '--skip-locked is only accepted by gc' '
+	test_must_fail git rerere --skip-locked clear 2>err &&
+	test_grep "option .--skip-locked. requires .gc." err
+'
+
 test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
 	git reset --hard &&
 	rm -rf $rr &&
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4f65fa9439..f0f9b37d4f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1007,9 +1007,17 @@ test_expect_rerere_gc () {
 		shift
 	fi
 
+	# An automatic run passes --skip-locked to "git rerere gc".
+	skip_locked=
+	case " $* " in
+	*" --auto "*)
+		skip_locked=--skip-locked
+		;;
+	esac
+
 	rm -f "rerere-gc.txt" &&
 	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" "$@" &&
-	test_subcommand $negate git rerere gc <rerere-gc.txt
+	test_subcommand $negate git rerere gc $skip_locked <rerere-gc.txt
 }
 
 test_expect_success 'rerere-gc task without --auto always collects garbage' '
@@ -1084,6 +1092,21 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '
 
+test_expect_success 'rerere-gc task with --auto succeeds while MERGE_RR is locked' '
+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
+	mkdir .git/rr-cache &&
+	>.git/MERGE_RR.lock &&
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc
+'
+
+test_expect_success 'rerere-gc task without --auto fails while MERGE_RR is locked' '
+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
+	mkdir .git/rr-cache &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 maintenance run --task=rerere-gc 2>err &&
+	test_grep "Unable to create" err
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "cannot be used together" err
-- 
gitgitgadget


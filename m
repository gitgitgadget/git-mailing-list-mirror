Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF545348D
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627216; cv=none; b=UwgaZ2s3idF6gOIVNeGMtPOCjvGZ5gmiGfrUM5zZAv8IYm2RFbCamBq3E87Kfhrubcm/Ql0t8XE41X4IdOPKqQCvvG0gkc7Bsx/UVi5La0MJV95GJBzB8/dOrLgoyRJcI1yrgQQAyZ0Cd5mZZp8ij+6D8iS5tk1cgmQ7Lm/SLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627216; c=relaxed/simple;
	bh=1yYwR7p68pim3hKglM4eycAAs3Tun8pyM5ft5G4mgNw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cy5KdcoSN9a6/4xEwvi2gnm2oNZvfkszxsFt2SGoMzSbAhl+1VLoa4n6oKKsMQZk2eBmPsPZgpMJ5zD7eu1YZU6YVTDh19OYRBGw8awxco6Xc4gJI2lrS3VeXjVIWVi7YJH9WrqLizuw05jHO3IjGj9+Gaz+iN/e9+fB/zr/5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw+twOUh; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw+twOUh"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4ab89cff9c7so143410b6e.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791627213; x=1792232013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=okNOjX5rqufFivZucT2JiSvc2oNo25JqcmWWeIKNnBk=;
        b=Rw+twOUhLEpsy/8N66vUxlWdOnSjYXF5mjrV0xJ/iFxEN4kq4/2jwySE4nHgGq/NDw
         mFgOcX+uyb3RygX6+DYbdmXPNukTUCxmCDZIA9YPBJG7ilENDF6wcIfVDRcJHEA8KLeh
         GWNLKxhKLvj3lBKeZxsoo9oVoho8/LvvUyZrtgYVj5kGIqDanl4QL5Ljhn2NQ66Ye617
         p5EsUNiAHTwyxV0ttDcl/ATXlX3Oc4tt6/ex4VlGtmTAu42O5iVkIR0VS9wlYW6B00sf
         dNN6WU7VWN58ZyZe3f2Lj5/MVdDZMfuRy2gJqYnoBT8IUnVdT0alryPZGbzEEleaxezk
         8G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791627213; x=1792232013;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okNOjX5rqufFivZucT2JiSvc2oNo25JqcmWWeIKNnBk=;
        b=qAIIdpjpH/NgNwbXcCIH1FTdUi8crX/zEP1fVfgkjcIup2gxRG4qbI17/v3fapc/Py
         dzyO9GsYAlziinu0tXjZ/2JL9F/66NE64QKB4rvuRPMLoDlCEsWPt1jgwU4CwwlAulIW
         4ekMxOa9132qmAFyIKcyZH5g3VDESTsy44U7jp+6wWZmKS2LeE7Qpx4F+4pk2hEu/msf
         e33Oq9O8ArCkPZf2HYYIQumljco2nO99MzjiDsNTlLcbqkHcBaePkWCWMEiDpKuDmPKX
         woYkd/2ZjNX80KmSnJlpDLBQ7L4D/fSxmHD5+409Qh+y2TyvMiiBGbE4aY5K3trieYzz
         Og4g==
X-Gm-Message-State: AFq9FYJwNmodpNpqT2I90kSUfm1Ien8fPbpEl9IsZR9LUAXoTInPA6sR
	DiL3qSGjG5qefOUgGuxgf0SpAuqK+2PA1L8/J8bgtLf8HMG6Jb6pQsA0smmMEhzJ
X-Gm-Gg: AYBFou0ZKm+Sa1S0i50C2Z6httqxg59UrkPQhEJHW5J+qlG1Zj/FFCf5yicu99pH60I
	3tyQSWqsYMl/JtMmJSGL/q0RXY0ZrfQKhbB7G3dAXTXymqKz0gJ1cJYCDDIsXkO3C8lEs0DPHCe
	NjRGf6O2zo/y080nJu+rJj++ZQ/7vVN5HT5E/ZkljGglD5UcOi7Q5VDkab0FB2ShHhNjZBYJixc
	twmjVxcKKXjKxXiLqwC5qXMzB4YttlI+OZI6/GPzLsWJv1ZUf3/bRNhaJlP8K7onsoQLgUlGFRW
	EIj6eY5cipObb7ZasFCM9XKBXJvEX2fyHB7a1SkXwfvdw/nwhD3JyGF3/CV8S5SEL3nsPgPBKNJ
	u8FaoJF++LIQxJEpZWzQu3Z7JMz7nZMFLZ0/21xo/UJ0UfFp1sXmh6Zq3SRfO+rfm8eSn3Td4mw
	VX+030Q3I0LcLwf+A4lbcIpCRKNDhcQEvc/K9/Ng9V+xMELfTBguligmBS/WkI/hyItTUslUlQT
	HoGGqgCqXvJlg==
X-Received: by 2002:a05:6808:3306:b0:4e9:3412:14a5 with SMTP id 5614622812f47-50c516e431cmr3880577b6e.28.1791627213278;
        Sat, 10 Oct 2026 03:13:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.239.199])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c16755440sm4921590b6e.6.2026.10.10.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:13:32 -0700 (PDT)
Message-Id: <000288119671bad19e5e9e37419766b364daaacc.1791627204.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 10:13:24 +0000
Subject: [PATCH v7 2/2] rerere: add "gc --skip-locked" for auto maintenance
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

Starting with the preceding commit, processes that want to acquire
the rerere cache's MERGE_RR.lock by default know to wait up to one
second until that lock has been released. This is a sensible default
for many commands that happen to write rerere entries, as we would
otherwise die immediately when the lock is taken by another process.

But for repository maintenance it's a bit more complicated, as there
are two cases that we have to care about. When the user explicitly
asks us to garbage collect rerere entries via `git rerere gc` they
probably want us to try our best to perform this operation. It's thus
sensible to wait for the lock and then die if we weren't able to
acquire it.

But we also prune rerere entries as part of auto-maintenance, which is
only executed on a best-effort basis anyway. Delaying the whole
operation to acquire the lock is somewhat heavy-handed, and neither
does it make sense to die in case we haven't been able to garbage
collect rerere entries as that would impede other housekeeping tasks.
Furthermore, it's totally fine to skip the operation when the rerere
cache is locked already, as we will retry during the next run anyway.

But we do not have an easy way to tell `git rerere gc` to skip the
operation in case the cache is locked already. Add a new
"--skip-locked" flag to plug that gap and have auto-maintenance pass
that flag.

Only auto-maintenance needs that flag, so hide it, like the
"--skip-foreground-tasks" flag that `git maintenance run` passes to
`git gc`.

Helped-by: Patrick Steinhardt <ps@pks.im>
Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  4 +++-
 builtin/gc.c                     |  4 +++-
 builtin/rerere.c                 | 10 ++++++++--
 rerere.c                         | 20 ++++++++++++++++----
 rerere.h                         | 11 ++++++++++-
 t/t4200-rerere.sh                | 26 ++++++++++++++++++++++++++
 t/t7900-maintenance.sh           | 25 ++++++++++++++++++++++++-
 7 files changed, 90 insertions(+), 10 deletions(-)

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
index a056cb791b..91cb3c8668 100644
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
+			  skip_locked ? RERERE_GC_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status")) {
 		if (setup_rerere(the_repository, &merge_rr,
 				 flags | RERERE_READONLY) < 0)
diff --git a/rerere.c b/rerere.c
index 64fac07c71..889ec700dd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -887,18 +887,28 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
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
 		 * it instead of dying right away.
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
@@ -1284,7 +1294,8 @@ out:
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr)
+void rerere_gc(struct repository *r, struct string_list *rr,
+	       enum rerere_gc_flags flags)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
@@ -1294,7 +1305,8 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr,
+			 (flags & RERERE_GC_NOWAIT) ? RERERE_NOWAIT : 0) < 0)
 		return;
 
 	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
diff --git a/rerere.h b/rerere.h
index feeb0e2c9f..61e986475b 100644
--- a/rerere.h
+++ b/rerere.h
@@ -10,6 +10,8 @@ struct repository;
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 #define RERERE_READONLY     04
+/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
+#define RERERE_NOWAIT       010
 
 /*
  * Marks paths that have been hand-resolved and added to the
@@ -37,7 +39,14 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *);
+
+enum rerere_gc_flags {
+	/* Skip the operation in case the MERGE_RR.lock is already taken. */
+	RERERE_GC_NOWAIT = (1 << 0),
+};
+
+void rerere_gc(struct repository *, struct string_list *,
+	       enum rerere_gc_flags flags);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7bd92235dc..527a872c00 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,32 @@ test_expect_success 'old records rest in peace' '
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
+	test_path_is_file $rr2/preimage
+'
+
+test_expect_success 'gc --skip-locked prunes while MERGE_RR is not locked' '
+	mkdir -p $rr2 &&
+	echo Hello >$rr2/preimage &&
+	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
+
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

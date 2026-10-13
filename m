Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C904FE2EB
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893281; cv=none; b=XZbXXCop1jco2rtvsSXGiP5nWjNIdXzeFvHlcUVEOYUV5aelIMn7US9z9qacDxo8sIOUpB5QuqbfSxGnvWdgs08hSXlE8fVSgCtNPZ9O/UVZ9fWmjYAkb2CP9dT8PIlVz5c0N+OY4J/0+7UbJdwTnInh/FLH30l9GDuOKysbjkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893281; c=relaxed/simple;
	bh=NENvHJY4jIkmd+7PS8KK9Tl0XaH2YxG88Mofwdcetck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bflzkLnbwwQESx1d11Z4IMuipSkE+t47dLuq+Zwpsx4TgEv7quOufJgCjt72HIg2GRiSDYkyffYvexJduYM0IyOtZekHA/Kd6FAXxjOGVfdXo6wGfp3VnMaWqPBl7SVdgRCMhcURtycsJ55Oz8MN+nwEmbjZglmrnhOu72EwUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If72iqB7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If72iqB7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-85377c8bc96so1095887b3a.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893279; x=1792498079; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SPKapgf9qBZepV+wwvDGMSlMdEE3vbhX6PAJNXv3gng=;
        b=If72iqB7qtqxjlZarodxl4u6+bJnrAaQzlTA1W9HmhoorGEO4WsZ4ZgGBMD18/FBSm
         80bTbTRvixdQ+eorTEYz8ZwuJ5ziNgGs7uceWBq3ry9WJTl5F/0PAnvm13a1iKq9HGaF
         GArrZWjI1oeMn+h4y1a1tE+DMq7O8G6JPYo/nGauhc/Y36lgXQE57NDMvUNNEjCOKBmv
         kChNG0mSDAlG8CtCncRbfRspVonbjkSl5q2Rgyo1tWwTfo7ivkuIew0iaXNty6XzsSvs
         E5gQu701B94A/maoopJrhbwZbueotWBn64p2wSd09JAZlC1mWc1eq7Zw2vIrgjtOAeYJ
         2+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893279; x=1792498079;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPKapgf9qBZepV+wwvDGMSlMdEE3vbhX6PAJNXv3gng=;
        b=qXaWJG0J4eW7axyB3UFfyItSFF59Y8eFhLWrTEUtb7ThkHY75jNfHzI2mvNQZk/eVw
         eKwOkT6OPys+lWIz+LU7PIR6IlojFdN6Y/P2uC1FqXndpmDUNpMiINTlGYtHtwJAcujV
         L5jmD4oe+FnN3dES+QukXUN8lm6YkfPoQ9kqbpQb6OJPNR4jBK5AP6tu3cDf3FBGMwqJ
         qvpxPBUFGe/4nVwEBCxTaRdXCX4md8aL6cNBmAf3bj0Qgrriz3yObuwDSOoGKspSy74F
         qctLIUO3dL/DP7lb/flV2BCySHcOSg4JeLlsWAnfNGVyz9j+u20EOMfWj7Id5AmF6818
         fwJg==
X-Gm-Message-State: AFq9FYILTebO4dglbHJXvqKCUKWS3Os20L2Qb8sP1qO6iwUUyUxJsUz2
	wj/jVOXVa+Aol9CbqMoLx7HPe9h9aBxxKps2XHz3sq8xEnchAkhkC37PN5O4Ow==
X-Gm-Gg: AYBFou3w44BnsIf0x9XXTXdd1MFQH21E/dpBL2BuUsQJjP6/F2QMmL2G94modghiAr4
	edVzblqZ2u81LcDDyaXjJV1B9+VMpR3W/16JlloeKGPbp2si/X0HANgDhKaCdNUIi7QfRjYj++Q
	HFHJ5L+YvayjSNSJEcnaxlHwqli5RjrFVx/Cqsv1yu5OupuO9r1W0OCWC8ppXudkHwr0udzDb2C
	b1KOI9wjQbO+1x/sSsn1M06BNxu1HXooCLjaIJm0ZPF+8bsYbsEIFOypxo49/O5JoXgNJVVEY6A
	e69RrRklbYteE8sxAz2oI53s9HLiYHLePhYjHP9EmiLoeBbkZMjDTfGa6dhjx179yqJzoDPxj7N
	JSK+mLR98NeeGbqtWKoyup2ZqwXcIqyV4/KaAq6uUn39G9exSkZdXs2xIhEMbKz2Wfjzyp+mupr
	TH0nHLstJQxVUGnC+j/AsKYyFkqLstTdvB1v3Th/iNwIsmbPdCqsEnJhcGz6V3lwitJo1O48hiL
	xhYduhcAFUsGw==
X-Received: by 2002:a05:6a20:e210:b0:3e0:f07d:a66 with SMTP id adf61e73a8af0-3e16bda71d8mr11883232637.23.1791893279239;
        Tue, 13 Oct 2026 05:07:59 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3ccf7cdsm4863968b3a.30.2026.10.13.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:07:58 -0700 (PDT)
Message-Id: <4202361858764ae057874159b9ce2060721dc51d.1791893274.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 12:07:53 +0000
Subject: [PATCH v8 2/2] rerere: add "gc --skip-locked" for auto maintenance
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
 rerere.c                         | 23 +++++++++++++++++------
 rerere.h                         |  4 +++-
 t/t4200-rerere.sh                | 26 ++++++++++++++++++++++++++
 t/t7900-maintenance.sh           | 26 +++++++++++++++++++++++++-
 7 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index ab035e2d7d..60e78e499f 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -16,4 +16,6 @@ rerere.lockTimeout::
 	lock when another process holds it, typically a background
 	`git rerere gc`.  Value 0 means not to wait at all; -1 means
 	to wait indefinitely.  Default is 1000 (i.e., wait for 1
-	second).
+	second).  A `git rerere gc` run by `git maintenance run --auto`
+	or `git gc --auto` does not wait and does nothing while the
+	lock is held.
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
index 64fac07c71..75b99f0f81 100644
--- a/rerere.c
+++ b/rerere.c
@@ -887,18 +887,29 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
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
+		if (flags & RERERE_NOWAIT) {
+			lock_flags = 0;
+			timeout_ms = 0;
+		}
+
 		/*
 		 * Another process may hold the lock for a while, e.g.
-		 * "git rerere gc" while it prunes rr-cache, so wait for
-		 * it instead of dying right away.
+		 * "git rerere gc" while it prunes rr-cache, so by default
+		 * wait for it instead of dying right away.
 		 */
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
@@ -1284,7 +1295,7 @@ out:
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr)
+void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
@@ -1294,7 +1305,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr, flags) < 0)
 		return;
 
 	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
diff --git a/rerere.h b/rerere.h
index feeb0e2c9f..1182ee3fb1 100644
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
@@ -37,7 +39,7 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *);
+void rerere_gc(struct repository *, struct string_list *, int);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 94165c8417..43795fb7a6 100755
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
index 4f65fa9439..9d610a29fe 100755
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
@@ -1084,6 +1092,22 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '
 
+test_expect_success 'rerere-gc task with --auto succeeds while MERGE_RR is locked' '
+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
+	# Without "rr-cache", rerere is disabled and never takes the lock.
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
+	test_grep "Unable to create.*MERGE_RR\.lock" err
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "cannot be used together" err
-- 
gitgitgadget

Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63876301460
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417366; cv=none; b=ORpGmEAajI26cvzgWnLim0F9pKfd1SrTCQ1gk4pE2vNWYKIqb7kkLUxhXrMXFx31UDKWOBaTr1x8qqvIXHKOcEJf/S6e9H2cprqp97v1sz8vpl7ePITh/Z1q730YqADusyIWAcpUvIFN/HJXEOx82eOGHl031PrIFHeo9gDiNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417366; c=relaxed/simple;
	bh=QQgPB/uGBOWYGRLo1bGi7Yx2rrewVZyr2ob9SNcvieg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYKZZcC42mmUbxGF9uii/5a38OuOZK5hX9Hycw1wlg1qONC8NzuFTO66UDsVR2kUHOKVnypVQNaPuQAsKYV1hpKG0Zgcs8+/SS3H/q7yGs6oNIT5XjgOTMiIejTPRdORlEGyB6KpWb0bGpTPuDNic83Dm5QTVjb9rZXjJefRsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuOI/8zz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuOI/8zz"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7042e50899so113944666b.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417363; x=1763022163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0kyJkAfnEaVgKwW4Q6fKIqrx2Vy/zvsXIhFwcmI4I8=;
        b=ZuOI/8zziBuRtIIplwrfrT8IiQgvYRV5mqKxaWg4ciKVUCznPod/tYBmVkBoOeyubM
         NtI+rnG2a9XdmOX5suuISVReI45eYlweifLjuTCVIrvDCV3uxisQ11yKwmr0i8fe5w7e
         SZLaMISnOXW94imuSz6Nvi1RENaFSh3LuPdB5ZNpZQjj9B6cf78MlcMri7NQc2SZqI6o
         01A6WwdOHIcagv+hPfRnYN2GO2SUaqqSM66iuBL3hv+lnbMhn8klcteYBoxGDEhh0jcG
         54niFeM4QJUKDFEeNNlXPEyANisWvT/GwFNhcTIZWxD+dqr/LX4+KsxLuMpQnDAM+GMG
         Ge1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417363; x=1763022163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0kyJkAfnEaVgKwW4Q6fKIqrx2Vy/zvsXIhFwcmI4I8=;
        b=Uc5dFVkdux6FaIIRtOf4HISzkx7DYwtLSMPyOhqVwU9T+JqiCm0l4kajZnpmtrYqm1
         3TiSQaOYutiI1zihL716Wy7o+QqiQQu7Sm/O78ynlFxYtoQSAuP1CR64WAaIty7lAqQ8
         A6LAyp3BAzxMCr6B8rEz7IaFOO9wPHl2bjQENvx7lPz+smVNcLOHhJt+gZCyj2WeQMzy
         O44BPONxhWw3MG330sQlb6rciUWhNTWpWIlpaNgOBXrG024bhRWIcKuA2mgoQPFB2r6X
         id+w6e445FUCin7lJ/H4SFFaU6wHb0oRydTDuWqN/59tiOZU0IK4IuoeJ98DAo0C2whM
         PiTg==
X-Gm-Message-State: AOJu0YzdeaIva55rFeSirenZW4SU/D5V0d0zUTKYvRIFhWPOItOb/dxk
	h5Lvu9GhaCKF8z6i4EbBRN7kYPYObCEu+j6bREslxLnpqF2JPtRgNKy5
X-Gm-Gg: ASbGncuyzCkxeJ1LKyxnQ47LQ+2Oe5M7pGQJx4Z42E/029+SbB3st/O1k74EJ9ygvXW
	tKxCYV6b4eTsIJ29UwoYb8UXUXLJ3hvTYOX4GKWhcomwDsQ/uPm08O0Pn2fugJFPbIO78F8dKza
	+8wXLceKwBSxAr1w+QmPWe444W20gjzNqw8ZnD82fy7Lu0A2j82vty+tswXjGZEUiBqjQeDbT9J
	Az5OKC7ZBiG9Lt2yfXKVSiQJYEZWpD8RP5r5kahtYxYJgA+SL31G4UobCA13liyDsm8Dq8ELdS1
	I0GhsDLskIq1RHX5/bYbz4fUNr7WVTMIkQQBYSKrXoHjgG11JbUBdVGvtlNQUv6idi/0PRZI8Ll
	2d1O0xU/sthaLxEflu/GB3APGmSDXddTw1nEB6WUbAzfJr5ePW2EhaYr6W+UawPN9nm0Csf2jdX
	NTojNWjnNBkJEayVM=
X-Google-Smtp-Source: AGHT+IEOL5+UoNQdVbgt3SsmmnlMpif7mGD+55lg3dE9R4wrLwlK5KEz6zKE+4ekNI7cJL9ncpZKwQ==
X-Received: by 2002:a17:906:6a11:b0:b72:6306:bf8a with SMTP id a640c23a62f3a-b72655adf63mr671883066b.54.1762417362423;
        Thu, 06 Nov 2025 00:22:42 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:107:48a1:df96:bd1c:78ca:785c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893360f6sm160577566b.10.2025.11.06.00.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:22:42 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 06 Nov 2025 09:22:34 +0100
Subject: [PATCH v3 5/5] maintenance: add 'is-needed' subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-5-d611a2a95cf5@gmail.com>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14580;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=QQgPB/uGBOWYGRLo1bGi7Yx2rrewVZyr2ob9SNcvieg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkMWsjGjrGHyuajouCFn1BQu4kMkOgN1Pu+6
 iWPreaJ4+foeYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpDFrIAAoJED7VnySO
 Rox/p5AL/0U8gPWnan6oiRz/SjZMFCIUJsdg+fX3CUgSU82q8YElrzsPDOv8CQUlTG6qb1tV2rX
 nDpM1MpoPouFttC89R6+MoRpSGTRKYMYtt48rXwhZJBFluvB6D7au6temjKqJ0k4f/XGY5ll+4v
 /ks9W345qwkz0UB/Eu2tBB8JYKW3TU5n7q+ZoXG11MXgVFo2f+GhcjiQvpEZ3e7dbzS5Ff4vtn0
 ejASiQ1+zB2qewhPCvbQJuaKI0uOcbkFum3REsyt9pHzJEy9r6ZA7bZfHABtBwfZUWn+1TSivjP
 WwjxDzHX7xrnQMZ5JIBhSEktF0rJKJfE91SzDhonkpSqT/bVQnCSPfh6WUUxrShnOtLs4MhLGTH
 F4nvHnniQA8uIhIfdZW0EG2AtjCTV8fLkH82XAg+muCPs5gcVr53v3jTfiWRQQyqKTzhBxGkLzI
 7if1r+U8eQi/+sJQbThEyisXn0Qncl4CMGmhaA9rqWSq3Vb2ypKQiqfHro9p83GW5kO9t7jS2n6
 9I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-maintenance(1)' command provides tooling to run maintenance
tasks over Git repositories. The 'run' subcommand, as the name suggests,
runs the maintenance tasks. When used with the '--auto' flag, it uses
heuristics to determine if the required thresholds are met for running
said maintenance tasks.

There is however a lack of insight into these heuristics. Meaning, the
checks are linked to the execution.

Add a new 'is-needed' subcommand to 'git-maintenance(1)' which allows
users to simply check if it is needed to run maintenance without
performing it.

This subcommand can check if it is needed to run maintenance without
actually running it. Ideally it should be used with the '--auto' flag,
which would allow users to check if the thresholds required are met. The
subcommand also supports the '--task' flag which can be used to check
specific maintenance tasks.

While adding the respective tests in 't/t7900-maintenance.sh', remove a
duplicate of the test: 'worktree-prune task with --auto honors
maintenance.worktree-prune.auto'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-maintenance.adoc | 13 +++++++++
 builtin/gc.c                       | 55 +++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh             | 54 ++++++++++++++++++++++++++-----------
 3 files changed, 105 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 540b5cf68b..37939510d4 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 'git maintenance' run [<options>]
 'git maintenance' start [--scheduler=<scheduler>]
 'git maintenance' (stop|register|unregister) [<options>]
+'git maintenance' is-needed [<options>]
 
 
 DESCRIPTION
@@ -84,6 +85,16 @@ The `unregister` subcommand will report an error if the current repository
 is not already registered. Use the `--force` option to return success even
 when the current repository is not registered.
 
+is-needed::
+    Check whether maintenance needs to be run without actually running it.
+    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
+    Ideally used with the '--auto' flag.
++
+If one or more `--task` options	are specified, then those tasks are checked
+in that order. Otherwise, the tasks are determined by which
+`maintenance.<task>.enabled` config options are true. By default, only
+`maintenance.gc.enabled` is true.
+
 TASKS
 -----
 
@@ -183,6 +194,8 @@ OPTIONS
 	in the `gc.auto` config setting, or when the number of pack-files
 	exceeds the `gc.autoPackLimit` config setting. Not compatible with
 	the `--schedule` option.
+	When combined with the `is-needed` subcommand, check if the required
+	thresholds are met without actually running maintenance.
 
 --schedule::
 	When combined with the `run` subcommand, run maintenance tasks
diff --git a/builtin/gc.c b/builtin/gc.c
index c3e7a84ec2..e5ba2a2e72 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -3253,7 +3253,59 @@ static int maintenance_stop(int argc, const char **argv, const char *prefix,
 	return update_background_schedule(NULL, 0);
 }
 
-static const char * const builtin_maintenance_usage[] = {
+static const char *const builtin_maintenance_is_needed_usage[] = {
+	"git maintenance is-needed [--task=<task>] [--schedule]",
+	NULL
+};
+
+static int maintenance_is_needed(int argc, const char **argv, const char *prefix,
+				 struct repository *repo UNUSED)
+{
+	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
+	struct string_list selected_tasks = STRING_LIST_INIT_DUP;
+	struct gc_config cfg = GC_CONFIG_INIT;
+	struct option options[] = {
+		OPT_BOOL(0, "auto", &opts.auto_flag,
+			 N_("run tasks based on the state of the repository")),
+		OPT_CALLBACK_F(0, "task", &selected_tasks, N_("task"),
+			       N_("check a specific task"),
+			       PARSE_OPT_NONEG, task_option_parse),
+		OPT_END()
+	};
+	bool is_needed = false;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_maintenance_is_needed_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc)
+		usage_with_options(builtin_maintenance_is_needed_usage, options);
+
+	gc_config(&cfg);
+	initialize_task_config(&opts, &selected_tasks);
+
+	if (opts.auto_flag) {
+		for (size_t i = 0; i < opts.tasks_nr; i++) {
+			if (tasks[opts.tasks[i]].auto_condition &&
+			    tasks[opts.tasks[i]].auto_condition(&cfg)) {
+				is_needed = true;
+				break;
+			}
+		}
+	} else {
+		/* When not using --auto, we should always require maintenance. */
+		is_needed = true;
+	}
+
+	string_list_clear(&selected_tasks, 0);
+	maintenance_run_opts_release(&opts);
+	gc_config_release(&cfg);
+
+	if (is_needed)
+		return 0;
+	return 1;
+}
+
+static const char *const builtin_maintenance_usage[] = {
 	N_("git maintenance <subcommand> [<options>]"),
 	NULL,
 };
@@ -3270,6 +3322,7 @@ int cmd_maintenance(int argc,
 		OPT_SUBCOMMAND("stop", &fn, maintenance_stop),
 		OPT_SUBCOMMAND("register", &fn, maintenance_register),
 		OPT_SUBCOMMAND("unregister", &fn, maintenance_unregister),
+		OPT_SUBCOMMAND("is-needed", &fn, maintenance_is_needed),
 		OPT_END(),
 	};
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ddd273d8dc..a17e2091c2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -49,7 +49,9 @@ test_expect_success 'run [--auto|--quiet]' '
 		git maintenance run --auto 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
+	git maintenance is-needed &&
 	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-no-auto.txt &&
+	! git maintenance is-needed --auto &&
 	test_subcommand ! git gc --auto --quiet --no-detach --skip-foreground-tasks <run-auto.txt &&
 	test_subcommand git gc --no-quiet --no-detach --skip-foreground-tasks <run-no-quiet.txt
 '
@@ -180,6 +182,11 @@ test_expect_success 'commit-graph auto condition' '
 
 	test_commit first &&
 
+	! git -c maintenance.commit-graph.auto=0 \
+		maintenance is-needed --auto --task=commit-graph &&
+	git -c maintenance.commit-graph.auto=1 \
+		maintenance is-needed --auto --task=commit-graph &&
+
 	GIT_TRACE2_EVENT="$(pwd)/cg-zero-means-no.txt" \
 		git -c maintenance.commit-graph.auto=0 $COMMAND &&
 	GIT_TRACE2_EVENT="$(pwd)/cg-one-satisfied.txt" \
@@ -290,16 +297,23 @@ test_expect_success 'maintenance.loose-objects.auto' '
 		git -c maintenance.loose-objects.auto=1 maintenance \
 		run --auto --task=loose-objects 2>/dev/null &&
 	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
+
 	printf data-A | git hash-object -t blob --stdin -w &&
+	! git -c maintenance.loose-objects.auto=2 \
+		maintenance is-needed --auto --task=loose-objects &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-loA" \
 		git -c maintenance.loose-objects.auto=2 \
 		maintenance run --auto --task=loose-objects 2>/dev/null &&
 	test_subcommand ! git prune-packed --quiet <trace-loA &&
+
 	printf data-B | git hash-object -t blob --stdin -w &&
+	git -c maintenance.loose-objects.auto=2 \
+		maintenance is-needed --auto --task=loose-objects &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-loB" \
 		git -c maintenance.loose-objects.auto=2 \
 		maintenance run --auto --task=loose-objects 2>/dev/null &&
 	test_subcommand git prune-packed --quiet <trace-loB &&
+
 	GIT_TRACE2_EVENT="$(pwd)/trace-loC" \
 		git -c maintenance.loose-objects.auto=2 \
 		maintenance run --auto --task=loose-objects 2>/dev/null &&
@@ -421,10 +435,13 @@ run_incremental_repack_and_verify () {
 	test_commit A &&
 	git repack -adk &&
 	git multi-pack-index write &&
+	! git -c maintenance.incremental-repack.auto=1 \
+		maintenance is-needed --auto --task=incremental-repack &&
 	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
 		-c maintenance.incremental-repack.auto=1 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
+
 	test_commit B &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
@@ -434,11 +451,14 @@ run_incremental_repack_and_verify () {
 		-c maintenance.incremental-repack.auto=2 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
+
 	test_commit C &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
 	^HEAD~1
 	EOF
+	git -c maintenance.incremental-repack.auto=2 \
+		maintenance is-needed --auto --task=incremental-repack &&
 	GIT_TRACE2_EVENT=$(pwd)/trace-B git \
 		-c maintenance.incremental-repack.auto=2 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
@@ -485,9 +505,15 @@ test_expect_success 'reflog-expire task --auto only packs when exceeding limits'
 	git reflog expire --all --expire=now &&
 	test_commit reflog-one &&
 	test_commit reflog-two &&
+
+	! git -c maintenance.reflog-expire.auto=3 \
+		maintenance is-needed --auto --task=reflog-expire &&
 	GIT_TRACE2_EVENT="$(pwd)/reflog-expire-auto.txt" \
 		git -c maintenance.reflog-expire.auto=3 maintenance run --auto --task=reflog-expire &&
 	test_subcommand ! git reflog expire --all <reflog-expire-auto.txt &&
+
+	git -c maintenance.reflog-expire.auto=2 \
+		maintenance is-needed --auto --task=reflog-expire &&
 	GIT_TRACE2_EVENT="$(pwd)/reflog-expire-auto.txt" \
 		git -c maintenance.reflog-expire.auto=2 maintenance run --auto --task=reflog-expire &&
 	test_subcommand git reflog expire --all <reflog-expire-auto.txt
@@ -514,6 +540,7 @@ test_expect_success 'worktree-prune task --auto only prunes with prunable worktr
 	test_expect_worktree_prune ! git maintenance run --auto --task=worktree-prune &&
 	mkdir .git/worktrees &&
 	: >.git/worktrees/abc &&
+	git maintenance is-needed --auto --task=worktree-prune &&
 	test_expect_worktree_prune git maintenance run --auto --task=worktree-prune
 '
 
@@ -530,22 +557,7 @@ test_expect_success 'worktree-prune task with --auto honors maintenance.worktree
 	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
 	# A positive value should require at least this many prunable worktrees.
 	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
-	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
-'
-
-test_expect_success 'worktree-prune task with --auto honors maintenance.worktree-prune.auto' '
-	# A negative value should always prune.
-	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=-1 maintenance run --auto --task=worktree-prune &&
-
-	mkdir .git/worktrees &&
-	: >.git/worktrees/first &&
-	: >.git/worktrees/second &&
-	: >.git/worktrees/third &&
-
-	# Zero should never prune.
-	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
-	# A positive value should require at least this many prunable worktrees.
-	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
+	git -c maintenance.worktree-prune.auto=3 maintenance is-needed --auto --task=worktree-prune &&
 	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
 '
 
@@ -554,11 +566,13 @@ test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
 	rm -rf worktree &&
 
 	rm -f worktree-prune.txt &&
+	! git -c gc.worktreePruneExpire=1.week.ago maintenance is-needed --auto --task=worktree-prune &&
 	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=1.week.ago maintenance run --auto --task=worktree-prune &&
 	test_subcommand ! git worktree prune --expire 1.week.ago <worktree-prune.txt &&
 	test_path_is_dir .git/worktrees/worktree &&
 
 	rm -f worktree-prune.txt &&
+	git -c gc.worktreePruneExpire=now maintenance is-needed --auto --task=worktree-prune &&
 	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=now maintenance run --auto --task=worktree-prune &&
 	test_subcommand git worktree prune --expire now <worktree-prune.txt &&
 	test_path_is_missing .git/worktrees/worktree
@@ -583,10 +597,13 @@ test_expect_success 'rerere-gc task without --auto always collects garbage' '
 
 test_expect_success 'rerere-gc task with --auto only prunes with prunable entries' '
 	test_when_finished "rm -rf .git/rr-cache" &&
+	! git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
 	mkdir .git/rr-cache &&
+	! git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
 	: >.git/rr-cache/entry &&
+	git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
 '
 
@@ -594,17 +611,22 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 	test_when_finished "rm -rf .git/rr-cache" &&
 
 	# A negative value should always prune.
+	git -c maintenance.rerere-gc.auto=-1 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
 
 	# A positive value prunes when there is at least one entry.
+	! git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
 	mkdir .git/rr-cache &&
+	! git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
 	: >.git/rr-cache/entry-1 &&
+	git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
 
 	# Zero should never prune.
 	: >.git/rr-cache/entry-1 &&
+	! git -c maintenance.rerere-gc.auto=0 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '
 

-- 
2.51.0


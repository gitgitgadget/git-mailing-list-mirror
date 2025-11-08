Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB528468D
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638739; cv=none; b=ln1aaM0Iom0FaW6DtcVz6sLwcm5ebzQQTduACdECwSuHjcwJLOegBoHkHwF2jDVmZ/kwfD5Pvw6gjHK0duZ3B/vXES7AxEuXBgEFuxmqzsdYZbRugxpjWpx+PN6w+lsd6wrZSTe6V0mXl5QJbJ6UAWiVUk1V97b6Fce/j05nSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638739; c=relaxed/simple;
	bh=dLwGukMD6CxFi/59kWJSZB41BIQTKJEW+7nTieQxEnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtAkU1izlXQRciD8lsr+72ulrKRYTl0epl7cgMwvTb0YbvCXSS0TQD8Vn3n1fcWmAorffhs3DnKVcuG2Gry56BYNVAsQ8euP2UXz8gjnRvgmjGItDDRiK2AoZiWULyrH9+bwR7QArJiuj/fBa+qNmkghe+uW+wzZia65siaZNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieaOLnx+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieaOLnx+"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640f627d01dso3329563a12.2
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762638734; x=1763243534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmUxAI3NKc3CW1dUsjYofGazEHSkvMj0qJt8WiOXUDo=;
        b=ieaOLnx+jMjTy4IeU3aUqeOWjYJ0D34VpwowGowRkB8pjxMTSzX/MPgJXCKBw+ro8E
         qmOVdrGVa+SnUZk/iCBuwFJ3z5fOvLlD7vK9AFs5sr3uS20Fvr3lcNZqKtBLK2m8Ouum
         6L8SBFpSU7zZbg9o9LXXIhSEG+M1ZqBNb31unov4K6iQtkorAcP2+sCrD3MOI06d0PTc
         6GNrR9r9BfXrnL0LzsWRouDgHOPmhga8Fa/GFSXD/zBquf38VbqFbzv5sU4dzpUC2jGL
         ldtxi17/nMemFQ+kqW0gx3cB1fSWa/Tu3e+0RKafZtx2ZzLkNpX1y8WU96vB8KBv/9zC
         Iq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762638734; x=1763243534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CmUxAI3NKc3CW1dUsjYofGazEHSkvMj0qJt8WiOXUDo=;
        b=RIZm8dvHmc/GavbBmrIn2JFb1/k3mkZhbUS1Qz7Cab5q/hFBJ7a4B0bY6cSKXjcxP/
         1zAyN/9/AM2ojoaQZ1/5q8XCs/rBfWz5Yg0Oa3zEh0m5UoTrQby7t5R2F/d2tRru5Z9B
         6U44Ps2oXdXAygxYyiHIWIM2H2L4wv6FPqSBNiNz2dP0Z+al0e74sGr3SC3S71gNjIpA
         NPKnzYd86jJthLvf2k4RpbFcbGzFbC3zQsWf8nPlAvn1dSBulx0yW0kgpGh6eR4gY5Ee
         pqPm22dKJ/i8Rpsc53pQ9ylGMmYyHgT3fsy9gSKeEjcqC0OOwo3WNt0Y3J4AOLM5/2TG
         tmAg==
X-Gm-Message-State: AOJu0YxJXc8k9xmfxv4vgcojwcVAXTuhB/XbW4QvkFztxSskXtrfN+Q/
	5u6VhCsPWE/wt5/COzoht80hGdxvO5igVviRkKCO1MSiAOYhjCKw3hTSUE6WRElA
X-Gm-Gg: ASbGncsg3Igsxcga+LEDWWCAZNtPzK4xBCRsha+LYyOsy+d0xSBQh0R9wMKHVoukbfl
	nlXlVNoTQ8olrS4MNuSrf4R6fPAoc81PVZyyfmKvgxUCN52fgEPCCCNeOZY/jL63JV9S0Mz5bfh
	n1SPW1nEwfCRwnTX8Trpx+TKRGENBEVc07eG3x6Xp5GkM3LkEy3qoitFzE+2N0Z0A9JUcl1tzcy
	ITosD1TEFFyroBaWOuMgVGAUao5y/ZGe96oDoJ59JsZE8Xax0GWPcqRqwQ/vojbMmtfN314yj4D
	RbSlxhc7CQ54iQ8J6dZGqnkGPcEKC7JMI3OrODItix9ZeGVleZcghnXTpwMsNG1j6R3pQEISJWR
	A2ZBCDF42OaU5rQ8cjP4bh8RINHvECysLQZSuLtZPnl0GTwkGu5nINO8iHAWXaLxjPYym5fT6Nn
	ZQ0gie
X-Google-Smtp-Source: AGHT+IHQCEV5uRuzLwTkA7dxtlmeQqd3kburJ9iugJvwrB8gZN7A566WlsDhlQn6iKjdbhNAWLvj8w==
X-Received: by 2002:a05:6402:51ca:b0:641:62bb:9c0 with SMTP id 4fb4d7f45d1cf-64162bb0edemr2059515a12.33.1762638734030;
        Sat, 08 Nov 2025 13:52:14 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415b69c366sm3056371a12.23.2025.11.08.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:52:13 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 08 Nov 2025 22:51:57 +0100
Subject: [PATCH v4 5/5] maintenance: add 'is-needed' subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-5-a90f229b6023@gmail.com>
References: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
In-Reply-To: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14892;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=dLwGukMD6CxFi/59kWJSZB41BIQTKJEW+7nTieQxEnQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPu4GNN7xAGAhWE419sZRLgXVPoxmSD20N8
 NMu03Ln/8Ni+IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7uBAAoJED7VnySO
 Rox/ZUYL/0iQL0PRxFO8CWAaesLIZNtJcgz135NrMOVzwl4cHGHUaQ24ftoOtLa/Co3AlUAc6Nh
 gTU2R+S/nDxpYYFpgs86+e7lNXdWcNArNE+w8UONCwxBY/TcwY/iAjj6wIIi7RbXoiYfT5YyjTJ
 BotP+wn19fM5qVmqgW68PLlLwvwbSmmmoauiuaTGEdz30ZvMYz3TIdhnZSx0tEiWHc6D2YYSdIN
 t7zjzcTZfBatsz1jI3Mds+6QUbcp05bSEZqk155iT8yKoyj5H/ijm1nvdBHO4hKoi4fuOtKSX+f
 AIufac4vDEMQZuZNlpPvh8ywucyRgtTD/Ps9iakhoE/gnx6HT1+LZIV0d+RNaEHx2LDec+1OEka
 SU+UzwIpzsiQqZtxZwoQSIltPy07p2y4pGIgyOANSZj0j+Mvvp2XRkAACYFjAcb3tsWrExMXL9p
 4ola7YZJfMSqeXGYGZesX2u2bEP95RBR/miuhOzL5XiW9JEgg/KJKa82sx6vLhFTl0+Zhn+Zp56
 8E=
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
 Documentation/git-maintenance.adoc | 13 ++++++++
 builtin/gc.c                       | 63 +++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh             | 54 ++++++++++++++++++++++----------
 3 files changed, 113 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 540b5cf68b..bda616f14c 100644
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
+If one or more `--task` options are specified, then those tasks are checked
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
index 85e9a38d10..928c805f02 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -3253,7 +3253,67 @@ static int maintenance_stop(int argc, const char **argv, const char *prefix,
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
+		/*
+		 * When not using --auto we always require maintenance right now.
+		 *
+		 * TODO: this certainly is too eager, as some maintenance tasks may
+		 * decide to not do anything because the data structures are already
+		 * fully optimized. We may eventually want to extend the auto
+		 * condition to also cover non-auto runs so that we can detect such
+		 * cases.
+		 */
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
@@ -3270,6 +3330,7 @@ int cmd_maintenance(int argc,
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


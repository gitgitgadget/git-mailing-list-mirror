Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD71C84C0
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941654; cv=none; b=YOJ+AB3byh5nlHNZM7+qMXpytijHEwE1iybkKPfKPbKow4otVK5qT74itb+usVNBzi4hZLYhGVm1tvxchJ4Qq+EAPJLknhlAI+iEPRD+RCHrXRNSiQvdpIabWtnwFNlWbhg90nTJ5VkSXY1XEhlk17hbEyTf7RYxuKDBDIvykf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941654; c=relaxed/simple;
	bh=AU0rXIeHMNiceK8uw6eWsXGJEPN/kk0iCeF4dtX00ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bo3AhjwG2bKIkiPcRpbK9yVvutWw79khld79Z80CKD+DQU8ojDLj5n1mbjGLkDo4f8P9Aub5hH8JGZ6xOYFYJjh32ASKcCtzAI6XC30YFFBcWIcdv4+8jjoEfTKEVZ/NmXVhrD7g4IwI6EVn4bvgrxpEgBSQsQE5kqhJdhCBQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL9uciuP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL9uciuP"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so2565383a12.3
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741941650; x=1742546450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EZj9PVjfTsk4kQWTNDcPKIoT4f7zMR6mj03B4QqUv0=;
        b=IL9uciuPGwxGlMs2evbgQmkMJ0zAS9dgqrIlZ3Mcb0Ay6XoEnAMb99EudlIY0XB6LF
         5lobbZdVIam/2+Tm3/o+IuErJEFj1RRo8XEfq08s0ItraB3cRwqUd+3PdyZooUBnG078
         YaCnu47t65evyaK2+L1pIPb4oxwuFu/uiAu6PZnJSfImgoKid4i/KQWzjGgDmlleQYXx
         uDBesr2TjnNj+exQ5zj4btZ8s8sUclavp6uPY3jrPtPA2HR3wG5o0HOlyp27G+r9f9MS
         CjUImo/zua7bD69euks6Rr6QQTsnOGsFuQgUYnqJ6VU7QsBFlDhuqoolpIgqCJpbnqS4
         /I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941650; x=1742546450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EZj9PVjfTsk4kQWTNDcPKIoT4f7zMR6mj03B4QqUv0=;
        b=Z+A+chQmw5m+yyj4FW1c7pX4fnHyacTAiqADOLC9cecIFJPqLwyLe7hdnrUVRjamLq
         1paPpCrbWvkI58nzq/j4G2khu53X35/nCtbi1U+E2X4oufhFhm0GecfyAyGDqkRsCDqz
         i3ULcfvWXSnrmx4bgX6ftjsQ7GHb4UeaFVyWMZFmwWEyuddpkkhRjgatbyiAZ+fzVz9y
         Aw4nj6CWSItXL6jYS95rW9U0kpdLevrDAFgfyukbQ0OxjH86ApdJguvRroU98WWKmaNR
         rBNi4XHJRADUiJoFLhtGqaQDHHKVy6l2o33y8Eb2akRwWDt1zp+w1Kro/zJepbHHNoyr
         /iSg==
X-Gm-Message-State: AOJu0YzqhI17M2UV+N7YzVt4morBeQCmGzjMOLWpyRWmqZb+9QywJnl2
	DSieXIK5UO7a0DEotG0A45nX8Lxufn3kCgZIPw4+zHekmIfULsZT
X-Gm-Gg: ASbGncuAuoKs5Ba1bVie2Ovq5cJj+9V5R3ISNuuymgq26AJZwWLZGRwBTNvbvRxG9mD
	6mtMqPkNlbfgKcW8uGshwhmOO/aaKt/oNop1NYdyFm8xiyYVxThX/kgCfkqJEISmmtUHoQkwSWA
	mhMonYeZEpe4JtV88XepJoV2YSTkK36F97OJzJoz4KiaTW63UV9iazZYT5HJ4hfK+mKpBd2CS8c
	RhlKPwJRB9phBb1SwSyPzMbuDqQZOrlzDsO/HHMTAk6ALJax0tNDdr4FW88zpfgD+7Xx42BDS4e
	9PLXRU4ZmsI5ULZfcPm/V24F3SzcnGD0R6VUVZqfYwz64mHc1YU=
X-Google-Smtp-Source: AGHT+IGPnlfAU9ciW2iW6+pgmlfdoa+/E4LaVjsRW0Qqt06NXhOmSHJvKKPLSNRTnfjABn/ZxBsgXQ==
X-Received: by 2002:a17:907:a089:b0:ac2:bcf3:b19b with SMTP id a640c23a62f3a-ac3303db1fbmr178209466b.49.1741941650127;
        Fri, 14 Mar 2025 01:40:50 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f2db:c900:a4aa:e466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314858edcsm191081866b.85.2025.03.14.01.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:40:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 14 Mar 2025 09:40:35 +0100
Subject: [PATCH v3 2/2] reflog: implement subcommand to drop reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
In-Reply-To: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, kristofferhaugsbakk@fastmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10162;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=AU0rXIeHMNiceK8uw6eWsXGJEPN/kk0iCeF4dtX00ik=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfT64+KZV1RwcLsudAppCnVoPbjBrEcWR3IU
 C7QTklCuLQ5QokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn0+uPAAoJED7VnySO
 Rox/uHEL/1hm6kKefpTsW5fDILWA0NQqwLY6PIY2rWwGbQ0zjznIxKPSGtKZJubqKUUwiR1RcCy
 jP61Nh/35/CNEWlbwvm2xznUuGUb5COXf7GMqu3BfM2844TBKTp2Wf9A52561XNJFyWFfHtVAlq
 ZlmV96b/5kSGhuWeopF1lk984A0xoe4Ru8S1doRJNQx0CeKsFPJvdR4p0Hjp6aAhf+rZ8BU/j64
 XkeiZI1zKgP/ioggr+ZWibUGGrRVbrC6WerAr/ogUeF4xHdh+HLiIWMDxa9AyFFRI+uCijtcs05
 ZYZ95kfW8bXr+bjPUQKpem/BzBr+R/j0XMl5LEgZQnFhkinYIwpXssDXCHxey5BX0c+x7lfWhGY
 0CFTJVGuObaOWBCP7JDN0QURIF5rMduLLvieEg5IHqEQiPdG6xkXG7q2YzDmpMgXZyi5+OQA21Z
 yJWl21b61eXRG+RVGvs5s0t6aaX9g7mC56rexGfi/7iICHIZuLJEcf/MPGg3/ygnUJSTHKsxCj6
 cY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While 'git-reflog(1)' currently allows users to expire reflogs and
delete individual entries, it lacks functionality to completely remove
reflogs for specific references. This becomes problematic in
repositories where reflogs are not needed but continue to accumulate
entries despite setting 'core.logAllRefUpdates=false'.

Add a new 'drop' subcommand to git-reflog that allows users to delete
the entire reflog for a specified reference. Include an '--all' flag to
enable dropping all reflogs from all worktrees and an addon flag
'--single-worktree', to only drop all reflogs from the current worktree.

While here, remove an extraneous newline in the file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-reflog.adoc |  23 ++++++--
 builtin/reflog.c              |  66 ++++++++++++++++++++++-
 t/t1410-reflog.sh             | 122 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index a929c52982..b55c060569 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -16,6 +16,7 @@ SYNOPSIS
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
+'git reflog drop' [--all [--single-worktree] | <refs>...]
 'git reflog exists' <ref>
 
 DESCRIPTION
@@ -48,10 +49,14 @@ and not reachable from the current tip, are removed from the reflog.
 This is typically not used directly by end users -- instead, see
 linkgit:git-gc[1].
 
-The "delete" subcommand deletes single entries from the reflog. Its
-argument must be an _exact_ entry (e.g. "`git reflog delete
-master@{2}`"). This subcommand is also typically not used directly by
-end users.
+The "delete" subcommand deletes single entries from the reflog, but
+not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
+reflog delete master@{2}`"). This subcommand is also typically not used
+directly by end users.
+
+The "drop" subcommand completely removes the reflog for the specified
+references. This is in contrast to "expire" and "delete", both of which
+can be used to delete reflog entries, but not the reflog itself.
 
 The "exists" subcommand checks whether a ref has a reflog.  It exits
 with zero status if the reflog exists, and non-zero status if it does
@@ -132,6 +137,16 @@ Options for `delete`
 `--dry-run`, and `--verbose`, with the same meanings as when they are
 used with `expire`.
 
+Options for `drop`
+~~~~~~~~~~~~~~~~~~~~
+
+--all::
+	Drop the reflogs of all references from all worktrees.
+
+--single-worktree::
+	By default when `--all` is specified, reflogs from all working
+	trees are dropped. This option limits the processing to reflogs
+	from the current working tree only.
 
 GIT
 ---
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 762719315e..a3652e69f1 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -29,6 +29,9 @@
 #define BUILTIN_REFLOG_EXISTS_USAGE \
 	N_("git reflog exists <ref>")
 
+#define BUILTIN_REFLOG_DROP_USAGE \
+	N_("git reflog drop [--all [--single-worktree] | <refs>...]")
+
 static const char *const reflog_show_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	NULL,
@@ -54,11 +57,17 @@ static const char *const reflog_exists_usage[] = {
 	NULL,
 };
 
+static const char *const reflog_drop_usage[] = {
+	BUILTIN_REFLOG_DROP_USAGE,
+	NULL,
+};
+
 static const char *const reflog_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	BUILTIN_REFLOG_LIST_USAGE,
 	BUILTIN_REFLOG_EXPIRE_USAGE,
 	BUILTIN_REFLOG_DELETE_USAGE,
+	BUILTIN_REFLOG_DROP_USAGE,
 	BUILTIN_REFLOG_EXISTS_USAGE,
 	NULL
 };
@@ -449,10 +458,64 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
 				   refname);
 }
 
+static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	int ret = 0, do_all = 0, single_worktree = 0;
+	const struct option options[] = {
+		OPT_BOOL(0, "all", &do_all, N_("drop the reflogs of all references")),
+		OPT_BOOL(0, "single-worktree", &single_worktree,
+			 N_("drop reflogs from the current worktree only")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
+
+	if (argc && do_all)
+		usage(_("references specified along with --all"));
+
+	if (do_all) {
+		struct worktree_reflogs collected = {
+			.reflogs = STRING_LIST_INIT_DUP,
+		};
+		struct string_list_item *item;
+		struct worktree **worktrees, **p;
+
+		worktrees = get_worktrees();
+		for (p = worktrees; *p; p++) {
+			if (single_worktree && !(*p)->is_current)
+				continue;
+			collected.worktree = *p;
+			refs_for_each_reflog(get_worktree_ref_store(*p),
+					     collect_reflog, &collected);
+		}
+		free_worktrees(worktrees);
+
+		for_each_string_list_item(item, &collected.reflogs)
+			ret |= refs_delete_reflog(get_main_ref_store(repo),
+						     item->string);
+		string_list_clear(&collected.reflogs, 0);
+
+		return ret;
+	}
+
+	for (int i = 0; i < argc; i++) {
+		char *ref;
+		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
+			ret |= error(_("reflog could not be found: '%s'"), argv[i]);
+			continue;
+		}
+
+		ret |= refs_delete_reflog(get_main_ref_store(repo), ref);
+		free(ref);
+	}
+
+	return ret;
+}
+
 /*
  * main "reflog"
  */
-
 int cmd_reflog(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -465,6 +528,7 @@ int cmd_reflog(int argc,
 		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
 		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
 		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
+		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
 		OPT_END()
 	};
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 1f7249be76..42b501f163 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -551,4 +551,126 @@ test_expect_success 'reflog with invalid object ID can be listed' '
 	)
 '
 
+test_expect_success 'reflog drop non-existent ref' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog exists refs/heads/non-existent &&
+		test_must_fail git reflog drop refs/heads/non-existent 2>stderr &&
+		test_grep "error: reflog could not be found: ${SQ}refs/heads/non-existent${SQ}" stderr
+	)
+'
+
+test_expect_success 'reflog drop' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop multiple references' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop refs/heads/main refs/heads/branch &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop multiple references some non-existent' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		test_must_fail git reflog exists refs/heads/non-existent &&
+		test_must_fail git reflog drop refs/heads/main refs/heads/non-existent refs/heads/branch 2>stderr &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch &&
+		test_must_fail git reflog exists refs/heads/non-existent &&
+		test_grep "error: reflog could not be found: ${SQ}refs/heads/non-existent${SQ}" stderr
+	)
+'
+
+test_expect_success 'reflog drop --all' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop --all &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop --all multiple worktrees' '
+	test_when_finished "rm -rf repo" &&
+	test_when_finished "rm -rf wt" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git worktree add ../wt &&
+		test_commit_bulk -C ../wt --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop --all &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop --all --single-worktree' '
+	test_when_finished "rm -rf repo" &&
+	test_when_finished "rm -rf wt" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git worktree add ../wt &&
+		test_commit -C ../wt foobar &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/wt &&
+		test-tool ref-store worktree:wt reflog-exists HEAD &&
+		git reflog drop --all --single-worktree &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/wt &&
+		test_must_fail test-tool ref-store worktree:main reflog-exists HEAD &&
+		test-tool ref-store worktree:wt reflog-exists HEAD
+	)
+'
+
+test_expect_success 'reflog drop --all with reference' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_must_fail git reflog drop --all refs/heads/main 2>stderr &&
+		test_grep "usage: references specified along with --all" stderr
+	)
+'
+
 test_done

-- 
2.48.1


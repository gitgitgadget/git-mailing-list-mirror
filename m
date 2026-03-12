Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFD238C1B
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322003; cv=none; b=ICGVmuTCPUux5axdrGlDer/Crf0pv584Z/HuH3TU5EtCm4IJXo5QFr0ZiEN3GZ0VTvpEJd6OG0UTUkLhy/TbUnBJwlOsO6d60pljk6zs369en0v3L7E56RfEzU9PWlyimEQwAFnt56TKLK5EmzMfeGq9IZvWwmZ36G+XWKhx8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322003; c=relaxed/simple;
	bh=DjumGvCW4MRPNuAXBcbsnSJyY2dfxgab0e/XomRxe7s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bdGIZXUrI2uoSKq9t1ANGsnk4opVdTrhs6S7uTCXsysSM76vnUVmT50cJJMp++VkzVweSgFCMlqiSnOTyHJd/wX17XbnYSkBPavUuYpoziQwCasp6yb9UpLjsNO7OYbG1Nlqwdpj3bWKDOjeWz2on9UMJJss138KUu7+P4zCJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDKpBEXP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDKpBEXP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50917417efbso9246041cf.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773322000; x=1773926800; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wAyFeejlJ6LKmTEKkpFD80eN3iNnXO0+rooPTB/vqLk=;
        b=IDKpBEXPGRZjca0krRBpxHRia2kNZdl2hMFdVaCQoFbpg1QvMs1pbPVGGK4CUc2s9Z
         76smuydWR8JakqmZ1GG2ammhdEOoGCBGR4aScm+Yy6xXSwGs8lhlII9MNE7NRhOZ6jRw
         xINT1RX8Wo72Fuq37USrWjhB4dlYnCbc+oAQa1DRASsBYVBudvvySjQMWF//0V9OAv7+
         pXG/wh4L73SG+6GokV2Ukf/kvSIywTjys6qzNRG9LAWPFxPNjDlghks4J0L5rSRJJe2q
         RANfdy9qISlV/365+9JyvWazjdEz8Yyd7bmPhzX1EnQB8cTktUPCHRVnx9ohHeblt/WB
         Nt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322000; x=1773926800;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAyFeejlJ6LKmTEKkpFD80eN3iNnXO0+rooPTB/vqLk=;
        b=j1oZfaJ353jt5K9YqLQXK4c9rXq+QrpeqxSvhBV73xWDpRkKn0hDCfbx3FMa4CY6xs
         lBfS2GYorE1GtqYH1p6TueD3cMW+GPFjBNaLnkapoln4Tp4zit29PL7hDlrgrhsBRVlg
         XD1kH7Z6qmVWmCfEPH5p9m4eTEoihIwjnPpke8hg9FRzMLoO6McQpHEd6nFl7WKxSeWQ
         kvvrZc8zxyv/x6EFAksd+EO+ekWHZHWmyXZPtdmqE+Sxwv5fN8h2ozkE9CyCgipFCmxT
         HG5ouObdjx8qUIuO/AjRNwfZIy3XpbIlWCBScV3R49GMX1fLhfvRFCV++axlK1kSXh4K
         N7xA==
X-Gm-Message-State: AOJu0Yz7IWma3/9NYGav+QBmxMF8mxAu6+MGjAxtRItoJtSQ+c8G0mfC
	N/sxe68k0kuaxDH1DtlymNv6J5UeNVCq/7eAo9FCP+p+Qe0BLbaSKrkpeskdfw==
X-Gm-Gg: ATEYQzwjPLrvedXLxadena+V/UZf4swcRlO5F8FZaWbmNqX9ZbKHIEH8TYoNW5EUdQm
	JlxinKlksh7c5Xzl0Q/xLEjU1E09Nhe7DVkUzeDag51AOb9X9+9LbIi9WH0PKBZMZCqc2gA6Ah8
	Fr2I8ieULAZZDLu2sCYfoqg7l/ysBr90ck7qd40bUYBKgKDZ+ad90zxcl63r/t6GORdG7X57aUP
	EI87B7HhLR68Syzldas31SjCxHzZK4qJFWHxU95BMY/Hp6NX9tbo2ABtXjeposPpob0X91gtMqJ
	MsH4VBk29z3ZjNjwXy3vjA8jjYZ3mm2sfHxB4yiGGQ7eMrw8+blg9li5Urv9TFRjHOqxTCQ6PUf
	qGZLtJqZfvNP9EXudrmH7l3cd8wE0P1DV/ZqQnQ49VMU+CqoRFTsONdhped/OXQMEezOYkKTxhV
	wkxoWbx9+WmTY+QdlB5vAj0nQ=
X-Received: by 2002:ac8:580c:0:b0:509:1dc8:e9e4 with SMTP id d75a77b69052e-509471ff524mr43537361cf.22.1773322000178;
        Thu, 12 Mar 2026 06:26:40 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.151.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0ea1d1sm37280571cf.22.2026.03.12.06.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:26:39 -0700 (PDT)
Message-Id: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 13:26:38 +0000
Subject: [PATCH] checkout: add --autostash option for branch switching
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When switching branches, local modifications in the working tree can
prevent the checkout from succeeding.  While "git rebase" and "git
merge" already support --autostash to handle this case automatically,
"git checkout" and "git switch" require users to manually stash and
unstash their changes.

Teach "git checkout" and "git switch" to accept --autostash and
--no-autostash options that automatically create a temporary stash
entry before the branch switch begins and apply it after the switch
completes.  If the stash application results in conflicts, the stash
entry is saved to the stash list so the user can resolve them later.

Also add a checkout.autoStash configuration option that enables this
behavior by default, which can be overridden with --no-autostash on
the command line.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: 'autostash' for branch switching

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v1
Pull-Request: https://github.com/git/git/pull/2234

 Documentation/config/checkout.adoc |  12 ++
 Documentation/git-checkout.adoc    |   9 ++
 Documentation/git-switch.adoc      |   9 ++
 builtin/checkout.c                 |  16 +++
 t/meson.build                      |   1 +
 t/t2061-switch-autostash.sh        | 181 +++++++++++++++++++++++++++++
 t/t9902-completion.sh              |   1 +
 7 files changed, 229 insertions(+)
 create mode 100755 t/t2061-switch-autostash.sh

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/checkout.adoc
index e35d212969..2e157c5398 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -36,6 +36,18 @@ with a small number of cores, the default sequential checkout often performs
 better. The size and compression level of a repository might also influence how
 well the parallel version performs.
 
+`checkout.autoStash`::
+	When set to true, automatically create a temporary stash entry
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run `git checkout` or `git switch`
+	on a dirty worktree.  However, use with care: the final stash
+	application after a successful branch switch might result in
+	non-trivial conflicts.
+	This option can be overridden by the `--no-autostash` and
+	`--autostash` options of linkgit:git-checkout[1] and
+	linkgit:git-switch[1].
+	Defaults to false.
+
 `checkout.thresholdForParallelism`::
 	When running parallel checkout with a small number of files, the cost
 	of subprocess spawning and inter-process communication might outweigh
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..96d9bf9203 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -272,6 +272,15 @@ When switching branches with `--merge`, staged changes may be lost.
 	`merge.conflictStyle` configuration variable.  Possible values are
 	`merge` (default), `diff3`, and `zdiff3`.
 
+`--autostash`::
+`--no-autostash`::
+	When switching branches, automatically create a temporary stash
+	entry before the operation begins, and apply it after the
+	operation ends.  This means that you can switch branches on a
+	dirty worktree.  However, use with care: the final stash
+	application after a successful branch switch might result in
+	non-trivial conflicts.
+
 `-p`::
 `--patch`::
 	Interactively select hunks in the difference between the
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..b296df2a0b 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -142,6 +142,15 @@ should result in deletion of the path).
 	`merge.conflictStyle` configuration variable.  Possible values are
 	`merge` (default), `diff3`, and `zdiff3`.
 
+`--autostash`::
+`--no-autostash`::
+	Automatically create a temporary stash entry before the
+	operation begins, and apply it after the operation ends.
+	This means that you can switch branches on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful branch switch might result in non-trivial
+	conflicts.
+
 `-q`::
 `--quiet`::
 	Quiet, suppress feedback messages.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1d1667fa4c..453dbe3230 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -30,6 +30,7 @@
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "sequencer.h"
 #include "setup.h"
 #include "submodule.h"
 #include "symlinks.h"
@@ -68,6 +69,7 @@ struct checkout_opts {
 	int only_merge_on_switching_branches;
 	int can_switch_when_in_progress;
 	int orphan_from_empty_tree;
+	int autostash;
 	int empty_pathspec_ok;
 	int checkout_index;
 	int checkout_worktree;
@@ -1202,9 +1204,16 @@ static int switch_branches(const struct checkout_opts *opts,
 			do_merge = 0;
 	}
 
+	if (opts->autostash) {
+		if (repo_read_index(the_repository) < 0)
+			die(_("index file corrupt"));
+		create_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
+	}
+
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
+			apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
 			branch_info_release(&old_branch_info);
 			return ret;
 		}
@@ -1215,6 +1224,8 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
+
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	branch_info_release(&old_branch_info);
 
@@ -1236,6 +1247,10 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.autostash")) {
+		opts->autostash = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
@@ -1745,6 +1760,7 @@ static struct option *add_common_switch_branch_options(
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is using this branch")),
+		OPT_AUTOSTASH(&opts->autostash),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
diff --git a/t/meson.build b/t/meson.build
index f66a73f8a0..0645253d25 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -275,6 +275,7 @@ integration_tests = [
   't2030-unresolve-info.sh',
   't2050-git-dir-relative.sh',
   't2060-switch.sh',
+  't2061-switch-autostash.sh',
   't2070-restore.sh',
   't2071-restore-patch.sh',
   't2072-restore-pathspec-file.sh',
diff --git a/t/t2061-switch-autostash.sh b/t/t2061-switch-autostash.sh
new file mode 100755
index 0000000000..6409a2afbf
--- /dev/null
+++ b/t/t2061-switch-autostash.sh
@@ -0,0 +1,181 @@
+#!/bin/sh
+
+test_description='checkout/switch --autostash tests'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo file0content >file0 &&
+	echo file1content >file1 &&
+	git add . &&
+	test_tick &&
+	git commit -m "initial commit" &&
+	git branch other-branch &&
+	echo file1main >file1 &&
+	git add . &&
+	test_tick &&
+	git commit -m "modify file1 on main" &&
+	git checkout other-branch &&
+	echo file1other >file1 &&
+	git add . &&
+	test_tick &&
+	git commit -m "modify file1 on other-branch" &&
+	echo file2content >file2 &&
+	git add . &&
+	test_tick &&
+	git commit -m "add file2 on other-branch" &&
+	git checkout main
+'
+
+test_expect_success 'switch --autostash on dirty worktree' '
+	git branch branch1 other-branch &&
+	echo dirty >file0 &&
+	git switch --autostash branch1 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'checkout --autostash on dirty worktree' '
+	git branch branch2 other-branch &&
+	echo dirty >file0 &&
+	git checkout --autostash branch2 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git checkout main
+'
+
+test_expect_success 'switch: checkout.autostash config' '
+	git branch branch3 other-branch &&
+	echo dirty >file0 &&
+	test_config checkout.autostash true &&
+	git switch branch3 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'checkout: checkout.autostash config' '
+	git branch branch4 other-branch &&
+	echo dirty >file0 &&
+	test_config checkout.autostash true &&
+	git checkout branch4 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git checkout main
+'
+
+test_expect_success '--no-autostash overrides checkout.autostash' '
+	git branch branch5 other-branch &&
+	echo dirty >file1 &&
+	test_config checkout.autostash true &&
+	test_must_fail git switch --no-autostash branch5 2>stderr &&
+	test_grep ! "Created autostash" stderr &&
+	git checkout -- file1
+'
+
+test_expect_success '--autostash overrides checkout.autostash=false' '
+	git branch branch6 other-branch &&
+	echo dirty >file0 &&
+	test_config checkout.autostash false &&
+	git switch --autostash branch6 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'autostash with dirty index' '
+	git branch branch7 other-branch &&
+	echo dirty-index >file0 &&
+	git add file0 &&
+	git switch --autostash branch7 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty-index >expected &&
+	test_cmp expected file0 &&
+	git checkout -- file0 &&
+	git switch main
+'
+
+test_expect_success 'autostash bypasses conflicting local changes' '
+	git branch branch8 other-branch &&
+	echo dirty >file1 &&
+	test_must_fail git switch branch8 2>stderr &&
+	test_grep "Your local changes" stderr &&
+	git switch --autostash branch8 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard &&
+	git switch main
+'
+
+test_expect_success 'autostash is a no-op with clean worktree' '
+	git branch branch9 other-branch &&
+	git switch --autostash branch9 >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	git switch main
+'
+
+test_expect_success '--autostash with --merge stashes and switches' '
+	git branch branch10 other-branch &&
+	echo dirty >file0 &&
+	git switch --autostash --merge branch10 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main
+'
+
+test_expect_success 'autostash with staged conflicting changes' '
+	git branch branch11 other-branch &&
+	echo staged-change >file1 &&
+	git add file1 &&
+	git switch --autostash branch11 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard &&
+	git switch main
+'
+
+test_expect_success '--autostash with --force preserves dirty changes' '
+	git branch branch12 other-branch &&
+	echo dirty-force >file1 &&
+	git switch --autostash --force branch12 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard &&
+	git switch main
+'
+
+test_expect_success '--autostash with new branch creation' '
+	echo dirty >file0 &&
+	git switch --autostash -c branch13 >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	echo dirty >expected &&
+	test_cmp expected file0 &&
+	git switch main &&
+	git branch -D branch13
+'
+
+test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..f33ca543a9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2602,6 +2602,7 @@ test_expect_success 'double dash "git checkout"' '
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
 	--auto-advance Z
+	--autostash Z
 	--progress Z
 	--guess Z
 	--no-guess Z

base-commit: 7f19e4e1b6a3ad259e2ed66033e01e03b8b74c5e
-- 
gitgitgadget

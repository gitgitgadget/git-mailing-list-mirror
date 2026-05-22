Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB476390228
	for <git@vger.kernel.org>; Fri, 22 May 2026 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491551; cv=none; b=rQhW8OV+iSz4U0pJE5stgsPmnlZd+fkj7C++vmkZhueRCegkkcUw2RUFaE71b+C2tpv389KKf6UKnAPqp59kFPOoOtHgS/NXOEuFfgkVBha9vYi7L9iZnsPyHPViuqShtkLuBtjsAX5DEpD0OLnL36DMAPYeTvo8cehCP2D36ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491551; c=relaxed/simple;
	bh=NU1u3wpWbtbXeWvfmROgPVnOUfx+1/B4jlqlXb4lfPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j9fY/PH4vgpq8TrUZo2ckF30SpKDQRPS13EZ3es2cbiJa9Jj/8G3dnNsHTHYtWeRwDkvFAFnKEXTBVc2QbsuJ6y/41jqU7fLLyThGMa2CcKVXd9pdX++DjvMbAcQUU9xXLq8UOaSH5XegZaCnFxWMcgMGUghqm9KLLhZ+bc0jjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAZyUF4Z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAZyUF4Z"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-512f750d4b2so87358921cf.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 16:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779491547; x=1780096347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u8I5YhqGUSZ3K0Aab5x1zyY+8ql9EUt69VTpOJu4PU=;
        b=hAZyUF4Z2t+bPp6AmBQuusSBMNbixaPTAa0hV9nBydmSga1x4DgLkQ/h7FCjBcdhrW
         f6CcNqxAUkPz+dytKgJgEO8uiq1pHBbThMLLq4FN8IurDWtRMPFOObMNE8tEOgRiL+7N
         Q1j1ugK4xhXHh7keL/0YRoRYaVxojeA2l5nF4WZU9EKUyPAkPV6bnUQDjoMwarKolQDS
         mAwcqsLTONXketN5Zxq4ISuzQ2m+M25nf6sIb2LqcgxQi/CzJFQhesAb0/oWbuGeit1A
         AIHfqxD4crQu74X/HzZ18Na1h26C0vMLrt9lk5CKDurOoqcHkRLr15FGV2K80x1UUDMz
         E1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491547; x=1780096347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/u8I5YhqGUSZ3K0Aab5x1zyY+8ql9EUt69VTpOJu4PU=;
        b=PpPI+NvQJpMlSnT+u1kmE5Qztso7JjKPZcnO3znlo0/TMRdRcyDfI9IShMfeToRGRr
         Ilmo1cNgckIwJjRY+PS0Qi6h3Wc23dWc9zeXi6bfgeu3BOVDmBuT/VENxP32AgC1gVGw
         rjoOker2vyVj/zZ4ntrS2Ab4BP4MvM+9O6HUFc+zyIeKWAdKLbBoNd06uOqgj3FH3yY9
         EeLNp2Tdf7LFnyzdb4azrx1J53A+4iUWUIwgmVk66l3UP5Gnh8LoiD8DIlszPCumuriX
         0yLCb9yLd3jWaI7Ypwltb1jyg2PPIQ+baNA+5oa/iHQ8xpKYgiH2V2SSivbYqihGL98B
         8+JQ==
X-Gm-Message-State: AOJu0YxjJzdmgeSLPUGLiqKI7JmnhnkbFFF9+POT/R3bz3zq2JiOr6Bo
	BAP9kANW30AYiMP5OhLpUMXF74Du0z+rU2PAWUzh2YGAoTsmPJknVS/9AZ2BBQ==
X-Gm-Gg: Acq92OH0XBOGdIvr2Ue63GuiDey4b5jCN0dvb3W6dhWJGvmr6rJ5ipomCMrDHTrLVyG
	GCqwnULay1MWZlBwY2xfEPvqsauxppoX3ktierwXaSJkUifax+Xvf+aoS1m0F0u8hkSzsdldCDt
	yF3r6ol/9okqiLQKQKA58dFEQ6cRIzQBsFNA4ispY7QM+WSy2BIYxaplCAEB/8Tblh6e1JrB7aN
	AtOG/c13nNr/3WRQ0x3ZCSV3KZyWn+wJM34OsXy0B24AfSbjpwT+SKQsFaHpF1NcukR2nPyEhVm
	Aj6VEwxabih//V8BRKiVoN3ctRpBMyo+SFFS2LqIYg2s1/QkdaQlz/oo+2li8yC4Tv0W20NHO0K
	1Hyk6FxbppgEWNO/BWRTg+KSMNXrjNTVpjqY7TlJJw7sRRMClWd+HHY2qzTK0hWAwm2i5PYK1Mp
	FokeZBkSr/jxH4jYud6Z8GMha/EBE=
X-Received: by 2002:a05:622a:90:b0:516:e236:1d3e with SMTP id d75a77b69052e-516e236221dmr7199081cf.6.1779491547564;
        Fri, 22 May 2026 16:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cb9650sm26281441cf.22.2026.05.22.16.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:12:27 -0700 (PDT)
Message-Id: <pull.2306.v2.git.git.1779491545531.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
References: <pull.2306.git.git.1779194605735.gitgitgadget@gmail.com>
From: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 23:12:25 +0000
Subject: [PATCH v2] stash: reuse cached index entries in --patch temporary
 index
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
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Victoria Dye <vdye@github.com>,
    Adam Johnson <me@adamj.eu>,
    Adam Johnson <me@adamj.eu>

From: Adam Johnson <me@adamj.eu>

`git stash -p` prepares the interactive selection by creating a
temporary index at HEAD, switching `GIT_INDEX_FILE` to it, and then
running the `add -p` machinery.

That temporary index was created by running `git read-tree HEAD`.  The
resulting index had no useful cached stat data or fsmonitor-valid bits
from the real index.  When `run_add_p()` refreshed that temporary index
before showing the first prompt, it could end up lstat(2)-ing every
tracked file, even in a repository where `git diff` and `git restore -p`
can use fsmonitor to avoid that work.

Create the temporary index in-process instead.  Use `unpack_trees()` to
reset the real index contents to HEAD while writing the result to the
temporary index path.  For paths whose index entries already match HEAD,
`oneway_merge()` reuses the existing cache entries, preserving their
cached stat data and `CE_FSMONITOR_VALID` state.

This makes the refresh performed by `run_add_p()` behave like the one
used by `git restore -p`: unchanged paths can be skipped via fsmonitor
instead of being scanned again.

In a 206k file repository with `core.fsmonitor` enabled and a one-line
change in one file, time to first prompt dropped from 34.774 seconds to
0.659 seconds. The new perf test file demonstrates similar improvements,
with maen times for without- and with-fsmonitor cases dropping from 6.90
and 6.83 seconds to 0.55 and 0.28 seconds, respectively.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    stash: reuse cached index entries in --patch temporary index

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2306%2Fadamchainz%2Faj%2Foptimize-stash-patch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2306/adamchainz/aj/optimize-stash-patch-v2
Pull-Request: https://github.com/git/git/pull/2306

Range-diff vs v1:

 1:  b228160cc4 ! 1:  8785572c4d stash: reuse cached index entries in --patch temporary index
     @@ Commit message
      
          In a 206k file repository with `core.fsmonitor` enabled and a one-line
          change in one file, time to first prompt dropped from 34.774 seconds to
     -    0.659 seconds.
     +    0.659 seconds. The new perf test file demonstrates similar improvements,
     +    with maen times for without- and with-fsmonitor cases dropping from 6.90
     +    and 6.83 seconds to 0.55 and 0.28 seconds, respectively.
      
          Signed-off-by: Adam Johnson <me@adamj.eu>
      
     @@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int
      +	struct lock_file lock_file = LOCK_INIT;
      +
      +	repo_read_index_preload(the_repository, NULL, 0);
     -+	if (refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL))
     -+		return -1;
     ++	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
      +
      +	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
      +
     @@ builtin/stash.c: static int stash_patch(struct stash_info *info, const struct pa
       		goto done;
       	}
      
     - ## t/t3904-stash-patch.sh ##
     -@@ t/t3904-stash-patch.sh: test_expect_success 'none of this moved HEAD' '
     - 	verify_saved_head
     - '
     - 
     -+test_expect_success 'stash -p with unmodified tracked files present' '
     -+	git reset --hard &&
     -+	echo line1 >alpha &&
     -+	echo line1 >beta &&
     -+	git add alpha beta &&
     -+	git commit -m "add alpha and beta" &&
     -+	echo line2 >>alpha &&
     -+	echo y | git stash -p &&
     -+	echo line1 >expect &&
     -+	test_cmp expect alpha &&
     -+	test_cmp expect beta &&
     -+	git stash pop &&
     -+	printf "line1\nline2\n" >expect &&
     -+	test_cmp expect alpha &&
     -+	echo line1 >expect &&
     -+	test_cmp expect beta
     + ## t/perf/p3904-stash-patch.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description="Performance tests for git stash -p"
     ++
     ++. ./perf-lib.sh
     ++
     ++test_perf_fresh_repo
     ++
     ++test_expect_success "setup" '
     ++	mkdir files &&
     ++	test_seq 1 100000 | while read i; do
     ++		echo "content $i" >files/$i.txt || return 1
     ++	done &&
     ++	git add files/ &&
     ++	git commit -q -m "add tracked files" &&
     ++	echo modified >files/1.txt
      +'
      +
     - test_expect_success 'stash -p with split hunk' '
     - 	git reset --hard &&
     - 	cat >test <<-\EOF &&
     ++test_perf "stash -p, no fsmonitor" \
     ++	--setup 'echo modified >files/1.txt' '
     ++	printf "q\n" | git stash -p >/dev/null 2>&1 || true
     ++'
     ++
     ++if test_have_prereq FSMONITOR_DAEMON
     ++then
     ++	test_expect_success "enable builtin fsmonitor" '
     ++		git config core.fsmonitor true &&
     ++		git fsmonitor--daemon start &&
     ++		git update-index --fsmonitor &&
     ++		git status >/dev/null 2>&1
     ++	'
     ++
     ++	test_perf "stash -p, builtin fsmonitor" \
     ++		--setup 'echo modified >files/1.txt && git status >/dev/null 2>&1' '
     ++		printf "q\n" | git stash -p >/dev/null 2>&1 || true
     ++	'
     ++
     ++	test_expect_success "stop builtin fsmonitor" '
     ++		git fsmonitor--daemon stop
     ++	'
     ++fi
     ++
     ++test_done


 builtin/stash.c             | 70 +++++++++++++++++++++++++++++++++----
 t/perf/p3904-stash-patch.sh | 43 +++++++++++++++++++++++
 2 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100755 t/perf/p3904-stash-patch.sh

diff --git a/builtin/stash.c b/builtin/stash.c
index 32dbc97b47..c4809f299a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -372,6 +372,56 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	return 0;
 }
 
+static int create_index_from_tree(const struct object_id *tree_id,
+				  const char *index_path)
+{
+	int nr_trees = 1;
+	int ret = 0;
+	struct unpack_trees_options opts;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
+	struct lock_file lock_file = LOCK_INIT;
+
+	repo_read_index_preload(the_repository, NULL, 0);
+	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
+
+	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+
+	memset(&opts, 0, sizeof(opts));
+
+	tree = repo_parse_tree_indirect(the_repository, tree_id);
+	if (!tree || repo_parse_tree(the_repository, tree)) {
+		ret = -1;
+		goto done;
+	}
+
+	init_tree_desc(t, &tree->object.oid, tree->buffer, tree->size);
+
+	opts.head_idx = 1;
+	opts.src_index = the_repository->index;
+	opts.dst_index = &dst_istate;
+	opts.merge = 1;
+	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	opts.fn = oneway_merge;
+
+	if (unpack_trees(nr_trees, t, &opts)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (write_locked_index(&dst_istate, &lock_file, COMMIT_LOCK)) {
+		ret = error(_("unable to write new index file"));
+		goto done;
+	}
+
+done:
+	release_index(&dst_istate);
+	if (ret)
+		rollback_lock_file(&lock_file);
+	return ret;
+}
+
 static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1321,18 +1371,26 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct interactive_options *interactive_opts)
 {
 	int ret = 0;
-	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
+	struct commit *head_commit;
+	const struct object_id *head_tree;
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 	char *old_index_env = NULL, *old_repo_index_file;
 
 	remove_path(stash_index_path.buf);
 
-	cp_read_tree.git_cmd = 1;
-	strvec_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
-	strvec_pushf(&cp_read_tree.env, "GIT_INDEX_FILE=%s",
-		     stash_index_path.buf);
-	if (run_command(&cp_read_tree)) {
+	head_commit = lookup_commit(the_repository, &info->b_commit);
+	if (!head_commit || repo_parse_commit(the_repository, head_commit)) {
+		ret = -1;
+		goto done;
+	}
+	head_tree = get_commit_tree_oid(head_commit);
+	if (!head_tree) {
+		ret = -1;
+		goto done;
+	}
+
+	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
 		ret = -1;
 		goto done;
 	}
diff --git a/t/perf/p3904-stash-patch.sh b/t/perf/p3904-stash-patch.sh
new file mode 100755
index 0000000000..4cfce638be
--- /dev/null
+++ b/t/perf/p3904-stash-patch.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description="Performance tests for git stash -p"
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+test_expect_success "setup" '
+	mkdir files &&
+	test_seq 1 100000 | while read i; do
+		echo "content $i" >files/$i.txt || return 1
+	done &&
+	git add files/ &&
+	git commit -q -m "add tracked files" &&
+	echo modified >files/1.txt
+'
+
+test_perf "stash -p, no fsmonitor" \
+	--setup 'echo modified >files/1.txt' '
+	printf "q\n" | git stash -p >/dev/null 2>&1 || true
+'
+
+if test_have_prereq FSMONITOR_DAEMON
+then
+	test_expect_success "enable builtin fsmonitor" '
+		git config core.fsmonitor true &&
+		git fsmonitor--daemon start &&
+		git update-index --fsmonitor &&
+		git status >/dev/null 2>&1
+	'
+
+	test_perf "stash -p, builtin fsmonitor" \
+		--setup 'echo modified >files/1.txt && git status >/dev/null 2>&1' '
+		printf "q\n" | git stash -p >/dev/null 2>&1 || true
+	'
+
+	test_expect_success "stop builtin fsmonitor" '
+		git fsmonitor--daemon stop
+	'
+fi
+
+test_done

base-commit: 7bcaabddcf68bd0702697da5904c3b68c52f94cf
-- 
gitgitgadget

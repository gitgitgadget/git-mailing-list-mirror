Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FD386C0F
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710580; cv=none; b=icYDDYafBIRhsEernRXvaGIDxRqI1rq9ss1GDSiSok6Jj1DOBtPlvpDXZ5wJRhycT5hiUruVdtM1mNV8/k7k3eP0InbCwXU3RmWGzTi9r16sYno21x06wMiFfqU3VwXIUcU7dB3LxUaEMWhaFOvBhdD5L3oIpzWs72eIXPAYbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710580; c=relaxed/simple;
	bh=0Nld2awgDEBat3BG/dLY1sfCaKnUU/QJAfZK6QwBwEM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LGjqkWEHu8TihEAyBbc7gBpZfLoXf5vlHtkheDEBgVhlcUTYMtEJfGkW68f2Mr1cbxbtCj7szQOuVTayMLN/nKDoUzAFR4A65TWw3GWvgclWzbRKT7uOPbZuhMn9A4B71jrkiIonuVeWs3JpeeCLz0N2NMxut9o/d/ypnVEkvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYUsOird; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYUsOird"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3825b0fbso777117285a.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 03:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772710577; x=1773315377; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZzkhTZQShaczFSyP4Z22whFmFTyCScaQB8cOKrKGPc=;
        b=iYUsOird6neiT8x9idUOdDzgVx0zd8J69yhCqQ5w1L/fW2m/1Plh6yrNV2E+avb0Vc
         7PkDFdKUo0vLvr701ZjFF8IWz8sOEtetMaEYZZ31oyOSfSENYLZN7Q5vimtjY0bHTrua
         JpN791Q5n95vtGWtK5N8+raVmMSnr4iiQIejicNHsMy6UWUeTNrf1H+sp5HdG+/jTzZ7
         9F6vGBsVb7Y+AYL/fZIAH0k30DMmRIlUTrEJh5RqaSLxy+f4SkALxc3n6h7JE9H6YnsL
         M7jqtofQJpte0jDz8RBzyk1Abl8gnpQWq1satYM1TZ3bCEim8Ei2aiWoY855QqLNw9aC
         hsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710577; x=1773315377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZzkhTZQShaczFSyP4Z22whFmFTyCScaQB8cOKrKGPc=;
        b=IsRjRMjP0WwkTFuNc07FVC0TiJ7Q5wNt9BXEnhD20VzAEr5kYVBAWReUzcDzWLqJeY
         yAT7N0evzsr25H6eHrVVrmxmIeGO16epVDjnInd3kOsdaMZQDmhAOTKrV7oPQz3EUiXa
         k5MTRio9IpLtVV7UM6ee/0eCjCpsOpH2FHtxmzIOH0AgivHlHUpmO0E0NOeh9fna+oEe
         Of8i43Eze/RNbn5KEA4ydp6gSSPfbhF+GICSR97HIMILN02G5jf1cRYAIkCb/xLsl4Y+
         1QPKMnuGWcWC4/e8XcutB2fSZkyT9QsXQKJGlcC0xWnHPKSrelDuMqCjT+a9WXVLGnk2
         3kdg==
X-Gm-Message-State: AOJu0Ywl3pwKkfEF0JIJr/Q3Q9QxX6niA3U4Obn4agekuuvPQ4ch7awK
	7v3c3BRTcPrbH4dvCqd1aRQRLmakzG0X5oARi+U7no8J544lc2V/2XLQQBic6A==
X-Gm-Gg: ATEYQzwTypbKKCMTdqRCpEReFSD6BTfBtkbGpOYVD3TOH80Xs+8Xr0+Aiyk4xqaQmbf
	Ai1JD8Ot8ElINBDdC0mVQ6cPjiKRP6r8ObmQEvypei5D9iClv6763HbD7NDrCyq72dc2Hj+04fE
	lzTE4bfvZIO0bfodn8JdzT9PQtM5BPSxupsHidsJ7/VauDYZ0JF5mmEWMjJJeChJ8UfhviV12xa
	t2IqvCHbEloG138viBlONENyoO49ixiGMucuFBLMiA7DuaFKvkfe2SDrkORRch9Uuaw5zeobvq3
	vBL4TVn/8taub6LmwLVvC8z0QgdOIEApE7ePYo4WUCV/YYC6oatqBWBzLQrQcGlEPiqaHXWUEpL
	Rq5kZ4S4/FRqfBCt2zH528Io/8roI+BidiIKWax81TV1dqqFEvOHMhjjvTMwIlcLxJ+Vy14CLMB
	5HsGPy6Ma/asI/h4ipCmH3JBg=
X-Received: by 2002:a05:620a:4892:b0:8cb:3b09:9ce7 with SMTP id af79cd13be357-8cd5aec017emr722211785a.5.1772710576943;
        Thu, 05 Mar 2026 03:36:16 -0800 (PST)
Received: from [127.0.0.1] ([68.154.54.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6534f3sm1830015485a.5.2026.03.05.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:36:16 -0800 (PST)
Message-Id: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
In-Reply-To: <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com>
References: <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com>
From: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 11:36:06 +0000
Subject: [PATCH v4] add: support pre-add hook
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Chandra Kethi-Reddy <chandrakr@pm.me>,
    Chandra Kethi-Reddy <chandrakr@pm.me>

From: Chandra Kethi-Reddy <chandrakr@pm.me>

"git add" has no hook that lets users inspect what is about to be
staged. Users who want to reject certain paths or content must
wrap the command in a shell alias or wait for pre-commit, which
fires too late to prevent staging.

Introduce a "pre-add" hook so that users can inspect or reject
proposed index updates at staging time.

  $1 -- index path used by this invocation (may not exist yet)
  $2 -- lockfile path containing proposed staged index state

Hook authors can inspect the result with ordinary Git commands:

  GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD

Both files should be treated as read-only. Exiting with non-zero
status rejects the update and leaves the index unchanged.

The hook accepts or rejects the entire proposed update. Per-path
filtering is not supported.

The hook is bypassed with "--no-verify" and is not invoked for
--interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
which stages through its own code path.

Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
---
    add: support pre-add hook
    
    
    Summary
    =======
    
     * v4 fixed various documentation/code refactoring issues and clarifies
       that per-path filtering is not supported.
    
    
    Notes
    =====
    
     * This design intentionally trades ODB prevention for correctness of
       hook inputs: blobs may already be written to object storage when the
       hook runs, but hook rejection still leaves the on-disk index
       unchanged
     * AI Disclosure: Codex and Claude Code CLI were used to assist
       drafting. All tests, code, and docs were committed by hand.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2045%2Fshatachandra%2Fpre-add-hooks-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2045/shatachandra/pre-add-hooks-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2045

Range-diff vs v3:

 1:  d0fb5f9da21 ! 1:  9383395bb06 add: support pre-add hook
     @@ Commit message
          wrap the command in a shell alias or wait for pre-commit, which
          fires too late to prevent staging.
      
     -    Introduce a "pre-add" hook that runs after "git add" computes the
     -    new index state but before committing it to disk. The hook
     -    receives two positional arguments:
     +    Introduce a "pre-add" hook so that users can inspect or reject
     +    proposed index updates at staging time.
      
            $1 -- index path used by this invocation (may not exist yet)
            $2 -- lockfile path containing proposed staged index state
      
     -    While the lockfile is active the current index path remains readable
     -    and unchanged, so a seperate copy is unnecessary. Hook authors can
     -    inspect the computed result with ordinary tools:
     +    Hook authors can inspect the result with ordinary Git commands:
      
            GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD
      
     -    without needing to interpret pathspec or mode flags as the proposed
     -    index already reflects their effect.
     +    Both files should be treated as read-only. Exiting with non-zero
     +    status rejects the update and leaves the index unchanged.
      
     -    At the finish label, write_locked_index() writes the proposed index
     -    to the lockfile without COMMIT_LOCK so commit_lock_file() can be
     -    called seperately after the hook runs. However, do_write_locked_index()
     -    unconditionally fires post-index-change after every write, and the
     -    existing test suite (t7113) asserts that index.lock does not exist when
     -    that hook fires. Tying the hook to COMMIT_LOCK would suppress it for
     -    other callers that depend on it after a non-committed write (e.g.,
     -    prepare_to_commit() in builtin/commit.c). A new SKIP_INDEX_CHANGE_HOOK
     -    flag lets builtin/add.c suppress the automatic notification on just this
     -    call, then emit post-index-change manually after commit_lock_file()
     -    publishes the new index. If the hook rejects, rollback_lock_file()
     -    discards the lockfile and the original index is left unchanged. When
     -    no hook is installed the existing write_locked_index(COMMIT_LOCK |
     -    SKIP_IF_UNCHANGED) path is taken.
     -
     -    The hook gate checks cache_changed regardless of exit_status so that
     -    mixed-result adds (e.g., a tracked modification combined with an
     -    ignored path) still run the hook when index content changes.
     +    The hook accepts or rejects the entire proposed update. Per-path
     +    filtering is not supported.
      
          The hook is bypassed with "--no-verify" and is not invoked for
          --interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
     @@ Commit message
      
       ## Documentation/git-add.adoc ##
      @@ Documentation/git-add.adoc: SYNOPSIS
     - [synopsis]
       git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
       	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
     --	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
     -+	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize] [--no-verify]
     - 	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
     + 	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
     +-	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
     ++	[--no-verify] [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
       	[--] [<pathspec>...]
       
     + DESCRIPTION
      @@ Documentation/git-add.adoc: use the `--force` option to add ignored files. If you specify the exact
       filename of an ignored file, `git add` will fail with a list of ignored
       files. Otherwise it will silently ignore the file.
       
     -+A `pre-add` hook can be run to inspect or reject the proposed index update
     -+after `git add` computes staging and writes it to the index lockfile,
     -+but before writing it to the final index. See linkgit:githooks[5].
     ++A `pre-add` hook can be used to reject `git add` (see linkgit:githooks[5]).
      +
       Please see linkgit:git-commit[1] for alternative ways to add content to a
       commit.
       
     +-
     + OPTIONS
     + -------
     + `<pathspec>...`::
      @@ Documentation/git-add.adoc: for `git add --no-all <pathspec>...`, i.e. ignored removed files.
       	Don't add the file(s), but only refresh their stat()
       	information in the index.
     @@ Documentation/githooks.adoc: and is invoked after the patch is applied and a com
      +`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
      +`--edit`, or `--dry-run`.
      +
     -+It takes two parameters: the path to the index file for this invocation
     ++It takes two arguments: the path to the index file for this invocation
      +of `git add`, and the path to the lockfile containing the proposed
     -+index after staging. It does not read from standard input. If no index
     -+exists yet, the first parameter names a path that does not exist and
     -+should be treated as an empty index.
     ++index after staging. If no index exists yet, the first argument names
     ++a path that does not exist and should be treated as an empty index.
      +
      +The hook is invoked after the index has been updated in memory and
      +written to the lockfile, but before it is committed to the final index
      +path. Exiting with a non-zero status causes `git add` to reject the
      +proposed state, roll back the lockfile, and leave the index unchanged.
     -+Exiting with zero status allows the index update to be committed.
     ++Exiting with zero status allows the index update to be committed. The
     ++hook accepts or rejects the entire proposed update; per-path filtering
     ++is not supported. Both files should be treated as read-only by the hook.
      +
     -+Git does not set `GIT_INDEX_FILE` for this hook. Hook authors may
     -+set `GIT_INDEX_FILE="$1"` to inspect current index state and
     -+`GIT_INDEX_FILE="$2"` to inspect proposed index state.
     ++Hook authors may set `GIT_INDEX_FILE="$1"` to inspect the current index
     ++state and `GIT_INDEX_FILE="$2"` to inspect the proposed index state.
      +
      +This hook can be used to prevent staging of files based on names, content,
      +or sizes (e.g., to block `.env` files, secret keys, or large files).
     @@ builtin/add.c: int cmd_add(int argc,
       	transaction = odb_transaction_begin(repo->objects);
       
       	ps_matched = xcalloc(pathspec.nr, 1);
     -@@ builtin/add.c: int cmd_add(int argc,
     - 						  include_sparse, flags);
     - 
     - 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
     --	    report_path_error(ps_matched, &pathspec))
     -+	    report_path_error(ps_matched, &pathspec)) {
     -+		free(orig_index_path);
     - 		exit(128);
     -+	}
     - 
     - 	if (add_new_files)
     - 		exit_status |= add_files(repo, &dir, flags);
      @@ builtin/add.c: int cmd_add(int argc,
       	odb_transaction_commit(transaction);
       
     @@ builtin/add.c: int cmd_add(int argc,
      +		} else if (commit_lock_file(&lock_file)) {
      +			die(_("unable to write new index file"));
      +		} else {
     -+			run_hooks_l(repo, "post-index-change",
     -+				    repo->index->updated_workdir ? "1" : "0",
     -+				    repo->index->updated_skipworktree ? "1" : "0",
     -+				    NULL);
     ++			emit_post_index_change(repo->index);
      +		}
     -+		repo->index->updated_workdir = 0;
     -+		repo->index->updated_skipworktree = 0;
      +	} else {
      +		if (write_locked_index(repo->index, &lock_file,
      +				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
     @@ read-cache-ll.h: int is_index_unborn(struct index_state *);
       #define COMMIT_LOCK		(1 << 0)
       #define SKIP_IF_UNCHANGED	(1 << 1)
      +#define SKIP_INDEX_CHANGE_HOOK	(1 << 2)
     ++
     ++void emit_post_index_change(struct index_state *istate);
       
       /*
        * Write the index while holding an already-taken lock. Close the lock,
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate,
       	else
       		ret = close_lock_file_gently(lock);
       
     --	run_hooks_l(the_repository, "post-index-change",
     --		    istate->updated_workdir ? "1" : "0",
     --		    istate->updated_skipworktree ? "1" : "0", NULL);
     --	istate->updated_workdir = 0;
     --	istate->updated_skipworktree = 0;
     ++	if (!(flags & SKIP_INDEX_CHANGE_HOOK))
     ++		emit_post_index_change(istate);
     ++	return ret;
     ++}
     ++
     ++void emit_post_index_change(struct index_state *istate)
     ++{
     + 	run_hooks_l(the_repository, "post-index-change",
     + 		    istate->updated_workdir ? "1" : "0",
     + 		    istate->updated_skipworktree ? "1" : "0", NULL);
     + 	istate->updated_workdir = 0;
     + 	istate->updated_skipworktree = 0;
      -
     -+	if (!(flags & SKIP_INDEX_CHANGE_HOOK)) {
     -+		run_hooks_l(the_repository, "post-index-change",
     -+			    istate->updated_workdir ? "1" : "0",
     -+			    istate->updated_skipworktree ? "1" : "0", NULL);
     -+		istate->updated_workdir = 0;
     -+		istate->updated_skipworktree = 0;
     -+	}
     - 	return ret;
     +-	return ret;
       }
       
     + static int write_split_index(struct index_state *istate,
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [


 Documentation/git-add.adoc  |  10 +-
 Documentation/githooks.adoc |  30 ++++
 builtin/add.c               |  38 ++++-
 read-cache-ll.h             |   3 +
 read-cache.c                |   9 +-
 t/meson.build               |   1 +
 t/t3706-pre-add-hook.sh     | 289 ++++++++++++++++++++++++++++++++++++
 7 files changed, 373 insertions(+), 7 deletions(-)
 create mode 100755 t/t3706-pre-add-hook.sh

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 6192daeb03..a3ff4ced83 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
 	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
-	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	[--no-verify] [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	[--] [<pathspec>...]
 
 DESCRIPTION
@@ -42,10 +42,11 @@ use the `--force` option to add ignored files. If you specify the exact
 filename of an ignored file, `git add` will fail with a list of ignored
 files. Otherwise it will silently ignore the file.
 
+A `pre-add` hook can be used to reject `git add` (see linkgit:githooks[5]).
+
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
 
-
 OPTIONS
 -------
 `<pathspec>...`::
@@ -163,6 +164,10 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
+`--no-verify`::
+	Bypass the `pre-add` hook if it exists. See linkgit:githooks[5] for
+	more information about hooks.
+
 `--ignore-errors`::
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
@@ -451,6 +456,7 @@ linkgit:git-reset[1]
 linkgit:git-mv[1]
 linkgit:git-commit[1]
 linkgit:git-update-index[1]
+linkgit:githooks[5]
 
 GIT
 ---
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 056553788d..90945a590e 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -94,6 +94,36 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
 
+pre-add
+~~~~~~~
+
+This hook is invoked by linkgit:git-add[1], and can be bypassed with the
+`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
+`--edit`, or `--dry-run`.
+
+It takes two arguments: the path to the index file for this invocation
+of `git add`, and the path to the lockfile containing the proposed
+index after staging. If no index exists yet, the first argument names
+a path that does not exist and should be treated as an empty index.
+
+The hook is invoked after the index has been updated in memory and
+written to the lockfile, but before it is committed to the final index
+path. Exiting with a non-zero status causes `git add` to reject the
+proposed state, roll back the lockfile, and leave the index unchanged.
+Exiting with zero status allows the index update to be committed. The
+hook accepts or rejects the entire proposed update; per-path filtering
+is not supported. Both files should be treated as read-only by the hook.
+
+Hook authors may set `GIT_INDEX_FILE="$1"` to inspect the current index
+state and `GIT_INDEX_FILE="$2"` to inspect the proposed index state.
+
+This hook can be used to prevent staging of files based on names, content,
+or sizes (e.g., to block `.env` files, secret keys, or large files).
+
+This hook is not invoked by `git commit -a` or `git commit --include`
+which still can run the `pre-commit` hook, providing a control point at
+commit time.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..ca8b681d8a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -25,6 +25,8 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "hook.h"
+#include "abspath.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -36,6 +38,7 @@ static int take_worktree_changes;
 static int add_renormalize;
 static int pathspec_file_nul;
 static int include_sparse;
+static int no_verify;
 static const char *pathspec_from_file;
 
 static int chmod_pathspec(struct repository *repo,
@@ -271,6 +274,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_BOOL( 0 , "no-verify", &no_verify, N_("bypass pre-add hook")),
 	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
 		   N_("override the executable bit of the listed files")),
@@ -391,6 +395,8 @@ int cmd_add(int argc,
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 	struct odb_transaction *transaction;
+	int run_pre_add = 0;
+	char *orig_index_path = NULL;
 
 	repo_config(repo, add_config, NULL);
 
@@ -576,6 +582,11 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
+	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
+		run_pre_add = 1;
+		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
+	}
+
 	transaction = odb_transaction_begin(repo->objects);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
@@ -598,9 +609,30 @@ int cmd_add(int argc,
 	odb_transaction_commit(transaction);
 
 finish:
-	if (write_locked_index(repo->index, &lock_file,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("unable to write new index file"));
+	if (run_pre_add && repo->index->cache_changed) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+		if (write_locked_index(repo->index, &lock_file,
+				SKIP_INDEX_CHANGE_HOOK))
+			die(_("unable to write proposed index"));
+
+		strvec_push(&opt.args, orig_index_path);
+		strvec_push(&opt.args, get_lock_file_path(&lock_file));
+		if (run_hooks_opt(repo, "pre-add", &opt)) {
+			rollback_lock_file(&lock_file); /* hook rejected */
+			exit_status = 1;
+		} else if (commit_lock_file(&lock_file)) {
+			die(_("unable to write new index file"));
+		} else {
+			emit_post_index_change(repo->index);
+		}
+	} else {
+		if (write_locked_index(repo->index, &lock_file,
+				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+			die(_("unable to write new index file"));
+	}
+
+	free(orig_index_path);
 
 	free(ps_matched);
 	dir_clear(&dir);
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b49d9af4..eed1d74d99 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -284,6 +284,9 @@ int is_index_unborn(struct index_state *);
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define SKIP_IF_UNCHANGED	(1 << 1)
+#define SKIP_INDEX_CHANGE_HOOK	(1 << 2)
+
+void emit_post_index_change(struct index_state *istate);
 
 /*
  * Write the index while holding an already-taken lock. Close the lock,
diff --git a/read-cache.c b/read-cache.c
index 0c07c3aef7..dfe8d8e4d7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3161,13 +3161,18 @@ static int do_write_locked_index(struct index_state *istate,
 	else
 		ret = close_lock_file_gently(lock);
 
+	if (!(flags & SKIP_INDEX_CHANGE_HOOK))
+		emit_post_index_change(istate);
+	return ret;
+}
+
+void emit_post_index_change(struct index_state *istate)
+{
 	run_hooks_l(the_repository, "post-index-change",
 		    istate->updated_workdir ? "1" : "0",
 		    istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
-
-	return ret;
 }
 
 static int write_split_index(struct index_state *istate,
diff --git a/t/meson.build b/t/meson.build
index f80e366cff..2419a9adbb 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -415,6 +415,7 @@ integration_tests = [
   't3703-add-magic-pathspec.sh',
   't3704-add-pathspec-file.sh',
   't3705-add-sparse-checkout.sh',
+  't3706-pre-add-hook.sh',
   't3800-mktag.sh',
   't3900-i18n-commit.sh',
   't3901-i18n-patch.sh',
diff --git a/t/t3706-pre-add-hook.sh b/t/t3706-pre-add-hook.sh
new file mode 100755
index 0000000000..f5092f0727
--- /dev/null
+++ b/t/t3706-pre-add-hook.sh
@@ -0,0 +1,289 @@
+#!/bin/sh
+
+test_description='pre-add hook tests
+
+These tests run git add with and without pre-add hooks to ensure functionality. Largely derived from t7503 (pre-commit and pre-merge-commit hooks) and t5571 (pre-push hooks).'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'with no hook' '
+	test_when_finished "rm -f actual" &&
+	echo content >file &&
+	git add file &&
+	test_path_is_missing actual
+'
+
+test_expect_success POSIXPERM 'with non-executable hook' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo should-not-run >>actual
+	exit 1
+	EOF
+	chmod -x .git/hooks/pre-add &&
+
+	echo content >file &&
+	git add file &&
+	test_path_is_missing actual
+'
+
+test_expect_success '--no-verify with no hook' '
+	echo content >file &&
+	git add --no-verify file &&
+	test_path_is_missing actual
+'
+
+test_expect_success 'with succeeding hook' '
+	test_when_finished "rm -f actual expected" &&
+	echo "pre-add" >expected &&
+	test_hook pre-add <<-\EOF &&
+	echo pre-add >>actual
+	EOF
+
+	echo content >file &&
+	git add file &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with failing hook' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo pre-add-rejected >>actual
+	exit 1
+	EOF
+
+	echo content >file &&
+	test_must_fail git add file
+'
+
+test_expect_success '--no-verify with failing hook' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo should-not-run >>actual
+	exit 1
+	EOF
+
+	echo content >file &&
+	git add --no-verify file &&
+	test_path_is_missing actual
+'
+
+test_expect_success 'setup for path-based tests' '
+	git add file &&
+	git commit -m "initial"
+'
+
+test_expect_success 'hook receives index-path and lockfile-path arguments' '
+	test_when_finished "git reset --hard &&
+			    rm -f staged expect-count arg-count arg-one arg-two \
+			    expect-index expect-lockpath" &&
+	echo staged >staged &&
+	cat >expect-count <<-\EOF &&
+	2
+	EOF
+	test_hook pre-add <<-\EOF &&
+	echo "$#" >arg-count &&
+	echo "$1" >arg-one &&
+	echo "$2" >arg-two &&
+	test "$1" != "$2" &&
+	test -r "$2"
+	EOF
+	git add staged &&
+	test_cmp expect-count arg-count &&
+	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
+	test_cmp expect-index arg-one &&
+	sed "s/$/.lock/" expect-index >expect-lockpath &&
+	test_cmp expect-lockpath arg-two
+'
+
+test_expect_success 'hook rejection leaves final index unchanged' '
+	test_when_finished "git reset --hard && rm -f reject index.before" &&
+	cp .git/index index.before &&
+	test_hook pre-add <<-\EOF &&
+	exit 1
+	EOF
+	echo reject >reject &&
+	test_must_fail git add reject &&
+	test_cmp_bin index.before .git/index &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success 'missing pre-existing index path treated as empty' '
+	test_when_finished "git reset --hard &&
+			    rm -f newfile arg-one after.raw after expect-index" &&
+	rm -f .git/index &&
+	test_hook pre-add <<-\EOF &&
+	echo "$1" >arg-one &&
+	test ! -e "$1" &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >after.raw &&
+	sort after.raw >after
+	EOF
+	echo newfile >newfile &&
+	git add newfile &&
+	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
+	test_cmp expect-index arg-one &&
+	grep "^newfile$" after &&
+	grep "^file$" after
+'
+
+test_expect_success 'hook respects GIT_INDEX_FILE' '
+	test_when_finished "git reset --hard &&
+			    rm -f arg-one arg-two expect-index expect-lockpath \
+			    alt-index alt-index.lock" &&
+	test_hook pre-add <<-\EOF &&
+	echo "$1" >arg-one &&
+	echo "$2" >arg-two
+	EOF
+	echo changed >>file &&
+	GIT_INDEX_FILE=alt-index git add file &&
+	echo "$PWD/alt-index" >expect-index &&
+	test_cmp expect-index arg-one &&
+	echo "$PWD/alt-index.lock" >expect-lockpath &&
+	test_cmp expect-lockpath arg-two
+'
+
+test_expect_success 'setup for mixed-result tests' '
+	echo "*.ignored" >.gitignore &&
+	git add .gitignore &&
+	git commit -m "add gitignore"
+'
+
+test_expect_success 'mixed-result add invokes pre-add hook' '
+	test_when_finished "git reset --hard &&
+			    rm -f bad.ignored index.before hook-ran proposed" &&
+	echo changed >>file &&
+	echo ignored >bad.ignored &&
+	cp .git/index index.before &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
+	grep "^file$" proposed &&
+	echo invoked >hook-ran &&
+	exit 1
+	EOF
+	test_must_fail git add file bad.ignored &&
+	test_path_is_file hook-ran &&
+	test_cmp_bin index.before .git/index &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success 'mixed-result add stages tracked update on approve' '
+	test_when_finished "git reset --hard &&
+			    rm -f bad.ignored hook-ran staged proposed" &&
+	echo changed >>file &&
+	echo ignored >bad.ignored &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
+	grep "^file$" proposed &&
+	echo invoked >hook-ran
+	EOF
+	test_must_fail git add file bad.ignored &&
+	test_path_is_file hook-ran &&
+	git diff --cached --name-only HEAD >staged &&
+	grep "^file$" staged &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success 'post-index-change fires after pre-add approval' '
+	test_when_finished "git reset --hard &&
+			    rm -f hook-order expect lockfile-present" &&
+	test_hook pre-add <<-\EOF &&
+	echo pre >>hook-order
+	EOF
+	test_hook post-index-change <<-\EOF &&
+	if test -f ".git/index.lock"
+	then
+		echo locked >lockfile-present
+	fi
+	echo post >>hook-order
+	EOF
+	echo updated >>file &&
+	git add file &&
+	cat >expect <<-\EOF &&
+	pre
+	post
+	EOF
+	test_cmp expect hook-order &&
+	test_path_is_missing lockfile-present
+'
+
+test_expect_success 'post-index-change is suppressed on pre-add rejection' '
+	test_when_finished "git reset --hard &&
+			    rm -f index.before hook-order expect" &&
+	cp .git/index index.before &&
+	test_hook pre-add <<-\EOF &&
+	echo pre >>hook-order &&
+	exit 1
+	EOF
+	test_hook post-index-change <<-\EOF &&
+	echo post >>hook-order
+	EOF
+	echo reject >>file &&
+	test_must_fail git add file &&
+	echo pre >expect &&
+	test_cmp expect hook-order &&
+	test_cmp_bin index.before .git/index &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success '--dry-run does not invoke hook' '
+	test_when_finished "rm -f hook-ran dry" &&
+	test_hook pre-add <<-\EOF &&
+	echo invoked >hook-ran
+	EOF
+	echo dry >dry &&
+	git add --dry-run dry &&
+	test_path_is_missing hook-ran
+'
+
+test_expect_success 'hook runs for git add -u' '
+	test_when_finished "git reset --hard && rm -f hook-ran" &&
+	test_hook pre-add <<-\EOF &&
+	echo invoked >hook-ran
+	EOF
+	echo changed >>file &&
+	git add -u &&
+	test_path_is_file hook-ran
+'
+
+test_expect_success 'hook example: block .env files' '
+	test_when_finished "git reset --hard &&
+			    rm -f .env safe.txt new-paths" &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-paths &&
+	while read path
+	do
+		case "$path" in
+		*.env)
+			echo "error: $path must not be staged" >&2
+			exit 1
+			;;
+		esac
+	done <new-paths
+	EOF
+	echo "DB_PASS=secret" >.env &&
+	test_must_fail git add .env &&
+	echo "safe content" >safe.txt &&
+	git add safe.txt
+'
+
+test_expect_success 'hook example: block secrets in content' '
+	test_when_finished "git reset --hard && rm -f config.txt secret" &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached HEAD >secret &&
+	if grep -q "API_KEY=" secret ||
+	   grep -q "SECRET_KEY=" secret ||
+	   grep -q "PRIVATE_KEY=" secret
+	then
+		echo "error: staged content contains secrets" >&2
+		exit 1
+	fi
+	EOF
+	echo "API_KEY=sksksk-live-12345" >config.txt &&
+	test_must_fail git add config.txt &&
+	echo "LOG_LEVEL=debug" >config.txt &&
+	git add config.txt
+'
+
+test_done

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget

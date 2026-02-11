Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919AB176FB1
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822328; cv=none; b=qnT7cEs/TiEpBTk1b1iEXCwoGw7YhRHwbmj92PHnGbXL/ohGcF+rvw1L8yQf2YKgfAdBRM4kQ4fzMRlscVLorFUq93vxLKiGy8VocO53oe5UnakbGnaIlBLlz1RzlHVXdH6xiZMPssYWwlTt1FJzAZSMP8WTX5n7ny8dxmAi9Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822328; c=relaxed/simple;
	bh=9YZHF7HFwQdxkyXHhRGkg25B3wHRSzjjCULV6V95d/Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m4PJ2DL7rrwWkXhNmSYQOGdbmiO8fhn2o6VQlZ/ZOUuDC1/1UjnEo4CbjLrPtuvVprp2XKPBsLyBZKdgVEMkdGm9FQvOxrq/3ibb6BoIhg9fy2dNCOH6H7ZtCwbodrd7aL7gGv7MRlmAhQYN+BLT38C4RAZegQxPTSrCMcj/2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKoT2riJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKoT2riJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5384ee23fso583036485a.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 07:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770822324; x=1771427124; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg2Uh1mu8+PraligNyeSzFpA+BaKKMGGItVJX6r8HUY=;
        b=aKoT2riJ9zQiaFw6MjVEh18NwM91u+Um9swD7B4IApf3VqOA5E8OOvC1jmMB0IW8W5
         8DmNPtW3Qs+xWs8pOMelkO5ymVHvyP3uCDaHEq5jpvSeuzf8bfFOUtvsvoh7XHZ4pU3o
         vRUWm8MIeM7uAH40Olbw8EPLYgz6g+IvUrI4fimCj7HwrH2HEnPtlV6rOm3z41yLJGD/
         rfFf6cqKr2duM8BY2JtH52xZeNKTw+NH8o+WNyfG+UUPIA3FbrjIqyj6t8V8psrYwE52
         4WJuhMGwCgMpDbqTrpJHaImUrUK2INyAKZ7tkgtOh24e6HjwnsajHN34jMuzu2/mkPXK
         tqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770822324; x=1771427124;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cg2Uh1mu8+PraligNyeSzFpA+BaKKMGGItVJX6r8HUY=;
        b=kxpjRs6fQjN/8Nkh3CbJWUfIGhuGkQxGx+4Ts0oGcvzum0grbSmuPzzSpg7oN4kuxN
         S3QvZwGnduA+r+VY1hsOAJvdD1YSVmLIjKGaJc93DE2lB+DXrXy/bl6jB2a0Lb3QCOmq
         0nDZ3jO+RvtIO8H4cMZYiOL9DqUTk5mLje4z5CfLQ7h6SEuedKGCYwYh+ycWg+mzc34M
         SoX8LwphQ6iOz2tF7RdGTamku9lIXD4jmCKkOTll3+SJbQYHpEtV6Y/8cc0ZJZS5Y9Pq
         W7sSvoJl1efN0OGXz+6srS2HX1XacYMe16fHKU8UhJBEqUs2F9D+lTkN9uBBOECtgDiG
         qiow==
X-Gm-Message-State: AOJu0YyCelqNSlOfTyHw8Ko9vj8UwBo7kkdckvEO4+JaE/Med7ho2Aqx
	DfQ/L7vjHdiNSWvJdC1di4iwQF22ODBJKPHCY1lyIQ5coijCnmt9Z2R6Y1MieaDc
X-Gm-Gg: AZuq6aJIHnOjdMWpXm0OqMTuTTcZEkSIPUdS1ttYjRqUAE1VjDOXVTlzCNrPhTM6PLd
	eLGjE56Wj0oz0uj9oakOkK9kuK8ctHqTaHebsqaJQgaxxKn8+mDz7ucAWQhPt7F2FVpjAU8fSYn
	te5rKDk1PK+hX+bXYikWCQA5K9FMDpiP826hmoW+TpSLw9eygJ/COOFP9OHrqk7cCulXZZPRVpb
	dRsHf4Frzu31mWx2LVOG30ecGevpprHKmPI3A4P2ExX8egxo+AJrYlZWq153A4umj05aIzpsMyj
	ba2+4oMBasGP2Y7fQo0zVdJmdVELFFoMBVmBIdqcXLJeGtGZ2KIfTJfe1iLnYk9B27fqxfRGU/7
	1WrSMLsOKAWjaCymOQOmzG7fxuX7EJRkGAqvktgkggrgc6Zb6lyLLKo/jwJxKSZ64TXxpyvTCSI
	/xk1WrkD/cNhWRRQ2mOhEm9MYSZzM=
X-Received: by 2002:a05:620a:1aa0:b0:8c7:b0d:df16 with SMTP id af79cd13be357-8cb28075dd6mr402023585a.62.1770822323630;
        Wed, 11 Feb 2026 07:05:23 -0800 (PST)
Received: from [127.0.0.1] ([135.232.184.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c8123sm130407685a.29.2026.02.11.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:05:22 -0800 (PST)
Message-Id: <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com>
In-Reply-To: <pull.2045.git.1770737573475.gitgitgadget@gmail.com>
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com>
From: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Feb 2026 15:05:12 +0000
Subject: [PATCH v2] add: support pre-add hook
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
Cc: Chandra Kethi-Reddy <chandrakr@pm.me>,
    Chandra Kethi-Reddy <chandrakr@pm.me>

From: Chandra Kethi-Reddy <chandrakr@pm.me>

"git add" has no hook that lets users inspect what is about to be
staged. Users who want to reject certain paths or content must
wrap the command in a shell alias or wait for pre-commit, which
fires after staging is already done and objects may already be in
the object database.

Introduce a "pre-add" hook that runs after "git add" computes the
new index state but before committing it to disk. The hook
receives two arguments:

  $1 -- path to a temporary copy of the index before this "git add"
  $2 -- path to the lockfile containing the proposed index

$1 on first add can be a non-existent path representing an empty
index.

Hook authors can inspect the computed result with ordinary tools:

  GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD

without needing to interpret pathspec or mode flags like "-u" or
"--renormalize" -- the proposed index already reflects their effect.

The implementation creates a temporary copy of the index via the
tempfile API when find_hook("pre-add") reports a hook is present,
then lets all staging proceed normally. At the finish label,
write_locked_index() writes the proposed index to the lockfile
without COMMIT_LOCK. If the hook approves, commit_lock_file()
atomically replaces the index. If the hook rejects,
rollback_lock_file() discards the lockfile and the original index
is left unchanged. When no hook is installed, the existing
write_locked_index(COMMIT_LOCK | SKIP_IF_UNCHANGED) path is still
taken.

The hook is bypassed with "--no-verify" and is not invoked for
--interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
which stages through its own code path.

Register t3706-pre-add-hook.sh in t/meson.build to synchronize Meson
and Makefile lists.

Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
---
    add: support pre-add hook
    
    
    Summary
    =======
    
     * v2 reworks pre-add to follow Junio's suggested architecture: snapshot
       original index, compute staging normally, write proposed index to
       lockfile, run hook with ($1 original, $2 proposed), then
       commit_lock_file() or rollback_lock_file().
     * Hook authors now inspect computed results directly with
       GIT_INDEX_FILE="$1" / GIT_INDEX_FILE="$2" instead of trying to
       emulate pathspec/mode behavior.
     * Added tests for two-argument contract, original-vs-proposed
       comparison, explicit rollback behavior on hook rejection, and example
       policies (filename/content rejection).
    
    
    Notes
    =====
    
     * This design intentionally trades ODB prevention for correctness of
       hook inputs: blobs may already be written to object storage when the
       hook runs, but hook rejection still leaves the on-disk index
       unchanged.
     * Conflicts with ar/parallel-hooks on seen:
       RUN_HOOKS_OPT_INIT → RUN_HOOKS_OPT_INIT_SERIAL.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2045%2Fshatachandra%2Fpre-add-hooks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2045/shatachandra/pre-add-hooks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2045

Range-diff vs v1:

 1:  964bec5b9ea ! 1:  10244150e24 add: support pre-add hook
     @@ Metadata
       ## Commit message ##
          add: support pre-add hook
      
     -    git has no hook that fires during 'git add'.  Users who want to
     -    validate files before staging must wrap 'git add' in a shell alias
     -    or wait for pre-commit, which fires after staging is already done.
     +    "git add" has no hook that lets users inspect what is about to be
     +    staged. Users who want to reject certain paths or content must
     +    wrap the command in a shell alias or wait for pre-commit, which
     +    fires after staging is already done and objects may already be in
     +    the object database.
      
     -    Add a pre-add hook that runs after pathspec validation and before
     -    any files are staged.  If the hook exits non-zero, 'git add' aborts
     -    without modifying the index.  The hook receives GIT_INDEX_FILE in
     -    its environment, following the same convention as pre-commit.
     +    Introduce a "pre-add" hook that runs after "git add" computes the
     +    new index state but before committing it to disk. The hook
     +    receives two arguments:
      
     -    The hook is bypassed with '--no-verify' (long flag only, since '-n'
     -    is already '--dry-run' in 'git add').  It is not invoked for
     -    --interactive, --patch, --edit, or --dry-run modes, nor by
     -    'git commit -a' which stages files through its own code path in
     -    builtin/commit.c.
     +      $1 -- path to a temporary copy of the index before this "git add"
     +      $2 -- path to the lockfile containing the proposed index
      
     -    The implementation calls run_hooks_opt() directly rather than the
     -    run_commit_hook() wrapper, which sets GIT_EDITOR=: and is not
     -    relevant for 'git add'.  When no hook is installed, there is no
     -    performance impact.
     +    $1 on first add can be a non-existent path representing an empty
     +    index.
      
     -    Disclosure: developed with guidance from Claude Code (Anthropic)
     -    and Codex CLI (OpenAI) for development, review and standards
     -    compliance. The contributor handtyped and reviewed all tests, code,
     -    and documentation.
     +    Hook authors can inspect the computed result with ordinary tools:
     +
     +      GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD
     +
     +    without needing to interpret pathspec or mode flags like "-u" or
     +    "--renormalize" -- the proposed index already reflects their effect.
     +
     +    The implementation creates a temporary copy of the index via the
     +    tempfile API when find_hook("pre-add") reports a hook is present,
     +    then lets all staging proceed normally. At the finish label,
     +    write_locked_index() writes the proposed index to the lockfile
     +    without COMMIT_LOCK. If the hook approves, commit_lock_file()
     +    atomically replaces the index. If the hook rejects,
     +    rollback_lock_file() discards the lockfile and the original index
     +    is left unchanged. When no hook is installed, the existing
     +    write_locked_index(COMMIT_LOCK | SKIP_IF_UNCHANGED) path is still
     +    taken.
     +
     +    The hook is bypassed with "--no-verify" and is not invoked for
     +    --interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
     +    which stages through its own code path.
     +
     +    Register t3706-pre-add-hook.sh in t/meson.build to synchronize Meson
     +    and Makefile lists.
      
          Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
      
     @@ Documentation/git-add.adoc: use the `--force` option to add ignored files. If yo
       filename of an ignored file, `git add` will fail with a list of ignored
       files. Otherwise it will silently ignore the file.
       
     -+A pre-add hook can be run to inspect or reject the add operation before
     -+it stages files. See linkgit:githooks[5] for details.
     ++A pre-add hook can be run to inspect or reject the proposed index update
     ++after `git add` computes staging and writes it to the index lockfile,
     ++but before writing it to the final index. See linkgit:githooks[5].
      +
       Please see linkgit:git-commit[1] for alternative ways to add content to a
       commit.
     @@ Documentation/githooks.adoc: and is invoked after the patch is applied and a com
      +~~~~~~~
      +
      +This hook is invoked by linkgit:git-add[1], and can be bypassed with the
     -+`--no-verify` option. This hook is not invoked for `--interactive`, `--patch`,
     -+`--edit`, or `--dry-run`. It takes no parameters, and is invoked after pathspec
     -+validation and before any files are staged. Exiting with a non-zero status
     -+from this script causes the `git add` command to abort without modifying the
     -+index.
     ++`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
     ++`--edit`, or `--dry-run`.
      +
     -+This hook is invoked with the environment variable `GIT_INDEX_FILE`
     -+which points to the index file. This allows the hook to inspect what
     -+files would be staged before the operation proceeds.
     ++It takes two parameters: the path to a copy of the index before this
     ++invocation of `git add`, and the path to the lockfile containing the
     ++proposed index after staging. It does not read from standard input.
     ++If no index exists yet, the first parameter names a path that does not
     ++exist and should be treated as an empty index. No special environment
     ++variables are set. The hook is invoked after the index has been updated
     ++in memory and written to the lockfile, but before it is committed to the
     ++final location.
      +
     -+This hook is not invoked by `git commit -a` or `git commit --include` which
     -+still can run the pre-commit hook, providing a control point at commit time.
     ++Exiting with a non-zero status causes `git add` to abort and leaves the
     ++index unchanged. Exiting with zero status causes the staged changes to
     ++take effect.
     ++
     ++This hook can be used to prevent staging of files based on names, content,
     ++or sizes (e.g., to block `.env` files, secret keys, or large files).
     ++
     ++This hook is not invoked by `git commit -a` or `git commit --include`
     ++which still can run the pre-commit hook, providing a control point at
     ++commit time.
      +
       pre-commit
       ~~~~~~~~~~
     @@ builtin/add.c
       #include "submodule.h"
       #include "add-interactive.h"
      +#include "hook.h"
     ++#include "copy.h"
       
       static const char * const builtin_add_usage[] = {
       	N_("git add [<options>] [--] <pathspec>..."),
     @@ builtin/add.c: static struct option builtin_add_options[] = {
       	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
       	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
       		   N_("override the executable bit of the listed files")),
     +@@ builtin/add.c: int cmd_add(int argc,
     + 	char *ps_matched = NULL;
     + 	struct lock_file lock_file = LOCK_INIT;
     + 	struct odb_transaction *transaction;
     ++	int run_pre_add = 0;
     ++	struct tempfile *orig_index = NULL;
     ++	char *orig_index_path = NULL;
     + 
     + 	repo_config(repo, add_config, NULL);
     + 
      @@ builtin/add.c: int cmd_add(int argc,
       		string_list_clear(&only_match_skip_worktree, 0);
       	}
       
     -+	if (!show_only && !no_verify) {
     ++	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
     ++		int fd_in, status;
     ++		const char *index_file = repo_get_index_file(repo);
     ++		char *template;
     ++
     ++		run_pre_add = 1;
     ++		template = xstrfmt("%s.pre-add.XXXXXX", index_file);
     ++		orig_index = xmks_tempfile(template);
     ++		free(template);
     ++
     ++		fd_in = open(index_file, O_RDONLY);
     ++		if (fd_in >= 0) {
     ++			status = copy_fd(fd_in, get_tempfile_fd(orig_index));
     ++			if (close(fd_in))
     ++				die_errno(_("unable to close index for pre-add hook"));
     ++			if (close_tempfile_gently(orig_index))
     ++				die_errno(_("unable to close temporary index copy"));
     ++			if (status < 0)
     ++				die(_("failed to copy index for pre-add hook"));
     ++		} else if (errno == ENOENT) {
     ++			orig_index_path = xstrdup(get_tempfile_path(orig_index));
     ++			if (delete_tempfile(&orig_index))
     ++				die_errno(_("unable to remove temporary index copy"));
     ++		} else {
     ++			die_errno(_("unable to open index for pre-add hook"));
     ++		}
     ++	}
     ++
     + 	transaction = odb_transaction_begin(repo->objects);
     + 
     + 	ps_matched = xcalloc(pathspec.nr, 1);
     +@@ builtin/add.c: int cmd_add(int argc,
     + 						  include_sparse, flags);
     + 
     + 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
     +-	    report_path_error(ps_matched, &pathspec))
     ++	    report_path_error(ps_matched, &pathspec)) {
     ++		if (orig_index)
     ++			delete_tempfile(&orig_index);
     ++		free(orig_index_path);
     + 		exit(128);
     ++	}
     + 
     + 	if (add_new_files)
     + 		exit_status |= add_files(repo, &dir, flags);
     +@@ builtin/add.c: int cmd_add(int argc,
     + 	odb_transaction_commit(transaction);
     + 
     + finish:
     +-	if (write_locked_index(repo->index, &lock_file,
     +-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
     +-		die(_("unable to write new index file"));
     ++	if (run_pre_add && !exit_status && repo->index->cache_changed) {
      +		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      +
     -+		strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s",
     -+			     repo_get_index_file(repo));
     ++		if (write_locked_index(repo->index, &lock_file, 0))
     ++			die(_("unable to write new index file"));
     ++
     ++		strvec_push(&opt.args, orig_index ? get_tempfile_path(orig_index) :
     ++					     orig_index_path);
     ++		strvec_push(&opt.args, get_lock_file_path(&lock_file));
      +		if (run_hooks_opt(repo, "pre-add", &opt)) {
     ++			rollback_lock_file(&lock_file); /* hook rejected */
      +			exit_status = 1;
     -+			goto finish;
     ++		} else {
     ++			if (commit_lock_file(&lock_file)) /* hook approved */
     ++				die(_("unable to write new index file"));
      +		}
     ++	} else {
     ++		if (write_locked_index(repo->index, &lock_file,
     ++				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
     ++			die(_("unable to write new index file"));
      +	}
      +
     - 	transaction = odb_transaction_begin(repo->objects);
     ++	delete_tempfile(&orig_index);
     ++	free(orig_index_path);
       
     - 	ps_matched = xcalloc(pathspec.nr, 1);
     + 	free(ps_matched);
     + 	dir_clear(&dir);
     +
     + ## t/meson.build ##
     +@@ t/meson.build: integration_tests = [
     +   't3703-add-magic-pathspec.sh',
     +   't3704-add-pathspec-file.sh',
     +   't3705-add-sparse-checkout.sh',
     ++  't3706-pre-add-hook.sh',
     +   't3800-mktag.sh',
     +   't3900-i18n-commit.sh',
     +   't3901-i18n-patch.sh',
      
       ## t/t3706-pre-add-hook.sh (new) ##
      @@
     @@ t/t3706-pre-add-hook.sh (new)
      +	test_path_is_missing actual
      +'
      +
     -+test_expect_success 'hook receives GIT_INDEX_FILE environment variable' '
     -+	test_when_finished "rm -f actual expected" &&
     -+	echo "hook-saw-env" >expected &&
     ++test_expect_success 'hook receives original and proposed index as arguments' '
     ++	test_when_finished "rm -f tracked expected hook-ran" &&
     ++	echo "initial" >tracked &&
     ++	git add tracked &&
     ++	git commit -m "initial" &&
      +	test_hook pre-add <<-\EOF &&
     -+	if test -z "$GIT_INDEX_FILE"
     -+	then
     -+		echo hook-missing-env >>actual
     -+	else
     -+		echo hook-saw-env >>actual
     -+	fi
     ++	test $# -eq 2 &&
     ++	test -f "$1" &&
     ++	test -f "$2" &&
     ++	echo pass >hook-ran
      +	EOF
      +
     -+	echo content >file &&
     -+	git add file &&
     -+	test_cmp expected actual
     ++	echo "modified" >tracked &&
     ++	git add tracked &&
     ++	echo pass >expected &&
     ++	test_cmp expected hook-ran
     ++'
     ++
     ++test_expect_success 'hook handles first add with no existing index' '
     ++	test_when_finished "rm -rf no-index" &&
     ++	test_create_repo no-index &&
     ++	echo ok >no-index/expected &&
     ++	test_hook -C no-index pre-add <<-\EOF &&
     ++	test $# -eq 2 &&
     ++	test ! -e "$1" &&
     ++	test -f "$2" &&
     ++	echo ok >hook-ran
     ++	EOF
     ++
     ++	echo first >no-index/file &&
     ++	git -C no-index add file &&
     ++	test_cmp no-index/expected no-index/hook-ran
      +'
      +
     -+test_expect_success 'with --dry-run (show-only) the hook is not invoked' '
     ++test_expect_success 'hook is not invoked with --dry-run (show-only)' '
      +	test_when_finished "rm -f actual" &&
      +	test_hook pre-add <<-\EOF &&
      +	echo should-not-run >>actual
     @@ t/t3706-pre-add-hook.sh (new)
      +	test_cmp expected actual
      +'
      +
     ++test_expect_success 'hook can compare original and proposed index' '
     ++	test_when_finished "rm -f old-raw new-raw old-list new-list \
     ++			    expected-old expected-new" &&
     ++	echo "initial" >file1 &&
     ++	echo "initial" >file2 &&
     ++	git add file1 file2 &&
     ++	git commit -m "initial" &&
     ++	echo "staged-before" >file1 &&
     ++	git add file1 &&
     ++	test_hook pre-add <<-\EOF &&
     ++	GIT_INDEX_FILE="$1" git diff --cached --name-only HEAD >old-raw &&
     ++	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-raw &&
     ++	sort old-raw >old-list &&
     ++	sort new-raw >new-list
     ++	EOF
     ++
     ++	echo "modified" >file2 &&
     ++	git add file2 &&
     ++	echo file1 >expected-old &&
     ++	printf "%s\n" file1 file2 >expected-new &&
     ++	test_cmp expected-old old-list &&
     ++	test_cmp expected-new new-list
     ++'
     ++
     ++test_expect_success 'hook rejection rolls back index unchanged' '
     ++	test_when_finished "rm -f file before after old-raw new-raw \
     ++			    old-list new-list expected-old expected-new" &&
     ++	echo "initial" >file &&
     ++	git add file &&
     ++	git commit -m "initial" &&
     ++	git diff --cached --name-only HEAD >before &&
     ++	test_hook pre-add <<-\EOF &&
     ++	GIT_INDEX_FILE="$1" git diff --cached --name-only HEAD >old-raw &&
     ++	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-raw &&
     ++	sort old-raw >old-list &&
     ++	sort new-raw >new-list &&
     ++	exit 1
     ++	EOF
     ++
     ++	echo "modified" >file &&
     ++	test_must_fail git add file &&
     ++	git diff --cached --name-only HEAD >after &&
     ++	test_cmp before after &&
     ++	: >expected-old &&
     ++	echo file >expected-new &&
     ++	test_cmp expected-old old-list &&
     ++	test_cmp expected-new new-list
     ++'
     ++
     ++test_expect_success 'hook example: block .env files' '
     ++	test_when_finished "rm -f .env safe.txt new-paths" &&
     ++	echo "initial" >base &&
     ++	git add base &&
     ++	git commit -m "initial" &&
     ++	test_hook pre-add <<-\EOF &&
     ++	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-paths &&
     ++	while read path
     ++	do
     ++		case "$path" in
     ++		*.env|.env)
     ++			echo "error: $path must not be staged" >&2
     ++			exit 1
     ++			;;
     ++		esac
     ++	done <new-paths
     ++	EOF
     ++
     ++	echo "DB_PASS=secret" >.env &&
     ++	test_must_fail git add .env &&
     ++	echo "safe content" >safe.txt &&
     ++	git add safe.txt
     ++'
     ++
     ++test_expect_success 'hook example: block secrets in content' '
     ++	test_when_finished "rm -f config.txt secret" &&
     ++	echo "initial" >config.txt &&
     ++	git add config.txt &&
     ++	git commit -m "initial" &&
     ++	test_hook pre-add <<-\EOF &&
     ++	GIT_INDEX_FILE="$2" git diff --cached HEAD >secret &&
     ++	if grep -qE "(API_KEY|SECRET_KEY|PRIVATE_KEY)=" secret
     ++	then
     ++		echo "error: staged content contains secrets" >&2
     ++		exit 1
     ++	fi
     ++	EOF
     ++
     ++	echo "API_KEY=sksksk-live-12345" >config.txt &&
     ++	test_must_fail git add config.txt &&
     ++	echo "LOG_LEVEL=debug" >config.txt &&
     ++	git add config.txt
     ++'
     ++
      +test_done


 Documentation/git-add.adoc  |  11 +-
 Documentation/githooks.adoc |  27 +++++
 builtin/add.c               |  68 ++++++++++-
 t/meson.build               |   1 +
 t/t3706-pre-add-hook.sh     | 227 ++++++++++++++++++++++++++++++++++++
 5 files changed, 329 insertions(+), 5 deletions(-)
 create mode 100755 t/t3706-pre-add-hook.sh

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 6192daeb03..c864ce272d 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
-	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
+	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize] [--no-verify]
 	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	[--] [<pathspec>...]
 
@@ -42,6 +42,10 @@ use the `--force` option to add ignored files. If you specify the exact
 filename of an ignored file, `git add` will fail with a list of ignored
 files. Otherwise it will silently ignore the file.
 
+A pre-add hook can be run to inspect or reject the proposed index update
+after `git add` computes staging and writes it to the index lockfile,
+but before writing it to the final index. See linkgit:githooks[5].
+
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
 
@@ -163,6 +167,10 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
+`--no-verify`::
+	Bypass the pre-add hook if it exists. See linkgit:githooks[5] for
+	more information about hooks.
+
 `--ignore-errors`::
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
@@ -451,6 +459,7 @@ linkgit:git-reset[1]
 linkgit:git-mv[1]
 linkgit:git-commit[1]
 linkgit:git-update-index[1]
+linkgit:githooks[5]
 
 GIT
 ---
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 056553788d..7ef8718112 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -94,6 +94,33 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
 
+pre-add
+~~~~~~~
+
+This hook is invoked by linkgit:git-add[1], and can be bypassed with the
+`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
+`--edit`, or `--dry-run`.
+
+It takes two parameters: the path to a copy of the index before this
+invocation of `git add`, and the path to the lockfile containing the
+proposed index after staging. It does not read from standard input.
+If no index exists yet, the first parameter names a path that does not
+exist and should be treated as an empty index. No special environment
+variables are set. The hook is invoked after the index has been updated
+in memory and written to the lockfile, but before it is committed to the
+final location.
+
+Exiting with a non-zero status causes `git add` to abort and leaves the
+index unchanged. Exiting with zero status causes the staged changes to
+take effect.
+
+This hook can be used to prevent staging of files based on names, content,
+or sizes (e.g., to block `.env` files, secret keys, or large files).
+
+This hook is not invoked by `git commit -a` or `git commit --include`
+which still can run the pre-commit hook, providing a control point at
+commit time.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..735c9a53fd 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -25,6 +25,8 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "hook.h"
+#include "copy.h"
 
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
@@ -391,6 +395,9 @@ int cmd_add(int argc,
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 	struct odb_transaction *transaction;
+	int run_pre_add = 0;
+	struct tempfile *orig_index = NULL;
+	char *orig_index_path = NULL;
 
 	repo_config(repo, add_config, NULL);
 
@@ -576,6 +583,34 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
+	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
+		int fd_in, status;
+		const char *index_file = repo_get_index_file(repo);
+		char *template;
+
+		run_pre_add = 1;
+		template = xstrfmt("%s.pre-add.XXXXXX", index_file);
+		orig_index = xmks_tempfile(template);
+		free(template);
+
+		fd_in = open(index_file, O_RDONLY);
+		if (fd_in >= 0) {
+			status = copy_fd(fd_in, get_tempfile_fd(orig_index));
+			if (close(fd_in))
+				die_errno(_("unable to close index for pre-add hook"));
+			if (close_tempfile_gently(orig_index))
+				die_errno(_("unable to close temporary index copy"));
+			if (status < 0)
+				die(_("failed to copy index for pre-add hook"));
+		} else if (errno == ENOENT) {
+			orig_index_path = xstrdup(get_tempfile_path(orig_index));
+			if (delete_tempfile(&orig_index))
+				die_errno(_("unable to remove temporary index copy"));
+		} else {
+			die_errno(_("unable to open index for pre-add hook"));
+		}
+	}
+
 	transaction = odb_transaction_begin(repo->objects);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
@@ -587,8 +622,12 @@ int cmd_add(int argc,
 						  include_sparse, flags);
 
 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
-	    report_path_error(ps_matched, &pathspec))
+	    report_path_error(ps_matched, &pathspec)) {
+		if (orig_index)
+			delete_tempfile(&orig_index);
+		free(orig_index_path);
 		exit(128);
+	}
 
 	if (add_new_files)
 		exit_status |= add_files(repo, &dir, flags);
@@ -598,9 +637,30 @@ int cmd_add(int argc,
 	odb_transaction_commit(transaction);
 
 finish:
-	if (write_locked_index(repo->index, &lock_file,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("unable to write new index file"));
+	if (run_pre_add && !exit_status && repo->index->cache_changed) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+		if (write_locked_index(repo->index, &lock_file, 0))
+			die(_("unable to write new index file"));
+
+		strvec_push(&opt.args, orig_index ? get_tempfile_path(orig_index) :
+					     orig_index_path);
+		strvec_push(&opt.args, get_lock_file_path(&lock_file));
+		if (run_hooks_opt(repo, "pre-add", &opt)) {
+			rollback_lock_file(&lock_file); /* hook rejected */
+			exit_status = 1;
+		} else {
+			if (commit_lock_file(&lock_file)) /* hook approved */
+				die(_("unable to write new index file"));
+		}
+	} else {
+		if (write_locked_index(repo->index, &lock_file,
+				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+			die(_("unable to write new index file"));
+	}
+
+	delete_tempfile(&orig_index);
+	free(orig_index_path);
 
 	free(ps_matched);
 	dir_clear(&dir);
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..d518596fcb 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -412,6 +412,7 @@ integration_tests = [
   't3703-add-magic-pathspec.sh',
   't3704-add-pathspec-file.sh',
   't3705-add-sparse-checkout.sh',
+  't3706-pre-add-hook.sh',
   't3800-mktag.sh',
   't3900-i18n-commit.sh',
   't3901-i18n-patch.sh',
diff --git a/t/t3706-pre-add-hook.sh b/t/t3706-pre-add-hook.sh
new file mode 100755
index 0000000000..5ff7161f9d
--- /dev/null
+++ b/t/t3706-pre-add-hook.sh
@@ -0,0 +1,227 @@
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
+test_expect_success 'hook receives original and proposed index as arguments' '
+	test_when_finished "rm -f tracked expected hook-ran" &&
+	echo "initial" >tracked &&
+	git add tracked &&
+	git commit -m "initial" &&
+	test_hook pre-add <<-\EOF &&
+	test $# -eq 2 &&
+	test -f "$1" &&
+	test -f "$2" &&
+	echo pass >hook-ran
+	EOF
+
+	echo "modified" >tracked &&
+	git add tracked &&
+	echo pass >expected &&
+	test_cmp expected hook-ran
+'
+
+test_expect_success 'hook handles first add with no existing index' '
+	test_when_finished "rm -rf no-index" &&
+	test_create_repo no-index &&
+	echo ok >no-index/expected &&
+	test_hook -C no-index pre-add <<-\EOF &&
+	test $# -eq 2 &&
+	test ! -e "$1" &&
+	test -f "$2" &&
+	echo ok >hook-ran
+	EOF
+
+	echo first >no-index/file &&
+	git -C no-index add file &&
+	test_cmp no-index/expected no-index/hook-ran
+'
+
+test_expect_success 'hook is not invoked with --dry-run (show-only)' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo should-not-run >>actual
+	exit 1
+	EOF
+
+	echo content >file &&
+	git add --dry-run file &&
+	test_path_is_missing actual
+'
+
+test_expect_success 'hook is invoked with git add -u' '
+	test_when_finished "rm -f actual expected file" &&
+	echo "initial" >file &&
+	git add file &&
+	git commit -m "initial" &&
+	echo "pre-add" >expected &&
+	test_hook pre-add <<-\EOF &&
+	echo pre-add >>actual
+	EOF
+
+	echo modified >file &&
+	git add -u &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hook can compare original and proposed index' '
+	test_when_finished "rm -f old-raw new-raw old-list new-list \
+			    expected-old expected-new" &&
+	echo "initial" >file1 &&
+	echo "initial" >file2 &&
+	git add file1 file2 &&
+	git commit -m "initial" &&
+	echo "staged-before" >file1 &&
+	git add file1 &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$1" git diff --cached --name-only HEAD >old-raw &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-raw &&
+	sort old-raw >old-list &&
+	sort new-raw >new-list
+	EOF
+
+	echo "modified" >file2 &&
+	git add file2 &&
+	echo file1 >expected-old &&
+	printf "%s\n" file1 file2 >expected-new &&
+	test_cmp expected-old old-list &&
+	test_cmp expected-new new-list
+'
+
+test_expect_success 'hook rejection rolls back index unchanged' '
+	test_when_finished "rm -f file before after old-raw new-raw \
+			    old-list new-list expected-old expected-new" &&
+	echo "initial" >file &&
+	git add file &&
+	git commit -m "initial" &&
+	git diff --cached --name-only HEAD >before &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$1" git diff --cached --name-only HEAD >old-raw &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-raw &&
+	sort old-raw >old-list &&
+	sort new-raw >new-list &&
+	exit 1
+	EOF
+
+	echo "modified" >file &&
+	test_must_fail git add file &&
+	git diff --cached --name-only HEAD >after &&
+	test_cmp before after &&
+	: >expected-old &&
+	echo file >expected-new &&
+	test_cmp expected-old old-list &&
+	test_cmp expected-new new-list
+'
+
+test_expect_success 'hook example: block .env files' '
+	test_when_finished "rm -f .env safe.txt new-paths" &&
+	echo "initial" >base &&
+	git add base &&
+	git commit -m "initial" &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-paths &&
+	while read path
+	do
+		case "$path" in
+		*.env|.env)
+			echo "error: $path must not be staged" >&2
+			exit 1
+			;;
+		esac
+	done <new-paths
+	EOF
+
+	echo "DB_PASS=secret" >.env &&
+	test_must_fail git add .env &&
+	echo "safe content" >safe.txt &&
+	git add safe.txt
+'
+
+test_expect_success 'hook example: block secrets in content' '
+	test_when_finished "rm -f config.txt secret" &&
+	echo "initial" >config.txt &&
+	git add config.txt &&
+	git commit -m "initial" &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached HEAD >secret &&
+	if grep -qE "(API_KEY|SECRET_KEY|PRIVATE_KEY)=" secret
+	then
+		echo "error: staged content contains secrets" >&2
+		exit 1
+	fi
+	EOF
+
+	echo "API_KEY=sksksk-live-12345" >config.txt &&
+	test_must_fail git add config.txt &&
+	echo "LOG_LEVEL=debug" >config.txt &&
+	git add config.txt
+'
+
+test_done

base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
-- 
gitgitgadget

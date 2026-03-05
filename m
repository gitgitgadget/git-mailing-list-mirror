Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74321B1BF
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707660; cv=none; b=OBxUsnXFi4vZhk7OcFOMXWiKFghWICKmLadedoOZFh9SWQb25uJJpZrDwbXzh1BrJVOvhVsHMzJeWL9yEBrzUhVnFLO5ioYzsae3iZ7JdssAo52NWnDEGiu1nJQolAowH4pp8HEM36tsxGVdpdOt56pdVoq4H/3sVHcZIXEDpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707660; c=relaxed/simple;
	bh=1vq/QlmMzFF49H+WS5ZuIdKf6OErmYYpILlyz0DgD+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuO42xZVLpuK1O3XoGx3c+v5tDEpLqktoXOETfzbcm0JhbhG27v9HFlni7oarfyMzyyBOsN8Bj6JepqUq/OjunbO+76gflJCVscurOosA93/IrV1qQCcXsSiyBnwRYjNncYGFPBnKZhQqwKV4G5F8ZiWXqPiftli0u6586dJv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5UigR+P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5UigR+P"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso52867135e9.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772707655; x=1773312455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3r88+dduYQLXGYun5x1Y4OKAGGt4VGwkI3pqUUgRMYo=;
        b=K5UigR+PXnTRD0gDru+7zGi52GQ8TS1wfeQ+HaHUAqyBawvz83tdgac+E4upukcJpV
         00nkPcIJZlHRokCRQ4wlimpfDI7KRF4St7log1s4ySYzXlpDoWL06D9YOSOzeoLoHX81
         YdudNPGkIhD6SUp2bBQEHlKigLwlhNqas+syNkJS9/mpNaqwA1exHvuBVkXGoUEFkopO
         qHqT3F0/F4JouEzKTxqXY3zhzONumSVsDG//FQTCH4+GwXYrWAmIh6p0YiHbRr2s+GmT
         ThZuAmCb4+vpCrZImegzasvajaNo+12ee7ON2cay56zBEbOClBUQ//0Y0/BmaEkkaqXt
         kZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772707655; x=1773312455;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r88+dduYQLXGYun5x1Y4OKAGGt4VGwkI3pqUUgRMYo=;
        b=Itjr+6+A80kymGtergSvPd3t+je/gjKVQ73wjn639M6uEKLfoXbz9ucQiBKELCfbPv
         iPVKRHqSu6j4Ms0UiNFJ+j1CNk6SubnbA1Cm6z0RaMt81jM4NtqYtfuesaMUdlaX6aRq
         xD/soM/2xlzzVtcjznQKFJ4+47UYJP64MKjT5LkcK8VNwPE80y+C9nWUGB/XIz1CUxdg
         iZ1Ym0PhYHmp0lscorBSiqLQENAf4uMjtHS7MsDmoV9rw4eo12qAFuGMEqKddD3vqFiG
         U0KplFIPYElkIN20GcAeOAsTJLGvk+mRKk49Rey6anW8xOIBEldVF1osIQ33j2/9IQxD
         MnUw==
X-Forwarded-Encrypted: i=1; AJvYcCUNuQbu8FTcSLJpgfbGlXoSVK7AhZwmXQ+TI6Ygl9eHw5NeTHyngMnOUHGLuaxhE0NTq/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyirjuQmDKB6HZ2QMJNOkc3xNHGXsfzpWR/Q1A9zivO3u4FNt7G
	v2kHor/VJ1VpZykQNPnmN0+uBPKJos3ud+5u6ottcyjdwY506OAITYZX8gWDrw==
X-Gm-Gg: ATEYQzx/ahyio2v0qyTO0UEY3KEly2NX37eGJd6PPw6jdrE13piOYtQQPAQQrO59ub+
	Z3QldyaGqARm1Up6bPEIWFlotjsGtSLAshGpnUslrHzMolwQue6Y2FAMB5O4+7xt+ww9hjYCZRR
	STmPGcR8jYXAi8vTGaAW+zFxlAMlEeUyE2QC4b/IFZtMgZuyr8wZTLp0bm8SiV3oxNjhQdIGXH0
	cMOWoLlkW5PwOWj1Bpye3AbZwfZD5XRcSVfC7g9Ln6lcNYbrLOAUI0SB0h/Wf582HHpruTGCR6u
	k060rznD/72iCEDJk/vRP9jYqkuXsGoGf/aHtXWy/071VCUQPz3kpwz0JP71snTuyMUoUYGTcsG
	IX5V8mKNSFUEx+awfIffswOn61l56Qnd5bkKO2vKVaiV85BldyaNOzFCU9eqV4AxiK3C6drmWEC
	BiFNBoFTMG/fvVS3MtJN3kulDztr08RCb/CDwXDU6S3fN8fEEqyAiVR0DGifuIlpvbxxzjYnPDQ
	GFrlg==
X-Received: by 2002:a05:600c:4e08:b0:483:6d9e:e4f5 with SMTP id 5b1f17b1804b1-4851ee80b4fmr31975345e9.5.1772707654622;
        Thu, 05 Mar 2026 02:47:34 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm34373378f8f.2.2026.03.05.02.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:47:34 -0800 (PST)
Message-ID: <27ee9a9c-0caa-4b6e-a968-51c71c8b6e5f@gmail.com>
Date: Thu, 5 Mar 2026 10:47:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] add: support pre-add hook
To: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chandra Kethi-Reddy <chandrakr@pm.me>
References: <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com>
 <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2026 05:54, Chandra Kethi-Reddy via GitGitGadget wrote:
> From: Chandra Kethi-Reddy <chandrakr@pm.me>
> 
> "git add" has no hook that lets users inspect what is about to be
> staged. Users who want to reject certain paths or content must
> wrap the command in a shell alias or wait for pre-commit, which
> fires too late to prevent staging.
> 
> Introduce a "pre-add" hook that runs after "git add" computes the
> new index state but before committing it to disk. The hook
> receives two positional arguments:
> 
>    $1 -- index path used by this invocation (may not exist yet)

Does this mean 'the index state before running "git add"'?

>    $2 -- lockfile path containing proposed staged index state
> 
> While the lockfile is active the current index path remains readable
> and unchanged, so a seperate copy is unnecessary. Hook authors can
> inspect the computed result with ordinary tools:
> 
>    GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD

If I understand the definition of "$2" above correctly this will show 
all the paths that have been staged since the last commit, not just the 
paths that are staged by the current invocation of "git add". That means 
if for some reason I need to bypass the hook when running "git add" I'll 
have to bypass it every time until I commit and cannot check the other 
changes that I'm staging. It also means that running "git add" several 
times, each with a different path runs the hook multiple times on the 
same content.

To get the list of paths that have changed since the last invocation of 
"git add" you'd need to diff against the other index which isn't 
possible to do directly. If there are no unmerged paths you can write a 
tree but if there are unmerged paths "git write-tree" will fail and so 
you cannot use things like "git diff --check" and have to fall back to 
inspecting the changes by running "git diff-index --cached" on each 
index, munging them together and feeding that into "git diff-pairs"

> 
> without needing to interpret pathspec or mode flags as the proposed
> index already reflects their effect.
> 
> The hook is bypassed with "--no-verify" and is not invoked for
> --interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
> which stages through its own code path.

These caveats are rather unfortunate as it means to be sure that staged 
changes get checked I have to duplicate the "pre-add" checks in the 
"pre-commit" hook which is rather inefficient. It would be very nice to 
be able to check changes as they're staged rather than just before they 
are committed but I can't help feeling that what's proposed here is 
driven by ease of implementation which leads to a rather incoherent user 
experience.

Thanks

Phillip

> 
> Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
> ---
>      add: support pre-add hook
>      
>      
>      Summary
>      =======
>      
>       * v3 switches pre-add inputs to stable paths ($1 index, $2 lockfile)
>         and removes copy-specific tempfile logic
>       * v3 fixes mixed-result gating so the hook runs whenever index content
>         changed, even if git add returned non-zero
>       * v3 adds SKIP_INDEX_CHANGE_HOOK flag to write_locked_index() so that
>         post-index-change is not fired while the lockfile is still on disk
>      
>      
>      Notes
>      =====
>      
>       * This design intentionally trades ODB prevention for correctness of
>         hook inputs: blobs may already be written to object storage when the
>         hook runs, but hook rejection still leaves the on-disk index
>         unchanged
>       * AI Disclosure: Codex and Claude Code CLI were used to assist
>         drafting. All tests, code, and docs were committed by hand.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2045%2Fshatachandra%2Fpre-add-hooks-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2045/shatachandra/pre-add-hooks-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/2045
> 
> Range-diff vs v2:
> 
>   1:  10244150e24 ! 1:  d0fb5f9da21 add: support pre-add hook
>       @@ Commit message
>            "git add" has no hook that lets users inspect what is about to be
>            staged. Users who want to reject certain paths or content must
>            wrap the command in a shell alias or wait for pre-commit, which
>       -    fires after staging is already done and objects may already be in
>       -    the object database.
>       +    fires too late to prevent staging.
>        
>            Introduce a "pre-add" hook that runs after "git add" computes the
>            new index state but before committing it to disk. The hook
>       -    receives two arguments:
>       +    receives two positional arguments:
>        
>       -      $1 -- path to a temporary copy of the index before this "git add"
>       -      $2 -- path to the lockfile containing the proposed index
>       +      $1 -- index path used by this invocation (may not exist yet)
>       +      $2 -- lockfile path containing proposed staged index state
>        
>       -    $1 on first add can be a non-existent path representing an empty
>       -    index.
>       -
>       -    Hook authors can inspect the computed result with ordinary tools:
>       +    While the lockfile is active the current index path remains readable
>       +    and unchanged, so a seperate copy is unnecessary. Hook authors can
>       +    inspect the computed result with ordinary tools:
>        
>              GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD
>        
>       -    without needing to interpret pathspec or mode flags like "-u" or
>       -    "--renormalize" -- the proposed index already reflects their effect.
>       +    without needing to interpret pathspec or mode flags as the proposed
>       +    index already reflects their effect.
>       +
>       +    At the finish label, write_locked_index() writes the proposed index
>       +    to the lockfile without COMMIT_LOCK so commit_lock_file() can be
>       +    called seperately after the hook runs. However, do_write_locked_index()
>       +    unconditionally fires post-index-change after every write, and the
>       +    existing test suite (t7113) asserts that index.lock does not exist when
>       +    that hook fires. Tying the hook to COMMIT_LOCK would suppress it for
>       +    other callers that depend on it after a non-committed write (e.g.,
>       +    prepare_to_commit() in builtin/commit.c). A new SKIP_INDEX_CHANGE_HOOK
>       +    flag lets builtin/add.c suppress the automatic notification on just this
>       +    call, then emit post-index-change manually after commit_lock_file()
>       +    publishes the new index. If the hook rejects, rollback_lock_file()
>       +    discards the lockfile and the original index is left unchanged. When
>       +    no hook is installed the existing write_locked_index(COMMIT_LOCK |
>       +    SKIP_IF_UNCHANGED) path is taken.
>        
>       -    The implementation creates a temporary copy of the index via the
>       -    tempfile API when find_hook("pre-add") reports a hook is present,
>       -    then lets all staging proceed normally. At the finish label,
>       -    write_locked_index() writes the proposed index to the lockfile
>       -    without COMMIT_LOCK. If the hook approves, commit_lock_file()
>       -    atomically replaces the index. If the hook rejects,
>       -    rollback_lock_file() discards the lockfile and the original index
>       -    is left unchanged. When no hook is installed, the existing
>       -    write_locked_index(COMMIT_LOCK | SKIP_IF_UNCHANGED) path is still
>       -    taken.
>       +    The hook gate checks cache_changed regardless of exit_status so that
>       +    mixed-result adds (e.g., a tracked modification combined with an
>       +    ignored path) still run the hook when index content changes.
>        
>            The hook is bypassed with "--no-verify" and is not invoked for
>            --interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
>            which stages through its own code path.
>        
>       -    Register t3706-pre-add-hook.sh in t/meson.build to synchronize Meson
>       -    and Makefile lists.
>       -
>            Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
>        
>         ## Documentation/git-add.adoc ##
>       @@ Documentation/git-add.adoc: use the `--force` option to add ignored files. If yo
>         filename of an ignored file, `git add` will fail with a list of ignored
>         files. Otherwise it will silently ignore the file.
>         
>       -+A pre-add hook can be run to inspect or reject the proposed index update
>       ++A `pre-add` hook can be run to inspect or reject the proposed index update
>        +after `git add` computes staging and writes it to the index lockfile,
>        +but before writing it to the final index. See linkgit:githooks[5].
>        +
>       @@ Documentation/git-add.adoc: for `git add --no-all <pathspec>...`, i.e. ignored r
>         	information in the index.
>         
>        +`--no-verify`::
>       -+	Bypass the pre-add hook if it exists. See linkgit:githooks[5] for
>       ++	Bypass the `pre-add` hook if it exists. See linkgit:githooks[5] for
>        +	more information about hooks.
>        +
>         `--ignore-errors`::
>       @@ Documentation/githooks.adoc: and is invoked after the patch is applied and a com
>        +`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
>        +`--edit`, or `--dry-run`.
>        +
>       -+It takes two parameters: the path to a copy of the index before this
>       -+invocation of `git add`, and the path to the lockfile containing the
>       -+proposed index after staging. It does not read from standard input.
>       -+If no index exists yet, the first parameter names a path that does not
>       -+exist and should be treated as an empty index. No special environment
>       -+variables are set. The hook is invoked after the index has been updated
>       -+in memory and written to the lockfile, but before it is committed to the
>       -+final location.
>       ++It takes two parameters: the path to the index file for this invocation
>       ++of `git add`, and the path to the lockfile containing the proposed
>       ++index after staging. It does not read from standard input. If no index
>       ++exists yet, the first parameter names a path that does not exist and
>       ++should be treated as an empty index.
>       ++
>       ++The hook is invoked after the index has been updated in memory and
>       ++written to the lockfile, but before it is committed to the final index
>       ++path. Exiting with a non-zero status causes `git add` to reject the
>       ++proposed state, roll back the lockfile, and leave the index unchanged.
>       ++Exiting with zero status allows the index update to be committed.
>        +
>       -+Exiting with a non-zero status causes `git add` to abort and leaves the
>       -+index unchanged. Exiting with zero status causes the staged changes to
>       -+take effect.
>       ++Git does not set `GIT_INDEX_FILE` for this hook. Hook authors may
>       ++set `GIT_INDEX_FILE="$1"` to inspect current index state and
>       ++`GIT_INDEX_FILE="$2"` to inspect proposed index state.
>        +
>        +This hook can be used to prevent staging of files based on names, content,
>        +or sizes (e.g., to block `.env` files, secret keys, or large files).
>        +
>        +This hook is not invoked by `git commit -a` or `git commit --include`
>       -+which still can run the pre-commit hook, providing a control point at
>       ++which still can run the `pre-commit` hook, providing a control point at
>        +commit time.
>        +
>         pre-commit
>       @@ builtin/add.c
>         #include "submodule.h"
>         #include "add-interactive.h"
>        +#include "hook.h"
>       -+#include "copy.h"
>       ++#include "abspath.h"
>         
>         static const char * const builtin_add_usage[] = {
>         	N_("git add [<options>] [--] <pathspec>..."),
>       @@ builtin/add.c: int cmd_add(int argc,
>         	struct lock_file lock_file = LOCK_INIT;
>         	struct odb_transaction *transaction;
>        +	int run_pre_add = 0;
>       -+	struct tempfile *orig_index = NULL;
>        +	char *orig_index_path = NULL;
>         
>         	repo_config(repo, add_config, NULL);
>       @@ builtin/add.c: int cmd_add(int argc,
>         	}
>         
>        +	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
>       -+		int fd_in, status;
>       -+		const char *index_file = repo_get_index_file(repo);
>       -+		char *template;
>       -+
>        +		run_pre_add = 1;
>       -+		template = xstrfmt("%s.pre-add.XXXXXX", index_file);
>       -+		orig_index = xmks_tempfile(template);
>       -+		free(template);
>       -+
>       -+		fd_in = open(index_file, O_RDONLY);
>       -+		if (fd_in >= 0) {
>       -+			status = copy_fd(fd_in, get_tempfile_fd(orig_index));
>       -+			if (close(fd_in))
>       -+				die_errno(_("unable to close index for pre-add hook"));
>       -+			if (close_tempfile_gently(orig_index))
>       -+				die_errno(_("unable to close temporary index copy"));
>       -+			if (status < 0)
>       -+				die(_("failed to copy index for pre-add hook"));
>       -+		} else if (errno == ENOENT) {
>       -+			orig_index_path = xstrdup(get_tempfile_path(orig_index));
>       -+			if (delete_tempfile(&orig_index))
>       -+				die_errno(_("unable to remove temporary index copy"));
>       -+		} else {
>       -+			die_errno(_("unable to open index for pre-add hook"));
>       -+		}
>       ++		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
>        +	}
>        +
>         	transaction = odb_transaction_begin(repo->objects);
>       @@ builtin/add.c: int cmd_add(int argc,
>         	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
>        -	    report_path_error(ps_matched, &pathspec))
>        +	    report_path_error(ps_matched, &pathspec)) {
>       -+		if (orig_index)
>       -+			delete_tempfile(&orig_index);
>        +		free(orig_index_path);
>         		exit(128);
>        +	}
>       @@ builtin/add.c: int cmd_add(int argc,
>        -	if (write_locked_index(repo->index, &lock_file,
>        -			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>        -		die(_("unable to write new index file"));
>       -+	if (run_pre_add && !exit_status && repo->index->cache_changed) {
>       ++	if (run_pre_add && repo->index->cache_changed) {
>        +		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>        +
>       -+		if (write_locked_index(repo->index, &lock_file, 0))
>       -+			die(_("unable to write new index file"));
>       ++		if (write_locked_index(repo->index, &lock_file,
>       ++				SKIP_INDEX_CHANGE_HOOK))
>       ++			die(_("unable to write proposed index"));
>        +
>       -+		strvec_push(&opt.args, orig_index ? get_tempfile_path(orig_index) :
>       -+					     orig_index_path);
>       ++		strvec_push(&opt.args, orig_index_path);
>        +		strvec_push(&opt.args, get_lock_file_path(&lock_file));
>        +		if (run_hooks_opt(repo, "pre-add", &opt)) {
>        +			rollback_lock_file(&lock_file); /* hook rejected */
>        +			exit_status = 1;
>       ++		} else if (commit_lock_file(&lock_file)) {
>       ++			die(_("unable to write new index file"));
>        +		} else {
>       -+			if (commit_lock_file(&lock_file)) /* hook approved */
>       -+				die(_("unable to write new index file"));
>       ++			run_hooks_l(repo, "post-index-change",
>       ++				    repo->index->updated_workdir ? "1" : "0",
>       ++				    repo->index->updated_skipworktree ? "1" : "0",
>       ++				    NULL);
>        +		}
>       ++		repo->index->updated_workdir = 0;
>       ++		repo->index->updated_skipworktree = 0;
>        +	} else {
>        +		if (write_locked_index(repo->index, &lock_file,
>        +				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>        +			die(_("unable to write new index file"));
>        +	}
>        +
>       -+	delete_tempfile(&orig_index);
>        +	free(orig_index_path);
>         
>         	free(ps_matched);
>         	dir_clear(&dir);
>        
>       + ## read-cache-ll.h ##
>       +@@ read-cache-ll.h: int is_index_unborn(struct index_state *);
>       + /* For use with `write_locked_index()`. */
>       + #define COMMIT_LOCK		(1 << 0)
>       + #define SKIP_IF_UNCHANGED	(1 << 1)
>       ++#define SKIP_INDEX_CHANGE_HOOK	(1 << 2)
>       +
>       + /*
>       +  * Write the index while holding an already-taken lock. Close the lock,
>       +
>       + ## read-cache.c ##
>       +@@ read-cache.c: static int do_write_locked_index(struct index_state *istate,
>       + 	else
>       + 		ret = close_lock_file_gently(lock);
>       +
>       +-	run_hooks_l(the_repository, "post-index-change",
>       +-		    istate->updated_workdir ? "1" : "0",
>       +-		    istate->updated_skipworktree ? "1" : "0", NULL);
>       +-	istate->updated_workdir = 0;
>       +-	istate->updated_skipworktree = 0;
>       +-
>       ++	if (!(flags & SKIP_INDEX_CHANGE_HOOK)) {
>       ++		run_hooks_l(the_repository, "post-index-change",
>       ++			    istate->updated_workdir ? "1" : "0",
>       ++			    istate->updated_skipworktree ? "1" : "0", NULL);
>       ++		istate->updated_workdir = 0;
>       ++		istate->updated_skipworktree = 0;
>       ++	}
>       + 	return ret;
>       + }
>       +
>       +
>         ## t/meson.build ##
>        @@ t/meson.build: integration_tests = [
>           't3703-add-magic-pathspec.sh',
>       @@ t/t3706-pre-add-hook.sh (new)
>        +	test_path_is_missing actual
>        +'
>        +
>       -+test_expect_success 'hook receives original and proposed index as arguments' '
>       -+	test_when_finished "rm -f tracked expected hook-ran" &&
>       -+	echo "initial" >tracked &&
>       -+	git add tracked &&
>       -+	git commit -m "initial" &&
>       ++test_expect_success 'setup for path-based tests' '
>       ++	git add file &&
>       ++	git commit -m "initial"
>       ++'
>       ++
>       ++test_expect_success 'hook receives index-path and lockfile-path arguments' '
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f staged expect-count arg-count arg-one arg-two \
>       ++			    expect-index expect-lockpath" &&
>       ++	echo staged >staged &&
>       ++	cat >expect-count <<-\EOF &&
>       ++	2
>       ++	EOF
>        +	test_hook pre-add <<-\EOF &&
>       -+	test $# -eq 2 &&
>       -+	test -f "$1" &&
>       -+	test -f "$2" &&
>       -+	echo pass >hook-ran
>       ++	echo "$#" >arg-count &&
>       ++	echo "$1" >arg-one &&
>       ++	echo "$2" >arg-two &&
>       ++	test "$1" != "$2" &&
>       ++	test -r "$2"
>        +	EOF
>       ++	git add staged &&
>       ++	test_cmp expect-count arg-count &&
>       ++	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
>       ++	test_cmp expect-index arg-one &&
>       ++	sed "s/$/.lock/" expect-index >expect-lockpath &&
>       ++	test_cmp expect-lockpath arg-two
>       ++'
>        +
>       -+	echo "modified" >tracked &&
>       -+	git add tracked &&
>       -+	echo pass >expected &&
>       -+	test_cmp expected hook-ran
>       ++test_expect_success 'hook rejection leaves final index unchanged' '
>       ++	test_when_finished "git reset --hard && rm -f reject index.before" &&
>       ++	cp .git/index index.before &&
>       ++	test_hook pre-add <<-\EOF &&
>       ++	exit 1
>       ++	EOF
>       ++	echo reject >reject &&
>       ++	test_must_fail git add reject &&
>       ++	test_cmp_bin index.before .git/index &&
>       ++	test_path_is_missing .git/index.lock
>        +'
>        +
>       -+test_expect_success 'hook handles first add with no existing index' '
>       -+	test_when_finished "rm -rf no-index" &&
>       -+	test_create_repo no-index &&
>       -+	echo ok >no-index/expected &&
>       -+	test_hook -C no-index pre-add <<-\EOF &&
>       -+	test $# -eq 2 &&
>       ++test_expect_success 'missing pre-existing index path treated as empty' '
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f newfile arg-one after.raw after expect-index" &&
>       ++	rm -f .git/index &&
>       ++	test_hook pre-add <<-\EOF &&
>       ++	echo "$1" >arg-one &&
>        +	test ! -e "$1" &&
>       -+	test -f "$2" &&
>       -+	echo ok >hook-ran
>       ++	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >after.raw &&
>       ++	sort after.raw >after
>        +	EOF
>       -+
>       -+	echo first >no-index/file &&
>       -+	git -C no-index add file &&
>       -+	test_cmp no-index/expected no-index/hook-ran
>       ++	echo newfile >newfile &&
>       ++	git add newfile &&
>       ++	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
>       ++	test_cmp expect-index arg-one &&
>       ++	grep "^newfile$" after &&
>       ++	grep "^file$" after
>        +'
>        +
>       -+test_expect_success 'hook is not invoked with --dry-run (show-only)' '
>       -+	test_when_finished "rm -f actual" &&
>       ++test_expect_success 'hook respects GIT_INDEX_FILE' '
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f arg-one arg-two expect-index expect-lockpath \
>       ++			    alt-index alt-index.lock" &&
>        +	test_hook pre-add <<-\EOF &&
>       -+	echo should-not-run >>actual
>       -+	exit 1
>       ++	echo "$1" >arg-one &&
>       ++	echo "$2" >arg-two
>        +	EOF
>       ++	echo changed >>file &&
>       ++	GIT_INDEX_FILE=alt-index git add file &&
>       ++	echo "$PWD/alt-index" >expect-index &&
>       ++	test_cmp expect-index arg-one &&
>       ++	echo "$PWD/alt-index.lock" >expect-lockpath &&
>       ++	test_cmp expect-lockpath arg-two
>       ++'
>        +
>       -+	echo content >file &&
>       -+	git add --dry-run file &&
>       -+	test_path_is_missing actual
>       ++test_expect_success 'setup for mixed-result tests' '
>       ++	echo "*.ignored" >.gitignore &&
>       ++	git add .gitignore &&
>       ++	git commit -m "add gitignore"
>        +'
>        +
>       -+test_expect_success 'hook is invoked with git add -u' '
>       -+	test_when_finished "rm -f actual expected file" &&
>       -+	echo "initial" >file &&
>       -+	git add file &&
>       -+	git commit -m "initial" &&
>       -+	echo "pre-add" >expected &&
>       ++test_expect_success 'mixed-result add invokes pre-add hook' '
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f bad.ignored index.before hook-ran proposed" &&
>       ++	echo changed >>file &&
>       ++	echo ignored >bad.ignored &&
>       ++	cp .git/index index.before &&
>        +	test_hook pre-add <<-\EOF &&
>       -+	echo pre-add >>actual
>       ++	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
>       ++	grep "^file$" proposed &&
>       ++	echo invoked >hook-ran &&
>       ++	exit 1
>        +	EOF
>       -+
>       -+	echo modified >file &&
>       -+	git add -u &&
>       -+	test_cmp expected actual
>       ++	test_must_fail git add file bad.ignored &&
>       ++	test_path_is_file hook-ran &&
>       ++	test_cmp_bin index.before .git/index &&
>       ++	test_path_is_missing .git/index.lock
>        +'
>        +
>       -+test_expect_success 'hook can compare original and proposed index' '
>       -+	test_when_finished "rm -f old-raw new-raw old-list new-list \
>       -+			    expected-old expected-new" &&
>       -+	echo "initial" >file1 &&
>       -+	echo "initial" >file2 &&
>       -+	git add file1 file2 &&
>       -+	git commit -m "initial" &&
>       -+	echo "staged-before" >file1 &&
>       -+	git add file1 &&
>       ++test_expect_success 'mixed-result add stages tracked update on approve' '
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f bad.ignored hook-ran staged proposed" &&
>       ++	echo changed >>file &&
>       ++	echo ignored >bad.ignored &&
>        +	test_hook pre-add <<-\EOF &&
>       -+	GIT_INDEX_FILE="$1" git diff --cached --name-only HEAD >old-raw &&
>       -+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-raw &&
>       -+	sort old-raw >old-list &&
>       -+	sort new-raw >new-list
>       ++	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
>       ++	grep "^file$" proposed &&
>       ++	echo invoked >hook-ran
>        +	EOF
>       -+
>       -+	echo "modified" >file2 &&
>       -+	git add file2 &&
>       -+	echo file1 >expected-old &&
>       -+	printf "%s\n" file1 file2 >expected-new &&
>       -+	test_cmp expected-old old-list &&
>       -+	test_cmp expected-new new-list
>       ++	test_must_fail git add file bad.ignored &&
>       ++	test_path_is_file hook-ran &&
>       ++	git diff --cached --name-only HEAD >staged &&
>       ++	grep "^file$" staged &&
>       ++	test_path_is_missing .git/index.lock
>        +'
>        +
>       -+test_expect_success 'hook rejection rolls back index unchanged' '
>       -+	test_when_finished "rm -f file before after old-raw new-raw \
>       -+			    old-list new-list expected-old expected-new" &&
>       -+	echo "initial" >file &&
>       ++test_expect_success 'post-index-change fires after pre-add approval' '
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f hook-order expect lockfile-present" &&
>       ++	test_hook pre-add <<-\EOF &&
>       ++	echo pre >>hook-order
>       ++	EOF
>       ++	test_hook post-index-change <<-\EOF &&
>       ++	if test -f ".git/index.lock"
>       ++	then
>       ++		echo locked >lockfile-present
>       ++	fi
>       ++	echo post >>hook-order
>       ++	EOF
>       ++	echo updated >>file &&
>        +	git add file &&
>       -+	git commit -m "initial" &&
>       -+	git diff --cached --name-only HEAD >before &&
>       ++	cat >expect <<-\EOF &&
>       ++	pre
>       ++	post
>       ++	EOF
>       ++	test_cmp expect hook-order &&
>       ++	test_path_is_missing lockfile-present
>       ++'
>       ++
>       ++test_expect_success 'post-index-change is suppressed on pre-add rejection' '
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f index.before hook-order expect" &&
>       ++	cp .git/index index.before &&
>        +	test_hook pre-add <<-\EOF &&
>       -+	GIT_INDEX_FILE="$1" git diff --cached --name-only HEAD >old-raw &&
>       -+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-raw &&
>       -+	sort old-raw >old-list &&
>       -+	sort new-raw >new-list &&
>       ++	echo pre >>hook-order &&
>        +	exit 1
>        +	EOF
>       -+
>       -+	echo "modified" >file &&
>       ++	test_hook post-index-change <<-\EOF &&
>       ++	echo post >>hook-order
>       ++	EOF
>       ++	echo reject >>file &&
>        +	test_must_fail git add file &&
>       -+	git diff --cached --name-only HEAD >after &&
>       -+	test_cmp before after &&
>       -+	: >expected-old &&
>       -+	echo file >expected-new &&
>       -+	test_cmp expected-old old-list &&
>       -+	test_cmp expected-new new-list
>       ++	echo pre >expect &&
>       ++	test_cmp expect hook-order &&
>       ++	test_cmp_bin index.before .git/index &&
>       ++	test_path_is_missing .git/index.lock
>       ++'
>       ++
>       ++test_expect_success '--dry-run does not invoke hook' '
>       ++	test_when_finished "rm -f hook-ran dry" &&
>       ++	test_hook pre-add <<-\EOF &&
>       ++	echo invoked >hook-ran
>       ++	EOF
>       ++	echo dry >dry &&
>       ++	git add --dry-run dry &&
>       ++	test_path_is_missing hook-ran
>       ++'
>       ++
>       ++test_expect_success 'hook runs for git add -u' '
>       ++	test_when_finished "git reset --hard && rm -f hook-ran" &&
>       ++	test_hook pre-add <<-\EOF &&
>       ++	echo invoked >hook-ran
>       ++	EOF
>       ++	echo changed >>file &&
>       ++	git add -u &&
>       ++	test_path_is_file hook-ran
>        +'
>        +
>        +test_expect_success 'hook example: block .env files' '
>       -+	test_when_finished "rm -f .env safe.txt new-paths" &&
>       -+	echo "initial" >base &&
>       -+	git add base &&
>       -+	git commit -m "initial" &&
>       ++	test_when_finished "git reset --hard &&
>       ++			    rm -f .env safe.txt new-paths" &&
>        +	test_hook pre-add <<-\EOF &&
>        +	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-paths &&
>        +	while read path
>        +	do
>        +		case "$path" in
>       -+		*.env|.env)
>       ++		*.env)
>        +			echo "error: $path must not be staged" >&2
>        +			exit 1
>        +			;;
>        +		esac
>        +	done <new-paths
>        +	EOF
>       -+
>        +	echo "DB_PASS=secret" >.env &&
>        +	test_must_fail git add .env &&
>        +	echo "safe content" >safe.txt &&
>       @@ t/t3706-pre-add-hook.sh (new)
>        +'
>        +
>        +test_expect_success 'hook example: block secrets in content' '
>       -+	test_when_finished "rm -f config.txt secret" &&
>       -+	echo "initial" >config.txt &&
>       -+	git add config.txt &&
>       -+	git commit -m "initial" &&
>       ++	test_when_finished "git reset --hard && rm -f config.txt secret" &&
>        +	test_hook pre-add <<-\EOF &&
>        +	GIT_INDEX_FILE="$2" git diff --cached HEAD >secret &&
>       -+	if grep -qE "(API_KEY|SECRET_KEY|PRIVATE_KEY)=" secret
>       ++	if grep -q "API_KEY=" secret ||
>       ++	   grep -q "SECRET_KEY=" secret ||
>       ++	   grep -q "PRIVATE_KEY=" secret
>        +	then
>        +		echo "error: staged content contains secrets" >&2
>        +		exit 1
>        +	fi
>        +	EOF
>       -+
>        +	echo "API_KEY=sksksk-live-12345" >config.txt &&
>        +	test_must_fail git add config.txt &&
>        +	echo "LOG_LEVEL=debug" >config.txt &&
> 
> 
>   Documentation/git-add.adoc  |  11 +-
>   Documentation/githooks.adoc |  30 ++++
>   builtin/add.c               |  47 +++++-
>   read-cache-ll.h             |   1 +
>   read-cache.c                |  13 +-
>   t/meson.build               |   1 +
>   t/t3706-pre-add-hook.sh     | 289 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 381 insertions(+), 11 deletions(-)
>   create mode 100755 t/t3706-pre-add-hook.sh
> 
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 6192daeb03..b47751acca 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>   [synopsis]
>   git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
>   	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
> -	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
> +	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize] [--no-verify]
>   	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>   	[--] [<pathspec>...]
>   
> @@ -42,6 +42,10 @@ use the `--force` option to add ignored files. If you specify the exact
>   filename of an ignored file, `git add` will fail with a list of ignored
>   files. Otherwise it will silently ignore the file.
>   
> +A `pre-add` hook can be run to inspect or reject the proposed index update
> +after `git add` computes staging and writes it to the index lockfile,
> +but before writing it to the final index. See linkgit:githooks[5].
> +
>   Please see linkgit:git-commit[1] for alternative ways to add content to a
>   commit.
>   
> @@ -163,6 +167,10 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
>   	Don't add the file(s), but only refresh their stat()
>   	information in the index.
>   
> +`--no-verify`::
> +	Bypass the `pre-add` hook if it exists. See linkgit:githooks[5] for
> +	more information about hooks.
> +
>   `--ignore-errors`::
>   	If some files could not be added because of errors indexing
>   	them, do not abort the operation, but continue adding the
> @@ -451,6 +459,7 @@ linkgit:git-reset[1]
>   linkgit:git-mv[1]
>   linkgit:git-commit[1]
>   linkgit:git-update-index[1]
> +linkgit:githooks[5]
>   
>   GIT
>   ---
> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index 056553788d..657e14d306 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -94,6 +94,36 @@ and is invoked after the patch is applied and a commit is made.
>   This hook is meant primarily for notification, and cannot affect
>   the outcome of `git am`.
>   
> +pre-add
> +~~~~~~~
> +
> +This hook is invoked by linkgit:git-add[1], and can be bypassed with the
> +`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
> +`--edit`, or `--dry-run`.
> +
> +It takes two parameters: the path to the index file for this invocation
> +of `git add`, and the path to the lockfile containing the proposed
> +index after staging. It does not read from standard input. If no index
> +exists yet, the first parameter names a path that does not exist and
> +should be treated as an empty index.
> +
> +The hook is invoked after the index has been updated in memory and
> +written to the lockfile, but before it is committed to the final index
> +path. Exiting with a non-zero status causes `git add` to reject the
> +proposed state, roll back the lockfile, and leave the index unchanged.
> +Exiting with zero status allows the index update to be committed.
> +
> +Git does not set `GIT_INDEX_FILE` for this hook. Hook authors may
> +set `GIT_INDEX_FILE="$1"` to inspect current index state and
> +`GIT_INDEX_FILE="$2"` to inspect proposed index state.
> +
> +This hook can be used to prevent staging of files based on names, content,
> +or sizes (e.g., to block `.env` files, secret keys, or large files).
> +
> +This hook is not invoked by `git commit -a` or `git commit --include`
> +which still can run the `pre-commit` hook, providing a control point at
> +commit time.
> +
>   pre-commit
>   ~~~~~~~~~~
>   
> diff --git a/builtin/add.c b/builtin/add.c
> index 32709794b3..d4d004a35b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -25,6 +25,8 @@
>   #include "strvec.h"
>   #include "submodule.h"
>   #include "add-interactive.h"
> +#include "hook.h"
> +#include "abspath.h"
>   
>   static const char * const builtin_add_usage[] = {
>   	N_("git add [<options>] [--] <pathspec>..."),
> @@ -36,6 +38,7 @@ static int take_worktree_changes;
>   static int add_renormalize;
>   static int pathspec_file_nul;
>   static int include_sparse;
> +static int no_verify;
>   static const char *pathspec_from_file;
>   
>   static int chmod_pathspec(struct repository *repo,
> @@ -271,6 +274,7 @@ static struct option builtin_add_options[] = {
>   	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>   	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>   	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> +	OPT_BOOL( 0 , "no-verify", &no_verify, N_("bypass pre-add hook")),
>   	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
>   	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
>   		   N_("override the executable bit of the listed files")),
> @@ -391,6 +395,8 @@ int cmd_add(int argc,
>   	char *ps_matched = NULL;
>   	struct lock_file lock_file = LOCK_INIT;
>   	struct odb_transaction *transaction;
> +	int run_pre_add = 0;
> +	char *orig_index_path = NULL;
>   
>   	repo_config(repo, add_config, NULL);
>   
> @@ -576,6 +582,11 @@ int cmd_add(int argc,
>   		string_list_clear(&only_match_skip_worktree, 0);
>   	}
>   
> +	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
> +		run_pre_add = 1;
> +		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
> +	}
> +
>   	transaction = odb_transaction_begin(repo->objects);
>   
>   	ps_matched = xcalloc(pathspec.nr, 1);
> @@ -587,8 +598,10 @@ int cmd_add(int argc,
>   						  include_sparse, flags);
>   
>   	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
> -	    report_path_error(ps_matched, &pathspec))
> +	    report_path_error(ps_matched, &pathspec)) {
> +		free(orig_index_path);
>   		exit(128);
> +	}
>   
>   	if (add_new_files)
>   		exit_status |= add_files(repo, &dir, flags);
> @@ -598,9 +611,35 @@ int cmd_add(int argc,
>   	odb_transaction_commit(transaction);
>   
>   finish:
> -	if (write_locked_index(repo->index, &lock_file,
> -			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> -		die(_("unable to write new index file"));
> +	if (run_pre_add && repo->index->cache_changed) {
> +		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +
> +		if (write_locked_index(repo->index, &lock_file,
> +				SKIP_INDEX_CHANGE_HOOK))
> +			die(_("unable to write proposed index"));
> +
> +		strvec_push(&opt.args, orig_index_path);
> +		strvec_push(&opt.args, get_lock_file_path(&lock_file));
> +		if (run_hooks_opt(repo, "pre-add", &opt)) {
> +			rollback_lock_file(&lock_file); /* hook rejected */
> +			exit_status = 1;
> +		} else if (commit_lock_file(&lock_file)) {
> +			die(_("unable to write new index file"));
> +		} else {
> +			run_hooks_l(repo, "post-index-change",
> +				    repo->index->updated_workdir ? "1" : "0",
> +				    repo->index->updated_skipworktree ? "1" : "0",
> +				    NULL);
> +		}
> +		repo->index->updated_workdir = 0;
> +		repo->index->updated_skipworktree = 0;
> +	} else {
> +		if (write_locked_index(repo->index, &lock_file,
> +				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> +			die(_("unable to write new index file"));
> +	}
> +
> +	free(orig_index_path);
>   
>   	free(ps_matched);
>   	dir_clear(&dir);
> diff --git a/read-cache-ll.h b/read-cache-ll.h
> index 71b49d9af4..a43971c07e 100644
> --- a/read-cache-ll.h
> +++ b/read-cache-ll.h
> @@ -284,6 +284,7 @@ int is_index_unborn(struct index_state *);
>   /* For use with `write_locked_index()`. */
>   #define COMMIT_LOCK		(1 << 0)
>   #define SKIP_IF_UNCHANGED	(1 << 1)
> +#define SKIP_INDEX_CHANGE_HOOK	(1 << 2)
>   
>   /*
>    * Write the index while holding an already-taken lock. Close the lock,
> diff --git a/read-cache.c b/read-cache.c
> index 0c07c3aef7..5051cda4ce 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3161,12 +3161,13 @@ static int do_write_locked_index(struct index_state *istate,
>   	else
>   		ret = close_lock_file_gently(lock);
>   
> -	run_hooks_l(the_repository, "post-index-change",
> -		    istate->updated_workdir ? "1" : "0",
> -		    istate->updated_skipworktree ? "1" : "0", NULL);
> -	istate->updated_workdir = 0;
> -	istate->updated_skipworktree = 0;
> -
> +	if (!(flags & SKIP_INDEX_CHANGE_HOOK)) {
> +		run_hooks_l(the_repository, "post-index-change",
> +			    istate->updated_workdir ? "1" : "0",
> +			    istate->updated_skipworktree ? "1" : "0", NULL);
> +		istate->updated_workdir = 0;
> +		istate->updated_skipworktree = 0;
> +	}
>   	return ret;
>   }
>   
> diff --git a/t/meson.build b/t/meson.build
> index f80e366cff..2419a9adbb 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -415,6 +415,7 @@ integration_tests = [
>     't3703-add-magic-pathspec.sh',
>     't3704-add-pathspec-file.sh',
>     't3705-add-sparse-checkout.sh',
> +  't3706-pre-add-hook.sh',
>     't3800-mktag.sh',
>     't3900-i18n-commit.sh',
>     't3901-i18n-patch.sh',
> diff --git a/t/t3706-pre-add-hook.sh b/t/t3706-pre-add-hook.sh
> new file mode 100755
> index 0000000000..f5092f0727
> --- /dev/null
> +++ b/t/t3706-pre-add-hook.sh
> @@ -0,0 +1,289 @@
> +#!/bin/sh
> +
> +test_description='pre-add hook tests
> +
> +These tests run git add with and without pre-add hooks to ensure functionality. Largely derived from t7503 (pre-commit and pre-merge-commit hooks) and t5571 (pre-push hooks).'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'with no hook' '
> +	test_when_finished "rm -f actual" &&
> +	echo content >file &&
> +	git add file &&
> +	test_path_is_missing actual
> +'
> +
> +test_expect_success POSIXPERM 'with non-executable hook' '
> +	test_when_finished "rm -f actual" &&
> +	test_hook pre-add <<-\EOF &&
> +	echo should-not-run >>actual
> +	exit 1
> +	EOF
> +	chmod -x .git/hooks/pre-add &&
> +
> +	echo content >file &&
> +	git add file &&
> +	test_path_is_missing actual
> +'
> +
> +test_expect_success '--no-verify with no hook' '
> +	echo content >file &&
> +	git add --no-verify file &&
> +	test_path_is_missing actual
> +'
> +
> +test_expect_success 'with succeeding hook' '
> +	test_when_finished "rm -f actual expected" &&
> +	echo "pre-add" >expected &&
> +	test_hook pre-add <<-\EOF &&
> +	echo pre-add >>actual
> +	EOF
> +
> +	echo content >file &&
> +	git add file &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'with failing hook' '
> +	test_when_finished "rm -f actual" &&
> +	test_hook pre-add <<-\EOF &&
> +	echo pre-add-rejected >>actual
> +	exit 1
> +	EOF
> +
> +	echo content >file &&
> +	test_must_fail git add file
> +'
> +
> +test_expect_success '--no-verify with failing hook' '
> +	test_when_finished "rm -f actual" &&
> +	test_hook pre-add <<-\EOF &&
> +	echo should-not-run >>actual
> +	exit 1
> +	EOF
> +
> +	echo content >file &&
> +	git add --no-verify file &&
> +	test_path_is_missing actual
> +'
> +
> +test_expect_success 'setup for path-based tests' '
> +	git add file &&
> +	git commit -m "initial"
> +'
> +
> +test_expect_success 'hook receives index-path and lockfile-path arguments' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f staged expect-count arg-count arg-one arg-two \
> +			    expect-index expect-lockpath" &&
> +	echo staged >staged &&
> +	cat >expect-count <<-\EOF &&
> +	2
> +	EOF
> +	test_hook pre-add <<-\EOF &&
> +	echo "$#" >arg-count &&
> +	echo "$1" >arg-one &&
> +	echo "$2" >arg-two &&
> +	test "$1" != "$2" &&
> +	test -r "$2"
> +	EOF
> +	git add staged &&
> +	test_cmp expect-count arg-count &&
> +	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
> +	test_cmp expect-index arg-one &&
> +	sed "s/$/.lock/" expect-index >expect-lockpath &&
> +	test_cmp expect-lockpath arg-two
> +'
> +
> +test_expect_success 'hook rejection leaves final index unchanged' '
> +	test_when_finished "git reset --hard && rm -f reject index.before" &&
> +	cp .git/index index.before &&
> +	test_hook pre-add <<-\EOF &&
> +	exit 1
> +	EOF
> +	echo reject >reject &&
> +	test_must_fail git add reject &&
> +	test_cmp_bin index.before .git/index &&
> +	test_path_is_missing .git/index.lock
> +'
> +
> +test_expect_success 'missing pre-existing index path treated as empty' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f newfile arg-one after.raw after expect-index" &&
> +	rm -f .git/index &&
> +	test_hook pre-add <<-\EOF &&
> +	echo "$1" >arg-one &&
> +	test ! -e "$1" &&
> +	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >after.raw &&
> +	sort after.raw >after
> +	EOF
> +	echo newfile >newfile &&
> +	git add newfile &&
> +	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
> +	test_cmp expect-index arg-one &&
> +	grep "^newfile$" after &&
> +	grep "^file$" after
> +'
> +
> +test_expect_success 'hook respects GIT_INDEX_FILE' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f arg-one arg-two expect-index expect-lockpath \
> +			    alt-index alt-index.lock" &&
> +	test_hook pre-add <<-\EOF &&
> +	echo "$1" >arg-one &&
> +	echo "$2" >arg-two
> +	EOF
> +	echo changed >>file &&
> +	GIT_INDEX_FILE=alt-index git add file &&
> +	echo "$PWD/alt-index" >expect-index &&
> +	test_cmp expect-index arg-one &&
> +	echo "$PWD/alt-index.lock" >expect-lockpath &&
> +	test_cmp expect-lockpath arg-two
> +'
> +
> +test_expect_success 'setup for mixed-result tests' '
> +	echo "*.ignored" >.gitignore &&
> +	git add .gitignore &&
> +	git commit -m "add gitignore"
> +'
> +
> +test_expect_success 'mixed-result add invokes pre-add hook' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f bad.ignored index.before hook-ran proposed" &&
> +	echo changed >>file &&
> +	echo ignored >bad.ignored &&
> +	cp .git/index index.before &&
> +	test_hook pre-add <<-\EOF &&
> +	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
> +	grep "^file$" proposed &&
> +	echo invoked >hook-ran &&
> +	exit 1
> +	EOF
> +	test_must_fail git add file bad.ignored &&
> +	test_path_is_file hook-ran &&
> +	test_cmp_bin index.before .git/index &&
> +	test_path_is_missing .git/index.lock
> +'
> +
> +test_expect_success 'mixed-result add stages tracked update on approve' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f bad.ignored hook-ran staged proposed" &&
> +	echo changed >>file &&
> +	echo ignored >bad.ignored &&
> +	test_hook pre-add <<-\EOF &&
> +	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
> +	grep "^file$" proposed &&
> +	echo invoked >hook-ran
> +	EOF
> +	test_must_fail git add file bad.ignored &&
> +	test_path_is_file hook-ran &&
> +	git diff --cached --name-only HEAD >staged &&
> +	grep "^file$" staged &&
> +	test_path_is_missing .git/index.lock
> +'
> +
> +test_expect_success 'post-index-change fires after pre-add approval' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f hook-order expect lockfile-present" &&
> +	test_hook pre-add <<-\EOF &&
> +	echo pre >>hook-order
> +	EOF
> +	test_hook post-index-change <<-\EOF &&
> +	if test -f ".git/index.lock"
> +	then
> +		echo locked >lockfile-present
> +	fi
> +	echo post >>hook-order
> +	EOF
> +	echo updated >>file &&
> +	git add file &&
> +	cat >expect <<-\EOF &&
> +	pre
> +	post
> +	EOF
> +	test_cmp expect hook-order &&
> +	test_path_is_missing lockfile-present
> +'
> +
> +test_expect_success 'post-index-change is suppressed on pre-add rejection' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f index.before hook-order expect" &&
> +	cp .git/index index.before &&
> +	test_hook pre-add <<-\EOF &&
> +	echo pre >>hook-order &&
> +	exit 1
> +	EOF
> +	test_hook post-index-change <<-\EOF &&
> +	echo post >>hook-order
> +	EOF
> +	echo reject >>file &&
> +	test_must_fail git add file &&
> +	echo pre >expect &&
> +	test_cmp expect hook-order &&
> +	test_cmp_bin index.before .git/index &&
> +	test_path_is_missing .git/index.lock
> +'
> +
> +test_expect_success '--dry-run does not invoke hook' '
> +	test_when_finished "rm -f hook-ran dry" &&
> +	test_hook pre-add <<-\EOF &&
> +	echo invoked >hook-ran
> +	EOF
> +	echo dry >dry &&
> +	git add --dry-run dry &&
> +	test_path_is_missing hook-ran
> +'
> +
> +test_expect_success 'hook runs for git add -u' '
> +	test_when_finished "git reset --hard && rm -f hook-ran" &&
> +	test_hook pre-add <<-\EOF &&
> +	echo invoked >hook-ran
> +	EOF
> +	echo changed >>file &&
> +	git add -u &&
> +	test_path_is_file hook-ran
> +'
> +
> +test_expect_success 'hook example: block .env files' '
> +	test_when_finished "git reset --hard &&
> +			    rm -f .env safe.txt new-paths" &&
> +	test_hook pre-add <<-\EOF &&
> +	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-paths &&
> +	while read path
> +	do
> +		case "$path" in
> +		*.env)
> +			echo "error: $path must not be staged" >&2
> +			exit 1
> +			;;
> +		esac
> +	done <new-paths
> +	EOF
> +	echo "DB_PASS=secret" >.env &&
> +	test_must_fail git add .env &&
> +	echo "safe content" >safe.txt &&
> +	git add safe.txt
> +'
> +
> +test_expect_success 'hook example: block secrets in content' '
> +	test_when_finished "git reset --hard && rm -f config.txt secret" &&
> +	test_hook pre-add <<-\EOF &&
> +	GIT_INDEX_FILE="$2" git diff --cached HEAD >secret &&
> +	if grep -q "API_KEY=" secret ||
> +	   grep -q "SECRET_KEY=" secret ||
> +	   grep -q "PRIVATE_KEY=" secret
> +	then
> +		echo "error: staged content contains secrets" >&2
> +		exit 1
> +	fi
> +	EOF
> +	echo "API_KEY=sksksk-live-12345" >config.txt &&
> +	test_must_fail git add config.txt &&
> +	echo "LOG_LEVEL=debug" >config.txt &&
> +	git add config.txt
> +'
> +
> +test_done
> 
> base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4


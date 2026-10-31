Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793455538;
	b=GOXfbNu6LsXFE8Wq3opMETyKPYMUl1TZXqYf/cVBYKFgqQ9eUCl6iPcQiXSvILjfXueD
	 H2NDOGh/joz+PSeAYVInB8UB6kWi6BY058uKKfpXkpCSxoZwfgVmHljEQj6Rk07SAJJ6t
	 K+rcJtQ9mxzXrXvVs7ceTMoOvm5duqADvYFGYcAyAm/+pf8aGRx3TmWCwyQC65k0/gT59
	 zOEiiPRBgiCIl4L+tR7y1BG+lLKLFEXF/+GWUV622amkC0kIoBeW15JZLfndcff0HGvmZ
	 yS8XzmSeF/QA7tfknIzGdTbK7uOVyOFpq00Cu6wPH2F6gwFLeRlVzOv2ZOzyU1H+FBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793455538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=v/T8DXS56PQXXbKl31aezznAUUeUySg4uH2GySMPzYo=;
	b=3iU9aL6T30eWwpUTR30YaQujfGWvC7Pd/QAhWLYCuw91O7KLG/1FGGanOySLJB/hF+r8
	 okpW6Xs199fUX/B0zzXv6P+zLaHgLF1dTGVXwPzrnejxqD6Uehq08BXYiscm9TVdIf8sI
	 rnBVBtKcTzh8XGi7BG4s/W2YqVCRnYvIxe9J7cO3Iw+wMG+zRyCFC2ypau55xTAzZ4y1F
	 q/3dBnhn4OcG5gXFFn7ceNu4ScIVGy963Eb3QNEU/RiZ7+y8HKGfrs+rKVeBEh6xNRqFL
	 MHVfv+ybKd2aJ4MPIcrA4KPIQRd3R1sl0ZZeG5BDTL/k0lCWRyB4ylyDCA4R/6Fdy1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nILeqhJF;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDE606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 14:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nILeqhJF
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a1947498bso1835170eec.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793455536; x=1794060336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v/T8DXS56PQXXbKl31aezznAUUeUySg4uH2GySMPzYo=;
        b=nILeqhJFaXglr6hGF5P0Tn7FLFL7IoPN8eauNEOO9RkWTJB8mb0I/cH1tuOx5Sxwca
         os0F001T4LZUahQC4ZdbkeRoSbMYdkKPLPbAJ7jxdO5FATfUobIB/dGuGgI8r+HZfz9R
         KOSd2l146m4mILkN4N7XLoaWyFsekIWiWfof5g6l2TUseBfuW9ZpHC94u8jCN1TlX7Fv
         DziA3jwDDdRpQsvSbnk777/aE0BDQ73ZYdZ5O2iepAdaKdv2hbGo6EJETCQwQ3W156O7
         CaFjXWt6lxKiQYPmy/lyePCSZgB4cmItJOsu2eJff9wf67Q7L6vDxjRbOHZkcMv6NYXx
         wbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793455536; x=1794060336;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/T8DXS56PQXXbKl31aezznAUUeUySg4uH2GySMPzYo=;
        b=IW+9UJAFW+lU063byjdtQ5jCCyHUE5dgzmTd5y72Qd9vP902rNNmlHFS+DNPMXlZY9
         IvPRCrtuz2CqodSYtF8ANt8Ih6fnDsCM7iPLurmMVaQh+MycQBufu7hzVmceH9YBgz1V
         CcZHb2SqwCGBNj0TuCfG5kvP8hDDMVd1qiFmKu5aHvEiERdyQbzRSwCqA5W7XQBw5i5d
         s0LZX/SCRk8vzkIaQzrHe2mEVPvTiXvdCXDw/atGddRzUnBL11J44oM95sBXRTZTfxk2
         tM/uKl8RhQF0lHdmNxalQ7LQRUIj6gy6EuRTXysIiyOB9v7NArH/qbiPCnpfDkoC8VfY
         F4IA==
X-Gm-Message-State: AFq9FYI2CN8aPMwuuSKm8b90FcduUaF2yIQZ3WXyDrrbLmCbWQy0QNra
	5RQ6kmfK5lSnTZSLqJuJ6pLCcctIY96IwmoHEhLD5SwxQFt7WD+bYlJA40qBOV5lOrI=
X-Gm-Gg: AYBFou1qQH1ZxRhFegSbPkzYvDBBiCnCUE36Y2xcwmt9vppjsT1yiNmYladEfvDMDLu
	rXV2npihGnZr5iyvtlufafy+q9nDzHaikJn0PYTH4xAQJIBQRzpwiq+uE5o+eJFgMRZstrt60zc
	sgia8hMBsoIkYqkDi1XOw2tYBck3gk0+TqmKHAVXqOlgXWKjyjiWZqLVzXPdJhwGQC3Ywged5Mh
	u+kyWwVNospaF8Q1aCyWrlcdTiS5LYBZJ0w4P8iCqSsvUNkqv8dOxxypbj7fWkCD1KLSViIXP+v
	c4GTodX6Qs57OyGRrUnoCAkju3+Wethr6AoKq07pAHGXxfPHA33ae6pf2x7/NKmqKBN3eDfOW95
	3Ykoewb/H55kFQm0YI8fCd7MktQ1t53eI12U/FamVReQ0Sd7ksXXWiyRs9foS5nttfbaKE5hsgf
	mvnpu5OqvahMTOLV2MDSLEu9976S0xUgaC9r6UsFy3NkXx/Ad4CLZzPc70YQROQBY3xb1Mb1wTC
	mSRo9aC8EAw1wuvN31It/r4L3jiTv6hSJiJ8R6TamnZwrGtdcl/we0Om0+4E3jXDnUSyXCboU3q
	caVIHTiB9pNfMRbvqL9MbmbjQH5XEBg7
X-Received: by 2002:a05:7300:f797:b0:36a:22df:412d with SMTP id 5a478bee46e88-36a42427cd3mr7756230eec.39.1793455535501;
        Sat, 31 Oct 2026 07:05:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.111.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm20522746eec.26.2026.10.31.07.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:05:27 -0700 (PDT)
Message-Id: <pull.2273.v2.git.1793455522168.gitgitgadget@gmail.com>
In-Reply-To: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
References: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
From: "Nakul V S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 14:05:22 +0000
Subject: [PATCH v2] sequencer: refuse to pick or revert shallow boundary
 commits
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Nakul V S <vsnakul@gmail.com>,
    Nakul V S <vsnakul@gmail.com>

From: Nakul V S <vsnakul@gmail.com>

In a shallow repository, the commits at the edge of the downloaded
history are recorded in $GIT_DIR/shallow and have their parents hidden
from the revision machinery.  Such a "shallow boundary" commit looks
like a root commit that added every file in its tree at once.

Reverting it therefore removes every tracked file, and cherry-picking
or rebasing it adds all of them again.  In a "git clone --depth=1" this
is the only commit there is, so "git revert HEAD" empties the working
tree, which is almost never what the user meant.

Refuse to do so by default for "revert", "cherry-pick" and "rebase".
For "revert" and "cherry-pick" only, add --allow-shallow-boundary to
override the check; it is remembered across --continue.  "rebase"
always refuses, and the error message suggests "git fetch --unshallow"
instead.

The check is made when the list of commits to replay is built, not when
each commit is picked, so a command that is going to be refused does so
before it has done anything: no commit is created, HEAD and the working
tree are untouched, and no sequencer or rebase state is left behind for
the user to clean up.

The "apply" backend of "rebase" does not go through the sequencer, so
it checks the commits "git format-patch" is about to turn into patches
before it rewinds HEAD.  This is skipped altogether in a repository
that is not shallow.

A "pick" or "revert" line for a shallow boundary commit that the user
types into the todo list by hand is not checked, as the check is not
made again after the todo list has been edited.  "git commit --amend"
is also left alone for now.

Signed-off-by: Nakul V S <vsnakul@gmail.com>
---
    sequencer: refuse to pick or revert shallow boundary commits by default
    
    Changes since v1:
    
     * Also refuse cherry-pick and rebase (merge, interactive and --apply
       backends), as suggested by Phillip.
     * Check when the list of commits is built rather than in
       do_pick_commit(), so a refused command leaves no state behind. Uses a
       single shared helper.
     * --allow-shallow-boundary is now accepted by cherry-pick as well, and
       is saved across --continue.
     * Dropped the option from the revert synopsis.
     * rebase --autostash restores the user's changes if the rebase is
       refused.
     * Rebased onto current master.
    
    Not covered here: git commit --amend, and pick/revert lines typed into
    the rebase todo by hand.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2273%2Fvsnakul%2Fsequencer-shallow-boundary-check-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2273/vsnakul/sequencer-shallow-boundary-check-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2273

Range-diff vs v1:

 1:  526b96f6ba ! 1:  fef8178d4d sequencer: refuse to revert shallow boundary commits by default
     @@ Metadata
      Author: Nakul V S <vsnakul@gmail.com>
      
       ## Commit message ##
     -    sequencer: refuse to revert shallow boundary commits by default
     +    sequencer: refuse to pick or revert shallow boundary commits
      
     -    When a repository is cloned with --depth=1, Git records the boundary
     -    commit in .git/shallow and rewrites its parent links via the graft
     -    mechanism, making it appear as a root commit. Reverting such a commit
     -    will therefore delete all tracked files, which is almost always
     -    unintended by the user.
     +    In a shallow repository, the commits at the edge of the downloaded
     +    history are recorded in $GIT_DIR/shallow and have their parents hidden
     +    from the revision machinery.  Such a "shallow boundary" commit looks
     +    like a root commit that added every file in its tree at once.
      
     -    Add a check in do_pick_commit() that detects when the target commit is
     -    a shallow boundary (nr_parent < 0 in the commit graft) and refuses the
     -    operation by default. A new --allow-shallow-boundary flag is provided
     -    for the rare cases where the user genuinely intends this behavior.
     +    Reverting it therefore removes every tracked file, and cherry-picking
     +    or rebasing it adds all of them again.  In a "git clone --depth=1" this
     +    is the only commit there is, so "git revert HEAD" empties the working
     +    tree, which is almost never what the user meant.
     +
     +    Refuse to do so by default for "revert", "cherry-pick" and "rebase".
     +    For "revert" and "cherry-pick" only, add --allow-shallow-boundary to
     +    override the check; it is remembered across --continue.  "rebase"
     +    always refuses, and the error message suggests "git fetch --unshallow"
     +    instead.
     +
     +    The check is made when the list of commits to replay is built, not when
     +    each commit is picked, so a command that is going to be refused does so
     +    before it has done anything: no commit is created, HEAD and the working
     +    tree are untouched, and no sequencer or rebase state is left behind for
     +    the user to clean up.
     +
     +    The "apply" backend of "rebase" does not go through the sequencer, so
     +    it checks the commits "git format-patch" is about to turn into patches
     +    before it rewinds HEAD.  This is skipped altogether in a repository
     +    that is not shallow.
     +
     +    A "pick" or "revert" line for a shallow boundary commit that the user
     +    types into the todo list by hand is not checked, as the check is not
     +    made again after the todo list has been edited.  "git commit --amend"
     +    is also left alone for now.
      
          Signed-off-by: Nakul V S <vsnakul@gmail.com>
      
     + ## Documentation/git-cherry-pick.adoc ##
     +@@ Documentation/git-cherry-pick.adoc: fail unless one of `--empty=keep` or `--allow-empty` are specified.
     + 	Pass the merge strategy-specific option through to the
     + 	merge strategy.  See linkgit:git-merge[1] for details.
     + 
     ++--allow-shallow-boundary::
     ++	By default, 'git cherry-pick' refuses to pick a commit that is a
     ++	shallow boundary (i.e. a commit listed in `.git/shallow`).
     ++	Its parents are missing from this repository, so it looks like
     ++	a root commit that added every file in its tree, and picking it
     ++	would add all of them.  This option overrides that safeguard.
     +++
     ++To get the missing history instead, use `git fetch --unshallow`.
     ++
     + include::rerere-options.adoc[]
     + 
     + SEQUENCER SUBCOMMANDS
     +
     + ## Documentation/git-rebase.adoc ##
     +@@ Documentation/git-rebase.adoc: repository that you share.
     + See also <<RECOVERING_FROM_UPSTREAM_REBASE,RECOVERING FROM UPSTREAM REBASE>>
     + below.
     + 
     ++If the commits to be rebased include a shallow boundary commit (a
     ++commit listed in `.git/shallow`), the rebase refuses to start, because
     ++the missing parents make that commit look like a root commit that added
     ++every file in its tree.  This applies to both the `merge` and `apply`
     ++backends, and nothing is changed when the rebase is refused.  Run
     ++`git fetch --unshallow` to get the missing history first.
     ++
     + When the rebase is run, it will first execute a `pre-rebase` hook if one
     + exists.  You can use this hook to do sanity checks and reject the rebase
     + if it isn't appropriate.  Please see the template `pre-rebase` hook script
     +
       ## Documentation/git-revert.adoc ##
     -@@ Documentation/git-revert.adoc: git-revert - Revert some existing commits
     - SYNOPSIS
     - --------
     - [verse]
     --'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>...
     -+'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] [--allow-shallow-boundary] <commit>...
     - 'git revert' (--continue | --skip | --abort | --quit)
     - 
     - DESCRIPTION
      @@ Documentation/git-revert.adoc: include::rerere-options.adoc[]
       	configuration variable can be used to enable this option by
       	default.
       
      +--allow-shallow-boundary::
      +	By default, 'git revert' refuses to revert a commit that is a
     -+	shallow boundary (i.e. a commit listed in `.git/shallow`),
     -+	because its true parent history is absent from the clone and
     -+	reverting it would remove all tracked files. This option
     -+	overrides that safeguard and allows the revert to proceed.
     ++	shallow boundary (i.e. a commit listed in `.git/shallow`).
     ++	Its parents are missing from this repository, so it looks like
     ++	a root commit that added every file in its tree, and reverting
     ++	it would remove all of them.  This option overrides that
     ++	safeguard.
      ++
     -+To restore full history before reverting, use
     -+`git fetch --unshallow` instead.
     ++To get the missing history instead, use `git fetch --unshallow`.
      +
       
       SEQUENCER SUBCOMMANDS
       ---------------------
      
     - ## builtin/revert.c ##
     + ## builtin/rebase.c ##
      @@
     -  */
     - 
     - static const char * const revert_usage[] = {
     --	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
     -+	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] [--allow-shallow-boundary] <commit>..."),
     - 	N_("git revert (--continue | --skip | --abort | --quit)"),
     - 	NULL
     - };
     + #include "sequencer.h"
     + #include "rebase-interactive.h"
     + #include "reset.h"
     ++#include "shallow.h"
     + #include "trace2.h"
     + #include "hook.h"
     + #include "trailer.h"
     +@@ builtin/rebase.c: static int init_basic_state(struct replay_opts *opts, const char *head_name,
     + 	return write_basic_state(opts, head_name, onto, orig_head);
     + }
     + 
     ++static int cleanup_autostash(struct rebase_options *opts);
     ++
     + static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
     + {
     + 	int ret = -1;
     +@@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
     + 				    &make_script_args, flags);
     + 	if (ret) {
     + 		error(_("could not generate todo list"));
     ++		/* Nothing has been started yet; put back what we stashed */
     ++		cleanup_autostash(opts);
     + 		goto cleanup;
     + 	}
     + 
     +@@ builtin/rebase.c: static int move_to_original_branch(struct rebase_options *opts)
     + 	return ret;
     + }
     + 
     ++/*
     ++ * The "apply" backend does not go through the sequencer, so check here that
     ++ * none of the commits "git format-patch" is about to turn into patches is a
     ++ * shallow boundary commit.  This walks the same set of commits as run_am().
     ++ */
     ++static int check_no_shallow_boundary_to_apply(struct rebase_options *opts)
     ++{
     ++	struct rev_info revs;
     ++	struct strvec args = STRVEC_INIT;
     ++	struct commit *commit;
     ++	int ret = 0;
     ++
     ++	if (!is_repository_shallow(the_repository))
     ++		return 0;
     ++
     ++	repo_init_revisions(the_repository, &revs, NULL);
     ++	revs.max_parents = 1;
     ++	revs.cherry_pick = 1;
     ++	revs.right_only = 1;
     ++	revs.limited = 1;
     ++
     ++	strvec_push(&args, "");
     ++	strvec_pushf(&args, "%s...%s",
     ++		     oid_to_hex(opts->root ?
     ++				&opts->onto->object.oid :
     ++				&opts->upstream->object.oid),
     ++		     oid_to_hex(&opts->orig_head->object.oid));
     ++	if (opts->restrict_revision)
     ++		strvec_pushf(&args, "^%s",
     ++			     oid_to_hex(&opts->restrict_revision->object.oid));
     ++
     ++	setup_revisions_from_strvec(&args, &revs, NULL);
     ++	if (prepare_revision_walk(&revs)) {
     ++		ret = error(_("revision walk setup failed"));
     ++		goto out;
     ++	}
     ++	while ((commit = get_revision(&revs))) {
     ++		if (sequencer_refuse_shallow_boundary(the_repository, commit, 0)) {
     ++			ret = -1;
     ++			break;
     ++		}
     ++	}
     ++
     ++out:
     ++	release_revisions(&revs);
     ++	strvec_clear(&args);
     ++	return ret;
     ++}
     ++
     + static int run_am(struct rebase_options *opts)
     + {
     + 	struct child_process am = CHILD_PROCESS_INIT;
     +@@ builtin/rebase.c: int cmd_rebase(int argc,
     + 	if (is_merge(&options))
     + 		goto run_rebase;
     + 
     ++	/* Fail before HEAD or the working tree has been touched */
     ++	if (check_no_shallow_boundary_to_apply(&options)) {
     ++		ret = -1;
     ++		goto cleanup_autostash;
     ++	}
     ++
     + 	/* Detach HEAD and reset the tree */
     + 	if (options.flags & REBASE_NO_QUIET)
     + 		printf(_("First, rewinding head to replay your work on top of "
     +
     + ## builtin/revert.c ##
      @@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, const char *prefix,
       		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
       		OPT_NOOP_NOARG('r', NULL),
       		OPT_BOOL('s', "signoff", &opts->signoff, N_("add a Signed-off-by trailer")),
      +		OPT_BOOL(0, "allow-shallow-boundary", &opts->allow_shallow_boundary,
     -+			 N_("allow reverting a shallow boundary commit")),
     ++			 N_("allow picking or reverting a shallow boundary commit")),
       		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
       			     N_("select mainline parent"), option_parse_m),
       		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
     +@@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, const char *prefix,
     + 				"--strategy-option", opts->xopts.nr ? 1 : 0,
     + 				"-x", opts->record_origin,
     + 				"--ff", opts->allow_ff,
     ++				"--allow-shallow-boundary", opts->allow_shallow_boundary,
     + 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
     + 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
     + 				"--keep-redundant-commits", opts->keep_redundant_commits,
      
       ## sequencer.c ##
      @@
     @@ sequencer.c
       
       #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
       
     -@@ sequencer.c: static enum pick_result do_pick_commit(struct repository *r,
     +@@ sequencer.c: static int populate_opts_cb(const char *key, const char *value,
     + 		opts->record_origin = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
     + 	else if (!strcmp(key, "options.allow-ff"))
     + 		opts->allow_ff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
     ++	else if (!strcmp(key, "options.allow-shallow-boundary"))
     ++		opts->allow_shallow_boundary =
     ++			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
     + 	else if (!strcmp(key, "options.mainline"))
     + 		opts->mainline = git_config_int(key, value, ctx->kvi);
     + 	else if (!strcmp(key, "options.strategy"))
     +@@ sequencer.c: int write_basic_state(struct replay_opts *opts, const char *head_name,
     + 	return 0;
     + }
     + 
     ++/*
     ++ * A shallow boundary commit has had its parents hidden, so it looks like
     ++ * a root commit that added every file at once.  Picking or reverting it
     ++ * would not do what the user expects, so refuse before anything is
     ++ * started.
     ++ */
     ++int sequencer_refuse_shallow_boundary(struct repository *r,
     ++				      const struct commit *commit, int allow)
     ++{
     ++	if (allow || !is_shallow_boundary_commit(r, &commit->object.oid))
     ++		return 0;
     ++	return error(_("commit %s is a shallow boundary commit; its parents "
     ++		       "are missing from this clone (use 'git fetch --unshallow' "
     ++		       "to get them)"),
     ++		     oid_to_hex(&commit->object.oid));
     ++}
     ++
     + static int walk_revs_populate_todo(struct todo_list *todo_list,
     + 				struct replay_opts *opts)
     + {
     +@@ sequencer.c: static int walk_revs_populate_todo(struct todo_list *todo_list,
     + 	encoding = get_log_output_encoding();
     + 
     + 	while ((commit = get_revision(opts->revs))) {
     +-		struct todo_item *item = append_new_todo(todo_list);
     +-		const char *commit_buffer = repo_logmsg_reencode(the_repository,
     +-								 commit, NULL,
     +-								 encoding);
     ++		struct todo_item *item;
     ++		const char *commit_buffer;
     + 		const char *subject;
     + 		int subject_len;
     + 
     ++		if (sequencer_refuse_shallow_boundary(the_repository, commit,
     ++					    opts->allow_shallow_boundary))
     ++			return -1;
     ++
     ++		item = append_new_todo(todo_list);
     ++		commit_buffer = repo_logmsg_reencode(the_repository, commit,
     ++						     NULL, encoding);
     + 		item->command = command;
     + 		item->commit = commit;
     + 		item->arg_offset = 0;
     +@@ sequencer.c: static int save_opts(struct replay_opts *opts)
     + 	if (opts->allow_ff)
     + 		res |= repo_config_set_in_file_gently(the_repository, opts_file,
     + 					"options.allow-ff", NULL, "true");
     ++	if (opts->allow_shallow_boundary)
     ++		res |= repo_config_set_in_file_gently(the_repository, opts_file,
     ++				"options.allow-shallow-boundary", NULL, "true");
     + 	if (opts->mainline) {
     + 		struct strbuf buf = STRBUF_INIT;
     + 		strbuf_addf(&buf, "%d", opts->mainline);
     +@@ sequencer.c: static int single_pick(struct repository *r,
     + 	int check_todo;
     + 	struct todo_item item;
     + 
     ++	if (sequencer_refuse_shallow_boundary(r, cmit, opts->allow_shallow_boundary))
     ++		return -1;
     ++
     + 	item.command = opts->action == REPLAY_PICK ?
     + 			TODO_PICK : TODO_REVERT;
     + 	item.commit = cmit;
     +@@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
     + 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
     + 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
     + 	int skipped_commit = 0;
     ++	int ret = 0;
     + 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
     + 	struct strbuf label_from_message = STRBUF_INIT;
     + 	struct commit_list *commits = NULL, **tail = &commits, *iter;
     +@@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
     + 		}
     + 		if (is_empty && !keep_empty)
     + 			continue;
     ++		if (sequencer_refuse_shallow_boundary(the_repository, commit, 0)) {
     ++			ret = -1;
     ++			goto cleanup;
     ++		}
     + 
     + 		strbuf_reset(&oneline);
     + 		pretty_print_commit(pp, commit, &oneline);
     +@@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
     + 		commit_list_free(list);
       	}
     - 	discard_index(r->index);
     - 
     -+	if (is_repository_shallow(r)) {
     -+		struct commit_graft *graft = lookup_commit_graft(r, &commit->object.oid);
     -+		if (graft && graft->nr_parent < 0 && !opts->allow_shallow_boundary) {
     -+			return error(_("%s: commit %s is a shallow boundary commit.\n"
     -+				       "Reverting it will remove all tracked files because its\n"
     -+				       "true parent history is not present in this clone.\n"
     -+				       "Use --allow-shallow-boundary to override, or\n"
     -+				       "'git fetch --unshallow' to restore full history first."),
     -+				     command_to_string(command),
     -+				     oid_to_hex(&commit->object.oid));
     + 
     ++cleanup:
     + 	commit_list_free(commits);
     + 	commit_list_free(tips);
     + 
     +@@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
     + 	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
     + 	strbuf_release(&state.buf);
     + 
     +-	return 0;
     ++	return ret;
     + }
     + 
     + int sequencer_make_script(struct repository *r, struct strbuf *out,
     +@@ sequencer.c: int sequencer_make_script(struct repository *r, struct strbuf *out,
     + 		}
     + 		if (is_empty && !keep_empty)
     + 			continue;
     ++		if (sequencer_refuse_shallow_boundary(r, commit, 0)) {
     ++			ret = -1;
     ++			goto cleanup;
      +		}
     -+	}
     -+
     - 	if (!commit->parents)
     - 		parent = NULL;
     - 	else if (commit->parents->next) {
     + 		strbuf_addf(out, "%s %s ", insn,
     + 			    oid_to_hex(&commit->object.oid));
     + 		pretty_print_commit(&pp, commit, out);
      
       ## sequencer.h ##
      @@ sequencer.h: struct replay_opts {
     @@ sequencer.h: struct replay_opts {
       
       	struct strvec trailer_args;
       
     +@@ sequencer.h: int sequencer_remove_state(struct replay_opts *opts);
     + #define TODO_LIST_REAPPLY_CHERRY_PICKS (1U << 7)
     + #define TODO_LIST_WARN_SKIPPED_CHERRY_PICKS (1U << 8)
     + 
     ++/*
     ++ * Return -1 after reporting an error if "commit" is a shallow boundary
     ++ * commit and "allow" is zero, 0 otherwise.
     ++ */
     ++int sequencer_refuse_shallow_boundary(struct repository *r,
     ++				      const struct commit *commit, int allow);
     + int sequencer_make_script(struct repository *r, struct strbuf *out,
     + 			  struct strvec *argv, unsigned flags);
     + 
     +
     + ## shallow.c ##
     +@@ shallow.c: int is_repository_shallow(struct repository *r)
     + 	return r->parsed_objects->is_shallow;
     + }
     + 
     ++int is_shallow_boundary_commit(struct repository *r, const struct object_id *oid)
     ++{
     ++	struct commit_graft *graft;
     ++	if (!is_repository_shallow(r))
     ++		return 0;
     ++	graft = lookup_commit_graft(r, oid);
     ++	return graft && graft->nr_parent < 0;
     ++}
     ++
     + static void reset_repository_shallow(struct repository *r)
     + {
     + 	r->parsed_objects->is_shallow = -1;
     +
     + ## shallow.h ##
     +@@ shallow.h: void set_alternate_shallow_file(struct repository *r, const char *path);
     + int register_shallow(struct repository *r, const struct object_id *oid);
     + int unregister_shallow(const struct object_id *oid);
     + int is_repository_shallow(struct repository *r);
     ++int is_shallow_boundary_commit(struct repository *r, const struct object_id *oid);
     + 
     + /*
     +  * Lock for updating the $GIT_DIR/shallow file.
      
       ## t/t3501-revert-cherry-pick.sh ##
      @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick is unaware of --reference (for now)' '
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick is unaware of --
      +# Tests for shallow boundary safeguard
      +
      +test_expect_success 'setup shallow boundary tests' '
     -+	git init src &&
     -+	test_commit -C src A &&
     -+	test_commit -C src B &&
     -+	git clone --no-local --depth=1 src shallow-repo
     ++	git init shallow-src &&
     ++	test_commit -C shallow-src A &&
     ++	test_commit -C shallow-src B &&
     ++	test_commit -C shallow-src C &&
     ++	git clone --no-local --depth=2 "file://$(pwd)/shallow-src" shallow-repo &&
     ++	git -C shallow-repo rev-parse --verify B >boundary &&
     ++	test_cmp shallow-repo/.git/shallow boundary
     ++'
     ++
     ++test_expect_success 'revert of shallow boundary commit is refused' '
     ++	git -C shallow-repo reset --hard C &&
     ++	test_must_fail git -C shallow-repo revert --no-edit B 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_missing shallow-repo/.git/sequencer &&
     ++	test_path_is_missing shallow-repo/.git/REVERT_HEAD &&
     ++	git -C shallow-repo rev-parse C >expect &&
     ++	git -C shallow-repo rev-parse HEAD >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'cherry-pick of shallow boundary commit is refused' '
     ++	git -C shallow-repo checkout -q --detach C &&
     ++	git -C shallow-repo rm -rq . &&
     ++	git -C shallow-repo commit -q -m empty &&
     ++	git -C shallow-repo rev-parse HEAD >expect &&
     ++	test_must_fail git -C shallow-repo cherry-pick B 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	git -C shallow-repo rev-parse HEAD >actual &&
     ++	test_cmp expect actual &&
     ++	git -C shallow-repo reset -q --hard C
     ++'
     ++
     ++test_expect_success 'revert of non-boundary commit in shallow repo works' '
     ++	git -C shallow-repo revert --no-edit C &&
     ++	git -C shallow-repo reset -q --hard C
     ++'
     ++
     ++test_expect_success 'multi-commit revert is refused before anything is reverted' '
     ++	test_must_fail git -C shallow-repo revert --no-edit C B 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_missing shallow-repo/.git/sequencer &&
     ++	git -C shallow-repo rev-parse C >expect &&
     ++	git -C shallow-repo rev-parse HEAD >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success '--allow-shallow-boundary overrides the revert check' '
     ++	git -C shallow-repo revert --no-edit --allow-shallow-boundary B &&
     ++	test_path_is_missing shallow-repo/B.t &&
     ++	git -C shallow-repo reset -q --hard C
     ++'
     ++
     ++test_expect_success '--allow-shallow-boundary overrides the cherry-pick check' '
     ++	git -C shallow-repo checkout -q --detach C &&
     ++	git -C shallow-repo rm -rq . &&
     ++	git -C shallow-repo commit -q -m empty &&
     ++	git -C shallow-repo cherry-pick --allow-shallow-boundary B &&
     ++	test_path_is_file shallow-repo/B.t &&
     ++	git -C shallow-repo reset -q --hard C
     ++'
     ++
     ++test_expect_success '--allow-shallow-boundary survives --continue' '
     ++	test_commit -C shallow-repo conflict-1 file one &&
     ++	test_commit -C shallow-repo conflict-2 file two &&
     ++	test_must_fail git -C shallow-repo revert --no-edit \
     ++		--allow-shallow-boundary conflict-1 B &&
     ++	echo resolved >shallow-repo/file &&
     ++	git -C shallow-repo add file &&
     ++	git -C shallow-repo revert --continue &&
     ++	test_path_is_missing shallow-repo/B.t &&
     ++	git -C shallow-repo reset -q --hard C
     ++'
     ++
     ++test_expect_success 'revert and cherry-pick in a non-shallow repo are unaffected' '
     ++	git init full-repo &&
     ++	test_commit -C full-repo A &&
     ++	test_commit -C full-repo B &&
     ++	git -C full-repo revert --no-edit B &&
     ++	git -C full-repo cherry-pick B &&
     ++	test_path_is_file full-repo/B.t
     ++'
     ++
     ++test_expect_success 'rebase of a range containing a shallow boundary is refused' '
     ++	git -C shallow-repo checkout -q --detach C &&
     ++	git -C shallow-repo rev-parse C >expect &&
     ++	test_must_fail git -C shallow-repo rebase --root 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_missing shallow-repo/.git/rebase-merge &&
     ++	git -C shallow-repo rev-parse HEAD >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'rebase --rebase-merges is refused as well' '
     ++	test_must_fail git -C shallow-repo rebase --rebase-merges --root 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_missing shallow-repo/.git/rebase-merge
     ++'
     ++
     ++test_expect_success 'rebase --apply of a range containing a shallow boundary is refused' '
     ++	git -C shallow-repo checkout -q --detach C &&
     ++	git -C shallow-repo checkout -q --orphan unrelated &&
     ++	git -C shallow-repo rm -rfq . &&
     ++	test_commit -C shallow-repo unrelated &&
     ++	git -C shallow-repo checkout -q --detach C &&
     ++	git -C shallow-repo rev-parse C >expect &&
     ++	test_must_fail git -C shallow-repo rebase --apply \
     ++		--onto unrelated unrelated 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_missing shallow-repo/.git/rebase-apply &&
     ++	git -C shallow-repo rev-parse HEAD >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'rebase --apply restores an autostash when refusing' '
     ++	echo dirty >shallow-repo/C.t &&
     ++	test_must_fail git -C shallow-repo rebase --apply --autostash \
     ++		--onto unrelated unrelated 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	echo dirty >expect &&
     ++	test_cmp expect shallow-repo/C.t &&
     ++	git -C shallow-repo stash list >stashes &&
     ++	test_must_be_empty stashes &&
     ++	git -C shallow-repo checkout -q -- C.t
     ++'
     ++
     ++test_expect_success 'rebase --apply that does not replay the boundary is unaffected' '
     ++	git -C shallow-repo checkout -q -B apply-topic C &&
     ++	test_commit -C shallow-repo E &&
     ++	git -C shallow-repo rebase --apply --onto unrelated C &&
     ++	test_path_is_file shallow-repo/E.t
     ++'
     ++
     ++test_expect_success 'rebase that does not replay the boundary is unaffected' '
     ++	git -C shallow-repo checkout -q -B topic C &&
     ++	test_commit -C shallow-repo D &&
     ++	git -C shallow-repo rebase C
     ++'
     ++
     ++test_expect_success 'rebase restores an autostash when refusing (merge backend)' '
     ++	git -C shallow-repo checkout -q --detach C &&
     ++	echo dirty >shallow-repo/C.t &&
     ++	test_must_fail git -C shallow-repo rebase --autostash --root 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_missing shallow-repo/.git/rebase-merge &&
     ++	echo dirty >expect &&
     ++	test_cmp expect shallow-repo/C.t &&
     ++	git -C shallow-repo stash list >stashes &&
     ++	test_must_be_empty stashes &&
     ++	git -C shallow-repo checkout -q -- C.t
     ++'
     ++
     ++test_expect_success 'interactive rebase restores an autostash when refusing' '
     ++	echo dirty >shallow-repo/C.t &&
     ++	test_must_fail env GIT_SEQUENCE_EDITOR=: \
     ++		git -C shallow-repo rebase -i --autostash --root 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_missing shallow-repo/.git/rebase-merge &&
     ++	echo dirty >expect &&
     ++	test_cmp expect shallow-repo/C.t &&
     ++	git -C shallow-repo stash list >stashes &&
     ++	test_must_be_empty stashes &&
     ++	git -C shallow-repo checkout -q -- C.t
     ++'
     ++
     ++test_expect_success 'rebase onto new upstream work in a shallow clone still works' '
     ++	git clone --no-local --depth=1 "file://$(pwd)/shallow-src" shallow-local &&
     ++	test_commit -C shallow-local local &&
     ++	test_commit -C shallow-src upstream &&
     ++	git -C shallow-local fetch origin &&
     ++	git -C shallow-local rebase origin/HEAD &&
     ++	test_path_is_file shallow-local/upstream.t &&
     ++	test_path_is_file shallow-local/local.t
      +'
      +
     -+test_expect_success 'revert of shallow boundary commit is refused by default' '
     -+	test_must_fail git -C shallow-repo revert --no-edit HEAD 2>err &&
     -+	test_grep "shallow boundary commit" err
     ++test_expect_success 'single-commit shallow clone: revert and cherry-pick are refused' '
     ++	git init one-src &&
     ++	test_commit -C one-src only &&
     ++	git clone --no-local --depth=1 "file://$(pwd)/one-src" one-shallow &&
     ++	git -C one-shallow rev-parse HEAD >expect &&
     ++	test_must_fail git -C one-shallow revert --no-edit HEAD 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_must_fail git -C one-shallow cherry-pick -n HEAD 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	test_path_is_file one-shallow/only.t &&
     ++	git -C one-shallow rev-parse HEAD >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'revert of shallow boundary succeeds with --allow-shallow-boundary' '
     -+	git -C shallow-repo revert --no-edit --allow-shallow-boundary HEAD
     ++test_expect_success 'revert and cherry-pick work once the clone is unshallowed' '
     ++	git clone --no-local --depth=2 "file://$(pwd)/shallow-src" unshallowed &&
     ++	test_must_fail git -C unshallowed revert --no-edit HEAD~1 2>err &&
     ++	test_grep "shallow boundary commit" err &&
     ++	git -C unshallowed fetch --unshallow &&
     ++	git -C unshallowed revert --no-edit C &&
     ++	test_path_is_missing unshallowed/C.t &&
     ++	git -C unshallowed cherry-pick C &&
     ++	test_path_is_file unshallowed/C.t
      +'
      +
     -+test_expect_success 'revert in non-shallow repo is unaffected' '
     -+	git init non-shallow &&
     -+	test_commit -C non-shallow A &&
     -+	test_commit -C non-shallow B &&
     -+	git -C non-shallow revert --no-edit HEAD
     ++test_expect_success '--allow-shallow-boundary cannot be combined with --abort' '
     ++	test_must_fail git -C shallow-repo revert --abort \
     ++		--allow-shallow-boundary 2>err &&
     ++	test_grep "cannot be used with" err
      +'
      +
       test_done


 Documentation/git-cherry-pick.adoc |   9 ++
 Documentation/git-rebase.adoc      |   7 +
 Documentation/git-revert.adoc      |  10 ++
 builtin/rebase.c                   |  60 +++++++++
 builtin/revert.c                   |   3 +
 sequencer.c                        |  52 +++++++-
 sequencer.h                        |   7 +
 shallow.c                          |   9 ++
 shallow.h                          |   1 +
 t/t3501-revert-cherry-pick.sh      | 208 +++++++++++++++++++++++++++++
 10 files changed, 361 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index f4cd8b9db7..ff6f1bf01d 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -178,6 +178,15 @@ fail unless one of `--empty=keep` or `--allow-empty` are specified.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+--allow-shallow-boundary::
+	By default, 'git cherry-pick' refuses to pick a commit that is a
+	shallow boundary (i.e. a commit listed in `.git/shallow`).
+	Its parents are missing from this repository, so it looks like
+	a root commit that added every file in its tree, and picking it
+	would add all of them.  This option overrides that safeguard.
++
+To get the missing history instead, use `git fetch --unshallow`.
+
 include::rerere-options.adoc[]
 
 SEQUENCER SUBCOMMANDS
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6536ebdc90..ed2ce2d46a 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -822,6 +822,13 @@ repository that you share.
 See also <<RECOVERING_FROM_UPSTREAM_REBASE,RECOVERING FROM UPSTREAM REBASE>>
 below.
 
+If the commits to be rebased include a shallow boundary commit (a
+commit listed in `.git/shallow`), the rebase refuses to start, because
+the missing parents make that commit look like a root commit that added
+every file in its tree.  This applies to both the `merge` and `apply`
+backends, and nothing is changed when the rebase is refused.  Run
+`git fetch --unshallow` to get the missing history first.
+
 When the rebase is run, it will first execute a `pre-rebase` hook if one
 exists.  You can use this hook to do sanity checks and reject the rebase
 if it isn't appropriate.  Please see the template `pre-rebase` hook script
diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e63..288eddcf6e 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -122,6 +122,16 @@ include::rerere-options.adoc[]
 	configuration variable can be used to enable this option by
 	default.
 
+--allow-shallow-boundary::
+	By default, 'git revert' refuses to revert a commit that is a
+	shallow boundary (i.e. a commit listed in `.git/shallow`).
+	Its parents are missing from this repository, so it looks like
+	a root commit that added every file in its tree, and reverting
+	it would remove all of them.  This option overrides that
+	safeguard.
++
+To get the missing history instead, use `git fetch --unshallow`.
+
 
 SEQUENCER SUBCOMMANDS
 ---------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 535db60181..2305a3a495 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -34,6 +34,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "shallow.h"
 #include "trace2.h"
 #include "hook.h"
 #include "trailer.h"
@@ -288,6 +289,8 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 	return write_basic_state(opts, head_name, onto, orig_head);
 }
 
+static int cleanup_autostash(struct rebase_options *opts);
+
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret = -1;
@@ -309,6 +312,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 				    &make_script_args, flags);
 	if (ret) {
 		error(_("could not generate todo list"));
+		/* Nothing has been started yet; put back what we stashed */
+		cleanup_autostash(opts);
 		goto cleanup;
 	}
 
@@ -618,6 +623,55 @@ static int move_to_original_branch(struct rebase_options *opts)
 	return ret;
 }
 
+/*
+ * The "apply" backend does not go through the sequencer, so check here that
+ * none of the commits "git format-patch" is about to turn into patches is a
+ * shallow boundary commit.  This walks the same set of commits as run_am().
+ */
+static int check_no_shallow_boundary_to_apply(struct rebase_options *opts)
+{
+	struct rev_info revs;
+	struct strvec args = STRVEC_INIT;
+	struct commit *commit;
+	int ret = 0;
+
+	if (!is_repository_shallow(the_repository))
+		return 0;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	revs.max_parents = 1;
+	revs.cherry_pick = 1;
+	revs.right_only = 1;
+	revs.limited = 1;
+
+	strvec_push(&args, "");
+	strvec_pushf(&args, "%s...%s",
+		     oid_to_hex(opts->root ?
+				&opts->onto->object.oid :
+				&opts->upstream->object.oid),
+		     oid_to_hex(&opts->orig_head->object.oid));
+	if (opts->restrict_revision)
+		strvec_pushf(&args, "^%s",
+			     oid_to_hex(&opts->restrict_revision->object.oid));
+
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (prepare_revision_walk(&revs)) {
+		ret = error(_("revision walk setup failed"));
+		goto out;
+	}
+	while ((commit = get_revision(&revs))) {
+		if (sequencer_refuse_shallow_boundary(the_repository, commit, 0)) {
+			ret = -1;
+			break;
+		}
+	}
+
+out:
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int run_am(struct rebase_options *opts)
 {
 	struct child_process am = CHILD_PROCESS_INIT;
@@ -1879,6 +1933,12 @@ int cmd_rebase(int argc,
 	if (is_merge(&options))
 		goto run_rebase;
 
+	/* Fail before HEAD or the working tree has been touched */
+	if (check_no_shallow_boundary_to_apply(&options)) {
+		ret = -1;
+		goto cleanup_autostash;
+	}
+
 	/* Detach HEAD and reset the tree */
 	if (options.flags & REBASE_NO_QUIET)
 		printf(_("First, rewinding head to replay your work on top of "
diff --git a/builtin/revert.c b/builtin/revert.c
index 52100a20cb..a2526f3095 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -128,6 +128,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
 		OPT_BOOL('s', "signoff", &opts->signoff, N_("add a Signed-off-by trailer")),
+		OPT_BOOL(0, "allow-shallow-boundary", &opts->allow_shallow_boundary,
+			 N_("allow picking or reverting a shallow boundary commit")),
 		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
 			     N_("select mainline parent"), option_parse_m),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
@@ -213,6 +215,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--strategy-option", opts->xopts.nr ? 1 : 0,
 				"-x", opts->record_origin,
 				"--ff", opts->allow_ff,
+				"--allow-shallow-boundary", opts->allow_shallow_boundary,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
 				"--keep-redundant-commits", opts->keep_redundant_commits,
diff --git a/sequencer.c b/sequencer.c
index 508ec71792..8d38ac3878 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -49,6 +49,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
+#include "shallow.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3201,6 +3202,9 @@ static int populate_opts_cb(const char *key, const char *value,
 		opts->record_origin = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
 		opts->allow_ff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	else if (!strcmp(key, "options.allow-shallow-boundary"))
+		opts->allow_shallow_boundary =
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value, ctx->kvi);
 	else if (!strcmp(key, "options.strategy"))
@@ -3466,6 +3470,23 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 	return 0;
 }
 
+/*
+ * A shallow boundary commit has had its parents hidden, so it looks like
+ * a root commit that added every file at once.  Picking or reverting it
+ * would not do what the user expects, so refuse before anything is
+ * started.
+ */
+int sequencer_refuse_shallow_boundary(struct repository *r,
+				      const struct commit *commit, int allow)
+{
+	if (allow || !is_shallow_boundary_commit(r, &commit->object.oid))
+		return 0;
+	return error(_("commit %s is a shallow boundary commit; its parents "
+		       "are missing from this clone (use 'git fetch --unshallow' "
+		       "to get them)"),
+		     oid_to_hex(&commit->object.oid));
+}
+
 static int walk_revs_populate_todo(struct todo_list *todo_list,
 				struct replay_opts *opts)
 {
@@ -3481,13 +3502,18 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	encoding = get_log_output_encoding();
 
 	while ((commit = get_revision(opts->revs))) {
-		struct todo_item *item = append_new_todo(todo_list);
-		const char *commit_buffer = repo_logmsg_reencode(the_repository,
-								 commit, NULL,
-								 encoding);
+		struct todo_item *item;
+		const char *commit_buffer;
 		const char *subject;
 		int subject_len;
 
+		if (sequencer_refuse_shallow_boundary(the_repository, commit,
+					    opts->allow_shallow_boundary))
+			return -1;
+
+		item = append_new_todo(todo_list);
+		commit_buffer = repo_logmsg_reencode(the_repository, commit,
+						     NULL, encoding);
 		item->command = command;
 		item->commit = commit;
 		item->arg_offset = 0;
@@ -3799,6 +3825,9 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->allow_ff)
 		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.allow-ff", NULL, "true");
+	if (opts->allow_shallow_boundary)
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
+				"options.allow-shallow-boundary", NULL, "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
@@ -5692,6 +5721,9 @@ static int single_pick(struct repository *r,
 	int check_todo;
 	struct todo_item item;
 
+	if (sequencer_refuse_shallow_boundary(r, cmit, opts->allow_shallow_boundary))
+		return -1;
+
 	item.command = opts->action == REPLAY_PICK ?
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
@@ -6078,6 +6110,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
 	int skipped_commit = 0;
+	int ret = 0;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label_from_message = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -6141,6 +6174,10 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 		if (is_empty && !keep_empty)
 			continue;
+		if (sequencer_refuse_shallow_boundary(the_repository, commit, 0)) {
+			ret = -1;
+			goto cleanup;
+		}
 
 		strbuf_reset(&oneline);
 		pretty_print_commit(pp, commit, &oneline);
@@ -6307,6 +6344,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		commit_list_free(list);
 	}
 
+cleanup:
 	commit_list_free(commits);
 	commit_list_free(tips);
 
@@ -6322,7 +6360,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
 	strbuf_release(&state.buf);
 
-	return 0;
+	return ret;
 }
 
 int sequencer_make_script(struct repository *r, struct strbuf *out,
@@ -6394,6 +6432,10 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
 		}
 		if (is_empty && !keep_empty)
 			continue;
+		if (sequencer_refuse_shallow_boundary(r, commit, 0)) {
+			ret = -1;
+			goto cleanup;
+		}
 		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
diff --git a/sequencer.h b/sequencer.h
index a5d12a1070..1035cc38d2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -57,6 +57,7 @@ struct replay_opts {
 	int committer_date_is_author_date;
 	int ignore_date;
 	int commit_use_reference;
+	int allow_shallow_boundary;
 
 	struct strvec trailer_args;
 
@@ -197,6 +198,12 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_REAPPLY_CHERRY_PICKS (1U << 7)
 #define TODO_LIST_WARN_SKIPPED_CHERRY_PICKS (1U << 8)
 
+/*
+ * Return -1 after reporting an error if "commit" is a shallow boundary
+ * commit and "allow" is zero, 0 otherwise.
+ */
+int sequencer_refuse_shallow_boundary(struct repository *r,
+				      const struct commit *commit, int allow);
 int sequencer_make_script(struct repository *r, struct strbuf *out,
 			  struct strvec *argv, unsigned flags);
 
diff --git a/shallow.c b/shallow.c
index 8e244a5669..bc31ff5232 100644
--- a/shallow.c
+++ b/shallow.c
@@ -92,6 +92,15 @@ int is_repository_shallow(struct repository *r)
 	return r->parsed_objects->is_shallow;
 }
 
+int is_shallow_boundary_commit(struct repository *r, const struct object_id *oid)
+{
+	struct commit_graft *graft;
+	if (!is_repository_shallow(r))
+		return 0;
+	graft = lookup_commit_graft(r, oid);
+	return graft && graft->nr_parent < 0;
+}
+
 static void reset_repository_shallow(struct repository *r)
 {
 	r->parsed_objects->is_shallow = -1;
diff --git a/shallow.h b/shallow.h
index 6a64db42c9..c3fb6b929e 100644
--- a/shallow.h
+++ b/shallow.h
@@ -14,6 +14,7 @@ void set_alternate_shallow_file(struct repository *r, const char *path);
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);
+int is_shallow_boundary_commit(struct repository *r, const struct object_id *oid);
 
 /*
  * Lock for updating the $GIT_DIR/shallow file.
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 939e7a16a6..49da8427cf 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -256,4 +256,212 @@ test_expect_success 'cherry-pick is unaware of --reference (for now)' '
 	test_grep "^usage: git cherry-pick" actual
 '
 
+# Tests for shallow boundary safeguard
+
+test_expect_success 'setup shallow boundary tests' '
+	git init shallow-src &&
+	test_commit -C shallow-src A &&
+	test_commit -C shallow-src B &&
+	test_commit -C shallow-src C &&
+	git clone --no-local --depth=2 "file://$(pwd)/shallow-src" shallow-repo &&
+	git -C shallow-repo rev-parse --verify B >boundary &&
+	test_cmp shallow-repo/.git/shallow boundary
+'
+
+test_expect_success 'revert of shallow boundary commit is refused' '
+	git -C shallow-repo reset --hard C &&
+	test_must_fail git -C shallow-repo revert --no-edit B 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_missing shallow-repo/.git/sequencer &&
+	test_path_is_missing shallow-repo/.git/REVERT_HEAD &&
+	git -C shallow-repo rev-parse C >expect &&
+	git -C shallow-repo rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick of shallow boundary commit is refused' '
+	git -C shallow-repo checkout -q --detach C &&
+	git -C shallow-repo rm -rq . &&
+	git -C shallow-repo commit -q -m empty &&
+	git -C shallow-repo rev-parse HEAD >expect &&
+	test_must_fail git -C shallow-repo cherry-pick B 2>err &&
+	test_grep "shallow boundary commit" err &&
+	git -C shallow-repo rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+	git -C shallow-repo reset -q --hard C
+'
+
+test_expect_success 'revert of non-boundary commit in shallow repo works' '
+	git -C shallow-repo revert --no-edit C &&
+	git -C shallow-repo reset -q --hard C
+'
+
+test_expect_success 'multi-commit revert is refused before anything is reverted' '
+	test_must_fail git -C shallow-repo revert --no-edit C B 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_missing shallow-repo/.git/sequencer &&
+	git -C shallow-repo rev-parse C >expect &&
+	git -C shallow-repo rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--allow-shallow-boundary overrides the revert check' '
+	git -C shallow-repo revert --no-edit --allow-shallow-boundary B &&
+	test_path_is_missing shallow-repo/B.t &&
+	git -C shallow-repo reset -q --hard C
+'
+
+test_expect_success '--allow-shallow-boundary overrides the cherry-pick check' '
+	git -C shallow-repo checkout -q --detach C &&
+	git -C shallow-repo rm -rq . &&
+	git -C shallow-repo commit -q -m empty &&
+	git -C shallow-repo cherry-pick --allow-shallow-boundary B &&
+	test_path_is_file shallow-repo/B.t &&
+	git -C shallow-repo reset -q --hard C
+'
+
+test_expect_success '--allow-shallow-boundary survives --continue' '
+	test_commit -C shallow-repo conflict-1 file one &&
+	test_commit -C shallow-repo conflict-2 file two &&
+	test_must_fail git -C shallow-repo revert --no-edit \
+		--allow-shallow-boundary conflict-1 B &&
+	echo resolved >shallow-repo/file &&
+	git -C shallow-repo add file &&
+	git -C shallow-repo revert --continue &&
+	test_path_is_missing shallow-repo/B.t &&
+	git -C shallow-repo reset -q --hard C
+'
+
+test_expect_success 'revert and cherry-pick in a non-shallow repo are unaffected' '
+	git init full-repo &&
+	test_commit -C full-repo A &&
+	test_commit -C full-repo B &&
+	git -C full-repo revert --no-edit B &&
+	git -C full-repo cherry-pick B &&
+	test_path_is_file full-repo/B.t
+'
+
+test_expect_success 'rebase of a range containing a shallow boundary is refused' '
+	git -C shallow-repo checkout -q --detach C &&
+	git -C shallow-repo rev-parse C >expect &&
+	test_must_fail git -C shallow-repo rebase --root 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_missing shallow-repo/.git/rebase-merge &&
+	git -C shallow-repo rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --rebase-merges is refused as well' '
+	test_must_fail git -C shallow-repo rebase --rebase-merges --root 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_missing shallow-repo/.git/rebase-merge
+'
+
+test_expect_success 'rebase --apply of a range containing a shallow boundary is refused' '
+	git -C shallow-repo checkout -q --detach C &&
+	git -C shallow-repo checkout -q --orphan unrelated &&
+	git -C shallow-repo rm -rfq . &&
+	test_commit -C shallow-repo unrelated &&
+	git -C shallow-repo checkout -q --detach C &&
+	git -C shallow-repo rev-parse C >expect &&
+	test_must_fail git -C shallow-repo rebase --apply \
+		--onto unrelated unrelated 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_missing shallow-repo/.git/rebase-apply &&
+	git -C shallow-repo rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --apply restores an autostash when refusing' '
+	echo dirty >shallow-repo/C.t &&
+	test_must_fail git -C shallow-repo rebase --apply --autostash \
+		--onto unrelated unrelated 2>err &&
+	test_grep "shallow boundary commit" err &&
+	echo dirty >expect &&
+	test_cmp expect shallow-repo/C.t &&
+	git -C shallow-repo stash list >stashes &&
+	test_must_be_empty stashes &&
+	git -C shallow-repo checkout -q -- C.t
+'
+
+test_expect_success 'rebase --apply that does not replay the boundary is unaffected' '
+	git -C shallow-repo checkout -q -B apply-topic C &&
+	test_commit -C shallow-repo E &&
+	git -C shallow-repo rebase --apply --onto unrelated C &&
+	test_path_is_file shallow-repo/E.t
+'
+
+test_expect_success 'rebase that does not replay the boundary is unaffected' '
+	git -C shallow-repo checkout -q -B topic C &&
+	test_commit -C shallow-repo D &&
+	git -C shallow-repo rebase C
+'
+
+test_expect_success 'rebase restores an autostash when refusing (merge backend)' '
+	git -C shallow-repo checkout -q --detach C &&
+	echo dirty >shallow-repo/C.t &&
+	test_must_fail git -C shallow-repo rebase --autostash --root 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_missing shallow-repo/.git/rebase-merge &&
+	echo dirty >expect &&
+	test_cmp expect shallow-repo/C.t &&
+	git -C shallow-repo stash list >stashes &&
+	test_must_be_empty stashes &&
+	git -C shallow-repo checkout -q -- C.t
+'
+
+test_expect_success 'interactive rebase restores an autostash when refusing' '
+	echo dirty >shallow-repo/C.t &&
+	test_must_fail env GIT_SEQUENCE_EDITOR=: \
+		git -C shallow-repo rebase -i --autostash --root 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_missing shallow-repo/.git/rebase-merge &&
+	echo dirty >expect &&
+	test_cmp expect shallow-repo/C.t &&
+	git -C shallow-repo stash list >stashes &&
+	test_must_be_empty stashes &&
+	git -C shallow-repo checkout -q -- C.t
+'
+
+test_expect_success 'rebase onto new upstream work in a shallow clone still works' '
+	git clone --no-local --depth=1 "file://$(pwd)/shallow-src" shallow-local &&
+	test_commit -C shallow-local local &&
+	test_commit -C shallow-src upstream &&
+	git -C shallow-local fetch origin &&
+	git -C shallow-local rebase origin/HEAD &&
+	test_path_is_file shallow-local/upstream.t &&
+	test_path_is_file shallow-local/local.t
+'
+
+test_expect_success 'single-commit shallow clone: revert and cherry-pick are refused' '
+	git init one-src &&
+	test_commit -C one-src only &&
+	git clone --no-local --depth=1 "file://$(pwd)/one-src" one-shallow &&
+	git -C one-shallow rev-parse HEAD >expect &&
+	test_must_fail git -C one-shallow revert --no-edit HEAD 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_must_fail git -C one-shallow cherry-pick -n HEAD 2>err &&
+	test_grep "shallow boundary commit" err &&
+	test_path_is_file one-shallow/only.t &&
+	git -C one-shallow rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'revert and cherry-pick work once the clone is unshallowed' '
+	git clone --no-local --depth=2 "file://$(pwd)/shallow-src" unshallowed &&
+	test_must_fail git -C unshallowed revert --no-edit HEAD~1 2>err &&
+	test_grep "shallow boundary commit" err &&
+	git -C unshallowed fetch --unshallow &&
+	git -C unshallowed revert --no-edit C &&
+	test_path_is_missing unshallowed/C.t &&
+	git -C unshallowed cherry-pick C &&
+	test_path_is_file unshallowed/C.t
+'
+
+test_expect_success '--allow-shallow-boundary cannot be combined with --abort' '
+	test_must_fail git -C shallow-repo revert --abort \
+		--allow-shallow-boundary 2>err &&
+	test_grep "cannot be used with" err
+'
+
 test_done

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
gitgitgadget

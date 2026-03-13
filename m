Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45649377021
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393824; cv=none; b=RzzHwtPhpwHHxsLmmWHJBIVW6xmAWk66KmmYnu/oDuOWNaZfJB1Boh9ftyLECYudccR187gy2S8a/6nAvj5uzidfht9fO2r8QGLY1tBalhVWymkXETsV0W3OKmq62Tcank1UzbIWJ9K+rtxt18yXPOSKyYhBtkhfyYld9dDqzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393824; c=relaxed/simple;
	bh=VNWncJFblkOExtnlhGpLmiifjgtTefW1bH/Li/MOoak=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iOZfDbz62LqJmlHr7rpkXJUkpsrT1Jvd8EtMN4aYTW98FB4iF8qFcmAVw8jL6O70gj95i/1LxYukbsRTI5KSSch20kLzEISsvpuADgBDTRTh3Xp5W34MPNipA2JjpemBCgBkFULwPG5wESuekdlMwxyjP4oFJRHPcTL66pxeVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhPqxPsh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhPqxPsh"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a00e8dc04so19221326d6.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773393820; x=1773998620; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQoJJNaEc/AFMhb+4ahCfsAtpFDAD7uhKmGy5Gskfk8=;
        b=XhPqxPshbx10QhPIZcY/iCvA4RdEAIodh5Jfg0k2/kt5sxO76O9MCdkeoNzkcr1R28
         lvY1vcOk1S/OUC0EfP9qm6mujnL64abqGG3e8mhZmKqodwQz/8xqYfwIDm9uWD1+jJvo
         x6R9+JjsYkDGDn8TTJKQthCUF2JTRQlHGTRPycJVslkAXe2TLJ8kmYas5lUzamhK4Tjg
         +DuzH/kcK9fJEg014nc8hU3Rgu8uR8Wbb753v8WbmyexCIyI/azhU3Uyy73nnyWhpM0M
         Tt1O+s9VpQ1V8lPeb/KhB/bGAjR8O5amZBZKe5RjOttlHTrhkHtrHmmuBlQ+NA1z0PR/
         PdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393820; x=1773998620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQoJJNaEc/AFMhb+4ahCfsAtpFDAD7uhKmGy5Gskfk8=;
        b=j15nEKN/6/A5OfdmTP3YT/Yv4eX+zk61jzycCn5dMAkFDJtjHjkw0D9p2AUAIEUCxR
         gpuzJJjLdgndme3gOwA9wffCtmRljrI/gMdbuUz+EqS+VrAJknbP2xf1j7XQicXi3NjW
         d+Dlhsxixk5rSf+bO/zGTIxVapXIzKhalTd92XRVa9RmrxXbPFJMFlwv+BV+xqMIvuRO
         5XwLWLdlUrQIoz/V431eHEDawjBDvkEA0mzb5R63apfrLjMdQC2HBb/OFYT/zjmvwqq3
         4YGLHyVbHo9C3XIfBdHNgaDVpcvr79wwEeP+ZP44dSIYO/zxjQJWqt0jJAX/HpSPx+FE
         0KUw==
X-Gm-Message-State: AOJu0YyeZbai+nHkph+FeX7pGuslIME2vNNfRtmwc8yEqauUO7PCRxWX
	cNbfhh12LUOhxNkmcoLHslyjePO9qEo+Q3Opy0i7NhM0tHQPTfuuY/BcFNZDCw==
X-Gm-Gg: ATEYQzyiS1ykbDgek1AtD2HJPj60UR8JdOqI+9jNco5R2j47F7lDNk3WUNmWhddQyaM
	qHjv3o/FX6OrZrclzyYYQvEsFMynP2mHazmdX3om7FvHDTT0BfTYzPF4BunVwRWIvhIX2QjFNhU
	rnkLktzHJ7CAqaSuIWVZEpH8g9C7R0p4G20gqPi+wBCZrwBTgzCd1R4Y+QdA36gnTnBcDKHRL4E
	Eobfppwioxq2a94XNoymkoFWF8jGVo4PCr2HJr/OFvlXIREoRcz604PtlHuYv+PuXi9dThj5HSW
	57dO4BnJo3S4IIWS/GIoYk9j8AEIQEZfAI4aCLmGc5buA6XNnMZ9M6OdRHyW7frUm58TP6tAexB
	esaiNHyCtt4IlAi2Fnqfwz8CgUHVwjXT0vtUkxYnFQDyJ1WiOFIQcRh7huwI+o1I9QBTPU7ncXa
	mu6CltZIQLW8NQL2qEF3RFUmn6vQ==
X-Received: by 2002:a05:6214:c47:b0:899:f5d3:321c with SMTP id 6a1803df08f44-89a81d321a1mr37439316d6.10.1773393819599;
        Fri, 13 Mar 2026 02:23:39 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a6947c4b8sm48661886d6.20.2026.03.13.02.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 02:23:39 -0700 (PDT)
Message-Id: <pull.2234.v3.git.git.1773393818235.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v2.git.git.1773344022931.gitgitgadget@gmail.com>
References: <pull.2234.v2.git.git.1773344022931.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Mar 2026 09:23:38 +0000
Subject: [PATCH v3] checkout: add --autostash option for branch switching
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v3
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v2:

 1:  be2b697c54 ! 1:  05f1e53163 checkout: add --autostash option for branch switching
     @@ Commit message
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## Documentation/config/checkout.adoc ##
     -@@ Documentation/config/checkout.adoc: with a small number of cores, the default sequential checkout often performs
     - better. The size and compression level of a repository might also influence how
     - well the parallel version performs.
     - 
     -+`checkout.autoStash`::
     -+	When set to true, enable autostash for `git checkout` and
     -+	`git switch` branch switching operations.  When a branch
     -+	switch would fail because local changes (in the index or the
     -+	working tree) overlap with paths that differ between the
     -+	current and target branch, a temporary stash entry is
     -+	automatically created before the switch and applied after
     -+	it completes.  If the local changes do not overlap with the
     -+	branch difference, the switch proceeds normally without
     -+	stashing.
     -+	This option can be overridden by the `--no-autostash` and
     -+	`--autostash` options of linkgit:git-checkout[1] and
     -+	linkgit:git-switch[1].
     -+	Defaults to false.
     -+
     - `checkout.thresholdForParallelism`::
     - 	When running parallel checkout with a small number of files, the cost
     - 	of subprocess spawning and inter-process communication might outweigh
     -
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: When switching branches with `--merge`, staged changes may be lost.
     - 	`merge.conflictStyle` configuration variable.  Possible values are
     - 	`merge` (default), `diff3`, and `zdiff3`.
     +@@ Documentation/git-checkout.adoc: working tree, by copying them from elsewhere, extracting a tarball, etc.
     + 	are different between the current branch and the branch to
     + 	which you are switching, the command refuses to switch
     + 	branches in order to preserve your modifications in context.
     +-	However, with this option, a three-way merge between the current
     +-	branch, your working tree contents, and the new branch
     +-	is done, and you will be on the new branch.
     +-+
     +-When a merge conflict happens, the index entries for conflicting
     +-paths are left unmerged, and you need to resolve the conflicts
     +-and mark the resolved paths with `git add` (or `git rm` if the merge
     +-should result in deletion of the path).
     ++	With this option, the conflicting local changes are
     ++	automatically stashed before the switch and reapplied
     ++	afterwards.  If the local changes do not overlap with the
     ++	differences between branches, the switch proceeds without
     ++	stashing.  If reapplying the stash results in conflicts, the
     ++	entry is saved to the stash list so you can use `git stash
     ++	pop` to recover and `git stash drop` when done.
     + +
     + When checking out paths from the index, this option lets you recreate
     + the conflicted merge in the specified paths.  This option cannot be
     + used when checking out paths from a tree-ish.
     +-+
     +-When switching branches with `--merge`, staged changes may be lost.
     + 
     + `--conflict=<style>`::
     + 	The same as `--merge` option above, but changes the way the
     +@@ Documentation/git-checkout.adoc: $ git checkout mytopic
     + error: You have local changes to 'frotz'; not switching branches.
     + ------------
     + 
     +-You can give the `-m` flag to the command, which would try a
     +-three-way merge:
     ++You can give the `-m` flag to the command, which would save the local
     ++changes in a stash entry and reset the working tree to allow switching:
     + 
     + ------------
     + $ git checkout -m mytopic
     +-Auto-merging frotz
     ++Created autostash: 7a9afa3
     ++Applied autostash.
     + ------------
     + 
     +-After this three-way merge, the local modifications are _not_
     ++After the switch, the local modifications are reapplied and are _not_
     + registered in your index file, so `git diff` would show you what
     + changes you made since the tip of the new branch.
     + 
     + === 3. Merge conflict
     + 
     +-When a merge conflict happens during switching branches with
     +-the `-m` option, you would see something like this:
     ++When the locally modified files overlap with files that need to be
     ++updated by the branch switch, the changes are stashed and reapplied
     ++after the switch.  If the stash application results in conflicts,
     ++they are not resolved and the stash is saved to the stash list:
     + 
     + ------------
     + $ git checkout -m mytopic
     +-Auto-merging frotz
     +-ERROR: Merge conflict in frotz
     +-fatal: merge program failed
     ++Created autostash: 7a9afa3
     ++Applying autostash resulted in conflicts.
     ++Your changes are safe in the stash.
     ++You can run "git stash pop" or "git stash drop" at any time.
     + ------------
       
     -+`--autostash`::
     -+`--no-autostash`::
     -+	When switching branches, if any of the paths that differ
     -+	between the current branch and the target branch have local
     -+	changes (in the index or the working tree), automatically
     -+	create a temporary stash entry before the operation begins,
     -+	and apply it after the operation ends.  If the local changes
     -+	do not overlap with the branch difference, the switch proceeds
     -+	without stashing.  When a stash entry is created and the
     -+	subsequent application results in conflicts, the stash entry
     -+	is saved so that you can use `git stash pop` to recover and
     -+	`git stash drop` when done.  Use with `--force` to always
     -+	stash local changes regardless of conflicts.
     -+
     - `-p`::
     - `--patch`::
     - 	Interactively select hunks in the difference between the
     +-At this point, `git diff` shows the changes cleanly merged as in
     +-the previous example, as well as the changes in the conflicted
     +-files.  Edit and resolve the conflict and mark it resolved with
     +-`git add` as usual:
     +-
     +-------------
     +-$ edit frotz
     +-$ git add frotz
     +-------------
     ++At this point, `git stash pop` can be used to recover and resolve
     ++the conflicts, and `git stash drop` to discard the stash when done.
     + 
     + CONFIGURATION
     + -------------
      
       ## Documentation/git-switch.adoc ##
     -@@ Documentation/git-switch.adoc: should result in deletion of the path).
     - 	`merge.conflictStyle` configuration variable.  Possible values are
     - 	`merge` (default), `diff3`, and `zdiff3`.
     +@@ Documentation/git-switch.adoc: variable.
     + 	If you have local modifications to one or more files that are
     + 	different between the current branch and the branch to which
     + 	you are switching, the command refuses to switch branches in
     +-	order to preserve your modifications in context.  However,
     +-	with this option, a three-way merge between the current
     +-	branch, your working tree contents, and the new branch is
     +-	done, and you will be on the new branch.
     +-+
     +-When a merge conflict happens, the index entries for conflicting
     +-paths are left unmerged, and you need to resolve the conflicts
     +-and mark the resolved paths with `git add` (or `git rm` if the merge
     +-should result in deletion of the path).
     ++	order to preserve your modifications in context.  With this
     ++	option, the conflicting local changes are automatically
     ++	stashed before the switch and reapplied afterwards.  If the
     ++	local changes do not overlap with the differences between
     ++	branches, the switch proceeds without stashing.  If
     ++	reapplying the stash results in conflicts, the entry is
     ++	saved to the stash list so you can use `git stash pop` to
     ++	recover and `git stash drop` when done.
     + 
     + `--conflict=<style>`::
     + 	The same as `--merge` option above, but changes the way the
     +@@ Documentation/git-switch.adoc: $ git switch mytopic
     + error: You have local changes to 'frotz'; not switching branches.
     + ------------
     + 
     +-You can give the `-m` flag to the command, which would try a three-way
     +-merge:
     ++You can give the `-m` flag to the command, which would save the local
     ++changes in a stash entry and reset the working tree to allow switching:
     + 
     + ------------
     + $ git switch -m mytopic
     +-Auto-merging frotz
     ++Created autostash: 7a9afa3
     ++Applied autostash.
     + ------------
     + 
     +-After this three-way merge, the local modifications are _not_
     ++After the switch, the local modifications are reapplied and are _not_
     + registered in your index file, so `git diff` would show you what
     + changes you made since the tip of the new branch.
       
     -+`--autostash`::
     -+`--no-autostash`::
     -+	When switching branches, if any of the paths that differ
     -+	between the current branch and the target branch have local
     -+	changes (in the index or the working tree), automatically
     -+	create a temporary stash entry before the operation begins,
     -+	and apply it after the operation ends.  If the local changes
     -+	do not overlap with the branch difference, the switch proceeds
     -+	without stashing.  When a stash entry is created and the
     -+	subsequent application results in conflicts, the stash entry
     -+	is saved so that you can use `git stash pop` to recover and
     -+	`git stash drop` when done.  Use with `--force` to always
     -+	stash local changes regardless of conflicts.
     -+
     - `-q`::
     - `--quiet`::
     - 	Quiet, suppress feedback messages.
      
       ## builtin/checkout.c ##
     +@@
     + #include "merge-ll.h"
     + #include "lockfile.h"
     + #include "mem-pool.h"
     +-#include "merge-ort-wrappers.h"
     + #include "object-file.h"
     + #include "object-name.h"
     + #include "odb.h"
      @@
       #include "repo-settings.h"
       #include "resolve-undo.h"
     @@ builtin/checkout.c
       #include "setup.h"
       #include "submodule.h"
       #include "symlinks.h"
     -@@ builtin/checkout.c: struct checkout_opts {
     - 	int only_merge_on_switching_branches;
     - 	int can_switch_when_in_progress;
     - 	int orphan_from_empty_tree;
     -+	int autostash;
     - 	int empty_pathspec_ok;
     - 	int checkout_index;
     - 	int checkout_worktree;
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 
     + 		ret = unpack_trees(2, trees, &topts);
     + 		clear_unpack_trees_porcelain(&topts);
     +-		if (ret == -1) {
     +-			/*
     +-			 * Unpack couldn't do a trivial merge; either
     +-			 * give up or do a real merge, depending on
     +-			 * whether the merge flag was used.
     +-			 */
     +-			struct tree *work;
     +-			struct tree *old_tree;
     +-			struct merge_options o;
     +-			struct strbuf sb = STRBUF_INIT;
     +-			struct strbuf old_commit_shortname = STRBUF_INIT;
     +-
     +-			if (!opts->merge)
     +-				return 1;
     +-
     +-			/*
     +-			 * Without old_branch_info->commit, the below is the same as
     +-			 * the two-tree unpack we already tried and failed.
     +-			 */
     +-			if (!old_branch_info->commit)
     +-				return 1;
     +-			old_tree = repo_get_commit_tree(the_repository,
     +-							old_branch_info->commit);
     +-
     +-			if (repo_index_has_changes(the_repository, old_tree, &sb))
     +-				die(_("cannot continue with staged changes in "
     +-				      "the following files:\n%s"), sb.buf);
     +-			strbuf_release(&sb);
     +-
     +-			/* Do more real merge */
     +-
     +-			/*
     +-			 * We update the index fully, then write the
     +-			 * tree from the index, then merge the new
     +-			 * branch with the current tree, with the old
     +-			 * branch as the base. Then we reset the index
     +-			 * (but not the working tree) to the new
     +-			 * branch, leaving the working tree as the
     +-			 * merged version, but skipping unmerged
     +-			 * entries in the index.
     +-			 */
     +-
     +-			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
     +-					0, 0);
     +-			init_ui_merge_options(&o, the_repository);
     +-			o.verbosity = 0;
     +-			work = write_in_core_index_as_tree(the_repository);
     +-
     +-			ret = reset_tree(new_tree,
     +-					 opts, 1,
     +-					 writeout_error, new_branch_info);
     +-			if (ret)
     +-				return ret;
     +-			o.ancestor = old_branch_info->name;
     +-			if (!old_branch_info->name) {
     +-				strbuf_add_unique_abbrev(&old_commit_shortname,
     +-							 &old_branch_info->commit->object.oid,
     +-							 DEFAULT_ABBREV);
     +-				o.ancestor = old_commit_shortname.buf;
     +-			}
     +-			o.branch1 = new_branch_info->name;
     +-			o.branch2 = "local";
     +-			o.conflict_style = opts->conflict_style;
     +-			ret = merge_ort_nonrecursive(&o,
     +-						     new_tree,
     +-						     work,
     +-						     old_tree);
     +-			if (ret < 0)
     +-				die(NULL);
     +-			ret = reset_tree(new_tree,
     +-					 opts, 0,
     +-					 writeout_error, new_branch_info);
     +-			strbuf_release(&o.obuf);
     +-			strbuf_release(&old_commit_shortname);
     +-			if (ret)
     +-				return ret;
     +-		}
     ++		if (ret == -1)
     ++			return 1;
     + 	}
     + 
     + 	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
     + 		die(_("unable to write new index file"));
     + 
     +-	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
     +-		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
     +-
     + 	return 0;
     + }
     + 
      @@ builtin/checkout.c: static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
       	release_revisions(&revs);
       }
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       			do_merge = 0;
       	}
       
     -+	if (opts->autostash) {
     ++	if (opts->merge) {
      +		if (repo_read_index(the_repository) < 0)
      +			die(_("index file corrupt"));
     -+		if (opts->discard_changes ||
     -+		    checkout_would_clobber_changes(&old_branch_info,
     ++		if (checkout_would_clobber_changes(&old_branch_info,
      +						   new_branch_info))
      +			create_autostash_ref(the_repository,
      +					     "CHECKOUT_AUTOSTASH");
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       
       	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
       
     ++	if (opts->conflict_style >= 0) {
     ++		struct strbuf cfg = STRBUF_INIT;
     ++		strbuf_addf(&cfg, "merge.conflictStyle=%s",
     ++			    conflict_style_name(opts->conflict_style));
     ++		git_config_push_parameter(cfg.buf);
     ++		strbuf_release(&cfg);
     ++	}
      +	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
     ++
     ++	discard_index(the_repository->index);
     ++	if (repo_read_index(the_repository) < 0)
     ++		die(_("index file corrupt"));
     ++
     ++	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
     ++		show_local_changes(&new_branch_info->commit->object,
     ++				   &opts->diff_options);
      +
       	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
       	branch_info_release(&old_branch_info);
       
     -@@ builtin/checkout.c: static int git_checkout_config(const char *var, const char *value,
     - 		opts->dwim_new_local_branch = git_config_bool(var, value);
     - 		return 0;
     - 	}
     -+	if (!strcmp(var, "checkout.autostash")) {
     -+		opts->autostash = git_config_bool(var, value);
     -+		return 0;
     -+	}
     - 
     - 	if (starts_with(var, "submodule."))
     - 		return git_default_submodule_config(var, value, NULL);
     -@@ builtin/checkout.c: static struct option *add_common_switch_branch_options(
     - 			   PARSE_OPT_NOCOMPLETE),
     - 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
     - 			 N_("do not check if another worktree is using this branch")),
     -+		OPT_AUTOSTASH(&opts->autostash),
     - 		OPT_END()
     - 	};
     - 	struct option *newopts = parse_options_concat(prevopts, options);
      
     - ## t/meson.build ##
     -@@ t/meson.build: integration_tests = [
     -   't2030-unresolve-info.sh',
     -   't2050-git-dir-relative.sh',
     -   't2060-switch.sh',
     -+  't2061-switch-autostash.sh',
     -   't2070-restore.sh',
     -   't2071-restore-patch.sh',
     -   't2072-restore-pathspec-file.sh',
     + ## sequencer.c ##
     +@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     + 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
     + 		}
     + 
     +-		printf(_("Created autostash: %s\n"), buf.buf);
     ++		fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
     + 		if (reset_head(r, &ropts) < 0)
     + 			die(_("could not reset --hard"));
     + 		discard_index(r->index);
      
     - ## t/t2061-switch-autostash.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='checkout/switch --autostash tests'
     -+
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
     -+. ./test-lib.sh
     -+
     -+test_expect_success 'setup' '
     -+	echo file0content >file0 &&
     -+	echo file1content >file1 &&
     -+	git add . &&
     -+	test_tick &&
     -+	git commit -m "initial commit" &&
     -+	git branch other-branch &&
     -+	echo file1main >file1 &&
     -+	git add . &&
     -+	test_tick &&
     -+	git commit -m "modify file1 on main" &&
     -+	git checkout other-branch &&
     -+	echo file1other >file1 &&
     -+	git add . &&
     -+	test_tick &&
     -+	git commit -m "modify file1 on other-branch" &&
     -+	echo file2content >file2 &&
     -+	git add . &&
     -+	test_tick &&
     -+	git commit -m "add file2 on other-branch" &&
     -+	git checkout main
     + ## t/t7201-co.sh ##
     +@@ t/t7201-co.sh: test_expect_success 'format of merge conflict from checkout -m' '
     + 	test_cmp expect current &&
     + 
     + 	cat <<-EOF >expect &&
     +-	<<<<<<< simple
     ++	<<<<<<< Updated upstream
     + 	a
     + 	c
     + 	e
     + 	=======
     + 	b
     + 	d
     +-	>>>>>>> local
     ++	>>>>>>> Stashed changes
     + 	EOF
     + 	test_cmp expect two
     + '
     +@@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
     + 	git checkout --merge --conflict=diff3 simple &&
     + 
     + 	cat <<-EOF >expect &&
     +-	<<<<<<< simple
     ++	<<<<<<< Updated upstream
     + 	a
     + 	c
     + 	e
     +-	||||||| main
     ++	||||||| Stash base
     + 	a
     + 	b
     + 	c
     +@@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
     + 	=======
     + 	b
     + 	d
     +-	>>>>>>> local
     ++	>>>>>>> Stashed changes
     + 	EOF
     + 	test_cmp expect two
     + '
     + 
     ++test_expect_success 'checkout --merge --conflict=zdiff3 <branch>' '
     ++	git checkout -f main &&
     ++	git reset --hard &&
     ++	git clean -f &&
     ++
     ++	fill a b X d e >two &&
     ++	git checkout --merge --conflict=zdiff3 simple &&
     ++
     ++	cat <<-EOF >expect &&
     ++	a
     ++	<<<<<<< Updated upstream
     ++	c
     ++	||||||| Stash base
     ++	b
     ++	c
     ++	d
     ++	=======
     ++	b
     ++	X
     ++	d
     ++	>>>>>>> Stashed changes
     ++	e
     ++	EOF
     ++	test_cmp expect two
      +'
      +
     -+test_expect_success 'switch --autostash skips stash when no conflict' '
     -+	git branch branch1 other-branch &&
     -+	echo dirty >file0 &&
     -+	git switch --autostash branch1 >actual 2>&1 &&
     -+	test_grep ! "Created autostash" actual &&
     -+	echo dirty >expected &&
     -+	test_cmp expected file0 &&
     -+	git switch main
     ++test_expect_success 'checkout -m respects merge.conflictStyle config' '
     ++	git checkout -f main &&
     ++	git reset --hard &&
     ++	git clean -f &&
     ++
     ++	test_config merge.conflictStyle diff3 &&
     ++	fill b d >two &&
     ++	git checkout -m simple &&
     ++
     ++	cat <<-EOF >expect &&
     ++	<<<<<<< Updated upstream
     ++	a
     ++	c
     ++	e
     ++	||||||| Stash base
     ++	a
     ++	b
     ++	c
     ++	d
     ++	e
     ++	=======
     ++	b
     ++	d
     ++	>>>>>>> Stashed changes
     ++	EOF
     ++	test_cmp expect two
      +'
      +
     -+test_expect_success 'checkout --autostash skips stash when no conflict' '
     -+	git branch branch2 other-branch &&
     -+	echo dirty >file0 &&
     -+	git checkout --autostash branch2 >actual 2>&1 &&
     -+	test_grep ! "Created autostash" actual &&
     -+	echo dirty >expected &&
     -+	test_cmp expected file0 &&
     -+	git checkout main
     -+'
     ++test_expect_success 'checkout -m skips stash when no conflict' '
     ++	git checkout -f main &&
     ++	git clean -f &&
      +
     -+test_expect_success 'switch: checkout.autostash config skips stash when no conflict' '
     -+	git branch branch3 other-branch &&
     -+	echo dirty >file0 &&
     -+	test_config checkout.autostash true &&
     -+	git switch branch3 >actual 2>&1 &&
     ++	fill 0 x y z >same &&
     ++	git checkout -m side >actual 2>&1 &&
      +	test_grep ! "Created autostash" actual &&
     -+	echo dirty >expected &&
     -+	test_cmp expected file0 &&
     -+	git switch main
     ++	fill 0 x y z >expect &&
     ++	test_cmp expect same
      +'
      +
     -+test_expect_success 'checkout: checkout.autostash config skips stash when no conflict' '
     -+	git branch branch4 other-branch &&
     -+	echo dirty >file0 &&
     -+	test_config checkout.autostash true &&
     -+	git checkout branch4 >actual 2>&1 &&
     ++test_expect_success 'checkout -m skips stash with non-conflicting dirty index' '
     ++	git checkout -f main &&
     ++	git clean -f &&
     ++
     ++	fill 0 x y z >same &&
     ++	git add same &&
     ++	git checkout -m side >actual 2>&1 &&
      +	test_grep ! "Created autostash" actual &&
     -+	echo dirty >expected &&
     -+	test_cmp expected file0 &&
     -+	git checkout main
     ++	fill 0 x y z >expect &&
     ++	test_cmp expect same
      +'
      +
     -+test_expect_success '--no-autostash overrides checkout.autostash' '
     -+	git branch branch5 other-branch &&
     -+	echo dirty >file1 &&
     -+	test_config checkout.autostash true &&
     -+	test_must_fail git switch --no-autostash branch5 2>stderr &&
     -+	test_grep ! "Created autostash" stderr &&
     -+	git checkout -- file1
     -+'
     ++test_expect_success 'checkout -m stashes and applies on conflicting changes' '
     ++	git checkout -f main &&
     ++	git clean -f &&
      +
     -+test_expect_success '--autostash overrides checkout.autostash=false' '
     -+	git branch branch6 other-branch &&
     -+	echo dirty >file0 &&
     -+	test_config checkout.autostash false &&
     -+	git switch --autostash branch6 >actual 2>&1 &&
     -+	test_grep ! "Created autostash" actual &&
     -+	echo dirty >expected &&
     -+	test_cmp expected file0 &&
     -+	git switch main
     ++	fill 1 2 3 4 5 6 7 >one &&
     ++	git checkout -m side >actual 2>&1 &&
     ++	test_grep "Created autostash" actual &&
     ++	test_grep "Applied autostash" actual &&
     ++	fill 1 2 3 4 5 6 7 >expect &&
     ++	test_cmp expect one
      +'
      +
     -+test_expect_success 'autostash with non-conflicting dirty index' '
     -+	git branch branch7 other-branch &&
     -+	echo dirty-index >file0 &&
     -+	git add file0 &&
     -+	git switch --autostash branch7 >actual 2>&1 &&
     -+	test_grep ! "Created autostash" actual &&
     -+	echo dirty-index >expected &&
     -+	test_cmp expected file0 &&
     -+	git checkout -- file0 &&
     -+	git switch main
     ++test_expect_success 'checkout -m with mixed staged and unstaged changes' '
     ++	git checkout -f main &&
     ++	git clean -f &&
     ++
     ++	fill 0 x y z >same &&
     ++	git add same &&
     ++	fill 1 2 3 4 5 6 7 >one &&
     ++	git checkout -m side >actual 2>&1 &&
     ++	test_grep "Created autostash" actual &&
     ++	test_grep "Applied autostash" actual &&
     ++	fill 0 x y z >expect &&
     ++	test_cmp expect same &&
     ++	fill 1 2 3 4 5 6 7 >expect &&
     ++	test_cmp expect one
      +'
      +
     -+test_expect_success 'autostash bypasses conflicting local changes' '
     -+	git branch branch8 other-branch &&
     -+	echo dirty >file1 &&
     -+	test_must_fail git switch branch8 2>stderr &&
     ++test_expect_success 'checkout -m stashes on truly conflicting changes' '
     ++	git checkout -f main &&
     ++	git clean -f &&
     ++
     ++	fill 1 2 3 4 5 >one &&
     ++	test_must_fail git checkout side 2>stderr &&
      +	test_grep "Your local changes" stderr &&
     -+	git switch --autostash branch8 >actual 2>&1 &&
     ++	git checkout -m side >actual 2>&1 &&
      +	test_grep "Created autostash" actual &&
      +	test_grep "Applying autostash resulted in conflicts" actual &&
      +	test_grep "Your changes are safe in the stash" actual &&
      +	git stash drop &&
     -+	git reset --hard &&
     -+	git switch main
     ++	git reset --hard
      +'
      +
     -+test_expect_success 'autostash is a no-op with clean worktree' '
     -+	git branch branch9 other-branch &&
     -+	git switch --autostash branch9 >actual 2>&1 &&
     -+	test_grep ! "Created autostash" actual &&
     -+	git switch main
     -+'
     -+
     -+test_expect_success '--autostash with --merge skips stash when no conflict' '
     -+	git branch branch10 other-branch &&
     -+	echo dirty >file0 &&
     -+	git switch --autostash --merge branch10 >actual 2>&1 &&
     -+	test_grep ! "Created autostash" actual &&
     -+	echo dirty >expected &&
     -+	test_cmp expected file0 &&
     -+	git switch main
     -+'
     ++test_expect_success 'checkout -m produces usable stash on conflict' '
     ++	git checkout -f main &&
     ++	git clean -f &&
      +
     -+test_expect_success 'autostash with staged conflicting changes' '
     -+	git branch branch11 other-branch &&
     -+	echo staged-change >file1 &&
     -+	git add file1 &&
     -+	git switch --autostash branch11 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applying autostash resulted in conflicts" actual &&
     ++	fill 1 2 3 4 5 >one &&
     ++	git checkout -m side >actual 2>&1 &&
      +	test_grep "Your changes are safe in the stash" actual &&
     -+	git stash drop &&
     -+	git reset --hard &&
     -+	git switch main
     ++	git checkout -f main &&
     ++	git stash pop &&
     ++	fill 1 2 3 4 5 >expect &&
     ++	test_cmp expect one
      +'
      +
     -+test_expect_success '--autostash with --force preserves dirty changes' '
     -+	git branch branch12 other-branch &&
     -+	echo dirty-force >file1 &&
     -+	git switch --autostash --force branch12 >actual 2>&1 &&
     ++test_expect_success 'checkout -m stashes on staged conflicting changes' '
     ++	git checkout -f main &&
     ++	git clean -f &&
     ++
     ++	fill 1 2 3 4 5 >one &&
     ++	git add one &&
     ++	git checkout -m side >actual 2>&1 &&
      +	test_grep "Created autostash" actual &&
      +	test_grep "Applying autostash resulted in conflicts" actual &&
      +	test_grep "Your changes are safe in the stash" actual &&
      +	git stash drop &&
     -+	git reset --hard &&
     -+	git switch main
     ++	git reset --hard
      +'
      +
     -+test_expect_success '--autostash with new branch creation skips stash' '
     -+	echo dirty >file0 &&
     -+	git switch --autostash -c branch13 >actual 2>&1 &&
     ++test_expect_success 'checkout -m -b skips stash with dirty tree' '
     ++	git checkout -f main &&
     ++	git clean -f &&
     ++
     ++	fill 0 x y z >same &&
     ++	git checkout -m -b newbranch >actual 2>&1 &&
      +	test_grep ! "Created autostash" actual &&
     -+	echo dirty >expected &&
     -+	test_cmp expected file0 &&
     -+	git switch main &&
     -+	git branch -D branch13
     ++	fill 0 x y z >expect &&
     ++	test_cmp expect same &&
     ++	git checkout main &&
     ++	git branch -D newbranch
      +'
      +
     -+test_expect_success 'autostash with conflicting changes that apply cleanly' '
     -+	git branch branch14 other-branch &&
     -+	echo file1other >file1 &&
     -+	git switch --autostash branch14 >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applied autostash" actual &&
     -+	echo file1other >expected &&
     -+	test_cmp expected file1 &&
     -+	git switch main
     -+'
     + test_expect_success 'switch to another branch while carrying a deletion' '
     + 	git checkout -f main &&
     + 	git reset --hard &&
     +
     + ## xdiff-interface.c ##
     +@@ xdiff-interface.c: int parse_conflict_style_name(const char *value)
     + 		return -1;
     + }
     + 
     ++const char *conflict_style_name(int style)
     ++{
     ++	switch (style) {
     ++	case XDL_MERGE_DIFF3:
     ++		return "diff3";
     ++	case XDL_MERGE_ZEALOUS_DIFF3:
     ++		return "zdiff3";
     ++	default:
     ++		return "merge";
     ++	}
     ++}
      +
     -+test_done
     + int git_xmerge_style = -1;
     + 
     + int git_xmerge_config(const char *var, const char *value,
      
     - ## t/t9902-completion.sh ##
     -@@ t/t9902-completion.sh: test_expect_success 'double dash "git checkout"' '
     - 	--ignore-other-worktrees Z
     - 	--recurse-submodules Z
     - 	--auto-advance Z
     -+	--autostash Z
     - 	--progress Z
     - 	--guess Z
     - 	--no-guess Z
     + ## xdiff-interface.h ##
     +@@ xdiff-interface.h: void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
     + void xdiff_clear_find_func(xdemitconf_t *xecfg);
     + struct config_context;
     + int parse_conflict_style_name(const char *value);
     ++const char *conflict_style_name(int style);
     + int git_xmerge_config(const char *var, const char *value,
     + 		      const struct config_context *ctx, void *cb);
     + extern int git_xmerge_style;


 Documentation/git-checkout.adoc |  50 +++++-----
 Documentation/git-switch.adoc   |  26 ++---
 builtin/checkout.c              | 160 +++++++++++++++---------------
 sequencer.c                     |   2 +-
 t/t7201-co.sh                   | 170 +++++++++++++++++++++++++++++++-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 7 files changed, 293 insertions(+), 128 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..1e8adf6ef3 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -251,20 +251,17 @@ working tree, by copying them from elsewhere, extracting a tarball, etc.
 	are different between the current branch and the branch to
 	which you are switching, the command refuses to switch
 	branches in order to preserve your modifications in context.
-	However, with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch
-	is done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
+	With this option, the conflicting local changes are
+	automatically stashed before the switch and reapplied
+	afterwards.  If the local changes do not overlap with the
+	differences between branches, the switch proceeds without
+	stashing.  If reapplying the stash results in conflicts, the
+	entry is saved to the stash list so you can use `git stash
+	pop` to recover and `git stash drop` when done.
 +
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.  This option cannot be
 used when checking out paths from a tree-ish.
-+
-When switching branches with `--merge`, staged changes may be lost.
 
 `--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
@@ -578,39 +575,36 @@ $ git checkout mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a
-three-way merge:
+You can give the `-m` flag to the command, which would save the local
+changes in a stash entry and reset the working tree to allow switching:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
+Created autostash: 7a9afa3
+Applied autostash.
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
 === 3. Merge conflict
 
-When a merge conflict happens during switching branches with
-the `-m` option, you would see something like this:
+When the locally modified files overlap with files that need to be
+updated by the branch switch, the changes are stashed and reapplied
+after the switch.  If the stash application results in conflicts,
+they are not resolved and the stash is saved to the stash list:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
-ERROR: Merge conflict in frotz
-fatal: merge program failed
+Created autostash: 7a9afa3
+Applying autostash resulted in conflicts.
+Your changes are safe in the stash.
+You can run "git stash pop" or "git stash drop" at any time.
 ------------
 
-At this point, `git diff` shows the changes cleanly merged as in
-the previous example, as well as the changes in the conflicted
-files.  Edit and resolve the conflict and mark it resolved with
-`git add` as usual:
-
-------------
-$ edit frotz
-$ git add frotz
-------------
+At this point, `git stash pop` can be used to recover and resolve
+the conflicts, and `git stash drop` to discard the stash when done.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..350e760fd2 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -126,15 +126,14 @@ variable.
 	If you have local modifications to one or more files that are
 	different between the current branch and the branch to which
 	you are switching, the command refuses to switch branches in
-	order to preserve your modifications in context.  However,
-	with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch is
-	done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
+	order to preserve your modifications in context.  With this
+	option, the conflicting local changes are automatically
+	stashed before the switch and reapplied afterwards.  If the
+	local changes do not overlap with the differences between
+	branches, the switch proceeds without stashing.  If
+	reapplying the stash results in conflicts, the entry is
+	saved to the stash list so you can use `git stash pop` to
+	recover and `git stash drop` when done.
 
 `--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
@@ -217,15 +216,16 @@ $ git switch mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a three-way
-merge:
+You can give the `-m` flag to the command, which would save the local
+changes in a stash entry and reset the working tree to allow switching:
 
 ------------
 $ git switch -m mytopic
-Auto-merging frotz
+Created autostash: 7a9afa3
+Applied autostash.
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1d1667fa4c..d3b3b815a7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -17,7 +17,6 @@
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
-#include "merge-ort-wrappers.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
@@ -30,6 +29,7 @@
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "sequencer.h"
 #include "setup.h"
 #include "submodule.h"
 #include "symlinks.h"
@@ -845,83 +845,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 		ret = unpack_trees(2, trees, &topts);
 		clear_unpack_trees_porcelain(&topts);
-		if (ret == -1) {
-			/*
-			 * Unpack couldn't do a trivial merge; either
-			 * give up or do a real merge, depending on
-			 * whether the merge flag was used.
-			 */
-			struct tree *work;
-			struct tree *old_tree;
-			struct merge_options o;
-			struct strbuf sb = STRBUF_INIT;
-			struct strbuf old_commit_shortname = STRBUF_INIT;
-
-			if (!opts->merge)
-				return 1;
-
-			/*
-			 * Without old_branch_info->commit, the below is the same as
-			 * the two-tree unpack we already tried and failed.
-			 */
-			if (!old_branch_info->commit)
-				return 1;
-			old_tree = repo_get_commit_tree(the_repository,
-							old_branch_info->commit);
-
-			if (repo_index_has_changes(the_repository, old_tree, &sb))
-				die(_("cannot continue with staged changes in "
-				      "the following files:\n%s"), sb.buf);
-			strbuf_release(&sb);
-
-			/* Do more real merge */
-
-			/*
-			 * We update the index fully, then write the
-			 * tree from the index, then merge the new
-			 * branch with the current tree, with the old
-			 * branch as the base. Then we reset the index
-			 * (but not the working tree) to the new
-			 * branch, leaving the working tree as the
-			 * merged version, but skipping unmerged
-			 * entries in the index.
-			 */
-
-			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					0, 0);
-			init_ui_merge_options(&o, the_repository);
-			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
-
-			ret = reset_tree(new_tree,
-					 opts, 1,
-					 writeout_error, new_branch_info);
-			if (ret)
-				return ret;
-			o.ancestor = old_branch_info->name;
-			if (!old_branch_info->name) {
-				strbuf_add_unique_abbrev(&old_commit_shortname,
-							 &old_branch_info->commit->object.oid,
-							 DEFAULT_ABBREV);
-				o.ancestor = old_commit_shortname.buf;
-			}
-			o.branch1 = new_branch_info->name;
-			o.branch2 = "local";
-			o.conflict_style = opts->conflict_style;
-			ret = merge_ort_nonrecursive(&o,
-						     new_tree,
-						     work,
-						     old_tree);
-			if (ret < 0)
-				die(NULL);
-			ret = reset_tree(new_tree,
-					 opts, 0,
-					 writeout_error, new_branch_info);
-			strbuf_release(&o.obuf);
-			strbuf_release(&old_commit_shortname);
-			if (ret)
-				return ret;
-		}
+		if (ret == -1)
+			return 1;
 	}
 
 	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
@@ -930,9 +855,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
-		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
-
 	return 0;
 }
 
@@ -1157,6 +1079,55 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	release_revisions(&revs);
 }
 
+static int checkout_would_clobber_changes(struct branch_info *old_branch_info,
+					  struct branch_info *new_branch_info)
+{
+	struct tree_desc trees[2];
+	struct tree *old_tree, *new_tree;
+	struct unpack_trees_options topts;
+	struct index_state tmp_index = INDEX_STATE_INIT(the_repository);
+	const struct object_id *old_commit_oid;
+	int ret;
+
+	if (!new_branch_info->commit)
+		return 0;
+
+	old_commit_oid = old_branch_info->commit ?
+		&old_branch_info->commit->object.oid :
+		the_hash_algo->empty_tree;
+	old_tree = repo_parse_tree_indirect(the_repository, old_commit_oid);
+	if (!old_tree)
+		return 0;
+
+	new_tree = repo_get_commit_tree(the_repository,
+					new_branch_info->commit);
+	if (!new_tree)
+		return 0;
+	if (repo_parse_tree(the_repository, new_tree) < 0)
+		return 0;
+
+	memset(&topts, 0, sizeof(topts));
+	topts.head_idx = -1;
+	topts.src_index = the_repository->index;
+	topts.dst_index = &tmp_index;
+	topts.initial_checkout = is_index_unborn(the_repository->index);
+	topts.merge = 1;
+	topts.update = 1;
+	topts.dry_run = 1;
+	topts.quiet = 1;
+	topts.fn = twoway_merge;
+
+	init_tree_desc(&trees[0], &old_tree->object.oid,
+		       old_tree->buffer, old_tree->size);
+	init_tree_desc(&trees[1], &new_tree->object.oid,
+		       new_tree->buffer, new_tree->size);
+
+	ret = unpack_trees(2, trees, &topts);
+	discard_index(&tmp_index);
+
+	return ret != 0;
+}
+
 static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
@@ -1202,9 +1173,19 @@ static int switch_branches(const struct checkout_opts *opts,
 			do_merge = 0;
 	}
 
+	if (opts->merge) {
+		if (repo_read_index(the_repository) < 0)
+			die(_("index file corrupt"));
+		if (checkout_would_clobber_changes(&old_branch_info,
+						   new_branch_info))
+			create_autostash_ref(the_repository,
+					     "CHECKOUT_AUTOSTASH");
+	}
+
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
+			apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
 			branch_info_release(&old_branch_info);
 			return ret;
 		}
@@ -1215,6 +1196,23 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	if (opts->conflict_style >= 0) {
+		struct strbuf cfg = STRBUF_INIT;
+		strbuf_addf(&cfg, "merge.conflictStyle=%s",
+			    conflict_style_name(opts->conflict_style));
+		git_config_push_parameter(cfg.buf);
+		strbuf_release(&cfg);
+	}
+	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
+
+	discard_index(the_repository->index);
+	if (repo_read_index(the_repository) < 0)
+		die(_("index file corrupt"));
+
+	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
+		show_local_changes(&new_branch_info->commit->object,
+				   &opts->diff_options);
+
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	branch_info_release(&old_branch_info);
 
diff --git a/sequencer.c b/sequencer.c
index aafd0bc959..72f0afe609 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4677,7 +4677,7 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..9ace3962ba 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -171,14 +171,14 @@ test_expect_success 'format of merge conflict from checkout -m' '
 	test_cmp expect current &&
 
 	cat <<-EOF >expect &&
-	<<<<<<< simple
+	<<<<<<< Updated upstream
 	a
 	c
 	e
 	=======
 	b
 	d
-	>>>>>>> local
+	>>>>>>> Stashed changes
 	EOF
 	test_cmp expect two
 '
@@ -192,11 +192,11 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	git checkout --merge --conflict=diff3 simple &&
 
 	cat <<-EOF >expect &&
-	<<<<<<< simple
+	<<<<<<< Updated upstream
 	a
 	c
 	e
-	||||||| main
+	||||||| Stash base
 	a
 	b
 	c
@@ -205,11 +205,171 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	=======
 	b
 	d
-	>>>>>>> local
+	>>>>>>> Stashed changes
 	EOF
 	test_cmp expect two
 '
 
+test_expect_success 'checkout --merge --conflict=zdiff3 <branch>' '
+	git checkout -f main &&
+	git reset --hard &&
+	git clean -f &&
+
+	fill a b X d e >two &&
+	git checkout --merge --conflict=zdiff3 simple &&
+
+	cat <<-EOF >expect &&
+	a
+	<<<<<<< Updated upstream
+	c
+	||||||| Stash base
+	b
+	c
+	d
+	=======
+	b
+	X
+	d
+	>>>>>>> Stashed changes
+	e
+	EOF
+	test_cmp expect two
+'
+
+test_expect_success 'checkout -m respects merge.conflictStyle config' '
+	git checkout -f main &&
+	git reset --hard &&
+	git clean -f &&
+
+	test_config merge.conflictStyle diff3 &&
+	fill b d >two &&
+	git checkout -m simple &&
+
+	cat <<-EOF >expect &&
+	<<<<<<< Updated upstream
+	a
+	c
+	e
+	||||||| Stash base
+	a
+	b
+	c
+	d
+	e
+	=======
+	b
+	d
+	>>>>>>> Stashed changes
+	EOF
+	test_cmp expect two
+'
+
+test_expect_success 'checkout -m skips stash when no conflict' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same
+'
+
+test_expect_success 'checkout -m skips stash with non-conflicting dirty index' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git add same &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same
+'
+
+test_expect_success 'checkout -m stashes and applies on conflicting changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 6 7 >one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	fill 1 2 3 4 5 6 7 >expect &&
+	test_cmp expect one
+'
+
+test_expect_success 'checkout -m with mixed staged and unstaged changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git add same &&
+	fill 1 2 3 4 5 6 7 >one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same &&
+	fill 1 2 3 4 5 6 7 >expect &&
+	test_cmp expect one
+'
+
+test_expect_success 'checkout -m stashes on truly conflicting changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	test_must_fail git checkout side 2>stderr &&
+	test_grep "Your local changes" stderr &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard
+'
+
+test_expect_success 'checkout -m produces usable stash on conflict' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git checkout -f main &&
+	git stash pop &&
+	fill 1 2 3 4 5 >expect &&
+	test_cmp expect one
+'
+
+test_expect_success 'checkout -m stashes on staged conflicting changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	git add one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "Created autostash" actual &&
+	test_grep "Applying autostash resulted in conflicts" actual &&
+	test_grep "Your changes are safe in the stash" actual &&
+	git stash drop &&
+	git reset --hard
+'
+
+test_expect_success 'checkout -m -b skips stash with dirty tree' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git checkout -m -b newbranch >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same &&
+	git checkout main &&
+	git branch -D newbranch
+'
+
 test_expect_success 'switch to another branch while carrying a deletion' '
 	git checkout -f main &&
 	git reset --hard &&
diff --git a/xdiff-interface.c b/xdiff-interface.c
index f043330f2a..5ee2b96d0a 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -325,6 +325,18 @@ int parse_conflict_style_name(const char *value)
 		return -1;
 }
 
+const char *conflict_style_name(int style)
+{
+	switch (style) {
+	case XDL_MERGE_DIFF3:
+		return "diff3";
+	case XDL_MERGE_ZEALOUS_DIFF3:
+		return "zdiff3";
+	default:
+		return "merge";
+	}
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value,
diff --git a/xdiff-interface.h b/xdiff-interface.h
index fbc4ceec40..ce54e1c0e0 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -55,6 +55,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
 struct config_context;
 int parse_conflict_style_name(const char *value);
+const char *conflict_style_name(int style);
 int git_xmerge_config(const char *var, const char *value,
 		      const struct config_context *ctx, void *cb);
 extern int git_xmerge_style;

base-commit: 67006b9db8b772423ad0706029286096307d2567
-- 
gitgitgadget

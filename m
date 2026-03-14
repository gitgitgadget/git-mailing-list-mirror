Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6C1BD9CE
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773482384; cv=none; b=XpY0QHNmiBaaBekC3ziHOjn4AiKaUdQDUij8FoFe+THRQdSa8Tm6Ng6sFzpB/iCAV1EItty6KNPu0HEkpegIJU9N3Iuaja/Hia4lVUS/2/SmyvUuCCAbP38rEi4khweAJLyjT9o9lWy/kWHpBReCahA09LPiz4QHvYnrF2nDQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773482384; c=relaxed/simple;
	bh=WKunKtx6ktS3rMA5BSQJ0JayuBh/1i1Ba58xPy05qhU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z3la0nIaSomoJV3Kx9SRdJgLxu8dRDWFObiBuY3cuoRqNdxZhZ9GB3F4p/Da+vvD3g3x/oGRUcYM15ME3a79b9638fYm/q5Mo2Zk4PrNr0u9Iv0YpyolzSI9nqnXnqWc+7hGbj7Ng6kzmaKzfTQDbcXwLm01pXiK7wdYhUDyaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRHxpUcW; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRHxpUcW"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f387a688dso2418999fac.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773482379; x=1774087179; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx962H0z9gOOXTzTEYCaNJxpV8T4y4JpvJTxHsFDg9Q=;
        b=dRHxpUcWG1mtrSCgXiUH4H/ZLfH2+SK29AoDMzc6waEjsuCYdMx66C1/vISLSr9AN4
         goqmmyyKbuwKVbwNdRtyv5p3o+oH1HHMGDQyLBaZ+KlQ0+HdPvjfdhbfGWAYXCqrl4up
         rptvu6wdMZ41ZFOkfIbOeUznlFDlGlyRErr9JndH/mw+Jse+7x5hQlTcBjWl9lFqQXBW
         4wvZglqmwyL3JxlOAil+6YX5KJGnl8FnrghXJwCLjwCyo0KwejDPwVee/oZwDRh0pbs+
         +hw53nQZrvLPn0I+LoOealI9DV/2wCTqd6TXhdjnZC+ETntyUYDNFirurLdfC0Ht9Nx0
         FdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773482379; x=1774087179;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx962H0z9gOOXTzTEYCaNJxpV8T4y4JpvJTxHsFDg9Q=;
        b=a+EKDR/S22S17vguxmDDuv7j76YXx+PgzWOecyzoJ6hIVYS6XxVS82Hi9q2cu3OCjU
         kmoNi+3ALxn508U2C2Flc2GQKIeZax6NxmmBRcayzOO0og4OFGulVzipGRCx64mc833k
         NNDEpCe1yHFw8LfaViAybsEvjYpg8G2zp7wLOjPLaMYcMdQCVcwfW1RjpXj4Zf4sok4f
         HujCidlwZZ07bg2jHko3VGOdNvyy4zLDLW2QX4mVPNxX/GFK91BvnJG3srD4gm5HWc8L
         yI3d9NQrWte9bZV+bqZ+H+ruIC9KE0BINgfGuul9Do2iPs6HiB5mYiDw/NP/EkEzVEFD
         QEHw==
X-Gm-Message-State: AOJu0YzAOOWGurq89EDrekvPTCCIc/a8RH5XHF7QzB62EICCLUwsQspt
	GzZgEGfOQzfJ8VFYQyUXPykpx1BvaK1xbSqJw0xphFj0YF58xdnH6La21VfCNA==
X-Gm-Gg: ATEYQzyRb+mryYHQPeV3Qf0Enzo66KFMYWUlqR7pzoBXFMxJUFCt/t0P1GUI6OXj+VQ
	97LAhITqtNRGipUyr1esEwEv/Dru1Nkzbk1qnd5U1FV+rll0JFNMm/wO+3mCVvoIu6AbRhmmrXr
	KArsvEB//wUo9n4alr6MP/da2niNQuXT9rxJYBFtgIrjN8OKWsIdB98accPPznqqpJeewlWe17X
	IA+RXiGCyuaHfxi0EMPxY0loiF/Q3q4W0PedqpKv5kriak06W/0ALG/0V3hvc5fkx4R0wKNoBzC
	1/WnEkD+Dv48xAwfpWUlsjN/4vjfd9rGKHcymzFJdW3pZ/LlELsGIWkTBygOcWqMVPJJItIwmAp
	jMMXEwzMV9/6c16ZogNTC3NhtTQu948KhUHSh03iKy5lbfeJ6JwC6cJJ3y1XHoWs9DK1pezycQj
	skKtVFj7pw1Cvg9MU+l26TWuWSOg==
X-Received: by 2002:a05:6871:e708:b0:40e:95b9:40f3 with SMTP id 586e51a60fabf-417b946c48fmr3980608fac.39.1773482378868;
        Sat, 14 Mar 2026 02:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.219.146])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e94b4sm9928243fac.11.2026.03.14.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:59:37 -0700 (PDT)
Message-Id: <pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v3.git.git.1773393818235.gitgitgadget@gmail.com>
References: <pull.2234.v3.git.git.1773393818235.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Mar 2026 09:59:35 +0000
Subject: [PATCH v4] checkout: -m (--merge) uses autostash when switching
 branches
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

When switching branches with "git checkout -m", local modifications
can block the switch.  Teach the -m flow to create a temporary stash
before switching and reapply it after.  On success, only "Applied
autostash." is shown.  If reapplying causes conflicts, the stash is
kept and the user is told they can resolve and run "git stash drop",
or run "git reset --hard" and later "git stash pop" to recover their
changes.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: 'autostash' for branch switching
    
    cc: Phillip Wood phillip.wood123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v4
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v3:

 1:  05f1e53163 ! 1:  5d49c0031a checkout: add --autostash option for branch switching
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    checkout: add --autostash option for branch switching
     +    checkout: -m (--merge) uses autostash when switching branches
      
     -    When switching branches, local modifications in the working tree can
     -    prevent the checkout from succeeding.  While "git rebase" and "git
     -    merge" already support --autostash to handle this case automatically,
     -    "git checkout" and "git switch" require users to manually stash and
     -    unstash their changes.
     -
     -    Teach "git checkout" and "git switch" to accept --autostash and
     -    --no-autostash options that automatically create a temporary stash
     -    entry before the branch switch begins and apply it after the switch
     -    completes.  If the stash application results in conflicts, the stash
     -    entry is saved to the stash list so the user can resolve them later.
     -
     -    Also add a checkout.autoStash configuration option that enables this
     -    behavior by default, which can be overridden with --no-autostash on
     -    the command line.
     +    When switching branches with "git checkout -m", local modifications
     +    can block the switch.  Teach the -m flow to create a temporary stash
     +    before switching and reapply it after.  On success, only "Applied
     +    autostash." is shown.  If reapplying causes conflicts, the stash is
     +    kept and the user is told they can resolve and run "git stash drop",
     +    or run "git reset --hard" and later "git stash pop" to recover their
     +    changes.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
       ------------
       $ git checkout -m mytopic
      -Auto-merging frotz
     -+Created autostash: 7a9afa3
      +Applied autostash.
       ------------
       
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
       
      -When a merge conflict happens during switching branches with
      -the `-m` option, you would see something like this:
     -+When the locally modified files overlap with files that need to be
     -+updated by the branch switch, the changes are stashed and reapplied
     -+after the switch.  If the stash application results in conflicts,
     -+they are not resolved and the stash is saved to the stash list:
     ++When the `--merge` (`-m`) option is in effect and the locally
     ++modified files overlap with files that need to be updated by the
     ++branch switch, the changes are stashed and reapplied after the
     ++switch.  If the stash application results in conflicts, they are not
     ++resolved and the stash is saved to the stash list:
       
       ------------
       $ git checkout -m mytopic
      -Auto-merging frotz
      -ERROR: Merge conflict in frotz
      -fatal: merge program failed
     -+Created autostash: 7a9afa3
     -+Applying autostash resulted in conflicts.
     -+Your changes are safe in the stash.
     -+You can run "git stash pop" or "git stash drop" at any time.
     - ------------
     +-------------
     ++Your local changes are stashed, however, applying it to carry
     ++forward your local changes resulted in conflicts:
       
      -At this point, `git diff` shows the changes cleanly merged as in
      -the previous example, as well as the changes in the conflicted
      -files.  Edit and resolve the conflict and mark it resolved with
      -`git add` as usual:
     --
     --------------
     ++ - You can try resolving them now.  If you resolved them
     ++   successfully, discard the stash entry with "git stash drop".
     + 
     ++ - Alternatively you can "git reset --hard" if you do not want
     ++   to deal with them right now, and later "git stash pop" to
     ++   recover your local changes.
     + ------------
      -$ edit frotz
      -$ git add frotz
      -------------
     -+At this point, `git stash pop` can be used to recover and resolve
     -+the conflicts, and `git stash drop` to discard the stash when done.
     ++
     ++You can try resolving the conflicts now.  Edit the conflicting files
     ++and mark them resolved with `git add` as usual, then run `git stash
     ++drop` to discard the stash entry.  Alternatively, you can clear the
     ++working tree with `git reset --hard` and recover your local changes
     ++later with `git stash pop`.
       
       CONFIGURATION
       -------------
     @@ builtin/checkout.c: static void orphaned_commit_warning(struct commit *old_commi
       static int switch_branches(const struct checkout_opts *opts,
       			   struct branch_info *new_branch_info)
       {
     +@@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
     + 	struct object_id rev;
     + 	int flag, writeout_error = 0;
     + 	int do_merge = 1;
     ++	struct strbuf old_commit_shortname = STRBUF_INIT;
     ++	const char *stash_label_ancestor = NULL;
     + 
     + 	trace2_cmd_mode("branch");
     + 
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       			do_merge = 0;
       	}
       
     ++	if (old_branch_info.name)
     ++		stash_label_ancestor = old_branch_info.name;
     ++	else if (old_branch_info.commit) {
     ++		strbuf_add_unique_abbrev(&old_commit_shortname,
     ++					 &old_branch_info.commit->object.oid,
     ++					 DEFAULT_ABBREV);
     ++		stash_label_ancestor = old_commit_shortname.buf;
     ++	}
     ++
      +	if (opts->merge) {
      +		if (repo_read_index(the_repository) < 0)
      +			die(_("index file corrupt"));
      +		if (checkout_would_clobber_changes(&old_branch_info,
      +						   new_branch_info))
     -+			create_autostash_ref(the_repository,
     -+					     "CHECKOUT_AUTOSTASH");
     ++			create_autostash_ref_silent(the_repository,
     ++						   "CHECKOUT_AUTOSTASH");
      +	}
      +
       	if (do_merge) {
       		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
       		if (ret) {
     -+			apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
     ++			apply_autostash_ref_with_labels(the_repository,
     ++						       "CHECKOUT_AUTOSTASH",
     ++						       new_branch_info->name,
     ++						       "local",
     ++						       stash_label_ancestor);
       			branch_info_release(&old_branch_info);
     ++			strbuf_release(&old_commit_shortname);
       			return ret;
       		}
     + 	}
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       
       	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +		git_config_push_parameter(cfg.buf);
      +		strbuf_release(&cfg);
      +	}
     -+	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH");
     ++	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH",
     ++				       new_branch_info->name, "local",
     ++				       stash_label_ancestor);
      +
      +	discard_index(the_repository->index);
      +	if (repo_read_index(the_repository) < 0)
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +
       	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
       	branch_info_release(&old_branch_info);
     ++	strbuf_release(&old_commit_shortname);
     + 
     + 	return ret || writeout_error;
     + }
     +
     + ## builtin/stash.c ##
     +@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     + 		die(_("could not write index"));
     + }
     + 
     +-static int do_apply_stash(const char *prefix, struct stash_info *info,
     +-			  int index, int quiet)
     ++static int do_apply_stash_with_labels(const char *prefix,
     ++				      struct stash_info *info,
     ++				      int index, int quiet,
     ++				      const char *label1, const char *label2,
     ++				      const char *label_ancestor)
     + {
     + 	int clean, ret;
     + 	int has_index = index;
     +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
       
     + 	init_ui_merge_options(&o, the_repository);
     + 
     +-	o.branch1 = "Updated upstream";
     +-	o.branch2 = "Stashed changes";
     +-	o.ancestor = "Stash base";
     ++	o.branch1 = label1 ? label1 : "Updated upstream";
     ++	o.branch2 = label2 ? label2 : "Stashed changes";
     ++	o.ancestor = label_ancestor ? label_ancestor : "Stash base";
     + 
     + 	if (oideq(&info->b_tree, &c_tree))
     + 		o.branch1 = "Version stash was based on";
     +@@ builtin/stash.c: restore_untracked:
     + 	return ret;
     + }
     + 
     ++static int do_apply_stash(const char *prefix, struct stash_info *info,
     ++			  int index, int quiet)
     ++{
     ++	return do_apply_stash_with_labels(prefix, info, index, quiet,
     ++					  NULL, NULL, NULL);
     ++}
     ++
     + static int apply_stash(int argc, const char **argv, const char *prefix,
     + 		       struct repository *repo UNUSED)
     + {
     + 	int ret = -1;
     + 	int quiet = 0;
     + 	int index = use_index;
     ++	const char *label1 = NULL, *label2 = NULL, *label_ancestor = NULL;
     + 	struct stash_info info = STASH_INFO_INIT;
     + 	struct option options[] = {
     + 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
     + 		OPT_BOOL(0, "index", &index,
     + 			 N_("attempt to recreate the index")),
     ++		OPT_STRING(0, "ours-label", &label1, N_("label"),
     ++			   N_("label for the upstream side in conflict markers")),
     ++		OPT_STRING(0, "theirs-label", &label2, N_("label"),
     ++			   N_("label for the stashed side in conflict markers")),
     ++		OPT_STRING(0, "base-label", &label_ancestor, N_("label"),
     ++			   N_("label for the base in diff3 conflict markers")),
     + 		OPT_END()
     + 	};
     + 
     +@@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char *prefix,
     + 	if (get_stash_info(&info, argc, argv))
     + 		goto cleanup;
     + 
     +-	ret = do_apply_stash(prefix, &info, index, quiet);
     ++	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
     ++					 label1, label2, label_ancestor);
     + cleanup:
     + 	free_stash_info(&info);
     + 	return ret;
      
       ## sequencer.c ##
     +@@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list, int offset)
     + 
     + static void create_autostash_internal(struct repository *r,
     + 				      const char *path,
     +-				      const char *refname)
     ++				      const char *refname,
     ++				      int silent)
     + {
     + 	struct strbuf buf = STRBUF_INIT;
     + 	struct lock_file lock_file = LOCK_INIT;
      @@ sequencer.c: static void create_autostash_internal(struct repository *r,
       					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
       		}
       
      -		printf(_("Created autostash: %s\n"), buf.buf);
     -+		fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
     ++		if (!silent)
     ++			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
       		if (reset_head(r, &ropts) < 0)
       			die(_("could not reset --hard"));
       		discard_index(r->index);
     +@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     + 
     + void create_autostash(struct repository *r, const char *path)
     + {
     +-	create_autostash_internal(r, path, NULL);
     ++	create_autostash_internal(r, path, NULL, 0);
     + }
     + 
     + void create_autostash_ref(struct repository *r, const char *refname)
     + {
     +-	create_autostash_internal(r, NULL, refname);
     ++	create_autostash_internal(r, NULL, refname, 0);
     + }
     + 
     +-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     ++void create_autostash_ref_silent(struct repository *r, const char *refname)
     ++{
     ++	create_autostash_internal(r, NULL, refname, 1);
     ++}
     ++
     ++static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     ++				    const char *label1, const char *label2,
     ++				    const char *label_ancestor)
     + {
     + 	struct child_process child = CHILD_PROCESS_INIT;
     + 	int ret = 0;
     +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     + 		child.no_stderr = 1;
     + 		strvec_push(&child.args, "stash");
     + 		strvec_push(&child.args, "apply");
     ++		if (label1)
     ++			strvec_pushf(&child.args, "--ours-label=%s", label1);
     ++		if (label2)
     ++			strvec_pushf(&child.args, "--theirs-label=%s", label2);
     ++		if (label_ancestor)
     ++			strvec_pushf(&child.args, "--base-label=%s", label_ancestor);
     + 		strvec_push(&child.args, stash_oid);
     + 		ret = run_command(&child);
     + 	}
     +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     + 		strvec_push(&store.args, stash_oid);
     + 		if (run_command(&store))
     + 			ret = error(_("cannot store %s"), stash_oid);
     ++		else if (attempt_apply)
     ++			fprintf(stderr,
     ++				_("Your local changes are stashed, however, applying it to carry\n"
     ++				  "forward your local changes resulted in conflicts:\n"
     ++				  "\n"
     ++				  " - You can try resolving them now.  If you resolved them\n"
     ++				  "   successfully, discard the stash entry with \"git stash drop\".\n"
     ++				  "\n"
     ++				  " - Alternatively you can \"git reset --hard\" if you do not want\n"
     ++				  "   to deal with them right now, and later \"git stash pop\" to\n"
     ++				  "   recover your local changes.\n"));
     + 		else
     + 			fprintf(stderr,
     +-				_("%s\n"
     ++				_("Autostash exists; creating a new stash entry.\n"
     + 				  "Your changes are safe in the stash.\n"
     + 				  "You can run \"git stash pop\" or"
     +-				  " \"git stash drop\" at any time.\n"),
     +-				attempt_apply ?
     +-				_("Applying autostash resulted in conflicts.") :
     +-				_("Autostash exists; creating a new stash entry."));
     ++				  " \"git stash drop\" at any time.\n"));
     + 	}
     + 
     + 	return ret;
     +@@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
     + 	}
     + 	strbuf_trim(&stash_oid);
     + 
     +-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
     ++	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
     ++				      NULL, NULL, NULL);
     + 
     + 	unlink(path);
     + 	strbuf_release(&stash_oid);
     +@@ sequencer.c: int apply_autostash(const char *path)
     + 
     + int apply_autostash_oid(const char *stash_oid)
     + {
     +-	return apply_save_autostash_oid(stash_oid, 1);
     ++	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
     + }
     + 
     + static int apply_save_autostash_ref(struct repository *r, const char *refname,
     +-				    int attempt_apply)
     ++				    int attempt_apply,
     ++				    const char *label1, const char *label2,
     ++				    const char *label_ancestor)
     + {
     + 	struct object_id stash_oid;
     + 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
     +@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     + 		return error(_("autostash reference is a symref"));
     + 
     + 	oid_to_hex_r(stash_oid_hex, &stash_oid);
     +-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
     ++	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
     ++				       label1, label2, label_ancestor);
     + 
     + 	refs_delete_ref(get_main_ref_store(r), "", refname,
     + 			&stash_oid, REF_NO_DEREF);
     +@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     + 
     + int save_autostash_ref(struct repository *r, const char *refname)
     + {
     +-	return apply_save_autostash_ref(r, refname, 0);
     ++	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
     + }
     + 
     + int apply_autostash_ref(struct repository *r, const char *refname)
     + {
     +-	return apply_save_autostash_ref(r, refname, 1);
     ++	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
     ++}
     ++
     ++int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     ++				    const char *label1, const char *label2,
     ++				    const char *label_ancestor)
     ++{
     ++	return apply_save_autostash_ref(r, refname, 1,
     ++					label1, label2, label_ancestor);
     + }
     + 
     + static int checkout_onto(struct repository *r, struct replay_opts *opts,
      
     - ## t/t7201-co.sh ##
     -@@ t/t7201-co.sh: test_expect_success 'format of merge conflict from checkout -m' '
     - 	test_cmp expect current &&
     - 
     - 	cat <<-EOF >expect &&
     --	<<<<<<< simple
     -+	<<<<<<< Updated upstream
     - 	a
     - 	c
     - 	e
     - 	=======
     - 	b
     - 	d
     --	>>>>>>> local
     -+	>>>>>>> Stashed changes
     + ## sequencer.h ##
     +@@ sequencer.h: void commit_post_rewrite(struct repository *r,
     + 
     + void create_autostash(struct repository *r, const char *path);
     + void create_autostash_ref(struct repository *r, const char *refname);
     ++void create_autostash_ref_silent(struct repository *r, const char *refname);
     + int save_autostash(const char *path);
     + int save_autostash_ref(struct repository *r, const char *refname);
     + int apply_autostash(const char *path);
     + int apply_autostash_oid(const char *stash_oid);
     + int apply_autostash_ref(struct repository *r, const char *refname);
     ++int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     ++				    const char *label1, const char *label2,
     ++				    const char *label_ancestor);
     + 
     + #define SUMMARY_INITIAL_COMMIT   (1 << 0)
     + #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
     +
     + ## t/t3420-rebase-autostash.sh ##
     +@@ t/t3420-rebase-autostash.sh: create_expected_failure_apply () {
     + 	First, rewinding head to replay your work on top of it...
     + 	Applying: second commit
     + 	Applying: third commit
     +-	Applying autostash resulted in conflicts.
     +-	Your changes are safe in the stash.
     +-	You can run "git stash pop" or "git stash drop" at any time.
     ++	Your local changes are stashed, however, applying it to carry
     ++	forward your local changes resulted in conflicts:
     ++
     ++	 - You can try resolving them now.  If you resolved them
     ++	   successfully, discard the stash entry with "git stash drop".
     ++
     ++	 - Alternatively you can "git reset --hard" if you do not want
     ++	   to deal with them right now, and later "git stash pop" to
     ++	   recover your local changes.
       	EOF
     - 	test_cmp expect two
     - '
     -@@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
     - 	git checkout --merge --conflict=diff3 simple &&
     - 
     - 	cat <<-EOF >expect &&
     --	<<<<<<< simple
     -+	<<<<<<< Updated upstream
     - 	a
     - 	c
     - 	e
     --	||||||| main
     -+	||||||| Stash base
     - 	a
     - 	b
     - 	c
     -@@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
     - 	=======
     - 	b
     - 	d
     --	>>>>>>> local
     -+	>>>>>>> Stashed changes
     + }
     + 
     + create_expected_failure_merge () {
     + 	cat >expected <<-EOF
     + 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
     +-	Applying autostash resulted in conflicts.
     +-	Your changes are safe in the stash.
     +-	You can run "git stash pop" or "git stash drop" at any time.
     ++	Your local changes are stashed, however, applying it to carry
     ++	forward your local changes resulted in conflicts:
     ++
     ++	 - You can try resolving them now.  If you resolved them
     ++	   successfully, discard the stash entry with "git stash drop".
     ++
     ++	 - Alternatively you can "git reset --hard" if you do not want
     ++	   to deal with them right now, and later "git stash pop" to
     ++	   recover your local changes.
     + 	Successfully rebased and updated refs/heads/rebased-feature-branch.
       	EOF
     + }
     +
     + ## t/t7201-co.sh ##
     +@@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
       	test_cmp expect two
       '
       
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +
      +	cat <<-EOF >expect &&
      +	a
     -+	<<<<<<< Updated upstream
     ++	<<<<<<< simple
      +	c
     -+	||||||| Stash base
     ++	||||||| main
      +	b
      +	c
      +	d
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	b
      +	X
      +	d
     -+	>>>>>>> Stashed changes
     ++	>>>>>>> local
      +	e
      +	EOF
      +	test_cmp expect two
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	git checkout -m simple &&
      +
      +	cat <<-EOF >expect &&
     -+	<<<<<<< Updated upstream
     ++	<<<<<<< simple
      +	a
      +	c
      +	e
     -+	||||||| Stash base
     ++	||||||| main
      +	a
      +	b
      +	c
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	=======
      +	b
      +	d
     -+	>>>>>>> Stashed changes
     ++	>>>>>>> local
      +	EOF
      +	test_cmp expect two
      +'
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +
      +	fill 1 2 3 4 5 6 7 >one &&
      +	git checkout -m side >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	test_grep "Applied autostash" actual &&
      +	fill 1 2 3 4 5 6 7 >expect &&
      +	test_cmp expect one
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	git add same &&
      +	fill 1 2 3 4 5 6 7 >one &&
      +	git checkout -m side >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     ++	test_grep ! "Created autostash" actual &&
      +	test_grep "Applied autostash" actual &&
      +	fill 0 x y z >expect &&
      +	test_cmp expect same &&
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	test_must_fail git checkout side 2>stderr &&
      +	test_grep "Your local changes" stderr &&
      +	git checkout -m side >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applying autostash resulted in conflicts" actual &&
     -+	test_grep "Your changes are safe in the stash" actual &&
     ++	test_grep ! "Created autostash" actual &&
     ++	test_grep "resulted in conflicts" actual &&
     ++	test_grep "git stash drop" actual &&
      +	git stash drop &&
      +	git reset --hard
      +'
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +
      +	fill 1 2 3 4 5 >one &&
      +	git checkout -m side >actual 2>&1 &&
     -+	test_grep "Your changes are safe in the stash" actual &&
     ++	test_grep "recover your local changes" actual &&
      +	git checkout -f main &&
      +	git stash pop &&
      +	fill 1 2 3 4 5 >expect &&
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	fill 1 2 3 4 5 >one &&
      +	git add one &&
      +	git checkout -m side >actual 2>&1 &&
     -+	test_grep "Created autostash" actual &&
     -+	test_grep "Applying autostash resulted in conflicts" actual &&
     -+	test_grep "Your changes are safe in the stash" actual &&
     ++	test_grep ! "Created autostash" actual &&
     ++	test_grep "resulted in conflicts" actual &&
     ++	test_grep "git stash drop" actual &&
      +	git stash drop &&
      +	git reset --hard
      +'
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
       	git checkout -f main &&
       	git reset --hard &&
      
     + ## t/t7600-merge.sh ##
     +@@ t/t7600-merge.sh: test_expect_success 'merge --squash --autostash conflict does not attempt to app
     + 	>unrelated &&
     + 	git add unrelated &&
     + 	test_must_fail git merge --squash c7 --autostash >out 2>err &&
     +-	! grep "Applying autostash resulted in conflicts." err &&
     ++	! grep "resulted in conflicts" err &&
     + 	grep "When finished, apply stashed changes with \`git stash pop\`" out
     + '
     + 
     +@@ t/t7600-merge.sh: test_expect_success 'merge with conflicted --autostash changes' '
     + 	git diff >expect &&
     + 	test_when_finished "test_might_fail git stash drop" &&
     + 	git merge --autostash c3 2>err &&
     +-	test_grep "Applying autostash resulted in conflicts." err &&
     ++	test_grep "resulted in conflicts" err &&
     + 	git show HEAD:file >merge-result &&
     + 	test_cmp result.1-9 merge-result &&
     + 	git stash show -p >actual &&
     +
       ## xdiff-interface.c ##
      @@ xdiff-interface.c: int parse_conflict_style_name(const char *value)
       		return -1;


 Documentation/git-checkout.adoc |  56 +++++-----
 Documentation/git-switch.adoc   |  26 ++---
 builtin/checkout.c              | 179 +++++++++++++++++---------------
 builtin/stash.c                 |  30 ++++--
 sequencer.c                     |  67 +++++++++---
 sequencer.h                     |   4 +
 t/t3420-rebase-autostash.sh     |  24 +++--
 t/t7201-co.sh                   | 160 ++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   4 +-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 11 files changed, 412 insertions(+), 151 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..9d5f5c51ae 100644
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
@@ -578,39 +575,44 @@ $ git checkout mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a
-three-way merge:
+You can give the `-m` flag to the command, which would save the local
+changes in a stash entry and reset the working tree to allow switching:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
+Applied autostash.
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
 === 3. Merge conflict
 
-When a merge conflict happens during switching branches with
-the `-m` option, you would see something like this:
+When the `--merge` (`-m`) option is in effect and the locally
+modified files overlap with files that need to be updated by the
+branch switch, the changes are stashed and reapplied after the
+switch.  If the stash application results in conflicts, they are not
+resolved and the stash is saved to the stash list:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
-ERROR: Merge conflict in frotz
-fatal: merge program failed
-------------
+Your local changes are stashed, however, applying it to carry
+forward your local changes resulted in conflicts:
 
-At this point, `git diff` shows the changes cleanly merged as in
-the previous example, as well as the changes in the conflicted
-files.  Edit and resolve the conflict and mark it resolved with
-`git add` as usual:
+ - You can try resolving them now.  If you resolved them
+   successfully, discard the stash entry with "git stash drop".
 
+ - Alternatively you can "git reset --hard" if you do not want
+   to deal with them right now, and later "git stash pop" to
+   recover your local changes.
 ------------
-$ edit frotz
-$ git add frotz
-------------
+
+You can try resolving the conflicts now.  Edit the conflicting files
+and mark them resolved with `git add` as usual, then run `git stash
+drop` to discard the stash entry.  Alternatively, you can clear the
+working tree with `git reset --hard` and recover your local changes
+later with `git stash pop`.
 
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
index 1d1667fa4c..1968e46ae9 100644
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
@@ -1165,6 +1136,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	int do_merge = 1;
+	struct strbuf old_commit_shortname = STRBUF_INIT;
+	const char *stash_label_ancestor = NULL;
 
 	trace2_cmd_mode("branch");
 
@@ -1202,10 +1175,34 @@ static int switch_branches(const struct checkout_opts *opts,
 			do_merge = 0;
 	}
 
+	if (old_branch_info.name)
+		stash_label_ancestor = old_branch_info.name;
+	else if (old_branch_info.commit) {
+		strbuf_add_unique_abbrev(&old_commit_shortname,
+					 &old_branch_info.commit->object.oid,
+					 DEFAULT_ABBREV);
+		stash_label_ancestor = old_commit_shortname.buf;
+	}
+
+	if (opts->merge) {
+		if (repo_read_index(the_repository) < 0)
+			die(_("index file corrupt"));
+		if (checkout_would_clobber_changes(&old_branch_info,
+						   new_branch_info))
+			create_autostash_ref_silent(the_repository,
+						   "CHECKOUT_AUTOSTASH");
+	}
+
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
+			apply_autostash_ref_with_labels(the_repository,
+						       "CHECKOUT_AUTOSTASH",
+						       new_branch_info->name,
+						       "local",
+						       stash_label_ancestor);
 			branch_info_release(&old_branch_info);
+			strbuf_release(&old_commit_shortname);
 			return ret;
 		}
 	}
@@ -1215,8 +1212,28 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	if (opts->conflict_style >= 0) {
+		struct strbuf cfg = STRBUF_INIT;
+		strbuf_addf(&cfg, "merge.conflictStyle=%s",
+			    conflict_style_name(opts->conflict_style));
+		git_config_push_parameter(cfg.buf);
+		strbuf_release(&cfg);
+	}
+	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH",
+				       new_branch_info->name, "local",
+				       stash_label_ancestor);
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
+	strbuf_release(&old_commit_shortname);
 
 	return ret || writeout_error;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index e79d612e57..1016d88e52 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -590,8 +590,11 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
-static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet)
+static int do_apply_stash_with_labels(const char *prefix,
+				      struct stash_info *info,
+				      int index, int quiet,
+				      const char *label1, const char *label2,
+				      const char *label_ancestor)
 {
 	int clean, ret;
 	int has_index = index;
@@ -643,9 +646,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	init_ui_merge_options(&o, the_repository);
 
-	o.branch1 = "Updated upstream";
-	o.branch2 = "Stashed changes";
-	o.ancestor = "Stash base";
+	o.branch1 = label1 ? label1 : "Updated upstream";
+	o.branch2 = label2 ? label2 : "Stashed changes";
+	o.ancestor = label_ancestor ? label_ancestor : "Stash base";
 
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
@@ -717,17 +720,31 @@ restore_untracked:
 	return ret;
 }
 
+static int do_apply_stash(const char *prefix, struct stash_info *info,
+			  int index, int quiet)
+{
+	return do_apply_stash_with_labels(prefix, info, index, quiet,
+					  NULL, NULL, NULL);
+}
+
 static int apply_stash(int argc, const char **argv, const char *prefix,
 		       struct repository *repo UNUSED)
 {
 	int ret = -1;
 	int quiet = 0;
 	int index = use_index;
+	const char *label1 = NULL, *label2 = NULL, *label_ancestor = NULL;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "index", &index,
 			 N_("attempt to recreate the index")),
+		OPT_STRING(0, "ours-label", &label1, N_("label"),
+			   N_("label for the upstream side in conflict markers")),
+		OPT_STRING(0, "theirs-label", &label2, N_("label"),
+			   N_("label for the stashed side in conflict markers")),
+		OPT_STRING(0, "base-label", &label_ancestor, N_("label"),
+			   N_("label for the base in diff3 conflict markers")),
 		OPT_END()
 	};
 
@@ -737,7 +754,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info(&info, argc, argv))
 		goto cleanup;
 
-	ret = do_apply_stash(prefix, &info, index, quiet);
+	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
+					 label1, label2, label_ancestor);
 cleanup:
 	free_stash_info(&info);
 	return ret;
diff --git a/sequencer.c b/sequencer.c
index aafd0bc959..53e04d8a94 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4632,7 +4632,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      int silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4677,7 +4678,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4689,15 +4691,22 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, 0);
 }
 
 void create_autostash_ref(struct repository *r, const char *refname)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, 0);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+void create_autostash_ref_silent(struct repository *r, const char *refname)
+{
+	create_autostash_internal(r, NULL, refname, 1);
+}
+
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4708,6 +4717,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label1)
+			strvec_pushf(&child.args, "--ours-label=%s", label1);
+		if (label2)
+			strvec_pushf(&child.args, "--theirs-label=%s", label2);
+		if (label_ancestor)
+			strvec_pushf(&child.args, "--base-label=%s", label_ancestor);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4726,15 +4741,23 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
+		else if (attempt_apply)
+			fprintf(stderr,
+				_("Your local changes are stashed, however, applying it to carry\n"
+				  "forward your local changes resulted in conflicts:\n"
+				  "\n"
+				  " - You can try resolving them now.  If you resolved them\n"
+				  "   successfully, discard the stash entry with \"git stash drop\".\n"
+				  "\n"
+				  " - Alternatively you can \"git reset --hard\" if you do not want\n"
+				  "   to deal with them right now, and later \"git stash pop\" to\n"
+				  "   recover your local changes.\n"));
 		else
 			fprintf(stderr,
-				_("%s\n"
+				_("Autostash exists; creating a new stash entry.\n"
 				  "Your changes are safe in the stash.\n"
 				  "You can run \"git stash pop\" or"
-				  " \"git stash drop\" at any time.\n"),
-				attempt_apply ?
-				_("Applying autostash resulted in conflicts.") :
-				_("Autostash exists; creating a new stash entry."));
+				  " \"git stash drop\" at any time.\n"));
 	}
 
 	return ret;
@@ -4752,7 +4775,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4771,11 +4795,13 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4791,7 +4817,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label1, label2, label_ancestor);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4801,12 +4828,20 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
 int save_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 0);
+	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
 }
 
 int apply_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 1);
+	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
+}
+
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor)
+{
+	return apply_save_autostash_ref(r, refname, 1,
+					label1, label2, label_ancestor);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9..68b94d86e3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -227,11 +227,15 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref_silent(struct repository *r, const char *refname);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
 int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
+				    const char *label1, const char *label2,
+				    const char *label_ancestor);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index ad3ba6a984..e4e2cb19ce 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -61,18 +61,30 @@ create_expected_failure_apply () {
 	First, rewinding head to replay your work on top of it...
 	Applying: second commit
 	Applying: third commit
-	Applying autostash resulted in conflicts.
-	Your changes are safe in the stash.
-	You can run "git stash pop" or "git stash drop" at any time.
+	Your local changes are stashed, however, applying it to carry
+	forward your local changes resulted in conflicts:
+
+	 - You can try resolving them now.  If you resolved them
+	   successfully, discard the stash entry with "git stash drop".
+
+	 - Alternatively you can "git reset --hard" if you do not want
+	   to deal with them right now, and later "git stash pop" to
+	   recover your local changes.
 	EOF
 }
 
 create_expected_failure_merge () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	Applying autostash resulted in conflicts.
-	Your changes are safe in the stash.
-	You can run "git stash pop" or "git stash drop" at any time.
+	Your local changes are stashed, however, applying it to carry
+	forward your local changes resulted in conflicts:
+
+	 - You can try resolving them now.  If you resolved them
+	   successfully, discard the stash entry with "git stash drop".
+
+	 - Alternatively you can "git reset --hard" if you do not want
+	   to deal with them right now, and later "git stash pop" to
+	   recover your local changes.
 	Successfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..f4fea7bb7a 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -210,6 +210,166 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
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
+	<<<<<<< simple
+	c
+	||||||| main
+	b
+	c
+	d
+	=======
+	b
+	X
+	d
+	>>>>>>> local
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
+	<<<<<<< simple
+	a
+	c
+	e
+	||||||| main
+	a
+	b
+	c
+	d
+	e
+	=======
+	b
+	d
+	>>>>>>> local
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
+	test_grep ! "Created autostash" actual &&
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
+	test_grep ! "Created autostash" actual &&
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
+	test_grep ! "Created autostash" actual &&
+	test_grep "resulted in conflicts" actual &&
+	test_grep "git stash drop" actual &&
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
+	test_grep "recover your local changes" actual &&
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
+	test_grep ! "Created autostash" actual &&
+	test_grep "resulted in conflicts" actual &&
+	test_grep "git stash drop" actual &&
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
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9838094b66..b061cc1b4a 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -342,7 +342,7 @@ test_expect_success 'merge --squash --autostash conflict does not attempt to app
 	>unrelated &&
 	git add unrelated &&
 	test_must_fail git merge --squash c7 --autostash >out 2>err &&
-	! grep "Applying autostash resulted in conflicts." err &&
+	! grep "resulted in conflicts" err &&
 	grep "When finished, apply stashed changes with \`git stash pop\`" out
 '
 
@@ -914,7 +914,7 @@ test_expect_success 'merge with conflicted --autostash changes' '
 	git diff >expect &&
 	test_when_finished "test_might_fail git stash drop" &&
 	git merge --autostash c3 2>err &&
-	test_grep "Applying autostash resulted in conflicts." err &&
+	test_grep "resulted in conflicts" err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-9 merge-result &&
 	git stash show -p >actual &&
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

base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F1DC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJTUUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTUUr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:20:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066571F041F
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so564132wmq.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5eloJnq/X1piC0MHKV7Mvjm8/2eCKPjbhnbj5fvWNo=;
        b=XZxBTq9DWO7gIt9wMU1MdVqKQdBx3/JBaZ4NROQWuG9qnnjjjbISQ8UdIaq/7tqNZh
         AjIjS4k5F8/8vLorpZzRftxj2q+icBxeZBCGPnrHDd/Bh39INBXrMXOJi6RM4Qtr11lF
         7/9Tm+4Yz9jqbckRNUSmtMAP5U2g2VLcoOm9pERnp4jSWJoSeGfPkRJcCkzkgCsxEvP5
         gDkGk4z2RYNh/Y+X3I+mRToDaQsSHSqm6QVlnPRaHCUOIC1V2F4eshiJ12pE0KndZPEX
         zLoIM0Q4gm476g8ddOGkdBtuhpa/f13WoNhcoQ/vAEK65fbkdbBSeVdtyClbgDLc0COv
         oRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5eloJnq/X1piC0MHKV7Mvjm8/2eCKPjbhnbj5fvWNo=;
        b=fU5HN4bMXCuVARLFsg2bCL95w52ffAlPlO8DMXFO6IdrFo2Odwqezdb4LBi8vVxdAj
         hxxAuKmDyID7xMkjqsNkcxBGiWPgmgiQ7eIGCYwD0D6rTtmyNrSo34xNDs8Vd9E3+uti
         fdW9XDvCvPub0RabvKoQaC6lnDlqCW8sDlwALGt5L3pR0+eBlko6dIMEa55tqTOl5DVn
         jr1NkFgvRq8RIQOD48P16YqUGGBNWGeV2LwGS49eVCDMlLWV6Dx6lT96qCHfH4t2Uzee
         l/CBqcPNzduppHtFMFw9sMkD/MP1KCmSVoexvKIFLrllZGtHZOIwPxOb4oDPEYciivYM
         6ALQ==
X-Gm-Message-State: ACrzQf3lVOj/bwwKofyF23WTZBc+pkwOv4u3JTO+zmy8U2y61RpFo3oC
        rjKUyn5HEdW8sZSh+ZkGvUg161QUNSk=
X-Google-Smtp-Source: AMsMyM4Q/P5dJCAckTULnr/4pr3vgsPKRt9rti9n+skKPvb3tH5n7WSeKkXgKAY6HNwhzhPGOj0xIQ==
X-Received: by 2002:a05:600c:230d:b0:3c4:2975:321a with SMTP id 13-20020a05600c230d00b003c42975321amr31495365wmo.155.1666297241445;
        Thu, 20 Oct 2022 13:20:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d554a000000b002364c77bcacsm1195404wrw.38.2022.10.20.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:20:40 -0700 (PDT)
Message-Id: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 20:20:31 +0000
Subject: [PATCH v2 0/7] clone, submodule update: check out submodule branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Philippe and Jonathan for your review on the previous version :)
Sorry for the long delay between iterations, I got wrapped up in other,
unrelated work.

The biggest change in this version is that "git submodule update" now
creates the branch when the submodule is cloned, not when the submodule's
worktree is updated. So when the worktree is updated, we use "git checkout "
instead of "git checkout -b ". This is more robust to branches created
directly in the submodule (which was pointed out by both reviewers), but
also allows us to add matching behavior to "git submodule add ", which also
clones + checks out submodules.

During the v1 discussion, I realize that my idea of the new submodule UX has
already diverged from what was initially communicated to the list. I plan to
check in a technical document describing the plans for new submodule UX,
which should hopefully make these discussions smoother (e.g. the commit
message in patch 7 can make reference to the doc).

= Description

This series teaches "git clone --recurse-submodules" and "git submodule
update" to understand "submodule.propagateBranches" (see Further Reading for
context), i.e. if the superproject has a branch checked out and a submodule
is cloned, the submodule will have the same branch checked out.

To do this, "git submodule update" checks if "submodule.propagateBranches"
is true, and if so, gets the current superproject branch and updates the
submodule by running "git checkout -b my-superproject-branch". Since "git
clone --recurse-submodules" is implemented using "git submodule update", it
also learns this trick.

The main challenges with this approach are:

 * If the remote HEAD points to a branch, "git clone" always creates that
   branch in the clone. But with "submodule.propagateBranches", we want
   submodules to use the branch names of their superproject, not their
   upstream.
   
   This is solved by adding a new flag to "git clone", "--detach", which
   detaches the clone's HEAD at the branch and does not create it.

 * When "git submodule update" recurses into submodules, the parent process
   has to propagate the value of "submodule.propagateBranches" to child
   processes, otherwise the behavior will be inconsistent if the submodule
   has the config unset.
   
   This is solved by adding an internal GIT_* environment variable and
   passing it down via prepare_submodule_repo_env(). This is cleaner than
   passing "-c submodule.propagateBranches=true", but an even cleaner
   solution would be for submodules to read "submodule.propagateBranches"
   from their superproject config. This would also be useful for
   "submodule.alternateLocation" and "submodule.alternateErrorStrategy", as
   we wouldn't have to set those values in newly-cloned submodules. This
   requires teaching Git to treat submodules differently, which was the
   subject of some WIP in [1]. That topic has stalled, but I don't mind
   restarting it if others prefer that.

[1]
https://lore.kernel.org/git/20220310004423.2627181-1-emilyshaffer@google.com/

= Patch organization

 * Patch 1/7 adds "--detach" to "git clone"
 * Patch 2/7 creates the environment variable and repository setting for
   "submodule.propagateBranches"
 * Patch 3/7 adds a new "--branch" option to "git submodule clone", which
   makes it create a named branch.
 * Patches 4-6/7 are prep work, and 7/7 adds the actual
   "submodule.propagateBranches" behavior

= Series history

Changes in v2:

 * The superproject's "submodule.propagateBranches" value is always used,
   even if false.
 * Branches are now created at clone time (by adding a new flag to "git
   submodule clone"), instead of at update time.
 * Rebase onto newer master. This got adjusted slightly to incorporate
   ab/submodule-helper-leakfix.
 * Add more tests to demonstrate edge case behavior.
 * Assorted commit message and doc improvements.

= Future work

 * Patch 5, which refactors resolve_gitlink_ref(), notes that a better
   interface would be to return the refname instead of using an "out"
   parameter, but we use an "out" parameter so that any new callers trying
   to use the old function signature will get stopped by the compiler. The
   refactor can be finished at a later time.

 * Patch 5 uses the name "target" when we are talking about what a symref
   points to, instead of "referent" like the other functions. "target" is
   the better choice, since "referent" could also apply to non-symbolic
   refs, but that cleanup is quite big.

= Further reading

Submodule branching RFC:
https://lore.kernel.org/git/kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com/

Original Submodule UX RFC/Discussion:
https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

Contributor Summit submodules Notes:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbjf.bet/

Submodule UX overhaul updates:
https://lore.kernel.org/git/?q=Submodule+UX+overhaul+update

"git branch --recurse-submodules":
https://lore.kernel.org/git/20220129000446.99261-1-chooglen@google.com/

Glen Choo (7):
  clone: teach --detach option
  repo-settings: add submodule_propagate_branches
  submodule--helper clone: create named branch
  t5617: drop references to remote-tracking branches
  submodule: return target of submodule symref
  submodule update: refactor update targets
  clone, submodule update: create and check out branches

 Documentation/git-clone.txt                   |  8 +-
 builtin/branch.c                              | 11 +--
 builtin/clone.c                               | 12 ++-
 builtin/submodule--helper.c                   | 91 ++++++++++++++++---
 builtin/update-index.c                        |  4 +-
 cache.h                                       |  1 +
 combine-diff.c                                |  3 +-
 diff-lib.c                                    |  2 +-
 dir.c                                         |  2 +-
 object-file.c                                 |  2 +-
 read-cache.c                                  |  4 +-
 refs.c                                        | 10 +-
 refs.h                                        |  5 +-
 repo-settings.c                               | 10 ++
 repository.h                                  |  1 +
 submodule.c                                   |  2 +
 t/t5601-clone.sh                              | 22 +++++
 ...es-remote.sh => t5617-clone-submodules.sh} | 36 +++++++-
 t/t7406-submodule-update.sh                   | 64 +++++++++++++
 unpack-trees.c                                |  3 +-
 20 files changed, 251 insertions(+), 42 deletions(-)
 rename t/{t5617-clone-submodules-remote.sh => t5617-clone-submodules.sh} (72%)


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1321%2Fchooglen%2Fsubmodule%2Fclone-recursive-with-branch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1321/chooglen/submodule/clone-recursive-with-branch-v2
Pull-Request: https://github.com/git/git/pull/1321

Range-diff vs v1:

 1:  936e237c716 ! 1:  432bc7cb3a4 clone: teach --detach option
     @@ Commit message
          clone: teach --detach option
      
          Teach "git clone" the "--detach" option, which leaves the cloned repo in
     -    detached HEAD (like "git checkout --detach"). If the clone is not bare,
     -    the remote's HEAD branch is also not created (bare clones always copy
     -    all remote branches directly to local branches, so the branch is still
     -    created in the bare case).
     +    detached HEAD (like "git checkout --detach"). In addition, if the clone
     +    is not bare, do not create the local branch pointed to by the remote's
     +    HEAD symref (bare clones always copy all remote branches directly to
     +    local branches, so the branch is still created in the bare case).
      
          This is especially useful in the "submodule.propagateBranches" workflow,
     -    where the submodule branch names match the superproject's branch names,
     -    so it makes no sense to name the branches after the submodule's remote's
     -    branches.
     +    where local submodule branches are named after the superproject's
     +    branches, so it makes no sense to create a local branch named after the
     +    submodule's remote's branch.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       
      +--detach::
      +	If the cloned repository's HEAD points to a branch, point the newly
     -+	created HEAD to the branch's commit instead of the branch itself. In a
     -+	non-bare repository, the branch will not be created.
     ++	created HEAD to the branch's commit instead of the branch itself.
     ++	Additionally, in a non-bare repository, the corresponding local branch
     ++	will not be created.
      +
       -u <upload-pack>::
       --upload-pack <upload-pack>::
     @@ builtin/clone.c: static int option_filter_submodules = -1;    /* unspecified */
       static struct string_list server_options = STRING_LIST_INIT_NODUP;
       static int option_remote_submodules;
      +static int option_detach;
     + static const char *bundle_uri;
       
       static int recurse_submodules_cb(const struct option *opt,
     - 				 const char *arg, int unset)
      @@ builtin/clone.c: static struct option builtin_clone_options[] = {
       		    N_("any cloned submodules will use their remote-tracking branch")),
       	OPT_BOOL(0, "sparse", &option_sparse_checkout,
       		    N_("initialize sparse-checkout file to include only files at root")),
      +	OPT_BOOL(0, "detach", &option_detach,
     -+		 N_("detach HEAD and don't create branch")),
     ++		 N_("detach HEAD and don't create a local branch")),
     + 	OPT_STRING(0, "bundle-uri", &bundle_uri,
     + 		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
       	OPT_END()
     - };
     - 
      @@ builtin/clone.c: static void update_remote_refs(const struct ref *refs,
       }
       
 2:  35f068eb031 ! 2:  20499c62065 repo-settings: add submodule_propagate_branches
     @@ Commit message
          or submodule, otherwise the behavior may be inconsistent if the
          repositories don't agree on the config.
      
     -    We haven't needed a way to propagate the config because because the only
     -    command that reads "submodule.propagateBranches" is "git branch", which
     -    only has one mode of operation with "--recurse-submodules". However, a
     -    future commit will teach "submodule.propagateBranches" to "git submodule
     +    We haven't needed a way to propagate the config because the only command
     +    that reads "submodule.propagateBranches" is "git branch", which only has
     +    one mode of operation with "--recurse-submodules". However, a future
     +    commit will teach "submodule.propagateBranches" to "git submodule
          update", making this necessary.
      
          Propagate "submodule.propagateBranches" to child processes by adding a
     @@ cache.h: static inline enum object_type object_type(unsigned int mode)
      
       ## repo-settings.c ##
      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     - 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
     - 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
     - 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
     -+	repo_cfg_bool(r, "submodule.propagateBranches", &r->settings.submodule_propagate_branches, 0);
     - 
     - 	/*
     --	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
     --	 * either it *or* the config sets
     --	 * r->settings.core_multi_pack_index if true. We don't take
     --	 * the environment variable if it exists (even if false) over
     --	 * any config, as in most other cases.
     -+	 * Boolean settings from config and environment variables. Only
     -+	 * take the environment variable if it is true, otherwise, use
     -+	 * the config.
     - 	 */
       	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
       		r->settings.core_multi_pack_index = 1;
     -+	if (git_env_bool(GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT, 0))
     -+		r->settings.submodule_propagate_branches = 1;
       
     ++	/*
     ++	 * If the environment variable is set, assume that it came from the
     ++	 * superproject and ignore the config.
     ++	 */
     ++	r->settings.submodule_propagate_branches =
     ++		git_env_bool(GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT, -1);
     ++	if (r->settings.submodule_propagate_branches == -1)
     ++		repo_cfg_bool(r, "submodule.propagateBranches",
     ++			      &r->settings.submodule_propagate_branches, 0);
     ++
       	/*
       	 * Non-boolean config
     + 	 */
      
       ## repository.h ##
      @@ repository.h: struct repo_settings {
 -:  ----------- > 3:  a4056e200ed submodule--helper clone: create named branch
 3:  d8a2faf9ce7 = 4:  affd0e24e1d t5617: drop references to remote-tracking branches
 4:  eab40dcb296 ! 5:  6f769cb80ad submodule: return target of submodule symref
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
      -	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
      +	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
      +				     &update_data->suboid, NULL))
     - 		die(_("Unable to find current revision in submodule path '%s'"),
     - 			update_data->displaypath);
     + 		return die_message(_("Unable to find current revision in submodule path '%s'"),
     + 				   update_data->displaypath);
       
      @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
     - 				    update_data->sm_path);
     + 						   update_data->sm_path);
       		}
       
      -		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
      +		if (resolve_gitlink_ref(update_data->sm_path, remote_ref,
      +					&update_data->oid, NULL))
     - 			die(_("Unable to find %s revision in submodule path '%s'"),
     - 			    remote_ref, update_data->sm_path);
     + 			return die_message(_("Unable to find %s revision in submodule path '%s'"),
     + 					   remote_ref, update_data->sm_path);
       
      @@ builtin/submodule--helper.c: static void die_on_repo_without_commits(const char *path)
       	strbuf_addstr(&sb, path);
     @@ refs.c: const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
       
       int resolve_gitlink_ref(const char *submodule, const char *refname,
      -			struct object_id *oid)
     -+			struct object_id *oid, const char **referent_out)
     ++			struct object_id *oid, const char **target_out)
       {
       	struct ref_store *refs;
       	int flags;
     -+	const char *referent;
     ++	const char *target;
       
       	refs = get_submodule_ref_store(submodule);
       
     @@ refs.c: const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
      -
      -	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
      -	    is_null_oid(oid))
     -+	referent = refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags);
     -+	if (!referent || is_null_oid(oid))
     ++	target = refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags);
     ++	if (!target || is_null_oid(oid))
       		return -1;
     -+	if (referent_out)
     -+		*referent_out = referent;
     ++	if (target_out)
     ++		*target_out = target;
       	return 0;
       }
       
     @@ refs.h: int peel_iterated_oid(const struct object_id *base, struct object_id *pe
        * successful, return 0 and set oid to the name of the object;
        * otherwise, return a non-zero value.
      + *
     -+ * FIXME: Return "referent" just like refs_resolve_ref_unsafe(). This will be
     ++ * FIXME: Return "target" just like refs_resolve_ref_unsafe(). This will be
      + * safe to do once we merge resolve_gitlink_ref() into master.
        */
       int resolve_gitlink_ref(const char *submodule, const char *refname,
      -			struct object_id *oid);
     -+			struct object_id *oid, const char **referent);
     ++			struct object_id *oid, const char **target);
       
       /*
        * Return true iff abbrev_name is a possible abbreviation for
 5:  513d18e56d3 ! 6:  abdfa888ff5 submodule--helper: refactor up-to-date criterion
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    submodule--helper: refactor up-to-date criterion
     +    submodule update: refactor update targets
      
     -    Refactor builtin/submodule--helper.c:update_submodule() to check if the
     -    submodule is up to date using a variable instead of checking the oids
     -    directly. In a subsequent commit, we will expand the definition of "up
     -    to date" to include checked out branches.
     +    Refactor two "git submodule update" code locations so that they no
     +    longer refer to oids directly. This shrinks the next commit's diff,
     +    where this code will need to handle branches.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## builtin/submodule--helper.c ##
     -@@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
     +@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet,
     + static int run_update_command(const struct update_data *ud, int subforce)
     + {
     + 	struct child_process cp = CHILD_PROCESS_INIT;
     +-	char *oid = oid_to_hex(&ud->oid);
     ++	const char *update_target = oid_to_hex(&ud->oid);;
     + 	int ret;
     + 
     + 	switch (ud->update_strategy.type) {
     +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
     + 		BUG("unexpected update strategy type: %d",
     + 		    ud->update_strategy.type);
     + 	}
     +-	strvec_push(&cp.args, oid);
     ++	strvec_push(&cp.args, update_target);
     + 
     + 	cp.dir = ud->sm_path;
     + 	prepare_submodule_repo_env(&cp.env);
     +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
     + 		switch (ud->update_strategy.type) {
     + 		case SM_UPDATE_CHECKOUT:
     + 			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
     +-				    oid, ud->displaypath);
     ++				    update_target, ud->displaypath);
     + 			/* No "ret" assignment, use "git checkout"'s */
     + 			break;
     + 		case SM_UPDATE_REBASE:
     + 			ret = die_message(_("Unable to rebase '%s' in submodule path '%s'"),
     +-					  oid, ud->displaypath);
     ++					  update_target, ud->displaypath);
     + 			break;
     + 		case SM_UPDATE_MERGE:
     + 			ret = die_message(_("Unable to merge '%s' in submodule path '%s'"),
     +-					  oid, ud->displaypath);
     ++					  update_target, ud->displaypath);
     + 			break;
     + 		case SM_UPDATE_COMMAND:
     + 			ret = die_message(_("Execution of '%s %s' failed in submodule path '%s'"),
     +-					  ud->update_strategy.command, oid, ud->displaypath);
     ++					  ud->update_strategy.command, update_target, ud->displaypath);
     + 			break;
     + 		default:
     + 			BUG("unexpected update strategy type: %d",
     +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
     + 	switch (ud->update_strategy.type) {
     + 	case SM_UPDATE_CHECKOUT:
     + 		printf(_("Submodule path '%s': checked out '%s'\n"),
     +-		       ud->displaypath, oid);
     ++		       ud->displaypath, update_target);
     + 		break;
     + 	case SM_UPDATE_REBASE:
     + 		printf(_("Submodule path '%s': rebased into '%s'\n"),
     +-		       ud->displaypath, oid);
     ++		       ud->displaypath, update_target);
     + 		break;
     + 	case SM_UPDATE_MERGE:
     + 		printf(_("Submodule path '%s': merged in '%s'\n"),
     +-		       ud->displaypath, oid);
     ++		       ud->displaypath, update_target);
     + 		break;
     + 	case SM_UPDATE_COMMAND:
     + 		printf(_("Submodule path '%s': '%s %s'\n"),
     +-		       ud->displaypath, ud->update_strategy.command, oid);
     ++		       ud->displaypath, ud->update_strategy.command, update_target);
     + 		break;
     + 	default:
     + 		BUG("unexpected update strategy type: %d",
     +@@ builtin/submodule--helper.c: static void update_data_to_args(const struct update_data *update_data,
       
       static int update_submodule(struct update_data *update_data)
       {
      +	int submodule_up_to_date;
     -+
     - 	ensure_core_worktree(update_data->sm_path);
     + 	int ret;
       
     - 	update_data->displaypath = get_submodule_displaypath(
     + 	ret = determine_submodule_update_strategy(the_repository,
      @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
       		free(remote_ref);
       	}
       
     --	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
     +-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
      +	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
     -+	if (!submodule_up_to_date || update_data->force)
     - 		if (run_update_procedure(update_data))
     - 			return 1;
     - 
     ++	if (!submodule_up_to_date || update_data->force) {
     + 		ret = run_update_procedure(update_data);
     + 		if (ret)
     + 			return ret;
 6:  6f7f2f9a3f1 ! 7:  3f98b0d1739 clone, submodule update: check out branches
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    clone, submodule update: check out branches
     +    clone, submodule update: create and check out branches
      
     -    Teach "git submodule update" to update submodules by creating and
     -    checking out the current superproject branch when
     -    "submodule.propagateBranches=true". "git clone --recurse-submodules"
     -    also learns this trick because it is implemented with "git submodule
     -    update --recursive".
     +    Teach "git submodule update" to:
      
     -    With "submodule.propagateBranches=true", submodules are cloned with
     -    "--detach" so that they do not contain branches from their upstream.
     -    This prevents conflicts between branch names from the superproject and
     -    the branch names from the submodule's upstream. Arguably, "--detach"
     -    should also be the default for "submodule.propagateBranches=false"
     -    since it doesn't make sense to create a submodule branch when the
     -    submodule is always expected to be in detached HEAD. But, to be
     -    conservative, this commit does not change the behavior of
     -    "submodule.propagateBranches=false".
     +    - create the branch with the same name as the current superproject
     +      branch when cloning a submodule
     +    - check out that branch (instead of the commit OID) when updating
     +      the submodule worktree
      
     -    "git submodule update" tries to create the branch as long as it is not
     -    currently checked out, thus it will fail if the submodule has the
     -    branch, but it is not checked out. This is fine because the main purpose
     -    of "git submodule update" is to clone new submodules (which have no
     -    branches, and will never have this problem). "git checkout" with
     -    "submodule.propagateBranches" will cover the use case of recursively
     -    checking out an existing branch.
     +    when submodule branching is enabled (submodule.propagateBranches = true)
     +    on the superproject and a branch is checked out. "git clone
     +    --recurse-submodules" also learns this trick because it is implemented
     +    with "git submodule update --recursive".
     +
     +    This approach of checking out the branch will not result in a dirty
     +    worktree for freshly cloned submodules because we can ensure that the
     +    submodule branch points to the superproject gitlink. In other cases, it
     +    does not work as well, but we can handle them incrementally:
     +
     +    - "git pull --recurse-submodules" merges the superproject tree (without
     +      updating the submodule branches), and runs "git submodule update" to
     +      update the worktrees, so it is almost guaranteed to result in a dirty
     +      worktree.
     +
     +      The implementation of "git pull --recurse-submodules" is likely to
     +      change drastically as submodule.propagateBranches work progresses
     +      (e.g. "git merge" learns to recurse in to submodules), and we may be
     +      able to replace the "git submodule update" invocation, or teach it new
     +      tricks that make the update behave well.
     +
     +    - The user might make changes to the submodule branch without committing
     +      them back to superproject. This is primarily affects "git checkout
     +      --recurse-submodules", since that is the primary way of switching away
     +      from a branch and leaving behind WIP (as opposed to "git submodule
     +      update", which is run post-checkout).
     +
     +      In a future series, "git checkout --recurse-submodules" will learn to
     +      consider submodule branches. We can introduce appropriate guardrails
     +      then, e.g. requiring that the superproject working tree is not dirty
     +      before switching away.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## builtin/submodule--helper.c ##
     -@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
     - 			strvec_push(&cp.args, clone_data->single_branch ?
     - 				    "--single-branch" :
     - 				    "--no-single-branch");
     -+		if (the_repository->settings.submodule_propagate_branches)
     -+			strvec_push(&cp.args, "--detach");
     -+
     - 
     - 		strvec_push(&cp.args, "--");
     - 		strvec_push(&cp.args, clone_data->url);
     -@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
     - 	if (error_strategy)
     - 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
     - 				       error_strategy);
     -+	if (the_repository->settings.submodule_propagate_branches)
     -+		git_config_set_in_file(p, "submodule.propagateBranches",
     -+				       "true");
     - 
     - 	free(sm_alternate);
     - 	free(error_strategy);
     -@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
     - 	memset(&filter_options, 0, sizeof(filter_options));
     - 	argc = parse_options(argc, argv, prefix, module_clone_options,
     - 			     git_submodule_helper_usage, 0);
     -+	prepare_repo_settings(the_repository);
     - 
     - 	clone_data.dissociate = !!dissociate;
     - 	clone_data.quiet = !!quiet;
     -@@ builtin/submodule--helper.c: struct submodule_update_clone {
     +@@ builtin/submodule--helper.c: static void submodule_update_clone_release(struct submodule_update_clone *suc)
       struct update_data {
       	const char *prefix;
     - 	const char *displaypath;
     + 	char *displaypath;
      +	const char *super_branch;
       	enum submodule_update_type update_default;
       	struct object_id suboid;
       	struct string_list references;
     -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
     - 		strvec_pushl(&cp.args, "checkout", "-q", NULL);
     - 		if (subforce)
     - 			strvec_push(&cp.args, "-f");
     -+		if (ud->super_branch)
     -+			strvec_pushl(&cp.args, "-b", ud->super_branch, NULL);
     - 		break;
     - 	case SM_UPDATE_REBASE:
     +@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
     + 		strvec_push(&child->args, suc->update_data->single_branch ?
     + 					      "--single-branch" :
     + 					      "--no-single-branch");
     ++	if (ud->super_branch) {
     ++		strvec_pushf(&child->args, "--branch=%s", ud->super_branch);
     ++		strvec_pushf(&child->args, "--branch-oid=%s", oid_to_hex(&ce->oid));
     ++	}
     + 
     + cleanup:
     + 	free(displaypath);
     +@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet,
     + static int run_update_command(const struct update_data *ud, int subforce)
     + {
     + 	struct child_process cp = CHILD_PROCESS_INIT;
     +-	const char *update_target = oid_to_hex(&ud->oid);;
     ++	const char *update_target;
     + 	int ret;
     + 
     ++	if (ud->update_strategy.type == SM_UPDATE_CHECKOUT &&
     ++	    ud->super_branch)
     ++		update_target = ud->super_branch;
     ++	else
     ++		update_target = oid_to_hex(&ud->oid);
     ++
     + 	switch (ud->update_strategy.type) {
     + 	case SM_UPDATE_CHECKOUT:
       		cp.git_cmd = 1;
     -@@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
     - static int update_submodule(struct update_data *update_data)
     +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
       {
       	int submodule_up_to_date;
     -+	const char *submodule_head = NULL;
     - 
     - 	ensure_core_worktree(update_data->sm_path);
     + 	int ret;
     ++	const char *submodule_head = "HEAD";
       
     + 	ret = determine_submodule_update_strategy(the_repository,
     + 						  update_data->just_cloned,
      @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
       	if (update_data->just_cloned)
       		oidcpy(&update_data->suboid, null_oid());
       	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
      -				     &update_data->suboid, NULL))
      +				     &update_data->suboid, &submodule_head))
     - 		die(_("Unable to find current revision in submodule path '%s'"),
     - 			update_data->displaypath);
     + 		return die_message(_("Unable to find current revision in submodule path '%s'"),
     + 				   update_data->displaypath);
       
      @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
       		free(remote_ref);
       	}
       
      -	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
     -+	if (update_data->super_branch &&
     -+	    submodule_head &&
     -+	    !skip_prefix(submodule_head, "refs/heads/", &submodule_head))
     ++	if (!update_data->super_branch)
     ++		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
     ++	else if (skip_prefix(submodule_head, "refs/heads/", &submodule_head))
      +		submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);
     ++	/* submodule_branch is "HEAD"; the submodule is in detached HEAD */
      +	else
     -+		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
     ++		submodule_up_to_date = 0;
      +
     - 	if (!submodule_up_to_date || update_data->force)
     - 		if (run_update_procedure(update_data))
     - 			return 1;
     + 	if (!submodule_up_to_date || update_data->force) {
     + 		ret = run_update_procedure(update_data);
     + 		if (ret)
      @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
     - 		goto cleanup;
     - 	}
     + 	int i, ret = 0;
     + 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
       
      +	if (the_repository->settings.submodule_propagate_branches) {
      +		struct branch *current_branch = branch_get(NULL);
     @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
      +			update_data->super_branch = current_branch->name;
      +	}
      +
     - 	for (i = 0; i < suc.update_clone_nr; i++) {
     - 		struct update_clone_data ucd = suc.update_clone[i];
     - 
     + 	suc.update_data = update_data;
     + 	run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
     + 				   update_clone_start_failure,
      @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
     - 	memset(&filter_options, 0, sizeof(filter_options));
     + 
       	argc = parse_options(argc, argv, prefix, module_update_options,
       			     git_submodule_helper_usage, 0);
      +	prepare_repo_settings(the_repository);
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
       		opt.init = 1;
      
       ## t/t5617-clone-submodules.sh ##
     -@@ t/t5617-clone-submodules.sh: pwd=$(pwd)
     - test_expect_success 'setup' '
     +@@ t/t5617-clone-submodules.sh: test_expect_success 'setup' '
     + 	git config --global protocol.file.allow always &&
       	git checkout -b main &&
       	test_commit commit1 &&
      +	mkdir subsub &&
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --recursive s
       	test_cmp expect.err actual.err
       '
       
     -+test_expect_success 'submodule update with submodule.propagateBranches checks out branches' '
     -+	test_when_finished "rm -fr top-cloned" &&
     -+	cp -r top-clean top-cloned &&
     -+
     -+	# Create a new upstream submodule
     -+	git init middle2 &&
     -+	test_commit -C middle2 "middle2" &&
     -+	git -C top submodule add ../middle2 middle2 &&
     -+	git -C top commit -m "add middle2" &&
     -+
     -+	git -C top-cloned checkout -b "new-branch" &&
     -+	git -C top-cloned pull origin main &&
     -+	test_config -C top-cloned submodule.propagateBranches true &&
     -+	git -C top-cloned submodule update --recursive &&
     -+
     -+	for REPO in "top-cloned/middle2" "top-cloned/middle" "top-cloned/middle/bottom"
     -+	do
     -+	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
     -+	    test $HEAD_BRANCH = "refs/heads/new-branch" || return 1
     -+	done
     ++test_expect_success 'setup superproject with submodule.propagateBranches' '
     ++	git init sub1 &&
     ++	test_commit -C sub1 "sub1" &&
     ++	git init branch-super &&
     ++	git -C branch-super submodule add ../sub1 sub1 &&
     ++	git -C branch-super commit -m "super" &&
     ++
     ++	# Clone into a clean repo that we can cp around
     ++	git clone --recurse-submodules \
     ++		-c submodule.propagateBranches=true \
     ++		branch-super branch-super-clean &&
     ++	git -C branch-super-clean config submodule.propagateBranches true &&
     ++
     ++	# Create an upstream submodule not in the clone
     ++	git init sub2 &&
     ++	test_commit -C sub2 "sub2" &&
     ++	git -C branch-super submodule add ../sub2 sub2 &&
     ++	git -C branch-super commit -m "add sub2"
     ++'
     ++
     ++test_expect_success 'submodule.propagateBranches - detached HEAD' '
     ++	test_when_finished "rm -fr branch-super-cloned" &&
     ++	cp -r branch-super-clean branch-super-cloned &&
     ++
     ++	git -C branch-super-cloned checkout --detach &&
     ++	git -C branch-super-cloned pull origin main &&
     ++	git -C branch-super-cloned submodule update &&
     ++
     ++	# sub2 should be in detached HEAD
     ++	git -C branch-super-cloned/sub2 rev-parse --verify HEAD &&
     ++	test_must_fail git -C branch-super-cloned/sub2 symbolic-ref HEAD
     ++'
     ++
     ++test_expect_success 'submodule.propagateBranches - branch checked out' '
     ++	test_when_finished "rm -fr branch-super-cloned" &&
     ++	cp -r branch-super-clean branch-super-cloned &&
     ++
     ++	git -C branch-super-cloned branch --recurse-submodules new-branch &&
     ++	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
     ++	git -C branch-super-cloned pull origin main &&
     ++	git -C branch-super-cloned submodule update &&
     ++
     ++	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
     ++	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
     ++	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
     ++	test $HEAD_BRANCH2 = "refs/heads/new-branch"
     ++'
     ++
     ++test_expect_success 'submodule.propagateBranches - other branch checked out' '
     ++	test_when_finished "rm -fr branch-super-cloned" &&
     ++	cp -r branch-super-clean branch-super-cloned &&
     ++
     ++	git -C branch-super-cloned branch --recurse-submodules new-branch &&
     ++	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
     ++	git -C branch-super-cloned/sub1 checkout -b other-branch &&
     ++	git -C branch-super-cloned pull origin main &&
     ++	git -C branch-super-cloned submodule update &&
     ++
     ++	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
     ++	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
     ++	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
     ++	test $HEAD_BRANCH2 = "refs/heads/new-branch"
      +'
      +
       test_done

-- 
gitgitgadget

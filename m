Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D34ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJ1UPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1UPC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B420BFB
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:14:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bp11so7964395wrb.9
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mwGBExJm+WsnWJAVXn6O6Oozcds4f6KxAUSJtsTHTk=;
        b=EwRN2vrQ4OCAFyIsKdeLVWe1FEM4dWkHZVqC2FpIp03gmkxZiF8Qce+eKag5eamPha
         BSYmz4Npu3K06UsEW3FWN44VGkkfu62LNROUV4UsBRw9yabHSD4xhfxpmagbhSIjHPWe
         kge0t4X9p9KBcymbolDcJ48QwL3fjXNcSuzzy752aBeDMT+9Drpip/MENvmMMhmhfXmt
         XLUgkOc9QnHilIkDk7cV3ZDu+mZPS4Lg1Ej3GfNuHezw0bVsIYReK+iXQzZH0FV3YSt2
         /PmuZR7hJgXWn1cO+L5pbWsX8Of3S787+kwOJXwKlwODwkLUpXHYj65AMgIKuqCpN6YV
         Irfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mwGBExJm+WsnWJAVXn6O6Oozcds4f6KxAUSJtsTHTk=;
        b=apIPhtvy/nWzEwkvSLnUnDDhxcW1XESOC9nDnNVNvpC3ezYrBUZDhn/ix/EJqCS9WJ
         0ZVCbsriOHFl/wD8/EmefXKnSC5RiZ4lAYLUfvpfl51Z6p/Id2ZMWAgSpKX06LJncBYG
         1x/Y5XcGl93PlHRboPVfLIEvi1tRoPiJlhx1SjBvkkOZ9cGtuO1FeabcOye3+gGzIqLw
         tATDlojry/3A+EYVPRAObJ2hWN3Sv2ciyIGsOytqrFBalt39wPVhs5B28+g1g4P5wggL
         JZL3dBjld/aUyxErxEMsloy0D3MwU4BzUVFrwsAHDDeZlgu//kAIlVejW0LdRHGyP/FG
         CYyg==
X-Gm-Message-State: ACrzQf2LNq7kcybnNEJs8gxlWbbRmneWBYjykru55ZE5aMhVJBO46Y2g
        rxvUF1vowIMaEZEKClpp+ms7/mTOwaA=
X-Google-Smtp-Source: AMsMyM5UtbRdOEfPri8MKlcrQCOSMvBkWP5gBq9+NK7V/maOWSampYNMET2b1SFNKhEy8UGalmKKeA==
X-Received: by 2002:adf:d23a:0:b0:236:467e:a3bc with SMTP id k26-20020adfd23a000000b00236467ea3bcmr587581wrh.542.1666988097922;
        Fri, 28 Oct 2022 13:14:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b003a531c7aa66sm5727898wmo.1.2022.10.28.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:14:57 -0700 (PDT)
Message-Id: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:48 +0000
Subject: [PATCH v3 0/8] clone, submodule update: check out submodule branches
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

This version has relatively few changes, and should address all of
Jonathan's comments (thanks!).

In the final patch, submodule_head is now initialized to NULL [1], which
means that in the "just_cloned" case, it remains NULL and we have to be
careful not to call skip_prefix() on it. A new patch (7/8), prepares for
this and also cleans up "struct update_data" a little bit.

= Description

This series teaches "git clone --recurse-submodules" and "git submodule
update" to understand "submodule.propagateBranches" (see Further Reading for
context), i.e. if the superproject has a branch checked out and a submodule
is cloned, the submodule will have the same branch checked out.

To do this, "git submodule update" checks if "submodule.propagateBranches"
is true. If so, and if the superproject has the branch 'topic' checked out,
then:

 * Submodules are cloned without their upstream branches
 * The 'topic' branch is created in the submodule
 * The submodule is updated via "git checkout topic" instead of checking out
   the gitlink's OID.

Since "git clone --recurse-submodules" is implemented using "git submodule
update", it also learns to create and check out the branch in submodules.

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
   subject of some WIP in [2]. That topic has stalled, but I don't mind
   restarting it if others prefer that.

[1]
https://lore.kernel.org/git/20221025175628.913542-1-jonathantanmy@google.com
[2]
https://lore.kernel.org/git/20220310004423.2627181-1-emilyshaffer@google.com/

= Patch organization

 * Patch 1/8 adds "--detach" to "git clone"
 * Patch 2/8 creates the environment variable and repository setting for
   "submodule.propagateBranches"
 * Patch 3/8 adds a new "--branch" option to "git submodule clone", which
   makes it create a named branch.
 * Patches 4-7/8 are prep work, and 8/8 adds the actual
   "submodule.propagateBranches" behavior

= Series history

Changes in v3:

 * Patch 3: Improve error messages for "git submodule--helper clone
   --branch"
 * Patch 7 (new): Remove update_data.suboid to make it easier to initialize
   submodule_head to NULL in the next patch.
 * Patch 8: Split tests into two parts - "newly cloned" and "already
   cloned", and test various conditions in already cloned submodules.
 * Assorted commit message and comment changes.
 * Reformat with "make style" (sorry for not doing this sooner..)

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

 * Patch 8 notes that for already cloned submodules, the branch may not
   point to the same OID as the superproject gitlink, and it may not even
   exist. This will be addressed in a more comprehensive manner when we add
   support for checking out branches with "git checkout
   --recurse-submodules".

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

Glen Choo (8):
  clone: teach --detach option
  repo-settings: add submodule_propagate_branches
  submodule--helper clone: create named branch
  t5617: drop references to remote-tracking branches
  submodule: return target of submodule symref
  submodule update: refactor update targets
  submodule--helper: remove update_data.suboid
  clone, submodule update: create and check out branches

 Documentation/git-clone.txt                   |   8 +-
 builtin/branch.c                              |  11 +-
 builtin/clone.c                               |  12 +-
 builtin/submodule--helper.c                   | 102 +++++++++---
 builtin/update-index.c                        |   4 +-
 cache.h                                       |   1 +
 combine-diff.c                                |   3 +-
 diff-lib.c                                    |   2 +-
 dir.c                                         |   2 +-
 object-file.c                                 |   2 +-
 read-cache.c                                  |   4 +-
 refs.c                                        |  10 +-
 refs.h                                        |   5 +-
 repo-settings.c                               |  13 ++
 repository.h                                  |   1 +
 submodule.c                                   |   2 +
 t/t5601-clone.sh                              |  22 +++
 ...es-remote.sh => t5617-clone-submodules.sh} |  40 ++++-
 t/t7406-submodule-update.sh                   | 156 ++++++++++++++++++
 unpack-trees.c                                |   3 +-
 20 files changed, 357 insertions(+), 46 deletions(-)
 rename t/{t5617-clone-submodules-remote.sh => t5617-clone-submodules.sh} (70%)


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1321%2Fchooglen%2Fsubmodule%2Fclone-recursive-with-branch-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1321/chooglen/submodule/clone-recursive-with-branch-v3
Pull-Request: https://github.com/git/git/pull/1321

Range-diff vs v2:

 1:  432bc7cb3a4 = 1:  432bc7cb3a4 clone: teach --detach option
 2:  20499c62065 ! 2:  06d7e15e830 repo-settings: add submodule_propagate_branches
     @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
       		r->settings.core_multi_pack_index = 1;
       
      +	/*
     -+	 * If the environment variable is set, assume that it came from the
     -+	 * superproject and ignore the config.
     ++	 * If the environment variable is set, assume that it was set by an
     ++	 * invocation of git running in a superproject with
     ++	 * submodule.propagateBranches set and that is recursing into this repo
     ++	 * as a submodule. Therefore, we should ignore whatever is set in this
     ++	 * repo's config.
      +	 */
      +	r->settings.submodule_propagate_branches =
      +		git_env_bool(GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT, -1);
 3:  a4056e200ed ! 3:  5a24d7e9255 submodule--helper clone: create named branch
     @@ Commit message
          branching is enabled, otherwise the named branch might conflict with the
          branch from the submodule remote's HEAD.
      
     -    These flags will be used by `git submodule update` in a later commit.
     -    "git submodule add" (which also invokes "git submodule--helper clone")
     -    should also do something similar when submodule branching is enabled,
     -    but this is left for a later series.
     +    This functionality will be tested in a later commit where "git submodule
     +    update" uses it to create and check out the correct branch when
     +    submodule branching is enabled. "git submodule add" (which also invokes
     +    "git submodule--helper clone") should also do something similar when
     +    submodule branching is enabled, but this is left for a later series.
      
          Arguably, "--detach" should also be the default for
          "submodule.propagateBranches=false" since it doesn't make sense to
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv
       	clone_data.dissociate = !!dissociate;
       	clone_data.quiet = !!quiet;
      @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
     - 	clone_data.require_init = !!require_init;
     - 	clone_data.filter_options = &filter_options;
     - 
     --	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
     -+	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path)
     -+	    || (!!clone_data.branch != !!clone_data.branch_oid))
       		usage_with_options(git_submodule_helper_usage,
       				   module_clone_options);
     + 
     ++	if (!!clone_data.branch != !!clone_data.branch_oid)
     ++		BUG("--branch and --branch-oid must be set/unset together");
      +	if ((clone_data.branch &&
      +	     !the_repository->settings.submodule_propagate_branches))
      +		BUG("--branch is only expected with submodule.propagateBranches");
     - 
     ++
       	clone_submodule(&clone_data, &reference);
       	list_objects_filter_release(&filter_options);
     + 	string_list_clear(&reference, 1);
 4:  affd0e24e1d = 4:  3a08f2ab776 t5617: drop references to remote-tracking branches
 5:  6f769cb80ad = 5:  bd8ffd7cde2 submodule: return target of submodule symref
 6:  abdfa888ff5 ! 6:  df1f7225f49 submodule update: refactor update targets
     @@ Commit message
          submodule update: refactor update targets
      
          Refactor two "git submodule update" code locations so that they no
     -    longer refer to oids directly. This shrinks the next commit's diff,
     +    longer refer to oids directly. This shrinks a subsequent commit's diff,
          where this code will need to handle branches.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
 -:  ----------- > 7:  4e402b67145 submodule--helper: remove update_data.suboid
 7:  3f98b0d1739 ! 8:  7cdd6c4184d clone, submodule update: create and check out branches
     @@ Commit message
          submodule branch points to the superproject gitlink. In other cases, it
          does not work as well, but we can handle them incrementally:
      
     -    - "git pull --recurse-submodules" merges the superproject tree (without
     -      updating the submodule branches), and runs "git submodule update" to
     -      update the worktrees, so it is almost guaranteed to result in a dirty
     -      worktree.
     +    - "git pull --recurse-submodules" merges the superproject tree,
     +      (changing the gitlink without updating the submodule branches), and
     +      runs "git submodule update" to update the worktrees, so it is almost
     +      guaranteed to result in a dirty worktree.
      
            The implementation of "git pull --recurse-submodules" is likely to
            change drastically as submodule.propagateBranches work progresses
     @@ builtin/submodule--helper.c: static void submodule_update_clone_release(struct s
       	char *displaypath;
      +	const char *super_branch;
       	enum submodule_update_type update_default;
     - 	struct object_id suboid;
       	struct string_list references;
     + 	struct submodule_update_strategy update_strategy;
      @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
       		strvec_push(&child->args, suc->update_data->single_branch ?
       					      "--single-branch" :
       					      "--no-single-branch");
      +	if (ud->super_branch) {
      +		strvec_pushf(&child->args, "--branch=%s", ud->super_branch);
     -+		strvec_pushf(&child->args, "--branch-oid=%s", oid_to_hex(&ce->oid));
     ++		strvec_pushf(&child->args, "--branch-oid=%s",
     ++			     oid_to_hex(&ce->oid));
      +	}
       
       cleanup:
     @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
      +	const char *update_target;
       	int ret;
       
     -+	if (ud->update_strategy.type == SM_UPDATE_CHECKOUT &&
     -+	    ud->super_branch)
     ++	if (ud->update_strategy.type == SM_UPDATE_CHECKOUT && ud->super_branch)
      +		update_target = ud->super_branch;
      +	else
      +		update_target = oid_to_hex(&ud->oid);
     @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
       	case SM_UPDATE_CHECKOUT:
       		cp.git_cmd = 1;
      @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
     - {
       	int submodule_up_to_date;
       	int ret;
     -+	const char *submodule_head = "HEAD";
     + 	struct object_id suboid;
     ++	const char *submodule_head = NULL;
       
       	ret = determine_submodule_update_strategy(the_repository,
       						  update_data->just_cloned,
      @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
     - 	if (update_data->just_cloned)
     - 		oidcpy(&update_data->suboid, null_oid());
     - 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
     --				     &update_data->suboid, NULL))
     -+				     &update_data->suboid, &submodule_head))
     + 		return ret;
     + 
     + 	if (!update_data->just_cloned &&
     +-	    resolve_gitlink_ref(update_data->sm_path, "HEAD", &suboid, NULL))
     ++	    resolve_gitlink_ref(update_data->sm_path, "HEAD", &suboid,
     ++				&submodule_head))
       		return die_message(_("Unable to find current revision in submodule path '%s'"),
       				   update_data->displaypath);
       
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
       		free(remote_ref);
       	}
       
     --	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
     -+	if (!update_data->super_branch)
     -+		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
     -+	else if (skip_prefix(submodule_head, "refs/heads/", &submodule_head))
     -+		submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);
     -+	/* submodule_branch is "HEAD"; the submodule is in detached HEAD */
     -+	else
     +-	submodule_up_to_date = !update_data->just_cloned &&
     +-		oideq(&update_data->oid, &suboid);
     ++	if (update_data->just_cloned)
      +		submodule_up_to_date = 0;
     ++	else if (update_data->super_branch)
     ++		/* Check that the submodule's HEAD points to super_branch. */
     ++		submodule_up_to_date =
     ++			skip_prefix(submodule_head, "refs/heads/",
     ++				    &submodule_head) &&
     ++			!strcmp(update_data->super_branch, submodule_head);
     ++	else
     ++		submodule_up_to_date = oideq(&update_data->oid, &suboid);
      +
       	if (!submodule_up_to_date || update_data->force) {
       		ret = run_update_procedure(update_data);
     @@ t/t5617-clone-submodules.sh: test_expect_success '--no-also-filter-submodules ov
       '
       
      +test_expect_success 'submodule.propagateBranches checks out branches at correct commits' '
     -+	git -C sub checkout -b not-main &&
     -+	git -C subsub checkout -b not-main &&
     ++	test_when_finished "git checkout main" &&
     ++
     ++	git checkout -b checked-out &&
     ++	git -C sub checkout -b not-in-clone &&
     ++	git -C subsub checkout -b not-in-clone &&
      +	git clone --recurse-submodules \
     ++		--branch checked-out \
      +		-c submodule.propagateBranches=true \
      +		"file://$pwd/." super_clone4 &&
      +
     -+	# Assert that each repo is pointing to "main"
     ++	# Assert that each repo is pointing to "checked-out"
      +	for REPO in "super_clone4" "super_clone4/sub" "super_clone4/sub/subsub"
      +	do
      +	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
     -+	    test $HEAD_BRANCH = "refs/heads/main" || return 1
     ++	    test $HEAD_BRANCH = "refs/heads/checked-out" || return 1
      +	done &&
      +
      +	# Assert that the submodule branches are pointing to the right revs
      +	EXPECT_SUB_OID="$(git -C super_clone4 rev-parse :sub)" &&
     -+	ACTUAL_SUB_OID="$(git -C super_clone4/sub rev-parse refs/heads/main)" &&
     ++	ACTUAL_SUB_OID="$(git -C super_clone4/sub rev-parse refs/heads/checked-out)" &&
      +	test $EXPECT_SUB_OID = $ACTUAL_SUB_OID &&
      +	EXPECT_SUBSUB_OID="$(git -C super_clone4/sub rev-parse :subsub)" &&
     -+	ACTUAL_SUBSUB_OID="$(git -C super_clone4/sub/subsub rev-parse refs/heads/main)" &&
     ++	ACTUAL_SUBSUB_OID="$(git -C super_clone4/sub/subsub rev-parse refs/heads/checked-out)" &&
      +	test $EXPECT_SUBSUB_OID = $ACTUAL_SUBSUB_OID &&
      +
      +	# Assert that the submodules do not have branches from their upstream
     -+	test_must_fail git -C super_clone4/sub rev-parse not-main &&
     -+	test_must_fail git -C super_clone4/sub/subsub rev-parse not-main
     ++	test_must_fail git -C super_clone4/sub rev-parse not-in-clone &&
     ++	test_must_fail git -C super_clone4/sub/subsub rev-parse not-in-clone
      +'
      +
       test_done
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --recursive s
      +		branch-super branch-super-clean &&
      +	git -C branch-super-clean config submodule.propagateBranches true &&
      +
     -+	# Create an upstream submodule not in the clone
     ++	# sub2 will not be in the clone. We will fetch the containing
     ++	# superproject commit and clone sub2 with "git submodule update".
      +	git init sub2 &&
      +	test_commit -C sub2 "sub2" &&
      +	git -C branch-super submodule add ../sub2 sub2 &&
      +	git -C branch-super commit -m "add sub2"
      +'
      +
     -+test_expect_success 'submodule.propagateBranches - detached HEAD' '
     ++test_clean_submodule ()
     ++{
     ++	local negate super_dir sub_dir expect_oid actual_oid &&
     ++	if test "$1" = "!"
     ++	then
     ++		negate=t
     ++		shift
     ++	fi
     ++	super_dir="$1" &&
     ++	sub_dir="$2" &&
     ++	expect_oid="$(git -C "$super_dir" rev-parse ":$sub_dir")" &&
     ++	actual_oid="$(git -C "$super_dir/$sub_dir" rev-parse HEAD)" &&
     ++	if test -n "$negate"
     ++	then
     ++		! test "$expect_oid" = "$actual_oid"
     ++	else
     ++		test "$expect_oid" = "$actual_oid"
     ++	fi
     ++}
     ++
     ++# Test the behavior of a newly cloned submodule
     ++test_expect_success 'branches - newly-cloned submodule, detached HEAD' '
      +	test_when_finished "rm -fr branch-super-cloned" &&
      +	cp -r branch-super-clean branch-super-cloned &&
      +
     -+	git -C branch-super-cloned checkout --detach &&
     -+	git -C branch-super-cloned pull origin main &&
     ++	git -C branch-super-cloned fetch origin main &&
     ++	git -C branch-super-cloned checkout FETCH_HEAD &&
     ++	git -C branch-super-cloned/sub1 checkout --detach &&
      +	git -C branch-super-cloned submodule update &&
      +
     -+	# sub2 should be in detached HEAD
     ++	# sub1 and sub2 should be in detached HEAD
     ++	git -C branch-super-cloned/sub1 rev-parse --verify HEAD &&
     ++	test_must_fail git -C branch-super-cloned/sub1 symbolic-ref HEAD &&
     ++	test_clean_submodule branch-super-cloned sub1 &&
      +	git -C branch-super-cloned/sub2 rev-parse --verify HEAD &&
     -+	test_must_fail git -C branch-super-cloned/sub2 symbolic-ref HEAD
     ++	test_must_fail git -C branch-super-cloned/sub2 symbolic-ref HEAD &&
     ++	test_clean_submodule branch-super-cloned sub2
     ++'
     ++
     ++test_expect_success 'branches - newly-cloned submodule, branch checked out' '
     ++	test_when_finished "rm -fr branch-super-cloned" &&
     ++	cp -r branch-super-clean branch-super-cloned &&
     ++
     ++	git -C branch-super-cloned fetch origin main &&
     ++	git -C branch-super-cloned checkout FETCH_HEAD &&
     ++	git -C branch-super-cloned branch new-branch &&
     ++	git -C branch-super-cloned checkout new-branch &&
     ++	git -C branch-super-cloned/sub1 branch new-branch &&
     ++	git -C branch-super-cloned submodule update &&
     ++
     ++	# Ignore sub1, we will test it later.
     ++	# sub2 should check out the branch
     ++	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
     ++	test $HEAD_BRANCH2 = "refs/heads/new-branch" &&
     ++	test_clean_submodule branch-super-cloned sub2
      +'
      +
     -+test_expect_success 'submodule.propagateBranches - branch checked out' '
     ++# Test the behavior of an already-cloned submodule.
     ++# NEEDSWORK When updating with branches, we always use the branch instead of the
     ++# gitlink's OID. This results in some imperfect behavior:
     ++#
     ++# - If the gitlink's OID disagrees with the branch OID, updating with branches
     ++#   may result in a dirty worktree
     ++# - If the branch does not exist, the update fails.
     ++#
     ++# We will reevaluate when "git checkout --recurse-submodules" supports branches
     ++# For now, just test for this imperfect behavior.
     ++test_expect_success 'branches - correct branch checked out, OIDs agree' '
      +	test_when_finished "rm -fr branch-super-cloned" &&
      +	cp -r branch-super-clean branch-super-cloned &&
      +
      +	git -C branch-super-cloned branch --recurse-submodules new-branch &&
     -+	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
     -+	git -C branch-super-cloned pull origin main &&
     ++	git -C branch-super-cloned checkout new-branch &&
     ++	git -C branch-super-cloned/sub1 checkout new-branch &&
      +	git -C branch-super-cloned submodule update &&
      +
      +	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
      +	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
     -+	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
     -+	test $HEAD_BRANCH2 = "refs/heads/new-branch"
     ++	test_clean_submodule branch-super-cloned sub1
      +'
      +
     -+test_expect_success 'submodule.propagateBranches - other branch checked out' '
     ++test_expect_success 'branches - correct branch checked out, OIDs disagree' '
      +	test_when_finished "rm -fr branch-super-cloned" &&
      +	cp -r branch-super-clean branch-super-cloned &&
      +
      +	git -C branch-super-cloned branch --recurse-submodules new-branch &&
     -+	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
     -+	git -C branch-super-cloned/sub1 checkout -b other-branch &&
     -+	git -C branch-super-cloned pull origin main &&
     ++	git -C branch-super-cloned checkout new-branch &&
     ++	git -C branch-super-cloned/sub1 checkout new-branch &&
     ++	test_commit -C branch-super-cloned/sub1 new-commit &&
      +	git -C branch-super-cloned submodule update &&
      +
      +	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
      +	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
     -+	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
     -+	test $HEAD_BRANCH2 = "refs/heads/new-branch"
     ++	test_clean_submodule ! branch-super-cloned sub1
     ++'
     ++
     ++test_expect_success 'branches - other branch checked out, correct branch exists, OIDs agree' '
     ++	test_when_finished "rm -fr branch-super-cloned" &&
     ++	cp -r branch-super-clean branch-super-cloned &&
     ++
     ++	git -C branch-super-cloned branch --recurse-submodules new-branch &&
     ++	git -C branch-super-cloned checkout new-branch &&
     ++	git -C branch-super-cloned/sub1 checkout main &&
     ++	git -C branch-super-cloned submodule update &&
     ++
     ++	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
     ++	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
     ++	test_clean_submodule branch-super-cloned sub1
     ++'
     ++
     ++test_expect_success 'branches - other branch checked out, correct branch exists, OIDs disagree' '
     ++	test_when_finished "rm -fr branch-super-cloned" &&
     ++	cp -r branch-super-clean branch-super-cloned &&
     ++
     ++	git -C branch-super-cloned branch --recurse-submodules new-branch &&
     ++	git -C branch-super-cloned checkout new-branch &&
     ++	git -C branch-super-cloned/sub1 checkout new-branch &&
     ++	test_commit -C branch-super-cloned/sub1 new-commit &&
     ++	git -C branch-super-cloned/sub1 checkout main &&
     ++	git -C branch-super-cloned submodule update &&
     ++
     ++	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
     ++	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
     ++	test_clean_submodule ! branch-super-cloned sub1
     ++'
     ++
     ++test_expect_success 'branches - other branch checked out, correct branch does not exist' '
     ++	test_when_finished "rm -fr branch-super-cloned" &&
     ++	cp -r branch-super-clean branch-super-cloned &&
     ++
     ++	git -C branch-super-cloned branch new-branch &&
     ++	git -C branch-super-cloned checkout new-branch &&
     ++	test_must_fail git -C branch-super-cloned submodule update
      +'
      +
       test_done

-- 
gitgitgadget

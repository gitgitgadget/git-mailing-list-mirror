Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20101F453
	for <e@80x24.org>; Mon, 15 Oct 2018 22:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJPF5z (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 01:57:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33126 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeJPF5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 01:57:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so23113761wrs.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lqCQwSH3BWanEIoKMO8t63fbKHna2gTxRJ+wtG/alas=;
        b=Xp5jd+oJIrBJDxTjuNIzPAyCS4uY0Pl82/4ri89TtAg7OGaQOMYbVxVlzQZt76hrAy
         3JeHeon06HS2T4U9qss0y8p79MzQv4sCHRH272rgd2UbtZYc8dY3t4VjI6J2uShalnGf
         sf8UWQDB8dbbqnyrWtvamwxGK3h60gX4HFGsaHo0cRsiO+eQvw+7YS9tYxytWIPv898K
         DsBRO9lZ3r+cMk88dVo73p9bR5+GBYj9Ce4EzlaL/ddYCDrnms2a+jwFCbQSk9rRs2ep
         MhvB9fiLdlKHx+QPvUc44eUjQuLdz/Eu49NAcLiWGDwLCCW0RQGywFNl3MtVP8WORFIB
         RVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqCQwSH3BWanEIoKMO8t63fbKHna2gTxRJ+wtG/alas=;
        b=P44UuDaxzcyyjBU6V/aXi3zy6H06/HDfTWAnFuBxZ9IVe/pDrNqR+MiJzmNUesEryI
         ChtXq5oN4WfzgSUQYKfnBPM3gIs2OVG/TpDbuHAcbrh/XQNAoYHf9n5/TugXpJa/6RuV
         AyPLwwvemcAHsA/eMbvSlEbxJ0GL/GrfovynX1pgp0QYC43Pn52h6cZtCuppp2nix2VA
         lTEtuACJ5keC+sLhSaFEiInezvfaaYeRLKJCULNqFhQQapPgHTXSC+lYC0DqzwcxWA+t
         agIbmyAzoDZp9dBS1dd6xfBld+RidsfGsPLCuXmx/eWrMaHyYjRB0OWUg7slnFPtHYiz
         MJjA==
X-Gm-Message-State: ABuFfog8dYN8pbzjOrBQa5vz6jGKMqu+SPd+CXfnXbDBLbwbWjJTXbb6
        Vbcra9o+wuz0pSSPAUaWvRA=
X-Google-Smtp-Source: ACcGV60vedHpxLrLgTLQF5V0GN4+bikCBZ7L9BcRwfwoQg9WkdGDMbFMAjRPAcuEsrsNoEZcBX9l8Q==
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr15379367wrc.131.1539641442524;
        Mon, 15 Oct 2018 15:10:42 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id j46-v6sm16480225wre.91.2018.10.15.15.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:10:41 -0700 (PDT)
Date:   Mon, 15 Oct 2018 23:10:40 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v10 00/21] Convert "git stash" to C builtin
Message-ID: <20181015221040.GD4883@hank.intra.tgummerer.com>
References: <https://public-inbox.org/git/cover.1537913094.git.ungureanupaulsebastian@gmail.com/>
 <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15, Paul-Sebastian Ungureanu wrote:
> Hello,
> 
> This is a new iteration of `git stash`, based on the last review.
> This iteration fixes some code styling issues, bring some changes
> to `do_push_stash()` and `do_create_stash()` to be closer to API by
> following Thomas Gummerer's review of last iteration [1]. Also, there
> were some missing messages [2], which are now included.

Thanks for your work!  I had two more comments (on the patches
inline).  Once those are addressed, I'd be happy for this to be merged
to 'next'.

Since I applied this locally, and it may help someone else who may
want to have a look at this, the range-diff is below:

 1:  b7224e494e =  1:  89142f99e7 sha1-name.c: add `get_oidf()` which acts like `get_oid()`
 2:  63f2e0e6f9 !  2:  2d45985676 strbuf.c: add `strbuf_join_argv()`
    @@ -14,19 +14,17 @@
      	strbuf_setlen(sb, sb->len + sb2->len);
      }
      
    -+const char *strbuf_join_argv(struct strbuf *buf,
    -+			     int argc, const char **argv, char delim)
    ++void strbuf_join_argv(struct strbuf *buf,
    ++		      int argc, const char **argv, char delim)
     +{
     +	if (!argc)
    -+		return buf->buf;
    ++		return;
     +
     +	strbuf_addstr(buf, *argv);
     +	while (--argc) {
     +		strbuf_addch(buf, delim);
     +		strbuf_addstr(buf, *(++argv));
     +	}
    -+
    -+	return buf->buf;
     +}
     +
      void strbuf_addchars(struct strbuf *sb, int c, size_t n)
    @@ -40,12 +38,12 @@
       */
      extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
      
    -+
     +/**
    -+ *
    ++ * Join the arguments into a buffer. `delim` is put between every
    ++ * two arguments.
     + */
    -+extern const char *strbuf_join_argv(struct strbuf *buf, int argc,
    -+				    const char **argv, char delim);
    ++extern void strbuf_join_argv(struct strbuf *buf, int argc,
    ++			     const char **argv, char delim);
     +
      /**
       * This function can be used to expand a format string containing
 3:  9b9433781b =  3:  63d10ee599 stash: improve option parsing test coverage
 4:  c1d38060c5 !  4:  a6953b57e5 stash: update test cases conform to coding guidelines
    @@ -1,8 +1,9 @@
     Author: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
     
    -    stash: update test cases conform to coding guidelines
    +    t3903: modernize style
     
    -    Removed whitespaces after redirection operators.
    +    Remove whitespaces after redirection operators and wrap
    +    long lines.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
     
 5:  ac7a8267e6 =  5:  9985d8650b stash: rename test cases to be more descriptive
 6:  0e6458a280 =  6:  93d7e82b96 stash: add tests for `git stash show` config
13:  6e04c948cf !  7:  e06aca5ff5 stash: mention options in `show` synopsis.
    @@ -1,9 +1,9 @@
     Author: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
     
    -    stash: mention options in `show` synopsis.
    +    stash: mention options in `show` synopsis
     
    -    Mention in the usage text and in the documentation, that `show`
    -    accepts any option known to `git diff`.
    +    Mention in the documentation, that `show` accepts any
    +    option known to `git diff`.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
     
    @@ -28,25 +28,3 @@
      
      	Show the changes recorded in the stash entry as a diff between the
      	stashed contents and the commit back when the stash entry was first
    -
    - diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
    - --- a/builtin/stash--helper.c
    - +++ b/builtin/stash--helper.c
    -@@
    - 
    - static const char * const git_stash_helper_usage[] = {
    - 	N_("git stash--helper list [<options>]"),
    --	N_("git stash--helper show [<stash>]"),
    -+	N_("git stash--helper show [<options>] [<stash>]"),
    - 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
    - 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
    - 	N_("git stash--helper branch <branchname> [<stash>]"),
    -@@
    - };
    - 
    - static const char * const git_stash_helper_show_usage[] = {
    --	N_("git stash--helper show [<stash>]"),
    -+	N_("git stash--helper show [<options>] [<stash>]"),
    - 	NULL
    - };
    - 
 7:  a2abd1b4bd !  8:  974dbaa492 stash: convert apply to builtin
    @@ -121,8 +121,8 @@
     +	    get_oidf(&info->w_tree, "%s:", revision) ||
     +	    get_oidf(&info->b_tree, "%s^1:", revision) ||
     +	    get_oidf(&info->i_tree, "%s^2:", revision)) {
    -+		free_stash_info(info);
     +		error(_("'%s' is not a stash-like commit"), revision);
    ++		free_stash_info(info);
     +		exit(128);
     +	}
     +}
    @@ -370,18 +370,20 @@
     +
     +			if (diff_tree_binary(&out, &info->w_commit)) {
     +				strbuf_release(&out);
    -+				return -1;
    ++				return error(_("Could not generate diff %s^!."),
    ++					     oid_to_hex(&info->w_commit));
     +			}
     +
     +			ret = apply_cached(&out);
     +			strbuf_release(&out);
     +			if (ret)
    -+				return -1;
    ++				return error(_("Conflicts in index."
    ++					       "Try without --index."));
     +
     +			discard_cache();
     +			read_cache();
     +			if (write_cache_as_tree(&index_tree, 0, NULL))
    -+				return -1;
    ++				return error(_("Could not save index tree"));
     +
     +			reset_head();
     +		}
 8:  b4e019e15e !  9:  70b09f7dbb stash: convert drop and clear to builtin
    @@ -68,7 +68,8 @@
     +			     PARSE_OPT_STOP_AT_NON_OPTION);
     +
     +	if (argc)
    -+		return error(_("git stash clear with parameters is unimplemented"));
    ++		return error(_("git stash clear with parameters is "
    ++			       "unimplemented"));
     +
     +	return do_clear_stash();
     +}
 9:  c097f4fb0c ! 10:  2408fb2f39 stash: convert branch to builtin
    @@ -53,7 +53,7 @@
     +			     git_stash_helper_branch_usage, 0);
     +
     +	if (!argc) {
    -+		fprintf_ln(stderr, "No branch name specified");
    ++		fprintf_ln(stderr, _("No branch name specified"));
     +		return -1;
     +	}
     +
10:  ed3c5ccfe8 ! 11:  b9d2ed6394 stash: convert pop to builtin
    @@ -58,7 +58,8 @@
     +
     +	assert_stash_ref(&info);
     +	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
    -+		printf_ln(_("The stash entry is kept in case you need it again."));
    ++		printf_ln(_("The stash entry is kept in case "
    ++			    "you need it again."));
     +	else
     +		ret = do_drop_stash(prefix, &info, quiet);
     +
11:  85c0e246c6 = 12:  32375ffef9 stash: convert list to builtin
12:  c7425be617 ! 13:  738b3e25fc stash: convert show to builtin
    @@ -24,7 +24,7 @@
      
      static const char * const git_stash_helper_usage[] = {
      	N_("git stash--helper list [<options>]"),
    -+	N_("git stash--helper show [<stash>]"),
    ++	N_("git stash--helper show [<options>] [<stash>]"),
      	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
      	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
      	N_("git stash--helper branch <branchname> [<stash>]"),
    @@ -33,7 +33,7 @@
      };
      
     +static const char * const git_stash_helper_show_usage[] = {
    -+	N_("git stash--helper show [<stash>]"),
    ++	N_("git stash--helper show [<options>] [<stash>]"),
     +	NULL
     +};
     +
14:  b661dba53c ! 14:  89add3b71a stash: convert store to builtin
    @@ -54,7 +54,8 @@
     +	struct object_context dummy;
     +	struct option options[] = {
     +		OPT__QUIET(&quiet, N_("be quiet")),
    -+		OPT_STRING('m', "message", &stash_msg, "message", N_("stash message")),
    ++		OPT_STRING('m', "message", &stash_msg, "message",
    ++			   N_("stash message")),
     +		OPT_END()
     +	};
     +
    @@ -64,7 +65,8 @@
     +
     +	if (argc != 1) {
     +		if (!quiet)
    -+			fprintf_ln(stderr, _("\"git stash store\" requires one <commit> argument"));
    ++			fprintf_ln(stderr, _("\"git stash store\" requires one "
    ++					     "<commit> argument"));
     +		return -1;
     +	}
     +
15:  bd827be103 ! 15:  989db67e9a stash: convert create to builtin
    @@ -49,7 +49,7 @@
     +		 * is because we will pass the output further to
     +		 * "git update-index -z ...".
     +		 */
    -+		strbuf_addch(data, 0);
    ++		strbuf_addch(data, '\0');
     +	}
     +}
     +
    @@ -61,7 +61,7 @@
      }
      
     +static void add_pathspecs(struct argv_array *args,
    -+				       struct pathspec ps) {
    ++			  struct pathspec ps) {
     +	int i;
     +
     +	for (i = 0; i < ps.nr; i++)
    @@ -119,7 +119,6 @@
     +static int check_changes(struct pathspec ps, int include_untracked)
     +{
     +	int result;
    -+	int ret = 0;
     +	struct rev_info rev;
     +	struct object_id dummy;
     +	struct strbuf out = STRBUF_INIT;
    @@ -176,7 +175,8 @@
     +			 stash_index_path.buf);
     +
     +	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
    -+	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0, NULL, 0)) {
    ++	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
    ++			 NULL, 0)) {
     +		ret = -1;
     +		goto done;
     +	}
    @@ -296,7 +296,8 @@
     +		goto done;
     +	}
     +
    -+	add_pending_object(&rev, parse_object(the_repository, &info->b_commit), "");
    ++	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
    ++			   "");
     +	if (run_diff_index(&rev, 0)) {
     +		ret = -1;
     +		goto done;
    @@ -392,7 +393,8 @@
     +	if (include_untracked && get_untracked_files(ps, include_untracked,
     +						     &untracked_files)) {
     +		if (save_untracked_files(info, &msg, untracked_files)) {
    -+			fprintf_ln(stderr, _("Cannot save the untracked files"));
    ++			fprintf_ln(stderr, _("Cannot save "
    ++					     "the untracked files"));
     +			ret = -1;
     +			*stash_msg = NULL;
     +			goto done;
    @@ -403,14 +405,16 @@
     +		ret = stash_patch(info, ps, &patch);
     +		*stash_msg = NULL;
     +		if (ret < 0) {
    -+			fprintf_ln(stderr, _("Cannot save the current worktree state"));
    ++			fprintf_ln(stderr, _("Cannot save the current "
    ++					     "worktree state"));
     +			goto done;
     +		} else if (ret > 0) {
     +			goto done;
     +		}
     +	} else {
     +		if (stash_working_tree(info, ps)) {
    -+			fprintf_ln(stderr, _("Cannot save the current worktree state"));
    ++			fprintf_ln(stderr, _("Cannot save the current "
    ++					     "worktree state"));
     +			ret = -1;
     +			*stash_msg = NULL;
     +			goto done;
    @@ -430,8 +434,11 @@
     +	 */
     +	parents = NULL;
     +	if (untracked_commit_option)
    -+		commit_list_insert(lookup_commit(the_repository, &info->u_commit), &parents);
    -+	commit_list_insert(lookup_commit(the_repository, &info->i_commit), &parents);
    ++		commit_list_insert(lookup_commit(the_repository,
    ++						 &info->u_commit),
    ++				   &parents);
    ++	commit_list_insert(lookup_commit(the_repository, &info->i_commit),
    ++			   &parents);
     +	commit_list_insert(head_commit, &parents);
     +
     +	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
    @@ -474,11 +481,12 @@
     +	if (!ret)
     +		printf_ln("%s", oid_to_hex(&info.w_commit));
     +
    ++	free(stash_msg);
    ++
     +	/*
     +	 * ret can be 1 if there were no changes. In this case, we should
     +	 * not error out.
     +	 */
    -+	free((char *) stash_msg);
     +	return ret < 0;
     +}
     +
16:  e8434e36aa ! 16:  474e72d365 stash: convert push to builtin
    @@ -58,7 +58,7 @@
     +		ret = stash_patch(info, ps, patch);
      		*stash_msg = NULL;
      		if (ret < 0) {
    - 			fprintf_ln(stderr, _("Cannot save the current worktree state"));
    + 			fprintf_ln(stderr, _("Cannot save the current "
     @@
      			     0);
      
    @@ -101,28 +101,25 @@
     +
     +		if (report_path_error(ps_matched, &ps, NULL)) {
     +			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
    -+			stash_msg = NULL;
     +			ret = -1;
    ++			free(ps_matched);
     +			goto done;
     +		}
     +		free(ps_matched);
     +	}
     +
     +	if (refresh_cache(REFRESH_QUIET)) {
    -+		stash_msg = NULL;
     +		ret = -1;
     +		goto done;
     +	}
     +
     +	if (!check_changes(ps, include_untracked)) {
    -+		stash_msg = NULL;
     +		if (!quiet)
     +			printf_ln(_("No local changes to save"));
     +		goto done;
     +	}
     +
     +	if (!reflog_exists(ref_stash) && do_clear_stash()) {
    -+		stash_msg = NULL;
     +		ret = -1;
     +		fprintf_ln(stderr, _("Cannot initialize stash"));
     +		goto done;
    @@ -293,8 +290,8 @@
     +			     0);
     +
     +	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
    -+	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
    -+			     include_untracked);
    ++	return do_push_stash(ps, xstrdup_or_null(stash_msg), quiet,
    ++			     keep_index, patch_mode, include_untracked);
     +}
     +
      int cmd_stash__helper(int argc, const char **argv, const char *prefix)
17:  5a79bcaebf ! 17:  f6af86e944 stash: make push -q quiet
    @@ -5,7 +5,7 @@
         There is a change in behaviour with this commit. When there was
         no initial commit, the shell version of stash would still display
         a message. This commit makes `push` to not display any message if
    -    `--quiet` or `-q` is specified.
    +    `--quiet` or `-q` is specified. Add tests for `--quiet`.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
     
    @@ -47,7 +47,8 @@
      	if (get_oid("HEAD", &info->b_commit)) {
     -		fprintf_ln(stderr, _("You do not have the initial commit yet"));
     +		if (!quiet)
    -+			fprintf_ln(stderr, _("You do not have the initial commit yet"));
    ++			fprintf_ln(stderr, _("You do not have "
    ++					     "the initial commit yet"));
      		ret = -1;
      		*stash_msg = NULL;
      		goto done;
    @@ -57,7 +58,8 @@
      			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
     -		fprintf_ln(stderr, _("Cannot save the current index state"));
     +		if (!quiet)
    -+			fprintf_ln(stderr, _("Cannot save the current index state"));
    ++			fprintf_ln(stderr, _("Cannot save the current "
    ++					     "index state"));
      		ret = -1;
      		*stash_msg = NULL;
      		goto done;
    @@ -65,9 +67,11 @@
      	if (include_untracked && get_untracked_files(ps, include_untracked,
      						     &untracked_files)) {
      		if (save_untracked_files(info, &msg, untracked_files)) {
    --			fprintf_ln(stderr, _("Cannot save the untracked files"));
    +-			fprintf_ln(stderr, _("Cannot save "
    +-					     "the untracked files"));
     +			if (!quiet)
    -+				fprintf_ln(stderr, _("Cannot save the untracked files"));
    ++				fprintf_ln(stderr, _("Cannot save "
    ++						     "the untracked files"));
      			ret = -1;
      			*stash_msg = NULL;
      			goto done;
    @@ -79,18 +83,22 @@
     +		ret = stash_patch(info, ps, patch, quiet);
      		*stash_msg = NULL;
      		if (ret < 0) {
    --			fprintf_ln(stderr, _("Cannot save the current worktree state"));
    +-			fprintf_ln(stderr, _("Cannot save the current "
    +-					     "worktree state"));
     +			if (!quiet)
    -+				fprintf_ln(stderr, _("Cannot save the current worktree state"));
    ++				fprintf_ln(stderr, _("Cannot save the current "
    ++						     "worktree state"));
      			goto done;
      		} else if (ret > 0) {
      			goto done;
      		}
      	} else {
      		if (stash_working_tree(info, ps)) {
    --			fprintf_ln(stderr, _("Cannot save the current worktree state"));
    +-			fprintf_ln(stderr, _("Cannot save the current "
    +-					     "worktree state"));
     +			if (!quiet)
    -+				fprintf_ln(stderr, _("Cannot save the current worktree state"));
    ++				fprintf_ln(stderr, _("Cannot save the current "
    ++						     "worktree state"));
      			ret = -1;
      			*stash_msg = NULL;
      			goto done;
    @@ -100,7 +108,8 @@
      			parents, &info->w_commit, NULL, NULL)) {
     -		fprintf_ln(stderr, _("Cannot record working tree state"));
     +		if (!quiet)
    -+			fprintf_ln(stderr, _("Cannot record working tree state"));
    ++			fprintf_ln(stderr, _("Cannot record "
    ++					     "working tree state"));
      		ret = -1;
      		goto done;
      	}
    @@ -114,8 +123,8 @@
      	if (!ret)
      		printf_ln("%s", oid_to_hex(&info.w_commit));
     @@
    + 
      	if (!reflog_exists(ref_stash) && do_clear_stash()) {
    - 		stash_msg = NULL;
      		ret = -1;
     -		fprintf_ln(stderr, _("Cannot initialize stash"));
     +		if (!quiet)
    @@ -151,7 +160,8 @@
      		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
     -			fprintf_ln(stderr, _("Cannot remove worktree changes"));
     +			if (!quiet)
    -+				fprintf_ln(stderr, _("Cannot remove worktree changes"));
    ++				fprintf_ln(stderr, _("Cannot remove "
    ++						     "worktree changes"));
      			ret = -1;
      			goto done;
      		}
18:  1c501ad666 ! 18:  c90e30173a stash: convert save to builtin
    @@ -40,7 +40,7 @@
      static struct strbuf stash_index_path = STRBUF_INIT;
      
     @@
    - 			     include_untracked);
    + 			     keep_index, patch_mode, include_untracked);
      }
      
     +static int save_stash(int argc, const char **argv, const char *prefix)
    @@ -72,8 +72,10 @@
     +			     git_stash_helper_save_usage,
     +			     PARSE_OPT_KEEP_DASHDASH);
     +
    -+	if (argc)
    -+		stash_msg = (char*) strbuf_join_argv(&buf, argc, argv, ' ');
    ++	if (argc) {
    ++		strbuf_join_argv(&buf, argc, argv, ' ');
    ++		stash_msg = buf.buf;
    ++	}
     +
     +	memset(&ps, 0, sizeof(ps));
     +	ret = do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
19:  c4401b21db ! 19:  4360ea875d stash: convert `stash--helper.c` into `stash.c`
    @@ -215,7 +215,7 @@
     +			     git_stash_branch_usage, 0);
      
      	if (!argc) {
    - 		fprintf_ln(stderr, "No branch name specified");
    + 		fprintf_ln(stderr, _("No branch name specified"));
     @@
      	};
      
    @@ -244,6 +244,62 @@
      
      	if (argc != 1) {
     @@
    + 			fprintf_ln(stderr, _("You do not have "
    + 					     "the initial commit yet"));
    + 		ret = -1;
    +-		*stash_msg = NULL;
    + 		goto done;
    + 	} else {
    + 		head_commit = lookup_commit(the_repository, &info->b_commit);
    +@@
    + 
    + 	if (!check_changes(ps, include_untracked)) {
    + 		ret = 1;
    +-		*stash_msg = NULL;
    + 		goto done;
    + 	}
    + 
    +@@
    + 			fprintf_ln(stderr, _("Cannot save the current "
    + 					     "index state"));
    + 		ret = -1;
    +-		*stash_msg = NULL;
    + 		goto done;
    + 	}
    + 
    +@@
    + 				fprintf_ln(stderr, _("Cannot save "
    + 						     "the untracked files"));
    + 			ret = -1;
    +-			*stash_msg = NULL;
    + 			goto done;
    + 		}
    + 		untracked_commit_option = 1;
    + 	}
    + 	if (patch_mode) {
    + 		ret = stash_patch(info, ps, patch, quiet);
    +-		*stash_msg = NULL;
    + 		if (ret < 0) {
    + 			if (!quiet)
    + 				fprintf_ln(stderr, _("Cannot save the current "
    +@@
    + 				fprintf_ln(stderr, _("Cannot save the current "
    + 						     "worktree state"));
    + 			ret = -1;
    +-			*stash_msg = NULL;
    + 			goto done;
    + 		}
    + 	}
    +@@
    + 	else
    + 		strbuf_addf(&stash_msg_buf, "On %s: %s", branch_name,
    + 			    *stash_msg);
    +-	*stash_msg = strbuf_detach(&stash_msg_buf, NULL);
    ++	*stash_msg = xstrdup(stash_msg_buf.buf);
    + 
    + 	/*
    + 	 * `parents` will be empty after calling `commit_tree()`, so there is
    +@@
      
      static int create_stash(int argc, const char **argv, const char *prefix)
      {
    @@ -264,9 +320,9 @@
     -	argc = parse_options(argc, argv, prefix, options,
     -			     git_stash_helper_create_usage,
     -			     0);
    -+	/* Startinf with argv[1], since argv[0] is "create" */
    -+	stash_msg = (char*) strbuf_join_argv(&stash_msg_buf, argc - 1,
    -+					     ++argv, ' ');
    ++	/* Starting with argv[1], since argv[0] is "create" */
    ++	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
    ++	stash_msg = stash_msg_buf.buf;
      
      	memset(&ps, 0, sizeof(ps));
     -	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info,
    @@ -277,15 +333,9 @@
      		printf_ln("%s", oid_to_hex(&info.w_commit));
      
     +	strbuf_release(&stash_msg_buf);
    -+
    - 	/*
    - 	 * ret can be 1 if there were no changes. In this case, we should
    - 	 * not error out.
    - 	 */
    --	free((char *) stash_msg);
    - 	return ret < 0;
    - }
    + 	free(stash_msg);
      
    + 	/*
     @@
      		OPT_END()
      	};
    @@ -299,7 +349,7 @@
     +				     0);
      
      	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
    - 	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
    + 	return do_push_stash(ps, xstrdup_or_null(stash_msg), quiet,
     @@
      	};
      
    @@ -308,7 +358,7 @@
     +			     git_stash_save_usage,
      			     PARSE_OPT_KEEP_DASHDASH);
      
    - 	if (argc)
    + 	if (argc) {
     @@
      	return ret;
      }
    @@ -375,10 +425,8 @@
     +			 * they need to be immediately followed by a string
     +			 * (i.e.`-m"foobar"` or `--message="foobar"`).
     +			 */
    -+			if ((strlen(argv[i]) > 2 &&
    -+			     !strncmp(argv[i], "-m", 2)) ||
    -+			    (strlen(argv[i]) > 10 &&
    -+			     !strncmp(argv[i], "--message=", 10)))
    ++			if (starts_with(argv[i], "-m") ||
    ++			    starts_with(argv[i], "--message="))
     +				continue;
     +
     +			usage_with_options(git_stash_usage, options);
20:  92dc11fd16 ! 20:  a384b05008 stash: optimize `get_untracked_files()` and `check_changes()`
    @@ -52,7 +52,6 @@
     +static int check_changes_tracked_files(struct pathspec ps)
      {
      	int result;
    --	int ret = 0;
      	struct rev_info rev;
      	struct object_id dummy;
     -	struct strbuf out = STRBUF_INIT;
    @@ -99,8 +98,8 @@
     -	if (!check_changes(ps, include_untracked)) {
     +	if (!check_changes(ps, include_untracked, &untracked_files)) {
      		ret = 1;
    - 		*stash_msg = NULL;
      		goto done;
    + 	}
     @@
      		goto done;
      	}
    @@ -110,9 +109,9 @@
     +	if (include_untracked) {
      		if (save_untracked_files(info, &msg, untracked_files)) {
      			if (!quiet)
    - 				fprintf_ln(stderr, _("Cannot save the untracked files"));
    + 				fprintf_ln(stderr, _("Cannot save "
     @@
    - 					     ++argv, ' ');
    + 	stash_msg = stash_msg_buf.buf;
      
      	memset(&ps, 0, sizeof(ps));
     -	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0);
    @@ -124,6 +123,7 @@
      		printf_ln("%s", oid_to_hex(&info.w_commit));
      
      	strbuf_release(&stash_msg_buf);
    + 	free(stash_msg);
     -
     -	/*
     -	 * ret can be 1 if there were no changes. In this case, we should
    @@ -148,6 +148,6 @@
      
     -	if (!check_changes(ps, include_untracked)) {
     +	if (!check_changes(ps, include_untracked, &untracked_files)) {
    - 		stash_msg = NULL;
      		if (!quiet)
      			printf_ln(_("No local changes to save"));
    + 		goto done;
21:  2c40c9232a = 21:  825d1e6ef1 stash: replace all `write-tree` child processes with API calls


> [1]
> https://public-inbox.org/git/20181002203730.GI2253@hank.intra.tgummerer.com/
> 
> [2]
> https://github.com/git-for-windows/git/commit/2af24038a95a3879aa0c29d91a43180b9465247e
> 
> Joel Teichroeb (5):
>   stash: improve option parsing test coverage
>   stash: convert apply to builtin
>   stash: convert drop and clear to builtin
>   stash: convert branch to builtin
>   stash: convert pop to builtin
> 
> Paul-Sebastian Ungureanu (16):
>   sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>   strbuf.c: add `strbuf_join_argv()`
>   t3903: modernize style
>   stash: rename test cases to be more descriptive
>   stash: add tests for `git stash show` config
>   stash: mention options in `show` synopsis
>   stash: convert list to builtin
>   stash: convert show to builtin
>   stash: convert store to builtin
>   stash: convert create to builtin
>   stash: convert push to builtin
>   stash: make push -q quiet
>   stash: convert save to builtin
>   stash: convert `stash--helper.c` into `stash.c`
>   stash: optimize `get_untracked_files()` and `check_changes()`
>   stash: replace all `write-tree` child processes with API calls
> 
>  Documentation/git-stash.txt  |    4 +-
>  Makefile                     |    2 +-
>  builtin.h                    |    1 +
>  builtin/stash.c              | 1605 ++++++++++++++++++++++++++++++++++
>  cache.h                      |    1 +
>  git-stash.sh                 |  752 ----------------
>  git.c                        |    1 +
>  sha1-name.c                  |   19 +
>  strbuf.c                     |   13 +
>  strbuf.h                     |    7 +
>  t/t3903-stash.sh             |  192 ++--
>  t/t3907-stash-show-config.sh |   83 ++
>  12 files changed, 1859 insertions(+), 821 deletions(-)
>  create mode 100644 builtin/stash.c
>  delete mode 100755 git-stash.sh
>  create mode 100755 t/t3907-stash-show-config.sh
> 
> -- 
> 2.19.0.rc0.23.g10a62394e7
> 

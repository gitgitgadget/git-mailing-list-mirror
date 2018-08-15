Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51C61F404
	for <e@80x24.org>; Wed, 15 Aug 2018 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHPBHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 21:07:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37574 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeHPBHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 21:07:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so2369266wrr.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwE9IStU+AqnV1yH2T5J3k7c62VtlKJrVLrUZuvMY24=;
        b=L0QtQAAJ86MCNCqg7FDiSKwIvwCbxneYtvrK/cXhtO8kofL/lb8BCF7uQTkXYZezlY
         WVHptCCKwCzrTbTW7vePbOCbEWYM5fvhrgE6/s00M3PGfY12p5zyFNOw36jE5GcGANJN
         IYAXB6ZcrBfbiJynaDmdS7k3SWl0QE8WgZXtXTJEUuuGsOMHDYOuaX4ESPrSpaZZO4Zv
         RnBKcJ+pjf9UtZuLAZrH4gwO5L9WwjlILS6hsZg746SoSkXUYwLB2mct4dsctJOZJp8t
         Ewf9S/qcMr2iX3UE1D4kvVJLg1asuE7P5sFNQWPlbdtH0Iuy4ozAo2Yp4Z8Z3IZsjrik
         WzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwE9IStU+AqnV1yH2T5J3k7c62VtlKJrVLrUZuvMY24=;
        b=ImKVCLgtakfQTabRps5MObhn80KKM1+Xd1Ek9bvjqfAQTIinfUM2E67OFdsuhNcEC2
         BO7E3FyWtp7hKfYmtqRPDJ9ChhQ3VWWkWsHUCOdYxJ1ZQdpc5d9pvFjbS7Z740BhwFSg
         CDYhXL1cL9g6QTiB6SSZ3Z722mFu6iU8efUqGD/+9o8fWJnsqGiIY2m9hHLWD5svG+z0
         3Vk4Ho0uCDgExmLKs7dlSAJtcax8Ktx+xqXySIAfsa7M7iiZf9jVrXXmvcLgQMvFaXPy
         w7K6clb5B+X7hmlo9cVbMjeT3usFdJVVbrxrt8zUxeXbFa2CXDPEqMqVpOjAUyzT+fK5
         YPmw==
X-Gm-Message-State: AOUpUlF59cIulYsdqPSHD/69O6IhzxqB/6D8y0+/LEcckldbwHoBC8X4
        mgdYWW4h/zQcqYH8K1xIMXg=
X-Google-Smtp-Source: AA+uWPzlOhOha7aNzE3qorUQ8MF4flFxdx9u5OGdNQeGagF1b7qXib2O7g+CMbF8FejzAnNlw+3a0g==
X-Received: by 2002:adf:9282:: with SMTP id 2-v6mr18242917wrn.69.1534371186949;
        Wed, 15 Aug 2018 15:13:06 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id v124-v6sm4227321wma.18.2018.08.15.15.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:13:06 -0700 (PDT)
Date:   Wed, 15 Aug 2018 23:13:05 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 15/26] stash: convert create to builtin
Message-ID: <20180815221305.GQ2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <0393bbd09daeb7ab67da4a343ba58d824c35532b.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0393bbd09daeb7ab67da4a343ba58d824c35532b.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Add stash create to the helper.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c | 406 ++++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            |   2 +-
>  2 files changed, 407 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 5ff810f8c..a4e57899b 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -21,6 +21,7 @@ static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper branch <branchname> [<stash>]"),
>  	N_("git stash--helper clear"),
>  	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
> +	N_("git stash--helper create [<message>]"),
>  	NULL
>  };
>  
> @@ -64,6 +65,11 @@ static const char * const git_stash_helper_store_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_create_usage[] = {
> +	N_("git stash--helper create [<message>]"),
> +	NULL
> +};
> +
>  static const char *ref_stash = "refs/stash";
>  static int quiet;
>  static struct strbuf stash_index_path = STRBUF_INIT;
> @@ -781,6 +787,404 @@ static int store_stash(int argc, const char **argv, const char *prefix)
>  	return do_store_stash(argv[0], stash_msg, quiet);
>  }
>
> [...]
> 
> +
> +static int do_create_stash(int argc, const char **argv, const char *prefix,
> +			   const char **stash_msg, int include_untracked,
> +			   int patch_mode, struct stash_info *info)
> +{
> +	int untracked_commit_option = 0;
> +	int ret = 0;
> +	int subject_len;
> +	int flags;
> +	const char *head_short_sha1 = NULL;
> +	const char *branch_ref = NULL;
> +	const char *head_subject = NULL;
> +	const char *branch_name = "(no branch)";
> +	struct commit *head_commit = NULL;
> +	struct commit_list *parents = NULL;
> +	struct strbuf msg = STRBUF_INIT;
> +	struct strbuf commit_tree_label = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	struct strbuf final_stash_msg = STRBUF_INIT;
> +
> +	read_cache_preload(NULL);
> +	refresh_cache(REFRESH_QUIET);
> +
> +	if (!check_changes(argv, include_untracked, prefix)) {
> +		ret = 1;
> +		goto done;

I wonder if we can just 'exit(0)' here, instead of returning.  This
whole command is a builtin, and I *think* outside of 'libgit.a' exiting
early is fine.  It does mean that we're not free'ing the memory
though, which means a leak checker would probably complain.  So
dunno.  It would simplify the code a little, but not sure it's worth it.

> +	}
> +
> +	if (get_oid("HEAD", &info->b_commit)) {
> +		fprintf_ln(stderr, "You do not have the initial commit yet");
> +		ret = -1;
> +		goto done;
> +	} else {
> +		head_commit = lookup_commit(the_repository, &info->b_commit);
> +	}
> +
> +	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> +	if (flags & REF_ISSYMREF)
> +		branch_name = strrchr(branch_ref, '/') + 1;
> +	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
> +					     DEFAULT_ABBREV);
> +	subject_len = find_commit_subject(get_commit_buffer(head_commit, NULL),
> +					  &head_subject);
> +	strbuf_addf(&msg, "%s: %s %.*s\n", branch_name, head_short_sha1,
> +		    subject_len, head_subject);

I think this can be written in a slightly simpler way:

	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
					     DEFAULT_ABBREV);
	strbuf_addf(&msg, "%s: %s", branch_name, head_short_sha1);
	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
	strbuf_addch(&msg, '\n');

The other advantage this brings is that it is consistent with other
places where we print/use the subject of a commit (e.g. in 'git reset
--hard').

> +
> +	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
> +	commit_list_insert(head_commit, &parents);
> +	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
> +	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
> +			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
> +		fprintf_ln(stderr, "Cannot save the current index state");

Looks like this message is translated in the current 'git stash'
implementation, so it should be here as well.  Same for the messages
below.

> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (include_untracked && get_untracked_files(argv, 1,
> +						     include_untracked, &out)) {
> +		if (save_untracked_files(info, &msg, &out)) {
> +			printf_ln("Cannot save the untracked files");

Why does this go to stdout, whereas "Cannot save the current index
state" above goes to stderr?  In the shell version of git stash these
all go to stderr fwiw.  There are a few similar cases, it would
probably be worth going through all the print statements here and see
if they need to be translated, and to which output stream they should
go.

> +			ret = -1;
> +			goto done;
> +		}
> +		untracked_commit_option = 1;
> +	}
> +	if (patch_mode) {
> +		ret = stash_patch(info, argv);
> +		if (ret < 0) {
> +			printf_ln("Cannot save the current worktree state");
> +			goto done;
> +		} else if (ret > 0) {
> +			goto done;
> +		}
> +	} else {
> +		if (stash_working_tree(info, argv)) {
> +			printf_ln("Cannot save the current worktree state");
> +			ret = -1;
> +			goto done;
> +		}
> +	}
> +
> +	if (!*stash_msg || !strlen(*stash_msg))
> +		strbuf_addf(&final_stash_msg, "WIP on %s", msg.buf);
> +	else
> +		strbuf_addf(&final_stash_msg, "On %s: %s\n", branch_name,
> +			    *stash_msg);
> +	*stash_msg = strbuf_detach(&final_stash_msg, NULL);

strbuf_detach means we're taking ownership of the memory, so we'll
have to free it afterwards. Looking at this we may not even want to
re-use the 'stash_msg' variable here, but instead introduce another
variable for it, so it doesn't have a dual meaning in this function.

> +
> +	/*
> +	 * `parents` will be empty after calling `commit_tree()`, so there is
> +	 * no need to call `free_commit_list()`
> +	 */
> +	parents = NULL;
> +	if (untracked_commit_option)
> +		commit_list_insert(lookup_commit(the_repository, &info->u_commit), &parents);
> +	commit_list_insert(lookup_commit(the_repository, &info->i_commit), &parents);
> +	commit_list_insert(head_commit, &parents);
> +
> +	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
> +			parents, &info->w_commit, NULL, NULL)) {
> +		printf_ln("Cannot record working tree state");
> +		ret = -1;
> +		goto done;
> +	}
> +
> +done:
> +	strbuf_release(&commit_tree_label);
> +	strbuf_release(&msg);
> +	strbuf_release(&out);
> +	strbuf_release(&final_stash_msg);
> +	return ret;
> +}
> +
> +static int create_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int include_untracked = 0;
> +	int ret = 0;
> +	const char *stash_msg = NULL;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_STRING('m', "message", &stash_msg, N_("message"),
> +			 N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_create_usage,
> +			     0);
> +
> +	ret = do_create_stash(argc, argv, prefix, &stash_msg,
> +			      include_untracked, 0, &info);

stash_msg doesn't have to be passed as a pointer to a pointer here, as
we never need the modified value after this function returns.  I think
just passing 'stash_msg' here instead of '&stash_msg' will make
'do_create_stash' slightly easier to read.

> +
> +	if (!ret)
> +		printf_ln("%s", oid_to_hex(&info.w_commit));
> +
> +	/*
> +	 * ret can be 1 if there were no changes. In this case, we should
> +	 * not error out.
> +	 */
> +	return ret < 0;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -817,6 +1221,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!show_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "store"))
>  		return !!store_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "create"))
> +		return !!create_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 5739c5152..ab06e4ffb 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -425,7 +425,7 @@ clear)
>  	;;
>  create)
>  	shift
> -	create_stash -m "$*" && echo "$w_commit"
> +	git stash--helper create --message "$*"
>  	;;
>  store)
>  	shift
> -- 
> 2.18.0.573.g56500d98f
> 

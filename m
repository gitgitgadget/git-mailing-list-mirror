Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3612D1F97E
	for <e@80x24.org>; Sat, 18 Aug 2018 15:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeHRSzG (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 14:55:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36964 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 14:55:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so9903408wmc.2
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZT6S985rNruEMNZn+47OHCJqDptF37hj6+2Ox9yXCw=;
        b=kbuKSd9e1swNnuI+QAQUYKFI/8L944fLM1lDHBkw3LvpJRljHEBhH7o72kG++DxYDx
         HaFovgcE8xLyhrbmVOp4zGUfXRMnVCY4umd9CvpDUeYG+w+lxaJAGdqiJubIU/l73HI2
         9xdxV8liV/zMEZPXcSeMp5XXwmWQZtjU703Qu8KMi9XZk67GNEhTCYnd78e51Mz9TURq
         OEdVy+HKr4DGt42n8r4JizIbF4SWhMdqF0WjVpA7RZV62hSFP6HiqSYceN25N6EJYVuq
         KhRnau6uU6bz9i57rdEUaTJQ7Q3AAJu1PqahWzGlP8LrmSenJx/8wNsxkkcjfhvC9FzH
         BLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZT6S985rNruEMNZn+47OHCJqDptF37hj6+2Ox9yXCw=;
        b=SReAHiYhbhw83MSzVdwXTLZAC4J121HWVtrYI5Tg289ymrhd/+GiltJPUOU4cUTN8C
         jNswF9uwp9mChbpkeG6sESbSFdJhXIzL3cGRBK9oj5jrXpCNrUroMOt5X16brtVSdtHm
         B0k08a4eLXMriR+tJRY5XRBCcxlnhozkc4yR2cRPpJg2DfP+XF+h7kX+yBe7HFF+TWG6
         Q07ZUZ2nisNSUiqmjPNpIcH8JPDlUqRQ0XHWNUUQvC2f/6/FRjuKShyer5CXGj9B3VOZ
         ddCMlO4D+xQXPYhizXc1z+g4Wt90ppfjo2KX8PALUo3dWm5oUz4ta6DEcpHJSo1cnod9
         1tUA==
X-Gm-Message-State: AOUpUlE+9DCXs5qcgcRuB1ik3rBbGUU7KAfICuvpgcMW+L1bwFucrBf7
        6cs/kawIAuiDCrsuezAR9kg=
X-Google-Smtp-Source: AA+uWPymRuYBJnCQ/x2hwSk4Bme5XySZjMuypISQoM4OSj9+yJh81ncTOGZXKsDbCMrVSwa2qtkF+A==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr22535136wmd.77.1534607217201;
        Sat, 18 Aug 2018 08:46:57 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id g2-v6sm5823650wme.20.2018.08.18.08.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 08:46:56 -0700 (PDT)
Date:   Sat, 18 Aug 2018 16:46:55 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 19/26] stash: make push to be quiet
Message-ID: <20180818154655.GC11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <c778a6aa99edd1ab58cfebc0976f1475f759611c.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c778a6aa99edd1ab58cfebc0976f1475f759611c.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: stash: make push to be quiet

Nit: maybe "stash: make push -q quiet"?  I think the subject should at
least mention the -q option.

On 08/08, Paul-Sebastian Ungureanu wrote:
> There is a change in behaviour with this commit. When there was
> no initial commit, the shell version of stash would still display
> a message. This commit makes `push` to not display any message if
> `--quiet` or `-q` is specified.

Yeah, not being quiet here cna be considered a bug, so this change in
behaviour makes sense.

Should the "No changes selected" message in 'stash_patch' also be made
quiet?

> ---
>  builtin/stash--helper.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index c26cad3d5..4fd79532c 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -1079,7 +1079,7 @@ static int stash_working_tree(struct stash_info *info,
>  
>  static int do_create_stash(int argc, const char **argv, const char *prefix,
>  			   const char **stash_msg, int include_untracked,
> -			   int patch_mode, struct stash_info *info)
> +			   int patch_mode, struct stash_info *info, int quiet)
>  {
>  	int untracked_commit_option = 0;
>  	int ret = 0;
> @@ -1105,7 +1105,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
>  	}
>  
>  	if (get_oid("HEAD", &info->b_commit)) {
> -		fprintf_ln(stderr, "You do not have the initial commit yet");
> +		if (!quiet)
> +			fprintf_ln(stderr, "You do not have the initial commit yet");
>  		ret = -1;
>  		goto done;
>  	} else {
> @@ -1127,7 +1128,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
>  	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
>  	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
>  			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
> -		fprintf_ln(stderr, "Cannot save the current index state");
> +		if (!quiet)
> +			fprintf_ln(stderr, "Cannot save the current index state");
>  		ret = -1;
>  		goto done;
>  	}
> @@ -1135,7 +1137,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
>  	if (include_untracked && get_untracked_files(argv, 1,
>  						     include_untracked, &out)) {
>  		if (save_untracked_files(info, &msg, &out)) {
> -			printf_ln("Cannot save the untracked files");
> +			if (!quiet)
> +				printf_ln("Cannot save the untracked files");
>  			ret = -1;
>  			goto done;
>  		}
> @@ -1144,14 +1147,16 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
>  	if (patch_mode) {
>  		ret = stash_patch(info, argv);
>  		if (ret < 0) {
> -			printf_ln("Cannot save the current worktree state");
> +			if (!quiet)
> +				printf_ln("Cannot save the current worktree state");
>  			goto done;
>  		} else if (ret > 0) {
>  			goto done;
>  		}
>  	} else {
>  		if (stash_working_tree(info, argv, prefix)) {
> -			printf_ln("Cannot save the current worktree state");
> +			if (!quiet)
> +				printf_ln("Cannot save the current worktree state");
>  			ret = -1;
>  			goto done;
>  		}
> @@ -1176,7 +1181,8 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
>  
>  	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
>  			parents, &info->w_commit, NULL, NULL)) {
> -		printf_ln("Cannot record working tree state");
> +		if (!quiet)
> +			printf_ln("Cannot record working tree state");
>  		ret = -1;
>  		goto done;
>  	}
> @@ -1208,7 +1214,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  			     0);
>  
>  	ret = do_create_stash(argc, argv, prefix, &stash_msg,
> -			      include_untracked, 0, &info);
> +			      include_untracked, 0, &info, 0);
>  
>  	if (!ret)
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
> @@ -1261,25 +1267,31 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
>  		return -1;
>  
>  	if (!check_changes(argv, include_untracked, prefix)) {
> -		fprintf_ln(stdout, "No local changes to save");
> +		if (!quiet)
> +			fprintf_ln(stdout, "No local changes to save");
>  		return 0;
>  	}
>  
>  	if (!reflog_exists(ref_stash) && do_clear_stash()) {
> -		fprintf_ln(stderr, "Cannot initialize stash");
> +		if (!quiet)
> +			fprintf_ln(stderr, "Cannot initialize stash");
>  		return -1;
>  	}
>  
>  	if ((ret = do_create_stash(argc, argv, prefix, &stash_msg,
> -				   include_untracked, patch_mode, &info)))
> +				   include_untracked, patch_mode, &info,
> +				   quiet)))
>  		return ret;
>  
>  	if (do_store_stash(oid_to_hex(&info.w_commit), stash_msg, 1)) {
> -		fprintf(stderr, "Cannot save the current status");
> +		if (!quiet)
> +			fprintf_ln(stderr, "Cannot save the current status");
>  		return -1;
>  	}
>  
> -	fprintf(stdout, "Saved working directory and index state %s", stash_msg);
> +	if (!quiet)
> +		fprintf(stdout, "Saved working directory and index state %s",
> +			stash_msg);
>  
>  	if (!patch_mode) {
>  		if (include_untracked && ps.nr == 0) {
> @@ -1367,7 +1379,8 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
>  		argv_array_pushl(&cp.args, "apply", "-R", NULL);
>  
>  		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
> -			fprintf_ln(stderr, "Cannot remove worktree changes");
> +			if (!quiet)
> +				fprintf_ln(stderr, "Cannot remove worktree changes");
>  			return -1;
>  		}
>  
> -- 
> 2.18.0.573.g56500d98f
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21A11F453
	for <e@80x24.org>; Wed, 31 Oct 2018 02:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeJaLhd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 07:37:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38754 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeJaLhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 07:37:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so14754059wrs.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K+Rsa8v+5+1+3KgJ/ZI2aInvnKqACX7iEEOpNBe67JE=;
        b=GICbJyWNCTJ1MaDejSYcR0hB0KMGTt9eENMNjgmuAbK8uEmaPBIOpITx7O3uXkHShA
         GcM6myLuHVSBIIPSTBO+9S5cLd0DHklAxyfoDjEuMJYX0do1CXRaqMVzi/RU2+sKvp8d
         BsFoGlvRuKLOM9lXI/nO/EEdHDU2vHOeAtoZAMAe+PY3VJw+EbD4pTGdaJHcT9HNDvDc
         +IPj6OAKRNZ+jgY21rqGCSxDO/iUnj9vUqEg+gTNf+O7z77Y32FyXScyZMa3mU8/EZjs
         sUzptTShEjv2T73eVTtI9d497//WOJhRv9BEn1XK+ZGmgW0Dg2xRwb8X8o44MkhZ5+1M
         Se0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K+Rsa8v+5+1+3KgJ/ZI2aInvnKqACX7iEEOpNBe67JE=;
        b=fiT7138YDuJE5ZKDiUIrixeQg/keRCq84KdOVQ8QYGlgGeSApuyRshvsw6c1nWXUMW
         HruitWXlqqfWmTzKwPxHOQExXgn/Mh0vP64uWXPCznmbFlWSruF7RqLpYcNoQzJPWMwJ
         Z8f2th9fgPu3zcyPSJTuPiEnuXWtYVDXZW8JyJ+ABgxFD6heZdVf4Gbls3f+X4kp1Xjs
         +hy7A4jC3xblpjrNbXeRTlk1FvQqMkQYskYPumAHgAnwzkoLZdmRLdRRq6R4sz7+0keq
         +5iLOgeZ+u89f1gg8k48vKUSQrYGo3Yvi0Rl+x++ZLj9qYPsKIRPcGBxzZuSRD88nZxE
         wj/g==
X-Gm-Message-State: AGRZ1gK/SXiwp/Lj/8TzQtbaiBiK1Bbg8PsqoCnUinWYbv7O0vae8uqA
        tjT8/URInZl1hcoiackg+jE=
X-Google-Smtp-Source: AJdET5eQO+cAn73l3YJnKdItbZWLZhamJ1avfIgcgCVBL+t8dQF6qjfnCCBwZ4vj8mZV0VgQxYHNDw==
X-Received: by 2002:adf:fcc1:: with SMTP id f1-v6mr997459wrs.172.1540953689571;
        Tue, 30 Oct 2018 19:41:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i11-v6sm15904164wrs.87.2018.10.30.19.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 19:41:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/2] worktree: rename is_worktree_locked to worktree_lock_reason
References: <20181030062409.42169-1-nbelakovski@gmail.com>
        <20181025055142.38077-1-nbelakovski@gmail.com>
        <20181030062409.42169-2-nbelakovski@gmail.com>
Date:   Wed, 31 Oct 2018 11:41:27 +0900
In-Reply-To: <20181030062409.42169-2-nbelakovski@gmail.com> (nbelakovski's
        message of "Mon, 29 Oct 2018 23:24:09 -0700")
Message-ID: <xmqqh8h2zvl4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> A function prefixed with 'is_' would be expected to return a boolean,
> however this function returns a string.
>
> Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> ---

Given that there is a clear documentation in worktree.h, and a
pointer that is not NULL is true in "if/while(ptr)", I'd say this
change is a borderline "meh".

I'll queue this on top of 1/2 and try merging to the integration
topics to see if it interacts with any other topics in flight.
Since the patch has already been written, let's not waste the effort
if there is no conflict with anybody else (otherwise I'd discard
this one---a "meh" patch is not worth having to worry about conflict
resolution).

Thanks.

>  builtin/worktree.c | 10 +++++-----
>  worktree.c         |  2 +-
>  worktree.h         |  4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index c4abbde2b..5e8402617 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -245,7 +245,7 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
>  	if (!wt)
>  		goto done;
>  
> -	locked = !!is_worktree_locked(wt);
> +	locked = !!worktree_lock_reason(wt);
>  	if ((!locked && opts->force) || (locked && opts->force > 1)) {
>  		if (delete_git_dir(wt->id))
>  		    die(_("unable to re-add worktree '%s'"), path);
> @@ -682,7 +682,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
>  	if (is_main_worktree(wt))
>  		die(_("The main working tree cannot be locked or unlocked"));
>  
> -	old_reason = is_worktree_locked(wt);
> +	old_reason = worktree_lock_reason(wt);
>  	if (old_reason) {
>  		if (*old_reason)
>  			die(_("'%s' is already locked, reason: %s"),
> @@ -714,7 +714,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
>  		die(_("'%s' is not a working tree"), av[0]);
>  	if (is_main_worktree(wt))
>  		die(_("The main working tree cannot be locked or unlocked"));
> -	if (!is_worktree_locked(wt))
> +	if (!worktree_lock_reason(wt))
>  		die(_("'%s' is not locked"), av[0]);
>  	ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
>  	free_worktrees(worktrees);
> @@ -787,7 +787,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
>  	validate_no_submodules(wt);
>  
>  	if (force < 2)
> -		reason = is_worktree_locked(wt);
> +		reason = worktree_lock_reason(wt);
>  	if (reason) {
>  		if (*reason)
>  			die(_("cannot move a locked working tree, lock reason: %s\nuse 'move -f -f' to override or unlock first"),
> @@ -900,7 +900,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  	if (is_main_worktree(wt))
>  		die(_("'%s' is a main working tree"), av[0]);
>  	if (force < 2)
> -		reason = is_worktree_locked(wt);
> +		reason = worktree_lock_reason(wt);
>  	if (reason) {
>  		if (*reason)
>  			die(_("cannot remove a locked working tree, lock reason: %s\nuse 'remove -f -f' to override or unlock first"),
> diff --git a/worktree.c b/worktree.c
> index b0d0b5426..befdbe7fa 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -235,7 +235,7 @@ int is_main_worktree(const struct worktree *wt)
>  	return !wt->id;
>  }
>  
> -const char *is_worktree_locked(struct worktree *wt)
> +const char *worktree_lock_reason(struct worktree *wt)
>  {
>  	assert(!is_main_worktree(wt));
>  
> diff --git a/worktree.h b/worktree.h
> index 6b12a3cf6..55d449b6a 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -10,7 +10,7 @@ struct worktree {
>  	char *path;
>  	char *id;
>  	char *head_ref;		/* NULL if HEAD is broken or detached */
> -	char *lock_reason;	/* private - use is_worktree_locked */
> +	char *lock_reason;	/* private - use worktree_lock_reason */
>  	struct object_id head_oid;
>  	int is_detached;
>  	int is_bare;
> @@ -60,7 +60,7 @@ extern int is_main_worktree(const struct worktree *wt);
>   * Return the reason string if the given worktree is locked or NULL
>   * otherwise.
>   */
> -extern const char *is_worktree_locked(struct worktree *wt);
> +extern const char *worktree_lock_reason(struct worktree *wt);
>  
>  #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802371F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbdEAShA (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:37:00 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34256 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdEASg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:36:59 -0400
Received: by mail-pf0-f178.google.com with SMTP id e64so40475375pfd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VO7wKn2a3y0ARLWh6/08UQD4roVKXzh3CCKcmaf24/k=;
        b=EVYDnm3xCjHdSdSMSfjZ4eFkBxMW0q20wYExxajeFEGVhSVdu0JU9gm+j6OC8nzwU0
         QL10imVlf0Rj8BawA1ygMuvvJxvVarwCZO31NO2jpVt3lvnWdrSc1PLCq8XQ85g4TpEx
         xnewudXmpmISShW6GZYD7SGMNqCBR+qw80T8b6g/uQBB6HBhM81Jx0mjPsQFmZMe+2yg
         I70/CG26tBIeGYwegA+rQFNh1YzRpUMkvJ5uGJiQ7vaoWC6/lbZbmrnUkF7eqAxjIOeW
         PXdy4eT1RVYjqLLMkh5en728qUUVS818ruOsKZeLi98rxNZbuG2p3yShWYQSaBq3/BOZ
         qwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VO7wKn2a3y0ARLWh6/08UQD4roVKXzh3CCKcmaf24/k=;
        b=daXPjgQV+KHTT2PuoPIhD6DBELQ6g4rs0wPM2jVFzg811lyIVcaAfzZRqxqgbVV+rw
         78UToXjOsoWN5a/krlHNJtg3EJvWNzbG7yXCZbwc40tE6W6MV3TDyg+b1He5bX14A5NR
         RaEj6qdwQtV6GEDcv0fFYCDYxfZuuKo+e6JEOCeOC/sr/jc6pQFFbOBaRyO06fAt3kuw
         ReYp//3fYOPDTnpRe96pqtQyB3yu60ckdrp42nbuVMSJ1MaRC3Xj9p9sGbWKULaEo/3k
         aAcayXo0G5ksIiWmKExDyD3xekuaAd+DeSCHlhskhkpXeTGtdt6bSm6qaqPfaYElFeuN
         juug==
X-Gm-Message-State: AN3rC/4je+OPRxu6BZg9azW3pmg7dwBOEqy7rjJ7zZMzwGoHrblw7utJ
        9l8iS7T0BMnDWSY+
X-Received: by 10.99.7.196 with SMTP id 187mr6716009pgh.226.1493663818216;
        Mon, 01 May 2017 11:36:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id y29sm28859124pfj.90.2017.05.01.11.36.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:36:57 -0700 (PDT)
Date:   Mon, 1 May 2017 11:36:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] submodule--helper: reattach-HEAD
Message-ID: <20170501183656.GH39135@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
 <20170501180058.8063-5-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501180058.8063-5-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Stefan Beller wrote:
> Add a new command, that reattaches a detached HEAD to its configured
> branch in a submodule.
> 
> In a later patch we will teach git-submodule as well as other submodule
> worktree manipulators (git reset/checkout --recurse-submodules) to not
> end up in a detached HEAD state in the submodules.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
>  
> +int reattach_HEAD(const char *submodule_path, int flags)
> +{
> +	const char *branch;
> +	struct object_id sub_head_object;
> +	struct object_id sub_branch_object;
> +
> +	const struct submodule *sub = submodule_from_path(null_sha1, submodule_path);
> +
> +	if (!sub) {
> +		if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
> +			return -1;
> +		die(_("no submodule mapping found in .gitmodules for path '%s'"),
> +			submodule_path);
It may be a bit clearer to do the following:

  if (flags & REATTACH_HEAD_DIE_ON_ERROR)
    die(...);

  return -1;

It just feels weird to me to have the inverted logic, that's my opinion
though.

> +	}
> +
> +	if (!sub->branch) {
> +		if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
> +			return -1;
> +		die(_("no branch configured to follow for submodule '%s'"),
> +			sub->path);
> +	}
> +
> +	/* lookup branch value in .gitmodules */
> +	if (strcmp(".", sub->branch)) {
> +		branch = sub->branch;
> +	} else {
> +		/* special care for '.': Is the superproject on a branch? */
> +		struct object_id oid;
> +		branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
> +		if (!branch) {
> +			if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
> +				return -1;
> +			die(_("Not on any branch, but submodule configured to follow superprojects branch"));
> +		}
> +	}
> +
> +	if (!strcmp("HEAD", branch))
> +		return 0;

So this is the case where the superproject is in a detached-HEAD state?
In that case then we don't need to continue because if the superproject
isn't on a branch, then there isn't a reason the submodule should be on
a branch.

> +
> +	resolve_gitlink_ref(sub->path, "HEAD", sub_head_object.hash);
> +	resolve_gitlink_ref(sub->path, branch, sub_branch_object.hash);
> +
> +	if (!oidcmp(&sub_head_object, &sub_branch_object)) {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		struct strbuf reason = STRBUF_INIT;
> +
> +		cp.dir = sub->path;
> +		prepare_submodule_repo_env(&cp.env_array);
> +
> +		strbuf_addf(&reason, "reattach HEAD to %s", branch);
> +		argv_array_pushl(&cp.args, "git", "symbolic-ref",
> +				 "-m", reason.buf, "HEAD", branch, NULL);
> +		if (run_command(&cp)) {
> +			if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
> +				return -1;
> +			die(_("could not run symbolic-ref in submodule '%s'"),
> +			    sub->path);
> +		}
> +		strbuf_release(&reason);
> +		return 0;
> +	} else {
> +		fprintf(stderr, "not reattaching HEAD, object ids differ:\n"
> +				"HEAD is %s\n branch is %s",
> +				oid_to_hex(&sub_head_object),
> +				oid_to_hex(&sub_branch_object));
> +		return 1;
> +	}
> +}
> +
>  static int find_first_merges(struct object_array *result, const char *path,
>  		struct commit *a, struct commit *b)
>  {
> diff --git a/submodule.h b/submodule.h
> index 1277480add..f7bb565a6d 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -119,6 +119,16 @@ extern int submodule_move_head(const char *path,
>   */
>  extern void prepare_submodule_repo_env(struct argv_array *out);
>  
> +/*
> + * Attach the submodules HEAD to its configured branch if the underlying
> + * object id are the same. Returns
> + * -  0 when the branch could be reattached.
> + * - +1 when the branch could not be reattached due to object name mismatch
> + * - <0 when an error occurred (e.g. missing .gitmodules file)
> + */
> +#define REATTACH_HEAD_DIE_ON_ERROR (1<<0)
> +extern int reattach_HEAD(const char *submodule_path, int flags);
> +
>  #define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
>  extern void absorb_git_dir_into_superproject(const char *prefix,
>  					     const char *path,
> -- 
> 2.13.0.rc1.1.gbc33f0f778
> 

-- 
Brandon Williams

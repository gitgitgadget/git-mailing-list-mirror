Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30B9202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 23:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbdCIXhZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 18:37:25 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36658 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbdCIXhX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 18:37:23 -0500
Received: by mail-pg0-f47.google.com with SMTP id g2so14422497pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 15:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1crj9LxmEAYlzKJ7GlgbtZWFst/jq4FSJ9OzARvRyQs=;
        b=i5W3SY09e5sIqZtDTTk/gn2HeSoNWgXoZNqzEybnfkPFJWx77KOw5wah5mPIFZYqJv
         u0txhPwAad00PYj4C5vxobGIgfvyuxFJEZRVxV4m9arVMRpZZbdWH7f990roJ72o4H+8
         CBBLsoWab5SitY03ykSf+zjsGyGIKrWpdtUAgqcVVBLj1w8g3+GAmjw8X7gRTowAf6G+
         XeAVdr/VPg1X6GoaYtS3pCPk4M6whQry6Tu4VzE5a8qu4rKx0pywtNE1OCtGjq7kum94
         4AiH0SopqG/zSq78+HcuYU28/EhVxBD4jrHVlgCzZeIEijfwwJSVO918yhfToakKcTNn
         LV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1crj9LxmEAYlzKJ7GlgbtZWFst/jq4FSJ9OzARvRyQs=;
        b=tejAPD9xbVt4Ppz6Y7/tZXATAyeOfd9uKGbBnai6bpPTVtuTy23m6jGJwRdwVihJMB
         XtD/aJzJrNyVWdE2q5Xm/Ni4TCAv/GMuN+DzKbYwFEermMDIl7ufUTudr2+kcttVR7G+
         PLpE6GCjyioZ51wjzfPj5cTxPv25PjTq/JbNji5IHdmAb7tVJ2+K5y6ENu09re0KoFty
         Crpj2RmakpG0PQMklJSILSu9TvLIEAKFVUv/dumc8Cw+QWKJ4MEzFAqt/eeKecjaZqbz
         RsM2bl6nL2TaftQaY3T5BTtX0tyWl2uc2z2SGt5PI+/Qz1NVxGtMbmUuqtfFE37wnBtI
         hoSg==
X-Gm-Message-State: AMke39kGxRdf7BzzGU2W4jSxXzPN/tIwrfUFZ5e+iN+9lrj9ylqJ2Nb9qzHIJyIbBFau4/Xj
X-Received: by 10.84.172.1 with SMTP id m1mr20406204plb.5.1489102631776;
        Thu, 09 Mar 2017 15:37:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id x21sm14621521pgf.15.2017.03.09.15.37.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 15:37:10 -0800 (PST)
Date:   Thu, 9 Mar 2017 15:37:09 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 12/17] update submodules: add submodule_move_head
Message-ID: <20170309233709.GD52558@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
 <20170309221543.15897-13-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309221543.15897-13-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Stefan Beller wrote:
> In later patches we introduce the options and flag for commands
> that modify the working directory, e.g. git-checkout.
> 
> This piece of code will be used universally for
> all these working tree modifications as it
> * supports dry run to answer the question:
>   "Is it safe to change the submodule to this new state?"
>   e.g. is it overwriting untracked files or are there local
>   changes that would be overwritten?
> * supports a force flag that can be used for resetting
>   the tree.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  submodule.h |   7 ++++
>  2 files changed, 142 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index 0b2596e88a..bc5fecf8c5 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  	return ret;
>  }
>  
> +static int submodule_has_dirty_index(const struct submodule *sub)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
> +					"--cached", "HEAD", NULL);

The formatting of this line is a little odd.  Also you can drop the
backslash.

Mostly because I haven't dug too deep yet/can't remember: Does
diff-index do the correct thing with nested submodules?  If I remember
correctly it does so this shouldn't be a problem.

> +	cp.no_stdin = 1;
> +	cp.no_stdout = 1;
> +	cp.dir = sub->path;
> +	if (start_command(&cp))
> +		die("could not recurse into submodule '%s'", sub->path);
> +
> +	return finish_command(&cp);
> +}
> +
> +static void submodule_reset_index(const char *path)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +
> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
> +	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
> +
> +	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
> +
> +	if (run_command(&cp))
> +		die("could not reset submodule index");
> +}
> +
> +/**
> + * Moves a submodule at a given path from a given head to another new head.
> + * For edge cases (a submodule coming into existence or removing a submodule)
> + * pass NULL for old or new respectively.
> + */
> +int submodule_move_head(const char *path,
> +			 const char *old,
> +			 const char *new,
> +			 unsigned flags)
> +{
> +	int ret = 0;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const struct submodule *sub;
> +
> +	sub = submodule_from_path(null_sha1, path);
> +
> +	if (!sub)
> +		die("BUG: could not get submodule information for '%s'", path);
> +
> +	if (old && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
> +		/* Check if the submodule has a dirty index. */
> +		if (submodule_has_dirty_index(sub))
> +			return error(_("submodule '%s' has dirty index"), path);
> +	}
> +
> +	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
> +		if (old) {
> +			if (!submodule_uses_gitfile(path))
> +				absorb_git_dir_into_superproject("", path,
> +					ABSORB_GITDIR_RECURSE_SUBMODULES);
> +		} else {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_addf(&sb, "%s/modules/%s",
> +				    get_git_common_dir(), sub->name);
> +			connect_work_tree_and_git_dir(path, sb.buf);
> +			strbuf_release(&sb);
> +
> +			/* make sure the index is clean as well */
> +			submodule_reset_index(path);
> +		}
> +	}
> +
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +
> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
> +	argv_array_pushl(&cp.args, "read-tree", NULL);
> +
> +	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
> +		argv_array_push(&cp.args, "-n");
> +	else
> +		argv_array_push(&cp.args, "-u");
> +
> +	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
> +		argv_array_push(&cp.args, "--reset");
> +	else
> +		argv_array_push(&cp.args, "-m");
> +
> +	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
> +	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
> +
> +	if (run_command(&cp)) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
> +		if (new) {
> +			struct child_process cp1 = CHILD_PROCESS_INIT;
> +			/* also set the HEAD accordingly */
> +			cp1.git_cmd = 1;
> +			cp1.no_stdin = 1;
> +			cp1.dir = path;
> +
> +			argv_array_pushl(&cp1.args, "update-ref", "HEAD",
> +					 new ? new : EMPTY_TREE_SHA1_HEX, NULL);
> +
> +			if (run_command(&cp1)) {
> +				ret = -1;
> +				goto out;
> +			}
> +		} else {
> +			struct strbuf sb = STRBUF_INIT;
> +
> +			strbuf_addf(&sb, "%s/.git", path);
> +			unlink_or_warn(sb.buf);
> +			strbuf_release(&sb);
> +
> +			if (is_empty_dir(path))
> +				rmdir_or_warn(path);
> +		}
> +	}
> +out:
> +	return ret;
> +}
> +
>  static int find_first_merges(struct object_array *result, const char *path,
>  		struct commit *a, struct commit *b)
>  {
> diff --git a/submodule.h b/submodule.h
> index 6f3fe85c7c..4cdf6445f7 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -96,6 +96,13 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
>  extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
>  extern int parallel_submodules(void);
>  
> +#define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
> +#define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
> +extern int submodule_move_head(const char *path,
> +			       const char *old,
> +			       const char *new,
> +			       unsigned flags);
> +
>  /*
>   * Prepare the "env_array" parameter of a "struct child_process" for executing
>   * a submodule by clearing any repo-specific envirionment variables, but
> -- 
> 2.12.0.rc1.45.g207f5fbb2b
> 

-- 
Brandon Williams

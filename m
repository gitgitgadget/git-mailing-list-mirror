Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FEC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 23:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiJZXed (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 19:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiJZXeb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 19:34:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157B102
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 16:34:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h9-20020a25e209000000b006cbc4084f2eso1045721ybe.23
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITAqOk0HIJFY+aJo9CqD2XNZPso1csvnDJeW933Xkh8=;
        b=W2/fKUjd+frsA7MCExPEwHa5hJXwymufIDkE0rbwc51O4XZJ/CUM9beqj4frMChLmK
         o4zodv/Ljc6W9Qo/124EYyl2tN3m9PJkx+6hSSrWOxJTR4FpHjcqRIWmJIeRXC7AV0QO
         UReeH8jHXCVwAJUt5Kduw6xWzlTy04AjY4I4dXKG10d2/idAI+b22xfzMdG7LzwMGamu
         UZSkZLvwv4avXQ6NsorV+sgiW3NfWVETmArQJ4BrFYxYfR5YZOxk1igpehyOm5ZjORcO
         DI2+W+ansVfbfgc4BUtG5LvbM2r8ANazn3Fnhy17E1WpG0maksSy7sDH+ZwY72lWZps8
         WtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITAqOk0HIJFY+aJo9CqD2XNZPso1csvnDJeW933Xkh8=;
        b=o861vTAyh09zd8pehDGfFqTsnLdkUlXA6aSDR6xR8vhBQxVWZ3Cjq7EvKeqbgs2HRS
         B234wfWnufSxYSjHcCoqrL8vp0oh9rXUSUsreNg23tOV2jILZkIj/fM2D4qGr9oQy9GO
         C73bPiiGjXDpTCZvfIGmmZvMt3SGOgJ9CxXceccWqKSMX+CDxzNL2pIpyZkQZfdUaFtj
         Z3o8zRbuGeGl3ylBhAFZ7/zLGZGLXYS7PG30JP4kJsRm25Tv7CUxoHw8XOsG137MqQON
         lu+YTdDms2/AKsRXoF3iYWuSduTyjxm6QcTtHvOES7HqIx6dDnBOqC2gcUI7VcFVX9f/
         h+jw==
X-Gm-Message-State: ACrzQf2GFZNJl3qOgm6HkSzUtnBQ+jZzntVtU/GA6hzplo5oTRwD+yb3
        5RioZES+0x3VWK17tnpXo7xBAfI++/m3qw==
X-Google-Smtp-Source: AMsMyM7UoVKjXbe19R+bIiiDDp584Utd+fdM4aXvfZFfwtKfylFHGXNxqR+7IOfRmh7GVAFJmAWhRJfqWlb36Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:8451:0:b0:6be:d8dc:20a7 with SMTP id
 r17-20020a258451000000b006bed8dc20a7mr1ybm.83.1666827263245; Wed, 26 Oct 2022
 16:34:23 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:34:21 -0700
In-Reply-To: <4672e3d958625cd76eb8056ab434e9a37f52661e.1665973401.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <4672e3d958625cd76eb8056ab434e9a37f52661e.1665973401.git.gitgitgadget@gmail.com>
Message-ID: <kl6lh6zqqhvm.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 8/9] archive: add --recurse-submodules to git-archive command
From:   Glen Choo <chooglen@google.com>
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> index 34549d849f1..f81ef741487 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -213,6 +214,25 @@ static void queue_directory(const struct object_id *oid,
>  	oidcpy(&d->oid, oid);
>  }
>  
> +static void queue_submodule(
> +		struct repository *superproject,
> +		const struct object_id *oid,
> +		struct strbuf *base, const char *filename,
> +		unsigned mode, struct archiver_context *c)
> +{
> +	struct repository subrepo;
> +
> +	if (repo_submodule_init(&subrepo, superproject, filename, null_oid()))
> +		return;
> +
> +	if (repo_read_index(&subrepo) < 0)
> +		die("index file corrupt");
> +
> +    queue_directory(oid, base, filename, mode, c);
> +
> +	repo_clear(&subrepo);
> +}
> +

This bit is puzzling to me because we init the submodule, read its
index, and then don't read objects from it at all. How does this work
when we aren't reading objects from the submodule we init here? My guess
is that read_tree() is already doing the heavy lifting of recursing into
submodules, so we don't need to worry any more about init-ing submodules
in archive.c, which is great.

So in effect, this is just checking whether we can read the submodule
and its index. We can drop this check since we already do that check in
read_tree().

What's much more surprising is that you can delete the entire function
body (even queue_directory()!) and the tests still pass! The tests are
definitely testing what they say they are (I've also checked the
tarballs), so I'm not sure what's going on.

I commented out queue_directory() in the S_ISDIR case, and the only test
failures I saw were:

- t5000.68, which uses a glob in its pathspec. I tried using a glob for
  in the archive submodule tests, but I couldn't reproduce the failure.
- t5004.11, which is a really big test case that I didn't bother looking
  deeply into.

So I'm at a loss as to what queue_directory() actually does. My best
guess at a reproduction would be to make a subdirectory in t5000.68 a
submodule. If we do find such a reproducing case, we should add it to
the test suite.

>  static int write_directory(
>  		struct repository *repo,
>  		struct archiver_context *c)
> @@ -228,9 +248,11 @@ static int write_directory(
>  		write_directory(repo, c) ||
>  		write_archive_entry(repo, &d->oid, d->path, d->baselen,
>  				    d->path + d->baselen, d->mode,
> -				    c) != READ_TREE_RECURSIVE;
> +				    c);
>  	free(d);
> -	return ret ? -1 : 0;
> +	if (ret == READ_TREE_RECURSIVE)
> +		return 0;
> +	return ret;
>  }
>  
>  static int queue_or_write_archive_entry(
> @@ -263,6 +285,11 @@ static int queue_or_write_archive_entry(
>  			return 0;
>  		queue_directory(oid, base, filename, mode, c);
>  		return READ_TREE_RECURSIVE;
> +	} else if (c->args->recurse_submodules && S_ISGITLINK(mode)) {
> +		if (is_submodule_active(r, filename)) {
> +			queue_submodule(r, oid, base, filename, mode, c);
> +			return READ_TREE_RECURSIVE;
> +		}

If we are omitting inactive submodules from the archive, we should test
this behavior.

>  	}
>  
>  	if (write_directory(r, c))
> @@ -446,6 +473,7 @@ static void parse_pathspec_arg(
>  		       PATHSPEC_PREFER_FULL,
>  		       "", pathspec);
>  	ar_args->pathspec.recursive = 1;
> +	ar_args->pathspec.recurse_submodules = ar_args->recurse_submodules;
>  	if (pathspec) {
>  		while (*pathspec) {
>  			if (**pathspec && !path_exists(repo, ar_args, *pathspec))
> @@ -609,6 +637,7 @@ static int parse_archive_args(int argc, const char **argv,
>  	int verbose = 0;
>  	int i;
>  	int list = 0;
> +	int recurse_submodules = 0;
>  	int worktree_attributes = 0;
>  	struct option opts[] = {
>  		OPT_GROUP(""),
> @@ -623,6 +652,8 @@ static int parse_archive_args(int argc, const char **argv,
>  		  add_file_cb, (intptr_t)&base },
>  		OPT_STRING('o', "output", &output, N_("file"),
>  			N_("write the archive to this file")),
> +		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
> +			N_("include submodules in archive")),
>  		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
>  			N_("read .gitattributes in working directory")),
>  		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
> @@ -686,6 +717,7 @@ static int parse_archive_args(int argc, const char **argv,
>  	args->verbose = verbose;
>  	args->base = base;
>  	args->baselen = strlen(base);
> +	args->recurse_submodules = recurse_submodules;
>  	args->worktree_attributes = worktree_attributes;
>  
>  	return argc;
> diff --git a/archive.h b/archive.h
> index 540a3b12130..1b21484dda6 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -18,6 +18,7 @@ struct archiver_args {
>  	timestamp_t time;
>  	struct pathspec pathspec;
>  	unsigned int verbose : 1;
> +	unsigned int recurse_submodules : 1;
>  	unsigned int worktree_attributes : 1;
>  	unsigned int convert : 1;
>  	int compression_level;
> -- 
> gitgitgadget

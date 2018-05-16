Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A6B1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeEPW1h (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:27:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43441 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeEPW1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:27:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id p8-v6so887141pgq.10
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VK5ar9e4iXPU7J8+I1R1IhpMr22qPdVLwMisnEiDfU=;
        b=kqBu41gboSQwZOyCtFnPev1+ZJia6U7St5bEodntSNsTUhDMCtjTHiDa/zkVIgtwPo
         GMPLDGz7Vb4qOlDpMMXPJu0TDzI3iBHcFHjanxhQZ9nnMKcDTUa2KKI3Zc/6O04XvgP9
         e/kRHk2fhQTU5ZLOq2G2RqHKwD18BtfhNcYSkzM8c2kzsw9WbkF9LlXYb+J9nAlAMTdU
         5N1Fg2/sKxChsZGvQjG+uB80sYuWawKHdcdCC4plfYOezWoKI2hnZrsm51DPrZakBrXZ
         ODwlg/bOc6TVmnVy6K0/8KVlAgCqvhSlrBOK4ZPtOcQTHC6ePBuN32zMdp7pyQNoCU9M
         g6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VK5ar9e4iXPU7J8+I1R1IhpMr22qPdVLwMisnEiDfU=;
        b=tG/jM+SuAsX85gCiOz6yqkyztdUM7hF7d2oPzCCdineqsTr0dmseEkWIF+Nd/zh8oH
         SOI/GOfivBlcdGUOucfNYPj1ntZuA50zjONWpXPm4Fj/S1Cs19PE7TNuaUZASKTltizo
         CXdl1K57SmmUV4L4Q66g0JHt49UrpdUzmCEX3NRR0y5rBdG2tM56AtMSNiPxE9m0lPak
         YEjG97tMNe0FJrjQ5v0+5B/aL5vz66LuWFE5VaST3/BdxEnSlclRcUDR6RxpL3VF6Yhp
         /trsDjggvJko/Lw1thi4SyQhxRHPc47RcZ5CvqeWM7BBP8U682fhg1IJTUh3fxosXcE6
         EWww==
X-Gm-Message-State: ALKqPweckAzRpnd3EsX0U7e2NRF2o4tua9oZIKY/k/0SoJlvFdBK0KvW
        Gt5Ff0IlXlqi3jNEKKB3CWCV5VPIflY=
X-Google-Smtp-Source: AB8JxZoJZFzpC6q9Zpk/Z5RT91VIkCtIhwux9Xx7SM9OGQAqbeKU4SHnnHRiKSam9xUOGTetp8/Q1A==
X-Received: by 2002:a65:5bcc:: with SMTP id o12-v6mr2113227pgr.449.1526509655964;
        Wed, 16 May 2018 15:27:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p24-v6sm7084679pfk.58.2018.05.16.15.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:27:34 -0700 (PDT)
Date:   Wed, 16 May 2018 15:27:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, ao2@ao2.it, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 11/11] read_cache: convert most calls to
 repo_read_index_or_die
Message-ID: <20180516222733.GB60301@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
 <20180516222118.233868-12-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516222118.233868-12-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/16, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  blame.c               | 5 +++--
>  builtin/am.c          | 3 ++-
>  builtin/diff.c        | 3 ++-
>  builtin/fsck.c        | 3 ++-
>  builtin/merge-index.c | 3 ++-
>  check-racy.c          | 2 +-
>  diff.c                | 5 +++--
>  merge-recursive.c     | 3 ++-
>  revision.c            | 5 +++--
>  sequencer.c           | 5 +++--
>  sha1-name.c           | 2 +-
>  11 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/blame.c b/blame.c
> index 78c9808bd1a..ebfa1c8efcd 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -5,6 +5,7 @@
>  #include "diff.h"
>  #include "diffcore.h"
>  #include "tag.h"
> +#include "repository.h"
>  #include "blame.h"
>  
>  void blame_origin_decref(struct blame_origin *o)
> @@ -159,7 +160,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  	unsigned mode;
>  	struct strbuf msg = STRBUF_INIT;
>  
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  	time(&now);
>  	commit = alloc_commit_node();
>  	commit->object.parsed = 1;
> @@ -241,7 +242,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  	 * want to run "diff-index --cached".
>  	 */
>  	discard_cache();
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  
>  	len = strlen(path);
>  	if (!mode) {
> diff --git a/builtin/am.c b/builtin/am.c
> index d834f9e62b6..3c6e77a5369 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -32,6 +32,7 @@
>  #include "apply.h"
>  #include "string-list.h"
>  #include "packfile.h"
> +#include "repository.h"
>  
>  /**
>   * Returns 1 if the file is empty or does not exist, 0 otherwise.
> @@ -1581,7 +1582,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
>  	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
>  
>  	discard_cache();
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  
>  	/*
>  	 * This is not so wrong. Depending on which base we picked, orig_tree
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 16bfb22f738..4bba211f1c7 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -17,6 +17,7 @@
>  #include "builtin.h"
>  #include "submodule.h"
>  #include "sha1-array.h"
> +#include "repository.h"
>  
>  #define DIFF_NO_INDEX_EXPLICIT 1
>  #define DIFF_NO_INDEX_IMPLICIT 2
> @@ -210,7 +211,7 @@ static void refresh_index_quietly(void)
>  	if (fd < 0)
>  		return;
>  	discard_cache();
> -	read_cache();
> +	repo_read_index(the_repository); /* do not die on error */
>  	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
>  	update_index_if_able(&the_index, &lock_file);
>  }
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 087360a6757..a42e98235da 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -18,6 +18,7 @@
>  #include "decorate.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "repository.h"
>  
>  #define REACHABLE 0x0001
>  #define SEEN      0x0002
> @@ -795,7 +796,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  	if (keep_cache_objects) {
>  		verify_index_checksum = 1;
>  		verify_ce_order = 1;
> -		read_cache();
> +		repo_read_index_or_die(the_repository);
>  		for (i = 0; i < active_nr; i++) {
>  			unsigned int mode;
>  			struct blob *blob;
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index c99443b095b..2d91c7c3b5e 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "run-command.h"
> +#include "repository.h"
>  
>  static const char *pgm;
>  static int one_shot, quiet;
> @@ -77,7 +78,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
>  	if (argc < 3)
>  		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
>  
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  
>  	i = 1;
>  	if (!strcmp(argv[i], "-o")) {
> diff --git a/check-racy.c b/check-racy.c
> index 24b6542352a..9b884639cf4 100644
> --- a/check-racy.c
> +++ b/check-racy.c
> @@ -6,7 +6,7 @@ int main(int ac, char **av)
>  	int dirty, clean, racy;
>  
>  	dirty = clean = racy = 0;
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  	for (i = 0; i < active_nr; i++) {
>  		struct cache_entry *ce = active_cache[i];
>  		struct stat st;
> diff --git a/diff.c b/diff.c
> index 1289df4b1f9..383f52fa118 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -22,6 +22,7 @@
>  #include "argv-array.h"
>  #include "graph.h"
>  #include "packfile.h"
> +#include "repository.h"
>  
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -4210,13 +4211,13 @@ void diff_setup_done(struct diff_options *options)
>  		options->rename_limit = diff_rename_limit_default;
>  	if (options->setup & DIFF_SETUP_USE_CACHE) {
>  		if (!active_cache)
> -			/* read-cache does not die even when it fails
> +			/* repo_read_indexe does not die even when it fails

s/repo_read_indexe/repo_read_index

>  			 * so it is safe for us to do this here.  Also
>  			 * it does not smudge active_cache or active_nr
>  			 * when it fails, so we do not have to worry about
>  			 * cleaning it up ourselves either.
>  			 */
> -			read_cache();
> +			repo_read_index(the_repository);
>  	}
>  	if (40 < options->abbrev)
>  		options->abbrev = 40; /* full */
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 0c0d48624da..76911c935c3 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2151,7 +2151,8 @@ int merge_recursive(struct merge_options *o,
>  
>  	discard_cache();
>  	if (!o->call_depth)
> -		read_cache();
> +		if (read_cache() < 0)
> +			return err(o, _("index file corrupt"));

if we're already moving to change read_cache() calls then we could
substitute it for repo_read_index here as well.

Maybe we can kill read_cache() while at it?

>  
>  	o->ancestor = "merged common ancestors";
>  	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
> diff --git a/revision.c b/revision.c
> index 1cff11833e7..8ad9824143d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -23,6 +23,7 @@
>  #include "packfile.h"
>  #include "worktree.h"
>  #include "argv-array.h"
> +#include "repository.h"
>  
>  volatile show_early_output_fn_t show_early_output;
>  
> @@ -1344,7 +1345,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
>  {
>  	struct worktree **worktrees, **p;
>  
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  	do_add_index_objects_to_pending(revs, &the_index);
>  
>  	if (revs->single_worktree)
> @@ -1486,7 +1487,7 @@ static void prepare_show_merge(struct rev_info *revs)
>  	head->object.flags |= SYMMETRIC_LEFT;
>  
>  	if (!active_nr)
> -		read_cache();
> +		repo_read_index_or_die(the_repository);
>  	for (i = 0; i < active_nr; i++) {
>  		const struct cache_entry *ce = active_cache[i];
>  		if (!ce_stage(ce))
> diff --git a/sequencer.c b/sequencer.c
> index 4ce5120e777..773165c8cde 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -23,6 +23,7 @@
>  #include "hashmap.h"
>  #include "notes-utils.h"
>  #include "sigchain.h"
> +#include "repository.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -432,7 +433,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf err = STRBUF_INIT;
>  
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  	if (checkout_fast_forward(from, to, 1))
>  		return -1; /* the callee should have complained already */
>  
> @@ -489,7 +490,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
>  		return -1;
>  
> -	read_cache();
> +	repo_read_index_or_die(the_repository);
>  
>  	init_merge_options(&o);
>  	o.ancestor = base ? base_label : "(empty tree)";
> diff --git a/sha1-name.c b/sha1-name.c
> index 5b93bf8da36..83d5f945cf1 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1639,7 +1639,7 @@ static int get_oid_with_context_1(const char *name,
>  			oc->path = xstrdup(cp);
>  
>  		if (!active_cache)
> -			read_cache();
> +			repo_read_index_or_die(the_repository);
>  		pos = cache_name_pos(cp, namelen);
>  		if (pos < 0)
>  			pos = -pos - 1;
> -- 
> 2.17.0.582.gccdcbd54c44.dirty
> 

-- 
Brandon Williams

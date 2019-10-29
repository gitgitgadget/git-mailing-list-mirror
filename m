Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03301F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 23:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfJ2X5n (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 19:57:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44266 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfJ2X5m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 19:57:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so179890pgd.11
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lW1xECIMtVR1TASOvQBfeqjJMLXeC+94oukf5DGAWh4=;
        b=FGm8ht0g2nIqpyflJhF/ai8bNc+PvLcGrt9p4Fy8E/wtV9/1u4KVQVGTLUiNeOcvMO
         S9CDZ2pCqRhv5Zi29qBLIA5ZrZ0qRpuPu5JzA4pJ8B+JQcK8hHOsejc/M1DTWH31TjbK
         FRxrx0VkXRB03Qb1jkKZ8pjdzNjCitEr0f2pwnZuF/273V18MNgGU/d5d5TBO4EwH/FJ
         S4lCacyXw9b8oQvbzSZSwm3q+eZrIT1ilG57hLvlb8QDz+7QAdJdQt60ou+7ejZ2MeX5
         qX/UIZPp0bp06P/vzF0JJGjzJ6RY0+j8hIX4Rv/glsho3/RvJMUZ8Xlq03S9EY3oqwnm
         tv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lW1xECIMtVR1TASOvQBfeqjJMLXeC+94oukf5DGAWh4=;
        b=D/K7/95jhvMbqwSZbIeAanyHFeakREoanIx+rFDaR2BZDq17n8HmP+MUr0LQRV8mAM
         ubTlKpPCMwNEGrUcO7eNHhKoiXLv5PFlXGhjC74D+bo5fSe+jxrvCfSNBmnc3odOvIOf
         zoiKLMywKKNS5MZET0kFgCnSQhWlmDAdPzmv9QafsnyQognZV15fwc1uuWLhMt8zsN8+
         mNeXSVXtZdGfHpgDveQlGydx17Ixbi+GslBs1l5gijqFMc+t8KGHJ06RGkBRiE8Ma6tx
         SCXE51tfMyDKFT3yUmN+BrsRypjznEcu1A10HwYcUBLoae7FxyZRlwbIe2/LZw7Bg7eC
         SoGQ==
X-Gm-Message-State: APjAAAUwtAa2RBwITfyneJWwS129oWxaMIX5pF/rZgPJhCQeoB+viaCK
        Gz/y4zI6xKvqd+GvzL5oipcjKg==
X-Google-Smtp-Source: APXvYqwKSKHKaMlCS2I34yk6QIYbmMTom/VVbUAv7WM6l+YzdQmMrIGhbDVfl8ZwkXcLSt6y04QoRQ==
X-Received: by 2002:a62:3387:: with SMTP id z129mr29100584pfz.253.1572393461096;
        Tue, 29 Oct 2019 16:57:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id o123sm229594pfg.161.2019.10.29.16.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:57:40 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:57:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] revision: move doc to revision.h
Message-ID: <20191029235736.GB229589@google.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <afab6d5f4ed8cbe8e6dcba9a50282a471b542b13.1572343246.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afab6d5f4ed8cbe8e6dcba9a50282a471b542b13.1572343246.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 10:00:45AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-revision-walking.txt
> to revision.h as it's easier for the developers to find the usage
> information beside the code instead of looking for it in another doc file.
> 
> Also documentation/technical/api-revision-walking.txt is removed because the
> information it has is now redundant and it'll be hard to keep it up to
> date and synchronized with the documentation in the header file.

This commit looks nice to me.

It also looks like new work for me to update
Documentation/MyFirstObjectWalk.txt to reflect this when it's merged
later :)

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  .../technical/api-revision-walking.txt        | 72 -------------------
>  revision.h                                    | 59 +++++++++++++++
>  2 files changed, 59 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/technical/api-revision-walking.txt
> 
> diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
> deleted file mode 100644
> index 03f9ea6ac4..0000000000
> --- a/Documentation/technical/api-revision-walking.txt
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -revision walking API
> -====================
> -
> -The revision walking API offers functions to build a list of revisions
> -and then iterate over that list.
> -
> -Calling sequence
> -----------------
> -
> -The walking API has a given calling sequence: first you need to
> -initialize a rev_info structure, then add revisions to control what kind
> -of revision list do you want to get, finally you can iterate over the
> -revision list.
> -
> -Functions
> ----------
> -
> -`repo_init_revisions`::
> -
> -	Initialize a rev_info structure with default values. The third
> -	parameter may be NULL or can be prefix path, and then the `.prefix`
> -	variable will be set to it. This is typically the first function you
> -	want to call when you want to deal with a revision list. After calling
> -	this function, you are free to customize options, like set
> -	`.ignore_merges` to 0 if you don't want to ignore merges, and so on. See
> -	`revision.h` for a complete list of available options.
> -
> -`add_pending_object`::
> -
> -	This function can be used if you want to add commit objects as revision
> -	information. You can use the `UNINTERESTING` object flag to indicate if
> -	you want to include or exclude the given commit (and commits reachable
> -	from the given commit) from the revision list.
> -+
> -NOTE: If you have the commits as a string list then you probably want to
> -use setup_revisions(), instead of parsing each string and using this
> -function.
> -
> -`setup_revisions`::
> -
> -	Parse revision information, filling in the `rev_info` structure, and
> -	removing the used arguments from the argument list. Returns the number
> -	of arguments left that weren't recognized, which are also moved to the
> -	head of the argument list. The last parameter is used in case no
> -	parameter given by the first two arguments.
> -
> -`prepare_revision_walk`::
> -
> -	Prepares the rev_info structure for a walk. You should check if it
> -	returns any error (non-zero return code) and if it does not, you can
> -	start using get_revision() to do the iteration.
> -
> -`get_revision`::
> -
> -	Takes a pointer to a `rev_info` structure and iterates over it,
> -	returning a `struct commit *` each time you call it. The end of the
> -	revision list is indicated by returning a NULL pointer.
> -
> -`reset_revision_walk`::
> -
> -	Reset the flags used by the revision walking api. You can use
> -	this to do multiple sequential revision walks.
> -
> -Data structures
> ----------------
> -
> -Talk about <revision.h>, things like:
> -
> -* two diff_options, one for path limiting, another for output;
> -* remaining functions;
> -
> -(Linus, JC, Dscho)
> diff --git a/revision.h b/revision.h
> index 4134dc6029..983ffc0f12 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -9,6 +9,19 @@
>  #include "diff.h"
>  #include "commit-slab-decl.h"
>  
> +/**
> + * The revision walking API offers functions to build a list of revisions
> + * and then iterate over that list.
> + *
> + * Calling sequence
> + * ----------------
> + *
> + * The walking API has a given calling sequence: first you need to initialize
> + * a rev_info structure, then add revisions to control what kind of revision
> + * list do you want to get, finally you can iterate over the revision list.
> + *
> + */
> +
>  /* Remember to update object flag allocation in object.h */
>  #define SEEN		(1u<<0)
>  #define UNINTERESTING   (1u<<1)
> @@ -306,11 +319,29 @@ struct setup_revision_opt {
>  #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
>  #define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
>  #endif
> +
> +/**
> + * Initialize a rev_info structure with default values. The third parameter may
> + * be NULL or can be prefix path, and then the `.prefix` variable will be set
> + * to it. This is typically the first function you want to call when you want
> + * to deal with a revision list. After calling this function, you are free to
> + * customize options, like set `.ignore_merges` to 0 if you don't want to
> + * ignore merges, and so on.
> + */
>  void repo_init_revisions(struct repository *r,
>  			 struct rev_info *revs,
>  			 const char *prefix);
> +
> +/**
> + * Parse revision information, filling in the `rev_info` structure, and
> + * removing the used arguments from the argument list. Returns the number
> + * of arguments left that weren't recognized, which are also moved to the
> + * head of the argument list. The last parameter is used in case no
> + * parameter given by the first two arguments.
> + */
>  int setup_revisions(int argc, const char **argv, struct rev_info *revs,
>  		    struct setup_revision_opt *);
> +
>  void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>  			const struct option *options,
>  			const char * const usagestr[]);
> @@ -319,9 +350,26 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>  int handle_revision_arg(const char *arg, struct rev_info *revs,
>  			int flags, unsigned revarg_opt);
>  
> +/**
> + * Reset the flags used by the revision walking api. You can use this to do
> + * multiple sequential revision walks.
> + */
>  void reset_revision_walk(void);
> +
> +/**
> + * Prepares the rev_info structure for a walk. You should check if it returns
> + * any error (non-zero return code) and if it does not, you can start using
> + * get_revision() to do the iteration.
> + */
>  int prepare_revision_walk(struct rev_info *revs);
> +
> +/**
> + * Takes a pointer to a `rev_info` structure and iterates over it, returning a
> + * `struct commit *` each time you call it. The end of the revision list is
> + * indicated by returning a NULL pointer.
> + */
>  struct commit *get_revision(struct rev_info *revs);
> +
>  char *get_revision_mark(const struct rev_info *revs,
>  			const struct commit *commit);
>  void put_revision_mark(const struct rev_info *revs,
> @@ -333,8 +381,19 @@ void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees)
>  
>  void show_object_with_name(FILE *, struct object *, const char *);
>  
> +/**
> + * This function can be used if you want to add commit objects as revision
> + * information. You can use the `UNINTERESTING` object flag to indicate if
> + * you want to include or exclude the given commit (and commits reachable
> + * from the given commit) from the revision list.
> + *
> + * NOTE: If you have the commits as a string list then you probably want to
> + * use setup_revisions(), instead of parsing each string and using this
> + * function.
> + */
>  void add_pending_object(struct rev_info *revs,
>  			struct object *obj, const char *name);
> +
>  void add_pending_oid(struct rev_info *revs,
>  		     const char *name, const struct object_id *oid,
>  		     unsigned int flags);
> -- 
> gitgitgadget
> 

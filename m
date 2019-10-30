Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94B61F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfJ3WJz (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:09:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38396 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfJ3WJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:09:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so3423351oie.5
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqFCxAbW4LPDywf4FkNwUXp2rVfA2cgCqykzbdEuqes=;
        b=JOiQgq+JFxvtujfrgtf8r7xmNe/b3r3/OpbBX44XjDieX9jERLegqxcLHMBI8Jwkr2
         fM5cuIQhiqoBmUtAKKuhmxqZkxgpz9wBU3wZhryxwrkDCAYGJaQlSBGZZCl6BERgtrgk
         l1zwZNbvBQ7yakc2IRnQHraJDYPPACbH9LVfYNuxyVn3hoS572z5TI+5rlHOkVAqpZnY
         71sjrakfj6i/SH8a9dP17UKFUg6+l9/fIJgoKzRL0yBYTZuRO0GMRurecd6k6CzqfnWg
         p17yfsIlVY0QBm14VUsiuB4NHjMMMtUipUIsLQLDBw7blS6G40rqw+2+pDX02CM5YSs7
         QjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqFCxAbW4LPDywf4FkNwUXp2rVfA2cgCqykzbdEuqes=;
        b=buPAnw93oM2sVylHtASVkYU4RHdAkuXvvXpT3wam3d2yThlos5ZraDJjaWJmne8KyE
         KueKv0Wmt0etpqUqucGBnr5XiPrrKo8pIxhIarrJcn+kvHMf5CeWYx/JLLI0w7QqLGgH
         ouJJb523hDu+7b526ma9PBc87d59LONIk+TYBc5c63hsLTDAzkyRG8cJuvZwdjqUM4yk
         E0nlY9vap4Dd2LzdIyRa4hMb2pcD7fQhRSsVQgYPUzYDCKjbp4euhQM2yR1ng57OxBoP
         fcqnJRJhH0aZ6BSJNgt7YdAlOxrD9zj4gaQ5X5ebHZOdhFeDtIj1bgFIws2qKtyCAmHy
         q/HA==
X-Gm-Message-State: APjAAAX9/2zkbhIEHEBWvxcaFia72+/uu8yDLkxZIZ0nnFgJiiSYb66h
        oY4rHNA2XVusNyfWVq/UrSqaTradukRO0/RmF9U=
X-Google-Smtp-Source: APXvYqz2l8syaBLecnJUjHJlqmd4T03llfrRujeNDuEuj9lnO8z27AJkSMnojCgmvX0aCT6AuJrKxtcfwi5iMaENAbo=
X-Received: by 2002:aca:dd02:: with SMTP id u2mr1284856oig.39.1572473394124;
 Wed, 30 Oct 2019 15:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com> <504f1f7c892c8bfc4774ac5fec912855e74e38a5.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <504f1f7c892c8bfc4774ac5fec912855e74e38a5.1572343246.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Oct 2019 15:09:42 -0700
Message-ID: <CABPp-BEYeCwTKXLTdaORrBGAFYb0X13rMMiQXwXv=UDSBKHnYQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] merge: move doc to ll-merge.h
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heba,

Thanks for the contribution.  I know you weren't the original author
of most this stuff, but I was curious if it really all belonged in
ll-merge.c and then noticed other issues...

On Tue, Oct 29, 2019 at 11:49 AM Heba Waly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
[...]
> diff --git a/ll-merge.h b/ll-merge.h
> index e78973dd55..ec3617c627 100644
> --- a/ll-merge.h
> +++ b/ll-merge.h
> @@ -7,16 +7,94 @@
>
>  #include "xdiff/xdiff.h"
>
> +/**
> + * The merge API helps a program to reconcile two competing sets of

Is this talking about xdiff/xmerge.c, ll_merge.c, merge-recursive.c,
or builtin/merge.c?  Those are all different level of "merge API" and
it's not clear.  Perhaps "The Low Level Merge API" or something like
that since you are moving it into ll-merge.h?

> + * improvements to some files (e.g., unregistered changes from the work
> + * tree versus changes involved in switching to a new branch), reporting
> + * conflicts if found.

Seems weird to bring up checkout -m without mentioning in by name
given that it isn't the default checkout behavior.  Would seem more
natural to mention a merge or rebase case.

> + *   The library called through this API is
> + * responsible for a few things.
> + *
> + *  - determining which trees to merge (recursive ancestor consolidation);

Um, that's done at the merge-recursive.c level, not at the ll-merge.c
level.  I'm confused why it'd be mentioned here.

> + *  - lining up corresponding files in the trees to be merged (rename
> + *    detection, subtree shifting), reporting edge cases like add/add
> + *    and rename/rename conflicts to the user;

All of that is also clearly stuff for merge-recursive.c; I'm not sure
why it'd be mentioned in the Low-Level merge file.

> + *  - performing a three-way merge of corresponding files, taking
> + *    path-specific merge drivers (specified in `.gitattributes`)
> + *    into account.

This, however, is ll-merge.c stuff.

> + *
> + * Calling sequence:
> + * ----------------
> + *
> + * - Prepare a `struct ll_merge_options` to record options.
> + *   If you have no special requests, skip this and pass `NULL`
> + *   as the `opts` parameter to use the default options.
> + *
> + * - Allocate an mmbuffer_t variable for the result.
> + *
> + * - Allocate and fill variables with the file's original content
> + *   and two modified versions (using `read_mmfile`, for example).
> + *
> + * - Call `ll_merge()`.
> + *
> + * - Read the merged content from `result_buf.ptr` and `result_buf.size`.
> + *
> + * - Release buffers when finished.  A simple
> + *   `free(ancestor.ptr); free(ours.ptr); free(theirs.ptr);
> + *   free(result_buf.ptr);` will do.
> + *
> + * If the modifications do not merge cleanly, `ll_merge` will return a
> + * nonzero value and `result_buf` will generally include a description of
> + * the conflict bracketed by markers such as the traditional `<<<<<<<`
> + * and `>>>>>>>`.
> + *
> + * The `ancestor_label`, `our_label`, and `their_label` parameters are
> + * used to label the different sides of a conflict if the merge driver
> + * supports this.
> + */

This part looks good.

> +/**
> + * This describes the set of options the calling program wants to affect
> + * the operation of a low-level (single file) merge.
> + */
>  struct ll_merge_options {
> +
> +    /**
> +     * Behave as though this were part of a merge between common ancestors in
> +     * a recursive merge. If a helper program is specified by the
> +        * `[merge "<driver>"] recursive` configuration, it will be used.
> +     */

This kind of leaves out the why.  Maybe add "(merges of binary files
may need to be handled differently in such cases, for example)" to the
end of the first sentence?

>         unsigned virtual_ancestor : 1;
> -       unsigned variant : 2;   /* favor ours, favor theirs, or union merge */
> +
> +       /**
> +        * Resolve local conflicts automatically in favor of one side or the other
> +        * (as in 'git merge-file' `--ours`/`--theirs`/`--union`).  Can be `0`,
> +        * `XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`,
> +        * or `XDL_MERGE_FAVOR_UNION`.
> +        */
> +       unsigned variant : 2;
> +
> +       /**
> +        * Resmudge and clean the "base", "theirs" and "ours" files before merging.
> +        * Use this when the merge is likely to have overlapped with a change in
> +        * smudge/clean or end-of-line normalization rules.
> +        */
>         unsigned renormalize : 1;

All looks good.

> +
>         unsigned extra_marker_size;

No documentation for this one?  Perhaps:

/*
 * Increase the length of conflict markers so that nested conflicts
 * can be differentiated.
 */

>         long xdl_opts;

Perhaps document this one with:

/* Extra xpparam_t flags as defined in xdiff/xdiff.h. */



>  };
>
> +/**
> + * Perform a three-way single-file merge in core.  This is a thin wrapper
> + * around `xdl_merge` that takes the path and any merge backend specified in
> + * `.gitattributes` or `.git/info/attributes` into account.
> + * Returns 0 for a clean merge.
> + */
>  int ll_merge(mmbuffer_t *result_buf,
>              const char *path,
>              mmfile_t *ancestor, const char *ancestor_label,

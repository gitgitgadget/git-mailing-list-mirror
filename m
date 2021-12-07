Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B2C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhLGRJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhLGRJr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:09:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE3C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:06:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so59499217edc.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdGk4l3wWbtCdWXKi3xgeb8DFYXBq7zeiIGlhwoZuGg=;
        b=c1Yx9D7gqyMwDiRAQnoJRD1DRS+Guzmw4xzjF+MABXWLQkM+lCpuLeg5E8e5T3jV0e
         3uH8XXHjBpxjtz0qvt3nQYkSk0IOknbBymLSPVIXqh9iXxKdiV9wjBrMJ8OGrz2w8HM6
         cPScu0ZEIQg3LJlEoUlaI9xJFlLbrjLD8jC+CmqTApR/Dn69/Erm3aqwnwY3xtRzEnLv
         0mxfURkedGsV1ppkKncsxhhyjFwWnGuBI9w30m0smm5XvGnedTwcm/dNTi7kVRNpf/+Y
         zM911KrkVirSRDO1IQSQR5Iq9KryzmREqhOL6HH3ZBllqMEnPwvaNBSVuTdfKrzUOk40
         +jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdGk4l3wWbtCdWXKi3xgeb8DFYXBq7zeiIGlhwoZuGg=;
        b=QHJSDmxpkijoylM0jQi2plYLs1C/upVd8A04RkjxOJ6pcYFiygeYPfkbq3PRAPMmL7
         +ZIM3RqKRCIE1w0LaUPEOzsEIKFotxMPQUE972geLVcL4Q7VwoBXrofACTL+N+ve3TzC
         6TKXFSKTwYdcrK2Zzt/rM9DCRcqv+KILf/y0sTAUfWCsoUfQ+T+/843WhBOOWi8DeU//
         9Ilvc4xcOOuTQ4z5xPdaC+Xryt62Tvdh2lhdv3mDzxF7vO9xvczzWIjwTgkHml+NkvD6
         ZS8+ZDgRYuwJ9lUj+MygnWq2PqPRGWXwbdfOTvtgT5CpLXCdLK8BfgqKhWOgs6A92+yZ
         9XOQ==
X-Gm-Message-State: AOAM530WTlLuXX/p9m/K0kik8V7EW8EYiNIupcY3hEFZcJNfVBEmS64S
        Um8cd0Qv1I7DjB6wvnzUGFVuPRjqfvUi2x9nAwI=
X-Google-Smtp-Source: ABdhPJzMatJVncNkhCdLXo25T17EilA/A5YC7zVjhNo31OoxU9dtGlyU9VOfiGgFOANjzUXvyT3yxRG26eOYtd4TjzM=
X-Received: by 2002:a17:906:7209:: with SMTP id m9mr719242ejk.434.1638896775360;
 Tue, 07 Dec 2021 09:06:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <95d3df78b2ffe2e0d6234f326f8f7acbd2b67301.1638648020.git.gitgitgadget@gmail.com>
 <9e4e34c9-5485-c10d-48b6-a1a6f5e12486@github.com>
In-Reply-To: <9e4e34c9-5485-c10d-48b6-a1a6f5e12486@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 09:06:03 -0800
Message-ID: <CABPp-BG=uO0bcUTDhy07Wv1bQRD4yGy+4Mrfp=XGCpzRoTWPPA@mail.gmail.com>
Subject: Re: [PATCH 4/6] git-sparse-checkout.txt: update to document that set
 handles init
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 4, 2021 at 1:48 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > As noted in the previous commit, using separate `init` and `set` steps
> > with sparse-checkout result in a number of issues.  The previous commit
> > made `set` able to handle the work of both commands.  Update the
> > documentation to reflect this, and mark `init` as deprecated.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-sparse-checkout.txt | 92 ++++++++++++++-------------
> >  1 file changed, 49 insertions(+), 43 deletions(-)
> >
> > diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> > index 42056ee9ff9..d22c925ecf8 100644
> > --- a/Documentation/git-sparse-checkout.txt
> > +++ b/Documentation/git-sparse-checkout.txt
> > @@ -30,28 +30,35 @@ COMMANDS
> >  'list'::
> >       Describe the patterns in the sparse-checkout file.
> >
> > -'init'::
> > -     Enable the `core.sparseCheckout` setting. If the
> > -     sparse-checkout file does not exist, then populate it with
> > -     patterns that match every file in the root directory and
> > -     no other directories, then will remove all directories tracked
> > -     by Git. Add patterns to the sparse-checkout file to
> > -     repopulate the working directory.
> > +'set'::
> > +     Enable the necessary config settings
> > +     (extensions.worktreeConfig, core.sparseCheckout,
> > +     core.sparseCheckoutCone) if they are not already enabled, and
> > +     write a set of patterns to the sparse-checkout file from the
> > +     list of arguments following the 'set' subcommand. Update the
> > +     working directory to match the new patterns.
> >  +
> > -To avoid interfering with other worktrees, it first enables the
> > -`extensions.worktreeConfig` setting and makes sure to set the
> > -`core.sparseCheckout` setting in the worktree-specific config file.
> > +When the `--stdin` option is provided, the patterns are read from
> > +standard in as a newline-delimited list instead of from the arguments.
> >  +
> > -When `--cone` is provided, the `core.sparseCheckoutCone` setting is
> > -also set, allowing for better performance with a limited set of
> > -patterns (see 'CONE PATTERN SET' below).
> > +When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
> > +input list is considered a list of directories instead of
> > +sparse-checkout patterns.  This allows for better performance with a
> > +limited set of patterns (see 'CONE PATTERN SET' below).  Note that the
> > +set command will write patterns to the sparse-checkout file to include
> > +all files contained in those directories (recursively) as well as
> > +files that are siblings of ancestor directories. The input format
> > +matches the output of `git ls-tree --name-only`.  This includes
> > +interpreting pathnames that begin with a double quote (") as C-style
> > +quoted strings.
> >  +
> > -Use the `--[no-]sparse-index` option to toggle the use of the sparse
> > -index format. This reduces the size of the index to be more closely
> > -aligned with your sparse-checkout definition. This can have significant
> > -performance advantages for commands such as `git status` or `git add`.
> > -This feature is still experimental. Some commands might be slower with
> > -a sparse index until they are properly integrated with the feature.
> > +Use the `--[no-]sparse-index` option to use a sparse index (the
> > +default is to not use it).  A sparse index reduces the size of the
> > +index to be more closely aligned with your sparse-checkout
> > +definition. This can have significant performance advantages for
> > +commands such as `git status` or `git add`.  This feature is still
> > +experimental. Some commands might be slower with a sparse index until
> > +they are properly integrated with the feature.
> >  +
> >  **WARNING:** Using a sparse index requires modifying the index in a way
> >  that is not completely understood by external tools. If you have trouble
> > @@ -60,23 +67,6 @@ to rewrite your index to not be sparse. Older versions of Git will not
> >  understand the sparse directory entries index extension and may fail to
> >  interact with your repository until it is disabled.
> >
> > -'set'::
> > -     Write a set of patterns to the sparse-checkout file, as given as
> > -     a list of arguments following the 'set' subcommand. Update the
> > -     working directory to match the new patterns. Enable the
> > -     core.sparseCheckout config setting if it is not already enabled.
> > -+
> > -When the `--stdin` option is provided, the patterns are read from
> > -standard in as a newline-delimited list instead of from the arguments.
> > -+
> > -When `core.sparseCheckoutCone` is enabled, the input list is considered a
> > -list of directories instead of sparse-checkout patterns. The command writes
> > -patterns to the sparse-checkout file to include all files contained in those
> > -directories (recursively) as well as files that are siblings of ancestor
> > -directories. The input format matches the output of `git ls-tree --name-only`.
> > -This includes interpreting pathnames that begin with a double quote (") as
> > -C-style quoted strings.
> > -
> >  'add'::
> >       Update the sparse-checkout file to include additional patterns.
> >       By default, these patterns are read from the command-line arguments,
> > @@ -96,9 +86,27 @@ C-style quoted strings.
> >
> >  'disable'::
> >       Disable the `core.sparseCheckout` config setting, and restore the
> > -     working directory to include all files. Leaves the sparse-checkout
> > -     file intact so a later 'git sparse-checkout init' command may
> > -     return the working directory to the same state.
> > +     working directory to include all files.
> > +
> > +'init'::
> > +     Deprecated command that behaves like `set` with no specified paths.
> > +     May be removed in the future.
>
> I'm on board with deprecating `init`, but one usage that's not covered by
> the updated `set` is toggling the sparse index *without* modifying the
> patterns. That likely won't matter to most users, but ones that assume `git
> sparse-checkout set --[no-]sparse-index` works the same way as `git
> sparse-checkout init --[no-]sparse-index` would find themselves losing their
> existing pattern set.
>
> Maybe `--[no-]sparse-index` should be added to `git sparse-checkout
> reapply`? For changing settings without updating patterns, that probably
> makes more sense than `init` or `set` anyway. If adding that option is
> outside the scope of what you want to do in this series, though, I'd be
> happy with a note somewhere in this documentation explicitly noting that
> `set` (unlike `init`) will change your patterns, even when toggling
> `index.sparse` (or `core.sparseCheckoutCone`).

I like that idea; reapply seems like the right place to allow folks to
toggle options without updating sparsity paths.  I'll add it.

> > ++
> > +Historically, `set` did not used to handle all the necessary config
> > +settings, which meant that both `init` and `set` had to be called.
> > +Invoking both meant the `init` step would first remove nearly all
> > +tracked files (and in cone mode, ignored files too), then the `set`
> > +step would add many of the tracked files (but not ignored files) back.
> > +In addition to the lost files, the performance and UI of this
> > +combination was poor.
> > ++
> > +Also, historically, `init` would not actually initialize the
> > +sparse-checkout file if it already existed.  This meant it was
> > +possible to return to a sparse-checkout without remembering which
> > +paths to pass to a subsequent 'set' or 'add' command.  However,
> > +`--cone` and `--sparse-index` options would not be remembered across
> > +the disable command, so the easy restore of calling a plain `init`
> > +decreased in utility.
> >
> >  SPARSE CHECKOUT
> >  ---------------
> > @@ -117,10 +125,8 @@ directory, it updates the skip-worktree bits in the index based
> >  on this file. The files matching the patterns in the file will
> >  appear in the working directory, and the rest will not.
> >
> > -To enable the sparse-checkout feature, run `git sparse-checkout init` to
> > -initialize a simple sparse-checkout file and enable the `core.sparseCheckout`
> > -config setting. Then, run `git sparse-checkout set` to modify the patterns in
> > -the sparse-checkout file.
> > +To enable the sparse-checkout feature, run `git sparse-checkout set` to
> > +set the patterns you want to use.
> >
> >  To repopulate the working directory with all files, use the
> >  `git sparse-checkout disable` command.
> >
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9791F461
	for <e@80x24.org>; Wed, 21 Aug 2019 21:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfHUVww (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 17:52:52 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:35044 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbfHUVww (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 17:52:52 -0400
Received: by mail-ua1-f51.google.com with SMTP id j21so1332402uap.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKUmriX4gDQw48854cccsLAEHvApqMd6iSJW3NL46bs=;
        b=GiidbIDVHP+fyh5UL9ZqBWzbV2AAvOnlTCAJzsKKcGmBjEQRbdOO04duDS1Qap/LRq
         aj1gnYAljQzXM14IBfLhxsfRhnb4UhW+oxuN+6WM63dQXdbrzdCOH2OwQD/+XHZHzmxL
         B0HK95KKW3hNMStRnH9bdmiXv++3w+7fCriPBd0qvd2rtMbIC7VsI8EqmX07aMv680Xl
         0ek1S6OaiqK+MPcoGQErBDn040szA9mGT+Tl4tdgU3aoyMxA6KuDpVkiZiO71AI7tRdq
         eMAu4mWITETkJoS4Fl5qkUrp1WUhayyi9CwqWUzqK580DNL8/uJkr05YT0rbFbmleaif
         Z4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKUmriX4gDQw48854cccsLAEHvApqMd6iSJW3NL46bs=;
        b=Q8S43Exdd4QptVzI/om8a+tTFkfWfxV0K4iGFK+aniuDHQHBqIRSA/2cwjoJLKu1qq
         vtGvp7RRJeCMpfNVN2DIkqFU013LCwbo9pnSBSQO4FycGbjaw/wMLXZAcmLfqiiBP2mt
         cEyneZdDYyJxOdZVAlUf7CmqTOv8nv+/6RWoa8IheXXxYdAjQ8WNxPCEe8m0WHWoPBrS
         VkFLlDOn8Ts4OSIneZD6ORaErGePBT5RNVSQIGrQ6zur/S1uEAAXWSTqqJTWm0a42jWB
         9UhHUVnQ/MFPFybIgVjn/1naRpHQ+XovK9ZqDvJ0AMhpnV27/ewFKlG0BniZgB6XG/2z
         +mrQ==
X-Gm-Message-State: APjAAAUjuju2FfkXQXyJy2AMQMN6vZ2LBHIrLWiakcBlUQqSET/oaCwX
        S9gw4MnLjj6s4vNPRVS2+P09kGE6pzIQ+UcVrLs=
X-Google-Smtp-Source: APXvYqxUg3befNsLelvS7a8sV2aeYJ3LcQ5csW5ZdaYVMnWM25LO+MhE+lyBGBbt9y3JTbfkyquJ6iHoYUadH6CZlo4=
X-Received: by 2002:ab0:4261:: with SMTP id i88mr3820236uai.95.1566424370462;
 Wed, 21 Aug 2019 14:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Aug 2019 14:52:38 -0700
Message-ID: <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This RFC includes a potential direction to make the sparse-checkout more
> user-friendly. While there, I also present a way to use a limited set of
> patterns to gain a significant performance boost in very large repositories.
>
> Sparse-checkout is only documented as a subsection of the read-tree docs
> [1], which makes the feature hard to discover. Users have trouble navigating
> the feature, especially at clone time [2], and have even resorted to
> creating their own helper tools [3].

Ooh, intriguing.  Count me as another person who has resorted to
making my own helper tool for others to use (specific to our internal
repository, though, as it also figures out inter-module dependencies
to allow specifying only a few modules of interest while still
checking out everything needed to build those; but it'd be nice to
need less scripting to handle the git-related bits to actually
sparsify or densify).

> This RFC attempts to solve these problems using a new builtin. Here is a
> sample workflow to give a feeling for how it can work:
>
> In an existing repo:
>
> $ git sparse-checkout init
> $ ls
> myFile1.txt myFile2.txt
>
> $ git sparse-checkout add
> /myFolder/*
> ^D
> $ ls
> myFile1.txt myFile2.txt myFolder
> $ ls myFolder
> a.c a.h
> $ git sparse-checkout disable
> $ ls
> hiddenFolder myFile1.txt myFile2.txt myFolder
>
> At clone time:
>
> $ git clone --sparse origin repo
> $ cd repo
> $ ls
> myFile1.txt myFile2.txt
> $ git sparse-checkout add
> /myFolder/*
> ^D
> $ ls
> myFile1.txt myFile2.txt myFolder
>
> Here are some more specific details:
>
>  * git sparse-checkout init enables core.sparseCheckout and populates the
>    sparse-checkout file with patterns that match only the files at root.

Does it enable core.sparseCheckout in the current worktree, or for all
worktrees?  Do we require extensions.worktreeConfig to be set to true
first?  If we don't require extensions.worktreeConfig to be set to
true, and users add worktrees later, do they encounter negative
surprises (immediately or later)?

worktrees in combination with sparseCheckouts were a headache here
until I just forced people to manually first set
extensions.worktreeConfig to true before using my 'sparsify' script,
regardless of whether the user was currently using worktrees.  That
fixed the issues, but having to provide a long error message and
explanation of why I wanted users to set some special config first was
slightly annoying.

I wonder if 'git worktree' and maybe even 'git config' should
themselves have special handling for core.sparseCheckouts, because it
can be a real mess otherwise.

>  * git clone learns the --sparse argument to run git sparse-checkout init
>    before the first checkout.

Nice.

>  * git sparse-checkout add reads patterns from stdin, one per line, then
>    adds them to the sparse-checkout file and refreshes the working
>    directory.

The default of reading from stdin seems a bit unusual to me, and I
worry about having to explain that to users.  I'd rather the add
command took positional parameters (anything that doesn't start with a
hyphen) and added those, e.g.
  $ git sparse-checkout add '/myFolder/*' '
with the option of the user specifying --stdin.

>  * git sparse-checkout disable removes the patterns from the sparse-checkout
>    file, disables core.sparseCheckout, and refills the working directory.

Does it leave an empty sparse-checkout file around?  Also, what if
users have several paths defining their sparse pattern, and want to
temporarily get a full checkout and then come back -- do they need to
re-specify all the paths?  (Maybe this *is* the route we want to go;
I'm just trying to mention any possible negative effects we _might_
run into so we can consider them.  It's not quite as relevant in my
case since people specify a few toplevel modules and sparse-checkout
gets several entries auto-generated for them.)

Also, I'm particularly worried that a user with multiple worktrees,
both sparse, could run 'git sparse-checkout disable' in one and then
find that when they return to the other worktree they get a variety of
nasty surprises (e.g. accidental staging or committing of the deletion
of a huge number of files, random weird errors, or gradual and weird
de-sparsifying as various git commands are run).  This, of course, can
be averted by making sure core.sparseCheckout is set on a per-worktree
basis, but that seems to be something people only do after running
into problems several times unless some kind of tooling enforces it.

>  * git sparse-checkout list lists the contents of the sparse-checkout file.
>
>
>
> The documentation for the sparse-checkout feature can now live primarily
> with the git-sparse-checkout documentation.

Yaay!

> Cone Mode
> =========
>
> What really got me interested in this area is a performance problem. If we
> have N patterns in the sparse-checkout file and M entries in the index, then
> we can perform up to O(N * M) pattern checks in clear_ce_flags(). This
> quadratic growth is not sustainable in a repo with 1,000+ patterns and
> 1,000,000+ index entries.

This has worried me for a while, even if it hasn't yet caused us
issues in practice.

> To solve this problem, I propose a new, more restrictive mode to
> sparse-checkout: "cone mode". In this mode, all patterns are based on prefix
> matches at a directory level. This can then use hashsets for fast
> performance -- O(M) instead of O(N*M). My hashset implementation is based on
> the virtual filesystem hook in the VFS for Git custom code [4].

Sweet!

> In cone mode, a user specifies a list of folders which the user wants every
> file inside. In addition, the cone adds all blobs that are siblings of the
> folders in the directory path to that folder. This makes the directories
> look "hydrated" as a user drills down to those recursively-closed folders.
> These directories are called "parent" folders, as a file matches them only
> if the file's immediate parent is that directory.
>
> When building a prototype of this feature, I used a separate file to contain
> the list of recursively-closed folders and built the hashsets dynamically
> based on that file. In this implementation, I tried to maximize the amount
> of backwards-compatibility by storing all data in the sparse-checkout file
> using patterns recognized by earlier Git versions.
>
> For example, if we add A/B/C as a recursive folder, then we add the
> following patterns to the sparse-checkout file:
>
> /*
> !/*/*
> /A/*
> !/A/*/*
> /A/B/*
> !/A/B/*/*
> /A/B/C/*
>
> The alternating positive/negative patterns say "include everything in this
> folder, but exclude everything another level deeper". The final pattern has
> no matching negation, so is a recursively closed pattern.

Oh, um, would there be any option for fast but without grabbing
sibling and parent files of requested directories?  And could users
still request individual files (not with regex or pathspec, but fully
specifying the path) and still get the fast mode?

Basically, our sparse usage is exclusively specifying leading
directories or full pathnames of individual files, but we really want
the repo to feel smaller and make sure people notice at a glance.  We
have a huge 'modules/' directory, and want people to be able to get
just 15 of the 500 or so subdirectories that would appear in that
directory with a non-sparse checkout.  And similarly we want to be
able to grab just one or two files from a directory of many files.

> Note that I have some basic warnings to try and check that the
> sparse-checkout file doesn't match what would be written by a cone-mode add.
> In such a case, Git writes a warning to stderr and continues with the old
> pattern matching algorithm. These checks are currently very barebones, and
> would need to be updated with more robust checks for things like regex
> characters in the middle of the pattern. As review moves forward (and if we
> don't change the data storage) then we could spend more time on this.

Instead of trying to validate the sparse-checkout file everytime,
perhaps we want to change core.sparseCheckout from a boolean to a
tri-state or something where it specifies how to parse the
sparse-checkout file?  Or maybe when special directive (some form of
comment-looking line) appears at the top of sparse-checkout then we
use the hashsets speedup while disallowing general regexes and
pathspecs other than leading directories and full pathnames?

I'm not sure if that makes sense or not; just throwing it out there as an idea.

> Derrick Stolee (8):
>   sparse-checkout: create builtin with 'list' subcommand
>   sparse-checkout: create 'init' subcommand
>   clone: add --sparse mode
>   sparse-checkout: 'add' subcommand
>   sparse-checkout: create 'disable' subcommand
>   sparse-checkout: add 'cone' mode
>   sparse-checkout: use hashmaps for cone patterns
>   sparse-checkout: init and add in cone mode
>
> Jeff Hostetler (1):
>   trace2:experiment: clear_ce_flags_1

I'll try to get some time to look over these patches in the next few days.

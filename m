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
	by dcvr.yhbt.net (Postfix) with ESMTP id 85CFB1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 23:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfJLXW0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 19:22:26 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33030 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfJLXW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 19:22:26 -0400
Received: by mail-ua1-f67.google.com with SMTP id u31so4057339uah.0
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XY7JXotNS7lIxwrAKpanb+zK5xQ0oxVSOdhKGL3bVE=;
        b=e/g1LPPMIreMfYMJlM4jXYv2B/ByqWVGKSwml1vIlZNlB7p5Uux4MmcnkJy6q3fBHC
         F/synSxmxTyaodRT9dMASzH71sJPo04soDiJfHexnybC67+3U/I0Be/NGDqPQQwYjXcp
         4YsR0qLNkdmhp2/tiIJ4ovaZX+91Fbs8Jt9Z7dpARj9RzfD5ofxektZsht6HnMnmqzMd
         e7Rgvi85NyYLkhtaH+mw7ytIqvftoATNCwktt09nAYRbE0FVJ2zlo0dT5GYswf0MNwpf
         0Sa2qynjzLVNMZdvFHctxYFsIXk/6qYMuJOgEc5UnCylWJn5yd7eG+3rLTaPHgA0vZ3c
         jWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XY7JXotNS7lIxwrAKpanb+zK5xQ0oxVSOdhKGL3bVE=;
        b=cHkFakiN02X5kbrgCyonezeEXcazI2X0pXdTJNYOy7S/hUFJ4CatR8Rrn0fQEI7Cba
         xOu/gaonYWOySaKMTEHMfYTvpbMsL2fV1GedSHb9sW9gL19PeJestDbOLMxDba3EjoRL
         ZrUQ2kE2Oh2xYmMcJ1Ql+a8rLoPVieUeyj0mI++4/IYecbaly7OpJMsmpzP1iYlbzVfp
         kzYmjH9XGeH2jp0D4AsbkaQVUDDRzrK80AeklR3ILx0GNAPcFPp3qQKRy3dYZmMsxAc/
         INUjLvlfePkzEqT3OXCnf2HSZmLNgBtgh2ejANPQUgyv6V+GtddP9qlGahdtyaZxmfZC
         pmPQ==
X-Gm-Message-State: APjAAAWGcXFusEoTbIdmqhU5Zk9IAYF1j5JQ7Glx/JttBaTg4lFu2t9j
        ae63k16CfVi8/Jgk9gmlx/td80BVk4bYW6adao8=
X-Google-Smtp-Source: APXvYqyK0CkXKEJcwmliVxYuG8YJxwLbYw/kr6K184mDqNj7NsnUbG+wcuT2ZzxJJiKZEMAZbEAm5+tkiaJY0DdhsCM=
X-Received: by 2002:a9f:2382:: with SMTP id 2mr10016494uao.95.1570922543567;
 Sat, 12 Oct 2019 16:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Oct 2019 16:22:11 -0700
Message-ID: <CABPp-BHJeuEHBDkf93m9sfSZ4rZB7+eFejiAXOsjLEUu5eT5FA@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] New sparse-checkout builtin and "cone" mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series makes the sparse-checkout feature more user-friendly. While
> there, I also present a way to use a limited set of patterns to gain a
> significant performance boost in very large repositories.
>
> Sparse-checkout is only documented as a subsection of the read-tree docs
> [1], which makes the feature hard to discover. Users have trouble navigating
> the feature, especially at clone time [2], and have even resorted to
> creating their own helper tools [3].
>
> This series attempts to solve these problems using a new builtin. Here is a
> sample workflow to give a feeling for how it can work:
>
> In an existing repo:
>
> $ git sparse-checkout init
> $ ls
> myFile1.txt myFile2.txt
> $ git sparse-checkout set "/*" "!/*/" /myFolder/
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
> $ git sparse-checkout set "/*" "!/*/" /myFolder/
> $ ls
> myFile1.txt myFile2.txt myFolder
>
> Here are some more specific details:
>
>  * git sparse-checkout init enables core.sparseCheckout and populates the
>    sparse-checkout file with patterns that match only the files at root.
>
>
>  * git clone learns the --sparse argument to run git sparse-checkout init
>    before the first checkout.
>
>
>  * git sparse-checkout set reads patterns from the arguments, or with
>    --stdin reads patterns from stdin one per line, then writes them to the
>    sparse-checkout file and refreshes the working directory.
>
>
>  * git sparse-checkout disable removes the patterns from the sparse-checkout
>    file, disables core.sparseCheckout, and refills the working directory.
>
>
>  * git sparse-checkout list lists the contents of the sparse-checkout file.
>
>
>
> The documentation for the sparse-checkout feature can now live primarily
> with the git-sparse-checkout documentation.
>
> Cone Mode
> =========
>
> What really got me interested in this area is a performance problem. If we
> have N patterns in the sparse-checkout file and M entries in the index, then
> we can perform up to O(N * M) pattern checks in clear_ce_flags(). This
> quadratic growth is not sustainable in a repo with 1,000+ patterns and
> 1,000,000+ index entries.
>
> To solve this problem, I propose a new, more restrictive mode to
> sparse-checkout: "cone mode". In this mode, all patterns are based on prefix
> matches at a directory level. This can then use hashsets for fast
> performance -- O(M) instead of O(N*M). My hashset implementation is based on
> the virtual filesystem hook in the VFS for Git custom code [4].
>
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
> !/*/
> /A/
> !/A/*/
> /A/B/
> !/A/B/*/
> /A/B/C/
>
> The alternating positive/negative patterns say "include everything in this
> folder, but exclude everything another level deeper". The final pattern has
> no matching negation, so is a recursively closed pattern.
>
> Note that I have some basic warnings to try and check that the
> sparse-checkout file doesn't match what would be written by a cone-mode add.
> In such a case, Git writes a warning to stderr and continues with the old
> pattern matching algorithm. These checks are currently very barebones, and
> would need to be updated with more robust checks for things like regex
> characters in the middle of the pattern. As review moves forward (and if we
> don't change the data storage) then we could spend more time on this.
>
> Thanks, -Stolee
>
> Updates in v2, relative to the RFC:
>
>  * Instead of an 'add' subcommand, use a 'set' subcommand. We can consider
>    adding 'add' and/or 'remove' subcommands later.
>
>
>  * 'set' reads from the arguments by default. '--stdin' option is available.
>
>
>  * A new performance-oriented commit is added at the end.
>
>
>  * Patterns no longer end with a trailing asterisk except for the first "/*"
>    pattern.
>
>
>  * References to a "bug" (that was really a strange GVFS interaction in
>    microsoft/git) around deleting outside the cone are removed.
>
>
>
> Updates in v3:
>
>  * The bad interaction with "cone mode" and .gitignore files is fixed. A
>    test is added in the last patch.
>
>
>  * Several patches are added that make the feature more robust. One
>    sanitizes user input, another few add progress indicators, and another
>    more prevent users from getting in bad states due to working directory
>    changes or concurrent processes.
>
>
>  * Updated several docs and commit messages according to feedback. Thanks,
>    Elijah!
>

I've read through v3, and at this point I'm mostly just finding small
stuff to comment on; the patches are looking pretty good.  One bigger
item I'd like to comment on, is that I'd really like this feature to
be explicitly labelled as experimental as per [1].  Not just because
of edge and corner case bugs (at least one of which we know about and
I've drummed on a few times), but much more importantly because I
believe grep, log, diff, and other commands should by default pay
attention to the sparsity patterns to limit their output for the user
both because that's the stuff the user is interested in and the files
outside those paths are at best noise, and because it provides them an
ability to get the responsiveness of a small repository even while
working in a bigger one.  See [2] for more details.  If we don't mark
this command as experimental, I'm worried people may start coming to
expect whatever behavior they get with sparse checkouts and then we'll
be locked in due to backward compatibility, and users who want a good
experience will have to know to set a whole bunch of flags instead of
getting the right behavior by default.

[1] https://public-inbox.org/git/b1444dab-24e5-6e4d-bea8-37abc433b546@gmail.com/
[2] https://public-inbox.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/

> Things to leave for future patches:
>
>  1. Integrate in 'git worktree add' to copy the sparse-checkout file to a
>     worktree-specific file.

I'm a big fan of this, but it sounds like Junio isn't[2].  I tried to
follow up to get more details, but I'm worried his view might mean
non-sparse-worktrees-by-default, which in turn I'm worried will be
unworkable with sufficiently large repos and/or not be very friendly
to future users of both partial clones and sparse checkouts.

[2] https://public-inbox.org/git/xmqqy2y3ejwe.fsf@gitster-ct.c.googlers.com/

>  2. More robustness around detecting non-cone patterns with wildcards in the
>     middle of the line.

Make sense.

>  3. 'git clone --sparse-cone' to clone into "cone mode" sparse-checkouts
>     (i.e. set 'core.sparseCheckoutCone=true'). This may not be
>     super-valuable, as it only starts changing behavior when someone calls
>     'git sparse-checkout set', but may be interesting.

It'd probably be nice for users, who would otherwise need to run:
  git clone --sparse ...
  git sparse-checkout init --cone
  git sparse-checkout set ...

The need to run init after doing a clone --sparse could possibly be
seen as annoying.  OR.... maybe those users will just set
core.sparseCheckoutCone=true in their global gitconfig, if the
documentation points them to it or they think about it.



Thanks for all the work on this series!  (And sorry my reviews always
take a while...)

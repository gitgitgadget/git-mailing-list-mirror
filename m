Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA451C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 19:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJJTft (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJJTfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 15:35:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6FD74B83
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:35:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gf8so10597214pjb.5
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzknxsau+kEJnNGFBHDQxYqu0hOiaILRExA4jPjeKtM=;
        b=QhHl96nXyTGwETNwbi4fnUDfYe0QJykYc2YTcSzLbgp3j6h+mYELC0vrrc2p203QAh
         iIVFA9Idm3GdOcZdlO0OdRzd81gNeIqua3vThp2avmro4qIJKXczF1D0JWt2YwG0JCgy
         O7adwOw9tqbVIQns77bvXI9UZEW7z+npAPb1rpJSCZ4CxG/1eCiKmD+1vKUVVBAujHE5
         pqmkN6ya1O9iZtzzgOiWEfjM0M0eBqlFHDhHvk2qai8ByFoPwqFlcrfo38QGGkn2wAme
         lqlhXPZNLxMJNtMUH/hoLOCOv4aZVLjEVpX8ZdFfoQl1jA3MjUDDEHr8E9yHfno5EsNt
         UXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzknxsau+kEJnNGFBHDQxYqu0hOiaILRExA4jPjeKtM=;
        b=6Z87ZKvWSYRbYMTheY3xxEstkdnfQGYjs9kDBBONr1JXRDE7e5QuJJc1rDZx1D2YsU
         Jo45+qCUp4UXCxIMvF7VDbZScx2Us+1jXWOc+18N3MFp5AiGhlu2mT7fyDUQKgI09/Fr
         NhCltJLK5cunR90n6b7kJOCgW+ujXfUKKDd7thbreCGuHO5qcbb+uWhURXOrlFlIQko5
         FcMIixwUuAYgSbAIGcthCz6LOhoUaOclrMkNFEKLI3zSssK63zzvL2lLz0/rU2BIKA/C
         5q9RVgk2TDlgk587KkJeLpAIpcbLat+sKB71cNiIOzHS9iuLZVE/bHRMPvkcrtcYyr15
         rIQg==
X-Gm-Message-State: ACrzQf0lzfwLlaLWX+A/ZAET4QTzoeQZWhYG3GDDCNXibAOtUj7GHIkw
        9d6W8WlOrwRrkd74xkevcP0n
X-Google-Smtp-Source: AMsMyM6V7IZEndjdXVmAQNpaZvXW8MXAeagyQhmpUDx04ZByBd1cMZikICu86HmBa04x8eQjW9LJjg==
X-Received: by 2002:a17:902:7b95:b0:178:ab50:76b5 with SMTP id w21-20020a1709027b9500b00178ab5076b5mr20792089pll.161.1665430536844;
        Mon, 10 Oct 2022 12:35:36 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b7-20020a621b07000000b0053b723a74f7sm7463958pfb.90.2022.10.10.12.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 12:35:36 -0700 (PDT)
Message-ID: <35d65b75-c5c4-132a-bbd5-49d3c012c69f@github.com>
Date:   Mon, 10 Oct 2022 12:35:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 01/10] technical doc: add a design doc for the evolve
 command
Content-Language: en-US
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
 <a5eb93254191b7ae9c17ce52e056955c669ea007.1664981958.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <a5eb93254191b7ae9c17ce52e056955c669ea007.1664981958.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos via GitGitGadget wrote:
> From: Stefan Xenos <sxenos@google.com>
> 
> This document describes what a change graph for
> git would look like, the behavior of the evolve command,
> and the changes planned for other commands.
> 
> It was originally proposed in 2018, see
> https://public-inbox.org/git/20181115005546.212538-1-sxenos@google.com/
> 
> Signed-off-by: Stefan Xenos <sxenos@google.com>
> Signed-off-by: Chris Poucet <poucet@google.com>
> ---
>  Documentation/technical/evolve.txt | 1070 ++++++++++++++++++++++++++++
>  1 file changed, 1070 insertions(+)
>  create mode 100644 Documentation/technical/evolve.txt
> 
> diff --git a/Documentation/technical/evolve.txt b/Documentation/technical/evolve.txt
> new file mode 100644
> index 00000000000..2051ea77b8a
> --- /dev/null
> +++ b/Documentation/technical/evolve.txt
> @@ -0,0 +1,1070 @@
> +Evolve
> +======
> +
> +Objective
> +=========
> +Create an "evolve" command to help users craft a high quality commit history.
> +Users can improve commits one at a time and in any order, then run git evolve to
> +rewrite their recent history to ensure everything is up-to-date. We track
> +amendments to a commit over time in a change graph. Users can share their
> +progress with others by exchanging their change graphs using the standard push,
> +fetch, and format-patch commands.
> +
> +Status
> +======
> +This proposal has not been implemented yet.
> +
> +Background
> +==========
> +Imagine you have three sequential changes up for review and you receive feedback
> +that requires editing all three changes. We'll define the word "change"
> +formally later, but for the moment let's say that a change is a work-in-progress
> +whose final version will be submitted as a commit in the future.
> +
> +While you're editing one change, more feedback arrives on one of the others.
> +What do you do?

For the sake of providing additional perspectives, I can say that I'd:

$ git stash
# Make changes based on new feedback
$ git add . & git commit --fixup <target commit>
$ git stash pop
# Continue working

or something along those lines.

> +
> +The evolve command is a convenient way to work with chains of commits that are
> +under review. Whenever you rebase or amend a commit, the repository remembers
> +that the old commit is obsolete and has been replaced by the new one. Then, at
> +some point in the future, you can run "git evolve" and the correct sequence of
> +rebases will occur in the correct order such that no commit has an obsolete
> +parent.
> +
> +Part of making the "evolve" command work involves tracking the edits to a commit
> +over time, which is why we need an change graph. However, the change
> +graph will also bring other benefits:
> +
> +- Users can view the history of a change directly (the sequence of amends and
> +  rebases it has undergone, orthogonal to the history of the branch it is on).
> +- It will be possible to quickly locate and list all the changes the user
> +  currently has in progress.
> +- It can be used as part of other high-level commands that combine or split
> +  changes.
> +- It can be used to decorate commits (in git log, gitk, etc) that are either
> +  obsolete or are the tip of a work in progress.
> +- By pushing and pulling the change graph, users can collaborate more
> +  easily on changes-in-progress. This is better than pushing and pulling the
> +  commits themselves since the change graph can be used to locate a more
> +  specific merge base, allowing for better merges between different versions of
> +  the same change.
> +- It could be used to correctly rebase local changes and other local branches
> +  after running git-filter-branch.
> +- It can replace the change-id footer used by gerrit.

While the first part of the "Background" section is good (talking about a
user scenario), I don't think this description of 'git evolve' belongs here.
I'd expect the background to talk about what you wish Git could do (but it
hard/impossible to do now), or what prompted you to (re-)submit this
proposal. By prescribing the 'git evolve' command as the solution up-front,
this doc makes it difficult to interpret the underlying "why" of the
proposal.

> +
> +Goals
> +-----
> +Legend: Goals marked with P0 are required. Goals marked with Pn should be
> +attempted unless they interfere with goals marked with Pn-1.
> +
> +P0. All commands that modify commits (such as the normal commit --amend or
> +    rebase command) should mark the old commit as being obsolete and replaced by
> +    the new one. No additional commands should be required to keep the
> +    change graph up-to-date.

You elaborate on it more later, but this design is proposing that this
"change" workflow becomes the default for everyone, with a config option
('core.enableChanges') to opt out. This would be massively disruptive (and
confusing) to the huge swath of users that have no desire to use this
particular workflow.

> +P0. Any commit that may be involved in a future evolve command should not be
> +    garbage collected. Specifically:
> +    - Commits that obsolete another should not be garbage collected until
> +      user-specified conditions have occurred and the change has expired from
> +      the reflog. User specified conditions for removing changes include:
> +      - The user explicitly deleted the change.
> +      - The change was merged into a specific branch.
> +    - Commits that have been obsoleted by another should not be garbage
> +      collected if any of their replacements are still being retained.

If the creation of these linkages is passive, but requires active user
intervention to clean up, this requirement could result in creating an
enormous amount of cruft in repositories. I might rebase a branch 10+ times
between pushes to make little tweaks to phrasing in commit messages, or fix
typos, etc. It sounds like I'd be pushing an order of magnitude more objects
than I am now, let alone the fact that they wouldn't be GC'd automatically.

> +P0. A commit can be obsoleted by more than one replacement (called divergence).
> +P0. Users must be able to resolve divergence (convergence).
> +P1. Users should be able to share chains of obsolete changes in order to
> +    collaborate on WIP changes.
> +P2. Such sharing should be at the user’s option. That is, it should be possible
> +    to directly share a change without also sharing the file states or commit
> +    comments from the obsolete changes that led up to it, and the choice not to
> +    share those commits should not require changing any commit hashes.
> +P2. It should be possible to discard part or all of the change graph
> +    without discarding the commits themselves that are already present in
> +    branches and the reflog.
> +P2. Provide sufficient information to replace gerrit's Change-Id footers.

A general comment on the "Goals" section (similar to the one on "Background)
- all of the listed goals are written assuming you've already decided on the
solution, rather than elaborating on the problems you're trying to solve
(e.g., "I want to create a persistent linkage between iterations of a commit
and be able to query that linkage"). Talking about the features you want
(and why) will not only make it much easier to understand the proposal, it
could inspire other contributors to suggest solutions you may not have
considered.

> +
> +Similar technologies
> +--------------------
> +There are some other technologies that address the same end-user problem.
> +
> +Rebase -i can be used to solve the same problem, but users can't easily switch
> +tasks midway through an interactive rebase or have more than one interactive
> +rebase going on at the same time. It can't handle the case where you have
> +multiple changes sharing the same parent when that parent needs to be rebased
> +and won't let you collaborate with others on resolving a complicated interactive
> +rebase. You can think of rebase -i as a top-down approach and the evolve command
> +as the bottom-up approach to the same problem.

I think it's worth considering whether 'rebase' can be updated to handle
these cases (since it might simplify and/or pare down your proposed design).

1. Can't easily switch tasks midway through an interactive rebase
   - I could imagine us introducing a 'git rebase pause' that does this,
     although it would require changes to how rebases are tracked
     internally.
2. Can't have more than one interactive rebase going on at the same time
   - Do you mean nested rebases, or just separate ones? I think both of them
     could be possible (with the changes to rebase tracking in #1), but
     nested ones might be tough to mentally keep track of.
3. Can't handle multiple changes sharing the same parent when the parent
   needs to be rebased
   - Since the introduction of '--update-refs' [1], this is technically
     possible (although it needs a UI for the use case you mentioned).
4. Won't let you collaborate with others on resolving a complicated
   interactive rebase
   - This is an interesting one, since it requires being able to push a
     mid-merge state. However, if you're planning on solving that for 'git
     evolve', a similar solution could probably be used for 'rebase'.
     Pushing a whole rebase script, though, would be more complicated.

The "top-down"/"bottom-up" analogy is a bit lost on me, I'm afraid. Could
you clarify what you mean by that?

[1] https://lore.kernel.org/git/pull.1247.v5.git.1658255624.gitgitgadget@gmail.com/

> +Overview
> +========
> +We introduce the notion of “meta-commits” which describe how one commit was
> +created from other commits. A branch of meta-commits is known as a change.
> +Changes are created and updated automatically whenever a user runs a command
> +that creates a commit. They are used for locating obsolete commits, providing a
> +list of a user’s unsubmitted work in progress, and providing a stable name for
> +each unsubmitted change.

The term "change" is overly generic; I and others already use it as a
general term for anything from "part of a patch" to "an entire patch
series". Maybe "evolution" (in keeping with 'git evolve' being the command
that updates all of the meta-commit branches)? Or "iteration" (although that
might also be overloaded with how we colloquially refer to [PATCH vN]
submissions)?

Also, I'm not sure what you mean by "unsubmitted". Un-pushed? 

> +
> +Users can exchange edit histories by pushing and fetching changes.
> +
> +New commands will be introduced for manipulating changes and resolving
> +divergence between them. Existing commands that create commits will be updated
> +to modify the meta-commit graph and create changes where necessary.
> +
> +Example usage
> +-------------

nit: please include information about where HEAD starts (I think you start
on 'metas/some_change_already_merged_upstream'?).

> +# First create three dependent changes
> +$ echo foo>bar.txt && git add .
> +$ git commit -m "This is a test"
> +created change metas/this_is_a_test
> +$ echo foo2>bar2.txt && git add .
> +$ git commit -m "This is also a test"
> +created change metas/this_is_also_a_test
> +$ echo foo3>bar3.txt && git add .
> +$ git commit -m "More testing"
> +created change metas/more_testing
> +
> +# List all our changes in progress
> +$ git change list
> +metas/this_is_a_test
> +metas/this_is_also_a_test
> +* metas/more_testing
> +metas/some_change_already_merged_upstream

If this is a list of all of the unmerged commits/changes you have, it's
going to be exceptionally long for people with multiple local branches.
Unless the results of 'git change list' are scoped to those reachable from
the meta-commit pointing at HEAD?

> +
> +# Now modify the earliest change, using its stable name
> +$ git reset --hard metas/this_is_a_test
> +$ echo morefoo>>bar.txt && git add . && git commit --amend --no-edit
> +
> +# Use git-evolve to fix up any dependent changes
> +$ git evolve
> +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> +rebasing metas/more_testing onto metas/this_is_also_a_test
> +Done
> +
Where is HEAD at this point? Still 'metas/this_is_a_test'? 

> +# Use git-obslog to view the history of the this_is_a_test change
> +$ git log --obslog
> +93f110 metas/this_is_a_test@{0} commit (amend): This is a test
> +930219 metas/this_is_a_test@{1} commit: This is a test
> +
> +# Now create an unrelated change
> +$ git reset --hard origin/master
> +$ echo newchange>unrelated.txt && git add .
> +$ git commit -m "Unrelated change"
> +created change metas/unrelated_change
> +
> +# Fetch the latest code from origin/master and use git-evolve
> +# to rebase all dependent changes.
> +$ git fetch origin master
> +$ git evolve origin/master
> +deleting metas/some_change_already_merged_upstream
> +rebasing metas/this_is_a_test onto origin/master
> +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> +rebasing metas/more_testing onto metas/this_is_also_a_test
> +rebasing metas/unrelated_change onto origin/master
> +Conflict detected! Resolve it and then use git evolve --continue to resume.
> +
> +# Sort out the conflict
> +$ git mergetool
> +$ git evolve origin/master
> +Done

You ran 'git evolve origin/master', but the message said to use 'git evolve
--continue'. Is that a typo, or do they actually do something different
after resolving a conflict?

> +
> +# Share the full history of edits for the this_is_a_test change
> +# with a review server
> +$ git push origin metas/this_is_a_test:refs/for/master
> +# Share the lastest commit for “Unrelated change”, without history
> +$ git push origin HEAD:refs/for/master

It would be nice to also show here how a change is "finalized" (unlinked
from previous iterations, allowing them to be garbage collected). I think
you add this detail later in the doc, but it'd be nice to have up-front to
show the full end-to-end workflow.

> +
> +Detailed design
> +===============
> +Obsolescence information is stored as a graph of meta-commits. A meta-commit is
> +a specially-formatted merge commit that describes how one commit was created
> +from others.
> +
> +Meta-commits look like this:
> +
> +$ git cat-file -p <example_meta_commit>
> +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> +parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> +parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> +author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +parent-type c r o
> +
> +This says “commit aa7ce555 makes commit d64309ee obsolete. It was created by
> +cherry-picking commit 7e1bbcd3”.
> +
> +The tree for meta-commits is always the empty tree, but future versions of git
> +may attach other trees here. For forward-compatibility fsck should ignore such
> +trees if found on future repository versions. This will allow future versions of
> +git to add metadata to the meta-commit tree without breaking forwards
> +compatibility.
> +
> +The commit comment for a meta-commit is an auto-generated user-readable string
> +describing the command that produced the meta commit. These strings are shown
> +to the user when they view the obslog.
> +

The rest of this section provides (very detailed) descriptions of what you
want to do with each command. I appreciate the detail, but I wanted to focus
the review/discussion on the high-level approach before diving into
implementation details.

My overall take on this proposal is that, while (I think) I understand how
your proposed solution works, I'm unsure as to whether it's the best way to
solve the problems you're hoping to solve. Reworking the "Background" and
"Goals" sections to focus more on pain points/what you want to get out of
the new workflow would help substantially with figuring that out, so please
consider updating those in your next re-roll.

As far as the described approach, I have some concerns with both the
user-facing side of things and the internal architecture. In terms of
user impact:

- Regardless of the decided approach, I don't think this workflow should be
  made the default for all users; it's just too different from typical
  workflows that Git users follow.
- Even if users do "opt-in" to using this workflow, I think it'd be valuable
  to have an "iterate only when I ask you to" option for users that don't
  want every single fixup be saved as a persistent "version" of a change.
- The term "change" is already a loose/overloaded concept in the context of
  Git, I'd strongly suggest picking something else. Relatedly, a
  "terminology" subsection (for things like "meta-commit", "evolve", etc.)
  under the "Overview" section  would help a lot with reading through this.

The backend concerns are mostly related to massively increasing the number
of pushed objects and the reachability of those objects. An "iterate only
when I ask you to" approach would help with this, but I don't know whether
that fits your needs or not.

Thanks!
- Victoria

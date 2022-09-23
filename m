Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A70C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 20:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiIWUAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIWUAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 16:00:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7ADCEB6
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 13:00:09 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-34d897f6fd9so10434607b3.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=7h9ET4p4HGHIQmcEX8Y6igd7lMClvp0ZQXFDeewc7+Q=;
        b=DeRSWm9N9g89t1eyySxv5ZXhL6LVMfWu4aVGk4cKuBqMUaQnumhUcySx8zEEsZ3a6x
         0x8eNLd7D1y4BBOwKtYCFURX1LtJriIwMi9RTikMlDVYizBG+cYCVI9E4O0kkzUnMmcO
         IM2sdSEsxJGo2kEANnoV6zVANJ8UBWF49UqFesmx9TS7hU19cgC3D0K2csg7fZ1dQBp3
         ryEF3DlKpUwOMYWfGIVjthndvSSF1Y0+1cGXbeYvSL5o/gWSNaGYGlNBvL+O1ePpBdS8
         R2sCdmvfRqdp8unqr6CoMQpUE0dgFJcGYIJkB2bYdLUooOJOhTvDxt6lZ2e9ObOGNpDr
         1j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7h9ET4p4HGHIQmcEX8Y6igd7lMClvp0ZQXFDeewc7+Q=;
        b=k3s7a2P+kpUdUdUT8zKI14u25iL/rtKBVxZDkJ0KIRrLxsDpHzE8QKTySYbtcARN2z
         8QDIyXw/YhgJv7LjF+0EXfMgd4T+uLxZrzK297KSgIN4AoBEzRaCtkAlobdNDHU6YrrI
         vjTcZhDEIXF2sDZp8/u2NDtdkXbiOLSvHRoidWnU/PPl6qR1aZhPWHEeQ94fKh+oh0u4
         qk9sujQjTz+1WprANWWW9xY5RG9UWzxNvG0j3dh4DvP4kgd6fJTSlzdgHzWYT2J/gAdC
         IMQBvLWPYSE+9Hs3F3lbHzGMqNrXrbR44RTYW+Zy3FVtp/ZLSa1C3KTQi36GCfxDsxrB
         niCg==
X-Gm-Message-State: ACrzQf0vvrJpHNvDF3S+erGUIz8xgjx1ZVp16J16xoDfkGYKKVsevLUZ
        OX5HQUvBctSuzXRR67NeFlqVw1DqwMI2ydf5a1oDiw==
X-Google-Smtp-Source: AMsMyM4rkJsYvSFfqex1Kgozx2+iC3yz9dDpusX9SK3VuaHLoAGWcpmrrXBWWKla9W6BRTGs+DP53ZAwJuwsk6miBUM=
X-Received: by 2002:a81:8701:0:b0:341:9e24:5992 with SMTP id
 x1-20020a818701000000b003419e245992mr9849047ywf.110.1663963207748; Fri, 23
 Sep 2022 13:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com> <a0cf68f8ba2adefae4fceeab0d438d05e355e695.1663959324.git.gitgitgadget@gmail.com>
In-Reply-To: <a0cf68f8ba2adefae4fceeab0d438d05e355e695.1663959324.git.gitgitgadget@gmail.com>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 23 Sep 2022 12:59:56 -0700
Message-ID: <CAMKO5CsXAhb0jM=sFOZCwnMf=ZdO1HrQ1EcTj9bW8OJ5aj6ZPw@mail.gmail.com>
Subject: Re: [PATCH 01/10] technical doc: add a design doc for the evolve command
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 11:56 AM Stefan Xenos via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
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
>  Documentation/technical/evolve.txt | 1051 ++++++++++++++++++++++++++++
>  1 file changed, 1051 insertions(+)
>  create mode 100644 Documentation/technical/evolve.txt
>
> diff --git a/Documentation/technical/evolve.txt b/Documentation/technical=
/evolve.txt
> new file mode 100644
> index 00000000000..68ee2457e52
> --- /dev/null
> +++ b/Documentation/technical/evolve.txt
> @@ -0,0 +1,1051 @@
> +Evolve
> +=3D=3D=3D=3D=3D=3D
> +
> +Objective
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Create an "evolve" command to help users craft a high quality commit his=
tory.
> +Users can improve commits one at a time and in any order, then run git e=
volve to
> +rewrite their recent history to ensure everything is up-to-date. We trac=
k
> +amendments to a commit over time in a change graph. Users can share thei=
r
> +progress with others by exchanging their change graphs using the standar=
d push,
> +fetch, and format-patch commands.
> +
> +Status
> +=3D=3D=3D=3D=3D=3D
> +This proposal has not been implemented yet.
> +
> +Background
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Imagine you have three sequential changes up for review and you receive =
feedback
> +that requires editing all three changes. We'll define the word "change"
> +formally later, but for the moment let's say that a change is a work-in-=
progress
> +whose final version will be submitted as a commit in the future.
> +
> +While you're editing one change, more feedback arrives on one of the oth=
ers.
> +What do you do?
> +
> +The evolve command is a convenient way to work with chains of commits th=
at are
> +under review. Whenever you rebase or amend a commit, the repository reme=
mbers
> +that the old commit is obsolete and has been replaced by the new one. Th=
en, at
> +some point in the future, you can run "git evolve" and the correct seque=
nce of
> +rebases will occur in the correct order such that no commit has an obsol=
ete
> +parent.
> +
> +Part of making the "evolve" command work involves tracking the edits to =
a commit
> +over time, which is why we need an change graph. However, the change
> +graph will also bring other benefits:
> +
> +- Users can view the history of a change directly (the sequence of amend=
s and
> +  rebases it has undergone, orthogonal to the history of the branch it i=
s on).
> +- It will be possible to quickly locate and list all the changes the use=
r
> +  currently has in progress.
> +- It can be used as part of other high-level commands that combine or sp=
lit
> +  changes.
> +- It can be used to decorate commits (in git log, gitk, etc) that are ei=
ther
> +  obsolete or are the tip of a work in progress.
> +- By pushing and pulling the change graph, users can collaborate more
> +  easily on changes-in-progress. This is better than pushing and pulling=
 the
> +  commits themselves since the change graph can be used to locate a more
> +  specific merge base, allowing for better merges between different vers=
ions of
> +  the same change.
> +- It could be used to correctly rebase local changes and other local bra=
nches
> +  after running git-filter-branch.
> +- It can replace the change-id footer used by gerrit.
> +
> +Goals
> +-----
> +Legend: Goals marked with P0 are required. Goals marked with Pn should b=
e
> +attempted unless they interfere with goals marked with Pn-1.
> +
> +P0. All commands that modify commits (such as the normal commit --amend =
or
> +    rebase command) should mark the old commit as being obsolete and rep=
laced by
> +    the new one. No additional commands should be required to keep the
> +    change graph up-to-date.
> +P0. Any commit that may be involved in a future evolve command should no=
t be
> +    garbage collected. Specifically:
> +    - Commits that obsolete another should not be garbage collected unti=
l
> +      user-specified conditions have occurred and the change has expired=
 from
> +      the reflog. User specified conditions for removing changes include=
:
> +      - The user explicitly deleted the change.
> +      - The change was merged into a specific branch.
> +    - Commits that have been obsoleted by another should not be garbage
> +      collected if any of their replacements are still being retained.
> +P0. A commit can be obsoleted by more than one replacement (called diver=
gence).
> +P0. Users must be able to resolve divergence (convergence).
> +P1. Users should be able to share chains of obsolete changes in order to
> +    collaborate on WIP changes.
> +P2. Such sharing should be at the user=E2=80=99s option. That is, it sho=
uld be possible
> +    to directly share a change without also sharing the file states or c=
ommit
> +    comments from the obsolete changes that led up to it, and the choice=
 not to
> +    share those commits should not require changing any commit hashes.
> +P2. It should be possible to discard part or all of the change graph
> +    without discarding the commits themselves that are already present i=
n
> +    branches and the reflog.
> +P2. Provide sufficient information to replace gerrit's Change-Id footers=
.
> +
> +Similar technologies
> +--------------------
> +There are some other technologies that address the same end-user problem=
.
> +
> +Rebase -i can be used to solve the same problem, but users can't easily =
switch
> +tasks midway through an interactive rebase or have more than one interac=
tive
> +rebase going on at the same time. It can't handle the case where you hav=
e
> +multiple changes sharing the same parent when that parent needs to be re=
based
> +and won't let you collaborate with others on resolving a complicated int=
eractive
> +rebase. You can think of rebase -i as a top-down approach and the evolve=
 command
> +as the bottom-up approach to the same problem.
I'll mention some other tools in this space too:

revup amend (https://github.com/Skydio/revup/blob/main/docs/amend.md)
(I'm the author) allows insertion of cached changes into any commit in
the current history, and then reapplies the rest of history on top of
those changes. It uses a "git apply --cached" engine under the hood so
doesn't touch the working directory (although it will soon use the new
git merge-tree). When paired with "revup upload" which creates and
pushes multiple branches in the background for you, its possible to
work on a "graph" of changes on a single branch linearly, then have
the true graph structure created at upload time.

git-revise (https://github.com/mystor/git-revise) does some very
similar things except it uses "git merge-file" combined with manually
merging the resulting trees. git branchstack
(https://github.com/krobelus/git-branchstack) can also create branches
in the background for you with the same mechanism.

These tools don't store any external state, but as such also don't
provide any specific collaboration mechanism for individual changes,
so I'm interested in the "evolve" approach as well.
> +
> +Several patch queue managers have been built on top of git (such as topg=
it,
> +stgit, and quilt). They address the same user need. However they also re=
ly on
> +state managed outside git that needs to be kept in sync. Such state can =
be
> +easily damaged when running a git native command that is unaware of the =
patch
> +queue. They also typically require an explicit initialization step to be=
 done by
> +the user which creates workflow problems.
> +
> +Mercurial implements a very similar feature in its EvolveExtension. The =
behavior
> +of the evolve command itself is very similar, but the storage format for=
 the
> +change graph differs. In the case of mercurial, each change set can have=
 one or
> +more obsolescence markers that point to other changesets that they repla=
ce. This
> +is similar to the "Commit Headers" approach considered in the other opti=
ons
> +appendix. The approach proposed here stores obsolescence information in =
a
> +separate metacommit graph, which makes exchanging of obsolescence inform=
ation
> +optional.
> +
> +Mercurial's default behavior makes it easy to find and switch between
> +non-obsolete changesets that aren't currently on any branch. We introduc=
e the
> +notion of a new ref namespace that enables a similar workflow via a diff=
erent
> +mechanism. Mercurial has the notion of changeset phases which isn't pres=
ent
> +in git and creates new ways for a changeset to diverge. Git doesn't need
> +to deal with these issues, but it has to deal with the problems of picki=
ng an
> +upstream branch as a target for rebases and protecting obsolescence info=
rmation
> +from GC. We also introduce some additional transformations (see
> +obsolescence-over-cherry-pick, below) that aren't present in the mercuri=
al
> +implementation.
> +
> +Semi-related work
> +-----------------
> +There are other technologies that address different problems but have so=
me
> +similarities with this proposal.
> +
> +Replacements (refs/replace) are superficially similar to obsolescences i=
n that
> +they describe that one commit should be replaced by another. However, th=
ey
> +differ in both how they are created and how they are intended to be used=
.
> +Obsolescences are created automatically by the commands a user runs, and=
 they
> +describe the user=E2=80=99s intent to perform a future rebase. Obsolete =
commits still
> +appear in branches, logs, etc like normal commits (possibly with an extr=
a
> +decoration that marks them as obsolete). Replacements are typically crea=
ted
> +explicitly by the user, they are meant to be kept around for a long time=
, and
> +they describe a replacement to be applied at read-time rather than as th=
e input
> +to a future operation. When a replaced commit is queried, it is typicall=
y hidden
> +and swapped out with its replacement as though the replacement has alrea=
dy
> +occurred.
> +
> +Git-imerge is a project to help make complicated merges easier, particul=
arly
> +when merging or rebasing long chains of patches. It is not an alternativ=
e to
> +the change graph, but its algorithm of applying smaller incremental merg=
es
> +could be used as part of the evolve algorithm in the future.
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +We introduce the notion of =E2=80=9Cmeta-commits=E2=80=9D which describe=
 how one commit was
> +created from other commits. A branch of meta-commits is known as a chang=
e.
> +Changes are created and updated automatically whenever a user runs a com=
mand
> +that creates a commit. They are used for locating obsolete commits, prov=
iding a
> +list of a user=E2=80=99s unsubmitted work in progress, and providing a s=
table name for
> +each unsubmitted change.
> +
> +Users can exchange edit histories by pushing and fetching changes.
> +
> +New commands will be introduced for manipulating changes and resolving
> +divergence between them. Existing commands that create commits will be u=
pdated
> +to modify the meta-commit graph and create changes where necessary.
> +
> +Example usage
> +-------------
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
> +Conflict detected! Resolve it and then use git evolve --continue to resu=
me.
> +
> +# Sort out the conflict
> +$ git mergetool
> +$ git evolve origin/master
> +Done
> +
> +# Share the full history of edits for the this_is_a_test change
> +# with a review server
> +$ git push origin metas/this_is_a_test:refs/for/master
> +# Share the lastest commit for =E2=80=9CUnrelated change=E2=80=9D, witho=
ut history
> +$ git push origin HEAD:refs/for/master
> +
> +Detailed design
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Obsolescence information is stored as a graph of meta-commits. A meta-co=
mmit is
> +a specially-formatted merge commit that describes how one commit was cre=
ated
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
> +This says =E2=80=9Ccommit aa7ce555 makes commit d64309ee obsolete. It wa=
s created by
> +cherry-picking commit 7e1bbcd3=E2=80=9D.
> +
> +The tree for meta-commits is always the empty tree, but future versions =
of git
> +may attach other trees here. For forward-compatibility fsck should ignor=
e such
> +trees if found on future repository versions. This will allow future ver=
sions of
> +git to add metadata to the meta-commit tree without breaking forwards
> +compatibility.
> +
> +The commit comment for a meta-commit is an auto-generated user-readable =
string
> +describing the command that produced the meta commit. These strings are =
shown
> +to the user when they view the obslog.
> +
> +Parent-type
> +-----------
> +The =E2=80=9Cparent-type=E2=80=9D field in the commit header identifies =
a commit as a
> +meta-commit and indicates the meaning for each of its parents. It is nev=
er
> +present for normal commits. It contains a space-deliminated list of enum=
 values
> +whose order matches the order of the parents. Possible parent types are:
> +
> +- c: (content) the content parent identifies the commit that this meta-c=
ommit is
> +  describing.
> +- r: (replaced) indicates that this parent is made obsolete by the conte=
nt
> +  parent.
> +- o: (origin) indicates that the content parent was generated by cherry-=
picking
> +  this parent.
> +- a: (abandoned) used in place of a content parent for abandoned changes=
. Points
> +  to the final content commit for the change at the time it was abandone=
d.
> +
> +There must be exactly one content or abandoned parent for each meta-comm=
it and
> +it is always the first parent. The content commit will always be a norma=
l commit
> +and not a meta-commit. However, future versions of git may create meta-c=
ommits
> +for other meta-commits and the fsck tool must be aware of this for forwa=
rds
> +compatibility.
> +
> +A meta-commit can have zero or more replaced parents. An amend operation=
 creates
> +a single replaced parent. A merge used to resolve divergence (see diverg=
ence,
> +below) will create multiple replaced parents. A meta-commit may have no
> +replaced parents if it describes a cherry-pick or squash merge that copi=
es one
> +or more commits but does not replace them.
> +
> +A meta-commit can have zero or more origin parents. A cherry-pick create=
s a
> +single origin parent. Certain types of squash merge will create multiple=
 origin
> +parents. Origin parents don't directly cause their origin to become obso=
lete,
> +but are used when computing blame or locating a merge base. The section
> +on obsolescence over cherry-picks describes how the evolve command uses
> +origin parents.
> +
> +A replaced parent or origin parent may be either a normal commit (indica=
ting
> +the oldest-known version of a change) or another meta-commit (for a chan=
ge that
> +has already been modified one or more times).
> +
> +The parent-type field needs to go after the committer field since git's =
rules
> +for forwards-compatibility require that new fields to be at the end of t=
he
> +header. Putting a new field in the middle of the header would break fsck=
.
> +
> +The presence of an abandoned parent indicates that the change should be =
pruned
> +by the evolve command, and removed from the repository's history. Any fo=
llow-up
> +changes should rebased onto the parent of the pruned commit. The abandon=
ed
> +parent points to the version of the change that should be restored if th=
e user
> +attempts to restore the change.
> +
> +Changes
> +-------
> +A branch of meta-commits describes how a commit was produced and what pr=
evious
> +commits it is based on. It is also an identifier for a thing the user is
> +currently working on. We refer to such a meta-branch as a change.
> +
> +Local changes are stored in the new refs/metas namespace. Remote changes=
 are
> +stored in the refs/remote/<remotename>/metas namespace.
> +
> +The list of changes in refs/metas is more than just a mechanism for the =
evolve
> +command to locate obsolete commits. It is also a convenient list of all =
of a
> +user=E2=80=99s work in progress and their current state - a list of thin=
gs they=E2=80=99re
> +likely to want to come back to.
> +
> +Strictly speaking, it is the presence of the branch in the refs/metas na=
mespace
> +that marks a branch as being a change, not the fact that it points to a
> +metacommit. Metacommits are only created when a commit is amended or reb=
ased, so
> +in the case where a change points to a commit that has never been modifi=
ed, the
> +change points to that initial commit rather than a metacommit.
> +
> +Changes are also stored in the refs/hiddenmetas namespace. Hiddenmetas h=
olds
> +metadata for historical changes that are not currently in progress by th=
e user.
> +Commands like filter-branch and other bulk import commands create metada=
ta in
> +this namespace.
> +
> +Note that the changes in hiddenmetas get special treatment in several wa=
ys:
> +
> +- They are not cleaned up automatically once merged, since it is expecte=
d that
> +  they refer to historical changes.
> +- User commands that modify changes don't append to these changes as the=
y would
> +  to a change in refs/metas.
> +- They are not displayed when the user lists their local changes.
> +
> +Obsolescence
> +------------
> +A commit is considered obsolete if it is reachable from the =E2=80=9Crep=
laces=E2=80=9D edges
> +anywhere in the history of a change and it isn=E2=80=99t the head of tha=
t change.
> +Commits may be the content for 0 or more meta-commits. If the same commi=
t
> +appears in multiple changes, it is not obsolete if it is the head of any=
 of
> +those changes.
> +
> +Note that there is an exception to this rule. The metas namespace takes
> +precedence over the hiddenmetas namespace for the purpose of obsolescenc=
e. That
> +is, if a change appears in a replaces edge of a change in the metas name=
space,
> +it is obsolete even if it also appears as the head of a change in the
> +hiddenmetas namespace.
> +
> +This special case prevents the hiddenmetas namespace from creating diver=
gence
> +with the user's work in progress, and allows the user to resolve histori=
cal
> +divergence by creating new changes in the metas namespace.
> +
> +Divergence
> +----------
> +From the user=E2=80=99s perspective, two changes are divergent if they b=
oth ask for
> +different replacements to the same commit. More precisely, a target comm=
it is
> +considered divergent if there is more than one commit at the head of a c=
hange in
> +refs/metas that leads to the target commit via an unbroken chain of =E2=
=80=9Creplaces=E2=80=9D
> +parents.
> +
> +Much like a merge conflict, divergence is a situation that requires user
> +intervention to resolve. The evolve command will stop when it encounters
> +divergence and prompt the user to resolve the problem. Users can solve t=
he
> +problem in several ways:
> +
> +- Discard one of the changes (by deleting its change branch).
> +- Merge the two changes (producing a single change branch).
> +- Copy one of the changes (keep both commits, but one of them gets a new
> +  metacommit appended to its history that is connected to its predecesso=
r via an
> +  origin edge rather than a replaces edge. That new change no longer obs=
oletes
> +  the original.)
> +
> +Obsolescence across cherry-picks
> +--------------------------------
> +By default the evolve command will treat cherry-picks and squash merges =
as being
> +completely separate from the original. Further amendments to the origina=
l commit
> +will have no effect on the cherry-picked copy. However, this behavior ma=
y not be
> +desirable in all circumstances.
> +
> +The evolve command may at some point support an option to look for cases=
 where
> +the source of a cherry-pick or squash merge has itself been amended, and
> +automatically apply that same change to the cherry-picked copy. In such =
cases,
> +it would traverse origin edges rather than ignoring them, and would trea=
t a
> +commit with origin edges as being obsolete if any of its origins were ob=
solete.
> +
> +Garbage collection
> +------------------
> +For GC purposes, meta-commits are normal commits. Just as a commit cause=
s its
> +parents and tree to be retained, a meta-commit also causes its parents t=
o be
> +retained.
> +
> +Change creation
> +---------------
> +Changes are created automatically whenever the user runs a command like =
=E2=80=9Ccommit=E2=80=9D
> +that has the semantics of creating a new change. They also move forward
> +automatically even if they=E2=80=99re not checked out. For example, when=
ever the user
> +runs a command like =E2=80=9Ccommit --amend=E2=80=9D that modifies a com=
mit, all branches in
> +refs/metas that pointed to the old commit move forward to point to its
> +replacement instead. This also happens when the user is working from a d=
etached
> +head.
> +
> +This does not mean that every commit has a corresponding change. By defa=
ult,
> +changes only exist for recent locally-created commits. Users may explici=
tly pull
> +changes from other users or keep their changes around for a long time, b=
ut
> +either behavior requires a user to opt-in. Code review systems like gerr=
it may
> +also choose to keep changes around forever.
> +
> +Note that the changes in refs/metas serve a dual function as both a way =
to
> +identify obsolete changes and as a way for the user to keep track of the=
ir work
> +in progress. If we were only concerned with identifying obsolete changes=
, it
> +would be sufficient to create the change branch lazily the first time a =
commit
> +is obsoleted. Addressing the second use - of refs/metas as a mechanism f=
or
> +keeping track of work in progress - is the reason for eagerly creating t=
he
> +change on first commit.
> +
> +Change naming
> +-------------
> +When a change is first created, the only requirement for its name is tha=
t it
> +must be unique. Good names would also serve as useful mnemonics and be e=
asy to
> +type. For example, a short word from the commit message containing no nu=
mbers or
> +special characters and that shows up with low frequency in other commit =
messages
> +would make a good choice.
> +
> +Different users may prefer different heuristics for their change names. =
For this
> +reason a new hook will be introduced to compute change names. Git will i=
nvoke
> +the hook for all newly-created changes and will append a numeric suffix =
if the
> +name isn=E2=80=99t unique. The default heuristics are not specified by t=
his proposal and
> +may change during implementation.
> +
> +Change deletion
> +---------------
> +Changes are normally only interesting to a user while a commit is still =
in
> +development and under review. Once the commit has submitted wherever it =
is
> +going, its change can be discarded.
> +
> +The normal way of deleting changes makes this easy to do - changes are d=
eleted
> +by the evolve command when it detects that the change is present in an u=
pstream
> +branch. It does this in two ways: if the latest commit in a change eithe=
r shows
> +up in the branch history or the change becomes empty after a rebase, it =
is
> +considered merged and the change is discarded. In this context, an =E2=
=80=9Cupstream
> +branch=E2=80=9D is any branch passed in as the upstream argument of the =
evolve command.
> +
> +In case this sometimes deletes a useful change, such automatic deletions=
 are
> +recorded in the reflog allowing them to be easily recovered.
> +
> +Sharing changes
> +---------------
> +Change histories are shared by pushing or fetching meta-commits and chan=
ge
> +branches. This provides users with a lot of control of what to share and
> +repository implementations with control over what to retain.
> +
> +Users that only want to share the content of a commit can do so by pushi=
ng the
> +commit itself as they currently would. Users that want to share an edit =
history
> +for the commit can push its change, which would point to a meta-commit r=
ather
> +than the commit itself if there is any history to share. Note that multi=
ple
> +changes can refer to the same commits, so it=E2=80=99s possible to const=
ruct and push a
> +different history for the same commit in order to remove sensitive or ir=
relevant
> +intermediate states.
> +
> +Imagine the user is working on a change =E2=80=9Cmychange=E2=80=9D that =
is currently the latest
> +commit on master. They have two ways to share it:
> +
> +# User shares just a commit without its history
> +> git push origin master
> +
> +# User shares the full history of the commit to a review system
> +> git push origin metas/mychange:refs/for/master
> +
> +# User fetches a collaborator=E2=80=99s modifications to their change
> +> git fetch remotename metas/mychange
> +# Which updates the ref remote/remotename/metas/mychange
> +
> +This will cause more intermediate states to be shared with the server th=
an would
> +have been shared previously. A review system like gerrit would need to k=
eep
> +track of which states had been explicitly pushed versus other intermedia=
te
> +states in order to de-emphasize (or hide) the extra intermediate states =
from the
> +user interface.
> +
> +Merge-base
> +----------
> +Merge-base will be changed to search the meta-commit graph for common an=
cestors
> +as well as the commit graph, and will generally prefer results from the
> +meta-commit graph over the commit graph. Merge-base will consider meta-c=
ommits
> +from all changes, and will traverse both origin and obsolete edges.
> +
> +The reason for this is that - when merging two versions of the same comm=
it
> +together - an earlier version of that same commit will usually be much m=
ore
> +similar than their common parent. This should make the workflow of colla=
borating
> +on unsubmitted patches as convenient as the workflow for collaborating i=
n a
> +topic branch by eliminating repeated merges.
> +
> +Configuration
> +-------------
> +The core.enableChanges configuration variable enables the creation and u=
pdate
> +of change branches. This is enabled by default.
> +
> +User interface
> +--------------
> +All git porcelain commands that create commits are classified as having =
one of
> +four behaviors: modify, create, copy, or import. These behaviors are dis=
cussed
> +in more detail below.
> +
> +Modify commands
> +---------------
> +Modification commands (commit --amend, rebase) will mark the old commit =
as
> +obsolete by creating a new meta-commit that references the old one as a
> +replaced parent. In the event that multiple changes point to the same co=
mmit,
> +this is done independently for every such change.
> +
> +More specifically, modifications work like this:
> +
> +1. Locate all existing changes for which the old commit is the content f=
or the
> +   head of the change branch. If no such branch exists, create one that =
points
> +   to the old commit. Changes that include this commit in their history =
but not
> +   at their head are explicitly not included.
> +2. For every such change, create a new meta-commit that references the n=
ew
> +   commit as its content and references the old head of the change as a
> +   replaced parent.
> +3. Move the change branch forward to point to the new meta-commit.
> +
> +Copy commands
> +-------------
> +Copy commands (cherry-pick, merge --squash) create a new meta-commit tha=
t
> +references the old commits as origin parents. Besides the fact that the =
new
> +parents are tagged differently, copy commands work the same way as modif=
y
> +commands.
> +
> +Create commands
> +---------------
> +Creation commands (commit, merge) create a new commit and a new change t=
hat
> +points to that commit. The do not create any meta-commits.
> +
> +Import commands
> +---------------
> +Import commands (fetch, pull) do not create any new meta-commits or chan=
ges
> +unless that is specifically what they are importing. For example, the fe=
tch
> +command would update remote/origin/metas/change35 and fetch all referenc=
ed
> +meta-commits if asked to do so directly, but it wouldn=E2=80=99t create =
any changes or
> +meta-commits for commits discovered on the master branch when running =
=E2=80=9Cgit fetch
> +origin master=E2=80=9D.
> +
> +Other commands
> +--------------
> +Some commands don=E2=80=99t fit cleanly into one of the above categories=
.
> +
> +Semantically, filter-branch should be treated as a modify command, but d=
oing so
> +is likely to create a lot of irrelevant clutter in the changes namespace=
 and the
> +large number of extra change refs may introduce performance problems. We
> +recommend treating filter-branch as an import command initially, but mak=
ing it
> +behave more like a modify command in future follow-up work. One possible
> +solution may be to treat commits that are part of existing changes as be=
ing
> +modified but to avoid creating changes for other rewritten changes. Anot=
her
> +solution may be to record the modifications as changes in the hiddenmeta=
s
> +namespace.
> +
> +Once the evolve command can handle obsolescence across cherry-picks, suc=
h
> +cherry-picks will result in a hybrid move-and-copy operation. It will cr=
eate
> +cherry-picks that replace other cherry-picks, which will have both origi=
n edges
> +(pointing to the new source commit being picked) and replacement edges (=
pointing
> +to the previous cherry-pick being replaced).
> +
> +Evolve
> +------
> +The evolve command performs the correct sequence of rebases such that no=
 change
> +has an obsolete parent. The syntax looks like this:
> +
> +git evolve [upstream=E2=80=A6]
> +
> +It takes an optional list of upstream branches. All changes whose parent=
 shows
> +up in the history of one of the upstream branches will be rebased onto t=
he
> +upstream branch before resolving obsolete parents.
> +
> +Any change whose latest state is found in an upstream branch (or that en=
ds up
> +empty after rebase) will be deleted. This is the normal mechanism for de=
leting
> +changes. Changes are created automatically on the first commit, and are =
deleted
> +automatically when evolve determines that they=E2=80=99ve been merged up=
stream.
> +
> +Orphan commits are commits with obsolete parents. The evolve command the=
n
> +repeatedly rebases orphan commits with non-orphan parents until there ar=
e either
> +no orphan commits left, or a merge conflict is discovered. It will also
> +terminate if it detects a divergent parent or a cycle that can't be reso=
lved
> +using any of the enabled transformations.
> +
> +When evolve discovers divergence, it will first check if it can resolve =
the
> +divergence automatically using one of its enabled transformations. Suppo=
rted
> +transformations are:
> +
> +- Check if the user has already merged the divergent changes in a follow=
-up
> +  change. That is, look for an existing merge in a follow-up change wher=
e all
> +  the parents are divergent versions of the same change. Squash that mer=
ge with
> +  its parents and use the result as the resolution for the divergence.
> +
> +- Attempt to auto-merge all the divergent changes (disabled by default).
> +
> +Each of the transformations can be enabled or disabled by command line o=
ptions.
> +
> +Cycles can occur when two changes reference one another as parents. This=
 can
> +happen when both changes use an obsolete version of the other change as =
their
> +parent. Although there are never cycles in the commit graph, users can c=
reate
> +cycles in the change graph by rebasing changes onto obsolete commits. Th=
e evolve
> +command has a transformation that will detect and break cycles by arbitr=
arily
> +picking one of the changes to go first. If this generates a merge confli=
ct,
> +it tries each of the other changes in sequence to see if any ordering me=
rges
> +cleanly. If no possible ordering merges cleanly, it picks one and termin=
ates
> +to let the user resolve the merge conflict.
> +
> +If the working tree is dirty, evolve will attempt to stash the user's ch=
anges
> +before applying the evolve and then reapply those changes afterward, in =
much
> +the same way as rebase --autostash does.
> +
> +Checkout
> +--------
> +Running checkout on a change by name has the same effect as checking out=
 a
> +detached head pointing to the latest commit on that change-branch. There=
 is no
> +need to ever have HEAD point to a change since changes always move forwa=
rd when
> +necessary, no matter what branch the user has checked out
> +
> +Meta-commits themselves cannot be checked out by their hash.
> +
> +Reset
> +-----
> +Resetting a branch to a change by name is the same as resetting to the c=
ontent
> +(or abandoned) commit at that change=E2=80=99s head.
> +
> +Commit
> +------
> +Commit --amend gets modify semantics and will move existing changes forw=
ard. The
> +normal form of commit gets create semantics and will create a new change=
.
> +
> +$ touch foo && git add . && git commit -m "foo" && git tag A
> +$ touch bar && git add . && git commit -m "bar" && git tag B
> +$ touch baz && git add . && git commit -m "baz" && git tag C
> +
> +This produces the following commits:
> +A(tree=3D[foo])
> +B(tree=3D[foo, bar], parent=3DA)
> +C(tree=3D[foo, bar, baz], parent=3DB)
> +
> +...along with three changes:
> +metas/foo =3D A
> +metas/bar =3D B
> +metas/baz =3D C
> +
> +Running commit --amend does the following:
> +$ git checkout B
> +$ touch zoom && git add . && git commit --amend -m "baz and zoom"
> +$ git tag D
> +
> +Commits:
> +A(tree=3D[foo])
> +B(tree=3D[foo, bar], parent=3DA)
> +C(tree=3D[foo, bar, baz], parent=3DB)
> +D(tree=3D[foo, bar, zoom], parent=3DA)
> +Dmeta(content=3DD, obsolete=3DB)
> +
> +Changes:
> +metas/foo =3D A
> +metas/bar =3D Dmeta
> +metas/baz =3D C
> +
> +Merge
> +-----
> +Merge gets create, modify, or copy semantics based on what is being merg=
ed and
> +the options being used.
> +
> +The --squash version of merge gets copy semantics (it produces a new cha=
nge that
> +is marked as a copy of all the original changes that were squashed into =
it).
> +
> +The =E2=80=9Cmodify=E2=80=9D version of merge replaces both of the origi=
nal commits with the
> +resulting merge commit. This is one of the standard mechanisms for resol=
ving
> +divergence. The parents of the merge commit are the parents of the two c=
ommits
> +being merged. The resulting commit will not be a merge commit if both of=
 the
> +original commits had the same parent or if one was the parent of the oth=
er.
> +
> +The =E2=80=9Ccreate=E2=80=9D version of merge creates a new change point=
ing to a merge commit
> +that has both original commits as parents. The result is what merge prod=
uces now
> +- a new merge commit. However, this version of merge doesn=E2=80=99t dir=
ectly resolve
> +divergence.
> +
> +To select between these two behaviors, merge gets new =E2=80=9C--amend=
=E2=80=9D and =E2=80=9C--noamend=E2=80=9D
> +options which select between the =E2=80=9Ccreate=E2=80=9D and =E2=80=9Cm=
odify=E2=80=9D behaviors respectively,
> +with noamend being the default.
> +
> +For example, imagine we created two divergent changes like this:
> +
> +$ touch foo && git add . && git commit -m "foo" && git tag A
> +$ touch bar && git add . && git commit -m "bar" && git tag B
> +$ touch baz && git add . && git commit --amend -m "bar and baz"
> +$ git tag C
> +$ git checkout B
> +$ touch bam && git add . && git commit --amend -m "bar and bam"
> +$ git tag D
> +
> +At this point the commit graph looks like this:
> +
> +A(tree=3D[foo])
> +B(tree=3D[bar], parent=3DA)
> +C(tree=3D[bar, baz], parent=3DA)
> +D(tree=3D[bar, bam], parent=3DA)
> +Cmeta(content=3DC, obsoletes=3DB)
> +Dmeta(content=3DD, obsoletes=3DB)
> +
> +There would be three active changes with heads pointing as follows:
> +
> +metas/changeA=3DA
> +metas/changeB=3DCmeta
> +metas/changeB2=3DDmeta
> +
> +ChangeB and changeB2 are divergent at this point. Lets consider what hap=
pens if
> +perform each type of merge between changeB and changeB2.
> +
> +Merge example: Amend merge
> +One way to resolve divergent changes is to use an amend merge. Recall th=
at HEAD
> +is currently pointing to D at this point.
> +
> +$ git merge --amend metas/changeB
> +
> +Here we=E2=80=99ve asked for an amend merge since we=E2=80=99re trying t=
o resolve divergence
> +between two versions of the same change. There are no conflicts so we en=
d up
> +with this:
> +
> +E(tree=3D[bar, baz, bam], parent=3DA)
> +Emeta(content=3DE, obsoletes=3D[Cmeta, Dmeta])
> +
> +With the following branches:
> +
> +metas/changeA=3DA
> +metas/changeB=3DEmeta
> +metas/changeB2=3DEmeta
> +
> +Notice that the result of the =E2=80=9Camend merge=E2=80=9D is a replace=
ment for C and D rather
> +than a new commit with C and D as parents (as a normal merge would have
> +produced). The parents of the amend merge are the parents of C and D whi=
ch - in
> +this case - is just A, so the result is not a merge commit. Also notice =
that
> +changeB and changeB2 are now aliases for the same change.
> +
> +Merge example: Noamend merge
> +Consider what would have happened if we=E2=80=99d used a noamend merge i=
nstead. Recall
> +that HEAD was at D and our branches looked like this:
> +
> +metas/changeA=3DA
> +metas/changeB=3DCmeta
> +metas/changeB2=3DDmeta
> +
> +$ git merge --noamend metas/changeB
> +
> +That would produce the sort of merge we=E2=80=99d normally expect today:
> +
> +F(tree=3D[bar, baz, bam], parent=3D[C, D])
> +
> +And our changes would look like this:
> +metas/changeA=3DA
> +metas/changeB=3DCmeta
> +metas/changeB2=3DDmeta
> +metas/changeF=3DF
> +
> +In this case, changeB and changeB2 are still divergent and we=E2=80=99ve=
 created a new
> +change for our merge commit. However, this is just a temporary state. Th=
e next
> +time we run the =E2=80=9Cevolve=E2=80=9D command, it will discover the d=
ivergence but also
> +discover the merge commit F that resolves it. Evolve will suggest conver=
ting F
> +into an amend merge in order to resolve the divergence and will display =
the
> +command for doing so.
> +
> +Rebase
> +------
> +In general the rebase command is treated as a modify command. When a cha=
nge is
> +rebased, the new commit replaces the original.
> +
> +Rebase --abort is special. Its intent is to restore git to the state it =
had
> +prior to running rebase. It should move back any changes to point to the=
 refs
> +they had prior to running rebase and delete any new changes that were cr=
eated as
> +part of the rebase. To achieve this, rebase will save the state of all c=
hanges
> +in refs/metas prior to running rebase and will restore the entire namesp=
ace
> +after rebase completes (deleting any newly-created changes). Newly-creat=
ed
> +metacommits are left in place, but will have no effect until garbage col=
lected
> +since metacommits are only used if they are reachable from refs/metas.
> +
> +Change
> +------
> +The =E2=80=9Cchange=E2=80=9D command can be used to list, rename, reset =
or delete change. It has
> +a number of subcommands.
> +
> +The "list" subcommand lists local changes. If given the -r argument, it =
lists
> +remote changes.
> +
> +The "rename" subcommand renames a change, given its old and new name. If=
 the old
> +name is omitted and there is exactly one change pointing to the current =
HEAD,
> +that change is renamed. If there are no changes pointing to the current =
HEAD,
> +one is created with the given name.
> +
> +The "forget" subcommand deletes a change by deleting its ref from the me=
tas/
> +namespace. This is the normal way to delete extra aliases for a change i=
f the
> +change has more than one name. By default, this will refuse to delete th=
e last
> +alias for a change if there are any other changes that reference this ch=
ange as
> +a parent.
> +
> +The "update" subcommand adds a new state to a change. It uses the defaul=
t
> +algorithm for assigning change names. If the content commit is omitted, =
HEAD is
> +used. If given the optional --force argument, it will overwrite any exis=
ting
> +change of the same name. This latter form of "update" can be used to eff=
ectively
> +reset changes.
> +
> +The "update" command can accept any number of --origin and --replace arg=
uments.
> +If any are present, the resulting change branch will point to a metacomm=
it
> +containing the given origin and replacement edges.
> +
> +The "abandon" command deletes a change using obsolescence markers. It ma=
rks the
> +change as being obsolete and having been replaced by its parent. If give=
n no
> +arguments, it applies to the current commit. Running evolve will cause a=
ny
> +abandoned changes to be removed from the branch. Any child changes will =
be
> +reparented on top of the parent of the abandoned change. If the current =
change
> +is abandoned, HEAD will move to point to its parent.
> +
> +The "restore" command restores a previously-abandoned change.
> +
> +The "prune" command deletes all obsolete changes and all changes that ar=
e
> +present in the given branch. Note that such changes can be recovered fro=
m the
> +reflog.
> +
> +Combined with the GC protection that is offered, this is intended to fac=
ilitate
> +a workflow that relies on changes instead of branches. Users could choos=
e to
> +work with no local branches and use changes instead - both for mailing l=
ist and
> +gerrit workflows.
> +
> +Log
> +---
> +When a commit is shown in git log that is part of a change, it is decora=
ted with
> +extra change information. If it is the head of a change, the name of the=
 change
> +is shown next to the list of branches. If it is obsolete, it is decorate=
d with
> +the text =E2=80=9Cobsolete, <n> commits behind <changename>=E2=80=9D.
> +
> +Log gets a new --obslog argument indicating that the obsolescence graph =
should
> +be followed instead of the commit graph. This also changes the default
> +formatting options to make them more appropriate for viewing different
> +iterations of the same commit.
> +
> +Pull
> +----
> +
> +Pull gets an --evolve argument that will automatically attempt to run "e=
volve"
> +on any affected branches after pulling.
> +
> +We also introduce an "evolve" enum value for the branch.<name>.rebase co=
nfig
> +value. When set, the evolve behavior will happen automatically for that =
branch
> +after every pull even if the --evolve argument is not used.
> +
> +Next
> +----
> +
> +The "next" command will reset HEAD to a non-obsolete commit that refers =
to this
> +change as its parent. If there is more than one such change, the user wi=
ll be
> +prompted. If given the --evolve argument, the next commit will be evolve=
d if
> +necessary first.
> +
> +The "next" command can be thought of as the opposite of
> +"git reset --hard HEAD^" in that it navigates to a child commit rather t=
han a
> +parent.
> +
> +Prev
> +----
> +
> +The "prev" command will reset HEAD to the latest version of the parent c=
hange.
> +If the parent change isn't obsolete, this is equivalent to
> +"git reset --hard HEAD^". If the parent commit is obsolete, it resets to=
 the
> +latest replacement for the parent commit.
> +
> +Other options considered
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +We considered several other options for storing the obsolescence graph. =
This
> +section describes the other options and why they were rejected.
> +
> +Commit header
> +-------------
> +Add an =E2=80=9Cobsoletes=E2=80=9D field to the commit header that point=
s backwards from a
> +commit to the previous commits it obsoletes.
> +
> +Pros:
> +- Very simple
> +- Easy to traverse from a commit to the previous commits it obsoletes.
> +Cons:
> +- Adds a cost to the storage format, even for commits where the change h=
istory
> +  is uninteresting.
> +- Unconditionally prevents the change history from being garbage collect=
ed.
> +- Always causes the change history to be shared when pushing or pulling =
changes.
> +
> +Git notes
> +---------
> +Instead of storing obsolescence information in metacommits, the metacomm=
it
> +content could go in a new notes namespace - say refs/notes/metacommit. E=
ach note
> +would contain the list of obsolete and origin parents. An automerger cou=
ld
> +be supplied to make it easy to merge the metacommit notes from different=
 remotes.
> +
> +Pros:
> +- Easy to locate all commits obsoleted by a given commit (since there wo=
uld only
> +  be one metacommit for any given commit).
> +Cons:
> +- Wrong GC behavior (obsolete commits wouldn=E2=80=99t automatically be =
retained by GC)
> +  unless we introduced a special case for these kinds of notes.
> +- No way to selectively share or pull the metacommits for one specific c=
hange.
> +  It would be all-or-nothing, which would be expensive. This could be ad=
dressed
> +  by changes to the protocol, but this would be invasive.
> +- Requires custom auto-merging behavior on fetch.
> +
> +Tags
> +----
> +Put the content of the metacommit in a message attached to tag on the
> +replacement commit. This is very similar to the git notes approach and h=
as the
> +same pros and cons.
> +
> +Simple forward references
> +-------------------------
> +Record an edge from an obsolete commit to its replacement in this form:
> +
> +refs/obsoletes/<A>
> +
> +pointing to commit <B> as an indication that B is the replacement for th=
e
> +obsolete commit A.
> +
> +Pros:
> +- Protects <B> from being garbage collected.
> +- Fast lookup for the evolve operation, without additional search struct=
ures
> +  (=E2=80=9Cwhat is the replacement for <A>?=E2=80=9D is very fast).
> +
> +Cons:
> +- Can=E2=80=99t represent divergence (which is a P0 requirement).
> +- Creates lots of refs (which can be inefficient)
> +- Doesn=E2=80=99t provide a way to fetch only refs for a specific change=
.
> +- The obslog command requires a search of all refs.
> +
> +Complex forward references
> +--------------------------
> +Record an edge from an obsolete commit to its replacement in this form:
> +
> +refs/obsoletes/<change_id>/obs<A>_<B>
> +
> +Pointing to commit <B> as an indication that B is the replacement for ob=
solete
> +commit A.
> +
> +Pros:
> +- Permits sharing and fetching refs for only a specific change.
> +- Supports divergence
> +- Protects <B> from being garbage collected.
> +
> +Cons:
> +- Creates lots of refs, which is inefficient.
> +- Doesn=E2=80=99t provide a good lookup structure for lookups in either =
direction.
> +
> +Backward references
> +-------------------
> +Record an edge from a replacement commit to the obsolete one in this for=
m:
> +
> +refs/obsolescences/<B>
> +
> +Cons:
> +- Doesn=E2=80=99t provide a way to resolve divergence (which is a P0 req=
uirement).
> +- Doesn=E2=80=99t protect <B> from being garbage collected (which could =
be fixed by
> +  combining this with a refs/metas namespace, as in the metacommit varia=
nt).
> +
> +Obsolescences file
> +------------------
> +Create a custom file (or files) in .git recording obsolescences.
> +
> +Pros:
> +- Can store exactly the information we want with exactly the performance=
 we want
> +  for all operations. For example, there could be a disk-based hashtable
> +  permitting constant time lookups in either direction.
> +
> +Cons:
> +- Handling GC, pushing, and pulling would all require custom solutions. =
GC
> +  issues could be addressed with a repository format extension.
> +
> +Squash points
> +-------------
> +We treat changes like topic branches, and use special squash points to m=
ark
> +places in the commit graph that separate changes.
> +
> +We create and update change branches in refs/metas at the same time we
> +would have in the metacommit proposal. However, rather than pointing to =
a
> +metacommit branch they point to normal commits and are treated as =E2=80=
=9Csquash
> +points=E2=80=9D - markers for sequences of commits intended to be squash=
ed together on
> +submission.
> +
> +Amends and rebases work differently than they do now. Rather than actual=
ly
> +containing the desired state of a commit, they contain a delta from the =
previous
> +version along with a squash point indicating that the preceding changes =
are
> +intended to be squashed on submission. Specifically, amends would become=
 new
> +changes and rebases would become merge commits with the old commit and n=
ew
> +parent as parents.
> +
> +When the changes are finally submitted, the squashes are executed, produ=
cing the
> +final version of the commit.
> +
> +In addition to the squash points, git would maintain a set of =E2=80=9Cn=
osquash=E2=80=9D tags
> +for commits that were used as ancestors of a change that are not meant t=
o be
> +included in the squash.
> +
> +For example, if we have this commit graph:
> +
> +A(...)
> +B(parent=3DA)
> +C(parent=3DB)
> +
> +...and we amend B to produce D, we=E2=80=99d get:
> +
> +A(...)
> +B(parent=3DA)
> +C(parent=3DB)
> +D(parent=3DB)
> +
> +...along with a new change branch indicating D should be squashed with i=
ts
> +parents when submitted:
> +
> +metas/changeB =3D D
> +metas/changeC =3D C
> +
> +We=E2=80=99d also create a nosquash tag for A indicating that A shouldn=
=E2=80=99t be included
> +when changeB is squashed.
> +
> +If a user amends the change again, they=E2=80=99d get:
> +
> +A(...)
> +B(parent=3DA)
> +C(parent=3DB)
> +D(parent=3DB)
> +E(parent=3DD)
> +
> +metas/changeB =3D E
> +metas/changeC =3D C
> +
> +Pros:
> +- Good GC behavior.
> +- Provides a natural way to share changes (they=E2=80=99re just normal b=
ranches).
> +- Merge-base works automatically without special cases.
> +- Rewriting the obslog would be easy using existing git commands.
> +- No new data types needed.
> +Cons:
> +- No way to connect the squashed version of a change to the original, so=
 no way
> +  to automatically clean up old changes. This also means users lose all =
benefits
> +  of the evolve command if they prematurely squash their commits. This m=
ay occur
> +  if a user thinks a change is ready for submission, squashes it, and th=
en later
> +  discovers an additional change to make.
> +- Histories would look very cluttered (users would see all previous edit=
s to
> +  their commit in the commit log, and all previous rebases would show up=
 as
> +  merges). Could be quite hard for users to tell what is going on. (Poss=
ible
> +  fix: also implement a new smart log feature that displays the log as t=
hough
> +  the squashes had occurred).
> +- Need to change the current behavior of current commands (like amend an=
d
> +  rebase) in ways that will be unexpected to many users.
> --
> gitgitgadget
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68061F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 20:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeKRGtG (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 01:49:06 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:43336 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeKRGtG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 01:49:06 -0500
Received: by mail-lj1-f177.google.com with SMTP id g26-v6so23120961lja.10
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 12:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/cNgt9TUF6hZrQq9C9oOdv4VmOiC/YtXeiisLlsOGlw=;
        b=JbDTi4TOqdtqBwRCU+KBW3PC+pbtdFQvK0b40BAY5KLZ8k+oc/d+0ZE1hLR/qZHjoH
         hqPvXN3FGaqjkdGCPhjj9Xdy0CNEx7K/gGBRdeLGASy3LiCllWdwhin164+j359ID5Ym
         SAHcsBw4s2Ls3EAs8JP/6Ka1/Tw8tyCJ/h0cWugYeomYgxQoX4Ba4fkHbr+FMuF6g2FV
         AQ+2UCDqwzurpoWggdFabiKQdxo1uCN+5DSl689mg/RpiVk7fi5zU7uwyv5Ffkez5UdQ
         ZH+ineRXmVfGXS2g+KbLd9TjSV3+HlEuhVRSg9fUnp0gPyzic8d9meOAExkA/oFRd0HL
         66pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/cNgt9TUF6hZrQq9C9oOdv4VmOiC/YtXeiisLlsOGlw=;
        b=nMefQc6hEQcjou/H3MIcgQRa/QNUDX2ecx1MRzv1+qGUA4smVV6YbaWapAOeO7DXPy
         WLinRVzOGcf8QhyiwgLCa0JU4LmcZXuWFGrebBWzyWkDcGACpGu2VI9WbKmOBmKICyyw
         SgFBAdKmmqLxj+Q/YuJqPEKft77wFTfqvtuQtuEU9KItjTPghHnSw/FjGrmFH+Qu+Nvd
         3aYP/jsr8LENO4LOQc+ZBdkakxqWu/lKl4CjYV9L3dixTo98BnFyhMrmoQ2pqvnis0Qg
         CDERKfusotsJ7tjkzPj+MDJbeJqp0QKN3HqDYve0OwdLZJVhxLwQEz/2q6GkDj8XNuro
         X1yA==
X-Gm-Message-State: AGRZ1gKniQvuQ770WSGRVzvnbniBMFfyfLhrw6wvDiqnu0XmcY/G1sF1
        GDjh+LlQIB4SDkeL1punZb2RAeDnLOodk937XpS/gA==
X-Google-Smtp-Source: AJdET5cROKIxvlwn4Fw5mTGb0fBAUsAjKW5QDMkQfcjAsDcwiiXs2lE44FI2j9GptJVkK5aT1yxih4jxPCqfKuyCF1M=
X-Received: by 2002:a2e:8702:: with SMTP id m2-v6mr8350784lji.132.1542486669503;
 Sat, 17 Nov 2018 12:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <nycvar.QRO.7.76.6.1811151344490.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811151344490.41@tvgsbejvaqbjf.bet>
From:   Stefan Xenos <sxenos@google.com>
Date:   Sat, 17 Nov 2018 12:30:58 -0800
Message-ID: <CAPL8Zitk1UBxpVCRWc-SV+1MtaOCJUOYUqCh7eJQcdR_wqpNfQ@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I am not sure that we necessarily need this to be a graph. I think part
> of the problems with not being able to GC *any* of this is by this
> requirement to have it stored in a graph, rather than having mappings fro=
m
> which you could reconstruct any non-GC'ed parts of that graph, if you
> really want.

Sorry, I'm not sure what GC problem you're alluding to here. As far as
I'm aware, this proposal should permit us to GC or retain any subset
of commits that we want. We create a chain of metacommits pointing to
the commits we want to retain, and put a ref in the metas namespace to
cause the chain itself to be retained. If we want to GC a different
subset, we can build a different chain of metacommits and move the ref
(or delete the ref entirely to permit the whole chain to be gc'd).
Could you be more specific about which use-case is problematic?

> Why is this missing most notably `hg evolve`?

Good point. I'll add a brief description and comparison to the doc.

> Also, please do not forget `git imerge`.

Thanks for directing me to this. It looks fantastic! I'm not sure it's
really an alternative to this work, but I could see adding an argument
to "git evolve" that allows you to use imerge for resolving merge
conflicts at any given step.

> Further, I see that this document tries to suggest a proliferation of new=
 commands

It does. Let me explain a bit about the reasoning behind this
breakdown of commands. My main priority was to keep the commands as
consistent with existing git commands as possible. Secondary goals
were:
- Mapping a single intent to a single command where possible makes it
easier to explain what that command does.
- Having lots of simpler commands as opposed to a few complex commands
makes them easier to type.
- Command names are more descriptive than lettered arguments.

Git already has a "log" and "reflog" command for displaying two
different types of log, so putting "obslog" on its own command makes
it consistent with the existing logs, easier to type, and keeps the
command simple.

The "evolve" command updates changes to give them up-to-date parents.
This is a new type of user intent that didn't exist previously in git,
so putting it on its own command keeps things simpler for users. The
relationship between the evolve and change commands is a lot like the
the relationship between the rebase command and the branch commands.
They could technically be combined into one command but I'm not sure
this would help with usability.

The "change" command combines many user intents (create a change,
rename a change, delete a change, etc.) If I were to design it from
scratch, I'd prefer to have all of these things on separate commands.
However, since changes are very similar to branches and users are
presumably already familiar with the branch command, I intentionally
made the change command as close as possible to the branch command -
using the same arguments for the same purpose. In this case, I
sacrificed the single-intent and simple commands goals in order to
retain consistency.

Anyway, that was my reasoning behind the selection of commands. Of
course, I'd welcome feedback - a good UX is the one that was built by
listening to feedback from its intended users. Personally, I don't
consider a proliferation of new commands to be inherently bad (or
inherently good, really). Is there a reason new commands should be
avoided?

Some other alternatives to consider:

- We could turn "obslog" into an extra option on the "log" command,
but that would be inconsistent with reflog and would complicate the
already-complex log command.
- If we were to combine "evolve" with another command, "git rebase
--evolve" would probably be the best candidate. However, this is
longer to type and I tend to prefer lots of simple commands over a few
complex ones. Also, the evolve command will get additional options in
the future (to enable stuff like amend-over-cherry-pick, various
automatic resolution strategies for divergence, etc.)... and putting
it on rebase would mean we'd end up with a lot of extra arguments
whose doc says "this argument is only used if you're also using
--evolve".
- We could break the "change" command into a bunch of simpler ones
"lschange", "mkchange", "rmchange", "mvchange", etc. I actually like
this a lot, but this would make it diverge from the "branch" command
so I'm not sure we should do it unless enough of us feel the same way.
- We could combine the "change" command with the "branch" command. The
branch command could look for the "metas" prefix to determine whether
its argument is a branch or a change -- or it could just search one
namespace followed by the other. This would make for fewer commands,
but I'm concerned it may create confusion by making changes resemble
branches too closely. If you're not already familiar with the
distinction, you may see unexpected behavior when the "branch" you
think you're manipulating turns out to be a change.

  - Stefan

On Thu, Nov 15, 2018 at 4:52 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Wed, 14 Nov 2018, sxenos@google.com wrote:
>
> > From: Stefan Xenos <sxenos@google.com>
> >
> > This document describes what an obsolescence graph for
> > git would look like, the behavior of the evolve command,
> > and the changes planned for other commands.
>
> Thanks, this is a good discussion starter.
>
> > +Objective
> > +---------
> > +Track the edits to a commit over time in an obsolescence graph.
>
> I am not sure that we necessarily need this to be a graph. I think part o=
f
> the problems with not being able to GC *any* of this is by this
> requirement to have it stored in a graph, rather than having mappings fro=
m
> which you could reconstruct any non-GC'ed parts of that graph, if you
> really want.
>
> > +Background
> > +----------
> > +Imagine you have three dependent changes up for review and you receive=
 feedback
> > +that requires editing all three changes. While you're editing one, mor=
e feedback
> > +arrives on one of the others. What do you do?
> > +
> > +The evolve command is a convenient way to work with chains of commits =
that are
> > +under review. Whenever you rebase or amend a commit, the repository re=
members
> > +that the old commit is obsolete and has been replaced by the new one. =
Then, at
> > +some point in the future, you can run "git evolve" and the correct seq=
uence of
> > +rebases will occur in the correct order such that no commit has an obs=
olete
> > +parent.
> > +
> > +Part of making the "evolve" command work involves tracking the edits t=
o a commit
> > +over time, which is why we need an obsolescence graph. However, the ob=
solescence
> > +graph will also bring other benefits:
> > +
> > +- Users can view the history of a commit directly (the sequence of ame=
nds and
> > +  rebases it has undergone, orthogonal to the history of the branch it=
 is on).
> > +- It will be possible to quickly locate and list all the changes the u=
ser
> > +  currently has in progress.
> > +- It can be used as part of other high-level commands that combine or =
split
> > +  changes.
> > +- It can be used to decorate commits (in git log, gitk, etc) that are =
either
> > +  obsolete or are the tip of a work in progress.
> > +- By pushing and pulling the obsolescence graph, users can collaborate=
 more
> > +  easily on changes-in-progress. This is better than pushing and pulli=
ng the
> > +  changes themselves since the obsolescence graph can be used to locat=
e a more
> > +  specific merge base, allowing for better merges between different ve=
rsions of
> > +  the same change.
> > +- It could be used to correctly rebase local changes and other local b=
ranches
> > +  after running git-filter-branch.
> > +- It can replace the change-id footer used by gerrit.
>
> Okay.
>
> > +Similar technologies
> > +--------------------
> > +There are some other technologies that address the same end-user probl=
em.
> > +
> > +Rebase -i can be used to solve the same problem, but users can't easil=
y switch
> > +tasks midway through an interactive rebase or have more than one inter=
active
> > +rebase going on at the same time. It can't handle the case where you h=
ave
> > +multiple changes sharing the same parent when that parent needs to be =
rebased
> > +and won't let you collaborate with others on resolving a complicated i=
nteractive
> > +rebase. You can think of rebase -i as a top-down approach and the evol=
ve command
> > +as the bottom-up approach to the same problem.
> > +
> > +Several patch queue managers have been built on top of git (such as to=
pgit,
> > +stgit, and quilt). They address the same user need. However they also =
rely on
> > +state managed outside git that needs to be kept in sync. Such state ca=
n be
> > +easily damaged when running a git native command that is unaware of th=
e patch
> > +queue. They also typically require an explicit initialization step to =
be done by
> > +the user which creates workflow problems.
> > +
> > +Replacements (refs/replace) are superficially similar to obsolescences=
 in that
> > +they describe that one commit should be replaced by another. However, =
they
> > +differ in both how they are created and how they are intended to be us=
ed.
> > +Obsolescences are created automatically by the commands a user runs, a=
nd they
> > +describe the user=E2=80=99s intent to perform a future rebase. Obsolet=
e commits still
> > +appear in branches, logs, etc like normal commits (possibly with an ex=
tra
> > +decoration that marks them as obsolete). Replacements are typically cr=
eated
> > +explicitly by the user, they are meant to be kept around for a long ti=
me, and
> > +they describe a replacement to be applied at read-time rather than as =
the input
> > +to a future operation. When a replaced commit is queried, it is typica=
lly hidden
> > +and swapped out with its replacement as though the replacement has alr=
eady
> > +occurred.
>
> Why is this missing most notably `hg evolve`? Also, there should be *at
> least* a brief introduction how `hg evolve` works. They do have the
> benefit of real-world testing, and probably encountered problems and came
> up with solutions, and we would be remiss if we did not learn from them.
>
> Also, please do not forget `git imerge`.
>
> Further, I see that this document tries to suggest a proliferation of new
> commands (`git change`, `git evolve`, `git obslog` and whatever I glanced
> over). This smells a little bit like it wants to be condensed into a
> single-purpose command, maybe `evolve`, maybe something better if you can
> think of anything.
>
> I guess I will have to stop now and read up on how `hg evolve` works. It
> is a it of a pity that that was not described in this document, first
> thing, as it forces everybody who is interested in this patch to duplicat=
e
> my effort and also go hunt for information about Mercurial.
>
> Ciao,
> Johannes
>
> > +Goals
> > +-----
> > +Legend: Goals marked with P0 are required. Goals marked with Pn should=
 be
> > +attempted unless they interfere with goals marked with Pn-1.
> > +
> > +P0. All commands that modify commits (such as the normal commit --amen=
d or
> > +    rebase command) should mark the old commit as being obsolete and r=
eplaced by
> > +    the new one. No additional commands should be required to keep the
> > +    obsolescence graph up-to-date.
> > +P0. Any commit that may be involved in a future evolve command should =
not be
> > +    garbage collected. Specifically:
> > +    - Commits that obsolete another should not be garbage collected un=
til
> > +      user-specified conditions have occurred and the change has expir=
ed from
> > +      the reflog. User specified conditions for removing changes inclu=
de:
> > +      - The user explicitly deleted the change.
> > +      - The change was merged into a specific branch.
> > +    - Commits that have been obsoleted by another should not be garbag=
e
> > +      collected if any of their replacements are still being retained.
> > +P0. A commit can be obsoleted by more than one replacement (called div=
ergence).
> > +P0. Must be able to resolve divergence (convergence).
> > +P1. Users should be able to share chains of obsolete changes in order =
to
> > +    collaborate on WIP changes.
> > +P2. Such sharing should be at the user=E2=80=99s option. That is, it s=
hould be possible
> > +    to directly share a change without also sharing the file states or=
 commit
> > +    comments from the obsolete changes that led up to it, and the choi=
ce not to
> > +    share those commits should not require changing any commit hashes.
> > +P2. It should be possible to discard part or all of the obsolescence g=
raph
> > +    without discarding the commits themselves that are already present=
 in
> > +    branches and the reflog.
> > +
> > +
> > +Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +We introduce the notion of =E2=80=9Cmeta-commits=E2=80=9D which descri=
be how one commit was
> > +created from other commits. A branch of meta-commits is known as a cha=
nge.
> > +Changes are created and updated automatically whenever a user runs a c=
ommand
> > +that creates a commit. They are used for locating obsolete commits, pr=
oviding a
> > +list of a user=E2=80=99s unsubmitted work in progress, and providing a=
 stable name for
> > +each unsubmitted change.
> > +
> > +Users can exchange edit histories by pushing and fetching changes.
> > +
> > +New commands will be introduced for manipulating changes and resolving
> > +divergence between them. Existing commands that create commits will be=
 updated
> > +to modify the meta-commit graph and create changes where necessary.
> > +
> > +Example usage
> > +-------------
> > +# First create three dependent changes
> > +$ echo foo>bar.txt && git add .
> > +$ git commit -m "This is a test"
> > +created change metas/this_is_a_test
> > +$ echo foo2>bar2.txt && git add .
> > +$ git commit -m "This is also a test"
> > +created change metas/this_is_also_a_test
> > +$ echo foo3>bar3.txt && git add .
> > +$ git commit -m "More testing"
> > +created change metas/more_testing
> > +
> > +# List all our changes in progress
> > +$ git change -l
> > +metas/this_is_a_test
> > +metas/this_is_also_a_test
> > +* metas/more_testing
> > +metas/some_change_already_merged_upstream
> > +
> > +# Now modify the earliest change, using its stable name
> > +$ git reset --hard metas/this_is_a_test
> > +$ echo morefoo>>bar.txt && git add . && git commit --amend --no-edit
> > +
> > +# Use git-evolve to fix up any dependent changes
> > +$ git evolve
> > +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> > +rebasing metas/more_testing onto metas/this_is_also_a_test
> > +Done
> > +
> > +# Use git-obslog to view the history of the this_is_a_test change
> > +$ git obslog
> > +93f110 metas/this_is_a_test@{0} commit (amend): This is a test
> > +930219 metas/this_is_a_test@{1} commit: This is a test
> > +
> > +# Now create an unrelated change
> > +$ git reset --hard origin/master
> > +$ echo newchange>unrelated.txt && git add .
> > +$ git commit -m "Unrelated change"
> > +created change metas/unrelated_change
> > +
> > +# Fetch the latest code from origin/master and use git-evolve
> > +# to rebase all dependent changes.
> > +$ git fetch origin master
> > +$ git evolve origin/master
> > +deleting metas/some_change_already_merged_upstream
> > +rebasing metas/this_is_a_test onto origin/master
> > +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> > +rebasing metas/more_testing onto metas/this_is_also_a_test
> > +rebasing metas/unrelated_change onto origin/master
> > +Conflict detected! Resolve it and then use git evolve --continue to re=
sume.
> > +
> > +# Sort out the conflict
> > +$ git mergetool
> > +$ git evolve --continue
> > +Done
> > +
> > +# Share the full history of edits for the this_is_a_test change
> > +# with a review server
> > +$ git push origin metas/this_is_a_test:refs/for/master
> > +# Share the lastest commit for =E2=80=9CUnrelated change=E2=80=9D, wit=
hout history
> > +$ git push origin HEAD:refs/for/master
> > +
> > +Detailed design
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Obsolescence information is stored as a graph of meta-commits. A meta-=
commit is
> > +a specially-formatted merge commit that describes how one commit was c=
reated
> > +from others.
> > +
> > +Meta-commits look like this:
> > +
> > +$ git cat-file -p <example_meta_commit>
> > +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> > +parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> > +parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> > +parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> > +author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> > +committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> > +parent-type content
> > +parent-type obsolete
> > +parent-type origin
> > +
> > +This says =E2=80=9Ccommit aa7ce555 makes commit d64309ee obsolete. It =
was created by
> > +cherry-picking commit 7e1bbcd3=E2=80=9D.
> > +
> > +The tree for meta-commits is always the empty tree whose hash matches
> > +4b825dc642cb6eb9a060e54bf8d69288fbee4904 exactly, but future versions =
of git may
> > +attach other trees here. For forward-compatibility fsck should ignore =
such trees
> > +if found on future repository versions. Similarly, current versions of=
 git
> > +should always fill in an empty commit comment and tools like fsck shou=
ld ignore
> > +the content of the commit comment if present in a future repository ve=
rsion.
> > +This will allow future versions of git to add metadata to the meta-com=
mit
> > +comments or tree without breaking forwards compatibility.
> > +
> > +Parent-type
> > +-----------
> > +The =E2=80=9Cparent-type=E2=80=9D field in the commit header identifie=
s a commit as a
> > +meta-commit and indicates the meaning for each of its parents. It is n=
ever
> > +present for normal commits. It is a list of enum values whose order ma=
tches the
> > +order of the parents. Possible parent types are:
> > +
> > +- content: the content parent identifies the commit that this meta-com=
mit is
> > +  describing.
> > +- obsolete: indicates that this parent is made obsolete by the content=
 parent.
> > +- origin: indicates that this parent was generated from the given comm=
it.
> > +
> > +There must be exactly one content parent for each meta-commit and it i=
s always
> > +be the first parent. The content commit will always be a normal commit=
 and not a
> > +meta-commit. However, future versions of git may create meta-commits f=
or other
> > +meta-commits and the fsck tool must be aware of this for forwards comp=
atibility.
> > +
> > +A meta-commit can have zero or more obsolete parents. An amend operati=
on creates
> > +a single obsolete parent. A merge used to resolve divergence (see dive=
rgence,
> > +below) will create multiple obsolete parents. A meta-commit may have z=
ero
> > +obsolete parents if it describes a cherry-pick or squash merge that co=
pies one
> > +or more commits but does not replace them.
> > +
> > +A meta-commit can have zero or more origin parents. A cherry-pick crea=
tes a
> > +single origin parent. Certain types of squash merge will create multip=
le origin
> > +parents.
> > +
> > +An obsolete parent or origin parent may be either a normal commit (ind=
icating
> > +the oldest-known version of a change) or another meta-commit (for a ch=
ange that
> > +has already been modified one or more times).
> > +
> > +Changes
> > +-------
> > +A branch of meta-commits describes how a commit was produced and what =
previous
> > +commits it is based on. It is also an identifier for a thing the user =
is
> > +currently working on. We refer to such a meta-branch as a change.
> > +
> > +Local changes are stored in the new refs/metas namespace. Remote chang=
es are
> > +stored in the refs/remotemetas/<remotename> namespace.
> > +
> > +The list of changes in refs/metas is more than just a mechanism for th=
e evolve
> > +command to locate obsolete commits. It is also a convenient list of al=
l of a
> > +user=E2=80=99s work in progress and their current state - a list of th=
ings they=E2=80=99re
> > +likely to want to come back to.
> > +
> > +Strictly speaking, it is the presence of the branch in the refs/metas =
namespace
> > +that marks a branch as being a change, not the fact that it points to =
a
> > +metacommit. Metacommits are only created when a commit is amended or r=
ebased, so
> > +in the case where a change points to a commit that has never been modi=
fied, the
> > +change points to that initial commit rather than a metacommit.
> > +
> > +Obsolescence
> > +------------
> > +A commit is considered obsolete if it is reachable from the =E2=80=9Cr=
eplaces=E2=80=9D edges
> > +anywhere in the history of a change and it isn=E2=80=99t the head of t=
hat change.
> > +Commits may be the content for 0 or more meta-commits. If the same com=
mit
> > +appears in multiple changes, it is not obsolete if it is the head of a=
ny of
> > +those changes.
> > +
> > +Divergence
> > +----------
> > +From the user=E2=80=99s perspective, two changes are divergent if they=
 both ask for
> > +different replacements to the same commit. More precisely, a target co=
mmit is
> > +considered divergent if there is more than one commit at the head of a=
 change in
> > +refs/metas that leads to the target commit via an unbroken chain of =
=E2=80=9Cobsolete=E2=80=9D
> > +edges.
> > +
> > +Much like a merge conflict, divergence is a situation that requires us=
er
> > +intervention to resolve. The evolve command will stop when it encounte=
rs
> > +divergence and prompt the user to resolve the problem. Users can solve=
 the
> > +problem in several ways:
> > +
> > +- Discard one of the changes (by deleting its change branch).
> > +- Merge the two changes (producing a single change branch).
> > +- Copy one of the changes (keep both commits, but one of them gets a n=
ew
> > +  metacommit appended to its history that is connected to its predeces=
sor via an
> > +  origin edge rather than an obsolete edge. That new change no longer =
obsoletes
> > +  the original.)
> > +
> > +Obsolescence across cherry-picks
> > +--------------------------------
> > +By default the evolve command will treat cherry-picks and squash merge=
s as being
> > +completely separate from the original. Further amendments to the origi=
nal commit
> > +will have no effect on the cherry-picked copy. However, this behavior =
may not be
> > +desirable in all circumstances.
> > +
> > +The evolve command may at some point support an option to look for cas=
es where
> > +the source of a cherry-pick or squash merge has itself been amended, a=
nd
> > +automatically apply that same change to the cherry-picked copy. In suc=
h cases,
> > +it would traverse origin edges rather than ignoring them, and would tr=
eat a
> > +commit with origin edges as being obsolete if any of its origins were =
obsolete.
> > +
> > +Garbage collection
> > +------------------
> > +For GC purposes, meta-commits are normal commits. Just as a commit cau=
ses its
> > +parents and tree to be retained, a meta-commit also causes its parents=
 to be
> > +retained.
> > +
> > +Change creation
> > +---------------
> > +Changes are created automatically whenever the user runs a command lik=
e =E2=80=9Ccommit=E2=80=9D
> > +that has the semantics of creating a new change. They also move forwar=
d
> > +automatically even if they=E2=80=99re not checked out. For example, wh=
enever the user
> > +runs a command like =E2=80=9Ccommit --amend=E2=80=9D that modifies a c=
ommit, all branches in
> > +refs/metas that pointed to the old commit move forward to point to its
> > +replacement instead. This also happens when the user is working from a=
 detached
> > +head.
> > +
> > +This does not mean that every commit has a corresponding change. By de=
fault,
> > +changes only exist for recent locally-created commits. Users may expli=
citly pull
> > +changes from other users or keep their changes around for a long time,=
 but
> > +either behavior requires a user to opt-in. Code review systems like ge=
rrit may
> > +also choose to keep changes around forever.
> > +
> > +Note that the changes in refs/metas serve a dual function as both a wa=
y to
> > +identify obsolete changes and as a way for the user to keep track of t=
heir work
> > +in progress. If we were only concerned with identifying obsolete chang=
es, it
> > +would be sufficient to create the change branch lazily the first time =
a commit
> > +is obsoleted. Addressing the second use - of refs/metas as a mechanism=
 for
> > +keeping track of work in progress - is the reason for eagerly creating=
 the
> > +change on first commit.
> > +
> > +Change naming
> > +-------------
> > +When a change is first created, the only requirement for its name is t=
hat it
> > +must be unique. Good names would also serve as useful mnemonics and be=
 easy to
> > +type. For example, a short word from the commit message containing no =
numbers or
> > +special characters and that shows up with low frequency in other commi=
t messages
> > +would make a good choice.
> > +
> > +Different users may prefer different heuristics for their change names=
. For this
> > +reason a new hook will be introduced to compute change names. Git will=
 invoke
> > +the hook for all newly-created changes and will append a numeric suffi=
x if the
> > +name isn=E2=80=99t unique. The default heuristics are not specified by=
 this proposal and
> > +may change during implementation.
> > +
> > +Change deletion
> > +---------------
> > +Changes are normally only interesting to a user while a commit is stil=
l in
> > +development and under review. Once the commit has submitted wherever i=
t is
> > +going, its change can be discarded.
> > +
> > +The normal way of deleting changes makes this easy to do - changes are=
 deleted
> > +by the evolve command when it detects that the change is present in an=
 upstream
> > +branch. It does this in two ways: if the latest commit in a change eit=
her shows
> > +up in the branch history or the change becomes empty after a rebase, i=
t is
> > +considered merged and the change is discarded. In this context, an =E2=
=80=9Cupstream
> > +branch=E2=80=9D is any branch passed in as the upstream argument of th=
e evolve command.
> > +
> > +In case this sometimes deletes a useful change, such automatic deletio=
ns are
> > +recorded in the reflog allowing them to be easily recovered.
> > +
> > +Sharing changes
> > +---------------
> > +Change histories are shared by pushing or fetching meta-commits and ch=
ange
> > +branches. This provides users with a lot of control of what to share a=
nd
> > +repository implementations with control over what to retain.
> > +
> > +Users that only want to share the content of a commit can do so by pus=
hing the
> > +commit itself as they currently would. Users that want to share an edi=
t history
> > +for the commit can push its change, which would point to a meta-commit=
 rather
> > +than the commit itself if there is any history to share. Note that mul=
tiple
> > +changes can refer to the same commits, so it=E2=80=99s possible to con=
struct and push a
> > +different history for the same commit in order to remove sensitive or =
irrelevant
> > +intermediate states.
> > +
> > +Imagine the user is working on a change =E2=80=9Cmychange=E2=80=9D tha=
t is currently the latest
> > +commit on master, they have two ways to share it:
> > +
> > +# User shares just a commit without its history
> > +> git push origin master
> > +
> > +# User shares the full history of the commit to a review system
> > +> git push origin change/mychange:refs/for/master
> > +
> > +# User fetches a collaborator=E2=80=99s modifications to their change
> > +> git fetch remotename change/mychange
> > +# Which updates the ref remotechange/remotename/mychange
> > +
> > +This will cause more intermediate states to be shared with the server =
than would
> > +have been shared previously. A review system like gerrit would need to=
 keep
> > +track of which states had been explicitly pushed versus other intermed=
iate
> > +states in order to de-emphasize (or hide) the extra intermediate state=
s from the
> > +user interface.
> > +
> > +Merge-base
> > +----------
> > +Merge-base will be changed to search the meta-commit graph for common =
ancestors
> > +as well as the commit graph, and will generally prefer results from th=
e
> > +meta-commit graph over the commit graph. Merge-base will consider meta=
-commits
> > +from all changes, and will traverse both origin and obsolete edges.
> > +
> > +The reason for this is that - when merging two versions of the same co=
mmit
> > +together - an earlier version of that same commit will usually be much=
 more
> > +similar than their common parent. This should make the workflow of col=
laborating
> > +on unsubmitted patches as convenient as the workflow for collaborating=
 in a
> > +topic branch by eliminating repeated merges.
> > +
> > +User interface
> > +--------------
> > +All git porcelain commands that create commits are classified as havin=
g one of
> > +four behaviors: modify, create, copy, or import. These behaviors are d=
iscussed
> > +in more detail below.
> > +
> > +Modify commands
> > +---------------
> > +Modification commands (commit --amend, rebase) will mark the old commi=
t as
> > +obsolete by creating a new meta-commit that references the old one as =
an
> > +obsolete parent. In the event that multiple changes point to the same =
commit,
> > +this is done independently for every such change.
> > +
> > +More specifically, modifications work like this:
> > +
> > +1. Locate all existing changes for which the old commit is the content=
 for the
> > +   head of the change branch. If no such branch exists, create one tha=
t points
> > +   to the old commit. Changes that include this commit in their histor=
y but not
> > +   at their head are explicitly not included.
> > +2. For every such change, create a new meta-commit that references the=
 new
> > +   commit as its content and references the old head of the change as =
an
> > +   obsolete parent.
> > +3. Move the change branch forward to point to the new meta-commit.
> > +
> > +Copy commands
> > +-------------
> > +Copy commands (cherry-pick, merge --squash) create a new meta-commit t=
hat
> > +references the old commits as origin parents. Besides the fact that th=
e new
> > +parents are tagged differently, copy commands work the same way as mod=
ify
> > +commands.
> > +
> > +Create commands
> > +---------------
> > +Creation commands (commit, merge) create a new commit and a new change=
 that
> > +points to that commit. The do not create any meta-commits.
> > +
> > +Import commands
> > +---------------
> > +Import commands (fetch, pull) do not create any new meta-commits or ch=
anges
> > +unless that is specifically what they are importing. For example, the =
fetch
> > +command would update remotechange/origin/change35 and fetch all refere=
nced
> > +meta-commits if asked to do so directly, but it wouldn=E2=80=99t creat=
e any changes or
> > +meta-commits for commits discovered on the master branch when running =
=E2=80=9Cgit fetch
> > +origin master=E2=80=9D.
> > +
> > +Other commands
> > +--------------
> > +Some commands don=E2=80=99t fit cleanly into one of the above categori=
es.
> > +
> > +Semantically, filter-branch should be treated as a modify command, but=
 doing so
> > +is likely to create a lot of irrelevant clutter in the changes namespa=
ce and the
> > +large number of extra change refs may introduce performance problems. =
We
> > +recommend treating filter-branch as an import command initially, but m=
aking it
> > +behave more like a modify command in future follow-up work. One possib=
le
> > +solution may be to treat commits that are part of existing changes as =
being
> > +modified but to avoid creating changes for other rewritten changes.
> > +
> > +Once the evolve command can handle obsolescence across cherry-picks, s=
uch
> > +cherry-picks will result in a hybrid move-and-copy operation. It will =
create
> > +cherry-picks that replace other cherry-picks, which will have both ori=
gin edges
> > +(pointing to the new source commit being picked) and obsolete edges (p=
ointing to
> > +the previous cherry-pick being replaced).
> > +
> > +Evolve
> > +------
> > +The evolve command performs the correct sequence of rebases such that =
no change
> > +has an obsolete parent. The syntax looks like this:
> > +
> > +git evolve [--abort][--continue][--quit] [upstream=E2=80=A6]
> > +
> > +It takes an optional list of upstream branches. All changes whose pare=
nt shows
> > +up in the history of one of the upstream branches will be rebased onto=
 the
> > +upstream branch before resolving obsolete parents.
> > +
> > +Any change whose latest state is found in an upstream branch (or that =
ends up
> > +empty after rebase) will be deleted. This is the normal mechanism for =
deleting
> > +changes. Changes are created automatically on the first commit, and ar=
e deleted
> > +automatically when evolve determines that they=E2=80=99ve been merged =
upstream.
> > +
> > +Orphan commits are commits with obsolete parents. The evolve command t=
hen
> > +repeatedly rebases orphan commits with non-orphan parents until there =
are either
> > +no orphan commits left, a merge conflict is discovered, or a divergent=
 parent is
> > +discovered.
> > +
> > +The --abort option returns all changes to the state they were in prior=
 to
> > +invoking evolve, and the --quit option terminates the current evolutio=
n without
> > +changing the current state.
> > +
> > +Checkout
> > +--------
> > +Running checkout on a change by name has the same effect as checking o=
ut a
> > +detached head pointing to the latest commit on that change-branch. The=
re is no
> > +need to ever have HEAD point to a change since changes always move for=
ward when
> > +necessary, no matter what branch the user has checked out
> > +
> > +Meta-commits themselves cannot be checked out by their hash.
> > +
> > +Reset
> > +-----
> > +Resetting a branch to a change by name is the same as resetting to the=
 commit at
> > +that change=E2=80=99s head.
> > +
> > +Commit
> > +------
> > +Commit --amend gets modify semantics and will move existing changes fo=
rward. The
> > +normal form of commit gets create semantics and will create a new chan=
ge.
> > +
> > +$ touch foo && git add . && git commit -m "foo" && git tag A
> > +$ touch bar && git add . && git commit -m "bar" && git tag B
> > +$ touch baz && git add . && git commit -m "baz" && git tag C
> > +
> > +This produces the following commits:
> > +A(tree=3D[foo])
> > +B(tree=3D[foo, bar], parent=3DA)
> > +C(tree=3D[foo, bar, baz], parent=3DB)
> > +
> > +...along with three changes:
> > +change/foo =3D A
> > +change/bar =3D B
> > +change/baz =3D C
> > +
> > +Running commit --amend does the following:
> > +$ git checkout B
> > +$ touch zoom && git add . && git commit --amend -m "baz and zoom"
> > +$ git tag D
> > +
> > +Commits:
> > +A(tree=3D[foo])
> > +B(tree=3D[foo, bar], parent=3DA)
> > +C(tree=3D[foo, bar, baz], parent=3DB)
> > +D(tree=3D[foo, bar, zoom], parent=3DA)
> > +Dmeta(content=3DD, obsolete=3DB)
> > +
> > +Changes:
> > +change/foo =3D A
> > +change/bar =3D Dmeta
> > +change/baz =3D C
> > +
> > +Merge
> > +-----
> > +Merge gets create, modify, or copy semantics based on what is being me=
rged and
> > +the options being used.
> > +
> > +The --squash version of merge gets copy semantics (it produces a new c=
hange that
> > +is marked as a copy of all the original changes that were squashed int=
o it).
> > +
> > +The =E2=80=9Cmodify=E2=80=9D version of merge replaces both of the ori=
ginal commits with the
> > +resulting merge commit. This is one of the standard mechanisms for res=
olving
> > +divergence. The parents of the merge commit are the parents of the two=
 commits
> > +being merged. The resulting commit will not be a merge commit if both =
of the
> > +original commits had the same parent or if one was the parent of the o=
ther.
> > +
> > +The =E2=80=9Ccreate=E2=80=9D version of merge creates a new change poi=
nting to a merge commit
> > +that has both original commits as parents. The result is what merge pr=
oduces now
> > +- a new merge commit. However, this version of merge doesn=E2=80=99t d=
irectly resolve
> > +divergence.
> > +
> > +To select between these two behaviors, merge gets new =E2=80=9C--amend=
=E2=80=9D and =E2=80=9C--noamend=E2=80=9D
> > +options which select between the =E2=80=9Ccreate=E2=80=9D and =E2=80=
=9Cmodify=E2=80=9D behaviors respectively,
> > +with noamend being the default.
> > +
> > +For example, imagine we created two divergent changes like this:
> > +
> > +$ touch foo && git add . && git commit -m "foo" && git tag A
> > +$ touch bar && git add . && git commit -m "bar" && git tag B
> > +$ touch baz && git add . && git commit --amend -m "bar and baz"
> > +$ git tag C
> > +$ git checkout B
> > +$ touch bam && git add . && git commit --amend -m "bar and bam"
> > +$ git tag D
> > +
> > +At this point the commit graph looks like this:
> > +
> > +A(tree=3D[foo])
> > +B(tree=3D[bar], parent=3DA)
> > +C(tree=3D[bar, baz], parent=3DA)
> > +D(tree=3D[bar, bam], parent=3DA)
> > +Cmeta(content=3DC, obsoletes=3DB)
> > +Dmeta(content=3DD, obsoletes=3DB)
> > +
> > +There would be three active changes with heads pointing as follows:
> > +
> > +change/changeA=3DA
> > +change/changeB=3DCmeta
> > +change/changeB2=3DDmeta
> > +
> > +ChangeB and changeB2 are divergent at this point. Lets consider what h=
appens if
> > +perform each type of merge between changeB and changeB2.
> > +
> > +Merge example: Amend merge
> > +One way to resolve divergent changes is to use an amend merge. Recall =
that HEAD
> > +is currently pointing to D at this point.
> > +
> > +$ git merge --amend change/changeB
> > +
> > +Here we=E2=80=99ve asked for an amend merge since we=E2=80=99re trying=
 to resolve divergence
> > +between two versions of the same change. There are no conflicts so we =
end up
> > +with this:
> > +
> > +E(tree=3D[bar, baz, bam], parent=3DA)
> > +Emeta(content=3DE, obsoletes=3D[Cmeta, Dmeta])
> > +
> > +With the following branches:
> > +
> > +change/changeA=3DA
> > +change/changeB=3DEmeta
> > +change/changeB2=3DEmeta
> > +
> > +Notice that the result of the =E2=80=9Camend merge=E2=80=9D is a repla=
cement for C and D rather
> > +than a new commit with C and D as parents (as a normal merge would hav=
e
> > +produced). The parents of the amend merge are the parents of C and D w=
hich - in
> > +this case - is just A, so the result is not a merge commit. Also notic=
e that
> > +changeB and changeB2 are now aliases for the same change.
> > +
> > +Merge example: Noamend merge
> > +Consider what would have happened if we=E2=80=99d used a noamend merge=
 instead. Recall
> > +that HEAD was at D and our branches looked like this:
> > +
> > +change/changeA=3DA
> > +change/changeB=3DCmeta
> > +change/changeB2=3DDmeta
> > +
> > +$ git merge --noamend change/changeB
> > +
> > +That would produce the sort of merge we=E2=80=99d normally expect toda=
y:
> > +
> > +F(tree=3D[bar, baz, bam], parent=3D[C, D])
> > +
> > +And our changes would look like this:
> > +change/changeA=3DA
> > +change/changeB=3DCmeta
> > +change/changeB2=3DDmeta
> > +change/changeF=3DF
> > +
> > +In this case, changeB and changeB2 are still divergent and we=E2=80=99=
ve created a new
> > +change for our merge commit. However, this is just a temporary state. =
The next
> > +time we run the =E2=80=9Cevolve=E2=80=9D command, it will discover the=
 divergence but also
> > +discover the merge commit F that resolves it. Evolve will suggest conv=
erting F
> > +into an amend merge in order to resolve the divergence and will displa=
y the
> > +command for doing so.
> > +
> > +Change
> > +------
> > +The =E2=80=9Cchange=E2=80=9D command can be used to list, rename, rese=
t or delete change. It
> > +takes arguments similar to the =E2=80=9Cbranch=E2=80=9D command.
> > +
> > +The -l argument lists all local changes that aren=E2=80=99t present in=
 the given branch.
> > +If the branch name is omitted, all local changes are listed.
> > +
> > +The -r argument list all remote changes.
> > +
> > +The -m argument renames a change, given its old and new name.
> > +
> > +The -d argument deletes a change. This is one way to resolve divergenc=
e.
> > +
> > +The -n argument renames the current change, or creates a change of the=
 given
> > +name for the current commit if no such change exists yet. If given an =
optional
> > +commit hash, the change is created for that commit rather than head. I=
f there
> > +are multiple local changes for the same commit and they are all aliase=
s for the
> > +same metacommit hash, they are all deleted except the newly-created na=
me. If
> > +given the name of a metacommit, the new change points to that metacomm=
it.
> > +
> > +The --purge argument deletes all obsolete changes and all changes that=
 are
> > +present in the given branch. Note that such changes can be recovered f=
rom the
> > +reflog.
> > +
> > +Combined with the GC protection that is offered, this is intended to f=
acilitate
> > +a workflow that relies on changes instead of branches. Users could cho=
ose to
> > +work with no local branches and use changes instead - both for mailing=
 list and
> > +gerrit workflows.
> > +
> > +Log
> > +---
> > +When a commit is shown in git log that is part of a change, it is deco=
rated with
> > +extra change information. If it is the head of a change, the name of t=
he change
> > +is shown next to the list of branches. If it is obsolete, it is decora=
ted with
> > +the word =E2=80=9Cobsolete=E2=80=9D.
> > +
> > +Obslog
> > +------
> > +Obslog command lists the change history for the current commit.
> > +
> > +Rebase
> > +------
> > +In general the rebase command is treated as a modify command. When a c=
hange is
> > +rebased, the new commit replaces the original.
> > +
> > +Rebase --abort is special. Its intent is to restore git to the state i=
t had
> > +prior to running rebase. It should move back any changes to point to t=
he refs
> > +they had prior to running rebase and delete any new changes that were =
created as
> > +part of the rebase. To achieve this, rebase will save the state of all=
 changes
> > +in refs/metas prior to running rebase and will restore the entire name=
space
> > +after rebase completes (deleting any newly-created changes). Newly-cre=
ated
> > +metacommits are left in place, but will have no effect until garbage c=
ollected
> > +since metacommits are only used if they are reachable from refs/metas.
> > +
> > +Other options considered
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +We considered several other options for storing the obsolescence graph=
. This
> > +section describes the other options and why they were rejected.
> > +
> > +Commit header
> > +-------------
> > +Add an =E2=80=9Cobsoletes=E2=80=9D field to the commit header that poi=
nts backwards from a
> > +commit to the previous commits it obsoletes.
> > +
> > +Pros:
> > +- Very simple
> > +- Easy to traverse from a commit to the previous commits it obsoletes.
> > +Cons:
> > +- Adds a cost to the storage format, even for commits where the change=
 history
> > +  is uninteresting.
> > +- Unconditionally prevents the change history from being garbage colle=
cted.
> > +- Always causes the change history to be shared when pushing or pullin=
g changes.
> > +
> > +Git notes
> > +---------
> > +Instead of storing obsolescence information in metacommits, the metaco=
mmit
> > +content could go in a new notes namespace - say refs/notes/metacommit.=
 Each note
> > +would contain the list of obsolete and origin parents, and an automerg=
er could
> > +be supplied to make it easy to merge the metacommit notes from differe=
nt remotes.
> > +
> > +Pros:
> > +- Easy to locate all commits obsoleted by a given commit (since there =
would only
> > +  be one metacommit for any given commit).
> > +Cons:
> > +- Wrong GC behavior (obsolete commits wouldn=E2=80=99t automatically b=
e retained by GC)
> > +  unless we introduced a special case for these kinds of notes.
> > +- No way to selectively share or pull the metacommits for one specific=
 change.
> > +  It would be all-or-nothing, which would be expensive. This could be =
addressed
> > +  by changes to the protocol, but this would be invasive.
> > +- Requires custom auto-merging behavior on fetch.
> > +
> > +Tags
> > +----
> > +Put the content of the metacommit in a message attached to tag on the
> > +replacement commit. This is very similar to the git notes approach and=
 has the
> > +same pros and cons.
> > +
> > +Simple forward references
> > +-------------------------
> > +Record an edge from an obsolete commit to its replacement in this form=
:
> > +
> > +refs/obsoletes/<A>
> > +
> > +pointing to commit <B> as an indication that B is the replacement for =
the
> > +obsolete commit A.
> > +
> > +Pros:
> > +- Protects <B> from being garbage collected.
> > +- Fast lookup for the evolve operation, without additional search stru=
ctures
> > +  (=E2=80=9Cwhat is the replacement for <A>?=E2=80=9D is very fast).
> > +
> > +Cons:
> > +- Can=E2=80=99t represent divergence (which is a P0 requirement).
> > +- Creates lots of refs (which can be inefficient)
> > +- Doesn=E2=80=99t provide a way to fetch only refs for a specific chan=
ge.
> > +- The obslog command requires a search of all refs.
> > +
> > +Complex forward references
> > +--------------------------
> > +Record an edge from an obsolete commit to its replacement in this form=
:
> > +
> > +refs/obsoletes/<change_id>/obs<A>_<B>
> > +
> > +Pointing to commit <B> as an indication that B is the replacement for =
obsolete
> > +commit A.
> > +
> > +Pros:
> > +- Permits sharing and fetching refs for only a specific change.
> > +- Supports divergence
> > +- Protects <B> from being garbage collected.
> > +
> > +Cons:
> > +- Creates lots of refs, which is inefficient.
> > +- Doesn=E2=80=99t provide a good lookup structure for lookups in eithe=
r direction.
> > +
> > +Backward references
> > +-------------------
> > +Record an edge from a replacement commit to the obsolete one in this f=
orm:
> > +
> > +refs/obsolescences/<B>
> > +
> > +Cons:
> > +- Doesn=E2=80=99t provide a way to resolve divergence (which is a P0 r=
equirement).
> > +- Doesn=E2=80=99t protect <B> from being garbage collected (which coul=
d be fixed by
> > +  combining this with a refs/metas namespace, as in the metacommit var=
iant).
> > +
> > +Obsolescences file
> > +------------------
> > +Create a custom file (or files) in .git recording obsolescences.
> > +
> > +Pros:
> > +- Can store exactly the information we want with exactly the performan=
ce we want
> > +  for all operations. For example, there could be a disk-based hashtab=
le
> > +  permitting constant time lookups in either direction.
> > +
> > +Cons:
> > +- Handling GC, pushing, and pulling would all require custom solutions=
. GC
> > +  issues could be addressed with a repository format extension.
> > +
> > +Squash points
> > +-------------
> > +We create and update change branches in refs/metas them at the same ti=
me we
> > +would in the metacommit proposal. However, rather than pointing to a m=
etacommit
> > +branch they point to normal commits and are treated as =E2=80=9Csquash=
 points=E2=80=9D - markers
> > +for sequences of commits intended to be squashed together on submissio=
n.
> > +
> > +Amends and rebases work differently than they do now. Rather than actu=
ally
> > +containing the desired state of a commit, they contain a delta from th=
e previous
> > +version along with a squash point indicating that the preceding change=
s are
> > +intended to be squashed on submission. Specifically, amends would beco=
me new
> > +changes and rebases would become merge commits with the old commit and=
 new
> > +parent as parents.
> > +
> > +When the changes are finally submitted, the squashes are executed, pro=
ducing the
> > +final version of the commit.
> > +
> > +In addition to the squash points, git would maintain a set of =E2=80=
=9Cnosquash=E2=80=9D tags
> > +for commits that were used as ancestors of a change that are not meant=
 to be
> > +included in the squash.
> > +
> > +For example, if we have this commit graph:
> > +
> > +A(...)
> > +B(parent=3DA)
> > +C(parent=3DB)
> > +
> > +...and we amend B to produce D, we=E2=80=99d get:
> > +
> > +A(...)
> > +B(parent=3DA)
> > +C(parent=3DB)
> > +D(parent=3DB)
> > +
> > +...along with a new change branch indicating D should be squashed with=
 its
> > +parents when submitted:
> > +
> > +change/changeB =3D D
> > +change/changeC =3D C
> > +
> > +We=E2=80=99d also create a nosquash tag for A indicating that A should=
n=E2=80=99t be included
> > +when changeB is squashed.
> > +
> > +If a user amends the change again, they=E2=80=99d get:
> > +
> > +A(...)
> > +B(parent=3DA)
> > +C(parent=3DB)
> > +D(parent=3DB)
> > +E(parent=3DD)
> > +
> > +change/changeB =3D E
> > +change/changeC =3D C
> > +
> > +Pros:
> > +- Good GC behavior.
> > +- Provides a natural way to share changes (they=E2=80=99re just normal=
 branches).
> > +- Merge-base works automatically without special cases.
> > +- Rewriting the obslog would be easy using existing git commands.
> > +- No new data types needed.
> > +Cons:
> > +- No way to connect the squashed version of a change to the original, =
so no way
> > +  to automatically clean up old changes. This also means users lose al=
l benefits
> > +  of the evolve command if they prematurely squash their commits. This=
 may occur
> > +  if a user thinks a change is ready for submission, squashes it, and =
then later
> > +  discovers an additional change to make.
> > +- Histories would look very cluttered (users would see all previous ed=
its to
> > +  their commit in the commit log, and all previous rebases would show =
up as
> > +  merges). Could be quite hard for users to tell what is going on. (Po=
ssible
> > +  fix: also implement a new smart log feature that displays the log as=
 though
> > +  the squashes had occurred).
> > +- Need to change the current behavior of current commands (like amend =
and
> > +  rebase) in ways that will be unexpected to many users.
> > --
> > 2.19.1.930.g4563a0d9d0-goog
> >
> >

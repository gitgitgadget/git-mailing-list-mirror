Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1E7C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 04:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiKOEEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 23:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiKOED5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 23:03:57 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8E71BEBA
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 20:03:51 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3704852322fso125920277b3.8
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 20:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc5ewpiu6enFotasx+Ptj3RGK7+Xz5JsN61BvZS2IT8=;
        b=FDQXeJA89Yd0CjHKn7NkJPPbpOnPhtYU0CJskcYT36pRykPV3plj626zCN+d7LVBck
         6dG+pfRM9KvA9Ft4i8Rak139+I4WDH+tnONJokk/ytzz1aLaV5Bk9YZ21N8Vafz2pjUz
         zklaXTMF7esOKNGsARq2UUYamFj/ia9ihDbd1R5+A+sezQ/UG0M/GLQSBYkR7dKrI3Bp
         mehrBxuHXrGg6+Cvv0GkQQ4r0zODrefNfFmzEuob/IWwz77MCWAPc+cDzYWNzu4BKkh0
         V7a/0X5DhzQW+vxulL0neP1ikHJbj08fW3yezKvnMxzGvJjXBWuUStpOvPHkG7+jaYeU
         QxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dc5ewpiu6enFotasx+Ptj3RGK7+Xz5JsN61BvZS2IT8=;
        b=ZfJSMSETP0KnKFWm6SYNu5qeHMBowEVhruA8Qmp/c5vhGU80IzjMZSP25+qBqNmHIg
         hUD5uDdtEsrRJ+Z/y0uEO5baUGOsALjVKr37elMXiIzN7VV4ulUCCjTevReovUxiUrq+
         2canB5sZCCxPhBN9BO99ufQySLiAw99EA0iRDpLLvs+6eMzkJXgTL021OQSDDB3WlD9M
         P+bynP2t6892f9Rzl23Ql5j0/1OG6zKSOJ+mcQpuz1FMLF7ZZaUcJ2083eLvr0HMZ8Cu
         t0gN2CQ1b2NfktxCjO8B0+l8SYCKNq4N55XXdgXxX6KjnV2CRCvbxY62fBvsspa/U4Bo
         n4ng==
X-Gm-Message-State: ANoB5pnjug6pZGHSewJJ3yiV2my2R1Mfsz+Y+KW8E6GpLPNBUb+QMZfg
        5Mr3AvUQNrfT/MAFmkPwTafb7h3BZ5bQuiChAwYpyJcaoOegrBs5Tsc=
X-Google-Smtp-Source: AA0mqf4jwl/7SBaKRZ7VdjpxvsuM27vIVibUuxo8idZlz2+SdHnlDD3gYpJnLGxtqfaAfECd/UGRX/gP5S72OQgGfyg=
X-Received: by 2002:a81:1756:0:b0:36b:a38a:95bc with SMTP id
 83-20020a811756000000b0036ba38a95bcmr15479618ywx.351.1668485029838; Mon, 14
 Nov 2022 20:03:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com> <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com>
In-Reply-To: <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 15 Nov 2022 12:03:37 +0800
Message-ID: <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=B9=
=B411=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 14:04=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Elijah Newren <newren@gmail.com>
>
> Once upon a time, Matheus wrote some patches to make
>    git grep [--cached | <REVISION>] ...
> restrict its output to the sparsity specification when working in a
> sparse checkout[1].  That effort got derailed by two things:
>
>   (1) The --sparse-index work just beginning which we wanted to avoid
>       creating conflicts for
>   (2) Never deciding on flag and config names and planned high level
>       behavior for all commands.
>
> More recently, Shaoxuan implemented a more limited form of Matheus'
> patches that only affected --cached, using a different flag name,
> but also changing the default behavior in line with what Matheus did.
> This again highlighted the fact that we never decided on command line
> flag names, config option names, and the big picture path forward.
>
> The --sparse-index work has been mostly complete (or at least released
> into production even if some small edges remain) for quite some time
> now.  We have also had several discussions on flag and config names,
> though we never came to solid conclusions.  Stolee once upon a time
> suggested putting all these into some document in
> Documentation/technical[3], which Victoria recently also requested[4].
> I'm behind the times, but here's a patch attempting to finally do that.
>
> [1] https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.=
1612901326.git.matheus.bernardino@usp.br/
>     (See his second link in that email in particular)
> [2] https://lore.kernel.org/git/20220908001854.206789-2-shaoxuan.yuan02@g=
mail.com/
> [3] https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvY=
Sb8akxAJgA@mail.gmail.com/
>     (Scroll to the very end for the final few paragraphs)
> [4] https://lore.kernel.org/git/cafcedba-96a2-cb85-d593-ef47c8c8397c@gith=
ub.com/
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     sparse-checkout.txt: new document with sparse-checkout directions
>
>     v2 and v3 didn't get any reviews (I know, I know, this document is
>     really long), but it's been nearly a month and this patch is still
>     marked as "Needs Review", so I'm hoping sending a v4 will encourage
>     feedback. I think it's good enough to accept and start iterating, but
>     want to be sure others agree.
>
>     As before, I think we're starting to converge on actual proposals;
>     there's some areas we've agreed on, others we've compromised on, and
>     some we've just figured out what the others were saying. The discussi=
on
>     has been very illuminating; thanks to everyone who has chimed in. I'v=
e
>     tried to take my best stab at cleaning up and culling things that don=
't
>     need to remain as open questions, but if I've mis-represented anyone =
or
>     missed something, don't hesitate to speak up. Everything is still ope=
n
>     for debate, even if not marked as a currently open question.
>
>     Changes since v3:
>
>      * A few minor wording cleanups here and there, and one paragraph mov=
ed
>        to keep similar things together.
>
>     Changes since v2:
>
>      * Compromised with Stollee on log -- Behavior A only affects
>        patch-related operations, not revision walking
>      * Incorporated Junio's suggestions about untracked file handling
>      * Added new usecases, one brought up by Martin, one by Stolee
>      * Added new sections:
>        * Usecases of primary concern
>        * Oversimplified mental models ("Cliff Notes" for this document!)
>      * Recategorization of a few commands based on discussion
>      * Greater details on how index operations work under Behavior A, to
>        avoid weird edge cases
>      * Extended explanation of the sparse specification, particularly whe=
n
>        index differs from HEAD
>      * Switched proposed flag names to --scope=3D{sparse,all} to avoid bi=
nary
>        flags that are hard to extend
>      * Switched proposed config option name (still need good values and
>        descriptions for it, though)
>      * Removed questions we seemed to have agreement on. Modified/extende=
d
>        some existing questions.
>      * Added Stolee's sparse-backfill ideas to the plans
>      * Additional Known bugs
>      * Various wording improvements
>      * Possibly other things I've missed.
>
>     Changes since v1:
>
>      * Added new sections:
>        * "Terminology"
>        * "Behavior classes"
>        * "Sparse specification vs. sparsity patterns"
>      * Tried to shuffle commands from unknown into appropriate sections
>        based on feedback, but I got some conflicting feedback, so...who
>        knows if thing are in the right place
>      * More consistency in using "sparse specification" over other terms
>      * Extra comments about how add/rm/mv operate on moving files across =
the
>        tracked/untracked boundary
>      * --restrict-but-warn should have been "restrict or error", but
>        reworded even more heavily as part of "Behavior classes" section
>      * Added extra questions based on feedback (--no-expand, update-index
>        stuff, apply --index)
>      * More details on apply/am bugs
>      * Documented read-tree issue
>      * A few cases of fixing line wrapping at <=3D80 chars
>      * Added more alternate name suggestions for options instead of
>        --[no-]restrict
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1367%2F=
newren%2Fsparse-checkout-directions-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1367/newre=
n/sparse-checkout-directions-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1367
>
>  Documentation/technical/sparse-checkout.txt | 1103 +++++++++++++++++++
>  1 file changed, 1103 insertions(+)
>  create mode 100644 Documentation/technical/sparse-checkout.txt
>
> diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/=
technical/sparse-checkout.txt
> new file mode 100644
> +=3D=3D=3D Terminology =3D=3D=3D
> +
> +sparse directory: An entry in the index corresponding to a directory, wh=
ich
> +       appears in the index instead of all the files under that director=
y
> +       that would normally appear.  See also sparse-index.  Something th=
at
> +       can cause confusion is that the "sparse directory" does NOT match
> +       the sparse specification, i.e. the directory is NOT present in th=
e
> +       working tree.  May be renamed in the future (e.g. to "skipped
> +       directory").
> +
> +sparse index: A special mode for sparse-checkout that also makes the
> +       index sparse by recording a directory entry in lieu of all the
> +       files underneath that directory (thus making that a "skipped
> +       directory" which unfortunately has also been called a "sparse
> +       directory"), and does this for potentially multiple
> +       directories.  Controlled by the --[no-]sparse-index option to
> +       init|set|reapply.
> +
> +sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
> +       define the set of files of interest.  A warning: It is easy to
> +       over-use this term (or the shortened "patterns" term), for two
> +       reasons: (1) users in cone mode specify directories rather than
> +       patterns (their directories are transformed into patterns, but
> +       users may think you are talking about non-cone mode if you use th=
e
> +       word "patterns"), and (b) the sparse specification might

nit: s/(b)/(2)/g

> +       transiently differ in the working tree or index from the sparsity
> +       patterns (see "Sparse specification vs. sparsity patterns").
> +
> +sparse specification: The set of paths in the user's area of focus.  Thi=
s
> +       is typically just the tracked files that match the sparsity
> +       patterns, but the sparse specification can temporarily differ and
> +       include additional files.  (See also "Sparse specification
> +       vs. sparsity patterns")
> +
> +       * When working with history, the sparse specification is exactly
> +         the set of files matching the sparsity patterns.
> +       * When interacting with the working tree, the sparse specificatio=
n
> +         is the set of tracked files with a clear SKIP_WORKTREE bit or
> +         tracked files present in the working copy.

I'm guessing what you mean here is:
Some files are stored with a flag bit of !SKIP_WORKTREE in its index entry.
But files are "vivifying" (restore to worktree) or new files added to
index (tracked files),
they also belong to the sparse specification.

I think we can add some examples to describe these terms.

#!/bin/sh

set -x

rm -rf mono-repo
git init mono-repo -b main
(
  cd mono-repo &&
  mkdir p1 p2 &&
  echo a >p1/a &&
  echo b >p1/b &&
  echo a >p2/a &&
  echo b >p2/b &&
  git add . &&
  git commit -m ok &&
  git sparse-checkout set p1 &&
  git ls-files -t &&
  echo a >>p1/a &&
  echo b >>p1/b &&
  mkdir p2 p3 &&
  echo next >>p2/a &&
  echo next >>p3/c &&
  git add p3/c &&
  # p2/a and p3/c vivify
  git ls-files -t &&
  # compare wortree/commit
  git --no-pager diff HEAD --name-only
)

> +       * When modifying or showing results from the index, the sparse
> +         specification is the set of files with a clear SKIP_WORKTREE bi=
t
> +         or that differ in the index from HEAD.

#!/bin/sh

set -x

rm -rf mono-repo
git init mono-repo -b main
(
  cd mono-repo &&
  mkdir p1 p2 &&
  echo a >p1/a &&
  echo b >p1/b &&
  echo a >p2/a &&
  echo b >p2/b &&
  git add . &&
  git commit -m ok &&
  git sparse-checkout set p1 &&
  git update-index --chmod=3D+x p2/a &&
  # compare commit/index
  git --no-pager diff --cached --name-only
)

> +       * If working with the index and the working copy, the sparse
> +         specification is the union of the paths from above.
> +
> +vivifying: When a command restores a tracked file to the working tree (a=
nd
> +       hopefully also clears the SKIP_WORKTREE bit in the index for that
> +       file), this is referred to as "vivifying" the file.
> +
> +
> +=3D=3D=3D Purpose of sparse-checkouts =3D=3D=3D
> +
> +sparse-checkouts exist to allow users to work with a subset of their
> +files.
> +
> +You can think of sparse-checkouts as subdividing "tracked" files into tw=
o
> +categories -- a sparse subset, and all the rest.  Implementationally, we
> +mark "all the rest" in the index with a SKIP_WORKTREE bit and leave them
> +out of the working tree.  The SKIP_WORKTREE files are still tracked, jus=
t
> +not present in the working tree.
> +
> +In the past, sparse-checkouts were defined by "SKIP_WORKTREE means the f=
ile
> +is missing from the working tree but pretend the file contents match HEA=
D".
> +That was not only bogus (it actually meant the file missing from the
> +working tree matched the index rather than HEAD), but it was also a
> +low-level detail which only provided decent behavior for a few commands.
> +There were a surprising number of ways in which that guiding principle g=
ave
> +command results that violated user expectations, and as such was a bad
> +mental model.  However, it persisted for many years and may still be fou=
nd
> +in some corners of the code base.
> +
> +Anyway, the idea of "working with a subset of files" is simple enough, b=
ut
> +there are multiple different high-level usecases which affect how some G=
it
> +subcommands should behave.  Further, even if we only considered one of
> +those usecases, sparse-checkouts can modify different subcommands in ove=
r a
> +half dozen different ways.  Let's start by considering the high level
> +usecases:
> +
> +  A) Users are _only_ interested in the sparse portion of the repo
> +
> +  A*) Users are _only_ interested in the sparse portion of the repo
> +      that they have downloaded so far
> +
> +  B) Users want a sparse working tree, but are working in a larger whole
> +
> +  C) sparse-checkout is a behind-the-scenes implementation detail allowi=
ng
> +     Git to work with a specially crafted in-house virtual file system;
> +     users are actually working with a "full" working tree that is
> +     lazily populated, and sparse-checkout helps with the lazy populatio=
n
> +     piece.
> +
> +It may be worth explaining each of these in a bit more detail:
> +
> +
> +  (Behavior A) Users are _only_ interested in the sparse portion of the =
repo
> +
> +These folks might know there are other things in the repository, but
> +don't care.  They are uninterested in other parts of the repository, and
> +only want to know about changes within their area of interest.  Showing
> +them other files from history (e.g. from diff/log/grep/etc.)  is a
> +usability annoyance, potentially a huge one since other changes in
> +history may dwarf the changes they are interested in.
> +
> +Some of these users also arrive at this usecase from wanting to use part=
ial
> +clones together with sparse checkouts (in a way where they have download=
ed
> +blobs within the sparse specification) and do disconnected development.
> +Not only do these users generally not care about other parts of the
> +repository, but consider it a blocker for Git commands to try to operate=
 on
> +those.  If commands attempt to access paths in history outside the spars=
ity
> +specification, then the partial clone will attempt to download additiona=
l
> +blobs on demand, fail, and then fail the user's command.  (This may be
> +unavoidable in some cases, e.g. when `git merge` has non-trivial changes=
 to
> +reconcile outside the sparse specification, but we should limit how ofte=
n
> +users are forced to connect to the network.)
> +
> +Also, even for users using partial clones that do not mind being
> +always connected to the network, the need to download blobs as
> +side-effects of various other commands (such as the printed diffstat
> +after a merge or pull) can lead to worries about local repository size
> +growing unnecessarily[10].
> +
> +  (Behavior A*) Users are _only_ interested in the sparse portion of the=
 repo
> +      that they have downloaded so far (a variant on the first usecase)
> +
> +This variant is driven by folks who using partial clones together with
> +sparse checkouts and do disconnected development (so far sounding like a
> +subset of behavior A users) and doing so on very large repositories.  Th=
e
> +reason for yet another variant is that downloading even just the blobs
> +through history within their sparse specification may be too much, so th=
ey
> +only download some.  They would still like operations to succeed without
> +network connectivity, though, so things like `git log -S${SEARCH_TERM} -=
p`
> +or `git grep ${SEARCH_TERM} OLDREV ` would need to be prepared to provid=
e
> +partial results that depend on what happens to have been downloaded.
> +
> +This variant could be viewed as Behavior A with the sparse specification
> +for history querying operations modified from "sparsity patterns" to
> +"sparsity patterns limited to the blobs we have already downloaded".
> +

 I think A's users might need a little more refinement.

A: Some users are _only_ interested in the sparse portion of the repo,
but they don't want to download all the blobs, they can accept to download
other data later using partial-clone, which can reduce the local storage si=
ze.
(Current default behavior)

A** : Some users are _only_ interested in the sparse portion of the repo,
but they want to download all the blobs in it to avoid some unnecessary
network connections afterwards.

> +=3D=3D=3D Usecases of primary concern =3D=3D=3D
> +
> +Most of the rest of this document will focus on Behavior A and Behavior
> +B.  Some notes about the other two cases and why we are not focusing on
> +them:
> +
> +  (Behavior A*)
> +
> +Supporting this usecase is estimated to be difficult and a lot of work.
> +There are no plans to implement it currently, but it may be a potential
> +future alternative.  Knowing about the existence of additional alternati=
ves
> +may affect our choice of command line flags (e.g. if we need tri-state o=
r
> +quad-state flags rather than just binary flags), so it was still importa=
nt
> +to at least note.
> +
> +Further, I believe the descriptions below for Behavior A are probably st=
ill
> +valid for this usecase, with the only exception being that it redefines =
the
> +sparse specification to restrict it to already-downloaded blobs.  The ha=
rd
> +part is in making commands capable of respecting that modified definitio=
n.
> +
> +  (Behavior C)
> +
> +This usecase violates some of the early sparse-checkout documented
> +assumptions (since files marked as SKIP_WORKTREE will be displayed to us=
ers
> +as present in the working tree).  That violation may mean various
> +sparse-checkout related behaviors are not well suited to this usecase an=
d
> +we may need tweaks -- to both documentation and code -- to handle it.
> +However, this usecase is also perhaps the simplest model to support in t=
hat
> +everything behaves like a dense checkout with a few exceptions (e.g. bra=
nch
> +checkouts and switches write fewer things, knowing the VFS will lazily
> +write the rest on an as-needed basis).
> +
> +Since there is no publically available VFS-related code for folks to try=
,
> +the number of folks who can test such a usecase is limited.
> +
> +The primary reason to note the Behavior C usecase is that as we fix thin=
gs
> +to better support Behaviors A and B, there may be additional places wher=
e
> +we need to make tweaks allowing folks in this usecase to get the origina=
l
> +non-sparse treatment.  For an example, see ecc7c8841d ("repo_read_index:
> +add config to expect files outside sparse patterns", 2022-02-25).  The
> +secondary reason to note Behavior C, is so that folks taking advantage o=
f
> +Behavior C do not assume they are part of the Behavior B camp and propos=
e
> +patches that break things for the real Behavior B folks.
> +
> +
> +=3D=3D=3D Oversimplified mental models =3D=3D=3D
> +
> +An oversimplification of the differences in the above behaviors is:
> +
> +  Behavior A: Restrict worktree and history operations to sparse specifi=
cation
> +  Behavior B: Restrict worktree operations to sparse specification; have=
 any
> +             history operations work across all files
> +  Behavior C: Do not restrict either worktree or history operations to t=
he
> +             sparse specification...with the exception of branch checkou=
ts or
> +             switches which avoid writing files that will match the inde=
x so
> +             they can later lazily be populated instead.
> +
> +
> +=3D=3D=3D Desired behavior =3D=3D=3D
> +
> +As noted previously, despite the simple idea of just working with a subs=
et
> +of files, there are a range of different behavioral changes that need to=
 be
> +made to different subcommands to work well with such a feature.  See
> +[1,2,3,4,5,6,7,8,9,10] for various examples.  In particular, at [2], we =
saw
> +that mere composition of other commands that individually worked correct=
ly
> +in a sparse-checkout context did not imply that the higher level command
> +would work correctly; it sometimes requires further tweaks.  So,
> +understanding these differences can be beneficial.
> +
> +* Commands behaving the same regardless of high-level use-case
> +
> +  * commands that only look at files within the sparsity specification
> +
> +      * diff (without --cached or REVISION arguments)
> +      * grep (without --cached or REVISION arguments)
> +      * diff-files
> +
> +  * commands that restore files to the working tree that match sparsity
> +    patterns, and remove unmodified files that don't match those
> +    patterns:
> +
> +      * switch
> +      * checkout (the switch-like half)
> +      * read-tree
> +      * reset --hard
> +
> +  * commands that write conflicted files to the working tree, but otherw=
ise
> +    will omit writing files to the working tree that do not match the
> +    sparsity patterns:
> +
> +      * merge
> +      * rebase
> +      * cherry-pick
> +      * revert
> +
> +      * `am` and `apply --cached` should probably be in this section but
> +       are buggy (see the "Known bugs" section below)
> +
> +    The behavior for these commands somewhat depends upon the merge
> +    strategy being used:
> +      * `ort` behaves as described above
> +      * `recursive` tries to not vivify files unnecessarily, but does so=
metimes
> +       vivify files without conflicts.
> +      * `octopus` and `resolve` will always vivify any file changed in t=
he merge
> +       relative to the first parent, which is rather suboptimal.
> +
> +    It is also important to note that these commands WILL update the ind=
ex
> +    outside the sparse specification relative to when the operation bega=
n,
> +    BUT these commands often make a commit just before or after such tha=
t
> +    by the end of the operation there is no change to the index outside =
the
> +    sparse specification.  Of course, if the operation hits conflicts or
> +    does not make a commit, then these operations clearly can modify the
> +    index outside the sparse specification.
> +
> +    Finally, it is important to note that at least the first four of the=
se
> +    commands also try to remove differences between the sparse
> +    specification and the sparsity patterns (much like the commands in t=
he
> +    previous section).
> +
> +  * commands that always ignore sparsity since commits must be full-tree
> +
> +      * archive
> +      * bundle
> +      * commit
> +      * format-patch
> +      * fast-export
> +      * fast-import
> +      * commit-tree
> +
> +  * commands that write any modified file to the working tree (conflicte=
d
> +    or not, and whether those paths match sparsity patterns or not):
> +
> +      * stash
> +      * apply (without `--index` or `--cached`)
> +
> +* Commands that may slightly differ for behavior A vs. behavior B:
> +
> +  Commands in this category behave mostly the same between the two
> +  behaviors, but may differ in verbosity and types of warning and error
> +  messages.
> +
> +  * commands that make modifications to which files are tracked:
> +      * add
> +      * rm
> +      * mv
> +      * update-index
> +
> +    The fact that files can move between the 'tracked' and 'untracked'
> +    categories means some commands will have to treat untracked files
> +    differently.  But if we have to treat untracked files differently,
> +    then additional commands may also need changes:
> +
> +      * status
> +      * clean
> +

I'm a bit worried about git status, because it's used in many shells
(e.g. zsh) i
in the git prompt function. Its default behavior is restricted, otherwise u=
sers
may get blocked when they use zsh to cd to that directory. I don't know how
to reproduce this problem (since the scenario is built on checkout to a loc=
al
unborn branch).

> +    In particular, `status` may need to report any untracked files outsi=
de
> +    the sparsity specification as an erroneous condition (especially to
> +    avoid the user trying to `git add` them, forcing `git add` to displa=
y
> +    an error).
> +
> +    It's not clear to me exactly how (or even if) `clean` would change,
> +    but it's the other command that also affects untracked files.
> +
> +    `update-index` may be slightly special.  Its --[no-]skip-worktree fl=
ag
> +    may need to ignore the sparse specification by its nature.  Also, it=
s
> +    current --[no-]ignore-skip-worktree-entries default is totally bogus=
.
> +
> +  * commands for manually tweaking paths in both the index and the worki=
ng tree
> +      * `restore`
> +      * the restore-like half of `checkout`
> +
> +    These commands should be similar to add/rm/mv in that they should
> +    only operate on the sparse specification by default, and require a
> +    special flag to operate on all files.
> +
> +    Also, note that these commands currently have a number of issues (se=
e
> +    the "Known bugs" section below)
> +
> +* Commands that significantly differ for behavior A vs. behavior B:
> +
> +  * commands that query history
> +      * diff (with --cached or REVISION arguments)
> +      * grep (with --cached or REVISION arguments)
> +      * show (when given commit arguments)
> +      * blame (only matters when one or more -C flags are passed)
> +       * and annotate
> +      * log
> +      * whatchanged
> +      * ls-files
> +      * diff-index
> +      * diff-tree
> +      * ls-tree
> +
> +    Note: for log and whatchanged, revision walking logic is unaffected
> +    but displaying of patches is affected by scoping the command to the
> +    sparse-checkout.  (The fact that revision walking is unaffected is
> +    why rev-list, shortlog, show-branch, and bisect are not in this
> +    list.)
> +
> +    ls-files may be slightly special in that e.g. `git ls-files -t` is
> +    often used to see what is sparse and what is not.  Perhaps -t should
> +    always work on the full tree?
> +

Recently git ls-files added a --format option, perhaps this can be modified=
 to
show if a file is SKIP_WORKTREE in the future.

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4cf8a23648..0aeff8e514 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -280,6 +280,9 @@ static size_t expand_show_index(struct strbuf *sb,
const char *start,
                              data->pathname));
        else if (skip_prefix(start, "(path)", &p))
                write_name_to_buf(sb, data->pathname);
+       else if (skip_prefix(start, "(skiptree)", &p))
+               strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
+                             "true" : "false");
        else
                die(_("bad ls-files format: %%%.*s"), (int)len, start);


> +=3D=3D=3D Behavior classes =3D=3D=3D
> +
> +From the above there are a few classes of behavior:
> +
> +  * "restrict"
> +
> +    Commands in this class only read or write files in the working tree
> +    within the sparse specification.
> +
> +    When moving to a new commit (e.g. switch, reset --hard), these comma=
nds
> +    may update index files outside the sparse specification as of the st=
art
> +    of the operation, but by the end of the operation those index files
> +    will match HEAD again and thus those files will again be outside the
> +    sparse specification.
> +
> +    When paths are explicitly specified, these paths are intersected wit=
h
> +    the sparse specification and will only operate on such paths.
> +    (e.g. `git restore [--staged] -- '*.png'`, `git reset -p -- '*.md'`)
> +
> +    Some of these commands may also attempt, at the end of their operati=
on,
> +    to cull transient differences between the sparse specification and t=
he
> +    sparsity patterns (see "Sparse specification vs. sparsity patterns" =
for
> +    details, but this basically means either removing unmodified files n=
ot
> +    matching the sparsity patterns and marking those files as
> +    SKIP_WORKTREE, or vivifying files that match the sparsity patterns a=
nd
> +    marking those files as !SKIP_WORKTREE).
> +
> +  * "restrict modulo conflicts"
> +
> +    Commands in this class generally behave like the "restrict" class,
> +    except that:
> +      (1) they will ignore the sparse specification and write files with
> +         conflicts to the working tree (thus temporarily expanding the
> +         sparse specification to include such files.)
> +      (2) they are grouped with commands which move to a new commit, sin=
ce
> +         they often create a commit and then move to it, even though we
> +         know there are many exceptions to moving to the new commit.  (F=
or
> +         example, the user may rebase a commit that becomes empty, or ha=
ve
> +         a cherry-pick which conflicts, or a user could run `merge
> +         --no-commit`, and we also view `apply --index` kind of like `am
> +         --no-commit`.)  As such, these commands can make changes to ind=
ex
> +         files outside the sparse specification, though they'll mark suc=
h
> +         files with SKIP_WORKTREE.
> +
> +  * "restrict also specially applied to untracked files"
> +
> +    Commands in this class generally behave like the "restrict" class,
> +    except that they have to handle untracked files differently too, oft=
en
> +    because these commands are dealing with files changing state between
> +    'tracked' and 'untracked'.  Often, this may mean printing an error
> +    message if the command had nothing to do, but the arguments may have
> +    referred to files whose tracked-ness state could have changed were i=
t
> +    not for the sparsity patterns excluding them.
> +
> +  * "no restrict"
> +
> +    Commands in this class ignore the sparse specification entirely.
> +
> +  * "restrict or no restrict dependent upon behavior A vs. behavior B"
> +
> +    Commands in this class behave like "no restrict" for folks in the
> +    behavior B camp, and like "restrict" for folks in the behavior A cam=
p.
> +    However, when behaving like "restrict" a warning of some sort might =
be
> +    provided that history queries have been limited by the sparse-checko=
ut
> +    specification.
> +
> +
> +=3D=3D=3D Subcommand-dependent defaults =3D=3D=3D
> +
> +Note that we have different defaults depending on the command for the
> +desired behavior :
> +
> +  * Commands defaulting to "restrict":
> +    * diff-files
> +    * diff (without --cached or REVISION arguments)
> +    * grep (without --cached or REVISION arguments)
> +    * switch
> +    * checkout (the switch-like half)
> +    * reset (<commit>)
> +
> +    * restore
> +    * checkout (the restore-like half)
> +    * checkout-index
> +    * reset (with pathspec)
> +
> +    This behavior makes sense; these interact with the working tree.
> +
> +  * Commands defaulting to "restrict modulo conflicts":
> +    * merge
> +    * rebase
> +    * cherry-pick
> +    * revert
> +
> +    * am
> +    * apply --index (which is kind of like an `am --no-commit`)
> +
> +    * read-tree (especially with -m or -u; is kind of like a --no-commit=
 merge)
> +    * reset (<tree-ish>, due to similarity to read-tree)
> +
> +    These also interact with the working tree, but require slightly
> +    different behavior either so that (a) conflicts can be resolved or (=
b)
> +    because they are kind of like a merge-without-commit operation.
> +
> +    (See also the "Known bugs" section below regarding `am` and `apply`)
> +
> +  * Commands defaulting to "no restrict":
> +    * archive
> +    * bundle
> +    * commit
> +    * format-patch
> +    * fast-export
> +    * fast-import
> +    * commit-tree
> +
> +    * stash
> +    * apply (without `--index`)
> +
> +    These have completely different defaults and perhaps deserve the mos=
t
> +    detailed explanation:
> +
> +    In the case of commands in the first group (format-patch,
> +    fast-export, bundle, archive, etc.), these are commands for
> +    communicating history, which will be broken if they restrict to a
> +    subset of the repository.  As such, they operate on full paths and
> +    have no `--restrict` option for overriding.  Some of these commands =
may
> +    take paths for manually restricting what is exported, but it needs t=
o
> +    be very explicit.
> +
> +    In the case of stash, it needs to vivify files to avoid losing the
> +    user's changes.
> +
> +    In the case of apply without `--index`, that command needs to update
> +    the working tree without the index (or the index without the working
> +    tree if `--cached` is passed), and if we restrict those updates to t=
he
> +    sparse specification then we'll lose changes from the user.
> +
> +  * Commands defaulting to "restrict also specially applied to untracked=
 files":
> +    * add
> +    * rm
> +    * mv
> +    * update-index
> +    * status
> +    * clean (?)
> +
> +    Our original implementation for the first three of these commands wa=
s
> +    "no restrict", but it had some severe usability issues:
> +      * `git add <somefile>` if honored and outside the sparse
> +       specification, can result in the file randomly disappearing later
> +       when some subsequent command is run (since various commands
> +       automatically clean up unmodified files outside the sparse
> +       specification).
> +      * `git rm '*.jpg'` could very negatively surprise users if it dele=
tes
> +       files outside the range of the user's interest.
> +      * `git mv` has similar surprises when moving into or out of the co=
ne,
> +       so best to restrict by default
> +
> +    So, we switched `add` and `rm` to default to "restrict", which made
> +    usability problems much less severe and less frequent, but we still =
got
> +    complaints because commands like:
> +       git add <file-outside-sparse-specification>
> +       git rm <file-outside-sparse-specification>
> +    would silently do nothing.  We should instead print an error in thos=
e
> +    cases to get usability right.
> +
> +    update-index needs to be updated to match, and status and maybe clea=
n
> +    also need to be updated to specially handle untracked paths.
> +
> +    There may be a difference in here between behavior A and behavior B =
in
> +    terms of verboseness of errors or additional warnings.
> +
> +  * Commands falling under "restrict or no restrict dependent upon behav=
ior
> +    A vs. behavior B"
> +
> +    * diff (with --cached or REVISION arguments)
> +    * grep (with --cached or REVISION arguments)
> +    * show (when given commit arguments)
> +    * blame (only matters when one or more -C flags passed)
> +      * and annotate
> +    * log
> +      * and variants: shortlog, gitk, show-branch, whatchanged, rev-list
> +    * ls-files
> +    * diff-index
> +    * diff-tree
> +    * ls-tree
> +
> +    For now, we default to behavior B for these, which want a default of
> +    "no restrict".
> +
> +    Note that two of these commands -- diff and grep -- also appeared in=
 a
> +    different list with a default of "restrict", but only when limited t=
o
> +    searching the working tree.  The working tree vs. history distinctio=
n
> +    is fundamental in how behavior B operates, so this is expected.  Not=
e,
> +    though, that for diff and grep with --cached, when doing "restrict"
> +    behavior, the difference between sparse specification and sparsity
> +    patterns is important to handle.
> +
> +    "restrict" may make more sense as the long term default for these[12=
].
> +    Also, supporting "restrict" for these commands might be a fair amoun=
t
> +    of work to implement, meaning it might be implemented over multiple
> +    releases.  If that behavior were the default in the commands that
> +    supported it, that would force behavior B users to need to learn to
> +    slowly add additional flags to their commands, depending on git
> +    version, to get the behavior they want.  That gradual switchover wou=
ld
> +    be painful, so we should avoid it at least until it's fully
> +    implemented.
> +
> +
> +=3D=3D=3D Sparse specification vs. sparsity patterns =3D=3D=3D
> +
> +In a well-behaved situation, the sparse specification is given directly
> +by the $GIT_DIR/info/sparse-checkout file.  However, it can transiently
> +diverge for a few reasons:
> +
> +    * needing to resolve conflicts (merging will vivify conflicted files=
)
> +    * running Git commands that implicitly vivify files (e.g. "git stash=
 apply")
> +    * running Git commands that explicitly vivify files (e.g. "git check=
out
> +      --ignore-skip-worktree-bits FILENAME")
> +    * other commands that write to these files (perhaps a user copies it
> +      from elsewhere)
> +
> +For the last item, note that we do automatically clear the SKIP_WORKTREE
> +bit for files that are present in the working tree.  This has been true
> +since 82386b4496 ("Merge branch 'en/present-despite-skipped'",
> +2022-03-09)
> +
> +However, such a situation is transient because:
> +
> +   * Such transient differences can and will be automatically removed as
> +     a side-effect of commands which call unpack_trees() (checkout,
> +     merge, reset, etc.).
> +   * Users can also request such transient differences be corrected via
> +     running `git sparse-checkout reapply`.  Various places recommend
> +     running that command.
> +   * Additional commands are also welcome to implicitly fix these
> +     differences; we may add more in the future.
> +
> +While we avoid dropping unstaged changes or files which have conflicts,
> +we otherwise aggressively try to fix these transient differences.  If
> +users want these differences to persist, they should run the `set` or
> +`add` subcommands of `git sparse-checkout` to reflect their intended
> +sparse specification.
> +
> +However, when we need to do a query on history restricted to the
> +"relevant subset of files" such a transiently expanded sparse
> +specification is ignored.  There are a couple reasons for this:
> +
> +   * The behavior wanted when doing something like
> +        git grep expression REVISION
> +     is roughly what the users would expect from
> +        git checkout REVISION && git grep expression
> +     (modulo a "REVISION:" prefix), which has a couple ramifications:
> +
> +   * REVISION may have paths not in the current index, so there is no
> +     path we can consult for a SKIP_WORKTREE setting for those paths.
> +
> +   * Since `checkout` is one of those commands that tries to remove
> +     transient differences in the sparse specification, it makes sense
> +     to use the corrected sparse specification
> +     (i.e. $GIT_DIR/info/sparse-checkout) rather than attempting to
> +     consult SKIP_WORKTREE anyway.
> +
> +So, a transiently expanded (or restricted) sparse specification applies =
to
> +the working tree, but not to history queries where we always use the
> +sparsity patterns.  (See [16] for an early discussion of this.)
> +
> +Similar to a transiently expanded sparse specification of the working tr=
ee
> +based on additional files being present in the working tree, we also nee=
d
> +to consider additional files being modified in the index.  In particular=
,
> +if the user has staged changes to files (relative to HEAD) that do not
> +match the sparsity patterns, and the file is not present in the working
> +tree, we still want to consider the file part of the sparse specificatio=
n
> +if we are specifically performing a query related to the index (e.g. git
> +diff --cached [REVISION], git diff-index [REVISION], git restore --stage=
d
> +--source=3DREVISION -- PATHS, etc.)  Note that a transiently expanded sp=
arse
> +specification for the index usually only matters under behavior A, since
> +under behavior B index operations are lumped with history and tend to
> +operate full-tree.
> +
> +
> +=3D=3D=3D Implementation Questions =3D=3D=3D
> +
> +  * Do the options --scope=3D{sparse,all} sound good to others?  Are the=
re better
> +    options?
> +    * Names in use, or appearing in patches, or previously suggested:
> +      * --sparse/--dense
> +      * --ignore-skip-worktree-bits
> +      * --ignore-skip-worktree-entries
> +      * --ignore-sparsity
> +      * --[no-]restrict-to-sparse-paths
> +      * --full-tree/--sparse-tree
> +      * --[no-]restrict
> +      * --scope=3D{sparse,all}
> +      * --focus/--unfocus
> +      * --limit/--unlimited
> +    * Rationale making me lean slightly towards --scope=3D{sparse,all}:
> +      * We want a name that works for many commands, so we need a name t=
hat
> +       does not conflict
> +      * We know that we have more than two possible usecases, so it is b=
est
> +       to avoid a flag that appears to be binary.
> +      * --scope=3D{sparse,all} isn't overly long and seems relatively
> +       explanatory
> +      * `--sparse`, as used in add/rm/mv, is totally backwards for
> +       grep/log/etc.  Changing the meaning of `--sparse` for these
> +       commands would fix the backwardness, but possibly break existing
> +       scripts.  Using a new name pairing would allow us to treat
> +       `--sparse` in these commands as a deprecated alias.
> +      * There is a different `--sparse`/`--dense` pair for commands usin=
g
> +       revision machinery, so using that naming might cause confusion
> +      * There is also a `--sparse` in both pack-objects and show-branch,=
 which
> +       don't conflict but do suggest that `--sparse` is overloaded
> +      * The name --ignore-skip-worktree-bits is a double negative, is
> +       quite a mouthful, refers to an implementation detail that many
> +       users may not be familiar with, and we'd need a negation for it
> +       which would probably be even more ridiculously long.  (But we
> +       can make --ignore-skip-worktree-bits a deprecated alias for
> +       --no-restrict.)
> +
> +  * If a config option is added (sparse.scope?) what should the values a=
nd
> +    description be?  "sparse" (behavior A), "worktree-sparse-history-den=
se"
> +    (behavior B), "dense" (behavior C)?  There's a risk of confusion,
> +    because even for Behaviors A and B we want some commands to be
> +    full-tree and others to operate sparsely, so the wording may need to=
 be
> +    more tied to the usecases and somehow explain that.  Also, right now=
,
> +    the primary difference we are focusing is just the history-querying
> +    commands (log/diff/grep).  Previous config suggestion here: [13]
> +

Maybe sparse.scope=3D{sparse, all}?

> +  * Is `--no-expand` a good alias for ls-files's `--sparse` option?
> +    (`--sparse` does not map to either `--scope=3Dsparse` or `--scope=3D=
all`,
> +    because in non-cone mode it does nothing and in cone-mode it shows t=
he
> +    sparse directory entries which are technically outside the sparse
> +    specification)
> +
> +  * Under Behavior A:
> +    * Does ls-files' `--no-expand` override the default `--scope=3Dall`,=
 or
> +      does it need an extra flag?
> +    * Does ls-files' `-t` option imply `--scope=3Dall`?
> +    * Does update-index's `--[no-]skip-worktree` option imply `--scope=
=3Dall`?
> +
> +  * sparse-checkout: once behavior A is fully implemented, should we tak=
e
> +    an interim measure to ease people into switching the default?  Namel=
y,
> +    if folks are not already in a sparse checkout, then require
> +    `sparse-checkout init/set` to take a
> +    `--set-scope=3D(sparse|worktree-sparse-history-dense|dense)` flag (w=
hich
> +    would set sparse.scope according to the setting given), and throw an
> +    error if the flag is not provided?  That error would be a great plac=
e
> +    to warn folks that the default may change in the future, and get the=
m
> +    used to specifying what they want so that the eventual default switc=
h
> +    is seamless for them.
> +
> +
> +=3D=3D=3D Implementation Goals/Plans =3D=3D=3D
> +
> + * Get buy-in on this document in general.
> +
> + * Figure out answers to the 'Implementation Questions' sections (above)
> +
> + * Fix bugs in the 'Known bugs' section (below)
> +
> + * Provide some kind of method for backfilling the blobs within the spar=
se
> +   specification in a partial clone
> +
> + [Below here is kind of spitballing since the first two haven't been res=
olved]
> +
> + * update-index: flip the default to --no-ignore-skip-worktree-entries,
> +   nuke this stupid "Oh, there's a bug?  Let me add a flag to let users
> +   request that they not trigger this bug." flag
> +
> + * Flags & Config
> +   * Make `--sparse` in add/rm/mv a deprecated alias for `--scope=3Dall`
> +   * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/resto=
re
> +     a deprecated aliases for `--scope=3Dall`
> +   * Create config option (sparse.scope?), tie it to the "Cliff notes"
> +     overview
> +
> +   * Add --scope=3Dsparse (and --scope=3Dall) flag to each of the histor=
y querying
> +     commands.  IMPORTANT: make sure diff machinery changes don't mess w=
ith
> +     format-patch, fast-export, etc.
> +

Thanks,
ZheNing Hu

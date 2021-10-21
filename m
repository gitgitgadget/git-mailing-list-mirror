Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52662C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C66B610CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJUL6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:58:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:51031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230391AbhJUL6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817388;
        bh=bia1QeDWKcK7gpWXxpTboLrDuMoZcF3JrKykfzEQ7pg=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=katEUU8UJ4hFKkjX/snTI1yzB1RvOC3j/1c/OZeSZKzOMKU98Lc6KbO3kJvVRJI7H
         xS/TGtsPFPegZtrQIxoCeEGuaCDM0UvemgOB4L8Vq1WhOZrTwN2VWqBgfVKFgrvX1+
         up113LO6PZCsmT8P5zvRh5ujUFweBzaXlnXr0Otk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1mbJlE0qHg-006gSk for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:56:28 +0200
Date:   Thu, 21 Oct 2021 13:56:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Sparse checkout behavior and plans
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211148230.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-539196121-1634816682=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211356200.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:/7inW9KIX36dZAk4HqFmEhv3HNNewLYm6fTM2GMuK0utlRi79QP
 PTubw82GNRHL8iz8UhA8HuAkMHerlrwJTFbwXJ4ZZKEONXXZLaeuxgQwI6gq7XkIr+OacSP
 9z0YLvi+HdQICSHNZh+WQYK4sRCi1fbetTP029YXS7F/KVxWZYWedtPlU/QU8FoNNAo7e9B
 TJ4Ry+39ouRfX2Xmj8XNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sKYDChVLrY8=:rWAqq2eR9vHv2rowgcGDIu
 U671tPnCc64PqMr9I+H7XcM1cz7M8JW7SKeBUBiCdSUTHN7/Nm/EKXcdaWBRThifpED+0IQ2l
 XHeSHqGUrXwsW0RrsfV2ouaAoDKleS1DduFKsE0olbR9B+L6YDRC63hXOd807UtLcOBl7M11R
 t0FliuWwbcrQJX02wUDQqtIRhOlUvY/42sKrE297daRi3rLDtw1AAHVFozsxcdWa3Cbk3F7tJ
 bb5+HCi/XsJE53OK365c0Hj0der99Oa7xwmNUaE05FlRP3OWSUwV/T8ZG0B7sMHaR4AFQBE2Z
 1ntPJBb84L2UPIt4tC88+TuJHB0mlBG3nqS5v6bD5Dy3JhEW6fesNUZ91S+laD/vzWG3ZLDfy
 oGP4UOMbhTaU2lwilMoK2d2jMh915BeiNHOm70+jZKAjIN4Y+LSeFOc99LbEROaqYfNAna7Qn
 nAi0C/Vzm7RelTMYrHwOA2I+a9B0U0Xptjyo08nBvuXWT3xy6IVgBqiAZSTR0EPKsh/add5ij
 NOJQgeU3Ymal9yQqXkaYwb5LrixS33UhHg8/8oMWslCi3uTTzJsPszVdRvvWawmaGCxaNaXSx
 kdtfq2r6PBwB0x0s845B0/Y09viI7cXf3fVil/Rv6h6/7LXnh04ydgK+A9pi/75ahZFgjjiSC
 /NuTqyAK6Ox8OZDVX0lGpPE68shk7FREJcOh94bKuIrgdTn6CYWyfPG6KWV57WDv9r33RKVi8
 VEyMCtPGkedOLijlZ8o6i4W0COeOen0MfgVtI98qT3LeELSMS8p2aiBpvjaFHdPh/30wFKR/M
 zYbIYtoQ56o5cj5Pr3Efnf72Df4Wiyrr+2jaQ1RxfA8iHqLUiFuu8q4B0UhjfalRmpKkcNn4K
 uY7oeoYaiZ4rZqlRheV5In//HxHnZHD4qLNae1WFAPsefK8Wfj5dIXJ4e0i4QCHeDfmPRNcZ8
 Br7b25dPe5Hl0k8sRsi/W8q1s9FujZyUeNy/6MycBYox3T++vjbGQ13RsSxc4SjV3XRSe4ozm
 sl1+V6ZqimVWmC8bKVj0ulbQwwMkUvUpVP/puD2nIcgYjqmIqCecUUo5xZtMMT+upJAjNiQEe
 d780WYsCkCjE/0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-539196121-1634816682=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211356201.56@tvgsbejvaqbjf.bet>

This session was led by Derrick Stolee. Supporting cast: Jonathan
"jrnieder" Nieder, Elijah Newren, Jeff Hostetler, Jeff "Peff" King,
Johannes "Dscho" Schindelin, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Emily=
 Shaffer,
Victoria Dye, brian m. carlson, and CB Bailey.

Notes:

 1.  Cone mode has stabilized

 2.  jrnieder: would sparse index without cone mode support be welcome?

     1. Stolee: you=E2=80=99re welcome to try ;-)

     2. Elijah: main theme: performance. Cone mode allows reasonable
        performance due to fewer rules to check

     3. Stolee: directory-level lookups mean lookups can have sublinear co=
st,
        since you can skip sparse rules (no need to check them in order to
        figure out whether or not a file is excluded or not)

 3.  Elijah: interested in =E2=80=9Csparse clones=E2=80=9D, i.e. clones th=
at download
     everything related to a specified cone

     1.  Would be nice not having to download extra objects when already h=
aving
         specified a cone of interest

     2.  Jeff: the original partial clone had code to restrict to a cone

     3.  Peff: we still have the code, but turned it off, you can have bit=
maps
         with that (too heavy on the server)

     4.  Stolee: also, how can the cone be updated if things change? Never
         solved that problem

     5.  Stolee: but the extra blob downloads turned out not to be too big=
 of a
         problem

     6.  Stolee: got a feature request to restrict git log to the current =
cone,
         git grep already does that (thanks Matheus)

     7.  Elijah: =E2=80=9Cgit grep=E2=80=9D without revision arguments is =
restricted to
         worktree, so it respects the sparse checkout. When you pass a
         revision, though, it searches the whole tree

     8.  Many commands want to examine the whole tree, makes sense to figu=
re
         out the UX (configuration, etc) of them together

     9.  Peff: Is diff code on someone=E2=80=99s radar?

     10. Stolee: I=E2=80=99d view that as part of the same story as =E2=80=
=9Cgit log=E2=80=9D, =E2=80=9Cgit log
         -p=E2=80=9D.

     11. Sparse index means we can avoid faulting in trees outside of HEAD=
, so
         it helps unlock this

 4.  Sparse index: Victoria and Lessley are taking lead on the number of
     commands supporting sparse index

     1. update-index, diff, blame, clean, stash, sparse-checkout itself so=
 far
        supported only in the Microsoft fork of Git

     2. Enabled by default internally so helps us gather data

     3. Elijah: awesome that you=E2=80=99re working on this, sorry I haven=
=E2=80=99t been as
        responsive as I=E2=80=99d like on reviews

     4. I=E2=80=99m interested in =E2=80=9Cclean=E2=80=9D in particular --=
- isn=E2=80=99t that about untracked
        files?

     5. Stolee: It uses the index to find what is tracked, want to avoid
        expanding the in-memory index. If there are files outside the spar=
se
        checkout area then it does expand.

 5.  jrnieder: question about failure modes

     1. When I convert a command, I make sure my code path doesn=E2=80=99t=
 assume the
        cache array contains all entries. Then I turn off
        command_requires_full_index. What happens if I missed a spot?

     2. Stolee: I put ensure_full_index() in front of everything that assu=
mes a
        full index, but if there=E2=80=99s a loop that we missed, there=E2=
=80=99s no extra
        protection.

     3. Example: cache-tree was calling itself, invalidating points,
        segfaulted.

     4. More worrying failure mode would be if commands proceed with bad d=
ata.
        Segfaulting is the good case!

     5. jrnieder is not too worried since we=E2=80=99re pretty far along a=
nd soon
        enough we=E2=80=99ll have converted all commands and these questio=
ns would be
        moot

        1. Stolee: goal isn=E2=80=99t to get 100% coverage, so point of qu=
estions being
           moot isn=E2=80=99t coming soon

        2. jrnieder: Thanks! Okay, I=E2=80=99ll take a look.

     6. http://sweng.the-davies.net/Home/rustys-api-design-manifesto

     7. Stolee is less worried because we have sufficient ensure_full_inde=
x
        calls.

 6.  One optimization we=E2=80=99re considering: not expanding the full in=
dex when
     anything outside the cone is needed (we=E2=80=99d like to maybe expan=
d just the
     part that needs expanding)

     1. Elijah: we would still keep cone mode, but it=E2=80=99s a bit weir=
d because the
        cone mode does not match what we have in the index

     2. Stolee: we might actually not need this

 7.  Stolee: in the process of this work, found D/F conflict issue, made a=
 test
     illustrating it

 8.  Elijah: atomicitiy

     1.  checkout is a non-atomic operation. ^C makes a mess

     2.  =E2=80=9Cgit sparse-checkout disable=E2=80=9D is non-atomic. Take=
s a while, people ^C,
         and the very last step is updating the sparsity files. Leaves the
         worktree with a bunch of files they don=E2=80=99t need but comman=
ds ignore
         them

     3.  We run into problems because then they can check out a different
         branch, do a bunch of other work, then update the sparse-checkout=
 and
         it will see these precious files it doesn=E2=80=99t want to overw=
rite

     4.  Should =E2=80=9Cgit status=E2=80=9D show them?

     5.  Dscho: We could set a flag on disk when you=E2=80=99re about to d=
isable, then
         if we were interrupted print an error message to get the user to =
sort
         things out

     6.  Peff: I was going to suggest something similar. FS doesn=E2=80=99=
t make
         transactions easy, but we can at least do a rollback (signal hand=
ler),
         not foolproof, but it works pretty well and covers your ^C case.

     7.  Stolee: coming in 2.34: sparse-checkout reapply will delete ignor=
ed
         (and tracked?) files. Helps with these leftover files.

     8.  Elijah: no current way to get out of that state, thank you for ma=
king
         sparse-checkout reapply do that

     9.  Stolee: noticed during experimental release to people from Office=
.
         Everything was slow because they had run build and left behind ig=
nored
         files

     10. jrnieder: Piggy-backing on Dscho=E2=80=99s comment, there=E2=80=
=99s a database
         analogy: record intent (in the database case, that=E2=80=99s a tr=
ansaction
         journal) before the non-atomic steps the act on that intent. Sugg=
ests
         maybe we should be updating the sparsity pattern before the check=
out
         step

 9.  That=E2=80=99s it, that=E2=80=99s the status update what=E2=80=99s cu=
rrently on the list.

 10. We have more plans, though.

 11. Idea: use git.git itself

     1. Tried it, but had to have 97% files to still be workable

     2. Could change the Makefile to accept that, say, po/ is missing

     3. =C3=86var: creates a lot of complexity for the build

     4. jrnieder: as VCS provider, what is our recommendation to build aut=
hors?
        Do we want them querying sparse checkout, do we want builds that J=
ust
        Work in cone mode, do we want to treat sparse checkout as a thing =
that
        builds don=E2=80=99t need to support?

     5. Stolee: want build system to be able to tell Git about what needs =
to be
        checked out. =E2=80=9CIn-tree sparse checkout=E2=80=9D (see below)

 12. Emily: we=E2=80=99re interested in sparse-checkout affecting the set =
of active
     submodules, just mentioning this as a heads-up

 13. [PATCH 00/10] [RFC] In-tree sparse-checkout definitions - Derrick Sto=
lee
     via GitGitGadget
     (https://lore.kernel.org/git/pull.627.git.1588857462.gitgitgadget@gma=
il.com/)

 14. Victoria: today when you switch gears and work on something else you =
have
     to update the sparse checkout pattern

 15. Proposal here is to have in-tree sparse checkout definitions, e.g. a
     .gitdependencies file that lists, for the directories you=E2=80=99re =
working with,
     what other subdirectories they depend on

 16. That way, you get exactly the folders you need

 17. Stolee: office has their own tool =E2=80=9Cscoper=E2=80=9D that figur=
es out dependencies
     and runs =E2=80=9Cgit sparse-checkout set=E2=80=9D for the user. Is c=
onfusing when you
     rebase and need to remember to run it

 18. Currently lives in a hook, custom and built for one engineering syste=
m,
     want to generalize and make a standard feature

 19. Victoria: being built in to Git would make sense because it=E2=80=99s=
 general
     enough to work in most monorepo environments.

 20. Involves two pieces: having git understand the dependencies and assem=
ble
     your sparse checkout cone using them, and having the build system mai=
ntain
     and use sparse checkout correctly.

 21. Some build setups tolerate missing directories reasonably well. If we=
 make
     .gitdependencies more of a first-class concept then we could go furth=
er
     and make build systems handle missing directories as something that w=
ould
     be expected

 22. C# .proj files link to dependencies on other .proj files with relativ=
e
     path. But in a solution file collecting all .proj files, it lists all=
 of
     them and you need to have them all present. If a subdirectory isn=E2=
=80=99t
     present, proposal is to build what is there instead of everything.

 23. Tried another prototype on how to do this in Bazel. It has a rigorous
     definition of inputs and outputs, and based on that you could transla=
te to
     a .gitdependencies file or sparse-checkout pattern.

 24. Microsoft=E2=80=99s buildxl has similar properties

 25. Victoria asks: how general is the above?

 26. brian: Many monorepos has multiple microservices. A cone can represen=
t
     what a particular service needs to run.

 27. If you=E2=80=99re building one coherent product like Windows, you=E2=
=80=99re going to need
     some prebuilt artifacts that you pull down.

 28. jrnieder: Large monorepos often have strong remote build. Not everyth=
ing
     you depend on is things that you need to have in source form locally

 29. CB: My team at Bloomberg has a teamwide =E2=80=9Cmonorepo=E2=80=9D (n=
ot Bloomberg-wide).
     We=E2=80=99re cmake based. Sparse checkout would be interesting for u=
s. We=E2=80=99re
     experimenting with what=E2=80=99s called workspace builds: you have a=
 thing you
     can build (a subdirectory), that you pull into the toplevel CMakeList=
s.txt
     as a single thing.

 30. With cmake you can declare a dependency with target_link_libraries. A
     dependency name can either be a cmake defined target in the codebase
     you=E2=80=99re building it, or it can be a pre-built library pulled i=
n another
     way, e.g. importing via a pkg-config file.

 31. At build time if I decide I want to change that library, I=E2=80=99ll=
 expand my
     sparse-checkout region, and rerun cmake to have it understand the new=
ly
     available source.

 32. Optionality: I don=E2=80=99t have to have that source checked out, bu=
t when it=E2=80=99s
     present I want to use it.

 33. Victoria: sounds like in-tree sparse checkout is more of an intermedi=
ate
     step. Sometimes you want the source, sometimes you want to pull in an
     external artifact.

 34. Elijah: we have a monorepo, about the size of the Linux kernel. Multi=
ple
     separate services, interconnected pieces. Using sparse-checkout requi=
red
     some code changes, refactoring that wasn=E2=80=99t just around the bu=
ild system.
     We created a tool before the sparse-checkout command existed, using o=
lder
     mechanisms, and then switched to sparse-checkout when it came out. We
     track our dependencies ourselves --- you need this set of modules (3 =
or 4)
     or the modules relevant to a particular team, and it then computes th=
e
     relevant directories to get. We had to make some changes to adopt con=
e
     mode but I like it and the changes it led to. Then you run the build
     system --- you have files that declare the dependencies, are they new=
er
     than .git/info/sparse-checkout? If not then recompute them again.

 35. Potentially would want to rerun the dependency generation after you r=
un a
     rebase as well=E2=80=A6

 36. If we track it in-tree, there are some interesting cases we=E2=80=99l=
l run into
     (merge conflicts on this generated file).

 37. Also, tracking dependencies in two places can result in difficulty, s=
kew.
     Maybe can generate one from the other.

 38. Our sparse checkout tends to be build oriented =E2=80=9Cwhat do I nee=
d for this
     build=E2=80=9D. But testing inverts the dependency graph, want to see=
 what tests
     depend on this code. We encourage them to test in the cloud but not
     everyone does that, leads fewer people to use sparse checkout.

 39. There=E2=80=99s some remote build, mixing-and-matching pieces built r=
emotely and
     locally.

 40. Part of working in a monorepo is you need strong tool hygiene enforce=
ment.
     Without that, you get a ball of mud of dependencies. Adopting sparse
     checkout drove modularity.

 41. =C3=86var: I=E2=80=99d be interested in a summary

 42. Git=E2=80=99s lack of support for sparse checkout was unusual, so I t=
hink this
     topic is well explored by previous version control systems

--8323328-539196121-1634816682=:56--

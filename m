Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E07C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 00:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiGLAGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLAGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 20:06:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AADBC96
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso4474384wms.5
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jqoNb/VcZQ9OQp33mrfMk0QcRTsBmrmxpCZvuTN7yDQ=;
        b=f1vJ5IpFlD1gzbGvIcsFz03OQoyh1z7IbAt0s3wEd61RCrUsnceki9elykjrSkuQEa
         2mdt1+vD1uXp6qj7I+zgm56xmWRM+KDZAU4viFnqjJmjc91OHxlYzq1J3NC0hbeg3s21
         omx85cJzab/n9wP4CVRgzu0ak2zD+XuCM3L9gU1zP1idtwhitXvn/i7URqlatVrG3lRX
         OqSmnQkKNmXQtRQ4x06NKcA6jYOU5TVYJf1sxD9aJT5GHWzKLv6MpE2CMLdMy9hXfcJd
         QSPdT6nglKhoEcs9gEyvoETRnE9M/sPgMEJYhjoUzw6nKHAqSozdzXkj6asfTc7XGSRZ
         dr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jqoNb/VcZQ9OQp33mrfMk0QcRTsBmrmxpCZvuTN7yDQ=;
        b=kkNPXjmWuyjWf3LbcLrvFBrjRB2rMON7EVvQasPEE08+yUYDVn61KK8PFeY8QZNkgw
         8hH/lbNUlwsN/yFgs8EWAOLueypYRdN0+nzkTtk3ON1j3sjXbbAfdeYAZ8iUcy2jjene
         Z0XAJwBGPY1V1mHNSN0/ytZwRWuGJcDM2gzuu6JJHXS3ShIi1ru8ffr4MVD4Lm7PfQ4p
         W5JExs2TFdzNjnX/n2euugTLZZGTITNijHF2K2hx0FwMjDMHawMr9xNtJ1ZDb+fW68mE
         mXzCpgxVwkj4M48V9hDOh2Vj7Ak8WNuWQT1E9QPDcGDL8vtpRyCGewpxS64yN76S+X9L
         88gw==
X-Gm-Message-State: AJIora+zJd8srr3OuqpwlxyM+WR+PaEGW6z8/2r4btmG80t9ZvUkZH49
        pLJ+9VAg92JaUeAafihFH5VTLZ55C8M=
X-Google-Smtp-Source: AGRyM1vy+LLSAyRoUsqOU9gokCxLk0JgCQWi1BR2MXa00UqtM8AyfgT5Rpm6U8Wv5i3oPar4CykHHA==
X-Received: by 2002:a05:600c:4f4d:b0:3a1:98de:abde with SMTP id m13-20020a05600c4f4d00b003a198deabdemr882497wmq.36.1657584369305;
        Mon, 11 Jul 2022 17:06:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe786000000b0021b9504cc83sm6917806wrm.31.2022.07.11.17.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:06:08 -0700 (PDT)
Message-Id: <pull.1275.v2.git.1657584367.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 00:06:05 +0000
Subject: [PATCH v2 0/2] scalar: prepare documentation for future work
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Changes since V1
================

 * Moved 'contrib/scalar/technical/scalar.txt' to
   'Documentation/technical/scalar.txt'.
 * Rephrased/removed references to Scalar being "built-in" to avoid
   confusion with the 'git ' built-ins.
 * Fixed line wrapping of bullet points in "Roadmap".
 * Removed the "[RFC]" tag.


What's this series?
===================

The questions of "what is Scalar?" and "why is Scalar part of Git?" have
been discussed at length already [1], but in preparation for the next few
series I plan to submit "finishing" the initial Scalar implementation
effort, I'd like to start by reframing its purpose.

Beginning with the "Philosophy of Scalar" [2], much of the existing
documentation refers to Scalar as "opinionated" - not unlike git itself.
However, with scalar now part of Git, continuing to describe it as
"opinionated" could unintentionally portray it as a divergence from "the
rest of Git" and its development community.

Rather than think of Scalar as an opinionated take on Git, I prefer to think
of it as a manifestation of Git's own "opinions" for a specific use case,
like many of the built-in commands. Over the years, developers have
contributed tons of features - often gated behind config settings - that
address performance issues they've encountered working in large
repositories: untracked cache, sparse index, merge-ort, etc. Some of these
features (like merge-ort) provide near-universal benefit to users and become
part of Git's default configuration. More often, though, these features are
large and difficult to prove are stable, or require some advanced manual
configuration to use properly, or simply make the "average" Git user's
experience worse (e.g., improving performance in in large repos, but
degrading it in smaller repos).

We've accumulated so many of these features that it's become difficult for
users to even find all of them, let alone use them. Git "knows" these
features exist, but also "knows" not to enable them by default because
they're either too experimental or not helpful to most users. Scalar is a
way for Git to take all of these features, bundle them together, and tell a
user, "Hey, do you need to make your large repo faster? Use this!" without
touching the default user experience.

All that to say, Scalar is essentially a collection of porcelain commands
[3] that fill a substantial UX niche in Git. Now, let's get into Scalar's
"future state".


A plan for Scalar
=================

Given the slightly tweaked "philosophy" above, my ultimate goal for Scalar
is to have it contain only what is too experimental or too large
repo-focused to be a default option or behavior in Git. Over time, some
features may be moved out of Scalar and into Git defaults as they are proven
stable and beneficial to the vast majority of users [4].

So what do we need to get there?

At a high level, the remaining work to "finalize" Scalar (past this RFC) can
be broken into three parts:

 1. Complete a few more features and subcommands of Scalar (integrate with
    the built-in FSMonitor & implement scalar help).
 2. Move stable, general-purpose parts of 'scalar.c' into other Git
    builtins/libraries (mainly scalar diagnose, either as part of git
    bug-report [5] or a new git built-in).
 3. Move Scalar out of contrib/ and into the "top-level" of Git. Includes
    expanded testing, especially performance testing.

The first makes scalar "feature complete" enough to be valuable to large
repo users (per my entirely subjective assessment, at least). The second
brings it in line with the goal of making Scalar only contain what can't
exist as a default feature of Git. Once those are finished, I think Scalar
will be out of its "work-in-progress" phase and ready to use as a built-in
component of Git (accompanied by sufficient testing, of course).


What's Scalar's future?
=======================

With the completion of the tasks listed in the previous section, there's
nothing left from the original Scalar CLI (in the Microsoft fork of Git) to
upstream. I don't consider that the "end" of supporting Scalar because, for
it to remain an effective tool, it'll need to stay up-to-date with the
latest performance features introduced to Git.

For example, one possible future extension might be to have Scalar enable
the sparse index by default, especially when more built-ins are updated with
sparse index compatibility. I'm interested in hearing what other features
might fit well there!


What I'm looking for
====================

The two patches in this series revise existing documentation to match the
description above. Please let me know if 1) those revisions match your
understanding of the above, 2) they convey the intent clearly, and (most
importantly) 3) they reflect a reasonable direction to take Scalar. And, of
course, if there's something I missed, I welcome any and all feedback &
ideas!

Thanks,

 * Victoria

[1]
https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/

[2]
https://github.com/microsoft/git/blob/173a9b783a414/contrib/scalar/docs/philosophy.md

[3] If you're wondering "why not call it git-scalar then?", my short answer
is 1) backward compatibility with the original "scalar" CLI, and 2) its
scope is larger and more persistent than a single command; Scalar works
across multiple repos, and each Scalar subcommand has scope and
functionality on par with a built-in command. I'm happy to talk through this
more if people are still unsure, though!

[4] That being said, Scalar's existence should not make Git more risk averse
in accepting new general-purpose features.

[5] https://lore.kernel.org/git/220517.86y1z05gja.gmgdl@evledraar.gmail.com/

Victoria Dye (2):
  scalar: reword command documentation to clarify purpose
  scalar: convert README.md into a technical design doc

 Documentation/technical/scalar.txt | 127 +++++++++++++++++++++++++++++
 contrib/scalar/README.md           |  82 -------------------
 contrib/scalar/scalar.txt          |   9 +-
 3 files changed, 131 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/technical/scalar.txt
 delete mode 100644 contrib/scalar/README.md


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1275%2Fvdye%2Fscalar%2Fdoc-update-rfc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1275/vdye/scalar/doc-update-rfc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1275

Range-diff vs v1:

 1:  38c0b4dff90 = 1:  38c0b4dff90 scalar: reword command documentation to clarify purpose
 2:  870bd90e47e ! 2:  65eda9755d2 scalar: convert README.md into a technical design doc
     @@ Metadata
       ## Commit message ##
          scalar: convert README.md into a technical design doc
      
     -    Replace 'README.md' with 'technical/scalar.txt' (still in 'contrib/'). In
     -    addition to reformatting for asciidoc, elaborate on the background, purpose,
     -    and design choices that went into Scalar.
     +    Adapt the content from 'contrib/scalar/README.md' into a design document in
     +    'Documentation/technical/'. In addition to reformatting for asciidoc,
     +    elaborate on the background, purpose, and design choices that went into
     +    Scalar.
      
     -    This document is intended to persist in the 'Documentation/technical/'
     -    directory after Scalar has been moved into the root of Git (out of
     -    'contrib/'). Before then, it will also contain a "Roadmap" section detailing
     -    the remaining series needed to finish the initial version of Scalar. The
     -    section will be removed once Scalar is moved to the repo root, but in the
     -    meantime serves as a guide for readers to keep up with progress on the
     -    feature.
     +    Most of this document will persist in the 'Documentation/technical/' after
     +    Scalar has been moved out of 'contrib/' and into the root of Git. Until that
     +    time, it will also contain a temporary "Roadmap" section detailing the
     +    remaining series needed to finish the initial version of Scalar. The section
     +    will be removed once Scalar is moved to the repo root, but in the meantime
     +    serves as a guide for readers to keep up with progress on the feature.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     - ## contrib/scalar/README.md (deleted) ##
     -@@
     --# Scalar - an opinionated repository management tool
     --
     --Scalar is an add-on to Git that helps users take advantage of advanced
     --performance features in Git. Originally implemented in C# using .NET Core,
     --based on the learnings from the VFS for Git project, most of the techniques
     --developed by the Scalar project have been integrated into core Git already:
     --
     --* partial clone,
     --* commit graphs,
     --* multi-pack index,
     --* sparse checkout (cone mode),
     --* scheduled background maintenance,
     --* etc
     --
     --This directory contains the remaining parts of Scalar that are not (yet) in
     --core Git.
     --
     --## Roadmap
     --
     --The idea is to populate this directory via incremental patch series and
     --eventually move to a top-level directory next to `gitk-git/` and to `git-gui/`. The
     --current plan involves the following patch series:
     --
     --- `scalar-the-beginning`: The initial patch series which sets up
     --  `contrib/scalar/` and populates it with a minimal `scalar` command that
     --  demonstrates the fundamental ideas.
     --
     --- `scalar-c-and-C`: The `scalar` command learns about two options that can be
     --  specified before the command, `-c <key>=<value>` and `-C <directory>`.
     --
     --- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
     --
     --- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled in `scalar
     --  register` and in `scalar clone`, for an enormous performance boost when
     --  working in large worktrees. This patch series necessarily depends on Jeff
     --  Hostetler's FSMonitor patch series to be integrated into Git.
     --
     --- `scalar-gentler-config-locking`: Scalar enlistments are registered in the
     --  user's Git config. This usually does not represent any problem because it is
     --  rare for a user to register an enlistment. However, in Scalar's functional
     --  tests, Scalar enlistments are created galore, and in parallel, which can lead
     --  to lock contention. This patch series works around that problem by re-trying
     --  to lock the config file in a gentle fashion.
     --
     --- `scalar-extra-docs`: Add some extensive documentation that has been written
     --  in the original Scalar project (all subject to discussion, of course).
     --
     --- `optionally-install-scalar`: Now that Scalar is feature (and documentation)
     --  complete and is verified in CI builds, let's offer to install it.
     --
     --- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move it next to
     --  `gitk-git/` and to `git-gui/`, making it a top-level command.
     --
     --The following two patch series exist in Microsoft's fork of Git and are
     --publicly available. There is no current plan to upstream them, not because I
     --want to withhold these patches, but because I don't think the Git community is
     --interested in these patches.
     --
     --There are some interesting ideas there, but the implementation is too specific
     --to Azure Repos and/or VFS for Git to be of much help in general (and also: my
     --colleagues tried to upstream some patches already and the enthusiasm for
     --integrating things related to Azure Repos and VFS for Git can be summarized in
     --very, very few words).
     --
     --These still exist mainly because the GVFS protocol is what Azure Repos has
     --instead of partial clone, while Git is focused on improving partial clone:
     --
     --- `scalar-with-gvfs`: The primary purpose of this patch series is to support
     --  existing Scalar users whose repositories are hosted in Azure Repos (which
     --  does not support Git's partial clones, but supports its predecessor, the GVFS
     --  protocol, which is used by Scalar to emulate the partial clone).
     --
     --  Since the GVFS protocol will never be supported by core Git, this patch
     --  series will remain in Microsoft's fork of Git.
     --
     --- `run-scalar-functional-tests`: The Scalar project developed a quite
     --  comprehensive set of integration tests (or, "Functional Tests"). They are the
     --  sole remaining part of the original C#-based Scalar project, and this patch
     --  adds a GitHub workflow that runs them all.
     --
     --  Since the tests partially depend on features that are only provided in the
     --  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
     -
     - ## contrib/scalar/technical/scalar.txt (new) ##
     + ## Documentation/technical/scalar.txt (new) ##
      @@
      +Scalar
      +======
      +
     -+Scalar is a built-in repository management tool that optimizes Git for use in
     -+large repositories. It accomplishes this by helping users to take advantage of
     ++Scalar is a repository management tool that optimizes Git for use in large
     ++repositories. It accomplishes this by helping users to take advantage of
      +advanced performance features in Git. Unlike most other Git built-in commands,
      +Scalar is not executed as a subcommand of 'git'; rather, it is built as a
      +separate executable containing its own series of subcommands.
     @@ contrib/scalar/technical/scalar.txt (new)
      +Roughly speaking (and subject to change), the following series are needed to
      +"finish" this initial version of Scalar:
      +
     -+- Finish Scalar features: Enable the built-in FSMonitor in Scalar
     -+  enlistments and implement `scalar help`. At the end of this series, Scalar
     -+  should be feature-complete from the perspective of a user.
     ++- Finish Scalar features: Enable the built-in FSMonitor in Scalar enlistments
     ++  and implement `scalar help`. At the end of this series, Scalar should be
     ++  feature-complete from the perspective of a user.
      +
     -+- Generalize features not specific to Scalar: In the spirit of
     -+  making Scalar configure only what is needed for large repo performance, move
     -+  common utilities into other parts of Git. Some of this will be internal-only,
     -+  but one major change will be generalizing `scalar diagnose` for use with any
     -+  Git repository.
     ++- Generalize features not specific to Scalar: In the spirit of making Scalar
     ++  configure only what is needed for large repo performance, move common
     ++  utilities into other parts of Git. Some of this will be internal-only, but one
     ++  major change will be generalizing `scalar diagnose` for use with any Git
     ++  repository.
      +
     -+- Move Scalar to toplevel: Make `scalar` a built-in component of Git by
     -+  moving it out of `contrib/` and into the root of `git`. The actual change will
     -+  be relatively small, but this series will also contain expanded testing to
     -+  ensure Scalar is stable and performant.
     ++- Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
     ++  `git`, including updates to build and install it with the rest of Git. This
     ++  change will incorporate Scalar into the Git CI and test framework, as well as
     ++  expand regression and performance testing to ensure the tool is stable.
      +
      +Finally, there are two additional patch series that exist in Microsoft's fork of
      +Git, but there is no current plan to upstream them. There are some interesting
     @@ contrib/scalar/technical/scalar.txt (new)
      +
      +  Since the tests partially depend on features that are only provided in the
      +  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
     +
     + ## contrib/scalar/README.md (deleted) ##
     +@@
     +-# Scalar - an opinionated repository management tool
     +-
     +-Scalar is an add-on to Git that helps users take advantage of advanced
     +-performance features in Git. Originally implemented in C# using .NET Core,
     +-based on the learnings from the VFS for Git project, most of the techniques
     +-developed by the Scalar project have been integrated into core Git already:
     +-
     +-* partial clone,
     +-* commit graphs,
     +-* multi-pack index,
     +-* sparse checkout (cone mode),
     +-* scheduled background maintenance,
     +-* etc
     +-
     +-This directory contains the remaining parts of Scalar that are not (yet) in
     +-core Git.
     +-
     +-## Roadmap
     +-
     +-The idea is to populate this directory via incremental patch series and
     +-eventually move to a top-level directory next to `gitk-git/` and to `git-gui/`. The
     +-current plan involves the following patch series:
     +-
     +-- `scalar-the-beginning`: The initial patch series which sets up
     +-  `contrib/scalar/` and populates it with a minimal `scalar` command that
     +-  demonstrates the fundamental ideas.
     +-
     +-- `scalar-c-and-C`: The `scalar` command learns about two options that can be
     +-  specified before the command, `-c <key>=<value>` and `-C <directory>`.
     +-
     +-- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
     +-
     +-- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled in `scalar
     +-  register` and in `scalar clone`, for an enormous performance boost when
     +-  working in large worktrees. This patch series necessarily depends on Jeff
     +-  Hostetler's FSMonitor patch series to be integrated into Git.
     +-
     +-- `scalar-gentler-config-locking`: Scalar enlistments are registered in the
     +-  user's Git config. This usually does not represent any problem because it is
     +-  rare for a user to register an enlistment. However, in Scalar's functional
     +-  tests, Scalar enlistments are created galore, and in parallel, which can lead
     +-  to lock contention. This patch series works around that problem by re-trying
     +-  to lock the config file in a gentle fashion.
     +-
     +-- `scalar-extra-docs`: Add some extensive documentation that has been written
     +-  in the original Scalar project (all subject to discussion, of course).
     +-
     +-- `optionally-install-scalar`: Now that Scalar is feature (and documentation)
     +-  complete and is verified in CI builds, let's offer to install it.
     +-
     +-- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move it next to
     +-  `gitk-git/` and to `git-gui/`, making it a top-level command.
     +-
     +-The following two patch series exist in Microsoft's fork of Git and are
     +-publicly available. There is no current plan to upstream them, not because I
     +-want to withhold these patches, but because I don't think the Git community is
     +-interested in these patches.
     +-
     +-There are some interesting ideas there, but the implementation is too specific
     +-to Azure Repos and/or VFS for Git to be of much help in general (and also: my
     +-colleagues tried to upstream some patches already and the enthusiasm for
     +-integrating things related to Azure Repos and VFS for Git can be summarized in
     +-very, very few words).
     +-
     +-These still exist mainly because the GVFS protocol is what Azure Repos has
     +-instead of partial clone, while Git is focused on improving partial clone:
     +-
     +-- `scalar-with-gvfs`: The primary purpose of this patch series is to support
     +-  existing Scalar users whose repositories are hosted in Azure Repos (which
     +-  does not support Git's partial clones, but supports its predecessor, the GVFS
     +-  protocol, which is used by Scalar to emulate the partial clone).
     +-
     +-  Since the GVFS protocol will never be supported by core Git, this patch
     +-  series will remain in Microsoft's fork of Git.
     +-
     +-- `run-scalar-functional-tests`: The Scalar project developed a quite
     +-  comprehensive set of integration tests (or, "Functional Tests"). They are the
     +-  sole remaining part of the original C#-based Scalar project, and this patch
     +-  adds a GitHub workflow that runs them all.
     +-
     +-  Since the tests partially depend on features that are only provided in the
     +-  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.

-- 
gitgitgadget

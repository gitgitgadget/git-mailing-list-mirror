Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9CBC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhKSXGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhKSXGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E580BC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 137so6305307wma.1
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ugQX3pSsGag/ZGzx+WgRBzTt7WWdLWKmA0IyZwhMwFE=;
        b=ikBxQ8vvxR2SqgPTjDNcFenYJD1oJeahv6Jwb5BA8vRutiuRnQhlbI+2SZP2FiJXEs
         8WqI7hjtsp5dTm4PYbowWp0uO1XVrrGrvN5KFlGd2uSTDzoIJiPvN8Jt9zEE7exuAB88
         cL3NUZ/7bkRe/CFYoRs13gwVcVX5zpVJCls88fvn8Pc1sRqwUAci1Z4RkbMXie6ygs2A
         a/kzYHaqN3Rq/9UlABL3KTg/0Zt8TtJeUK0MQo6NrGqZNO1f0cyUIbozkCMRhCk03HxR
         3um5ROY2bAXBBRQrV7dDXLpP5bNUt1Jfrh8jMLf9R8LbwKZ71VYtGSTYddUd1Tuj2rl1
         w0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ugQX3pSsGag/ZGzx+WgRBzTt7WWdLWKmA0IyZwhMwFE=;
        b=6gh+EMi6fHbtkUNjplRlQFUBUkGDDHaj/mrqlO2NTw5MaxomXjMPq3chu0kiq/8jKl
         IgsvAvjvdmfGaG/QExkKJSsOuFdQDwVgmQUchuZ8yVSdksVhGTlNKwVOx4JePVoYDZqO
         Rcv5XTvFgRem0oWzk5ik4x52mDusiT/DaOoCvu043Wwuv7OQNAhIuFZob0cFowrvlXN7
         CcxDUV03U/j5o0oJHtf0jL1lbfqc8XfCo/0tn3RGR8CwL3kQUDgeMX0RtLLtROtj3Egm
         zb+n9458sNNlmogGp7ZJGj8DVhIjZkrVfNgXPB2WLxWMzceYYoziCWyIl2LeY6UvjpkZ
         /z7Q==
X-Gm-Message-State: AOAM530BPORrV/Ne0BNOlGIgfI6kOrCJX86fMdg/JupE9YdfMbY06yQm
        6E8STU2QcS831wYa2oJfMerFVG5UEDo=
X-Google-Smtp-Source: ABdhPJwRjQOLogUTgJz9ERRB82QKeEtVP5I6fsOLZmzKPfJtTqz6uGuFCgclbJOOm7+ygCVs1ZNpNA==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr4442948wma.9.1637363025936;
        Fri, 19 Nov 2021 15:03:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm1264977wrz.90.2021.11.19.15.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:45 -0800 (PST)
Message-Id: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:27 +0000
Subject: [PATCH v8 00/17] Upstreaming the Scalar command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr: This series contributes the core part of the Scalar command to the
Git project. This command provides an opinionated way to create and
configure Git repositories with a focus on very large repositories.

Changes since v7:

 * Clarified in the commit message why we cannot easily encapsulate the
   Scalar part of the CMake configuration in contrib/scalar/.
 * Improved the README.md.

Changes since v6:

 * Rebased on top of v2.34.0.
 * Inserted a commit that adds contrib/scalar/README.md, containing the
   roadmap of what I have planned for Scalar.
 * The Scalar test's definition of GIT_TEST_MAINT_SCHEDULER has been
   adjusted to accommodate for a change in v2.32.0..v2.34.0.
 * The config setting defaults now include fetch.showForcedUpdates=false,
   which has been identified as helping with a performance issue in large
   repositories.
 * To avoid mistaking the current patch series for being feature-complete
   enough to unleash onto end users, I moved the Makefile rules to build
   HTML/manual pages to a later patch series.
 * The patch that adds support for -c <key>=<value> and -C <directory> was
   moved to its own add-on patch series: While it is obvious that those
   options are valuable to have, an open question is whether there are other
   "pre-command" options in git that would be useful, too, and I would like
   to postpone that discussion to that date.
 * I added two patches that I had planned on keeping in an add-on patch
   series for later, to build and test Scalar as part of the CI. I am still
   not 100% certain that it is a good idea to do so already now, but let's
   see what the reviewers have to say.

Changes since v5:

 * Fixed the commit message talking about make -C contrib/scalar/Makefile.
 * Fixed the git ls-tree invocation suggested in the manual for scalar
   clone.
 * Invoking make -C contrib/scalar, then changing a source file of libgit.a
   and then immediately invoking make -C contrib/scalar again will now
   implicitly rebuild libgit.a.

Changes since v4:

 * scalar delete now refuses to delete anything if it was started from
   within the enlistment.
 * scalar delete releases any handles to the object store before deleting
   the enlistment.
 * The OBJECTS list in the Makefile will now include Scalar.
 * scalar register now supports secondary worktrees, in addition to the
   primary worktree.

Changes since v3:

 * Moved the "Changes since" section to the top, to make it easier to see
   what changed.
 * Reworded the commit message of the first patch.
 * Removed the [RFC] prefix because I did not hear any objections against
   putting this into contrib/.

Changes since v2:

 * Adjusted the description of the list command in the manual page , as
   suggested by Bagas.
 * Addressed two style nits in cmd_run().
 * The documentation of git reconfigure -a was improved.

Changes since v1:

 * A couple typos were fixed
 * The code parsing the output of ls-remote was made more readable
 * The indentation used in scalar.txt now consistently uses tabs
 * We no longer hard-code core.bare = false when registering with Scalar


Background
==========

Microsoft invested a lot of effort into scaling Git to the needs of the
Windows operating system source code. Based on the experience of the first
approach, VFS for Git, the Scalar project was started. Scalar specifically
has as its core goal to funnel all improvements into core Git.


The present
===========

The Scalar project provides a completely functional non-virtual experience
for monorepos. But why stop there. The Scalar project was designed to be a
self-destructing vehicle to allow those key concepts to be moved into core
Git itself for the benefit of all. For example, partial clone,
sparse-checkout, and scheduled background maintenance have already been
upstreamed and removed from Scalar proper. This patch series provides a
C-based implementation of the final remaining portions of the Scalar
command. This will make it easier for users to experiment with the Scalar
command. It will also make it substantially easier to experiment with moving
functionality from Scalar into core Git, while maintaining
backwards-compatibility for existing Scalar users.

The C-based Scalar has been shipped to Scalar users, and can be tested by
any interested reader: https://github.com/microsoft/git/releases/ (it offers
a Git for Windows installer, a macOS package and an Ubuntu package, Scalar
has been included since v2.33.0.vfs.0.0).


Next steps
==========

Since there are existing Scalar users, I want to ensure
backwards-compatibility with its existing command-line interface. Keeping
that in mind, everything in this series is up for discussion.

I obviously believe that Scalar brings a huge benefit, and think that it
would be ideal for all of Scalar's learnings to end up in git clone/git
init/git maintenance eventually. It is also conceivable, however, that the
scalar command could graduate to be a core part of Git at some stage in the
future (such a decision would probably depend highly on users' feedback).
See also the discussion about the architecture of Scalar
[https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/],
kicked off by Stolee.

On top of this patch series, I have lined up a few more:

 1. Implement a scalar diagnose command.
 2. Use the built-in FSMonitor (that patch series obviously needs to wait
    for FSMonitor to be integrated).
 3. Modify the config machinery to be more generous about concurrent writes,
    say, to the user-wide config.
 4. A few patches to optionally build and install scalar as part of a
    regular Git install (also teaching git help scalar to find the Scalar
    documentation

These are included in my vfs-with-scalar branch thicket
[https://github.com/dscho/git/commits/vfs-with-scalar]. On top of that, this
branch thicket also includes patches I do not plan on upstreaming, mainly
because they are too specific either to VFS for Git, or they support Azure
Repos (which does not offer partial clones but speaks the GVFS protocol,
which can be used to emulate partial clones).

One other thing is very interesting about that vfs-with-scalar branch
thicket: it contains a GitHub workflow which will run Scalar's quite
extensive Functional Tests suite. This test suite is quite comprehensive and
caught us a lot of bugs in the past, not only in the Scalar code, but also
core Git.


Epilogue
========

Now, to address some questions that I imagine every reader has who made it
this far:

 * Why not put the Scalar functionality directly into core Git, even a
   built-in? I wanted to provide an easy way for Git contributors to "play
   with" Scalar, without forcing a new top-level command into Git.
 * Why implement the Scalar command in the Git code base? Apart from
   simplifying Scalar maintenance in the Microsoft port of Git, the tight
   version coupling between Git and Scalar reduces the maintenance burden
   even further. Besides, I believe that it will make it much easier to
   shift functionality from Scalar into core Git, once we took the hurdle of
   accepting the Scalar code into the code base.
 * Why contribute Scalar to the Git project? We are biased, of course, yet
   our data-driven approach provides evidence that Scalar helps handling
   huge repositories with ease. By contributing it to the core Git project,
   we are able to share it with more users, especially some users who do not
   want to install Microsoft's fork of Git. We also hope that a lot of
   Scalar (maybe all of it) will end up in core Git, to benefit even more
   users.

Derrick Stolee (4):
  scalar: 'register' sets recommended config and starts maintenance
  scalar: 'unregister' stops background maintenance
  scalar: implement 'scalar list'
  scalar: implement the `run` command

Johannes Schindelin (12):
  scalar: add a README with a roadmap
  scalar: create a rudimentary executable
  scalar: start documenting the command
  scalar: create test infrastructure
  cmake: optionally build `scalar`, too
  ci: also run the `scalar` tests
  scalar: let 'unregister' handle a deleted enlistment directory
    gracefully
  scalar: implement the `clone` subcommand
  scalar: teach 'clone' to support the --single-branch option
  scalar: allow reconfiguring an existing enlistment
  scalar: teach 'reconfigure' to optionally handle all registered
    enlistments
  scalar: implement the `version` command

Matthew John Cheetham (1):
  scalar: implement the `delete` command

 .github/workflows/main.yml          |  15 +
 Makefile                            |   9 +
 ci/run-build-and-tests.sh           |   1 +
 ci/run-test-slice.sh                |   5 +
 contrib/buildsystems/CMakeLists.txt |  14 +
 contrib/scalar/.gitignore           |   2 +
 contrib/scalar/Makefile             |  45 ++
 contrib/scalar/README.md            |  82 +++
 contrib/scalar/scalar.c             | 826 ++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt           | 145 +++++
 contrib/scalar/t/Makefile           |  78 +++
 contrib/scalar/t/t9099-scalar.sh    |  88 +++
 12 files changed, 1310 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/README.md
 create mode 100644 contrib/scalar/scalar.c
 create mode 100644 contrib/scalar/scalar.txt
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1005%2Fdscho%2Fscalar-the-beginning-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1005/dscho/scalar-the-beginning-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1005

Range-diff vs v7:

  1:  3aa095dc824 !  1:  3a2e28275f1 scalar: add a README with a roadmap
     @@ contrib/scalar/README.md (new)
      @@
      +# Scalar - an opinionated repository management tool
      +
     -+Scalar is an add-on to Git, helping Git scale to very large repositories and
     -+worktrees. Originally implemented in C# using .NET Core, based on the learnings
     -+from the VFS for Git project, most of the techniques developed by the Scalar
     -+project have been integrated into core Git already:
     ++Scalar is an add-on to Git that helps users take advantage of advanced
     ++performance features in Git. Originally implemented in C# using .NET Core,
     ++based on the learnings from the VFS for Git project, most of the techniques
     ++developed by the Scalar project have been integrated into core Git already:
      +
      +* partial clone,
      +* commit graphs,
     @@ contrib/scalar/README.md (new)
      +- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
      +
      +- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled in `scalar
     -+  init` and in `scalar clone`, for an enormous performance boost when working
     -+  in large worktrees. This patch series necessarily depends on Jeff Hostetler's
     -+  FSMonitor patch series to be integrated into Git.
     ++  register` and in `scalar clone`, for an enormous performance boost when
     ++  working in large worktrees. This patch series necessarily depends on Jeff
     ++  Hostetler's FSMonitor patch series to be integrated into Git.
      +
      +- `scalar-gentler-config-locking`: Scalar enlistments are registered in the
      +  user's Git config. This usually does not represent any problem because it is
     @@ contrib/scalar/README.md (new)
      +- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move it next to
      +  `gitk-git/` and to `git-gui/`, making it a top-level command.
      +
     -+The following two patch series exist, but there is no plan to integrate them
     -+into Git's source tree:
     ++The following two patch series exist in Microsoft's fork of Git and are
     ++publicly available. There is no current plan to upstream them, not because I
     ++want to withhold these patches, but because I don't think the Git community is
     ++interested in these patches.
     ++
     ++There are some interesting ideas there, but the implementation is too specific
     ++to Azure Repos and/or VFS for Git to be of much help in general (and also: my
     ++colleagues tried to upstream some patches already and the enthusiasm for
     ++integrating things related to Azure Repos and VFS for Git can be summarized in
     ++very, very few words).
     ++
     ++These still exist mainly because the GVFS protocol is what Azure Repos has
     ++instead of partial clone, while Git is focused on improving partial clone:
      +
      +- `scalar-with-gvfs`: The primary purpose of this patch series is to support
      +  existing Scalar users whose repositories are hosted in Azure Repos (which
  2:  e0693cc713c =  2:  50160d61a41 scalar: create a rudimentary executable
  3:  d80627615f8 =  3:  74cd6410931 scalar: start documenting the command
  4:  9da1616849e =  4:  37231a4dd07 scalar: create test infrastructure
  5:  dbaad4753c1 !  5:  a39b9c81214 cmake: optionally build `scalar`, too
     @@ Metadata
       ## Commit message ##
          cmake: optionally build `scalar`, too
      
     -    The CMake configuration unfortunately does not let us encapsulate all
     -    (or at least the vast majority) of Scalar's build definition in the
     -    `contrib/scalar/` subdirectory.
     +    The CMake configuration unfortunately does not let us easily encapsulate
     +    Scalar's build definition in the `contrib/scalar/` subdirectory: The
     +    `scalar` executable needs to link in `libgit.a` and `common-main.o`, for
     +    example.
     +
     +    Also, `scalar.c` includes Git's header files, which means that
     +    `scalar.c` needs to be compiled with the very same flags as `libgit.a`
     +    lest `scalar.o` and `libgit.a` have different ideas of, say,
     +    `platform_SHA_CTX`, which would naturally lead to memory corruption.
      
          To alleviate that somewhat, we guard the inclusion of Scalar via the
          `INCLUDE_SCALAR` environment variable.
  6:  1b0328fa236 =  6:  8e3542e43f7 ci: also run the `scalar` tests
  7:  cca604ef326 =  7:  385abdb8d8e scalar: 'register' sets recommended config and starts maintenance
  8:  9fea89cd161 =  8:  64c6a75353e scalar: 'unregister' stops background maintenance
  9:  5e077bf892b =  9:  f7fc1958b9e scalar: let 'unregister' handle a deleted enlistment directory gracefully
 10:  dfa0c470989 = 10:  fd2680bc945 scalar: implement 'scalar list'
 11:  febefe39886 = 11:  4966a43aad9 scalar: implement the `clone` subcommand
 12:  2677bcff335 = 12:  b00d68b37b0 scalar: teach 'clone' to support the --single-branch option
 13:  99affb84284 = 13:  771d826bbb1 scalar: implement the `run` command
 14:  69e2242240b = 14:  a8b2d26a830 scalar: allow reconfiguring an existing enlistment
 15:  0068c18aa62 = 15:  ca284ff34a2 scalar: teach 'reconfigure' to optionally handle all registered enlistments
 16:  d5218523a38 = 16:  9983eb8912c scalar: implement the `delete` command
 17:  96a803416b5 = 17:  889f613ab18 scalar: implement the `version` command

-- 
gitgitgadget

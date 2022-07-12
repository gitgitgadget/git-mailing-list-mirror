Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C27CCA47B
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 00:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiGLAGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiGLAGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 20:06:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF34020F41
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a5so8979042wrx.12
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s2aJ1qbR+Lz6T3P/4tkb8SmzjljLLeXdp8zbxw0pOsE=;
        b=Z1p/l58BTAMovDBtm0iBnfor1k2fFY6s7CAT0Y91mtxO28lnbXMTVo4hvcjU7lCw9L
         NDLGOXyVdmXuBXBo+vswLP3RGRcHtOjIK0u0gMTUrC/kvpekc42LPNZi2/LvFsznykox
         llhlAyWtN+3b25CeIrRrBcdHHahHbosVwN9xrQTM+caGHoNLp7pk4rvtzjUaiQWLGVx3
         xtXD0l2D4lhYChXbHQWZvHhd5EM1KDYtSIWQVNgi6JenAUmzC207itp0KQog/fetIcqe
         p1vM9b2liYKmGaNV8pqlkWWrdsSzDRJM6p/QkA5l5ze4a1BvS9bxCYZN1z6lAfl+wtMf
         Uvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s2aJ1qbR+Lz6T3P/4tkb8SmzjljLLeXdp8zbxw0pOsE=;
        b=aCE8NrLCTZ8vZnsy6svnMyTbmUS1ZnIMRVoqKFkxA5J+s5aXb0I4wsK/YO5rXSMLcA
         5uDcaJallYj6DpMMyBtWflXwKtyU5Xy66elZqzhMZiLPxLiSnq7yDrnj+OW7DLfk7lkL
         B+/pwKyokLn7yc4ib7g77DlBCJqBKDKA/GfPn5LlAYoLvdbJnugcmwBfgUICBwQeCvZh
         xtOEqrjzfQdj2LZ7NotEiUUTpmIJWbJVAEq7OUn7OrbemD1hJhyUynP2AzsJiUoJLWJy
         gOn/bbE62bvl6XFTTftiPm7zS9W8uSyR37cjhF7wi9a6Ebc2uXUGEG54XC+GmWovD7kk
         6FkA==
X-Gm-Message-State: AJIora/AeljKHGGkYxzljH7xEIM0u0o3ayY+m9ef2AnjRUMD3KttUDfI
        aNEWbQC2tg9zCcBiUK0HXg4C4R/bHjU=
X-Google-Smtp-Source: AGRyM1t/V7HZ9FDinIYlzojCxWSTQc7mEeB+MeXazW4m3zO/R7kSeyQi5JLUBXc0HrCy7exk3R1sHw==
X-Received: by 2002:a5d:5955:0:b0:21d:854d:3322 with SMTP id e21-20020a5d5955000000b0021d854d3322mr18969015wri.503.1657584371010;
        Mon, 11 Jul 2022 17:06:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b0021d8b1656dfsm6968233wrq.93.2022.07.11.17.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:06:10 -0700 (PDT)
Message-Id: <65eda9755d2a29e222bf7e6cc719921b24377cc6.1657584367.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.v2.git.1657584367.gitgitgadget@gmail.com>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
        <pull.1275.v2.git.1657584367.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 00:06:07 +0000
Subject: [PATCH v2 2/2] scalar: convert README.md into a technical design doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Adapt the content from 'contrib/scalar/README.md' into a design document in
'Documentation/technical/'. In addition to reformatting for asciidoc,
elaborate on the background, purpose, and design choices that went into
Scalar.

Most of this document will persist in the 'Documentation/technical/' after
Scalar has been moved out of 'contrib/' and into the root of Git. Until that
time, it will also contain a temporary "Roadmap" section detailing the
remaining series needed to finish the initial version of Scalar. The section
will be removed once Scalar is moved to the repo root, but in the meantime
serves as a guide for readers to keep up with progress on the feature.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/technical/scalar.txt | 127 +++++++++++++++++++++++++++++
 contrib/scalar/README.md           |  82 -------------------
 2 files changed, 127 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/technical/scalar.txt
 delete mode 100644 contrib/scalar/README.md

diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
new file mode 100644
index 00000000000..08bc09c225a
--- /dev/null
+++ b/Documentation/technical/scalar.txt
@@ -0,0 +1,127 @@
+Scalar
+======
+
+Scalar is a repository management tool that optimizes Git for use in large
+repositories. It accomplishes this by helping users to take advantage of
+advanced performance features in Git. Unlike most other Git built-in commands,
+Scalar is not executed as a subcommand of 'git'; rather, it is built as a
+separate executable containing its own series of subcommands.
+
+Background
+----------
+
+Scalar was originally designed as an add-on to Git and implemented as a .NET
+Core application. It was created based on the learnings from the VFS for Git
+project (another application aimed at improving the experience of working with
+large repositories). As part of its initial implementation, Scalar relied on
+custom features in the Microsoft fork of Git that have since been integrated
+into core Git:
+
+* partial clone,
+* commit graphs,
+* multi-pack index,
+* sparse checkout (cone mode),
+* scheduled background maintenance,
+* etc
+
+With the requisite Git functionality in place and a desire to bring the benefits
+of Scalar to the larger Git community, the Scalar application itself was ported
+from C# to C and integrated upstream.
+
+Features
+--------
+
+Scalar is comprised of two major pieces of functionality: automatically
+configuring built-in Git performance features and managing repository
+enlistments.
+
+The Git performance features configured by Scalar (see "Background" for
+examples) confer substantial performance benefits to large repositories, but are
+either too experimental to enable for all of Git yet, or only benefit large
+repositories. As new features are introduced, Scalar should be updated
+accordingly to incorporate them. This will prevent the tool from becoming stale
+while also providing a path for more easily bringing features to the appropriate
+users.
+
+Enlistments are how Scalar knows which repositories on a user's system should
+utilize Scalar-configured features. This allows it to update performance
+settings when new ones are added to the tool, as well as centrally manage
+repository maintenance. The enlistment structure - a root directory with a
+`src/` subdirectory containing the cloned repository itself - is designed to
+encourage users to route build outputs outside of the repository to avoid the
+performance-limiting overhead of ignoring those files in Git.
+
+Design
+------
+
+Scalar is implemented in C and interacts with Git via a mix of child process
+invocations of Git and direct usage of `libgit.a`. Internally, it is structured
+much like other built-ins with subcommands (e.g., `git stash`), containing a
+`cmd_<subcommand>()` function for each subcommand, routed through a `cmd_main()`
+function. Most options are unique to each subcommand, with `scalar` respecting
+some "global" `git` options (e.g., `-c` and `-C`).
+
+Because `scalar` is not invoked as a Git subcommand (like `git scalar`), it is
+built and installed as its own executable in the `bin/` directory, alongside
+`git`, `git-gui`, etc.
+
+Roadmap
+-------
+
+NOTE: this section will be removed once the remaining tasks outlined in this
+roadmap are complete.
+
+Scalar is a large enough project that it is being upstreamed incrementally,
+living in `contrib/` until it is feature-complete. So far, the following patch
+series have been accepted:
+
+- `scalar-the-beginning`: The initial patch series which sets up
+  `contrib/scalar/` and populates it with a minimal `scalar` command that
+  demonstrates the fundamental ideas.
+
+- `scalar-c-and-C`: The `scalar` command learns about two options that can be
+  specified before the command, `-c <key>=<value>` and `-C <directory>`.
+
+- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
+
+Roughly speaking (and subject to change), the following series are needed to
+"finish" this initial version of Scalar:
+
+- Finish Scalar features: Enable the built-in FSMonitor in Scalar enlistments
+  and implement `scalar help`. At the end of this series, Scalar should be
+  feature-complete from the perspective of a user.
+
+- Generalize features not specific to Scalar: In the spirit of making Scalar
+  configure only what is needed for large repo performance, move common
+  utilities into other parts of Git. Some of this will be internal-only, but one
+  major change will be generalizing `scalar diagnose` for use with any Git
+  repository.
+
+- Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
+  `git`, including updates to build and install it with the rest of Git. This
+  change will incorporate Scalar into the Git CI and test framework, as well as
+  expand regression and performance testing to ensure the tool is stable.
+
+Finally, there are two additional patch series that exist in Microsoft's fork of
+Git, but there is no current plan to upstream them. There are some interesting
+ideas there, but the implementation is too specific to Azure Repos and/or VFS
+for Git to be of much help in general.
+
+These still exist mainly because the GVFS protocol is what Azure Repos has
+instead of partial clone, while Git is focused on improving partial clone:
+
+- `scalar-with-gvfs`: The primary purpose of this patch series is to support
+  existing Scalar users whose repositories are hosted in Azure Repos (which does
+  not support Git's partial clones, but supports its predecessor, the GVFS
+  protocol, which is used by Scalar to emulate the partial clone).
+
+  Since the GVFS protocol will never be supported by core Git, this patch series
+  will remain in Microsoft's fork of Git.
+
+- `run-scalar-functional-tests`: The Scalar project developed a quite
+  comprehensive set of integration tests (or, "Functional Tests"). They are the
+  sole remaining part of the original C#-based Scalar project, and this patch
+  adds a GitHub workflow that runs them all.
+
+  Since the tests partially depend on features that are only provided in the
+  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
diff --git a/contrib/scalar/README.md b/contrib/scalar/README.md
deleted file mode 100644
index 634b5771ed3..00000000000
--- a/contrib/scalar/README.md
+++ /dev/null
@@ -1,82 +0,0 @@
-# Scalar - an opinionated repository management tool
-
-Scalar is an add-on to Git that helps users take advantage of advanced
-performance features in Git. Originally implemented in C# using .NET Core,
-based on the learnings from the VFS for Git project, most of the techniques
-developed by the Scalar project have been integrated into core Git already:
-
-* partial clone,
-* commit graphs,
-* multi-pack index,
-* sparse checkout (cone mode),
-* scheduled background maintenance,
-* etc
-
-This directory contains the remaining parts of Scalar that are not (yet) in
-core Git.
-
-## Roadmap
-
-The idea is to populate this directory via incremental patch series and
-eventually move to a top-level directory next to `gitk-git/` and to `git-gui/`. The
-current plan involves the following patch series:
-
-- `scalar-the-beginning`: The initial patch series which sets up
-  `contrib/scalar/` and populates it with a minimal `scalar` command that
-  demonstrates the fundamental ideas.
-
-- `scalar-c-and-C`: The `scalar` command learns about two options that can be
-  specified before the command, `-c <key>=<value>` and `-C <directory>`.
-
-- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
-
-- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled in `scalar
-  register` and in `scalar clone`, for an enormous performance boost when
-  working in large worktrees. This patch series necessarily depends on Jeff
-  Hostetler's FSMonitor patch series to be integrated into Git.
-
-- `scalar-gentler-config-locking`: Scalar enlistments are registered in the
-  user's Git config. This usually does not represent any problem because it is
-  rare for a user to register an enlistment. However, in Scalar's functional
-  tests, Scalar enlistments are created galore, and in parallel, which can lead
-  to lock contention. This patch series works around that problem by re-trying
-  to lock the config file in a gentle fashion.
-
-- `scalar-extra-docs`: Add some extensive documentation that has been written
-  in the original Scalar project (all subject to discussion, of course).
-
-- `optionally-install-scalar`: Now that Scalar is feature (and documentation)
-  complete and is verified in CI builds, let's offer to install it.
-
-- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move it next to
-  `gitk-git/` and to `git-gui/`, making it a top-level command.
-
-The following two patch series exist in Microsoft's fork of Git and are
-publicly available. There is no current plan to upstream them, not because I
-want to withhold these patches, but because I don't think the Git community is
-interested in these patches.
-
-There are some interesting ideas there, but the implementation is too specific
-to Azure Repos and/or VFS for Git to be of much help in general (and also: my
-colleagues tried to upstream some patches already and the enthusiasm for
-integrating things related to Azure Repos and VFS for Git can be summarized in
-very, very few words).
-
-These still exist mainly because the GVFS protocol is what Azure Repos has
-instead of partial clone, while Git is focused on improving partial clone:
-
-- `scalar-with-gvfs`: The primary purpose of this patch series is to support
-  existing Scalar users whose repositories are hosted in Azure Repos (which
-  does not support Git's partial clones, but supports its predecessor, the GVFS
-  protocol, which is used by Scalar to emulate the partial clone).
-
-  Since the GVFS protocol will never be supported by core Git, this patch
-  series will remain in Microsoft's fork of Git.
-
-- `run-scalar-functional-tests`: The Scalar project developed a quite
-  comprehensive set of integration tests (or, "Functional Tests"). They are the
-  sole remaining part of the original C#-based Scalar project, and this patch
-  adds a GitHub workflow that runs them all.
-
-  Since the tests partially depend on features that are only provided in the
-  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
-- 
gitgitgadget

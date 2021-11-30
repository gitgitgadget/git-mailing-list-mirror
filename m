Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD86C4332F
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhK3L63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhK3L6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9FEC061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y196so17204418wmc.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQJ4Fsl7CqY1kSfF5905tSksE/gGYx0P1d+aDxCpFio=;
        b=OR9vyDJ7XhqE6YBr1dPI8alU2SK7IqkIIHqdDCH1YD8LnCEkfeKdFSGFeNM2DwCOXG
         m4Uh12UrK+K3rf5UCyDaJjxfO0myexzsJpKrkIO7z+P2SPL7DHQ+pOwxXCKTF/91m/Kx
         rKdjBs9jmc/xL9hmoAPDXVbcpLkGno5ZcSQ9A3jXIA076CIAESMIgxXr+CIbbtbBKrhG
         SoGeghqSOiXL/SSvWOOMIV1hCSUeL4tYm+4XLWYg8UaZjk2x0fEofNTCp3Jgl7bPw2++
         /zjedAW2rJhyWPF4yDBubjPSdAxPh3+qJnt2PbHqQU8OZg3xNhm5MmqEWVHTY99P4y6d
         NsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uQJ4Fsl7CqY1kSfF5905tSksE/gGYx0P1d+aDxCpFio=;
        b=DZj39xakmX0+18hchLPqsv2OqCvzL8InukLGmh7PNlt66/WZyq2RZSyLPC2tk/8fmM
         9LCw/x5rVnhQIFZg1qWAUeop6KGx0+QdHTplgIzDww098Oyz32EQQ8ILDsJ/N2Oeeodw
         4h2ciuElKbc0zzBjkBOlP63UCm1hzJbXp8FdgtXVvUaJSsp/po7YgAsbrKNNpUyrFyqP
         oiMzmw78eyK6jTvAd2B7eKiAiIEfy4uDm0sjzDyM2+Y379j1pzal38G6iYfScGJjodpg
         5J+T+AziW8PwlATdA+w8KAeUJUlfxBm8mCEXn56ULeMsMWuqi8TEYB/fhz7u4ruvtuNw
         aSaw==
X-Gm-Message-State: AOAM531BcH4UF6H4RSoqDOB6WgRws1nNYFC6gTf39sVD3r1s5oXD8MM2
        tGIaeFIi43zOFlljziKYcFW4coq/iWc=
X-Google-Smtp-Source: ABdhPJzYfKFnAoOIduqXM+RDS4wOWLA+oU43q7+1JCYmYvtW7vRIKyJ6MW4KYZ7T8Yt3dSzU9EyIlQ==
X-Received: by 2002:a1c:a710:: with SMTP id q16mr4478686wme.138.1638273291535;
        Tue, 30 Nov 2021 03:54:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm2234166wmi.36.2021.11.30.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:51 -0800 (PST)
Message-Id: <3a2e28275f112d114bbd3ba046f440c5f917fc32.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:33 +0000
Subject: [PATCH v9 01/17] scalar: add a README with a roadmap
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Scalar command will be contributed incrementally, over a bunch of
patch series. Let's document what Scalar is about, and then describe the
patch series that are planned.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/README.md | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 contrib/scalar/README.md

diff --git a/contrib/scalar/README.md b/contrib/scalar/README.md
new file mode 100644
index 00000000000..634b5771ed3
--- /dev/null
+++ b/contrib/scalar/README.md
@@ -0,0 +1,82 @@
+# Scalar - an opinionated repository management tool
+
+Scalar is an add-on to Git that helps users take advantage of advanced
+performance features in Git. Originally implemented in C# using .NET Core,
+based on the learnings from the VFS for Git project, most of the techniques
+developed by the Scalar project have been integrated into core Git already:
+
+* partial clone,
+* commit graphs,
+* multi-pack index,
+* sparse checkout (cone mode),
+* scheduled background maintenance,
+* etc
+
+This directory contains the remaining parts of Scalar that are not (yet) in
+core Git.
+
+## Roadmap
+
+The idea is to populate this directory via incremental patch series and
+eventually move to a top-level directory next to `gitk-git/` and to `git-gui/`. The
+current plan involves the following patch series:
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
+- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled in `scalar
+  register` and in `scalar clone`, for an enormous performance boost when
+  working in large worktrees. This patch series necessarily depends on Jeff
+  Hostetler's FSMonitor patch series to be integrated into Git.
+
+- `scalar-gentler-config-locking`: Scalar enlistments are registered in the
+  user's Git config. This usually does not represent any problem because it is
+  rare for a user to register an enlistment. However, in Scalar's functional
+  tests, Scalar enlistments are created galore, and in parallel, which can lead
+  to lock contention. This patch series works around that problem by re-trying
+  to lock the config file in a gentle fashion.
+
+- `scalar-extra-docs`: Add some extensive documentation that has been written
+  in the original Scalar project (all subject to discussion, of course).
+
+- `optionally-install-scalar`: Now that Scalar is feature (and documentation)
+  complete and is verified in CI builds, let's offer to install it.
+
+- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move it next to
+  `gitk-git/` and to `git-gui/`, making it a top-level command.
+
+The following two patch series exist in Microsoft's fork of Git and are
+publicly available. There is no current plan to upstream them, not because I
+want to withhold these patches, but because I don't think the Git community is
+interested in these patches.
+
+There are some interesting ideas there, but the implementation is too specific
+to Azure Repos and/or VFS for Git to be of much help in general (and also: my
+colleagues tried to upstream some patches already and the enthusiasm for
+integrating things related to Azure Repos and VFS for Git can be summarized in
+very, very few words).
+
+These still exist mainly because the GVFS protocol is what Azure Repos has
+instead of partial clone, while Git is focused on improving partial clone:
+
+- `scalar-with-gvfs`: The primary purpose of this patch series is to support
+  existing Scalar users whose repositories are hosted in Azure Repos (which
+  does not support Git's partial clones, but supports its predecessor, the GVFS
+  protocol, which is used by Scalar to emulate the partial clone).
+
+  Since the GVFS protocol will never be supported by core Git, this patch
+  series will remain in Microsoft's fork of Git.
+
+- `run-scalar-functional-tests`: The Scalar project developed a quite
+  comprehensive set of integration tests (or, "Functional Tests"). They are the
+  sole remaining part of the original C#-based Scalar project, and this patch
+  adds a GitHub workflow that runs them all.
+
+  Since the tests partially depend on features that are only provided in the
+  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
-- 
gitgitgadget


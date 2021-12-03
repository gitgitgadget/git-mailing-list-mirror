Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED74C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352522AbhLCNh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbhLCNh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:37:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF42AC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d24so5923688wra.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQJ4Fsl7CqY1kSfF5905tSksE/gGYx0P1d+aDxCpFio=;
        b=J2jOHkIafDyCO9wAnS2gmvnPk4CX9eSP5u7YrNhQX9VPr3QxNIohReAq2GoLt9ZpP7
         +XFDobvR/jTOBYAsblg2huCi2L8JXOrLsoDaPxcL3filcMgD3OLCReR0MZfSVkS8JmFs
         WxohLQTq/jAOnRCqfL9CSf64hjtu8kYRqZVV0/8O2qrdD63O064X+o7oVO9h9mEMsLCL
         DUrFf6sVtiYeqJvyi4H4WJdKlEy2x57bNsnzZBJv3qEFMHYFADHgdoxgpXuxZU5SPAUW
         vZiOhJQrqSqhdIrmhIF18SnMGuI1GbdtNOyVazm2xZzd3wBQ8Fbo1dXOzC78DliT+WFq
         IjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uQJ4Fsl7CqY1kSfF5905tSksE/gGYx0P1d+aDxCpFio=;
        b=3f4w+kJjPmReNDCUKFEUAj7JrJ367RjzlQz16c4QpgwUu7ZQwIDtygh21GK5lt5/+6
         RYZJymVZ1z/ZWTizJmEfkdCJ1aMCAIbRsoMJC7crJWc57VeFk14NfSZ+Clz+eSYjp2IP
         Fs+1DNh9OnUyLpfAsBUvjMWGp4SGCE3sLfAx/Cz+nsGAV3z56yCicDS7R54j9HEyS63F
         gM6gmGRbGFVQjBwG0XocXx6jboBTPIXoW10jg52gLZC5A8SH/D1c3BcppCMIlXaK5gim
         dXjvlMiexBKoWsDkhugsiRi1RTriZgYEY82wS8FxW8v+TxWTKNBm6mDxFZgzJ1bhk7LP
         NXAA==
X-Gm-Message-State: AOAM531a/gk/94uUjYHAbwiQLt2VrBTO7te01/kRfn1U8m80OhnyLi6G
        vAtSU5SBRVySULEZv9b6ZsteceibSPE=
X-Google-Smtp-Source: ABdhPJz3kyxajDRnzQvfE95TujViNADLqbrmR2lSm6GSNbLRVeVffYKEi0HAXP4nJF3DVjRzOSa5VA==
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr20500395wra.281.1638538472180;
        Fri, 03 Dec 2021 05:34:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k27sm5288175wms.41.2021.12.03.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:31 -0800 (PST)
Message-Id: <3a2e28275f112d114bbd3ba046f440c5f917fc32.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:15 +0000
Subject: [PATCH v10 01/15] scalar: add a README with a roadmap
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


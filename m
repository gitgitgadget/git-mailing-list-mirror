Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069D4C4332F
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC7361A79
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhKQOW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhKQOWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:22:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50EC061764
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t30so4993920wra.10
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wIr3am6SCsIbgGZvNtNpnMILEzX+zX3D0DVgxD6BgPw=;
        b=BJQS2kzyqs8UXv66u1WcoSBRVSe7EUfkr9uq8s43uVX7ZSL7Ss33cD7JaBdrP177YM
         D8WUzN2bUDpTLMfK9H0xIdyq33UcExWcCCjyvrG694CTkVr06ZQj7rdP2oxzsvKVU4pB
         Evs2lRNKv142gVALS3ZkGAoGxfb2Hs4tDXt0BFWHrCTFU2B8Py9lynZjngLp3P1OJC2z
         ZyuBcmC1NHgHmAQDPS3qfax4pq5OHt4PdNsxiFZzPzvVsUuMSTfJ8LzDoUA9xYJl0LSq
         uEZ6JWEVn+rRXQM1UkkHIRHrk35ybmb4hmSxx/q2SYa1W1M+qQEOxTBP8O0YUTSjMdtw
         xbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wIr3am6SCsIbgGZvNtNpnMILEzX+zX3D0DVgxD6BgPw=;
        b=bJluZNbJ4JSFCHxzpBqL/1r8EvT4wejaq32tCu4qSTXGHkleHkO9mb1xeSX6aaKV6B
         5rYlISLlIvhSApvoWH/f7kxGnzQx4QlD11B95q7EmmPZCJELSeDzdIB2Zxy9aAK0C1ps
         bXImkai5EOLdm/wacGaa1sLu9tVNjTkt6a+wkGebZghsriDYj1NQlwzTY8xDrP+OkqSl
         0kaQB9cJhUVsHEYBy8mSCyGqCLO1jzywRcFt/ZK7WyjtCOPt2ulOCB+ONi0rAKizYiSO
         tfW0hPNGyeSBb9gUz+14wBGDN3kT1HX6hH5lPwRl0qFlQFZwpFfczJ3grBStL/yX6DWm
         3Gqg==
X-Gm-Message-State: AOAM533gLbMT514ex+4xO8UG16yXfy0MATOCT4LtOfTcW/lRqb8lVDCx
        SCsRrI7XeV/kSYLw8xeSPFWQqZYEUuw=
X-Google-Smtp-Source: ABdhPJzQljNH8oK4avo5+CEtkoOYM7lwrf/6EE5KqBM7m+o7dBtblerYxF07kKxoHFiV4wtcYOB8WA==
X-Received: by 2002:adf:e484:: with SMTP id i4mr20393477wrm.49.1637158764465;
        Wed, 17 Nov 2021 06:19:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19sm28413wra.5.2021.11.17.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:24 -0800 (PST)
Message-Id: <3aa095dc824ea7f659e6c11aa2c21be6cadbe985.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:06 +0000
Subject: [PATCH v7 01/17] scalar: add a README with a roadmap
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
        Theodore Ts'o <tytso@mit.edu>,
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
 contrib/scalar/README.md | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 contrib/scalar/README.md

diff --git a/contrib/scalar/README.md b/contrib/scalar/README.md
new file mode 100644
index 00000000000..7898a683ba5
--- /dev/null
+++ b/contrib/scalar/README.md
@@ -0,0 +1,71 @@
+# Scalar - an opinionated repository management tool
+
+Scalar is an add-on to Git, helping Git scale to very large repositories and
+worktrees. Originally implemented in C# using .NET Core, based on the learnings
+from the VFS for Git project, most of the techniques developed by the Scalar
+project have been integrated into core Git already:
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
+  init` and in `scalar clone`, for an enormous performance boost when working
+  in large worktrees. This patch series necessarily depends on Jeff Hostetler's
+  FSMonitor patch series to be integrated into Git.
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
+The following two patch series exist, but there is no plan to integrate them
+into Git's source tree:
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B4C001B5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiIBQL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiIBQLC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:11:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0606641D01
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 09:05:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso1710151wmb.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=NHckKwoRME6izHezy19QDuLVea12ybAgp0ADMPSukzw=;
        b=EzhszcxxrOZItuzER0h0UTYz+sVx8r11oUfCcBekApLlsJygpLPT/ixIkmqQIXQcUT
         zVJOUlw2qkj1aKp1nPd3UheefKBVBnA5tqpQ/e46Ih5cJLG6RV4ZGvsU8dE2pud4VYmx
         tb+FOJ1Lc6qTzc1HC3+cuG7A7MvFnl09GMXf5qs4OGmWgfUshjfBxQQGYmlIqAa3PULW
         hMC7CBBgJVaAu09G3UnLpgEm7YLb0J3KV4+IRaxIBJxwSDu7KnzlBic0PF3gLBcU3rW9
         10va3b3OtsA3adsClFVIUuDJWueouOT/L64s7cY5OKs9b8KprkAt9rhE/UI4qW5AqWlJ
         FChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NHckKwoRME6izHezy19QDuLVea12ybAgp0ADMPSukzw=;
        b=H5KP4xGSqfPwhf719kdgWZjxRzmp81QBKJiM1AuecRGTjXjTAh1X13dpsi+sorPWyb
         B+otDjmUVXIsGEUFMyJ6G1oY3UMDeyWeSz0UF77hPlvmCwnt91pn0lUdYN+48xpLyPC7
         grtMKMxvqYheaGTV01Wxb+941WjwnTN0FNDjHGa4PFASaDqbBUiIlk41NFHehH1Vab+W
         obkK3JK9QkxD7Y0oQvqFqfe0JjJYGc73wDvh5JKU8XXeKA0my7dYnt6+Zw9oL8q5Ue0A
         WkoAE04bi8dMFe375XQVzt8Mz0Ib7lmlbewvvRNOPk+Sb/ZwspvFxVjuSMoXpzZl1ohb
         Duug==
X-Gm-Message-State: ACgBeo2kKhEychUzdsxZ0YXHaqFZkVFBDGcwBuAZOBa5MzxDVSxGfzU8
        E03sXdJdcadZnjJpaw6Oq8AkFplCedo=
X-Google-Smtp-Source: AA6agR4dBhVPUmM7H/O+p88oR1cuSkzdEXXlir6mqyD19sFRAUqsqyz7oMYrP2GVG4GgV6MBCbfSxg==
X-Received: by 2002:a1c:7414:0:b0:3a5:fd9e:e629 with SMTP id p20-20020a1c7414000000b003a5fd9ee629mr3392514wmc.194.1662134221616;
        Fri, 02 Sep 2022 08:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t64-20020a1c4643000000b003a673055e68sm10154836wma.0.2022.09.02.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:57:01 -0700 (PDT)
Message-Id: <6bedd80c398dd862d17b03528cc14f17e9484391.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:50 +0000
Subject: [PATCH v2 9/9] Documentation/technical: include Scalar technical doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Include 'Documentation/technical/scalar.txt' alongside the other HTML
technical docs when installing them.

Now that the document is intended as a widely-accessible reference, remove
the internal work-in-progress roadmap from the document. Those details
should no longer be needed to guide Scalar's development and, if they were
left, they could fall out-of-date and be misleading to readers.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/Makefile             |  1 +
 Documentation/technical/scalar.txt | 61 ------------------------------
 2 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 16c9e062390..9ec53afdf18 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -116,6 +116,7 @@ TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
+TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/trivial-merge
diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 0600150b3ad..921cb104c3c 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -64,64 +64,3 @@ some "global" `git` options (e.g., `-c` and `-C`).
 Because `scalar` is not invoked as a Git subcommand (like `git scalar`), it is
 built and installed as its own executable in the `bin/` directory, alongside
 `git`, `git-gui`, etc.
-
-Roadmap
--------
-
-NOTE: this section will be removed once the remaining tasks outlined in this
-roadmap are complete.
-
-Scalar is a large enough project that it is being upstreamed incrementally,
-living in `contrib/` until it is feature-complete. So far, the following patch
-series have been accepted:
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
-- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
-  into `git diagnose` and `git bugreport --diagnose`.
-
-- 'scalar-add-fsmonitor: Enable the built-in FSMonitor in Scalar
-  enlistments. At the end of this series, Scalar should be feature-complete
-  from the perspective of a user.
-
-Roughly speaking (and subject to change), the following series are needed to
-"finish" this initial version of Scalar:
-
-- Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
-  `git`. This includes a variety of related updates, including:
-    - building & installing Scalar in the Git root-level 'make [install]'.
-    - builing & testing Scalar as part of CI.
-    - moving and expanding test coverage of Scalar (including perf tests).
-    - implementing 'scalar help'/'git help scalar' to display scalar
-      documentation.
-
-Finally, there are two additional patch series that exist in Microsoft's fork of
-Git, but there is no current plan to upstream them. There are some interesting
-ideas there, but the implementation is too specific to Azure Repos and/or VFS
-for Git to be of much help in general.
-
-These still exist mainly because the GVFS protocol is what Azure Repos has
-instead of partial clone, while Git is focused on improving partial clone:
-
-- `scalar-with-gvfs`: The primary purpose of this patch series is to support
-  existing Scalar users whose repositories are hosted in Azure Repos (which does
-  not support Git's partial clones, but supports its predecessor, the GVFS
-  protocol, which is used by Scalar to emulate the partial clone).
-
-  Since the GVFS protocol will never be supported by core Git, this patch series
-  will remain in Microsoft's fork of Git.
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

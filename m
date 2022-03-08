Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7462C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbiCHHlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbiCHHkz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8A3DDE5
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h15so2643225wrc.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DyI06a7wt/jqpClfvebBRaw5+VFsEvpBA/RH2pk/6z8=;
        b=f6xMLMnaQwk51wsey8mzl398um8oEpd2c5e3WmCI3cQg3hztpqVUvBVVpqhi12Xb1W
         lUFLwXCuSfCwDnRbZv2Css3cCSKjH8/lFwcvOGyYvVB9NYo8rc+MLuqhhUbaAi3y4K/w
         JyzM8j6YvCJjYtaJ0gxRrhgwYJJdjRnpPRlmUVno9QhIT4YIKhNXTwkp9NlG3Edvxq5i
         csXZ4gKwUcJnfee6VmX4z+8p8cbKwAErmtu9mk+tOZkWAXXjHlc2VohbKcN8cxuUaRqy
         oBeL/DWI4cte7iBXlCDsvq8Y3AMM69USfIRwECd8mSVjZPMCrCKZmsw+fK5P1xBWKySi
         qDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DyI06a7wt/jqpClfvebBRaw5+VFsEvpBA/RH2pk/6z8=;
        b=u/Hsz5nnLb4j1GR6Y9OSMey4POu1h1CYbDRnO/gSjRoCe+/OKPT2uJf1Faz19O8OtQ
         vY5IWaOQPBTJVrQTYPaw53WwK9lnlmbT5UO6goZyIBVbWf4ZMyaClqS+5wiW+Ti1oaBz
         cksPOiLEVg57sBOBOBgFfefP5LDTHfPZGqC1++wHzA2OH+FHt6QjVUrE2jsn8dbzOuiG
         DzGYs3cJsJTQmmXPAtb1KFljKsSzmRx5/12wh/xv1fopbxqSi5i/oR8/dFFkaArjCi7u
         tYBNg6l5qTLxgke0eETZeIERjN2yRl+i7SRq6HZZ1DtowOt0Hekobiut2Q6BktG1psAQ
         ajqA==
X-Gm-Message-State: AOAM533y94czrjhYJC8QKsjdw1bS4oaQkof/k4dpTBU1ZXdEm2u8pyJI
        uQ2WY+QA8WceNg9qCuH+/cWRHjm/+Nw=
X-Google-Smtp-Source: ABdhPJwz/2D5LF+fawpvdJbiEOZ4sVr3y+1WhYa9NG1WVQuwfAdrG2uQ1y7gGerTzQNmmaR12Wtdyg==
X-Received: by 2002:a05:6000:1d83:b0:1ef:f98a:5406 with SMTP id bk3-20020a0560001d8300b001eff98a5406mr11638413wrb.8.1646725197604;
        Mon, 07 Mar 2022 23:39:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b001ed89dcacbbsm13087343wrs.23.2022.03.07.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:57 -0800 (PST)
Message-Id: <3e35d62c5eefe5ef272cf0b3cbd10d94e6bbabd2.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:47 +0000
Subject: [PATCH 8/9] git-sparse-checkout.txt: mark non-cone mode as deprecated
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While we have no current plans to actually remove --no-cone mode, we
think users would be better off not using it.  Update the documentation
accordingly, including explaining why we think non-cone mode is
problematic for users.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 86 +++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 35e4e2d809e..11792187224 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -71,10 +71,13 @@ and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
 to be enabled.
 +
 When `--no-cone` is passed, the input list is considered a list of
-patterns.  This mode is harder to use and less performant, and is thus
-not recommended.  See the "Sparse Checkout" section of
-linkgit:git-read-tree[1] and the "Pattern Set" sections below for more
-details.
+patterns.  This mode is harder to use, and unless you can keep the
+number of patterns small, its design also scales poorly.  It used to be
+the default mode, but we do not recommend using it.  It does not work
+with the `--sparse-index` option, and will likely be incompatible with
+other new features as they are added.  See the "Non-cone Problems"
+section below and the "Sparse Checkout" section of
+linkgit:git-read-tree[1] for more details.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -190,6 +193,81 @@ directory, it updates the skip-worktree bits in the index based
 on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
+INTERNALS -- NON-CONE PROBLEMS
+------------------------------
+
+The `$GIT_DIR/info/sparse-checkout` file populated by the `set` and
+`add` subcommands is defined to be a bunch of patterns (one per line)
+using the same syntax as `.gitignore` files.  In cone mode, these
+patterns are restricted to matching directories (and users only ever
+need supply or see directory names), while in non-cone mode any
+gitignore-style pattern is permitted.  Using the full gitignore-style
+patterns in non-cone mode has a number of shortcomings:
+
+  * Fundamentally, it makes various worktree-updating processes (pull,
+    merge, rebase, switch, reset, checkout, etc.) require O(N*M) pattern
+    matches, where N is the number of patterns and M is the number of
+    paths in the index.  This scales poorly.
+
+  * Avoiding the scaling issue has to be done via limiting the number
+    of patterns via specifying leading directory name or glob.
+
+  * Passing globs on the command line is error-prone as users may
+    forget to quote the glob, causing the shell to expand it into all
+    matching files and pass them all individually along to
+    sparse-checkout set/add.  This both exacerbates the scaling
+    problem, and hardcodes the list of selected files to those which
+    were present at the time the initial set/add subcommand was run
+    (and thus ignoring other files matching the same glob which come
+    into the working tree after switching branches or pulling down
+    updates).
+
+  * It uses "ignore"/"exclude" syntax for selecting what to "include",
+    which periodically causes confusion.
+
+  * It introduces inconsistencies in the Git command line, since other
+    commands use pathspecs, but sparse-checkout (in non-cone mode) uses
+    gitignore patterns.
+
+  * It has edge cases where the "right" behavior is unclear.  Two examples:
+
+    First, two users are in a subdirectory, and the first runs
+       git sparse-checkout set '/toplevel-dir/*.c'
+    while the second runs
+       git sparse-checkout set relative-dir
+    Should those arguments be transliterated into
+       current/subdirectory/toplevel-dir/*.c
+    and
+       current/subdirectory/relative-dir
+    before inserting into the sparse-checkout file?  The user who typed
+    the first command is probably aware that arguments to set/add are
+    supposed to be patterns in non-cone mode, and probably would not be
+    happy with such a transliteration.  However, many gitignore-style
+    patterns are just paths, which might be what the user who typed the
+    second command was thinking, and they'd be upset if their argument
+    wasn't transliterated.
+
+    Second, what should bash-completion complete on for set/add commands
+    for non-cone users?  If it suggests paths, is it exacerbating the
+    problem above?  Also, if it suggests paths, what if the user has a
+    file or directory that begins with either a '!' or '#' or has a '*',
+    '\', '?', '[', or ']' in its name?  And if it suggests paths, will
+    it complete "/pro" to "/proc" (in the root filesytem) rather than to
+    "/progress.txt" in the current directory?  (Note that users are
+    likely to want to start paths with a leading '/' in non-cone mode,
+    for the same reason that .gitignore files often have one.)
+    Completing on files or directories might give nasty surprises in
+    all these cases.
+
+  * The excessive flexibility made other extensions essentially
+    impractical.  `--sparse-index` may not have been feasible in
+    non-cone mode, but even if it was, it would have been far more work
+    to implement and may have been too slow in practice.  Some ideas for
+    adding coupling between partial clones and sparse checkouts are only
+    practical with a more restricted set of paths.
+
+For all these reasons, non-cone mode is deprecated.  Please switch to
+using cone mode.
 
 INTERNALS -- CONE PATTERN SET
 -----------------------------
-- 
gitgitgadget


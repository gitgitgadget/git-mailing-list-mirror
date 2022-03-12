Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D560C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiCLDM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiCLDMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD19293F19
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i8so15580663wrr.8
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Trm2SuLOmb5hUWC9StR/SY122ZTTAUWBv+lMEf0TWFk=;
        b=G5LpyKmQcLZ3szMbhv0iSuhOLrRiVVq9/wUvE5VGc/GW4DVvbJ4KmiIsfO/VR4pDVN
         1O4DEsaMZsPOaRV8VyNlVAsqr9ssjDVE8fLITcKZgqx7HxzNJvuj4l94bNJPJfByLxfO
         lg8By4/J6rt2uaHiU0a0JlOxig3tTCYyTAs02DACCcKkhe384EpeylTgR3/ef7rTfg3j
         yprRg2ZvElblUdIb6tEjPEVHjOtZlTzYTWME99XiqiBaw1qWBrC+OjFeBWk4jNlYrDku
         fzndBFBEzLSIwOPSrI/x62/Avc/ZmgsQBK3j0tO8VrqQM6a6re/yAMhb/qthyhsaVpeG
         yhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Trm2SuLOmb5hUWC9StR/SY122ZTTAUWBv+lMEf0TWFk=;
        b=dV5ofwst7aCuR1NYMUh40StQ1RyPiiGODeACKr23nVx568jTjMWuBEn51n0PxTfeev
         ndYiQS4M0ULowLThW9mCu2Kwez5WEOqOEYIR+4nX49xutC3xHXdu2EjmtYEGT8M5VihL
         pNYV/7lt7DBcBUaeVImMkha5a7z3kzgURnmezE7LFI2Hl9LBppwCoAGymxOb9zNbpMQ9
         +eC3KK+KTTq/qOzSEVry/hK1aP9Q5Ep/OJPcw4Q2d4ym9n29nFhEG8HG0NXROc6GJr+W
         hJbbtrirEfRSZ/xm4uSe2QCr078jZlH/IfEUHHQ3UozAWVjyFFVna9Jo8lMNcHf+vvoX
         ExBw==
X-Gm-Message-State: AOAM532NBbgWFlVDkP8KIgpK+BvJ0rZJS8Bz18/DnSuGNC0cLO4QQWzP
        BEoAbH9B1YMylf77VEwTDyQKGYFSrsA=
X-Google-Smtp-Source: ABdhPJyofkcIu8uZmxfwG7glMlKQYbU+bT6CNAast7o5/Dys8UJnOzBsN6lBzCzAHETbpf0OfD0u3Q==
X-Received: by 2002:a05:6000:15cc:b0:1f1:f814:27c4 with SMTP id y12-20020a05600015cc00b001f1f81427c4mr9453822wry.630.1647054689267;
        Fri, 11 Mar 2022 19:11:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d46c2000000b001f079ba0158sm7725220wrs.60.2022.03.11.19.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:28 -0800 (PST)
Message-Id: <2d2b81986a55f0692d5536dec88079c58853f205.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:20 +0000
Subject: [PATCH v2 8/9] git-sparse-checkout.txt: mark non-cone mode as
 deprecated
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
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
index ae6ea8b48b0..aaf3ae63853 100644
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
@@ -191,6 +194,81 @@ directory, it updates the skip-worktree bits in the index based
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F44C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443406AbiDVCfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443392AbiDVCfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871544B43A
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so9078288wrg.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mniuo+xVSZDEQAPlzXASCWjhGUSvKje1AXNU3Lzz9ko=;
        b=RkRHbmu86keaZGrI9R2tvx4CT03oecOfkhNsz9bvTJb4BTon6BtS+EEeMyz7u3zpw1
         WtWUSvesSTV7wr4fulKI1gqmXdy4jh+eLHDwQixEAPgdJkMU9V+jhbVZYyc6WIMJDnhZ
         cpmwT7veKH8r4Agtf3zDBbMyWXm2fLUAM6msOOvyT0xnNQfihlidIQ2z4lnsZ5npkwkT
         udewxavZH/Xr/4aWvucosCGUiSaOYPsrqhzFihiKXqz0kvNIUDiDBbIKJ+xZb8gqCR9/
         bnTzPS8Zp1IyYKwar8UXLn7N5hb7fJtnm6uqCxKnuxLZFRNFfr+0UHeKmglddHcwm50C
         7ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mniuo+xVSZDEQAPlzXASCWjhGUSvKje1AXNU3Lzz9ko=;
        b=HjdGklqzGF6BqJQ4muW6/+dzIzg0IiB6SYLaD0EpX3HrVzphmovHY2c/Uh/Iu3jLG9
         6nWBngSyrwrQKRH0n6BV4WwbD0PfJcA/4aiDFCkukw6BymybeSUHdWR7lNlModhwlSPx
         YLhtYfq7Bch5oUy55oGXy/pA8Md25+WKgSCnkTFcoPefWLOHyWtedBXbvSz2zGTNYXXz
         qkkc2Vk5B0T7fEbjO01vDqTNeNDZAexfoFCTiDcz81OHda3+8GQtCuXT/8oExQDQFvC8
         dvFLw7L+elgN1DbaLESObEOOpff7Ppxg+zjUgScyNR5k0fdY+YMypXDZEcyuzu8bCfUm
         yo1g==
X-Gm-Message-State: AOAM530dpexl9lVkbW4zTSserpxO/fNVriBafd52RUyqyD9eR5mg3I17
        vFSHaUu/J7Dp7/yf4vjI7EBkOtMNW24=
X-Google-Smtp-Source: ABdhPJytgfJOkBiDQCODtOhHMfLLIK3H6jPdGQDEG7gGTzobii0MoBgTPvcuNf4dElVoDSKc/xGZSQ==
X-Received: by 2002:adf:ed81:0:b0:207:a82a:bcf1 with SMTP id c1-20020adfed81000000b00207a82abcf1mr1766772wro.194.1650594756723;
        Thu, 21 Apr 2022 19:32:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a056000154300b0020a9dcac3c2sm611599wry.20.2022.04.21.19.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:36 -0700 (PDT)
Message-Id: <a1b68fd6126eb341ef3637bb93fedad4309b36d0.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:25 +0000
Subject: [PATCH v3 8/9] git-sparse-checkout.txt: mark non-cone mode as
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
 Documentation/git-sparse-checkout.txt | 98 +++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 6e32034511d..c65d0ce96bb 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -71,10 +71,9 @@ and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
 to be enabled.
 +
 When `--no-cone` is passed, the input list is considered a list of
-patterns.  This mode is harder to use and less performant, and is thus
-not recommended.  See the "Sparse Checkout" section of
-linkgit:git-read-tree[1] and the "Internals...Pattern Set" sections
-below for more details.
+patterns.  This mode has a number of drawbacks, including not working
+with some options like `--sparse-index`.  As explained in the
+"Non-cone Problems" section below, we do not recommend using it.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -191,6 +190,97 @@ directory, it updates the skip-worktree bits in the index based
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
+    sparse-checkout set/add.  While this could also be a problem with
+    e.g. "git grep -- *.c", mistakes with grep/log/status appear in
+    the immediate output.  With sparse-checkout, the mistake gets
+    recorded at the time the sparse-checkout command is run and might
+    not be problematic until the user later switches branches or rebases
+    or merges, thus putting a delay between the user's error and when
+    they have a chance to catch/notice it.
+
+  * Related to the previous item, sparse-checkout has an 'add'
+    subcommand but no 'remove' subcommand.  Even if a 'remove'
+    subcommand were added, undoing an accidental unquoted glob runs
+    the risk of "removing too much", as it may remove entries that had
+    been included before the accidental add.
+
+  * Non-cone mode uses gitignore-style patterns to select what to
+    *include* (with the exception of negated patterns), while
+    .gitignore files use gitignore-style patterns to select what to
+    *exclude* (with the exception of negated patterns).  The
+    documentation on gitignore-style patterns usually does not talk in
+    terms of matching or non-matching, but on what the user wants to
+    "exclude".  This can cause confusion for users trying to learn how
+    to specify sparse-checkout patterns to get their desired behavior.
+
+  * Every other git subcommand that wants to provide "special path
+    pattern matching" of some sort uses pathspecs, but non-cone mode
+    for sparse-checkout uses gitignore patterns, which feels
+    inconsistent.
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
+    impractical.  `--sparse-index` is likely impossible in non-cone
+    mode; even if it is somehow feasible, it would have been far more
+    work to implement and may have been too slow in practice.  Some
+    ideas for adding coupling between partial clones and sparse
+    checkouts are only practical with a more restricted set of paths
+    as well.
+
+For all these reasons, non-cone mode is deprecated.  Please switch to
+using cone mode.
+
 
 INTERNALS -- CONE MODE HANDLING
 -------------------------------
-- 
gitgitgadget


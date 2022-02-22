Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F5AC433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiBVASm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbiBVASe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A025583
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q9-20020a1ca709000000b0037fa5c3e5c1so492888wme.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vRLAXu7IUAenlYcmwbE2VS19je7hP/m8yd7jeW4E9uk=;
        b=LrFLb6vlzhgd/lbXKtRf+qHsg3ZPFufuSAwt4rdr8XrpenKxnwqYtntu9BTA5s9K21
         DmY8olly/yzYLm6culf5ifY6K7aJhlI2yTvio2qaXPyH2ZKHqSWCXKHboSvqdfXWwSxh
         Wby3yJZt4eeGc1StMnkPAKa0hKvTweEnHD7CPiGbVQZLpw3CtBVCH4RNxN9EtrAZpI6+
         0zMJHSToXGyoODh6oV0Jm7SV0EI5dQL07m9qOjz1DrSYPpwpnKTl02wA9Qf7jkhAWP4F
         Ir5VvSzGCj14RmxJi704Rg36RaevxRgOkKvHpa1vbh4rW5cp84df2AWShMlrE1JW1nO1
         WV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vRLAXu7IUAenlYcmwbE2VS19je7hP/m8yd7jeW4E9uk=;
        b=nCLRpaf28HV/EuC4hGT/i5URtxdrX9v+6adUUcx15aAGKm5WCdD5GPm2DVFjUDNbGm
         3ePzf80ip30+mfaQPSFG0/qgGDdUynM/f5yj6iz8UbsDUTPE9nQfiPhLjVwROcAwn/aI
         5kn4dJcgxHaPOGIsEqnDVd34ntJ50gFpaWcSGBXspEvy3OTEKYtDZxLjiYah7fVIcDg4
         Ax5ZA51hYAUBAJUKN7a979Y+fHP6LFXtovI1JRc83blgImME1iaCM2ocxigePxYyUb7n
         PKwPxTrKzCBNYfhiO6kIwvJMErbQ0VY33WPaWJSDpgYmuu9kNtD5y4Hql8LG1b+JeQBl
         RE3Q==
X-Gm-Message-State: AOAM5304p7zsv0FLEakACtSXXd/FO2+BU2YaIWiUM+vjZ2aZKKBSusIC
        cdfeI9kk9fzeDjWl0ul7wtBh94DmYcc=
X-Google-Smtp-Source: ABdhPJwBlNNdy1sz7KkQWOC2z1Sj5RBlU/mDCmxjSsHRqm9bhfFZ2EoAQoGI7xnKRPswT51owPgCdg==
X-Received: by 2002:a05:600c:4f08:b0:37b:e830:d231 with SMTP id l8-20020a05600c4f0800b0037be830d231mr1134649wmq.144.1645489088161;
        Mon, 21 Feb 2022 16:18:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25sm724650wmm.15.2022.02.21.16.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:07 -0800 (PST)
Message-Id: <65a0cd527118578c98a6862460caa86ecb49735a.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:57 +0000
Subject: [PATCH v2 08/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is helpful to distinguish between a 'working tree' and a 'worktree'.
A worktree contains a working tree plus additional metadata. This
metadata includes per-worktree refs and worktree-specific config.

This is the fourth of multiple changes to git-worktree.txt, restricted
to the REFS section.

This section previously described "per working tree" refs but they are
now replaced with "per-worktree" refs, which matches the definition in
glossary-content.txt.

The first paragraph of this section was also a bit confusing, so it is
cleaned up to make it easier to understand.

Helped-by: Taylor Blau <m3@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 358325ac073..41c6d503937 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -256,24 +256,23 @@ have two worktrees, at `/abc/def/ghi` and `/abc/def/ggg`, then `ghi` or
 
 REFS
 ----
-In multiple working trees, some refs may be shared between all working
-trees and some refs are local. One example is `HEAD` which is different for each
-working tree. This section is about the sharing rules and how to access
-refs of one working tree from another.
-
-In general, all pseudo refs are per working tree and all refs starting
-with `refs/` are shared. Pseudo refs are ones like `HEAD` which are
-directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are
-exceptions, however: refs inside `refs/bisect` and `refs/worktree` are not
-shared.
-
-Refs that are per working tree can still be accessed from another
-working tree via two special paths, `main-worktree` and `worktrees`. The
-former gives access to per-working tree refs of the main working tree,
-while the latter to all linked working trees.
+When using multiple worktrees, some refs are shared between all worktrees,
+but others are specific to an individual worktree. One example is `HEAD`,
+which is different for each worktree. This section is about the sharing
+rules and how to access refs of one worktree from another.
+
+In general, all pseudo refs are per-worktree and all refs starting with
+`refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
+under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are exceptions,
+however: refs inside `refs/bisect` and `refs/worktree` are not shared.
+
+Refs that are per-worktree can still be accessed from another worktree via
+two special paths, `main-worktree` and `worktrees`. The former gives
+access to per-worktree refs of the main worktree, while the latter to all
+linked worktrees.
 
 For example, `main-worktree/HEAD` or `main-worktree/refs/bisect/good`
-resolve to the same value as the main working tree's `HEAD` and
+resolve to the same value as the main worktree's `HEAD` and
 `refs/bisect/good` respectively. Similarly, `worktrees/foo/HEAD` or
 `worktrees/bar/refs/bisect/bad` are the same as
 `$GIT_COMMON_DIR/worktrees/foo/HEAD` and
-- 
gitgitgadget


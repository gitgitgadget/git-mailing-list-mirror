Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD79C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244371AbiBTRzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242712AbiBTRy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B44527F2
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i14so23240101wrc.10
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y4G3BuvzZ27u99w4kESd3Mky5xmGxr3j5yjlpmhWy70=;
        b=pl8dQvbTmxWjR5x/zkpp7XFPWlntn/xGTIddU7RsYX6DAxMkqFNGFG+gJ/XYCB9xab
         cdjJXPKrXrFdndEsh3iFCm4i2a3MiIXQMFVM6p5fu3dfu8EUWr1ZnkiOZXd5Vr8Hi/CG
         ZLcpBLlGUh9N3IJtoMNT662k8qAgpcuE2mGUpEZrH9AgtXcSbh1MO4B0KwdKKB5nYYZa
         T4b0bRRaIQ/2B7kKmuVAtl6+GP1jRTNbbXWl5weQvkRUQx8v4tKsHHEEGfZCXz7fTT77
         a7c7KBlUJjNgj3FOg7f1Gv5Xq/HXmMuLhkBFEVSvu0yXSk87gdaWpvAP9fFxAUCSd/DY
         iOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y4G3BuvzZ27u99w4kESd3Mky5xmGxr3j5yjlpmhWy70=;
        b=jGBJzbr6jbH8fuyQr5pWEzVifG49eGqObiPTDRGMdsNgcyxfCrAjXlGPOEXLnMaOya
         SSoGezzsfKZlun6wFrpVTyRa3QJd4WhN0uJvXgGmDYQrdXKfb1CU6ZVPSkmu1/ZRy/zZ
         CbufeUFKSVfAQIXNguoq+aPRFGyNveeotQev5+s4G+Oy0+MmwQJS9NruQVA489yhscom
         iL9XwhcXJDYMOJn+IDaVQ+WiVrD95Ts/f3Jz7R2ohYQnV4Y4rvmANl3jxfA4MKshXM2L
         RPN6EMQWcrokYzJKwZPfN+7JE1vpUghN/lIEGFo1UleTX85TXzISFUDnJp/JxrrbkfhV
         f/Yw==
X-Gm-Message-State: AOAM532RfwA2uShaSZnLWL5MjsXBQkBYvoP+7j4QaifihlOl8QDCrxl7
        kgbfs9ZFpkS5l8bGp5naoNk+Q18uljs=
X-Google-Smtp-Source: ABdhPJyY4dEJnTeLoPenX20kdl39j/RhhiGGkXCaek5jF8F4uz/30aHeDqFTOAGiVxgew9gOUkKs5g==
X-Received: by 2002:a05:6000:1e0d:b0:1e4:bb5d:4bd6 with SMTP id bj13-20020a0560001e0d00b001e4bb5d4bd6mr13200812wrb.676.1645379676589;
        Sun, 20 Feb 2022 09:54:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm30341951wrl.62.2022.02.20.09.54.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:35 -0800 (PST)
Message-Id: <e7e579d2995288de13a2328e592e61f2b6dfaf63.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:24 +0000
Subject: [PATCH 08/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
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

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 10021c85e77..54a2c335fd5 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -255,24 +255,23 @@ have two worktrees, at `/abc/def/ghi` and `/abc/def/ggg`, then `ghi` or
 
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
+In multiple worktrees, some refs may be shared between all worktrees and
+some refs are local. One example is `HEAD` which is different for each
+worktree. This section is about the sharing rules and how to access
+refs of one worktree from another.
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


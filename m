Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B4C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiBLUfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiBLUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8E606E7
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i14so20614317wrc.10
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EERqRBajAwrz8tYYP1jAGLo3bEid1AOblU7xP683Vq0=;
        b=SfrPzW/2yXTlOjALvVQj1kUoQPUgJNKIAuBk0olkgbY5OrDHuJeRSHZQsu5twT0rMY
         ei5CTmvhhKX2/ekYAVbdhuoFpc89BvwkUvNE9hGjwtqX3kmaVuyvXevI13XLOLTSgM5S
         YPUC5yBM6XBViUUY0F6DBYbmul9sL4g5tT6uUkIs9iQ5vFQJgGjyRZnd6UKZzLCaHxlF
         eUWlBdHrexlFZyDR9wGinwFnoCzGLBjQovFcfkFrHCOA1js6R6/ak8+5g8gp+kumPFnU
         V+08qf5QEwbEq558A0sQymx+mqxcQqNwhlvrcwNhUPLi60LKSI9480C2LzvA7Dgx5Qez
         aqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EERqRBajAwrz8tYYP1jAGLo3bEid1AOblU7xP683Vq0=;
        b=0cEWb22JvNi2pD57jiPU//msq54TrpEy1LouhQIdJrKbsQ6062+sRrXgjvNQ1lI+Xf
         rQ8MryVXq5KYnBD5Ineaxkq+/BBoFGmCVFy5aLNbx/0RqJpzrfUxmshoCG+fBvzzj7On
         ArV/LBjeQH+FeM8CMg397fHZeGhzpYk1sPoNATCHGfgpl1hsBylZo2KuSID4K4gxmoQH
         BZXaiHJH4jMm0v7J4sKT/1UygDEoCUxq6G9nFqX7tbwIshKwIZHiwVHZLzcjz7JCydmh
         mxqAHiyqC2GBPU36p81oT5P31hEGpr4KLVzx9nxeXeRGK3c74wi4V/DIJlglkQAeCMIJ
         z8hA==
X-Gm-Message-State: AOAM531Mjvi7Diaazb3JF5lF8FjAFEsH8bKpAElFHxhGG1EL0uz5eWbO
        bKKuW9qmuZMy+81zgbkhh+yZYJ1+ovU=
X-Google-Smtp-Source: ABdhPJz54QU6RMxakr0zu6dSHsjpAjxOIIhYheU5IH5XVI9kzdwyiN/XaoTUbULm5pOhg/t3z0FP8g==
X-Received: by 2002:a5d:6111:: with SMTP id v17mr5931059wrt.477.1644698104548;
        Sat, 12 Feb 2022 12:35:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm16608803wrq.112.2022.02.12.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:35:04 -0800 (PST)
Message-Id: <c279236ab655c7cfc851e8555acb355c42c4e5bc.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:53 +0000
Subject: [PATCH v4 12/12] git-merge-tree.txt: add a section on potentional
 usage mistakes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 3f566477dcb..4520bbf020a 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -158,6 +158,52 @@ that they'd have access to if using `git merge`:
   * any messages that would have been printed to stdout (the <Informational
     messages>)
 
+MISTAKES TO AVOID
+-----------------
+
+Do NOT look through the resulting toplevel tree to try to find which
+files conflict; parse the <Conflicted file info> section instead.  Not
+only would parsing an entire tree be horrendously slow in large
+repositories, there are numerous types of conflicts not representable by
+conflict markers (modify/delete, mode conflict, binary file changed on
+both sides, file/directory conflicts, various rename conflict
+permutations, etc.)
+
+Do NOT interpret an empty <Conflicted file info> list as a clean merge;
+check the exit status.  A merge can have conflicts without having
+individual files conflict (there are a few types of directory rename
+conflicts that fall into this category, and others might also be added
+in the future).
+
+Do NOT attempt to guess or make the user guess the conflict types from
+the <Conflicted file info> list.  The information there is insufficient
+to do so.  For example: Rename/rename(1to2) conflicts (both sides
+renamed the same file differently) will result in three different file
+having higher order stages (but each only has one higher order stage),
+with no way (short of the <Informational messages> section) to determine
+which three files are related.  File/directory conflicts also result in
+a file with exactly one higher order stage.
+Possibly-involved-in-directory-rename conflicts (when
+"merge.directoryRenames" is unset or set to "conflicts") also result in
+a file with exactly one higher order stage.  In all cases, the
+<Informational messages> section has the necessary info, though it is
+not designed to be machine parseable.
+
+Do NOT assume all filenames listed in the <Informational messages>
+section had conflicts.  Messages can be included for files that have no
+conflicts, such as "Auto-merging <file>".
+
+AVOID taking the OIDS from the <Conflicted file info> and re-merging
+them to present the conflicts to the user.  This will lose information.
+Instead, look up the version of the file found within the <OID of
+toplevel tree> and show that instead.  In particular, the latter will
+have conflict markers annotated with the original branch/commit being
+merged and, if renames were involved, the original filename.  While you
+could include the original branch/commit in the conflict marker
+annotations when re-merging, the original filename is not available from
+the <Conflicted file info> and thus you would be losing information that
+might help the user resolve the conflict.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget

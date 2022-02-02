Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA158C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiBBHfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiBBHfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:35:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A27C061768
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f17so36592185wrx.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6SVI/G9lzVJsL+RL6mpaPU8pp+ZN1o5bN2bojCFt7TM=;
        b=F8YSo2Dia7SGLichN7oLY2NSAPE/mBCZ1g80iFDMfj3iBVMzp1DF2nQpLTUHltSFju
         Ca/XCtnf0rrfvSnJnCxiT38mPYNquSXpX65XFSk6HETqUv8dSHphDVQlZPvS6mtDqoGd
         pbgUcR3icu20HplAYnbr/Y8AvOYU05t/AvmEsu6pvYthQX6Exo5PTrwvCiqQC1WMljSL
         XwB1pEnDDWGgYKfUnPJMg7CJRFFO7jlNF0zADiJTKKKdDjDrehBhFqyFyQBzO65KF8BP
         YwFsH7mk6L+Agzdw3Tsj8W4QUWsG2Qo9kbDXQ4cyfPQRkrgRzAwxBaIqzmBGMu0YpisG
         Zvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6SVI/G9lzVJsL+RL6mpaPU8pp+ZN1o5bN2bojCFt7TM=;
        b=17e1pWTHmftbSAgrNRxAAFhzIERK3Jfktfzv/z/xKTm0lO1xB8Ditq5zplKUS1reE3
         UcNx50dtDxAcXkvZSutcurO1mQuvso+sDIbUI3lN0996wXLI93+Nv0ytk6R+q/2fAgRr
         87ZE3CWhD7w1wSaZLJWiBWh8o0fCb8Nn3bmMSqr3OSG6GQ215i2vor7RgW2LnAJijORI
         0cwSN54HqnTdt5+NDFpdpxEKbsdMru6m3GUs6Lm9ug+vcGIOYC78s7SHELyduTXkF9rU
         nBWsmH8u1Cs4SDINgFi4yMmUm7UFRz1AYcuOTBI/YHo1SOaYsV0Tdj2zGzbHBtdU82wx
         yYgQ==
X-Gm-Message-State: AOAM533DAriijh/krTPWc/f37peKCeiKLyiyurGcL7qZDCKAhdU+Jpo0
        VQGyc0mDZsgSZNcKfgEf94lP4DVQvuw=
X-Google-Smtp-Source: ABdhPJz+t9qXdqX6FsNhGQqlKdyYysjauTkY6qo+hPAsdamcIlGbGl9u0hTzCLQkdyiHgwy+IXgSeA==
X-Received: by 2002:a5d:5583:: with SMTP id i3mr24826553wrv.411.1643787295636;
        Tue, 01 Feb 2022 23:34:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6sm4055564wmq.26.2022.02.01.23.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:55 -0800 (PST)
Message-Id: <bc8591bbb63acc7b4e7b3550e0e6ea1ed5638635.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:41 +0000
Subject: [PATCH v3 15/15] git-merge-tree.txt: add a section on potentional
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
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
index e6a9ff2768b..6a2ed475106 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -146,6 +146,52 @@ that they'd have access to if using `git merge`:
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

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A290C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353093AbiA2SHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353013AbiA2SH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D930CC061757
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso6391039wms.4
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lLW1tnVjrI8ldV8t2Ig6LB0ohAIWgVUqYCgU8u6eHps=;
        b=qMx8aUz9OSLKalXt80m8bmfRqhcdC2zJCmDonL8Z/PgKK6ciMlQg4Fgzz7TncgYJax
         fuWEyjYAewOTP/3phkIMbOOL+SgRxSVIV75bTIYqJLCqVqIhuAGGbunf5heEufimfqfE
         jN/ckp0K2BrwgBuGB6/52ZTatZ3fwNPyrboEhPMVVnKd0Zv0tJA3ehYTYCOEsz9ToTlE
         pjrB2OKKH9qVgEHYbJGEPq9Ffwz3t9mkC7lrNikkdBdXCImbFcV37D373aJs+VexAB27
         nLHOxghLKfecSA3WW0WkAeER3ODuut26EF/df/iHSD7rqDd5CkpmfbXfXFIEoPnYobhe
         gMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lLW1tnVjrI8ldV8t2Ig6LB0ohAIWgVUqYCgU8u6eHps=;
        b=7ZHe0btFjrNkbwsDL0jAN4pnHmu/VIjof2nNj0wMss2PEi8GYTS56zfQDOOqrnirmB
         fbhelDCdo/XAt/Uxx9BYbqX689niv1pv4GM1L5WsW8qhELBxhInFb24UEuszxpPVdyWi
         p0W3ZAz4eOZkSJF4fhphiwYTpTX2X0SJuNqFzGrTIhUAD3cjXZArKlhx9U2nOT+AiuoB
         QQEVX384Pd15skfy/CmI+K0qG9lFD3O0GplqCjXinmPCAH007e9KHcOiw+GnUcijT+fP
         l93ed+mXDWDVfXnndcoGeauEi3pR1eANtsueHkmiwhcVY6YYYh9eDyRE1sSItSrhfH6s
         XRQw==
X-Gm-Message-State: AOAM531fA6LBZGEm5j5LC4+RcpWJxM3D3RikrBjKV2N0PkuzyQXWAREA
        ibJt0EY0efuAwE4z3vGV91SJf5eyNgk=
X-Google-Smtp-Source: ABdhPJy6JluEPoTDMpGm6Qvvnq1vFgHIq8PTYCTUGc3S59/H+NtkTpmQlPjaTEvMRkhhKklUJish9A==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr8844398wmq.142.1643479645265;
        Sat, 29 Jan 2022 10:07:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm7409535wrq.70.2022.01.29.10.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:24 -0800 (PST)
Message-Id: <e7c63425a0e4070a3bfd0e7614d7447a42e3d598.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:13 +0000
Subject: [PATCH v2 13/13] git-merge-tree.txt: add a section on potentional
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
index d35710c81d5..b97ddc58a7a 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -133,6 +133,52 @@ that they'd have access to if using `git merge`:
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

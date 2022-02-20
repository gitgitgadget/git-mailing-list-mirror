Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C37C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiBTGzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiBTGzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DA36698
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i19so7710229wmq.5
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E8cDhvbbpXfjyR65pEqNCLWAyhmPg/DC2dwO+imBzdg=;
        b=Np0tMTtglbaCwrhgXuYrBaRzqHuNRu/u+RgOHGuZZfgAN+MICxMXqAsQFRfiX8gA0I
         h/KNntv5lkIJtL9gundsF/7Awh89zy4txtpumimu/ozRN1/VkAj+onehWwCwXMYDIn5G
         uSLjK1YsqpYP24XcwW9CIxP0YiurEX4GanpiQ/uh8ywuVjgtTulsaPK9ANpCg30nDVoI
         Q90mIkHIqRrjsR8Onz2lOCgSFI7oRtww0w8y0qURl9zvlRzENAqoZ6KjJmrsRk5miYRa
         x5H/1vChCA1bhtpm2T7sx7bZ4DC5EZSm2WgnAae1HoTrbSR1bFJ3g4LCZgMWT6cS5nmf
         apeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E8cDhvbbpXfjyR65pEqNCLWAyhmPg/DC2dwO+imBzdg=;
        b=uy/X7zhLUdwT2Y6vpMPBGea+t1cHeUEkONWxzRYaVsbIxlUEccunNRAhGWjUfqFCOz
         X4ZQ8LcquiHgZu8BtZ93HW4j878rh6YRVPUJXYaNKyvOq/V7tPNXE5+bJpbdUuGdvZc6
         XraPXtp8J2tjDP/heSEYgaUJn7yBk/v+sSrfr5qkH6tLxil0Y8zpzV/xv5usw14+E3L6
         S07hjZO3A3Sgm7DL6/JxGoZMuh6KADMVRpYmblfW5YjJIXamn2JjjrCkWbRg/+j9Lh27
         5hOEoq+MhDQfvOH65sP1B8gtMVE1n/MQuKNxI208Hy8PxvKJuLvLlN7hw6rBQ5hGMnDm
         7B3g==
X-Gm-Message-State: AOAM531e5dkl1WG7I1fz7Pfwe9ELiTFkecBPNRl5EJ8lWJmUQBNVKP4q
        SCOcFRDCtKpxCs15UTyJQyHgYK7Xv6k=
X-Google-Smtp-Source: ABdhPJzaX6hJ4HpfrlHH0CWV2Hokz7VhDfuSG+0fCJb6g8RzQiaXJUkeh4mEDD8hHbTEWoSgg6pwjg==
X-Received: by 2002:a05:600c:21ce:b0:37c:526:4793 with SMTP id x14-20020a05600c21ce00b0037c05264793mr16902175wmj.120.1645340094060;
        Sat, 19 Feb 2022 22:54:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm12520211wri.6.2022.02.19.22.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:53 -0800 (PST)
Message-Id: <7abf633b6382118a63e983b80186e91dc38eef5f.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:42 +0000
Subject: [PATCH v5 12/12] git-merge-tree.txt: add a section on potentional
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
index d2ff2fa3035..306149fa0e2 100644
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

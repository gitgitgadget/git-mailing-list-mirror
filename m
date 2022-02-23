Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB71CC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbiBWHsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiBWHrf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7033584F
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so1898723wmj.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d5LUpEtsylubslKgfGvKWNGyvk65ye3p0n2yZ7hg8ZI=;
        b=prMEcr9HTwFPJxw1I7i60UcF+IOcOhFDTYhmRT9hQtM7D3/eUYjIGdLKH/VLtinH8C
         NhHmuRmzYgVwA8O/P2sUD4qv65917a5MubieeroAcayywmWxBfHEcrAletTkT54d4cYM
         UyXS+LaOxPPaKsOjCCl+27IcqYV7SRbK67pjlaIi+/dnaeiqpIBBZfluT41/kg3xv6kg
         Zu9y1NQ0D96YkNEZNgMwM2MAVfmR91kWkoS/36kQESPN5jljoNpmcYTIHwR5sbytu+X0
         Dg2IS67WvHvVF4MRwxs3FdGeyofjftUgYbHC/lN5does8umbt5kVK3dcFjftFaaeZtXX
         cSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d5LUpEtsylubslKgfGvKWNGyvk65ye3p0n2yZ7hg8ZI=;
        b=UxOoZx3u3FQ9M589ke6t8Y8zZD9YnUsFGoiuXStVEYFcWAhiX/PtlxZ7Zr/tPgcIV5
         LmyXkZ7HtyDbBfAsiMyut4BEjnRv7sjDj7SAffVwuSpYglOQ38yl+q0l/qKfKGX1mP60
         w63VbtIKmyI2dATdvLcjw7xHJkAL3etXswDiz6R+ObwVZsZIoxfCKzr9Bt2DcqqEwtQ2
         ircynaUTAqsZjy0+9M1vG87+Mb3icbme26Eo6GGy6iJkYBqkAh1l6URDwbiYChIRSVIK
         7xwTLtvxuvv3A9c2f3Bd1J5oVBuf2NgmQ318BUsr7mhakus8WIdkHBeKlwig39ILeBzH
         arig==
X-Gm-Message-State: AOAM532fjQqUQMd6ZUGbV4cccOWQP/DrcGanRo75Jg3hPzQoYSJaLStP
        IAoppzYj6cCMeoZclX8OGvjhf697OOI=
X-Google-Smtp-Source: ABdhPJxE9YhC0HtvWB1oTVO/xzQNhw5sPjP830QIr5ZAnzmnGQYvleNNI9O2i4qqJL0hYgwf2nLQmw==
X-Received: by 2002:a1c:7918:0:b0:37b:fab4:9b1 with SMTP id l24-20020a1c7918000000b0037bfab409b1mr6329103wme.40.1645602426186;
        Tue, 22 Feb 2022 23:47:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm47773753wrx.92.2022.02.22.23.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:47:05 -0800 (PST)
Message-Id: <d58a7c7a9f6495467b5c6844e8557990b1f1df27.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:53 +0000
Subject: [PATCH v6 12/12] git-merge-tree.txt: add a section on potentional
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
index 628324646d3..ee8125810e6 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -156,6 +156,52 @@ with linkgit:git-merge[1]:
   * any messages that would have been printed to stdout (the
     <<IM,Informational messages>>)
 
+MISTAKES TO AVOID
+-----------------
+
+Do NOT look through the resulting toplevel tree to try to find which
+files conflict; parse the <<CFI,Conflicted file info>> section instead.
+Not only would parsing an entire tree be horrendously slow in large
+repositories, there are numerous types of conflicts not representable by
+conflict markers (modify/delete, mode conflict, binary file changed on
+both sides, file/directory conflicts, various rename conflict
+permutations, etc.)
+
+Do NOT interpret an empty <<CFI,Conflicted file info>> list as a clean
+merge; check the exit status.  A merge can have conflicts without having
+individual files conflict (there are a few types of directory rename
+conflicts that fall into this category, and others might also be added
+in the future).
+
+Do NOT attempt to guess or make the user guess the conflict types from
+the <<CFI,Conflicted file info>> list.  The information there is
+insufficient to do so.  For example: Rename/rename(1to2) conflicts (both
+sides renamed the same file differently) will result in three different
+file having higher order stages (but each only has one higher order
+stage), with no way (short of the <<IM,Informational messages>> section)
+to determine which three files are related.  File/directory conflicts
+also result in a file with exactly one higher order stage.
+Possibly-involved-in-directory-rename conflicts (when
+"merge.directoryRenames" is unset or set to "conflicts") also result in
+a file with exactly one higher order stage.  In all cases, the
+<<IM,Informational messages>> section has the necessary info, though it
+is not designed to be machine parseable.
+
+Do NOT assume all filenames listed in the <<IM,Informational messages>>
+section had conflicts.  Messages can be included for files that have no
+conflicts, such as "Auto-merging <file>".
+
+AVOID taking the OIDS from the <<CFI,Conflicted file info>> and
+re-merging them to present the conflicts to the user.  This will lose
+information.  Instead, look up the version of the file found within the
+<<OIDTLT,OID of toplevel tree>> and show that instead.  In particular,
+the latter will have conflict markers annotated with the original
+branch/commit being merged and, if renames were involved, the original
+filename.  While you could include the original branch/commit in the
+conflict marker annotations when re-merging, the original filename is
+not available from the <<CFI,Conflicted file info>> and thus you would
+be losing information that might help the user resolve the conflict.
+
 [[DEPMERGE]]
 DEPRECATED DESCRIPTION
 ----------------------
-- 
gitgitgadget

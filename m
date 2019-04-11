Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC8020248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDKNON (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:14:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34885 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDKNOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:14:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so3459955pfh.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1skPf+qTIlrbxpo9z26HdduQnOIHtFqiFkeTFm19bk=;
        b=pgdtmsOqNM9URh0Zn0YxM8O8t2MS458cajlc/kroDKXI/38XbBXY621sV2Etf5zPZS
         3uHmsu5WtnFwbx9etDEqaW/EOeuq7I02SpfLdGZH6IhClXavAta5Av7MGm5X3cyS86B0
         LUbTDzKNw2XbSF+PhcA3i7f3my9oKmNfYM20yqAKpUfRQxn5dn2GwfP1zBe8iLgnLmCR
         0Csn5OFFgiwu4VxzsMB53ghZB4VNt9or0EQ6IAXow6DLy7OUNL4WvhvFaNrtLiISfuEq
         Pljie4RQpiqCWPGS6eY9+Oc7jEqVB1gebk7GcEztf5sRf4QHCAnlRQbDqZn5VCLVPZKk
         DXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1skPf+qTIlrbxpo9z26HdduQnOIHtFqiFkeTFm19bk=;
        b=OgXkglLhvrDYQdgDJ+OT+VUdFNGPav+ULszzf/NbDYEsXNCMBvjahCfriUe6x1xMNJ
         3CFUGy54HWiv6HTjeM8ymx1d8fp5wEsdy5C5TPxxDnFWcgMtAG0gsJva9UDg03uSHnbV
         syEBH0q7O4PcewzqVelh2bjQ6zoYW60s3KiZgzkBnSXLrmh+g6HN+udRyFh/7EW2D0gh
         iE1g3BrD6DSZoDiK/ybhFKmHQXp7lNX/tvmn6fvWYDC6V0QTe2UjJtceU46Jm+rTmgLV
         drgA4ZWt+6VbajVX7kEzyaO7oYENKvu3uM2bdJe7zp0jJjm0P9YKCpWLT1lJuM2vCcfU
         cp6Q==
X-Gm-Message-State: APjAAAWEKJP6Dwabzgiq+m4xPOp+j24pXJR9YdZrLoRnLSuS7LM/TPMk
        TZtVGZ0Ed6O6Z67oRppLhyM=
X-Google-Smtp-Source: APXvYqy0Vtcbv9KlSVuU3AO+38FsebzXXJPCc2U+cm+cGlmWKDGgxvGvoCW5R8av16pj+GXWmCvs5Q==
X-Received: by 2002:a65:420b:: with SMTP id c11mr47177503pgq.24.1554988452021;
        Thu, 11 Apr 2019 06:14:12 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id v188sm62964222pgb.7.2019.04.11.06.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:14:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:14:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 16/16] help: move git-diff and git-reset to different groups
Date:   Thu, 11 Apr 2019 20:12:18 +0700
Message-Id: <20190411131218.19195-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The third column in command-list.txt determines what group a common
command is printed in 'git help'.

"git reset" is currently in the "work on the current change (see also:
git help everyday)" group. While it's true that "git reset" can
manipulate the index and can be in this group, its unique
functionality is resetting HEAD, which should be the "grow, mark,
tweak history" group.

Moving it there will also avoid the confusion because both 'restore'
and 'reset' are in the same group, next to each other.

While looking at the 'group, mark, tweak history', I realize "git
diff" should not be there. All the commands in this group is about
_changing_ the commit history while "git diff" is a read-only
operation. It fits better in the "examine the history and state" group
(especially when "git status", its close friend, is already there).

This is what we have after the reorganization:

    work on the current change (see also: git help everyday)
       add       Add file contents to the index
       mv        Move or rename a file, a directory, or a symlink
       restore   Restore working tree files
       rm        Remove files from the working tree and from the index

    examine the history and state (see also: git help revisions)
       bisect    Use binary search to find the commit that introduced a bug
       diff      Show changes between commits, commit and working tree, etc
       grep      Print lines matching a pattern
       log       Show commit logs
       show      Show various types of objects
       status    Show the working tree status

    grow, mark and tweak your common history
       branch    List, create, or delete branches
       commit    Record changes to the repository
       merge     Join two or more development histories together
       rebase    Reapply commits on top of another base tip
       reset     Reset current HEAD to the specified state
       switch    Switch branches
       tag       Create, list, delete or verify a tag object signed with GPG

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index cf8dccb439..a9ac72bef4 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -81,7 +81,7 @@ git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
-git-diff                                mainporcelain           history
+git-diff                                mainporcelain           info
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
@@ -150,7 +150,7 @@ git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain           worktree
+git-reset                               mainporcelain           history
 git-restore                             mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
-- 
2.21.0.682.g30d2204636


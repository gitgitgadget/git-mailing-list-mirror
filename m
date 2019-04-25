Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD6E1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfDYJr2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:47:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfDYJr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:47:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so10872473pfm.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yO06+4pP23lPE3wKIqaNU40BXgHPiUJJpthw/aAf8o=;
        b=NElwNsBYempfpyFPrzfGUfJOyA5B8CVEKDkF1a1lwEzkbrXmzdAbWWfrayc4n3AXvq
         Y0jlH3S2VVMgAQ+puuenEZtJ8Pr6krDslJXSKejtgYBHojf54e6o0kG4ehqPGLMMFl4g
         4fM0Vi7yiYHI096HNFwlqqZO0a1fui27ToovfbDeX40n+Pj06SCrgQdj8177kcP+SRiH
         2gXZhSIhxOO8sN2QA/JglNpnLnVg5mEVVcxk7hZgMvcBLbCamj8zcAa+enOT5XB2hbZi
         E9UUyU1X57BPTpmDQvUnloCS0rjsQ7WRg+HDzfRxh2UnqUvhWzbxBc/cipyU9GgB0snh
         MVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yO06+4pP23lPE3wKIqaNU40BXgHPiUJJpthw/aAf8o=;
        b=O0rj+37SYaPJJa1iE+qPIwGYhrt4YwJfnQQ59TsCV0SLklRPOH8OBR+E8O773LTqv+
         BFK12J9dB/eD1o1dzfd467xE1j0+lkkFcuBgRnGOa2h28X1NRwH7tJUDPN+mLvcrB0Ci
         y9c7I9eiaN5pMoviikU/L6UzPebUajtq6wlmJg7tEuKDFSxIN+mbJQuOydpHxS10prdY
         GKHAD2XzBJdQqmEcaSJeZ+7ABwkXHyPlJanH5bf9Hz47AyjhdGt9Vtaj0Z2cHQCCeLyy
         sZK56qVVR1rurGbB5tuhfaqWJ+X7GggfaQbqJrRm576lTj66bdwx3dGT64KG0QL+51lI
         HwcQ==
X-Gm-Message-State: APjAAAXWkQPIZLns2hjqt8TD2uA0dMQOmrOtoHJYyPEiVyg8J7yOVVQ8
        nQ2OKfonQc2JUIf46SRJh6Bu76sD
X-Google-Smtp-Source: APXvYqyDO7JYvJx9nMR3gCe62VV9UFrcBWm3FT5F6xFO+XWGAwbZxxjjd0EUjkIgXfC8kt1jyw6e1A==
X-Received: by 2002:a63:5953:: with SMTP id j19mr35842516pgm.260.1556185647542;
        Thu, 25 Apr 2019 02:47:27 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id a18sm8401058pfg.177.2019.04.25.02.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:47:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:47:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 15/16] help: move git-diff and git-reset to different groups
Date:   Thu, 25 Apr 2019 16:45:59 +0700
Message-Id: <20190425094600.15673-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
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
2.21.0.854.ge34a79f761


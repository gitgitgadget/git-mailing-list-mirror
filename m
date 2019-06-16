Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19FAF1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 13:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfFPNZS (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 09:25:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43677 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfFPNZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 09:25:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so7024631wru.10
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=NMFwcZ8FPFlmd4B21QLY9f5In3muKf62bE31Smazj3Q=;
        b=f1JxaBDpjeUftrjQjxSgHKZUsmfo5+ImrI9Y/VmoL0DWcvRzq6RTB3+kYdoS19qASz
         QTMbEMH5mMFYSb2JnzqACGSePAGliweSPxi5O7NHuuPZoWBJBSTYB2h+ZN0Gwgwjoqxb
         ye1dZYH63qlEV2lc2R+sMbQM71Oro9RB54CzJ8vdnbi15eN0Q9EfIdaDObKocP7osbIk
         nx7fLANXj5qtNfkkggJGZa7IcP+vI4jsoNvyfupx5jYsWWKvsGyVKXrh+yvNfDvy9q7L
         kMZE5tOLJ901Zvmbo6G0F/4vku2oTd3HBeyYktCYMWq7MpE+OD57wW0bwPqH7oI9R/Yk
         xO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=NMFwcZ8FPFlmd4B21QLY9f5In3muKf62bE31Smazj3Q=;
        b=oU7X8oT1JIN7orhOeleCLpcO9ivbe8VIPOyEacgDCPLaM/VNmo9YZhEyRovVbp6I4L
         zvRq4kHaBPxdZbIa9g7cib7OhFRqZHf1kjRJfINHwcKGcKkO/5kfPXQvsmd2tmz/tomM
         0u6CqIWRy8/Dx4OIthV2u4HkYbZsqSBCjBG+dckRoCBUtj+fNyFUFh/qKvEdmhqT9UiV
         +gu/etlWLvltZHuABJn6E7ptQP1wBgo3r3kPWYux+VD/XTx7Uf9fZpPYAgj1KpzEWJMP
         6dzov6a1UDp7/ZWlf9AE3lWAJkobdeEqkBsMMI1430d7T7YrASYsLZR6VpanaTb84sJT
         OjeA==
X-Gm-Message-State: APjAAAUBXPRtV/ppBErHTAZK+yu6v1/ffwKiydbU2YJaMwy8/MHv0msv
        2U+OBircQyOKpJgBBd1XkkHm2Smj
X-Google-Smtp-Source: APXvYqyFwkRkEoKx2Hg3srcSLdIEcxmNjaoQNSjTnX/4yUHN6L+jiAp4T5R0IZLBydNzLk79iKc1mQ==
X-Received: by 2002:adf:df91:: with SMTP id z17mr66805139wrl.336.1560691516020;
        Sun, 16 Jun 2019 06:25:16 -0700 (PDT)
Received: from localhost.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id d5sm5998741wrc.17.2019.06.16.06.25.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 06:25:15 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] show --continue/skip etc. consistently in synopsis
Date:   Sun, 16 Jun 2019 14:24:57 +0100
Message-Id: <20190616132457.19413-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.22.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The synopsis for am shows the command mode options as
    (--continue | --skip | --abort | --quit)
They are on a single line and in parenthesis as they are not
optional. Fix the merge and rebase docs to match this style.
---
This patch is based on top of nd/merge-quit.
The docs for cherry-pick/revert are updated to this style by
https://public-inbox.org/git/20190616082040.9440-1-rohit.ashiwal265@gmail.com/T/#u

Documentation/git-merge.txt  | 3 +--
 Documentation/git-rebase.txt | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b7d581fc76..07ca9fb78c 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -13,8 +13,7 @@ SYNOPSIS
 	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
-'git merge' --abort
-'git merge' --continue
+'git merge' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5629ba4c5d..a67d40596a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
+'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
 
 DESCRIPTION
 -----------
-- 
2.22.0


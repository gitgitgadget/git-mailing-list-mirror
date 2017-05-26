Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731081FA14
	for <e@80x24.org>; Fri, 26 May 2017 17:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbdEZRhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 13:37:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34247 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdEZRhK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 13:37:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so5134328wmf.1
        for <git@vger.kernel.org>; Fri, 26 May 2017 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FGcXhUke07q8x4hOwyBU8LlEGpN29bnXgQeJy8jwvow=;
        b=UINb5fVmDMn4IPc+NyO73bid2ZTTfQRbk+Y5ocL07NowIx1ytwYVNPiDJRcL5DCHjg
         4ewpQEvJHMypXNrM8zexrYCvq1tSP2Zt5vFwR7J7hJX5kUWAA2M72Yau/FagxPqcQgD2
         IrHSoQGTfvEiAsJATesQpPwgsA5xMiITCnyHOEAo/fqNB244EkkVvHlHw73wpNODJbom
         Rfn+5je5txIUs8NXp2rsHEdnCdaATj/mHick6qGMrw8w74GMNvgVtYQ1mLm+e3bXE5xw
         vD5z916ZfGiDh464KZCqrtXkq4lKxHtqa26tPlEKVHVXWD8+9YgvEekChtiXAMouwx9J
         k6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FGcXhUke07q8x4hOwyBU8LlEGpN29bnXgQeJy8jwvow=;
        b=nHC06lGe7lVXixVmTo400kiKl3NBGhRsd8F4YVg2c9EfUCNowdIAkJthP1egxwpoVU
         lBI7P7J2fSmBH6lxeQbRZtEAgb+LzpkP2Z75LN/3SPwZ2KrWPQMgDoGKyfDD6453uVQX
         c82mk//5CrngtJ+zyB4fYqUW/wKI+fnZQc9Gu/6Ds5V7gfuX5Sxstq5YzB3HRy78/K3c
         JXjEGeoLWprjmzEZ+LN9cw9Kk13gU0QqgYC1r8WVUZ5eOHETTBpfS31psISSHN4N8EpB
         RzFXpMpDAsMOZysLAfj6UqKQkvOmCX3MpaS9ck4q+iVnYzwxFjluk6hXoul8gjTnv8/p
         7iIQ==
X-Gm-Message-State: AODbwcDqQZCyZ+deFDNn+BkmOtGljr+f+ZXYTxFvw2UMUF640jN0Zmnd
        1XAYnVWtzScNPZOk
X-Received: by 10.28.57.6 with SMTP id g6mr14971535wma.63.1495820229257;
        Fri, 26 May 2017 10:37:09 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3403:a000:f033:4aff:d081:da9b])
        by smtp.gmail.com with ESMTPSA id b43sm1823020wra.6.2017.05.26.10.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 May 2017 10:37:07 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: filter-branch does not require re-export of vars
Date:   Fri, 26 May 2017 19:36:54 +0200
Message-Id: <20170526173654.4238-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `set_ident` in `filter-branch` exported the variables
GIT_(AUTHOR|COMMITTER)_(NAME|EMAIL|DATE) at least since 6f6826c52b in 2007.
Therefore the filter scripts don't need to re-eport them again.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-filter-branch.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 6e4bb0220..7b695dbb7 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -86,8 +86,7 @@ OPTIONS
 	This filter may be used if you only need to modify the environment
 	in which the commit will be performed.  Specifically, you might
 	want to rewrite the author/committer name/email/time environment
-	variables (see linkgit:git-commit-tree[1] for details).  Do not forget
-	to re-export the variables.
+	variables (see linkgit:git-commit-tree[1] for details).
 
 --tree-filter <command>::
 	This is the filter for rewriting the tree and its contents.
@@ -340,12 +339,10 @@ git filter-branch --env-filter '
 	if test "$GIT_AUTHOR_EMAIL" = "root@localhost"
 	then
 		GIT_AUTHOR_EMAIL=john@example.com
-		export GIT_AUTHOR_EMAIL
 	fi
 	if test "$GIT_COMMITTER_EMAIL" = "root@localhost"
 	then
 		GIT_COMMITTER_EMAIL=john@example.com
-		export GIT_COMMITTER_EMAIL
 	fi
 ' -- --all
 --------------------------------------------------------
-- 
2.13.0


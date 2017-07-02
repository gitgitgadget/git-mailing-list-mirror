Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1806202AB
	for <e@80x24.org>; Sun,  2 Jul 2017 11:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbdGBL14 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jul 2017 07:27:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34177 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdGBL14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2017 07:27:56 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so20162544pge.1
        for <git@vger.kernel.org>; Sun, 02 Jul 2017 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cH5aF0kOp3kWcCdKBVyI50xHGie/jELoVz3L4kTyBjM=;
        b=O2myTTXFXNiLkoG8lc5tljel+MOTLQsPHXnA8F6jZtuZ1Ip5gwJfl0RZPXy2TFiLZh
         XgsRQNA6lkq1njd3r/iaWrYaNWFTRnOAOw2WXrJqByZjw1C4TVX88/k8DXpno0HVGRwD
         tVQ855Y/2dAoOGWmUu95kNjEKD4F8LA8drj3nEEbwINVUWRa3NRqw9wvJVFJb0SijMAR
         xozAd4h6HSfRxtqCLNJU+9pP/7f0KW1Y9pNvI9lmPLZwqu1qmBR226FUtvPI72uB9Zg8
         0clqJdRU2SKolgV6I6JXBedeoZS8INJ8P7vTIpi/kxafgM0wYdQ9FOAWknOrP3iUpInK
         WnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cH5aF0kOp3kWcCdKBVyI50xHGie/jELoVz3L4kTyBjM=;
        b=mKWEg2mLsrnZpJIdcBdSbOePjpXTsJzk/uNJgL1YnilnrdKgzFpuGpiRnrtYx0rrgi
         SxGXtW9NQucVEFuRBYtQkY/OzhEEbcf4Nzjo96aU+JrX/60UnYoYZFaJOLBS1JXsHWtM
         CNhaqlOm4VXWxAaCW/yP0gGhOHuPQ1ZYR4R4UUsUxoyzIxUmT9r6iOWvVGMULRimVyqo
         AAGGRFBQ9f4zYiKY4MhNKH4aYe4oHrVSN7kewoh8OQJoV1bAQHUmhEnJq1SWgUF9E42P
         y2eG/Um6+uXdmS50LA+xB5mAXJMG2/tSFgaTDsvTfGQpCDiEH8a15Oxn0L7YKo6BlNwA
         mcXg==
X-Gm-Message-State: AIVw111wKqAIs3aHk4VyjUEZM6uJSU4n1d/Sr2hPfWBu2l1BbyRGguii
        8Cu9UmZWpE/iIGkNQm21aw==
X-Received: by 10.99.186.83 with SMTP id l19mr4848117pgu.44.1498994875382;
        Sun, 02 Jul 2017 04:27:55 -0700 (PDT)
Received: from localhost.localdomain ([42.111.160.182])
        by smtp.gmail.com with ESMTPSA id z86sm31837690pfl.40.2017.07.02.04.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jul 2017 04:27:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH/RFC] hooks: replace irrelevant hook sample
Date:   Sun,  2 Jul 2017 16:57:28 +0530
Message-Id: <20170702112728.15757-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1498994345.1667.5.camel@gmail.com>
References: <1498994345.1667.5.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pre-commit-msg hook sample has an example that comments
the "Conflicts:" part of the merge commmit. It isn't relevant
anymore as it's done by default since 261f315b ("merge & sequencer:
turn "Conflicts:" hint into a comment", 2014-08-28).

Add an alternative example that replaces it to ensure there's
atleast one example that could be used just by enabling the hook.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 This patch assumes that a previous patch that touched the commit
 template [1] has been appled. Else it could remove the information
 about the branch from the comments.

 [1]:http://public-inbox.org/git/%3C20170630121221.3327-2-kaarticsivaraam91196@gmail.com%3E/raw
 
 templates/hooks--prepare-commit-msg.sample | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..03783b3de 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,8 +9,9 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes three examples.  The first comments out the
-# "Conflicts:" part of a merge commit.
+# This hook includes three examples.  The first removes the
+# comment lines that start with "# Please enter the" and
+# "# with" from the commit message.
 #
 # The second includes the output of "git diff --name-status -r"
 # into the message, just before the "git status" output.  It is
@@ -20,17 +21,17 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2,$3" in
-  merge,)
-    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
+sed -i '/# Please enter the .*/d' "$1"
+sed -i '/# with .*/d' "$1"
 
+# case "$2,$3" in
 # ,|template,)
 #   @PERL_PATH@ -i.bak -pe '
 #      print "\n" . `git diff --cached --name-status -r`
 #	 if /^#/ && $first++ == 0' "$1" ;;
-
-  *) ;;
-esac
+#
+#  *) ;;
+# esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
-- 
2.11.0


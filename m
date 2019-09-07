Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC2B1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404416AbfIGON0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46289 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbfIGONZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so7230667lfc.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlclNzxkxAlmmQptdiIu+G7fa5HeYegZeaLjXk1IMVw=;
        b=sLrVdGChuop+42Qmqea35G6rYgBV8bFh9GL/DDEJE+tzPNgP3el/1YGAKhEdB7wwsf
         HSZ4SPXkXsQiHfE1UmBhF5g4AtP1tZA/ijIMKWPJqshNU4jTVwfrlP1ZenvP9VdNqu7F
         tWwMZSkZUonbacGdwbZZvQWOK5AEukQegD+EeHxQjpslmlHKQm8XGl7jrMo/TGOKDyzD
         wPdxNbHrLXYTefaiwRbyFl0yxXrZ9DimBP4rqGz/FesIaQP4uz1i1fs7slwpQOQhVFhM
         olfWEtX67HKQzce08pRtSXV1/HWFiDwtWc1AXR6XUQ2uRR4R61/2Vbxr/TsiQaCI48mx
         wCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlclNzxkxAlmmQptdiIu+G7fa5HeYegZeaLjXk1IMVw=;
        b=piTHJJw96hYgtts3MQDnrkfIDD2v01Gs3AXzfMk7H4axm6DV7AOr+JuvmwOWNfztTi
         mnPy4mWoyK3NGxWWSySrytzpvtlmIvN97lM2flEfQaJuELgRBEaGKdNhlNMFElkS20wK
         UFlJwKmn6h3zBBqNE1hzuWVgouYMkBqSmjmG7uThFmFz7eT7R7iHaIX24Mf7wwYD6BZo
         M+em9oZRNy1cDgOebZ4WU+8JcXv3SqmUZGxsUDcebS47zds0j4+fvCM7Vu8KsFuUUCJ/
         /xiX8rmPvG0XJ2XHfyJE63BIsvhM9gY9fCanZvoIvqj3Qev8PpMnPDP5B7bAtROlmdeh
         +EtA==
X-Gm-Message-State: APjAAAVWDu6W/R/u3IfpK5obhZ0p/mjPJQzvdUqlBl9WJPFimn3HEakQ
        qP6yHgsr+6p2tDmt59c+Tbj/YKzf
X-Google-Smtp-Source: APXvYqztAVr93mMijt8ryrx4pj9F4HIvTulhMY+l28kSalDlQnW/UN4TpkaatSYthlBD27WspW0SeQ==
X-Received: by 2002:a19:428f:: with SMTP id p137mr10246789lfa.149.1567865603510;
        Sat, 07 Sep 2019 07:13:23 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:22 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 6/7] git-merge-index.txt: wrap shell listing in "----"
Date:   Sat,  7 Sep 2019 16:12:52 +0200
Message-Id: <e948f00338e9a9f849d23fe7a88962cda34700fa.1567707999.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567707999.git.martin.agren@gmail.com>
References: <cover.1567707999.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The example output of `git merge-index` has been enriched by a second
"column" of helpful comments. When Asciidoctor renders this, the cells
in that second column aren't aligned.

Fix this by marking the example shell session as a code listing by
wrapping it in "----". Also drop some of the horizontal space between
the two columns so that we fit into 80 columns. This changes the
rendering with both AsciiDoc and Asciidoctor. They now render this
identically, nicely aligned, and within 80 columns.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-merge-index.txt | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 02676fb391..2ab84a91e5 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -54,20 +54,24 @@ original is first. But the argument order to the 3-way merge program
 
 Examples:
 
-  torvalds@ppc970:~/merge-test> git merge-index cat MM
-  This is MM from the original tree.			# original
-  This is modified MM in the branch A.			# merge1
-  This is modified MM in the branch B.			# merge2
-  This is modified MM in the branch B.			# current contents
+----
+torvalds@ppc970:~/merge-test> git merge-index cat MM
+This is MM from the original tree.		# original
+This is modified MM in the branch A.		# merge1
+This is modified MM in the branch B.		# merge2
+This is modified MM in the branch B.		# current contents
+----
 
 or
 
-  torvalds@ppc970:~/merge-test> git merge-index cat AA MM
-  cat: : No such file or directory
-  This is added AA in the branch A.
-  This is added AA in the branch B.
-  This is added AA in the branch B.
-  fatal: merge program failed
+----
+torvalds@ppc970:~/merge-test> git merge-index cat AA MM
+cat: : No such file or directory
+This is added AA in the branch A.
+This is added AA in the branch B.
+This is added AA in the branch B.
+fatal: merge program failed
+----
 
 where the latter example shows how 'git merge-index' will stop trying to
 merge once anything has returned an error (i.e., `cat` returned an error
-- 
2.23.0


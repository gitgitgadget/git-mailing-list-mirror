Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B288920372
	for <e@80x24.org>; Mon,  9 Oct 2017 22:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbdJIWGX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 18:06:23 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:48146 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdJIWGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 18:06:22 -0400
Received: by mail-pf0-f173.google.com with SMTP id b79so2826152pfk.5
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CSrSxCyDBTabyBeJH5Rghp4SltdVuAR5xzJoqbD3IVY=;
        b=PQECD28CVqsvrCjnPh5B9uAPqPq6jrli65sbDY2aaddrQr40mkSMGqA+aNTNJHY7G7
         mMOZ6vuXQ852LKIxE9ViWt4QBdM9zgV5270ZfhOWNgii2YmH4GcPkMBdG0aEY0PGXiON
         8Nnz2l+7l7RGSuMt3cSZLl0Y7+7svJCGESsFHYEBfUSDvZb1dmRCi3pTq0AHmAhzic0k
         WZZU7VSkYFUG4c/gqACJqq32e7rE2vtrnfrHIYVf8v7hMs8TRuJIBpuob+xX0uOrcZ0r
         GUeuM8d7EKdlg0ljoFNDLx3zF4HRaYZxEaVGnDOb820UXvXUlw4u4txHZ7C3z9ScNZxP
         QJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CSrSxCyDBTabyBeJH5Rghp4SltdVuAR5xzJoqbD3IVY=;
        b=AwlQOKVr6o3kyt+54be2nND+JzCBIIla4hpLvyiatECWOpCmJv6yMTmJk2utmK4lEJ
         ifg8GOVMtYETStGV5LiTe9DhewclGqfAEIi6hlB4pVPONBD1X1T2A2Dxw46hwkYoBged
         B7g7R0Ld3XEncig6S5QPWIjIgsLgfJodJZ85WDEVlQkOeDv6KXM7K4syc/T7JUuaN/47
         KBVjmP83Ssdy86x5DyiBEKdBhsU+Grgzpz/waU9jKoUj0PWgM92JkCamozlDEpgu8sxD
         ikeAkHy7Yfncjx5oBp+kc4Jlr5q6UxHVQwSoRVoMYh6IMg8UzrbIXeXo8aOyIWZIW6oG
         +sIw==
X-Gm-Message-State: AMCzsaWAlEdqGTfFKmivUwqIRKJ/tJ7KmUYfi/FvXKn/Zqcq73bw0j1a
        RK8JB6lG7IP3mi6BjoRwzjB1tCPD89M=
X-Google-Smtp-Source: AOwi7QAmki9hoCJmBKw2olk9Jui+kNlAwl2MdpaobUDVvpzbcQh6XizepK8OIqDfJj+3Mp+cGozxsg==
X-Received: by 10.84.211.79 with SMTP id b73mr10166870pli.214.1507586781961;
        Mon, 09 Oct 2017 15:06:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:e1ca:db03:c662:1b81])
        by smtp.gmail.com with ESMTPSA id l6sm17227144pfc.112.2017.10.09.15.06.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 15:06:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] submodule: spell out API of submodule_move_head
Date:   Mon,  9 Oct 2017 15:06:15 -0700
Message-Id: <20171009220615.27541-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way users of this function do not need to read the implementation to
know what it will do.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c |  5 -----
 submodule.h | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index c1edc91a13..d12e4ea96c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1507,11 +1507,6 @@ static void submodule_reset_index(const char *path)
 		die("could not reset submodule index");
 }
 
-/**
- * Moves a submodule at a given path from a given head to another new head.
- * For edge cases (a submodule coming into existence or removing a submodule)
- * pass NULL for old or new respectively.
- */
 int submodule_move_head(const char *path,
 			 const char *old,
 			 const char *new,
diff --git a/submodule.h b/submodule.h
index f0da0277a4..3c15977be9 100644
--- a/submodule.h
+++ b/submodule.h
@@ -111,6 +111,24 @@ extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git
  */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
+/**
+ * Move the HEAD and content of the active submodule at 'path' from object id
+ * 'old' to 'new'.
+ *
+ * Updates the submodule at 'path' and files in its work tree to commit
+ * 'new'. The commit previously pointed to by the submodule is named by
+ * 'old'. This updates the submodule's HEAD, index, and work tree but
+ * does not touch its gitlink entry in the superproject.
+ *
+ * If the submodule did not previously exist, then 'old' should be NULL.
+ * Similarly, if the submodule is to be removed, 'new' should be NULL.
+ *
+ * If updating the submodule would cause local changes to be overwritten,
+ * then instead of updating the submodule, this function prints an error
+ * message and returns -1.
+ *
+ * If the submodule is not active, this does nothing and returns 0.
+ */
 #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
 extern int submodule_move_head(const char *path,
-- 
2.14.0.rc0.3.g6c2e499285


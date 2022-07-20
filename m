Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82449C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 06:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiGTGfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 02:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiGTGfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 02:35:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E67BFC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 23:35:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso632157wms.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tEknypPeKvW6eZJLFEp9ec2am1QlCaZFFqGrheBS+i4=;
        b=J1APO1TeFKEgtMjuFZKFZmxbTB7lqBXmdhCg/jXTUAN/u1DzlJgTbngCQT+pVtWYVZ
         7wjtzgf8y5MH+APGvdRdlXWaAhQyRPP9J00vYHNL0WLKBUrLB/BgQH/0sqYt+gKDSGuz
         k5yMU/ANl6puuX6FzI37vULSlNpA9q1l4x/0FvyAHLVFJg3Jz/jwhbzHAeDsy2GYwl4R
         iFCWSUMgOybpVbn6Ivu32LcYof5XbLRdZ0F9Dvkc9KvX6VGLvGSjdXr5FxHkKxM+BQu9
         0Pyb4z+gT1R2euBflgoAqZ6XYtkyyPh2Njc4BaQGUYMYw5V1jWS7DKnfpJ89GRr1gaff
         8qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tEknypPeKvW6eZJLFEp9ec2am1QlCaZFFqGrheBS+i4=;
        b=GoLHgsKZ9VqkblaFZexUi0TwQfGb9HJoSBXUvhVGi4rRVP1Cno3SLOjjyhbWG7BAF7
         E3Zn84kPLbgopQeKS39+xVpQUGbXUtTM5fWXWkMipblUlXFmYb3FlDSS0QSBh5UXt63Y
         G5TIDN8SrJ5nRMBvbK2fC8/nmihso7LnCzNJBnsg0xM2S/3HXMIleFwxxiLGlS5Yy71s
         RV6y27eE0+u8Z2St279ie5+Lndyy7EPH1B3SibcxhfwnAXE9EjFHnh+KcBxQHMj0Kx5x
         034BTJnsiK54XbmIhS/UyWg37j/OMH3AvYdE8/66tAP3sPXhGFXjQM5r9Bo5KZrkBSoW
         635Q==
X-Gm-Message-State: AJIora9OIR8YBP+qMqO94/Yd9l7GHtqkncBMRHVOmSxqJfDBlcYBMSVf
        s1PavwNGb5MQQjRBO2f/XGHKBViQvJ4=
X-Google-Smtp-Source: AGRyM1sZaHj6Jlk+gnV8aIUsJgSTWC+55DX9569ljhyRLe198aEy6Q7saGHNMrJG+JU2QUSZVuwTew==
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id r7-20020a05600c35c700b003a32612f823mr2291721wmq.33.1658298903662;
        Tue, 19 Jul 2022 23:35:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm6371858wms.3.2022.07.19.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 23:35:03 -0700 (PDT)
Message-Id: <69c9fd5fbec859c2cced95930ac4d427a09aee90.1658298900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 06:34:59 +0000
Subject: [PATCH 2/2] git-p4: fix error handling in P4Unshelve.renameBranch()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>,
        Moritz Baumann <moritz.baumann@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Moritz Baumann <moritz.baumann@sap.com>

The error handling code referenced a variable that does not exist.
Also, the condition could never evaluate to True.

Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
---
 git-p4.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1de3d6f1cd4..8f20d15f272 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4369,19 +4369,16 @@ class P4Unshelve(Command):
     def renameBranch(self, branch_name):
         """Rename the existing branch to branch_name.N ."""
 
-        found = True
         for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
                 # Copy ref to backup
                 gitUpdateRef(backup_branch_name, branch_name)
                 gitDeleteRef(branch_name)
-                found = True
                 print("renamed old unshelve branch to {0}".format(backup_branch_name))
                 break
-
-        if not found:
-            sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))
+        else:
+            sys.exit("gave up trying to rename existing branch {0}".format(branch_name))
 
     def findLastP4Revision(self, starting_point):
         """Look back from starting_point for the first commit created by git-p4
-- 
gitgitgadget

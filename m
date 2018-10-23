Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64471F453
	for <e@80x24.org>; Tue, 23 Oct 2018 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeJXAzX (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 20:55:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50876 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXAzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 20:55:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so2441976wmg.0
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3p6q9ginm/ERGCQ4tel00uPMDr5VkhAFfmgzz9Xg2c8=;
        b=dOHww2rAejQxWClcT92aNLW76bQRWVJ0G260BD9nz46f1w+sLdX87jOlnbZ6AottZx
         6iuhS2Gz+Ft+LGKJ1re9gGhqdsOWHG9nL6fNsfjLa4cFLhzpnP+HtdNup8J5RVi9035h
         yXZhLeW6EmhOhWZ8NEYG393GQsqEpxl05CQ9qCSUy46PwVU6hbuQu2kSvKRq/mjFrAOy
         /rSZ904C8SvHxBjsGWXNPV53scPiVmQQN3v1eK6RF9vu1ektLbHx7jpYzNwjaQ4oXukc
         ucQK4YOznvWDFeodTn/cvQgwilk3ffR/sPzn+vOCKKvXuC/uCjf9w3WK46gHHt2bPoSX
         qlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3p6q9ginm/ERGCQ4tel00uPMDr5VkhAFfmgzz9Xg2c8=;
        b=j+RKLpU3kqaodldi74NWFawue6dWd3QyWbVb9rNdJ1u9o/g7cOK+q8PJ5CxhrR3v2Y
         fIjDjc43uTZP4Z1eW4yBqSKi10+VmyQOCPTXHUI9rjD96Ny8BbDLCHQti9WT3mJkwSlS
         1mCpkIfj2bgrWKXuMzfbix3I3DvlffFY0czYFKJb9aaPyqCspOT6nQ2Rj49283iF1mD/
         kGdOvmbJVRh/Z181RdzF4DD/ulTRyudJhKSmvPrEyPSa+gn9d5r6p2HO7fOiyE0n2YW8
         qwxm/0qudAZJO8iWuTKXoKDF+ynxByLhEG4P8I4VKysJnftw2ZgUiu9BzADp1G6i53Fo
         ZC2Q==
X-Gm-Message-State: ABuFfojQ+RhwRfbeU/dATM08pfNg9sslDMKnHlfi7Oa7AEO/3ZKsU2Gh
        kLfSlypo3r67aMUZj6TQT4Nsjnql
X-Google-Smtp-Source: ACcGV63LpiGIc2g0ane1PXftRMj1ZHMoRq5tBhQcaVl5leD79do33mK/uyLl28h3wkN+Z1mJxKXl+Q==
X-Received: by 2002:a1c:5fc2:: with SMTP id t185-v6mr20842210wmb.12.1540312275455;
        Tue, 23 Oct 2018 09:31:15 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.250])
        by smtp.gmail.com with ESMTPSA id h78-v6sm2508972wmd.4.2018.10.23.09.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 09:31:14 -0700 (PDT)
From:   Slavica <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica <slawica92@hotmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Slavica <slawica92@hotmail.com>
Subject: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user name
Date:   Tue, 23 Oct 2018 18:29:41 +0200
Message-Id: <20181023162941.3840-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of enhancement request that ask for `git stash` to work even if `user.name` is not configured.
The issue is discussed here: https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.

Signed-off-by: Slavica <slawica92@hotmail.com>
---
 t/t3903-stash.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9e06494ba0..9ff34a65bc 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1156,4 +1156,21 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_failure 'stash with HOME as non-existing directory' '
+    test_commit 1 &&
+    test_config user.useconfigonly true &&
+    test_config stash.usebuiltin true &&
+    (
+        HOME=$(pwd)/none &&
+        export HOME &&
+        unset GIT_AUTHOR_NAME &&
+        unset GIT_AUTHOR_EMAIL &&
+        unset GIT_COMMITTER_NAME &&
+        unset GIT_COMMITTER_EMAIL &&
+        test_must_fail git config user.email &&
+        echo changed >1.t &&
+		git stash
+    )
+'
+
 test_done
-- 
2.19.1.windows.1


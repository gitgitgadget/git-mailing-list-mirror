Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C5B1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 22:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391716AbfGRW5y (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 18:57:54 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52404 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfGRW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 18:57:54 -0400
Received: by mail-qk1-f201.google.com with SMTP id r200so24655945qke.19
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 15:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hr9nqW2VWjZHPz6vEmxxSuuVj7+YooS/haM098tyz+4=;
        b=c0o0A7kVdu912T/THBnmOHB1JgDWvPDuTtYomZPDeFMdZp+oC1NKREkPctuao2uaRN
         /bnt2AQXLiILS8tJI6xAMdUa8VKa4Y/GZ5ZGG3w1s4dHcwuLMFKKJPvDMMt3mNwEWyXS
         BNIIUQQy6FAWZC/QHEr1aXqwO15618eSJrbUUCZTZqZy5OgO+KICHfr0E6oTOlOklqGG
         Se8LvmbOMARr2VDcvy15Q+bnFnULXURFXx+xEaYuJ51Ld3sn9E/we9kLK9qDgq1P+Qm+
         zXlPf9edSYUsMWq5Xg34qYqJePm1r9acmdPG3EpnPvfdzNL+0rC2jRtomUc6VBM5jwQI
         FpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hr9nqW2VWjZHPz6vEmxxSuuVj7+YooS/haM098tyz+4=;
        b=m0/q1LF2o3/NOlN7rUrra0EE05WGZdhu76rcuVsByL9yfPqt6coJh2KNjkyQymyNuQ
         tG1veHWuRMvKrrKw3FXFYh3JNuLJpUSlmzoOXietcotTcZ/RG6rb0zG6tMFtucgyyCAv
         gi6ggeZTlx2BM+dQukeb5tx9zrdQhM7X4apJU9Kdg3tkXgQx7CNTj0qHc/Fso+h4CW7N
         xo6QIJ7/0NIHlXFl+OkDwop+6C9yhNt8X/Iqxxqtk+uUEOINi2j2sI59ZTIXH51XVM/i
         HTYLA4iVJtQZcIhO1Pcq+ON8wGHP/14fGTF+qeArS6rXj0fbXY+YwAIhWI6IjqKz3IAR
         lKGg==
X-Gm-Message-State: APjAAAVSGjlWrC0wJmM7kejAAMW6ZKquKPNnCHlZTZKCkvBTDuY1WHfL
        /hEcSfjzgg+qrOwQjGR+PqR4WUmxcQFrfhpsvuF8C1U6KaY/KUZC4IZDqein6B/zYRxe8bJCRnV
        LbXhkyr7+E2DFlKEJLvdcCadx4J3UyZv8EvJg+rZ+CQlzaF0QyRGPb9JE/kyAuFw=
X-Google-Smtp-Source: APXvYqwTbdM0P1rX/MsHRLNdoEM2ObWxReU71ZCibUyb0IjJvDTaf6X/mt6KjvaUB0JSnumgBABEUIq6xs8EMg==
X-Received: by 2002:a0c:e001:: with SMTP id j1mr35396820qvk.110.1563490673121;
 Thu, 18 Jul 2019 15:57:53 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:57:40 -0700
In-Reply-To: <cover.1563490164.git.steadmon@google.com>
Message-Id: <69dc3696e715f9be9e545e0142244e16bdd489cc.1563490164.git.steadmon@google.com>
Mime-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 4/4] t7503: add tests for pre-merge-hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, stefanbeller@gmail.com,
        martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@grubix.eu>

Add tests which make sure that the pre-merge-hook is called when
present, allows/disallows merge commits depending on its return value
and is suppressed by "--no-verify".

[js: renamed test as suggested in review comments]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 ...> t7503-pre-commit-and-pre-merge-hooks.sh} | 66 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)
 rename t/{t7503-pre-commit-hook.sh => t7503-pre-commit-and-pre-merge-hooks.sh} (67%)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-and-pre-merge-hooks.sh
similarity index 67%
rename from t/t7503-pre-commit-hook.sh
rename to t/t7503-pre-commit-and-pre-merge-hooks.sh
index 984889b39d..36ae87f7ef 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-and-pre-merge-hooks.sh
@@ -1,9 +1,22 @@
 #!/bin/sh
 
-test_description='pre-commit hook'
+test_description='pre-commit and pre-merge hooks'
 
 . ./test-lib.sh
 
+test_expect_success 'root commit' '
+
+	echo "root" > file &&
+	git add file &&
+	git commit -m "zeroth" &&
+	git checkout -b side &&
+	echo "foo" > foo &&
+	git add foo &&
+	git commit -m "make it non-ff" &&
+	git checkout master
+
+'
+
 test_expect_success 'with no hook' '
 
 	echo "foo" > file &&
@@ -12,6 +25,14 @@ test_expect_success 'with no hook' '
 
 '
 
+test_expect_success 'with no hook (merge)' '
+
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master
+
+'
+
 test_expect_success '--no-verify with no hook' '
 
 	echo "bar" > file &&
@@ -20,15 +41,25 @@ test_expect_success '--no-verify with no hook' '
 
 '
 
+test_expect_success '--no-verify with no hook (merge)' '
+
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master
+
+'
+
 # now install hook that always succeeds
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
 HOOK="$HOOKDIR/pre-commit"
+MERGEHOOK="$HOOKDIR/pre-merge"
 mkdir -p "$HOOKDIR"
 cat > "$HOOK" <<EOF
 #!/bin/sh
 exit 0
 EOF
 chmod +x "$HOOK"
+cp -p "$HOOK" "$MERGEHOOK"
 
 test_expect_success 'with succeeding hook' '
 
@@ -38,6 +69,14 @@ test_expect_success 'with succeeding hook' '
 
 '
 
+test_expect_success 'with succeeding hook (merge)' '
+
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master
+
+'
+
 test_expect_success '--no-verify with succeeding hook' '
 
 	echo "even more" >> file &&
@@ -46,11 +85,20 @@ test_expect_success '--no-verify with succeeding hook' '
 
 '
 
+test_expect_success '--no-verify with succeeding hook (merge)' '
+
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master
+
+'
+
 # now a hook that fails
 cat > "$HOOK" <<EOF
 #!/bin/sh
 exit 1
 EOF
+cp -p "$HOOK" "$MERGEHOOK"
 
 test_expect_success 'with failing hook' '
 
@@ -68,6 +116,22 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
+test_expect_success 'with failing hook (merge)' '
+
+	git checkout side &&
+	test_must_fail git merge -m "merge master" master &&
+	git checkout master
+
+'
+
+test_expect_success '--no-verify with failing hook (merge)' '
+
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master
+
+'
+
 chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
 
-- 
2.22.0.657.g960e92d24f-goog


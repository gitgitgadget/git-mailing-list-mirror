Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988721F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbeHPF0V (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:21 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:49191 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF0V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:21 -0400
Received: by mail-yw1-f74.google.com with SMTP id d20-v6so3529004ywa.16
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=vM5o5OCjk7mrjUCgJf+8rX3JEY+dwNvMuB5LhWO0re0=;
        b=GL0qKJuq2+TXJWjWvaLgFssI6yS5yB+QoOQXdsellSI0vXrKcjmwvBLfRCsv6+GK2z
         ALoUo3YVZcwH9HENKCVcRDIT5txnTXCJnVzl+huYkEAVyvX71DaLCM0tHvTb7X84ZAUe
         4m5m6ec3MS1oxlg6h0SGMty69nIA++I9a7Fi4LO68sCY5TeiuPlEVvhG8kY+Nzaamz/G
         tRoOOsrIKDPGshF4UHqigz4eTRPEqGhVy86SMkfarRccSXREt4/e3xF+VkMQE0aFI6id
         UFlvuEsLokUjbsVUf/1dQwRs/HjxfeVTu3/spHvf73IOatDW7/lbIRLiIUn8kYBMZXc9
         l7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=vM5o5OCjk7mrjUCgJf+8rX3JEY+dwNvMuB5LhWO0re0=;
        b=ezkpazwJkd2K0CtZ42mA5i6SrjpV7FY7vn5nBbicxUInttOx4WKh7C6jR03uETecbn
         FXRKj8rl3DdTgrcVQCISfBIO4dEZ6UH0WC6VdkgbiuH6DJM6YK6x/9NfTfQQLuplXZv0
         CNsk6JIIEfNeSgNI18MbszDh19Mx2lzg6cUpRsiehKiH7BtVmLbFyKcRQFohq+06A4EW
         ubI5Apz+IAQCX6wFVfSaIdBhS75dAf9x8Oa8iWkRlBiIdCJQJPlD1vIb3ATiHG4q27AK
         9sWq1QtGjSdZ6cDm0kJnR8HPDv4p/XeK92YpfY2iWRMuKAnlkhHlRoqg1KC8BEKenGTA
         xCGw==
X-Gm-Message-State: AOUpUlGoreh9jc5iLxC5NThimKQyjTuAo/DQNHRFKVygqvNyxYdNKpdB
        RKRJTd0BYONHP1Mq3YN89JoSHloVreYrNBt2OxFW+rTCg+B29qnV7hh77XBgPvGp/Jv/nkl4aF3
        oWhVun3K0tDCcxmNDcMAQzNTGCEkPid88EcucJcG73Y6f8mK570rsci833cQc
X-Google-Smtp-Source: AA+uWPxDypZ7iA7b0giHNh5V2tawNhmF0U9okb7Z/43JL1aAiEA6lbc5RrwAhqhyzBE983z4Z7NcjdJ9Uk4f
MIME-Version: 1.0
X-Received: by 2002:a81:ae1c:: with SMTP id m28-v6mr8275548ywh.42.1534386673837;
 Wed, 15 Aug 2018 19:31:13 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:30:54 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com>
Message-Id: <20180816023100.161626-2-sbeller@google.com>
References: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 1/7] t7410: update to new style
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it fix a typo (s/independed/independent) and
make sure git is not in a chain of pipes.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7410-submodule-checkout-to.sh | 99 +++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 1acef32647a..f1b492ebc46 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -6,55 +6,72 @@ test_description='Combination of submodules and multiple workdirs'
 
 base_path=$(pwd -P)
 
-test_expect_success 'setup: make origin' \
-    'mkdir -p origin/sub && ( cd origin/sub && git init &&
-	echo file1 >file1 &&
-	git add file1 &&
-	git commit -m file1 ) &&
-    mkdir -p origin/main && ( cd origin/main && git init &&
-	git submodule add ../sub &&
-	git commit -m "add sub" ) &&
-    ( cd origin/sub &&
-	echo file1updated >file1 &&
-	git add file1 &&
-	git commit -m "file1 updated" ) &&
-    ( cd origin/main/sub && git pull ) &&
-    ( cd origin/main &&
-	git add sub &&
-	git commit -m "sub updated" )'
-
-test_expect_success 'setup: clone' \
-    'mkdir clone && ( cd clone &&
-	git clone --recursive "$base_path/origin/main")'
+test_expect_success 'setup: make origin'  '
+	mkdir -p origin/sub &&
+	(
+		cd origin/sub && git init &&
+		echo file1 >file1 &&
+		git add file1 &&
+		git commit -m file1
+	) &&
+	mkdir -p origin/main &&
+	(
+		cd origin/main && git init &&
+		git submodule add ../sub &&
+		git commit -m "add sub"
+	) &&
+	(
+		cd origin/sub &&
+		echo file1updated >file1 &&
+		git add file1 &&
+		git commit -m "file1 updated"
+	) &&
+	git -C origin/main/sub pull &&
+	(
+		cd origin/main &&
+		git add sub &&
+		git commit -m "sub updated"
+	)
+'
+
+test_expect_success 'setup: clone' '
+	mkdir clone &&
+	git -C clone clone --recursive "$base_path/origin/main"
+'
 
 rev1_hash_main=$(git --git-dir=origin/main/.git show --pretty=format:%h -q "HEAD~1")
 rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1")
 
-test_expect_success 'checkout main' \
-    'mkdir default_checkout &&
-    (cd clone/main &&
-	git worktree add "$base_path/default_checkout/main" "$rev1_hash_main")'
+test_expect_success 'checkout main' '
+	mkdir default_checkout &&
+	git -C clone/main worktree add "$base_path/default_checkout/main" "$rev1_hash_main"
+'
 
-test_expect_failure 'can see submodule diffs just after checkout' \
-    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
+test_expect_failure 'can see submodule diffs just after checkout' '
+	git -C default_checkout/main diff --submodule master"^!" >out &&
+	grep "file1 updated" out
+'
 
-test_expect_success 'checkout main and initialize independed clones' \
-    'mkdir fully_cloned_submodule &&
-    (cd clone/main &&
-	git worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
-    (cd fully_cloned_submodule/main && git submodule update)'
+test_expect_success 'checkout main and initialize independent clones' '
+	mkdir fully_cloned_submodule &&
+	git -C clone/main worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main" &&
+	git -C fully_cloned_submodule/main submodule update
+'
 
-test_expect_success 'can see submodule diffs after independed cloning' \
-    '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+test_expect_success 'can see submodule diffs after independent cloning' '
+	git -C fully_cloned_submodule/main diff --submodule master"^!" >out &&
+	grep "file1 updated" out
+'
 
-test_expect_success 'checkout sub manually' \
-    'mkdir linked_submodule &&
-    (cd clone/main &&
-	git worktree add "$base_path/linked_submodule/main" "$rev1_hash_main") &&
-    (cd clone/main/sub &&
-	git worktree add "$base_path/linked_submodule/main/sub" "$rev1_hash_sub")'
+test_expect_success 'checkout sub manually' '
+	mkdir linked_submodule &&
+	git -C clone/main worktree add "$base_path/linked_submodule/main" "$rev1_hash_main" &&
+	git -C clone/main/sub worktree add "$base_path/linked_submodule/main/sub" "$rev1_hash_sub"
+'
 
-test_expect_success 'can see submodule diffs after manual checkout of linked submodule' \
-    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+test_expect_success 'can see submodule diffs after manual checkout of linked submodule' '
+	git -C linked_submodule/main diff --submodule master"^!" >out &&
+	grep "file1 updated" out
+'
 
 test_done
-- 
2.18.0.265.g16de1b435c9.dirty


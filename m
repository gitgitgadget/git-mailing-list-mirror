Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D711F955
	for <e@80x24.org>; Sat, 29 Dec 2018 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeL2ViH (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 16:38:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43540 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeL2ViH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 16:38:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so23765257wrs.10
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 13:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raXQox0NLpNTPFerYzp01nOYFXLF7VkRO7qt1KETpVA=;
        b=AlXZVpSIR2N11YW3PRo2hoRkKEPAysKWJHYL0NMHYi0IUIMiRBXLiqfM3z88sWEaAw
         GA3+7Ime/OhnGrlLN+pqxhpqUmf7hroN7l82QOx4CNtuoLB/zb170Q3ZW08lEMf77g6H
         dTlSu1sywvsUY6EK0L6VV5l+HlZ/LuuTxRnKjeIXbmJ+KJ9X9CzZ7LhxRctWZOqjM+A1
         NiE9RbwDe0FGBuSi+AcZFhYd5ORC6cfmEkklZsHA+T0Wm4bBZPbt2zSMeRUYY/FsjDTd
         /M8e43XcC3koaTS5UEZUfAVGEZJjf4f+zT5hJvINQiDwSbq89CNEQnjg7nnnJ+1hvZN5
         HHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raXQox0NLpNTPFerYzp01nOYFXLF7VkRO7qt1KETpVA=;
        b=siRH2k9V4tQzmufNtZ1XGKD799S0dOCPSfkMeyrKA6xwayjLlemeWPDOQRlNQBktVs
         /ISaKAFlr09j3NPwlD/7KVe8G/NGqDLJ3w/BqSVZ2G+NuPvdT+9Cxy7ypYS/16rmuRxg
         jeQXSfiFCXjkoZpc9zUm3YVt8w+BlfWw++DBLIF4En8VvMFfG5lkmYYjKjxczNZPgTjx
         2oFaYBgJZFHn7FOpaQDbX+XNW/ot1EXJPk0sAvWM8NzeI8FRBx8P0G7w+NANsICBjgvS
         cBaayDAwmBL7yrQaXns/j4hl+pjmQUd2dCfL0FEncDcl0TfkiXcNllkq+mW/xzd086nw
         WWBg==
X-Gm-Message-State: AJcUukey2ue3lxUF6Z4A9j1dk68ZO7Aljor7B3WsCXcVqiVTOKr8V4w1
        RKsQTe6pQY+EoPvjxxhDypmo0YOL
X-Google-Smtp-Source: ALg8bN6dgwU40WS0rJAOL0EUpu2aoQv/CHdE/EONSsDa2Bz/5vqwXgKx2q8knbfdbeilN5XAwYtIPg==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr29931357wro.78.1546119483900;
        Sat, 29 Dec 2018 13:38:03 -0800 (PST)
Received: from localhost.localdomain ([95.86.70.194])
        by smtp.gmail.com with ESMTPSA id n9sm25282448wrx.80.2018.12.29.13.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 13:38:03 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 1/2] t5403: simplify by using a single repository
Date:   Sat, 29 Dec 2018 23:37:58 +0200
Message-Id: <20181229213759.12878-1-orgads@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

There is no strong reason to use separate clones to run
these tests; just use a single test repository prepared
with more modern test_commit shell helper function.

While at it, replace three "awk '{print $N}'" on the same
file with shell built-in "read" into three variables.

Revert d42ec126aa717d00549e387d5a95fd55683c2e2c which is a workaround for
Cygwin that is no longer needed.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 78 +++++++++++------------------------
 1 file changed, 23 insertions(+), 55 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index fc898c9eac..1d15a1031f 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,82 +7,50 @@ test_description='Test the post-checkout hook.'
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo Data for commit0. >a &&
-	echo Data for commit0. >b &&
-	git update-index --add a &&
-	git update-index --add b &&
-	tree0=$(git write-tree) &&
-	commit0=$(echo setup | git commit-tree $tree0) &&
-	git update-ref refs/heads/master $commit0 &&
-	git clone ./. clone1 &&
-	git clone ./. clone2 &&
-	GIT_DIR=clone2/.git git branch new2 &&
-	echo Data for commit1. >clone2/b &&
-	GIT_DIR=clone2/.git git add clone2/b &&
-	GIT_DIR=clone2/.git git commit -m new2
-'
-
-for clone in 1 2; do
-    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
-#!/bin/sh
-echo $@ > $GIT_DIR/post-checkout.args
-EOF
-    chmod u+x clone${clone}/.git/hooks/post-checkout
-done
-
-test_expect_success 'post-checkout runs as expected ' '
-	GIT_DIR=clone1/.git git checkout master &&
-	test -e clone1/.git/post-checkout.args
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-checkout <<-\EOF &&
+	echo "$@" >.git/post-checkout.args
+	EOF
+	test_commit one &&
+	test_commit two &&
+	test_commit three
 '
 
 test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
-	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	test_when_finished "rm -f .git/post-checkout.args" &&
+	git checkout master &&
+	read old new flag <.git/post-checkout.args &&
 	test $old = $new && test $flag = 1
 '
 
-test_expect_success 'post-checkout runs as expected ' '
-	GIT_DIR=clone1/.git git checkout master &&
-	test -e clone1/.git/post-checkout.args
-'
-
 test_expect_success 'post-checkout args are correct with git checkout -b ' '
-	GIT_DIR=clone1/.git git checkout -b new1 &&
-	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	test_when_finished "rm -f .git/post-checkout.args" &&
+	git checkout -b new1 &&
+	read old new flag <.git/post-checkout.args &&
 	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
-	GIT_DIR=clone2/.git git checkout new2 &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	test_when_finished "rm -f .git/post-checkout.args" &&
+	git checkout two &&
+	read old new flag <.git/post-checkout.args &&
 	test $old != $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
-	GIT_DIR=clone2/.git git checkout master b &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	test_when_finished "rm -f .git/post-checkout.args" &&
+	git checkout master -- three.t &&
+	read old new flag <.git/post-checkout.args &&
 	test $old = $new && test $flag = 0
 '
 
-if test "$(git config --bool core.filemode)" = true; then
-mkdir -p templates/hooks
-cat >templates/hooks/post-checkout <<'EOF'
-#!/bin/sh
-echo $@ > $GIT_DIR/post-checkout.args
-EOF
-chmod +x templates/hooks/post-checkout
-
 test_expect_success 'post-checkout hook is triggered by clone' '
+	mkdir -p templates/hooks &&
+	write_script templates/hooks/post-checkout <<-\EOF &&
+	echo "$@" >$GIT_DIR/post-checkout.args
+	EOF
 	git clone --template=templates . clone3 &&
 	test -f clone3/.git/post-checkout.args
 '
-fi
 
 test_done
-- 
2.20.1


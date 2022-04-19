Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75135C433FE
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 01:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbiDSBeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 21:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiDSBeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 21:34:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D41E3F7
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so529048wmq.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q4vHFrcL6U+n84kwB4O5isWXvqlO5mjvge06h4xjCRU=;
        b=nleISJKOiRw3vAKsqxymXrX6lAkfJ4sN5qPlA/IUIaNpXVf6vGVqZF8u1CZLBADe7y
         RKbSZC7DHYOygqPqi4XKM048uOQ/QXoYl9XxSdmZi9BBjRPRjMVpSpwZ2h11knVNmv7L
         Tkxaq57FFmMUSIl06lOW84SildJfHM8K2c9d/aIAhlHivHZLphdzJIfhiGa96PCakF7k
         U8+CVbllISfPdMWQoHtR617QIQrNEqDzcSDEPp1wJh93B1BG339ICFjeuH/V8ayc5cgl
         5ZMp3gdBg06GfnOnK43/HEq4wfR5RDMRNfSTy7v2i1TcmM4OmisQF8iGwKOUNJqlCb0t
         dmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q4vHFrcL6U+n84kwB4O5isWXvqlO5mjvge06h4xjCRU=;
        b=LmejwIhzV22b/VNa+VWEL+M+BIJ6bLitZQhbnz0RT9HXVgffvXp4wd9NEho5DukBve
         0ezOnl+DHMQq8j89lbOvsGmYxGbPnB3HEMl5UxHGIVHpB7MCdvMQp5xpD+CpXQC2ZYB7
         6q4LpvuhEKXBsI5PNypnQWYbvER3RFxHXscweNnHTBME7D2nvrLx+LyLhtYo/72KKYZy
         Onm44ZcJRt8pbRtf3TUPow9ZLsvdONQejwIDVGz+SGfYMltFx1rNX2tvSMxGAq0YFCaC
         SyHLjZJSQnc60FvqrKX25OWcPKOY2xg4PwIafInKzAEzV4A6y64KcRDSnrzGTKmfJ8O1
         yn/Q==
X-Gm-Message-State: AOAM533X4bqpagdkwq0sRJ0ikQzmDU3Nr5Sbm98qO3EiDeuM6Se0zFnF
        GWl82Tp0AUhBWCz7h4sFTzE1wxAhaSw=
X-Google-Smtp-Source: ABdhPJxFnF3NVKqRgRzYWfM5V2OELhIm+RJqhWY0azmQ/YD/q9I05UFr345uVy21VT5m38uGJ6FtKw==
X-Received: by 2002:a1c:3b09:0:b0:38e:ad45:5ec6 with SMTP id i9-20020a1c3b09000000b0038ead455ec6mr13443327wma.194.1650331880303;
        Mon, 18 Apr 2022 18:31:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm11590664wra.96.2022.04.18.18.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:31:19 -0700 (PDT)
Message-Id: <e5c29a12df61d0f587594664f50ec025b934fadf.1650331876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
References: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
From:   "Jack McGuinness via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Apr 2022 01:31:15 +0000
Subject: [PATCH 2/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script
 p2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jack McGuinness <jmcguinness2@ucmerced.edu>

Remove whitespace after redirect operator.

Signed-off-by: Jack McGuinness <jmcguinness2@ucmerced.edu>
---
 t/t4202-log.sh | 62 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c5d191356f1..fe3976829bb 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -45,29 +45,29 @@ test_expect_success setup '
 	git commit -m sixth
 '
 
-printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
+printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" >expect
 test_expect_success 'pretty' '
-	git log --pretty="format:%s" > actual &&
+	git log --pretty="format:%s" >actual &&
 	test_cmp expect actual
 '
 
-printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect
+printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" >expect
 test_expect_success 'pretty (tformat)' '
-	git log --pretty="tformat:%s" > actual &&
+	git log --pretty="tformat:%s" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'pretty (shortcut)' '
-	git log --pretty="%s" > actual &&
+	git log --pretty="%s" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'format' '
-	git log --format="%s" > actual &&
+	git log --format="%s" >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect << EOF
  This is
   the sixth
   commit.
@@ -77,16 +77,16 @@ cat > expect << EOF
 EOF
 
 test_expect_success 'format %w(11,1,2)' '
-	git log -2 --format="%w(11,1,2)This is the %s commit." > actual &&
+	git log -2 --format="%w(11,1,2)This is the %s commit." >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'format %w(,1,2)' '
-	git log -2 --format="%w(,1,2)This is%nthe %s%ncommit." > actual &&
+	git log -2 --format="%w(,1,2)This is%nthe %s%ncommit." >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect << EOF
 $(git rev-parse --short :/sixth  ) sixth
 $(git rev-parse --short :/fifth  ) fifth
 $(git rev-parse --short :/fourth ) fourth
@@ -95,14 +95,14 @@ $(git rev-parse --short :/second ) second
 $(git rev-parse --short :/initial) initial
 EOF
 test_expect_success 'oneline' '
-	git log --oneline > actual &&
+	git log --oneline >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'diff-filter=A' '
-	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
-	git log --no-renames --pretty="format:%s" --diff-filter A HEAD > actual-separate &&
-	printf "fifth\nfourth\nthird\ninitial" > expect &&
+	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD >actual &&
+	git log --no-renames --pretty="format:%s" --diff-filter A HEAD >actual-separate &&
+	printf "fifth\nfourth\nthird\ninitial" >expect &&
 	test_cmp expect actual &&
 	test_cmp expect actual-separate
 '
@@ -174,43 +174,43 @@ test_expect_success 'git config log.follow is overridden by --no-follow' '
 
 # Note that these commits are intentionally listed out of order.
 last_three="$(git rev-parse :/fourth :/sixth :/fifth)"
-cat > expect << EOF
+cat >expect << EOF
 $(git rev-parse --short :/sixth ) sixth
 $(git rev-parse --short :/fifth ) fifth
 $(git rev-parse --short :/fourth) fourth
 EOF
 test_expect_success 'git log --no-walk <commits> sorts by commit time' '
-	git log --no-walk --oneline $last_three > actual &&
+	git log --no-walk --oneline $last_three >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git log --no-walk=sorted <commits> sorts by commit time' '
-	git log --no-walk=sorted --oneline $last_three > actual &&
+	git log --no-walk=sorted --oneline $last_three >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect << EOF
 === $(git rev-parse --short :/sixth ) sixth
 === $(git rev-parse --short :/fifth ) fifth
 === $(git rev-parse --short :/fourth) fourth
 EOF
 test_expect_success 'git log --line-prefix="=== " --no-walk <commits> sorts by commit time' '
-	git log --line-prefix="=== " --no-walk --oneline $last_three > actual &&
+	git log --line-prefix="=== " --no-walk --oneline $last_three >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect << EOF
 $(git rev-parse --short :/fourth) fourth
 $(git rev-parse --short :/sixth ) sixth
 $(git rev-parse --short :/fifth ) fifth
 EOF
 test_expect_success 'git log --no-walk=unsorted <commits> leaves list of commits as given' '
-	git log --no-walk=unsorted --oneline $last_three > actual &&
+	git log --no-walk=unsorted --oneline $last_three >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git show <commits> leaves list of commits as given' '
-	git show --oneline -s $last_three > actual &&
+	git show --oneline -s $last_three >actual &&
 	test_cmp expect actual
 '
 
@@ -227,7 +227,7 @@ test_expect_success 'log --grep' '
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect << EOF
 second
 initial
 EOF
@@ -514,7 +514,7 @@ test_expect_success '-c color.grep.matchSelected log --grep' '
 	test_cmp expect actual
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 * Second
 * sixth
 * fifth
@@ -528,7 +528,7 @@ test_expect_success 'simple log --graph' '
 	test_cmp_graph
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 123 * Second
 123 * sixth
 123 * fifth
@@ -550,7 +550,7 @@ test_expect_success 'set up merge history' '
 	git merge side
 '
 
-cat > expect <<\EOF
+cat >expect <<\EOF
 *   Merge branch 'side'
 |\
 | * side-2
@@ -569,7 +569,7 @@ test_expect_success 'log --graph with merge' '
 	test_cmp_graph --date-order
 '
 
-cat > expect <<\EOF
+cat >expect <<\EOF
 | | | *   Merge branch 'side'
 | | | |\
 | | | | * side-2
@@ -588,7 +588,7 @@ test_expect_success 'log --graph --line-prefix="| | | " with merge' '
 	test_cmp_graph --line-prefix="| | | " --date-order
 '
 
-cat > expect.colors <<\EOF
+cat >expect.colors <<\EOF
 *   Merge branch 'side'
 <BLUE>|<RESET><CYAN>\<RESET>
 <BLUE>|<RESET> * side-2
@@ -618,7 +618,7 @@ test_expect_success 'diff-tree --graph' '
 	grep "one" actual
 '
 
-cat > expect <<\EOF
+cat >expect <<\EOF
 *   commit main
 |\  Merge: A B
 | | Author: A U Thor <author@example.com>
@@ -699,7 +699,7 @@ test_expect_success 'set up more tangled history' '
 	git merge reach
 '
 
-cat > expect <<\EOF
+cat >expect <<\EOF
 *   Merge tag 'reach'
 |\
 | \
@@ -1822,7 +1822,7 @@ test_expect_success GPGSM 'log x509 fingerprint' '
 '
 
 test_expect_success GPGSM 'log OpenPGP fingerprint' '
-	echo "D4BE22311AD3131E5EDA29A461092E85B7227189" > expect &&
+	echo "D4BE22311AD3131E5EDA29A461092E85B7227189" >expect &&
 	git log -n1 --format="%GP" signed-subkey >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget


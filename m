Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B9C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 01:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbiDSBeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbiDSBeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 21:34:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3401E3F8
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so20450232wrd.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I0AVYDEqTUSsgyuLz2b0p+Ffh0TlwdAHqsxFWijdWmM=;
        b=Z429fx7xI4LamUkN1BUHW3PyU3fzAbzs2gxaEfr+z8TGUWAkGetxaeTloIT/CqIQ77
         YzwbFqR+u71wo13sMlmfId77Db+Xs75L8dF91Ynzv7HvlkGSneM4TbslkkwogB/jn+t1
         f9RWfcuHl5mAaglJ68PFAvhbtatxqkwSw519VjQnJ9k64oxd6uUbyrweYCJ/exj9db9f
         Ao4DOnrXPFlNwnPj97YSYJnnC0ClecqHZ3GGCZqxCX5thpnzXYlKW9TgKxhaZMKkR23V
         eA+t9tN7Ex+CiF47mQp72hDlTznM93BAFnrch4FjFkA9YJKL7PXbL0gm2oZ1bXaah9fk
         5o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I0AVYDEqTUSsgyuLz2b0p+Ffh0TlwdAHqsxFWijdWmM=;
        b=dTiWZPHhXOE1mhmdWXH0uVfIA3iLOKmILotNTL0DcQfFHiG+77GGUwagbxgYaif6jI
         W276nDwGcyxAeCAJ4gowxvNGFCF0sKIWp3m4H7+FyTj8N0Hm9Z01d4UXlruvYsep+/SV
         4bqBbUngwnIH1sfFClyw6sDEqtjSPhG32NcMjBf0xRr4qRzY8EYNdMIR2vDf30/shMks
         1CI46k3b4iRkf4lB9iTdG7cQRJUxC/88X/hktYwDsShP4elANysl5bu03DtoUhpu1sXZ
         SM7QDQyZgpJxYr/UX0r0rvWcCQB4S3Fmy4kJ4FPVVLdfJFcczg/KZr9QGNuGp2WejHN5
         epng==
X-Gm-Message-State: AOAM533clOpaRGZV0aiSWXlnIkkBvQCTLma/9NRxypt1LUBtYx958BUp
        ucz4o+2DwhzOMPCXp2prFOdGydYyLfY=
X-Google-Smtp-Source: ABdhPJxwdVxr83hoT3PQP6ZtNOBorAMoqerwwOoNBQxO3H6/1CJxC023tsVWapN5lL8fEZs57Vsqng==
X-Received: by 2002:a5d:6d8d:0:b0:207:aae1:2fb6 with SMTP id l13-20020a5d6d8d000000b00207aae12fb6mr9924927wrs.376.1650331879151;
        Mon, 18 Apr 2022 18:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a0560001b8e00b00205918bd86esm11444843wru.78.2022.04.18.18.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:31:18 -0700 (PDT)
Message-Id: <0c6aa4e9103b301556437d35acefa535a90e6a1e.1650331876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
References: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
From:   "Jack McGuinness via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Apr 2022 01:31:14 +0000
Subject: [PATCH 1/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script
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

Replace test body spaces with tabs where appropiate
Remove blank lines at start and and of test bodies.

Signed-off-by: Jack McGuinness <jmcguinness2@ucmerced.edu>
---
 t/t4202-log.sh | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index be07407f855..c5d191356f1 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -15,7 +15,6 @@ test_cmp_graph () {
 }
 
 test_expect_success setup '
-
 	echo one >one &&
 	git add one &&
 	test_tick &&
@@ -44,31 +43,26 @@ test_expect_success setup '
 	git rm a/two &&
 	test_tick &&
 	git commit -m sixth
-
 '
 
 printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
 test_expect_success 'pretty' '
-
 	git log --pretty="format:%s" > actual &&
 	test_cmp expect actual
 '
 
 printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect
 test_expect_success 'pretty (tformat)' '
-
 	git log --pretty="tformat:%s" > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'pretty (shortcut)' '
-
 	git log --pretty="%s" > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'format' '
-
 	git log --format="%s" > actual &&
 	test_cmp expect actual
 '
@@ -83,13 +77,11 @@ cat > expect << EOF
 EOF
 
 test_expect_success 'format %w(11,1,2)' '
-
 	git log -2 --format="%w(11,1,2)This is the %s commit." > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'format %w(,1,2)' '
-
 	git log -2 --format="%w(,1,2)This is%nthe %s%ncommit." > actual &&
 	test_cmp expect actual
 '
@@ -103,47 +95,37 @@ $(git rev-parse --short :/second ) second
 $(git rev-parse --short :/initial) initial
 EOF
 test_expect_success 'oneline' '
-
 	git log --oneline > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'diff-filter=A' '
-
 	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
 	git log --no-renames --pretty="format:%s" --diff-filter A HEAD > actual-separate &&
 	printf "fifth\nfourth\nthird\ninitial" > expect &&
 	test_cmp expect actual &&
 	test_cmp expect actual-separate
-
 '
 
 test_expect_success 'diff-filter=M' '
-
 	git log --pretty="format:%s" --diff-filter=M HEAD >actual &&
 	printf "second" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'diff-filter=D' '
-
 	git log --no-renames --pretty="format:%s" --diff-filter=D HEAD >actual &&
 	printf "sixth\nthird" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'diff-filter=R' '
-
 	git log -M --pretty="format:%s" --diff-filter=R HEAD >actual &&
 	printf "third" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'multiple --diff-filter bits' '
-
 	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
 	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
 	test_cmp expect actual &&
@@ -152,19 +134,15 @@ test_expect_success 'multiple --diff-filter bits' '
 	git log -M --pretty="format:%s" \
 		--diff-filter=a --diff-filter=R HEAD >actual &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'diff-filter=C' '
-
 	git log -C -C --pretty="format:%s" --diff-filter=C HEAD >actual &&
 	printf "fourth" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'git log --follow' '
-
 	git log --follow --pretty="format:%s" ichi >actual &&
 	printf "third\nsecond\ninitial" >expect &&
 	test_cmp expect actual
@@ -879,7 +857,7 @@ test_expect_success 'multiple decorate-refs' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs="heads/octopus*" \
 		--decorate-refs="tags/reach" >actual &&
-    test_cmp expect.decorate actual
+	test_cmp expect.decorate actual
 '
 
 test_expect_success 'decorate-refs-exclude with glob' '
@@ -2190,10 +2168,10 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
 '
 
 test_expect_success 'log --end-of-options' '
-       git update-ref refs/heads/--source HEAD &&
-       git log --end-of-options --source >actual &&
-       git log >expect &&
-       test_cmp expect actual
+	git update-ref refs/heads/--source HEAD &&
+	git log --end-of-options --source >actual &&
+	git log >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'set up commits with different authors' '
-- 
gitgitgadget


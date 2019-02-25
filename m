Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A47520248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfBYXRD (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34967 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXRB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so11837177wrx.2
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMngvvDKGpk0kJnaOwFWROgzsZB79mwkheEp8tkZ+Bc=;
        b=XpsicqNU8uzFITnS5jKfYWcmeiblfMYxWMXCrBTTVSBEH71RkoucmcgKe0NdsgtYKC
         pcSwCWywazq/H9a/7vtP5xywe7Z8MMiZXmGVZmWL1SsgSuth2GW/TI1YD3/aTzS/r1aG
         8FKGHy53TFumkXQsg5pL8JuWvl0o9YAiSalAEc1Tlyk59CaZaLr1rOdjy3VvOnYozp4Q
         v5OBpY3myMqqCS3MRwSsQEXbbhAwpLthQe158ppjf+gxP103vbdm+RAl+q6jInBTLxCr
         GklGPRVF8WRdVpMJauHPjJ0YYbR5JZ0+XTlftH9g15XwfmZ9lUFeVhci4ftfUa/8zfwj
         WT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMngvvDKGpk0kJnaOwFWROgzsZB79mwkheEp8tkZ+Bc=;
        b=ufTe5M75Pv7u0PG0dsmiShOJnLzH9MqlwPoP53WgV6ZAYKX7S9fvtHxNA1ABKY31cl
         AMq8ztk1+V/oaSwTdkroSvUWT7eJEKig4c9VRne6pyizIwNJmmBPbI9cyynPLgbtOgN9
         9vatJYmcOfS74jf9e8VN6t4Xi3l6BaLjwLr74COAkTPi7WTYzPPq2eh+FQ43RP8lqXaa
         zEXcl3gtlPcfrtMq/QV32scjVeVqJpeKsF6NDy/Bk2FOMeMgZdw5s517S7Za3JJTK5DW
         qRYrkbEK0YJ/RxEaxrRoKtV861CGD9Q44k80aABMudHuQq7A8f6rzuFB5FNlC0Fpg+n3
         YP6Q==
X-Gm-Message-State: AHQUAua0+8pH4cEqYdev+ftOQPekh+4+YTXHBlgVpn3mU5/SNnzCGF0n
        2PdGXNxQRXHC0ONE7i5QGJ8dA4rh
X-Google-Smtp-Source: AHgI3IY2J23UiRBnZm4GYxIyyo7dgg6sUbqbXFXmrA0+WaZVq6FjPdkDV3V/f8/mzsqd0FLz+ybdPQ==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr1963368wrt.162.1551136619570;
        Mon, 25 Feb 2019 15:16:59 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id t69sm5121870wmt.16.2019.02.25.15.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:58 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 08/27] stash: rename test cases to be more descriptive
Date:   Mon, 25 Feb 2019 23:16:12 +0000
Message-Id: <20190225231631.30507-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Rename some test cases' labels to be more descriptive and under 80
characters per line.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index fc292f339f..023421a36c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -612,7 +612,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
-test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
+test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -626,7 +626,7 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	git reset --hard HEAD
 '
 
-test_expect_success 'stash pop - fail early if specified stash is not a stash reference' '
+test_expect_success 'pop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -690,7 +690,7 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
 	git stash drop
 '
 
-test_expect_success 'stash branch should not drop the stash if the branch exists' '
+test_expect_success 'branch: do not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
 	git add file &&
@@ -701,7 +701,7 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash branch should not drop the stash if the apply fails' '
+test_expect_success 'branch: should not drop the stash if the apply fails' '
 	git stash clear &&
 	git reset HEAD~1 --hard &&
 	echo foo >file &&
@@ -715,7 +715,7 @@ test_expect_success 'stash branch should not drop the stash if the apply fails'
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
+test_expect_success 'apply: show same status as git status (relative to ./)' '
 	git stash clear &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
@@ -1056,7 +1056,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec shows no changes when there are none' '
+test_expect_success 'push <pathspec>: show no changes when there are none' '
 	>foo &&
 	git add foo &&
 	git commit -m "tmp" &&
@@ -1066,7 +1066,7 @@ test_expect_success 'stash push with pathspec shows no changes when there are no
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec not in the repository errors out' '
+test_expect_success 'push: <pathspec> not in the repository errors out' '
 	>untracked &&
 	test_must_fail git stash push untracked &&
 	test_path_is_file untracked
-- 
2.21.0.rc2.291.g17236886c5


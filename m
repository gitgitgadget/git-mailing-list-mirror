Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074B6201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966352AbdEOTOS (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:14:18 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35180 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966194AbdEOTOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:14:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id k74so19039057qke.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WxZJm2MT2SHhoRBCNwGjwk/dv374v7+b3j6hO/ad1VE=;
        b=Lc/aJf/Eh8ouROiQ4hpUbB3bPgqiyuydNcvJ++FMFPKbJphYUM9y/G/yq2fCPhBZ9r
         ohRxkFEAaQ98/FOrvB4lYi8TfcwLRwiJ3yta47If69sLbdcij8LW7jn2WGKMGfY2Xyya
         TNHNeyP4thkPYhcdMr2lmz8lUp61A8KJ8Aa2rRB+pzrH17nDkl3qewg/bQU46T0VzDCM
         YHMp8ddzlW9un+6oPQtNm2HaaPUPW++xyI+xS8eft0nQL5tqPgXsUBSeoZMzSt0MCDbr
         3WKsxx0YHEWV7tEiL3ErEiOksIrhMoO6Jlr1VVoiUvQXn8lxCC8wVSbxg34iCjeWh3Vb
         xbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WxZJm2MT2SHhoRBCNwGjwk/dv374v7+b3j6hO/ad1VE=;
        b=ZuTKohZk3fw4p9etV/BvpZnbmmk/LJhz80wn+1zzp97oP88dycPDNfkhyPc19uQ/Fl
         y58+RuKyeE6Y8Me3005DpG63qj4De2PB613EBewqZRATwuvC6VNwBdMaxG9C5UJAjM/S
         8vm1q2qQGcaR6MGjTr0k7YSqEkSHmEnJNiH+piqrQ5UIxDBsc18/Pun2Y0lN+PDQkPiv
         YwlRLstx6k9Bdzrqjud6qNTpNXnR7bJpyg8RYiB3ErqGB+iS14Ir7n6TF0KorxlWz08O
         7jA1ZECqu6FQLSMMW3RNDfoWTmKqi7e4tnsoH/f6ST3VJ3bT2kzNzqs9DGNWuMgxIzQT
         hafg==
X-Gm-Message-State: AODbwcDcThDzfGWGM25wWN0VTVkNJhL2BX/+pvbkF3WkpWn68trqa2c8
        P9e1KcHd27O1Dw==
X-Received: by 10.55.96.3 with SMTP id u3mr7388354qkb.47.1494875655823;
        Mon, 15 May 2017 12:14:15 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 47sm9086903qts.26.2017.05.15.12.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:14:15 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v1 3/5] fsmonitor: add test cases for fsmonitor extension
Date:   Mon, 15 May 2017 15:13:45 -0400
Message-Id: <20170515191347.1892-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170515191347.1892-1-benpeart@microsoft.com>
References: <20170515191347.1892-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases that ensure status results are correct when using the new
fsmonitor extension.  Test untracked, modified, and new files by
ensuring the results are identical to when not using the extension.

Add a test to ensure updates to the index properly mark corresponding
entries in the index extension as dirty so that the status is correct
after commands that modify the index but don't trigger changes in the
working directory.

Add a test that verifies that if the fsmonitor extension doesn't tell
git about a change, it doesn't discover it on its own.  This ensures
git is honoring the extension and that we get the performance benefits
desired.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 134 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 t/t7519-status-fsmonitor.sh

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
new file mode 100644
index 0000000000..2d63efc27b
--- /dev/null
+++ b/t/t7519-status-fsmonitor.sh
@@ -0,0 +1,134 @@
+#!/bin/sh
+
+test_description='git status with file system watcher'
+
+. ./test-lib.sh
+
+clean_repo () {
+	git reset --hard HEAD
+	git clean -fd
+}
+
+dirty_repo () {
+	: >untracked
+	: >dir1/untracked
+	: >dir2/untracked
+	echo 1 >modified
+	echo 2 >dir1/modified
+	echo 3 >dir2/modified
+	echo 4 >new
+	echo 5 >dir1/new
+	echo 6 >dir2/new
+	git add new
+	git add dir1/new
+	git add dir2/new
+}
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	printf "untracked\0"
+	printf "dir1/untracked\0"
+	printf "dir2/untracked\0"
+	printf "modified\0"
+	printf "dir1/modified\0"
+	printf "dir2/modified\0"
+	printf "new\0""
+	printf "dir1/new\0"
+	printf "dir2/new\0"
+	EOF
+	: >tracked &&
+	: >modified &&
+	mkdir dir1 &&
+	: >dir1/tracked &&
+	: >dir1/modified &&
+	mkdir dir2 &&
+	: >dir2/tracked &&
+	: >dir2/modified &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+	dirty_repo
+'
+
+cat >.gitignore <<\EOF
+.gitignore
+expect*
+output*
+EOF
+
+# Status is well tested elsewhere so we'll just ensure that the results are
+# the same when using core.fsmonitor. First call after turning on the option
+# does a complete scan so need to do two calls to ensure we test the new
+# codepath.
+
+test_expect_success 'status with core.untrackedcache true' '
+	git config core.fsmonitor true  &&
+	git config core.untrackedcache true &&
+	git -c core.fsmonitor=false -c core.untrackedcache=true status >expect &&
+	clean_repo &&
+	git status &&
+	dirty_repo &&
+	git status >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'status with core.untrackedcache false' '
+	git config core.fsmonitor true &&
+	git config core.untrackedcache false &&
+	git -c core.fsmonitor=false -c core.untrackedcache=false status >expect &&
+	clean_repo &&
+	git status &&
+	dirty_repo &&
+	git status >output &&
+	test_i18ncmp expect output
+'
+
+# Ensure commands that call refresh_index() to move the index back in time
+# properly invalidate the fsmonitor cache
+
+test_expect_success 'refresh_index() invalidates fsmonitor cache' '
+	git config core.fsmonitor true &&
+	git config core.untrackedcache true &&
+	clean_repo &&
+	git status &&
+	dirty_repo &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	EOF
+	git add . &&
+	git commit -m "to reset" &&
+	git status &&
+	git reset HEAD~1 &&
+	git status >output &&
+	git -c core.fsmonitor=false status >expect &&
+	test_i18ncmp expect output
+'
+
+# Now make sure it's actually skipping the check for modified and untracked
+# files unless it is told about them.  Note, after "git reset --hard HEAD" no
+# extensions exist other than 'TREE' so do a "git status" to get the extension
+# written before testing the results.
+
+test_expect_success 'status doesnt detect unreported modifications' '
+	git config core.fsmonitor true &&
+	git config core.untrackedcache true &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	:
+	EOF
+	clean_repo &&
+	git status &&
+	: >untracked &&
+	echo 2 >dir1/modified &&
+	git status >output &&
+	test_i18ngrep ! "Changes not staged for commit:" output &&
+	test_i18ngrep ! "Untracked files:" output &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	printf "untracked%s\0"
+	printf "dir1/modified\0"
+	EOF
+	git status >output &&
+	test_i18ngrep "Changes not staged for commit:" output &&
+	test_i18ngrep "Untracked files:" output
+'
+
+test_done
-- 
2.13.0.windows.1.6.g4597375fc3


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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC1A201CF
	for <e@80x24.org>; Thu, 18 May 2017 20:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbdERUOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 16:14:15 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35464 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbdERUOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 16:14:12 -0400
Received: by mail-qk0-f193.google.com with SMTP id k74so7550433qke.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vUi3V/ndeN9lZbdBncJ/e4F1mziL298fOX8GsVzdzL4=;
        b=c0eOntpeECxXrGtVTAmCZGy4uF++Hk0v7iCkWHafB9zJ2fxU8Ne/zYDq9gzBbSR3XT
         UJOsreetzHwEsWN/smFcqYNUXCQyD4Q6OoWiruyB4+b9gcDowZwPcA8BmLvihn+FQvGG
         lCJXdnQBhZjvY9BdbnDiC5uUuHvrpDrSJ8HMGfPTHdyrAU0Ljr2XD2GS4yyHz9Umv3Qz
         XtJOBf79YvjkRCIU6kUswu9r/YU/wNkBnEnMMCWMM/zxUeQBEyz0nkHsXlessGISmJTZ
         iFNE6hk69jZ9DM3mVYFmgtfg6vZiHEEbLdEgzLq06FBlmBTQxcqe5s5hjh4uzF80pQP3
         0Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUi3V/ndeN9lZbdBncJ/e4F1mziL298fOX8GsVzdzL4=;
        b=dyUORmaQwUAxewdWGEpWnKtm2DHbljVjjYCWig6pfE2G16XrIStQ4RwDaBLNPn1BYo
         I/1SHIJqBa1go3OjOmSaYFeOYZmEEFzd5X8JeJ4dOhfJ3EnlZ62Al7y+2REK8oLTcGt/
         pnQ7kkBjkHzBM7Lq7pCQuuWDE/lZxMreKyQYROhIvVcLCP8H8ERr6XEtgwSC/pqTGpBe
         xbJ+8hZNtdQAnHX4Q7zkv5VsjC3niCl83Tsda8k2VxS8gTXDToAHpePXNlkd7ONu5eZj
         fjGeFNKGlZHrHZT0yIfrnPps6nnsP7QFGJiSoNVylYGZTYCQ+orYNJC6/SrtFhbnTfEX
         cLEg==
X-Gm-Message-State: AODbwcCM0JiI1eQShByi8jVSKeSuSu1kiZrJXQ/SuFpuBPdHsjp0Rln7
        0ri/1nt+VH910Q==
X-Received: by 10.55.40.100 with SMTP id o97mr6352552qkh.257.1495138450981;
        Thu, 18 May 2017 13:14:10 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y17sm4369133qtc.29.2017.05.18.13.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 13:14:10 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v2 4/6] fsmonitor: add test cases for fsmonitor extension
Date:   Thu, 18 May 2017 16:13:31 -0400
Message-Id: <20170518201333.13088-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170518201333.13088-1-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
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

All test hooks output a marker file that is used to ensure the hook
was actually used to generate the test results.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 153 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100755 t/t7519-status-fsmonitor.sh

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
new file mode 100755
index 0000000000..d3cffc758f
--- /dev/null
+++ b/t/t7519-status-fsmonitor.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description='git status with file system watcher'
+
+. ./test-lib.sh
+
+clean_repo () {
+	git reset --hard HEAD
+	git clean -fd
+	rm marker -f
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
+# The test query-fsmonitor hook proc will output a marker file we can use to
+# ensure the hook was actually used to generate the correct results.
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	: >marker
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
+marker*
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
+	test_path_is_missing marker &&
+	dirty_repo &&
+	git status >output &&
+	test_path_is_file marker &&
+	test_i18ncmp expect output
+'
+
+
+test_expect_success 'status with core.untrackedcache false' '
+	git config core.fsmonitor true &&
+	git config core.untrackedcache false &&
+	git -c core.fsmonitor=false -c core.untrackedcache=false status >expect &&
+	clean_repo &&
+	git status &&
+	test_path_is_missing marker &&
+	dirty_repo &&
+	git status >output &&
+	test_path_is_file marker &&
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
+	test_path_is_missing marker &&
+	dirty_repo &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	:>marker
+	EOF
+	git add . &&
+	git commit -m "to reset" &&
+	git status &&
+	test_path_is_file marker &&
+	git reset HEAD~1 &&
+	git status >output &&
+	test_path_is_file marker &&
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
+	:>marker
+	EOF
+	clean_repo &&
+	git status &&
+	test_path_is_missing marker &&
+	: >untracked &&
+	echo 2 >dir1/modified &&
+	git status >output &&
+	test_path_is_file marker &&
+	test_i18ngrep ! "Changes not staged for commit:" output &&
+	test_i18ngrep ! "Untracked files:" output &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	:>marker
+	printf "untracked%s\0"
+	printf "dir1/modified\0"
+	EOF
+	git status >output &&
+	test_path_is_file marker &&
+	test_i18ngrep "Changes not staged for commit:" output &&
+	test_i18ngrep "Untracked files:" output
+'
+
+test_done
-- 
2.13.0.windows.1.6.g4597375fc3


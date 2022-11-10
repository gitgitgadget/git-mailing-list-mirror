Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB3C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 20:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKJUEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 15:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiKJUEp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 15:04:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0402C10B
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 12:04:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k8so3840192wrh.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 12:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=delBCqzDeQTBUJFic7q0++nBHnUXbB2pr4Xy6byv3to=;
        b=QPpPgNE+xKrKy8M9uEcSWOIX4l8mmy5epslW6SzzU8E7QmZ4OfqLzXjWxj7n9+B4GO
         6GBMhI4kT0DmCKZyX38/+gezl5Cz5wutJu+RAuQCBg9pZpxDzmtEG5pFpu0P8UAHGgAY
         T0OQM4pTcEOWs1uKX3gn/0pmSi/02yCmMLhP4QiHPIHXkHZItpwU2tNoUfuGheEAjl93
         r4pt1JJo0Tgi52kQS7lKzncz9m+/RV8Dy7x4RzMWv3zdf3XoEtZK5VhR51U3k1T4bP/R
         /mcNdwJskG/Tuzcj7wE8H63JsSmMwokBJp7wGCLQ08eJ4uz6CS3GS8Da+qHyuJla5qgd
         q6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=delBCqzDeQTBUJFic7q0++nBHnUXbB2pr4Xy6byv3to=;
        b=Am2dK1DhxaGiyycbIXmL4azI2uLGccWGPe/MaSH8ogGdR39ADi3ZVqyQgclvyyU7gF
         aZyPycvvGkcWBJtFTXOSFq3v6SyZUDa0w/nCh3QEr0vDda1Qarj+khaM0aqqYr9eT23L
         QPUi9jvURKir9IH9jYZEbM50z3RBoonxblyMIHbUw8gKuoxYZsrxAnEKSZMbljsU5SNX
         wVU5nk6Pi6LYjxkUXTJ3u7mjW2rmlR3ctHlAQDgRHFXlOzfCm6GpzB1ad6L9CG+gqt05
         BP/bAHiL1qBETIPjgkaH7ORhDDAoVN7WmjAbp9DG4Mj4IwqmxxTWGSxmFHkyoG9ZhwIQ
         Jp4w==
X-Gm-Message-State: ACrzQf3sCet4BOysCOG9QKHjNVAVc9vFJt0kXSp3pPoSHQiJ7cK763uF
        /Y0Umbj1py88rZCnoEGs63EEiIiwKD4=
X-Google-Smtp-Source: AMsMyM7ag14EubXz7sEtNh0IdF5fPsSo2P/8bDKY9qSl8otf1zsk7h3D5UeMza0bQMHzI/U+wUK1Yg==
X-Received: by 2002:a5d:5d89:0:b0:226:e5ca:4bc2 with SMTP id ci9-20020a5d5d89000000b00226e5ca4bc2mr42290856wrb.310.1668110680966;
        Thu, 10 Nov 2022 12:04:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003b4a68645e9sm7016561wmq.34.2022.11.10.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:04:40 -0800 (PST)
Message-Id: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
References: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 20:04:38 +0000
Subject: [PATCH v5] status: long status advice adapted to recent capabilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Rudy Rigot <rudy.rigot@gmail.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rudy Rigot <rudy.rigot@gmail.com>

Improve the advice displayed when `git status` is slow because
of excessive numbers of untracked files.  Update the `git status`
man page to explain the various configuration options.

`git status` can be slow when there are a large number of untracked
files and directories, because Git must search the entire worktree
to enumerate them.  Previously, Git would print an advice message
with the elapsed search time and a suggestion to disable the search
using the `-uno` option.  This suggestion also carried a warning
that might scare off some users.

Git can reduce the size and time of the untracked file search when
the `core.untrackedCache` and `core.fsmonitor` features are enabled
by caching results from previous `git status` invocations.

Update the advice to explain the various combinations of additional
configuration options and refer to (new) documentation in the man
page that explains it in more detail than what can be printed in an
advice message.

Finally, add new tests to verify the new functionality.

Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
---
    status: long status advice adapted to recent capabilities
    
    Here is version 5 for this patch.
    
    Changes since v4:
    
     * Test improvements (readability, isolation. ...)
     * Doc improvements (referencing other docs, adding advice to try again,
       ...)
     * Minor logic simplifications

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

Range-diff vs v4:

 1:  85b35882c02 ! 1:  8b1b9ee094f status: long status advice adapted to recent capabilities
     @@ Documentation/git-status.txt: during the write may conflict with other simultane
      +--------------------------------
      +
      +`git status` can be very slow in large worktrees if/when it
     -+needs to search for untracked files and directories.  There are
     ++needs to search for untracked files and directories. There are
      +many configuration options available to speed this up by either
      +avoiding the work or making use of cached results from previous
     -+Git commands.  Since we all work in different ways, there is no
     -+single optimum set of settings right for everyone.  Here is a
     -+brief summary of the relevant options to help you choose which
     -+is right for you.  Each of these settings is independently
     -+documented elsewhere in more detail, so please refer to them
     -+for complete details.
     -+
     -+* The `-uno` flag or the `status.showUntrackedfiles=false`
     -+    config : indicate that `git status` should not report untracked
     ++Git commands. There is no single optimum set of settings right
     ++for everyone.  Here is a brief summary of the relevant options
     ++to help you choose which is right for you.
     ++
     ++* First, you may want to run `git status` again. Your current
     ++	configuration may already be caching `git status` results,
     ++	so it could be faster on subsequent runs.
     ++
     ++* The `--untracked-files=no` flag or the
     ++	`status.showUntrackedfiles=false` config (see above for both) :
     ++	indicate that `git status` should not report untracked
      +	files. This is the fastest option. `git status` will not list
      +	the untracked files, so you need to be careful to remember if
      +	you create any new files and manually `git add` them.
      +
     -+* `advice.statusUoption=false` : this config option disables a
     -+	warning message when the search for untracked files takes longer
     -+	than desired. In some large repositories, this message may appear
     -+	frequently and not be a helpful signal.
     -+
     -+* `core.untrackedCache=true` : enable the untracked cache feature
     -+    and only search directories that have been modified since the
     -+    previous `git status` command.  Git remembers the set of
     -+    untracked files within each directory and assumes that if a
     -+    directory has not been modified, then the set of untracked
     -+    file within has not changed.  This is much faster than
     -+    enumerating the contents of every directory, but still not
     -+    without cost, because Git still has to search for the set of
     -+    modified directories. The untracked cache is stored in the
     ++* `advice.statusUoption=false` (see linkgit:git-config[1]) :
     ++	this config option disables a warning message when the search
     ++	for untracked files takes longer than desired. In some large
     ++	repositories, this message may appear frequently and not be a
     ++	helpful signal.
     ++
     ++* `core.untrackedCache=true` (see linkgit:git-update-index[1]) :
     ++	enable the untracked cache feature and only search directories
     ++	that have been modified since the previous `git status` command.
     ++	Git remembers the set of untracked files within each directory
     ++	and assumes that if a directory has not been modified, then
     ++	the set of untracked file within has not changed.  This is much
     ++	faster than enumerating the contents of every directory, but still
     ++	not without cost, because Git still has to search for the set of
     ++	modified directories. The untracked cache is stored in the
      +	.git/index file. The reduced cost searching for untracked
      +	files is offset slightly by the increased size of the index and
      +	the cost of keeping it up-to-date. That reduced search time is
      +	usually worth the additional size.
      +
      +* `core.untrackedCache=true` and `core.fsmonitor=true` or
     -+    `core.fsmonitor=<hook_command_pathname>` : enable both the
     -+    untracked cache and FSMonitor features and only search
     -+    directories that have been modified since the previous
     -+    `git status` command.  This is faster than using just the
     -+    untracked cache alone because Git can also avoid searching
     -+    for modified directories.  Git only has to enumerate the
     -+    exact set of directories that have changed recently. While
     -+	the FSMonitor feature can be enabled without the untracked
     -+	cache, the benefits are greatly reduced in that case.
     ++	`core.fsmonitor=<hook_command_pathname>` (see
     ++	linkgit:git-update-index[1]) : enable both the untracked cache
     ++	and FSMonitor features and only search directories that have
     ++	been modified since the previous `git status` command.  This
     ++	is faster than using just the untracked cache alone because
     ++	Git can also avoid searching for modified directories.  Git
     ++	only has to enumerate the exact set of directories that have
     ++	changed recently. While the FSMonitor feature can be enabled
     ++	without the untracked cache, the benefits are greatly reduced
     ++	in that case.
      +
      +Note that after you turn on the untracked cache and/or FSMonitor
      +features it may take a few `git status` commands for the various
     @@ t/t7065-wtstatus-slow.sh (new)
      +
      +. ./test-lib.sh
      +
     -+DATA="$TEST_DIRECTORY/t7065"
     -+
      +GIT_TEST_UF_DELAY_WARNING=1
      +export GIT_TEST_UF_DELAY_WARNING
      +
      +test_expect_success setup '
     -+	git checkout -b test
     ++	git checkout -b test &&
     ++	echo "actual" >> .gitignore &&
     ++	echo "expected" >> .gitignore &&
     ++	echo "out" >> .gitignore &&
     ++	git add .gitignore &&
     ++	git commit -m "Add .gitignore"
      +'
      +
      +test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
     -+	test_must_fail git config --get core.untrackedCache &&
     -+	test_must_fail git config --get core.fsmonitor &&
     -+	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     -+	cat >../expected <<-EOF &&
     -+On branch test
     -+
     -+No commits yet
     -+
     ++	test_might_fail git config --unset-all core.untrackedCache &&
     ++	test_might_fail git config --unset-all core.fsmonitor &&
     ++	git status >out &&
     ++	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     ++	cat >expected <<-\EOF &&
     ++		On branch test
      +
     -+It took X seconds to enumerate untracked files.
     -+See '"'"'git help status'"'"' for information on how to improve this.
     ++		It took X seconds to enumerate untracked files.
     ++		See '"'"'git help status'"'"' for information on how to improve this.
      +
     -+nothing to commit (create/copy files and use "git add" to track)
     ++		nothing to commit, working tree clean
      +	EOF
     -+	test_cmp ../expected ../actual &&
     -+	rm -fr ../actual ../expected
     ++	test_cmp expected actual
      +'
      +
      +test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
      +	git config core.untrackedCache true &&
     -+	test_must_fail git config --get core.fsmonitor &&
     -+	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     -+	cat >../expected <<-EOF &&
     -+On branch test
     ++	test_might_fail git config --unset-all core.fsmonitor &&
     ++	git status >out &&
     ++	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     ++	cat >expected <<-\EOF &&
     ++		On branch test
      +
     -+No commits yet
     ++		It took X seconds to enumerate untracked files.
     ++		See '"'"'git help status'"'"' for information on how to improve this.
      +
     -+
     -+It took X seconds to enumerate untracked files.
     -+See '"'"'git help status'"'"' for information on how to improve this.
     -+
     -+nothing to commit (create/copy files and use "git add" to track)
     ++		nothing to commit, working tree clean
      +	EOF
     -+	test_cmp ../expected ../actual &&
     -+	rm -fr ../actual ../expected
     ++	test_cmp expected actual
      +'
      +
      +test_expect_success 'when core.untrackedCache true, and fsmonitor' '
      +	git config core.untrackedCache true &&
      +	git config core.fsmonitor true &&
     -+	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     -+	cat >../expected <<-EOF &&
     -+On branch test
     -+
     -+No commits yet
     -+
     ++	git status >out &&
     ++	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
     ++	cat >expected <<-\EOF &&
     ++		On branch test
      +
     -+It took X seconds to enumerate untracked files,
     -+but this is currently being cached.
     -+See '"'"'git help status'"'"' for information on how to improve this.
     ++		It took X seconds to enumerate untracked files,
     ++		but this is currently being cached.
     ++		See '"'"'git help status'"'"' for information on how to improve this.
      +
     -+nothing to commit (create/copy files and use "git add" to track)
     ++		nothing to commit, working tree clean
      +	EOF
     -+	test_cmp ../expected ../actual &&
     -+	rm -fr ../actual ../expected
     ++	test_cmp expected actual
      +'
      +
      +test_done
     @@ wt-status.c: static void wt_longstatus_print_tracking(struct wt_status *s)
       
      +static inline int uf_was_slow(uint32_t untracked_in_ms)
      +{
     -+	const char *x;
     -+	x = getenv("GIT_TEST_UF_DELAY_WARNING");
     -+	if (x) {
     ++	if (getenv("GIT_TEST_UF_DELAY_WARNING")) {
      +		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
      +	}
      +


 Documentation/git-status.txt | 59 +++++++++++++++++++++++++++++++
 t/t7065-wtstatus-slow.sh     | 68 ++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 30 +++++++++++++---
 3 files changed, 152 insertions(+), 5 deletions(-)
 create mode 100755 t/t7065-wtstatus-slow.sh

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 5e438a7fdc1..ed1ae3bd35c 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -457,6 +457,65 @@ during the write may conflict with other simultaneous processes, causing
 them to fail. Scripts running `status` in the background should consider
 using `git --no-optional-locks status` (see linkgit:git[1] for details).
 
+UNTRACKED FILES AND STATUS SPEED
+--------------------------------
+
+`git status` can be very slow in large worktrees if/when it
+needs to search for untracked files and directories. There are
+many configuration options available to speed this up by either
+avoiding the work or making use of cached results from previous
+Git commands. There is no single optimum set of settings right
+for everyone.  Here is a brief summary of the relevant options
+to help you choose which is right for you.
+
+* First, you may want to run `git status` again. Your current
+	configuration may already be caching `git status` results,
+	so it could be faster on subsequent runs.
+
+* The `--untracked-files=no` flag or the
+	`status.showUntrackedfiles=false` config (see above for both) :
+	indicate that `git status` should not report untracked
+	files. This is the fastest option. `git status` will not list
+	the untracked files, so you need to be careful to remember if
+	you create any new files and manually `git add` them.
+
+* `advice.statusUoption=false` (see linkgit:git-config[1]) :
+	this config option disables a warning message when the search
+	for untracked files takes longer than desired. In some large
+	repositories, this message may appear frequently and not be a
+	helpful signal.
+
+* `core.untrackedCache=true` (see linkgit:git-update-index[1]) :
+	enable the untracked cache feature and only search directories
+	that have been modified since the previous `git status` command.
+	Git remembers the set of untracked files within each directory
+	and assumes that if a directory has not been modified, then
+	the set of untracked file within has not changed.  This is much
+	faster than enumerating the contents of every directory, but still
+	not without cost, because Git still has to search for the set of
+	modified directories. The untracked cache is stored in the
+	.git/index file. The reduced cost searching for untracked
+	files is offset slightly by the increased size of the index and
+	the cost of keeping it up-to-date. That reduced search time is
+	usually worth the additional size.
+
+* `core.untrackedCache=true` and `core.fsmonitor=true` or
+	`core.fsmonitor=<hook_command_pathname>` (see
+	linkgit:git-update-index[1]) : enable both the untracked cache
+	and FSMonitor features and only search directories that have
+	been modified since the previous `git status` command.  This
+	is faster than using just the untracked cache alone because
+	Git can also avoid searching for modified directories.  Git
+	only has to enumerate the exact set of directories that have
+	changed recently. While the FSMonitor feature can be enabled
+	without the untracked cache, the benefits are greatly reduced
+	in that case.
+
+Note that after you turn on the untracked cache and/or FSMonitor
+features it may take a few `git status` commands for the various
+caches to warm up before you see improved command times.  This is
+normal.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/t/t7065-wtstatus-slow.sh b/t/t7065-wtstatus-slow.sh
new file mode 100755
index 00000000000..bc624756622
--- /dev/null
+++ b/t/t7065-wtstatus-slow.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='test status when slow untracked files'
+
+. ./test-lib.sh
+
+GIT_TEST_UF_DELAY_WARNING=1
+export GIT_TEST_UF_DELAY_WARNING
+
+test_expect_success setup '
+	git checkout -b test &&
+	echo "actual" >> .gitignore &&
+	echo "expected" >> .gitignore &&
+	echo "out" >> .gitignore &&
+	git add .gitignore &&
+	git commit -m "Add .gitignore"
+'
+
+test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
+	test_might_fail git config --unset-all core.untrackedCache &&
+	test_might_fail git config --unset-all core.fsmonitor &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+		On branch test
+
+		It took X seconds to enumerate untracked files.
+		See '"'"'git help status'"'"' for information on how to improve this.
+
+		nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
+	git config core.untrackedCache true &&
+	test_might_fail git config --unset-all core.fsmonitor &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+		On branch test
+
+		It took X seconds to enumerate untracked files.
+		See '"'"'git help status'"'"' for information on how to improve this.
+
+		nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'when core.untrackedCache true, and fsmonitor' '
+	git config core.untrackedCache true &&
+	git config core.fsmonitor true &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+		On branch test
+
+		It took X seconds to enumerate untracked files,
+		but this is currently being cached.
+		See '"'"'git help status'"'"' for information on how to improve this.
+
+		nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..5093bf8c894 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,8 +18,10 @@
 #include "worktree.h"
 #include "lockfile.h"
 #include "sequencer.h"
+#include "fsmonitor-settings.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
+#define UF_DELAY_WARNING_IN_MS (2 * 1000)
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -1205,6 +1207,15 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
+static inline int uf_was_slow(uint32_t untracked_in_ms)
+{
+	if (getenv("GIT_TEST_UF_DELAY_WARNING")) {
+		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
+	}
+
+	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
+}
+
 static void show_merge_in_progress(struct wt_status *s,
 				   const char *color)
 {
@@ -1814,6 +1825,7 @@ static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
@@ -1870,13 +1882,21 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
+		if (uf_was_slow(s->untracked_in_ms) && advice_enabled(ADVICE_STATUS_U_OPTION)) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+			if (fsm_mode > FSMONITOR_MODE_DISABLED) {
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("It took %.2f seconds to enumerate untracked files,\n"
+						"but this is currently being cached."),
+						s->untracked_in_ms / 1000.0);
+			} else {
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("It took %.2f seconds to enumerate untracked files."),
+						s->untracked_in_ms / 1000.0);
+			}
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
-					   "may speed it up, but you have to be careful not to forget to add\n"
-					   "new files yourself (see 'git help status')."),
-					 s->untracked_in_ms / 1000.0);
+					_("See 'git help status' for information on how to improve this."));
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 		}
 	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB8AC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 04:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiKJEqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 23:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKJEqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 23:46:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EB1275F
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 20:46:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o4so619180wrq.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 20:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJt1HsuzSak0mmeLM2N9YCw3AprkN/JvtFtXslZjqCs=;
        b=JtFA9Z3he8WVt+tTF31kFF/ZR3/4nb0WlClf4s4cSrIIv2uYvRduLYU0exbV+ZZfcr
         /j70XxWXFlwTi61PP66fUPIJ80sBj117v7CSVEZG1m11xavfEwnf/dHXuJFRyvYzXs5B
         uVftjtjCFMfF5A5i67wx7cZDz2EVXHGuDmp+Zn/4Zgg9K9zsgH2WmO+K+lZMK3lZJqKc
         RJR6g55gV2adE6rzKL7LqG85ucZF2aLrRJCCbV/4m0kJB6iAVQSl4kgjpgWC9DxI8gUb
         tV295fPxCUudt3SE15c97i1uciUtZ+2mk+RIrteEtZXFqzRBv5NVgEUvtQdInoJ7mSiT
         qAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJt1HsuzSak0mmeLM2N9YCw3AprkN/JvtFtXslZjqCs=;
        b=uiro97fv/tXdtU+4H7me4rH9czOFbxEjIkN+ohrAbFJQ2WmsjF8tfyJzKK/+0NgDJU
         J0rFfG4ISdqGdTJYzVDfIup5ZRX2rl52TcTNpDMfLIlJ7qguKp+qp/qHCDAV97quDJ/L
         qgPMzzgZZelxCDnhgfby1AoUn3UxBA+D8H1VKyRT0WbNfSZ7rwRo85NCvzNPmSN8ujS2
         A8mipJs6GA2veRb3hMga2ntnDUIess3Ygkr4w0su4DM5pTOHIHvb0jzMvpH1ynL2Xu73
         F1s5jTNGnNzgaKECYIHRCaLmeNIgrviTosKIdDnbnywdpGrLkuZVH19FCQ7Jrtyq5pID
         MWPg==
X-Gm-Message-State: ACrzQf2U9Pp/aOEv+SMX1lYbJzkxUjn2NvO+dwH86on5Z1XLcJfPXwY6
        8StrXw46SnUS0QzEiIKO1UllLncUGfY=
X-Google-Smtp-Source: AMsMyM52KJsHjqPs+qcQxF4GstXwHWIWzyofoyUxEaGNpVuYU7ElJvf5OSvFXYEqsU7/+5GnvYeBTA==
X-Received: by 2002:adf:aa89:0:b0:236:64ce:2c0a with SMTP id h9-20020adfaa89000000b0023664ce2c0amr961709wrc.230.1668055575753;
        Wed, 09 Nov 2022 20:46:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5404000000b00228d52b935asm14944376wrv.71.2022.11.09.20.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 20:46:15 -0800 (PST)
Message-Id: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
References: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 04:46:13 +0000
Subject: [PATCH v4] status: long status advice adapted to recent capabilities
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
    
    Here is version 4 for this patch.
    
    Changes since v3:
    
     * Integrated all feedback on the doc content itself, as is.
     * Moved the small test files into here docs in the test code.
     * Fix some awkward indentations.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

Range-diff vs v3:

 1:  3c98492cb82 ! 1:  85b35882c02 status: long status advice adapted to recent capabilities
     @@ Documentation/git-status.txt: during the write may conflict with other simultane
      +documented elsewhere in more detail, so please refer to them
      +for complete details.
      +
     -+* `-uno` or `status.showUntrackedFiles=false` : just don't search
     -+    and don't report on untracked files.  This is the fastest.
     -+    `git status` will not list the untracked files, so you need
     -+    to be careful to remember if you create any new files and
     -+    manually `git add` them.
     ++* The `-uno` flag or the `status.showUntrackedfiles=false`
     ++    config : indicate that `git status` should not report untracked
     ++	files. This is the fastest option. `git status` will not list
     ++	the untracked files, so you need to be careful to remember if
     ++	you create any new files and manually `git add` them.
      +
     -+* `advice.statusUoption=false` : search, but don't complain if it
     -+    takes too long.
     ++* `advice.statusUoption=false` : this config option disables a
     ++	warning message when the search for untracked files takes longer
     ++	than desired. In some large repositories, this message may appear
     ++	frequently and not be a helpful signal.
      +
      +* `core.untrackedCache=true` : enable the untracked cache feature
      +    and only search directories that have been modified since the
     @@ Documentation/git-status.txt: during the write may conflict with other simultane
      +    file within has not changed.  This is much faster than
      +    enumerating the contents of every directory, but still not
      +    without cost, because Git still has to search for the set of
     -+    modified directories.
     ++    modified directories. The untracked cache is stored in the
     ++	.git/index file. The reduced cost searching for untracked
     ++	files is offset slightly by the increased size of the index and
     ++	the cost of keeping it up-to-date. That reduced search time is
     ++	usually worth the additional size.
      +
      +* `core.untrackedCache=true` and `core.fsmonitor=true` or
      +    `core.fsmonitor=<hook_command_pathname>` : enable both the
     @@ Documentation/git-status.txt: during the write may conflict with other simultane
      +    `git status` command.  This is faster than using just the
      +    untracked cache alone because Git can also avoid searching
      +    for modified directories.  Git only has to enumerate the
     -+    exact set of directories that have changed recently.
     ++    exact set of directories that have changed recently. While
     ++	the FSMonitor feature can be enabled without the untracked
     ++	cache, the benefits are greatly reduced in that case.
      +
      +Note that after you turn on the untracked cache and/or FSMonitor
      +features it may take a few `git status` commands for the various
     @@ t/t7065-wtstatus-slow.sh (new)
      +test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
      +	test_must_fail git config --get core.untrackedCache &&
      +	test_must_fail git config --get core.fsmonitor &&
     -+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     -+    test_cmp "$DATA/no_untrackedcache_no_fsmonitor" ../actual &&
     -+    rm -fr ../actual
     -+'
     -+
     -+test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
     -+    git config core.untrackedCache true &&
     -+	test_must_fail git config --get core.fsmonitor &&
     -+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     -+    test_cmp "$DATA/with_untrackedcache_no_fsmonitor" ../actual &&
     -+    rm -fr ../actual
     -+'
     -+
     -+test_expect_success 'when core.untrackedCache true, and fsmonitor' '
     -+    git config core.untrackedCache true &&
     -+	git config core.fsmonitor true &&
     -+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     -+    test_cmp "$DATA/with_untrackedcache_with_fsmonitor" ../actual &&
     -+    rm -fr ../actual
     -+'
     -+
     -+test_done
     -
     - ## t/t7065/no_untrackedcache_no_fsmonitor (new) ##
     -@@
     ++	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     ++	cat >../expected <<-EOF &&
      +On branch test
      +
      +No commits yet
      +
      +
      +It took X seconds to enumerate untracked files.
     -+See 'git help status' for information on how to improve this.
     ++See '"'"'git help status'"'"' for information on how to improve this.
      +
      +nothing to commit (create/copy files and use "git add" to track)
     -
     - ## t/t7065/with_untrackedcache_no_fsmonitor (new) ##
     -@@
     ++	EOF
     ++	test_cmp ../expected ../actual &&
     ++	rm -fr ../actual ../expected
     ++'
     ++
     ++test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
     ++	git config core.untrackedCache true &&
     ++	test_must_fail git config --get core.fsmonitor &&
     ++	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     ++	cat >../expected <<-EOF &&
      +On branch test
      +
      +No commits yet
      +
      +
      +It took X seconds to enumerate untracked files.
     -+See 'git help status' for information on how to improve this.
     ++See '"'"'git help status'"'"' for information on how to improve this.
      +
      +nothing to commit (create/copy files and use "git add" to track)
     -
     - ## t/t7065/with_untrackedcache_with_fsmonitor (new) ##
     -@@
     ++	EOF
     ++	test_cmp ../expected ../actual &&
     ++	rm -fr ../actual ../expected
     ++'
     ++
     ++test_expect_success 'when core.untrackedCache true, and fsmonitor' '
     ++	git config core.untrackedCache true &&
     ++	git config core.fsmonitor true &&
     ++	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     ++	cat >../expected <<-EOF &&
      +On branch test
      +
      +No commits yet
     @@ t/t7065/with_untrackedcache_with_fsmonitor (new)
      +
      +It took X seconds to enumerate untracked files,
      +but this is currently being cached.
     -+See 'git help status' for information on how to improve this.
     ++See '"'"'git help status'"'"' for information on how to improve this.
      +
      +nothing to commit (create/copy files and use "git add" to track)
     ++	EOF
     ++	test_cmp ../expected ../actual &&
     ++	rm -fr ../actual ../expected
     ++'
     ++
     ++test_done
      
       ## wt-status.c ##
      @@
     @@ wt-status.c: static void wt_longstatus_print(struct wt_status *s)
       		if (s->show_ignored_mode)
       			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
      -		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
     --			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
     --			status_printf_ln(s, GIT_COLOR_NORMAL,
     ++		if (uf_was_slow(s->untracked_in_ms) && advice_enabled(ADVICE_STATUS_U_OPTION)) {
     + 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
     ++			if (fsm_mode > FSMONITOR_MODE_DISABLED) {
     ++				status_printf_ln(s, GIT_COLOR_NORMAL,
     ++						_("It took %.2f seconds to enumerate untracked files,\n"
     ++						"but this is currently being cached."),
     ++						s->untracked_in_ms / 1000.0);
     ++			} else {
     ++				status_printf_ln(s, GIT_COLOR_NORMAL,
     ++						_("It took %.2f seconds to enumerate untracked files."),
     ++						s->untracked_in_ms / 1000.0);
     ++			}
     + 			status_printf_ln(s, GIT_COLOR_NORMAL,
      -					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
      -					   "may speed it up, but you have to be careful not to forget to add\n"
      -					   "new files yourself (see 'git help status')."),
      -					 s->untracked_in_ms / 1000.0);
     -+		if (uf_was_slow(s->untracked_in_ms)) {
     -+			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
     -+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
     -+				if (fsm_mode > FSMONITOR_MODE_DISABLED) {
     -+					status_printf_ln(s, GIT_COLOR_NORMAL,
     -+							_("It took %.2f seconds to enumerate untracked files,\n"
     -+							"but this is currently being cached."),
     -+							s->untracked_in_ms / 1000.0);
     -+				} else {
     -+					status_printf_ln(s, GIT_COLOR_NORMAL,
     -+							_("It took %.2f seconds to enumerate untracked files."),
     -+							s->untracked_in_ms / 1000.0);
     -+				}
     -+				status_printf_ln(s, GIT_COLOR_NORMAL,
     -+						_("See 'git help status' for information on how to improve this."));
     -+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
     -+			}
     ++					_("See 'git help status' for information on how to improve this."));
     ++			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
       		}
       	} else if (s->committable)
       		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),


 Documentation/git-status.txt | 55 +++++++++++++++++++++++++++
 t/t7065-wtstatus-slow.sh     | 74 ++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 32 +++++++++++++---
 3 files changed, 156 insertions(+), 5 deletions(-)
 create mode 100755 t/t7065-wtstatus-slow.sh

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 54a4b29b473..c51ba5e79e1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -457,6 +457,61 @@ during the write may conflict with other simultaneous processes, causing
 them to fail. Scripts running `status` in the background should consider
 using `git --no-optional-locks status` (see linkgit:git[1] for details).
 
+UNTRACKED FILES AND STATUS SPEED
+--------------------------------
+
+`git status` can be very slow in large worktrees if/when it
+needs to search for untracked files and directories.  There are
+many configuration options available to speed this up by either
+avoiding the work or making use of cached results from previous
+Git commands.  Since we all work in different ways, there is no
+single optimum set of settings right for everyone.  Here is a
+brief summary of the relevant options to help you choose which
+is right for you.  Each of these settings is independently
+documented elsewhere in more detail, so please refer to them
+for complete details.
+
+* The `-uno` flag or the `status.showUntrackedfiles=false`
+    config : indicate that `git status` should not report untracked
+	files. This is the fastest option. `git status` will not list
+	the untracked files, so you need to be careful to remember if
+	you create any new files and manually `git add` them.
+
+* `advice.statusUoption=false` : this config option disables a
+	warning message when the search for untracked files takes longer
+	than desired. In some large repositories, this message may appear
+	frequently and not be a helpful signal.
+
+* `core.untrackedCache=true` : enable the untracked cache feature
+    and only search directories that have been modified since the
+    previous `git status` command.  Git remembers the set of
+    untracked files within each directory and assumes that if a
+    directory has not been modified, then the set of untracked
+    file within has not changed.  This is much faster than
+    enumerating the contents of every directory, but still not
+    without cost, because Git still has to search for the set of
+    modified directories. The untracked cache is stored in the
+	.git/index file. The reduced cost searching for untracked
+	files is offset slightly by the increased size of the index and
+	the cost of keeping it up-to-date. That reduced search time is
+	usually worth the additional size.
+
+* `core.untrackedCache=true` and `core.fsmonitor=true` or
+    `core.fsmonitor=<hook_command_pathname>` : enable both the
+    untracked cache and FSMonitor features and only search
+    directories that have been modified since the previous
+    `git status` command.  This is faster than using just the
+    untracked cache alone because Git can also avoid searching
+    for modified directories.  Git only has to enumerate the
+    exact set of directories that have changed recently. While
+	the FSMonitor feature can be enabled without the untracked
+	cache, the benefits are greatly reduced in that case.
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
index 00000000000..468b8934836
--- /dev/null
+++ b/t/t7065-wtstatus-slow.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='test status when slow untracked files'
+
+. ./test-lib.sh
+
+DATA="$TEST_DIRECTORY/t7065"
+
+GIT_TEST_UF_DELAY_WARNING=1
+export GIT_TEST_UF_DELAY_WARNING
+
+test_expect_success setup '
+	git checkout -b test
+'
+
+test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
+	test_must_fail git config --get core.untrackedCache &&
+	test_must_fail git config --get core.fsmonitor &&
+	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+	cat >../expected <<-EOF &&
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files.
+See '"'"'git help status'"'"' for information on how to improve this.
+
+nothing to commit (create/copy files and use "git add" to track)
+	EOF
+	test_cmp ../expected ../actual &&
+	rm -fr ../actual ../expected
+'
+
+test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
+	git config core.untrackedCache true &&
+	test_must_fail git config --get core.fsmonitor &&
+	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+	cat >../expected <<-EOF &&
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files.
+See '"'"'git help status'"'"' for information on how to improve this.
+
+nothing to commit (create/copy files and use "git add" to track)
+	EOF
+	test_cmp ../expected ../actual &&
+	rm -fr ../actual ../expected
+'
+
+test_expect_success 'when core.untrackedCache true, and fsmonitor' '
+	git config core.untrackedCache true &&
+	git config core.fsmonitor true &&
+	git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+	cat >../expected <<-EOF &&
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files,
+but this is currently being cached.
+See '"'"'git help status'"'"' for information on how to improve this.
+
+nothing to commit (create/copy files and use "git add" to track)
+	EOF
+	test_cmp ../expected ../actual &&
+	rm -fr ../actual ../expected
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..336f41e6d9f 100644
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
@@ -1205,6 +1207,17 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
+static inline int uf_was_slow(uint32_t untracked_in_ms)
+{
+	const char *x;
+	x = getenv("GIT_TEST_UF_DELAY_WARNING");
+	if (x) {
+		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
+	}
+
+	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
+}
+
 static void show_merge_in_progress(struct wt_status *s,
 				   const char *color)
 {
@@ -1814,6 +1827,7 @@ static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
@@ -1870,13 +1884,21 @@ static void wt_longstatus_print(struct wt_status *s)
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

base-commit: bbe21b64a08f89475d8a3818e20c111378daa621
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB0C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiKVQ7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiKVQ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 11:59:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8A49B7C
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:59:42 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d1so13554284wrs.12
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLWT2U/hErftbaIrsOxytbbjqGA01jWqXwk/JK65o3I=;
        b=OpN6bxPj7H6JqOfKwYcrGyEfN2XOva5rsDddU3L6e/+O6R2wola8mT/MTAg/9/Ejfj
         H/ir5yaXTZj+s2NX+EU6WSodunoOuJAcW4NosMEFo0AQwL/M9IpSCxDFnz50AkPHGT36
         xJV/vCcc93z1IIWrsAnkAHkMCkMj81+ym3Kc+A5iQPwcFwJTB9Q52j6dvjh8CCFeFljq
         zjQtG5lHNlo9e8FSDkTG+vTtHwuI7MwNLzKzC3Y2NnlD3e97DFUuwXan01TNCxQwBUWI
         vN0L/e91/Uo2gYEFe/7mZZ60+e0EctuqzEq9QsWs6KtK/+mSMpdLuUEjFcWlfSUTfiHr
         8r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLWT2U/hErftbaIrsOxytbbjqGA01jWqXwk/JK65o3I=;
        b=6rBqkgRQf2d7p54SHRWUFhkkpPuYRIeJ8ZzOx0b7EuBGntyucEwhyAEQ8qDt+V7HqE
         ushVUfMJb6dYkOk/k+3gjYIIw1OeeFV+dzdyn3CWwoYgVAbqDL8w9WUS8wn3UPf/k8cZ
         3w5TUC6E15udP7XLdLMACBiAcCZw5egKOKSBVftP3F1z031yE1n2MZLCaUAwSaWBXze5
         UNWB1YT1uhjc5IR5U1/MJkZFPDwS4xY3TIphP4RnRB3vaIVmKuxkOfkW5viqgrDVdwcP
         w/t9qJkuGJylEE7dEKQ+ByH0j2qp8fdkH31ea4ApkVUH4+zCZMALSaGxCyzkHlScWxbK
         xvvw==
X-Gm-Message-State: ANoB5pluPnL1NdqPPOlayz0Y4HXS5sAPQnoxU/8C3UcGTZhAZpsf1PjO
        C9fDRbTuyWIASgGHnAk3NjCd58s2ytM=
X-Google-Smtp-Source: AA0mqf6GfQLo++yXUXWgi4zppZuH5h1LCvBxh5qn5reuexH9NFrI3Ysbc0Q4n4ra6iZqJQgzR/Vkgw==
X-Received: by 2002:a5d:6b46:0:b0:236:56a6:823e with SMTP id x6-20020a5d6b46000000b0023656a6823emr14681467wrw.495.1669136380192;
        Tue, 22 Nov 2022 08:59:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003a3170a7af9sm18661877wmo.4.2022.11.22.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:59:39 -0800 (PST)
Message-Id: <pull.1384.v7.git.1669136378754.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com>
References: <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 16:59:38 +0000
Subject: [PATCH v7] status: modernize git-status "slow untracked files" advice
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

`git status` can be slow when there are a large number of
untracked files and directories since Git must search the entire
worktree to enumerate them.  When it is too slow, Git prints
advice with the elapsed search time and a suggestion to disable
the search using the `-uno` option.  This suggestion also carries
a warning that might scare off some users.

However, these days, `-uno` isn't the only option.  Git can reduce
the size and time of the untracked file search when the
`core.untrackedCache` and `core.fsmonitor` features are enabled by
caching results from previous `git status` invocations.

Therefore, update the `git status` man page to explain the various
configuration options, and update the advice to provide more
detail about the current configuration and to refer to the updated
documentation.

Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
---
    status: modernize git-status "slow untracked files" advice
    
    Here is version 7 for this patch.
    
    Changes since v6:
    
     * Readability improvements in tests
     * Rewrite of the commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

Range-diff vs v6:

 1:  ff3aa0e01c0 ! 1:  871a9becbdf status: long status advice adapted to recent capabilities
     @@ Metadata
      Author: Rudy Rigot <rudy.rigot@gmail.com>
      
       ## Commit message ##
     -    status: long status advice adapted to recent capabilities
     +    status: modernize git-status "slow untracked files" advice
      
     -    Improve the advice displayed when `git status` is slow because
     -    of excessive numbers of untracked files.  Update the `git status`
     -    man page to explain the various configuration options.
     +    `git status` can be slow when there are a large number of
     +    untracked files and directories since Git must search the entire
     +    worktree to enumerate them.  When it is too slow, Git prints
     +    advice with the elapsed search time and a suggestion to disable
     +    the search using the `-uno` option.  This suggestion also carries
     +    a warning that might scare off some users.
      
     -    `git status` can be slow when there are a large number of untracked
     -    files and directories, because Git must search the entire worktree
     -    to enumerate them.  Previously, Git would print an advice message
     -    with the elapsed search time and a suggestion to disable the search
     -    using the `-uno` option.  This suggestion also carried a warning
     -    that might scare off some users.
     +    However, these days, `-uno` isn't the only option.  Git can reduce
     +    the size and time of the untracked file search when the
     +    `core.untrackedCache` and `core.fsmonitor` features are enabled by
     +    caching results from previous `git status` invocations.
      
     -    Git can reduce the size and time of the untracked file search when
     -    the `core.untrackedCache` and `core.fsmonitor` features are enabled
     -    by caching results from previous `git status` invocations.
     -
     -    Update the advice to explain the various combinations of additional
     -    configuration options and refer to (new) documentation in the man
     -    page that explains it in more detail than what can be printed in an
     -    advice message.
     -
     -    Finally, add new tests to verify the new functionality.
     +    Therefore, update the `git status` man page to explain the various
     +    configuration options, and update the advice to provide more
     +    detail about the current configuration and to refer to the updated
     +    documentation.
      
          Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
      
     @@ t/t7065-wtstatus-slow.sh (new)
      +
      +test_description='test status when slow untracked files'
      +
     -+. ./test-lib.sh
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +
      +GIT_TEST_UF_DELAY_WARNING=1
      +export GIT_TEST_UF_DELAY_WARNING
      +
     ++. ./test-lib.sh
     ++
      +test_expect_success setup '
     -+	git checkout -b test &&
      +	cat >.gitignore <<-\EOF &&
      +	/actual
      +	/expected
     @@ t/t7065-wtstatus-slow.sh (new)
      +'
      +
      +test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
     -+	test_might_fail git config --unset-all core.untrackedCache &&
     -+	test_might_fail git config --unset-all core.fsmonitor &&
     ++	test_unconfig core.untrackedCache &&
     ++	test_unconfig core.fsmonitor &&
      +	git status >out &&
      +	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
      +	cat >expected <<-\EOF &&
     -+	On branch test
     ++	On branch main
      +
      +	It took X seconds to enumerate untracked files.
      +	See '"'"'git help status'"'"' for information on how to improve this.
     @@ t/t7065-wtstatus-slow.sh (new)
      +
      +test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
      +	test_config core.untrackedCache true &&
     -+	test_might_fail git config --unset-all core.fsmonitor &&
     ++	test_unconfig core.fsmonitor &&
      +	git status >out &&
      +	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
      +	cat >expected <<-\EOF &&
     -+	On branch test
     ++	On branch main
      +
      +	It took X seconds to enumerate untracked files.
      +	See '"'"'git help status'"'"' for information on how to improve this.
     @@ t/t7065-wtstatus-slow.sh (new)
      +	git status >out &&
      +	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
      +	cat >expected <<-\EOF &&
     -+	On branch test
     ++	On branch main
      +
      +	It took X seconds to enumerate untracked files,
      +	but the results were cached, and subsequent runs may be faster.


 Documentation/git-status.txt | 59 +++++++++++++++++++++++++++++
 t/t7065-wtstatus-slow.sh     | 72 ++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 28 +++++++++++---
 3 files changed, 154 insertions(+), 5 deletions(-)
 create mode 100755 t/t7065-wtstatus-slow.sh

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 5e438a7fdc1..570c36e07c1 100644
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
+	the set of untracked files within has not changed.  This is much
+	faster than enumerating the contents of every directory, but still
+	not without cost, because Git still has to search for the set of
+	modified directories. The untracked cache is stored in the
+	`.git/index` file. The reduced cost of searching for untracked
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
index 00000000000..6733e8ba36b
--- /dev/null
+++ b/t/t7065-wtstatus-slow.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='test status when slow untracked files'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+GIT_TEST_UF_DELAY_WARNING=1
+export GIT_TEST_UF_DELAY_WARNING
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	cat >.gitignore <<-\EOF &&
+	/actual
+	/expected
+	/out
+	EOF
+	git add .gitignore &&
+	git commit -m "Add .gitignore"
+'
+
+test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
+	test_unconfig core.untrackedCache &&
+	test_unconfig core.fsmonitor &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+	On branch main
+
+	It took X seconds to enumerate untracked files.
+	See '"'"'git help status'"'"' for information on how to improve this.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
+	test_config core.untrackedCache true &&
+	test_unconfig core.fsmonitor &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+	On branch main
+
+	It took X seconds to enumerate untracked files.
+	See '"'"'git help status'"'"' for information on how to improve this.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'when core.untrackedCache true, and fsmonitor' '
+	test_config core.untrackedCache true &&
+	test_config core.fsmonitor true &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+	On branch main
+
+	It took X seconds to enumerate untracked files,
+	but the results were cached, and subsequent runs may be faster.
+	See '"'"'git help status'"'"' for information on how to improve this.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..1f6d64e759f 100644
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
@@ -1205,6 +1207,13 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
+static int uf_was_slow(uint32_t untracked_in_ms)
+{
+	if (getenv("GIT_TEST_UF_DELAY_WARNING"))
+		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
+	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
+}
+
 static void show_merge_in_progress(struct wt_status *s,
 				   const char *color)
 {
@@ -1814,6 +1823,7 @@ static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
@@ -1870,13 +1880,21 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
+		if (advice_enabled(ADVICE_STATUS_U_OPTION) && uf_was_slow(s->untracked_in_ms)) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+			if (fsm_mode > FSMONITOR_MODE_DISABLED) {
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("It took %.2f seconds to enumerate untracked files,\n"
+						"but the results were cached, and subsequent runs may be faster."),
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

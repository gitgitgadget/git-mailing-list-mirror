Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE8FC4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 21:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiKOVUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 16:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiKOVUC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 16:20:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A12790B
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:19:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k8so26584143wrh.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGXF/P4GxwcZD8KNsQNRfkcQqjFMC3h5jFuMEIrF4HM=;
        b=Y8JpucXmj6On+W65oQzfZCNhwQ3gVn3N8nErXVnOgaVARAMaYPyNVWyXidwVrWyCaA
         fWPF/3wIfcnu8erubaK1AZ2XjrcoLxW9WWTw2a6DjW9BG6dYYFCChRP3ZymxeEeoPupp
         l5CqiWv2xn6UAxxgdMjAXymYcFPVaIdMyg0WgFtvKQLotuHqNHF5WEZTt5K53c8+oO8n
         pLiJI9TcMsvXzH6en/3DrDiD9/hpGteAsRROKGI+EzasGA3ofumWbYIIjde5v1Xm6S53
         YvH8DEaFuS/+x/NryUnbM5c8CFAm2FS5q+ppNu0E1ACRFONRmBH19iRkzO2TIEkk/aY+
         Sw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGXF/P4GxwcZD8KNsQNRfkcQqjFMC3h5jFuMEIrF4HM=;
        b=gSNd1Nb5MlxrYQYuFm1YpKiiUVBKIJke5Zgl46JQ3sRcRhLG2MNU9Wor7zyyqbZib5
         1tZpmL2ITr48ai328hq6qGqLIPi5pj8xVx9JLKqQxILXhM8Udcv4ZSd0B6aEL9gC7GTl
         2ZPbUDMvBnHOfUCTegxRF9ScIPnzUP+xDM7vcdjNfD2CBRx4oW6eed9XBAWhdjrzpTl7
         f9L+RQo0iKnCDJzbRQHS/L0/gMZUkUCf4R3WiKrNre6SisZkV94t/Tmonfgqxo6Gy0SC
         ReD2yjn/yy1iYxw1TT5KlUEGgyCGIBF7i7Sef1BCHDososWQ81LuIfgDZeiVMNUYXOJS
         iQCQ==
X-Gm-Message-State: ANoB5pms4KYVE0WIdJg/+C/s7B6Ci5BUkSU3pn1LGkpgllRXwKnqZlMQ
        OH7xt9G+LKzdGVS5cdxXPsh4NBRYI+k=
X-Google-Smtp-Source: AA0mqf4Awdky9CC16/m4hy/YTfgq9AGKqe34N883xLt6wxHawEVhfOBvMlQLOOVBzOVpLbiHIJaxvw==
X-Received: by 2002:adf:f4c3:0:b0:22e:3498:9adb with SMTP id h3-20020adff4c3000000b0022e34989adbmr12574808wrp.335.1668547189662;
        Tue, 15 Nov 2022 13:19:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a84375d0d1sm25181479wmq.44.2022.11.15.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:19:49 -0800 (PST)
Message-Id: <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Nov 2022 21:19:47 +0000
Subject: [PATCH v6] status: long status advice adapted to recent capabilities
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
    
    Here is version 6 for this patch.
    
    Changes since v5:
    
     * End of sentence for fsmonitor case was changed to "but the results
       were cached, and subsequent runs may be faster."
     * Except for that, mostly style and doc fixes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

Range-diff vs v5:

 1:  8b1b9ee094f ! 1:  ff3aa0e01c0 status: long status advice adapted to recent capabilities
     @@ Documentation/git-status.txt: during the write may conflict with other simultane
      +	that have been modified since the previous `git status` command.
      +	Git remembers the set of untracked files within each directory
      +	and assumes that if a directory has not been modified, then
     -+	the set of untracked file within has not changed.  This is much
     ++	the set of untracked files within has not changed.  This is much
      +	faster than enumerating the contents of every directory, but still
      +	not without cost, because Git still has to search for the set of
      +	modified directories. The untracked cache is stored in the
     -+	.git/index file. The reduced cost searching for untracked
     ++	`.git/index` file. The reduced cost of searching for untracked
      +	files is offset slightly by the increased size of the index and
      +	the cost of keeping it up-to-date. That reduced search time is
      +	usually worth the additional size.
     @@ t/t7065-wtstatus-slow.sh (new)
      +
      +test_expect_success setup '
      +	git checkout -b test &&
     -+	echo "actual" >> .gitignore &&
     -+	echo "expected" >> .gitignore &&
     -+	echo "out" >> .gitignore &&
     ++	cat >.gitignore <<-\EOF &&
     ++	/actual
     ++	/expected
     ++	/out
     ++	EOF
      +	git add .gitignore &&
      +	git commit -m "Add .gitignore"
      +'
     @@ t/t7065-wtstatus-slow.sh (new)
      +	git status >out &&
      +	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
      +	cat >expected <<-\EOF &&
     -+		On branch test
     ++	On branch test
      +
     -+		It took X seconds to enumerate untracked files.
     -+		See '"'"'git help status'"'"' for information on how to improve this.
     ++	It took X seconds to enumerate untracked files.
     ++	See '"'"'git help status'"'"' for information on how to improve this.
      +
     -+		nothing to commit, working tree clean
     ++	nothing to commit, working tree clean
      +	EOF
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
     -+	git config core.untrackedCache true &&
     ++	test_config core.untrackedCache true &&
      +	test_might_fail git config --unset-all core.fsmonitor &&
      +	git status >out &&
      +	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
      +	cat >expected <<-\EOF &&
     -+		On branch test
     ++	On branch test
      +
     -+		It took X seconds to enumerate untracked files.
     -+		See '"'"'git help status'"'"' for information on how to improve this.
     ++	It took X seconds to enumerate untracked files.
     ++	See '"'"'git help status'"'"' for information on how to improve this.
      +
     -+		nothing to commit, working tree clean
     ++	nothing to commit, working tree clean
      +	EOF
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'when core.untrackedCache true, and fsmonitor' '
     -+	git config core.untrackedCache true &&
     -+	git config core.fsmonitor true &&
     ++	test_config core.untrackedCache true &&
     ++	test_config core.fsmonitor true &&
      +	git status >out &&
      +	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
      +	cat >expected <<-\EOF &&
     -+		On branch test
     ++	On branch test
      +
     -+		It took X seconds to enumerate untracked files,
     -+		but this is currently being cached.
     -+		See '"'"'git help status'"'"' for information on how to improve this.
     ++	It took X seconds to enumerate untracked files,
     ++	but the results were cached, and subsequent runs may be faster.
     ++	See '"'"'git help status'"'"' for information on how to improve this.
      +
     -+		nothing to commit, working tree clean
     ++	nothing to commit, working tree clean
      +	EOF
      +	test_cmp expected actual
      +'
     @@ wt-status.c: static void wt_longstatus_print_tracking(struct wt_status *s)
       	strbuf_release(&sb);
       }
       
     -+static inline int uf_was_slow(uint32_t untracked_in_ms)
     ++static int uf_was_slow(uint32_t untracked_in_ms)
      +{
     -+	if (getenv("GIT_TEST_UF_DELAY_WARNING")) {
     ++	if (getenv("GIT_TEST_UF_DELAY_WARNING"))
      +		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
     -+	}
     -+
      +	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
      +}
      +
     @@ wt-status.c: static void wt_longstatus_print(struct wt_status *s)
       		if (s->show_ignored_mode)
       			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
      -		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
     -+		if (uf_was_slow(s->untracked_in_ms) && advice_enabled(ADVICE_STATUS_U_OPTION)) {
     ++		if (advice_enabled(ADVICE_STATUS_U_OPTION) && uf_was_slow(s->untracked_in_ms)) {
       			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
      +			if (fsm_mode > FSMONITOR_MODE_DISABLED) {
      +				status_printf_ln(s, GIT_COLOR_NORMAL,
      +						_("It took %.2f seconds to enumerate untracked files,\n"
     -+						"but this is currently being cached."),
     ++						"but the results were cached, and subsequent runs may be faster."),
      +						s->untracked_in_ms / 1000.0);
      +			} else {
      +				status_printf_ln(s, GIT_COLOR_NORMAL,


 Documentation/git-status.txt | 59 ++++++++++++++++++++++++++++++
 t/t7065-wtstatus-slow.sh     | 70 ++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 28 ++++++++++++---
 3 files changed, 152 insertions(+), 5 deletions(-)
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
index 00000000000..8d08a962f88
--- /dev/null
+++ b/t/t7065-wtstatus-slow.sh
@@ -0,0 +1,70 @@
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
+	test_might_fail git config --unset-all core.untrackedCache &&
+	test_might_fail git config --unset-all core.fsmonitor &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+	On branch test
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
+	test_might_fail git config --unset-all core.fsmonitor &&
+	git status >out &&
+	sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
+	cat >expected <<-\EOF &&
+	On branch test
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
+	On branch test
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

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A7FA3741
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 00:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJ2AGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 20:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJ2AGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 20:06:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A38F214646
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 17:06:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y16so8461510wrt.12
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 17:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+tc8AgQuESJQbHL48P95PlLax5hXzJKd0Vga4ZKRjM=;
        b=BXONVWBkf2RCHddnlumiKMX0wYKzWYY1MVbnJqhyjZFe3d+A0y7EqKbUtk7gV5B4ui
         Qjn/HCb9TA+fTNKPXj9a5qsb2/vwhLc/bvlCZV0xxH+jFy/Fl/JoBOBYdw1hpDzqmb3/
         K1ZboXVlwDE8iDtd5rMRj+IiCAFR/SfLlIB3JQSxwdtxVyFxFBho78g6tggsY+a3HUgQ
         37/1PQv7GvQKOjxk6MpghoG9FclFvQVNemxYD4OXRnWnCLvUdhF9Qn4JlCZQJzK0rCjJ
         YCyKdyJIfC0ealuk/XGvBuXPJ++EFXtS4SjO9AywI/UGHqVCtigoFqPsuJE/YKDgwpot
         nS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+tc8AgQuESJQbHL48P95PlLax5hXzJKd0Vga4ZKRjM=;
        b=1v5xzSbMnEKr0LfS78sG/nSkVFA8O0yw4u2zKYQOaJV5AQlN+iBEMM9tyR3XTdmzng
         /1av84jRjLjLEmrByux/pGP7AMLzzUpVcKgIolWZabPbLael1X6fmJ3XxOC1iN7P33X6
         0qrupcIseBsdn6zBh8L3VCoAP6yZXIQXNbAuPmtu7zcac9baTkDp4e9hAERtW6D1HROd
         e7BE4tFp+r77LmGE+BSGjHIsNa2QtZ0czuyPAi6noFQl1/Li4ApzajL8quCWw34ZJhYs
         HAudSV1bf1fh8HrYadiGCrb6Kct+KkraEM4MFf+B+NGZTHl6Qb9MK+ti83d7AtCFWUfn
         Ftog==
X-Gm-Message-State: ACrzQf3HgpvqjkpdBlP5wqY3a+Q3cslAONzmRaMUxyPM6hXK9zaqs4Hm
        Xj0k7dlNZ034KQ/+4XIVnZ3FWm76GdA=
X-Google-Smtp-Source: AMsMyM4myiSv792qvzkDfIe2uhQ8cGTSLBe57M7SpumzWI/ijC7DqmxSX/gEUBhk/zoDjq9kmTW/og==
X-Received: by 2002:adf:f6c9:0:b0:236:547f:698a with SMTP id y9-20020adff6c9000000b00236547f698amr921971wrp.180.1667002006981;
        Fri, 28 Oct 2022 17:06:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c204a00b003b476cabf1csm50449wmg.26.2022.10.28.17.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 17:06:46 -0700 (PDT)
Message-Id: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Oct 2022 00:06:45 +0000
Subject: [PATCH v2] status: long status advice adapted to recent capabilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rudy Rigot <rudy.rigot@gmail.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rudy Rigot <rudy.rigot@gmail.com>

Currently, if git-status takes more than 2 seconds for enumerating untracked
files, a piece of advice is given to the user to consider ignoring untracked
files. But Git now offers more possibilities to resolve that situation
(untracked cache, fsmonitor) with different downsides.

This change is about refreshing that advice message. A new section in the
documentation is introduced to present the possibilities, and the advice
message links to it. I'm also introducing tests for this advice message,
which was untested so far.

One of the downsides of untracked cache / fsmonitor, is that the first call
may be long in order to generate the cache, but the user may not know what
their current configuration is. When collecting feedback from users of our
very large repo, that's the most common point of confusion that keeps coming
back: people complain about git status being slow, but are satisfied when
we inform them that it's being cached and they should run it again to check.
As a result, the advice message tries to keep them informed of their current
configuration.

Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
---
    status: long status advice adapted to recent capabilities
    
    Here is version 2 for this patch to change the long status advice to
    adapt to recent capabilities (untracked cache, FSMonitor).
    
    Clerical note: I /preview'd this with GitGitGadget, and this seems to be
    expressed as a patch on top of my first patch ("Range-diff vs v1")
    first, before showing the actual patch as refreshed. I'm assuming that
    is what is expected, please let me know if I'm doing this wrong.
    
    Changes since v1:
    
     * Introduced a new section in git status's docs to explain the various
       options, that the new advice can link to. I realized there's already
       solid details about untracked cache and fsmonitor in the
       update-index's docs, so I kept the new section very high-level and
       strategic, linking to update-index's docs for more details. I don't
       think anything's inaccurate, but I really could use some eyes on this
       anyway to be sure.
     * Changed the advice message depending on context (see test files to
       see every possible phrasing the end user can meet). I am very open to
       feedback, of course. One of my priorities was to keep the
       already-optimized user in the loop about what optimizations they may
       already have, in case they're only seeing this message because it's
       the git status run that did the first caching, since that's what's
       been confusing our users when using fsmonitor.
     * Introduced tests for all this. I chose to simulate the slowness
       thanks to a an environment variable rather than a symbol, just
       because it was also helpful to set it from the outside at dev time,
       but I'm not strongly opinionated about whether it should be one or
       the other.
     * Removed the advice.statusFsmonitor config I had introduced in v1,
       since it's all one short consolidated advice message now.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

Range-diff vs v1:

 1:  cc372e7c9d0 ! 1:  9ef7f1834b7 fsmonitor: long status advice adapted to the fsmonitor use case
     @@ Metadata
      Author: Rudy Rigot <rudy.rigot@gmail.com>
      
       ## Commit message ##
     -    fsmonitor: long status advice adapted to the fsmonitor use case
     +    status: long status advice adapted to recent capabilities
      
     -    Currently, if git-status takes more than 2 seconds for enumerating
     -    untracked files, a piece of advice is given to the user to consider
     -    ignoring untracked files. This is somewhat at odds with the UX
     -    upsides from having fsmonitor enabled, since fsmonitor will be
     -    here to take care of mitigating the performance downsides from
     -    those untracked files.
     +    Currently, if git-status takes more than 2 seconds for enumerating untracked
     +    files, a piece of advice is given to the user to consider ignoring untracked
     +    files. But Git now offers more possibilities to resolve that situation
     +    (untracked cache, fsmonitor) with different downsides.
      
     -    I considered just suppressing that piece of advice entirely for
     -    repositories with fsmonitor disabled, but I decided to replace
     -    it with another piece of advice instead, letting the user know
     -    that this run may have been slow, but the next ones should be faster.
     -    Of course, please let me know if the phrasing can be improved. To
     -    keep consistent with other pieces of advice, this new one can be
     -    hidden with a new advice.statusFsmonitor config.
     +    This change is about refreshing that advice message. A new section in the
     +    documentation is introduced to present the possibilities, and the advice
     +    message links to it. I'm also introducing tests for this advice message,
     +    which was untested so far.
      
     -    If the repository does not have fsmonitor enabled, or if the new
     -    piece of advice is hidden by config, the behavior falls back to
     -    today's behavior: show the message advising to ignore untracked
     -    files, as long as it wasn't disabled with the existing advice.statusUoption
     -    config.
     -
     -    Test-wise, I tried to figure out ways to mock the behavior of a
     -    slow git-status, but I couldn't figure it out, so I could use some
     -    advice. I tracked down Commit 6a38ef2ced (status: advise to consider
     -    use of -u when read_directory takes too long, 2013-03-13), and it
     -    also didn't have tests, so I'm questioning whether it can in fact
     -    be reasonably done. Thanks in advance for any guidance.
     +    One of the downsides of untracked cache / fsmonitor, is that the first call
     +    may be long in order to generate the cache, but the user may not know what
     +    their current configuration is. When collecting feedback from users of our
     +    very large repo, that's the most common point of confusion that keeps coming
     +    back: people complain about git status being slow, but are satisfied when
     +    we inform them that it's being cached and they should run it again to check.
     +    As a result, the advice message tries to keep them informed of their current
     +    configuration.
      
          Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
      
     - ## Documentation/config/advice.txt ##
     -@@ Documentation/config/advice.txt: advice.*::
     - 		and that calculation takes longer than expected. Will not
     - 		appear if `status.aheadBehind` is false or the option
     - 		`--no-ahead-behind` is given.
     -+	statusFsmonitor::
     -+		Shown when the linkgit:git-status[1] command takes more than
     -+		2 seconds to enumerate untracked files, and fsmonitor is enabled.
     - 	statusHints::
     - 		Show directions on how to proceed from the current
     - 		state in the output of linkgit:git-status[1], in
     + ## Documentation/git-status.txt ##
     +@@ Documentation/git-status.txt: during the write may conflict with other simultaneous processes, causing
     + them to fail. Scripts running `status` in the background should consider
     + using `git --no-optional-locks status` (see linkgit:git[1] for details).
     + 
     ++UNTRACKED FILES AND STATUS SPEED
     ++--------------------------------
     ++
     ++If your untracked files take an unusual amount of time to enumerate, your
     ++repository certainly has a lot of them, and an advice message will display
     ++about it. Here are some configurations to consider in order to improve the
     ++situation:
     ++
     ++* Setting the `core.untrackedCache` configuration as `true` will allow for
     ++`git status` to keep track of the mtime of folders, in order to cache past
     ++`status` results and be sure to only browse folders that changed on subsequent
     ++runs, for filesystems that can support it (see linkgit:git-update-index[1]
     ++for details).
     ++* Used in conjonction with `core.untrackedCache`, setting the `core.fsmonitor`
     ++configuration as `true` will allow for `git status` to keep track of what
     ++files recently changed, in order to cache past `status` results and be sure
     ++to only focus on those files on subsequent runs (see linkgit:git-update-index[1]
     ++for details).
     ++* If none of the above options are satisfactory, setting the
     ++`status.showUntrackedFiles` configuration as `no` will cause `git status`
     ++to not attempt to list untracked files anymore, in which case you have to be
     ++careful not to forget to add new files yourself.
     ++
     ++If none of the above solutions are satisfactory, and you are bothered with
     ++the advice message, you can disable it by setting the `advice.statusUoption`
     ++configuration to `false`.
     ++
     + SEE ALSO
     + --------
     + linkgit:gitignore[5]
     +
     + ## t/t7065-wtstatus-slow.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='test status when slow untracked files'
     ++
     ++. ./test-lib.sh
     ++
     ++DATA="$TEST_DIRECTORY/t7065"
     ++
     ++GIT_TEST_UF_DELAY_WARNING=1
     ++export GIT_TEST_UF_DELAY_WARNING
     ++
     ++test_expect_success setup '
     ++	git checkout -b test
     ++'
     ++
     ++test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
     ++	test_must_fail git config --get core.untrackedCache &&
     ++	test_must_fail git config --get core.fsmonitor &&
     ++    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     ++    test_cmp "$DATA/no_untrackedcache_no_fsmonitor" ../actual &&
     ++    rm -fr ../actual
     ++'
     ++
     ++test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
     ++    git config core.untrackedCache true &&
     ++	test_must_fail git config --get core.fsmonitor &&
     ++    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     ++    test_cmp "$DATA/with_untrackedcache_no_fsmonitor" ../actual &&
     ++    rm -fr ../actual
     ++'
     ++
     ++test_expect_success 'when core.untrackedCache true, and fsmonitor' '
     ++    git config core.untrackedCache true &&
     ++	git config core.fsmonitor true &&
     ++    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
     ++    test_cmp "$DATA/with_untrackedcache_with_fsmonitor" ../actual &&
     ++    rm -fr ../actual
     ++'
     ++
     ++test_done
     + \ No newline at end of file
      
     - ## advice.c ##
     -@@ advice.c: static struct {
     - 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
     - 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1 },
     - 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
     -+	[ADVICE_STATUS_FSMONITOR]			= { "statusFsmonitor", 1 },
     - 	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
     - 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
     - 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
     + ## t/t7065/no_untrackedcache_no_fsmonitor (new) ##
     +@@
     ++On branch test
     ++
     ++No commits yet
     ++
     ++
     ++It took X seconds to enumerate untracked files.
     ++See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
     ++for configuration options that may improve that time.
     ++
     ++nothing to commit (create/copy files and use "git add" to track)
      
     - ## advice.h ##
     -@@ advice.h: struct string_list;
     - 	ADVICE_SEQUENCER_IN_USE,
     - 	ADVICE_SET_UPSTREAM_FAILURE,
     - 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
     -+	ADVICE_STATUS_FSMONITOR,
     - 	ADVICE_STATUS_HINTS,
     - 	ADVICE_STATUS_U_OPTION,
     - 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
     + ## t/t7065/with_untrackedcache_no_fsmonitor (new) ##
     +@@
     ++On branch test
     ++
     ++No commits yet
     ++
     ++
     ++It took X seconds to enumerate untracked files,
     ++but this is currently being cached, with fsmonitor OFF.
     ++See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
     ++for configuration options that may improve that time.
     ++
     ++nothing to commit (create/copy files and use "git add" to track)
     +
     + ## t/t7065/with_untrackedcache_with_fsmonitor (new) ##
     +@@
     ++On branch test
     ++
     ++No commits yet
     ++
     ++
     ++It took X seconds to enumerate untracked files,
     ++but this is currently being cached, with fsmonitor ON.
     ++See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
     ++for configuration options that may improve that time.
     ++
     ++nothing to commit (create/copy files and use "git add" to track)
      
       ## wt-status.c ##
      @@
     @@ wt-status.c
      +#include "fsmonitor-settings.h"
       
       #define AB_DELAY_WARNING_IN_MS (2 * 1000)
     ++#define UF_DELAY_WARNING_IN_MS (2 * 1000)
     + 
     + static const char cut_line[] =
     + "------------------------ >8 ------------------------\n";
     +@@ wt-status.c: static void wt_longstatus_print_tracking(struct wt_status *s)
     + 	strbuf_release(&sb);
     + }
       
     ++static inline int uf_was_slow(uint32_t untracked_in_ms)
     ++{
     ++	const char *x;
     ++	x = getenv("GIT_TEST_UF_DELAY_WARNING");
     ++	if (x) {
     ++		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
     ++	}
     ++
     ++	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
     ++}
     ++
     + static void show_merge_in_progress(struct wt_status *s,
     + 				   const char *color)
     + {
      @@ wt-status.c: static void wt_longstatus_print(struct wt_status *s)
       {
       	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
     @@ wt-status.c: static void wt_longstatus_print(struct wt_status *s)
      -					   "may speed it up, but you have to be careful not to forget to add\n"
      -					   "new files yourself (see 'git help status')."),
      -					 s->untracked_in_ms / 1000.0);
     -+		if (2000 < s->untracked_in_ms) {
     -+			if (advice_enabled(ADVICE_STATUS_FSMONITOR) && fsm_mode > FSMONITOR_MODE_DISABLED) {
     ++		if (uf_was_slow(s->untracked_in_ms)) {
     ++			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
      +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
     ++				if (s->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE) {
     ++					status_printf_ln(s, GIT_COLOR_NORMAL,
     ++							_("It took %.2f seconds to enumerate untracked files,\n"
     ++							"but this is currently being cached, with fsmonitor %s."),
     ++							s->untracked_in_ms / 1000.0,
     ++							(fsm_mode > FSMONITOR_MODE_DISABLED) ? "ON" : "OFF");
     ++				} else {
     ++					status_printf_ln(s, GIT_COLOR_NORMAL,
     ++							_("It took %.2f seconds to enumerate untracked files."),
     ++							s->untracked_in_ms / 1000.0);
     ++				}
      +				status_printf_ln(s, GIT_COLOR_NORMAL,
     -+						_("It took a while to check your git status this time, but the results\n"
     -+						"were cached, and your next runs should be faster."));
     -+			} else if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
     ++						_("See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed\n"
     ++						"for configuration options that may improve that time."));
      +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
     -+				status_printf_ln(s, GIT_COLOR_NORMAL,
     -+						_("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
     -+						"may speed it up, but you have to be careful not to forget to add\n"
     -+						"new files yourself (see 'git help status')."),
     -+						s->untracked_in_ms / 1000.0);
      +			}
       		}
       	} else if (s->committable)


 Documentation/git-status.txt               | 27 +++++++++++++++
 t/t7065-wtstatus-slow.sh                   | 40 ++++++++++++++++++++++
 t/t7065/no_untrackedcache_no_fsmonitor     | 10 ++++++
 t/t7065/with_untrackedcache_no_fsmonitor   | 11 ++++++
 t/t7065/with_untrackedcache_with_fsmonitor | 11 ++++++
 wt-status.c                                | 40 ++++++++++++++++++----
 6 files changed, 132 insertions(+), 7 deletions(-)
 create mode 100755 t/t7065-wtstatus-slow.sh
 create mode 100644 t/t7065/no_untrackedcache_no_fsmonitor
 create mode 100644 t/t7065/with_untrackedcache_no_fsmonitor
 create mode 100644 t/t7065/with_untrackedcache_with_fsmonitor

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 54a4b29b473..3d92e5fd018 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -457,6 +457,33 @@ during the write may conflict with other simultaneous processes, causing
 them to fail. Scripts running `status` in the background should consider
 using `git --no-optional-locks status` (see linkgit:git[1] for details).
 
+UNTRACKED FILES AND STATUS SPEED
+--------------------------------
+
+If your untracked files take an unusual amount of time to enumerate, your
+repository certainly has a lot of them, and an advice message will display
+about it. Here are some configurations to consider in order to improve the
+situation:
+
+* Setting the `core.untrackedCache` configuration as `true` will allow for
+`git status` to keep track of the mtime of folders, in order to cache past
+`status` results and be sure to only browse folders that changed on subsequent
+runs, for filesystems that can support it (see linkgit:git-update-index[1]
+for details).
+* Used in conjonction with `core.untrackedCache`, setting the `core.fsmonitor`
+configuration as `true` will allow for `git status` to keep track of what
+files recently changed, in order to cache past `status` results and be sure
+to only focus on those files on subsequent runs (see linkgit:git-update-index[1]
+for details).
+* If none of the above options are satisfactory, setting the
+`status.showUntrackedFiles` configuration as `no` will cause `git status`
+to not attempt to list untracked files anymore, in which case you have to be
+careful not to forget to add new files yourself.
+
+If none of the above solutions are satisfactory, and you are bothered with
+the advice message, you can disable it by setting the `advice.statusUoption`
+configuration to `false`.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/t/t7065-wtstatus-slow.sh b/t/t7065-wtstatus-slow.sh
new file mode 100755
index 00000000000..92c053eaa64
--- /dev/null
+++ b/t/t7065-wtstatus-slow.sh
@@ -0,0 +1,40 @@
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
+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+    test_cmp "$DATA/no_untrackedcache_no_fsmonitor" ../actual &&
+    rm -fr ../actual
+'
+
+test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
+    git config core.untrackedCache true &&
+	test_must_fail git config --get core.fsmonitor &&
+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+    test_cmp "$DATA/with_untrackedcache_no_fsmonitor" ../actual &&
+    rm -fr ../actual
+'
+
+test_expect_success 'when core.untrackedCache true, and fsmonitor' '
+    git config core.untrackedCache true &&
+	git config core.fsmonitor true &&
+    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
+    test_cmp "$DATA/with_untrackedcache_with_fsmonitor" ../actual &&
+    rm -fr ../actual
+'
+
+test_done
\ No newline at end of file
diff --git a/t/t7065/no_untrackedcache_no_fsmonitor b/t/t7065/no_untrackedcache_no_fsmonitor
new file mode 100644
index 00000000000..e346deaa1db
--- /dev/null
+++ b/t/t7065/no_untrackedcache_no_fsmonitor
@@ -0,0 +1,10 @@
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files.
+See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
+for configuration options that may improve that time.
+
+nothing to commit (create/copy files and use "git add" to track)
diff --git a/t/t7065/with_untrackedcache_no_fsmonitor b/t/t7065/with_untrackedcache_no_fsmonitor
new file mode 100644
index 00000000000..a649d367493
--- /dev/null
+++ b/t/t7065/with_untrackedcache_no_fsmonitor
@@ -0,0 +1,11 @@
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files,
+but this is currently being cached, with fsmonitor OFF.
+See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
+for configuration options that may improve that time.
+
+nothing to commit (create/copy files and use "git add" to track)
diff --git a/t/t7065/with_untrackedcache_with_fsmonitor b/t/t7065/with_untrackedcache_with_fsmonitor
new file mode 100644
index 00000000000..d5e95d984f8
--- /dev/null
+++ b/t/t7065/with_untrackedcache_with_fsmonitor
@@ -0,0 +1,11 @@
+On branch test
+
+No commits yet
+
+
+It took X seconds to enumerate untracked files,
+but this is currently being cached, with fsmonitor ON.
+See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed
+for configuration options that may improve that time.
+
+nothing to commit (create/copy files and use "git add" to track)
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..be903c6e294 100644
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
@@ -1870,13 +1884,25 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
-					   "may speed it up, but you have to be careful not to forget to add\n"
-					   "new files yourself (see 'git help status')."),
-					 s->untracked_in_ms / 1000.0);
+		if (uf_was_slow(s->untracked_in_ms)) {
+			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+				if (s->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE) {
+					status_printf_ln(s, GIT_COLOR_NORMAL,
+							_("It took %.2f seconds to enumerate untracked files,\n"
+							"but this is currently being cached, with fsmonitor %s."),
+							s->untracked_in_ms / 1000.0,
+							(fsm_mode > FSMONITOR_MODE_DISABLED) ? "ON" : "OFF");
+				} else {
+					status_printf_ln(s, GIT_COLOR_NORMAL,
+							_("It took %.2f seconds to enumerate untracked files."),
+							s->untracked_in_ms / 1000.0);
+				}
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("See https://git-scm.com/docs/git-status#_untracked_files_and_status_speed\n"
+						"for configuration options that may improve that time."));
+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+			}
 		}
 	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),

base-commit: bbe21b64a08f89475d8a3818e20c111378daa621
-- 
gitgitgadget

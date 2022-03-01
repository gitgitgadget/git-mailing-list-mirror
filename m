Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE27C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiCASpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiCASoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A6657B4
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t11so953705wrm.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ODuNg15CXAlMZk9QLr/IXCBO1K/76+iTCoZ+ADCF8lQ=;
        b=gnetaDHc5PCZnyE4qt7P0beqd+1KcjtHrqIEYWhpi5rEiK0YWuUFnbnw+HQtnU4hge
         HLWFvMpsQ7T3WIXtUJoE82WmUq7hljjDEhNyFTk5Hrg+x5+GiIGGpZgZjXnf+nAGkm4C
         rxKWVFDVAXNCXCWAgEHafBNrHjmnGLUyiF1yCvu74PIHU5J1zT1ihxb3mC6AexD2jj29
         0IMG8JdxbZsFG2NZVu1Q1hAdgiKDss1rJqbZM6lLbS/P0Pdut6QIFx6RKxDcVzpLnJOV
         tOhwtc1E/NajuxKmUDcoZVddAEhhoV9Fg8poM8SmQIivVyFqZuAt2tmTzPorfMkTd0sC
         L88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ODuNg15CXAlMZk9QLr/IXCBO1K/76+iTCoZ+ADCF8lQ=;
        b=2qF9nE8FPDVCBHmDSGUS1rJYL2580T9AXSw3GddnqfD4TVOGpo4gLodcTocc01gmq5
         3mLHKl6NMOqZG/++lHwlu6FTh3tofVRMm1c/MoyS+K5shtNuWtNxmxl5LdTj7HLUoEMT
         BRzh5FlTV/aIAVur+OF3jmoiK+tG1/W7HL5quuyfLRtGn9LRtaTExQ6DF/urkqSxyihJ
         w2uK/46AbPmCYpjIHTahoKVpYq80KNXD2pHbaOJAcgCifkxb+Ar8uqK4cwbYtj4Nr7K2
         MeyuSqIi+XWsQn1Jp8RyuXFOSRtvgivAwqggp3wP0dVW3ZHVcgVSJU2fIqWmE4Y9Jt5B
         HpfQ==
X-Gm-Message-State: AOAM5315DFG9EHrcjxrhZg/TU41GKxEps3iLzP1NFo3YCYcr5OVOCel0
        pPjvOoNxtBiQZFaDldUZ6TLBzvExGlk=
X-Google-Smtp-Source: ABdhPJxny4ckGKLDd+42IZf6u80vJ5uU1BM+7nBJ3MqBPuBA3EGXX/DuoHx+Q6WNwRpfkmr5ze/8nA==
X-Received: by 2002:a5d:52c8:0:b0:1ed:e591:be70 with SMTP id r8-20020a5d52c8000000b001ede591be70mr20355204wrv.436.1646160232771;
        Tue, 01 Mar 2022 10:43:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0037bd5fabd10sm4135116wmq.48.2022.03.01.10.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:52 -0800 (PST)
Message-Id: <db8809da089f28282c6bce1752a25423811a374a.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:23 +0000
Subject: [PATCH v6 21/30] t7527: create test for fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7527-builtin-fsmonitor.sh | 511 +++++++++++++++++++++++++++++++++++
 1 file changed, 511 insertions(+)
 create mode 100755 t/t7527-builtin-fsmonitor.sh

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
new file mode 100755
index 00000000000..5f7b8e54233
--- /dev/null
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -0,0 +1,511 @@
+#!/bin/sh
+
+test_description='built-in file system watcher'
+
+. ./test-lib.sh
+
+if ! test_have_prereq FSMONITOR_DAEMON
+then
+	skip_all="fsmonitor--daemon is not supported on this platform"
+	test_done
+fi
+
+stop_daemon_delete_repo () {
+	r=$1
+	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
+	rm -rf $1
+	return 0
+}
+
+start_daemon () {
+	case "$#" in
+		1) r="-C $1";;
+		*) r="";
+	esac
+
+	git $r fsmonitor--daemon start || return $?
+	git $r fsmonitor--daemon status || return $?
+
+	return 0
+}
+
+# Is a Trace2 data event present with the given catetory and key?
+# We do not care what the value is.
+#
+have_t2_data_event () {
+	c=$1
+	k=$2
+
+	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
+}
+
+test_expect_success 'explicit daemon start and stop' '
+	test_when_finished "stop_daemon_delete_repo test_explicit" &&
+
+	git init test_explicit &&
+	start_daemon test_explicit &&
+
+	git -C test_explicit fsmonitor--daemon stop &&
+	test_must_fail git -C test_explicit fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon start' '
+	test_when_finished "stop_daemon_delete_repo test_implicit" &&
+
+	git init test_implicit &&
+	test_must_fail git -C test_implicit fsmonitor--daemon status &&
+
+	# query will implicitly start the daemon.
+	#
+	# for test-script simplicity, we send a V1 timestamp rather than
+	# a V2 token.  either way, the daemon response to any query contains
+	# a new V2 token.  (the daemon may complain that we sent a V1 request,
+	# but this test case is only concerned with whether the daemon was
+	# implicitly started.)
+
+	GIT_TRACE2_EVENT="$(pwd)/.git/trace" \
+		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
+	nul_to_q <actual >actual.filtered &&
+	grep "builtin:" actual.filtered &&
+
+	# confirm that a daemon was started in the background.
+	#
+	# since the mechanism for starting the background daemon is platform
+	# dependent, just confirm that the foreground command received a
+	# response from the daemon.
+
+	have_t2_data_event fsm_client query/response-length <.git/trace &&
+
+	git -C test_implicit fsmonitor--daemon status &&
+	git -C test_implicit fsmonitor--daemon stop &&
+	test_must_fail git -C test_implicit fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon stop (delete .git)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_1" &&
+
+	git init test_implicit_1 &&
+
+	start_daemon test_implicit_1 &&
+
+	# deleting the .git directory will implicitly stop the daemon.
+	rm -rf test_implicit_1/.git &&
+
+	# [1] Create an empty .git directory so that the following Git
+	#     command will stay relative to the `-C` directory.
+	#
+	#     Without this, the Git command will override the requested
+	#     -C argument and crawl out to the containing Git source tree.
+	#     This would make the test result dependent upon whether we
+	#     were using fsmonitor on our development worktree.
+	#
+	sleep 1 &&
+	mkdir test_implicit_1/.git &&
+
+	test_must_fail git -C test_implicit_1 fsmonitor--daemon status
+'
+
+test_expect_success 'implicit daemon stop (rename .git)' '
+	test_when_finished "stop_daemon_delete_repo test_implicit_2" &&
+
+	git init test_implicit_2 &&
+
+	start_daemon test_implicit_2 &&
+
+	# renaming the .git directory will implicitly stop the daemon.
+	mv test_implicit_2/.git test_implicit_2/.xxx &&
+
+	# See [1] above.
+	#
+	sleep 1 &&
+	mkdir test_implicit_2/.git &&
+
+	test_must_fail git -C test_implicit_2 fsmonitor--daemon status
+'
+
+test_expect_success 'cannot start multiple daemons' '
+	test_when_finished "stop_daemon_delete_repo test_multiple" &&
+
+	git init test_multiple &&
+
+	start_daemon test_multiple &&
+
+	test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
+	grep "fsmonitor--daemon is already running" actual &&
+
+	git -C test_multiple fsmonitor--daemon stop &&
+	test_must_fail git -C test_multiple fsmonitor--daemon status
+'
+
+# These tests use the main repo in the trash directory
+
+test_expect_success 'setup' '
+	>tracked &&
+	>modified &&
+	>delete &&
+	>rename &&
+	mkdir dir1 &&
+	>dir1/tracked &&
+	>dir1/modified &&
+	>dir1/delete &&
+	>dir1/rename &&
+	mkdir dir2 &&
+	>dir2/tracked &&
+	>dir2/modified &&
+	>dir2/delete &&
+	>dir2/rename &&
+	mkdir dirtorename &&
+	>dirtorename/a &&
+	>dirtorename/b &&
+
+	cat >.gitignore <<-\EOF &&
+	.gitignore
+	expect*
+	actual*
+	EOF
+
+	git -c core.fsmonitor=false add . &&
+	test_tick &&
+	git -c core.fsmonitor=false commit -m initial &&
+
+	git config core.fsmonitor true
+'
+
+# The test already explicitly stopped (or tried to stop) the daemon.
+# This is here in case something else fails first.
+#
+redundant_stop_daemon () {
+	git fsmonitor--daemon stop
+	return 0
+}
+
+test_expect_success 'update-index implicitly starts daemon' '
+	test_when_finished redundant_stop_daemon &&
+
+	test_must_fail git fsmonitor--daemon status &&
+
+	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_1" \
+		git update-index --fsmonitor &&
+
+	git fsmonitor--daemon status &&
+	test_might_fail git fsmonitor--daemon stop &&
+
+	# Confirm that the trace2 log contains a record of the
+	# daemon starting.
+	test_subcommand git fsmonitor--daemon start <.git/trace_implicit_1
+'
+
+test_expect_success 'status implicitly starts daemon' '
+	test_when_finished redundant_stop_daemon &&
+
+	test_must_fail git fsmonitor--daemon status &&
+
+	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_2" \
+		git status >actual &&
+
+	git fsmonitor--daemon status &&
+	test_might_fail git fsmonitor--daemon stop &&
+
+	# Confirm that the trace2 log contains a record of the
+	# daemon starting.
+	test_subcommand git fsmonitor--daemon start <.git/trace_implicit_2
+'
+
+edit_files () {
+	echo 1 >modified
+	echo 2 >dir1/modified
+	echo 3 >dir2/modified
+	>dir1/untracked
+}
+
+delete_files () {
+	rm -f delete
+	rm -f dir1/delete
+	rm -f dir2/delete
+}
+
+create_files () {
+	echo 1 >new
+	echo 2 >dir1/new
+	echo 3 >dir2/new
+}
+
+rename_files () {
+	mv rename renamed
+	mv dir1/rename dir1/renamed
+	mv dir2/rename dir2/renamed
+}
+
+file_to_directory () {
+	rm -f delete
+	mkdir delete
+	echo 1 >delete/new
+}
+
+directory_to_file () {
+	rm -rf dir1
+	echo 1 >dir1
+}
+
+verify_status () {
+	git status >actual &&
+	GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
+	GIT_INDEX_FILE=.git/fresh-index git -c core.fsmonitor=false status >expect &&
+	test_cmp expect actual &&
+	echo HELLO AFTER &&
+	cat .git/trace &&
+	echo HELLO AFTER
+}
+
+# The next few test cases confirm that our fsmonitor daemon sees each type
+# of OS filesystem notification that we care about.  At this layer we just
+# ensure we are getting the OS notifications and do not try to confirm what
+# is reported by `git status`.
+#
+# We run a simple query after modifying the filesystem just to introduce
+# a bit of a delay so that the trace logging from the daemon has time to
+# get flushed to disk.
+#
+# We `reset` and `clean` at the bottom of each test (and before stopping the
+# daemon) because these commands might implicitly restart the daemon.
+
+clean_up_repo_and_stop_daemon () {
+	git reset --hard HEAD
+	git clean -fd
+	git fsmonitor--daemon stop
+	rm -f .git/trace
+}
+
+test_expect_success 'edit some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	edit_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/modified$"  .git/trace &&
+	grep "^event: dir2/modified$"  .git/trace &&
+	grep "^event: modified$"       .git/trace &&
+	grep "^event: dir1/untracked$" .git/trace
+'
+
+test_expect_success 'create some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	create_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/new$" .git/trace &&
+	grep "^event: dir2/new$" .git/trace &&
+	grep "^event: new$"      .git/trace
+'
+
+test_expect_success 'delete some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	delete_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/delete$" .git/trace &&
+	grep "^event: dir2/delete$" .git/trace &&
+	grep "^event: delete$"      .git/trace
+'
+
+test_expect_success 'rename some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	rename_files &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1/rename$"  .git/trace &&
+	grep "^event: dir2/rename$"  .git/trace &&
+	grep "^event: rename$"       .git/trace &&
+	grep "^event: dir1/renamed$" .git/trace &&
+	grep "^event: dir2/renamed$" .git/trace &&
+	grep "^event: renamed$"      .git/trace
+'
+
+test_expect_success 'rename directory' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	mv dirtorename dirrenamed &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dirtorename/*$" .git/trace &&
+	grep "^event: dirrenamed/*$"  .git/trace
+'
+
+test_expect_success 'file changes to directory' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	file_to_directory &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: delete$"     .git/trace &&
+	grep "^event: delete/new$" .git/trace
+'
+
+test_expect_success 'directory changes to a file' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon
+	) &&
+
+	directory_to_file &&
+
+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
+
+	grep "^event: dir1$" .git/trace
+'
+
+# The next few test cases exercise the token-resync code.  When filesystem
+# drops events (because of filesystem velocity or because the daemon isn't
+# polling fast enough), we need to discard the cached data (relative to the
+# current token) and start collecting events under a new token.
+#
+# the 'test-tool fsmonitor-client flush' command can be used to send a
+# "flush" message to a running daemon and ask it to do a flush/resync.
+
+test_expect_success 'flush cached data' '
+	test_when_finished "stop_daemon_delete_repo test_flush" &&
+
+	git init test_flush &&
+
+	(
+		GIT_TEST_FSMONITOR_TOKEN=true &&
+		export GIT_TEST_FSMONITOR_TOKEN &&
+
+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace_daemon" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon test_flush
+	) &&
+
+	# The daemon should have an initial token with no events in _0 and
+	# then a few (probably platform-specific number of) events in _1.
+	# These should both have the same <token_id>.
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
+	nul_to_q <actual_0 >actual_q0 &&
+
+	touch test_flush/file_1 &&
+	touch test_flush/file_2 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
+	nul_to_q <actual_1 >actual_q1 &&
+
+	grep "file_1" actual_q1 &&
+
+	# Force a flush.  This will change the <token_id>, reset the <seq_nr>, and
+	# flush the file data.  Then create some events and ensure that the file
+	# again appears in the cache.  It should have the new <token_id>.
+
+	test-tool -C test_flush fsmonitor-client flush >flush_0 &&
+	nul_to_q <flush_0 >flush_q0 &&
+	grep "^builtin:test_00000002:0Q/Q$" flush_q0 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
+	nul_to_q <actual_2 >actual_q2 &&
+
+	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+
+	touch test_flush/file_3 &&
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
+	nul_to_q <actual_3 >actual_q3 &&
+
+	grep "file_3" actual_q3
+'
+
+# The next few test cases create repos where the .git directory is NOT
+# inside the one of the working directory.  That is, where .git is a file
+# that points to a directory elsewhere.  This happens for submodules and
+# non-primary worktrees.
+
+test_expect_success 'setup worktree base' '
+	git init wt-base &&
+	echo 1 >wt-base/file1 &&
+	git -C wt-base add file1 &&
+	git -C wt-base commit -m "c1"
+'
+
+test_expect_success 'worktree with .git file' '
+	git -C wt-base worktree add ../wt-secondary &&
+
+	(
+		GIT_TRACE2_PERF="$(pwd)/trace2_wt_secondary" &&
+		export GIT_TRACE2_PERF &&
+
+		GIT_TRACE_FSMONITOR="$(pwd)/trace_wt_secondary" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon wt-secondary
+	) &&
+
+	git -C wt-secondary fsmonitor--daemon stop &&
+	test_must_fail git -C wt-secondary fsmonitor--daemon status
+'
+
+# NEEDSWORK: Repeat one of the "edit" tests on wt-secondary and
+# confirm that we get the same events and behavior -- that is, that
+# fsmonitor--daemon correctly watches BOTH the working directory and
+# the external GITDIR directory and behaves the same as when ".git"
+# is a directory inside the working directory.
+
+test_expect_success 'cleanup worktrees' '
+	stop_daemon_delete_repo wt-secondary &&
+	stop_daemon_delete_repo wt-base
+'
+
+test_done
-- 
gitgitgadget


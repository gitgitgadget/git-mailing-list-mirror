Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07795C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiCVSD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiCVSCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275168FB5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a1so23180182wrh.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VPIgOuiAOe22AhrUKCUQaqZanCARZzKqg38pHCnSMQs=;
        b=AUddoLbeWi9PulQiWtcYrhr5c5uPyWTAgSYpmtNsyjszrIDi3CLW56fxIWjNS7Ulup
         D2jsmTt24WKlLNnYl5eeBMSHDUSAqjOIkFRhPHtwUN9G3LlPoaYXiluKeHUc8cAZzn+Q
         T1NfUGuEGCmY6oKXdN13IkuQmZ79u3nF2IyRJcsJeGuinq9g7buSR3i3IGlWTYULWYI0
         SSYP6Fc3nywxlUMpm4dq2zx4owNJal6eaQxQg8+uI80lWNjcyD+XjxP4WdoF3HPf1naM
         aNjau8yzGEpE0EHIhAz+O+V6ik8nlmOdkGJFBAzQTP2SgFyM4aC2jWkUD09J5DLwGS0M
         DXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VPIgOuiAOe22AhrUKCUQaqZanCARZzKqg38pHCnSMQs=;
        b=vodD0Yv/C88r39obgaytJCWXjuxUP3wCxZIIQ9sa9iA4HT+MIgWcxP4o3bJVXHu7Tr
         duHJmojo3MiyDPoMUdLvcNWyanOo0LqbHhBCroWP5JxOYMZB0pV+wjxrLXsPrtLF2497
         /sBBczy+91zMlAd8JrOZDx2WDaaCEqIJWslVPd7EBgc9GekfukEpMjm+oKJmyPAb0PRS
         3yxT2ZEV6JQmMEJMcJeNW8wXNa9v5hPIH5p29hv0dpJbPNtIST1ir7G5fCFirW//Knqe
         uSINHKTayFWuzp2inMKMGLLihCuA7zXyXuUcgOrAFP98/+iNS6de2HDDjaYTUzkWlyI5
         H8pg==
X-Gm-Message-State: AOAM532tJMrfqjN0EzLAAcI5mUiKvJkEMbm3zlE2N7m3PpLyCXq+0l3i
        I4TAPN/ukGBS2nhbOSiEhPbOrnsv+5c=
X-Google-Smtp-Source: ABdhPJwnfm2pnv/q+qKw88RqndoC5pnyUtL1dNJbdRARV1+vgcH3GSpNxKiQJSuHzTs+o6XpBgm1+Q==
X-Received: by 2002:a05:6000:168e:b0:204:f92:53e9 with SMTP id y14-20020a056000168e00b002040f9253e9mr10437289wrd.349.1647972047425;
        Tue, 22 Mar 2022 11:00:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b00203e4c8bdf1sm14478966wrs.93.2022.03.22.11.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:46 -0700 (PDT)
Message-Id: <4a920d0b54a25a442bf52efc171139c698d59dc7.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:02 +0000
Subject: [PATCH v7 21/29] t7527: create test for fsmonitor--daemon
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
 t/t7527-builtin-fsmonitor.sh | 501 +++++++++++++++++++++++++++++++++++
 1 file changed, 501 insertions(+)
 create mode 100755 t/t7527-builtin-fsmonitor.sh

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
new file mode 100755
index 00000000000..d79635e7596
--- /dev/null
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -0,0 +1,501 @@
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
+	r=$1 &&
+	test_might_fail git -C $r fsmonitor--daemon stop &&
+	rm -rf $1
+}
+
+start_daemon () {
+	r= &&
+	tf= &&
+	t2= &&
+	tk= &&
+
+	while test "$#" -ne 0
+	do
+		case "$1" in
+		-C)
+			shift;
+			test "$#" -ne 0 || BUG "error: -C requires arg"
+			r="-C $1"
+			shift
+			;;
+		-tf)
+			shift;
+			test "$#" -ne 0 || BUG "error: -tf requires arg"
+			tf="$1"
+			shift
+			;;
+		-t2)
+			shift;
+			test "$#" -ne 0 || BUG "error: -t2 requires arg"
+			t2="$1"
+			shift
+			;;
+		-tk)
+			shift;
+			test "$#" -ne 0 || BUG "error: -tk requires arg"
+			tk="$1"
+			shift
+			;;
+		*)
+			BUG "error: unknown option: '$1'"
+			;;
+		esac
+	done &&
+
+	(
+		if test -n "$tf"
+		then
+			GIT_TRACE_FSMONITOR="$tf"
+			export GIT_TRACE_FSMONITOR
+		fi &&
+
+		if test -n "$t2"
+		then
+			GIT_TRACE2_PERF="$t2"
+			export GIT_TRACE2_PERF
+		fi &&
+
+		if test -n "$tk"
+		then
+			GIT_TEST_FSMONITOR_TOKEN="$tk"
+			export GIT_TEST_FSMONITOR_TOKEN
+		fi &&
+
+		git $r fsmonitor--daemon start &&
+		git $r fsmonitor--daemon status
+	)
+}
+
+# Is a Trace2 data event present with the given catetory and key?
+# We do not care what the value is.
+#
+have_t2_data_event () {
+	c=$1 &&
+	k=$2 &&
+
+	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
+}
+
+test_expect_success 'explicit daemon start and stop' '
+	test_when_finished "stop_daemon_delete_repo test_explicit" &&
+
+	git init test_explicit &&
+	start_daemon -C test_explicit &&
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
+	GIT_TRACE2_EVENT="$PWD/.git/trace" \
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
+	start_daemon -C test_implicit_1 &&
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
+	start_daemon -C test_implicit_2 &&
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
+	start_daemon -C test_multiple &&
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
+	test_might_fail git fsmonitor--daemon stop
+}
+
+test_expect_success 'update-index implicitly starts daemon' '
+	test_when_finished redundant_stop_daemon &&
+
+	test_must_fail git fsmonitor--daemon status &&
+
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
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
+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
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
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
+	>dir1/untracked
+}
+
+delete_files () {
+	rm -f delete &&
+	rm -f dir1/delete &&
+	rm -f dir2/delete
+}
+
+create_files () {
+	echo 1 >new &&
+	echo 2 >dir1/new &&
+	echo 3 >dir2/new
+}
+
+rename_files () {
+	mv rename renamed &&
+	mv dir1/rename dir1/renamed &&
+	mv dir2/rename dir2/renamed
+}
+
+file_to_directory () {
+	rm -f delete &&
+	mkdir delete &&
+	echo 1 >delete/new
+}
+
+directory_to_file () {
+	rm -rf dir1 &&
+	echo 1 >dir1
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
+	git reset --hard HEAD &&
+	git clean -fd &&
+	test_might_fail git fsmonitor--daemon stop &&
+	rm -f .git/trace
+}
+
+test_expect_success 'edit some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon -tf "$PWD/.git/trace" &&
+
+	edit_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
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
+	start_daemon -tf "$PWD/.git/trace" &&
+
+	create_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dir1/new$" .git/trace &&
+	grep "^event: dir2/new$" .git/trace &&
+	grep "^event: new$"      .git/trace
+'
+
+test_expect_success 'delete some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon -tf "$PWD/.git/trace" &&
+
+	delete_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dir1/delete$" .git/trace &&
+	grep "^event: dir2/delete$" .git/trace &&
+	grep "^event: delete$"      .git/trace
+'
+
+test_expect_success 'rename some files' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon -tf "$PWD/.git/trace" &&
+
+	rename_files &&
+
+	test-tool fsmonitor-client query --token 0 &&
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
+	start_daemon -tf "$PWD/.git/trace" &&
+
+	mv dirtorename dirrenamed &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: dirtorename/*$" .git/trace &&
+	grep "^event: dirrenamed/*$"  .git/trace
+'
+
+test_expect_success 'file changes to directory' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon -tf "$PWD/.git/trace" &&
+
+	file_to_directory &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	grep "^event: delete$"     .git/trace &&
+	grep "^event: delete/new$" .git/trace
+'
+
+test_expect_success 'directory changes to a file' '
+	test_when_finished clean_up_repo_and_stop_daemon &&
+
+	start_daemon -tf "$PWD/.git/trace" &&
+
+	directory_to_file &&
+
+	test-tool fsmonitor-client query --token 0 &&
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
+	start_daemon -C test_flush -tf "$PWD/.git/trace_daemon" -tk true &&
+
+	# The daemon should have an initial token with no events in _0 and
+	# then a few (probably platform-specific number of) events in _1.
+	# These should both have the same <token_id>.
+
+	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
+	nul_to_q <actual_0 >actual_q0 &&
+
+	>test_flush/file_1 &&
+	>test_flush/file_2 &&
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
+	>test_flush/file_3 &&
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
+	start_daemon -C wt-secondary \
+		-tf "$PWD/trace_wt_secondary" \
+		-t2 "$PWD/trace2_wt_secondary" &&
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


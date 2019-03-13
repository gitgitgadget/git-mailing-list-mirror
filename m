Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D476120248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfCMMYr (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35027 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMMYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id t18so1779922wrx.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mN1kCxbgqQogjd9IfmawffGmAZe7+Vpw47mgnA8JA/8=;
        b=SMFtmo2hn5XWp4K6E4y0nayBXT6+qzMKhzq5eeQEWArdPBfIUH8RegolN/g1B97I27
         EKpC1vjuJv6unGyGGP6GQ9F15OS97zx4DMlfVHCX1SMMAPcVmuluV0dX9x0AGS01YC7d
         DNABhpIG4lAZdQ37OH/1cPS8V2+ooCnSiKTx1bRwEpQn6EgYdUMcbp4K5MKa7lqIFBEh
         Xo0o1gjct+fQfmFjLcm4NbWoxI/cHewf5EPkg4SdeKCqcudzGem4mhXNdymTwfuEwm4T
         26l2o+EbxRRzH18RCK6oCpYAmo+RhnbEy6x0ssPJPFQoEwkbxHFnt33qgWvWJR2KYDUz
         a7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN1kCxbgqQogjd9IfmawffGmAZe7+Vpw47mgnA8JA/8=;
        b=sK0duM2W7nuj2QtcbtAPIjIiJRxrio7GxYb5m+0p9rDAmNKpgvV8I2J9zdE8RAM6Sn
         WPslwNoUiDZuV8YjRqo/NT5j1gPb0kqxoWgBorggu5A2265m3C7+G05/rnZBx/o9tOmk
         p5nCCM7edqXk72G8gRS4bQv9SiyvOMwrHjFA1KOeCh0r+hJsQeE27tbYZMuOWV7VdqMj
         VO0j0xAJylwnAkELbdl5Y2syL3J9UnV674cTfWchZJAJnvvaydAjqG+eda/XU+D/7iLN
         ZfxyJYuvBVQiTM1HkHzpRB6B53TllOV4Cg2VdHKnuwbAnSui5SD0VjaC1kUu4z7H280E
         jPAA==
X-Gm-Message-State: APjAAAX1yvLkVZoo/rokcISRLjes8LGLdV2XN7bkzqBgYXabPsI07dG9
        1+G/tNoMYNurxUQRMlC9ikh/E/zo
X-Google-Smtp-Source: APXvYqwXnEAAlvpI66JRL5kWVmWGcB+iubJhq+Q4RXF89ml5WIIzNqgMD7JeWFdqE1ILWo732XwWnA==
X-Received: by 2002:a5d:6948:: with SMTP id r8mr4660943wrw.255.1552479883109;
        Wed, 13 Mar 2019 05:24:43 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/11] test-lib: introduce 'test_atexit'
Date:   Wed, 13 Mar 2019 13:24:11 +0100
Message-Id: <20190313122419.2210-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When running Apache, 'git daemon', or p4d, we want to kill them at the
end of the test script, otherwise a leftover daemon process will keep
its port open indefinitely, and thus will interfere with subsequent
executions of the same test script.

So far, we stop these daemon processes "manually", i.e.:

  - by registering functions or commands in the trap on EXIT to stop
    the daemon while preserving the last seen exit code before the
    trap (to deal with a failure when run with '--immediate' or with
    interrupts by ctrl-C),

  - and by invoking these functions/commands last thing before
    'test_done' (and sometimes restoring the test framework's default
    trap on EXIT, to prevent the daemons from being killed twice).

On one hand, we do this inconsistently, e.g. 'git p4' tests invoke
different functions in the trap on EXIT and in the last test before
'test_done', and they neither restore the test framework's default trap
on EXIT nor preserve the last seen exit code.  On the other hand, this
is error prone, because, as shown in a previous patch in this series,
any output from the cleanup commands in the trap on EXIT can prevent a
proper cleanup when a test script run with '--verbose-log' and certain
shells, notably 'dash', is interrupted.

Let's introduce 'test_atexit', which is loosely modeled after
'test_when_finished', but has a broader scope: rather than running the
commands after the current test case, run them when the test script
finishes, and also run them when the test is interrupted, or exits
early in case of a failure while the '--immediate' option is in
effect.

When running the cleanup commands at the end of a successful test,
then they will be run in 'test_done' before it removes the trash
directory, i.e. the cleanup commands will still be able to access any
pidfiles or socket files in there.  When running the cleanup commands
after an interrupt or failure with '--immediate', then they will be
run in the trap on EXIT.  In both cases they will be run in
'test_eval_', i.e. both standard error and output of all cleanup
commands will go where they should according to the '-v' or
'--verbose-log' options, and thus won't cause any troubles when
interrupting a test script run with '--verbose-log'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/README                | 20 ++++++++++++++++++++
 t/t0000-basic.sh        | 18 ++++++++++++++++++
 t/test-lib-functions.sh | 28 ++++++++++++++++++++++++++++
 t/test-lib.sh           | 23 +++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/t/README b/t/README
index 886bbec5bc..af510d236a 100644
--- a/t/README
+++ b/t/README
@@ -862,6 +862,26 @@ library for your script to use.
 		...
 	'
 
+ - test_atexit <script>
+
+   Prepend <script> to a list of commands to run unconditionally to
+   clean up before the test script exits, e.g. to stop a daemon:
+
+	test_expect_success 'test git daemon' '
+		git daemon &
+		daemon_pid=$! &&
+		test_atexit 'kill $daemon_pid' &&
+		hello world
+	'
+
+   The commands will be executed before the trash directory is removed,
+   i.e. the atexit commands will still be able to access any pidfiles or
+   socket files.
+
+   Note that these commands will be run even when a test script run
+   with '--immediate' fails.  Be careful with your atexit commands to
+   minimize any changes to the failed state.
+
  - test_write_lines <lines>
 
    Write <lines> on standard output, one line per argument.
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b6566003dd..c03054c538 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -825,6 +825,24 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_expect_success 'test_atexit is run' "
+	test_must_fail run_sub_test_lib_test \
+		atexit-cleanup 'Run atexit commands' -i <<-\\EOF &&
+	test_expect_success 'tests clean up even after a failure' '
+		> ../../clean-atexit &&
+		test_atexit rm ../../clean-atexit &&
+		> ../../also-clean-atexit &&
+		test_atexit rm ../../also-clean-atexit &&
+		> ../../dont-clean-atexit &&
+		(exit 1)
+	'
+	test_done
+	EOF
+	test_path_is_file dont-clean-atexit &&
+	test_path_is_missing clean-atexit &&
+	test_path_is_missing also-clean-atexit
+"
+
 test_expect_success 'test_oid setup' '
 	test_oid_init
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80402a428f..6a50dba390 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -934,6 +934,34 @@ test_when_finished () {
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
 }
 
+# This function can be used to schedule some commands to be run
+# unconditionally at the end of the test script, e.g. to stop a daemon:
+#
+#	test_expect_success 'test git daemon' '
+#		git daemon &
+#		daemon_pid=$! &&
+#		test_atexit 'kill $daemon_pid' &&
+#		hello world
+#	'
+#
+# The commands will be executed before the trash directory is removed,
+# i.e. the atexit commands will still be able to access any pidfiles or
+# socket files.
+#
+# Note that these commands will be run even when a test script run
+# with '--immediate' fails.  Be careful with your atexit commands to
+# minimize any changes to the failed state.
+
+test_atexit () {
+	# We cannot detect when we are in a subshell in general, but by
+	# doing so on Bash is better than nothing (the test will
+	# silently pass on other shells).
+	test "${BASH_SUBSHELL-0}" = 0 ||
+	error "bug in test script: test_atexit does nothing in a subshell"
+	test_atexit_cleanup="{ $*
+		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
+}
+
 # Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index db3875d1e4..b35881696f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -620,6 +620,10 @@ test_external_has_tap=0
 
 die () {
 	code=$?
+	# This is responsible for running the atexit commands even when a
+	# test script run with '--immediate' fails, or when the user hits
+	# ctrl-C, i.e. when 'test_done' is not invoked at all.
+	test_atexit_handler || code=$?
 	if test -n "$GIT_EXIT_OK"
 	then
 		exit $code
@@ -1045,9 +1049,28 @@ write_junit_xml_testcase () {
 	junit_have_testcase=t
 }
 
+test_atexit_cleanup=:
+test_atexit_handler () {
+	# In a succeeding test script 'test_atexit_handler' is invoked
+	# twice: first from 'test_done', then from 'die' in the trap on
+	# EXIT.
+	# This condition and resetting 'test_atexit_cleanup' below makes
+	# sure that the registered cleanup commands are run only once.
+	test : != "$test_atexit_cleanup" || return 0
+
+	setup_malloc_check
+	test_eval_ "$test_atexit_cleanup"
+	test_atexit_cleanup=:
+	teardown_malloc_check
+}
+
 test_done () {
 	GIT_EXIT_OK=t
 
+	# Run the atexit commands _before_ the trash directory is
+	# removed, so the commands can access pidfiles and socket files.
+	test_atexit_handler
+
 	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
 	then
 		test -n "$junit_have_testcase" || {
-- 
2.21.0.499.g4d310c7a8e.dirty


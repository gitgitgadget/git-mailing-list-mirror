Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BFAC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiC2Aor (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiC2Ao2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37B23D470
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so22558977wrg.12
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DGQ9vb1yDIhgR+KfEeN5nvs2ec9d8lwUbrdqGRhjbxo=;
        b=jXLB7NRKPq49h17/Yc+UJEtSQ5XpXVM1XgCkdXiQHvsYd66Y9kMg2F4NFGMIix8RPM
         AGdyZNovs8b5vy0CXgH9XnhYD2y1ftcopi1r0N44QODKTF9oXUr0Plw8SvdcKUO6q+2F
         AECKat1KqJsow6NUcO9cAZR6cIIygUmoMifijQ3HvPwvmN51lnsD55fcgJpKIYzG9CyU
         J3PCqs1jUXGa0O1TEY2HyZArxCpTnGR1bM0a0QZdje18Fhik1bx1OP9O0jIGgj6GMN5N
         HNxJvTntnXNajj0CJOSQFJdls2VVTtRRLg1zSFJuO6qdjhbFPcQSU8rXCzrVzLjxTlmh
         AlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DGQ9vb1yDIhgR+KfEeN5nvs2ec9d8lwUbrdqGRhjbxo=;
        b=UoJjeFe0z4XpsDri9slHvFfvwZ5hmlVq7Fb/Jf3++hWWmIiEdbB0395HGdhh2HUG/8
         4UNQTLGtyXGE/7YYxmZ+CKnNyEBewXQMVlE5FW9MG0cPRCk7IcPbmAeMmPSiYSLpBFzu
         x6Ve+qxMM0FhXxkf8vroy3eM+1rN8rvQPa0/tbnmizgfjxvD4cRTLV8YVqtNdfDgfizz
         OzlPbXaw2zvPT9JSb26hgimoRns61N90HrUEibtIQoV2gDZE0pPUkjrdinm1GAlPXoeL
         p4udjvrJDvICXdh/QwqREnfxq1W9G/35viViaoJUx7EN1fGxKX2hy05rwU8IXtIaihXO
         W0Vg==
X-Gm-Message-State: AOAM531088M8Cp1mpOkEaATLOtgUTcaktyE7Qn4dCwyl7BbGXp7gNjEU
        H8GXzuyePVC7FTji2JHswCmPYQFqU3o=
X-Google-Smtp-Source: ABdhPJzaPYPSy63J/Dg7Jn9Xa11CSMQnen9TEQnCi/mPxYVwHSnN1xvKskruA5ewlOGs5db8wY/axA==
X-Received: by 2002:a5d:47c5:0:b0:205:9248:817a with SMTP id o5-20020a5d47c5000000b002059248817amr25998940wrc.718.1648514564200;
        Mon, 28 Mar 2022 17:42:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b00205c0cb33e0sm4568035wrw.35.2022.03.28.17.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:43 -0700 (PDT)
Message-Id: <ee7ecf4cabeff14cc64c979aa77fbb2597a9f986.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:28 +0000
Subject: [PATCH v4 11/13] t/perf: add iteration setup mechanism to perf-lib
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Tests that affect the repo in stateful ways are easier to write if we
can run setup steps outside of the measured portion of perf iteration.

This change adds a "--setup 'setup-script'" parameter to test_perf. To
make invocations easier to understand, I also moved the prerequisites to
a new --prereq parameter.

The setup facility will be used in the upcoming perf tests for batch
mode, but it already helps in some existing tests, like t5302 and t7820.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p4220-log-grep-engines.sh       |  3 +-
 t/perf/p4221-log-grep-engines-fixed.sh |  3 +-
 t/perf/p5302-pack-index.sh             | 15 +++----
 t/perf/p7519-fsmonitor.sh              | 18 ++------
 t/perf/p7820-grep-engines.sh           |  6 ++-
 t/perf/perf-lib.sh                     | 62 +++++++++++++++++++++++---
 6 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/t/perf/p4220-log-grep-engines.sh b/t/perf/p4220-log-grep-engines.sh
index 2bc47ded4d1..03fbfbb85d3 100755
--- a/t/perf/p4220-log-grep-engines.sh
+++ b/t/perf/p4220-log-grep-engines.sh
@@ -36,7 +36,8 @@ do
 		else
 			prereq=""
 		fi
-		test_perf $prereq "$engine log$GIT_PERF_4220_LOG_OPTS --grep='$pattern'" "
+		test_perf "$engine log$GIT_PERF_4220_LOG_OPTS --grep='$pattern'" \
+			--prereq "$prereq" "
 			git -c grep.patternType=$engine log --pretty=format:%h$GIT_PERF_4220_LOG_OPTS --grep='$pattern' >'out.$engine' || :
 		"
 	done
diff --git a/t/perf/p4221-log-grep-engines-fixed.sh b/t/perf/p4221-log-grep-engines-fixed.sh
index 060971265a9..0a6d6dfc219 100755
--- a/t/perf/p4221-log-grep-engines-fixed.sh
+++ b/t/perf/p4221-log-grep-engines-fixed.sh
@@ -26,7 +26,8 @@ do
 		else
 			prereq=""
 		fi
-		test_perf $prereq "$engine log$GIT_PERF_4221_LOG_OPTS --grep='$pattern'" "
+		test_perf "$engine log$GIT_PERF_4221_LOG_OPTS --grep='$pattern'" \
+			--prereq "$prereq" "
 			git -c grep.patternType=$engine log --pretty=format:%h$GIT_PERF_4221_LOG_OPTS --grep='$pattern' >'out.$engine' || :
 		"
 	done
diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index c16f6a3ff69..14c601bbf86 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -26,9 +26,8 @@ test_expect_success 'set up thread-counting tests' '
 	done
 '
 
-test_perf PERF_EXTRA 'index-pack 0 threads' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
+test_perf 'index-pack 0 threads' --prereq PERF_EXTRA \
+	--setup 'rm -rf repo.git && git init --bare repo.git' '
 	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
 '
 
@@ -36,17 +35,15 @@ for t in $threads
 do
 	THREADS=$t
 	export THREADS
-	test_perf PERF_EXTRA "index-pack $t threads" '
-		rm -rf repo.git &&
-		git init --bare repo.git &&
+	test_perf "index-pack $t threads" --prereq PERF_EXTRA \
+		--setup 'rm -rf repo.git && git init --bare repo.git' '
 		GIT_DIR=repo.git GIT_FORCE_THREADS=1 \
 		git index-pack --threads=$THREADS --stdin <$PACK
 	'
 done
 
-test_perf 'index-pack default number of threads' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
+test_perf 'index-pack default number of threads' \
+	--setup 'rm -rf repo.git && git init --bare repo.git' '
 	GIT_DIR=repo.git git index-pack --stdin < $PACK
 '
 
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index c8be58f3c76..5b489c968b8 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -60,18 +60,6 @@ then
 	esac
 fi
 
-if test -n "$GIT_PERF_7519_DROP_CACHE"
-then
-	# When using GIT_PERF_7519_DROP_CACHE, GIT_PERF_REPEAT_COUNT must be 1 to
-	# generate valid results. Otherwise the caching that happens for the nth
-	# run will negate the validity of the comparisons.
-	if test "$GIT_PERF_REPEAT_COUNT" -ne 1
-	then
-		echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
-		GIT_PERF_REPEAT_COUNT=1
-	fi
-fi
-
 trace_start() {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
@@ -167,10 +155,10 @@ setup_for_fsmonitor() {
 
 test_perf_w_drop_caches () {
 	if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-		test-tool drop-caches
+		test_perf "$1" --setup "test-tool drop-caches" "$2"
+	else
+		test_perf "$@"
 	fi
-
-	test_perf "$@"
 }
 
 test_fsmonitor_suite() {
diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
index 8b09c5bf328..9bfb86842a9 100755
--- a/t/perf/p7820-grep-engines.sh
+++ b/t/perf/p7820-grep-engines.sh
@@ -49,13 +49,15 @@ do
 		fi
 		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 		then
-			test_perf $prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" "
+			test_perf "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" \
+				--prereq "$prereq" "
 				git -c grep.patternType=$engine grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine' || :
 			"
 		else
 			for threads in $GIT_PERF_GREP_THREADS
 			do
-				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern' with $threads threads" "
+				test_perf "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern' with $threads threads"
+					--prereq PTHREADS,$prereq "
 					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine.$threads' || :
 				"
 			done
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 407252bac70..a935ad622d3 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -189,19 +189,38 @@ exit $ret' >&3 2>&4
 }
 
 test_wrapper_ () {
-	test_wrapper_func_=$1; shift
+	local test_wrapper_func_=$1; shift
+	local test_title_=$1; shift
 	test_start_
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	BUG "not 2 or 3 parameters to test-expect-success"
+	test_prereq=
+	test_perf_setup_=
+	while test $# != 0
+	do
+		case $1 in
+		--prereq)
+			test_prereq=$2
+			shift
+			;;
+		--setup)
+			test_perf_setup_=$2
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	test "$#" = 1 || BUG "test_wrapper_ needs 2 positional parameters"
 	export test_prereq
-	if ! test_skip "$@"
+	export test_perf_setup_
+	if ! test_skip "$test_title_" "$@"
 	then
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
 		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
 		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
-		"$test_wrapper_func_" "$@"
+		"$test_wrapper_func_" "$test_title_" "$@"
 	fi
 
 	test_finish_
@@ -214,6 +233,16 @@ test_perf_ () {
 		echo "perf $test_count - $1:"
 	fi
 	for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
+		if test -n "$test_perf_setup_"
+		then
+			say >&3 "setup: $test_perf_setup_"
+			if ! test_eval_ $test_perf_setup_
+			then
+				test_failure_ "$test_perf_setup_"
+				break
+			fi
+
+		fi
 		say >&3 "running: $2"
 		if test_run_perf_ "$2"
 		then
@@ -237,11 +266,24 @@ test_perf_ () {
 	rm test_time.*
 }
 
+# Usage: test_perf 'title' [options] 'perf-test'
+#	Run the performance test script specified in perf-test with
+#	optional prerequisite and setup steps.
+# Options:
+#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--setup "setup-steps": Run setup steps prior to each measured iteration
+#
 test_perf () {
 	test_wrapper_ test_perf_ "$@"
 }
 
 test_size_ () {
+	if test -n "$test_perf_setup_"
+	then
+		say >&3 "setup: $test_perf_setup_"
+		test_eval_ $test_perf_setup_
+	fi
+
 	say >&3 "running: $2"
 	if test_eval_ "$2" 3>"$base".result; then
 		test_ok_ "$1"
@@ -250,6 +292,14 @@ test_size_ () {
 	fi
 }
 
+# Usage: test_size 'title' [options] 'size-test'
+#	Run the size test script specified in size-test with optional
+#	prerequisites and setup steps. Returns the numeric value
+#	returned by size-test.
+# Options:
+#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--setup "setup-steps": Run setup steps prior to the size measurement
+
 test_size () {
 	test_wrapper_ test_size_ "$@"
 }
-- 
gitgitgadget


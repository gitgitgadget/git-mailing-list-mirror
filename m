Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A836CC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbiC3FIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242762AbiC3FHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F35B674D7
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so2735170wme.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=92E+j38GPKUpnVjZkT1Mcgrfcah4Fkc3Z+GCmwZdNoI=;
        b=fkG4knhtX/wTVe+maOO451SWvLoSdsnaX0+D+57iLj8yc3w3cHUPsrh6mwrsOHwtQt
         GFsREo+Snnj8+QmqsCzaxJy9fupgyBoEU7epMoWqwf8vKWnEbJQgx6Iv1Nz+VbnlUZa/
         9kpBpBus1IN0fZsqiR4WuuCIbAf0RG01tQte+cF5vgJU6Go4fveSP1tusrxnkvMoSP03
         oVKn3W0ZPvY9q6H2ePeLz2eWRJLIBCsh+Yj70eJkjUZY8cmLSYf3i024DliUVkjanZBI
         W3eEMKJ6NgoMcjfEBfzDfbrs836IfDNsX1F6QHdpJ0pkSqMhsyceddX1DCLV6ZUAPCWg
         b3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=92E+j38GPKUpnVjZkT1Mcgrfcah4Fkc3Z+GCmwZdNoI=;
        b=MUn0VeTxyTZQEaWfmMU38on18EFSg9TjzIx76pSJFkEhsbuwpj2H7BpyTC59jOC9Sm
         LxxApSb2GQr4AnYWNx/YX6RJvRmfkKeHVLCdh9jPx2hvtVXZs/aMelV1irnZuF94TY5y
         VEd2ifRGUc/dP9yg5tRc2pkCncx6NhhK+aou0QL5xYS/02wBmkaByqFdAhUtpVPsSVqi
         i3bymW6PAkgYitayIZ8Sasiei/UX47WDgLeE1Yqgg2uph0FOXwGD3ziJOxk/dXn1EAcH
         rox2I3OMl8olo7P9XLu8+SvRoMJuFrqbXsImSs+fhopGqApA98mZMePZKHhn+aiDhFAz
         5Wxw==
X-Gm-Message-State: AOAM531M3IJhT55sr23/Bd/1YhPX1JW+P0kJuQzXh8zCfDzIrT8BWOzD
        O05WOSv0jVWaUKAFM4genzUe2PCak24=
X-Google-Smtp-Source: ABdhPJzyqA+zcVRgCwK7EXySzhpNiQACFZGFMLJo8g+kEdDaoDAk8wFZhaVjRhOICbdUDnGGjkY81g==
X-Received: by 2002:a05:600c:3b24:b0:38c:dbdb:a35c with SMTP id m36-20020a05600c3b2400b0038cdbdba35cmr2581320wms.175.1648616747677;
        Tue, 29 Mar 2022 22:05:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600015cf00b00203e324347bsm19081430wry.102.2022.03.29.22.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:47 -0700 (PDT)
Message-Id: <47cc63e1dda6fa6417ff6bace4e9e371aaae0d7d.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:30 +0000
Subject: [PATCH v5 12/14] t/perf: add iteration setup mechanism to perf-lib
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
 6 files changed, 74 insertions(+), 33 deletions(-)

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
index 407252bac70..e9cc16d045a 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -189,19 +189,40 @@ exit $ret' >&3 2>&4
 }
 
 test_wrapper_ () {
+	local test_wrapper_func_ test_title_
 	test_wrapper_func_=$1; shift
+	test_title_=$1; shift
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
+
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
@@ -214,6 +235,16 @@ test_perf_ () {
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
@@ -237,11 +268,24 @@ test_perf_ () {
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
@@ -250,6 +294,14 @@ test_size_ () {
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


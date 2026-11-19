Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074050;
	b=X5nHwuM1HBMPn9oPiuE+I42VSh5X2Sb3yY5kOsi2rE2ZKhnwNnMRg9IAjfGwvHwpRxo6
	 OZ/OOnAlCShOxRUCFlOmRq0MblWQD38MsCpHFfvIrB/L5a7RYgBNYraogCfZdH0i+ehja
	 hEdpyZldbHRbvMyeIwUH93orGiSWAeJSqn8p9+aDn1Gmq5BK1K4SgSG5OWHVqUR9bfahy
	 FvV72XboJ3j+hBQlUZEicU7Ov8PKdQwIotnP1M57+/6Jhca2/6X2DL+Z9axu3YkBAKSAf
	 xCFUBn4hLuFVyD0hOooexwdZE22997a5Zu80XDbFzDZPgDBReu0gTJ+TI4nJKz/+E4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=L656aHRm0NyqZzLDd1dJqJ/DLa09M4QOKKY60xV2V5Y=;
	b=Pj7t5iXIR+eLmb2Pw0fdjKjgkf6vd8v5VTzaNAUhweCkN9ZNcc4xjaoN4IYHelVNxLLN
	 jq7KGvXYSsAOYc/jPGc84E3SKytCyqIS+gV75oC23i5UajFkmKazhSz5rAUJlpmoKKs2K
	 9D0OGSlNcayf7MeXytA2Y9pebFdj96BWowxYaSftm+1MavGkI+H3DCiBnSKBcE82NvMYo
	 OMZkPk/1IuVt8YjttF0LUT45zOMYNydWwdWyKaYXpdL/smn7ff//JKbB6CHT9Jk7eHFvG
	 mIYNX4tc+hF0vwgPO6+TlVuDABZzfOmmhOiCRLReY4YGMHSWjdhWtzmmHv9IC0YomCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I75DyXV0;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A4606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160A4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I75DyXV0
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-380b40312e2so5296727eec.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795074048; x=1795678848; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L656aHRm0NyqZzLDd1dJqJ/DLa09M4QOKKY60xV2V5Y=;
        b=I75DyXV0tl6BodBll7KJwxH0WRCCGujfqKfzMU7o5kzIRCF/4dfdFAkVlktb752JEu
         GlJP8yyPKi+IaPvgNMoeu9sr3Wus4STApVoIScoV06QoGeKLWDfmztvyCg+OkGtERt4o
         kCvylsG2VTVwmzqa7381yZ3eypPyZW08zPprlBteBgjjgkusReIHwXPvy+JL5w6Jt94/
         tq/n0tPaeCsrjzCCR/Nsp6Yl3ahO11m6q3tTraQO7bJa0BYypc68eFykD3gv4N91+I9o
         yzuYxeEIjK3Y2vgOsOP9mcNzL/hs8MOqgehT5CBa7Khn258mVQ7zqglq4+hankd4kwMK
         Oq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795074048; x=1795678848;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L656aHRm0NyqZzLDd1dJqJ/DLa09M4QOKKY60xV2V5Y=;
        b=EO2wo2J7GObfBVQUTj9AbUy+ZShfCZjhL9n19mek2MGjP4wW6/9jzdM/jrE49ic9S0
         LuitjXQF3l6luI12HKSEm7j3wSr/i02V3bCKEHYcuRHf1LgbHmy3SEGHxGeyaqt+H03p
         1Hs6+V43KcoxotnBY1cxCxl2z4t7YhpJHFzbDwgoXCr0CXtlQ+ct5saDCwND/sqqfKWx
         vToQ1+P5wD+9QA6Il8rxwkWD+AHsvYAmsCwIKoX+6ez436jATXc3VrcV726Ec5aweDWO
         2qqkLPgEwJCMEuTinSndmydfRZyqKsL0CTiKOuM6NSSQRAnaa6iK1yRiW83Urq1kzhRq
         gJRg==
X-Gm-Message-State: APuU4Z/zrvfmwhDoFIWpGHWGfQAZHnYphbd0HFk3JT5fcMRu/LocaA3A
	7ukmFrCKDCg2ZniLvNmopg9SSUBDhdfnINXpBpWvDEOB7WLoVYJucWWtfDYD3w==
X-Gm-Gg: AZFdTZehRDxme9pVyBCkLt5T8OzwycWXM9JhbR/aFYV6X5GbeGHjsVtHuzGZeBpn9p3
	bIdaLdlWtVxLKu7HgimoHY0Ooe1/evxNm5CPnSXSiyZXnoMrlX6G83xwuCh7/opPKfkNQzK2w8P
	fs3A8f4k0RiV5Ank81A+5l4vML3LzGa38sTT00papRJvPml1khLb/3WQ19uv/zo9JcN2uKMt7qP
	Y/kizHiVy8Kr/L6NyAMkAS6gZmrdSlLS1Op51sz+nuR6f6zxjiwye78Wn5nb65ZcmP/oiQla0GT
	F081izWpVN+6JsATJeZUtQ/kbC3Hl10f04N56gH+sAAMrBtGXoP4P9X2kdOkpqgPsrshKouafZU
	cwAxDJtP3sfuovT1MQY8kWzNI3cfml7nu15m6dMPn7IIsiv1LZiqoVzIT4PmK7u1xfwEN+iZWpy
	0H2nOXc8o1D5DbrUWii4bDaKfCDeWLARjr9IkgkfkFM82DXqASZZiMNk11k6Tpfq3bXeJSxlxHa
	YSEAlTBgs/l/gNtB23MccqtamLGheZkdRQVXEGsIaufDQtf5eHoMM4VDNIOUcQAC92q/meyYGMO
	znyPRgbJX1UVC+DxSuJHqX1vIvmyG2NP25WJ
X-Received: by 2002:a05:7301:fc13:b0:37f:73f9:aee7 with SMTP id 5a478bee46e88-3827da11e94mr5128011eec.5.1795074047948;
        Wed, 18 Nov 2026 23:40:47 -0800 (PST)
Received: from [127.0.1.1] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a45260a8sm25234574eec.3.2026.11.18.23.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:40:47 -0800 (PST)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Thu, 19 Nov 2026 13:10:31 +0530
Subject: [PATCH] test-lib: run EXPENSIVE tests one at a time
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO+n/moC/yWMQQrDIBBFryKzzoBKSUqvErpIzJhOG7Q4JhQkd
 6+2y/f57xUQSkwCN1Ug0cHCMVQwnQL3mMJKyEtlsNr2xpgBX4KOcYthxUySsZ3Q8we1vtJg/XL
 RroeqvxPV+Zce73+WfX6Sy60H5/kFoVe0MHwAAAA=
X-Change-ID: 20261117-ks-ci-long-test-hang-fix-008e72fd40c6
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.16.0

Recently, we've acquired quite a few expensive test in our test suite.
For instance, these commits add several tests that require
multi-gigabytes:

  - 9048b48fb (t1600-index: add expensive tests for over-long
    tree paths, 2026-10-16) added tests to t1600

  - 288266c11d (xdiff: use size_t for merge buffer size computations,
    2026-10-16) added tests to t4300

  - 55c54fd375 (apply: reject binary patches greater than MAX_APPLY_SIZE,
    2026-03-25), added tests to t4141

We also have the memory hungry 5GB filtered hash-object test in t1007.

When GIT_TEST_LONG is set, "prove --jobs" happily runs several of these
at once. On the 16GB GitLab CI runners this exhausts memory: the
sanitizer jobs have been hanging in t1007 until they hit the job
timeout ever since the new EXPENSIVE tests in t1600 started running
alongside it. Running the two under a 16GB memory cap reproduces it,
with the t1007 git process getting OOM-killed.

GitHub CI runners are no exception and observe the same behaviour.

Take a lock shared by all test scripts around each EXPENSIVE test, so
only one of them runs at a time. The lock is a directory in
TEST_RESULTS_DIR, created with mkdir(1) like the existing valgrind
symlink lock. It records the holder's PID so that a lock left behind by
a script that was killed with SIGKILL gets taken over by the next
waiter. It is released after the test and its cleanup finish, and from
the EXIT trap when a script dies or is interrupted while holding it.

Cheap tests in the same scripts keep running in parallel. Only the
expensive ones wait for each other.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
In recent times, we've been noticing the sanitizer jobs (linux-leaks,
linux-reftable-leaks, linux-asan-ubsan) hang and fail with timeout in
our GitLab CI runners. On some digging, it turns out that this is
because of multiple memory hungry tests running in parallel.

So, I thought of suggesting this patch to serialize the expensive tests
at least to avoid the putting the CI runners under memory pressure.

The GitHub CI runners also observed the same behaviour.

Both CI runners are happy with this change.

GitHub: https://github.com/sivaraam/git/actions/runs/43281285339
GitLab: https://gitlab.com/gitlab-org/git/-/pipelines/3079929506
---
 t/README      |  4 +++-
 t/test-lib.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index fd7e8504b5..c156dd3af6 100644
--- a/t/README
+++ b/t/README
@@ -117,7 +117,9 @@ appropriately before running "make". Short options can be bundled, i.e.
 -l::
 --long-tests::
 	This causes additional long-running tests to be run (where
-	available), for more exhaustive testing.
+	available), for more exhaustive testing. These tests can use a
+	lot of memory and disk, so only one of them runs at a time, even
+	when several test scripts run in parallel (e.g. "prove --jobs").
 
 -r::
 --run=<test-selector>::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c56654b7c5..4d29172c9d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -784,6 +784,7 @@ die () {
 	# test script run with '--immediate' fails, or when the user hits
 	# ctrl-C, i.e. when 'test_done' is not invoked at all.
 	test_atexit_handler || code=$?
+	release_expensive_lock_
 	if test -n "$GIT_EXIT_OK"
 	then
 		exit $code
@@ -1089,6 +1090,42 @@ fail_117 () {
 	return 117
 }
 
+# EXPENSIVE tests can need many gigabytes of memory or disk, so two of
+# them running at the same time under "prove --jobs" can exhaust the
+# machine. Allow only one at a time across all test scripts that share
+# this TEST_OUTPUT_DIRECTORY.
+expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
+have_expensive_lock_=
+
+acquire_expensive_lock_ () {
+	mkdir -p "$TEST_RESULTS_DIR" || return 1
+	while ! mkdir "$expensive_lock_" 2>/dev/null
+	do
+		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
+		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
+		then
+			# The holder was killed without releasing the lock.
+			rm -rf "$expensive_lock_"
+			continue
+		fi
+		if test -z "$expensive_lock_waited_"
+		then
+			say >&3 "waiting for another EXPENSIVE test to finish"
+			expensive_lock_waited_=t
+		fi
+		sleep 1
+	done
+	expensive_lock_waited_=
+	echo $$ >"$expensive_lock_/pid"
+	have_expensive_lock_=t
+}
+
+release_expensive_lock_ () {
+	test -n "$have_expensive_lock_" || return 0
+	rm -rf "$expensive_lock_"
+	have_expensive_lock_=
+}
+
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
@@ -1103,6 +1140,12 @@ test_run_ () {
 		fi
 	fi
 
+	case ",$test_prereq," in
+	*,EXPENSIVE,*)
+		acquire_expensive_lock_
+		;;
+	esac
+
 	setup_malloc_check
 	test_eval_ "$1"
 	eval_ret=$?
@@ -1115,6 +1158,7 @@ test_run_ () {
 		test_eval_ "$test_cleanup"
 		teardown_malloc_check
 	fi
+	release_expensive_lock_
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
 	then
 		echo ""

---
base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
change-id: 20261117-ks-ci-long-test-hang-fix-008e72fd40c6


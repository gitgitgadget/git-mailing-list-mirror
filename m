Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6F21F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeJaVkS (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 17:40:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41658 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbeJaVkS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 17:40:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so16319648wrw.8
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d32Csq0FyspoC6YJvyOapgRX2BF/CkWM94zee6csHhM=;
        b=CDxMdV2hNAidrTATrAWGk6mCi2+fG48j/I3dR09fYprTlvQx6zhbltdJEaRMJMYeMU
         Ur7vuSws+6VCrhAjCI6bjIAXVLugCc3FhFPa7zLN4sPIyHh7QONN5xY7yvjmQzKy/7xJ
         7+PbYLBr/EIQ5Zlv+BZ0VnvHpE1LnZKjvmF+1zL41Wfvgr5ZgfZDy5EFl/b8KhxumoXY
         W0HOZLbKTWaC00nB8PTJPEj6YDRfNlLIBuL5RXvzAFJVrwdeKRXMT0v5trIV7p+clV8r
         21QMCZGlzR3c3zIw/saI7oWQeZjaNXPSrzf0V+IhxQQI62T8aQ3kyEN/QnnaAgdbd6JY
         CoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d32Csq0FyspoC6YJvyOapgRX2BF/CkWM94zee6csHhM=;
        b=WLPVgSFCDB5isme4Ck30BEnsFjdzLspT8YeHY+UKo0YkQpYWqHsNwx66Av8rwmYIXy
         4PvnaQgjuqf/6FD3oX/zRvzPmRMdlI/4aQdPt+gXNTJ2eC9O7Te7ORhdi23/8dn4wzF2
         gMYFp0yKW5/d9aKSVBuWvW5S5G9gC+YNvM9/Sc6SuL6s2Me0LH11uxiBiRZp86KMZOs0
         qKq/Fcc6kD4MsunNCiH3nTQ58trmbNRDHHKQapg8Q8zj1IOjYviju0D9UqeIV6FH+lC2
         055E2WWgNbUhFXaEShX7IgotzQbwBYoXH2gED845s4uZuqeF+TgjBdNhHqWj+2i7GXGR
         7lXg==
X-Gm-Message-State: AGRZ1gIs9hSg/mV5SW5Q/m4qD4W3DHPIwvBfOBJScf84uRlpv8Sw0Hrk
        n09eSiiizpUs7JioFAR7ZT3RD4H4Fb0=
X-Google-Smtp-Source: AJdET5du4ZChJ90EtZzBOa+I4jz8lPRWN0hW2OMfWA5Y8+T1952ENRIAnRPwKiKFgex8eWim49KKww==
X-Received: by 2002:adf:84c1:: with SMTP id 59-v6mr2900454wrg.144.1540989744602;
        Wed, 31 Oct 2018 05:42:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l42-v6sm2336705wre.37.2018.10.31.05.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:42:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] tests: add a special test setup that runs "git fsck" before exiting
Date:   Wed, 31 Oct 2018 12:42:08 +0000
Message-Id: <20181031124208.29451-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181030232337.GC32038@sigill.intra.peff.net>
References: <20181030232337.GC32038@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to run the tests with GIT_TEST_FSCK=true in the
environment. If set we'll run "git fsck" at the end of every test, and
those tests that fail need to annotate what their failure was.

The goal is to detect regressions in fsck that our tests might
otherwise miss. We had one such regression in c68b489e56 ("fsck: parse
loose object paths directly", 2017-01-13) released with Git 2.12.0,
which wasn't spotted more than a year and a half later during the
2.20.0 window.

As it turns out there already was a test for what triggerd that bug
all along in the form of t5000-tar-tree.sh, we just weren't running
"git fsck" at the end[1].

That specific bug has been fixed in ("check_stream_sha1(): handle
input underflow", 2018-10-30)[1], but since we have a demonstrable
history of not anticipating which tests which would make "git fsck"
fail need to be made part of the "git fsck" test suite let's add this
test mode to cover potential blind spots. The "git fsck" command is
also something where we might expect that during our RC windows users
aren't actively testing on already corrupt repositories, so "in the
wild" test coverage will be spotty, so we need all the help we can
get.

1. https://public-inbox.org/git/878t2fkxrn.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/20181030232312.GB32038@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                |  5 +++++
 t/t0000-basic.sh        | 26 ++++++++++++++++++++++++++
 t/test-lib-functions.sh |  2 ++
 t/test-lib.sh           | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/t/README b/t/README
index 8847489640..092f78b3d7 100644
--- a/t/README
+++ b/t/README
@@ -343,6 +343,11 @@ of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
 index loading single threaded.
 
+GIT_TEST_FSCK=<boolean> if true arranges for "git fsck" to be run at
+the end of the test scripts. Those tests that fail will need to set a
+"GIT_TEST_FSCK_TESTS" variable before we enter "test_done" with a test
+fragment to test that fsck.{out,err} is the expected failure.
+
 Naming Tests
 ------------
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4d23373526..8e667e6691 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -19,6 +19,7 @@ modification *should* take notice and update the test vectors here.
 '
 
 . ./test-lib.sh
+unset GIT_TEST_FSCK
 
 try_local_x () {
 	local x="local" &&
@@ -393,6 +394,31 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
 	)
 "
 
+test_expect_success 'GIT_TEST_FSCK=true' "
+	test_when_finished 'sane_unset GIT_TEST_FSCK' &&
+	GIT_TEST_FSCK=true &&
+	export GIT_TEST_FSCK &&
+	run_sub_test_lib_test run-git-fsck-test \
+		'--run basic' --run='1 3 5' <<-\\EOF &&
+	for i in 1 2 3 4 5 6
+	do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	GIT_TEST_FSCK=true test_done
+	EOF
+	check_sub_test_lib_test run-git-fsck-test <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 # skip passing test #2 (--run)
+	> ok 3 - passing test #3
+	> ok 4 # skip passing test #4 (--run)
+	> ok 5 - passing test #5
+	> ok 6 # skip passing test #6 (--run)
+	> ok 7 # skip git fsck at end (due to GIT_TEST_FSCK) (expected to succeed) (--run)
+	> # passed all 7 test(s)
+	> 1..7
+	EOF
+"
+
 test_expect_success '--run basic' "
 	run_sub_test_lib_test run-basic \
 		'--run basic' --run='1 3 5' <<-\\EOF &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..7d002ff5aa 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -470,6 +470,7 @@ test_expect_success () {
 # Usage: test_external description command arguments...
 # Example: test_external 'Perl API' perl ../path/to/test.pl
 test_external () {
+	unset GIT_TEST_FSCK
 	test "$#" = 4 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 3 ||
 	error >&5 "bug in the test script: not 3 or 4 parameters to test_external"
@@ -511,6 +512,7 @@ test_external () {
 # Like test_external, but in addition tests that the command generated
 # no output on stderr.
 test_external_without_stderr () {
+	unset GIT_TEST_FSCK
 	# The temporary file has no (and must have no) security
 	# implications.
 	tmp=${TMPDIR:-/tmp}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 897e6fcc94..5f7f5595e3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -454,6 +454,8 @@ GIT_EXIT_OK=
 trap 'die' EXIT
 trap 'exit $?' INT
 
+GIT_TEST_FSCK_TESTS=
+
 # The user-facing functions are loaded from a separate file so that
 # test_perf subshells can have them too
 . "$TEST_DIRECTORY/test-lib-functions.sh"
@@ -789,7 +791,36 @@ test_at_end_hook_ () {
 	:
 }
 
+_test_done_fsck() {
+	desc='git fsck at end (due to GIT_TEST_FSCK)'
+	if test -n "$GIT_TEST_FSCK_TESTS"
+	then
+		test_expect_success "$desc (expected to fail)" '
+			test_must_fail git fsck 2>fsck.err >fsck.out
+		'
+		test_expect_success "$desc (expected to fail) -- assert failure mode" "
+			test_path_exists fsck.err &&
+			test_path_exists fsck.out &&
+			$GIT_TEST_FSCK_TESTS
+		"
+	else
+		test_expect_success "$desc (expected to succeed)" '
+			git fsck
+		'
+	fi
+}
+
 test_done () {
+	# Don't want to run this under TEST_NO_CREATE_REPO, otherwise
+	# we end up sloowly running "git fsck" against git.git
+	if test -z "$TEST_NO_CREATE_REPO" &&
+		    # test -n first so all --verbose output isn't
+		    # polluted with this check
+		    test -n "$GIT_TEST_FSCK" &&
+		    test_have_prereq TEST_FSCK
+	then
+		_test_done_fsck
+	fi
 	GIT_EXIT_OK=t
 
 	if test -z "$HARNESS_ACTIVE"
@@ -1268,3 +1299,5 @@ test_lazy_prereq CURL '
 test_lazy_prereq SHA1 '
 	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
 '
+
+test_lazy_prereq TEST_FSCK 'test-tool env-bool GIT_TEST_FSCK'
-- 
2.19.1.899.g0250525e69


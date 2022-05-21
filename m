Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878E1C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347144AbiEUWTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347037AbiEUWTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3094EF69
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k30so15902607wrd.5
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=le2cv+HomVUYLKGp+TzkR9V/sqB0i/ZnSks/92czT8U=;
        b=HDgkzuXiHjP8E5zaxYcWdxmjSK/kDj4GRU4UTTP6tVe14yMNOjue39y6lj1/z8KHxu
         4z08HS7yW4zQz5F+h4kbUtz1YlzIWiEsqYsH6/JlOaOqD6bUViIVVpzKrnY+d37rnBGU
         gM0K4a+6yUXY/Jb/Bw279ScTejXYtQwq0zEdgyIhYy0bD3CEe5v44/aXVYgV15ES1Urz
         D1Ui6t8JUGleLKPuKGSAcesZCRvUqB1T1b1cJ0ngS3iJs/iyIBNwaIn+oZn5K5jfxEnr
         i86nGMckt/6+bKvV5wK2qrywo9Xws0Ldea4SYB3I0ZRKniQvrHBlqrUbdpD25iSCL41v
         357A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=le2cv+HomVUYLKGp+TzkR9V/sqB0i/ZnSks/92czT8U=;
        b=Cfx/hp9YVvFKkj4pujtuXJ77F0Wy6C0AYrS0npOV8XsPg7BNFLgTmXQW8ScRqc77a2
         iUHmNCXPP4ne2T0ERoPYNU0KVLudSSbXpWc4eQnS5ef3OgDzUpCLY5C5J3Xz7Oj5Tyl/
         PkRWIKyN78S6Jr+jeagfym0gLylLbS74vcYnBgu2rZvOTesIKsLcRofvbvOJDEur1prW
         b6GuQLzXTDNIWay7fjE/jKNGcl89+l4sl2rUSKA7b9J1EeiayVUZg/iOPNEAPzBBV5ag
         W1LDlNgXGk/g55OmRUsKlGJ1ZZIcEDQ642UFozMX9q5CM4Jx1wOjaRcKb9+ot/BjAi5H
         CLMQ==
X-Gm-Message-State: AOAM531c2v+QDIFKfeZNY5Fiaj5RoHKOhNR6sjO9NRwZR5DtngyA17EO
        VBzJNsm8N1VdIV+3jHdsIJHpDGiFrHY=
X-Google-Smtp-Source: ABdhPJx6RT5Y5sYaHPB7x2jiYgn5o9aooEQwVUAVHjNQyCMJwtRtYDEgCzj1e2zzl4ivjjjW3pxHlQ==
X-Received: by 2002:adf:eb4c:0:b0:20e:64b8:1ce8 with SMTP id u12-20020adfeb4c000000b0020e64b81ce8mr13425669wrn.609.1653171540022;
        Sat, 21 May 2022 15:19:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m40-20020a05600c3b2800b00397381a7ae8sm5167433wms.30.2022.05.21.15.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:18:59 -0700 (PDT)
Message-Id: <cbf476e4e988cd24ed42fd6f5ddaa7840a33583b.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:46 +0000
Subject: [PATCH v3 02/12] tests: refactor --write-junit-xml code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The code writing JUnit XML is interspersed directly with all the code in
`t/test-lib.sh`, and it is therefore not only ill-separated, but
introducing yet another output format would make the situation even
worse.

Let's introduce an abstraction layer by hiding the JUnit XML code behind
four new functions that are supposed to be called before and after each
test and test case.

This is not just an academic exercise, refactoring for refactoring's
sake. We _actually_ want to introduce such a new output format, to
make it substantially easier to diagnose test failures in our GitHub
workflow, therefore we do need this refactoring.

This commit is best viewed with `git show --color-moved
--color-moved-ws=allow-indentation-change <commit>`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-junit.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh       | 124 ++++++-------------------------------------
 2 files changed, 142 insertions(+), 108 deletions(-)
 create mode 100644 t/test-lib-junit.sh

diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
new file mode 100644
index 00000000000..9d55d74d764
--- /dev/null
+++ b/t/test-lib-junit.sh
@@ -0,0 +1,126 @@
+# Library of functions to format test scripts' output in JUnit XML
+# format, to support Git's test suite result to be presented in an
+# easily digestible way on Azure Pipelines.
+#
+# Copyright (c) 2022 Johannes Schindelin
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
+#
+# The idea is for `test-lib.sh` to source this file when the user asks
+# for JUnit XML; these functions will then override (empty) functions
+# that are are called at the appropriate times during the test runs.
+
+start_test_output () {
+	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
+	mkdir -p "$junit_xml_dir"
+	junit_xml_base=${1##*/}
+	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
+	junit_attrs="name=\"${junit_xml_base%.sh}\""
+	junit_attrs="$junit_attrs timestamp=\"$(TZ=UTC \
+		date +%Y-%m-%dT%H:%M:%S)\""
+	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
+	junit_suite_start=$(test-tool date getnanos)
+	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+	then
+		GIT_TEST_TEE_OFFSET=0
+	fi
+}
+
+start_test_case_output () {
+	junit_start=$(test-tool date getnanos)
+}
+
+finalize_test_case_output () {
+	test_case_result=$1
+	shift
+	case "$test_case_result" in
+	ok)
+		set "$*"
+		;;
+	failure)
+		junit_insert="<failure message=\"not ok $test_count -"
+		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
+		junit_insert="$junit_insert $(xml_attr_encode \
+			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+			   then
+				test-tool path-utils skip-n-bytes \
+					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+			   else
+				printf '%s\n' "$@" | sed 1d
+			   fi)")"
+		junit_insert="$junit_insert</failure>"
+		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+		then
+			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
+				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
+		fi
+		set "$1" "      $junit_insert"
+		;;
+	fixed)
+		set "$* (breakage fixed)"
+		;;
+	broken)
+		set "$* (known breakage)"
+		;;
+	skip)
+		message="$(xml_attr_encode "$skipped_reason")"
+		set "$1" "      <skipped message=\"$message\" />"
+		;;
+	esac
+
+	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
+	shift
+	junit_attrs="$junit_attrs classname=\"$this_test\""
+	junit_attrs="$junit_attrs time=\"$(test-tool \
+		date getnanos $junit_start)\""
+	write_junit_xml "$(printf '%s\n' \
+		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
+	junit_have_testcase=t
+}
+
+finalize_test_output () {
+	if test -n "$junit_xml_path"
+	then
+		test -n "$junit_have_testcase" || {
+			junit_start=$(test-tool date getnanos)
+			write_junit_xml_testcase "all tests skipped"
+		}
+
+		# adjust the overall time
+		junit_time=$(test-tool date getnanos $junit_suite_start)
+		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
+			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
+			-e '/^ *<\/testsuite/d' \
+			<"$junit_xml_path" >"$junit_xml_path.new"
+		mv "$junit_xml_path.new" "$junit_xml_path"
+
+		write_junit_xml "  </testsuite>" "</testsuites>"
+		write_junit_xml=
+	fi
+}
+
+write_junit_xml () {
+	case "$1" in
+	--truncate)
+		>"$junit_xml_path"
+		junit_have_testcase=
+		shift
+		;;
+	esac
+	printf '%s\n' "$@" >>"$junit_xml_path"
+}
+
+xml_attr_encode () {
+	printf '%s\n' "$@" | test-tool xml-encode
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f09e8f3efce..bdb11e28eea 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -137,6 +137,12 @@ mark_option_requires_arg () {
 	store_arg_to=$2
 }
 
+# These functions can be overridden e.g. to output JUnit XML
+start_test_output () { :; }
+start_test_case_output () { :; }
+finalize_test_case_output () { :; }
+finalize_test_output () { :; }
+
 parse_option () {
 	local opt="$1"
 
@@ -196,7 +202,7 @@ parse_option () {
 		tee=t
 		;;
 	--write-junit-xml)
-		write_junit_xml=t
+		. "$TEST_DIRECTORY/test-lib-junit.sh"
 		;;
 	--stress)
 		stress=t ;;
@@ -664,7 +670,7 @@ exec 6<&0
 exec 7>&2
 
 _error_exit () {
-	finalize_junit_xml
+	finalize_test_output
 	GIT_EXIT_OK=t
 	exit 1
 }
@@ -774,35 +780,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$*"
-	fi
+	finalize_test_case_output ok "$@"
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
 }
 
 test_failure_ () {
-	if test -n "$write_junit_xml"
-	then
-		junit_insert="<failure message=\"not ok $test_count -"
-		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
-		junit_insert="$junit_insert $(xml_attr_encode \
-			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-			   then
-				test-tool path-utils skip-n-bytes \
-					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
-			   else
-				printf '%s\n' "$@" | sed 1d
-			   fi)")"
-		junit_insert="$junit_insert</failure>"
-		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-		then
-			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
-				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
-		fi
-		write_junit_xml_testcase "$1" "      $junit_insert"
-	fi
+	finalize_test_case_output failure "$@"
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
@@ -815,19 +799,13 @@ test_failure_ () {
 }
 
 test_known_broken_ok_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$* (breakage fixed)"
-	fi
+	finalize_test_case_output fixed "$@"
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$* (known breakage)"
-	fi
+	finalize_test_case_output broken "$@"
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
@@ -1104,10 +1082,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	if test -n "$write_junit_xml"
-	then
-		junit_start=$(test-tool date getnanos)
-	fi
+	start_test_case_output
 }
 
 test_finish_ () {
@@ -1158,12 +1133,7 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		if test -n "$write_junit_xml"
-		then
-			message="$(xml_attr_encode "$skipped_reason")"
-			write_junit_xml_testcase "$1" \
-				"      <skipped message=\"$message\" />"
-		fi
+		finalize_test_case_output skip "$@"
 
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
@@ -1179,53 +1149,6 @@ test_at_end_hook_ () {
 	:
 }
 
-write_junit_xml () {
-	case "$1" in
-	--truncate)
-		>"$junit_xml_path"
-		junit_have_testcase=
-		shift
-		;;
-	esac
-	printf '%s\n' "$@" >>"$junit_xml_path"
-}
-
-xml_attr_encode () {
-	printf '%s\n' "$@" | test-tool xml-encode
-}
-
-write_junit_xml_testcase () {
-	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
-	shift
-	junit_attrs="$junit_attrs classname=\"$this_test\""
-	junit_attrs="$junit_attrs time=\"$(test-tool \
-		date getnanos $junit_start)\""
-	write_junit_xml "$(printf '%s\n' \
-		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
-	junit_have_testcase=t
-}
-
-finalize_junit_xml () {
-	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
-	then
-		test -n "$junit_have_testcase" || {
-			junit_start=$(test-tool date getnanos)
-			write_junit_xml_testcase "all tests skipped"
-		}
-
-		# adjust the overall time
-		junit_time=$(test-tool date getnanos $junit_suite_start)
-		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
-			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
-			-e '/^ *<\/testsuite/d' \
-			<"$junit_xml_path" >"$junit_xml_path.new"
-		mv "$junit_xml_path.new" "$junit_xml_path"
-
-		write_junit_xml "  </testsuite>" "</testsuites>"
-		write_junit_xml=
-	fi
-}
-
 test_atexit_cleanup=:
 test_atexit_handler () {
 	# In a succeeding test script 'test_atexit_handler' is invoked
@@ -1248,7 +1171,7 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	finalize_junit_xml
+	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
 	then
@@ -1539,22 +1462,7 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
 
-if test -n "$write_junit_xml"
-then
-	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
-	mkdir -p "$junit_xml_dir"
-	junit_xml_base=${0##*/}
-	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
-	junit_attrs="name=\"${junit_xml_base%.sh}\""
-	junit_attrs="$junit_attrs timestamp=\"$(TZ=UTC \
-		date +%Y-%m-%dT%H:%M:%S)\""
-	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
-	junit_suite_start=$(test-tool date getnanos)
-	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-	then
-		GIT_TEST_TEE_OFFSET=0
-	fi
-fi
+start_test_output "$0"
 
 # Convenience
 # A regexp to match 5 and 35 hexdigits
-- 
gitgitgadget


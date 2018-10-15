Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFC51F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJOR4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:41 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40111 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:40 -0400
Received: by mail-pg1-f180.google.com with SMTP id n31-v6so8936888pgm.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gPWGZ2JCNoc3E32GHvBNMmbF54a9B105ZM2Iy8SOCJM=;
        b=qWI7EwOG8P9u4YERwiDlbJ3jCFM+7tGZADwAsUURyxPL3IzCeELkLh+xjJhevhY2tl
         tUEYdRowyB8ofr/ZGqGGYn0GJnow7BpRXjOAvc5b2hO2IBkJkGaLmy7vrTwU1G6dZ/Dh
         0f+9ho8knuxisNgo8osMg6RVxJzSNU6oHt7MRvRPeTVHgI6fEhxxlbrWt4dzYB3RAOTw
         RMkk/vMH8ZfvLZAfHBy9c5tIX5PM2Pc3Fgx3Fgg89RPhHvstYqKAbtggM7qwKMBYkghl
         +AyV6SFQ4HQrMX1inrWEB+44ffC6k0hS/gE5BNxMAfNSxAX3cR4pV+YiSSrKm936GzSL
         DTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gPWGZ2JCNoc3E32GHvBNMmbF54a9B105ZM2Iy8SOCJM=;
        b=QoiiEwQheJZqK2Fr4CVCTZ6oqyQZnsZzpfb6TNobWVhtXNWHDmAwnL1N58lVlHZ/c2
         kZ5/FejRexJ8DL2tMzoB7WwsUj8eTul4Gyq468StVum/d1I9AdwIK8bilrCsD2PRsioU
         7sRv0PMOOfk4u6CeqO3wMcwgxldyjGoG4ALIbTF5L6bJFTshULqWzjg6kQz+dRQGHrqf
         rBsZGNKWtHM8ItNsmofaMZCQ+hlUROcWwmxtAvKjCvyRLAlL94vNAbX4HqVTEJXzC1vT
         yWYV22ObGIl6Aqg61z25OnqA+Y3l8er727yxkY2EtfUVKzaf/6aVGKWzhcZwGeQ03jfS
         Fwyw==
X-Gm-Message-State: ABuFfoiYhl8UlJRJyqK2uXC6GTvTm12ATg2dFCTeGfEoAYBYxUN3rB7z
        lS/bD4IfXQ35kXt1LhAMcTvZZVuO
X-Google-Smtp-Source: ACcGV61qcBQg+NOwBEYIpL4kaTVFbnJTEeJP/vX8/qaM7gCsuKuGNUeObqIRaOsFZNiDL9IgXhmvEA==
X-Received: by 2002:a62:9fc4:: with SMTP id v65-v6mr17071182pfk.130.1539598324830;
        Mon, 15 Oct 2018 03:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 68-v6sm13286480pfg.136.2018.10.15.03.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:04 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:04 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:46 GMT
Message-Id: <cf4c5ae47007651a95cbfc56f126326429e17999.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/13] tests: optionally write results as JUnit-style .xml
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This will come in handy when publishing the results of Git's test suite
during an automated Azure DevOps run.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitignore  |  1 +
 t/test-lib.sh | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/t/.gitignore b/t/.gitignore
index 348715f0e4..91cf5772fe 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -2,3 +2,4 @@
 /test-results
 /.prove
 /chainlinttmp
+/out/
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f95bfda60..7ed0013f6d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -288,6 +288,9 @@ do
 	--verbose-log)
 		verbose_log=t
 		shift ;;
+	--write-junit-xml)
+		write_junit_xml=t
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -431,11 +434,24 @@ trap 'exit $?' INT
 # the test_expect_* functions instead.
 
 test_ok_ () {
+	if test -n "$write_junit_xml"
+	then
+		write_junit_xml_testcase "$*"
+	fi
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
 }
 
 test_failure_ () {
+	if test -n "$write_junit_xml"
+	then
+		junit_insert="<failure message=\"not ok $test_count -"
+		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
+		junit_insert="$junit_insert $(xml_attr_encode \
+			"$(printf '%s\n' "$@" | sed 1d)")"
+		junit_insert="$junit_insert</failure>"
+		write_junit_xml_testcase "$1" "      $junit_insert"
+	fi
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
@@ -444,11 +460,19 @@ test_failure_ () {
 }
 
 test_known_broken_ok_ () {
+	if test -n "$write_junit_xml"
+	then
+		write_junit_xml_testcase "$* (breakage fixed)"
+	fi
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
+	if test -n "$write_junit_xml"
+	then
+		write_junit_xml_testcase "$* (known breakage)"
+	fi
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
@@ -706,6 +730,10 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
+	if test -n "$write_junit_xml"
+	then
+		junit_start=$(test-tool date getnanos)
+	fi
 }
 
 test_finish_ () {
@@ -743,6 +771,13 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
+		if test -n "$write_junit_xml"
+		then
+			message="$(xml_attr_encode "$skipped_reason")"
+			write_junit_xml_testcase "$1" \
+				"      <skipped message=\"$message\" />"
+		fi
+
 		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
@@ -758,9 +793,58 @@ test_at_end_hook_ () {
 	:
 }
 
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
+	# We do not translate CR to &#x0d; because BSD sed does not handle
+	# \r in the regex. In practice, the output should not even have any
+	# carriage returns.
+	printf '%s\n' "$@" |
+	sed -e 's/&/\&amp;/g' -e "s/'/\&apos;/g" -e 's/"/\&quot;/g' \
+		-e 's/</\&lt;/g' -e 's/>/\&gt;/g' \
+		-e 's/	/\&#x09;/g' -e 's/$/\&#x0a;/' -e '$s/&#x0a;$//' |
+	tr -d '\012\015'
+}
+
+write_junit_xml_testcase () {
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
 test_done () {
 	GIT_EXIT_OK=t
 
+	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
+	then
+		test -n "$junit_have_testcase" || {
+			junit_start=$(test-tool date getnanos)
+			write_junit_xml_testcase "all tests skipped"
+		}
+
+		# adjust the overall time
+		junit_time=$(test-tool date getnanos $junit_suite_start)
+		sed "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
+			<"$junit_xml_path" >"$junit_xml_path.new"
+		mv "$junit_xml_path.new" "$junit_xml_path"
+
+		write_junit_xml "  </testsuite>" "</testsuites>"
+	fi
+
 	if test -z "$HARNESS_ACTIVE"
 	then
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
@@ -996,6 +1080,7 @@ then
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
+
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
@@ -1009,6 +1094,19 @@ then
 	test_done
 fi
 
+if test -n "$write_junit_xml"
+then
+	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
+	mkdir -p "$junit_xml_dir"
+	junit_xml_base=${0##*/}
+	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
+	junit_attrs="name=\"${junit_xml_base%.sh}\""
+	junit_attrs="$junit_attrs timestamp=\"$(TZ=UTC \
+		date +%Y-%m-%dT%H:%M:%S)\""
+	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
+	junit_suite_start=$(test-tool date getnanos)
+fi
+
 # Provide an implementation of the 'yes' utility
 yes () {
 	if test $# = 0
-- 
gitgitgadget


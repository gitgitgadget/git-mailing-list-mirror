Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F0EC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiJFPBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiJFPBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:01:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463719C7FE
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:01:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u10so3138940wrq.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvRFiaJmsqetlNJFKWxu6EIX9Z/N0PlvHHmepEUvuvc=;
        b=aJ6ZGjLhCMAor+E+3YRRaum54NrhxN+mynVy2jqWQ3z6OWjFUT1TooUWAhdz3FawMl
         ePlqOzDxkgjl4VN81BMO7KUb3nQ5iIo0WLyhdbPtHXUE5Fvw7NReu9R6OTjPgMVExUp/
         I3BAXohnRTXhKHTwq0zkWgakn1YhWIbN7muKavUf58AlPJR9mrkdzlGlrBQOfXCdbauc
         rMJU8ckUpohiRe7uhL3jctPlO6802SQiWZJMUjI4GHVitDDI6ypuooSYhFyPsMtCbS24
         3hznseoTJgvoDNUUN1fAeNF60kmbBJJRco+i9aP9pO1NuL0PCkOSCodOFSkZjI9Ru5I6
         Fluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvRFiaJmsqetlNJFKWxu6EIX9Z/N0PlvHHmepEUvuvc=;
        b=XDNa7+yaBS1IE0M6pue3lANRx3Ep0ltb9R4/dfri4Nt02W4al3r9NkYiq7VMwtOd5i
         L+2aPoNg6kGD3ehTszF3VnR+oyBgAhmuYQKIy2M8LnHvLI+lgoy+vqIfEqCGSS/JT3ts
         C5n5f5nFydLn+vidHpJTO/IGnjBzgDXMJLXsHyXl5qByGZVVJtz9HkPkW7SGrzI+2ICE
         e4pBktJ7YT/u+T7P90V6igf/GGD09HJas0jIpuLDLxqg3iO0E5KfdCRmWRTjJcz/gCan
         tC5F4IcJWuefNhV++Mku/mFQHuW50CQz6hBI2t4aV6Txf+CdpJrjFUwiANyP+ONDjnwL
         Yt8Q==
X-Gm-Message-State: ACrzQf2WvZsWKGPiw8q4Jr5qmoDg2vI6S2CNWRdtNHt0LagtuyVB5DwG
        UOF3E4u4wQEbXzKxPNsDGZFLSR+bFXs=
X-Google-Smtp-Source: AMsMyM79SFAYG1V7DuIiRqExpxZDnRZ/E1bl/n9IEuYhpjsyEi2c7tBtBT4LGE8gxMhPCtRchUljoQ==
X-Received: by 2002:a05:6000:2c1:b0:22e:7507:a182 with SMTP id o1-20020a05600002c100b0022e7507a182mr244752wry.550.1665068479264;
        Thu, 06 Oct 2022 08:01:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003a682354f63sm5707409wmq.11.2022.10.06.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:01:18 -0700 (PDT)
Message-Id: <645fa2990f79bdb7ee00ff3fd34122676469a783.1665068476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 15:01:15 +0000
Subject: [PATCH 2/3] [RFC] test_todo: allow [!] grep as the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Many failing tests use grep, this commit converts a sample to use
test_todo(). As POSIX specifies that a return code greater than one
indicates an error rather than a failing match we take care not the
hide that.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t0000-basic.sh                | 20 ++++++++++--
 t/t3510-cherry-pick-sequence.sh | 12 +++----
 t/t4014-format-patch.sh         | 20 ++++++------
 t/test-lib-functions.sh         | 56 ++++++++++++++++++++++++++++-----
 4 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 52362ad3dd3..db5c2059eb5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -190,6 +190,14 @@ test_expect_success 'subtest: test_todo allowed arguments' '
 		"test_todo test_must_fail git --version"
 	test_expect_success "test_todo test_must_fail rejects bad command" \
 		"test_todo test_must_fail test_true"
+	test_expect_success "test_todo accepts grep" \
+		"echo a >a && test_todo grep b <a"
+	test_expect_success "test_todo accepts ! grep" \
+		"echo a >a && test_todo ! grep -v b <a"
+	test_expect_success "test_todo detects grep errors" \
+		"echo a >a && test_todo grep --invalid-option b <a"
+	test_expect_success "test_todo detects ! grep errors" \
+		"echo a >a && test_todo ! grep --invalid-option -v b <a"
 	test_done
 	EOF
 	check_sub_test_lib_test acceptable-test-todo <<-\EOF
@@ -199,9 +207,15 @@ test_expect_success 'subtest: test_todo allowed arguments' '
 	> not ok 3 - test_todo test_must_fail accepts good command # TODO known breakage
 	> not ok 4 - test_todo test_must_fail rejects bad command
 	> #	test_todo test_must_fail test_true
-	> # still have 2 known breakage(s)
-	> # failed 2 among remaining 2 test(s)
-	> 1..4
+	> not ok 5 - test_todo accepts grep # TODO known breakage
+	> not ok 6 - test_todo accepts ! grep # TODO known breakage
+	> not ok 7 - test_todo detects grep errors
+	> #	echo a >a && test_todo grep --invalid-option b <a
+	> not ok 8 - test_todo detects ! grep errors
+	> #	echo a >a && test_todo ! grep --invalid-option -v b <a
+	> # still have 4 known breakage(s)
+	> # failed 4 among remaining 4 test(s)
+	> 1..8
 	EOF
 '
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3b0fa66c33d..cd869255a2c 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -577,7 +577,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
 	grep "cherry picked from.*$picked" msg
 '
 
-test_expect_failure '--signoff is automatically propagated to resolved conflict' '
+test_expect_success '--signoff is automatically propagated to resolved conflict' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick --signoff base..anotherpick &&
 	echo "c" >foo &&
@@ -591,11 +591,11 @@ test_expect_failure '--signoff is automatically propagated to resolved conflict'
 	git cat-file commit HEAD~3 >initial_msg &&
 	! grep "Signed-off-by:" initial_msg &&
 	grep "Signed-off-by:" unrelatedpick_msg &&
-	! grep "Signed-off-by:" picked_msg &&
+	test_todo ! grep "Signed-off-by:" picked_msg &&
 	grep "Signed-off-by:" anotherpick_msg
 '
 
-test_expect_failure '--signoff dropped for implicit commit of resolution, multi-pick case' '
+test_expect_success '--signoff dropped for implicit commit of resolution, multi-pick case' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked anotherpick &&
 	echo c >foo &&
@@ -605,10 +605,10 @@ test_expect_failure '--signoff dropped for implicit commit of resolution, multi-
 	git diff --exit-code HEAD &&
 	test_cmp_rev initial HEAD^^ &&
 	git cat-file commit HEAD^ >msg &&
-	! grep Signed-off-by: msg
+	test_todo ! grep Signed-off-by: msg
 '
 
-test_expect_failure 'sign-off needs to be reaffirmed after conflict resolution, single-pick case' '
+test_expect_success 'sign-off needs to be reaffirmed after conflict resolution, single-pick case' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked &&
 	echo c >foo &&
@@ -618,7 +618,7 @@ test_expect_failure 'sign-off needs to be reaffirmed after conflict resolution,
 	git diff --exit-code HEAD &&
 	test_cmp_rev initial HEAD^ &&
 	git cat-file commit HEAD >msg &&
-	! grep Signed-off-by: msg
+	test_todo ! grep Signed-off-by: msg
 '
 
 test_expect_success 'malformed instruction sheet 1' '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ad5c0292794..ab649bf27e5 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -165,12 +165,12 @@ test_expect_success 'additional command line cc (ascii)' '
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
 '
 
-test_expect_failure 'additional command line cc (rfc822)' '
+test_expect_success 'additional command line cc (rfc822)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout main..side >patch5 &&
 	sed -e "/^\$/q" patch5 >hdrs5 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
-	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
+	test_todo grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
 '
 
 test_expect_success 'command line headers' '
@@ -195,16 +195,16 @@ test_expect_success 'command line To: header (ascii)' '
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
 '
 
-test_expect_failure 'command line To: header (rfc822)' '
+test_expect_success 'command line To: header (rfc822)' '
 	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
+	test_todo grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
 '
 
-test_expect_failure 'command line To: header (rfc2047)' '
+test_expect_success 'command line To: header (rfc2047)' '
 	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
+	test_todo grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_success 'configuration To: header (ascii)' '
@@ -214,18 +214,18 @@ test_expect_success 'configuration To: header (ascii)' '
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
 '
 
-test_expect_failure 'configuration To: header (rfc822)' '
+test_expect_success 'configuration To: header (rfc822)' '
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
 	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
+	test_todo grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
 '
 
-test_expect_failure 'configuration To: header (rfc2047)' '
+test_expect_success 'configuration To: header (rfc2047)' '
 	git config format.to "R Ä Cipient <rcipient@example.com>" &&
 	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
+	test_todo grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
 # check_patch <patch>: Verify that <patch> looks like a half-sane
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8978709b231..aee10bd0706 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1010,8 +1010,9 @@ list_contains () {
 # with env, the env and its corresponding variable settings will be
 # stripped before we we test the command being run.
 #
-# test_todo() allows any of the assertions beginning test_ such as
-# test_cmp in addition the commands allowed by test_must_fail().
+# test_todo() allows "grep" or any of the assertions beginning test_
+# such as test_cmp in addition the commands allowed by
+# test_must_fail().
 
 test_must_fail_acceptable () {
 	local name
@@ -1050,9 +1051,21 @@ test_must_fail_acceptable () {
 		fi
 		return 1
 		;;
-	test_*)
-		test "$name" = "todo"
-		return $?
+	grep|test_*)
+		if test "$name" = "todo"
+		then
+			test_todo_command_="$1"
+			return 0
+		fi
+		return 1
+		;;
+	'!')
+		if test "$name" = "todo" && test "$2" = "grep"
+		then
+			test_todo_command_=grep
+			return 0
+		fi
+		return 1
 		;;
 	*)
 		return 1
@@ -1061,6 +1074,7 @@ test_must_fail_acceptable () {
 }
 
 test_must_fail_helper () {
+	test_todo_command_=
 	test_must_fail_name_="$1"
 	shift
 	case "$1" in
@@ -1077,8 +1091,27 @@ test_must_fail_helper () {
 		echo >&7 "test_$test_must_fail_name_: only 'git' is allowed: $*"
 		return 1
 	fi
+	test_invert_exit_code_=
+	if test "$1" = "!"
+	then
+		test_invert_exit_code_=1
+		shift
+	fi
 	"$@" 2>&7
 	exit_code=$?
+	if test -n "$test_invert_exit_code_"
+	# We only invert the exit code of grep. An exit code greater
+	# than 1 indicates an error rather than a failed match so
+	# we only want to swap zero and one.
+	then
+		if test $exit_code -eq 0
+		then
+			exit_code=1
+		elif test $exit_code -eq 1
+		then
+			exit_code=0
+		fi
+	fi
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
 		echo >&4 "test_$test_must_fail_name_: command succeeded: $*"
@@ -1098,6 +1131,15 @@ test_must_fail_helper () {
 	then
 		echo >&4 "test_$test_must_fail_name_: valgrind error: $*"
 		return 1
+	else
+		case "$test_todo_command_" in
+		grep)
+			if test $exit_code -ne 1
+			then
+			       echo >&4 "test_todo: $test_todo_command_ error: $*"
+			       return 1
+			fi;;
+		esac
 	fi
 
 	return 0
@@ -1116,8 +1158,8 @@ test_must_fail_helper () {
 #	'
 #
 # This test will fail if "git foo" fails or err is unexpectedly empty.
-# test_todo can be used with "git" or any of the "test_*" assertions
-# such as test_cmp().
+# test_todo can be used with "git", "grep" or any of the "test_*"
+# assertions such as test_cmp().
 
 test_todo () {
 	if test "$test_todo_" = "test_expect_failure"
-- 
gitgitgadget


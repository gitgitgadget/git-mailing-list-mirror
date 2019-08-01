Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A801F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbfHAWUx (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:20:53 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50009 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfHAWUx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:20:53 -0400
Received: by mail-qk1-f201.google.com with SMTP id l14so62567838qke.16
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O4AvoCjuwA+WjTqL1DaSIUatCjugC4tSL0G9vqNzyYY=;
        b=FtFjmz8fCw/TFnMd03kVkuxjEqhZlPa8ZQSFeB+1sal5wFzVRHmTq+6cYmPBVkPxvS
         oieOzKfLVyhZKaCBXafEpUO1Mxvb4ZIMWUP0meTJoSbB7URKD16ek+LtePEUjqGHobtv
         vRyaWxWTw8BnIVIE0CYNNoVLiY9g3Uv9RPA+q7O4IOtkuY9mXuzHtaYLeW2tySyTtM3h
         p2Lp+TALEtV1lNk+/CYQe+ybjPEK8AdHbSd9vVhpwPaGWQFVNRoW+vu069mMg3/slj2Y
         1gr+a6dE4o34es47LqRxEkSHtiSimuYai967BrKPaD2L9OtW20IclDr4FBfDquXJA6LJ
         +ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O4AvoCjuwA+WjTqL1DaSIUatCjugC4tSL0G9vqNzyYY=;
        b=iBdE1v4Wl3xNWVmU43HwJ4TU5RkUMGrFIgQNWvoAZ/LMy0JuZ/eIHB0Cfkog0oZ/Nj
         8nrSWvxLBXSxHeHrOvC4iz5WweKsFNQ7G4RbS0+ay61jU0saSVIUMQwG6FniF18gYWmW
         kbukzsmO/9aTpbkxnHc+lmgwOc0FhLsDal3+JtqLW7meVpV+pCNVhiuJDTt8H7f9AVkf
         jKR7brAA7YeRkEAIA6vfh05EXyc8jiFMHu8+Jip7MPmHXKQJxIz++OuYm4nLn8wHsLwM
         Kdx3mtGVsnR5xpTPOEhfW4z6G3rXAAc5n3l/OpnT27r1VNpwIZknJ49GdFrb3lxNUiAj
         QKVQ==
X-Gm-Message-State: APjAAAW3bx4Y1nSMhi1NzRBrf84NnE5R5IKElwm8IYe0dh343rkYgORU
        EdLQJC+1zJ7M775dwhWWTE6Dbg/Z/ZS/2Y7MpsoAePfYfnF7wfxAC5gOT1iDRGtdgJ3nlKOpeAF
        nOdxCisPUD6UgsbLW86wN6llNPguP/u+2g99y5M9tjWpbM4wl6JM+OoGq8DJpO3g=
X-Google-Smtp-Source: APXvYqxrRfJzP73OsiAmg9OIP0MXlHjATGSX7eSgW/CPR9KyEf7QSRNZixV6O5pGYPvu3JaKvk4ek4ObYF2VUg==
X-Received: by 2002:ac8:929:: with SMTP id t38mr93398705qth.287.1564698051773;
 Thu, 01 Aug 2019 15:20:51 -0700 (PDT)
Date:   Thu,  1 Aug 2019 15:20:43 -0700
In-Reply-To: <cover.1564695892.git.steadmon@google.com>
Message-Id: <f0476b2b1e1e1f1d528b94523e86f210ccbd7dab.1564695893.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1563490164.git.steadmon@google.com> <cover.1564695892.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 1/4] t7503: verify proper hook execution
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t7503 did not verify that the expected hooks actually ran during
testing. Fix that by making the hook scripts write their $0 into a file
so that we can compare actual execution vs. expected execution.

While we're at it, do some test style cleanups, such as using
write_script() and doing setup inside a test_expect_success block.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t7503-pre-commit-hook.sh | 162 +++++++++++++++++++++----------------
 1 file changed, 94 insertions(+), 68 deletions(-)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b39d..500bdd97c2 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -4,124 +4,149 @@ test_description='pre-commit hook'
 
 . ./test-lib.sh
 
-test_expect_success 'with no hook' '
+HOOKDIR="$(git rev-parse --git-dir)/hooks"
+PRECOMMIT="$HOOKDIR/pre-commit"
+
+# Prepare sample scripts that write their $0 to actual_hooks
+test_expect_success 'sample script setup' '
+	mkdir -p "$HOOKDIR" &&
+	write_script "$HOOKDIR/success.sample" <<-\EOF &&
+	echo $0 >>actual_hooks
+	exit 0
+	EOF
+	write_script "$HOOKDIR/fail.sample" <<-\EOF &&
+	echo $0 >>actual_hooks
+	exit 1
+	EOF
+	write_script "$HOOKDIR/require-prefix.sample" <<-\EOF &&
+	echo $0 >>actual_hooks
+	test $GIT_PREFIX = "success/"
+	EOF
+	write_script "$HOOKDIR/check-author.sample" <<-\EOF
+	echo $0 >>actual_hooks
+	test "$GIT_AUTHOR_NAME" = "New Author" &&
+	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
+	EOF
+'
 
-	echo "foo" > file &&
+test_expect_success 'with no hook' '
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	touch expected_hooks actual_hooks &&
+	echo "foo" >file &&
 	git add file &&
-	git commit -m "first"
-
+	git commit -m "first" &&
+	test_cmp expected_hooks actual_hooks
 '
 
 test_expect_success '--no-verify with no hook' '
-
-	echo "bar" > file &&
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	touch expected_hooks actual_hooks &&
+	echo "bar" >file &&
 	git add file &&
-	git commit --no-verify -m "bar"
-
+	git commit --no-verify -m "bar" &&
+	test_cmp expected_hooks actual_hooks
 '
 
-# now install hook that always succeeds
-HOOKDIR="$(git rev-parse --git-dir)/hooks"
-HOOK="$HOOKDIR/pre-commit"
-mkdir -p "$HOOKDIR"
-cat > "$HOOK" <<EOF
-#!/bin/sh
-exit 0
-EOF
-chmod +x "$HOOK"
-
 test_expect_success 'with succeeding hook' '
-
-	echo "more" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "success.sample" "$PRECOMMIT" &&
+	touch actual_hooks &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "more" >>file &&
 	git add file &&
-	git commit -m "more"
-
+	git commit -m "more" &&
+	test_cmp expected_hooks actual_hooks
 '
 
 test_expect_success '--no-verify with succeeding hook' '
-
-	echo "even more" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "success.sample" "$PRECOMMIT" &&
+	touch expected_hooks actual_hooks &&
+	echo "even more" >>file &&
 	git add file &&
-	git commit --no-verify -m "even more"
-
+	git commit --no-verify -m "even more" &&
+	test_cmp expected_hooks actual_hooks
 '
 
-# now a hook that fails
-cat > "$HOOK" <<EOF
-#!/bin/sh
-exit 1
-EOF
-
 test_expect_success 'with failing hook' '
-
-	echo "another" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "fail.sample" "$PRECOMMIT" &&
+	touch actual_hooks &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "another" >>file &&
 	git add file &&
-	test_must_fail git commit -m "another"
-
+	test_must_fail git commit -m "another" &&
+	test_cmp expected_hooks actual_hooks
 '
 
 test_expect_success '--no-verify with failing hook' '
-
-	echo "stuff" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "fail.sample" "$PRECOMMIT" &&
+	touch expected_hooks actual_hooks &&
+	echo "stuff" >>file &&
 	git add file &&
-	git commit --no-verify -m "stuff"
-
+	git commit --no-verify -m "stuff" &&
+	test_cmp expected_hooks actual_hooks
 '
 
-chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
-
-	echo "content" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks; chmod +x \"$HOOKDIR/fail.sample\"" &&
+	ln -s "fail.sample" "$PRECOMMIT" &&
+	chmod -x "$HOOKDIR/fail.sample" &&
+	touch expected_hooks actual_hooks &&
+	echo "content" >>file &&
 	git add file &&
-	git commit -m "content"
-
+	git commit -m "content" &&
+	test_cmp expected_hooks actual_hooks
 '
 
 test_expect_success POSIXPERM '--no-verify with non-executable hook' '
-
-	echo "more content" >> file &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks; chmod +x \"$HOOKDIR/fail.sample\"" &&
+	ln -s "fail.sample" "$PRECOMMIT" &&
+	chmod -x "$HOOKDIR/fail.sample" &&
+	touch expected_hooks actual_hooks &&
+	echo "more content" >>file &&
 	git add file &&
-	git commit --no-verify -m "more content"
-
+	git commit --no-verify -m "more content" &&
+	test_cmp expected_hooks actual_hooks
 '
-chmod +x "$HOOK"
-
-# a hook that checks $GIT_PREFIX and succeeds inside the
-# success/ subdirectory only
-cat > "$HOOK" <<EOF
-#!/bin/sh
-test \$GIT_PREFIX = success/
-EOF
 
 test_expect_success 'with hook requiring GIT_PREFIX' '
-
-	echo "more content" >> file &&
+	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks success" &&
+	ln -s "require-prefix.sample" "$PRECOMMIT" &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "more content" >>file &&
 	git add file &&
 	mkdir success &&
 	(
 		cd success &&
 		git commit -m "hook requires GIT_PREFIX = success/"
 	) &&
-	rmdir success
+	test_cmp expected_hooks actual_hooks
 '
 
 test_expect_success 'with failing hook requiring GIT_PREFIX' '
-
-	echo "more content" >> file &&
+	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks fail" &&
+	ln -s "require-prefix.sample" "$PRECOMMIT" &&
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo "more content" >>file &&
 	git add file &&
 	mkdir fail &&
 	(
 		cd fail &&
 		test_must_fail git commit -m "hook must fail"
 	) &&
-	rmdir fail &&
-	git checkout -- file
+	git checkout -- file &&
+	test_cmp expected_hooks actual_hooks
 '
 
 test_expect_success 'check the author in hook' '
-	write_script "$HOOK" <<-\EOF &&
-	test "$GIT_AUTHOR_NAME" = "New Author" &&
-	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	ln -s "check-author.sample" "$PRECOMMIT" &&
+	cat >expected_hooks <<-EOF &&
+	$PRECOMMIT
+	$PRECOMMIT
+	$PRECOMMIT
 	EOF
 	test_must_fail git commit --allow-empty -m "by a.u.thor" &&
 	(
@@ -133,7 +158,8 @@ test_expect_success 'check the author in hook' '
 	) &&
 	git commit --author="New Author <newauthor@example.com>" \
 		--allow-empty -m "by new.author via command line" &&
-	git show -s
+	git show -s &&
+	test_cmp expected_hooks actual_hooks
 '
 
 test_done
-- 
2.22.0.770.g0f2c4a37fd-goog


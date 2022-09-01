Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46891ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiIAAam (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIAAaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C85E6AA3E
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k17so8180524wmr.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=q86GMcjBtEEokqSMLg6tH3ZO+WReq/RUwXBUegY1+6U=;
        b=TcpCbHfHLuAP07jYqpLsgSvO3AbPaEmF0EAhH9oKCj55LdpV1tcNsq94CuuunG5b2C
         oMi4RIbraogmKFXzCyxrl5Xwy8npxu6iZBF9BR3Vt9twQaI8gqZlDr4D/QDt3QyHqaQ/
         +Ayk68TpSPhjH5Xsu92z1Z2XyQL2D9V8slvEAbvAxyiSeAgAcQwW2JsxhVb1y0RmQjn8
         imD7uyCt32EF+rIeCn0qeSEw6WgKYHvk42yuIGHTgYIpFRIrbtVTDxlZk7Rn4NkxUfLH
         iuPlJ2iWl3vhf7PGzobGawXKXK+qXKceAsayxasfa9/5qxM+vTA4kdIaNX5yaLb82dat
         g4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=q86GMcjBtEEokqSMLg6tH3ZO+WReq/RUwXBUegY1+6U=;
        b=I9RP8z4NJzE/UqoATiVKaPCbdbplZNofCa9mslBmGXyQaYkh+4xS99h59bwsGSRi1U
         4DSnXQ6BadxdqrYpzS0Ap1eFEkYr9ucm8sXH1kDC/BuZ34F2G6ufvhQcgo/NGBKe2ETo
         l0q11q+R5bUDPHl/l1aH5U3NdJ1r7VfOm2oAkLNmCSPmLWmaGWu3aqyy8IblO7RXpUac
         7wQyuKrCLaS5qXL9nTrgnapc8KXOm3eaJlTmbUrPr/SXafsd3FxULTT7haahpT1hJJ7r
         4SPrVmz8S1JhxPQEEUcD0ErXCGf3z7Lu3su7FnzP2u/TPPO1qpxLFgkdb+yf3Wc2Fn41
         XaKw==
X-Gm-Message-State: ACgBeo3MWvHd3kCi6uIQl/NeYod5/lmuoAxyQjjFhDGQKsBgaEeRMEhM
        aYK2L9jyb2jUriIyUh3+vPxU2wOF1ho=
X-Google-Smtp-Source: AA6agR4xTqlCCqYaYylyrja0ZLpwo5FiRuphbEcnzfB2CtrSHI0Ozr9L2GxQHxwwv5HXRDXoKvwcaw==
X-Received: by 2002:a05:600c:3c84:b0:3a6:9596:fa1f with SMTP id bg4-20020a05600c3c8400b003a69596fa1fmr3412767wmb.162.1661992208118;
        Wed, 31 Aug 2022 17:30:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c42c500b003a54fffa809sm3253093wme.17.2022.08.31.17.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:07 -0700 (PDT)
Message-Id: <737d666bf9e309686f95e4909998c33200c1e0a4.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:46 +0000
Subject: [PATCH 08/18] t/Makefile: apply chainlint.pl to existing self-tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Now that chainlint.pl is functional, take advantage of the existing
chainlint self-tests to validate its operation. (While at it, stop
validating chainlint.sed against the self-tests since it will soon be
retired.)

Due to chainlint.sed implementation limitations leaking into the
self-test "expect" files, a few of them require minor adjustment to make
them compatible with chainlint.pl which does not share those
limitations.

First, because `sed` does not provide any sort of real recursion,
chainlint.sed only emulates recursion into subshells, and each level of
recursion leads to a multiplicative increase in complexity of the `sed`
rules. To avoid substantial complexity, chainlint.sed, therefore, only
emulates subshell recursion one level deep. Any subshell deeper than
that is passed through as-is, which means that &&-chains are not checked
in deeper subshells. chainlint.pl, on the other hand, employs a proper
recursive descent parser, thus checks subshells to any depth and
correctly flags broken &&-chains in deep subshells.

Second, due to sed's line-oriented nature, chainlint.sed, by necessity,
folds multi-line quoted strings into a single line. chainlint.pl, on the
other hand, employs a proper lexical analyzer which preserves quoted
strings as-is, including embedded newlines.

Furthermore, the output of chainlint.sed and chainlint.pl do not match
precisely in terms of whitespace. However, since the purpose of the
self-checks is to verify that the ?!AMP?! annotations are being
correctly added, minor whitespace differences are immaterial. For this
reason, rather than adjusting whitespace in all existing self-test
"expect" files to match the new linter's output, the `check-chainlint`
target ignores whitespace differences. Since `diff -w` is not POSIX,
`check-chainlint` attempts to employ `git diff -w`, and only falls back
to non-POSIX `diff -w` (and `-u`) if `git diff` is not available.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/Makefile                                    | 29 +++++++++++++++----
 t/chainlint/block.expect                      |  2 +-
 t/chainlint/here-doc-multi-line-string.expect |  3 +-
 t/chainlint/multi-line-string.expect          | 11 +++++--
 t/chainlint/nested-subshell.expect            |  2 +-
 t/chainlint/t7900-subtree.expect              | 13 +++++++--
 6 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 1c80c0c79a0..11f276774ea 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -38,7 +38,7 @@ T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
 TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
-CHAINLINT = sed -f chainlint.sed
+CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 
 all: $(DEFAULT_TEST_TARGET)
 
@@ -73,10 +73,29 @@ clean-chainlint:
 
 check-chainlint:
 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
-	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
-	sed -e '/^[ 	]*$$/d' $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
-	$(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests | grep -v '^[	]*$$' >'$(CHAINLINTTMP_SQ)'/actual && \
-	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
+	for i in $(CHAINLINTTESTS); do \
+		echo "test_expect_success '$$i' '" && \
+		sed -e '/^# LINT: /d' chainlint/$$i.test && \
+		echo "'"; \
+	done >'$(CHAINLINTTMP_SQ)'/tests && \
+	{ \
+		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
+		for i in $(CHAINLINTTESTS); do \
+			echo "# chainlint: $$i" && \
+			sed -e '/^[ 	]*$$/d' chainlint/$$i.expect; \
+		done \
+	} >'$(CHAINLINTTMP_SQ)'/expect && \
+	$(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
+		grep -v '^[ 	]*$$' >'$(CHAINLINTTMP_SQ)'/actual && \
+	if test -f ../GIT-BUILD-OPTIONS; then \
+		. ../GIT-BUILD-OPTIONS; \
+	fi && \
+	if test -x ../git$$X; then \
+		DIFFW="../git$$X --no-pager diff -w --no-index"; \
+	else \
+		DIFFW="diff -w -u"; \
+	fi && \
+	$$DIFFW '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index da60257ebc4..37dbf7d95fa 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -1,7 +1,7 @@
 (
 	foo &&
 	{
-		echo a
+		echo a ?!AMP?!
 		echo b
 	} &&
 	bar &&
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index 2578191ca8a..be64b26869a 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,4 +1,5 @@
 (
-	cat <<-TXT && echo "multi-line	string" ?!AMP?!
+	cat <<-TXT && echo "multi-line
+	string" ?!AMP?!
 	bap
 )
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index ab0dadf748e..27ff95218e7 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -1,9 +1,14 @@
 (
-	x="line 1		line 2		line 3" &&
-	y="line 1		line2" ?!AMP?!
+	x="line 1
+		line 2
+		line 3" &&
+	y="line 1
+		line2" ?!AMP?!
 	foobar
 ) &&
 (
-	echo "xyz" "abc		def		ghi" &&
+	echo "xyz" "abc
+		def
+		ghi" &&
 	barfoo
 )
diff --git a/t/chainlint/nested-subshell.expect b/t/chainlint/nested-subshell.expect
index 41a48adaa2b..02e0a9f1bb5 100644
--- a/t/chainlint/nested-subshell.expect
+++ b/t/chainlint/nested-subshell.expect
@@ -6,7 +6,7 @@
 	) >file &&
 	cd foo &&
 	(
-		echo a
+		echo a ?!AMP?!
 		echo b
 	) >file
 )
diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
index 1cccc7bf7e1..69167da2f27 100644
--- a/t/chainlint/t7900-subtree.expect
+++ b/t/chainlint/t7900-subtree.expect
@@ -1,10 +1,17 @@
 (
-	chks="sub1sub2sub3sub4" &&
+	chks="sub1
+sub2
+sub3
+sub4" &&
 	chks_sub=$(cat <<TXT | sed "s,^,sub dir/,"
 ) &&
-	chkms="main-sub1main-sub2main-sub3main-sub4" &&
+	chkms="main-sub1
+main-sub2
+main-sub3
+main-sub4" &&
 	chkms_sub=$(cat <<TXT | sed "s,^,sub dir/,"
 ) &&
 	subfiles=$(git ls-files) &&
-	check_equal "$subfiles" "$chkms$chks"
+	check_equal "$subfiles" "$chkms
+$chks"
 )
-- 
gitgitgadget


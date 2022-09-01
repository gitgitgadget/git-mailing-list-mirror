Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548CECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiIAAbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiIAAaX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535EAA4E5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s7so5364909wro.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ErgQMUsG7c28yKpl9jLIaLFXZ1NiyhHYBFR/p41F6Cw=;
        b=bQ25yg89kMP8uFhpAlQb623k7bcWkf++kn/xE0Y7AH9p1QuYzQdA07lor0GLbxTZBN
         O7kuUdibrqPmH0voPHxOBCjIHSpAN5lVENvZ1vXLf+F4F0Jl7ytRhCI+3ILnEeuTc0Rn
         LculC68xmnhpkijV//OM4FoAT5zI23wDpnbOgf76ZErMmhMNVZDcQMvn22VAwY7eoT3I
         tO0wUsXDauxC8NUCy/OsYhnsqZRpzL03SJgGWzNXTulCnjmkn766sl6veiuhkawDaR/X
         6VHy2zPwYwQoXbfzSLMk0BhTNDbiKio5XAl4MHFFz3GmnpOIH0CReqQB+9o235cyxuWE
         HEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ErgQMUsG7c28yKpl9jLIaLFXZ1NiyhHYBFR/p41F6Cw=;
        b=RrSZzlpaW5Abq4d2NLvyDbqxyAKkOYHh7H3T8InV4whli04go8E+jYuEuxnA7ga4H7
         Z0JmF+42i4b4MZrM9rUo8IlCci9Az5IehBQGSv4saVTznVaDLkRjbnemVmH/IwdXU7i8
         /P40/Ry7gjUj3b1wYCHYo0kNRHYqIfNsF3ZWhLDUghX6f94hHABZN0M7DDJ6Kj9ukyrf
         BQgN3wbDYg4LClEfcc+zEOt/W45kOXIM9nPjQHyW4opC/YOz2zISh7hJ82ypUtFc0wmg
         ivqFSW8+nB5YbKUcEdItVspMmBIsQ6Llng47AiQLL4XRS6pZaAG3Jv/Q5ikiGhVpJtfy
         wovA==
X-Gm-Message-State: ACgBeo3w/olhjaWiSQ9BFfT/N1Yv1wzB3iv9PXNWi7GLkO7Zq4Uq6WQl
        X5MpOL5m6xFKjqfW+565HyvYTMZdJ4s=
X-Google-Smtp-Source: AA6agR54jfo1qqNZhcZ3FBMZv53THXAmmFYj/Xh/HVOjurq3EPZc3gWOJdYoZ6nBRZL1Th5EJqC3aw==
X-Received: by 2002:a5d:5943:0:b0:226:d08e:fe11 with SMTP id e3-20020a5d5943000000b00226d08efe11mr13302184wri.78.1661992218195;
        Wed, 31 Aug 2022 17:30:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b003a5dde32e4bsm3601087wmq.37.2022.08.31.17.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:17 -0700 (PDT)
Message-Id: <d95a4239014326d425fd667aab89789e3d198a64.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:55 +0000
Subject: [PATCH 17/18] t/Makefile: teach `make test` and `make prove` to run
 chainlint.pl
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

Unlike chainlint.sed which "lints" a single test body at a time, thus is
invoked once per test, chainlint.pl can check all test bodies in all
test scripts with a single invocation. As such, it is akin to other bulk
"linters" run by the Makefile, such as `test-lint-shell-syntax`,
`test-lint-duplicates`, etc.

Therefore, teach `make test` and `make prove` to invoke chainlint.pl
along with the other bulk linters. Also, since the single chainlint.pl
invocation by `make test` or `make prove` has already checked all tests
in all scripts, instruct the individual test scripts not to run
chainlint.pl on themselves unnecessarily.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/Makefile | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 11f276774ea..3db48c0cb64 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -36,14 +36,21 @@ CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
 
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
+TLIBS = $(sort $(wildcard lib-*.sh)) annotate-tests.sh
 TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
+TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 
+# `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
+# checks all tests in all scripts via a single invocation, so tell individual
+# scripts not to "chainlint" themselves
+CHAINLINTSUPPRESS = GIT_TEST_CHAIN_LINT=0 && export GIT_TEST_CHAIN_LINT &&
+
 all: $(DEFAULT_TEST_TARGET)
 
 test: pre-clean check-chainlint $(TEST_LINT)
-	$(MAKE) aggregate-results-and-cleanup
+	$(CHAINLINTSUPPRESS) $(MAKE) aggregate-results-and-cleanup
 
 failed:
 	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
@@ -52,7 +59,7 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove ***"; $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
@@ -99,6 +106,9 @@ check-chainlint:
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
+ifneq ($(GIT_TEST_CHAIN_LINT),0)
+test-lint: test-chainlint
+endif
 
 test-lint-duplicates:
 	@dups=`echo $(T) $(TPERF) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
@@ -121,6 +131,9 @@ test-lint-filenames:
 		test -z "$$bad" || { \
 		echo >&2 "non-portable file name(s): $$bad"; exit 1; }
 
+test-chainlint:
+	@$(CHAINLINT) $(T) $(TLIBS) $(TPERF) $(TINTEROP)
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
@@ -136,4 +149,5 @@ valgrind:
 perf:
 	$(MAKE) -C perf/ all
 
-.PHONY: pre-clean $(T) aggregate-results clean valgrind perf check-chainlint clean-chainlint
+.PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
+	check-chainlint clean-chainlint test-chainlint
-- 
gitgitgadget


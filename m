Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A530CC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiCAKZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiCAKZg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6FB8EB6C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:24:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b5so19750248wrr.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IALL0QMC0v8ysobvDm4KtZMwa6z5A/re01nuKPjfC2M=;
        b=lspBwPY6bzkDX7k1wvY3KMadqrcO60U3T58RSGi5tIcIqkVUG44n2VUBep2eWxD2vN
         3tFaXnRyI3rSIL4YGpsW0tFvC9Tp6JADljWBOYGPfnEZJw6dO3QmANw/9quReC0kOq96
         fKEBKasC6Du0EzGbQKvD+ZDbn/bIkj8y54GD/ImvX+1qREpXdmZQRZjrXNiRjo9LXVd0
         YMvgRwHdhJ4mBriuUqkHeJZ1EUYRVLkHD5We+QoA+8l15HiN5kI7BoKBXMm31uChPj/I
         Ts/POmRywaY3zalwz8av0gmIcN5wMPQsqe2ahOcVWdHqwgcWIfYDzonr7lMvAjWVWq/M
         2bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IALL0QMC0v8ysobvDm4KtZMwa6z5A/re01nuKPjfC2M=;
        b=PDy6ZRscPVZm7oD8XeXqLBd2+OBEpaE2yBYqu1IKUD92eXubjA82KSTLIFVnHJx0cR
         dmbVPif2DVRBigW8ONjgIXaUhOhE/4SqKNpHweXuqNyn8Bk/PkWV7VK/1VPl6vtGu4be
         8HfHg4RQ0KlFl+M2sMRfmzps6lYTSXM2cbznw04PxQx/XsH6nD6zBMPZ+rEDFYn7sA4y
         xzX8fVagojPA503rQy1QRc2uY2rTCwKbPuwSDndZ5uwa4ldIsjqZ6q0tmIOpXL4/4hI3
         3B0S24ePO6XoTJCZqNldG2u6STR/ZFpEqbhy+csFaySR7KgvnSla4HrJxnlJ+6peim07
         5ufg==
X-Gm-Message-State: AOAM532G5RQ09wuklcOOmlF+5eRKHXeFwVRjQ5HVx6msmtTAdniMvNpE
        1tjn1+5mgak+A3beOp1SpsCgJvP2OxM=
X-Google-Smtp-Source: ABdhPJyHNzIQBVMJvQGEjuz60B+os7AEi4U2GfqZAnHVMM9DKuzy0GfV3qFkm4sNCWauk3Ros1jDCQ==
X-Received: by 2002:adf:f48c:0:b0:1ea:9cb7:6c8b with SMTP id l12-20020adff48c000000b001ea9cb76c8bmr19291322wro.60.1646130291727;
        Tue, 01 Mar 2022 02:24:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm2443667wmq.8.2022.03.01.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:24:51 -0800 (PST)
Message-Id: <42ff3e170bff42f9b9ca6adb433b3d7c2a39c729.1646130289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:24:42 +0000
Subject: [PATCH v2 2/9] ci/run-build-and-tests: take a more high-level view
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the web UI of GitHub workflows, failed runs are presented with the
job step that failed auto-expanded. In the current setup, this is not
helpful at all because that shows only the output of `prove`, which says
which test failed, but not in what way.

What would help understand the reader what went wrong is the verbose
test output of the failed test.

The logs of the failed runs do contain that verbose test output, but it
is shown in the _next_ step (which is marked as succeeding, and is
therefore _not_ auto-expanded). Anyone not intimately familiar with this
would completely miss the verbose test output, being left mostly
puzzled with the test failures.

We are about to show the failed test cases' output in the _same_ step,
so that the user has a much easier time to figure out what was going
wrong.

But first, we must partially revert the change that tried to improve the
CI runs by combining the `Makefile` targets to build into a single
`make` invocation. That might have sounded like a good idea at the time,
but it does make it rather impossible for the CI script to determine
whether the _build_ failed, or the _tests_. If the tests were run at
all, that is.

So let's go back to calling `make` for the build, and call `make test`
separately so that we can easily detect that _that_ invocation failed,
and react appropriately.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 280dda7d285..2818b3046ae 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-export MAKE_TARGETS="all test"
+run_tests=t
 
 case "$jobname" in
 linux-gcc)
@@ -41,14 +41,15 @@ pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
 	export DEVOPTS=pedantic
-	export MAKE_TARGETS=all
+	run_tests=
 	;;
 esac
 
-# Any new "test" targets should not go after this "make", but should
-# adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
-# start running tests.
-make $MAKE_TARGETS
+make
+if test -n "$run_tests"
+then
+	make test
+fi
 check_unignored_build_artifacts
 
 save_good_tree
-- 
gitgitgadget


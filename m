Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8471D1F404
	for <e@80x24.org>; Sun, 17 Dec 2017 22:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbdLQWts (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 17:49:48 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44013 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbdLQWtn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 17:49:43 -0500
Received: by mail-wr0-f196.google.com with SMTP id w68so52907wrc.10
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m5VbXeP/u1s8aFU8BS9T2fE4Sdy+275DLCHqmxKICnI=;
        b=B1ts4U7Dnv0oEQ65peRp31n2U2nasK+Ss8j+YXBYiGXsAU+aDdVbZMwoV0Dkb8eBMu
         Zey9hbyX+PhXdNxDoptRh4VLdQjIgOVa8pMa2VO76Ar2df29Vc4qnjEzbUgudxPV/qvO
         lEQ+Mf78Zgmhbp7PO5xHp1jM/3ydC2FbH3IzRrriTZ1cEVf+7BE4EKm2FSbBkotgEJX/
         eQK7dyfczDzynb874d/OzulV+0wX3QDNDBCpHrlkDAAAobqGCE/+ZHrkBvF4/deHt81m
         weW1rduEVpVfAb9YTN/5k/6BoIZVZFhFeQ7Hp6Qyk/D9HL31LwG6NPsLviJ0KfpY01cQ
         67JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m5VbXeP/u1s8aFU8BS9T2fE4Sdy+275DLCHqmxKICnI=;
        b=fHOCgScrmRW+KxAREEaBgeGZcXKH0oDk7DDEaQYfp1fIJXlWWZZvDTswZ1TBD/Qlix
         JYxbSvIZCLkVsjMl8kW2l5pA4WrBKQ2ciHv2SKlsm7rg/ezm9VNY/4M6IGnI9hCOOpwY
         xgrLJEwSlrrTA/PH47ojBiNmAWE4Mjy7qcK149dsyHYVd2l0QUjNgvkHd6vnZgkq6ZQt
         opZihHEOPhEIQQtznzH6l5Wfxbju3SqpQiCm4qZhaN8VNXMIoz//LJonvbfMJhtrQn8z
         UgAIAt+++LYKa2gTcwdAFnWX/PmH904q+0zct7Belg16a5npCOnlTU/QW79JbhfYQLMW
         vZhg==
X-Gm-Message-State: AKGB3mIPDiPBztryy44zjvy7KyF60ML5aMTDptn1HRA8qYlFqbv11xSd
        l4k6AXPTDMKLcfscOOOoptPIgtQS
X-Google-Smtp-Source: ACJfBouMvsHPFbTTXfUEUue+mn2UWHNaAPljn9I9oTEaHcFpk/2xh0Cy3Te++Oim915P+Kc+OojfHw==
X-Received: by 10.223.195.138 with SMTP id p10mr17090241wrf.88.1513550981786;
        Sun, 17 Dec 2017 14:49:41 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 26sm18992177wrw.19.2017.12.17.14.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Dec 2017 14:49:41 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Date:   Sun, 17 Dec 2017 22:51:22 +0000
Message-Id: <20171217225122.28941-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670
In-Reply-To: <20171217225122.28941-1-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split index mode only has a few dedicated tests, but as the index is
involved in nearly every git operation, this doesn't quite cover all the
ways repositories with split index can break.  To use split index mode
throughout the test suite a GIT_TEST_SPLIT_INDEX environment variable
can be set, which makes git split the index at random and thus
excercises the functionality much more thoroughly.

As this is not turned on by default, it is not executed nearly as often
as the test suite is run, so occationally breakages slip through.  Try
to counteract that by running the test suite with GIT_TEST_SPLIT_INDEX
mode turned on on travis.

To avoid using too many cycles on travis only run split index mode in
the linux-gcc and the linux 32-bit gcc targets.  The Linux builds were
chosen over the Mac OS builds because they tend to be much faster to
complete.

The linux gcc build was chosen over the linux clang build because the
linux clang build is the fastest build, so it can serve as an early
indicator if something is broken and we want to avoid spending the extra
cycles of running the test suite twice for that.

Helped-by: Lars Schneider <larsxschneider@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 ci/run-linux32-build.sh | 1 +
 ci/run-tests.sh         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e30fb2cddc..f173c9cf2a 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -27,4 +27,5 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
     cd /usr/src/git &&
     make --jobs=2 &&
     make --quiet test
+    GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
 '
diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index f0c743de94..c7aee5b9ff 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -8,3 +8,7 @@
 mkdir -p $HOME/travis-cache
 ln -s $HOME/travis-cache/.prove t/.prove
 make --quiet test
+if test "$jobname" = "linux-gcc"
+then
+	GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
+fi
-- 
2.15.1.620.gb9897f4670


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB2B1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754741AbeAGW2f (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 17:28:35 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34608 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754724AbeAGW2a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 17:28:30 -0500
Received: by mail-wr0-f194.google.com with SMTP id 36so8989577wrh.1
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 14:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xOfxfgxEmN/7PwZdrS2UNTLC8GLF7DsDg0U9fdRkRv0=;
        b=Icjuo3nszc713nx1UthPo9/S6naibGpg0vEGQPAHxggGN8p9B2DBH5tVucZYbwRNdP
         WBt3RMVbpkrs6HIWHZuXo/vFJXaaSvc9iKM63ykEWphfQVvUJoPJo27oZ8kgY01cWh6Y
         /0hE67kB2SnPuv/WDZELI+1M86RAyrTZ2kHml9eUX15tomHW6d5vlP+mvYcGwFOyF/QQ
         kMaNj9UTzN5KTBTxAbCe455rTYg7FyeISSGAecsI4nqiXHcpuSdxFprYxewSscUHXFfJ
         vBKIRQgEXtfK24u3ClK0JX9UAyj+TAZ730Aao0DmM40x2dKK4DB+QxoKybNYNtWKWMAa
         e0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xOfxfgxEmN/7PwZdrS2UNTLC8GLF7DsDg0U9fdRkRv0=;
        b=LeSN/pIlpNyla2eFnzM1DmX2OWNeHeBYipU0FHS6KTmsqZbhPJ5/f5LQrUgLEdK/xm
         Kct+74eLQv/V9/rAa3wzHA9C/E5fI9fD9MfxqrhRWPkh1D1RLHWDZhE8XdkYHchD6a71
         SgJh8/jds1z+WlFGHnfn8geAo4hiOxYZqgqUhBJwHRbI5lNMQcQq/wDGdwUJlBdi4E8U
         gdPX2u9MLjDoDRwJ577ImzcFfUIwWm1gX8rYvAZAf6X4iM35fbb4pjvNV2Heuq1PI8kD
         Kz9S58slcbeeWNf/L2G8V8Zikh2grzW5DhzvCyODpzQL9IfFaK4pupKZjKDORbC6zKkh
         9+Jg==
X-Gm-Message-State: AKGB3mLXVOB6G2lV2hbxLNqCDdPkvxHChxqSih4/7OH7Sr5grtzO2aH+
        qp8nMRSuCEk28faZE8lx0OPGYZWW
X-Google-Smtp-Source: ACJfBotlSftEpFGvcr6zTItkZX3G+VmUzQmtn2H+VIQVGaO+DPvQEqPuIP6Z8OqeVjxcQiM+ZoVumw==
X-Received: by 10.223.141.235 with SMTP id o98mr1919916wrb.39.1515364109684;
        Sun, 07 Jan 2018 14:28:29 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id s19sm11037190wrg.29.2018.01.07.14.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 14:28:28 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Date:   Sun,  7 Jan 2018 22:30:15 +0000
Message-Id: <20180107223015.17720-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79
In-Reply-To: <20180107223015.17720-1-t.gummerer@gmail.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
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
the linux-gcc target only.  The Linux build was chosen over the Mac OS
builds because it tends to be much faster to complete.

The linux gcc build was chosen over the linux clang build because the
linux clang build is the fastest build, so it can serve as an early
indicator if something is broken and we want to avoid spending the extra
cycles of running the test suite twice for that.

Helped-by: Lars Schneider <larsxschneider@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 ci/run-tests.sh | 4 ++++
 1 file changed, 4 insertions(+)

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
2.16.0.rc1.238.g530d649a79


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFDA202B1
	for <e@80x24.org>; Sat, 20 May 2017 21:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756446AbdETVnh (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36576 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756358AbdETVne (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so23158558wmh.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EX5ivpJheWgXOzB1LZI795t1Iejj+9y87d5e5e9Rsgo=;
        b=UvhpbGc2BdsHpZe6wHXDut0+yvUF36Yyrn2C7dZiNVjbGmDCTIG1GslfLPKdsU56Tn
         jKKA1XOCQdpeDw1HKWEWUjq3cAAfhgCHf0wDY/fXXd52TRhRtx1+XkaneLQgLSrVfWJu
         ND4UKVIo/8UqFXFZF+oacBaF+1Zk1yJXB1yTCG464mLIWLp70F8dtmJRhOBM95uo1JD2
         5dqDwTfD07ykSkoXaQE5P+X3uvri8YYOKuCbt7iZy0Jaci163CdOkkD9Ne8cV23R9sPA
         6VnmyAdptLykYVOB2WzhM+naiWjTP4Jr8lcxnt12AH62MyRWGAGDDZZ6Z3TRgK4Bci1a
         SWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EX5ivpJheWgXOzB1LZI795t1Iejj+9y87d5e5e9Rsgo=;
        b=WHHTSqy1JPa8VCAfgFt6L+2vKn15kYHI4rL6Ydqb35q0Q0xuz1dYp09mGVO40DWgs8
         xj0aDJHpNS+tq1LOsq9g6OSJE12vgitCYSh+lkoc+CGPT42qVXEVqjXbUBWuoHD6d4b+
         Y8Q5fYGJmsfAL5h6FxiabdZMyuPOB799peWV/KKbHr3PFvpzThgP41sBtvDX82qoGuT8
         qNbA7fl+r5vsexfv8sudNBjoP0BFmMZJ+Tl5UfQkMigJiPW5s3HQHhtVEm5Oz/yWlvhy
         Q0DP2h1mQx8IyxbpaLMMmiTFRTx562sWHmS4WEOGXCPjnj+Zkgc8PxeY2UzUovTlUlTO
         4BXA==
X-Gm-Message-State: AODbwcCjl3KGlLvLiqp+BYPgX957rtXc7Mv3mDuRyVhnKlOL0/7dNDfL
        6jlsWxJllYLXFw==
X-Received: by 10.28.175.136 with SMTP id y130mr10221128wme.112.1495316611827;
        Sat, 20 May 2017 14:43:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/30] perf: add a comparison test of grep regex engines with -F
Date:   Sat, 20 May 2017 21:42:21 +0000
Message-Id: <20170520214233.7183-19-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a performance comparison test which compares both case-sensitive &
case-insensitive fixed-string grep, as well as non-ASCII
case-sensitive & case-insensitive grep.

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux ./run p7821-grep-engines-fixed.sh
    [...]
    Test                             this tree
    ------------------------------------------------
    7821.1: fixed grep int           0.61(1.72+0.65)
    7821.2: basic grep int           0.69(1.72+0.53)
    7821.3: extended grep int        0.60(1.72+0.54)
    7821.4: perl grep int            0.65(1.65+0.64)
    7821.6: fixed grep uncommon      0.25(0.53+0.48)
    7821.7: basic grep uncommon      0.26(0.57+0.46)
    7821.8: extended grep uncommon   0.25(0.52+0.51)
    7821.9: perl grep uncommon       0.26(0.56+0.48)
    7821.11: fixed grep æ            0.40(1.26+0.44)
    7821.12: basic grep æ            0.40(1.28+0.43)
    7821.13: extended grep æ         0.39(1.28+0.44)
    7821.14: perl grep æ             0.39(1.29+0.44)

This test needs to be run with GIT_PERF_7821_GREP_OPTS=' -i' to avoid
going through the same kwset.[ch] codepath, see the "Even when -F..."
comment in grep.c:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_7821_GREP_OPTS=' -i' ./run p7821-grep-engines-fixed.sh
    [...]
    Test                                this tree
    ---------------------------------------------------
    7821.1: fixed grep -i int           1.55(1.86+0.66)
    7821.2: basic grep -i int           0.66(1.97+0.54)
    7821.3: extended grep -i int        0.72(1.88+0.62)
    7821.4: perl grep -i int            0.75(1.93+0.57)
    7821.6: fixed grep -i uncommon      0.27(0.52+0.54)
    7821.7: basic grep -i uncommon      0.25(0.58+0.44)
    7821.8: extended grep -i uncommon   0.26(0.62+0.43)
    7821.9: perl grep -i uncommon       0.26(0.55+0.53)
    7821.11: fixed grep -i æ            0.32(0.87+0.46)
    7821.12: basic grep -i æ            0.30(0.90+0.41)
    7821.13: extended grep -i æ         0.32(0.92+0.41)
    7821.14: perl grep -i æ             0.29(0.71+0.53)

I'm planning to make that not be the case, this performance test gives
a baseline for comparing performance before & after any such change.

See commit ("perf: add a comparison test of grep regex engines",
2017-04-19) for details on the machine the above test run was executed
on.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p7821-grep-engines-fixed.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/perf/p7821-grep-engines-fixed.sh

diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
new file mode 100755
index 0000000000..d935194ecf
--- /dev/null
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description="Comparison of git-grep's regex engines with -F
+
+Set GIT_PERF_7821_GREP_OPTS in the environment to pass options to
+git-grep. Make sure to include a leading space,
+e.g. GIT_PERF_7821_GREP_OPTS=' -w'. See p7820-grep-engines.sh for more
+options to try.
+"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+for args in 'int' 'uncommon' 'æ'
+do
+	for engine in fixed basic extended perl
+	do
+		test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $args" "
+			git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $args >'out.$engine.$args' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for$GIT_PERF_7821_GREP_OPTS $args" "
+		test_cmp 'out.fixed.$args' 'out.basic.$args' &&
+		test_cmp 'out.fixed.$args' 'out.extended.$args' &&
+		test_cmp 'out.fixed.$args' 'out.perl.$args'
+	"
+done
+
+test_done
-- 
2.13.0.303.g4ebf302169


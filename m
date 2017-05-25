Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C3D20284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036740AbdEYTrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34345 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036732AbdEYTrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so55399219wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eka2un3fBtbQ7e7bD5MYrGi/HcqC1Yol4ANndEtxydI=;
        b=CHnKBdjV7FjT9Gj6r7+C1tXh5RU4xuc4PfPlLYHqn2caFfsNcXsOr/A6M4AbkfRMer
         zfeN5FxE/qEJjMs6oys/esPAcjSL4u6GjJEVn+gSLa0a3EXHNViE61hEkbc1u9wG1qur
         93lpYcMBpP7uqv7tx6lyGBxkrAPYEA14Y1L6wIoenqF4qsf86aCzInvCSptPC/LcaCwC
         UV6ccks6dab37vXcIYuzx8l+JjPBsijEn5nGe8/4D+0wNpPEF9ZGS18qNyjGHHj93aPS
         lvOkYpgYEyvW+ff2uH3NlH67kx+/vXB0Mh+/zL0p/XgS9CPzjfodRnrZ4GPRLvQqh25k
         +Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eka2un3fBtbQ7e7bD5MYrGi/HcqC1Yol4ANndEtxydI=;
        b=AgWzGYhry3AfzLgAGjbG85BAXBUdeJSxkkWV5yjXssdHyVrnJudLylilBAjFEqaqAL
         ADRmkh4uSRvhDjmxovDtiV5vbproxWEL11eOQpEM0BQMYXtAboRiPsKwYd5NxK+5MKJ9
         APU15omSyBbkA3UbLl6zZ7LuszeHEcc82NAlKb6Y9Ogj9xy7/ejqUlulwMgwkeIXNzRI
         ztj0ZoM1NisT7pLT8uXeWajlsrl6fPe1GXEgmvihD71UvKKD/wS98D2iAhvOOTn6fHBY
         BIJ5FlxFWeGTbQ4T/jxZKfKO8R2tgWPG0CmPRSc8Ulvc6DTBuip9X9WRhKY0o62vrExm
         Onjw==
X-Gm-Message-State: AODbwcDMwJIzfxS3Z8saIQUOzdZTubdCPCd1e5VTRxxBDYDhMCkfBeav
        x40cT/c90yFb0w==
X-Received: by 10.223.133.216 with SMTP id 24mr30165419wru.194.1495741625575;
        Thu, 25 May 2017 12:47:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:04 -0700 (PDT)
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
Subject: [PATCH v4 20/31] perf: add a comparison test of log --grep regex engines with -F
Date:   Thu, 25 May 2017 19:45:24 +0000
Message-Id: <20170525194535.9324-21-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a performance comparison test of log --grepgrep regex engines
given fixed strings.

See the preceding fixed-string t/perf change ("perf: add a comparison
test of grep regex engines with -F", 2017-04-21) for notes about this,
in particular this mostly tests exactly the same codepath now, but
might not in the future:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux ./run p4221-log-grep-engines-fixed.sh
    [...]
    Test                                     this tree
    --------------------------------------------------------
    4221.1: fixed log --grep='int'           5.99(5.55+0.40)
    4221.2: basic log --grep='int'           5.92(5.56+0.31)
    4221.3: extended log --grep='int'        6.01(5.51+0.45)
    4221.4: perl log --grep='int'            5.99(5.56+0.38)
    4221.6: fixed log --grep='uncommon'      5.06(4.76+0.27)
    4221.7: basic log --grep='uncommon'      5.02(4.78+0.21)
    4221.8: extended log --grep='uncommon'   4.99(4.78+0.20)
    4221.9: perl log --grep='uncommon'       5.00(4.72+0.26)
    4221.11: fixed log --grep='æ'            5.35(5.12+0.20)
    4221.12: basic log --grep='æ'            5.34(5.11+0.20)
    4221.13: extended log --grep='æ'         5.39(5.10+0.22)
    4221.14: perl log --grep='æ'             5.44(5.16+0.23)

Only the non-ASCII -i case is different:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_4221_LOG_OPTS=' -i' ./run p4221-log-grep-engines-fixed.sh
    [...]
    Test                                        this tree
    -----------------------------------------------------------
    4221.1: fixed log -i --grep='int'           6.17(5.77+0.35)
    4221.2: basic log -i --grep='int'           6.16(5.59+0.39)
    4221.3: extended log -i --grep='int'        6.15(5.70+0.39)
    4221.4: perl log -i --grep='int'            6.15(5.69+0.38)
    4221.6: fixed log -i --grep='uncommon'      5.10(4.88+0.21)
    4221.7: basic log -i --grep='uncommon'      5.04(4.76+0.25)
    4221.8: extended log -i --grep='uncommon'   5.07(4.82+0.23)
    4221.9: perl log -i --grep='uncommon'       5.03(4.78+0.22)
    4221.11: fixed log -i --grep='æ'            5.93(5.65+0.25)
    4221.12: basic log -i --grep='æ'            5.88(5.62+0.25)
    4221.13: extended log -i --grep='æ'         6.02(5.69+0.29)
    4221.14: perl log -i --grep='æ'             5.36(5.06+0.29)

See commit ("perf: add a comparison test of grep regex engines",
2017-04-19) for details on the machine the above test run was executed
on.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p4221-log-grep-engines-fixed.sh | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 t/perf/p4221-log-grep-engines-fixed.sh

diff --git a/t/perf/p4221-log-grep-engines-fixed.sh b/t/perf/p4221-log-grep-engines-fixed.sh
new file mode 100755
index 0000000000..060971265a
--- /dev/null
+++ b/t/perf/p4221-log-grep-engines-fixed.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description="Comparison of git-log's --grep regex engines with -F
+
+Set GIT_PERF_4221_LOG_OPTS in the environment to pass options to
+git-grep. Make sure to include a leading space,
+e.g. GIT_PERF_4221_LOG_OPTS=' -i'. Some options to try:
+
+	-i
+	--invert-grep
+	-i --invert-grep
+"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+for pattern in 'int' 'uncommon' 'æ'
+do
+	for engine in fixed basic extended perl
+	do
+		if test $engine = "perl" && ! test_have_prereq PCRE
+		then
+			prereq="PCRE"
+		else
+			prereq=""
+		fi
+		test_perf $prereq "$engine log$GIT_PERF_4221_LOG_OPTS --grep='$pattern'" "
+			git -c grep.patternType=$engine log --pretty=format:%h$GIT_PERF_4221_LOG_OPTS --grep='$pattern' >'out.$engine' || :
+		"
+	done
+
+	test_expect_success "assert that all engines found the same for$GIT_PERF_4221_LOG_OPTS '$pattern'" '
+		test_cmp out.fixed out.basic &&
+		test_cmp out.fixed out.extended &&
+		if test_have_prereq PCRE
+		then
+			test_cmp out.fixed out.perl
+		fi
+	'
+done
+
+test_done
-- 
2.13.0.303.g4ebf302169


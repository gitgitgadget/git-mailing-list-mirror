Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9FA1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeDEC2Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:28:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43547 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbeDEC2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:28:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id c21-v6so13413077plz.10
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QbYMUeO/aOnLIEdPbmwz504AXDgwTs4qEF+BAXv6ueI=;
        b=OIAaYdzEiz9KIK9MSC4XJ8FSPoGTp3TEKBb7Q8HfUEYiDSHliNPcO3cVRBU9CpD8sC
         RYRl6S+lMxXtghU2Evr3ZL0YPZIFdojf1e15rV0AsMVbGFx9Ze+JE8HoSqx/oPFIqh9a
         ZkubOgIS1PZr6UMNIKvU4rmO4urOfLT5eO2Osd9rgmHNwBt23DCin3OmSgxuHmpECb/5
         eiq+XwaVov59Ogjwfg5W4c9wf2hkcNEDQwvem9Zn+b/0Ohk5v3UbowMw6JUGD+AR/6UL
         DjhaYgQ6pmPNUtDXgT2mUyUP2Hl5eV21yh2PKnXzgO08oVEkVz2te75LB/I1H3Z31vA6
         twCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QbYMUeO/aOnLIEdPbmwz504AXDgwTs4qEF+BAXv6ueI=;
        b=X5Iq7XLJlNOzcSbpgDxz6thg4JB9IVpfcdzpY/0+7zu0FioOA0Q5Gyv2mGnNhap9/r
         2h7zcRAxxM+pJCUf2o+THc1DyGWAqz+Z7NQ8PTsOqenijbubOyBbe1Li75kZ1vfE3fBv
         Vy7/PNNPdM9cL8YQfxiPDblRMxy8jqpZHBHk7D4zu+A200t0esz6Wvh+S5nX16jcuNrc
         8Ng7UIXa1eKZet7P+dRuD5wiXNm87i+RJxqcW6eQyd9xB7dwXCSXRNtob9Hv1BVBEe6Q
         PrZ75EnoNkIgL1J8aORiy/2S3+UpQncUpToset5AxGotWXikqtm0bvlJwsceDMStONUP
         ugJA==
X-Gm-Message-State: AElRT7FFIwqqowPPgdBRJKCY9mHm2IdHDROcI3qs/8Hn108BsRKG3R0x
        GYpj3qvPJdiNBTYDFL2FSgxzj44=
X-Google-Smtp-Source: AIpwx4/6lwlODxyWNHvDYju9bjZ1qpsmF8QvFANlQQXpHEPaesoilFi23CG62QAqzefMhxQek6+l+A==
X-Received: by 10.98.95.70 with SMTP id t67mr15775918pfb.200.1522895303379;
        Wed, 04 Apr 2018 19:28:23 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id 86sm14194093pfh.93.2018.04.04.19.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:28:22 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v5 1/5] stash: improve option parsing test coverage
Date:   Wed,  4 Apr 2018 19:28:06 -0700
Message-Id: <20180405022810.15796-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405022810.15796-1-joel@teichroeb.net>
References: <20180405022810.15796-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for converting the stash command incrementally to
a builtin command, this patch improves test coverage of the option
parsing. Both for having too many parameters, or too few.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b172..4eaa4cae9a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,36 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'giving too many ref agruments does not modify files' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	echo foo >file2 &&
+	git stash &&
+	echo bar >file2 &&
+	git stash &&
+	test-chmtime =123456789 file2 &&
+	for type in apply pop "branch stash-branch"
+	do
+		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
+		test_i18ngrep "Too many" err &&
+		test 123456789 = $(test-chmtime -v +0 file2 | sed 's/[^0-9].*$//') || return 1
+	done
+'
+
+test_expect_success 'giving too many ref agruments to drop does not drop anything' '
+	git stash list > stashlist1 &&
+	test_must_fail git stash drop stash@{0} stash@{1} 2>err &&
+	test_i18ngrep "Too many" err &&
+	git stash list > stashlist2 &&
+	test_cmp stashlist1 stashlist2
+'
+
+test_expect_success 'giving too many ref agruments to show does not show anything' '
+	test_must_fail git stash show stash@{0} stash@{1} 2>err 1>out && # show must not show anything
+	test_i18ngrep "Too many" err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'stash create - no changes' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
@@ -479,6 +509,11 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash branch complains with no arguments' '
+	test_must_fail git stash branch 2>err &&
+	test_i18ngrep "No branch name specified" err
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.16.3


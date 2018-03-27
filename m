Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807081F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbeC0Fpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:45:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35459 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeC0Fp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:45:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id j3so2444282pgf.2
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSHqSdeJXcufyfsmCMnhBEtc8SaQfWkmlp3luE+Jl1I=;
        b=IpH9JdmD9g4igYUB8k+bbQ/FMWydqryfYX8uHSxSU1CDLtR5vmZZAhvG79LWBy9Jbr
         XWdnVCEELJlG8FjaCJT70oWL7GmDUAQrk8qqhHIHIJ1u8lGUfK837MIZPhevKSWCfyVG
         2gXRc+wtQSWp6U2p7TNsRwJ0UE5dhUpM/C5UMClPpeRLQY2nunDUpdmvBMYRs1E/2t0t
         lp8Od4l1zHBZAmyImh59oiKloZSJAt01HGRAk8LlLkZ9I7GU83pPWWeDnVaJhhg7ndZM
         Zm5jyOlGL/XJIl8un5foS1mma2DdQntHoof6GKj+4HmIpqAZIPf1NpZ47Snpdn/Azrin
         +8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSHqSdeJXcufyfsmCMnhBEtc8SaQfWkmlp3luE+Jl1I=;
        b=oRCpFZBOHWFc1zWQO1DdGzTK3eVvpDmRFHV8+4NNszLa0ih2sYE0NT2+it/ueAk9BX
         vQG19v15aNjw7GtLhx1WY5JFq7jQJ64Kv5Qk5ZoC2mFGSEYAYsbiWMEf9ofP6kr/065M
         E2dwIPKbKpl+OKrMyf2KBbr2PdamU6cLN0H4Nn2FCnYUBB7huEnd2bzNxVbV10qIyLrg
         O5bcgB21Itau2n3l91pRErJJRxbo8TbfCHjzmAuCOgm5+tsprzGRoxZZkCW6D6z2/bv8
         QfWQJEA7Guz/qmI5VKSZUz7G3dQD7lLZ19h3HArQnyoT0CHZyw1MWWQ2crhQDy09xZu2
         QcKw==
X-Gm-Message-State: AElRT7HAJ0ivpBg9aHPAYooH+io3yclnUdJy74LrK1GH+HvxmJ0+DFe4
        L0uyji87fxBwXFdAb8Avr+OWRI4=
X-Google-Smtp-Source: AG47ELsEZJDhLwhtjPfwkv7JdUSxb8P2CY5gcMI7yRJwJ7TPISZ9jRchhh8Nz3MkyVCTQdB77l2SAw==
X-Received: by 10.101.93.17 with SMTP id e17mr31042078pgr.239.1522129528696;
        Mon, 26 Mar 2018 22:45:28 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id n8sm898733pff.131.2018.03.26.22.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 22:45:28 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 1/5] stash: improve option parsing test coverage
Date:   Mon, 26 Mar 2018 22:44:28 -0700
Message-Id: <20180327054432.26419-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180327054432.26419-1-joel@teichroeb.net>
References: <20180327054432.26419-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for converting the stash command incrementally to
a builtin command, this patch improves test coverage of the option
parsing. Both for having too many paramerters, or too few.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b17..8a666c60c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -84,6 +84,17 @@ test_expect_success 'apply stashed changes (including index)' '
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'giving too many ref agruments does nothing' '
+
+	for type in apply drop pop show "branch stash-branch"
+	do
+		test-chmtime =123456789 file &&
+		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
+		test_i18ngrep "Too many" err &&
+		test 123456789 = $(test-chmtime -v +0 file | sed 's/[^0-9].*$//') || return 1
+	done
+'
+
 test_expect_success 'unstashing in a subdirectory' '
 	git reset --hard HEAD &&
 	mkdir subdir &&
@@ -479,6 +490,11 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
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
2.16.2


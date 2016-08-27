Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A633E1F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbcH0SqQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35459 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754850AbcH0SqH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:07 -0400
Received: by mail-it0-f66.google.com with SMTP id f128so2935892ith.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZsC72ewgwCD9yNj/D8GAVkLdLoDIYR9itotjVcbA1k=;
        b=vOVUAvZ+MoF5AMimSYbWuBteI2d0t7IJL2afxEUsXqtbqp/NbaZSONr2Jt5Wr1u6pw
         Q3+Fs86S4EgTQDIIH1LwGQB7ZpyCUTc4fCtFXFaFpgrn40euVxG2kZaW25AEa3sMiP+y
         hyn5627pVYI9ZkpieA4cJyLWfSaxffkMjGqxu2KV4pJGt38dvQl0Hu24LLz0AGEOGMCN
         RM7XwDOQmJCdo9cvDoPmehbPwokWGnqQLUdU+3WXnvlXiSNt2yD+Fat5oAFKwn6025Hk
         UC8zh8IsrUSAsWXrOVvTxG+SkDq+/ZdMTkGO0WxGKy51xU6cyve772TwFT6Xh/idjbX9
         WIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZsC72ewgwCD9yNj/D8GAVkLdLoDIYR9itotjVcbA1k=;
        b=EElVaP8WYmk4X8eOh3ixHhr4LtV25Swtfltnctv8Dj2Bk0vMo49gavT3+Fkbhfrgm+
         ytIH3aDuxxcB79gsTquIUNAvtocPimIFutiRGPIMVkxPrhqXYQ9S3TfUe2X9crTY5A4n
         7gxU7UQ44WxSiRGu9Ns+oWVTFaeuPp9CvXnlsCkZgmEx3cai0A+tICVUO4+IAPtnxol6
         6z+/xq5p5i40gzBOfLPuHgq4XOHj+/I0r1e6Ze+M4auUrIYhpVzCDQhujE1Rl2UbAK8J
         5q/JPdE85WTvss0jqVwNfCd8iNBocPHahsqiU/r0NfnRZpOIrmhtlVD7FnbWLdN4rJea
         EXGg==
X-Gm-Message-State: AE9vXwNQ1sWTmUllCEKf3rc2b4td3nuwr5sm3Jzv73n25eRSsj1l9J4+zys1B4ELDGvurg==
X-Received: by 10.36.37.197 with SMTP id g188mr5636104itg.89.1472323566650;
        Sat, 27 Aug 2016 11:46:06 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 07/14] apply: don't print on stdout in verbosity_silent mode
Date:   Sat, 27 Aug 2016 20:45:40 +0200
Message-Id: <20160827184547.4365-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When apply_verbosity is set to verbosity_silent nothing should be
printed on both stderr and stdout.

To avoid printing on stdout, we can just skip calling the following
functions:

	- stat_patch_list(),
	- numstat_patch_list(),
	- summary_patch_list().

It is safe to do that because the above functions have no side
effects other than printing:

- stat_patch_list() only computes some local values and then call
show_stats() and print_stat_summary(), those two functions only
compute local values and call printing functions,
- numstat_patch_list() also only computes local values and calls
printing functions,
- summary_patch_list() calls show_file_mode_name(), printf(),
show_rename_copy(), show_mode_change() that are only printing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index df85cbc..ddbb0a2 100644
--- a/apply.c
+++ b/apply.c
@@ -4702,13 +4702,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && state->apply_verbosity > verbosity_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && state->apply_verbosity > verbosity_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && state->apply_verbosity > verbosity_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.9.2.770.g14ff7d2


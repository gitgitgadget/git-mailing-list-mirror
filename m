Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7616D2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdBYHbK (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:31:10 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33297 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdBYHbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:31:09 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so5918270pgj.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V/nn7twLuz2xGSd8oHg8vS1cRMEx8WlecXePr3FQvks=;
        b=a2Kw/SKq7xvlX2LMfoRWsCEurDNiNQ9/so89BpxNgA/NPNuB70dOuSPJNFw2G9l4Pc
         HOowvB7FyXrjxWbjUj3VQx6C7BfoIzdUC02rRnHRX2rvMO2L2yE962Dc30HjsAyKVsQz
         kIKNTEjVwqGaJNwbSVW3nzGt9fe63BtD4JoGY6xBpjNq1TX2OgCfWfnh8GN4CGGA2cBB
         hUoC2jWQzvluTNNfqgb1FIMwTnxfj4BuU2RhOafq+vhiz5wIGh1TuiIVecAj1leZ+5Ky
         yfTCV4RXuhlmPx8P7gK3Ers46zniDE9I/bFjLOFM6LL0MUEwelLFfuc4yUzOk73Ghr8f
         nTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V/nn7twLuz2xGSd8oHg8vS1cRMEx8WlecXePr3FQvks=;
        b=KXI8DHXdGshzZZ480btVwJKrQjy6AA+GjtM/QuGdDeHNXkPj9k6tVyToiUd9sPAS7p
         nqa/LGzlFp3U0QpprQeKQL7JYgXJtVtpQ0ejww3/VMt3NhCb1AQcVXG9b6uQWCZAmMrq
         cZ0AUtLLFgj2YeMUQQhFpGwdqqht24NxsGpnTL9T1Tl3NuiexpAFZDoOt26Ds1I7ddMp
         dyyNulCmdeKcI+gQDWvvFNSlGoiVjxSWQDAIelA5X93WM62iQcsrX1PhJTK1+rctcZ8B
         gevgxU4lTp82UnmAiOpW3ooFtsSqVg8Bn/dxPtQDNRSnOGxWTDDbZANy7mG25o6DXEdK
         1wbg==
X-Gm-Message-State: AMke39l+uZpcXpXKDQSdS5FfeI5y9KWOmAkbeXgAhmMmJg+1CDOD4COOoLDAI5UKwyWZAQ==
X-Received: by 10.99.111.138 with SMTP id k132mr8594796pgc.138.1488007511505;
        Fri, 24 Feb 2017 23:25:11 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id a1sm18725256pgn.51.2017.02.24.23.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:25:11 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 2/6 v5] revision.c: swap if/else blocks
Date:   Sat, 25 Feb 2017 07:24:43 +0000
Message-Id: <1488007487-12965-3-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Swap the condition and bodies of an "if (A) do_A else do_B" in
setup_revisions() to "if (!A) do_B else do A", to make the change in
the the next step easier to read.

No behaviour change is intended in this step.

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 revision.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 5674a9a..8d4ddae 100644
--- a/revision.c
+++ b/revision.c
@@ -2238,7 +2238,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		}
 
 
-		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
+		if (!handle_revision_arg(arg, revs, flags, revarg_opt))
+			got_rev_arg = 1;
+		else {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
@@ -2255,8 +2257,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			append_prune_data(&prune_data, argv + i);
 			break;
 		}
-		else
-			got_rev_arg = 1;
 	}
 
 	if (prune_data.nr) {
-- 
2.1.4


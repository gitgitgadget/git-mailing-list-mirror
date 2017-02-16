Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155B31FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 15:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932301AbdBPPOo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 10:14:44 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34484 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbdBPPOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 10:14:43 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so1836551pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 07:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XIMgBdDrtsL8GNl2f7eChml4jrWQJ79P5K8zjHI565I=;
        b=G5/WOzQALx8xFisr3OIsjLSLmZMk5ZM2/qH2nVlU2/wHbGNJj7v92FUfT1KtLYJC4L
         4Gw9Q5fnQGfNWoDymPTjq6ueWoWZGwq5jlePLXZ/deK1Nlkv7emBn4pfSPU0f9Ogug1g
         JuC0utg30GgzeTojtsJm/GSuP6sHZcj9eE7whCswR/SMy3BXWTOrTxrzLn8dvTBrQR/M
         iflyyaUpdvM4rxchClQyJiv+Q8Zg84ymuEs11xv2wi0K9+TmBleac8OpVhYy7lXasnCT
         tk5MqtUzswY8HKxPtwtA0OrVQfEGVvFoGkb6ZQ++/QOj7Gbsba6k8uo0tlMcSWxIobzr
         CH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XIMgBdDrtsL8GNl2f7eChml4jrWQJ79P5K8zjHI565I=;
        b=gH3BWYnmVHt5t1trCqhDGT13rIcxS04IjJtQM+nlZrzZXnToxPF3B3X2XmitSE/8i5
         lPg7eKdfio5oyGUliohHC0KLJt+WGUlxLowwJs+SC+FQNptDhRJ6mKbEa22V9uvB1p1i
         9+5v66oilhMj3oy9KRyD8at8bM3OoASEbjy8YoYabHnbmaGVxx1mI3KJVVORejelwzBE
         VlOH95jFe/utxvuqnv//v+HBJ+PYxO5idydPGmwbcJl5+HmA4RJP171SjUfdAScpDZlj
         uZqdxomiO5IzxkI9d9DQcMkX3a0/JEtBYW/UlgKPffSxUQcUNXrHJRMrW43WRoBcpol5
         4S0w==
X-Gm-Message-State: AMke39mGhrCUP08aSGr7aTEIZCfvjGfa0AvYFqDRTid4GZVhg3mB7KafDBKujh5kzxqZfg==
X-Received: by 10.98.67.153 with SMTP id l25mr3143465pfi.91.1487258082806;
        Thu, 16 Feb 2017 07:14:42 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id y6sm14531701pgc.1.2017.02.16.07.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 07:14:42 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 2/4 v4] revision.c: swap if/else blocks
Date:   Thu, 16 Feb 2017 15:14:12 +0000
Message-Id: <1487258054-32292-3-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Swap the condition and bodies of an "if (A) do_A else do_B" in
setup_revisions() to "if (!A) do_B else do_A", to make the change in
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


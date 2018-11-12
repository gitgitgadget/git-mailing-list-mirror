Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53001F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeKMJVX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:21:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45569 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeKMJVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 04:21:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so435539plm.12
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6oxfrDCBb9qJIz9th+JHiESZAKRJ+OOFSrz9TwLWK0c=;
        b=jhARiC+RCeogUnkNmmgbNs2OR4PUnLWbeu/y1axBhdKb5kbuMLxetR6LD+VTZFnEdj
         BAFacZ13J+htCWQEy33lyToYPE6XA95sebs2ANss3lYch4Ub7T6ec8tOiTYPgTetMtET
         6cBY+xMHEGxZbdQpnhAvo+mbcubtIdyDh5kbJYQNfFdWg55oQ4PMXTkPEj5rn+BHuPDd
         4IFtgbj43fGtO539rFAdBd5o3Xl47OYJknRoSt8LZc9dZ5ZwFhN1MPktmNUvll0S0rIq
         XK4ku3grLTWxNlDfGP6OEP3K4ISRVPTRmzjp+jsREnYC7P0SWlqakx8CxHGi7dlA5aqj
         SE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6oxfrDCBb9qJIz9th+JHiESZAKRJ+OOFSrz9TwLWK0c=;
        b=Tc6hNJR14lZbtIOuOAm5IQvR9ZkxXykxFaC8fWNc8foZCAfScTujP4EkIVJ+s9IQL+
         vSB57ecY9MZt6xN7N2wKyZXj8mDS0i1ND7UhJw9spLspMbphcBLd4mn+lAeQCz6B+59s
         Q4iUDcjCZVLDkhsakHcuv2BtOnma9uDP+wrcqI+Hg+5OkcR491zAxJhaMbewT+ux+D7y
         gdq4b7RiNDUrLoRdn9VuPCPfa111SbcZkLUh2ii69aprHUL0QohOX3GWVm/O4y1GYqoD
         JwvS3weRB85Btqti8xDjHbBAjomH1+29RaBiaHDYEm6EW1VObfIss21wn9T1I7J1Z1JP
         Y3Sw==
X-Gm-Message-State: AGRZ1gIVx32R3MUoCzmDxftK94Uxx5q3k0uXZL5EoD0TeQVcLQg+QJV9
        P9f1O3yz5TjB0/z0sbKYoYLnoUbo
X-Google-Smtp-Source: AJdET5fPPjCYIv9FyFMWXWtUHVqO/lk3xolbG0QrCc6HiMc0hHZ6uE7uV7A0i/4Xz1geuWsq/e+nrg==
X-Received: by 2002:a17:902:7587:: with SMTP id j7mr1206135pll.191.1542065161779;
        Mon, 12 Nov 2018 15:26:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id u2-v6sm19415631pfn.50.2018.11.12.15.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 15:26:01 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:26:01 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 23:25:52 GMT
Message-Id: <8d1dec51b704c45bf36af24f657cc40f006989e2.1542065154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.75.git.gitgitgadget@gmail.com>
References: <pull.75.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/5] built-in rebase --skip/--abort: clean up stale
 .git/<name> files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The scripted version of the rebase used to execute `git reset --hard`
when skipping or aborting. When we ported this to C, we did update the
worktree and some reflogs, but we failed to imitate `git reset --hard`'s
behavior regarding files in .git/ such as MERGE_HEAD.

Let's address this oversight.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..017dce1b50 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -23,6 +23,7 @@
 #include "revision.h"
 #include "commit-reach.h"
 #include "rerere.h"
+#include "branch.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -1002,6 +1003,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
 			die(_("could not discard worktree changes"));
+		remove_branch_state();
 		if (read_basic_state(&options))
 			exit(1);
 		goto run_rebase;
@@ -1019,6 +1021,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			       options.head_name, 0, NULL, NULL) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
+		remove_branch_state();
 		ret = finish_rebase(&options);
 		goto cleanup;
 	}
-- 
gitgitgadget


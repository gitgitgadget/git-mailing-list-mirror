Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC97C28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 02:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiHWCmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbiHWCm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 22:42:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10F95C361
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u5so7537942wrt.11
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=KDeA+meMH9uLBc60HPCozj/VqbEw65cex2awP285pug=;
        b=gDOuOCsFKXnCS9yJI5qWH+d9aBIgzUOxQMf4PgL08ydM1mHiC4EfRZrlRmETOOVn6P
         pzhfhR15OqWtys+5Tporg0drX3MJMSzlXPXCf1e+K9khptcJxitFByq4sW1uv1HUiXVj
         2iIbI3XbcE2jfcTAuxFJymnmmoIXj4vuE7YjiOZDcn3iJUsEGZLopLsb1099US1uvUM2
         6uG7cFTuBZcY/b1l4o8geUOonCGNus9ZM0YQ4PSZnM1IJTo+uiONBKjQzwuC4KSXmAUE
         NKlls08hZQnPy+XMNAoVdQujxRphtw2Vx9tfLheIIIVbvySnY510v59dcrpobTgr4o4Q
         E4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=KDeA+meMH9uLBc60HPCozj/VqbEw65cex2awP285pug=;
        b=nDgdhA0BqYuS2p1kK5wrNuxZY5X3vYlkst7aXPoSkl0qphIm8Jsh9xjKoPeo6nUQUg
         u6v5ZkCAlIfIwj58ri5m1yzoUoKSqNJdS32iXXYZ0LurimWqeP/bjcAtIIH5xqFyrWRU
         hSZbFylBhhhZIdWLU7LRUok+2LF1ZbE2I134NR6n6kz/Xlr+jmRAcQACwJl+91KlJpc8
         bAqeFe+q7B9/4Uj+ILPGxr2jzU73QxeKzXCrawbe7c5wNFkC/vSKpMq54hY2UuS4Ed5j
         VdY7LLNy4CrrpswpDSvnPNn/KY5i4jE/4cWYjrpRjaS17ruDdDMU70WQ/+YAlgYPB3+E
         /kOQ==
X-Gm-Message-State: ACgBeo2MGF8r1ygzamV00cvRDZ36773oUKpBlr1lmHvorZfHOO+/jmGd
        M812iWcQa7E0QsbZX1oawqHGho8EHZA=
X-Google-Smtp-Source: AA6agR5hcAvc2eUurzF6Gigz0RHLZMIAeyiRi+2KfbLwHVDEE8+NPHu6LLBb7Y+k2NwIynKQKkXCvw==
X-Received: by 2002:adf:d1c1:0:b0:220:5ec3:fb62 with SMTP id b1-20020adfd1c1000000b002205ec3fb62mr12009752wrd.69.1661222546098;
        Mon, 22 Aug 2022 19:42:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003a5ce167a68sm20234334wms.7.2022.08.22.19.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 19:42:25 -0700 (PDT)
Message-Id: <88173eba0b9cdd861b9c8e3d229decae3b312681.1661222541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
        <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 02:42:21 +0000
Subject: [PATCH v2 3/3] merge: small code readability improvement
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

After our loop through the selected strategies, we compare best_strategy
to wt_strategy.  This is fine, but the fact that the code setting
best_strategy sets it to use_strategies[i]->name requires a little bit
of extra checking to determine that at the time of setting, that's the
same as wt_strategy.  Just setting best_strategy to wt_strategy makes it
a little easier to verify what the loop is doing, at least for this
reader.

Further, use_strategies[i]->name is used in a number of places, where we
could just use wt_strategy.  The latter takes less time for this reader
to parse (one variable name instead of three), so just use wt_strategy
to make the code slightly faster for human readers to parse.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index abf0567b20f..5900b81729d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1708,7 +1708,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		wt_strategy = use_strategies[i]->name;
 
-		ret = try_merge_strategy(use_strategies[i]->name,
+		ret = try_merge_strategy(wt_strategy,
 					 common, remoteheads,
 					 head_commit);
 		/*
@@ -1723,12 +1723,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				 * another.
 				 */
 				merge_was_ok = 1;
-				best_strategy = use_strategies[i]->name;
+				best_strategy = wt_strategy;
 				break;
 			}
 			cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;
 			if (best_cnt <= 0 || cnt <= best_cnt) {
-				best_strategy = use_strategies[i]->name;
+				best_strategy = wt_strategy;
 				best_cnt = cnt;
 			}
 		}
-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3741F461
	for <e@80x24.org>; Fri,  5 Jul 2019 20:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGEUck (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 16:32:40 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44416 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 16:32:39 -0400
Received: by mail-ua1-f66.google.com with SMTP id 8so2625262uaz.11
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZL7UYaWRxXfuc7oJO2mRkHfZWe6qoPezUHBaKV0z3Q=;
        b=AvCWCOn1vSPlW3cPoYewUm8q2lJIjS2hTB5yL6Hla8klLR6anQBmO2G3sbjR/50zXa
         PLfd6emvImwEqsUVqQG0Ud7+agepkMIpUnbrW167+Y3kKGvVVdE3147ztD8+gCfttn7/
         L1zH3BbBQ3Dd8R+CdwYa39kh85PSWdXByCv6MqhTFrReEITG4BH9OEqMR4clDMqh/ma9
         krV9hl2dTMuxifqo62c+VusvfTvV6vvE5FXsZk12bvnVR6DjcDHczi+ji960pJUtIkAq
         ho6GK3DLJMzKAQnlpTLF/EdhmFSq07keJzLa3yy792tccRg93KNbUpWUFdIizF4lQ6cL
         QCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZL7UYaWRxXfuc7oJO2mRkHfZWe6qoPezUHBaKV0z3Q=;
        b=KbE2lXKmgiIlqPgvlJ+2D/MBfeGq2eDe2VZsmA8JdyguacLe/mKlrVI/SWQp12q25g
         8bMrmxI5LqunKrOn5DpF2Uri9DleD8B9grWooSLumsA/8nGu4sC/Mkc5L6sMgBPZHr4s
         0Fn08X/Cd+KSwu8+EPhqQ1LcnFLf8Cigj/r+dX2+QZFmBYphdJYKqtVyBI9z3Jv5aCMo
         P/WaCkJ1R8eX+tIZD2vRz8C2WwqdpKeVmNjREJyDMwZJrCGerYpXupXGaLlv8l/uJJsG
         Fur4kZ/WE38zNah1/O86f2g5MdSfqRRJY+/afoL3uuin/SAcMbrUN6yvwPucZk4lG5Rx
         kpuA==
X-Gm-Message-State: APjAAAUDvv/Ml2Bm8SILkdhbniy3+GrJOq56u5N1jZ9ycyJHzIyll+Ah
        YVidNS9tf7RB9ROAHn8RykDsor5RLHc=
X-Google-Smtp-Source: APXvYqxVJw7uW+l0lDZLLkMTXK1odgVVnZISZdfFI3UUwh34D9iokrJP+t5oYVU0cDDSKa7OcJKLDQ==
X-Received: by 2002:a9f:28e4:: with SMTP id d91mr3319647uad.30.1562358758581;
        Fri, 05 Jul 2019 13:32:38 -0700 (PDT)
Received: from linuxerio.hitronhub.home ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id s12sm705101vkh.51.2019.07.05.13.32.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:32:38 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1] merge - rename a shadowed variable in cmd_merge
Date:   Fri,  5 Jul 2019 14:32:27 -0600
Message-Id: <20190705203227.23451-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

variable ret used in cmd_merge introduced in d5a35c114ab was already
a local variable used inside a for loop inside the function.

for-local variable is being renamed to ret_try_merge to avoid shadow.
---
 builtin/merge.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6e99aead46..972b6c376a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1587,7 +1587,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		oidclr(&stash);
 
 	for (i = 0; i < use_strategies_nr; i++) {
-		int ret;
+		int ret_try_merge;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
 			restore_state(&head_commit->object.oid, &stash);
@@ -1601,26 +1601,26 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		wt_strategy = use_strategies[i]->name;
 
-		ret = try_merge_strategy(use_strategies[i]->name,
-					 common, remoteheads,
-					 head_commit);
-		if (!option_commit && !ret) {
+		ret_try_merge = try_merge_strategy(use_strategies[i]->name,
+						common, remoteheads,
+						head_commit);
+		if (!option_commit && !ret_try_merge) {
 			merge_was_ok = 1;
 			/*
 			 * This is necessary here just to avoid writing
 			 * the tree, but later we will *not* exit with
 			 * status code 1 because merge_was_ok is set.
 			 */
-			ret = 1;
+			ret_try_merge = 1;
 		}
 
-		if (ret) {
+		if (ret_try_merge) {
 			/*
 			 * The backend exits with 1 when conflicts are
 			 * left to be resolved, with 2 when it does not
 			 * handle the given merge at all.
 			 */
-			if (ret == 1) {
+			if (ret_try_merge == 1) {
 				int cnt = evaluate_result();
 
 				if (best_cnt <= 0 || cnt <= best_cnt) {
-- 
2.22.0.214.g8dca754b1e


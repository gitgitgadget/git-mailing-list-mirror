Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C87C28D13
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 04:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiHUEii (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 00:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHUEif (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 00:38:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECBADFEB
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:38:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6050515wmc.0
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=MFYwz6PheNpX7vbXD74uZ2DSWZj9pWuhH4L1hfLaq58=;
        b=AZsp1PT54uwzBi1vC6yspgReTkbAAc7lU8FpnEgQvDo866YdBieFW0HbMdGuIqrH/A
         EmaqOuyL44wjACOGQ68wX/9IaXDCX4g+bp+h1MS2yaq7X7wmQGRxxcmeO5yb+aztC2Bl
         WSLA70cJZTA9RCqjd+zlCH5nfVxW1iGJKrYZPHSe/k+EsdjIHI0ipvWZVjgRRMORBGFY
         R0dgpYiIVW6/KFKSiwTnd5vq96m2taRtQmaunPqwvG+boBiOOWf7WSw4ifuA7XiCwd+r
         dR6eoUDRMUe2aRszgsJ2GbsIViwcl6/n0IVoV7X+KYCjXCoeVSCUor0ny9AbZgk2t2/H
         PQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=MFYwz6PheNpX7vbXD74uZ2DSWZj9pWuhH4L1hfLaq58=;
        b=rWnTUFi/Mexl72zkmF0ebWTIqU0NluNCioO+otyur7KIpYu0IDSxc31m7GpQyb3krY
         XAluWRPki7oak4HHGOWn62i7vKieyAQ8QbylflHp63Hl02jmKTj0ct3AQeBD60W8xsRW
         oagWLz2tSZbdvVe5sGdUSOV8Tc/oA2CW3l6w48BKYMPaLZuLaTN31ieb3YIDWGeGw/6y
         wAk/DXy/Cgf/UuX9hDsQeEtQVMihbFKsmmwHe2yRHFMRvTFOolLZmZolUe5AsLKOnYn/
         0ZxewgZB/O05/OEtbdGv+PuM7eeRpl1NgNWPdII4lUgTUnzz/JKXju8J0OmDpxpsW90+
         tMnA==
X-Gm-Message-State: ACgBeo2Jhej/6GgDpKbQWQA0MZwiLowgl3/UiwKoafDKkcRSd4DNCqzs
        35UbhaEkhbyYrFPmdTSynv3oQBwAEeQ=
X-Google-Smtp-Source: AA6agR7Lr1X3ZiF+mA6bVcuWSjvOVnQEEwPKPIIHoHZKuCHWu5rf11d/eB9eC1tSAfV7i28321hasw==
X-Received: by 2002:a05:600c:1084:b0:3a6:150d:b92 with SMTP id e4-20020a05600c108400b003a6150d0b92mr12001547wmd.151.1661056712638;
        Sat, 20 Aug 2022 21:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c34c700b003a53731f273sm10484237wmq.31.2022.08.20.21.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 21:38:32 -0700 (PDT)
Message-Id: <5657a05e7635ecadbb8d2e41ad97fe19f3633fdd.1661056709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Aug 2022 04:38:29 +0000
Subject: [PATCH 2/2] merge: avoid searching for strategies with fewer than 0
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

builtin/merge.c has a loop over the specified strategies, where if
they all fail with conflicts, it picks the one with the least number
of conflicts.

In the codepath that finds a successful merge, if an automatic commit
was wanted, the code breaks out of the above loop, which makes sense.
However, if the user requested there be no automatic commit, the loop
would continue looking for a "better" strategy.  Since it had just
found a strategy with 0 conflicts though, and it is not possible to
have fewer than 0 conflicts, the continuing search is guaranteed to be
futile.

While searching additional strategies won't cause problems other than
wasting energy, it is wasteful.  Avoid searching for other strategies
with fewer than 0 conflicts.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b4253710d19..f04100ce0da 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1718,12 +1718,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		if (ret < 2) {
 			if (!ret) {
-				if (option_commit) {
+				if (option_commit)
 					/* Automerge succeeded. */
 					automerge_was_ok = 1;
-					break;
-				}
-				merge_was_ok = 1;
+				else
+					/* Merge good, but let user commit */
+					merge_was_ok = 1;
+				/*
+				 * This strategy worked; no point in trying
+				 * another.
+				 */
+				best_strategy = wt_strategy;
+				break;
 			}
 			cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;
 			if (best_cnt <= 0 || cnt <= best_cnt) {
-- 
gitgitgadget

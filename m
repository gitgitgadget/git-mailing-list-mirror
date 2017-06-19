Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9099D20401
	for <e@80x24.org>; Mon, 19 Jun 2017 02:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbdFSCmP (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 22:42:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36547 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdFSCmO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 22:42:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so14597089pfd.3
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 19:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMSWlZTAWc0IY4ElcwWagM+lVw4k4QzRjKdCIh2Pa2w=;
        b=GNGrihnh7ASlc5a6UFGA+9rWSFQCGDGAg/STeq75J6Q5UeY8LINlaXJz604Sx5hnHX
         +NlNDQJyXpuxzq8LtroI+fzUJyWRLCgIxi02LjsXtbxj0VqsLY0b8xLHKkyi29mvluhY
         S19Y/FyTnYazygy4ikqEC4xDPGXTeNYsJLqU4nWYh4eTtCr0Atzjvo485MCdAnX54JVq
         mEBsHZckkybqTdHy8aGntUgIqIksXh6ygeyq20yy5CNUjHxGzKNoC5cVNuMZsDYFs9CJ
         kzeRZ6WFllcyqsFNV4cZVmNklJg/L+RTQ95ccL+RqXgajoBTHjFxgqC0kw1vx7OdJd9g
         VjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMSWlZTAWc0IY4ElcwWagM+lVw4k4QzRjKdCIh2Pa2w=;
        b=tWqf9Q/uGX4NLBnknFMmk1DSbHMD2+90CzcqcG4T+WyhUoaVJ4QXSf3hesHZd4Iz+s
         36yCVUrdeQmjs/4q9O7q9dtx7hB96Y/pMTr4xzNzr/Ok4xBqqVoP4Zr76yc1V/7Q7GRU
         5wjzkM26ckCDbC49jsZioj4sw6qsUKE2mJC58RFRS1OdmHqB2n7YtM1ByqAHTaHlPgFq
         ZaeTqCJbNaEhQj8gc5RR7IlCge9KnFaTzwzopnqFCkEYuuv51g/unxNH/cVn5WPigzFw
         7T0u3qlM6rpAt712Wolpmjl/39bdN/2ykes+Xc1NDAxTIywTgWFy5TvIp564tITh/mPK
         I3Xg==
X-Gm-Message-State: AKS2vOwz3GThJ9il6SyrXDa8NIBAecuOeEZl/RQO9GtWoTBNbw2KpneB
        2D39QOijxVtdxA==
X-Received: by 10.98.155.218 with SMTP id e87mr23152764pfk.24.1497840134097;
        Sun, 18 Jun 2017 19:42:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:8284:9daf:c00c:2460:a1a2:73fc])
        by smtp.gmail.com with ESMTPSA id s9sm18147396pfe.21.2017.06.18.19.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 19:42:13 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH 2/2] Add test for the new status message
Date:   Mon, 19 Jun 2017 08:11:44 +0530
Message-Id: <20170619024144.5537-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <87shix8zik.fsf@gmail.com>
References: <87shix8zik.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 t/t7508-status.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index fb00e6d9b..e9337c728 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1499,4 +1499,15 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'No commits yet should be noted in status output' '
+       git init initial &&
+       cd initial &&
+       git status >output &&
+       test_i18ngrep "No commits yet" output &&
+       test_commit initial &&
+       git status >output &&
+       test_i18ngrep ! "No commits yet" output &&
+       test_i18ngrep "nothing.*to commit" output
+'
+
 test_done
-- 
2.11.0


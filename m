Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCC1ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiH3NzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiH3Nyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:54:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63113E90
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so6188532wms.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=o/LdOqUzCNHGwvswaHVae5HSWOMYANZGKbhv6ZUrQS4=;
        b=cxXXUx6386mAIEAU5+sOXNvqZD5IXu+1mhIhcIq6AmLrKI2wMYYq1/iD/kKawtSHbt
         xEUWvVDDqOK/qdOhlKx1zbcS4O+P/NiMgjZ4aXUWg+tDLM1CBNeO47Cq1XeTbvFFt8Qj
         B1cxUehlZXN2TtDjt7i/qb68QBp74aOp9kcjj2qFTHaLvkNYkKPPZ22DDPR1xYLJcc3l
         N8xXlk57v7QhrEY1BvKSUx2BGa2e+dC/hA2OWS3EmuGfmliLONedTQs1U35aEUwdoT9B
         QhF9XdVjZ7NMFk2BZqSY10w8luxP9NGREDUpjumdzedeE64/juaxd4Bi4w6BxfC7uUNn
         Ya1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=o/LdOqUzCNHGwvswaHVae5HSWOMYANZGKbhv6ZUrQS4=;
        b=eDU0wWUBNTvjJT5VO5cCzt8ygfay65ZceQAP7BrL1AdePDseZDCrj78yf/odse3YL0
         5ZcIYzaOChCwmYT0KTVoacNv4i89t2pl9rSAU6ei7rd5Z3bFX/R/ZgiWD3VbiVjZQABl
         mKlmli0jE4lPn/6d9O1rUx66QYuNGudI/oN0mJyKayiZuLy3alnbQlhOVdHqqI1HtGAL
         QJHVA6pbwHktGi++dF1ItNos2lCjP5Hsw6dDqR6ZpfIbo0ZxukEGoCdIUNpKukoiRyyT
         nf8LfbLUcWu6Slva4Gq1/7B4Uxltvmr2l06CL4szekNHkPddRYeChOVqhzrPjSgf8SMx
         okGA==
X-Gm-Message-State: ACgBeo0FiEDWWlyC5AbReTU1cA3yjRO9e0/YUOky2lbbQJkT/qdcNOEr
        HXnjRR4sHL6rszTcejq+dBfdxiWtKKY=
X-Google-Smtp-Source: AA6agR76/Wz0WmakOEcDteAbibTQRb7yl16tdMrH4AZ2dxDa1W+BUEvRCc4sHiqid3xp8YG//pH2Sw==
X-Received: by 2002:a05:600c:1912:b0:3a5:f4fc:cd40 with SMTP id j18-20020a05600c191200b003a5f4fccd40mr9869450wmq.205.1661867668889;
        Tue, 30 Aug 2022 06:54:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b003a5ad7f6de2sm12497204wmq.15.2022.08.30.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:54:28 -0700 (PDT)
Message-Id: <54d25d991b09219f6992dc3e8c102ce1ccef6313.1661867664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 13:54:23 +0000
Subject: [PATCH 2/3] t3701: test the built-in `add -i` regardless of NO_PERL
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The built-in `git add --interactive` does not require Perl, therefore we
can safely run these tests even when building with `NO_PERL=LetsDoThat`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b354fb39de8..8d16cd45821 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -7,9 +7,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-if ! test_have_prereq PERL
+if test_have_prereq !ADD_I_USE_BUILTIN,!PERL
 then
-	skip_all='skipping add -i tests, perl not available'
+	skip_all='skipping add -i (scripted) tests, perl not available'
 	test_done
 fi
 
-- 
gitgitgadget


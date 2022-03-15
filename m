Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83FC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiCOBvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbiCOBu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:50:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DF10FFB
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so595439wmb.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=837qGVpXFZzM+0YUSLB3JsjOQ4eE6KaJGG+jcxv7f0o=;
        b=fuok133nJCseS2SveuR7EkwZl8C3RlQxR5PvkmzR3eVgi3PH3ej+4MyLVUNt8Shu+f
         SOfuB55zHO3VxbhL6vnYSv9EfK2UTU6tspCwiyfScihS358Ty2y8X1OfMz6C4YB5b8qc
         h6f1rP7rNA4dnj0ZampTSU2OIE0kxphJCnpXVucz2g+0PEhirVIt8cAS9q4e/O+wFUdA
         pG8NnwPVaBcXehN10MyTwHwYHe6JhXTZDQhZhNxcnrV/PUsgcnMA3k3ouwz2m5Pg4hjp
         ZslSaDSWwCMl+VspuZaRlF8z0l6CoKt15c+3oI7QWuYjg5RLkWUe2JX0eycVhtlrfmKE
         sm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=837qGVpXFZzM+0YUSLB3JsjOQ4eE6KaJGG+jcxv7f0o=;
        b=ZlK0g2bOZXtGrwTQNVcc8BVK0N43ZI0jr/IhDkdGDCRrsYab9uvKSTQfhWQaA7iD4E
         LzluX7UqIpNjUxS1X9lm1byCm41z5yI7H/hZZQvR1+Ee/9oACB509vhRfn26uaqSB1fZ
         ayXlpCF3Ix1om4P9oc9IVrXkv2EQgS1VE6g3CPX4O/UMmNh0so/rc/5Q3cctU0Lp3wj1
         m1xxDPWa20jbi8ckkSuKZzLX8hk0znd0WW8JA35RKrV2dD1Ll7rlPy/5lWfjzU3LTctZ
         XZsEd4rAhLCj2UvXgB74RCEdoKmQNicIjV/JilVf4V4yi3JlecxkPfZWj+T+UG26C5+1
         Gt7Q==
X-Gm-Message-State: AOAM531rjaYMFIACAkJqDnL1LenzFr2SGivmPc84N79nCXIJpD2O2EZY
        fM570dCcjFuWs3nA2A8tmLcOBBKtqGw=
X-Google-Smtp-Source: ABdhPJx62+2vg6sZHiHvgoLl+ehqLdFkyE6J++rXIuI8+JIUvtgQ612/tvlmCNbuaV+RGN/duc3cwg==
X-Received: by 2002:a05:600c:5108:b0:389:b089:291 with SMTP id o8-20020a05600c510800b00389b0890291mr1348238wms.109.1647308986638;
        Mon, 14 Mar 2022 18:49:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b00387369f380bsm924035wmq.41.2022.03.14.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:49:46 -0700 (PDT)
Message-Id: <548c9303c448f85b4c1c5db44886b8b9b7b44db5.1647308982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 01:49:41 +0000
Subject: [PATCH v3 4/5] reset: suppress '--no-refresh' advice if logging is
 silenced
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If using '--quiet' or 'reset.quiet=true', do not print the 'resetnoRefresh'
advice string. For applications that rely on '--quiet' disabling all
non-error logs, the advice message should be suppressed accordingly.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index feab85e03de..c8a356ec5b0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -535,7 +535,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
-				if (advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
 					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
 						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
 						 "to make this the default."), t_delta_in_ms / 1000.0);
-- 
gitgitgadget


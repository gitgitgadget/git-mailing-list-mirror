Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CAAC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbhLVS4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbhLVS4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED41C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so6733716wrw.10
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=o7THXJk0bGUQ7vXKQPrp/bTH3Wn/bWknF01Vl9ctpJtg8NPtHk6mD6XpXqGV3CpdFy
         sPUXizPa4HT5fggAc/HhNOWp5gNa1I0oUoRcta1cll8wz8fWM4dURHQjWpfIZEm7ndDk
         3PW7o2jh1k5p6U48Bu6+c8bc3L0iOdMXC8b2asrHl+HiLGIm9VMZDDlGNe5+nq4B5mrU
         OH8cYhI2isowXBtnYeG3cyUVwm//kFl3H9dztdscfnbnoH+hIemionx7E+H86E8WCYte
         ye/ofxvDa1m3qjbe2XRPR+XKjwWGct+Fn5KFOg3gUOw5PJJz6ZOHUMsZz4VlXwS9gTBs
         SFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=WyG1hpoF9x84kfZln6VPtYlEI0D38UyXxfLVqN6cY4TWXhvBx7zSRg2VzhyrpQa1LT
         Cjr38lRViuONeflm8IZANJcDH7p7lyQgmDl56KBe9JtDi/inSRB082Xf6gpQaM//jNkS
         xtE5Lm/rPuwn3Fo/5OcfvVUDhtuuLzYzi7QFOQKDOcWsUykEhqSIUZ3f4I5kM3zea7zd
         5M7vxUENVp2vKPqQLvDuT/sQ/cYYA1CJNC9NJxr9JTVO5rIJGDAQxSji0s7vQU1Wn3IE
         fhSyH99AB6kBSZIsettHH2kO6FkomtVhOF5D0R8KHwfjsx7Ail542n70H33HLNET31I4
         EBjw==
X-Gm-Message-State: AOAM530zfOWvONKhqzzyUYzCobgFqt8ki9KBofcd1+vcfPn080O7aimt
        qkCN29wT5Qd4x6AjajZ8KpyEDdCRh3I=
X-Google-Smtp-Source: ABdhPJwVYlYdN7sCX0IVHlDFfXLLIKmTcmwY+LPwWbtj4R/VHvQY5HP34PZbwnxaVgrqXwHXvFxOIg==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr3107018wrq.44.1640199399893;
        Wed, 22 Dec 2021 10:56:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm4476336wml.45.2021.12.22.10.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:39 -0800 (PST)
Message-Id: <e6e53aabc39a347b7dfd8bd601e2e2a6e4b37268.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:24 +0000
Subject: [PATCH v5 04/16] reftable: check reftable_stack_auto_compact() return
 value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Fixes a problem detected by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index eb0b7228b0c..d628420e63a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -814,6 +814,7 @@ static void test_reftable_stack_auto_compaction(void)
 		EXPECT_ERR(err);
 
 		err = reftable_stack_auto_compact(st);
+		EXPECT_ERR(err);
 		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-- 
gitgitgadget


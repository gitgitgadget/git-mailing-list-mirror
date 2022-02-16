Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DAEC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiBPKPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:15:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiBPKPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:15:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592F22AC906
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w11so2614007wra.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fbkoO+oY2DNBCw+/7YmdbNGXh6pRof0tA0Qh0Ob21jw=;
        b=KXZ4I8woX4X4UYolFN0BefUY4HT7Yy1u3eAsFsGamANX63pTbek/jlbWsXEUtOai86
         cDn3/8td9F4gMhjp8uiIU6vbBWjKO8oJ1/3KIhCHcWA864CkirPAKLhNOm/qL343rgm1
         mB3VlfPuUH1wUXOTq5/d20Xj5sqS+IhQcOCR/aX7Kk6I4CwSxElMxv9ni2ZSWl+7wNY/
         G8uPW/3WkbW5/rixVxK8eB8kBAU9GkcEJFDQs1w5IJ5CE7CslVRt0sthohkxl+oJ7DOB
         Ufg0V/ArqoMG9+DfaHhWXTI1oylL1zljxJRzzEAhfSWfHkp8RF1fNFCQSKB9Hk1xrvPf
         wFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fbkoO+oY2DNBCw+/7YmdbNGXh6pRof0tA0Qh0Ob21jw=;
        b=jrYFLQOKpkEqfoF5uactg/hepL7BMNfny37+lS6zMcANOd39Zw+VnEUkKqQ/sQnH6h
         h3xAagqpuiDkm1+PJHCJNUY61Vy6WaRf6kAvImx8vOtvBZOnMJkwWzeXf5nXAIKoBmFQ
         5c/eMLwcBiMSRZPXSAJtwPOqRE4CWSLXvgRA9PnXMn00IUTELYML61UlEhnyPmtETyrm
         OErcY6PH8JwbqpeqwCMNg7iTG39hqhvrnqA4be0kVoBYH39V/R/g1xYQrv2eTPy3OXXL
         GpYt41TgYQAXyGKjCFGsEEdhFFd4augVMNObNQb4j7C6o6469PEgkFhmrlyne6DYAaxf
         VImw==
X-Gm-Message-State: AOAM530ewyzVBi+2hT7CufVG3irpws4K2zj63V+2FmfIOyzjZa4VmQwy
        tBc1svABZqWvkNnYHCDBYGv7i3QOq9Y=
X-Google-Smtp-Source: ABdhPJxe+CvZbKL4PP8s+7lACBR7qG0c00A1uN6Xhg6yEu4E2kpXsu0w1FWgsHs6ST6+rYo2uo77lQ==
X-Received: by 2002:adf:d20f:0:b0:1e6:30c9:4aec with SMTP id j15-20020adfd20f000000b001e630c94aecmr1696823wrh.577.1645006515827;
        Wed, 16 Feb 2022 02:15:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm11382288wrd.30.2022.02.16.02.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:15:15 -0800 (PST)
Message-Id: <7e705d771b041ae0d455a4296e2955a24e264779.1645006510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:15:09 +0000
Subject: [PATCH v2 4/4] xdiff: handle allocation failure when merging
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Other users of xdiff such as libgit2 need to be able to handle
allocation failures. These allocation failures were previously
ignored.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xmerge.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index d43abe05b95..af40c88a5b3 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -708,13 +708,18 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	    xdl_build_script(&xe2, &xscr2) < 0)
 		goto out;
 
-	status = 0;
 	if (!xscr1) {
 		result->ptr = xdl_malloc(mf2->size);
+		if (!result->ptr)
+			goto out;
+		status = 0;
 		memcpy(result->ptr, mf2->ptr, mf2->size);
 		result->size = mf2->size;
 	} else if (!xscr2) {
 		result->ptr = xdl_malloc(mf1->size);
+		if (!result->ptr)
+			goto out;
+		status = 0;
 		memcpy(result->ptr, mf1->ptr, mf1->size);
 		result->size = mf1->size;
 	} else {
-- 
gitgitgadget

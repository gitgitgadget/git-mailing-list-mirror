Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9601C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC2C63225
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhKPJwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhKPJwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A688CC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o29so16338515wms.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8PooKE+ZmACiLnvvFNaC9GMC6c2B/Iz1nlWdS4LuFUY=;
        b=I9Skn8z1zBoKy/ahgJb66TsVduCgG+pOE34rvoP066qkRLozj74D7qziexNVQ935tL
         2VhgJDALYjeE320CInyNEcytOwWVbR4P1MW9cg/crEwTCY0O1i5GU+eok1e1OweSDF1W
         QwOTzlZAi2SUub9nmz+LE8aXlJlAAU+CoAOtBlhFmpPn+0YGMYLY35l8XdubqXsyngxP
         DgHPJeMGOXMX94QXmfSdBmuLtyh1aK/Lwl6sH5h4+BZv3DT0Kc8BY1yrigd7Deui/RSN
         ZL+DNZyvtF3CD+ywJuI3ghbKF474PLk+YPMBBprUNVdIrX59tJvfiMvsf8l40VRtdyhb
         8ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8PooKE+ZmACiLnvvFNaC9GMC6c2B/Iz1nlWdS4LuFUY=;
        b=Z2gKePGTS8HhZhMzo5LxtK3oj37NpUndVEpQpDDOiL251uCNfmG7bHJIEvCNDwQtcy
         iw8MIQ+4Q5dSfIvMMDH/JkiuB6bM+2fpO6B2sVQowXR8z8irs0j3C6EEJwzOdVj8Qwg2
         +bhjs22soIUWSEWm4JEW6KhemhHYdIM+InHz9A83+f5cTQSpPAhr1v1INDfLE10unFz9
         RGX85CMTjsGplw0MBYbVMnbb3lIDmrxLLZK3d0G1Qq0WUnNwdY+k6Qn/rvIFSsvGQsJ7
         X/VJupQApiA4dT9byIDuMMf/KtX3OW83oB1GawvaIKEmRi5rTm841eMK01T8FHUdPk/l
         FwYQ==
X-Gm-Message-State: AOAM530lIrJo7rYJ6CAQkFvKE5d5aTDZItM0aD/s0bySJH16kFYwFiXM
        5U4GkkAFfRmot+Pt1McDqiuZfRnnr64=
X-Google-Smtp-Source: ABdhPJzMebaM12G+91v/GRdCtK6MGDw+qoiByDBr0hssrCxi2a8AqaFCzBKPVRcPCpCXg0Bv8rqqIg==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr6168984wmq.59.1637056182040;
        Tue, 16 Nov 2021 01:49:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm17584045wrp.79.2021.11.16.01.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:41 -0800 (PST)
Message-Id: <47c652716e88af7199c44a555780eafb643a1f9e.1637056178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:25 +0000
Subject: [PATCH v4 02/15] diff --color-moved: clear all flags on blocks that
 are too short
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a block of potentially moved lines is not long enough then the
DIFF_SYMBOL_MOVED_LINE flag is cleared on the matching lines so they
are not marked as moved. To avoid problems when we start rewinding
after an unsuccessful match in a couple of commits time make sure all
the move related flags are cleared, not just DIFF_SYMBOL_MOVED_LINE.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 52c791574b7..bd8e4ec9757 100644
--- a/diff.c
+++ b/diff.c
@@ -1114,6 +1114,8 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
  * NEEDSWORK: This uses the same heuristic as blame_entry_score() in blame.c.
  * Think of a way to unify them.
  */
+#define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
+  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
 static int adjust_last_block(struct diff_options *o, int n, int block_length)
 {
 	int i, alnum_count = 0;
@@ -1130,7 +1132,7 @@ static int adjust_last_block(struct diff_options *o, int n, int block_length)
 		}
 	}
 	for (i = 1; i < block_length + 1; i++)
-		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
+		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK;
 	return 0;
 }
 
@@ -1237,8 +1239,6 @@ static void mark_color_as_moved(struct diff_options *o,
 	free(pmb);
 }
 
-#define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
-  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
 static void dim_moved_lines(struct diff_options *o)
 {
 	int n;
-- 
gitgitgadget


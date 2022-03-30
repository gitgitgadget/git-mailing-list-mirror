Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F5FC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbiC3FHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242720AbiC3FH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF5266623
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so27596951wrg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4E3crma7zgCOi3ds7U5p/TJuGKDkbTL9Fu3rj9gxZZo=;
        b=l2PdaytBMynmT5Baxm+MKxxBN2g+OAWR1bHuB5m0ddDUQpTGARJ2Lne1sTEjcCRHCF
         Plaa2TFUoZUvEiiQVBMHZ3GINnI83Ld+ClahjDHXXKRi+mfIvus22D0qF0WiameGWduh
         RoB+Y/SvXTJcr8yOCaNnx4eM7QWXaS1fvDWr5gOnpqjO9iP68AUDGb2I5YLzuBa3HIX3
         79YLVp8UHT8IlHcMBLdxdIEh3djCJRMVXLeVXCMV1Hpacsd0mF8+yqstIap+jTizyFBv
         HMbUb320B6ISuNcYIfmxls88XFvqOUAK3uNEU0jiKqyY5QO++G3qoflIUgx3wRuTq6XS
         EirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4E3crma7zgCOi3ds7U5p/TJuGKDkbTL9Fu3rj9gxZZo=;
        b=ue0TT7lsCAlsmJedHnSZR3UomS6bkxczIh6c3DYGM45GEeqtwVq8NYmHnKEqqKDyoZ
         9AyJE2yURIuwIzihAWVxxd8n6ec64EQ/9nUgaZkpyFecnG6T8/32UctzCY2a3c0LwiYX
         RC6gcCHGozCfallh5iJ4ooxW9kPnbILwaZUn9Mr7e/8evLj0F/pHa5ijn9JhD7Ty2MNN
         fsLxmELMdpgTDUfv/TEckUaX1Z38cSXtkqMl3fWkcqc0fI5i4dqudFDkAaCaCMvtgXVq
         xr7Iu67/2h3BcDB1crHU6hvKBK880UTe2a+sQSxi0WaBx69bXRzxIQ+yH33ItTxAqVHe
         eRQA==
X-Gm-Message-State: AOAM532txWh/+sQG950kgvwa3LJp6HOZzeNJCAxuzWnx/y8hLAcG7q4l
        Q2F9gtaGBm4MLtI/yLS/bfP8nK31q1E=
X-Google-Smtp-Source: ABdhPJzwHAnguen1JiGdUzmUXnAaGii/vFyOi/M0DiwQyvt2zUf6mOrfY8CSJpgZDepJ7s3WjOBShw==
X-Received: by 2002:adf:d1c9:0:b0:203:c225:d042 with SMTP id b9-20020adfd1c9000000b00203c225d042mr34036424wrd.630.1648616741795;
        Tue, 29 Mar 2022 22:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b00205c0cb33e0sm7417769wrw.35.2022.03.29.22.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:41 -0700 (PDT)
Message-Id: <d514842ad493a819e3640ecb658f702e530d6e85.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:24 +0000
Subject: [PATCH v5 06/14] builtin/add: add ODB transaction around
 add_files_to_cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The add_files_to_cache function is invoked internally by
builtin/commit.c and builtin/checkout.c for their flags that stage
modified files before doing the larger operation. These commands
can benefit from batched fsyncing.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/add.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 9bf37ceae8e..e39770e4746 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -141,7 +141,16 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.format_callback_data = &data;
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
+
+	/*
+	 * Use an ODB transaction to optimize adding multiple objects.
+	 * This function is invoked from commands other than 'add', which
+	 * may not have their own transaction active.
+	 */
+	begin_odb_transaction();
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	end_odb_transaction();
+
 	clear_pathspec(&rev.prune_data);
 	return !!data.add_errors;
 }
-- 
gitgitgadget


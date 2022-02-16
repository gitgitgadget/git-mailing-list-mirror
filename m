Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF315C433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbiBPEVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:21:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbiBPEVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:21:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE11AF3A
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so1336746wrb.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7YuP0Nx5zpadGi0XMIQi9hW1TFbpV+oEB6DRVtErdrw=;
        b=fb6E1tTJ2ij8iWK7W0laRFdzc5w4J44Z8f5V0AOc2Ki8zfarGzgMMZ8jIhpIXMidUg
         WBh8MD1oxGbwWzz+cMtav2bKXl9p0me2/mDAOxFlgKOGIoteth53znt3oFJY5GKOCeob
         OuI2ZyoIzGgMuxWv7IUtMvUk2oP6qwgN65oLGg1zj669HxhAy+8dXddAWQJAAO9EJOyQ
         v5d9mXqcmYF3Vq8rU1jdWroMjrqnPRjZeI3L9kgMfk27CpEmp34bsv+H8SDY7fOUMDuX
         rTY0TO6D8w5U/sAeKOnmfw5YUsiOAIx4KVTf6srG9/KspCar/T+Q8MYFxwc7wN0jHmkg
         1CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7YuP0Nx5zpadGi0XMIQi9hW1TFbpV+oEB6DRVtErdrw=;
        b=MK7MHcPPHNViR+FWvNQ8/OLzUeypGKiomj4wP9jpKj8T2TwWpWeXAO176PkFoJ1csn
         mELOS3waud3UCX7S3I2zMi1VPEponX9hhDU/6KPUbVutckV5BSNnPCOY7tdjSMX/GnXr
         5KNSqtdXeTcJMPfIMlwHFK12hEI/o5DLITpZbYpFANn6IMyUABOcKVZO5HDi/kfom60A
         jGNEJP2bXfX5ZiNIsm8zY95+HxeFTOiZ0OU1tBHnYJUwoFmmOJcv3bJPHYI0jlWeOFcC
         7LhTcWQZ9i8q+mi643okbbT0Xtim4cCLxZaIQdalE9y8YvfgoNbGax6U15L3DIhq7r6l
         wwSA==
X-Gm-Message-State: AOAM530YHIO0I3kS16OqnEBWZpP913bVHHHLDSOTx4wOL4iDQOSJJq6D
        HQ9OmyuQSLtKaolDwpis+AsMoO7jOwI=
X-Google-Smtp-Source: ABdhPJyNw9ErFF8ZaOBdmS7mlsu3WOM1BLTMQ5rrvgHUd+es4yT1fagYm5/W/tw1SVjBAc7EZRfpXQ==
X-Received: by 2002:adf:fdca:0:b0:1e3:eb0:f472 with SMTP id i10-20020adffdca000000b001e30eb0f472mr734883wrs.291.1644985285949;
        Tue, 15 Feb 2022 20:21:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd20sm2692504wmb.20.2022.02.15.20.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:21:25 -0800 (PST)
Message-Id: <0c2ab523e74be6f39b82c8fc9c73b4ac57f9963e.1644985283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
        <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 04:21:20 +0000
Subject: [PATCH v3 2/5] sparse-checkout: correctly set non-cone mode when
 expected
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit f2e3a218e8 ("sparse-checkout: enable `set` to initialize
sparse-checkout mode", 2021-12-14) made the `set` command able to
initialize sparse-checkout mode, but it also had to function when
sparse-checkout mode was already setup and the user just wanted to
change the sparsity paths.  So, if the user passed --cone or --no-cone,
then we should override the current setting, but if they didn't pass
either, we should use whatever the current cone mode setting is.

Unfortunately, there was a small error in the logic in that it would not
set the in-memory cone mode value (core_sparse_checkout_one) when
--no-cone was specified, but since it did set the config setting on
disk, any subsequent git invocation would correctly get non-cone mode.
As such, the error did not previously matter.  However, a subsequent
commit will add some logic that depends on core_sparse_checkout_cone
being set to the correct mode, so make sure it is set consistently with
the config values we will be writing to disk.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fcd574f5fc1..fb85a1459c3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -403,6 +403,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 		core_sparse_checkout_cone = 1;
 	} else {
 		mode = MODE_ALL_PATTERNS;
+		core_sparse_checkout_cone = 0;
 	}
 	if (record_mode && set_config(mode))
 		return 1;
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA2C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiEYPBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbiEYPBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333E9AFACE
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so3518245wms.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=V9HPbAw08ZIvkWIykZ/MJKGMTPCOfduOc+rXXAWC7bgH7G3PDtogiz+pbo886Dtsdr
         rFwAY1BcAHpoajvFo/8BDUkhpPdjKP8kFpTFBZRNePR6wJWiX2ll9rMtcg+G3FCa0/MT
         sBnG3jLtJkONFoX65bCvXvvFXwCjpfkmMyVtVJ85Z6FG3LRFFg3yq1ghRzZAwvEXJaqr
         v2yfOPZPS3OVXne4WDUwQpJNcXsv9XgcYVSyUoVGijziyzgKy7zm7AaZkIr5z2swPK37
         yUT/OR+ECHMcVrkkdrBq+Gyx0pk8zLKapijP7dvaJ8ANaMtD7MIzsohs8lpxSnKb1egI
         iOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=oCje+JmdqdolaesOUZq4p9NfgBbO2GBE2bANmZfb0b4XPtKO5GFYmorI8FfcDyurfR
         WfiXpEyZdf6+fQ7MXT5yM4UKe0C4Zbf+AFbeC0ykGAqzg6dzm5Zufpjkop+A0GT0Ta9u
         sQ9mXvJGY7eh08tc56b94T6sGZUuK1zoSQ0cTWS+m0PO9GouAT1hgVFwcf0eOZUAGx4X
         wZGwyG51X52L+PRkX7dQMJ1vJzJC8atMro48mqqZ9F5/amikmSfjneYr1iKT8sn87OmW
         DqMWhwnYMOKWHMt1eSMrZN4zDjLYMk5349mx0UrxpovPLVBlE0PE/vDVsn0NYsJy9mGm
         N1bQ==
X-Gm-Message-State: AOAM533w6TIXnSnCxH8mJIFQEJW+TrFjx96NEPr6xjlXoeODlcok7/Ds
        yHHlLxwb0QeI3zR9zS6Qw9E4CsudYvE=
X-Google-Smtp-Source: ABdhPJyPPGVDOQTt80d1jV+heUkJxx3GAAruppEf7Dj75pBrhrklRvkpevhaq0yKbZW8V0/hkfVfPg==
X-Received: by 2002:a05:600c:3b29:b0:397:4f6d:5119 with SMTP id m41-20020a05600c3b2900b003974f6d5119mr8704244wms.129.1653490873163;
        Wed, 25 May 2022 08:01:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020adfdec8000000b0020c5253d8e5sm2287917wrn.49.2022.05.25.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:12 -0700 (PDT)
Message-Id: <aaff000cecb43550e0974bfda117e1c065ab8203.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:33 +0000
Subject: [PATCH v8 11/30] unpack-trees: initialize fsmonitor_has_run_once in
 o->result
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Initialize `o->result.fsmonitor_has_run_once` based upon value
in `o->src_index->fsmonitor_has_run_once` to prevent a second
fsmonitor query during the tree traversal and possibly getting
a skewed view of the working directory.

The checkout code has already talked to the fsmonitor and the
traversal is updating the index as it traverses, so there is
no need to query the fsmonitor.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3a..888cff81f9c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1772,6 +1772,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
+	o->result.fsmonitor_has_run_once = o->src_index->fsmonitor_has_run_once;
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
-- 
gitgitgadget


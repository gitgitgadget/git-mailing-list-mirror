Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17BC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbiCHWRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350659AbiCHWQl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC405749F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j17so318712wrc.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=PpmqAXj8rAPFRs45YHRX5SR7b1knHUKXRMphy4bIx96lhWS978Ofrg9A5eDtTBaSOo
         fE5UJyvNzADGxDPYisMVKnsQx/qov+VUpzLbwhYMcdqkhkmS1HT9TeBHPsbBNH2PFH1U
         mG4pc1vOo1RbwElre2zVmjUoUz3e2ZFNYCIX8dWFCo5PEpTbyjSbKiNAHnv7xKZbGrdp
         duzkqD56+4ohmazZvQpOetUHnsP3XFG/VnNHcOKq3KIhlLE4KcYCMD4DxsdPtr1UIpY2
         FltXM2SXqBY65Ru+jqRDq7MD700PpJNpCOuASMu4hdKZPiXw87vc7sOwk9bcBGhwSQoe
         RtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=ZcNk9ZBvArcYhNbJkegCz6nrEdyAvSJuu0fFRs1J2x6vYvLgm0mKhuJl89yQpbcfRW
         mIp3V4GIqkJu4cz1xkabk4P5og+unVCzzo81vEJyp/FIsrYWXEZDZRRsVTGJeMIpsSDb
         ea2PpZplm07hYyqd19F+GyRR+oef7A1GJksbzmRAcK6koScW2CA4rnpS1I6qlm8NhxFi
         6a2k2GMoHl7YD0rV+/0FrOi0Mwy5odlAl4Up/Lkb0v7m25JFSkcecIRXQHvBCqSn7Wtz
         ulkL4d3aZpRw5efVt8eubvCoB+26ekTZOlOO67E1aVhpdyopArNOaSydhs1f8Qgh3bEE
         CMdg==
X-Gm-Message-State: AOAM531TN5+eGEPcg0I0q7AMJnttTwu7aPsEEf7gysMAzSA32KxxRFNi
        3PoDvpf/8fWNYdQfaNvRYtIJeqenLOc=
X-Google-Smtp-Source: ABdhPJzF/uar0L+ZdFrCbwCNz/3bcJIOd9LI/YCrWcQqySYiwVdFEo0UGYl7uqP2eDnDXsONsnZK5w==
X-Received: by 2002:adf:e0ce:0:b0:1ef:706d:d6b9 with SMTP id m14-20020adfe0ce000000b001ef706dd6b9mr13782564wri.71.1646777740800;
        Tue, 08 Mar 2022 14:15:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b001f04b96f9a9sm96379wrd.42.2022.03.08.14.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:40 -0800 (PST)
Message-Id: <f63de4eda3152e01c1a682d7bd002efd1e45878e.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:10 +0000
Subject: [PATCH v2 10/27] unpack-trees: initialize fsmonitor_has_run_once in
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


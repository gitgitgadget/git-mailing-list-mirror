Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F3C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349303AbiEZVtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349215AbiEZVtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E572E8B8E
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 7so528512wmz.3
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=D1qzqlsLDg4HqNOYCnoR2bRHqlf1D5gYDHfeSFKfDv6Dufw747iOG/uwrAm2BlA5zY
         olyHkYwQrUkCC/0JXI+Bz8P+YC9+eWUpp1ffmvWr4gv+19J+sjYPszYDkBaEbaJdaLJL
         E6wrfraUTnclKsYSgiAy/7LNmZSN/0zxcWSArHOb4gpqqEq7a/Z4Fr5F11A1yKu5VngO
         WXdJc9KAwWyotInRmN2b051HmkPrfr1iuzOyKLt95asX6RDjndFAdkYXgJbG2NFdmtlh
         bkqC6FXew4Yq+7EAxPzpXCeNAK6AT4EMQL+K+oQmjGtu/dIEgXsGkxJ7YcYnFBhjU0sP
         3F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=hIbuVVqSfVqbw3xUJqFiLtYnhyWhpI/8wIDibRoyeRuH/tkV4jYo4XXrPGkIAM1UFl
         Kz9mY9/qP2GVz2QirklEP+CcxjxtMJ3YEilVOK+ZBZTDa73AsC/zkhaKHoipZXhl8HmQ
         kloFMY5FtbF3orf/0lMDfA79DXEQ1DsTwBi8ooHEdpFXWUcNsGsK920Pqs0T+h5+S3Ey
         +Inmg1GhJUmjIM2XDXr60ssy1OM0ImwmXtVofkOyBpeC6T2oH7h01Ve+9ENupeV6OPIl
         qiY2EDsCsbxn2AVeq7uNj835lCvKYKvc0arvThzUXhkBCTJeL66G5ESz5RwfG28my+MY
         Y3GQ==
X-Gm-Message-State: AOAM531gvzwwKTCyCQOThneI/WEZAnhT0B5rNKd//YQuSNkuRwfnuaDy
        4gIaIogJyyjcVqGNQ2WuoX6V4kJdhCg=
X-Google-Smtp-Source: ABdhPJx6jWLHTIxyZwvA7skdRIW3ze8tPppHFmxWwUc4+SCwaypPTGHqBGssbogT+ohUJ6Y/FaiZrg==
X-Received: by 2002:a7b:c187:0:b0:397:611b:2619 with SMTP id y7-20020a7bc187000000b00397611b2619mr4112640wmi.71.1653601756542;
        Thu, 26 May 2022 14:49:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003942a244edfsm266502wmb.36.2022.05.26.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:16 -0700 (PDT)
Message-Id: <27f360b33364d997ee7e31b0b0c6704fad088616.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:05 +0000
Subject: [PATCH v9 11/30] unpack-trees: initialize fsmonitor_has_run_once in
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


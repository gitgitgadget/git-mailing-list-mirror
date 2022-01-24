Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5CC4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbiAXTid (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352026AbiAXT30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE458C029821
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w11so3315768wra.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AMPYXTx+eFm7luhlSKnYJkvbRFLbh+PvTxpJ8Mh2QOA=;
        b=oHW/bOCJgxJfcv4yY8j9a0joK9KaJeAwPyp6VFnYhK7UEALUR7UiCeUFkhTQdJLbdL
         Kfm6BoXFentZfYFGtB76C1Sxsgl7NFl5oYXGJaZk0tY+jOLTOOKV8mgIurvY4VgPyDhQ
         E8ag4crhJocWEV0e3PtJIf0o+LhBBzDxdNLRCuZ45khZ7Wh0hZp+2ZfzVmpJTc5NjePv
         5Hkg7WI91he5luh1Zd1Dr5010xmoe3RNbrZOUtH/zukbZl1X1UG4xYcvmwx+wfD/JJtQ
         29609OWMMu3wRJi3qRG4zJ2I/JiOrY/CwhOi9qhdphEqQkKZG8sG25BrAobbTnP9JfUj
         bMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AMPYXTx+eFm7luhlSKnYJkvbRFLbh+PvTxpJ8Mh2QOA=;
        b=4mcEPwm/qhqX2GLz0TD29lRBsj7oN0BvfeM2GdvXrxgRUa1bO5yxbxoGT4lhAFQtRL
         um6lbajJQ6lBXD92/7wxicgupuoHetXKqhLc+UW7ez7pLR/Na/xlC2QJfBtMDLMGdOc0
         Ue0hXP5McY+o/VBzzveWl/zZCiWsVLYrkEsF/F1xJnLKNQE16x/jfSSnjBl8VOMJCq+O
         ieTWO6BUDZdVCE3R2TrFCGGGnQC5tZeL7gwVWZYMSIkNjFeQHKJnXqFZ3361VS4a07Yl
         wrkkIDmRp8F5xHEJ162nM8BwcdnsQsgTr9IBbGKq2j2YKvLbRd6UWVWxmjrsXdpCdy8+
         SknQ==
X-Gm-Message-State: AOAM532fJDDjwVAzOhAP91fFrd8pR/1ULeQ0EtGDBV/srDaRWRZ5ew64
        1i3egwRjA4Y7TaBDWLQjhUmQqlLe3YpDBA==
X-Google-Smtp-Source: ABdhPJwgdekz6gT/R48Q6oddCqS8G3a2O3xGNWu2/IJ5HiaiG+X+ujRGmc+/9x2G8BNVm7CbEKQcKw==
X-Received: by 2002:adf:fa8a:: with SMTP id h10mr15237716wrr.372.1643051628223;
        Mon, 24 Jan 2022 11:13:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20sm216975wmq.9.2022.01.24.11.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:47 -0800 (PST)
Message-Id: <f11a996438360c209f9da2db768e2be98c4413a9.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:31 +0000
Subject: [PATCH v7 03/16] reftable: fix resource leak blocksource.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered in the unlikely event of fstat() failing on an
opened file.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/blocksource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..2605371c28d 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -134,8 +134,10 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	err = fstat(fd, &st);
-	if (err < 0)
-		return -1;
+	if (err < 0) {
+		close(fd);
+		return REFTABLE_IO_ERROR;
+	}
 
 	p = reftable_calloc(sizeof(struct file_block_source));
 	p->size = st.st_size;
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383FCC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiCVSZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiCVSZS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30428D6B0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so23630301wru.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=frAgk+GnUmXFwY7nudp4DgXTjAEOmpIoQGmvYysxzYlRMMD5kt6AJdVaYoPDyUYwVF
         Dr/fiopz/kzJwarL0rfoEhrw+9rfQYymc8dJebSNktrUB0xXsSRIUlvrWNLcydYDj6XQ
         b5ocULpCKMPSlRb8IqQE49JOIHzooIofC/O1LuDnSwscR66Mh8kPNDbnN/a+/c6GGsA2
         vHt2N6FDyDQXaFwxXh8RE5zzpRBWRoavf6fvvAs89yQfSqkOZ7q4ZFpWY4z3fkGmY26c
         iC30BA3Eee3a0sp+igkILoa/+v5+Gcl4hQR036zbWhaWbXKIV1ho0qO7GQN3mZV3rWta
         vtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=SPT3MlTCNu5i/4qhN1sG42YJgG7+6XRW+MqNoeMh9BeMh6CUVMt1TrJmlDpJOm0jsn
         pSejQDeR/n3FLRV2Th41UEyw1nWQrjNOJ4t0GQZ7JOV2dm35bRDEmPTyMaT+7Ve12dk5
         +s/4XKbD5b7a5FnJRCpphZhFP93BCI1HuYfTp1y0EtvrrGJtru1s7VbXHlYbKtAUafe/
         w/AUzma3VWg8cozNia0vlV3fEtwBDUO8T2PbVzY/ZBe9d3aB0EPmNOt3orv9CnAkP7nC
         Vcwovr5q0OHcsel907Qn9bslX2lk6FMvqCrkxt1UIk49azvG+WfGSyIcfnEf81DCqku2
         376g==
X-Gm-Message-State: AOAM532bOdfYmgDIDJP6/eZG+U8G99IP4hxaCsS5yCsGYFgGW+vn01U5
        C5/Az93O4moOIYaukJWzfLEUNRIXWJ0=
X-Google-Smtp-Source: ABdhPJz/ANozmo2eopnJLVLPp5HS59+wwF8ETgyAHtHU5xkdHnsdBglwb2NSWW/O4t8yOZu/qU060A==
X-Received: by 2002:adf:f102:0:b0:205:7d05:d250 with SMTP id r2-20020adff102000000b002057d05d250mr2750857wro.350.1647973411000;
        Tue, 22 Mar 2022 11:23:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm2254437wmb.22.2022.03.22.11.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:29 -0700 (PDT)
Message-Id: <ed1f7231309e5761aa0a434ae02458ce2b559eb2.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:44 +0000
Subject: [PATCH v3 11/27] unpack-trees: initialize fsmonitor_has_run_once in
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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


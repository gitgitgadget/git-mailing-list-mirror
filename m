Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ADAC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbiCXQxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352185AbiCXQxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3738B0A44
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7576524wmb.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=h82y3/skhxNriyyeyVaIj5zazOKB3u0QvrTG3Z2gv9GMssDZulpKwln9ZtWHdYorZN
         Ad43Plv04GHzWLJwSnqiYrkgC0767Pkj5bzEnEC8gp1LY2uYNpVpo5R7iSnVwATDFU6a
         TsbCJHQ0e6/UDMhYUvxcloFYi+JkbP1Fh/L88FGjBk0JfuwYXsOY44siwYn3qU2fkUJI
         4QtOGJXfmrCvJ831uzCTxEE+ofX49bSjmK54g4HQxt9o92njaqJEYsIpXJxTnDHSoaKb
         hc07qHFM2q0jc2aFD268yqRTjCJI/rgkhPy8wYbKH2ePqtdLOiodjP1YtOFTLObCcXDi
         G4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=aICqcRW5QuILCBQLNCQ9/SsdHBnm24T92LErzsAAaCAmRhN4gxbepUEszGmafMylHZ
         xbGSUzqTjFIUQN4HTmS0ToVXz2Yp2jfY+hanhez2osvXIt9jlWUmKWY/xI6mKhDBaSnq
         O4DanYTOxhyZC2qjJFuTy+w9fEsBAqiD5O50TEHCY4BZ3Ift24jhyTCkh+u2wzTqna9E
         HPUrKLW+783cPQW6waRRGvqeBIRiNjpwgr6nMLt3H61dR3Wt2C3Wzcjirc7YlRV4S8BP
         ep7732bkso+U3Z3ZAGdDCh8Vx9GtHU0I1X9CLwK9g7kbZ9OHvdAJyt3Rvlau+LwfNxNx
         Cx6w==
X-Gm-Message-State: AOAM532h3abQWyRyuDKcoILWkGdbbQNzUq6CIW0BqScroc9k4URjNdjP
        rmc3Q88KwVSr3wWU4df4CBcjTZ+gGoc=
X-Google-Smtp-Source: ABdhPJyy7RzZV+h4z7RVD7UmhekaRMeP6WyL/JfXYleBcnCxTdPtSdkTVCxGWLYHVjj086BXfgymMA==
X-Received: by 2002:a05:600c:1910:b0:38c:bff7:b9db with SMTP id j16-20020a05600c191000b0038cbff7b9dbmr5668343wmq.182.1648140696353;
        Thu, 24 Mar 2022 09:51:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm4082916wry.53.2022.03.24.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:35 -0700 (PDT)
Message-Id: <db5197b44bbd4ebc0c380aff481288157909120d.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:04 +0000
Subject: [PATCH v4 11/27] unpack-trees: initialize fsmonitor_has_run_once in
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


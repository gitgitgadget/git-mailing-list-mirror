Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6297F1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfA3TvL (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46818 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732941AbfA3TvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so593120edt.13
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=IY0ns77yxTV2fuqfz9IarB2CHCcMgTeWwD/NRvefdvNoiV1xtt2cfiYH/vmX95iEpR
         ct1+n+D9b4bON4jD+yg0Mw9HFzDftv3AHxsEicMW06eY9ziS2mWKjppSixWtejDb2piW
         uf6ddBmDN7xlswI5Md97ELC/sTeLlXMuo32WlJiMi+jpoE2guJ8D7jIZeLTaZ9nkxRWt
         IRhoxemOf+lRErrQK08qDInfjPBzoKvb7XHWSLRpfVktv2Lv/GxdqdWwCgK51ZlhJ2jX
         wHCA8FF+PN707UwBTptvTQQDR5HqNI4/ViU6tPaVNhF+X91guZrkKvaXEBT7Pse6+m1a
         KFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gkl/SeuuBvHNvR1dGTKxIOcbnKIgfgd1oncsXBT5oQU=;
        b=Eh4v+8sH4sI/Xk3A3MmjnzxbOBS9v2uxznp6yQDe2N+IKtMwn/9jl2uUGQNTlwKlGC
         nhAYNVqEop/KTu7kxhT2CZwGcDTxo9Zu5n/P9H3DxYMvNS9BOM7JfjEKIMuUEMcdU8YU
         9urdwSyvIGn+ONWmnULyZC2Zix4FAFm0g8svZ5V0u+sSpBG2pNm9bViwKK4FeJlQkQjj
         kjFJUgmolnUyAgVEYJUzXrKj5psxaeFKa8x/xxiwVj0rHwRxiMFY1lqyNeH/JtrXqTpD
         svh6Z1vNQemjF5u6xOgwX/mj8Ge4GrR4mN33lm52ezT3ZTFYYKx+SEqbKp+3/umG+v1s
         Ol3w==
X-Gm-Message-State: AJcUukeAcUv/XPbi1hldNS48/FIN6dSn7kvG+3px5KgfeubFExyCr3YZ
        MuX92Skt/PXzO+qT4HgbQguzHjWD
X-Google-Smtp-Source: ALg8bN7M7cUsh7479vFxRXFIXquqNb754I4lTOalYK2FA3h9u/CPt9WrHYiEHfrEAMZ9o2UDh89nug==
X-Received: by 2002:a17:906:940a:: with SMTP id q10mr27139039ejx.222.1548877868567;
        Wed, 30 Jan 2019 11:51:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay20sm471739ejb.32.2019.01.30.11.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:07 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:07 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:50:53 GMT
Message-Id: <0d59a6f2ebcb7d07b766ef00bfec3d248ca2e7da.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 04/14] trace2:data: add trace2 regions to wt-status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2_region_enter() and trace2_region_leave() calls around the
various phases of a status scan.  This gives elapsed time for each
phase in the GIT_TR2_PERF and GIT_TR2_EVENT trace target.

Also, these Trace2 calls now use s->repo rather than the_repository.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 wt-status.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0fe3bcd4cd..434636850e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -748,12 +748,23 @@ static int has_unmerged(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
+	trace2_region_enter("status", "worktrees", s->repo);
 	wt_status_collect_changes_worktree(s);
-	if (s->is_initial)
+	trace2_region_leave("status", "worktrees", s->repo);
+
+	if (s->is_initial) {
+		trace2_region_enter("status", "initial", s->repo);
 		wt_status_collect_changes_initial(s);
-	else
+		trace2_region_leave("status", "initial", s->repo);
+	} else {
+		trace2_region_enter("status", "index", s->repo);
 		wt_status_collect_changes_index(s);
+		trace2_region_leave("status", "index", s->repo);
+	}
+
+	trace2_region_enter("status", "untracked", s->repo);
 	wt_status_collect_untracked(s);
+	trace2_region_leave("status", "untracked", s->repo);
 
 	wt_status_get_state(s->repo, &s->state, s->branch && !strcmp(s->branch, "HEAD"));
 	if (s->state.merge_in_progress && !has_unmerged(s))
@@ -2291,6 +2302,13 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
+	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
+	trace2_data_intmax("status", s->repo, "count/untracked",
+			   s->untracked.nr);
+	trace2_data_intmax("status", s->repo, "count/ignored", s->ignored.nr);
+
+	trace2_region_enter("status", "print", s->repo);
+
 	switch (s->status_format) {
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(s);
@@ -2309,6 +2327,8 @@ void wt_status_print(struct wt_status *s)
 		wt_longstatus_print(s);
 		break;
 	}
+
+	trace2_region_leave("status", "print", s->repo);
 }
 
 /**
-- 
gitgitgadget


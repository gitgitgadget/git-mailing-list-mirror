Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A40E1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933111AbeGIUo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:44:56 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:49187 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGIUox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:44:53 -0400
Received: by mail-yb0-f202.google.com with SMTP id c2-v6so1250544ybl.16
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=X2zjoEnicH2bXdli0EjfqgI0Exn7Qnju2fLVq5dLeAw=;
        b=qHMxwGNbPkxDS321r16W7GPs4Y4fIAamyvf2PA4CV2+3i0XpUFxaP/plvnZ0NN2Y93
         HueJjSau1LHEKjLz1mZR2b4LU3kWidqGy1eNaFFcXOmmLr38rSQDTFrqO7MH1aL/Sgig
         pF/xdQNwOecDUIlXC/XZc4efZYTnQ9NzM2ZOLpL2QOf7Sdu+Vmof9BozbraafO2qn6K8
         tfkJKBYP4tf6iwt/hjjfJHoKyLI1WcGBtGZEnDQT1ltQD5tp253E0cjZJ4SH8P9nApDc
         w4lXXWoSoKUOGgpSvrVUxpsKaOlZNTM1AA3mBfaSUdNQ6gZzmG9bSB/LiTuLqIkSVAA/
         kJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=X2zjoEnicH2bXdli0EjfqgI0Exn7Qnju2fLVq5dLeAw=;
        b=Fnwh3zc/bCwtD1ZylPWj5llwltd9IhKX3GxYzIZFAe8xQmdr63seSre5dmeN8SN5Mi
         rgHPBgOfyou3bLkOZRku5xYbRW+89+JBgSBrF2Kn9uZtlscxECw2Rl6XnUM4VMM2bVEt
         YR559i+N+ZAsciewcquCDKSSVUiRnkJGggPpgeMGEFLsDBqgUCqgus4go4BTg1dwj64p
         9BDjVUEsgc+dohto1mJBORQURZ3v0wy4N4LBvDdNc+epmTWfq/U1jxk2Vp8Yxeo1r7C2
         miSCcsVIsgsBMAaDGwVdneDflZ5oxcOB4V5Apc7VL3YzI3tzEsAwQTJDlOxIsQ5XKQBC
         Ooiw==
X-Gm-Message-State: APt69E2GmVutNdBJKfyESNuE9D74vfx0YzrpWeJSmzVcW8rfSVQeOsAv
        MeeqYSTM8fsW3UyLE0fObFcWCn8LFNgw9yYopcVRuIL10o/wplcxxyzbT7tHBrMjmwIMFylYnwH
        Ernkq8sWH+kT0IAh6i+V5pEzcde5813L7PYzgfklFWHYMWEIQE7rkZBS92jALNi8Zlswx+KsgrK
        pG
X-Google-Smtp-Source: AAOMgpfnmm0YXl2TeraRGNhvX+3AL/ikYvfCTRRjFSY1umNdvZ34HV5UOvP9R3vWNol9nxB+fJHZ6JvVRWetvpXDjC/f
MIME-Version: 1.0
X-Received: by 2002:a81:ae61:: with SMTP id g33-v6mr7216488ywk.54.1531169093075;
 Mon, 09 Jul 2018 13:44:53 -0700 (PDT)
Date:   Mon,  9 Jul 2018 13:44:37 -0700
In-Reply-To: <cover.1531168854.git.jonathantanmy@google.com>
Message-Id: <c7849a302bafe224ca3240b4c0af546c6e6e7bd4.1531168854.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 3/6] commit-graph: add missing forward declaration
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit-graph.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.h b/commit-graph.h
index 506cb45fb1..674052bef4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,6 +5,8 @@
 #include "repository.h"
 #include "string-list.h"
 
+struct commit;
+
 char *get_commit_graph_filename(const char *obj_dir);
 
 /*
-- 
2.18.0.203.gfac676dfb9-goog


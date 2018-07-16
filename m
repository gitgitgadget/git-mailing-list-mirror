Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880861F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeGPXfZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:25 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:49321 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:25 -0400
Received: by mail-yw0-f202.google.com with SMTP id w190-v6so14017887ywg.16
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=iHbizZNcHS4JaVfk1R/4rmfJTdOIaefxalwnxaUiIaY=;
        b=nV8CfY+hiiZrhHljXdnlgaydcAT7Y9bviE0Tr3r9cJGPXc91zmOV68N6S0cot+HS88
         n9te9d4MS/J5rAnBF3apvXi+T5ohfbdrIwb8ZHnlm4tnn7bnds4TfQJsQGgkcn+bxwFK
         XHheBYyyHQf/n5JKbfIsL9IePrrJBMxawUUFplZCgT/kZzDyOvTO1o/h5etxb8IRmZiZ
         1DR17/1+zY+ji36Q37Fle+WSbudo2IjXm5hT0a4BqZCny/2CfZCSryOoY8iSPCvXmMyz
         QSvjQpcnWDfA4tUWDkthXJoH5BEBkuwV48oiPMiidx7uCoBRwrEMJvwnj5MqHFX8qyhK
         tJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=iHbizZNcHS4JaVfk1R/4rmfJTdOIaefxalwnxaUiIaY=;
        b=byz+OkebCcRA1yN7aTxrUeov3a2EPV2CmLK8KWICfE3ACJUD0Imb0edEIW8ic0eMHZ
         WCnIruOD64wV+zDMaQmeJauN4kofpl5p7WYdA2VXQbFUTT+QSE3yvuMIulXLw/+LAVJB
         kFFY+Q266S4QwR8oHib4qpIyphAA/NU4X4IgzLhMnTI7/srYDsuI4vumgnPVW2EOt4Da
         KYfVc45u0vM9BNV74Mg0MgrH6+/uDEevVePWYsfpUvtVy8OG/S9fXCwdnvqoehP2PyR7
         MZwaxQqL6DKnXJQT3F8g5zb2vQiIztrj75C1DeSX2kaLN8fQC6dqZ7ICTcBrLO1Bvi7M
         Dm+w==
X-Gm-Message-State: AOUpUlEZnr9B/JRr2jhtrbqz8kGwTSXGuURrlaz3ZpGKmrQR6n3L4So+
        t85dEd3zr6GfNNHeUrOn2Aa4esv8eR7EzP3UnAZO+i/YndSka/qwLy2YZAWS6xxag7EFkSZbOLl
        ORyfDSRjwjAuAOR/GEcnfE8rvmfo11Pgp/U2uKbxakVoJ+iFkm4PbYsKvE/Oq
X-Google-Smtp-Source: AAOMgpdoGcP00/hY36sgjw3cGrcVxYxvkmK2VOt1cNw+aAsYa9GXNcISnu166BGGF9wieZxboXq1oI3yGJNi
MIME-Version: 1.0
X-Received: by 2002:a25:b90a:: with SMTP id x10-v6mr5712912ybj.79.1531782350063;
 Mon, 16 Jul 2018 16:05:50 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:05:34 -0700
In-Reply-To: <20180716230542.81372-1-sbeller@google.com>
Message-Id: <20180716230542.81372-2-sbeller@google.com>
References: <20180716230542.81372-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 1/9] xdiff/xdiff.h: remove unused flags
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These flags were there since the beginning (3443546f6e (Use a *real*
built-in diff generator, 2006-03-24), but were never used. Remove them.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiff.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c1937a29112..2356da5f784 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -52,14 +52,6 @@ extern "C" {
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
-#define XDL_MMB_READONLY (1 << 0)
-
-#define XDL_MMF_ATOMIC (1 << 0)
-
-#define XDL_BDOP_INS 1
-#define XDL_BDOP_CPY 2
-#define XDL_BDOP_INSB 3
-
 /* merge simplification levels */
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
-- 
2.18.0.203.gfac676dfb9-goog


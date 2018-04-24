Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A773A1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeDXVDi (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41683 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDXVDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id v63so3712122pfk.8
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eHEXJIbGcUh13g5+mcFVmzwaNkL+s89iovEc2LpCMAY=;
        b=LBoeSDQdMb0A/pqSfXMuSBdLsHPa8XMd6qXqZ6Rg5jKybtAaq18Q4O1hgGOlPppbYs
         Rqb2IhPXpWNh3SEdQjE6AHNpFUeL4PjV1anI/aloJwptn/Kvj+/SuPf2e8MHjFfxifRO
         M1Eb6m7aonKjUrlJYkfJDu0IKpO+ZVDnb0Dw08i859iv+LCMGj1BeqNYHs4hgvddVLEz
         N81p5fwtPol9U5SlogUqF3WTBBJw5Djh1sOT705yA00YUEp6fGRRtdpCkz5wAvQAfaLX
         cXE4WfghEkOI7FQbfirBFazkeh+gzuPylWH/8X4BH4sowIbcD7OfefUuLU8VIm9yMcld
         UaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eHEXJIbGcUh13g5+mcFVmzwaNkL+s89iovEc2LpCMAY=;
        b=fsNJt1AAsFlphcW5jEoSjsKs0J4K5IP/yb44YhQ3AIDeYiQMwxMMjwR2mN0F9ge2A8
         EH9Bn++Lv/Vd/KbCLjz4ZfLq6l8e8LNuwG2pynMfnP4Bs1r4rNQi1eUTzUE29rsuA15W
         r9fp3XixTpGRM14KEGpi+H9Ooe5IGU+J2gTm/KcmIAztHnlsALdIhMTtLyhnk0zrbAyI
         mGp9OJTUx3jP8Q5XO+Rh8SHVtxfKTBcEh455Mr1hIn6g8VUGkiYM77BybA0cTliYlyAV
         mXqSjIRnE1F4/bLQdGjt1XVkpGdKNAb8swvWJiJz0D2I6xq9IftoWYBMF1e6CHCJiMe6
         6e1A==
X-Gm-Message-State: ALQs6tBcj3A53DCKQ19CSr7lEyBaEeWzAKDX9KF9BII3gJZQgWPaGOow
        1IYLpQr6UuEFwIIazUWKNQUAGWBXEUw=
X-Google-Smtp-Source: AIpwx49ESNeI2GXb0bS/v57lr9qG2buFVz10DpnnDJbcPW60vBFe2dN58TK/aQCLNFhtYUfSQZ7H4A==
X-Received: by 2002:a17:902:205:: with SMTP id 5-v6mr25707984plc.301.1524603814049;
        Tue, 24 Apr 2018 14:03:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v12sm23082563pgs.21.2018.04.24.14.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] xdiff/xdiff.h: remove unused flags
Date:   Tue, 24 Apr 2018 14:03:24 -0700
Message-Id: <20180424210330.87861-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These flags were there since the beginning (3443546f6e (Use a *real*
built-in diff generator, 2006-03-24), but were never used. Remove them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiff.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c1937a2911..2356da5f78 100644
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
2.17.0.441.gb46fe60e1d-goog


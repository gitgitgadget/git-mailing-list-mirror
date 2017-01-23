Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4671620A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdAWUfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:43 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34101 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWUfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:42 -0500
Received: by mail-pg0-f41.google.com with SMTP id 14so47682244pgg.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/sJRbbmVtGS2HRaOoFw7y0W5NKGXrZH7pVvwKVuqITw=;
        b=nYysEE0YPIHmmn1dk9fpNKLWUhP0g10jYqaDk3CAsMStJ0mJlRGZW1vEQrZA9P5thX
         oozx5TAIiho3nGx6UjuGDWRCE2iqdyA9mmHs2qL7gqfQ0Td37yNZnyF+5tc2dDOnupE7
         LjojuGcyvp46brsrSTnxp5RF38azVfrd1jkmsHY42qCiqdHDm5s8lLJ9uo6hrBeRGPtr
         nmSGGzTJD4UakCLHzYaYWBK4SxqpEZBH2iPipbwSbfayzutghJ6NiAj53d19pmNKVWoU
         l3vkQ0FizVt8qVlpx1DZXG0SH/RO2F0mZTGgyTPbkJTsWUHDAcWJdrm4GGDznN2K1Wq3
         mxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/sJRbbmVtGS2HRaOoFw7y0W5NKGXrZH7pVvwKVuqITw=;
        b=CMatPtJnMwrQvjw7SPav9xuRZj2++ReJ8A+e5jnVMVx3aL+gOQDJ9cSLk5LlZZGoBc
         7SL6pxLGji+kkkosi1aAexY17dqvFr4yv/sHtrFVo7NEDtjNXSXgIFDnDPJDCzQqo/GD
         TN1w30TEuRhzar+EebQyUDVj1F9oPcUpRhoekxWiCNOG8fs8BZPe05rjQ68//echgPB/
         V1dveJfy+xBmsFT/n/SdiJxugveSPPoCEN5wP9+xGIKdx/eyg5Zx07JNdxey3rmzSJuz
         tGOiyaBUa50QDk+QZ2OuFZROlJXCQxtUPWIHnhvzG36rCd1qMukcMPayu+vo4egz4hDh
         301A==
X-Gm-Message-State: AIkVDXLf1GLPfdI/EEkpsFYGO20LGYm2V8K1nUxNWl/thBkcWgxnDiQLFd1quG/05uSFg6dd
X-Received: by 10.84.196.131 with SMTP id l3mr44389931pld.150.1485203741732;
        Mon, 23 Jan 2017 12:35:41 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:40 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 03/27] attr.c: update a stale comment on "struct match_attr"
Date:   Mon, 23 Jan 2017 12:35:01 -0800
Message-Id: <20170123203525.185058-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When 82dce998 (attr: more matching optimizations from .gitignore,
2012-10-15) changed a pointer to a string "*pattern" into an
embedded "struct pattern" in struct match_attr, it forgot to update
the comment that describes the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 04d24334e..007f1a299 100644
--- a/attr.c
+++ b/attr.c
@@ -131,9 +131,8 @@ struct pattern {
  * If is_macro is true, then u.attr is a pointer to the git_attr being
  * defined.
  *
- * If is_macro is false, then u.pattern points at the filename pattern
- * to which the rule applies.  (The memory pointed to is part of the
- * memory block allocated for the match_attr instance.)
+ * If is_macro is false, then u.pat is the filename pattern to which the
+ * rule applies.
  *
  * In either case, num_attr is the number of attributes affected by
  * this rule, and state is an array listing them.  The attributes are
-- 
2.11.0.483.g087da7b7c-goog


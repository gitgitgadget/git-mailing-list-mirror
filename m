Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8DA20986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756247AbcJVXco (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:44 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36915 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756164AbcJVXci (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:38 -0400
Received: by mail-it0-f54.google.com with SMTP id m138so74575585itm.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0tv3kEo7yzKaMRO38jvBuT/O9o3QDC1Ei5awRP64DAA=;
        b=LYuQwkiE8DjngTcs4VDVkpS8daHdFY2x1Ap1Wod/A2KZexFGWzgAVnbr3HDW+TkrTN
         cDSAYV578vO14GAz/mOHO7tdNCtVDGCjVFUfylAamYtrO8YPAJ8J7cM1xhNcygxIkPr5
         6En5+lQK2BgN+T5pd/Dv7iVyfbmXYto8Q8fvHXxzBeaUMD9QdlXlc7G4qzoh8s48L3/b
         nsDBRWzI7xf8K5Ihw4DmvqH5DBJrYzzoEitAjZrmIFbInEeG4Wn8Szpr/RUuPidGlsJC
         bkOT7I+7P29TDwBe4ZpbjFUcIS4CEi0V8wq+BizLT6Hs54MZm9xm+Br2DOhNrNdNqsRN
         BtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0tv3kEo7yzKaMRO38jvBuT/O9o3QDC1Ei5awRP64DAA=;
        b=QyrD9x/jaDF6QwE4GGLajdWYaXULZPvsher4biF/4IvFLb53YfanYypcp4e5V45ftx
         3+8jgf3RkmdVMCIDg+D6YSdrYngHr3qYqsh4CvyAkMNJdeJO9fEt1Y9SV0TbttPtJ+UP
         sdilkRDnAzyrlQM+0Y9Ibqbs4+A0HFkgzeuTVNONeDgAkPOZTJGyMLr5tBuiJJbtQ1D3
         Ohy6dCBXpac/q7XcY0Q1dc+pb48y6vLXmF/4c0YY/GbjNZzIAHYpXHwWt4jdleAI6NPu
         +FA1zVUmjSMacIAoqtFBTXs7TqZzjuN49EQ4PDtpbBfxPqoBFxUULvkfJcs5M6xfnT/d
         a+aQ==
X-Gm-Message-State: ABUngveqmeE6p9Dr3x7+SA7mDjayOgO8KJ/aO4FE2C0/bS3fTU6z8toNibDxyw9vSBFuXrZj
X-Received: by 10.107.160.20 with SMTP id j20mr7312928ioe.27.1477179157495;
        Sat, 22 Oct 2016 16:32:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id w143sm1973735itc.7.2016.10.22.16.32.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/36] attr.c: update a stale comment on "struct match_attr"
Date:   Sat, 22 Oct 2016 16:31:52 -0700
Message-Id: <20161022233225.8883-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 45aec1b..4ae7801 100644
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
2.10.1.508.g6572022


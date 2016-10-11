Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A4320989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbcJKAVc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:32 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35385 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752588AbcJKAV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:28 -0400
Received: by mail-pa0-f43.google.com with SMTP id qn10so3900725pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1eACjeVeGLJIHq79YT944PDkyhcjBCl4DL66PSxilvc=;
        b=Ut4prwgpPdlKHEIqconvmISBi26LLgn8jnwkLnrT4X5RkRPSQpof8rcg6VgHtRb25d
         vm7XxFoIvabNIZKbZd887kI+lMauxLk9PXrXkygBnu8nouucNdYuL2QbM4oBhftJP4UW
         NOS9FJOych+7+0PDv54LfJ67k6aWM/Jmy93a+g+6WwCi9dYrEZLPJSpzsMqrmed+9+pF
         4w1GDmSW9Mj7nJLA2ResXzIneHhL1PYUF3t8aAkQm23fka3XM/nxJs9RmCOuqwUeEeI4
         QR2IealiO9hsLFzo0ZnCdVniqQtDshJMYIKaW9/cIcJ6fQ8cC+QwzNih5H8FkaKzQ04z
         oqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1eACjeVeGLJIHq79YT944PDkyhcjBCl4DL66PSxilvc=;
        b=FPYjLwjHnpSigITFSiOtqS/CvmXQ9+RhePg9ChZH0SoKXgXbwS1gDD4X6wQB5aeOJ7
         IDsOnz+XxiYHGe1apn4fFFVuMAr4T4oaHW07RLSD+2f87Iy99yAVgl7ihJ0L0SFEnnOS
         CdyrkGxh2i7ATaETigHA0yCitx3v71FTVofq1i0Mss8MFnLnVgeRvvEqRwOxJ6vbmvqx
         r5CZfJ5WKg9rUq8ddzZeYfxVr+UGNPLfEcQPnwRGz52YKR4HqZPJYR5+PVOOLOdHSkw4
         UWOdddDWUVUaedumG0RwRmQrpwodooWSLiVV8DCqvFRkBSxOHKPcbFPEulf4iGmypJ1k
         bmSQ==
X-Gm-Message-State: AA6/9RngqOfnaCn0KnXBKWmt4cblxCV16a2IQuIgZ/Vld0K2pejKMo0GhyvR9ORzMJFzJdVg
X-Received: by 10.67.3.74 with SMTP id bu10mr1745891pad.16.1476145287780;
        Mon, 10 Oct 2016 17:21:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id v4sm513638pfb.52.2016.10.10.17.21.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/28] attr.c: update a stale comment on "struct match_attr"
Date:   Mon, 10 Oct 2016 17:20:50 -0700
Message-Id: <20161011002115.23312-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
2.10.1.382.ga23ca1b.dirty


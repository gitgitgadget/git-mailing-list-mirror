Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D34420248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfDNVJo (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:09:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53000 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNVJo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:09:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so17958602wma.2
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AyXg/WaXZe0AwsEa77ZCeVOKDiH+WUoFZBC27dRBnw=;
        b=K9dKG4s0tLQnDDYPnecumORDag7Vr+oNAX/sKla/6J9H7pbdJe6Qk9oJPZ/mukZW2F
         cKp4p4XNoQNN0/eM68sEmJfz3qw4CMzS39y9oxDViCD95daeMUrCEMI2bv0rdAFfhim4
         YyHdNzVJzs0B3l2CEGtZQPNX/VM1UXkARSfMoZeNL6AMzqGvINwo94LWxLgk/AdFKtvm
         R6nuIplqhJ5/xm4Ucn8uhyPUdO1ac3uySEiuaCohVXKg4rjGuSeOBCJX8dGE4HXXw4zH
         N4Be5/ZY1JBEVRTi+XFxsKot1m804Gq+s1pkxUIWTzu7yAePx1LoI+6dP2cxXStDK1gj
         cZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AyXg/WaXZe0AwsEa77ZCeVOKDiH+WUoFZBC27dRBnw=;
        b=g2wY15SzqhBsIq8dm3FXqYpg8HUJoC0FvkKryJFiPRFGdUgzG/ayJcs8SCjXydbZGj
         +ZWRCGvjl/ZlEOfiQPxXhbJ1nIJTw1u9ueZE638PKDOo8nsfLZGd9Ijrb9FwONQZiU8f
         5Wh0sTFGG79HMCFrJNs+66LiABgx3oQLpc0jV8KwlBQtBQ1wi+mLBYvKdlkv55mTlEJ3
         2eVUfgJkMBajdZ8RKm0EUDvDyu5pDUb1aki/v+2/xtm0s7ZxwrnyqXDafs5stAUao1Rw
         1olvyTjSrbsZ+jpJcfZVhKWzG3h+zc3h9w9arWkgQMNrjAO+RieABgOIkz3H+pcR4PI1
         Qlyg==
X-Gm-Message-State: APjAAAWLGKQF6K8zj4ohtB5abTZQ7UFSJ7lVmP5wPNIgxkKVW7cqSaPC
        gOUbePolLKfD7q6Z2dTwGzTtcjes
X-Google-Smtp-Source: APXvYqyIaBVN56Sp22yxlj34GhfOSwF3nfHEkZnSHG72tWNqiYSgAQEHfIsrOrgKA2q5jwc0NVsPKA==
X-Received: by 2002:a1c:cfcb:: with SMTP id f194mr18585486wmg.51.1555276182586;
        Sun, 14 Apr 2019 14:09:42 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id v17sm13722022wmc.30.2019.04.14.14.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 14:09:41 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH 1/4] range-diff: fix function parameter indentation
Date:   Sun, 14 Apr 2019 22:09:30 +0100
Message-Id: <20190414210933.20875-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e1
In-Reply-To: <20190414210933.20875-1-t.gummerer@gmail.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the indentation of the function parameters for a couple of
functions, to match the style in the rest of the file.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 48b0e1b4ce..9242b8975f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -148,7 +148,7 @@ static int read_patches(const char *range, struct string_list *list)
 }
 
 static int patch_util_cmp(const void *dummy, const struct patch_util *a,
-		     const struct patch_util *b, const char *keydata)
+			  const struct patch_util *b, const char *keydata)
 {
 	return strcmp(a->diff, keydata ? keydata : b->diff);
 }
@@ -373,7 +373,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 }
 
 static void patch_diff(const char *a, const char *b,
-			      struct diff_options *diffopt)
+		       struct diff_options *diffopt)
 {
 	diff_queue(&diff_queued_diff,
 		   get_filespec("a", a), get_filespec("b", b));
-- 
2.21.0.593.g511ec345e1


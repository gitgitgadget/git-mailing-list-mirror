Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7818920986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756239AbcJVXcm (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:42 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38778 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756236AbcJVXck (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:40 -0400
Received: by mail-it0-f51.google.com with SMTP id 66so74076781itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpiBp9SCcXpBEVsbbEVKNAEBA90Cw3qrAO+0pVRwAsE=;
        b=GpCs2vyoCtn8wwtxjU7S0z+twIFNkOxOMQiQ7XQ1iOEXYK0mzIKNBAr+2dWoohwKyh
         9wjbJaL/JJ+qixw0KQMNEF7dYFwfiaux4K5xiWOm3RqFETSBnq44kmSaATEFsJiB+dw2
         Bo+uOvd7sxEHOhMpz65HK1turxPfYeFRVPmrhTLhOLLCbV9uoXFDJv72gpTFqxi+ASey
         KPwK90u+aA5A5bwDk0MlJF95pwCYx+ONpePJIhvUIr/H0SMBigDf1058og2U2iu9HwXW
         1fSCBLnDg0wVTcq0zVCnL7xSq8/5E5nTooC/97ilpVTQBEWRIt/3plTnDRrdiqfx35ES
         rJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpiBp9SCcXpBEVsbbEVKNAEBA90Cw3qrAO+0pVRwAsE=;
        b=mO52S9w/3Tq8ie/BktgF8Xc1OqkGCgRGM/DToP8weEzIUsUAS0r9YQOP/DDCizvBRU
         r7e7NlY1EaH6ZhcTI8fsTvt4F+ZrcvmzOaTKKMPMQwRV5Go5rJkzwc0QCwAFhNjp1969
         8PJVzG9vgK8vmUkGlOnSBh5Q+jThhCIm9C/6Clh5R/hjCIAvFr0i+UO1tMJM4KzxUI02
         ynxZ/4FmFXodInTEuUVFw6QO5kPjxJI26nlJYgqiH5dTmKDz0IKref8yYNPNVd0Hr/F8
         0aIKr9EXtABZ1MH323/dPIJUuy4LhyJGGHv+IzKKt9t5v6/0XtE2oz50oUbhUtiUI4QS
         SSUQ==
X-Gm-Message-State: ABUngvf/KgZibrPYYDJe7SHWXz6pcgwOEZMdMu7MwN+7rjXnBZ9pOGL+O4kgqpAUnnH3jmbc
X-Received: by 10.107.34.199 with SMTP id i190mr7345480ioi.90.1477179159389;
        Sat, 22 Oct 2016 16:32:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id e12sm4564479ioe.14.2016.10.22.16.32.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/36] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date:   Sat, 22 Oct 2016 16:31:53 -0700
Message-Id: <20161022233225.8883-5-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 4ae7801..05db667 100644
--- a/attr.c
+++ b/attr.c
@@ -183,6 +183,12 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
+		/*
+		 * As this function is always called twice, once with
+		 * e == NULL in the first pass and then e != NULL in
+		 * the second pass, no need for invalid_attr_name()
+		 * check here.
+		 */
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
-- 
2.10.1.508.g6572022


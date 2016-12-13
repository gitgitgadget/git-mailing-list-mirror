Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E099A20451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbcLMXXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:23:07 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34358 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbcLMXXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:23:07 -0500
Received: by mail-pf0-f181.google.com with SMTP id c4so340901pfb.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OywUCgha3NL18P1uqzfgv5ly/ZHD5oUbVmzG76UCYRw=;
        b=BQNONaXe8NB+c3EziPosHyFIB8ACG9CFy/61qxBZqn/1olReZ33UvbVOJIzWdoZ1xz
         21PeRfP4TBk7CcMuIdqnZeaCdW4xWN7lo7QUyexrIuMx7JCjpMyfYdOJPMDtOowCvDBB
         TGJpswN8qruvgjgY9xQveqhS3yfz7mAsXDrSekTRZH23kXrLPjs7eOVs2QxdFXK62yqy
         qA0YC98Apo6jkTRVitYEn03AR5hnQpV8U3TgLccRE8TU/Xz2z0sQC/OqZOfJL6wF4KMD
         fnNu5iJAcYHYv2Fs8e2tbDPZfPpsAXUKLeWJin/lck+GV3qocXODKGPd9QNh7yWCi1AT
         E0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OywUCgha3NL18P1uqzfgv5ly/ZHD5oUbVmzG76UCYRw=;
        b=RVVrVT4uYv1jMEoFBq5tHIcI2LXFuIPtV8k6JQGkN7xVHEXiH2Rx12y1n4//xMDylY
         hhDjbiHOSuusiulUH+h9GoGnavlVm33JcqY+VJSFeA0SYS77Q1/7BDbPk8Q6Xr8WH/5z
         8kfXHRR0vFYDJq4gLqe1KC7CpS8M6iCFyc7QzgB5T9POQ7kB8RLzo17uGxmXF34yyaBE
         qwwSAvQuZ/nQqp4ctRgF+8y2svJf40zxYITeI8oMs98QeyGCVs9ntToPbU0BK9xOS55q
         UwfPaJABQfg5fehubCjwdAtzc8b0CvAdoGLz4BTBwn5sVWk6tOIKg028dsreozZfnYnD
         9Dig==
X-Gm-Message-State: AKaTC02Ib46ylmpHy5sCmcoUJk2CELAAfsoH1d7IV1vzpVIolvTMpPulYKAbtpdC2CDLoqBR
X-Received: by 10.99.185.84 with SMTP id v20mr82148300pgo.98.1481670905297;
        Tue, 13 Dec 2016 15:15:05 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:15:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 16/16] pathspec: rename prefix_pathspec to init_pathspec_item
Date:   Tue, 13 Dec 2016 15:14:30 -0800
Message-Id: <1481670870-66754-17-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Give a more relevant name to the prefix_pathspec function as it does
more than just prefix a pathspec element.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 4ce2016..d4efcf6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -297,21 +297,11 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 }
 
 /*
- * Take an element of a pathspec and check for magic signatures.
- * Append the result to the prefix. Return the magic bitmap.
- *
- * For now, we only parse the syntax and throw out anything other than
- * "top" magic.
- *
- * NEEDSWORK: This needs to be rewritten when we start migrating
- * get_pathspec() users to use the "struct pathspec" interface.  For
- * example, a pathspec element may be marked as case-insensitive, but
- * the prefix part must always match literally, and a single stupid
- * string cannot express such a case.
+ * Perform the initialization of a pathspec_item based on a pathspec element.
  */
-static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
-				const char *prefix, int prefixlen,
-				const char *elt)
+static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
+			       const char *prefix, int prefixlen,
+			       const char *elt)
 {
 	unsigned magic = 0, element_magic = 0;
 	const char *copyfrom = elt;
@@ -329,6 +319,8 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		magic |= get_global_magic(element_magic);
 	}
 
+	item->magic = magic;
+
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
 		die("BUG: 'prefix' magic is supposed to be used at worktree's root");
@@ -401,7 +393,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	/* sanity checks, pathspec matchers assume these are sane */
 	assert(item->nowildcard_len <= item->len &&
 	       item->prefix         <= item->len);
-	return magic;
 }
 
 static int pathspec_item_cmp(const void *a_, const void *b_)
@@ -500,8 +491,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
-		item[i].magic = prefix_pathspec(item + i, flags,
-						prefix, prefixlen, entry);
+		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
 
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
-- 
2.8.0.rc3.226.g39d4020


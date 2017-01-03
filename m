Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9461FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760806AbdACTRN (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:17:13 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33498 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757444AbdACTRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:17:11 -0500
Received: by mail-pg0-f41.google.com with SMTP id g1so178573309pgn.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1DMKc491HQzh9aUgBq/amVZI9UA6MdUBT7BRq1JJBc=;
        b=mldC055/XBECYF7INbh/4QR4DnmRI+XfUKPwbQrrgjh7EUmFOp3aEcAZd01mk6s5t/
         wsd0ATWnt5S+Ka5DCqXf7Si1ALVc20bwnmE1iV5b7JJKCIISqWp8ZN8J7f0pmrAfJDTP
         N7XjArsG32FBR+rfAo2L2gTXw0OlvXOBll5kOQfZsSzzQf0tGJS6k40fcDBFdvN6FfxL
         AB2A5xs6hiLifFPNUCskPV/XCXmNKSWPEKvUoeClyhGkLowIUriA9FqstoQl6cp2x1op
         f8qfLizqEC+wR+hAag8+HpWzfHSFx2DScWWZdaFZz/GWzRMVqzZC1d7KCFIymVWvmR+r
         ZMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1DMKc491HQzh9aUgBq/amVZI9UA6MdUBT7BRq1JJBc=;
        b=hDPP+2JFCrMbkkGuB4b4krqNnIoKM73ypIAY0jgzcL63rBpflbcoSCIJBOhoga5F1q
         lcufzCNXF5NCGL0LSMyLRw7Rv8cZaE7BVRvc4mp4ivBl9V+10cY9h455YvsXaG3unoaj
         g9BXqZAfR/RFsceWZl0ejbZrrMnyOzktzjm0EEUWxco5EVmFL+ZXsIiVUc+BzUZBovng
         LUdZUD98rmNKDMbUu9jIb+fRo2PeuztdOVIJ4pJ+0OJCN0qYaEPwYLf6BhKSJ2UCrsFk
         00PRGIjXHURodOnqCFfwMLVY9pcDoctJRqmWsk6q1Dwi1jqVJx5LBDiTdP9hDN+cc9KX
         pJAg==
X-Gm-Message-State: AIkVDXLOOGo3kBKjbEV4V/cK/iyn9VRRhTVyNQBLG3In8+HwYZ3ZLj/XDKNXUJJ0ZVzend3N
X-Received: by 10.99.127.72 with SMTP id p8mr117431294pgn.183.1483469004037;
        Tue, 03 Jan 2017 10:43:24 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:22 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 16/16] pathspec: rename prefix_pathspec to init_pathspec_item
Date:   Tue,  3 Jan 2017 10:42:41 -0800
Message-Id: <20170103184241.128409-17-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
index ae9e1401f..bcf3ba039 100644
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
@@ -501,8 +492,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
-		item[i].magic = prefix_pathspec(item + i, flags,
-						prefix, prefixlen, entry);
+		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
 
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
-- 
2.11.0.390.gc69c2f50cf-goog


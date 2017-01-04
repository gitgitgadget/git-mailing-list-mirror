Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC8420754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935355AbdADSEs (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:48 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33935 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761470AbdADSEo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:44 -0500
Received: by mail-pg0-f43.google.com with SMTP id y62so177755701pgy.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N78kqVaJcl5TE3v1FVN7wEsC+gdlgHo4quyfninc9M0=;
        b=IgTmHh9ioyVFQXGEk6LpDnHkIegKaLMwZWeXbQ/shovkEc+JVkPE1X/f7nShXW95bN
         TTU1zqfz3VJoX/4Ol8PwpoIdcKrBx4tYTroya1+gjmd89GfK1OJ1cBAqGxqG8NovEYH+
         5rK6v1Y/RbDqynsFjSuZFRU8QKernffqf3RSfOy1lkSuPSdQoxjyl+/B/53W2Ck8GQQ2
         ZSR731mJGxGlkMrzGbmzFO7XMzNnTpbcrOElrw+tV/ivA5Qf/KklRJ/ALpARTZae+dYO
         Uy4Fg+JJ3DTVhtzH96c7DA/dk1I7hyFy4Mqx81UI9SE2FN0ZkAs31bUhH1FkZgqau+pz
         qYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N78kqVaJcl5TE3v1FVN7wEsC+gdlgHo4quyfninc9M0=;
        b=kSKJ83UgWSlFoqq/8BDNJvvr5+Izq75Z0+hTk8uA2pKB8SxstDJ8jtZtcHpup5CMjf
         avqiUvmGrA/AaW0gNBXTBh+Osi6jY0Tj92AJyIY7A8cFPOsga5B542EQFge9z1VMB2J9
         TFx61HKa/XlUYP11ugjCeT2tver90ngDP6vojD0TZaWHbaINcomoCjcGPI5Q16xgU376
         cdz2aQZ7oEh8eT2oPlDFRCbnuMwyfeCRKdxv6P1+ZQhllKumkjEyJ2swLiXolmjis2Z3
         t6iAhYgCemHMX/SHagaT9jYxZXg8lilZ6AV8RLUZ4kahmhcov1OtV9LeeOEs48gdZDoW
         pYOQ==
X-Gm-Message-State: AIkVDXLyfVXA+v565RBLdT+UTHyCvQnIfi9Rl0aI2h/NF+O401nKX6usyfUII1Xm47437BGp
X-Received: by 10.98.160.140 with SMTP id p12mr3546399pfl.97.1483553084016;
        Wed, 04 Jan 2017 10:04:44 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 16/16] pathspec: rename prefix_pathspec to init_pathspec_item
Date:   Wed,  4 Jan 2017 10:04:11 -0800
Message-Id: <20170104180411.150000-17-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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
index e53530e7a..ff2509ddd 100644
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


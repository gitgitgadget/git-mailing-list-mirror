Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CEA220754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935626AbdADSEs (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:04:48 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35904 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbdADSEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:43 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so83386865pfz.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9aXZOzrIuC5zhlbeEEDIqpM0SM2L/MIyi3dPetjU9Y=;
        b=imgYD8kAWVaZc5WO8XCDeNwcxJplzgFgwRHkm44GFW36r1qt/h/FR7DZepAcRZ/85d
         V4fzT+Vh9h4Y76dbrKkecyTN5kXl0zKYZW9hKIyBkwsIawvu76crhPy1/qg39RnIHNDF
         PzDi5O/L7Qdf+HdPn8Qr5BK8IIAgtZ47FvreLo2oiYBSXunAyU233JZUKG2uzpEW36Qw
         jZbKcnw9LPD87lm/hamNwt3QCPirAEN80xu+rZAxGk+mOvChjCzqxFjB3h2MC1t9RB0U
         BcIKUjxyAZQYOOOmP4QksWx+mseCZXs2HA6nhrEZ+hW9h+JxnA4UzzbcqXJqhn3bHiKP
         CijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9aXZOzrIuC5zhlbeEEDIqpM0SM2L/MIyi3dPetjU9Y=;
        b=oJim7XIarjxx6v79tiHdPXbAuWwdQTUlFARr/27DfrOj2XSJOiCAUKHGzZ+DWpqC9o
         +uV9de0gynYWtQoUNE88qVGgpws14lW87bVqi9QrX7Ph9P2LLNLW+CriibE2E0Ja3Tb8
         OsqweV3JKZG/xrXF4AwOie9yvWgQQMyV42BX8p08Y2bRYoH/wBUL7onAA7jDqD1Uz0ql
         zs8EHZRV772As/9FP2HrnmV1q7JDWqACwyuh0Btyu3EOcHZtlRDjt3m+yJ9x9ZXGdxKv
         5acu8WnipCZye2LqaO3HNaM8o3SKgjJTdLixVAqFXcZ648ESfzWIM4IQkNSy8CdR1w86
         qweA==
X-Gm-Message-State: AIkVDXJc90vKlWFW4G0mK5AR7KbWqWDssAJuyagS69JyPx6ZbeennPAV6irMxVd5zC4PQLNP
X-Received: by 10.98.14.82 with SMTP id w79mr62479472pfi.153.1483553082526;
        Wed, 04 Jan 2017 10:04:42 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:41 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 15/16] pathspec: small readability changes
Date:   Wed,  4 Jan 2017 10:04:10 -0800
Message-Id: <20170104180411.150000-16-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few small changes to improve readability.  This is done by grouping related
assignments, adding blank lines, ensuring lines are <80 characters, and
adding additional comments.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index f3a7a1d33..e53530e7a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -67,11 +67,11 @@ static struct pathspec_magic {
 	char mnemonic; /* this cannot be ':'! */
 	const char *name;
 } pathspec_magic[] = {
-	{ PATHSPEC_FROMTOP, '/', "top" },
-	{ PATHSPEC_LITERAL,   0, "literal" },
-	{ PATHSPEC_GLOB,   '\0', "glob" },
-	{ PATHSPEC_ICASE,  '\0', "icase" },
-	{ PATHSPEC_EXCLUDE, '!', "exclude" },
+	{ PATHSPEC_FROMTOP,  '/', "top" },
+	{ PATHSPEC_LITERAL, '\0', "literal" },
+	{ PATHSPEC_GLOB,    '\0', "glob" },
+	{ PATHSPEC_ICASE,   '\0', "icase" },
+	{ PATHSPEC_EXCLUDE,  '!', "exclude" },
 };
 
 static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
@@ -336,6 +336,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	if ((magic & PATHSPEC_LITERAL) && (magic & PATHSPEC_GLOB))
 		die(_("%s: 'literal' and 'glob' are incompatible"), elt);
 
+	/* Create match string which will be used for pathspec matching */
 	if (pathspec_prefix >= 0) {
 		match = xstrdup(copyfrom);
 		prefixlen = pathspec_prefix;
@@ -343,11 +344,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 		match = xstrdup(copyfrom);
 		prefixlen = 0;
 	} else {
-		match = prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom);
+		match = prefix_path_gently(prefix, prefixlen,
+					   &prefixlen, copyfrom);
 		if (!match)
 			die(_("%s: '%s' is outside repository"), elt, copyfrom);
 	}
+
 	item->match = match;
+	item->len = strlen(item->match);
+	item->prefix = prefixlen;
+
 	/*
 	 * Prefix the pathspec (keep all magic) and assign to
 	 * original. Useful for passing to another command.
@@ -364,8 +370,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	} else {
 		item->original = xstrdup(elt);
 	}
-	item->len = strlen(item->match);
-	item->prefix = prefixlen;
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
 		strip_submodule_slash_cheap(item);
@@ -373,13 +377,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
 		strip_submodule_slash_expensive(item);
 
-	if (magic & PATHSPEC_LITERAL)
+	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
-	else {
+	} else {
 		item->nowildcard_len = simple_length(item->match);
 		if (item->nowildcard_len < prefixlen)
 			item->nowildcard_len = prefixlen;
 	}
+
 	item->flags = 0;
 	if (magic & PATHSPEC_GLOB) {
 		/*
-- 
2.11.0.390.gc69c2f50cf-goog


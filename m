Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A117A20451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbcLMXVf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:21:35 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34820 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbcLMXVe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:21:34 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so319822pfk.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z7qLQYNzO36Bf14u32mRagnrMK0ule3iDn9oAX4ccmw=;
        b=FS2DZbSha5kODYwlLuLRNsrnUuywUTPX2xZ39ckt1qv/ltGYO9QCc2FYm1EOBumwCv
         PRuua2U7wp5AgYFc6DRoKuR0Fpc9Wm6oZifj1BnL2lGvuTp6FgGD9D+sS1k3V5dB46/C
         QMyhSOzfaAGBVtZ422X0CrdWVBLZN7598nTudHFfM2nCFpMhw0CJosOndOHwKWwiKiCE
         3uFREqtF4ys1cJMsg7jaP1D5EK20zF4q9OdI4FSWpsqQaK9MC6aJ+a4Aq5aa1WqrZX9N
         yWVb20D9Syin3jrz8jDlO5RNrlT0F/X0XBb3bcHD/XCqeUPZjf8i5giK8AptFk6gCo1I
         U9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z7qLQYNzO36Bf14u32mRagnrMK0ule3iDn9oAX4ccmw=;
        b=dP5epm9NekkrLSqby3ZG8uF6Zhyek+oHw2IAWfgl3tX/4hKsZNciekBtiWs5YSArWy
         w346jReGxKIxq9NDp3lwgMLEmMM1GeSZ/IIu8Z8J5AfjlgpH/znDfmMKx6qfJCeaoCig
         CA49KgWMeMWV1y8MU4IBU8KX0mLfF0wGOrPgEjIYuXb3LjNA3M2cFQ1MtwGiZ5ybyfrB
         BPtB/5vhW0V63TEHN0agUsdlglvHiyXcivN6wwfgejX5YUGd0RQWQVNZPUUr4ivUeY8N
         7HGgIuOJL/nSzzlS4/NZpiAwTYCqQ/2w0pAOXuFYRqQrnF/SMWfOJ1o4ZIBeFE/bW/sU
         w46g==
X-Gm-Message-State: AKaTC01nFdwfr/iVHnpY/L31/NdesYoowfk3gyH16sNk97oeTvujs3/a+WRMMxjy0Vc2fJHd
X-Received: by 10.84.209.161 with SMTP id y30mr203009921plh.163.1481670903472;
        Tue, 13 Dec 2016 15:15:03 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:15:02 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 15/16] pathspec: small readability changes
Date:   Tue, 13 Dec 2016 15:14:29 -0800
Message-Id: <1481670870-66754-16-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
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
index 6fd4b8e..4ce2016 100644
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
2.8.0.rc3.226.g39d4020


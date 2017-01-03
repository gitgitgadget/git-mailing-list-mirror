Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766E12092F
	for <e@80x24.org>; Tue,  3 Jan 2017 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760688AbdACSxp (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:53:45 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34149 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760673AbdACSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:53:06 -0500
Received: by mail-pf0-f172.google.com with SMTP id c4so77942598pfb.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9sgQWZS5+0VISK79TwmhTiF/vYiJtmF5aCrqUeSZEKc=;
        b=iTJ3VgevV9hoMSvcookbU/5u461oM6Sa24RlVLnWsINYEhJFldCsjd4ZotudSge/yB
         jXLaEzSoiihMUdpm3hOuc0PM7YmUSUoaSq/O/0D9Hl/RPUVSX538ZNUza26TVXLBoxb8
         NbK9NZUV64MZlsWmbPZK+UJixphuPZY/s9/LYGzPDNX9mrQofDHQSJw3CjjehHd2sMAt
         W1du7DInEytuzLIF1shqy3mqsZeohD/jlDm7WVvipjJMVw+y88hU+lFwBjp9VZzv0+vJ
         7KP/lKOZKtj2JIXcPBtnUEbO5SkbneJ1FVSz3AYCX1foQYjdjYF/jwIVzCYfOIXQASjt
         7mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9sgQWZS5+0VISK79TwmhTiF/vYiJtmF5aCrqUeSZEKc=;
        b=ahR8jDATtuhED2YI+tu91oY8CQdtDfprdGNBGiKK87dWszg49JdaFvLeSRWTsrt1ly
         KViRBL/uAfBH6VEvbKhevX3oiR9x6RLkSF8Nc9VhwrEzvbjAux3baUlidVaGtz3q2qX2
         Y0HgVM+jPAgKfc50Gcj39IH1+Q11cTGAdTKCcxdL6ZGRTJWc3TcByLMnZe1HgUqHNc/q
         dx2uMwsm1IW3TsD2BdXu7mBO3oyMSBnThAeTDrdIHpcSYJ2TQS1+90+BNc9QJLViC84G
         4v+jCei+DYscyEqo+BnUVZPqb1SQ/vK2bMvSdwfoGlEumbvFS8y+ns8z6/8iaNvxdEYy
         ng8Q==
X-Gm-Message-State: AIkVDXJSE+X1leFQTPBr26GPd5w5NML+FcBS6lOFBmckS76bAXRik/w1cFCAVi5+795Hkhw+
X-Received: by 10.84.192.1 with SMTP id b1mr137793882pld.113.1483469002233;
        Tue, 03 Jan 2017 10:43:22 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:21 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 15/16] pathspec: small readability changes
Date:   Tue,  3 Jan 2017 10:42:40 -0800
Message-Id: <20170103184241.128409-16-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
index 4a1f8ea44..ae9e1401f 100644
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1B21F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfIQQfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:39 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46733 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbfIQQfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:21 -0400
Received: by mail-pg1-f174.google.com with SMTP id a3so2277723pgm.13
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBHeQeLyrG62p0aLCic0OhOt7oYk/po87vmQDsiCBBM=;
        b=MBTgDP4rqAqjhrYi9QLvm0RYzxZ66CRmldZnTwEYF/PQJUFpa2LSXoEaShPNqfo0aY
         Fy9Zzs6204J/L2eQtvJLdM3MPHhfxIOpRwAxMF2LR14em6Yf1SGlnKVFZeWZvZSKRG+H
         IqI/CWOo6zvxNtyRdozv4jc5QPIS5r+tLIsVHexCGwW28sDCfxb1JMQNZ9wxafLlxaf6
         k6cFizBWwKy4Oeq3AtZ7pv5d3d9XJYSeox3qy6XpF5zGp1A2l3DfEvLHn8ZGp+3Tfyy0
         pC64uvyqi3XXTx5EbkSkvt+PlSbw9PP9Y9/VA6p9Ju/iBmkbYxcBnwxh+Q4sq2PjV7dt
         LrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oBHeQeLyrG62p0aLCic0OhOt7oYk/po87vmQDsiCBBM=;
        b=B1DmZVXJp5b47m2tjsICgS7wlVfWYV6q2IuTgx/qwYUU4qjLOTpZqpBUTqtiEOLMAK
         VTUj7KBRtNq9UNwvXdk0aPc8voL1c92sE6Ql5Ck4hXwXgUlm0pOtGLlvcdy0zdAh1VKC
         bCGlzbddlnxmGGjPb45DeOGqMRZYNY60FBphHHjh9fBzE15rpQfhOIMsbjRwgmWGS6uW
         2vjWoRxLGHisc6sLQqGhxNdbQD3fR7bmTpxitsgi93mBZGmnnJVqoCA6MQ2hkpK1xm78
         uVzalYRgYHBxpbhlIBxnAr0kXt5Hkb7fshk0EkrWNx++IDtUR1f1riwNJ8NELh/TB8Rm
         OAMA==
X-Gm-Message-State: APjAAAWwgIKbftZjr+F2Qp18kceb6K6QWIE7JueQGul5R69oINNM84DR
        c6bACUbx5Fxn9qMtUBE6wj8RWcNK4ec=
X-Google-Smtp-Source: APXvYqwYnIyYRWVOp1d2egEx32wHYzVnaDJ3lu3y7NQpgJ/cnHIbNU9oV7RcVdqXhVO68k33DCr6Wg==
X-Received: by 2002:a17:90a:3462:: with SMTP id o89mr5986121pjb.2.1568738120504;
        Tue, 17 Sep 2019 09:35:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:19 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 07/12] dir: add commentary explaining match_pathspec_item's return value
Date:   Tue, 17 Sep 2019 09:34:59 -0700
Message-Id: <20190917163504.14566-8-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The way match_pathspec_item() handles names and pathspecs with trailing
slash characters, in conjunction with special options like
DO_MATCH_DIRECTORY and DO_MATCH_LEADING_PATHSPEC were non-obvious, and
broken until this patch series.  Add a table in a comment explaining the
intent of how these work.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 47c0a99cb5..3b2fe1701c 100644
--- a/dir.c
+++ b/dir.c
@@ -276,16 +276,27 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 #define DO_MATCH_LEADING_PATHSPEC (1<<2)
 
 /*
- * Does 'match' match the given name?
- * A match is found if
+ * Does the given pathspec match the given name?  A match is found if
  *
- * (1) the 'match' string is leading directory of 'name', or
- * (2) the 'match' string is a wildcard and matches 'name', or
- * (3) the 'match' string is exactly the same as 'name'.
+ * (1) the pathspec string is leading directory of 'name' ("RECURSIVELY"), or
+ * (2) the pathspec string has a leading part matching 'name' ("LEADING"), or
+ * (3) the pathspec string is a wildcard and matches 'name' ("WILDCARD"), or
+ * (4) the pathspec string is exactly the same as 'name' ("EXACT").
  *
- * and the return value tells which case it was.
+ * Return value tells which case it was (1-4), or 0 when there is no match.
  *
- * It returns 0 when there is no match.
+ * It may be instructive to look at a small table of concrete examples
+ * to understand the differences between 1, 2, and 4:
+ *
+ *                              Pathspecs
+ *                |    a/b    |   a/b/    |   a/b/c
+ *          ------+-----------+-----------+------------
+ *          a/b   |  EXACT    |  EXACT[1] | LEADING[2]
+ *  Names   a/b/  | RECURSIVE |   EXACT   | LEADING[2]
+ *          a/b/c | RECURSIVE | RECURSIVE |   EXACT
+ *
+ * [1] Only if DO_MATCH_DIRECTORY is passed; otherwise, this is NOT a match.
+ * [2] Only if DO_MATCH_LEADING_PATHSPEC is passed; otherwise, not a match.
  */
 static int match_pathspec_item(const struct index_state *istate,
 			       const struct pathspec_item *item, int prefix,
@@ -353,7 +364,7 @@ static int match_pathspec_item(const struct index_state *istate,
 			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
 
-	/* Perform checks to see if "name" is a super set of the pathspec */
+	/* Perform checks to see if "name" is a leading string of the pathspec */
 	if (flags & DO_MATCH_LEADING_PATHSPEC) {
 		/* name is a literal prefix of the pathspec */
 		int offset = name[namelen-1] == '/' ? 1 : 0;
-- 
2.22.1.17.g6e632477f7.dirty


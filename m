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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6EC1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfIEPru (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45712 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfIEPrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so1619841pgm.12
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NTeyaqErXn1p0fKxVGdbOEPdFp7b7o6IUB8roMKpxo=;
        b=DQwuMQ/5VAIdeoraOYjGJrI/ermK1dTQ0ZqFLOO6mA0GTyT/r2DIdiPI/r8gerSZg4
         PV+0giplmq5z9c5t3QY18WCvq6GhPGzzG5oinoNa+ZVFUddqu+/OgfZ2bjUcpgr+Ymph
         uTS1cUegNGyefSAAWNpQHWgx9MmyMx1x13A2Ar+acSsxhebGR6QxkY64n3bN/yBwD2pO
         7G/ENz9/0VFd3U1pcQ88/RCNfTLB27Oi9SNLKl1vHO+J9hb9JY4tat8vO9zR5qovEmf0
         vf6CkRGOVompvK3o24LYxY4YBtl0HmwV4SuUXd+Kw4P5X42iKisCkPUzJsG8MHAvsn0D
         IVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NTeyaqErXn1p0fKxVGdbOEPdFp7b7o6IUB8roMKpxo=;
        b=HguR0bwoV0WHz5qOGkIAL9yFLgY+WTn3MrBWbKCuWnIf6pdA5JaPvGTxNJhaSd3lqG
         Ek722WXwOAC1eAphL5wpRT3z0qsY9imqUVVDRaUubG231FuwnHlc88DlYpgqjXtKSgvK
         lO64T0wwNNuQskeLbut54bywbZIw50yA8JLiUX3oXCqAQihjM0nZkr/nqYnbKQfgLdPe
         fBy5N13uSrAGIAb9TtPe344a7c5Mix3yVlVlGEFFV1JVSdWd2iF47tJK0WAJb23K30ku
         KBj/jFyZFN5+SGKtSr5EVGtGev7UN3m7JPKVPA+3A7MZYYOPVJSE3YTT4rHBVY7CPxxM
         udCw==
X-Gm-Message-State: APjAAAXsaT5nc377juLuvUCSUWWDnWtyve06apz/WvQh7aZsi9vFKBaO
        6gRKo5hzi1IOFlmb5dG02pEj/Eyw
X-Google-Smtp-Source: APXvYqy5RPT4W+UFl0cSB/B3ykhr6B/ZJJC9kUpoUSyaReUxWkOjgRIALrGPKlJnMNEfLb8RvTMJjA==
X-Received: by 2002:aa7:9386:: with SMTP id t6mr4764062pfe.214.1567698467958;
        Thu, 05 Sep 2019 08:47:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 07/12] dir: add commentary explaining match_pathspec_item's return value
Date:   Thu,  5 Sep 2019 08:47:30 -0700
Message-Id: <20190905154735.29784-8-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
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
2.22.1.11.g45a39ee867


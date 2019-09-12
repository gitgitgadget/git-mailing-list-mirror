Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7692F1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfILWM6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38177 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfILWMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so16838515pfe.5
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RhH5+WN9W8rQGx537TUhBIbRaNxG3235PEiKSbH2HZ8=;
        b=ouzSwwHuzS0EBdMGU0uUcw936k2cpDPWuoKDNfo7kFDfGRQfhJjuwxYtDd6JbMFArq
         I+vKunef7AVtSO/702pwwRozKQxv++L1J4pbNfazdwrxnzCEOwPoiS2Pf9qKYGFIRg8m
         dTDNRaGx428T9Z7RGtICCvF3ebHaDSE3bXAcg5B1Zg4GSMwDWZkfJn92bACu4fg9VdJ6
         Z8p7W7cOPCNDATPCDC1tFJoMOaFU5X+jQWH44reMxAt0aBXjAl0d9k3JatO11HpznE6b
         /xEC8i8j1SoU6kgnJBl0HlxbyhRS+OntWU1Ra6Et8k3B4QF+GR7n+HiEkp1+bQI2KGzB
         qaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhH5+WN9W8rQGx537TUhBIbRaNxG3235PEiKSbH2HZ8=;
        b=Ub/fCta0xtjQk8mOXXsMEu8D86hAaoood1GV/bU9leAAmHVk1Y4xv/Ue+3Q89y3MgY
         +pH2WaXKrLCU1Z7HZ6cpVXB/VnIfZ1/HKD51CT33sjmRVl3WOppiaJ19FhCv0lZ1wzIF
         c05FdU/olxQl9D5Ihd0eYucNPNOgcmnvI89ZA/EMovBq4eCMWZ3lh2rUheEEdjr5L2lM
         XRV2lCTa5HYJBxy0iMpY+KlcNgXlmhZyMsBmXdgrebiVTTrtZaAHm3lqaPpbjS2rlW/o
         qnoTi0GWue3KmInKRreMwtaPU50j/tL10D8LOUtkwN3gLBhe6Ksm2lB/Qwojo73yMgMy
         vkVw==
X-Gm-Message-State: APjAAAVOwtons/eiexlS1tBBqqiuj21BfIGrjZVv6OYJXhPjUDQCZvZ4
        R36FYt4U4qOPekB4lsE0G80rmOA716k=
X-Google-Smtp-Source: APXvYqwadkSL81QecAUTJRgioPiVRbvGaChgRPJsTQiypo+8ir0Es9uct3gwMdmE7VUeS5n5DcQ1Tw==
X-Received: by 2002:aa7:9735:: with SMTP id k21mr53305645pfg.174.1568326373538;
        Thu, 12 Sep 2019 15:12:53 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 07/12] dir: add commentary explaining match_pathspec_item's return value
Date:   Thu, 12 Sep 2019 15:12:35 -0700
Message-Id: <20190912221240.18057-8-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
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
2.23.0.173.gad11b3a635.dirty


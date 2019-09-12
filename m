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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3177F1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfILWMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34613 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfILWMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so14204194pgc.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0uEERlhSj1jQ8ltZ9A8V9jrRCUqZJji6g6VVTNzNQc=;
        b=Dtz+RKCSR1VX07P1wNXWkRxu5LNZuWbBJlPlghDgxHo5Ybc9X2O2RbEx8uqUiCTUKu
         6b4DiTwqCudFVOo71Q2N827L6yRVDhNfMYwu4kcOyK8P/ZoTxN2s97YJGIX/6FJ54eLc
         w1stBxtXis0EhO/fCDiSZef0bPqCLeT7//QSrb88FOHBGI9eOIYVe4y6gQ4Fo05ESB5s
         kRtUTshg6FBi3ho7scYab0Muq6YqZImXLr7zrLJCBmD2XPPWHRzTbLITFZiyI4N3iPh0
         jCkx9RrqMZg4YfqAOcNcmQHhblFvqVBn846wClsmQuvuVx8/FJ9gkC6zC4ciesuKIj9A
         pi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0uEERlhSj1jQ8ltZ9A8V9jrRCUqZJji6g6VVTNzNQc=;
        b=jVQhxcO+HEBF87LG1YW7ZrWUCWuCBVOmn1lnBl3Z6uSiP0ILR3fplnVoQBtHZlYS8J
         hp3QmYdGbO0wXkLQt3kvhh1sgIuml8NENY558Lf85SIkj2mDQ2QjBbgWH1lFi+TByU60
         iK9shOADTIRxvg9SIAoJfX43MVYT+qRE/WqczzR/7VdwF5uKN99uD8/zX17GXiiIJiEW
         X8IjbhjXt9N7ytzzBVwRLnTPyjtRd66fG3rczN8iiutXZxco7v82rK35BX/mhtnUOJpE
         QL8XELTrhDyqkpXB3Vp1j7qjNvJPQkC1nm7zMa2QqpjPRQVZUFHxbPjkAkHMiCD7dP4+
         qRjg==
X-Gm-Message-State: APjAAAViUfaN3H4Cq72/g2ZPZOubs6jZ6tsuYM86eLL57p86f5ln5UPg
        aDhew2ayybiGOTkH8rau5imzt4eWF4I=
X-Google-Smtp-Source: APXvYqy7J+S5tB8z1rETzGb4IpZ3ZMcRpXnR7pCvmpOWLCEu0VVYfy9Rp1KTsNerMF8QQGqz7c2J8g==
X-Received: by 2002:a62:1d93:: with SMTP id d141mr1863430pfd.127.1568326369608;
        Thu, 12 Sep 2019 15:12:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 03/12] dir: fix off-by-one error in match_pathspec_item
Date:   Thu, 12 Sep 2019 15:12:31 -0700
Message-Id: <20190912221240.18057-4-newren@gmail.com>
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

For a pathspec like 'foo/bar' comparing against a path named "foo/",
namelen will be 4, and match[namelen] will be 'b'.  The correct location
of the directory separator is namelen-1.

The reason the code worked anyway was that the following code immediately
checked whether the first matchlen characters matched (which they do) and
then bailed and return MATCHED_RECURSIVELY anyway since wildmatch doesn't
have the ability to check if "name" can be matched as a directory (or
prefix) against the pathspec.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index a9168bed96..bf1a74799e 100644
--- a/dir.c
+++ b/dir.c
@@ -356,8 +356,9 @@ static int match_pathspec_item(const struct index_state *istate,
 	/* Perform checks to see if "name" is a super set of the pathspec */
 	if (flags & DO_MATCH_SUBMODULE) {
 		/* name is a literal prefix of the pathspec */
+		int offset = name[namelen-1] == '/' ? 1 : 0;
 		if ((namelen < matchlen) &&
-		    (match[namelen] == '/') &&
+		    (match[namelen-offset] == '/') &&
 		    !ps_strncmp(item, match, name, namelen))
 			return MATCHED_RECURSIVELY;
 
-- 
2.23.0.173.gad11b3a635.dirty


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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF541F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfIQQfv (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34600 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfIQQfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so2318648pgc.1
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXPd/arPbBc8IArv2/mU6ox4RrlUoFYC4oKDBsj3tU4=;
        b=Ehbz2e4Qd/Oa379vmUkXXMfjFAQ/H1KDTziFWS5EtEO4+gdIoKce6/1v+8F0m4g3s+
         nEeaAiExMM78UBgAMjpi8VyBrwsFIM0/KGPEs+EUCX0FU4FLOfV/vsSvG9ypOuUBg/vE
         /7bfbVilMdTQrReOe14RdWWw0YnJLMLI8ljQND2zPk1pjhxtlwGmlmQ7iVllHBXOExDm
         0rQt/2S89jcqJQmYvI4jh07zzPiEqUhb7I7El9yaAbr80AXPclRFQ136KhYFt5tvpfUi
         hjJKronIgkgcotTrAtRiNWRHSL8f2lW7Lg+O7Wf9B/CLMRCGCE+FuTRPV/fuD/w7g/n4
         71+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXPd/arPbBc8IArv2/mU6ox4RrlUoFYC4oKDBsj3tU4=;
        b=Svwb9+SMmJgpjNr803KXNttIJjLdEkiPSh/vAZEsH7eXykMGO2nkns9LnYufJp9UaD
         JQh/cH+UqKlUEcZki/LaYnOkgMG7kv8tyeuhxi8X1MD/jP2q8OaoBXZqeCn11Ug8cO6C
         cwVPhs60p3OM11n/zPMDmd9rniUwtvoSvS0/olfCyQfbgNwEJkLRh4V0Rg+q6KT0sq2a
         ZreQBlgWZvWRhjrn4nLLSGLvD2f84hJhFuDnYy6S1HHSwxGfpmqohD6rkdF0Rub3+DZK
         zu83o39lGljAMMIWMM13OqZhDo97QCus8R0LTEmf0TdqwFmaSIeH/GHIyu2NmizzT5wB
         O9lg==
X-Gm-Message-State: APjAAAUCUAjh2xqdE3sqJB5S3k/ZnJLvEq/sjHNLI5gjCcU8tbiNoM4Y
        /+xYIVewAOuEemIzM5RvQeUA+8JTzC0=
X-Google-Smtp-Source: APXvYqwzy51Jv3nAFOZse1+UXh0cAUcb9/DfismVrh3lwhYR4oVoA07AoSU1evXqcO4+Q1gfFvXXBA==
X-Received: by 2002:a17:90a:dc81:: with SMTP id j1mr5792913pjv.92.1568738118211;
        Tue, 17 Sep 2019 09:35:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 05/12] dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
Date:   Tue, 17 Sep 2019 09:34:57 -0700
Message-Id: <20190917163504.14566-6-newren@gmail.com>
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

The specific checks done in match_pathspec_item for the DO_MATCH_SUBMODULE
case are useful for other cases which have nothing to do with submodules.
Rename this constant; a subsequent commit will make use of this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 76a3c3894b..b4d656192e 100644
--- a/dir.c
+++ b/dir.c
@@ -273,7 +273,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 
 #define DO_MATCH_EXCLUDE   (1<<0)
 #define DO_MATCH_DIRECTORY (1<<1)
-#define DO_MATCH_SUBMODULE (1<<2)
+#define DO_MATCH_LEADING_PATHSPEC (1<<2)
 
 /*
  * Does 'match' match the given name?
@@ -354,7 +354,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		return MATCHED_FNMATCH;
 
 	/* Perform checks to see if "name" is a super set of the pathspec */
-	if (flags & DO_MATCH_SUBMODULE) {
+	if (flags & DO_MATCH_LEADING_PATHSPEC) {
 		/* name is a literal prefix of the pathspec */
 		int offset = name[namelen-1] == '/' ? 1 : 0;
 		if ((namelen < matchlen) &&
@@ -498,7 +498,7 @@ int submodule_path_match(const struct index_state *istate,
 					strlen(submodule_name),
 					0, seen,
 					DO_MATCH_DIRECTORY |
-					DO_MATCH_SUBMODULE);
+					DO_MATCH_LEADING_PATHSPEC);
 	return matched;
 }
 
-- 
2.22.1.17.g6e632477f7.dirty


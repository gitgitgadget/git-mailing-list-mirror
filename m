Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A6B1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 11:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392057AbfIGLvM (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 07:51:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38597 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfIGLvM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 07:51:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id d10so5040054pgo.5
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ENeWcRgeyJ/C7eXCjcFdzvUAR8ofI6X3IVg3AJwgqg=;
        b=EvK+NMrjw+GjRr1DgppIynCGZciqI/3CSZennbBrMXmtX1reKCX7933L0Dzk6qEKOj
         iaAqDdv4T+Srn5zAzwljnTBScjqK1eIE0YnG1khUENAZ58UGgS0QGm0bh+GeTW9Oc5Qt
         t8JnuZeZz+P2nQP6tai9V/luGF8ScfB1/4XcP0w3Eow+U8s684u13aym+NJn0xOsbGq3
         uxMqiXn6oZart4h2dEvuF+v/Ya+66/V1fZ5tBdxmkX3aMf2gDz+7dSuY1QAa6Ps/89aq
         ER7PxyfjB/ft5Y9uJaXFBZrhiMNxGOYdlN+hQ7r5tcl/AZV07xK6zVceF5SwyTax9b5Y
         oldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ENeWcRgeyJ/C7eXCjcFdzvUAR8ofI6X3IVg3AJwgqg=;
        b=M7uS3NWAIwRy1HOjWfHKPuBSq5puH+11OMa12Xek1CoT9dz2k8Hzi9+nojLYzteyJ0
         l8/DLy8GsmhQjAY3YAFdZZ5i3/HMgcG0XGHX//j7l/1gYi9Is5AlBi2so9pNw1VoSXld
         k+kjPeksjtnUKICfyYLmZKgpdKX2Rb7xqGXe43ACTwwlFIfnD78yM4p9vnF9oVswsoMm
         TAfWIWorMm3CChf1Ubx2QkyNuEeB0AAzOSTvxldOOlOCyBxqwcePlvNj5LeLGVzKhjVu
         yHPpspHhuyC6FBJtmFvFZlhyrFiwViXsiltOU0xCdtkUdM6z/zQ1DK5jBtnCbENT0G6w
         0i2w==
X-Gm-Message-State: APjAAAVKZ/LNHiE1naKc3SDgpTf0oy0NtcZ7rIMs8yrjoASUGJyq15BK
        cVJMokYsiq9KiPHzl4eQFmE=
X-Google-Smtp-Source: APXvYqwElzp2s7haTlUS+Q452eNsCzr3L62Lix9jdM1ff0hXU2rDaC1OP+DsMDYzbvwGG1SjK9H9qg==
X-Received: by 2002:a63:c304:: with SMTP id c4mr12064164pgd.126.1567857071516;
        Sat, 07 Sep 2019 04:51:11 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.225])
        by smtp.gmail.com with ESMTPSA id a11sm18134792pfg.94.2019.09.07.04.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 04:51:10 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v4 4/6] sequencer: rename amend_author to author_to_rename
Date:   Sat,  7 Sep 2019 17:20:32 +0530
Message-Id: <20190907115034.14933-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of amend_author was to free() the malloc()'d string
obtained from get_author() while amending a commit. But we can
also use the variable to free() the author at our convenience.
Rename it to convey this meaning.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fd925f2d72..0d78abeec8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1354,7 +1354,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1375,7 +1375,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1470,7 +1470,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.21.0


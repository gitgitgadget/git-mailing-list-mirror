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
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B21F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfHLTqZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:46:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46637 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:46:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so12802993pgt.13
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mO2xbifietlJqTtCLOfbNWpD0nJR/ZodfNsz/oAo0Ow=;
        b=cZMleKrXnRQ21XTrDsDfOkbcMdj1xGq8nzvZAt/jUEgC2i7tZZinlV8c8Aky0Jic87
         DZqSfcIfYlP3tkAUU9ao7qNFcOyjwWpAlPPReAUHtgPuKADJTOvh8NxRTIP+DmgGzDbc
         NdU1gzOansE/efkM0fpi9uFrsgqdhL2fI6z2ixTD0AB7VUHFoYEunNJk5IQiBweIpiE0
         vI8sNBN+Gi5t9rFkqPuecQ+rQbZcNIxudQb4wJIA0NJwf5rp8tSTv7/G/hVu40eLWJUq
         e/bnMqWzwEFNVj21nCzZ+QXJ2N8bT9+HaglResrPcamIM3JPZSBZfEVPinJ5ojFxA3TK
         m9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mO2xbifietlJqTtCLOfbNWpD0nJR/ZodfNsz/oAo0Ow=;
        b=K9nqiK9VygKfl5IJKcgUMOma6WlVQRm1KV8bKSa3gd/ZnN27oLkxWHYYk1thT+Vj1N
         ld4Ts6Vt0ZQ3qpR2q6RktRUVGtOs6aFY2/e1wOOTCcGHZJALMCl/g6LYqCaswhQ0igKl
         M3oR1Zff+WQb1fWRFNw0C+tfXo+9vzhtkUU/JgG2ypCqKXoXqneZtMoL0aW98r2N/PI8
         paSLJ1H7nOTqll5XkeAtYieVwtN87RTVLmKPWiqgON+94ipzYWlZCVdlb2SZdPYU4yXD
         9xXVexLnT3aIEPfmzU9+4qWYGL8BaGdSjLkw9NxBKD4K8SVP2ga+k1bNubNoHkvxhIrV
         DOnQ==
X-Gm-Message-State: APjAAAUraAO/tz33rqJJ5yg4q90Pg54H5wjKF55TknjGvRLlFYCE7GVJ
        ypLTAA/PkvkGLIxG8lV5mqQ=
X-Google-Smtp-Source: APXvYqzg47kzvrbs6fmm/xfag1YnOURFCYmnQUNrhVSBYefb3hUQ8hOOOdmUvRe6O+7yOgzgFiy+ZQ==
X-Received: by 2002:a62:1715:: with SMTP id 21mr11899597pfx.134.1565639184061;
        Mon, 12 Aug 2019 12:46:24 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id j187sm13275947pfg.178.2019.08.12.12.46.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:46:23 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 4/6] sequencer: rename amend_author to author_to_rename
Date:   Tue, 13 Aug 2019 01:12:58 +0530
Message-Id: <20190812194301.5655-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
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
index fbc0ed0cad..e186136ccc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1424,7 +1424,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1445,7 +1445,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1534,7 +1534,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.21.0


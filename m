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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7DB1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfHFRkI (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:40:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34460 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbfHFRkG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:40:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so35741981pgc.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPw9CDSGJPf0hc1a9Z0rhBE8x3WWxA5vXNagatfSjtA=;
        b=MyL+KFwgINNCl5C7Y2AYz4xlcDIE+Oy2hnl8X5ywa2pzuXes+uaNAdceFVvKgOILaZ
         EVlu1ElAY1/LhBdoAiV0f8BCHOgfdi4WRVp89LCFtlQ2Pn3Qo8L7RFMSAlXjvrWKTUVj
         /CwK3Iv8oRPrAbwjBs36pjAp2PDMhQhkOvhjrvEKx3yKkpGcJmlmB5PKNJvQShcjeopE
         fmV/ds/kZi+YrBL4aLvkzjq84bAIYRMPA09YZ1uIHQT3mTPjhDWz53xmpEU8sv0IuBzD
         PQtCp7IQ2kJVbgrj5STfCCzVJLQjKrfrXtjFIkKcqC/CBskxRpiQyL303z+OnBhcCGz+
         TOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPw9CDSGJPf0hc1a9Z0rhBE8x3WWxA5vXNagatfSjtA=;
        b=mWjYOFpiUooPXhdPqi8d2QLeUXJvQk+24TWwV/Av1ty4wpSqLQE3p8K8w2/XLmuyC6
         35TdMUJQcNycshdubLWvLW6kCmvY/Xy551ed3EdiupXxt6/FOFbzNNNo0h4DLDYDfthL
         YtmQDnDE8Wnba8SDN/fIxmJLzbLrrFEgUwXWPqXTbUq1lJrDFUVldFBMyfGKqD0t5bZ2
         Uup5/VNVu1v4peeh7oZZ9KjxC0QNk7CPzCNsBZqOYQcRJ9zNAwz4sfHAdPDm0SxrIIO3
         Pykl4Bo+LSxrX2M8CEHSpNqRQ/H7FAGjZq2FLe3rW4roauMlFbXqhlRA/FH///rdeubp
         U3kg==
X-Gm-Message-State: APjAAAVgR+Et11FnDWSP4wtaXOmo5Lqv3PToLv8Mk6E4XJl7lCFmWVTX
        vJTdP+aeGZr2whQ3QWTUUWQ=
X-Google-Smtp-Source: APXvYqzCgobXSbXVYiVL82/3jsdfftsK6QVzcPFitQx9XDduyUAWgOtzuItJCRuX5R4RyaXVtI4IYw==
X-Received: by 2002:a63:714a:: with SMTP id b10mr4196038pgn.25.1565113205840;
        Tue, 06 Aug 2019 10:40:05 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id z20sm139757104pfk.72.2019.08.06.10.40.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:40:05 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCHl 4/6] sequencer: rename amend_author to author_to_rename
Date:   Tue,  6 Aug 2019 23:06:36 +0530
Message-Id: <20190806173638.17510-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of amend_author was to free() the malloc()'d string
obtained from get_author(). But the name does not actually convey
this purpose. Rename it to something meaningful.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65adf79222..d24a6fd585 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1417,7 +1417,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1441,7 +1441,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1526,7 +1526,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.21.0


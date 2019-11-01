Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB901F454
	for <e@80x24.org>; Fri,  1 Nov 2019 14:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfKAOB2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 10:01:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33922 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfKAOB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 10:01:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id x195so3666311pfd.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/TAxabC2d0nANaBWmKtiOPmFhIwLikHZtKrvhnWodc=;
        b=cUqUUVxl3Wen0wT6LQOJHp69mbJl3X2Gg/8wiG8qRboSSSEKcfmqvRifcK4AE/f8CX
         FxeHLzg5CjLjyAtoW07W8Z1UxOOQ2K3e4usvNkFSCQW3pvNVx4N64Yhmigj5Tikus9dm
         nsZnqnlh66fsXmvvmWjCjeDWwRcqDELR8RguuTqCx0s2BrkLYUuXAx/8R6+hHr27z7qQ
         JlESiiU54XMZbwo1scPQg50FrMOu+DlBg8O7RDT5zkhE+q9Hn7cdkqe0XJsuIXxZl06A
         XYK4IUbWgzEYueTrOYU7Wq4gjlUnVjh0/TVbJB9eU+ev71QSnbAD4IIyA3vGsz7U3ZE6
         2j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/TAxabC2d0nANaBWmKtiOPmFhIwLikHZtKrvhnWodc=;
        b=q9X/WnBF8PX3BW2vKsXuSbeoTqcomr9lY8sczQ3BYbQLS14010TOqKv6b9nTrclP11
         xzJGW4apMldQ05o5Sv/6N00ezxAgk8bMoJGhWwwIZeZJC5n68bJ2rgitkEcqEN2hG0P4
         Z06XgUHHfm41YQ7Zi2eNRZMwnd3+8pS1+CUR5aBzDdQCqNYR6P6/V7Os9TM4vWKgRCyl
         D+R7SqHN1qshdlyZafucDiuseq5mUGzyVqZcmhzfHdr4jbnx8R0X6whm4bsgPBCBhLsx
         DuN7n5PB+pSEGila1poR57E1OVa6+wTCHjIf+jSQZ4xIx7qGyymOrtu0c0wPxPVS7sYH
         ebtw==
X-Gm-Message-State: APjAAAVa9Ru5avh+aRYqC2Iuejq9HL/uDw7JOV/wj2W8OnlpPpwtv0C8
        25Oe7Vy+GnKF1Y1n9XD/xYsPh3iDipE=
X-Google-Smtp-Source: APXvYqwr/JS3IOvuLif9+xQ+EDdreQ4ixhc3DytVlWuBskIXjH4U7TPJ+oBMhw8AcuMh0AkL9N0tlA==
X-Received: by 2002:a63:5d12:: with SMTP id r18mr13435808pgb.149.1572616887464;
        Fri, 01 Nov 2019 07:01:27 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.214])
        by smtp.gmail.com with ESMTPSA id z4sm7806816pjt.20.2019.11.01.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:01:26 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v5 4/6] sequencer: rename amend_author to author_to_rename
Date:   Fri,  1 Nov 2019 19:30:01 +0530
Message-Id: <20191101140003.13960-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
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
index e2c324b3a6..34e45246f7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1353,7 +1353,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1374,7 +1374,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1473,7 +1473,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.21.0


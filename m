Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC21D1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 02:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfI0CUB (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 22:20:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38383 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfI0CUA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 22:20:00 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so12233454iom.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 19:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oRwHnVCd3gl4lDg4MXfjyn173UW/2bQZvoHi1tjNzjA=;
        b=gD9sTdDkf3RgcSOZBLZsRlRhtSh8n3j2dRAYK19eY94WFlndqDM0TdbrJi6NmgrlNO
         t6fYMhZVu02It0PFGTgFu66cmgWlgefNvjwXdSHgUEFQTo7bNpcZOc91gArG46eRY+UN
         iM05EeJnmMT/qzeFu24eHALArLEExZYlcWqT58mGwoJK6E9INg9g8lsrWQpsuir9s3Ee
         k2cxKlZvn5Pe8baxN2Y4BB70qGSUmghSP72CMud6bpN3WcFESHwdxvjiGmPVHXB4NGEy
         szTh4t3Am8D3dSgBMWrTiTYRQxcvu/r3fRJgZk3C37X+yRn/N5crZQqqg397aV9eIMRt
         gdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oRwHnVCd3gl4lDg4MXfjyn173UW/2bQZvoHi1tjNzjA=;
        b=gQQOA0OqiPYNw7P4qVoSH+89BQvHtk5JKqhBLb3gvp60mNi6pbnNKZQgYkHgK58/M/
         YcVW6DXmJHoklOWWeWoWHFJX9uZzuL855tYBd+P1tqKxYzxd13LblaiMRR9XTKcb8CO0
         rS+pw1lMtZMYuWgXiW/iNJEro9fAQ1cIkJEGILA28dzvLKwMIn5R/Bf9pUHOAXmikoU8
         c7F/QMvoy52/ID30TXOhMZCS0fjedEi/zQGtLFnGlTt4ZxFuAqzmliGaYuTRf+vCNhbI
         8rfJajX7wQqTf3Q6MSQR6QxLDjcpb+Mnyxupek6C+MUSZVsIe1FbYzUF9O90LkXD/UJh
         0wjw==
X-Gm-Message-State: APjAAAVq1xQNmJBllpb8TNSmM3BD4nMMCuYXgmhOrCEViUNk/rSVjnYY
        C10zoz9vNIfEjruef79/CBAQOsII7Q0=
X-Google-Smtp-Source: APXvYqze/jjB49w/rre/S9LOsGf8hQw4LO8FhEahL1Bfz23hGB+H94TQJ/LRZCGrhPL0lU8v+sjy0g==
X-Received: by 2002:a6b:251:: with SMTP id 78mr6545848ioc.23.1569550799522;
        Thu, 26 Sep 2019 19:19:59 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id 28sm660312ilq.61.2019.09.26.19.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 19:19:58 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, stolee@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] commit-graph: remove a duplicate assignment
Date:   Thu, 26 Sep 2019 20:19:52 -0600
Message-Id: <20190927021952.364646-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b02d2c426..d0e1f9e1f2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1522,7 +1522,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 {
-	struct commit_graph *g = ctx->r->objects->commit_graph;
+	struct commit_graph *g;
 	uint32_t num_commits = ctx->commits.nr;
 	uint32_t i;
 
-- 
2.23.0


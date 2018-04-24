Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CF31F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755736AbeDXFOI (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:14:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41242 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbeDXFOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:14:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id g21-v6so19433094wrb.8
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x66xr+SNDatau9uQeDPg4JSytnjZGrZSmxT8t4YbmfE=;
        b=laD2MZx6z1PWyYNV0ICP4Bq/dPPFNxrz84+f7VCaI6snW5h6BM7xGuwsetiolMtZzr
         ugzM66vLvg8BhPeZaSgP4x9id/k16IL6wlb/mKQpZHLUG9FH8FfJkUCEObew+Tah1O7M
         cOQyGbSvsC+NasR5To9WSGzo6xnqJqi/pOTkfZqRH6C07j/h8ES4+DeZ5N/kSmGMj0Ef
         Eb0KXbWSA7gvXcegrVc7X2NDE08c6AT0QiqyX4r8T6Aas6LifSgPLXWQ4Z3MBdfeK2Ot
         ZmA8a2d5QHlD8LTtk4T/tKm5WTmtC21131W3udstfyrGcVtJsTmmx4xSBGtEfpKZgyHs
         mKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x66xr+SNDatau9uQeDPg4JSytnjZGrZSmxT8t4YbmfE=;
        b=d6Cj3KihwlGgXyKMJwyNHg4UOWdFlf//tQpn2g87pB5U5xPVIW6OJGL+F97Yf3dejE
         fhYzsFfdCPi1BgOcxSLIXyRuyR3shFWsBbxJKW2Zv0Q1uNPYjZ0bgGsxXM6zsIKULEYt
         T8OlLoZ+8kphfnI20xsFHCve5RKqkwpMA9PsMVHmp0b7jGg+Io1+XWlFI9fggZ2+Q9bv
         e2OBEJXzUqPTD1oK9qJ7J9l4MvQNnxUoL52R1Lf0+W1Miw6V+Om+3SJ4lIG23QwRGs9X
         NkEKCUjI3AetN/9Ks1fgHDmstfVkIxl+gIltIQZmnXCwmlCp4WeOxVx9aTLtbZORL7lS
         2WSg==
X-Gm-Message-State: ALQs6tD/rSdhabYv3kAawiAKcYbXoeW8qG40/PNtX4v5V5518pCb79g3
        77ilK57MsI6bo0nqjzXTjp8=
X-Google-Smtp-Source: AIpwx4/o5350CUcKz2X3VAz5/j5U+LpqbaVcX07x4fkM1mAbGxR5HhDddcLCf3ljOQGLJ43lDFdUAA==
X-Received: by 2002:adf:86ed:: with SMTP id 42-v6mr20062949wry.158.1524546846091;
        Mon, 23 Apr 2018 22:14:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q138sm13091233wmd.1.2018.04.23.22.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Apr 2018 22:14:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/2] merge: setup `opts` later in `checkout_fast_forward()`
Date:   Tue, 24 Apr 2018 07:13:38 +0200
Message-Id: <f140d2795b9dce8b805cd2ebaf076742978ab8ae.1524545557.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524545557.git.martin.agren@gmail.com>
References: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net> <cover.1524545557.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we initialize the various fields in `opts` but before we actually
use them, we might return early. Move the initialization further down,
to immediately before we use `opts`.

This limits the scope of `opts` and will help a subsequent commit fix a
memory leak without having to worry about those early returns.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/merge.c b/merge.c
index f06a4773d4..f123658e58 100644
--- a/merge.c
+++ b/merge.c
@@ -94,8 +94,24 @@ int checkout_fast_forward(const struct object_id *head,
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
-	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
+
+	trees[nr_trees] = parse_tree_indirect(head);
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
+		return -1;
+	}
+	trees[nr_trees] = parse_tree_indirect(remote);
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
+		return -1;
+	}
+	for (i = 0; i < nr_trees; i++) {
+		parse_tree(trees[i]);
+		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+	}
+
+	memset(&opts, 0, sizeof(opts));
 	if (overwrite_ignore) {
 		memset(&dir, 0, sizeof(dir));
 		dir.flags |= DIR_SHOW_IGNORED;
@@ -112,20 +128,6 @@ int checkout_fast_forward(const struct object_id *head,
 	opts.fn = twoway_merge;
 	setup_unpack_trees_porcelain(&opts, "merge");
 
-	trees[nr_trees] = parse_tree_indirect(head);
-	if (!trees[nr_trees++]) {
-		rollback_lock_file(&lock_file);
-		return -1;
-	}
-	trees[nr_trees] = parse_tree_indirect(remote);
-	if (!trees[nr_trees++]) {
-		rollback_lock_file(&lock_file);
-		return -1;
-	}
-	for (i = 0; i < nr_trees; i++) {
-		parse_tree(trees[i]);
-		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
-	}
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
 		return -1;
-- 
2.17.0


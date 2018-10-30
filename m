Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BE01F453
	for <e@80x24.org>; Tue, 30 Oct 2018 06:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeJ3PQc (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 11:16:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45441 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeJ3PQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 11:16:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id s3-v6so5096908pga.12
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lejabh9rB+jIuzlFNVY23h1SM9s9+5s6VErpr+5zUKQ=;
        b=OprEOouvsSShSCuSXzU3hwphuXHwP7i7VJxxrARuqzKWuUXg2ZjmEsCCEyatNcb/K6
         VA0piAdSbUG609lgvcePsMiznWsylFGOovSoc4wqu5AYWzrjty2EhOnBjycw81QdCCqO
         air0CkQuLaR7wBiDzO2201lD+Cdus5a72IuwrEfk6AxPhjGhygsJqJ6fnE9H/oM+vlwB
         Eo8Jwr4I6B2tQITd/fWqaJ/6MmzAQQz91ngABm1Y8XcoDjcBVK9cLmnzOfuFikHwToTf
         EdbMVZvFlFCe+4WG0dVe3pE68GRKf5ijVR/N4gkFra3/H+0I0ZDwC28KNnH53Hj+tZK2
         lczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lejabh9rB+jIuzlFNVY23h1SM9s9+5s6VErpr+5zUKQ=;
        b=DqSq8JhkkgvfeKHJQGgO0p7sYJNMpJdjcQ1TOa+xwVEYfTU8zCAnXu6wmyR0gpjsk2
         fqWzaAZA6e0X4wOb1/ciDijU3dLnZFRpx6m5QJoz/BT+6vJyNFE7l1eOwSByoJpzvFsD
         wtD9BvVGhANSxJbT2S763zewMlkcY9oCiEpCPLAQ7FpipBxAR3I1g7rKOMtfpmgDP3rx
         IK1rL8AaKk6dKNH8m8xLacI7P47ljUNwYnAEofjp5618jqzpTwXehfQ4+NruqjRj6VxW
         0mZ04yjB3VYcRprvigmn2KpFv81PqR/mkIKZvLoR4//GT78qEv8AcQK+CgVccfBMA7du
         i+wA==
X-Gm-Message-State: AGRZ1gLdM4HmNhF87JicAkEBRO2eHAwU4AC7BYJ5b8k3FZHI6Tw6gj9D
        OWjLEu+GzrccaR3BOPFmYt/3hjf3
X-Google-Smtp-Source: AJdET5cS40kysamVyNv8GPTa3qgjoHA0Cb66hVb5FG0CCkRfiJmLmwfQfQg3cMAbG3k6zNMIVEObAg==
X-Received: by 2002:a63:1342:: with SMTP id 2-v6mr16570573pgt.19.1540880662949;
        Mon, 29 Oct 2018 23:24:22 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-200-74.socal.res.rr.com. [23.241.200.74])
        by smtp.gmail.com with ESMTPSA id m1-v6sm24817085pgl.33.2018.10.29.23.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 23:24:22 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org, sunshine@sunshineco.com
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v3 1/2] worktree: update documentation for lock_reason and lock_reason_valid
Date:   Mon, 29 Oct 2018 23:24:08 -0700
Message-Id: <20181030062409.42169-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181025055142.38077-1-nbelakovski@gmail.com>
References: <20181025055142.38077-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Clarify that these fields are to be considered implementation details
and direct the reader to use the is_worktree_locked function to retrieve
said information.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 worktree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/worktree.h b/worktree.h
index df3fc30f7..6b12a3cf6 100644
--- a/worktree.h
+++ b/worktree.h
@@ -10,12 +10,12 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
-	char *lock_reason;	/* internal use */
+	char *lock_reason;	/* private - use is_worktree_locked */
 	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
 	int is_current;
-	int lock_reason_valid;
+	int lock_reason_valid; /* private */
 };
 
 /* Functions for acting on the information about worktrees. */
-- 
2.14.2


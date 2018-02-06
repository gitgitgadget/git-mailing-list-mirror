Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4893E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBFA2J (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:28:09 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39385 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbeBFA2H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:28:07 -0500
Received: by mail-pl0-f65.google.com with SMTP id o13so134088pli.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JzeoKJMZ9lQDz5RLoaZ5Yqr2mg80u3/o164ViglvgcA=;
        b=h9yPh9mlAbJB1YQDa4n5oHwWq3ezfIi+hu3BMYHC6rmU2kIlR8FHrlH+g1niq0i96W
         dDuvKgN5zrYeb7gbaFUmhyKDF+PtCp1/lLqDuTxB2075LZmOnyVqKxkLkZVkUFrDxYVp
         cx7afMlhrZLINk/0wgj7zglrAsOuj1WZnmOVm+3Qjr2VQFNxZWlNhpqyr3dpRU/BM7gR
         hjLQaW+8szR9zOMHOCa5/W7/HkuqmvkNm7iyI82Tz4sbhAnBfNUHosy7xUrf5GgVCq/N
         N4fhQi6PxHJ8Qk0IJFbIzuybuCBtpxAaOXhOwlJYAccPf/hmYzv2n+J23e0TVogw1L07
         ENng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzeoKJMZ9lQDz5RLoaZ5Yqr2mg80u3/o164ViglvgcA=;
        b=HdboH3Q75s26sOHkoK3qhTzP3aICvB8w7XxF1SU1+Ag5f8IS+iIN1oCYmktDdXGytX
         P3BBn+6BPxTbyvvhBUZKpi75sNDEDMJb7MwEX/8McJseBDWUiIYNWyWLOzX9MIjEr0aY
         Hr3+fJiYssFytL6dPQ1h/J2nbkOGrLF6CQDzB6IkRcaWp2nX0wlFuSiJez2Cy0VbmwlL
         TGY5RdFXgpgrGP2iEKUkpWuSwQxbyofb8C8o9GZHSO20jwNBySJcli7Nf0tGYcoQKRX7
         8TXYBk3/4ZQ1CXwllWsmfeMdRs0w2iL/zL+qBP6qbOoFIEgfvkDXRcJFxIX0HCqnOrqz
         WAZA==
X-Gm-Message-State: APf1xPBOXQAr3lGUtTW9HJ9v1FVmpSE1UeH66Xg7JSllGf6MS3dvFwVC
        8i8Rq/x72kTVaWgwCtx3j6iE+Z5KkUc=
X-Google-Smtp-Source: AH8x227fbkbpdOwbmQ3PfpIwSE3PvoaHdAr43AVVnlnkn5p8D+wt0Be2FQ6EEIQw1fffiWmfLdrEKw==
X-Received: by 2002:a17:902:4283:: with SMTP id h3-v6mr559890pld.175.1517876886352;
        Mon, 05 Feb 2018 16:28:06 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z10sm14585720pgs.17.2018.02.05.16.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:28:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 163/194] commit: add repository argument to merge_bases_many
Date:   Mon,  5 Feb 2018 16:17:18 -0800
Message-Id: <20180206001749.218943-65-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index a4f35cd9fc..ed7349bbd7 100644
--- a/commit.c
+++ b/commit.c
@@ -854,7 +854,8 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 	return result;
 }
 
-static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+#define merge_bases_many(r, o, n, t) merge_bases_many_##r(o, n, t)
+static struct commit_list *merge_bases_many_the_repository(struct commit *one, int n, struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -980,7 +981,7 @@ static struct commit_list *get_merge_bases_many_0_the_repository(struct commit *
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(one, n, twos);
+	result = merge_bases_many(the_repository, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
-- 
2.15.1.433.g936d1b9894.dirty


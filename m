Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E391F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeA2WkF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:40:05 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:53550 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbeA2WiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:17 -0500
Received: by mail-oi0-f74.google.com with SMTP id 24so408431oir.20
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HbPvmS+GugQ6/aSZPYq5/KCrJiRywF+JhnuD+Gb/CYU=;
        b=rw9Xx36QsKjC91eej1WZmYlHjq1S3TCUZQf6BWpvfpdlAkf9QuZbrsRSVFZCu7zPlN
         FKrW5YfjJfx29Q0f7Db8kjnp7dG3M744mqnfH5qPv36NPjtv0XyAezblMns5jp5TIknG
         5Da1E1fGSmo0xLpQxs0q6HqnOqqWGkZAonKOjLnHEUDpN+qNv0NNhNA2rYXMM/mGvq/G
         /t6Ljetm1J9ZCS0JQyWhmIQbyyu5lBJcaPNnw8kuAIoPDSLOLv4j0NvJKiCiAB0Nwn0q
         UGDhQotJzibOrRb71zr+YAvRz8EEmxLYjEQGWuilvklv9Es/Y3g2b0SE3kRgKz3bhIBS
         NwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HbPvmS+GugQ6/aSZPYq5/KCrJiRywF+JhnuD+Gb/CYU=;
        b=KkbU05fXph0oXJ9gmEZVUTVto31jsExI/4gdWC7suukV3k716SEZgh4dG/xUhQT3mt
         lZF0ywZHM+40C3vAmYu1ob/MpiKDJZEjPZDHAQ64oIy7PfwDXTXoCDpaVMvzv2tQCOYp
         HvtOpDGYqEb0rZN71N3lbxMtQ+oGBN6vUWxofI1TNTO9xzZCOESQJoh4bua9d0hXPc8g
         mLDfPE3EtZxW9F1SLICEkmvFEofzCNWKna/UwCcvcRCW+i+bwmmuf6kCRps1fwQbynwN
         ds1stOTXvKu9vhxEgXlEALlo7p8lvYkwPw9LV7qmYUx3mRjlbtgZ3SYi1Adp0B7J51jt
         qm/w==
X-Gm-Message-State: AKwxytcl+7bZdaXOWAcgDB3juzx/sdBieFK6Lr3oz6zhT65Tq0DVA/ZG
        pxTs6xHr3PvVgfG/Dml2lKVUlMrdHGL359x+8Yb6azbh3q+PTLxPMtjQYbzyg8zA6dbakx5/mbQ
        qCkFFIqr9kq3WkXsE+kPGmEi7LEHuxq8I/GOYHnSiDXOqJ7SiLw4EdF+O4g==
X-Google-Smtp-Source: AH8x224X5YdjN9n6E2757Tvk/sy4c7R1kd4i7SQpXAUO0iLuZiYhf70viJpUbxRF8QiKj7NA51QrUpad3VQ=
MIME-Version: 1.0
X-Received: by 10.157.61.245 with SMTP id l108mr17039730otc.38.1517265496257;
 Mon, 29 Jan 2018 14:38:16 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:06 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-16-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 15/37] commit: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 commit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/commit.c b/commit.c
index cd9ace105..874b6e510 100644
--- a/commit.c
+++ b/commit.c
@@ -861,19 +861,19 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	commit_list_insert(in->item, &ret);
 
 	for (i = in->next; i; i = i->next) {
-		struct commit_list *new = NULL, *end = NULL;
+		struct commit_list *new_commits = NULL, *end = NULL;
 
 		for (j = ret; j; j = j->next) {
 			struct commit_list *bases;
 			bases = get_merge_bases(i->item, j->item);
-			if (!new)
-				new = bases;
+			if (!new_commits)
+				new_commits = bases;
 			else
 				end->next = bases;
 			for (k = bases; k; k = k->next)
 				end = k;
 		}
-		ret = new;
+		ret = new_commits;
 	}
 	return ret;
 }
@@ -1617,11 +1617,11 @@ struct commit *get_merge_parent(const char *name)
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next)
 {
-	struct commit_list *new = xmalloc(sizeof(struct commit_list));
-	new->item = commit;
-	*next = new;
-	new->next = NULL;
-	return &new->next;
+	struct commit_list *new_commit = xmalloc(sizeof(struct commit_list));
+	new_commit->item = commit;
+	*next = new_commit;
+	new_commit->next = NULL;
+	return &new_commit->next;
 }
 
 const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
-- 
2.16.0.rc1.238.g530d649a79-goog


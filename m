Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3621F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162537AbeBNTB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:26 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:39217 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162515AbeBNTBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:23 -0500
Received: by mail-vk0-f74.google.com with SMTP id p2so13521694vke.6
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=eNAk7xwef+uDY4x9+c84lcLUtu9T/RFFSSBX+LZWdV0=;
        b=N1dzzc8Yk1Im2cPMH3IydjYj8BGVZAahoCQgYV/aqR5JOAGVIi4J9YKESBHcA3FqYd
         YEFQa6kORWmbRFXfogUQ1M9OJm+Wwef/9kMRQpg3rYSOSlZzCqe6O6LTWOIVsXUewVn6
         IW4uxhC26Yyc/pOkXJj2H+uwroR4tNKRIIEZphV8hZC16bqBBOcim6VMKz0+mnUqHoQS
         X2e/jdj7ZALgrh4awUXzwMgdbF2sf1qrvGHf8H9fz+mZ6vMxVRtfbBxTGeluzWq5tsOp
         Bvv8R3jeBGg5msSX01AXKB+5PLhpC3vUL+YQZEMnMIxE266wY4fG4cWJ8zxuoFhxZLUU
         7CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=eNAk7xwef+uDY4x9+c84lcLUtu9T/RFFSSBX+LZWdV0=;
        b=peLiRu74+XuaQPXWLyMM1t8eUOY6KYxI5i0H18c8duWa98Y+oCExJsQSXPdhm0OzO2
         9aL0oR6eGQnmjxcSFkzZYA793aH2pD+j5lyXD12mw+l+VxUr1fsx/7pmINET6QKtYo6M
         ZeoGB4h5WObSoZyCeFVQbU3AdJELdmzpfyUuuH4/N/+ScmCgdm+RmQ9xZ6b25DRqVCFO
         S2S3rz0oFVS6SUUEYQJrY6E5nhIokPoA8iuaZyrWHz3vKYOVYBRYY4qBjyN53iXCodcA
         Ub6MGiTHPnPsrKQFdRZ8VAxuciYYRrehGWNbisOO/sz9CJZo68NBzo3lczjnQkBM12fm
         i7eQ==
X-Gm-Message-State: APf1xPClIP/mdHpEpO519W0MxaUPXa85umcLXiJdtN+r9HHDzKWRHWBA
        Y+XcGPvcbvVElzezSEZ9Gw0infzxEdea4/KaoevCVgjTKMhiavvn2SB/Pj6kHTh5dvzvZsOclqy
        zcnf0NfoQKAZrZ7K7kA170IIpRYV8qZ6A/pcL+igMLdo9gr8moRFkRsrCTw==
X-Google-Smtp-Source: AH8x227iFqDbMtVZM3hn/IMzmLQcWiv0Xy1puPYq9+HUAwSUVHJCbZFr8yT88BtL1VmxSVCTBunc1QNxcjo=
MIME-Version: 1.0
X-Received: by 10.176.80.203 with SMTP id d11mr2796731uaa.102.1518634882733;
 Wed, 14 Feb 2018 11:01:22 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:37 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-16-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 15/37] commit: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
2.16.1.291.g4437f3f132-goog


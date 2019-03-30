Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3718920248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfC3LWE (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34981 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfC3LWD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so2439322pgf.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvY2S7a8efdubnqZ497rHTpt8jwV5naQZUHDCe65xZU=;
        b=HraR7F0oYUFpZjn9nN2158VZlKLlBg5w2jr8S0/znd1yiuuZJ0CbgWp0XbOf+vlqa4
         mEIzcLrE3cJGJ/4BS4jYl9LBePoy02uOcKRxiwMTWxkRB9/kqH7zx2jZdqh1A7dtu+tR
         wT1h4cV038pcXtRdfZJdcQsSSKfEWRWb9jR6C/oYP3bVMvK4af22T3JrFZVdWkZP1aMf
         PgHAWEjAl72tQskUj/0eJdBZl7RtwIgdhRm6QyHBkNJMK7QvZpfqwPB7xlW/q9zTNXRm
         RND7o3x2p0UkBloORW21iEGvWYL1nmLeuJ6SSvSTepXIDJ6OF4dP7XDQl6MUboIV2zgL
         DtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvY2S7a8efdubnqZ497rHTpt8jwV5naQZUHDCe65xZU=;
        b=Fbw3zR+WIil3UTYqC5uG5gorb8376IIDGgghVZ9fIcmOFqB2PQmdb8RpmSR+3Z8+Qt
         uxur9Of17/x+9LT1E53ky4RqMGWINiR4KiAcNQgTaV9fzs64UywzQ2CnZnAWuYcECkim
         qdv03sgXQ3q/Iq8Y/TTHexmWJ/xb5j1PRHkiZW/WlWySnKMq9srISS4oAjsZiTWFvo8k
         F1XcV191NWfQ58P9bfewX0WLHKcBCzuJv14H7R2e6RVVfTLxzGxxh0ZY7WtOZc/3hij8
         ShCD4JnYO+VZjTYFLbU//uCeukisI4EOMSna4/I4W8Op/tzxoFdCVGNq4onrySjD0sn0
         9aHg==
X-Gm-Message-State: APjAAAWQ9yf4l1ZM+q1qf21S3HagVGqyPBKU1ZnO/Ahzkfe2NDC8bgfp
        j6gmKAAMOfG6B4sJNGM+ngbEnhLs
X-Google-Smtp-Source: APXvYqzhgz056ETgLhoombg47R8Ub3B+PRfpMgB+QHVeXax96tUA1QSVJro4tBUfUXUVCIJHAhT+BA==
X-Received: by 2002:a65:6299:: with SMTP id f25mr51376414pgv.376.1553944923220;
        Sat, 30 Mar 2019 04:22:03 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id p26sm8880471pfa.49.2019.03.30.04.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/31] sha1-name.c: remove the_repo from get_oid_oneline()
Date:   Sat, 30 Mar 2019 18:19:15 +0700
Message-Id: <20190330111927.18645-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 49c62d5254..fb80306f1a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -15,7 +15,7 @@
 #include "midx.h"
 #include "commit-reach.h"
 
-static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
+static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
 
 typedef int (*disambiguate_hint_fn)(struct repository *, const struct object_id *, void *);
 
@@ -1090,7 +1090,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 
 		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
-		ret = get_oid_oneline(prefix, oid, list);
+		ret = get_oid_oneline(the_repository, prefix, oid, list);
 		free(prefix);
 		return ret;
 	}
@@ -1204,8 +1204,9 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	return 0;
 }
 
-static int get_oid_oneline(const char *prefix, struct object_id *oid,
-			    struct commit_list *list)
+static int get_oid_oneline(struct repository *r,
+			   const char *prefix, struct object_id *oid,
+			   struct commit_list *list)
 {
 	struct commit_list *backup = NULL, *l;
 	int found = 0;
@@ -1236,7 +1237,7 @@ static int get_oid_oneline(const char *prefix, struct object_id *oid,
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		if (!parse_object(the_repository, &commit->object.oid))
+		if (!parse_object(r, &commit->object.oid))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
@@ -1760,7 +1761,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			for_each_ref(handle_one_ref, &list);
 			head_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
-			return get_oid_oneline(name + 2, oid, list);
+			return get_oid_oneline(repo, name + 2, oid, list);
 		}
 		if (namelen < 3 ||
 		    name[2] != ':' ||
-- 
2.21.0.479.g47ac719cd3


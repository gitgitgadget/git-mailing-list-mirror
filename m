Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0060E1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfFXJ4G (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:56:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44261 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFXJ4F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so6575308plr.11
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luyi7uKA1TWVYgolKLhyMKxtRUKQjajZ2kWt761rU6k=;
        b=j7DZ3xNnTxHpWqSenJbevLdQxgm/p95DTCOe6l4rCUM/DsyijUpXQbKWJOj2XLn7Ps
         agkAwdNfupk5IMGBCnEqqzcgvrGG325itiDYvVO4c1b5BlJM90MoroWrfBRAuVbBKD69
         CqJUKf6+QrC6FLShlE1O0vknV8XT/fUaZLI9joGeFwGzJqK47GzYReBKogC/RAIyuoEo
         TGR3z36PEZ80nrZ+6Ibi2816eChOshVeNPpNmgBmIeTRISNbYalKEk8Ev1jUJGRxbyk8
         9+8wbBszyiN6faU87MeXeman/e4vV/WYPmp7/4AihxFxRrM4Uxa7d0TqCs5Oce9AzkzT
         SQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luyi7uKA1TWVYgolKLhyMKxtRUKQjajZ2kWt761rU6k=;
        b=jP/MioVLyHxGLmdvZno4JuxH6ez5xSWjXzPt/yf03RLc7L9lVd5GVnGoZnTCjm9MYu
         OCLxvCb4N4CThHWLF02tkkJtQi+m4yv1YBQ1wMDGL03L5JJPexUi9MPw1BxhmeeX3G9i
         Ur/a70qlxraGyfwy8oVV3at/ximaopCCziFgbP5LvAkJSQxPLJzO9rF/sTTeXhgmEcXL
         qAnwSvfJuSIXfhUv/o+TQB8cJgnMK/3gWm+MjiWV/peXTeGPdTDMyR61qFUfQOfIliF3
         nw5FkshhkX/sXMdQfiIegymn8iwe/RoMRsDSTPYO1hWSlOqCQ3dPm3DmYf0D/0lqX6ev
         nofA==
X-Gm-Message-State: APjAAAXYd8jlROc9E4VB8YwofG1GeC93uCv14q7aQ5VxleGQH6OnvyPQ
        R8/cRuw5x2hAuNO/x6jlVZWHZkdT
X-Google-Smtp-Source: APXvYqzIDJHCBOPPqqWuzbl22qCXh3S9n5GK/XG6TLUhuAa7LydrAJVxRy7dhju3kZ3o64OkjhHdLQ==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr12927479ply.170.1561370164666;
        Mon, 24 Jun 2019 02:56:04 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id q198sm15724474pfq.155.2019.06.24.02.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:56:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 16:56:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/6] match-trees.c: remove the_repo from shift_tree*()
Date:   Mon, 24 Jun 2019 16:55:32 +0700
Message-Id: <20190624095533.22162-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624095533.22162-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h                     |  4 ++--
 match-trees.c               | 12 +++++++-----
 merge-recursive.c           |  4 ++--
 t/helper/test-match-trees.c |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index cd84cc9bbe..ddefda2bb6 100644
--- a/cache.h
+++ b/cache.h
@@ -1786,8 +1786,8 @@ int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int
 extern int diff_auto_refresh_index;
 
 /* match-trees.c */
-void shift_tree(const struct object_id *, const struct object_id *, struct object_id *, int);
-void shift_tree_by(const struct object_id *, const struct object_id *, struct object_id *, const char *);
+void shift_tree(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, int);
+void shift_tree_by(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, const char *);
 
 /*
  * whitespace rules.
diff --git a/match-trees.c b/match-trees.c
index de7e8a6783..f6c194c1cc 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -248,7 +248,8 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
  * other hand, it could cover tree one and we might need to pick a
  * subtree of it.
  */
-void shift_tree(const struct object_id *hash1,
+void shift_tree(struct repository *r,
+		const struct object_id *hash1,
 		const struct object_id *hash2,
 		struct object_id *shifted,
 		int depth_limit)
@@ -290,7 +291,7 @@ void shift_tree(const struct object_id *hash1,
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry(the_repository, hash2, del_prefix, shifted, &mode))
+		if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
 		return;
@@ -307,7 +308,8 @@ void shift_tree(const struct object_id *hash1,
  * Unfortunately we cannot fundamentally tell which one to
  * be prefixed, as recursive merge can work in either direction.
  */
-void shift_tree_by(const struct object_id *hash1,
+void shift_tree_by(struct repository *r,
+		   const struct object_id *hash1,
 		   const struct object_id *hash2,
 		   struct object_id *shifted,
 		   const char *shift_prefix)
@@ -317,12 +319,12 @@ void shift_tree_by(const struct object_id *hash1,
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry(the_repository, hash1, shift_prefix, &sub1, &mode1) &&
+	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &mode1) &&
 	    S_ISDIR(mode1))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry(the_repository, hash2, shift_prefix, &sub2, &mode2) &&
+	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &mode2) &&
 	    S_ISDIR(mode2))
 		candidate |= 2;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index b051066795..6d772eb0eb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -153,9 +153,9 @@ static struct tree *shift_tree_object(struct repository *repo,
 	struct object_id shifted;
 
 	if (!*subtree_shift) {
-		shift_tree(&one->object.oid, &two->object.oid, &shifted, 0);
+		shift_tree(repo, &one->object.oid, &two->object.oid, &shifted, 0);
 	} else {
-		shift_tree_by(&one->object.oid, &two->object.oid, &shifted,
+		shift_tree_by(repo, &one->object.oid, &two->object.oid, &shifted,
 			      subtree_shift);
 	}
 	if (oideq(&two->object.oid, &shifted))
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 96857f26ac..b9fd427571 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -20,7 +20,7 @@ int cmd__match_trees(int ac, const char **av)
 	if (!two)
 		die("not a tree-ish %s", av[2]);
 
-	shift_tree(&one->object.oid, &two->object.oid, &shifted, -1);
+	shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);
 	printf("shifted: %s\n", oid_to_hex(&shifted));
 
 	exit(0);
-- 
2.22.0.rc0.322.g2b0371e29a


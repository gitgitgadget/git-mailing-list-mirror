Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5C120372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbdJFUMu (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:12:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43776 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdJFUMr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id m72so3855209wmc.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGZGEdKjaIqTcODAFe3p4WjLsboo9JNsa2mzpFuuXXw=;
        b=HzS8SZn590cOm7OXZEgZgRTOQI0eWP+FwsDdaalccTM1oiHjLk6gysrOMqMP9RFzqU
         gvRMzmm1HzSFZuhcxeRwFTv8g+XHuCaA8JlIWMUAn55YgZ8Opn3rnHeRRlXA83kI/nj2
         e+PIZmlkWAcVJBIsvPCtEN/6hy8DZLdk3/t1RN624FZYKPfWOQKjzqvXVKV7QyI4Uawk
         9huXXQEFfgyEffgSvThVIqienTiz92rRKLfxLIs/f1NTR+1V8h1V/n5gi4vQRnXiVcDe
         9kk3vK5chxzTjJvLprO9TOULpvEFHxOBcKwuWBWdPz/AvZFnKtUNJ6f1y3K1U0WZKjdB
         EeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGZGEdKjaIqTcODAFe3p4WjLsboo9JNsa2mzpFuuXXw=;
        b=O70LbX5t9rqlYjtTUc04UByC4HR4TyVXtNDSt4uHzGl/0L+6ZR6lqEl2pqTh3nQ9UW
         pmfMe4+QgHtK9QUtkG79+EJzmqI/pudvn5jgc1JdEn1LG9VugiCzfDZdaLhH0ZyDV3B4
         57BsxNFkgQB0fO+4LXYWrBn+zwesQj1J7lATYLk8Jl5Cn/h5p9F8eapTGNz73A59r2eW
         5wm2IIZg9MX/aom9jtE7/dBVLfW/ifeESAJruMk3lB/q1/11M37wqbVkUveehr1+z/mx
         wpEaEMqYTtpaI5gFfvf53M1z4rV1wJTu1I6N7Dq2NfvyD/XaJTb+jFBeH9E75fS33e4V
         QCCg==
X-Gm-Message-State: AMCzsaXWfhQYHFXoxVlrvkbbGttj4jcSNszzyZUEqijej+M8rkQRFBaF
        pBJnW5B1/fTezwrFH6rgn5R2cfzVzTE=
X-Google-Smtp-Source: AOwi7QCkT/rcnrXcR3A/Ya1XvwGZpTZSLGBZkruw1sB2aNn0sWkwkonZ0Y3oLRuHYl+KuyD/qig/9g==
X-Received: by 10.28.23.1 with SMTP id 1mr2519073wmx.101.1507320765991;
        Fri, 06 Oct 2017 13:12:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/12] cache-tree: simplify locking logic
Date:   Fri,  6 Oct 2017 22:12:08 +0200
Message-Id: <2954e5ec4361c6932593663859aa437583edb500.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we have taken the lock using `LOCK_DIE_ON_ERROR`, we know that
`newfd` is non-negative. So when we check for exactly that property
before calling `write_locked_index()`, the outcome is guaranteed.

If we write and commit successfully, we set `newfd = -1`, so that we can
later avoid calling `rollback_lock_file` on an already-committed lock.
But we might just as well unconditionally call `rollback_lock_file()` --
it will be a no-op if we have already committed.

All in all, we use `newfd` as a bool and the only benefit we get from it
is that we can avoid calling a no-op. Remove `newfd` so that we have one
variable less to reason about.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache-tree.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 71d092ed5..f646f5673 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -602,11 +602,11 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 
 int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
-	int entries, was_valid, newfd;
+	int entries, was_valid;
 	struct lock_file lock_file = LOCK_INIT;
 	int ret = 0;
 
-	newfd = hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path);
 	if (entries < 0) {
@@ -625,10 +625,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 			ret = WRITE_TREE_UNMERGED_INDEX;
 			goto out;
 		}
-		if (0 <= newfd) {
-			if (!write_locked_index(index_state, &lock_file, COMMIT_LOCK))
-				newfd = -1;
-		}
+		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
 		 * ends up using the old index with unupdated cache-tree part
@@ -650,8 +647,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 		hashcpy(sha1, index_state->cache_tree->oid.hash);
 
 out:
-	if (0 <= newfd)
-		rollback_lock_file(&lock_file);
+	rollback_lock_file(&lock_file);
 	return ret;
 }
 
-- 
2.15.0.rc0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D571F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbeIUVr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37273 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390391AbeIUVr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so12113506ljk.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYQJ0P0hF0r32FsvNB0weHLoENTArVFfWLZiKdsr3LI=;
        b=cnN2eHH75Sn+aud2iCiNPzjUpMLoSugra2fSHGJ+I20UVsDI5ekvGwG0waWEIcr4YV
         fzAm/RgESEqmVuhU0KkTi21zjoBUxyyWu4oQmzYdHsA+mz00NP7DGZvkUgziuZDgQIWz
         erOwr5Idww8ckbWrpTdeUpVWHIhzQvhfMFU5EwjbBQRXU54p9AhpD5bGLfjONVv4jf+6
         eCHb3cuEw395mZ8QK3emecF9TO7sgUT5MAhLCcadXaK7D4QzU4NQKHPrp8LhIcsxjjx8
         vHHw7TwgigEHk5LZ8iTjlvNUXfkCZFxIZCwVUWgZMKPuApOMdRlxsa/vCJ8nHF1lRbIj
         egFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYQJ0P0hF0r32FsvNB0weHLoENTArVFfWLZiKdsr3LI=;
        b=JHAK1d2XEzEzvPLHF7B8Xfhij9Cx2y0Qsi5Vc9VHy2mrWZPstGslwGYBTYI/tMi1NB
         +WZpVEpG9qn4GeLCleWqX/3QSNeCTOnSwHyGWkb8VikrapRBGAut/qtrusetwoyQK4lL
         lLgc7MeR+M9wehke5Visija1z8y+Fzki+CF+4IN6CLEmp40epMIjf8dDtUYZczrpXmrh
         z769Z6ZdtFw80sRvzTn9r3OpcHNOz9D8HYuDi8/vzqywWAIFPFhgZZyYGTHfdWTfQ0vL
         kQqLQ3QZoqtvv7oUha6xcn+XujRQ0r7+0u1ayY8O21q8KnDLlNHVRQWkD2GuaSWx7Ee3
         vRiQ==
X-Gm-Message-State: ABuFfogAb89SWM2fUaWpbi+mHkdPlaNvJo+G4lembTMkschfzYa43Dij
        KiVUizdUsI/iGV5caufDXnI=
X-Google-Smtp-Source: ACcGV60JQZCyv6me6cOxB7oeFOwJY9iXq9HuJNXfiIyNAinVsF9QAN/FTiQsste9ns/UBGR0/oxphw==
X-Received: by 2002:a2e:5d57:: with SMTP id r84-v6mr2262016ljb.89.1537545473707;
        Fri, 21 Sep 2018 08:57:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 05/23] blame.c: rename "repo" argument to "r"
Date:   Fri, 21 Sep 2018 17:57:21 +0200
Message-Id: <20180921155739.14407-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current naming convention for 'struct repository *' is 'r' for
temporary variables or arguments. I did not notice this. Since we're
updating blame.c again in the next patch, let's fix this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 blame.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/blame.c b/blame.c
index aca06f4b12..98bf50d89a 100644
--- a/blame.c
+++ b/blame.c
@@ -90,7 +90,7 @@ static struct blame_origin *get_origin(struct commit *commit, const char *path)
 
 
 
-static void verify_working_tree_path(struct repository *repo,
+static void verify_working_tree_path(struct repository *r,
 				     struct commit *work_tree, const char *path)
 {
 	struct commit_list *parents;
@@ -102,15 +102,15 @@ static void verify_working_tree_path(struct repository *repo,
 		unsigned mode;
 
 		if (!get_tree_entry(commit_oid, path, &blob_oid, &mode) &&
-		    oid_object_info(repo, &blob_oid, NULL) == OBJ_BLOB)
+		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
 
-	pos = index_name_pos(repo->index, path, strlen(path));
+	pos = index_name_pos(r->index, path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
-	else if (-1 - pos < repo->index->cache_nr &&
-		 !strcmp(repo->index->cache[-1 - pos]->name, path))
+	else if (-1 - pos < r->index->cache_nr &&
+		 !strcmp(r->index->cache[-1 - pos]->name, path))
 		; /* path is in the index, unmerged */
 	else
 		die("no such path '%s' in HEAD", path);
@@ -166,7 +166,7 @@ static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
  * Prepare a dummy commit that represents the work tree (or staged) item.
  * Note that annotating work tree item never works in the reverse.
  */
-static struct commit *fake_working_tree_commit(struct repository *repo,
+static struct commit *fake_working_tree_commit(struct repository *r,
 					       struct diff_options *opt,
 					       const char *path,
 					       const char *contents_from)
@@ -183,7 +183,7 @@ static struct commit *fake_working_tree_commit(struct repository *repo,
 	unsigned mode;
 	struct strbuf msg = STRBUF_INIT;
 
-	read_index(repo->index);
+	read_index(r->index);
 	time(&now);
 	commit = alloc_commit_node(the_repository);
 	commit->object.parsed = 1;
@@ -195,7 +195,7 @@ static struct commit *fake_working_tree_commit(struct repository *repo,
 
 	parent_tail = append_parent(parent_tail, &head_oid);
 	append_merge_parents(parent_tail);
-	verify_working_tree_path(repo, commit, path);
+	verify_working_tree_path(r, commit, path);
 
 	origin = make_origin(commit, path);
 
@@ -253,7 +253,7 @@ static struct commit *fake_working_tree_commit(struct repository *repo,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(repo->index, path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(r->index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_object_file(buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
@@ -264,28 +264,28 @@ static struct commit *fake_working_tree_commit(struct repository *repo,
 	 * bits; we are not going to write this index out -- we just
 	 * want to run "diff-index --cached".
 	 */
-	discard_index(repo->index);
-	read_index(repo->index);
+	discard_index(r->index);
+	read_index(r->index);
 
 	len = strlen(path);
 	if (!mode) {
-		int pos = index_name_pos(repo->index, path, len);
+		int pos = index_name_pos(r->index, path, len);
 		if (0 <= pos)
-			mode = repo->index->cache[pos]->ce_mode;
+			mode = r->index->cache[pos]->ce_mode;
 		else
 			/* Let's not bother reading from HEAD tree */
 			mode = S_IFREG | 0644;
 	}
-	ce = make_empty_cache_entry(repo->index, len);
+	ce = make_empty_cache_entry(r->index, len);
 	oidcpy(&ce->oid, &origin->blob_oid);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
-	add_index_entry(repo->index, ce,
+	add_index_entry(r->index, ce,
 			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 
-	cache_tree_invalidate_path(repo->index, path);
+	cache_tree_invalidate_path(r->index, path);
 
 	return commit;
 }
@@ -520,14 +520,14 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
  *
  * This also fills origin->mode for corresponding tree path.
  */
-static int fill_blob_sha1_and_mode(struct repository *repo,
+static int fill_blob_sha1_and_mode(struct repository *r,
 				   struct blame_origin *origin)
 {
 	if (!is_null_oid(&origin->blob_oid))
 		return 0;
 	if (get_tree_entry(&origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
 		goto error_out;
-	if (oid_object_info(repo, &origin->blob_oid, NULL) != OBJ_BLOB)
+	if (oid_object_info(r, &origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
-- 
2.19.0.640.gcd3aa10a8a


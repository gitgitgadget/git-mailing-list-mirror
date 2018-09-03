Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B361F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeICWbj (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41107 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeICWbi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so1076401ljy.8
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mw77215xbtI4pdrCTFdOnyXypu++O77yEMTjoWFg1sY=;
        b=N+QfTfMv1atEJYtl2ineXSMG7fxLwzuR8fooI9L3Rihv+QgsFmRWWQTnvGgp+y2l09
         p7ZF96lEUVC23n4FfbaJBzCswfBp0mEQMT+uDelatCGH/hcBn0PYwjzW3X3o+Fj0PVRm
         4KgEVl2A21SXdQhgNM9IPwEZ3pr7210TMB4hZnEhBu4FPQRS+LUEv4fRFZFZfQqgHUq2
         wo6NC7v+YbUP6A/EQopfK4BmHpjG3cMzr+cjvXhVikJap/WvCk+ogJzIw7kVhCvBuVV/
         iYGy6l7oMOmkyEdYT65geka6bhlZwVonDH/5bdVa3qNjGxS5XzNbd6BKE3NjODPZu/kr
         /Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mw77215xbtI4pdrCTFdOnyXypu++O77yEMTjoWFg1sY=;
        b=HsX8gc6g1NnNMt6D5Z3XW+4XoynDBHvWwWYo88zs0nysY1zUW4RgNiJ1HnPVEEnMSO
         rT8ciVE99GuGiVi9e9WwsPsVpOfI2yi6rntm5eIWyyCjSwksTXt+eW1MwK+wW6tcznyT
         vYC6IDxfxGueiYGyk12o5EWZTvSiUtTKvIkQkxganlOo+x4pFiIu7vXaXjM5gwNlUfob
         GIJ/UxHdl67KF+8lTuFoIhSeYhdVpbbSxmvU4FvC/za1mQPvlXozUjbmjq8OkV63bcTW
         RhLS26lcSeUvi85H5JweaOpcETlGV1alBRPx2DBAoyRLFrj/QCQfpE3crx1mcyioj4TN
         aBzw==
X-Gm-Message-State: APzg51CtymzLTaQXEqTPe6nm0w/uA0uZA6Ue71m4UWgiK4HMZiRkhCUB
        4SDKYK+Jhl2t/BdLlT+16nY=
X-Google-Smtp-Source: ANB0VdaBHP7uV1WC62Mn6I3B1fjE039F0rvVLcmOxPjFHsFteY6179KVnHyH7Odm74axS/iCt2UtDw==
X-Received: by 2002:a2e:54b:: with SMTP id 72-v6mr8377052ljf.152.1535998216878;
        Mon, 03 Sep 2018 11:10:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 05/24] blame.c: rename "repo" argument to "r"
Date:   Mon,  3 Sep 2018 20:09:13 +0200
Message-Id: <20180903180932.32260-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
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
2.19.0.rc0.337.ge906d732e7


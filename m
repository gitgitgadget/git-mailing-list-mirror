Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ED020966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdCZCoB (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:44:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34302 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdCZCoA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:44:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id o126so4074828pfb.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzFhQBgKTiAY1DsQIg2/UZSopdKwEG5Vc3aUAuyumIY=;
        b=BynXMeXeWHHykQncS0m+KGEjTyiWw2v3IPz3SFdV5CAQ/vUTR7CKSFs2s0jkmhwv3v
         x0KUqOt0qNaRVzcZpdl1F3zKb3nm8S57lAI4HvtzFoM5e0gnaLPCJVn+6ve3QoPeKMhB
         4/vcZt5RYyNnn/j6+U6eXY0TbAnxrR4mhuB/rHMiuvgKem/sv+mY7oUkTi0V11cXIMyJ
         RU6t4hWoDqO2fX8Km7M0t63Ajs31Vqw/RKR5BHvn6Aqx+P730sdsNejoin6Adzk8ZjH4
         yy20dgkN+lO+4urUAeatueNC/BHPirkhRZLwM/O2SXyQGuXDzbyGzjzPzt0+3RT2Bvne
         63XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzFhQBgKTiAY1DsQIg2/UZSopdKwEG5Vc3aUAuyumIY=;
        b=k5gEFKm6jqUFCA7GAJzvZdsu0yoP3zj5hwU3M/PJx/ipA3Z8eYkKVQh3b1kkvvJULi
         QbJyTI5i7Ic1F6jejHwiPUZSLyVGPVBS7qNU9y1jaHAxC9xVr9OPzmoo7Gcrnmizxujr
         Im7A4qIF+METLxwC3KqtHd3z237DyMiTc5H9YTjgU3tJT578zjGZ15n9zy12rP1J8ymB
         TiTR33I7IVrZfAwNbMPBQAdfRYascZCwZxetFszMYgrtuoPSuVO42p5O5E3XGCxNNhzx
         FA/kl2TsgE0iD+qUxuudYHXPPnxss/FJRH4v8VzLnIj5t5yC3oY5Zz71c3kPPbhx5Wi0
         qaEQ==
X-Gm-Message-State: AFeK/H23SNkeXqkMH2Bn0E6E6RZRgcfvdlCS7+w8Ys+yZiHp1WQNQQT2x2zDOux6HHOeiQ==
X-Received: by 10.84.218.2 with SMTP id q2mr21009541pli.141.1490496234554;
        Sat, 25 Mar 2017 19:43:54 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id i15sm12807978pfj.51.2017.03.25.19.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:43:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:43:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 10/28] files-backend: add and use files_ref_path()
Date:   Sun, 26 Mar 2017 09:42:23 +0700
Message-Id: <20170326024241.31984-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep repo-related path handling in one place. This will make it easier
to add submodule/multiworktree support later.

This automatically adds the "if submodule then use the submodule version
of git_path" to other call sites too. But it does not mean those
operations are submodule-ready. Not yet.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b0e0df9f66..741e52d143 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1180,6 +1180,18 @@ static void files_reflog_path(struct files_ref_store *refs,
 	strbuf_git_path(sb, "logs/%s", refname);
 }
 
+static void files_ref_path(struct files_ref_store *refs,
+			   struct strbuf *sb,
+			   const char *refname)
+{
+	if (refs->submodule) {
+		strbuf_git_path_submodule(sb, refs->submodule, "%s", refname);
+		return;
+	}
+
+	strbuf_git_path(sb, "%s", refname);
+}
+
 /*
  * Get the packed_ref_cache for the specified files_ref_store,
  * creating it if necessary.
@@ -1249,19 +1261,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	struct strbuf refname;
 	struct strbuf path = STRBUF_INIT;
 	size_t path_baselen;
-	int err = 0;
 
-	if (refs->submodule)
-		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
-	else
-		strbuf_git_path(&path, "%s", dirname);
+	files_ref_path(refs, &path, dirname);
 	path_baselen = path.len;
 
-	if (err) {
-		strbuf_release(&path);
-		return;
-	}
-
 	d = opendir(path.buf);
 	if (!d) {
 		strbuf_release(&path);
@@ -1396,10 +1399,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	*type = 0;
 	strbuf_reset(&sb_path);
 
-	if (refs->submodule)
-		strbuf_git_path_submodule(&sb_path, refs->submodule, "%s", refname);
-	else
-		strbuf_git_path(&sb_path, "%s", refname);
+	files_ref_path(refs, &sb_path, refname);
 
 	path = sb_path.buf;
 
@@ -1587,7 +1587,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	*lock_p = lock = xcalloc(1, sizeof(*lock));
 
 	lock->ref_name = xstrdup(refname);
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_ref_path(refs, &ref_file, refname);
 
 retry:
 	switch (safe_create_leading_directories(ref_file.buf)) {
@@ -2056,7 +2056,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_ref_path(refs, &ref_file, refname);
 	resolved = !!resolve_ref_unsafe(refname, resolve_flags,
 					lock->old_oid.hash, type);
 	if (!resolved && errno == EISDIR) {
@@ -2355,7 +2355,7 @@ static void try_remove_empty_parents(struct files_ref_store *refs,
 		strbuf_setlen(&buf, q - buf.buf);
 
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "%s", buf.buf);
+		files_ref_path(refs, &sb, buf.buf);
 		if ((flags & REMOVE_EMPTY_PARENTS_REF) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REF;
 
@@ -2672,7 +2672,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			struct strbuf path = STRBUF_INIT;
 			int result;
 
-			strbuf_git_path(&path, "%s", newrefname);
+			files_ref_path(refs, &path, newrefname);
 			result = remove_empty_directories(&path);
 			strbuf_release(&path);
 
@@ -3906,7 +3906,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			    update->type & REF_ISSYMREF) {
 				/* It is a loose reference. */
 				strbuf_reset(&sb);
-				strbuf_git_path(&sb, "%s", lock->ref_name);
+				files_ref_path(refs, &sb, lock->ref_name);
 				if (unlink_or_msg(sb.buf, err)) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -4206,19 +4206,18 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "init_db");
-
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	strbuf_git_path(&sb, "refs/heads");
+	files_ref_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 
 	strbuf_reset(&sb);
-	strbuf_git_path(&sb, "refs/tags");
+	files_ref_path(refs, &sb, "refs/tags");
 	safe_create_dir(sb.buf, 1);
 
 	strbuf_release(&sb);
-- 
2.11.0.157.gd943d85


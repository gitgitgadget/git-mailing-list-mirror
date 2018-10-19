Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342571F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJSW7c (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41341 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeJSW7b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21-v6so31074456lja.8
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLQNLOu/+ibJEg9wfBfkj/YAoih8BQjN0jo9Ue9j3IM=;
        b=tbajN1mvmjJHhuVn6c/jtCCI6sDye6oyMfjj5PyjLb30/TZFiXluB5gMrv4g6CgX53
         xCG1paYaOVTFR5/A8uDBkf3VcUd2B5dtzxydeM9pjqita88Qxu5W/aJ85I+h1naDmTfx
         9y7T4I+OwGoqq2FRj3hQgoOxLPKFyCOyeZ+Rr6t2zELn0YcQx0/XHi+d4R17iLYJm6oy
         jlW9wrVx0Se8Olk1BOOWGQnzOOM89z3Ruvrsc/GFrvZtlyJco6c6pGzG+aEZFMnMLm6F
         Bu4aoTbMvaJHtTDiE1eKpiPPh20uJG8GvbhVXRKBPFllOo4dxUY8mS0kQC8En3pUFYgO
         ZNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLQNLOu/+ibJEg9wfBfkj/YAoih8BQjN0jo9Ue9j3IM=;
        b=sdxCFxJO+hcSwz/rmjygRuu1gEuxtnN30xDrw5LA9OXDZ+y/IhF08I6yF2WmRRox72
         3raavqNG8vOI87ghQBFgGYGZ4fbyRrMzHdysIlu4Lhz94H4x7tbO44GoIi509GvZvHAJ
         hndLQ5GnvtjhM1QsqJ6zOF7/aNhVvEKhKH18Wnvj/TQb6vlwCp4MsVqMNax3dxS6T8Az
         sSl/g2doxZnADeSBSJL2E6wYjbPCZbufCxQE+ETaxtV8LWlAfzZAwZQdpjNrsLgevmF6
         gSn+CHnAARwxuz7KjzzQd+/Of13m2DiXItb0M/sAGdfabYhYRquPHMivNcXH+GwwZINo
         vy3A==
X-Gm-Message-State: ABuFfoiMpl7UD04BxgLvE8GlPxw8qsKs5/iLB4Bv7SHVXjn2I2VjvRsx
        pso2voAAlvQ++8RNi5mmw8dKhEE5
X-Google-Smtp-Source: AJdET5eXvauqwDVly/qFStNLweM9U3HWsdMtnicVhg2UFIUBGqAaoLixP1Vj7t0C2SCh9gwbP0IH3Q==
X-Received: by 2002:a2e:8919:: with SMTP id d25-v6mr5207787lji.69.1539960782056;
        Fri, 19 Oct 2018 07:53:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:53:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/19] read-cache.c: remove the_* from index_has_changes()
Date:   Fri, 19 Oct 2018 16:52:35 +0200
Message-Id: <20181019145237.16079-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c      |  6 +++---
 cache.h           |  6 +++---
 merge-recursive.c |  2 +-
 read-cache.c      | 12 +++++-------
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 65e10a5eb3..37b52be7db 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1771,7 +1771,7 @@ static void am_run(struct am_state *state, int resume)
 
 	refresh_and_write_cache();
 
-	if (index_has_changes(&the_index, NULL, &sb)) {
+	if (repo_index_has_changes(the_repository, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
@@ -1829,7 +1829,7 @@ static void am_run(struct am_state *state, int resume)
 			 * the result may have produced the same tree as ours.
 			 */
 			if (!apply_status &&
-			    !index_has_changes(&the_index, NULL, NULL)) {
+			    !repo_index_has_changes(the_repository, NULL, NULL)) {
 				say(state, stdout, _("No changes -- Patch already applied."));
 				goto next;
 			}
@@ -1883,7 +1883,7 @@ static void am_resolve(struct am_state *state)
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-	if (!index_has_changes(&the_index, NULL, NULL)) {
+	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
 			"If there is nothing left to stage, chances are that something else\n"
 			"already introduced the same changes; you might want to skip this patch."));
diff --git a/cache.h b/cache.h
index 91c092cf76..4b3ec4ff82 100644
--- a/cache.h
+++ b/cache.h
@@ -701,9 +701,9 @@ extern int unmerged_index(const struct index_state *);
  * provided, the space-separated list of files that differ will be appended
  * to it.
  */
-extern int index_has_changes(struct index_state *istate,
-			     struct tree *tree,
-			     struct strbuf *sb);
+extern int repo_index_has_changes(struct repository *repo,
+				  struct tree *tree,
+				  struct strbuf *sb);
 
 extern int verify_path(const char *path, unsigned mode);
 extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
diff --git a/merge-recursive.c b/merge-recursive.c
index ad0a5b0202..22b382e85f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3282,7 +3282,7 @@ int merge_trees(struct merge_options *o,
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!o->call_depth && index_has_changes(istate, head, &sb)) {
+	if (!o->call_depth && repo_index_has_changes(o->repo, head, &sb)) {
 		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
 		return -1;
diff --git a/read-cache.c b/read-cache.c
index 46e5e4000a..19389c6f30 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2372,22 +2372,20 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-int index_has_changes(struct index_state *istate,
-		      struct tree *tree,
-		      struct strbuf *sb)
+int repo_index_has_changes(struct repository *repo,
+			   struct tree *tree,
+			   struct strbuf *sb)
 {
+	struct index_state *istate = repo->index;
 	struct object_id cmp;
 	int i;
 
-	if (istate != &the_index) {
-		BUG("index_has_changes cannot yet accept istate != &the_index; do_diff_cache needs updating first.");
-	}
 	if (tree)
 		cmp = tree->object.oid;
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
-		repo_diff_setup(the_repository, &opt);
+		repo_diff_setup(repo, &opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
-- 
2.19.1.647.g708186aaf9


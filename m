Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146941F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfAXIaM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:30:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35692 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfAXIaM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:30:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so2646228pfi.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFotHXnkZfamZV+K6NDRzhhK2WfmnAFs6HPBSkMm2Vg=;
        b=Dm6PU3yK7EZ8Rtcz37likKwQ4zIZrvZHshR3w40A4ZbDGH/o7MEG8uKs87THptV1gD
         mkW4UOunBsKY8A3qIMBpNx11F9fL2aA/W8Md2GQTxNIRKEX6JcvIXuB89sQ3ERkYSawk
         cWhr3ejoVzgQwPVwQZL0fdH9xSr9cTihkW/IyYgbpAc+rX/2NPu8hxzYSLU4D4uPYy/0
         SriEvgREPTIKKb4YSF5PTrAZ2bHAD/SH97wGP6eYKBk7yOqygJi6wWvz2zE+c1khS22Q
         0yAdjmdXVuSa25ji0ytSCMKI85rhFXMnLxlt+SrMMQ/h9OqP3KV4WeT+vgCYAHaFpepv
         Thsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFotHXnkZfamZV+K6NDRzhhK2WfmnAFs6HPBSkMm2Vg=;
        b=mfs9g9iR1scf8i1FE2+qfPtXUvv0sALVigsAtihlluVvyfcDxwU8BBr8FCs1uHFGKl
         kwjltNKbRssKmCm9zn11bfvALeEvAaDNOFexgrxRXca6jOlS/1TV59NpdXNFC8JpW650
         5hB4OLhMJsLXpc7NEB2p4PkT5SAGBwGg/YpMwSRsaLhP99BSFNLIjIqeXUzVlpDgpO9+
         Zof6xpKhz6Xeh7dB1rYgdNqhqeII/lJMhEEC1N1abCT6J7xV+FRwu0G5vsdtDitfSNju
         u6C6bGHbbKzcF6hDrMEWBStDYUTTvUpTkykaUWzPvU3fhXtvu9B5f5xfvF7jb6v5GM70
         CAbA==
X-Gm-Message-State: AJcUukek6Hsd/8JNfFgLjMSNXp4IqBhQWxaWdjkQE/IPD+TNDAjHGPrz
        ZhZe9uLem7URPQp7LpVhkWdXikOiabU=
X-Google-Smtp-Source: ALg8bN4baXsxCvTnNR5ZxegBcJQoAuTR4Iv8w3QvYcY7D1i5y8ZiID2Wvj/E44uDQJ7SRcRJ8xZ+QA==
X-Received: by 2002:a63:4b25:: with SMTP id y37mr5272621pga.181.1548318611783;
        Thu, 24 Jan 2019 00:30:11 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id t5sm38314242pfb.60.2019.01.24.00.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:30:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:30:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/11] read-cache.c: remove the_* from index_has_changes()
Date:   Thu, 24 Jan 2019 15:29:11 +0700
Message-Id: <20190124082912.24401-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c      |  6 +++---
 cache.h           |  6 +++---
 merge-recursive.c |  2 +-
 read-cache.c      | 12 +++++-------
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 611712dc95..a9ffc92eaa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1719,7 +1719,7 @@ static void am_run(struct am_state *state, int resume)
 
 	refresh_and_write_cache();
 
-	if (index_has_changes(&the_index, NULL, &sb)) {
+	if (repo_index_has_changes(the_repository, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
@@ -1777,7 +1777,7 @@ static void am_run(struct am_state *state, int resume)
 			 * the result may have produced the same tree as ours.
 			 */
 			if (!apply_status &&
-			    !index_has_changes(&the_index, NULL, NULL)) {
+			    !repo_index_has_changes(the_repository, NULL, NULL)) {
 				say(state, stdout, _("No changes -- Patch already applied."));
 				goto next;
 			}
@@ -1831,7 +1831,7 @@ static void am_resolve(struct am_state *state)
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-	if (!index_has_changes(&the_index, NULL, NULL)) {
+	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
 			"If there is nothing left to stage, chances are that something else\n"
 			"already introduced the same changes; you might want to skip this patch."));
diff --git a/cache.h b/cache.h
index fdcd69bfb0..326e73f391 100644
--- a/cache.h
+++ b/cache.h
@@ -706,9 +706,9 @@ extern int unmerged_index(const struct index_state *);
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
index a596d95739..df00896b25 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3412,7 +3412,7 @@ int merge_trees(struct merge_options *o,
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!o->call_depth && index_has_changes(istate, head, &sb)) {
+	if (!o->call_depth && repo_index_has_changes(o->repo, head, &sb)) {
 		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
 		return -1;
diff --git a/read-cache.c b/read-cache.c
index 61cc0571da..2549477ed2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2365,22 +2365,20 @@ int unmerged_index(const struct index_state *istate)
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
2.20.1.560.g70ca8b83ee


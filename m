Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220081F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935100AbeF3JVL (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:21:11 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33483 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934429AbeF3JUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:52 -0400
Received: by mail-lf0-f53.google.com with SMTP id u14-v6so3433336lfu.0
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1cKy6vc5z31pszDAsDcoXWACOId9ewGg61sOqbxNY0=;
        b=k7qJww2J22bR4JsNScmPDZTkbJ8TLLQMmmvkP8DqS0dvJMBC5Xx4caiU0dD7gtSCqP
         0AHNvmHAc+wBl746v1GLXzsglrZnuQMqdqT/GEGIzQy+AftAXWkeVqseDM8KNRZC1Tpg
         /uofn79NOuo2TCh3vV0XPLCelKOryqkesJEY2G2YP9YnYelHMwikNtcZU2OKw2z1M7XS
         5CWRSxddzVLzJ6NuiWZx0WvHGVhK5qRTmJLp8l/HFKLo3puabcogTmRL+IMvpWctp7dB
         dEETOWiPkZvBpkhshg2kJ025tKV4HknHeH4mHn8rnwIgHMAq3Mje1gQDmwcaDzsC9xH1
         UPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1cKy6vc5z31pszDAsDcoXWACOId9ewGg61sOqbxNY0=;
        b=SLzX5wOlZK6IgtFrMKN0rcdSzrqvddL6IdYzjnyoBssFU7KoY9sHx5S0B386ouD6yK
         40URcYVwlqGgRb80d9uYavccWpfhFqLni7iENHlEUt0JWLWuXgJm1KjgrXWYA0vZ+mQY
         tcZ+XrIMH1l58gIYTHUeDOMT9+qKalbnx6fpmT2H/6WHB63vpJgCrA1712R620OEe7yc
         kjhW9bHXSFoJGMMWc3xr4m8QG0nubq+bPsCngKvD2M4plZuPqo4siulElyXiqxvK3vx4
         hAEOOe+JaCrAeFji39jMweSsllYkNNaMTlJOwP3IJqadT8jj/YVpV0Rf8fXMUn8zG/vt
         SGdQ==
X-Gm-Message-State: APt69E2T/07a5n5O7r1Z6shQfyWsIYfLOomd543+p2QjPAcrbsLrUSvE
        ym/ggjcDNrt510BM8TSHiqz26w==
X-Google-Smtp-Source: AAOMgpcQo3wcp71VxEkpzOZOGpJHiIayzvYntD1+j2Oo27MZEs8+9J1rYrN3YuJzHPlQAEpXsLFyfg==
X-Received: by 2002:a19:a947:: with SMTP id s68-v6mr12363248lfe.70.1530350450461;
        Sat, 30 Jun 2018 02:20:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/12] revision.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:30 +0200
Message-Id: <20180630092031.29910-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.h | 69 +++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/revision.h b/revision.h
index b8c47b98e2..5f082a6d98 100644
--- a/revision.h
+++ b/revision.h
@@ -226,7 +226,7 @@ struct rev_info {
 	const char *break_bar;
 };
 
-extern int ref_excluded(struct string_list *, const char *path);
+int ref_excluded(struct string_list *, const char *path);
 void clear_ref_exclusion(struct string_list **);
 void add_ref_exclusion(struct string_list **, const char *exclude);
 
@@ -248,39 +248,39 @@ struct setup_revision_opt {
 	unsigned revarg_opt;
 };
 
-extern void init_revisions(struct rev_info *revs, const char *prefix);
-extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
-			   struct setup_revision_opt *);
-extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
-			       const struct option *options,
-			       const char * const usagestr[]);
+void init_revisions(struct rev_info *revs, const char *prefix);
+int setup_revisions(int argc, const char **argv, struct rev_info *revs,
+		    struct setup_revision_opt *);
+void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
+			const struct option *options,
+			const char * const usagestr[]);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
-extern int handle_revision_arg(const char *arg, struct rev_info *revs,
-			       int flags, unsigned revarg_opt);
+int handle_revision_arg(const char *arg, struct rev_info *revs,
+			int flags, unsigned revarg_opt);
 
-extern void reset_revision_walk(void);
-extern int prepare_revision_walk(struct rev_info *revs);
-extern struct commit *get_revision(struct rev_info *revs);
-extern char *get_revision_mark(const struct rev_info *revs,
-			       const struct commit *commit);
-extern void put_revision_mark(const struct rev_info *revs,
-			      const struct commit *commit);
+void reset_revision_walk(void);
+int prepare_revision_walk(struct rev_info *revs);
+struct commit *get_revision(struct rev_info *revs);
+char *get_revision_mark(const struct rev_info *revs,
+			const struct commit *commit);
+void put_revision_mark(const struct rev_info *revs,
+		       const struct commit *commit);
 
-extern void mark_parents_uninteresting(struct commit *commit);
-extern void mark_tree_uninteresting(struct tree *tree);
+void mark_parents_uninteresting(struct commit *commit);
+void mark_tree_uninteresting(struct tree *tree);
 
-extern void show_object_with_name(FILE *, struct object *, const char *);
+void show_object_with_name(FILE *, struct object *, const char *);
 
-extern void add_pending_object(struct rev_info *revs,
-			       struct object *obj, const char *name);
-extern void add_pending_oid(struct rev_info *revs,
-			    const char *name, const struct object_id *oid,
-			    unsigned int flags);
+void add_pending_object(struct rev_info *revs,
+			struct object *obj, const char *name);
+void add_pending_oid(struct rev_info *revs,
+		     const char *name, const struct object_id *oid,
+		     unsigned int flags);
 
-extern void add_head_to_pending(struct rev_info *);
-extern void add_reflogs_to_pending(struct rev_info *, unsigned int flags);
-extern void add_index_objects_to_pending(struct rev_info *, unsigned int flags);
+void add_head_to_pending(struct rev_info *);
+void add_reflogs_to_pending(struct rev_info *, unsigned int flags);
+void add_index_objects_to_pending(struct rev_info *, unsigned int flags);
 
 enum commit_action {
 	commit_ignore,
@@ -288,10 +288,10 @@ enum commit_action {
 	commit_error
 };
 
-extern enum commit_action get_commit_action(struct rev_info *revs,
-					    struct commit *commit);
-extern enum commit_action simplify_commit(struct rev_info *revs,
-					  struct commit *commit);
+enum commit_action get_commit_action(struct rev_info *revs,
+				     struct commit *commit);
+enum commit_action simplify_commit(struct rev_info *revs,
+				   struct commit *commit);
 
 enum rewrite_result {
 	rewrite_one_ok,
@@ -301,8 +301,9 @@ enum rewrite_result {
 
 typedef enum rewrite_result (*rewrite_parent_fn_t)(struct rev_info *revs, struct commit **pp);
 
-extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
-	rewrite_parent_fn_t rewrite_parent);
+int rewrite_parents(struct rev_info *revs,
+		    struct commit *commit,
+		    rewrite_parent_fn_t rewrite_parent);
 
 /*
  * The log machinery saves the original parent list so that
@@ -313,6 +314,6 @@ extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
  * get_saved_parents() will transparently return commit->parents if
  * history simplification is off.
  */
-extern struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
+struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
 #endif
-- 
2.18.0.rc2.476.g39500d3211


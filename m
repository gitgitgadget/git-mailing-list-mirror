Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBF31F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIVX7k (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41890 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbeIVX7j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so13583043lfc.8
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQNPFTymY/xrhi/XeH7gGuLhDGmMl0U+6ewdYUKsvs8=;
        b=GabTtX4qYVt2VTz5Vj+F5GZ1MQ66yFuRyPI2+Tg6O+gbw/pACz5mG/QKpKecn5n9tq
         jHJSTauJBeih8QjNxfDaQAVhi54eiET8NnMwi0WGVi7tUH6V39JK7nB9Vo4+NGAG1Hu7
         ey1RxGOTvf6+KU/LY7fjh94dyR3/dSlp0L/2sz/oBN4Zh90YvqP/bOO4bXEZj5/914bD
         xjvHu+NJyH+2MijGo76H0zB28GQANWmRGKd3beoGg1M6pgUtRqSzuZgYwKjz42Lpt0gw
         ic2/2mweysDOmD5NLJfoOU4RZRov420EYTiOP3dTVV12bRHtxVexAVSgkrvCnB5IeDYf
         rcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQNPFTymY/xrhi/XeH7gGuLhDGmMl0U+6ewdYUKsvs8=;
        b=S+hfvnotBw2+svWrVM1d8o+4vTaR/Uwl7IsYOh9xTnrQxR1i1nzW0JBIX+qpXnhFFr
         40jeGreQsKqNUa8r0yAn66xxqqEGVjfksxI4y4ZNCqsfhhHQyAtZO/SMDzZBaQIjuyzX
         N+nbvJ7DG2MfFBRVO7cFcJaAwp/SP95M5jlWKHp2ThvN4F04MdPfiZbqLZ9fCtNRZ/9m
         rIu3FiGQk+rR/a4UVkp2uexo6S4HXe/WAxDx1PTw3cy9qz1+2Z4Qpw1+/zVpO8HJNylo
         gxGEA2ddV2YDkA0U5Ywdwv7fvfRYOvfjG+W2cD8VN4FL2DQDbeR/cUGYhq6NPpW9u44w
         Hx8g==
X-Gm-Message-State: APzg51D2zYKsSr1C9mgipYPKein5R98Pdf9yAyB+M/Knok9O1h7ATb6s
        9Zjq3q6EVhr1KghbExLNEwGxn5Qa
X-Google-Smtp-Source: ANB0VdazAyPkZlmyO3iDMlK9dpC9DMqWG3qjwS4XShnBUM9NC9NGtodu8ZlQTfCDPQSc65oQ8cEDag==
X-Received: by 2002:a19:cd8c:: with SMTP id d134-v6mr1874694lfg.41.1537639511729;
        Sat, 22 Sep 2018 11:05:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/8] revision.c: better error reporting on ref from different worktrees
Date:   Sat, 22 Sep 2018 20:04:57 +0200
Message-Id: <20180922180500.4689-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the new ref aliases to pass refs from another worktree
around and access them from the current ref store instead. This does
not change any functionality, but when a problem shows up, we would
report something like

    fatal: bad object worktrees/ztemp/HEAD
    warning: reflog of 'main/HEAD' references pruned commits

instead of

    fatal: bad object HEAD
    warning: reflog of 'HEAD' references pruned commits

which does not really tell where the refs are from.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 21 +++++++++++++--------
 worktree.c | 32 +++++++++++++++++++++++++++++---
 worktree.h | 14 ++++++++++++++
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/revision.c b/revision.c
index 63aae722c1..8ce660e3b1 100644
--- a/revision.c
+++ b/revision.c
@@ -1177,7 +1177,7 @@ struct all_refs_cb {
 	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
-	struct ref_store *refs;
+	struct worktree *wt;
 };
 
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1214,7 +1214,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	cb->all_revs = revs;
 	cb->all_flags = flags;
 	revs->rev_input_given = 1;
-	cb->refs = NULL;
+	cb->wt = NULL;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1277,15 +1277,20 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static int handle_one_reflog(const char *refname,
+static int handle_one_reflog(const char *refname_in_wt,
 			     const struct object_id *oid,
 			     int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
+	struct strbuf refname = STRBUF_INIT;
+
 	cb->warned_bad_reflog = 0;
-	cb->name_for_errormsg = refname;
-	refs_for_each_reflog_ent(cb->refs, refname,
+	strbuf_worktree_ref(cb->wt, &refname, refname_in_wt);
+	cb->name_for_errormsg = refname.buf;
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+				 refname.buf,
 				 handle_one_reflog_ent, cb_data);
+	strbuf_release(&refname);
 	return 0;
 }
 
@@ -1300,8 +1305,8 @@ static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
 		if (wt->is_current)
 			continue;
 
-		cb->refs = get_worktree_ref_store(wt);
-		refs_for_each_reflog(cb->refs,
+		cb->wt = wt;
+		refs_for_each_reflog(get_worktree_ref_store(wt),
 				     handle_one_reflog,
 				     cb);
 	}
@@ -1314,7 +1319,7 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.refs = get_main_ref_store(the_repository);
+	cb.wt = NULL;
 	for_each_reflog(handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
diff --git a/worktree.c b/worktree.c
index b0d0b5426d..ec1a5bc511 100644
--- a/worktree.c
+++ b/worktree.c
@@ -487,6 +487,28 @@ int submodule_uses_worktrees(const char *path)
 	return ret;
 }
 
+void strbuf_worktree_ref(const struct worktree *wt,
+			 struct strbuf *sb,
+			 const char *refname)
+{
+	if (wt && !wt->is_current) {
+		if (is_main_worktree(wt))
+			strbuf_addstr(sb, "main/");
+		else
+			strbuf_addf(sb, "worktrees/%s/", wt->id);
+	}
+	strbuf_addstr(sb, refname);
+}
+
+const char *worktree_ref(const struct worktree *wt, const char *refname)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
+	strbuf_worktree_ref(wt, &sb, refname);
+	return sb.buf;
+}
+
 int other_head_refs(each_ref_fn fn, void *cb_data)
 {
 	struct worktree **worktrees, **p;
@@ -495,13 +517,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	worktrees = get_worktrees(0);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct ref_store *refs;
+		struct object_id oid;
+		int flag;
 
 		if (wt->is_current)
 			continue;
 
-		refs = get_worktree_ref_store(wt);
-		ret = refs_head_ref(refs, fn, cb_data);
+		if (!refs_read_ref_full(get_main_ref_store(the_repository),
+					worktree_ref(wt, "HEAD"),
+					RESOLVE_REF_READING,
+					&oid, &flag))
+			ret = fn(worktree_ref(wt, "HEAD"), &oid, flag, cb_data);
 		if (ret)
 			break;
 	}
diff --git a/worktree.h b/worktree.h
index df3fc30f73..0016eb9e88 100644
--- a/worktree.h
+++ b/worktree.h
@@ -108,4 +108,18 @@ extern const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+/*
+ * Return a refname suitable for access from the current ref store.
+ */
+void strbuf_worktree_ref(const struct worktree *wt,
+			 struct strbuf *sb,
+			 const char *refname);
+
+/*
+ * Return a refname suitable for access from the current ref
+ * store. The result may be destroyed at the next call.
+ */
+const char *worktree_ref(const struct worktree *wt,
+			 const char *refname);
+
 #endif
-- 
2.19.0.647.gb9a6049235


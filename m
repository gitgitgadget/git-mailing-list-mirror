Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4855220248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfC3LVe (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45648 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfC3LVd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so2210442plb.12
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zkk+sKvuQ3qNLst7Ye1UEl3IZh2DQklA0UBtoCRshnY=;
        b=FHt/9dv5aYRrEe/DzjT1mw8paF8Inoe/Klv9V4osYrYBd/sM57bE9fI2oR0n4MI8RX
         //LvLH6LhTU/dzkh6oAJGElxM+ng9qmf+BFBpdaVBhPPeSxfl05/1y1QGAAj09CAbLmU
         vT8LycoI//QrL9FuFYr/dnLsHcNb60yIlZEls4aDZBeK60/8oTVsomexoJFaKPmHqchU
         b4BNnI1E7trFaCVrMMsLCcOjcilQ2bku4R/oea5A8zMxYaSO4K/ePsL5wJC97f8EGmxF
         BicfcLSS3axvZGQSZeBj9cXiOZOtNB3PfqWJn+8EPo1s4XUseNEwOYZGbRoUgaaz0XNX
         cIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zkk+sKvuQ3qNLst7Ye1UEl3IZh2DQklA0UBtoCRshnY=;
        b=ckvD78c89AdZiVpYgSkgw8ibMikdT08bsy5B3+njaHSmCZOM80h3zJfIS0n5f1zTsJ
         SjMGo6bUuTu/fmJDFXX8Dy+QTYPJCc0uDI1XCFifDGGCJACTGBiTDs6NsX/SHGH0bagD
         cJwcJZWzickBM2QYdmQA6FQB+pG9RxxLXGjefcksuf1Hk94gRkz2hEO4bZvW2cAPFCf/
         i48U6naG64z4ks58VKf30lHe8YXGvPA3NHjqZum8+Gjm3m2vc1NN1GyOo5K3aZm+fHtF
         DcphWOiGAzUFH4U0AgXNh5viKh82BzuaW1DF0LHykSi1ks50xBqsG/RXbP7o+o07gyWG
         jdeQ==
X-Gm-Message-State: APjAAAW3Q0YYSzJoBP32h5rzkj8ZbK2W+5EDVyy1UgTCuP0xbSJEbBmB
        Gg3JGL6qTepEqJ5wlsCb+53rEHzF
X-Google-Smtp-Source: APXvYqzV3yABX4UQ0JJCfFLEQal44311ImdxCpXnZMtyQw8ChrA+68enc/PcvO/B5PmPg/ImpRGKlQ==
X-Received: by 2002:a17:902:7c0f:: with SMTP id x15mr15770822pll.338.1553944892903;
        Sat, 30 Mar 2019 04:21:32 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id p81sm9093424pfi.186.2019.03.30.04.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/31] sha1-name.c: store and use repo in struct disambiguate_state
Date:   Sat, 30 Mar 2019 18:19:09 +0700
Message-Id: <20190330111927.18645-14-pclouds@gmail.com>
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
 sha1-name.c | 95 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 36 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 9b57787b76..a75992eb54 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -17,13 +17,14 @@
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
-typedef int (*disambiguate_hint_fn)(const struct object_id *, void *);
+typedef int (*disambiguate_hint_fn)(struct repository *, const struct object_id *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
 	char hex_pfx[GIT_MAX_HEXSZ + 1];
 	struct object_id bin_pfx;
 
+	struct repository *repo;
 	disambiguate_hint_fn fn;
 	void *cb_data;
 	struct object_id candidate;
@@ -38,7 +39,7 @@ struct disambiguate_state {
 static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
 {
 	if (ds->always_call_fn) {
-		ds->ambiguous = ds->fn(current, ds->cb_data) ? 1 : 0;
+		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
 		return;
 	}
 	if (!ds->candidate_exists) {
@@ -58,7 +59,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	}
 
 	if (!ds->candidate_checked) {
-		ds->candidate_ok = ds->fn(&ds->candidate, ds->cb_data);
+		ds->candidate_ok = ds->fn(ds->repo, &ds->candidate, ds->cb_data);
 		ds->disambiguate_fn_used = 1;
 		ds->candidate_checked = 1;
 	}
@@ -71,7 +72,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	}
 
 	/* if we reach this point, we know ds->candidate satisfies fn */
-	if (ds->fn(current, ds->cb_data)) {
+	if (ds->fn(ds->repo, current, ds->cb_data)) {
 		/*
 		 * if both current and candidate satisfy fn, we cannot
 		 * disambiguate.
@@ -89,9 +90,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct object_directory *odb;
 
-	for (odb = the_repository->objects->odb;
-	     odb && !ds->ambiguous;
-	     odb = odb->next) {
+	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next) {
 		int pos;
 		struct oid_array *loose_objects;
 
@@ -182,10 +181,10 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(the_repository); m && !ds->ambiguous;
+	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
 	     m = m->next)
 		unique_in_midx(m, ds);
-	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
+	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -215,7 +214,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 		 * same repository!
 		 */
 		ds->candidate_ok = (!ds->disambiguate_fn_used ||
-				    ds->fn(&ds->candidate, ds->cb_data));
+				    ds->fn(ds->repo, &ds->candidate, ds->cb_data));
 
 	if (!ds->candidate_ok)
 		return SHORT_NAME_AMBIGUOUS;
@@ -224,59 +223,67 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
-static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_commit_only(struct repository *r,
+				    const struct object_id *oid,
+				    void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_COMMIT;
 }
 
-static int disambiguate_committish_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_committish_only(struct repository *r,
+					const struct object_id *oid,
+					void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(the_repository, oid, NULL);
+	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(the_repository, parse_object(the_repository, oid),
-			NULL, 0);
+	obj = deref_tag(r, parse_object(r, oid), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
 }
 
-static int disambiguate_tree_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_tree_only(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
-static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_treeish_only(struct repository *r,
+				     const struct object_id *oid,
+				     void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(the_repository, oid, NULL);
+	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(the_repository, parse_object(the_repository, oid),
-			NULL, 0);
+	obj = deref_tag(r, parse_object(r, oid), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
 }
 
-static int disambiguate_blob_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_blob_only(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -310,7 +317,8 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 	return error("unknown hint type for '%s': %s", var, value);
 }
 
-static int init_object_disambiguation(const char *name, int len,
+static int init_object_disambiguation(struct repository *r,
+				      const char *name, int len,
 				      struct disambiguate_state *ds)
 {
 	int i;
@@ -341,7 +349,8 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb(the_repository);
+	ds->repo = r;
+	prepare_alt_odb(r);
 	return 0;
 }
 
@@ -351,25 +360,25 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
-	if (ds->fn && !ds->fn(oid, ds->cb_data))
+	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
 
-	type = oid_object_info(the_repository, oid, NULL);
+	type = oid_object_info(ds->repo, oid, NULL);
 	if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(the_repository, oid);
+		struct commit *commit = lookup_commit(ds->repo, oid);
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(the_repository, oid);
+		struct tag *tag = lookup_tag(ds->repo, oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
 
 	advise("  %s %s%s",
-	       find_unique_abbrev(oid, DEFAULT_ABBREV),
+	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
 	       type_name(type) ? type_name(type) : "unknown type",
 	       desc.buf);
 
@@ -383,6 +392,13 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int repo_collect_ambiguous(struct repository *r,
+				  const struct object_id *oid,
+				  void *data)
+{
+	return collect_ambiguous(oid, data);
+}
+
 static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
@@ -428,7 +444,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
-	if (init_object_disambiguation(name, len, &ds) < 0)
+	if (init_object_disambiguation(the_repository, name, len, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -483,11 +499,11 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(prefix, strlen(prefix), &ds) < 0)
+	if (init_object_disambiguation(the_repository, prefix, strlen(prefix), &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
-	ds.fn = collect_ambiguous;
+	ds.fn = repo_collect_ambiguous;
 	ds.cb_data = &collect;
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
@@ -543,6 +559,13 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static int repo_extend_abbrev_len(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data)
+{
+	return extend_abbrev_len(oid, cb_data);
+}
+
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
 				     struct min_abbrev_data *mad)
 {
@@ -668,10 +691,10 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 
 	find_abbrev_len_packed(&mad);
 
-	if (init_object_disambiguation(hex, mad.cur_len, &ds) < 0)
+	if (init_object_disambiguation(r, hex, mad.cur_len, &ds) < 0)
 		return -1;
 
-	ds.fn = extend_abbrev_len;
+	ds.fn = repo_extend_abbrev_len;
 	ds.always_call_fn = 1;
 	ds.cb_data = (void *)&mad;
 
-- 
2.21.0.479.g47ac719cd3


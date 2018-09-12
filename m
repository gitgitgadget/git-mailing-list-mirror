Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8F11F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeIMAiG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:38:06 -0400
Received: from mout.web.de ([212.227.15.14]:50863 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeIMAiG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:38:06 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MX0VQ-1gNBuy3uqK-00W1JC; Wed, 12
 Sep 2018 21:32:05 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] Make git_check_attr() a void function
Date:   Wed, 12 Sep 2018 21:32:02 +0200
Message-Id: <20180912193202.12896-1-tboegi@web.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ALz6a6YBZ9v/H/dn64M+7dLwq2vE+5VQc1MleyuF7G+0Pg1/wdL
 7Azbs4BepSDUu+EUKomKV2eSMdlHodZsAOcuk2bu39SjXRu9hsYWcCguylhntjt5x3HdVXE
 zQDr1uvwFkNQTAkAc18Ta0x81RA3KGhS9yShpBd/A3Hr/LjS+W43wFO4vQtFKSsc5rBm+cV
 CWupL/sUe1aTleWO3dWWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cMWzEXYxen4=:5PTq0kWWd8dzW1qC84wQ1K
 I/IwVBvWGUMVTT8edbNrFaIFEAOT/+m5gshgUxb1gkdoa9Da6scNSQeVw6Qor939n7HDTr+iF
 f/wxwD5eq1azOENlppZp9ZvrEOMd0pvnWHnp6wVYZdh0DKWiuM6y/S4lsnZcxaseAXETNFPQq
 WMkVyivZ1sm5Yk9GhJFS6IRphl3hqdPnWCMFmN2xTciGf35CUmILESP0cAXpibUYfp8/GJsNl
 Nt3F3rGK6dP83aY4vJlfBeOMWfV+VZHHEo74AEdEZQfHCpbfGuTfRdMqw+gh7Q9GeA8gMxuPl
 4EZpq/+QQyFkzZQUeqI2slnZEOCqq4B1KEzXSqQL5cwuOp2a+TG9Ym3tvsYV2g/QHga0Y0vNd
 eZuBVL+Lv53ePCDXfqJRtnBaKo+HxBR7d/27QTryks64TDedWaWQJPRyhP+L8xIiu2kz9AZ4n
 Wp1QJgECh2MhV3fkLmRflMrtFtxHmt1kz6VUU+MV/el5eKkAYJ4eYZhWhQuzeyinKnGR+ntxC
 QR1f6pAh5wZov3FADNlG0k3oF4Aaoek5psRoC/z8DaKnL82Saa8AdNRNyoAx4YbdiGyBhQZ9s
 d2TCXC6N2/+7axo2S+D9Qm/wqigHl3CIfslnbetZxgJNkEuJ8cVKa0COqh4acX8XoFF3HuI7l
 2RH+hTOb9YB07Wg4mKJxzE3qcTIvhBBln8AL6r35hThPLx7SwOVsEGHw90pUMfzQAskWVmFNI
 5S3w/yjyntvxLipsiNl33bYfURJbJ7HAmz5jKDi7N7LHBoOzMnGDimO8MqYkqUvsld7PMsHI3
 l0koKAla5XRcxE1d10pGS9PoeWlOHGCw8WhExpuL3ycJoK9/vA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

git_check_attr() returns always 0.
Remove all the error handling code of the callers, which is never executed.
Change git_check_attr() to be a void function.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 archive.c              |  3 ++-
 attr.c                 |  8 +++-----
 attr.h                 |  4 ++--
 builtin/check-attr.c   |  3 +--
 builtin/pack-objects.c |  3 +--
 convert.c              | 42 ++++++++++++++++++----------------------
 ll-merge.c             | 16 +++++++--------
 userdiff.c             |  3 +--
 ws.c                   | 44 +++++++++++++++++++-----------------------
 9 files changed, 57 insertions(+), 69 deletions(-)

diff --git a/archive.c b/archive.c
index 0a07b140fe..c1870105eb 100644
--- a/archive.c
+++ b/archive.c
@@ -110,7 +110,8 @@ static const struct attr_check *get_archive_attrs(struct index_state *istate,
 	static struct attr_check *check;
 	if (!check)
 		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	return git_check_attr(istate, path, check) ? NULL : check;
+	git_check_attr(istate, path, check);
+	return check;
 }
 
 static int check_attr_export_ignore(const struct attr_check *check)
diff --git a/attr.c b/attr.c
index 98e4953f6e..60d284796d 100644
--- a/attr.c
+++ b/attr.c
@@ -1143,9 +1143,9 @@ static void collect_some_attrs(const struct index_state *istate,
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
-int git_check_attr(const struct index_state *istate,
-		   const char *path,
-		   struct attr_check *check)
+void git_check_attr(const struct index_state *istate,
+		    const char *path,
+		    struct attr_check *check)
 {
 	int i;
 
@@ -1158,8 +1158,6 @@ int git_check_attr(const struct index_state *istate,
 			value = ATTR__UNSET;
 		check->items[i].value = value;
 	}
-
-	return 0;
 }
 
 void git_all_attrs(const struct index_state *istate,
diff --git a/attr.h b/attr.h
index 2be86db36e..b0378bfe5f 100644
--- a/attr.h
+++ b/attr.h
@@ -63,8 +63,8 @@ void attr_check_free(struct attr_check *check);
  */
 const char *git_attr_name(const struct git_attr *);
 
-int git_check_attr(const struct index_state *istate,
-		   const char *path, struct attr_check *check);
+void git_check_attr(const struct index_state *istate,
+		    const char *path, struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index c05573ff9c..30a2f84274 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -65,8 +65,7 @@ static void check_attr(const char *prefix,
 	if (collect_all) {
 		git_all_attrs(&the_index, full_path, check);
 	} else {
-		if (git_check_attr(&the_index, full_path, check))
-			die("git_check_attr died");
+		git_check_attr(&the_index, full_path, check);
 	}
 	output_attr(check, file);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d1144a8f7e..eb71dab5be 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -951,8 +951,7 @@ static int no_try_delta(const char *path)
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
-	if (git_check_attr(&the_index, path, check))
-		return 0;
+	git_check_attr(&the_index, path, check);
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
 	return 0;
diff --git a/convert.c b/convert.c
index 6057f1f580..e0848226d2 100644
--- a/convert.c
+++ b/convert.c
@@ -1297,6 +1297,7 @@ static void convert_attrs(const struct index_state *istate,
 			  struct conv_attrs *ca, const char *path)
 {
 	static struct attr_check *check;
+	struct attr_check_item *ccheck = NULL;
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
@@ -1306,30 +1307,25 @@ static void convert_attrs(const struct index_state *istate,
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(istate, path, check)) {
-		struct attr_check_item *ccheck = check->items;
-		ca->crlf_action = git_path_check_crlf(ccheck + 4);
-		if (ca->crlf_action == CRLF_UNDEFINED)
-			ca->crlf_action = git_path_check_crlf(ccheck + 0);
-		ca->ident = git_path_check_ident(ccheck + 1);
-		ca->drv = git_path_check_convert(ccheck + 2);
-		if (ca->crlf_action != CRLF_BINARY) {
-			enum eol eol_attr = git_path_check_eol(ccheck + 3);
-			if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_LF)
-				ca->crlf_action = CRLF_AUTO_INPUT;
-			else if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_CRLF)
-				ca->crlf_action = CRLF_AUTO_CRLF;
-			else if (eol_attr == EOL_LF)
-				ca->crlf_action = CRLF_TEXT_INPUT;
-			else if (eol_attr == EOL_CRLF)
-				ca->crlf_action = CRLF_TEXT_CRLF;
-		}
-		ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
-	} else {
-		ca->drv = NULL;
-		ca->crlf_action = CRLF_UNDEFINED;
-		ca->ident = 0;
+	git_check_attr(istate, path, check);
+	ccheck = check->items;
+	ca->crlf_action = git_path_check_crlf(ccheck + 4);
+	if (ca->crlf_action == CRLF_UNDEFINED)
+		ca->crlf_action = git_path_check_crlf(ccheck + 0);
+	ca->ident = git_path_check_ident(ccheck + 1);
+	ca->drv = git_path_check_convert(ccheck + 2);
+	if (ca->crlf_action != CRLF_BINARY) {
+		enum eol eol_attr = git_path_check_eol(ccheck + 3);
+		if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_LF)
+			ca->crlf_action = CRLF_AUTO_INPUT;
+		else if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_CRLF)
+			ca->crlf_action = CRLF_AUTO_CRLF;
+		else if (eol_attr == EOL_LF)
+			ca->crlf_action = CRLF_TEXT_INPUT;
+		else if (eol_attr == EOL_CRLF)
+			ca->crlf_action = CRLF_TEXT_CRLF;
 	}
+	ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
 
 	/* Save attr and make a decision for action */
 	ca->attr_action = ca->crlf_action;
diff --git a/ll-merge.c b/ll-merge.c
index 0e2800f7bb..1936fee9e1 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -371,13 +371,12 @@ int ll_merge(mmbuffer_t *result_buf,
 	if (!check)
 		check = attr_check_initl("merge", "conflict-marker-size", NULL);
 
-	if (!git_check_attr(&the_index, path, check)) {
-		ll_driver_name = check->items[0].value;
-		if (check->items[1].value) {
-			marker_size = atoi(check->items[1].value);
-			if (marker_size <= 0)
-				marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
-		}
+	git_check_attr(&the_index, path, check);
+	ll_driver_name = check->items[0].value;
+	if (check->items[1].value) {
+		marker_size = atoi(check->items[1].value);
+		if (marker_size <= 0)
+			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
 	driver = find_ll_merge_driver(ll_driver_name);
 
@@ -398,7 +397,8 @@ int ll_merge_marker_size(const char *path)
 
 	if (!check)
 		check = attr_check_initl("conflict-marker-size", NULL);
-	if (!git_check_attr(&the_index, path, check) && check->items[0].value) {
+	git_check_attr(&the_index, path, check);
+	if (check->items[0].value) {
 		marker_size = atoi(check->items[0].value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/userdiff.c b/userdiff.c
index f3f4be579c..f565f6731d 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -278,8 +278,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	if (git_check_attr(&the_index, path, check))
-		return NULL;
+	git_check_attr(&the_index, path, check);
 
 	if (ATTR_TRUE(check->items[0].value))
 		return &driver_true;
diff --git a/ws.c b/ws.c
index 5b67b426e7..a64ab51e09 100644
--- a/ws.c
+++ b/ws.c
@@ -74,35 +74,31 @@ unsigned parse_whitespace_rule(const char *string)
 unsigned whitespace_rule(const char *pathname)
 {
 	static struct attr_check *attr_whitespace_rule;
+	const char *value;
 
 	if (!attr_whitespace_rule)
 		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	if (!git_check_attr(&the_index, pathname, attr_whitespace_rule)) {
-		const char *value;
-
-		value = attr_whitespace_rule->items[0].value;
-		if (ATTR_TRUE(value)) {
-			/* true (whitespace) */
-			unsigned all_rule = ws_tab_width(whitespace_rule_cfg);
-			int i;
-			for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
-				if (!whitespace_rule_names[i].loosens_error &&
-				    !whitespace_rule_names[i].exclude_default)
-					all_rule |= whitespace_rule_names[i].rule_bits;
-			return all_rule;
-		} else if (ATTR_FALSE(value)) {
-			/* false (-whitespace) */
-			return ws_tab_width(whitespace_rule_cfg);
-		} else if (ATTR_UNSET(value)) {
-			/* reset to default (!whitespace) */
-			return whitespace_rule_cfg;
-		} else {
-			/* string */
-			return parse_whitespace_rule(value);
-		}
-	} else {
+	git_check_attr(&the_index, pathname, attr_whitespace_rule);
+	value = attr_whitespace_rule->items[0].value;
+	if (ATTR_TRUE(value)) {
+		/* true (whitespace) */
+		unsigned all_rule = ws_tab_width(whitespace_rule_cfg);
+		int i;
+		for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
+			if (!whitespace_rule_names[i].loosens_error &&
+			    !whitespace_rule_names[i].exclude_default)
+				all_rule |= whitespace_rule_names[i].rule_bits;
+		return all_rule;
+	} else if (ATTR_FALSE(value)) {
+		/* false (-whitespace) */
+		return ws_tab_width(whitespace_rule_cfg);
+	} else if (ATTR_UNSET(value)) {
+		/* reset to default (!whitespace) */
 		return whitespace_rule_cfg;
+	} else {
+		/* string */
+		return parse_whitespace_rule(value);
 	}
 }
 
-- 
2.18.0


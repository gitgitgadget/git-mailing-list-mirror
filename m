Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DA21F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbdL0KUU (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:20:20 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34231 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdL0KUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:20:19 -0500
Received: by mail-pf0-f194.google.com with SMTP id a90so19650049pfk.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acdFTl5YL9Dq9ShObAewmYSTg32qh9r5OJ9PvfGBQGk=;
        b=Z3SYTrMbGTWXAnpM/8XfKS7y7wKJCplA8g6z7McTj5cYxxXG0utk5dyUaUXHeO03Tt
         C/s76oqSbQYeaJtjbWp9XhGwYQb7YXcAmi1hXst/2LSZaJXezlCJ7Iz/VtxvMaqf+Dty
         g/51SBevyHLsNtnloujgZoBMm6S3nwlGphNjmjUYvdFelz6CsOF9dbgObUeQb4J7hOfN
         2AmcHLoLb4w2ruZLiIfRUEMQPps+Hkm7LDwkkb8RFbb0CIiPqwFVwW7/VEexpd2o6mJ8
         w3N3tQgnPXSnxYoTx6Ul4Gq2oNN/9hCJ0+UAiSVy75NGmNgzfs6NLU302cjyIL6ZGRyg
         5k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acdFTl5YL9Dq9ShObAewmYSTg32qh9r5OJ9PvfGBQGk=;
        b=hMMNZb+dH3yNh96vXf/J+zORbkEqib+4Mc9rDDW+ydRCoax70Ep8+hkTGkquYC/gFU
         vGKno+y4KJCs9Xfehi34mzzfF913kMFrMgXxaiDpYKkUxTqQTmQCzrqaJM7QO/eqPF+b
         8faHgzyI7Sf5xUBopha5ixMACizBk75+rW6olgS6qBhJ81su+bWmgbr9nyeM5CuP33r6
         WvSIlFv92Frl9mus0smIuLouhz+og2bV6/1IBSAP2HUnk2WJozH3nrs2Qh2s/LYBSJK3
         4JIcwv7Pi/x2lQE8W2AWOJJydCW00Xfw2AHK1Ll/x+LgIjcp8PaB/D5jIuM9xSOZpcFB
         LoLQ==
X-Gm-Message-State: AKGB3mJD9BB6bVpWC3rjTHzL+HmR8msR8QLq20Uvpsyeb023XSokXE0F
        BA5kExXC27SyjbvPGB7ty1Uldw==
X-Google-Smtp-Source: ACJfBouyZWUMTjLYSlnH2nupP3B+Ejin6AkR53oRNZo8HPFyp/hwe5QYWCP7TKws1XVG0a9adARqfA==
X-Received: by 10.99.108.4 with SMTP id h4mr6831812pgc.113.1514370018797;
        Wed, 27 Dec 2017 02:20:18 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id u81sm69046792pfa.70.2017.12.27.02.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:20:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:20:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 5/6] wt-status.c: rename rename-related fields in wt_status_change_data
Date:   Wed, 27 Dec 2017 17:18:38 +0700
Message-Id: <20171227101839.26427-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171227101839.26427-1-pclouds@gmail.com>
References: <20171226091012.24315-1-pclouds@gmail.com>
 <20171227101839.26427-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These field "head_path" is used for rename display only. In the next
patch we introduce another rename pair where the rename source is no
longer HEAD. Rename it to something more generic.

While at there, rename "score" as well and store the rename diff code
in a separate field instead of hardcoding key[0] (i.e. diff-index) in
porcelain v2 code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 wt-status.c | 50 ++++++++++++++++++++++++++------------------------
 wt-status.h |  5 +++--
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 05af895fe2..fab6951573 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -360,8 +360,8 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	switch (change_type) {
 	case WT_STATUS_UPDATED:
 		status = d->index_status;
-		if (d->head_path)
-			one_name = d->head_path;
+		if (d->rename_source)
+			one_name = d->rename_source;
 		break;
 	case WT_STATUS_CHANGED:
 		if (d->new_submodule_commits || d->dirty_submodule) {
@@ -391,7 +391,7 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 		die("BUG: unhandled diff status %c", status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
-	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
+	if (one_name != two_name)
 		status_printf_more(s, c, "%s%.*s%s -> %s",
 				   what, len, padding, one, two);
 	else
@@ -531,8 +531,9 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
-			d->head_path = xstrdup(p->one->path);
-			d->score = p->score * 100 / MAX_SCORE;
+			d->rename_source = xstrdup(p->one->path);
+			d->rename_score = p->score * 100 / MAX_SCORE;
+			d->rename_status = p->status;
 			/* fallthru */
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
@@ -1724,13 +1725,14 @@ static void wt_shortstatus_status(struct string_list_item *it,
 	putchar(' ');
 	if (s->null_termination) {
 		fprintf(stdout, "%s%c", it->string, 0);
-		if (d->head_path)
-			fprintf(stdout, "%s%c", d->head_path, 0);
+		if (d->rename_source)
+			fprintf(stdout, "%s%c", d->rename_source, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
-		if (d->head_path) {
-			one = quote_path(d->head_path, s->prefix, &onebuf);
+
+		if (d->rename_source) {
+			one = quote_path(d->rename_source, s->prefix, &onebuf);
 			if (*one != '"' && strchr(one, ' ') != NULL) {
 				putchar('"');
 				strbuf_addch(&onebuf, '"');
@@ -2035,10 +2037,10 @@ static void wt_porcelain_v2_print_changed_entry(
 	struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
-	struct strbuf buf_index = STRBUF_INIT;
-	struct strbuf buf_head = STRBUF_INIT;
-	const char *path_index = NULL;
-	const char *path_head = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf_from = STRBUF_INIT;
+	const char *path = NULL;
+	const char *path_from = NULL;
 	char key[3];
 	char submodule_token[5];
 	char sep_char, eol_char;
@@ -2057,8 +2059,8 @@ static void wt_porcelain_v2_print_changed_entry(
 		 */
 		sep_char = '\0';
 		eol_char = '\0';
-		path_index = it->string;
-		path_head = d->head_path;
+		path = it->string;
+		path_from = d->rename_source;
 	} else {
 		/*
 		 * Path(s) are C-quoted if necessary. Current path is ALWAYS first.
@@ -2068,27 +2070,27 @@ static void wt_porcelain_v2_print_changed_entry(
 		 */
 		sep_char = '\t';
 		eol_char = '\n';
-		path_index = quote_path(it->string, s->prefix, &buf_index);
-		if (d->head_path)
-			path_head = quote_path(d->head_path, s->prefix, &buf_head);
+		path = quote_path(it->string, s->prefix, &buf);
+		if (d->rename_source)
+			path_from = quote_path(d->rename_source, s->prefix, &buf_from);
 	}
 
-	if (path_head)
+	if (path_from)
 		fprintf(s->fp, "2 %s %s %06o %06o %06o %s %s %c%d %s%c%s%c",
 				key, submodule_token,
 				d->mode_head, d->mode_index, d->mode_worktree,
 				oid_to_hex(&d->oid_head), oid_to_hex(&d->oid_index),
-				key[0], d->score,
-				path_index, sep_char, path_head, eol_char);
+				d->rename_status, d->rename_score,
+				path, sep_char, path_from, eol_char);
 	else
 		fprintf(s->fp, "1 %s %s %06o %06o %06o %s %s %s%c",
 				key, submodule_token,
 				d->mode_head, d->mode_index, d->mode_worktree,
 				oid_to_hex(&d->oid_head), oid_to_hex(&d->oid_index),
-				path_index, eol_char);
+				path, eol_char);
 
-	strbuf_release(&buf_index);
-	strbuf_release(&buf_head);
+	strbuf_release(&buf);
+	strbuf_release(&buf_from);
 }
 
 /*
diff --git a/wt-status.h b/wt-status.h
index fe27b465e2..3f84d5c29f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -44,10 +44,11 @@ struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
 	int stagemask;
-	int score;
 	int mode_head, mode_index, mode_worktree;
 	struct object_id oid_head, oid_index;
-	char *head_path;
+	int rename_status;
+	int rename_score;
+	char *rename_source;
 	unsigned dirty_submodule       : 2;
 	unsigned new_submodule_commits : 1;
 };
-- 
2.15.0.320.g0453912d77


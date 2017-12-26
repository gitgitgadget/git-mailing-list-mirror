Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25211F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbdLZJK7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:10:59 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46104 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdLZJK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:10:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id r2so2211338pgq.13
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ex2STq7HRG2XRWMRs3bVuIgyPukVNbmwWwpZFVa+xFk=;
        b=Uc9cKmr8II5jDG8TGhEIvDYbPwLiY2jQOeTr6sU5YjYviqajbFiaKi+Hb6VaHTuAgg
         PzsRGx0vOxlBxHpvf0I+kCVR0TpcTDl7I0hDDHKUUoZ1Obrl71S64+BkztLkbiBLjFmb
         5aYQKIYjos4YCycerERFWIDJUkmyc+xhljEc168EdXo8DWWBG4pGDhMwd+9xv6r+25Rb
         5Rj+KIKbJVj91z9WqQIDU9qetquobfK+uxnkb0U8EtvdMYPoOUIXVxrhZFe3i3Bemsdl
         rtETvQwYSfdc/+B7271qWXMXHGksX22vgNeNcFsafqBC9waznVqxPWyrLswnNR3bG2es
         Y+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ex2STq7HRG2XRWMRs3bVuIgyPukVNbmwWwpZFVa+xFk=;
        b=h6uSp1h4L1FsQ2TMnRTFDO1eYsQ/xnyLwRCl/AK+cnBZ2VI7db864IFS/ZJarfc4pa
         bDEwiuTvZ8Ln4NSpgZktJGCe/tBAhHCU1EbYxvydsUankDJ6vJKSjgv53GltaHEdQegM
         LgbYIxXCklmvnRJ/hbTli2oOXR+vutv0ddEdsMUydg3n1MpvWzbvEcaCxXo3HjiDVSw8
         iSpMzIa1Dr3uGeNjbmgd5xoip674+ZogRGM4LcBt4u2jsRuPG2cPOejdvxzwF6CfV4rX
         Q4Y1f1sMsaSrp95rjPrQrex43FcDHVWZI/zdKwfCoE8QuHIqQ2KSSM+pyWzxwmXJVME9
         IotQ==
X-Gm-Message-State: AKGB3mJ19slPv9tIF1FzQFq7QyzslURWML9GlDzYv/YIBz6SRBEB3jt1
        5VdQF4P1NVpcZi/W/pL/Mwp1cg==
X-Google-Smtp-Source: ACJfBosNxThJYRLsRFujAqEPz5MEyhfxjjpALk4wPF0OwFDpA0SRHoPQ/tRQEeo32rluRBz45oqETg==
X-Received: by 10.99.95.135 with SMTP id t129mr21787631pgb.161.1514279458149;
        Tue, 26 Dec 2017 01:10:58 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id l13sm59805575pfj.73.2017.12.26.01.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:10:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 6/7] wt-status.c: handle worktree renames
Date:   Tue, 26 Dec 2017 16:10:11 +0700
Message-Id: <20171226091012.24315-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171226091012.24315-1-pclouds@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
in index" - 2016-10-24) there are never "new files" in the index, which
essentially disables rename detection because we only detect renames
when a new file appears in a diff pair.

After that commit, an i-t-a entry can appear as a new file in "git
diff-files". But the diff callback function in wt-status.c does not
handle this case and produces incorrect status output.

PS. The reader may notice that this patch adds a new xstrdup() but not
a free(). Yes we leak memory (the same for head_path). But wt_status
so far has been short lived, this leak should not matter in
practice.

Noticed-by: Alex Vandiver <alexmv@dropbox.com>
Helped-by: Igor Djordjevic <igor.d.djordjevic@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2203-add-intent.sh | 28 ++++++++++++++++++++
 wt-status.c           | 72 +++++++++++++++++++++++++++++++++++++++------------
 wt-status.h           |  4 +--
 3 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 878e73fe98..e5bfda1853 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -162,5 +162,33 @@ test_expect_success 'commit: ita entries ignored in empty commit check' '
 	)
 '
 
+test_expect_success 'rename detection finds the right names' '
+	git init rename-detection &&
+	(
+		cd rename-detection &&
+		echo contents > first &&
+		git add first &&
+		git commit -m first &&
+		mv first third &&
+		git add -N third &&
+
+		git status | grep -v "^?" >actual.1 &&
+		test_i18ngrep "renamed: *first -> third" actual.1 &&
+
+		git status --porcelain | grep -v "^?" >actual.2 &&
+		cat >expected.2 <<-\EOF &&
+		 R first -> third
+		EOF
+		test_cmp expected.2 actual.2 &&
+
+		oid=12f00e90b6ef79117ce6e650416b8cf517099b78 &&
+		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		cat >expected.3 <<-EOF &&
+		2 .R N... 100644 100644 100644 $oid $oid R100 first	third
+		EOF
+		test_cmp expected.3 actual.3
+	)
+'
+
 test_done
 
diff --git a/wt-status.c b/wt-status.c
index c124d7589c..d5bdf4c2e9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -376,6 +376,8 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 			strbuf_addch(&extra, ')');
 		}
 		status = d->worktree_status;
+		if (d->worktree_path)
+			two_name = d->worktree_path;
 		break;
 	default:
 		die("BUG: unhandled change_type %d in wt_longstatus_print_change_data",
@@ -460,6 +462,12 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			/* mode_worktree is zero for a delete. */
 			break;
 
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			d->worktree_path = xstrdup(p->two->path);
+			d->worktree_score = p->score * 100 / MAX_SCORE;
+			/* fallthru */
+
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 		case DIFF_STATUS_UNMERGED:
@@ -1712,6 +1720,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 			 struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
+	const char *from, *to;
 
 	if (d->index_status)
 		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
@@ -1722,15 +1731,30 @@ static void wt_shortstatus_status(struct string_list_item *it,
 	else
 		putchar(' ');
 	putchar(' ');
+
+	if (d->head_path && d->worktree_path)
+		die("BUG: to be addressed in the next patch");
+
+	if (d->head_path) {
+		from = d->head_path;
+		to = it->string;
+	} else if (d->worktree_path) {
+		from = it->string;
+		to = d->worktree_path;
+	} else {
+		from = it->string;
+		to = NULL;
+	}
 	if (s->null_termination) {
-		fprintf(stdout, "%s%c", it->string, 0);
-		if (d->head_path)
-			fprintf(stdout, "%s%c", d->head_path, 0);
+		fprintf(stdout, "%s%c", from, 0);
+		if (to)
+			fprintf(stdout, "%s%c", to, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
-		if (d->head_path) {
-			one = quote_path(d->head_path, s->prefix, &onebuf);
+
+		if (to) {
+			one = quote_path(from, s->prefix, &onebuf);
 			if (*one != '"' && strchr(one, ' ') != NULL) {
 				putchar('"');
 				strbuf_addch(&onebuf, '"');
@@ -1738,8 +1762,9 @@ static void wt_shortstatus_status(struct string_list_item *it,
 			}
 			printf("%s -> ", one);
 			strbuf_release(&onebuf);
-		}
-		one = quote_path(it->string, s->prefix, &onebuf);
+			one = quote_path(to, s->prefix, &onebuf);
+		} else
+			one = quote_path(from, s->prefix, &onebuf);
 		if (*one != '"' && strchr(one, ' ') != NULL) {
 			putchar('"');
 			strbuf_addch(&onebuf, '"');
@@ -2036,12 +2061,13 @@ static void wt_porcelain_v2_print_changed_entry(
 {
 	struct wt_status_change_data *d = it->util;
 	struct strbuf buf_index = STRBUF_INIT;
-	struct strbuf buf_head = STRBUF_INIT;
+	struct strbuf buf_other = STRBUF_INIT;
 	const char *path_index = NULL;
-	const char *path_head = NULL;
-	char key[3];
+	const char *path_other = NULL;
+	char key[3], status_other;
 	char submodule_token[5];
 	char sep_char, eol_char;
+	int score;
 
 	wt_porcelain_v2_fix_up_changed(it, s);
 	wt_porcelain_v2_submodule_state(d, submodule_token);
@@ -2050,6 +2076,19 @@ static void wt_porcelain_v2_print_changed_entry(
 	key[1] = d->worktree_status ? d->worktree_status : '.';
 	key[2] = 0;
 
+	if (d->head_path && d->worktree_path)
+		die("BUG: to be addressed in the next patch");
+
+	if (d->head_path) {
+		path_other = d->head_path;
+		status_other = d->index_status;
+		score = d->head_score;
+	} else if (d->worktree_path) {
+		path_other = d->worktree_path;
+		status_other = d->worktree_status;
+		score = d->worktree_score;
+	}
+
 	if (s->null_termination) {
 		/*
 		 * In -z mode, we DO NOT C-quote pathnames.  Current path is ALWAYS first.
@@ -2058,7 +2097,6 @@ static void wt_porcelain_v2_print_changed_entry(
 		sep_char = '\0';
 		eol_char = '\0';
 		path_index = it->string;
-		path_head = d->head_path;
 	} else {
 		/*
 		 * Path(s) are C-quoted if necessary. Current path is ALWAYS first.
@@ -2069,17 +2107,17 @@ static void wt_porcelain_v2_print_changed_entry(
 		sep_char = '\t';
 		eol_char = '\n';
 		path_index = quote_path(it->string, s->prefix, &buf_index);
-		if (d->head_path)
-			path_head = quote_path(d->head_path, s->prefix, &buf_head);
+		if (path_other)
+			path_other = quote_path(path_other, s->prefix, &buf_other);
 	}
 
-	if (path_head)
+	if (path_other)
 		fprintf(s->fp, "2 %s %s %06o %06o %06o %s %s %c%d %s%c%s%c",
 				key, submodule_token,
 				d->mode_head, d->mode_index, d->mode_worktree,
 				oid_to_hex(&d->oid_head), oid_to_hex(&d->oid_index),
-				key[0], d->head_score,
-				path_index, sep_char, path_head, eol_char);
+				status_other, score,
+				path_index, sep_char, path_other, eol_char);
 	else
 		fprintf(s->fp, "1 %s %s %06o %06o %06o %s %s %s%c",
 				key, submodule_token,
@@ -2088,7 +2126,7 @@ static void wt_porcelain_v2_print_changed_entry(
 				path_index, eol_char);
 
 	strbuf_release(&buf_index);
-	strbuf_release(&buf_head);
+	strbuf_release(&buf_other);
 }
 
 /*
diff --git a/wt-status.h b/wt-status.h
index f9330982ac..332ff545aa 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -44,10 +44,10 @@ struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
 	int stagemask;
-	int head_score;
+	int head_score, worktree_score;
 	int mode_head, mode_index, mode_worktree;
 	struct object_id oid_head, oid_index;
-	char *head_path;
+	char *head_path, *worktree_path;
 	unsigned dirty_submodule       : 2;
 	unsigned new_submodule_commits : 1;
 };
-- 
2.15.0.320.g0453912d77


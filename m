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
	by dcvr.yhbt.net (Postfix) with ESMTP id 825A61F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbdLZJLE (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:11:04 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39526 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZJLD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:11:03 -0500
Received: by mail-pl0-f68.google.com with SMTP id bi12so17607474plb.6
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRWxBO0MqSO+3xfUCBQTJUDxZuyzV8ZTVlGmg7qYSYQ=;
        b=SdtrH6CaB/Orbhz54hxfhyy00gD3JBzQXCZzrvWnq7cFeyXDn3doL8v+XExIGKOAAK
         9eSbtuCDTjIeetd4c1CFX7mg8i5YobAu+Ly8mLYUWCznREPuNzSlw89Vcw6wkwh7Y3zV
         T8lV9XHuW4BxfWKTpTuGVL5H5wiDohThQ0YEDCDpVsNzB9EG6pJ/qAUJ77lIhTnWIpLh
         /9e7OMALM2zcQlXbIHmSeBsunbP0dAydH+LugGiHFxXYeKNOnoJi6o8UaUgQH8b3Ctkb
         QKLSeoX2DhuJNcBLp/K8VqTjHKNtKgVqVFobP8dUdvod7VUFrpD/fbW8dScB1gv+/ITg
         xEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRWxBO0MqSO+3xfUCBQTJUDxZuyzV8ZTVlGmg7qYSYQ=;
        b=AAxm39kAp7dRw0lMjSLT2qL21QiMxSOmB9Cg8IzCKxh5TwMu615dwBygeQ21V3Aw92
         C+6LftOTtqhAZtYj1SXJM4h01ruDbAK1mnJcFgC3mvM7H6GqhcQeTRNZ5cZV4HjqgqJk
         fm+QZhtcpx0qYGnKyGSd+3/KdU5SI0oQJiQHbHPgGEglef6O+QMRlCiR0ZE8zw1Di6KL
         ym6tYmPwE6MQAuGFePkNu2brYYVA/L1erev/+83J9m/8DAaM3YWLsh1Baau6k/0Pxwag
         BrS1XsY8pSDA364EE0WJghytjUwe/Aqz/61KrftWXTnEC2gVyG04DSfzGvP+/LMc7Ayd
         0PtA==
X-Gm-Message-State: AKGB3mJICX11CPCYmeUI2r6XZGrQWpNOPACbn8dRODtvnVPkr3Phtxi/
        JaPwq/Js5B+unQ1yy4cWCYycrg==
X-Google-Smtp-Source: ACJfBos4UeTu8WswAN68dyJKHfp9MXHkugTvh8VejCJ1bh64tqlmioE9ESeZAc4XN3E/J+Q5R1T2eg==
X-Received: by 10.84.240.139 with SMTP id z11mr24646905plk.348.1514279463079;
        Tue, 26 Dec 2017 01:11:03 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id p87sm61584432pfi.95.2017.12.26.01.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:11:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 7/7] wt-status.c: avoid double renames in short/porcelain format
Date:   Tue, 26 Dec 2017 16:10:12 +0700
Message-Id: <20171226091012.24315-8-pclouds@gmail.com>
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

The presence of worktree rename leads to an interesting situation,
what if the same index entry is renamed twice, compared to HEAD and to
worktree? We can have that with this setup

    echo first > first && git add first && git commit -m first
    git mv first second  # rename reported in "diff --cached"
    mv second third      # rename reported in "diff-files"

For the long format this is fine because we print two "->" rename
lines, one in the "updated" section, one in "changed" one.

For other output formats, it gets tricky because they combine both
diffs in one line but can only display one rename per line. The result
"XY" column of short format, for example, would be "RR" in that case.

This case either needs some extension in short/porcelain format
to show something crazy like

    RR first -> second -> third

or we could show renames as two lines instead of one, for example
something like this for short form:

    R  first -> second
     R second -> third

But for now it's safer and simpler to just break the "second -> third"
rename pair and show

    RD first -> second
     A third

like we have been showing until now.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2203-add-intent.sh | 33 +++++++++++++++++++++++++++++
 wt-status.c           | 58 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index e5bfda1853..79aca93810 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -190,5 +190,38 @@ test_expect_success 'rename detection finds the right names' '
 	)
 '
 
+test_expect_success 'double rename detection in status' '
+	git init rename-detection-2 &&
+	(
+		cd rename-detection-2 &&
+		echo contents > first &&
+		git add first &&
+		git commit -m first &&
+		git mv first second &&
+		mv second third &&
+		git add -N third &&
+
+		git status | grep -v "^?" >actual.1 &&
+		test_i18ngrep "renamed: *first -> second" actual.1 &&
+		test_i18ngrep "renamed: *second -> third" actual.1 &&
+
+
+		git status --porcelain | grep -v "^?" >actual.2 &&
+		cat >expected.2 <<-\EOF &&
+		RD first -> second
+		 A third
+		EOF
+		test_cmp expected.2 actual.2 &&
+
+		oid=12f00e90b6ef79117ce6e650416b8cf517099b78 &&
+		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		cat >expected.3 <<-EOF &&
+		2 RD N... 100644 100644 000000 $oid $oid R100 second	first
+		1 .A N... 000000 000000 100644 $_z40 $_z40 third
+		EOF
+		test_cmp expected.3 actual.3
+	)
+'
+
 test_done
 
diff --git a/wt-status.c b/wt-status.c
index d5bdf4c2e9..e62853f748 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -419,6 +419,47 @@ static char short_submodule_status(struct wt_status_change_data *d)
 	return d->worktree_status;
 }
 
+static struct string_list_item * break_double_rename(
+		struct wt_status *s, struct string_list_item *it,
+		int *status, struct diff_filepair *p)
+{
+	struct wt_status_change_data *d;
+	struct string_list_item *new_it;
+
+	d = it->util;
+	/*
+	 * _collect_index_changes() must have been called or
+	 * d->head_path does not contain a real value.
+	 */
+	if (!d || !d->head_path)
+		return it;
+
+	switch (s->status_format) {
+	case STATUS_FORMAT_SHORT:
+	case STATUS_FORMAT_PORCELAIN:
+	case STATUS_FORMAT_PORCELAIN_V2:
+		break;
+	case STATUS_FORMAT_LONG:
+	case STATUS_FORMAT_NONE:
+		/* this output can handle double renames ok */
+		return it;
+	default:
+		die("BUG: finalize_deferred_config() should have been called");
+	}
+
+	switch (*status) {
+	case DIFF_STATUS_RENAMED:
+		d->worktree_status = DIFF_STATUS_DELETED;
+		/* fallthru */
+	case DIFF_STATUS_COPIED:
+		*status = DIFF_STATUS_ADDED;
+		new_it = string_list_insert(&s->change, p->two->path);
+		return new_it;
+	}
+
+	return it;
+}
+
 static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -433,16 +474,19 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		struct diff_filepair *p;
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
+		int status;
 
 		p = q->queue[i];
+		status = p->status;
 		it = string_list_insert(&s->change, p->one->path);
+		it = break_double_rename(s, it, &status, p);
 		d = it->util;
 		if (!d) {
 			d = xcalloc(1, sizeof(*d));
 			it->util = d;
 		}
 		if (!d->worktree_status)
-			d->worktree_status = p->status;
+			d->worktree_status = status;
 		if (S_ISGITLINK(p->two->mode)) {
 			d->dirty_submodule = p->two->dirty_submodule;
 			d->new_submodule_commits = !!oidcmp(&p->one->oid,
@@ -451,7 +495,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 				d->worktree_status = short_submodule_status(d);
 		}
 
-		switch (p->status) {
+		switch (status) {
 		case DIFF_STATUS_ADDED:
 			d->mode_worktree = p->two->mode;
 			break;
@@ -477,7 +521,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			break;
 
 		default:
-			die("BUG: unhandled diff-files status '%c'", p->status);
+			die("BUG: unhandled diff-files status '%c'", status);
 			break;
 		}
 
@@ -710,12 +754,12 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
-	wt_status_collect_changes_worktree(s);
-
 	if (s->is_initial)
 		wt_status_collect_changes_initial(s);
 	else
+		/* must be called before _collect_changes_worktree() */
 		wt_status_collect_changes_index(s);
+	wt_status_collect_changes_worktree(s);
 	wt_status_collect_untracked(s);
 }
 
@@ -1733,7 +1777,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 	putchar(' ');
 
 	if (d->head_path && d->worktree_path)
-		die("BUG: to be addressed in the next patch");
+		die("BUG: break_double_rename() fails to break this pair");
 
 	if (d->head_path) {
 		from = d->head_path;
@@ -2077,7 +2121,7 @@ static void wt_porcelain_v2_print_changed_entry(
 	key[2] = 0;
 
 	if (d->head_path && d->worktree_path)
-		die("BUG: to be addressed in the next patch");
+		die("BUG: break_double_rename() fails to break this pair");
 
 	if (d->head_path) {
 		path_other = d->head_path;
-- 
2.15.0.320.g0453912d77


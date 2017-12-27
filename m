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
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2771F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbdL0KU0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:20:26 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46527 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdL0KUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:20:25 -0500
Received: by mail-pl0-f66.google.com with SMTP id i6so19231820plt.13
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjZxUn3nKsCAl1g20xqgTifqlkFY8UJWbB32x+qsqCw=;
        b=Px3cxlsuRAvQZuMth4JR3lavffphXThq5rBaciNMaUaXsk8Dfbov3WrFcGWtu0NsJM
         YNfdutwZMCdaLapz8DkjSUxwZP1K+ExbctZOtBSqryWSPSy1N7OPOm7YKC0zs+2INMPp
         cjWof366utGzCrjkV69Y79Lbw2NBr0XVEy6xQZKCfNZbHvbhgeoiCclIaW2n0T1RgDcK
         6NptsZeqi3cBAr8uQzxsf8ei9XPhjbwvm+fYd5gchLdzGGVXZ7azCbVvgjjv9zjKbXEX
         MK46n3tBheO2Qc8/Wta0BcCLIfYRnlj4yoR0bNV5fULGR8ieWa5yflAn5BAQ6HMENDmG
         Yl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjZxUn3nKsCAl1g20xqgTifqlkFY8UJWbB32x+qsqCw=;
        b=VFAIk0CTz2JFac06tY2NOJLr4sw0jKENm3gMwRjf1tYcurZtEnpId6YoGtyhfqWILT
         rT/zrQ85RlqCXdWDDzHO6ncSyUde8E4NYX6txnqX2fOSrVb8TbjWDJXkbn94P9ktbSiP
         YjbNH+2Hw3RKaOO2flScfZRK83JS2g5oYBsQQNORYoX0ixZ9wJfXxTbSUsN4Q+keUUdb
         4xVD1/GNrZqOszam6QItXA86ZdRLzoRQJ7qPHNHs6VWjECO4ipUJa5m//rHr7QU5dn8y
         QTFcR4XW64/9NShew42WlyeCksMBRkYEqakY89uQCgQ3c4qjRz4uCT9etAhKiCDQo6gp
         rsAA==
X-Gm-Message-State: AKGB3mIHHHAwKnuSv5fe1JtYfaT/Y2JxU5NaKdSwa+rsSfR2HHaFLF1g
        a3l7l56jjMC+N7ZU5ZimQ7oLdQ==
X-Google-Smtp-Source: ACJfBouUl05+FygyAube3wEuJf7m/PZpU3aXX/lC5b3Efk6jj8ZYZsdIom3befjLA5pZHYxJJqKQlg==
X-Received: by 10.159.247.193 with SMTP id v1mr27601415plz.102.1514370024285;
        Wed, 27 Dec 2017 02:20:24 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id a81sm67252644pfj.143.2017.12.27.02.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:20:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:20:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 6/6] wt-status.c: handle worktree renames
Date:   Wed, 27 Dec 2017 17:18:39 +0700
Message-Id: <20171227101839.26427-7-pclouds@gmail.com>
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
 Documentation/git-status.txt | 23 +++++++++--------
 t/t2203-add-intent.sh        | 60 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 22 +++++++++++++---
 3 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 81cab9aefb..72bfb87f66 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -149,14 +149,15 @@ the status.relativePaths config option below.
 Short Format
 ~~~~~~~~~~~~
 
-In the short-format, the status of each path is shown as
+In the short-format, the status of each path is shown as one of these
+forms
 
-	XY PATH1 -> PATH2
+	XY PATH
+	XY ORIG_PATH -> PATH
 
-where `PATH1` is the path in the `HEAD`, and the " `-> PATH2`" part is
-shown only when `PATH1` corresponds to a different path in the
-index/worktree (i.e. the file is renamed). The `XY` is a two-letter
-status code.
+where `ORIG_PATH` is where the renamed/copied contents came
+from. `ORIG_PATH` is only shown when the entry is renamed or
+copied. The `XY` is a two-letter status code.
 
 The fields (including the `->`) are separated from each other by a
 single space. If a filename contains whitespace or other nonprintable
@@ -192,6 +193,8 @@ in which case `XY` are `!!`.
     [MARC]           index and work tree matches
     [ MARC]     M    work tree changed since index
     [ MARC]     D    deleted in work tree
+    [ D]        R    renamed in work tree
+    [ D]        C    copied in work tree
     -------------------------------------------------
     D           D    unmerged, both deleted
     A           U    unmerged, added by us
@@ -309,13 +312,13 @@ Renamed or copied entries have the following format:
 		of similarity between the source and target of the
 		move or copy). For example "R100" or "C75".
     <path>      The pathname.  In a renamed/copied entry, this
-		is the path in the index and in the working tree.
+		is the target path.
     <sep>       When the `-z` option is used, the 2 pathnames are separated
 		with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
 		byte separates them.
-    <origPath>  The pathname in the commit at HEAD.  This is only
-		present in a renamed/copied entry, and tells
-		where the renamed/copied contents came from.
+    <origPath>  The pathname in the commit at HEAD or in the index.
+		This is only present in a renamed/copied entry, and
+		tells where the renamed/copied contents came from.
     --------------------------------------------------------
 
 Unmerged entries have the following format; the first character is
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 878e73fe98..78236dc7d8 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -162,5 +162,65 @@ test_expect_success 'commit: ita entries ignored in empty commit check' '
 	)
 '
 
+test_expect_success 'rename detection finds the right names' '
+	git init rename-detection &&
+	(
+		cd rename-detection &&
+		echo contents >first &&
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
+		hash=12f00e90b6ef79117ce6e650416b8cf517099b78 &&
+		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		cat >expected.3 <<-EOF &&
+		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
+		EOF
+		test_cmp expected.3 actual.3
+	)
+'
+
+test_expect_success 'double rename detection in status' '
+	git init rename-detection-2 &&
+	(
+		cd rename-detection-2 &&
+		echo contents >first &&
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
+		git status --porcelain | grep -v "^?" >actual.2 &&
+		cat >expected.2 <<-\EOF &&
+		R  first -> second
+		 R second -> third
+		EOF
+		test_cmp expected.2 actual.2 &&
+
+		hash=12f00e90b6ef79117ce6e650416b8cf517099b78 &&
+		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		cat >expected.3 <<-EOF &&
+		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
+		2 .R N... 100644 100644 100644 $hash $hash R100 third	second
+		EOF
+		test_cmp expected.3 actual.3
+	)
+'
+
 test_done
 
diff --git a/wt-status.c b/wt-status.c
index fab6951573..f5debcd2b4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -360,8 +360,6 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	switch (change_type) {
 	case WT_STATUS_UPDATED:
 		status = d->index_status;
-		if (d->rename_source)
-			one_name = d->rename_source;
 		break;
 	case WT_STATUS_CHANGED:
 		if (d->new_submodule_commits || d->dirty_submodule) {
@@ -382,6 +380,14 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 		    change_type);
 	}
 
+	/*
+	 * Only pick up the rename it's relevant. If the rename is for
+	 * the changed section and we're printing the updated section,
+	 * ignore it.
+	 */
+	if (d->rename_status == status)
+		one_name = d->rename_source;
+
 	one = quote_path(one_name, s->prefix, &onebuf);
 	two = quote_path(two_name, s->prefix, &twobuf);
 
@@ -433,7 +439,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		struct wt_status_change_data *d;
 
 		p = q->queue[i];
-		it = string_list_insert(&s->change, p->one->path);
+		it = string_list_insert(&s->change, p->two->path);
 		d = it->util;
 		if (!d) {
 			d = xcalloc(1, sizeof(*d));
@@ -460,6 +466,14 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			/* mode_worktree is zero for a delete. */
 			break;
 
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			if (d->rename_status)
+				die("BUG: multiple renames on the same target? how?");
+			d->rename_source = xstrdup(p->one->path);
+			d->rename_score = p->score * 100 / MAX_SCORE;
+			d->rename_status = p->status;
+			/* fallthru */
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 		case DIFF_STATUS_UNMERGED:
@@ -531,6 +545,8 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
+			if (d->rename_status)
+				die("BUG: multiple renames on the same target? how?");
 			d->rename_source = xstrdup(p->one->path);
 			d->rename_score = p->score * 100 / MAX_SCORE;
 			d->rename_status = p->status;
-- 
2.15.0.320.g0453912d77


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3A61F404
	for <e@80x24.org>; Sat, 24 Feb 2018 14:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBXOFj (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 09:05:39 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36418 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeBXOFi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 09:05:38 -0500
Received: by mail-pl0-f65.google.com with SMTP id v3so6623717plg.3
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 06:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+XjHZY9EXfPNvopyvoKY/r9shFQVUG7oTkJVny/fOE=;
        b=biyvmYQdvyF919f4UH15scoywAhCYPFGRvW7MHIfx/BVTCPEn3jdOo2RDb3JpOzY1t
         YOau9QDKVtKZzm38F8ZclY0OvX3XzC01/1VYU58FlsLsBPZWEId4tLaB6LWMJHsNDLK4
         zeRr8y6X0dzIUJXBFjg4P5OA0mrwsm3wdNl0c8czOa5em8maX3z1ROFMPLFbXABVHcHm
         Iy5OW+5xOSVBUZnwdMzIWr4UpCyOkGAH03g3a0ASmkNse4hgx4QTvitAFI7Hj4lrEoQT
         RbMJQQeNmKefI2TltNIaU/QzpqpmEwAxDmKUlE5e1Zi+Ja73/TdZ1NrkB4dh3KlTyPMc
         Vmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+XjHZY9EXfPNvopyvoKY/r9shFQVUG7oTkJVny/fOE=;
        b=SPEPCrDWx6rFtHfW6AmBbuT/mF8MHsj8WiKMsSgg94VNQ0w+CuykIAEJGJ8RE49V24
         Fe/s7zg1A3QXAQ0BlJRtEShKbywUUQjaUvpyHMTwvt5MdPWIJOFCs2rUXypYf1j5NB/b
         RkDE4v0zNLgaodqub1CluC3POtG5WttK6Fidx4W5ziDhIDU536R6Or5hhERAx7sCmie0
         hCfcgZOiuXBLonqJmdvGYx+6a+ZpgN70rf66NlzhhE1HPWpP2377pAvTlz5kxpfJA1Nb
         2D17ZKvFTixVzRix4mO1rsiLZYZ1frRfVuaGm0pB1MDQ+NQX02eXMAszeBAA8gsIwpQW
         Wj0w==
X-Gm-Message-State: APf1xPBM5bUgNucPa36/RPoATVdol1yzC5qgOKgaVQyVkBbMeEpq321K
        EEFtrUWByWH8xPJPEZPBo6RT1w==
X-Google-Smtp-Source: AH8x224U8/MWduUAM7jdF/KOueRqgPExcLRsvOQialC8JR8jT3Ph7uWgEvBbxHsgXImWM+c9fOp4KA==
X-Received: by 2002:a17:902:a705:: with SMTP id w5-v6mr4879837plq.299.1519481137788;
        Sat, 24 Feb 2018 06:05:37 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id p9sm8106882pgs.35.2018.02.24.06.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2018 06:05:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 21:05:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 2/2] diff: add --stat-with-summary
Date:   Sat, 24 Feb 2018 21:05:09 +0700
Message-Id: <20180224140509.25061-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224140509.25061-1-pclouds@gmail.com>
References: <20180201130221.15563-1-pclouds@gmail.com>
 <20180224140509.25061-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Certain information is currently shown with --summary, but when used
in combination with --stat it's a bit hard to read since info of the
same file is in two places (--stat and --summary).

On top of that, commits that add or remove files double the number of
display lines, which could be a lot if you add or remove a lot of
files.

--stat-with-summary embeds most of --summary back in --stat in the
little space between the file name part and the graph line, e.g. with
commit 0433d533f1:

   Documentation/merge-config.txt         |  4 +
   builtin/merge.c                        |  2 +
   ...-pull-verify-signatures.sh (new +x) | 81 ++++++++++++++
   t/t7612-merge-verify-signatures.sh     | 45 ++++++++
   4 files changed, 132 insertions(+)

It helps both condensing information and saving some text
space. What's new in diffstat is:

- A new 0644 file is shown as (new)
- A new 0755 file is shown as (new +x)
- A new symlink is shown as (new +l)
- A deleted file is shown as (gone)
- A mode change adding executable bit is shown as (mode +x)
- A mode change removing it is shown as (mode -x)

Note that --stat-with-summary does not contain all the information
--summary provides. Rewrite percentage is not shown but it could be
added later, like R50% or C20%.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt                |  8 ++++
 diff.c                                        | 37 +++++++++++++++++++
 diff.h                                        |  1 +
 t/t4013-diff-various.sh                       |  5 +++
 ...ty_--root_--stat_--compact-summary_initial | 12 ++++++
 ...-R_--root_--stat_--compact-summary_initial | 12 ++++++
 ...tree_--stat_--compact-summary_initial_mode |  4 ++
 ...e_-R_--stat_--compact-summary_initial_mode |  4 ++
 8 files changed, 83 insertions(+)
 create mode 100644 t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
 create mode 100644 t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c330c01ff0..e3a44f03cd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -128,6 +128,14 @@ have to use `--diff-algorithm=default` option.
 These parameters can also be set individually with `--stat-width=<width>`,
 `--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
+--compact-summary::
+	Output a condensed summary of extended header information such
+	as file creations or deletions ("new" or "gone", optionally "+l"
+	if it's a symlink) and mode changes ("+x" or "-x" for adding
+	or removing executable bit respectively) in diffstat. The
+	information is put betwen the filename part and the graph
+	part. Implies `--stat`.
+
 --numstat::
 	Similar to `--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
diff --git a/diff.c b/diff.c
index e3f72de27d..62e413a80f 100644
--- a/diff.c
+++ b/diff.c
@@ -2129,6 +2129,7 @@ struct diffstat_t {
 		char *from_name;
 		char *name;
 		char *print_name;
+		const char *comments;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
@@ -2205,6 +2206,9 @@ static void fill_print_name(struct diffstat_file *file)
 	else
 		quote_c_style(file->name, &pname, NULL, 0);
 
+	if (file->comments)
+		strbuf_addf(&pname, " (%s)", file->comments);
+
 	file->print_name = strbuf_detach(&pname, NULL);
 }
 
@@ -3239,6 +3243,32 @@ static void builtin_diff(const char *name_a,
 	return;
 }
 
+static char *get_compact_summary(const struct diff_filepair *p, int is_renamed)
+{
+	if (!is_renamed) {
+		if (p->status == DIFF_STATUS_ADDED) {
+			if (S_ISLNK(p->two->mode))
+				return "new +l";
+			else if ((p->two->mode & 0777) == 0755)
+				return "new +x";
+			else
+				return "new";
+		} else if (p->status == DIFF_STATUS_DELETED)
+			return "gone";
+	}
+	if (S_ISLNK(p->one->mode) && !S_ISLNK(p->two->mode))
+		return "mode -l";
+	else if (!S_ISLNK(p->one->mode) && S_ISLNK(p->two->mode))
+		return "mode +l";
+	else if ((p->one->mode & 0777) == 0644 &&
+		 (p->two->mode & 0777) == 0755)
+		return "mode +x";
+	else if ((p->one->mode & 0777) == 0755 &&
+		 (p->two->mode & 0777) == 0644)
+		return "mode -x";
+	return NULL;
+}
+
 static void builtin_diffstat(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two,
@@ -3258,6 +3288,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 	data = diffstat_add(diffstat, name_a, name_b);
 	data->is_interesting = p->status != DIFF_STATUS_UNKNOWN;
+	if (o->flags.stat_with_summary)
+		data->comments = get_compact_summary(p, data->is_renamed);
 
 	if (!one || !two) {
 		data->is_unmerged = 1;
@@ -4544,6 +4576,11 @@ int diff_opt_parse(struct diff_options *options,
 	else if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
+	else if (!strcmp(arg, "--compact-summary")) {
+		 options->flags.stat_with_summary = 1;
+		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	} else if (!strcmp(arg, "--no-compact-summary"))
+		 options->flags.stat_with_summary = 0;
 
 	/* renames options */
 	else if (starts_with(arg, "-B") ||
diff --git a/diff.h b/diff.h
index 6bd278aac1..d29560f822 100644
--- a/diff.h
+++ b/diff.h
@@ -93,6 +93,7 @@ struct diff_flags {
 	unsigned dirstat_by_line:1;
 	unsigned funccontext:1;
 	unsigned default_follow_renames:1;
+	unsigned stat_with_summary:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f10798b2df..3f9a24fd56 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -361,6 +361,11 @@ diff --no-index --raw dir2 dir
 diff --no-index --raw --abbrev=4 dir2 dir
 :noellipses diff --no-index --raw --abbrev=4 dir2 dir
 diff --no-index --raw --no-abbrev dir2 dir
+
+diff-tree --pretty --root --stat --compact-summary initial
+diff-tree --pretty -R --root --stat --compact-summary initial
+diff-tree --stat --compact-summary initial mode
+diff-tree -R --stat --compact-summary initial mode
 EOF
 
 test_expect_success 'log -S requires an argument' '
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
new file mode 100644
index 0000000000..d6451ff7cc
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty --root --stat --compact-summary initial
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
+ 3 files changed, 8 insertions(+)
+$
diff --git a/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
new file mode 100644
index 0000000000..1989e55cd0
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty -R --root --stat --compact-summary initial
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+ dir/sub (gone) | 2 --
+ file0 (gone)   | 3 ---
+ file2 (gone)   | 3 ---
+ 3 files changed, 8 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode b/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
new file mode 100644
index 0000000000..9c7c8f63af
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree --stat --compact-summary initial mode
+ file0 (mode +x) | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode b/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
new file mode 100644
index 0000000000..e38f3d3bfb
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree -R --stat --compact-summary initial mode
+ file0 (mode -x) | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
-- 
2.16.1.435.g8f24da2e1a


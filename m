Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E5A1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934897AbeF3JVC (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:21:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38085 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934077AbeF3JUs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id a4-v6so8470557lff.5
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJsae93PZh1IwQ4Xwvqv9JC8q7Kv84/pTArJGViMkM8=;
        b=JGPyv/8xYOmavtMCftMQ1KydY5mPnCq8mZ+Pgbp+jjNVjGK/le8hmPPBTP0bkOXvOM
         J4QEg6y8wPPwonju1CTF2WKvcE7kmxW4iv8E5uwrNdUWp0FpEBn71yuWDkEru5ho5MTm
         PghYwc8njAg3GxrL1VRuZXbnaOW9d2gB69PhDA4A8ba7/wTHswrU5uzP+GWi2o3Cv2f+
         hwFp4B/qM1pTKBuTau3AnA214BM99gRX7ymKMtqaNIG5ZusIyZT037sBnmkxMK9UvHhx
         rYC4ra2RrZxcsOe0GYx+Ja7g40qgl93UumwQjOJbjzNyzVaVxAPTWuLplDLfd3x3IyHR
         I/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJsae93PZh1IwQ4Xwvqv9JC8q7Kv84/pTArJGViMkM8=;
        b=IEDGDSmh04fZ9kYNIFTwsB0q5w70ER/EaBGfLSJkZ/0VffWUGbEaN5YzBCIVteP0F8
         59TY+XsIuUGxlZGWB9l98W5fUrrrzIhfq97GkG8Hf6SA3pbknUPGEQL4LiR9Ri9g/iY3
         u0s+urhRG0qUUNsr1w8UMg+8eF6UePdF8e9yGS0bRt7nRZOaDIwGNV9BoUsEip+7UQ0H
         lb1i7Lj0QVdRFxTG5gmNhomviK9EsYZavcXO2S4WGvDcTygJjdBerKVP0Mi2RznrPVNl
         LaIxVQUgVfK2sBnDUqtnrZIrFyuqTRFbza/4SsxmBWV0fU057I6LPQWbuArJhVaEgqbd
         CPWQ==
X-Gm-Message-State: APt69E2BXMrR5pM5NjBJZrV8LOY5MQVnTwu/3B6tBDdqwlnfwMCh9uFA
        s9RIWo+T78SUEGlRZGoKpqILmg==
X-Google-Smtp-Source: AAOMgpdV08EeA2WhXKZB/RpWAWipa0vRNglVaS6wzSEAutMp5oIZ0ROnyvm0nHb6as1Ugu5xW+74LQ==
X-Received: by 2002:a19:db18:: with SMTP id s24-v6mr589366lfg.109.1530350446388;
        Sat, 30 Jun 2018 02:20:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/12] diff.h: remove extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:26 +0200
Message-Id: <20180630092031.29910-8-pclouds@gmail.com>
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
 diff.h | 120 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/diff.h b/diff.h
index dedac472ca..4a8885fb0f 100644
--- a/diff.h
+++ b/diff.h
@@ -253,15 +253,15 @@ const char *diff_line_prefix(struct diff_options *);
 
 extern const char mime_boundary_leader[];
 
-extern struct combine_diff_path *diff_tree_paths(
+struct combine_diff_path *diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
-extern int diff_tree_oid(const struct object_id *old_oid,
-			 const struct object_id *new_oid,
-			 const char *base, struct diff_options *opt);
-extern int diff_root_tree_oid(const struct object_id *new_oid, const char *base,
-			      struct diff_options *opt);
+int diff_tree_oid(const struct object_id *old_oid,
+		  const struct object_id *new_oid,
+		  const char *base, struct diff_options *opt);
+int diff_root_tree_oid(const struct object_id *new_oid, const char *base,
+		       struct diff_options *opt);
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
@@ -278,33 +278,33 @@ struct combine_diff_path {
 	st_add4(sizeof(struct combine_diff_path), (l), 1, \
 		st_mult(sizeof(struct combine_diff_parent), (n)))
 
-extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
-			      int dense, struct rev_info *);
+void show_combined_diff(struct combine_diff_path *elem, int num_parent,
+			int dense, struct rev_info *);
 
-extern void diff_tree_combined(const struct object_id *oid, const struct oid_array *parents, int dense, struct rev_info *rev);
+void diff_tree_combined(const struct object_id *oid, const struct oid_array *parents, int dense, struct rev_info *rev);
 
-extern void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
+void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
 
-extern int diff_can_quit_early(struct diff_options *);
+int diff_can_quit_early(struct diff_options *);
 
-extern void diff_addremove(struct diff_options *,
-			   int addremove,
-			   unsigned mode,
-			   const struct object_id *oid,
-			   int oid_valid,
-			   const char *fullpath, unsigned dirty_submodule);
+void diff_addremove(struct diff_options *,
+		    int addremove,
+		    unsigned mode,
+		    const struct object_id *oid,
+		    int oid_valid,
+		    const char *fullpath, unsigned dirty_submodule);
 
-extern void diff_change(struct diff_options *,
-			unsigned mode1, unsigned mode2,
-			const struct object_id *old_oid,
-			const struct object_id *new_oid,
-			int old_oid_valid, int new_oid_valid,
-			const char *fullpath,
-			unsigned dirty_submodule1, unsigned dirty_submodule2);
+void diff_change(struct diff_options *,
+		 unsigned mode1, unsigned mode2,
+		 const struct object_id *old_oid,
+		 const struct object_id *new_oid,
+		 int old_oid_valid, int new_oid_valid,
+		 const char *fullpath,
+		 unsigned dirty_submodule1, unsigned dirty_submodule2);
 
-extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
+struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_CACHE		2
@@ -314,17 +314,17 @@ extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *pat
  * Poor man's alternative to parse-option, to allow both stuck form
  * (--option=value) and separate form (--option value).
  */
-extern int parse_long_opt(const char *opt, const char **argv,
-			 const char **optarg);
-
-extern int git_diff_basic_config(const char *var, const char *value, void *cb);
-extern int git_diff_heuristic_config(const char *var, const char *value, void *cb);
-extern void init_diff_ui_defaults(void);
-extern int git_diff_ui_config(const char *var, const char *value, void *cb);
-extern void diff_setup(struct diff_options *);
-extern int diff_opt_parse(struct diff_options *, const char **, int, const char *);
-extern void diff_setup_done(struct diff_options *);
-extern int git_config_rename(const char *var, const char *value);
+int parse_long_opt(const char *opt, const char **argv,
+		   const char **optarg);
+
+int git_diff_basic_config(const char *var, const char *value, void *cb);
+int git_diff_heuristic_config(const char *var, const char *value, void *cb);
+void init_diff_ui_defaults(void);
+int git_diff_ui_config(const char *var, const char *value, void *cb);
+void diff_setup(struct diff_options *);
+int diff_opt_parse(struct diff_options *, const char **, int, const char *);
+void diff_setup_done(struct diff_options *);
+int git_config_rename(const char *var, const char *value);
 
 #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
@@ -342,8 +342,8 @@ extern int git_config_rename(const char *var, const char *value);
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
-extern void diffcore_std(struct diff_options *);
-extern void diffcore_fix_diff_index(struct diff_options *);
+void diffcore_std(struct diff_options *);
+void diffcore_fix_diff_index(struct diff_options *);
 
 #define COMMON_DIFF_OPTIONS_HELP \
 "\ncommon diff options:\n" \
@@ -373,9 +373,9 @@ extern void diffcore_fix_diff_index(struct diff_options *);
 "                show all files diff when -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
 
-extern int diff_queue_is_empty(void);
-extern void diff_flush(struct diff_options*);
-extern void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
+int diff_queue_is_empty(void);
+void diff_flush(struct diff_options*);
+void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 
 /* diff-raw status letters */
 #define DIFF_STATUS_ADDED		'A'
@@ -397,24 +397,24 @@ extern void diff_warn_rename_limit(const char *varname, int needed, int degraded
  * This is different from find_unique_abbrev() in that
  * it stuffs the result with dots for alignment.
  */
-extern const char *diff_aligned_abbrev(const struct object_id *sha1, int);
+const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 
 /* do not report anything on removed paths */
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
-extern int run_diff_files(struct rev_info *revs, unsigned int option);
-extern int run_diff_index(struct rev_info *revs, int cached);
+int run_diff_files(struct rev_info *revs, unsigned int option);
+int run_diff_index(struct rev_info *revs, int cached);
 
-extern int do_diff_cache(const struct object_id *, struct diff_options *);
-extern int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
+int do_diff_cache(const struct object_id *, struct diff_options *);
+int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 
-extern int diff_result_code(struct diff_options *, int);
+int diff_result_code(struct diff_options *, int);
 
-extern void diff_no_index(struct rev_info *, int, const char **);
+void diff_no_index(struct rev_info *, int, const char **);
 
-extern int index_differs_from(const char *def, const struct diff_flags *flags,
-			      int ita_invisible_in_index);
+int index_differs_from(const char *def, const struct diff_flags *flags,
+		       int ita_invisible_in_index);
 
 /*
  * Fill the contents of the filespec "df", respecting any textconv defined by
@@ -427,30 +427,30 @@ extern int index_differs_from(const char *def, const struct diff_flags *flags,
  * struct. If it is non-NULL, then "outbuf" points to a newly allocated buffer
  * that should be freed by the caller.
  */
-extern size_t fill_textconv(struct userdiff_driver *driver,
-			    struct diff_filespec *df,
-			    char **outbuf);
+size_t fill_textconv(struct userdiff_driver *driver,
+		     struct diff_filespec *df,
+		     char **outbuf);
 
 /*
  * Look up the userdiff driver for the given filespec, and return it if
  * and only if it has textconv enabled (otherwise return NULL). The result
  * can be passed to fill_textconv().
  */
-extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
+struct userdiff_driver *get_textconv(struct diff_filespec *one);
 
 /*
  * Prepare diff_filespec and convert it using diff textconv API
  * if the textconv driver exists.
  * Return 1 if the conversion succeeds, 0 otherwise.
  */
-extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
+int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
 
-extern int parse_rename_score(const char **cp_p);
+int parse_rename_score(const char **cp_p);
 
-extern long parse_algorithm_value(const char *value);
+long parse_algorithm_value(const char *value);
 
-extern void print_stat_summary(FILE *fp, int files,
-			       int insertions, int deletions);
-extern void setup_diff_pager(struct diff_options *);
+void print_stat_summary(FILE *fp, int files,
+			int insertions, int deletions);
+void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.18.0.rc2.476.g39500d3211


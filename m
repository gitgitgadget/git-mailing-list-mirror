Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F471F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJ2KAy (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37702 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2KAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id q130so1692576wme.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8ItaMLWPuiDh0xwOy8VHn052gcTcGh76NSKNNuJiI7E=;
        b=b6Ny4ibVBr4HI6Tq6a8uF2+8ScwdB+B6T6Riat5bS9IIO42eJUxGUzXJtIsFlQkomU
         +Nu4XnheV+u3VtCCx2iiNRXnL3S+NskBNydr7w6+OFaaDh9QojOs0q8b3RmZb+zh79iY
         hJBd86J/CAipOospJkbrxf7b1/9wTVtq2urjalJ/ai1p708tCPY+3AeqAFI4MgvyTUdw
         xpKXjYVYK565IK/Zq5gCeF5aru9ZqDOBAEojrFBfGz1txvSwhWWhxtNFlccyGDmKM5Cw
         vkui3DvZVx8WNu161Knb1Yyoy/qfvKj68J2JCliNswQixoVKPK2kNA1i080wtKhEHehq
         qBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8ItaMLWPuiDh0xwOy8VHn052gcTcGh76NSKNNuJiI7E=;
        b=YA19Cc59eiMO8WA80RYQ+e/iEwbWgUR2vgnZZXnF5u6/fHjHjpgrp4Lqf+NoIOUwq8
         IyrPqa3VS9gMtiQfE8+PZ7ii2YeQfBo0ufRYDwmvxyPQKmggny8ZKQwmsfT1OA/IEcAS
         lIKr0EcJO17k4NSnrxafOcu263dyOLDUuIzQ98N3Vtzh7hoGOU5gOcVSro98pNVeIjOG
         xYkWVHHZe8rHECEP6E73ckvId4JEgYDvW+l1yvddiHBV9oYekQBakGJknOOrIjslGXaK
         rU1sx3jYIegRq6nlx9D7Pz2QaEMiPexUIsnHhXI6muHwnHlKTu+3LaeumUlSozfm8thE
         KMfg==
X-Gm-Message-State: APjAAAX1FRHYa4WDe0E0BH6FKWd6D1tybUmeiz/gvENcRtT/rL6pqm0r
        8hYgE3SQ1ezCDUB1hWAghQfGEunc
X-Google-Smtp-Source: APXvYqwLiyaWToOQKG5deu3menA6Cy/11OK1WNww8ZMN0ED5kXavqlsI2Zca6Gmgh0Y9a5MZw66deQ==
X-Received: by 2002:a1c:f208:: with SMTP id s8mr1904432wmc.82.1572343249230;
        Tue, 29 Oct 2019 03:00:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r81sm2522320wme.16.2019.10.29.03.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:48 -0700 (PDT)
Message-Id: <1796c119be0be2e707685b423fdb23c6f6675a28.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:37 +0000
Subject: [PATCH 01/10] diff: move doc to diff.h and diffcore.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-diff.txt to both
diff.h and diffcore.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-diff.txt is removed because the information
it has is now redundant and it'll be hard to keep it up to date and
synchronized with the documentation in the header files.

There are three members documented in the doc file that weren't found in
the header files, assuming the doc wasn't up to date and the members
no longer exist:
touched_flags, COLOR_DIFF_WORDS and QUIET.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-diff.txt | 174 ---------------------------
 diff.h                               | 127 +++++++++++++++++++
 diffcore.h                           |  32 +++++
 3 files changed, 159 insertions(+), 174 deletions(-)
 delete mode 100644 Documentation/technical/api-diff.txt

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
deleted file mode 100644
index 30fc0e9c93..0000000000
--- a/Documentation/technical/api-diff.txt
+++ /dev/null
@@ -1,174 +0,0 @@
-diff API
-========
-
-The diff API is for programs that compare two sets of files (e.g. two
-trees, one tree and the index) and present the found difference in
-various ways.  The calling program is responsible for feeding the API
-pairs of files, one from the "old" set and the corresponding one from
-"new" set, that are different.  The library called through this API is
-called diffcore, and is responsible for two things.
-
-* finding total rewrites (`-B`), renames (`-M`) and copies (`-C`), and
-  changes that touch a string (`-S`), as specified by the caller.
-
-* outputting the differences in various formats, as specified by the
-  caller.
-
-Calling sequence
-----------------
-
-* Prepare `struct diff_options` to record the set of diff options, and
-  then call `repo_diff_setup()` to initialize this structure.  This
-  sets up the vanilla default.
-
-* Fill in the options structure to specify desired output format, rename
-  detection, etc.  `diff_opt_parse()` can be used to parse options given
-  from the command line in a way consistent with existing git-diff
-  family of programs.
-
-* Call `diff_setup_done()`; this inspects the options set up so far for
-  internal consistency and make necessary tweaking to it (e.g. if
-  textual patch output was asked, recursive behaviour is turned on);
-  the callback set_default in diff_options can be used to tweak this more.
-
-* As you find different pairs of files, call `diff_change()` to feed
-  modified files, `diff_addremove()` to feed created or deleted files,
-  or `diff_unmerge()` to feed a file whose state is 'unmerged' to the
-  API.  These are thin wrappers to a lower-level `diff_queue()` function
-  that is flexible enough to record any of these kinds of changes.
-
-* Once you finish feeding the pairs of files, call `diffcore_std()`.
-  This will tell the diffcore library to go ahead and do its work.
-
-* Calling `diff_flush()` will produce the output.
-
-
-Data structures
----------------
-
-* `struct diff_filespec`
-
-This is the internal representation for a single file (blob).  It
-records the blob object name (if known -- for a work tree file it
-typically is a NUL SHA-1), filemode and pathname.  This is what the
-`diff_addremove()`, `diff_change()` and `diff_unmerge()` synthesize and
-feed `diff_queue()` function with.
-
-* `struct diff_filepair`
-
-This records a pair of `struct diff_filespec`; the filespec for a file
-in the "old" set (i.e. preimage) is called `one`, and the filespec for a
-file in the "new" set (i.e. postimage) is called `two`.  A change that
-represents file creation has NULL in `one`, and file deletion has NULL
-in `two`.
-
-A `filepair` starts pointing at `one` and `two` that are from the same
-filename, but `diffcore_std()` can break pairs and match component
-filespecs with other filespecs from a different filepair to form new
-filepair.  This is called 'rename detection'.
-
-* `struct diff_queue`
-
-This is a collection of filepairs.  Notable members are:
-
-`queue`::
-
-	An array of pointers to `struct diff_filepair`.  This
-	dynamically grows as you add filepairs;
-
-`alloc`::
-
-	The allocated size of the `queue` array;
-
-`nr`::
-
-	The number of elements in the `queue` array.
-
-
-* `struct diff_options`
-
-This describes the set of options the calling program wants to affect
-the operation of diffcore library with.
-
-Notable members are:
-
-`output_format`::
-	The output format used when `diff_flush()` is run.
-
-`context`::
-	Number of context lines to generate in patch output.
-
-`break_opt`, `detect_rename`, `rename-score`, `rename_limit`::
-	Affects the way detection logic for complete rewrites, renames
-	and copies.
-
-`abbrev`::
-	Number of hexdigits to abbreviate raw format output to.
-
-`pickaxe`::
-	A constant string (can and typically does contain newlines to
-	look for a block of text, not just a single line) to filter out
-	the filepairs that do not change the number of strings contained
-	in its preimage and postimage of the diff_queue.
-
-`flags`::
-	This is mostly a collection of boolean options that affects the
-	operation, but some do not have anything to do with the diffcore
-	library.
-
-`touched_flags`::
-	Records whether a flag has been changed due to user request
-	(rather than just set/unset by default).
-
-`set_default`::
-	Callback which allows tweaking the options in diff_setup_done().
-
-BINARY, TEXT;;
-	Affects the way how a file that is seemingly binary is treated.
-
-FULL_INDEX;;
-	Tells the patch output format not to use abbreviated object
-	names on the "index" lines.
-
-FIND_COPIES_HARDER;;
-	Tells the diffcore library that the caller is feeding unchanged
-	filepairs to allow copies from unmodified files be detected.
-
-COLOR_DIFF;;
-	Output should be colored.
-
-COLOR_DIFF_WORDS;;
-	Output is a colored word-diff.
-
-NO_INDEX;;
-	Tells diff-files that the input is not tracked files but files
-	in random locations on the filesystem.
-
-ALLOW_EXTERNAL;;
-	Tells output routine that it is Ok to call user specified patch
-	output routine.  Plumbing disables this to ensure stable output.
-
-QUIET;;
-	Do not show any output.
-
-REVERSE_DIFF;;
-	Tells the library that the calling program is feeding the
-	filepairs reversed; `one` is two, and `two` is one.
-
-EXIT_WITH_STATUS;;
-	For communication between the calling program and the options
-	parser; tell the calling program to signal the presence of
-	difference using program exit code.
-
-HAS_CHANGES;;
-	Internal; used for optimization to see if there is any change.
-
-SILENT_ON_REMOVE;;
-	Affects if diff-files shows removed files.
-
-RECURSIVE, TREE_IN_RECURSIVE;;
-	Tells if tree traversal done by tree-diff should recursively
-	descend into a tree object pair that are different in preimage
-	and postimage set.
-
-(JC)
diff --git a/diff.h b/diff.h
index 7f8f024feb..86d7871618 100644
--- a/diff.h
+++ b/diff.h
@@ -9,6 +9,49 @@
 #include "object.h"
 #include "oidset.h"
 
+/**
+ * The diff API is for programs that compare two sets of files (e.g. two trees,
+ * one tree and the index) and present the found difference in various ways.
+ * The calling program is responsible for feeding the API pairs of files, one
+ * from the "old" set and the corresponding one from "new" set, that are
+ * different.
+ * The library called through this API is called diffcore, and is responsible
+ * for two things.
+ *
+ * - finding total rewrites (`-B`), renames (`-M`) and copies (`-C`), and
+ * changes that touch a string (`-S`), as specified by the caller.
+ *
+ * - outputting the differences in various formats, as specified by the caller.
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * - Prepare `struct diff_options` to record the set of diff options, and then
+ * call `repo_diff_setup()` to initialize this structure.  This sets up the
+ * vanilla default.
+ *
+ * - Fill in the options structure to specify desired output format, rename
+ * detection, etc.  `diff_opt_parse()` can be used to parse options given
+ * from the command line in a way consistent with existing git-diff family
+ * of programs.
+ *
+ * - Call `diff_setup_done()`; this inspects the options set up so far for
+ * internal consistency and make necessary tweaking to it (e.g. if textual
+ * patch output was asked, recursive behaviour is turned on); the callback
+ * set_default in diff_options can be used to tweak this more.
+ *
+ * - As you find different pairs of files, call `diff_change()` to feed
+ * modified files, `diff_addremove()` to feed created or deleted files, or
+ * `diff_unmerge()` to feed a file whose state is 'unmerged' to the API.
+ * These are thin wrappers to a lower-level `diff_queue()` function that is
+ * flexible enough to record any of these kinds of changes.
+ *
+ * - Once you finish feeding the pairs of files, call `diffcore_std()`.
+ * This will tell the diffcore library to go ahead and do its work.
+ *
+ * - Calling `diff_flush()` will produce the output.
+ */
+
 struct combine_diff_path;
 struct commit;
 struct diff_filespec;
@@ -65,21 +108,66 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
+
+    /**
+     * Tells if tree traversal done by tree-diff should recursively descend
+     * into a tree object pair that are different in preimage and postimage set.
+     */
 	unsigned recursive;
 	unsigned tree_in_recursive;
+
+	/* Affects the way how a file that is seemingly binary is treated. */
 	unsigned binary;
 	unsigned text;
+
+	/**
+	 * Tells the patch output format not to use abbreviated object names on the
+	 * "index" lines.
+	 */
 	unsigned full_index;
+
+	/* Affects if diff-files shows removed files. */
 	unsigned silent_on_remove;
+
+	/**
+	 * Tells the diffcore library that the caller is feeding unchanged
+	 * filepairs to allow copies from unmodified files be detected.
+	 */
 	unsigned find_copies_harder;
+
 	unsigned follow_renames;
 	unsigned rename_empty;
+
+	/* Internal; used for optimization to see if there is any change. */
 	unsigned has_changes;
+
 	unsigned quick;
+
+	/**
+	 * Tells diff-files that the input is not tracked files but files in random
+	 * locations on the filesystem.
+	 */
 	unsigned no_index;
+
+	/**
+	 * Tells output routine that it is Ok to call user specified patch output
+	 * routine.  Plumbing disables this to ensure stable output.
+	 */
 	unsigned allow_external;
+
+	/**
+	 * For communication between the calling program and the options parser;
+	 * tell the calling program to signal the presence of difference using
+	 * program exit code.
+	 */
 	unsigned exit_with_status;
+
+	/**
+	 * Tells the library that the calling program is feeding the filepairs
+	 * reversed; `one` is two, and `two` is one.
+	 */
 	unsigned reverse_diff;
+
 	unsigned check_failed;
 	unsigned relative_name;
 	unsigned ignore_submodules;
@@ -131,36 +219,72 @@ enum diff_submodule_format {
 	DIFF_SUBMODULE_INLINE_DIFF
 };
 
+/**
+ * the set of options the calling program wants to affect the operation of
+ * diffcore library with.
+ */
 struct diff_options {
 	const char *orderfile;
+
+	/**
+	 * A constant string (can and typically does contain newlines to look for
+	 * a block of text, not just a single line) to filter out the filepairs
+	 * that do not change the number of strings contained in its preimage and
+	 * postimage of the diff_queue.
+	 */
 	const char *pickaxe;
+
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	const char *line_prefix;
 	size_t line_prefix_length;
+
+	/**
+	 * collection of boolean options that affects the operation, but some do
+	 * not have anything to do with the diffcore library.
+	 */
 	struct diff_flags flags;
 
 	/* diff-filter bits */
 	unsigned int filter;
 
 	int use_color;
+
+	/* Number of context lines to generate in patch output. */
 	int context;
+
 	int interhunkcontext;
+
+	/* Affects the way detection logic for complete rewrites, renames and
+	 * copies.
+	 */
 	int break_opt;
 	int detect_rename;
+
 	int irreversible_delete;
 	int skip_stat_unmatch;
 	int line_termination;
+
+	/* The output format used when `diff_flush()` is run. */
 	int output_format;
+
 	unsigned pickaxe_opts;
+
+    /* Affects the way detection logic for complete rewrites, renames and
+     * copies.
+     */
 	int rename_score;
 	int rename_limit;
+
 	int needed_rename_limit;
 	int degraded_cc_to_c;
 	int show_rename_progress;
 	int dirstat_permille;
 	int setup;
+
+	/* Number of hexdigits to abbreviate raw format output to. */
 	int abbrev;
+
 	int ita_invisible_in_index;
 /* white-space error highlighting */
 #define WSEH_NEW (1<<12)
@@ -192,6 +316,7 @@ struct diff_options {
 	/* to support internal diff recursion by --follow hack*/
 	int found_follow;
 
+	/* Callback which allows tweaking the options in diff_setup_done(). */
 	void (*set_default)(struct diff_options *);
 
 	FILE *file;
@@ -245,6 +370,7 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
 void diff_emit_submodule_pipethrough(struct diff_options *o,
 				     const char *line, int len);
 
+/* Output should be colored. */
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
@@ -270,6 +396,7 @@ enum color_diff {
 	DIFF_FILE_OLD_BOLD = 21,
 	DIFF_FILE_NEW_BOLD = 22,
 };
+
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
 	diff_get_color((o)->use_color, ix)
diff --git a/diffcore.h b/diffcore.h
index b651061c0e..7c07347e42 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -28,6 +28,12 @@ struct userdiff_driver;
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
+/**
+ * the internal representation for a single file (blob).  It records the blob
+ * object name (if known -- for a work tree file it typically is a NUL SHA-1),
+ * filemode and pathname.  This is what the `diff_addremove()`, `diff_change()`
+ * and `diff_unmerge()` synthesize and feed `diff_queue()` function with.
+ */
 struct diff_filespec {
 	struct object_id oid;
 	char *path;
@@ -66,6 +72,17 @@ void diff_free_filespec_data(struct diff_filespec *);
 void diff_free_filespec_blob(struct diff_filespec *);
 int diff_filespec_is_binary(struct repository *, struct diff_filespec *);
 
+/**
+ * This records a pair of `struct diff_filespec`; the filespec for a file in
+ * the "old" set (i.e. preimage) is called `one`, and the filespec for a file
+ * in the "new" set (i.e. postimage) is called `two`.  A change that represents
+ * file creation has NULL in `one`, and file deletion has NULL in `two`.
+ *
+ * A `filepair` starts pointing at `one` and `two` that are from the same
+ * filename, but `diffcore_std()` can break pairs and match component filespecs
+ * with other filespecs from a different filepair to form new filepair. This is
+ * called 'rename detection'.
+ */
 struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
@@ -77,6 +94,7 @@ struct diff_filepair {
 	unsigned done_skip_stat_unmatch : 1;
 	unsigned skip_stat_unmatch_result : 1;
 };
+
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
 #define DIFF_PAIR_RENAME(p) ((p)->renamed_pair)
@@ -94,11 +112,25 @@ void diff_free_filepair(struct diff_filepair *);
 
 int diff_unmodified_pair(struct diff_filepair *);
 
+/**
+ * This is a collection of filepairs.  Notable members are:
+ *
+ * - `queue`:
+ * An array of pointers to `struct diff_filepair`. This dynamically grows as
+ * you add filepairs;
+ *
+ * - `alloc`:
+ * The allocated size of the `queue` array;
+ *
+ * - `nr`:
+ * The number of elements in the `queue` array.
+ */
 struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
 };
+
 #define DIFF_QUEUE_CLEAR(q) \
 	do { \
 		(q)->queue = NULL; \
-- 
gitgitgadget


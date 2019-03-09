Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9123020248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCIS0P (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:26:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40149 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfCIS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:26:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so663029wmh.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HJJ9aSym9wXfNJJ44WQOG4LVVFYSQw1+LAYbeqhoYIE=;
        b=C2Thouw54Z9kZYzhQ0/zX8HNJoYsX52C3LyQnpsuejTzZueEn0rJHK1ZacO4PRgmV4
         ABiKMHtyNyBK/Lo/0lLW8Zi3qGTgAk043ddHc0+TwXQr4vFXxbmaS0nyY/mWGvZgD9xL
         mhYafkfWcnGd6UdZ5bbt8T6Pt0ySezIzySnBeNH+MCx/e3Gp1Q4Rf+rrEl67HokFB5Nd
         DoZXVHKEiLnyVrj7KSoKQ47YTqpoXy8an7yeWHmcvZ7WRWWsvD3waJpjUGKXwEUMGRy6
         odG0eDIW/YIqUYOlpBopr4sr7783rjNv0k0Pt04AH2DY9pYqNiGDn+zQOQBrLcqwfiec
         rXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HJJ9aSym9wXfNJJ44WQOG4LVVFYSQw1+LAYbeqhoYIE=;
        b=UVxOyhziJ99z814ubq5/jX/SeRGvpdu2JinqbZX02knNSEkM2BbCZ3cKEq+t87spuK
         b7oHo3dgixDzednvlYCWpOc/iGMbAbaKcAt/BcpugBQbea5kJiQwxoX4YO8vkg0BwLIB
         mMXbiKO8U0TESi80+8mN4Cuv/L2ZwOfSygRVBKAy3OZ3fPJCOWEvTlQgn5//uzTEfVcH
         sntjO0RBIaE7nFMkHbz3ANbQkEekM3ckzCyakjVMagxzzVQ543FEkXp7ZbpdJPa8AqPf
         u8Z2UbAEd7hAeEWD8w140C9I1XfnOUD3/YrfW+/AMaPMUAdfKNDQFz+k0jEn8ITKfjhj
         lcMw==
X-Gm-Message-State: APjAAAWI+bTtJB/J6bWkMgfMvbAUuHiqe6mO6AJMKe2gtTuleKmO/jF8
        DuPckm7708sg3n7Hk3QKysg=
X-Google-Smtp-Source: APXvYqxPji0d6E6UMFD/OJYE/Fnf6SFBUGzX/AUyRzAkPhIBeEpsL3vPIPFKMXZdFqIIN/IECswlJg==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr12611149wml.11.1552155972601;
        Sat, 09 Mar 2019 10:26:12 -0800 (PST)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id d24sm4561820wrb.47.2019.03.09.10.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 10:26:11 -0800 (PST)
Date:   Sat, 9 Mar 2019 18:26:10 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v13 18/27] stash: convert create to builtin
Message-ID: <20190309182610.GD31533@hank.intra.tgummerer.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-19-t.gummerer@gmail.com>
 <20190307191836.GB29221@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Thu, 7 Mar 2019, Jeff King wrote:
> 
> > On Mon, Feb 25, 2019 at 11:16:22PM +0000, Thomas Gummerer wrote:
> > 
> > > +static void add_pathspecs(struct argv_array *args,
> > > +			  struct pathspec ps) {
> > 
> > Here and elsewhere in the series, I notice that we pass the pathspec
> > struct by value, which is quite unusual for our codebase (and
> > potentially confusing, if any of the callers were to mutate the pointers
> > in the struct).
> > 
> > Is there any reason this shouldn't be "const struct pathspec *ps" pretty
> > much throughout the file?
> 
> I am quite certain that this is merely an oversight. It totes slipped
> by my review, for example.

Yep, it slipped by me as well.  Here's a patch to fix it:

--- >8 ---
Subject: [PATCH 1/2] stash: pass pathspec as pointer

Passing the pathspec by value is potentially confusing, as the copy is
only a shallow copy, so save the overhead of the copy, and pass the
pathspec struct as a pointer.

In addition use copy_pathspec to copy the pathspec into
rev.prune_data, so the copy is a proper deep copy, and owned by the
revision API, as that's what the API expects.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1bfa24030c..6eb67c75c3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -826,11 +826,11 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 }
 
 static void add_pathspecs(struct argv_array *args,
-			  struct pathspec ps) {
+			  const struct pathspec *ps) {
 	int i;
 
-	for (i = 0; i < ps.nr; i++)
-		argv_array_push(args, ps.items[i].match);
+	for (i = 0; i < ps->nr; i++)
+		argv_array_push(args, ps->items[i].match);
 }
 
 /*
@@ -840,7 +840,7 @@ static void add_pathspecs(struct argv_array *args,
  * = 0 if there are not any untracked files
  * > 0 if there are untracked files
  */
-static int get_untracked_files(struct pathspec ps, int include_untracked,
+static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 			       struct strbuf *untracked_files)
 {
 	int i;
@@ -853,12 +853,12 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
 	if (include_untracked != INCLUDE_ALL_FILES)
 		setup_standard_excludes(&dir);
 
-	seen = xcalloc(ps.nr, 1);
+	seen = xcalloc(ps->nr, 1);
 
-	max_len = fill_directory(&dir, the_repository->index, &ps);
+	max_len = fill_directory(&dir, the_repository->index, ps);
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (dir_path_match(&the_index, ent, &ps, max_len, seen)) {
+		if (dir_path_match(&the_index, ent, ps, max_len, seen)) {
 			found++;
 			strbuf_addstr(untracked_files, ent->name);
 			/* NUL-terminate: will be fed to update-index -z */
@@ -881,7 +881,7 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
  * = 0 if there are no changes.
  * > 0 if there are changes.
  */
-static int check_changes_tracked_files(struct pathspec ps)
+static int check_changes_tracked_files(const struct pathspec *ps)
 {
 	int result;
 	struct rev_info rev;
@@ -895,7 +895,7 @@ static int check_changes_tracked_files(struct pathspec ps)
 		return -1;
 
 	init_revisions(&rev, NULL);
-	rev.prune_data = ps;
+	copy_pathspec(&rev.prune_data, ps);
 
 	rev.diffopt.flags.quick = 1;
 	rev.diffopt.flags.ignore_submodules = 1;
@@ -920,7 +920,7 @@ static int check_changes_tracked_files(struct pathspec ps)
  * The function will fill `untracked_files` with the names of untracked files
  * It will return 1 if there were any changes and 0 if there were not.
  */
-static int check_changes(struct pathspec ps, int include_untracked,
+static int check_changes(const struct pathspec *ps, int include_untracked,
 			 struct strbuf *untracked_files)
 {
 	int ret = 0;
@@ -974,7 +974,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	return ret;
 }
 
-static int stash_patch(struct stash_info *info, struct pathspec ps,
+static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
@@ -1033,7 +1033,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	return ret;
 }
 
-static int stash_working_tree(struct stash_info *info, struct pathspec ps)
+static int stash_working_tree(struct stash_info *info, const struct pathspec *ps)
 {
 	int ret = 0;
 	struct rev_info rev;
@@ -1050,7 +1050,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	}
 	set_alternate_index_output(NULL);
 
-	rev.prune_data = ps;
+	copy_pathspec(&rev.prune_data, ps);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
 	rev.diffopt.format_callback_data = &diff_output;
@@ -1094,7 +1094,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	return ret;
 }
 
-static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
+static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
 			   int include_untracked, int patch_mode,
 			   struct stash_info *info, struct strbuf *patch,
 			   int quiet)
@@ -1226,10 +1226,10 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(ps))
+	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1238,7 +1238,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
+static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
 			 int keep_index, int patch_mode, int include_untracked)
 {
 	int ret = 0;
@@ -1258,15 +1258,15 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 	}
 
 	read_cache_preload(NULL);
-	if (!include_untracked && ps.nr) {
+	if (!include_untracked && ps->nr) {
 		int i;
-		char *ps_matched = xcalloc(ps.nr, 1);
+		char *ps_matched = xcalloc(ps->nr, 1);
 
 		for (i = 0; i < active_nr; i++)
-			ce_path_match(&the_index, active_cache[i], &ps,
+			ce_path_match(&the_index, active_cache[i], ps,
 				      ps_matched);
 
-		if (report_path_error(ps_matched, &ps, NULL)) {
+		if (report_path_error(ps_matched, ps, NULL)) {
 			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
 			ret = -1;
 			free(ps_matched);
@@ -1313,7 +1313,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 			  stash_msg_buf.buf);
 
 	if (!patch_mode) {
-		if (include_untracked && !ps.nr) {
+		if (include_untracked && !ps->nr) {
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
@@ -1327,7 +1327,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 			}
 		}
 		discard_cache();
-		if (ps.nr) {
+		if (ps->nr) {
 			struct child_process cp_add = CHILD_PROCESS_INIT;
 			struct child_process cp_diff = CHILD_PROCESS_INIT;
 			struct child_process cp_apply = CHILD_PROCESS_INIT;
@@ -1467,7 +1467,7 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 				     0);
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
-	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
+	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
 			     include_untracked);
 }
 
@@ -1504,7 +1504,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_push_stash(ps, stash_msg, quiet, keep_index,
+	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
 			    patch_mode, include_untracked);
 
 	strbuf_release(&stash_msg_buf);
-- 
2.21.0.474.g541d9dca55

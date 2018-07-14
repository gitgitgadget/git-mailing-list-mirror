Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E701F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeGNWFX (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35569 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbeGNWFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so19050835wrt.2
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/i0MUzQxaMEDrRwohA9f1swkviosCuDr5mMGAKA+bFE=;
        b=cxILuOleXZjOViAzIVlkTUQEEmB2uEAS9MESIRbMhsIupLfRLCGzw1dnaN8FrQtVSS
         gkP4iH59onSomvO+o+4MlE6l6ENLEWd1IVxVLoxd7Qlcoi08zlI/tL52GPQWquY2pB7G
         QfxFq3jGUxjnPKZQWPfjNsAOsIUyAzHnaesaYxglufCrGxQgOZnrPRyTmMnXWILdfOTR
         zeV5KE1SKytvx+eIBAu/O62n42OK6qxrdNBnDjLRlvBLMAgzk1VsPdcYCcF+txhvXIj3
         VmbOCyf5yuT74LZx33ahCU/lnccI6uvz/WUaAC1a4mvA7kR8WA8ntxJAZmeMjDse3R+g
         iiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/i0MUzQxaMEDrRwohA9f1swkviosCuDr5mMGAKA+bFE=;
        b=L5jn4fb7cQkhAA5JeyD/43w9Cdt77Twc92qRc09BpmkvMxbdFAdTsRJFAlxiROAfJq
         ns/pJcMPHADFuGyTmgD0z8Zn714cg7AoQQiKcA8SmxS01NHxfCDSob4ILSjyEk1YvrPy
         V/8zuuIyynHyAziUYD+Lt3HfjyIxyYi7rZu5DZ6T3ano4hplYM0AVOofUmhrKKycujBP
         70a88ArdjAbb3vq+Q9H40otUqRxa17jS5wlv1oysP3FLGEt7SdwxSKuue75fqqLlxLRd
         o8QVzp7dPIbog47u55cbfFQfbfnySACArrpcgKwobhkj6wjId4z1eV8WWpLaozf+DIgg
         Uu1A==
X-Gm-Message-State: AOUpUlHDNZoDypxT2u9e2WY/d0Xc/lhKwts0hwig6q+bIaCFQ1P7+gfM
        4kTRWFzjyM1u4SEzFzNlCT0/Hk9E
X-Google-Smtp-Source: AAOMgpf4ZP7eANYaI27gsvlhU9KSUgU9GTwa4FUUhnKgROl++JwwgQB2WhSj/IU6bqtyMUge2itBxQ==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr8814316wro.195.1531604695053;
        Sat, 14 Jul 2018 14:44:55 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id w21-v6sm4044799wmc.45.2018.07.14.14.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:44:54 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 04/11] rerere: mark strings for translation
Date:   Sat, 14 Jul 2018 22:44:36 +0100
Message-Id: <20180714214443.7184-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git rerere' is considered a plumbing command and as such its output
should be translated.  Its functionality is also only enabled through
a config setting, so scripts really shouldn't rely on the output
either way.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/rerere.c |  4 +--
 rerere.c         | 68 ++++++++++++++++++++++++------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index e0c67c98e9..5ed941b91f 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -75,7 +75,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
 		if (argc < 2)
-			warning("'git rerere forget' without paths is deprecated");
+			warning(_("'git rerere forget' without paths is deprecated"));
 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
 			       prefix, argv + 1);
 		return rerere_forget(&pathspec);
@@ -107,7 +107,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			const char *path = merge_rr.items[i].string;
 			const struct rerere_id *id = merge_rr.items[i].util;
 			if (diff_two(rerere_path(id, "preimage"), path, path, path))
-				die("unable to generate diff for '%s'", rerere_path(id, NULL));
+				die(_("unable to generate diff for '%s'"), rerere_path(id, NULL));
 		}
 	} else
 		usage_with_options(rerere_usage, options);
diff --git a/rerere.c b/rerere.c
index cde1f6e696..be98c0afcb 100644
--- a/rerere.c
+++ b/rerere.c
@@ -212,7 +212,7 @@ static void read_rr(struct string_list *rr)
 
 		/* There has to be the hash, tab, path and then NUL */
 		if (buf.len < 42 || get_sha1_hex(buf.buf, sha1))
-			die("corrupt MERGE_RR");
+			die(_("corrupt MERGE_RR"));
 
 		if (buf.buf[40] != '.') {
 			variant = 0;
@@ -221,10 +221,10 @@ static void read_rr(struct string_list *rr)
 			errno = 0;
 			variant = strtol(buf.buf + 41, &path, 10);
 			if (errno)
-				die("corrupt MERGE_RR");
+				die(_("corrupt MERGE_RR"));
 		}
 		if (*(path++) != '\t')
-			die("corrupt MERGE_RR");
+			die(_("corrupt MERGE_RR"));
 		buf.buf[40] = '\0';
 		id = new_rerere_id_hex(buf.buf);
 		id->variant = variant;
@@ -259,12 +259,12 @@ static int write_rr(struct string_list *rr, int out_fd)
 				    rr->items[i].string, 0);
 
 		if (write_in_full(out_fd, buf.buf, buf.len) < 0)
-			die("unable to write rerere record");
+			die(_("unable to write rerere record"));
 
 		strbuf_release(&buf);
 	}
 	if (commit_lock_file(&write_lock) != 0)
-		die("unable to write rerere record");
+		die(_("unable to write rerere record"));
 	return 0;
 }
 
@@ -484,12 +484,12 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	io.input = fopen(path, "r");
 	io.io.wrerror = 0;
 	if (!io.input)
-		return error_errno("could not open '%s'", path);
+		return error_errno(_("could not open '%s'"), path);
 
 	if (output) {
 		io.io.output = fopen(output, "w");
 		if (!io.io.output) {
-			error_errno("could not write '%s'", output);
+			error_errno(_("could not write '%s'"), output);
 			fclose(io.input);
 			return -1;
 		}
@@ -499,15 +499,15 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 
 	fclose(io.input);
 	if (io.io.wrerror)
-		error("there were errors while writing '%s' (%s)",
+		error(_("there were errors while writing '%s' (%s)"),
 		      path, strerror(io.io.wrerror));
 	if (io.io.output && fclose(io.io.output))
-		io.io.wrerror = error_errno("failed to flush '%s'", path);
+		io.io.wrerror = error_errno(_("failed to flush '%s'"), path);
 
 	if (hunk_no < 0) {
 		if (output)
 			unlink_or_warn(output);
-		return error("could not parse conflict hunks in '%s'", path);
+		return error(_("could not parse conflict hunks in '%s'"), path);
 	}
 	if (io.io.wrerror)
 		return -1;
@@ -568,7 +568,7 @@ static int find_conflict(struct string_list *conflict)
 {
 	int i;
 	if (read_cache() < 0)
-		return error("index file corrupt");
+		return error(_("index file corrupt"));
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -601,7 +601,7 @@ int rerere_remaining(struct string_list *merge_rr)
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
 	if (read_cache() < 0)
-		return error("index file corrupt");
+		return error(_("index file corrupt"));
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -684,17 +684,17 @@ static int merge(const struct rerere_id *id, const char *path)
 	 * Mark that "postimage" was used to help gc.
 	 */
 	if (utime(rerere_path(id, "postimage"), NULL) < 0)
-		warning_errno("failed utime() on '%s'",
+		warning_errno(_("failed utime() on '%s'"),
 			      rerere_path(id, "postimage"));
 
 	/* Update "path" with the resolution */
 	f = fopen(path, "w");
 	if (!f)
-		return error_errno("could not open '%s'", path);
+		return error_errno(_("could not open '%s'"), path);
 	if (fwrite(result.ptr, result.size, 1, f) != 1)
-		error_errno("could not write '%s'", path);
+		error_errno(_("could not write '%s'"), path);
 	if (fclose(f))
-		return error_errno("writing '%s' failed", path);
+		return error_errno(_("writing '%s' failed"), path);
 
 out:
 	free(cur.ptr);
@@ -714,13 +714,13 @@ static void update_paths(struct string_list *update)
 		struct string_list_item *item = &update->items[i];
 		if (add_file_to_cache(item->string, 0))
 			exit(128);
-		fprintf(stderr, "Staged '%s' using previous resolution.\n",
+		fprintf_ln(stderr, _("Staged '%s' using previous resolution."),
 			item->string);
 	}
 
 	if (write_locked_index(&the_index, &index_lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die("unable to write new index file");
+		die(_("unable to write new index file"));
 }
 
 static void remove_variant(struct rerere_id *id)
@@ -752,7 +752,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 		if (!handle_file(path, NULL, NULL)) {
 			copy_file(rerere_path(id, "postimage"), path, 0666);
 			id->collection->status[variant] |= RR_HAS_POSTIMAGE;
-			fprintf(stderr, "Recorded resolution for '%s'.\n", path);
+			fprintf_ln(stderr, _("Recorded resolution for '%s'."), path);
 			free_rerere_id(rr_item);
 			rr_item->util = NULL;
 			return;
@@ -786,9 +786,9 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 		if (rerere_autoupdate)
 			string_list_insert(update, path);
 		else
-			fprintf(stderr,
-				"Resolved '%s' using previous resolution.\n",
-				path);
+			fprintf_ln(stderr,
+				   _("Resolved '%s' using previous resolution."),
+				   path);
 		free_rerere_id(rr_item);
 		rr_item->util = NULL;
 		return;
@@ -802,11 +802,11 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
 		const char *path = rerere_path(id, "postimage");
 		if (unlink(path))
-			die_errno("cannot unlink stray '%s'", path);
+			die_errno(_("cannot unlink stray '%s'"), path);
 		id->collection->status[variant] &= ~RR_HAS_POSTIMAGE;
 	}
 	id->collection->status[variant] |= RR_HAS_PREIMAGE;
-	fprintf(stderr, "Recorded preimage for '%s'\n", path);
+	fprintf_ln(stderr, _("Recorded preimage for '%s'"), path);
 }
 
 static int do_plain_rerere(struct string_list *rr, int fd)
@@ -878,7 +878,7 @@ static int is_rerere_enabled(void)
 		return rr_cache_exists;
 
 	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
-		die("could not create directory '%s'", git_path_rr_cache());
+		die(_("could not create directory '%s'"), git_path_rr_cache());
 	return 1;
 }
 
@@ -1031,7 +1031,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 */
 	ret = handle_cache(path, sha1, NULL);
 	if (ret < 1)
-		return error("could not parse conflict hunks in '%s'", path);
+		return error(_("could not parse conflict hunks in '%s'"), path);
 
 	/* Nuke the recorded resolution for the conflict */
 	id = new_rerere_id(sha1);
@@ -1049,7 +1049,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 		handle_cache(path, sha1, rerere_path(id, "thisimage"));
 		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
 			free(cur.ptr);
-			error("failed to update conflicted state in '%s'", path);
+			error(_("failed to update conflicted state in '%s'"), path);
 			goto fail_exit;
 		}
 		cleanly_resolved = !try_merge(id, path, &cur, &result);
@@ -1060,16 +1060,16 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	}
 
 	if (id->collection->status_nr <= id->variant) {
-		error("no remembered resolution for '%s'", path);
+		error(_("no remembered resolution for '%s'"), path);
 		goto fail_exit;
 	}
 
 	filename = rerere_path(id, "postimage");
 	if (unlink(filename)) {
 		if (errno == ENOENT)
-			error("no remembered resolution for '%s'", path);
+			error(_("no remembered resolution for '%s'"), path);
 		else
-			error_errno("cannot unlink '%s'", filename);
+			error_errno(_("cannot unlink '%s'"), filename);
 		goto fail_exit;
 	}
 
@@ -1079,7 +1079,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 * the postimage.
 	 */
 	handle_cache(path, sha1, rerere_path(id, "preimage"));
-	fprintf(stderr, "Updated preimage for '%s'\n", path);
+	fprintf_ln(stderr, _("Updated preimage for '%s'"), path);
 
 	/*
 	 * And remember that we can record resolution for this
@@ -1088,7 +1088,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	item = string_list_insert(rr, path);
 	free_rerere_id(item);
 	item->util = id;
-	fprintf(stderr, "Forgot resolution for '%s'\n", path);
+	fprintf(stderr, _("Forgot resolution for '%s'\n"), path);
 	return 0;
 
 fail_exit:
@@ -1103,7 +1103,7 @@ int rerere_forget(struct pathspec *pathspec)
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 	if (read_cache() < 0)
-		return error("index file corrupt");
+		return error(_("index file corrupt"));
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
 	if (fd < 0)
@@ -1191,7 +1191,7 @@ void rerere_gc(struct string_list *rr)
 	git_config(git_default_config, NULL);
 	dir = opendir(git_path("rr-cache"));
 	if (!dir)
-		die_errno("unable to open rr-cache directory");
+		die_errno(_("unable to open rr-cache directory"));
 	/* Collect stale conflict IDs ... */
 	while ((e = readdir(dir))) {
 		struct rerere_dir *rr_dir;
-- 
2.17.0.410.g65aef3a6c4


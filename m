Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D4621847
	for <e@80x24.org>; Wed,  2 May 2018 15:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbeEBPcc (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 11:32:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46895 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbeEBPc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 11:32:29 -0400
Received: by mail-lf0-f65.google.com with SMTP id v85-v6so21449604lfa.13
        for <git@vger.kernel.org>; Wed, 02 May 2018 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dh/tW9yKytm/K2W1+FE480R728h1JzqfeE8N9jR9SdU=;
        b=byvgDizuvEIcHmpo0+E0XZi1Oa8q4aso3fVSY429a+X7kdwid6Ve1qjhLHcpZOW7V5
         YXwBduZvfN3lNMb3X755g3RApWuM0Sn0YCuHj81Tl8T5HmySY83MO+Pb+BKCo1fLDOnq
         7VNm9taH6F++/OLPgMBNBKOTkJfpcuVVabJ5n+qLmfyQZfyy24Vb774eSQ6QZkz+O/MN
         E4cOEk9Ug6xvXcbwAJ4vCrs9G7/ZxK3iZrbBW0yPw14agHe+N6duxB3Ku1KaKMy+YD/u
         TWvUNSWq2KcaLeALK8hJXXvLRXbHFfXz30CIVp5QMXBYzJDQIm1clL6rDHwjPQszotsd
         MYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dh/tW9yKytm/K2W1+FE480R728h1JzqfeE8N9jR9SdU=;
        b=Dp6cHjS3ayRXM00arH89S2grYjO79XZjmvHfCOMN1we4FZvg++mJofjWSFV+VgquN1
         0vacU4YOXdXfRZlXzVkubRfrjDp17Jv9pCDOSCw9bZocxy50zNYSXjgWtv0WAPM5iIy2
         IruMi+hiqEQHG7PsfehAuLxhNS8sYkof/+NzeHSfDvFiDoHM3E99Or1Oks6Ghs35Mj4w
         RVzASEFzPVLZdX+3ZHlUg/dbV02wkYhGE0IJMh1JAe7TmqnvZf+yT7IHREwGSx/p/hdp
         23xK/GX13AcJuSraqCrGe83lLxQVXczUy3P/Mh4kgK43ck1k3gPEEnISRJjjkJZv+iYs
         Z6Tw==
X-Gm-Message-State: ALQs6tBUak6Q366Jz3cy7k3EKV91dp7Kq7RtIvPSUjYDVoFjPDJjsL0i
        cZBH6J2lURtux3sdjno5ZBE=
X-Google-Smtp-Source: AB8JxZqkhynKjaq5txOBaC18kZQ3COIHz1MLfPSkwzgcC1gJaAhxKr1Xzbmlqknbfg0XXjiw5GzQ2Q==
X-Received: by 2002:a19:d14a:: with SMTP id i71-v6mr11767331lfg.1.1525275147801;
        Wed, 02 May 2018 08:32:27 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y24-v6sm2430427ljy.21.2018.05.02.08.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 08:32:26 -0700 (PDT)
Date:   Wed, 2 May 2018 17:32:24 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/42] object_id part 13
Message-ID: <20180502153224.GA8237@duynguyen.home>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 02, 2018 at 12:25:28AM +0000, brian m. carlson wrote:
> Changes from v1:
> * Add missing sign-off.
> * Removed unneeded braces from init_pack_info.
> * Express 51 in terms of the_hash_algo->hexsz.
> * Fix comments referring to SHA-1.
> * Update commit messages as suggested.
> * Add and use empty_tree_oid_hex and empty_blob_oid_hex.

Interdiff for people who don't have time to read 42 patches yet

diff --git a/builtin/merge.c b/builtin/merge.c
index 8d75ebe64b..7084bcfdea 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -290,7 +290,7 @@ static void read_empty(const struct object_id *oid, int verbose)
 		args[i++] = "-v";
 	args[i++] = "-m";
 	args[i++] = "-u";
-	args[i++] = oid_to_hex(the_hash_algo->empty_tree);
+	args[i++] = empty_tree_oid_hex();
 	args[i++] = oid_to_hex(oid);
 	args[i] = NULL;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c31ceb30c2..dca523f50f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -968,7 +968,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 		return "Working directory has unstaged changes";
 
 	/* diff-index with either HEAD or an empty tree */
-	diff_index[4] = head_has_history() ? "HEAD" : oid_to_hex(the_hash_algo->empty_tree);
+	diff_index[4] = head_has_history() ? "HEAD" : empty_tree_oid_hex();
 
 	child_process_init(&child);
 	child.argv = diff_index;
diff --git a/cache.h b/cache.h
index c5b041019b..71b3c1b15b 100644
--- a/cache.h
+++ b/cache.h
@@ -1033,6 +1033,9 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
 	return !oidcmp(oid, the_hash_algo->empty_tree);
 }
 
+const char *empty_tree_oid_hex(void);
+const char *empty_blob_oid_hex(void);
+
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
diff --git a/http.c b/http.c
index ec70676748..312a5e1833 100644
--- a/http.c
+++ b/http.c
@@ -2070,7 +2070,7 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 				get_sha1_hex(data + i + 6, hash);
 				fetch_and_setup_pack_index(packs_head, hash,
 						      base_url);
-				i += 51;
+				i += hexsz + 11;
 				break;
 			}
 		default:
diff --git a/sequencer.c b/sequencer.c
index 12c1e1cdbb..94b6513402 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1480,8 +1480,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
 			oidcpy(&head, the_hash_algo->empty_tree);
-		if (index_differs_from(unborn ?
-				       oid_to_hex(the_hash_algo->empty_tree) : "HEAD",
+		if (index_differs_from(unborn ? empty_tree_oid_hex() : "HEAD",
 				       NULL, 0))
 			return error_dirty_index(opts);
 	}
diff --git a/server-info.c b/server-info.c
index 828ec5e538..7ce6dcd67b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -223,11 +223,9 @@ static void init_pack_info(const char *infofile, int force)
 	else
 		stale = 1;
 
-	for (i = 0; i < num_pack; i++) {
-		if (stale) {
+	for (i = 0; i < num_pack; i++)
+		if (stale)
 			info[i]->old_num = -1;
-		}
-	}
 
 	/* renumber them */
 	QSORT(info, num_pack, compare_info);
diff --git a/sha1_file.c b/sha1_file.c
index 794753bd54..bf6c8da3ff 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -109,6 +109,18 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 };
 
+const char *empty_tree_oid_hex(void)
+{
+	static char buf[GIT_MAX_HEXSZ + 1];
+	return oid_to_hex_r(buf, the_hash_algo->empty_tree);
+}
+
+const char *empty_blob_oid_hex(void)
+{
+	static char buf[GIT_MAX_HEXSZ + 1];
+	return oid_to_hex_r(buf, the_hash_algo->empty_blob);
+}
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
diff --git a/submodule.c b/submodule.c
index 22a96b7af0..ee7eea4877 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1567,7 +1567,7 @@ static void submodule_reset_index(const char *path)
 				   get_super_prefix_or_empty(), path);
 	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
-	argv_array_push(&cp.args, oid_to_hex(the_hash_algo->empty_tree));
+	argv_array_push(&cp.args, empty_tree_oid_hex());
 
 	if (run_command(&cp))
 		die("could not reset submodule index");
@@ -1659,9 +1659,9 @@ int submodule_move_head(const char *path,
 		argv_array_push(&cp.args, "-m");
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
-		argv_array_push(&cp.args, old_head ? old_head : oid_to_hex(the_hash_algo->empty_tree));
+		argv_array_push(&cp.args, old_head ? old_head : empty_tree_oid_hex());
 
-	argv_array_push(&cp.args, new_head ? new_head : oid_to_hex(the_hash_algo->empty_tree));
+	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
 
 	if (run_command(&cp)) {
 		ret = -1;
diff --git a/upload-pack.c b/upload-pack.c
index 0858527c5b..1fb4942235 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -492,7 +492,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 		"rev-list", "--stdin", NULL,
 	};
 	struct object *o;
-	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + SHA-1 + LF */
+	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	int i;
 
 	cmd->argv = argv;
@@ -561,7 +561,7 @@ static int get_reachable_list(struct object_array *src,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int i;
 	struct object *o;
-	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + SHA-1 + LF */
+	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (do_reachable_revlist(&cmd, src, reachable) < 0)
diff --git a/wt-status.c b/wt-status.c
index 857724bd60..e44115b3be 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -600,11 +600,10 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
-	char hex[GIT_MAX_HEXSZ + 1];
 
 	init_revisions(&rev, NULL);
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? oid_to_hex_r(hex, the_hash_algo->empty_tree) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.flags.override_submodule_config = 1;
@@ -976,14 +975,13 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	struct setup_revision_opt opt;
 	int dirty_submodules;
 	const char *c = color(WT_STATUS_HEADER, s);
-	char hex[GIT_MAX_HEXSZ + 1];
 
 	init_revisions(&rev, NULL);
 	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? oid_to_hex_r(hex, the_hash_algo->empty_tree) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;


--
Duy

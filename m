Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B61520D12
	for <e@80x24.org>; Thu,  1 Jun 2017 05:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdFAFy1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 01:54:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34841 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdFAFy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 01:54:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so6624121pfd.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JC/b4+debpsHDtxkNaJbH5vS5TJhtLf0K7dFXFzxjtQ=;
        b=mS2dXVk/NVcv+rRhsEa9fzdLGAYlPM3WROEP5a4qj0nMLVcXxQsvjaUgDwcroFfy+C
         PKeQwrmWfnHU6WbK57zYszGtNcTVM/ZxShEAdyAzhCar1KiNXMF5vD6f4+/Aj/dvNP+7
         BsTFeBanUHLLiw/VG9JyDkUXSXqX5Z7bUwS8gxsKv20DKdvED5ansBN0PKIO01x8Hx0u
         umlSzVGboXHUAbC7XZETrBqDXZcjtpKF35lrDYXZulH6DnNl0Yn+4eXS/OeEfj3KSwKm
         rM7nr+hsEbyq/3H2WMmkMXXGBCUue/ShHvhH6983DeSkOTNXNg0MGtY+8h+pgBo6fgdV
         ns3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JC/b4+debpsHDtxkNaJbH5vS5TJhtLf0K7dFXFzxjtQ=;
        b=hxAzvVqZbmk2E556nlVwrCrJxjKDUeskfgs6p46kesVd6IclZwpnyjRfJ1ooXtAmOt
         s2pxl3wuzZYj26olYWkhqNd6zpBdhlSo2jG6ttYArwSkgXNUHzFzpCXeQnr8eFbahYyq
         04xrxG/5s/NAI310/EwhD5M/7Mctq0WFI9ndVFFFmsRQxa6c0KxZ7fk/GLZ1QmKOL6Ue
         Y8fchVbke9bi/j3BbCjBt/3Ucy6lFCoy3oT5tO5aFQ0UqSHC6L+8xvHdwNiq9nEeMNps
         x7RLI7yMD+UIrRbVzRM6cwA9ffVEbsoliqbHNCKzsXktQ86tMp57B51yJPDHoAgyOxK5
         qiJA==
X-Gm-Message-State: AODbwcBYB8kJKowNPag3KrJ9ic5tkLpyPmjH6/D70AGgUmqZtaoKkmPd
        t8sOyUNW5L1jgg==
X-Received: by 10.99.125.87 with SMTP id m23mr36763209pgn.79.1496296450691;
        Wed, 31 May 2017 22:54:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id d13sm27756385pfl.12.2017.05.31.22.54.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 22:54:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
        <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
        <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
        <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
        <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
        <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
        <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
        <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
        <xmqq7f0w6z7u.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 01 Jun 2017 14:54:08 +0900
In-Reply-To: <xmqq7f0w6z7u.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Jun 2017 14:42:13 +0900")
Message-ID: <xmqq37bk6ynz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> For now, I will mix this in when queuing the whole thing in 'pu', as
> I hate to push out something that does not even work for me to the
> general public.
> 
> -- >8 --
> Subject: [PATCH] diff- and log- family: handle "git cmd -h" early
> ...

And then the check_help_option() thing may look like this.  

I am not proud of the way it "unifies" the two styles of usage
strings, obviously.

One benefit this patch has is that it makes it easier to highlight
what it does *not* touch.

    $ git grep -A2 -E -e 'a(rg)?c [!=]= 2 .*strcmp.*-h'

shows there are somewhat curious construct

	if (argc != 2 || !strcmp(argv[1], "-h"))
		usage(...);

left in the code.  Upon closer inspection, they all happen to be
doing the right thing for their current set of options and
arguments, but they are somewhat ugly.


 builtin/am.c               |  3 +--
 builtin/branch.c           |  3 +--
 builtin/check-ref-format.c |  3 +--
 builtin/checkout-index.c   |  7 ++++---
 builtin/commit.c           |  6 ++----
 builtin/diff-files.c       |  3 +--
 builtin/diff-index.c       |  3 +--
 builtin/diff-tree.c        |  3 +--
 builtin/gc.c               |  3 +--
 builtin/index-pack.c       |  3 +--
 builtin/ls-files.c         |  3 +--
 builtin/merge-ours.c       |  3 +--
 builtin/merge.c            |  3 +--
 builtin/pack-redundant.c   |  3 +--
 builtin/rev-list.c         |  3 +--
 builtin/update-index.c     |  3 +--
 builtin/upload-archive.c   |  3 +--
 fast-import.c              |  3 +--
 git-compat-util.h          |  3 +++
 usage.c                    | 11 +++++++++++
 20 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8881d73615..12b7298907 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2307,8 +2307,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(usage, options);
+	check_help_option(argc, argv, usage, options);
 
 	git_config(git_am_config, NULL);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 83fcda43dc..8c4465f0e4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -599,8 +599,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_branch_usage, options);
+	check_help_option(argc, argv, builtin_branch_usage, options);
 
 	git_config(git_branch_config, NULL);
 
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index eac499450f..aab5776dd5 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -55,8 +55,7 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	int flags = 0;
 	const char *refname;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_check_ref_format_usage);
+	check_help_option(argc, argv, builtin_check_ref_format_usage, NULL);
 
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 07631d0c9c..8dd28ae8ba 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -179,9 +179,10 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_checkout_index_usage,
-				   builtin_checkout_index_options);
+	check_help_option(argc, argv,
+			  builtin_checkout_index_usage,
+			  builtin_checkout_index_options);
+
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 66c9ac587b..05c2f61e33 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1376,8 +1376,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_status_usage, builtin_status_options);
+	check_help_option(argc, argv, builtin_status_usage, builtin_status_options);
 
 	status_init_config(&s, git_status_config);
 	argc = parse_options(argc, argv, prefix,
@@ -1661,8 +1660,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_usage, builtin_commit_options);
+	check_help_option(argc, argv, builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index c97069a714..ff52edb46c 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -20,8 +20,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	int result;
 	unsigned options = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_files_usage);
+	check_help_option(argc, argv, diff_files_usage, NULL);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index d59bf6cf5f..518482850e 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -17,8 +17,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int i;
 	int result;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_cache_usage);
+	check_help_option(argc, argv, diff_cache_usage, NULL);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index a4e7398b4b..aa12c02203 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -105,8 +105,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt s_r_opt;
 	int read_stdin = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_tree_usage);
+	check_help_option(argc, argv, diff_tree_usage, NULL);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
diff --git a/builtin/gc.c b/builtin/gc.c
index f484eda43c..b1a6163347 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -363,8 +363,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_gc_usage, builtin_gc_options);
+	check_help_option(argc, argv, builtin_gc_usage, builtin_gc_options);
 
 	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 04b9dcaf0f..2be24276d6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1640,8 +1640,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(index_pack_usage);
+	check_help_option(argc, argv, index_pack_usage, NULL);
 
 	check_replace_refs = 0;
 	fsck_options.walk = mark_link;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b376afc312..6d5334aae5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -587,8 +587,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(ls_files_usage, builtin_ls_files_options);
+	check_help_option(argc, argv, ls_files_usage, builtin_ls_files_options);
 
 	memset(&dir, 0, sizeof(dir));
 	prefix = cmd_prefix;
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 684411694f..52be2fa2f4 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -20,8 +20,7 @@ static const char *diff_index_args[] = {
 
 int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 {
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_merge_ours_usage);
+	check_help_option(argc, argv, builtin_merge_ours_usage, NULL);
 
 	/*
 	 * We need to exit with 2 if the index does not match our HEAD tree,
diff --git a/builtin/merge.c b/builtin/merge.c
index eab03a026d..446eb0f3fb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1108,8 +1108,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	void *branch_to_free;
 	int orig_argc = argc;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_merge_usage, builtin_merge_options);
+	check_help_option(argc, argv, builtin_merge_usage, builtin_merge_options);
 
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cb1df1c761..80603b9b47 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -601,8 +601,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	unsigned char *sha1;
 	char buf[42]; /* 40 byte sha1 + \n + \0 */
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(pack_redundant_usage);
+	check_help_option(argc, argv, pack_redundant_usage, NULL);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b250c515b1..ce6acf18c7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -277,8 +277,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int use_bitmap_index = 0;
 	const char *show_progress = NULL;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(rev_list_usage);
+	check_help_option(argc, argv, rev_list_usage, NULL);
 
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 32fd977b43..e6df968056 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1009,8 +1009,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(update_index_usage, options);
+	check_help_option(argc, argv, update_index_usage, options);
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 84532ae9a9..0e097969db 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -76,8 +76,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	struct child_process writer = { argv };
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(upload_archive_usage);
+	check_help_option(argc, argv, upload_archive_usage, NULL);
 
 	/*
 	 * Set up sideband subprocess.
diff --git a/fast-import.c b/fast-import.c
index 9a22fc92c0..fd7a4fb472 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3447,8 +3447,7 @@ int cmd_main(int argc, const char **argv)
 {
 	unsigned int i;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(fast_import_usage);
+	check_help_option(argc, argv, fast_import_usage, NULL);
 
 	setup_git_directory();
 	reset_pack_idx_option(&pack_idx_opts);
diff --git a/git-compat-util.h b/git-compat-util.h
index 22b756ed51..c30b6b9a72 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -418,6 +418,9 @@ extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+struct option;
+extern void check_help_option(int, const char **, const void *, struct option *);
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
diff --git a/usage.c b/usage.c
index 2f87ca69a8..007d732094 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,7 @@
  */
 #include "git-compat-util.h"
 #include "cache.h"
+#include "parse-options.h"
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {
@@ -225,3 +226,13 @@ NORETURN void BUG(const char *fmt, ...)
 	va_end(ap);
 }
 #endif
+
+void check_help_option(int argc, const char **argv, const void *help, struct option *opt)
+{
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		if (opt)
+			usage_with_options((const char * const *)help, opt);
+		else
+			usage((const char *)help);
+	}
+}
-- 
2.13.0-513-g1c0955652f


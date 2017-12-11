Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3646E1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdLKT7M (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 14:59:12 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:39789 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdLKT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 14:59:11 -0500
Received: by mail-it0-f49.google.com with SMTP id 68so18676508ite.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FNCDCfjSDtww4vAGxtjvgj7uYvO/bcn8d6zF4NjDv6Q=;
        b=wFZ0cGHqqANGUeQ6S7usuzIiz+P/1Y9APK4W9PKXF+ByOGBEIzWklgavVEcU+QF1Qx
         hEpdBnewQvU0iTOftmy3g5TGZNQEAoRGRHziIIqQw8zty94qVSlCbrstRqgm9/54Vn+0
         hlplxHHCxGkp87BDARI19Yq0td1wDUae3xpQREDxeoo7Q/aXFIDWgw8zAMgvYBPW5l2Y
         twVkFOie3tCzpnAcu6eQothPYRXqNRgZnYzaKRf+1shmVnKOJAGdUooZLFf+jjRIlfxe
         kAnViD5fuiE9bHtLaOVdp9ZPg4l3myC7tL8OohpnsKSc32ceUSukWvuC1Xi/J/UWg6/0
         ZqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FNCDCfjSDtww4vAGxtjvgj7uYvO/bcn8d6zF4NjDv6Q=;
        b=KykNFUO7JzcZMkk43Cri4OdtxDZpEPoeCJPRt3yK1eZBRskf2TFCwQnKYNa+TcGAbb
         efl1s2rm4GokeNIyClyBo+sN3JtT0mX8A2DYk5I4nmbq8zOwOEiMASQhmdZD2qWH+OKZ
         5BmA2/K2AHoFJQrkHjLRW8vHVAqZdJW/WV0ja2IQdEQP6C+wqy7WAiHsSw8wRF+/gBF/
         TSoLbuKsC7W6mveLk6Q+J51fBreuGfxWUFO8161c/L9RL+TBz9bXRoWP2F3fTiRRD8v4
         seBRfckRYZ6yMBteHJQx05RTuv1wctcZlFwP+LdBvia3TtKtCRfat5Nc8FFVC+g0FV3Z
         w0IQ==
X-Gm-Message-State: AKGB3mIZcHky+L1Fjil2aEmgccMgEs8v9G6x35VD4l5EktT+KCxCTHwv
        harS64xt+W+csOeiUTtRnoLhGCVrnNc=
X-Google-Smtp-Source: ACJfBosQ9T/wITioA5v5u82/b084hdR68obQD9qXjgggeBKasRTjMp1qOHnkIfJZTHm+jDJCjDm7pg==
X-Received: by 10.36.64.73 with SMTP id n70mr2348336ita.89.1513022349935;
        Mon, 11 Dec 2017 11:59:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m184sm4030136itg.8.2017.12.11.11.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 11:59:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     peff@peff.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/1] diff-core blobfind
Date:   Mon, 11 Dec 2017 11:58:34 -0800
Message-Id: <20171211195835.57057-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171208002447.20261-1-sbeller@google.com>
References: <20171208002447.20261-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* added check for unmerged entries (!DIFF_PAIR_UNMERGED)
* added support to find submodules
* renamed the UI to `--find-object` instead of --blobfind.

diff to currently queued below.

Thanks,
Stefan

Stefan Beller (1):
  diffcore: add a filter to find a specific blob

 Documentation/diff-options.txt |  6 +++++
 Makefile                       |  1 +
 builtin/log.c                  |  2 +-
 diff.c                         | 21 ++++++++++++++++-
 diff.h                         |  3 +++
 diffcore-oidfind.c             | 42 ++++++++++++++++++++++++++++++++++
 diffcore.h                     |  1 +
 revision.c                     |  5 ++++-
 t/t4064-diff-oidfind.sh        | 51 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 diffcore-oidfind.c
 create mode 100755 t/t4064-diff-oidfind.sh

-- 
2.15.1.424.g9478a66081-goog

diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
index 34d53b95f1..67a99e522b 100644
--- c/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -501,9 +501,10 @@ information.
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
 
---blobfind=<blob-id>::
+--find-object=<object-id>::
 	Restrict the output such that one side of the diff
-	matches the given blob-id.
+	matches the given object id. The object can be a blob,
+	or gitlink entry.
 
 endif::git-format-patch[]
 
diff --git c/Makefile w/Makefile
index fdfa8f38f6..fc2b136694 100644
--- c/Makefile
+++ w/Makefile
@@ -775,7 +775,7 @@ LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-blobfind.o
+LIB_OBJS += diffcore-oidfind.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
diff --git c/builtin/log.c w/builtin/log.c
index 7b91f61423..2ab7f338e6 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -181,7 +181,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.follow_renames || rev->diffopt.blobfind)
+	    rev->diffopt.flags.follow_renames || rev->diffopt.oidfind)
 		rev->always_show_header = 0;
 
 	if (source)
diff --git c/diff.c w/diff.c
index 8861f89ab1..cb35934634 100644
--- c/diff.c
+++ w/diff.c
@@ -4082,7 +4082,7 @@ void diff_setup(struct diff_options *options)
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	options->flags.rename_empty = 1;
-	options->blobfind = NULL;
+	options->oidfind = NULL;
 
 	/* pathchange left =NULL by default */
 	options->change = diff_change;
@@ -4488,16 +4488,17 @@ static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *ar
 	return 1;
 }
 
-static int parse_blobfind_opt(struct diff_options *opt, const char *arg)
+static int parse_oidfind_opt(struct diff_options *opt, const char *arg)
 {
 	struct object_id oid;
 
-	if (get_oid_blob(arg, &oid) || sha1_object_info(oid.hash, NULL) != OBJ_BLOB)
-		return error("object '%s' is not a blob", arg);
+	/* We don't even need to have the object, any oid works. */
+	if (get_oid_blob(arg, &oid))
+		return error("unable to resolve '%s'", arg);
 
-	if (!opt->blobfind)
-		opt->blobfind = xcalloc(1, sizeof(*opt->blobfind));
-	oidset_insert(opt->blobfind, &oid);
+	if (!opt->oidfind)
+		opt->oidfind = xcalloc(1, sizeof(*opt->oidfind));
+	oidset_insert(opt->oidfind, &oid);
 	return 1;
 }
 
@@ -4750,8 +4751,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if ((argcount = short_opt('O', av, &optarg))) {
 		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
-	} else if (skip_prefix(arg, "--blobfind=", &arg))
-		return parse_blobfind_opt(options, arg);
+	} else if (skip_prefix(arg, "--find-object=", &arg))
+		return parse_oidfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
@@ -5786,8 +5787,8 @@ void diffcore_std(struct diff_options *options)
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
 
-		if (options->blobfind)
-			diffcore_blobfind(options);
+		if (options->oidfind)
+			diffcore_oidfind(options);
 		if (options->break_opt != -1)
 			diffcore_break(options->break_opt);
 		if (options->detect_rename)
diff --git c/diff.h w/diff.h
index 9178e498fa..d2badb29a1 100644
--- c/diff.h
+++ w/diff.h
@@ -175,7 +175,7 @@ struct diff_options {
 	enum diff_words_type word_diff;
 	enum diff_submodule_format submodule_format;
 
-	struct oidset *blobfind;
+	struct oidset *oidfind;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
diff --git c/diffcore-blobfind.c w/diffcore-oidfind.c
similarity index 64%
rename from diffcore-blobfind.c
rename to diffcore-oidfind.c
index e65c7cad6e..39a0b5390f 100644
--- c/diffcore-blobfind.c
+++ w/diffcore-oidfind.c
@@ -10,16 +10,17 @@ static void diffcore_filter_blobs(struct diff_queue_struct *q,
 {
 	int src, dst;
 
-	if (!options->blobfind)
-		BUG("blobfind oidset not initialized???");
+	if (!options->oidfind)
+		BUG("oidfind oidset not initialized???");
 
 	for (src = dst = 0; src < q->nr; src++) {
 		struct diff_filepair *p = q->queue[src];
 
-		if ((DIFF_FILE_VALID(p->one) &&
-		     oidset_contains(options->blobfind, &p->one->oid)) ||
+		if (!DIFF_PAIR_UNMERGED(p) &&
+		    ((DIFF_FILE_VALID(p->one) &&
+		     oidset_contains(options->oidfind, &p->one->oid)) ||
 		    (DIFF_FILE_VALID(p->two) &&
-		     oidset_contains(options->blobfind, &p->two->oid))) {
+		     oidset_contains(options->oidfind, &p->two->oid)))) {
 			q->queue[dst] = p;
 			dst++;
 		} else {
@@ -35,7 +36,7 @@ static void diffcore_filter_blobs(struct diff_queue_struct *q,
 	}
 }
 
-void diffcore_blobfind(struct diff_options *options)
+void diffcore_oidfind(struct diff_options *options)
 {
 	diffcore_filter_blobs(&diff_queued_diff, options);
 }
diff --git c/diffcore.h w/diffcore.h
index 431917672f..6bb1d76b1a 100644
--- c/diffcore.h
+++ w/diffcore.h
@@ -107,7 +107,7 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-extern void diffcore_blobfind(struct diff_options *);
+extern void diffcore_oidfind(struct diff_options *);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
diff --git c/revision.c w/revision.c
index 8e1a89f832..e4611054b9 100644
--- c/revision.c
+++ w/revision.c
@@ -2410,7 +2410,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
 	    revs->diffopt.flags.follow_renames ||
-	    revs->diffopt.blobfind)
+	    revs->diffopt.oidfind)
 		revs->diff = 1;
 
 	if (revs->topo_order)
@@ -2884,7 +2884,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
-	if (revs->diffopt.blobfind)
+	if (revs->diffopt.oidfind)
 		revs->simplify_history = 0;
 	return 0;
 }
diff --git c/t/t4064-diff-blobfind.sh w/t/t4064-diff-oidfind.sh
similarity index 65%
rename from t/t4064-diff-blobfind.sh
rename to t/t4064-diff-oidfind.sh
index b2c2964d77..7afe62df87 100755
--- c/t/t4064-diff-blobfind.sh
+++ w/t/t4064-diff-oidfind.sh
@@ -26,8 +26,24 @@ test_expect_success 'find the greeting blob' '
 	add the greeting blob
 	EOF
 
-	git log --abbrev=12 --oneline --blobfind=greeting^{blob} >actual.raw &&
-	cut -c 14- actual.raw >actual &&
+	git log --format=%s --find-object=greeting^{blob} >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'setup a submodule' '
+	test_create_repo sub &&
+	test_commit -C sub sub &&
+	git submodule add ./sub sub &&
+	git commit -a -m "add sub"
+'
+
+test_expect_success 'find a submodule' '
+	cat >expect <<-EOF &&
+	add sub
+	EOF
+
+	git log --format=%s --find-object=HEAD:sub >actual &&
 
 	test_cmp expect actual
 '

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EA81F404
	for <e@80x24.org>; Sun, 12 Aug 2018 09:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeHLLox (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 07:44:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42378 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbeHLLox (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 07:44:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so10275573ljc.9
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 02:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ZPSW+X3R/1EjweWTRb2nZGc4l5E3AS8vBCcEiptLZE=;
        b=nSWttc7PQKjU7r0qcmsVq1MA0ieSCVRPT2Jdsn3VpaWLhbCRV4GZSeaNa8GgCA/kdp
         x4pjzxcCd6et5upTssujTQg4rrfGVBcrLB8NIUpQPiw4gn15HQYyZBd9RChQBxCunKFW
         XbmoJxJ4Bs+XyATq2SOtDNvENKOBavb7lEckNa853ecYPJbbbV//Rwfz8lWBe5jn40Yy
         J65MHv4fBvJcw+AN69RmhAR93kc9HTHjWxyrL7xemh5y0od8JcBuDR7d8VDytZ6T/ua9
         2OAkQ9OJxbu6fOR2LmAR5yoSnEdGXq+s3IiKyWOdRbCpsUWqxzcwb3zTOXWCUH8V1iss
         yXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZPSW+X3R/1EjweWTRb2nZGc4l5E3AS8vBCcEiptLZE=;
        b=J9L6lOACcXB/X3TRB83JsdxKSfLbGM8PH5+5S+Ms6JTw/m0hYC3zdWXGEMuvvAPebX
         wNHOcj8imSCfgijOfj/etJCo/FS0haHDpDikky82jU4AxjSv0jExzwmks5X8H1sA/FBp
         0hN0Qk+tM3IbVSrM/3kb1tMWWRsM+OuLoqgcUNsD21aeVRUXqep/cUhT4F/6HO4jsxkB
         R2Kl35yIEKglMsQMAG8MthrdC4LpGDceyLG2wIVyOlylaxhPG4+GkQSgWdptfUJtro80
         UnmofY0QOTOPWsndrgzx+/d9VJqHqYlW/3x2Jf63OmZJxO6fG/LandVtLjlnlYb/NYk/
         mSwA==
X-Gm-Message-State: AOUpUlG8Jyd/y8+XwGUHTCa2SYwkzmI+9JyWrNhIVDGQk7m/wFFjGC7P
        9bGCgq2xvIdoxVKOOIqHFDo=
X-Google-Smtp-Source: AA+uWPxMUJDJ95nPYeidvL2attH6dhe7jWXSEWIwuli1Xlf29QrbUK8yB03+XF5ZIItZVqxtJn4ApA==
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr8831597ljb.119.1534064850806;
        Sun, 12 Aug 2018 02:07:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2793181lff.28.2018.08.12.02.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 02:07:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4] clone: report duplicate entries on case-insensitive filesystems
Date:   Sun, 12 Aug 2018 11:07:14 +0200
Message-Id: <20180812090714.19060-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180810153608.30051-1-pclouds@gmail.com>
References: <20180810153608.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paths that only differ in case work fine in a case-sensitive
filesystems, but if those repos are cloned in a case-insensitive one,
you'll get problems. The first thing to notice is "git status" will
never be clean with no indication what exactly is "dirty".

This patch helps the situation a bit by pointing out the problem at
clone time. Even though this patch talks about case sensitivity, the
patch makes no assumption about folding rules by the filesystem. It
simply observes that if an entry has been already checked out at clone
time when we're about to write a new path, some folding rules are
behind this.

This patch is tested with vim-colorschemes repository on a JFS partition
with case insensitive support on Linux. This repository has two files
darkBlue.vim and darkblue.vim.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v4 removes nr_duplicates (and fixes that false warning Szeder
 reported). It also hints about case insensitivity as a cause of
 problem because it's most likely the case when this warning shows up.

 builtin/clone.c  |  1 +
 cache.h          |  1 +
 entry.c          | 28 ++++++++++++++++++++++++++++
 t/t5601-clone.sh |  8 +++++++-
 unpack-trees.c   | 28 ++++++++++++++++++++++++++++
 unpack-trees.h   |  1 +
 6 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5c439f1394..0702b0e9d0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -747,6 +747,7 @@ static int checkout(int submodule_progress)
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
 	opts.merge = 1;
+	opts.clone = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/cache.h b/cache.h
index 8b447652a7..6d6138f4f1 100644
--- a/cache.h
+++ b/cache.h
@@ -1455,6 +1455,7 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 clone:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/entry.c b/entry.c
index b5d1d3cf23..c70340df8e 100644
--- a/entry.c
+++ b/entry.c
@@ -399,6 +399,31 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 	return lstat(path, st);
 }
 
+static void mark_colliding_entries(const struct checkout *state,
+				   struct cache_entry *ce, struct stat *st)
+{
+	int i;
+
+	ce->ce_flags |= CE_MATCHED;
+
+#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
+	for (i = 0; i < state->istate->cache_nr; i++) {
+		struct cache_entry *dup = state->istate->cache[i];
+
+		if (dup == ce)
+			break;
+
+		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
+			continue;
+
+		if (dup->ce_stat_data.sd_ino == st->st_ino) {
+			dup->ce_flags |= CE_MATCHED;
+			break;
+		}
+	}
+#endif
+}
+
 /*
  * Write the contents from ce out to the working tree.
  *
@@ -455,6 +480,9 @@ int checkout_entry(struct cache_entry *ce,
 			return -1;
 		}
 
+		if (state->clone)
+			mark_colliding_entries(state, ce, &st);
+
 		/*
 		 * We unlink the old file, to get the new one with the
 		 * right permissions (including umask, which is nasty
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0b62037744..f2eb73bc74 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -624,10 +624,16 @@ test_expect_success 'clone on case-insensitive fs' '
 			git hash-object -w -t tree --stdin) &&
 		c=$(git commit-tree -m bogus $t) &&
 		git update-ref refs/heads/bogus $c &&
-		git clone -b bogus . bogus
+		git clone -b bogus . bogus 2>warning
 	)
 '
 
+test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
+	grep X icasefs/warning &&
+	grep x icasefs/warning &&
+	test_i18ngrep "the following paths have collided" icasefs/warning
+'
+
 partial_clone () {
 	       SERVER="$1" &&
 	       URL="$2" &&
diff --git a/unpack-trees.c b/unpack-trees.c
index cd0680f11e..443df048ef 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -359,6 +359,12 @@ static int check_updates(struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 	state.istate = index;
 
+	if (o->clone) {
+		state.clone = 1;
+		for (i = 0; i < index->cache_nr; i++)
+			index->cache[i]->ce_flags &= ~CE_MATCHED;
+	}
+
 	progress = get_progress(o);
 
 	if (o->update)
@@ -423,6 +429,28 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+
+	if (o->clone) {
+		int printed_warning = 0;
+
+		for (i = 0; i < index->cache_nr; i++) {
+			struct cache_entry *ce = index->cache[i];
+
+			if (!(ce->ce_flags & CE_MATCHED))
+				continue;
+
+			if (!printed_warning) {
+				warning(_("the following paths have collided (e.g. case-sensitive paths\n"
+					  "on a case-insensitive filesystem) and only one from the same\n"
+					  "colliding group is in the working tree:\n"));
+				printed_warning = 1;
+			}
+
+			fprintf(stderr, "  '%s'\n", ce->name);
+			ce->ce_flags &= ~CE_MATCHED;
+		}
+	}
+
 	return errs != 0;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..d940f1c5c2 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -42,6 +42,7 @@ struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
 		     update,
+		     clone,
 		     index_only,
 		     nontrivial_merge,
 		     trivial_merges_only,
-- 
2.18.0.1004.g6639190530


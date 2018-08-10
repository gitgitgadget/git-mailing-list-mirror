Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D851F404
	for <e@80x24.org>; Fri, 10 Aug 2018 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeHJSHn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:07:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46124 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbeHJSHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:07:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so7480042ljj.13
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=chkpNAzyA0v1HO3rUe81aieHMOy3q4WL4iEkZPJVY6E=;
        b=nZNpTDdpkf2IWtDELOgFvjpRgrYLnRtPKqc1SeXnFz5Z9FrSNgDD91ZKyATaUOe7AM
         /QRsDDKkfIpQl1CrNoYbAhWUH9DyoSEWXyAhczZSbx+sinJIfEcneOCjP0LxxWMwwSwZ
         yeK3bN3UKGWPcVNlpGIAX54P57nc6zgwV3IHboQa8nhwXLhmXDdqaA7rMXPdngoHuvhr
         KMf2PyybX0IAPBGvYf1KL0TZlqe1dXX7bnoBa5UZj6ak7UWexvfm4tuGNBHfsIlsFIP+
         851RNAVAiSHLyfqiCpngYmvbJCcsfVd+tipWdBpf71H4RFmwbNJ4TBa2JpCzjjEbI7fh
         F6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chkpNAzyA0v1HO3rUe81aieHMOy3q4WL4iEkZPJVY6E=;
        b=RY7pPpmk4eiPa5u2r9xRkDacWPO8NGlfVYtCuS3qXmO0aPQPmq6ZJXymT75cow/Fxk
         ed5m3P6EEZgoweEfFStmCwdRjHRMhCDdtEGLW0RvhuLRdG83BaIYxWJAm6xteM3pu40V
         9NAYfTZz7noG9bMSUMMfJGTt9ayKK+5a4nmWJeMzlKeDg9tqzTRPw3R1o0dwT17NcFOH
         mpJwETelOioStn/NCy25jpN6Q9VM/zjZBM3lsBbAY+XydeHcV74GRtR+5ajKpBOgScsG
         7Fmj2Ft/+XhqwAt0fZ0kxuqiWfbXS7rSkD0UKf6NDTufvkpAjFOLcVnUr5ML80ehIwPV
         rTwQ==
X-Gm-Message-State: AOUpUlHmbkEz0LBWLiuNS+6dx8zvtsYRsr0m8JvFvanQ/NRAQ2ojVX2E
        rE4PxU9GlVPmafutnidfRxOyz728
X-Google-Smtp-Source: AA+uWPw3XXLXW/jnlqLCh/641wLvXUUTNO1wvvIU/K3+n3QErssNsVSSDV0rBSEcUlwoH2mSn0rAJw==
X-Received: by 2002:a2e:5d88:: with SMTP id v8-v6mr4889557lje.137.1533915439451;
        Fri, 10 Aug 2018 08:37:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f18-v6sm1664680lja.85.2018.08.10.08.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:37:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de
Subject: [PATCH v3 1/1] clone: report duplicate entries on case-insensitive filesystems
Date:   Fri, 10 Aug 2018 17:36:08 +0200
Message-Id: <20180810153608.30051-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.915.gd571298aae
In-Reply-To: <20180810153608.30051-1-pclouds@gmail.com>
References: <20180807190110.16216-1-pclouds@gmail.com>
 <20180810153608.30051-1-pclouds@gmail.com>
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
 builtin/clone.c |  1 +
 cache.h         |  2 ++
 entry.c         | 32 ++++++++++++++++++++++++++++++++
 unpack-trees.c  | 22 ++++++++++++++++++++++
 unpack-trees.h  |  1 +
 5 files changed, 58 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9ebb5acf56..38d5609282 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -748,6 +748,7 @@ static int checkout(int submodule_progress)
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
 	opts.merge = 1;
+	opts.clone = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/cache.h b/cache.h
index 8dc7134f00..cdf0984707 100644
--- a/cache.h
+++ b/cache.h
@@ -1515,9 +1515,11 @@ struct checkout {
 	const char *base_dir;
 	int base_dir_len;
 	struct delayed_checkout *delayed_checkout;
+	int *nr_duplicates;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 clone:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/entry.c b/entry.c
index b5d1d3cf23..f2d73e6255 100644
--- a/entry.c
+++ b/entry.c
@@ -399,6 +399,35 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 	return lstat(path, st);
 }
 
+static void mark_duplicate_entries(const struct checkout *state,
+				   struct cache_entry *ce, struct stat *st)
+{
+	int i;
+	int *count = state->nr_duplicates;
+
+	if (!count)
+		BUG("state->nr_duplicates must not be NULL");
+
+	ce->ce_flags |= CE_MATCHED;
+	(*count)++;
+
+#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
+	for (i = 0; i < state->istate->cache_nr; i++) {
+		struct cache_entry *dup = state->istate->cache[i];
+
+		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
+			continue;
+
+		if (ce_uptodate(dup) &&
+		    dup->ce_stat_data.sd_ino == st->st_ino) {
+			dup->ce_flags |= CE_MATCHED;
+			(*count)++;
+			break;
+		}
+	}
+#endif
+}
+
 /*
  * Write the contents from ce out to the working tree.
  *
@@ -455,6 +484,9 @@ int checkout_entry(struct cache_entry *ce,
 			return -1;
 		}
 
+		if (state->clone)
+			mark_duplicate_entries(state, ce, &st);
+
 		/*
 		 * We unlink the old file, to get the new one with the
 		 * right permissions (including umask, which is nasty
diff --git a/unpack-trees.c b/unpack-trees.c
index f9efee0836..d4fece913c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -344,12 +344,20 @@ static int check_updates(struct unpack_trees_options *o)
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 	int i;
+	int nr_duplicates = 0;
 
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
 
+	if (o->clone) {
+		state.clone = 1;
+		state.nr_duplicates = &nr_duplicates;
+		for (i = 0; i < index->cache_nr; i++)
+			index->cache[i]->ce_flags &= ~CE_MATCHED;
+	}
+
 	progress = get_progress(o);
 
 	if (o->update)
@@ -414,6 +422,20 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+
+	if (o->clone && state.nr_duplicates) {
+		warning(_("the following paths have collided and only one from the same\n"
+			  "colliding group is in the working tree:\n"));
+		for (i = 0; i < index->cache_nr; i++) {
+			struct cache_entry *ce = index->cache[i];
+
+			if (!(ce->ce_flags & CE_MATCHED))
+				continue;
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
2.18.0.915.gd571298aae


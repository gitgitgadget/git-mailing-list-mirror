Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C538207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbdEBWYI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:08 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33635 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbdEBWXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:45 -0400
Received: by mail-pg0-f43.google.com with SMTP id y4so62827000pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WlmduLBrdy9giN1BRyT/EhSnMGSN+xymszL5BichrOI=;
        b=gybJAYsJroCoUE7HdCTKY32hbHYwjq/GKS1PAiND0Lmo0HqsNTc277PwAlSnF7Cnrp
         8yUmHRS2ThV+JwMfkQymPpCWKB8sNwRhsIBADE3l96ZuU7VEH76uqsHnEMopT0X0SwBC
         tqt0A97noL3wtMaS/euIxiPgLV4vdDvVPLvAtBqOPsRyRL97bOtIuNhOa5ZpPN2K841A
         lAWmFDCY8wyKPrDRnyjGH758RzooydbPy/Bd4ICmhAPhSbMAqUShniAQWFiFFDerUBbv
         ojvNUjJb4IMIoMihwGEbAIljfOnsMF5phTmX2Yh6iKTa5XN6TrwWiyt0fb6a0Q8O1tbk
         Sz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WlmduLBrdy9giN1BRyT/EhSnMGSN+xymszL5BichrOI=;
        b=srRRY6b4C4C/nfnQ7HhoqCMuk15cmnqgvkMMrhbbCXNO1/H+/0tHFppl8X7h49yzUD
         hr53uS7+eWnBxsu3MetTBS9+Qn3CE08KYhsmvztZQd3eyaQDzCEod5cjvXMoDkgrAc8O
         FkE2uHrImsL1qGeRT2hNfW/acKS/8bsn7fYHNBsqx49AJewWGBIKs+h8tLbkOY2JOeNW
         Q7MfuOy7PU0MO1rEBNZW5aXCqPHVbm3jjBBSFwtqv7RlrOX8b/8ov0LYGeDqE1fK7wgJ
         tcL5laazZ5JEiZCUzJK+ZCc+hYtPRQ5LKiPZolR3B9g75+8Y2wGc9iJ9X70TPBRrruhm
         TNcQ==
X-Gm-Message-State: AN3rC/7FJTgtj/rb26mddtiRHkR9+Zit4JExUvQJaZLpPSKd0Qy0krbQ
        3Ec3xtACC5Hi4T1O
X-Received: by 10.99.119.76 with SMTP id s73mr9542244pgc.215.1493763819911;
        Tue, 02 May 2017 15:23:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id u135sm21002844pgb.58.2017.05.02.15.23.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/24] cache.h: drop resolve_undo_clear
Date:   Tue,  2 May 2017 15:23:07 -0700
Message-Id: <20170502222322.21055-10-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout.c     | 2 +-
 builtin/merge.c        | 2 +-
 builtin/read-tree.c    | 2 +-
 builtin/update-index.c | 2 +-
 cache.h                | 1 -
 merge.c                | 2 +-
 6 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2328a475ea..abcc45a74f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -491,7 +491,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (read_index_preload(&the_index, NULL) < 0)
 		return error(_("index file corrupt"));
 
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 	if (opts->force) {
 		ret = reset_tree(new->commit->tree, opts, 1, writeout_error);
 		if (ret)
diff --git a/builtin/merge.c b/builtin/merge.c
index c27c806ac1..b023107d26 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1191,7 +1191,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists)."));
 	}
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 
 	if (verbosity < 0)
 		show_diffstat = 0;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 0bcf021ead..61f5f6f028 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -199,7 +199,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			die("You need to resolve your current index first");
 		stage = opts.merge = 1;
 	}
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b8458016f0..c9f06169c0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -796,7 +796,7 @@ static int chmod_callback(const struct option *opt,
 static int resolve_undo_clear_callback(const struct option *opt,
 				const char *arg, int unset)
 {
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 8a2dc393dc..abf1474034 100644
--- a/cache.h
+++ b/cache.h
@@ -371,7 +371,6 @@ extern void free_name_hash(struct index_state *istate);
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
-#define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #endif
 
 enum object_type {
diff --git a/merge.c b/merge.c
index 748305031e..06509a6df2 100644
--- a/merge.c
+++ b/merge.c
@@ -39,7 +39,7 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	discard_cache();
 	if (read_index(&the_index) < 0)
 		die(_("failed to read the cache"));
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 
 	return ret;
 }
-- 
2.13.0.rc1.39.ga6db8bfa24


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AF5207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbdEBWXv (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:51 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33235 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdEBWXg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:36 -0400
Received: by mail-pf0-f174.google.com with SMTP id q20so3539588pfg.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5rwTukvDeVGo3QkQuk7q3D8JRZIk2p3PT2JclLQ8tY=;
        b=kqwPiMmzqnIRfGxdy2TzMRPyq+rBX7DEoAEMqSId/cD2CqTZvUxtgNImphI0cetamz
         FSFXVOA1Q8YHaWBXSt4n5N5EcovncPE4sLhRUgKZ54YlwAYzMU29maxmHh73eRuCEOn6
         neiM8Wyia9IyjVu52g0H7UG1dm3+PU043gAemLHFFq3YHrX0AuXHA0a5bJHY0QNKrwHE
         ND7nihvuKg9ech9vtNRAqtO8AfK17aUXijFh8LJPC9KUlEUszdadxoYMPI8rjdKtDG0O
         EnZRf47cs6DInOr8HbbCLIUQ5nxytYmu7fRbgrAFVko6dQMMkni+iJPsYnqcX/R2rAIi
         T35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5rwTukvDeVGo3QkQuk7q3D8JRZIk2p3PT2JclLQ8tY=;
        b=EYI1DVHnrCrJ0E8UJt17T9C+O6yrbRG+6X+cKv/dNR0SS6Y228FJg2ozmDaqPbF2ZT
         GlzduI1F1C2RkKgl+CeV532l/SAr7mDf0gdjZjxnsL8t7LneOgNXB1/dlIt9ab0FMY6h
         7BHsEwyn21LtLbEXHNUqcTyLPV/JFWxzxdrOOFMgmM4nF0BkwWDiKiTpVn1TZL8M7XFG
         xnCNsPkT5tiwVHcus9Aw/MjV3KqJD7kvyFRdbxJsvv3wbFmUVZKDw1Q/J0scPdvGAPnt
         A4w//Wc1XvxsZawYvqMcnTk/h6zUyaoyb4TtAUpFbV3Vyh3lQUwQcJH05gN5zwQhyHF0
         L9DA==
X-Gm-Message-State: AN3rC/5Hr3hM3n8fNVaaAVtKlDAOCfkKMDdL2Ndv2KWy+bI+JUyOxEhD
        8EC/b85Avkt40W+X
X-Received: by 10.98.209.24 with SMTP id z24mr1425954pfg.200.1493763815085;
        Tue, 02 May 2017 15:23:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id x9sm706049pff.98.2017.05.02.15.23.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/24] cache.h: drop read_cache_unmerged()
Date:   Tue,  2 May 2017 15:23:03 -0700
Message-Id: <20170502222322.21055-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@@ @@
-read_cache_unmerged()
+read_index_unmerged(&the_index)

Additionally drop the define from cache.h manually.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c        | 2 +-
 builtin/merge.c     | 2 +-
 builtin/pull.c      | 2 +-
 builtin/read-tree.c | 2 +-
 builtin/reset.c     | 2 +-
 cache.h             | 1 -
 sequencer.c         | 2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index cb3e4dff63..bb0927fbcc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2053,7 +2053,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (!remote_tree)
 		return error(_("Could not parse object '%s'."), oid_to_hex(remote));
 
-	read_cache_unmerged();
+	read_index_unmerged(&the_index);
 
 	if (fast_forward_to(head_tree, head_tree, 1))
 		return -1;
diff --git a/builtin/merge.c b/builtin/merge.c
index 4d4c56050c..c27c806ac1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1170,7 +1170,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
-	if (read_cache_unmerged())
+	if (read_index_unmerged(&the_index))
 		die_resolve_conflict("merge");
 
 	if (file_exists(git_path_merge_head())) {
diff --git a/builtin/pull.c b/builtin/pull.c
index dd1a4a94e4..42578cee05 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -788,7 +788,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	git_config(git_pull_config, NULL);
 
-	if (read_cache_unmerged())
+	if (read_index_unmerged(&the_index))
 		die_resolve_conflict("pull");
 
 	if (file_exists(git_path_merge_head()))
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f997814933..0bcf021ead 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -195,7 +195,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 */
 
 	if (opts.reset || opts.merge || opts.prefix) {
-		if (read_cache_unmerged() && (opts.prefix || opts.merge))
+		if (read_index_unmerged(&the_index) && (opts.prefix || opts.merge))
 			die("You need to resolve your current index first");
 		stage = opts.merge = 1;
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 03c5498d6e..4a4eb723dd 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -66,7 +66,7 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		opts.reset = 1;
 	}
 
-	read_cache_unmerged();
+	read_index_unmerged(&the_index);
 
 	if (reset_type == KEEP) {
 		struct object_id head_oid;
diff --git a/cache.h b/cache.h
index a66ae97fb7..9b94339573 100644
--- a/cache.h
+++ b/cache.h
@@ -355,7 +355,6 @@ extern void free_name_hash(struct index_state *istate);
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define is_cache_unborn() is_index_unborn(&the_index)
-#define read_cache_unmerged() read_index_unmerged(&the_index)
 #define discard_cache() discard_index(&the_index)
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
diff --git a/sequencer.c b/sequencer.c
index 9409b65aaa..f20e05fe60 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -349,7 +349,7 @@ static struct tree *empty_tree(void)
 
 static int error_dirty_index(struct replay_opts *opts)
 {
-	if (read_cache_unmerged())
+	if (read_index_unmerged(&the_index))
 		return error_resolve_conflict(_(action_name(opts)));
 
 	error(_("your local changes would be overwritten by %s."),
-- 
2.13.0.rc1.39.ga6db8bfa24


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B6320248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfCYMI5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:57 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40694 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbfCYMI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:56 -0400
Received: by mail-wr1-f48.google.com with SMTP id t5so9789194wri.7
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TOmfnxLYLrMWfiJ9ILhdwq1eLAphKC0g7BwWDC4V58=;
        b=Hv0vMAM5zeMtEx5dwgaXtm5xjrmSiAQkNpWLgPy943/0X039AI42GdqZQqEnsXc99v
         Dfc37ONVmrfxjgUYcwqffJdv8qnd+XtRzvQWWETDk2Iz8zmfFhsn02QPKmg9mFhyvrfa
         dm+jWrbwgTU8JvRV0unmDbTabzdfWSoih9e+3mzyZRUUcnkFF+Whxl2UkGNRAwIfV1Zz
         J/j10fgfVn6GXY49ks1Oq5h/M21syxhNA51dsKOq2j0iQ01bnbv+7/SQaNEqMH0Zuk3m
         ygDqifzqAbxW/ktSwLZ7QdspnXERL9XA6kfuLH09BuKLBT29+hbLcwRVYCQGFvrllEVC
         CIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TOmfnxLYLrMWfiJ9ILhdwq1eLAphKC0g7BwWDC4V58=;
        b=WJpJzAl2fcXK0KoJAVmveVlvQTXDTJDO5YPRz1xYpX9afs2ozIRFZQYIHJWR6PxHxt
         i+HyCwbT2XvJ4OcOLu/zXykI4IRR3SvYOnw1q2p9UIJpKRvyLnmFy807QCnLDgvnaAvl
         eVMpxtPL0h5wQBzYGjefruDZFHzkSUwAw3eSvkza/G0bowrNW1FzzDvWXaJESqaNPm4b
         p2Uhpzo6s4A+uTRfiDMNGJgbcc2YNSS2uxWS+ZR72PcxHrd86ga0aZUxRMDMqaXdlnOj
         L4VhS5fA1UILH5m9oJKHR3ir3dwwrH99Cn801e5X6hEuOnE1ZRpORxeFiBHoTFzWQ97i
         3s8A==
X-Gm-Message-State: APjAAAW4M/E+7bXjR6xqTlNpOYmfG/AjyL40AlD2dMkhs9Z+YuLE+JYU
        CbEbILOOeZLXlbJpGovQGDk2FqKMZMk=
X-Google-Smtp-Source: APXvYqyogzfvbARA+Dpme85bP9I82QkoCliA4o2qC623h6/SwbQa8H7XmhEYvSbcrR+H0fg0hMcXuA==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr16588515wru.130.1553515733971;
        Mon, 25 Mar 2019 05:08:53 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/8] commit-graph write: don't die if the existing graph is corrupt
Date:   Mon, 25 Mar 2019 13:08:33 +0100
Message-Id: <20190325120834.15529-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
References: <20190314214740.23360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the commit-graph is written we end up calling
parse_commit(). This will in turn invoke code that'll consult the
existing commit-graph about the commit, if the graph is corrupted we
die.

We thus get into a state where a failing "commit-graph verify" can't
be followed-up with a "commit-graph write" if core.commitGraph=true is
set, the graph either needs to be manually removed to proceed, or
core.commitGraph needs to be set to "false".

Change the "commit-graph write" codepath to use a new
parse_commit_no_graph() helper instead of parse_commit() to avoid
this. The latter will call repo_parse_commit_internal() with
use_commit_graph=1 as seen in 177722b344 ("commit: integrate commit
graph with commit parsing", 2018-04-10).

Not using the old graph at all slows down the writing of the new graph
by some small amount, but is a sensible way to prevent an error in the
existing commit-graph from spreading.

Just fixing the current issue would be likely to result in code that's
inadvertently broken in the future. New code might use the
commit-graph at a distance. To detect such cases introduce a
"GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD" setting used when we do our
corruption tests, and test that a "write/verify" combo works after
every one of our current test cases where we now detect commit-graph
corruption.

Some of the code changes here might be strictly unnecessary, e.g. I
was unable to find cases where the parse_commit() called from
write_graph_chunk_data() didn't exit early due to
"item->object.parsed" being true in
repo_parse_commit_internal() (before the use_commit_graph=1 has any
effect). But let's also convert those cases for good measure, we do
not have exhaustive tests for all possible types of commit-graph
corruption.

This might need to be re-visited if we learn to write the commit-graph
incrementally, but probably not. Hopefully we'll just start by finding
out what commits we have in total, then read the old graph(s) to see
what they cover, and finally write a new graph file with everything
that's missing. In that case the new graph writing code just needs to
continue to use e.g. a parse_commit() that doesn't consult the
existing commit-graphs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c          | 10 +++++++---
 commit-graph.h          |  1 +
 commit.h                |  6 ++++++
 t/t5318-commit-graph.sh | 11 +++++++++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a26d266663..34ecaaf857 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -311,6 +311,10 @@ static int prepare_commit_graph(struct repository *r)
 	struct object_directory *odb;
 	int config_value;
 
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
+		die("dying as requested by the '%s' variable on commit-graph load!",
+		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
+
 	if (r->objects->commit_graph_attempted)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
@@ -575,7 +579,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		uint32_t packedDate[2];
 		display_progress(progress, ++*progress_cnt);
 
-		parse_commit(*list);
+		parse_commit_no_graph(*list);
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
 
 		parent = (*list)->parents;
@@ -772,7 +776,7 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
-		if (commit && !parse_commit(commit))
+		if (commit && !parse_commit_no_graph(commit))
 			add_missing_parents(oids, commit);
 	}
 	stop_progress(&progress);
@@ -1021,7 +1025,7 @@ void write_commit_graph(const char *obj_dir,
 			continue;
 
 		commits.list[commits.nr] = lookup_commit(the_repository, &oids.list[i]);
-		parse_commit(commits.list[commits.nr]);
+		parse_commit_no_graph(commits.list[commits.nr]);
 
 		for (parent = commits.list[commits.nr]->parents;
 		     parent; parent = parent->next)
diff --git a/commit-graph.h b/commit-graph.h
index ada7aea9ed..7dfb8c896f 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -7,6 +7,7 @@
 #include "cache.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
+#define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 
 struct commit;
 
diff --git a/commit.h b/commit.h
index 42728c2906..5d33477e78 100644
--- a/commit.h
+++ b/commit.h
@@ -89,6 +89,12 @@ static inline int repo_parse_commit(struct repository *r, struct commit *item)
 {
 	return repo_parse_commit_gently(r, item, 0);
 }
+
+static inline int parse_commit_no_graph(struct commit *commit)
+{
+	return repo_parse_commit_internal(the_repository, commit, 0, 0);
+}
+
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define parse_commit_internal(item, quiet, use) repo_parse_commit_internal(the_repository, item, quiet, use)
 #define parse_commit_gently(item, quiet) repo_parse_commit_gently(the_repository, item, quiet)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 1cb0355c7e..d146cf4982 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -377,7 +377,13 @@ corrupt_graph_verify() {
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err &&
-	git status --short
+	if test "$2" != "no-copy"
+	then
+		cp $objdir/info/commit-graph commit-graph-pre-write-test
+	fi &&
+	git status --short &&
+	GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD=true git commit-graph write &&
+	git commit-graph verify
 }
 
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
@@ -403,7 +409,7 @@ corrupt_graph_and_verify() {
 test_expect_success POSIXPERM,SANITY 'detect permission problem' '
 	corrupt_graph_setup &&
 	chmod 000 $objdir/info/commit-graph &&
-	corrupt_graph_verify "Could not open"
+	corrupt_graph_verify "Could not open" "no-copy"
 '
 
 test_expect_success 'detect too small' '
@@ -522,6 +528,7 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	git fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
 	test_must_fail git fsck
 '
 
-- 
2.21.0.360.g471c308f928


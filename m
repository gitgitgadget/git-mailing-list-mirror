Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCF61F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeGPN17 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46807 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbeGPN17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:59 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so15218805pld.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UZlG0CzQeB9kI5ulEIXLlnp3IRzh91DYgTykpqS3ng0=;
        b=HKO9COXfyFAXJpmomvg00C4SnNGzyXAMSqwQHaHGwCewxtFAdUyk0LgQntKT7kZ3o2
         OT5pF8aAae1nzbTZWaDnijSK3CZyMwj1Sbz9VjqIqmjy31yqCzrOsYP0WmEQdSO1Zmcr
         tmS7iuXRDBZfVR4yrdrOHfJaQC8q17DIRA7ryYedikARD+KuVcf4tK7cIT7XJjoTDDyc
         wIjgz3WtG+j5oCbF0Xtf/wI+sQ/0ngqUWigXeKru3RbgfToihvoPRh4ERlRPtv8ph1F+
         /r8NpJtJiHsDLzu8PZh9zBzSa2H+IXtmQoABi3X+oGiVR/6Zs3Q5pQ50+bFdPwMD26+P
         kfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UZlG0CzQeB9kI5ulEIXLlnp3IRzh91DYgTykpqS3ng0=;
        b=WSArO7Hn7xS+srGthAQJsUxia+j0OBsdXV4HqL4pVPmNIRHVkzHnmif9kViji1QT5Z
         gi5CgAQN1neo9NCsXdXg5usr7F0IlN/wb+r9Vg8A2z4mNyOQWf8ybDFOJZo/5aXw42kR
         7oZhrJo+9nRe9OnEEMGoTxdXl6dODCm/gfh/4Y/eeciTTXxYkssvM97USFWyALKcdMMV
         IU30Alzb9ZSnce9JAs3QdauPDmTh08S8BCEZe+QPahAra/Lpjz/YvO4/vAAWoAJUdtLQ
         lK+w8qBzzGwT4uPnWCB9QfH8SqiKjCulmoTlbvlW6W0hrdX8dzz573NeGxu6L/vrNjrR
         9CjA==
X-Gm-Message-State: AOUpUlFjWlKGsoYwk1OR7yYVz/mGBbky9kHPb4mLbIPIx+FN2wJ5aTfa
        o9lXnYKR5Og1b443AxfioSXwLg==
X-Google-Smtp-Source: AAOMgpfSY8iftYtJfy6UfVrM0BcRJIxyv9JuaYVy+U0OMJSej7lf11m330Z/PNrihOV+uv93qNCaVw==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7-v6mr16976406plt.162.1531746037778;
        Mon, 16 Jul 2018 06:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id v6-v6sm93993388pfa.28.2018.07.16.06.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:37 -0700 (PDT)
Message-Id: <a60b7011adfd107633d7d3158c9c3fa127dc1a61.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 15:25:08 -0400
Subject: [PATCH 16/16] commit-reach: use can_all_from_reach
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The is_descendant_of method previously used in_merge_bases() to check if
the commit can reach any of the commits in the provided list. This had
two performance problems:

1. The performance is quadratic in worst-case.

2. A single in_merge_bases() call requires walking beyond the target
   commit in order to find the full set of boundary commits that may be
   merge-bases.

The can_all_from_reach method avoids this quadratic behavior and can
limit the search beyond the target commits using generation numbers. It
requires a small prototype adjustment to stop using commit-date as a
cutoff, as that optimization is no longer appropriate here.

Since in_merge_bases() uses paint_down_to_common(), is_descendant_of()
naturally found cutoffs to avoid walking the entire commit graph. Since
we want to always return the correct result, we cannot use the
min_commit_date cutoff in can_all_from_reach. We then rely on generation
numbers to provide the cutoff.

Since not all repos will have a commit-graph file, nor will we always
have generation numbers computed for a commit-graph file, create a new
method, generation_numbers_enabled(), that checks for a commit-graph
file and sees if the first commit in the file has a non-zero generation
number. In the case that we do not have generation numbers, use the old
logic for is_descendant_of().

Performance was meausured on a copy of the Linux repository using the
'test-tool reach is_descendant_of' command using this input:

A:v4.9
X:v4.10
X:v4.11
X:v4.12
X:v4.13
X:v4.14
X:v4.15
X:v4.16
X:v4.17
X.v3.0

Note that this input is tailored to demonstrate the quadratic nature of
the previous method, as it will compute merge-bases for v4.9 versus all
of the later versions before checking against v4.1.

Before: 0.26 s
 After: 0.21 s

Since we previously used the is_descendant_of method in the ref_newer
method, we also measured performance there using
'test-tool reach ref_newer' with this input:

A:v4.9
B:v3.19

Before: 0.10 s
 After: 0.08 s

By adding a new commit with parent v3.19, we test the non-reachable case
of ref_newer:

Before: 0.09 s
 After: 0.08 s

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 18 ++++++++++++++++++
 commit-graph.h |  6 ++++++
 commit-reach.c | 24 +++++++++++++++++-------
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b0a55ad12..e9786fa86 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -233,6 +233,24 @@ static int prepare_commit_graph(struct repository *r)
 	return !!r->objects->commit_graph;
 }
 
+int generation_numbers_enabled(struct repository *r)
+{
+	uint32_t first_generation;
+	struct commit_graph *g;
+	if (!prepare_commit_graph(r))
+	       return 0;
+
+	g = r->objects->commit_graph;
+
+	if (!g->num_commits)
+		return 0;
+
+	first_generation = get_be32(g->chunk_commit_data +
+				    g->hash_len + 8) >> 2;
+
+	return !!first_generation;
+}
+
 static void close_commit_graph(void)
 {
 	free_commit_graph(the_repository->objects->commit_graph);
diff --git a/commit-graph.h b/commit-graph.h
index 76e098934..0de8f8831 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -51,6 +51,12 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
+/*
+ * Return 1 if and only if the repository has a commit-graph
+ * file and generation numbers are computed in that file.
+ */
+int generation_numbers_enabled(struct repository *r);
+
 void write_commit_graph_reachable(const char *obj_dir, int append);
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
diff --git a/commit-reach.c b/commit-reach.c
index ac132c8e4..9eb622540 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -276,15 +276,25 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 {
 	if (!with_commit)
 		return 1;
-	while (with_commit) {
-		struct commit *other;
 
-		other = with_commit->item;
-		with_commit = with_commit->next;
-		if (in_merge_bases(other, commit))
-			return 1;
+	if (generation_numbers_enabled(the_repository)) {
+		struct commit_list *from_list = NULL;
+		int result;
+		commit_list_insert(commit, &from_list);
+		result = can_all_from_reach(from_list, with_commit, 0);
+		free_commit_list(from_list);
+		return result;
+	} else {
+		while (with_commit) {
+			struct commit *other;
+
+			other = with_commit->item;
+			with_commit = with_commit->next;
+			if (in_merge_bases(other, commit))
+				return 1;
+		}
+		return 0;
 	}
-	return 0;
 }
 
 /*
-- 
gitgitgadget

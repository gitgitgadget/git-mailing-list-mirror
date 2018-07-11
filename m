Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EE71F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 22:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbeGKWt2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:49:28 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:49016 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGKWt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:49:28 -0400
Received: by mail-yb0-f201.google.com with SMTP id v1-v6so26336464ybm.15
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=jDVBFowlHvl3ynbQ4AgKRFIpLbn/+A+sFivC9qJK3Rw=;
        b=Hi8cjM4Forkz/JTzJuBii6SZcJLxEP/P7t3thwfDpjmx7byTDVqQsFgdYTbDoSxwaB
         Aa63Al5uHKir7jGGIw4vrds48EZkgKGEtJbrOE3WqXA7T5X6OOGkUh8Ua8LIntkXs/Ho
         wnu/CgQcbPXAb+ID2zagKNrQjo47geqJNoHq/6qBU0YlzpQWwnSFJiRiUIf/r3TYLoW6
         elpw24BKChajNC0rG5ATC2TxmN82aU5LaRtJsnst+znwLzCZ550YaNaCNnLE2msdIYfz
         U19gFqsS9iqNspujLn6qydVyEwzCo+SMHMFHcrXJBXpi+mr0YSGSXR5umH5fIFW7Rpw2
         zfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=jDVBFowlHvl3ynbQ4AgKRFIpLbn/+A+sFivC9qJK3Rw=;
        b=YhZYlexRrQhUmh94DJyWNYx6QTs51wemiGhydyugo6k4zFWYnTJ+H0vMjq5BqRjTQG
         d2U6ol4rOQWocUFhNACak9NgYaeqr+4epbIgqdkZSU+vn2HOPPJBOdySCtHQPwDhUXSr
         7urOUeKiofFOUAphuDgfXrT3ogkOADJ9088W3uGtrfWe9I6XXcWaaul1MAqFcO8zTOIj
         8+U6NLXJaW12QqCYFN3dMUA2wgkoQ9WQye1vMxCwviuUSBpR+2lpKRkGdVRNDbIVyh9t
         8OmHuu7Beaa9hbDBsYFsk4scJTr8nsWrCAtvVAk+Dp7gYE+zw10bD3dw2hNSDcTDDWTT
         yeHg==
X-Gm-Message-State: AOUpUlG2F2YjwbfZvdo8YFsC2HFsTsEiWMh5smemC/8o1uUc1UlnkW/5
        9TUhAZ2SA9JJPMikJgx43aXyFSoty+HDt7NY3QtqlY9X1DCDszTwN7+NdUihir+1YWL/BiZ8i5h
        vgu0YT1G5GZf6/q5LSDSAdtzFV7M3M9OJOUvt7iJduQz/dLJSXWqaxB7XvH8O9+ykdB9ETkFNSs
        jS
X-Google-Smtp-Source: AAOMgpd36tUPyGWITTxjqJ9r8eYiCjRiG1QdBrZVna70syF+vu9sikKeOjWETx1nG3ZR/dbKDLzfhGwdlxYPTirHRRb4
MIME-Version: 1.0
X-Received: by 2002:a25:e805:: with SMTP id k5-v6mr198505ybd.53.1531348977556;
 Wed, 11 Jul 2018 15:42:57 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:42:40 -0700
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com>
Message-Id: <0d422eaf12ff16e962d65c0db45c67099ba91ab9.1531348540.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531348540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v3 4/6] commit-graph: add free_commit_graph
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/commit-graph.c |  2 ++
 commit-graph.c         | 24 ++++++++++++++----------
 commit-graph.h         |  2 ++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c7d0db5ab4..0bf0c48657 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -115,6 +115,8 @@ static int graph_read(int argc, const char **argv)
 		printf(" large_edges");
 	printf("\n");
 
+	free_commit_graph(graph);
+
 	return 0;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 1ea701ed69..143a587581 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -231,16 +231,8 @@ static int prepare_commit_graph(void)
 
 static void close_commit_graph(void)
 {
-	if (!commit_graph)
-		return;
-
-	if (commit_graph->graph_fd >= 0) {
-		munmap((void *)commit_graph->data, commit_graph->data_len);
-		commit_graph->data = NULL;
-		close(commit_graph->graph_fd);
-	}
-
-	FREE_AND_NULL(commit_graph);
+	free_commit_graph(commit_graph);
+	commit_graph = NULL;
 }
 
 static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
@@ -1033,3 +1025,15 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 
 	return verify_commit_graph_error;
 }
+
+void free_commit_graph(struct commit_graph *g)
+{
+	if (!g)
+		return;
+	if (g->graph_fd >= 0) {
+		munmap((void *)g->data, g->data_len);
+		g->data = NULL;
+		close(g->graph_fd);
+	}
+	free(g);
+}
diff --git a/commit-graph.h b/commit-graph.h
index 674052bef4..94defb04a9 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -58,4 +58,6 @@ void write_commit_graph(const char *obj_dir,
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
+void free_commit_graph(struct commit_graph *);
+
 #endif
-- 
2.18.0.203.gfac676dfb9-goog


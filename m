Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30961F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933169AbeGIUo6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:44:58 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:57270 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbeGIUo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:44:56 -0400
Received: by mail-vk0-f74.google.com with SMTP id q184-v6so8784119vke.23
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hAVadCsnxLCmB1m4n5tGP8jZscANkMrpx9dQgseaB9M=;
        b=B5J8KH5lMYtGV6HjPjm5gn5hHLi10yBMHApI6zOx76pfCb5aGSY88H7Djod4XLIb2P
         f1AdjLQ5TMd1h/CniIgfWHogpowTdDUOG/P1GdyaLoEVFoZCPx9hUgM4ORH1IVhfcxAg
         +QwE2bLerXxfZB3e0tGm917pw934f9uj+0cRXifvXR+vztHm9E5NDN6dc2zHPR0TwXUg
         LYLeDBO0b/C5RT3xYeUcOSbEIinVPmMVaUyhxA7PCKd3vnpYllaB499aT2aScxjlBDaD
         NsHV7DCrqxylx2mFteaKlkzrmhHBaujNs9s+YJvCJrKfvKxLe/1AFHSZdjVXWFj4IGIf
         zfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hAVadCsnxLCmB1m4n5tGP8jZscANkMrpx9dQgseaB9M=;
        b=apA/7n5Mvqd1JsisTepm21S5ZkaQjiJq28FxmVWURLU//G6++TLlR67BN055XXVBma
         ytzfNchaSG8EOdMgneq2o6lfFpjQIo8YFvjha+HLd1A9ikhTpOSG20efreRtDhOKaMk9
         QnmAjDKkF20Hq4r8hykffzoxDfdO8f0T82Pxq/nYrFBtiXLveKK3l9NRXr1kjX9tZDzf
         p7PIPVPTdege3IbCYxodZzCbeLjEcFvWdP62zRlbQ0OoTQ5ihESs9O7HrxcpeD1GdmBf
         u7tFgf4GOXPE4gIe4ZUZY00v1Me7ycwB7Uii1NS2aDmMsMpsN+3lysHKha/1ni5Gb+8l
         QYdA==
X-Gm-Message-State: APt69E0vr7PJqdPjaibxR6qPbUrLU7ec8rzEjkCukxMpxz+EDFPoL1GC
        LJRGDPpxLtWsW+TMdV4JbOA1HY/+GcGtjTufH1ONbVwYlHIjXZmpXE1UUfGVDkkD53Bc/2mO9o2
        O+pRe0eAxPBJNDrrw+XY9AkFytMorzjjZ/nDbR+FtmPVJx6HZ5IH/Gb7KlGhW8dtqZ+uycRX/Fx
        XB
X-Google-Smtp-Source: AAOMgpfbyWwO+oHnGi1HBHACUnrVTQgpYLkD0Pfszdt1dhiqOlXjmc67FB6dxBPG4JhrZbQ9egkfCGNWTQNPeJw5+6ej
MIME-Version: 1.0
X-Received: by 2002:a9f:3b03:: with SMTP id i3-v6mr1408420uah.25.1531169095427;
 Mon, 09 Jul 2018 13:44:55 -0700 (PDT)
Date:   Mon,  9 Jul 2018 13:44:38 -0700
In-Reply-To: <cover.1531168854.git.jonathantanmy@google.com>
Message-Id: <06fd347b21dbc039936dd9ab2701d16b9befbd19.1531168854.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 4/6] commit-graph: add free_commit_graph
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
index 5ba60f63f9..6d1bc4ff7c 100644
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


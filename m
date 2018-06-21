Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DF51F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933843AbeFUV3j (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:29:39 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:49094 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbeFUV3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:38 -0400
Received: by mail-io0-f202.google.com with SMTP id t11-v6so3558140iog.15
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PUAq6gOcye1sq/KiY6xPoWR8+jPZW5zX/R9piNYWYvE=;
        b=T4B4E7VlZkWfNXS2Rx0JJwK5F9NEaHChd0EGEqhX/ZNx+1PXZZHtfXulYtX21NfARq
         jY8ijSfNRmka+WoIDQ0M4vGz9fdD5Sh9IsPcMDbGf9UMznfgeb05ZznH8nxToj7wHS7w
         ih/w+F+gelipBRVFry+nkuYaiqTKw6QNmz1vLI9J/zo+gOlVJVoARCOfHHBVtGEWmBja
         50CLFUbl/SWpdKyGL3rtnAy59tjnf/lQ1Ci7LA5V7B61eJ1//zknPwL3OFfqDx7Qi3On
         SjAdGNHMm2cjVneal7A/nvt40Jzvs4q5GpZPy8Ux1Np8P1vv620P7JzhQbuw6dPWzUFb
         v8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PUAq6gOcye1sq/KiY6xPoWR8+jPZW5zX/R9piNYWYvE=;
        b=sKbBZ7eX1vGYE77+JJDzeIJhdbJBihnOVlKraHmmyf6ecRSjOt3Pyy6ZTykl7aAHsC
         CgqP6oY8ri+CQZHQ/PRBSBN4ou0ypOaX5ZrR7xcV7orK5gj3fODALkk6qvVzmGp3W2gG
         h+UWi/Xr6E+EiAK9J2EMv+b2RahCgCtshkev9cdkJIE4s1/YVtomNBfy5ORQR9yvrxEf
         xL+C6XpgNY3gSJrpwm1+4m7ABlKRzUb7S88GvKrg35lS92lFfa9ZtlIT+z6cV7RY31/Q
         /+X5J0T5NTE0Ud9jjCN0p17Nls427rVgxHBys4Ei213kLDLS+GOnw2rkQCXUST8riisQ
         UKcQ==
X-Gm-Message-State: APt69E0M6lRenlwzjQ1zn3YwdAQZivlar0wZcN6mhZ0cBFo4tnYEqjj7
        HgCXBnOXH87MEI6yvauUB07+tAzrFLn4hGklvdjIZlieALm0rEW8fflnfGOgE8UUwsRbgBMiHC8
        +OP/Xb/ssID51LFbvmbhvpEOD6Okq+kVJyw+TqPQLEO3F+jL+02lBg8nd2CEULJMCiUx450Yj8T
        tH
X-Google-Smtp-Source: ADUXVKJcupmine1im8OrkOeWkq3uKL6BZKlgoYlb/cpkQdpgYZ4H5VLdBTbfFBSgEKa8DX2boDOVnz5/iFYJOcXjxl8P
MIME-Version: 1.0
X-Received: by 2002:a24:45d5:: with SMTP id c82-v6mr3333983itd.46.1529616576715;
 Thu, 21 Jun 2018 14:29:36 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:29:23 -0700
In-Reply-To: <cover.1529616356.git.jonathantanmy@google.com>
Message-Id: <10e98b79ecdc7aa8d6abc2d6870fca2692d1956f.1529616356.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: [PATCH 3/5] commit-graph: add free_commit_graph
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
index 37420ae0fd..9c2d55221c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -74,6 +74,8 @@ static int graph_read(int argc, const char **argv)
 		printf(" large_edges");
 	printf("\n");
 
+	free_commit_graph(graph);
+
 	return 0;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 4c6127088f..9f4e761229 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -216,16 +216,8 @@ static void prepare_commit_graph(void)
 
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
@@ -759,3 +751,15 @@ void write_commit_graph(const char *obj_dir,
 	oids.alloc = 0;
 	oids.nr = 0;
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
index 7004dfdca9..320ee9fd8a 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -47,4 +47,6 @@ void write_commit_graph(const char *obj_dir,
 			int nr_commits,
 			int append);
 
+void free_commit_graph(struct commit_graph *);
+
 #endif
-- 
2.18.0.rc2.347.g0da03f3a46.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC6E1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437781AbeKWCTa (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38017 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391765AbeKWCT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id k198so9560958wmd.3
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AMsBOknSbMIu7WHP3pCkMe9SwoVnD2lqpFACmHRvDWc=;
        b=jLczhgzU84LBwYWE2px8TlsCf54y8aPD9c7xMwTv0VRLuzOkTJinpCataXYx88UqpO
         TBqoAtemnyPCDJA70lQo2kuwCCOVvucIk65dWH+gUWX0N9diyxSF/90fIUJIZDjGhLKN
         QZ4xjvYxhSGosE9s2qxnqwh7I3sI4MM5lnElm3d+0ngu4irD8vDU0yrNnPVBYzTdQNtz
         1b+eZ5rdIC7T0fruY0290dUH37ukdx+cUxBWg0DHHQzvpROpoftq72v6UcavP+eudsM4
         vIpVa5Xb7EOX8w+zZknIFpKuNlazO2GCK4BAZPUERwqDtA+OvxQK4H7klRCoIouaiLrk
         RXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMsBOknSbMIu7WHP3pCkMe9SwoVnD2lqpFACmHRvDWc=;
        b=ktq58HkbD6ozTnDEmxjrHxC/xdzpttBZthW9sonp8V9FVbFXBIG3lSBCaQbNFaqlwe
         xBDokg/HE/ZyY8Ez0C71ekRqkYWaiCLGfstxLfuSQxKPuvNk1iIayK5z2VO6CcnNVfQl
         xAQ9GUj8DRiynVcFKx7ELORvZro2vZx77cDhKf/W9HM6pERbSwcLhw7Am4S8AGxgzTdD
         53xIm0izLo1MrXEg5OIgUzRAgZq3228mXZawo20VDvf7EdiqyrTfmco1w+w2aXFqy8GG
         t3FoFU6XCwAjVkw+i1IukrDzERk3w4gPTdvFkWm1YBhJYPxEyxvUpoWBuWI6f6M2Jgua
         YvLA==
X-Gm-Message-State: AA+aEWZtLUz0RevamvCNuwlJE2rstrCw76kMz64TomsuUYRflaHf85uU
        fLdisaBY9DKqRJEb4vNSmXTtGrXE35w=
X-Google-Smtp-Source: AJdET5dgB8Ng1bSsSxPda1DqATPcvDnYIqw61CfYws7tf88A3RNVVTvDPFDbwxEhS7MLdCUxeNzhmQ==
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr10830246wmc.140.1542901175076;
        Thu, 22 Nov 2018 07:39:35 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/10] commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
Date:   Thu, 22 Nov 2018 15:39:13 +0000
Message-Id: <20181122153922.16912-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

The commit graph file format describes an optional 'Large Edge List'
chunk, and the function writing out this chunk is called
write_graph_chunk_large_edges().  Then there are two functions in
'commit-graph.c', namely write_graph_chunk_data() and
write_commit_graph(), which have a local variable called
'num_extra_edges'.

It can be confusing on first sight whether large edges and extra edges
refer to the same thing or not, but they do, so let's rename those
variables to 'num_large_edges'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..7b4e3a02cf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -475,7 +475,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
-	uint32_t num_extra_edges = 0;
+	uint32_t num_large_edges = 0;
 
 	while (list < last) {
 		struct commit_list *parent;
@@ -507,7 +507,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		if (!parent)
 			edge_value = GRAPH_PARENT_NONE;
 		else if (parent->next)
-			edge_value = GRAPH_OCTOPUS_EDGES_NEEDED | num_extra_edges;
+			edge_value = GRAPH_OCTOPUS_EDGES_NEEDED | num_large_edges;
 		else {
 			edge_value = sha1_pos(parent->item->object.oid.hash,
 					      commits,
@@ -521,7 +521,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 		if (edge_value & GRAPH_OCTOPUS_EDGES_NEEDED) {
 			do {
-				num_extra_edges++;
+				num_large_edges++;
 				parent = parent->next;
 			} while (parent);
 		}
@@ -761,7 +761,7 @@ void write_commit_graph(const char *obj_dir,
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
 	int num_chunks;
-	int num_extra_edges;
+	int num_large_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
 
@@ -871,7 +871,7 @@ void write_commit_graph(const char *obj_dir,
 	commits.alloc = count_distinct;
 	ALLOC_ARRAY(commits.list, commits.alloc);
 
-	num_extra_edges = 0;
+	num_large_edges = 0;
 	for (i = 0; i < oids.nr; i++) {
 		int num_parents = 0;
 		if (i > 0 && oideq(&oids.list[i - 1], &oids.list[i]))
@@ -885,11 +885,11 @@ void write_commit_graph(const char *obj_dir,
 			num_parents++;
 
 		if (num_parents > 2)
-			num_extra_edges += num_parents - 1;
+			num_large_edges += num_parents - 1;
 
 		commits.nr++;
 	}
-	num_chunks = num_extra_edges ? 4 : 3;
+	num_chunks = num_large_edges ? 4 : 3;
 
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
@@ -916,7 +916,7 @@ void write_commit_graph(const char *obj_dir,
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	if (num_extra_edges)
+	if (num_large_edges)
 		chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
 	else
 		chunk_ids[3] = 0;
@@ -926,7 +926,7 @@ void write_commit_graph(const char *obj_dir,
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
 	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
 	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
-	chunk_offsets[4] = chunk_offsets[3] + 4 * num_extra_edges;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * num_large_edges;
 
 	for (i = 0; i <= num_chunks; i++) {
 		uint32_t chunk_write[3];
-- 
2.20.0.rc0.387.gc7a69e6b6c


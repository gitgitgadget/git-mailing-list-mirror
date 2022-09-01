Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AD2ECAAD5
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiIAJlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiIAJlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:41:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714E126495
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:41:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n17so21552648wrm.4
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=3fNp0xWy4ypRVVc6MHsw8lJAmPQZQlIUMjSn2xeBII8=;
        b=RnzkbtYG8ZWcevWVS9T6XQsUFb2Dfu4+Z31GECjQd5Zn4kw7xFM7alWdzFpO2R7XOB
         DSfhJ+PwmZ6FVPsqepzg2/DcQURrOz6nlUfoucU1vzAMWvcvcTmHpf3QZ2Pp3qTbUY/G
         1UratLLn+DtT4JTrKEf45tNVyMjRCgW7XGWN7qCm/A9D3OdB4B8wSfagXiSz7DYeJKlM
         713u7iCzbWZ27BQOFlLALZhcN/xqtwTqIsjCWoCUaM7huJWRXgybSVL80rd4GE+4NxG7
         3EtC79PrvqVEjIZSYk6WodQ8ljFdRXtQyU+HXSjgpWB/v0maPVx/SxbI4SI06j+oHv6u
         EFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3fNp0xWy4ypRVVc6MHsw8lJAmPQZQlIUMjSn2xeBII8=;
        b=THHpo4Hn1CSzkFdRmIqVFf7fN+waGrpTFsN8IPmfjQ2nS1YZQjpsC+xe60Jw7Df+F9
         PthRpF2sap+/jdWwFUD6EcLJrKAgPs8GzwjbZkFq1Ys4xzFbbARjbDMUIHRSBYR51u+y
         5/8P3ODf+UmFw9OynZvyBlSR0q8K9DrAVRFeujgek3tQQEdh5h+Swnq63b9CuXTKzIm1
         8StDWRYRTrga9VHuR61zJJd5cDHllMkBtHiWHZCIN6tghrRAUUjSkkpZU4VX63Ww8Bz3
         pvu8Krb7EXXBDaM4nkJkbjMvp6kG92mNiQAMI5ESebmuuuzO8EsfEh51ytE1WX2wkYP5
         AuNw==
X-Gm-Message-State: ACgBeo3NxMWSo/yI+8AUSDAtqBRvTCLR6CdNbrIzha9t1stFdr4uKgNr
        VlYhJkY5hZNxVJJkbgSurXIzemyrdng=
X-Google-Smtp-Source: AA6agR5kFsKkHCquhi6QL9LFdcyW1F1IkT/xfe7m1pToIx2jq6W03a5GWeOGsAmYRpZ7IQlJRqa7Og==
X-Received: by 2002:a5d:5847:0:b0:221:748d:243c with SMTP id i7-20020a5d5847000000b00221748d243cmr13548110wrf.222.1662025275106;
        Thu, 01 Sep 2022 02:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003a317ee3036sm4750590wmk.2.2022.09.01.02.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:41:14 -0700 (PDT)
Message-Id: <19fd72c34dcd1332df638d76b0b028e9d9da3d41.1662025272.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:41:10 +0000
Subject: [PATCH 1/3] commit-graph: let commit graph respect commit graft
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In repo_parse_commit_internal(), if we want to use
commit graph, it will call parse_commit_in_graph() to
parse commit's content from commit graph, otherwise
call repo_read_object_file() to parse commit's content
from commit object.

repo_read_object_file() will respect commit graft,
which can correctly amend commit's parents. But
parse_commit_in_graph() not. Inconsistencies here may
result in incorrect processing of shallow clone.

So let parse_commit_in_graph() respect commit graft as
repo_read_object_file() does, which can solve this problem.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 commit-graph.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f2a36032f84..89bb6f87079 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -820,6 +820,7 @@ static int fill_commit_in_graph(struct repository *r,
 	struct commit_list **pptr;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
+	struct commit_graft *graft;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
@@ -833,31 +834,54 @@ static int fill_commit_in_graph(struct repository *r,
 
 	set_commit_tree(item, NULL);
 
+	graft = lookup_commit_graft(r, &item->object.oid);
+	if (graft)
+		r->parsed_objects->substituted_parent = 1;
+
 	pptr = &item->parents;
 
 	edge_value = get_be32(commit_data + g->hash_len);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
-	pptr = insert_parent_or_die(r, g, edge_value, pptr);
+	if (!(graft && (graft->nr_parent < 0 || grafts_replace_parents)))
+		pptr = insert_parent_or_die(r, g, edge_value, pptr);
 
 	edge_value = get_be32(commit_data + g->hash_len + 4);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	if (!(edge_value & GRAPH_EXTRA_EDGES_NEEDED)) {
-		pptr = insert_parent_or_die(r, g, edge_value, pptr);
-		return 1;
+		if (!(graft && (graft->nr_parent < 0 || grafts_replace_parents))) {
+			pptr = insert_parent_or_die(r, g, edge_value, pptr);
+			return 1;
+		}
 	}
 
 	parent_data_ptr = (uint32_t*)(g->chunk_extra_edges +
 			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
 	do {
 		edge_value = get_be32(parent_data_ptr);
-		pptr = insert_parent_or_die(r, g,
-					    edge_value & GRAPH_EDGE_LAST_MASK,
-					    pptr);
+		if (!(graft && (graft->nr_parent < 0 || grafts_replace_parents))) {
+			pptr = insert_parent_or_die(r, g,
+						    edge_value & GRAPH_EDGE_LAST_MASK,
+						    pptr);
+		}
 		parent_data_ptr++;
 	} while (!(edge_value & GRAPH_LAST_EDGE));
 
+	if (graft) {
+		int i;
+		struct commit *new_parent;
+		for (i = 0; i < graft->nr_parent; i++) {
+			new_parent = lookup_commit(r,
+						   &graft->parent[i]);
+			if (!new_parent)
+				die(_("bad graft parent %s in commit %s"),
+				       oid_to_hex(&graft->parent[i]),
+				       oid_to_hex(&item->object.oid));
+			pptr = &commit_list_insert(new_parent, pptr)->next;
+		}
+	}
+
 	return 1;
 }
 
-- 
gitgitgadget


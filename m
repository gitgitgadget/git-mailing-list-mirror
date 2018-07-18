Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E15A1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbeGRQv2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38443 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeGRQv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so4594939ljc.5
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmZsKlfdWHblGdUxl7/icNOecGgUpXkrYgA+I9fMw+s=;
        b=Wqnrz4R2wXWsFJgcD/1KqNptAAYHWV8L2UgFHJRNKt5UOP8+eU6durXAgbTtH62Nnm
         ulp6ZltKZmb9ZJ7vIkBd84rWXQvCmhiOBBHGzn8wKUeld+aOHqzZvqGhxUxxIpc+RjHx
         IRdFFvxVVLOzzj4gMHbseFJFFOg1to/siopdzLacv7QkbTvI0bxQXUHixn5oeN/qNLHE
         jiTlne7fFtvEfM7T5SvkHrnm4VIAYKZ/pZOB1KUP3IYbIV8b25NjzPCbwlPfvrzt4czI
         9cBgOd6yVLmyn3uCdTcXpY19nFhLIcrrh13U2P88Zc+Y/Ivlsxrr8Higd8sdbuv6pvaR
         azig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmZsKlfdWHblGdUxl7/icNOecGgUpXkrYgA+I9fMw+s=;
        b=P6NxvKjZTbJC2PIRPG7u12Iu88NlhNqIIcsnwUoLbFw5vRzf1np/52g6MqhrpIP5cy
         A9oZRWmys0hdCTKTiRrUuQtS8H5oCKY8BXtdxXiK8HE8vU5q46zAQftmV6GZq3ELGYsi
         bIjCj7CUSgxSor1S0qGt8pu6QUckpWnV0zRBKCSXsUyL/Ft/Jz5+jFNzH4MlNhDUzrYe
         8TcfmQX7kLwlZOxVREw33cuiV8VQHK0boxFeH6ZT5OxYMIbj+sEsYunhlIIZJMYKX+3m
         eu+KEnhepj8PoG/QoqRtXLh04X1QN6TRwtU2nF+KU/obLGXadL+5k4dTlT8rZUQM7NwH
         K06g==
X-Gm-Message-State: AOUpUlGNF8xiD8NeBJdh2AnUpq3CrsZ1GbGCms0GfQEHIRtJ6gMc9J0B
        bzg1YDGVw8pF8BeZ9KIgjh+vBQ==
X-Google-Smtp-Source: AAOMgpf+kRphbyOVBA4P4+kUKMFOXSCx2fmA1oJOC0gd/sNcqfAKVfCR6rGiTb8Oifcw7p9amdteJQ==
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr4939224ljt.56.1531930370068;
        Wed, 18 Jul 2018 09:12:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/23] commit-graph.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:46 +0200
Message-Id: <20180718161101.19765-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit-graph.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b63a1fc85e..c8d521923c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -77,28 +77,28 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 	if (graph_size < GRAPH_MIN_SIZE) {
 		close(fd);
-		die("graph file %s is too small", graph_file);
+		die(_("graph file %s is too small"), graph_file);
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	data = (const unsigned char *)graph_map;
 
 	graph_signature = get_be32(data);
 	if (graph_signature != GRAPH_SIGNATURE) {
-		error("graph signature %X does not match signature %X",
+		error(_("graph signature %X does not match signature %X"),
 		      graph_signature, GRAPH_SIGNATURE);
 		goto cleanup_fail;
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
 	if (graph_version != GRAPH_VERSION) {
-		error("graph version %X does not match version %X",
+		error(_("graph version %X does not match version %X"),
 		      graph_version, GRAPH_VERSION);
 		goto cleanup_fail;
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
 	if (hash_version != GRAPH_OID_VERSION) {
-		error("hash version %X does not match version %X",
+		error(_("hash version %X does not match version %X"),
 		      hash_version, GRAPH_OID_VERSION);
 		goto cleanup_fail;
 	}
@@ -122,7 +122,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
-			error("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
+			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
 			goto cleanup_fail;
 		}
@@ -158,7 +158,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		}
 
 		if (chunk_repeated) {
-			error("chunk id %08x appears multiple times", chunk_id);
+			error(_("chunk id %08x appears multiple times"), chunk_id);
 			goto cleanup_fail;
 		}
 
@@ -244,7 +244,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c = lookup_commit(&oid);
 	if (!c)
-		die("could not find commit %s", oid_to_hex(&oid));
+		die(_("could not find commit %s"), oid_to_hex(&oid));
 	c->graph_pos = pos;
 	return &commit_list_insert(c, pptr)->next;
 }
@@ -537,7 +537,7 @@ static int add_packed_commits(const struct object_id *oid,
 
 	oi.typep = &type;
 	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
-		die("unable to get type of object %s", oid_to_hex(oid));
+		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
 		return 0;
@@ -683,9 +683,9 @@ void write_commit_graph(const char *obj_dir,
 			strbuf_addstr(&packname, pack_indexes[i]);
 			p = add_packed_git(packname.buf, packname.len, 1);
 			if (!p)
-				die("error adding pack %s", packname.buf);
+				die(_("error adding pack %s"), packname.buf);
 			if (open_pack_index(p))
-				die("error opening index for %s", packname.buf);
+				die(_("error opening index for %s"), packname.buf);
 			for_each_object_in_pack(p, add_packed_commits, &oids);
 			close_pack(p);
 		}
-- 
2.18.0.rc2.476.g39500d3211


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0859B1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436847AbeKWAH5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:07:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54773 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436841AbeKWAH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:07:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so9010889wma.4
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AMsBOknSbMIu7WHP3pCkMe9SwoVnD2lqpFACmHRvDWc=;
        b=je47O8ZtKEFCZkCFUgACqTc84alNndaCBgJMjsFIczDSswbOzgy0yOMn1g3LhPkkdF
         MY7EGja+1JmY5zU0crGKsceG5nWfruGVf5n7W4Og7PupT8BjvqsF9ReNFd+iF7nL9U6k
         dCJQn9ksAFTragmDWvbsJ3+Iwc7STj4jSP/gYN7lVwKjF/Lo9b805RaVt1UA3jJpnxMI
         2avSRJg2Im+z1i/Bj+TG+NyoxbI1J0P/L2q9TrG3sxrxGoqcxlAzP9c7LzcS1cTbOJee
         ChJQD1TfCCMg22t4mHuuXVFfzBdRriqRG0RmTxC2SslDR/2keZ8x/vLx/9CBU5pRfUSu
         tK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMsBOknSbMIu7WHP3pCkMe9SwoVnD2lqpFACmHRvDWc=;
        b=Qp53aWHpyAOMy7RPOjFKlvZjhkd5qf5QYMSV+h+qa77gyVCRiGf46z1LXRo51/REMY
         cZlJM0MWmXCENMdHZUxNz6Q3JQvXn+2su/OFd9wNTpuietAbglcyn5TEvm6zsDhVjxz6
         XN9e1uida9HcKBc0LxQr5S74zJhwfwVX1FWgBUjr338CAQbS0OqbIFeNejWIdA3cAtgd
         qaSP5vQ4iBN+3UBwJVnK71nIcd5kN8/HoP/cKH5e+16hVNKf668H8A6Gufd/qirnVeuC
         oqMD66V/VRZGyB4CSTQLtql0I5iqdvTX3Kb17/uTefKab0iQ8r0NbWVekeQBRnyuoAPj
         OdNQ==
X-Gm-Message-State: AGRZ1gJLd5M5+YhNxVjmuQeOTMmSjLe1buUjEI9jyGuokyeOqinMwCNb
        cSkR2OM/O28tZ+h2rVjLq+DQH7kl
X-Google-Smtp-Source: AJdET5dt8RzRY0YR7RE3fyUTFa3L/2nVKmoKAPYUWYYKFds7561XKfrX5uEIdZp0ZHJUUp2M5MCKhA==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr9922193wmj.90.1542893313619;
        Thu, 22 Nov 2018 05:28:33 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:32 -0800 (PST)
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
Subject: [PATCH v3 01/10] commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
Date:   Thu, 22 Nov 2018 13:28:14 +0000
Message-Id: <20181122132823.9883-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181121012600.26951-1-szeder.dev@gmail.com>
References: <20181121012600.26951-1-szeder.dev@gmail.com>
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB7A1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 01:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeKUL56 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 06:57:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUL55 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 06:57:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so3897499wrr.12
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 17:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USqIV18khhoH4fBpwu0qDAzGoeCJwCwJE0jP5f4XDXk=;
        b=klju8ZZt+Jsv2uYcWEU7M1tVgnVozxAI7Z0wGKYENBbH1JCgI4RVOqP9J1CS/+sJ0/
         GwPf1AkghukS5nF7twypJ+HRTcd0gfXH5/iyuqafplsrvBYUuYtQCoct9BukR2/0EYDJ
         +b01JRiJYjG78WnqPmK5lq63LPOb9uSfWNum2lwahoQPhEHUdVT9GXntrMZ+tBGqX5Ag
         kWqUcAPh1HBQk2RnsQjMLCbbcO4IF6lK0S8c1ote/vu4mtFwLohx7LCXB8uqUCdX3CFJ
         Rpt3mJEgubZGRgY9MBc2a1XEwNFJlA7meosvolElG49wOY2xD0+So50MxaySYZmfhDO0
         Us6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USqIV18khhoH4fBpwu0qDAzGoeCJwCwJE0jP5f4XDXk=;
        b=rcjNQeDofmlX3rnoZovnktl35GQ13dHGpXHSlkwDVoprBFk3h/pbXv4b/g1/4m7H2l
         iMBGprI+Gx/jj7sJyId2Mpz2+5p2oHTD9GmLxQ3gYQdhp2HygMhnbtVWN+aX1wVZhBQJ
         hyKJ/xo5s6OSCEuxHfhggqY1FyKflPfB1sQ6Vf53nhdsJQJOLNu1Z82pXfk0swr9X+Yh
         o5PrYqhyhw3TNnUih/IgzpRv+HmCN4cx/FYzleR66vxJ27lA3i1VneELs8IqJaXz1gkQ
         FSwYoCECFJazuJnJPxOAdURH43BJ88HieppZEe2FCryr1vvF7xAXY9OQQxVlDwWFMpie
         /xTw==
X-Gm-Message-State: AA+aEWZ9xmp9X0FR7vLpdfp1UWB/BGDpYtwg2CScZDtj6U3oagg/72xR
        CpWf29ibmWtp8O2G89vDukw=
X-Google-Smtp-Source: AFSGD/XeqH1wAAenLNtb19iJZ2dGBPtUN8LI9p7eN7hqsnS5WygCd4Vh8F5OZp9h7pU9dTfQRkihgA==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr3673227wrs.86.1542763549205;
        Tue, 20 Nov 2018 17:25:49 -0800 (PST)
Received: from localhost.localdomain (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id g16sm1035274wrr.62.2018.11.20.17.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 17:25:48 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
Date:   Wed, 21 Nov 2018 02:25:32 +0100
Message-Id: <20181121012532.26878-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.134.gf0022f8e60
In-Reply-To: <20181121012344.26711-1-szeder.dev@gmail.com>
References: <20181121012344.26711-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---

I rename these variables to 'num_large_edges', because the commit
graph file format speaks about the 'Large Edge List' chunk.

However, I do find that the term 'extra' makes much more sense and
fits the concept better (i.e. extra commit graph edges resulting from
the extra parents or octopus merges; after a s/extra/large/g the
previous phrase would make no sense), and notice that the term 'large'
doesn't come up in the file format itseld (the chunk's magic is {'E',
'D', 'G', 'E'}, there is no 'L' in there), but only in the
specification text and a couple of variable and function names in the
code.

Would it make sense to do the rename in the other direction?

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
2.20.0.rc0.134.gf0022f8e60


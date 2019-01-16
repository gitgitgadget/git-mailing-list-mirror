Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D8F1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393162AbfAPNaJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34727 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732885AbfAPNaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so6979005wrw.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKwjG0pedZGSwCGACvJObsPQltN3dQKsxguVFTra7s4=;
        b=JlKT0VganDGSCobSEwf4vzXBrkalQq2uyuBdevTEXGBEB/ejZ5KO2fsyMxFKOIkOGl
         qRZrh25ylXSQVA3wyUZ4ihScOx/0Mz7FYftkysPFCIxLZl8O14G7w7OUYmoJE7OM+3WM
         lKmrnKfU9Mc01qu/4nrjiSIIPJEDSozLU0rN9t+ZB5d8O/1MgoUbL3SZChVaSw9WlL+C
         YNZQZNE32E67wD9aP3lchbC+2Du0YcupCK6oh0hI3UFssspCJT/RTkb7Q1RwJJmH+dH5
         j4stbt1ygKdXW+jvtb0opsXzUI4GLmtO+03hx81bZPs/VTn+zl3fhjnx9fJi23U1X8YO
         1Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKwjG0pedZGSwCGACvJObsPQltN3dQKsxguVFTra7s4=;
        b=gHWpgimzsTKAJxzo+yuMz2mGhMhWn+6cEkPHxygKFb0bX+gR2EAXo0UGxBHDnQS6/b
         kmRp1CXtvoVcq8B3x/RBVGGKJDq5qLoGQCZ4NGUH/CoYT53hBVwKWnSnNsejOx+Ac7y0
         EEntPrBAK1B4/m4c8IN5FIoOEa9peepUbHfDMTjXMlucZrQslwAyJhqY/n899ONlQwVk
         AwaefQGXyehMO+rLcCDHkPMQZWuL8ax5g/BcAyYLgpDvrzHonvIPURuNY0M5w6jZaQGB
         G9XiL/4cjEp4+ykGu9lDC/vcbytHb1RKPNSB6jtNIfF0hnVjYEY7YNDvyfOsqWlkGuYI
         Y4Fw==
X-Gm-Message-State: AJcUukfvEO0LZoHSMnzVc7PKUz96rBjbNevthK+r/Z8Bro42XH/UFzBQ
        hMoekZ4R009Qb4iGRVGHafbozLDB
X-Google-Smtp-Source: ALg8bN5HW+1L1SiYzHNWhVB14dQxdUWsxKfUtqXvU1/eZRMnuNJPqwaBM6XWPU3x95oNwdOqGnmdFQ==
X-Received: by 2002:adf:f052:: with SMTP id t18mr8001928wro.112.1547645406011;
        Wed, 16 Jan 2019 05:30:06 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:05 -0800 (PST)
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
Subject: [PATCH v5 1/9] commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
Date:   Wed, 16 Jan 2019 14:29:39 +0100
Message-Id: <20190116132947.26025-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181122153922.16912-2-avarab@gmail.com>
References: <20181122153922.16912-2-avarab@gmail.com>
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
index 5c8fb4b134..ab292e5d01 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -472,7 +472,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 {
 	struct commit **list = commits;
 	struct commit **last = commits + nr_commits;
-	uint32_t num_extra_edges = 0;
+	uint32_t num_large_edges = 0;
 
 	while (list < last) {
 		struct commit_list *parent;
@@ -504,7 +504,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		if (!parent)
 			edge_value = GRAPH_PARENT_NONE;
 		else if (parent->next)
-			edge_value = GRAPH_OCTOPUS_EDGES_NEEDED | num_extra_edges;
+			edge_value = GRAPH_OCTOPUS_EDGES_NEEDED | num_large_edges;
 		else {
 			edge_value = sha1_pos(parent->item->object.oid.hash,
 					      commits,
@@ -518,7 +518,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 		if (edge_value & GRAPH_OCTOPUS_EDGES_NEEDED) {
 			do {
-				num_extra_edges++;
+				num_large_edges++;
 				parent = parent->next;
 			} while (parent);
 		}
@@ -765,7 +765,7 @@ void write_commit_graph(const char *obj_dir,
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
 	int num_chunks;
-	int num_extra_edges;
+	int num_large_edges;
 	struct commit_list *parent;
 	struct progress *progress = NULL;
 
@@ -875,7 +875,7 @@ void write_commit_graph(const char *obj_dir,
 	commits.alloc = count_distinct;
 	ALLOC_ARRAY(commits.list, commits.alloc);
 
-	num_extra_edges = 0;
+	num_large_edges = 0;
 	for (i = 0; i < oids.nr; i++) {
 		int num_parents = 0;
 		if (i > 0 && oideq(&oids.list[i - 1], &oids.list[i]))
@@ -889,11 +889,11 @@ void write_commit_graph(const char *obj_dir,
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
@@ -920,7 +920,7 @@ void write_commit_graph(const char *obj_dir,
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	if (num_extra_edges)
+	if (num_large_edges)
 		chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
 	else
 		chunk_ids[3] = 0;
@@ -930,7 +930,7 @@ void write_commit_graph(const char *obj_dir,
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
 	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
 	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
-	chunk_offsets[4] = chunk_offsets[3] + 4 * num_extra_edges;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * num_large_edges;
 
 	for (i = 0; i <= num_chunks; i++) {
 		uint32_t chunk_write[3];
-- 
2.20.1.153.gd81d796ee0


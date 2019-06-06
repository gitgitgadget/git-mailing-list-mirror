Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1874E1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfFFOPi (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46171 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfFFOPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id h10so3520236edi.13
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rfp8nug5J7s66mjwvlnu7umexaC3ndHnoxesoCixggY=;
        b=nDti2/kIl4ws+2z47Q49SaADtbMppRctiLOHgrUzIZylqD8NEHZ5TNaI+vWOjP7Byl
         t4hl6sOR6wYm8kJPTXZuOof2selIApUojrdCsblpuuJ7135P5ZnMC0c308c1vFIJzE2j
         MxnxkUvySNepW6nNcfiiXvlguC1yyefT+mOavOpLDRqyflHGew/1ODm28PkZKa55Rdli
         z562aeUW9m7XgZTLAc3v4H0CTHMQ8Kzp+rIUhPXgbXL1CXbRUIztPsc5DnO9OMEvRQMZ
         StV9YrBLUWyX2zxJxF7xzLrFFJhmwZfVV4CmDw1eHFnbmnQxyAxvUZ334bpbjUtZmHJU
         Sv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rfp8nug5J7s66mjwvlnu7umexaC3ndHnoxesoCixggY=;
        b=XLA+TCa3QZVoC9QKCu9my8nB/LuGeAEdH3Kys9U297LMuhVPqe+63dlA6O/D45wqTm
         7YAgYQa/G8ruax1zJN7CFOGTEkF0Fxd9t7h2Y1+sGc82MbHRs7akn6iyN5g9btZGaM+7
         ttYzMoQb3zZ/Udard5vToK82RdJLrwAWg4BMONAtBYd//8txm6YG1oHGnbTLMugqJWwY
         lY/4NozXqP+brs5KgMCaZjFamicwPFRIGNh4YbaqWwPQ0gjKsd6RofN/ORPHjYpTPj4l
         MgrjHktECJBHRE5gR60b8peHPBXKLNmrTE7kij5xE/RGx7Cc50B3Mk1vTasMCP70Gs2M
         gSKQ==
X-Gm-Message-State: APjAAAWoqsiAHRFuSYCVQEK6Dw7N+4pZrPocLT/Bk1+jpcLSV9WSvVFy
        9OyWaH54TvuSvlF0Mz5uls1N7A6T
X-Google-Smtp-Source: APXvYqyIxLKh7YjuO8BOz5j/p7lSEXKEBo1L87cXgUVWNn0e0qP5xpyQEGAghZIaRIZR9wJhHhj00g==
X-Received: by 2002:a50:84a1:: with SMTP id 30mr50987161edq.105.1559830532922;
        Thu, 06 Jun 2019 07:15:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm493591edu.21.2019.06.06.07.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:32 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:32 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:17 GMT
Message-Id: <ca670536dfe08277e953b2ef5f017dc32c1581d5.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/14] commit-graph: load commit-graph chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Prepare the logic for reading a chain of commit-graphs.

First, look for a file at $OBJDIR/info/commit-graph. If it exists,
then use that file and stop.

Next, look for the chain file at $OBJDIR/info/commit-graphs/commit-graph-chain.
If this file exists, then load the hash values as line-separated values in that
file and load $OBJDIR/info/commit-graphs/graph-{hash[i]}.graph for each hash[i]
in that file. The file is given in order, so the first hash corresponds to the
"base" file and the final hash corresponds to the "tip" file.

This implementation assumes that all of the graph-{hash}.graph files are in
the same object directory as the commit-graph-chain file. This will be updated
in a future change. This change is purposefully simple so we can isolate the
different concerns.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e2f438f6a3..3ed930159e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,6 +45,19 @@ char *get_commit_graph_filename(const char *obj_dir)
 	return xstrfmt("%s/info/commit-graph", obj_dir);
 }
 
+static char *get_split_graph_filename(const char *obj_dir,
+				      const char *oid_hex)
+{
+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph",
+		       obj_dir,
+		       oid_hex);
+}
+
+static char *get_chain_filename(const char *obj_dir)
+{
+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", obj_dir);
+}
+
 static uint8_t oid_version(void)
 {
 	return 1;
@@ -286,18 +299,107 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 	return load_commit_graph_one_fd_st(fd, &st);
 }
 
+static struct commit_graph *load_commit_graph_v1(struct repository *r, const char *obj_dir)
+{
+	char *graph_name = get_commit_graph_filename(obj_dir);
+	struct commit_graph *g = load_commit_graph_one(graph_name);
+	free(graph_name);
+
+	return g;
+}
+
+static int add_graph_to_chain(struct commit_graph *g,
+			      struct commit_graph *chain,
+			      struct object_id *oids,
+			      int n)
+{
+	struct commit_graph *cur_g = chain;
+
+	while (n) {
+		n--;
+		cur_g = cur_g->base_graph;
+	}
+
+	g->base_graph = chain;
+
+	if (chain)
+		g->num_commits_in_base = chain->num_commits + chain->num_commits_in_base;
+
+	return 1;
+}
+
+static struct commit_graph *load_commit_graph_chain(struct repository *r, const char *obj_dir)
+{
+	struct commit_graph *graph_chain = NULL;
+	struct strbuf line = STRBUF_INIT;
+	struct stat st;
+	struct object_id *oids;
+	int i = 0, valid = 1;
+	char *chain_name = get_chain_filename(obj_dir);
+	FILE *fp;
+
+	if (stat(chain_name, &st)) {
+		free(chain_name);
+		return NULL;
+	}
+
+	if (st.st_size <= the_hash_algo->hexsz) {
+		free(chain_name);
+		return NULL;
+	}
+
+	fp = fopen(chain_name, "r");
+	free(chain_name);
+
+	if (!fp)
+		return NULL;
+
+	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
+
+	while (strbuf_getline_lf(&line, fp) != EOF && valid) {
+		char *graph_name;
+		struct commit_graph *g;
+
+		if (get_oid_hex(line.buf, &oids[i])) {
+			warning(_("invalid commit-graph chain: line '%s' not a hash"),
+				line.buf);
+			valid = 0;
+			break;
+		}
+
+		graph_name = get_split_graph_filename(obj_dir, line.buf);
+		g = load_commit_graph_one(graph_name);
+		free(graph_name);
+
+		if (g && add_graph_to_chain(g, graph_chain, oids, i))
+			graph_chain = g;
+		else
+			valid = 0;
+	}
+
+	free(oids);
+	fclose(fp);
+
+	return graph_chain;
+}
+
+static struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
+{
+	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
+
+	if (!g)
+		g = load_commit_graph_chain(r, obj_dir);
+
+	return g;
+}
+
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 {
-	char *graph_name;
 
 	if (r->objects->commit_graph)
 		return;
 
-	graph_name = get_commit_graph_filename(obj_dir);
-	r->objects->commit_graph =
-		load_commit_graph_one(graph_name);
-
-	FREE_AND_NULL(graph_name);
+	r->objects->commit_graph = read_commit_graph_one(r, obj_dir);
 }
 
 /*
-- 
gitgitgadget


Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95D135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337195; cv=none; b=S0eH3fbHjsYOHRTYXICw/2nvv3wmrEfy9wmd7CMvTyzqdIgZBV9Rfa+PK5F8uqzv0YVmT61MeatyR4k44wfu8oz3twoZJsHJ/Ma1yESE489QZr/xbMscJaZr0TVFkrgL4q8NIA0NredqNn44HH+/XDQJayLh8slcBjoH/oipJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337195; c=relaxed/simple;
	bh=JgtwCzjBckp3YHD9dUDpxe0aKb2T0n6kxi1lGWleDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUMsNaMkZddWdK6arz6m34aCiRUUGS1XN0kcirgC8HfISFezd3bU2pOij+TxhVrlh7MlxbvwRUB3iCuBl2OauI5l23n+lB57KqR8+hp9vlWeZDIRm6z+ICSD1kjND01JEE6xSknOQE8t70uw1DKVMhcuLhpCVExzA6Lf1CX9ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Aa4kzbkf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Aa4kzbkf"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c0c19ff02so56783085a.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337192; x=1719941992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9t6xq6qLTTwHHmF3vN7MvS2P4wEOHzKelOXt+QaYtzE=;
        b=Aa4kzbkfDY1qCHn2iapfb6Yg32tWhTcwtKehShNKddxgjS75xZ16mm0mCCoYhXHxoh
         rcG/mTtIzttRBWi11QZwXEniDN8PzDVNkXGTIIo/rmT43AL8BFYqZ+EHZP9qNEkXLT2d
         7lyMZpQIWq86OuWbc6K5LfIofzxOEQM+4GgGtvv3zmsgHH5aAvdKRW49arc0GInJoAeM
         aIx42YEUgnaWjXV8lavUIQV577VPm9ywV78MnHuL6vEBtFvzdio04NxzdViZ0jpUfC29
         jIMuW0w9MG/i+b0J0yMT4PmM1tsDXDSUzrRaKG4sms/S4RYWj2LIPSri0Ktp6K9vIFp8
         fjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337192; x=1719941992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t6xq6qLTTwHHmF3vN7MvS2P4wEOHzKelOXt+QaYtzE=;
        b=XiRylXX1pxNoAbkKt3Cn2vWEfFY/ZsMz1uK07PGi38bNthQGAYZ8vpRohKCxRey+fa
         lmt5cb/Pd2RBmYckmCV2u290SxocPuCiLlsq7lmhB0doxF7nfxI2g4aBmy+447/j8aEo
         DTQj0TF8bXNv6soU6sisK/roDqCjIAlMVXfgjcL/q5yqMLymBqB3/7/l2xBXS7X6BceQ
         q2U/hzmqAOv+O4Ma6pyp3yYF9TIP/dXwV13iZtnsRmUM42DDpMAsIqnK+zSHnkZ6r7fk
         xkWYR4N6torlRF//ltXPWHOx6sJDJ3xf+jneYXQgpZD8Fdr12kePNXXhGMf4JdnZpp2Q
         gRvA==
X-Gm-Message-State: AOJu0YyNHQNZp4bss6QYfRFiMFlqNmn83FIl+uD1YSisw8F8JLzX2wfj
	9Q6S2bQgGKdw/9iAP1w5l73i7MX5Fw3V+pmOf/OY55Wj4rDfBelBJnu+tiuWgE/CGsoldghcg8W
	+5ks=
X-Google-Smtp-Source: AGHT+IH6Z2rUhV8QOz5ek2MuUD4bjlENjWdix56wCmSgFed6LwOanmPRpi1n/V1y84kpI7R/E7TxEg==
X-Received: by 2002:a05:622a:4b0e:b0:444:ee8e:75c0 with SMTP id d75a77b69052e-444ee8e796amr42138191cf.6.1719337192470;
        Tue, 25 Jun 2024 10:39:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44504570578sm349791cf.3.2024.06.25.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:52 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 09/16] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <60c063ca4aa86e0397b42f2c742f986987490683.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

A subsequent commit will introduce another version of the changed-path
filter in the commit graph file. In order to control which version to
write (and read), a config variable is needed.

Therefore, introduce this config variable. For forwards compatibility,
teach Git to not read commit graphs when the config variable
is set to an unsupported version. Because we teach Git this,
commitgraph.readChangedPaths is now redundant, so deprecate it and
define its behavior in terms of the config variable we introduce.

This commit does not change the behavior of writing (Git writes changed
path filters when explicitly instructed regardless of any config
variable), but a subsequent commit will restrict Git such that it will
only write when commitgraph.changedPathsVersion is a recognized value.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/commitgraph.txt | 26 +++++++++++++++++++++++---
 commit-graph.c                       |  5 +++--
 oss-fuzz/fuzz-commit-graph.c         |  2 +-
 repo-settings.c                      |  6 +++++-
 repository.h                         |  2 +-
 5 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c..e68cdededa 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -9,6 +9,26 @@ commitGraph.maxNewFilters::
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
 commitGraph.readChangedPaths::
-	If true, then git will use the changed-path Bloom filters in the
-	commit-graph file (if it exists, and they are present). Defaults to
-	true. See linkgit:git-commit-graph[1] for more information.
+	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
+	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
+	is also set, commitGraph.changedPathsVersion takes precedence.)
+
+commitGraph.changedPathsVersion::
+	Specifies the version of the changed-path Bloom filters that Git will read and
+	write. May be -1, 0 or 1. Note that values greater than 1 may be
+	incompatible with older versions of Git which do not yet understand
+	those versions. Use caution when operating in a mixed-version
+	environment.
++
+Defaults to -1.
++
+If -1, Git will use the version of the changed-path Bloom filters in the
+repository, defaulting to 1 if there are none.
++
+If 0, Git will not read any Bloom filters, and will write version 1 Bloom
+filters when instructed to write.
++
+If 1, Git will only read version 1 Bloom filters, and will write version 1
+Bloom filters.
++
+See linkgit:git-commit-graph[1] for more information.
diff --git a/commit-graph.c b/commit-graph.c
index 3d89febae4..87b07e7b85 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -459,7 +459,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_read_changed_paths) {
+	if (s->commit_graph_changed_paths_version) {
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   graph_read_bloom_index, graph);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
@@ -555,7 +555,8 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
 		}
 
 		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
-		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
+		    g->bloom_filter_settings->num_hashes != settings->num_hashes ||
+		    g->bloom_filter_settings->hash_version != settings->hash_version) {
 			g->chunk_bloom_indexes = NULL;
 			g->chunk_bloom_data = NULL;
 			FREE_AND_NULL(g->bloom_filter_settings);
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 75e668a057..c4e555fbe3 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -21,7 +21,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 */
 	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
 	the_repository->settings.commit_graph_generation_version = 2;
-	the_repository->settings.commit_graph_read_changed_paths = 1;
+	the_repository->settings.commit_graph_changed_paths_version = 1;
 	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
diff --git a/repo-settings.c b/repo-settings.c
index a0b590bc6c..2b4e68731b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -23,6 +23,7 @@ void prepare_repo_settings(struct repository *r)
 	int value;
 	const char *strval;
 	int manyfiles;
+	int read_changed_paths;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -54,7 +55,10 @@ void prepare_repo_settings(struct repository *r)
 	/* Commit graph config or default, does not cascade (simple) */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
 	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
-	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
+	repo_cfg_bool(r, "commitgraph.readchangedpaths", &read_changed_paths, 1);
+	repo_cfg_int(r, "commitgraph.changedpathsversion",
+		     &r->settings.commit_graph_changed_paths_version,
+		     read_changed_paths ? -1 : 0);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
 
diff --git a/repository.h b/repository.h
index a35cd77c35..bd7a408013 100644
--- a/repository.h
+++ b/repository.h
@@ -32,7 +32,7 @@ struct repo_settings {
 
 	int core_commit_graph;
 	int commit_graph_generation_version;
-	int commit_graph_read_changed_paths;
+	int commit_graph_changed_paths_version;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
-- 
2.45.2.664.g446e6a2b1f


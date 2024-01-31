Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58A3B787
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741567; cv=none; b=MUYOHHXGcLEVouPhDOrDU3jP1KyZwE0jbQWqbKLavXNrw0CJCyorylxAHISYc00VDJG6i99n6KnuYMZwZEila2QxE49rbdT0umyfNPTUPanVAKSCE/tiJrq0PsQgOu7p43SFXF+vJeqUAChdTcLI9ZmN5tSTgEA9rJf8u6xYM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741567; c=relaxed/simple;
	bh=w6/JmHtq3W/XFJPWhIgWmsEh1Gm/avH/upAp0ujalZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0fMkVDwiHbOUcd5fBSa4Bbc94qBitGT4eDb4Vwcq5t0B9toBHCz1yijP38ogEjPi3+e5q5md976leD9tFaS89aYeym/JRUeuRfb6a5NQIJpdUqZZxZxsA4OrxwBUqx6v8MxwSiug8unlcTgAUNHDQHpednKXa7Vf418uvidKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IfafW0T3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IfafW0T3"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78406c22dc7so26911985a.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741564; x=1707346364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+qJCc4C16jR0f6W2tHmNYuk/U+XF38U0iOkbqJ7sMI=;
        b=IfafW0T3NJHkEccf/bGmBBvfX6ofuJcOEi4Oot180/Fm4h9ZcrmUcztuqoiiEwfpRT
         0qAlqTSsgAUmFc88B0ka5Er1wp90kzfdJdMmZFpx753tuCF33BQqT1iEh/9dXdsmnJ2N
         Vf5MCngHOpkqH53dclwc4hn+Zj00ImwE7NvxVXKhByzEGOvKbpr8rodxUCiWYfCWmSSp
         jVO3ueNmVzjdr1ZPkxcxYYvJmlCJQYBsBZqqdLcArG0xr9+rhTyuFEEFmixZZRN5BkAh
         SEggWdw1eDoBGmCbhoILTs5NtfaSauvJSBuslkGedbMkbq+IvvRbrUwXThwUaTDZiptF
         JcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741564; x=1707346364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+qJCc4C16jR0f6W2tHmNYuk/U+XF38U0iOkbqJ7sMI=;
        b=Mr1eVfwPkMsKyyvIoHAhESxPRDW+6m+i43Oe3KG4xE7+O+ZvwlIbgWXSvv2RN2XiJS
         iJNuVg8uQOHxvO2Zv9zPKez2iqXWSSsd92nORyzwwPHVhqD+s5SX390AuW+ofLCyDC2K
         0UGIM6fZESmMNAvhn/KwYITZx8lEUWFwK2gCHfaANAA7MQ13iP4P+nKmKN8pnpOg1Jfj
         d9D9s3qlhPYVEAtI8Xu51J25P5jC+3Eta2f6/YC3ICVV+tj9IiFRL5hDyVBS43rVPwal
         X8e1yA0BokT3KhIjfWse8FW+oEAf5ci9fsWrR9EUg6c2QpUNVVpnAH8rCEE+YL19JfkX
         6aUQ==
X-Gm-Message-State: AOJu0Yz0taxTnF8VmjYDPd1GbdhtPGdyECNiNuunhZ8LjQb5afPL9csr
	GXIUFkAaqq+x43FOsSlTDa8Kpz5L0gIXzji7PP1S5srsHw7rDL8TrZ2dsej5prAOR59bvZPRkSy
	7B2Q=
X-Google-Smtp-Source: AGHT+IF+GdoNIlCWaZGEuXili2HvZC13WSHOvvyV/n7KOTQ50Cfwu8Xe9zTS6/OzDkf/KFHWwxT5UQ==
X-Received: by 2002:ae9:c105:0:b0:783:4dfb:11ae with SMTP id z5-20020ae9c105000000b007834dfb11aemr656396qki.63.1706741564109;
        Wed, 31 Jan 2024 14:52:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a0a4500b00783f5432f2esm3635438qka.54.2024.01.31.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:43 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 09/16] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <b13c9b8ff95e5cb7c2b4bd48590762215f6c2fb4.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

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
index 216cf03da1..b80bf36720 100644
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
index 2992079dd9..325c0b991a 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -19,7 +19,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 * possible.
 	 */
 	the_repository->settings.commit_graph_generation_version = 2;
-	the_repository->settings.commit_graph_read_changed_paths = 1;
+	the_repository->settings.commit_graph_changed_paths_version = 1;
 	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
diff --git a/repo-settings.c b/repo-settings.c
index 30cd478762..c821583fe5 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -23,6 +23,7 @@ void prepare_repo_settings(struct repository *r)
 	int value;
 	const char *strval;
 	int manyfiles;
+	int read_changed_paths;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -53,7 +54,10 @@ void prepare_repo_settings(struct repository *r)
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
index 7a250a6605..1edc4d4a67 100644
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
2.43.0.509.g253f65a7fc


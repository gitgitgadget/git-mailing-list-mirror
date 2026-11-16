Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834508;
	b=vWH4PzzXOMS+vENttENHheFMfEH1kuGE6QbIx99qfkhZUAWZZIIF5aPiGqTIF/H507WB
	 iLF7SoH2VlJoY4L2Yq+NrODktqCCiRkfQbPrgukk1oEYGVmoiFoAHiDCA/lnp6KNAyLqk
	 hq1DS+8k6OGJuSCw8LrOtpdselMjquGiCbbX3IwkIFeGN7XzyrSULN+jhdiS5oWpLdlLB
	 cko9IDUXAGuRn+l+q/MswhP+antqHr7HtOZZFzaYyQlj66Wfyy73u6lFPCxibvMAdomuv
	 9bDiXa2+9rze5SipiacMzSXawn3tYE53ZuYpms2qzmQMcBhGQw/t/Vdu9Fxdp1XTAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834508;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yny9wCRNM/3MabbrwIOHYwtDfCw96VrOlUTsh5jAdo0=;
	b=KeNZfsFKMx60eegJbsjMj+dD5Yce+KZdrTQks6/bPFHZXNl3aZYsNq5Uw7F0nC8CZ3FP
	 tnqD8GtoP1igqxY4eFM84OOmMD23CNRxEjbFMs5ZgK10NxrR+YZh5SWoG7qw1vPfKHc9R
	 HiuLxddN0xITiYH7q1+WVLjWzv9SmxEhuHmufNZfsRN3ru50+volW5wuYZbDmn0+UzJsO
	 3dXQ7zdaqndBZQLvIyIYf49Yd8OQBur0aQL3FqRPcRPdohfCF3bluObj4DNaKyOrnWzJs
	 DCAeJtGNwJNwDgPJ9DdqBl6lptJCPUspC44OgSBWC5e1lwyBrbauwZjzvEDQIxiCEYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=KLp17ULw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KTK7LG1B;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400E606A337
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7400E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=KLp17ULw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KTK7LG1B
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0D9B1400033
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 08:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834506;
	 x=1794920906; bh=yny9wCRNM/3MabbrwIOHYwtDfCw96VrOlUTsh5jAdo0=; b=
	KLp17ULw6vLoJWdA4x6OS0KV94WaQRkEftvmAfjDhRMUJsK4NtHBjRWItxs0+zyZ
	Z33fxhPeDmfcVDDBH0pGmenWRrzlTWz8oIY2GO7rgwhXT78wWAL25KQn99kA3dAE
	RbCAh617f7RSZu6CetfKJGnCYIDR/DcL4Ulrv0eggJ7oB5358UIRdaNaWj5AraXC
	5VsWuMo/0b2RWak8tSdLsYaWISMFag/WRYO0NWcWBYshITeqy0u9aAHtnfWXfmkF
	YK2rqpJ4KjhyUu8S/RrRFjSLirP97sDBG2SC/UgKwgtwn8xsptiHoIrJ1qiKf0O4
	ZMuk5q5Yrsr1BmSmZDvimQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834506; x=
	1794920906; bh=yny9wCRNM/3MabbrwIOHYwtDfCw96VrOlUTsh5jAdo0=; b=K
	TK7LG1BKKayPlXXnxiN1syF2XZJrpK5FzytUbtt0EFgSMM2SelE6D9ON3gQpgUmh
	BircN2vxwlHyyiMazMT4tciYBpoUA7qwdUIYuCPj6EjhkkTy8Eq7CzRHFZWoowPU
	F5ojpWgs63RQ/05jMYim/VpfA3/kDrIm9lMmqDTpBb/fRC3sNFynSC17VqUVJEvh
	bCLs9ZJfFl6+qnFZh85hR25H1FHKHkuQvrTrI+aR9NU9mH5lYUOymECSVPULek/r
	kUdr23wLNl0TLYCuXhobYsvI5oLLaA9ss2pBCsl2q66heq3CKMLP1TtPN0446ktQ
	o4IgtVzWvP5j/BahXx3Xg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834506; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:tKS3SmTU1BMVxa7nZhsGZ8OaC4toGHHmpTREcRpcRtCAgun
	zTmUkMK7cn38t359kMcAwKwKTPix5PM8rcRMJcf560qig0O7I83E9BnubNYO1c0O
	4ahckqhnGQuGOwkWU5e3g22wsN4XiW5YGscMDP7bf7Np0KqPKEaLuZz/tzC79UXr
	K3GFPt5AN5+kNXOoDlhme6uD0gNppWFvSJWQctBp5Bh2dwuKT5GSGJ+VGL6pj/fi
	KU0Cok0zp4i4r033I9DgHJdUG3NnJrMloe22O/ayXFo0L3XSxnGIa9B5iQwEzjK8
	uuL9FCzyKA0En07vpeSHSZYrWnQzcPP8pP5QvfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IUDOcaX2pZWI/PHmtIKQS2tEn6Fl5HvL9rvEp5SOmWo=:uBLyaQ/2RM4gG9cCti92zWTbBsk8OTN1xSt8lhKmbRQ=;
X-ME-Sender: <xms:SgD7alSQuZsVlFFkBTa8GETDQfHvbQ2-S2fCrhqOQy2l9QCuDpeoug>
    <xme:SgD7alsAvpGNZKkwq2x48eZ7BBjQvPWuXUjpxSRWu2Ox_dKBSt1L6BuZyYdKFACyo
    jjzIVUvhwqjabTqOPWsk1WFMIehJk9EL7_3Yj-KxG9nKIrGY6gXX7M>
X-ME-Received: <xmr:SgD7agdUPnwBbaWTq3LKob03Ii-F5YLQzR1_ljIVOShuD_RecsFqZzzz1F7bLVhIo7MwV8A>
X-ME-Proxy-Cause: dmFkZTGDOts0vqr0aKWRUcnFWX2Osp5gN2qQrQiKgx0G0z61tex3Qx3J3ESCLCinpI8hSw
    2vG99o74wMnSZAo8wtYDZxyA6R847A8ASdn/5QNWTHI5e2QOa//69E5yGYEz5FUfZlQN/T
    B8T5MGqMJ5GFcrN7pcqdJEIpt/p3h0CIJYP5pL1qBGNcUr/aJvm0pYpP+SfCAZpZsoHW/H
    KZa5v/u5xJwPsub/sAKsamEJY1eYIEiu4PU1c5BTotBJm2q3EHg6U00bQhjV0POO0UoRG5
    48JtVfk4AQ7VQz9bbR1I6l9T+zTjGPZj+oHdBcbJmt/Yhab4GreLMl630Z7MgXho2swEeQ
    wRDOJl4UwqYuNbdimczJ5ZPIS0g22DRDPh4tXtbW2rkOmwgvxEFOAlx26NDfuPBChH7Fel
    wzJpYRSmUOVA/5fviGEje2xHuCE+QY+RG74xKa0ZtIh2EWNMnhErRhdUTm6HQYfTOEo2CO
    yDGoi7YuNQQpLa4EZVIXTfknnJfzL30Qp9dGZxrJC2MevR4DCutQONCpEEum08hnHiRTK5
    yBIUAb7APDI6whWEgXGaQ222aUIN/8/waBPlPxTec1plRVe6YW7CiU5StskYbQaURO9gCb
    rB2OK/Koeav4ibTmvdauD9aP3fONzk/JjyuLq6YsQPyqK3jFvXNOd6ZowHXw
X-ME-Proxy: <xmx:SgD7aiKS8daRhr4mXOy8FiaMUksKJ3EREI5Org45_HUGdO5_GhqgBg>
    <xmx:SgD7aua5omLsvlTswgSTaW-n3etEs9-iLCXxzaFDXaVeCg6k1pYcVw>
    <xmx:SgD7atu3AMgOiaEVHUaRyR77jYyN51M4DVc52Sz6tdurO5pQwOuXCw>
    <xmx:SgD7arsTYETqh0dkfowODR6zUt6fJj5YLkBzGV2J0aC4NLYyCoT0Gg>
    <xmx:SgD7ahSu1s9WGZ5haB1ym4FklBjryJoPhTJdjql-RZUzYhop1SmtlWJt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a198dd8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:48 +0100
Subject: [PATCH 12/12] odb/source-files: internalize logic to derive commit
 graph paths
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-12-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commit we have moved the logic to derive commit graph
paths into the "files" backend. We couldn't yet make the logic private
to the backend though because we still use it when we verify commit
graphs.

Refactor the code and expose two new functions that are specific to the
"files" backend to read and write a commit graph into a specific object
directory. These functions are only for use for existing callers in
git-commit-graph(1), so adapt that one caller to use those functions.

This converts the last caller outside of the "files" backend to stop
caring about exact commit graph paths anymore. Drop the declarations for
functions that derive such paths and make them private.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  57 +++++++-----------
 commit-graph.h         |  21 -------
 odb/source-files.c     | 157 ++++++++++++++++++++++++++++---------------------
 odb/source-files.h     |  12 ++++
 4 files changed, 123 insertions(+), 124 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 6ee644d8487..d9d3cdd335a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -59,13 +59,7 @@ static int cmd_commit_graph_verify(int argc,
 {
 	struct opts_commit_graph opts = { 0 };
 	struct commit_graph *graph = NULL;
-	struct odb_files_dir *dir = NULL;
-	char *graph_name;
-	char *chain_name;
-	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
 	enum commit_graph_verify_flags flags = isatty(2) ? COMMIT_GRAPH_VERIFY_PROGRESS : 0;
-	int fd;
-	struct stat st;
 	int ret;
 	struct option options[] = {
 		OPT_BIT(0, "shallow", &flags,
@@ -85,37 +79,27 @@ static int cmd_commit_graph_verify(int argc,
 	if (argc)
 		usage_with_options(builtin_commit_graph_verify_usage, options);
 
-	if (!opts.obj_dir)
-		opts.obj_dir = repo_get_object_directory(repo);
-
-	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
-	if (!dir)
-		die(_("could not find object directory matching %s"), opts.obj_dir);
-
-	graph_name = get_commit_graph_filename(dir->abspath);
-	chain_name = get_commit_graph_chain_filename(dir->abspath);
-	if (open_commit_graph(graph_name, &fd, &st))
-		opened = OPENED_GRAPH;
-	else if (errno != ENOENT)
-		die_errno(_("Could not open commit-graph '%s'"), graph_name);
-	else if (open_commit_graph_chain(chain_name, &fd, &st,
-					 repo->hash_algo))
-		opened = OPENED_CHAIN;
-	else if (errno != ENOENT)
-		die_errno(_("could not open commit-graph chain '%s'"), chain_name);
-
-	FREE_AND_NULL(graph_name);
-	FREE_AND_NULL(chain_name);
-
-	if (opened == OPENED_NONE)
-		return 0;
-	else if (opened == OPENED_GRAPH)
-		graph = commit_graph_read(repo, fd, &st);
-	else
-		graph = load_commit_graph_chain_fd_st(repo->objects, fd, &st);
+	if (repo->objects->source->type == ODB_SOURCE_FILES) {
+		struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
+		struct odb_files_dir *dir = files->dirs;
+
+		if (opts.obj_dir) {
+			dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
+			if (!dir)
+				die(_("could not find object directory matching %s"), opts.obj_dir);
+		}
 
-	if (!graph)
+		ret = odb_source_files_read_commit_graph_dir(files, dir, &graph);
+	} else {
+		if (opts.obj_dir)
+			die(_("--object-dir= is not supported with %s backend"),
+			    odb_source_type_to_name(repo->objects->source->type));
+		ret = odb_source_read_commit_graph(repo->objects->source, &graph);
+	}
+	if (ret < 0)
 		return 1;
+	if (ret > 0)
+		return 0;
 
 	ret = commit_graph_verify(graph, flags);
 
@@ -328,7 +312,8 @@ static int cmd_commit_graph_write(int argc,
 	}
 
 	if (dir) {
-		if (commit_graph_write(repo, dir->abspath, &write_opts))
+		struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
+		if (odb_source_files_write_commit_graph_dir(files, dir, &write_opts))
 			result = 1;
 	} else {
 		if (odb_write_commit_graph(repo->objects, &write_opts))
diff --git a/commit-graph.h b/commit-graph.h
index 3295498fd34..a84227c7a6d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -29,12 +29,7 @@ struct repository;
 struct object_database;
 struct string_list;
 
-char *get_commit_graph_filename(const char *dir);
-char *get_commit_graph_chain_filename(const char *dir);
 struct commit_graph *prepare_commit_graph(struct repository *r);
-int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
-int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st,
-			    const struct git_hash_algo *hash_algo);
 
 /*
  * Given a commit struct, try to fill the commit struct info, including:
@@ -124,8 +119,6 @@ struct commit_graph {
  */
 struct commit_graph *commit_graph_read(struct repository *repo,
 				       int fd, struct stat *st);
-struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
-						   int fd, struct stat *st);
 
 /*
  * Link the commit graph layer `g` on top of the chain `base`. `base` may be
@@ -226,20 +219,6 @@ int commit_graph_write_layer(struct repository *r,
 			     struct commit_graph **base,
 			     unsigned char *hash);
 
-/*
- * The commit_graph_write* methods return zero on success
- * and a negative value on failure. Note that if the repository
- * is not compatible with the commit-graph feature, then the
- * methods will return 0 without writing a commit-graph.
- *
- * The object directory `dir` may be given as a relative path; it is
- * canonicalized internally so that it compares equal to the directory of
- * graphs that have already been loaded.
- */
-int commit_graph_write(struct repository *r,
-		       const char *dir,
-		       const struct commit_graph_write_options *opts);
-
 enum commit_graph_verify_flags {
 	COMMIT_GRAPH_VERIFY_SHALLOW = (1 << 0),
 	COMMIT_GRAPH_VERIFY_PROGRESS = (1 << 1),
diff --git a/odb/source-files.c b/odb/source-files.c
index 90cda52b48b..16d331e4f28 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1231,7 +1231,7 @@ static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
 	return 0;
 }
 
-char *get_commit_graph_filename(const char *dir)
+static char *get_commit_graph_filename(const char *dir)
 {
 	return xstrfmt("%s/info/commit-graph", dir);
 }
@@ -1243,12 +1243,12 @@ static char *get_split_graph_filename(const char *dir,
 		       oid_hex);
 }
 
-char *get_commit_graph_chain_filename(const char *dir)
+static char *get_commit_graph_chain_filename(const char *dir)
 {
 	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", dir);
 }
 
-int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
+static int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 {
 	*fd = git_open(graph_file);
 	if (*fd < 0)
@@ -1260,40 +1260,45 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-static struct commit_graph *load_commit_graph_one(struct repository *repo,
-						  const char *dir,
-						  const char *graph_file)
+static int load_commit_graph_one(struct repository *repo,
+				 const char *dir,
+				 const char *graph_file,
+				 struct commit_graph **out)
 {
 	struct stat st;
 	int fd;
 	struct commit_graph *g;
-	int open_ok = open_commit_graph(graph_file, &fd, &st);
 
-	if (!open_ok)
-		return NULL;
+	if (!open_commit_graph(graph_file, &fd, &st)) {
+		if (errno == ENOENT)
+			return 1;
+		return error_errno(_("Could not open commit-graph '%s'"),
+				   graph_file);
+	}
 
 	g = commit_graph_read(repo, fd, &st);
-	if (g) {
-		g->dir = absolute_pathdup(dir);
-		g->filename = absolute_pathdup(graph_file);
-	}
+	if (!g)
+		return -1;
 
-	return g;
+	g->dir = absolute_pathdup(dir);
+	g->filename = absolute_pathdup(graph_file);
+	*out = g;
+	return 0;
 }
 
-static struct commit_graph *load_commit_graph_v1(struct repository *repo,
-						 const char *dir)
+static int load_commit_graph_v1(struct repository *repo,
+				const char *dir,
+				struct commit_graph **out)
 {
 	char *graph_name = get_commit_graph_filename(dir);
-	struct commit_graph *g = load_commit_graph_one(repo, dir, graph_name);
+	int ret = load_commit_graph_one(repo, dir, graph_name, out);
 	free(graph_name);
-
-	return g;
+	return ret;
 }
 
-int open_commit_graph_chain(const char *chain_file,
-			    int *fd, struct stat *st,
-			    const struct git_hash_algo *hash_algo)
+static int open_commit_graph_chain(const char *chain_file,
+				   int *fd, struct stat *st,
+				   const struct git_hash_algo *hash_algo)
 {
 	*fd = git_open(chain_file);
 	if (*fd < 0)
@@ -1316,8 +1321,8 @@ int open_commit_graph_chain(const char *chain_file,
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
-						   int fd, struct stat *st)
+static struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
+							  int fd, struct stat *st)
 {
 	struct commit_graph *graph_chain = NULL;
 	struct strbuf line = STRBUF_INIT;
@@ -1345,20 +1350,25 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 		files = odb_source_files_downcast(odb->source);
 		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 			char *graph_name = get_split_graph_filename(dir->abspath, line.buf);
-			struct commit_graph *g = load_commit_graph_one(odb->repo, dir->abspath, graph_name);
+			struct commit_graph *g = NULL;
+			int ret;
 
+			ret = load_commit_graph_one(odb->repo, dir->abspath, graph_name, &g);
 			free(graph_name);
 
-			if (g) {
-				if (!commit_graph_link_base(g, graph_chain)) {
-					graph_chain = g;
-					valid = 1;
-				} else {
-					commit_graph_free(g);
-				}
-
+			if (ret > 0)
+				continue;
+			if (ret < 0)
 				break;
+
+			if (!commit_graph_link_base(g, graph_chain)) {
+				graph_chain = g;
+				valid = 1;
+			} else {
+				commit_graph_free(g);
 			}
+
+			break;
 		}
 
 		if (!valid) {
@@ -1377,49 +1387,64 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 	return graph_chain;
 }
 
-static struct commit_graph *load_commit_graph_chain(struct repository *repo,
-						    const char *dir)
+static int load_commit_graph_chain(struct repository *repo,
+				   const char *dir,
+				   struct commit_graph **out)
 {
 	char *chain_file = get_commit_graph_chain_filename(dir);
 	struct stat st;
 	int fd;
-	struct commit_graph *g = NULL;
+	int ret;
 
-	if (open_commit_graph_chain(chain_file, &fd, &st, repo->hash_algo)) {
-		/* ownership of fd is taken over by load function */
-		g = load_commit_graph_chain_fd_st(repo->objects, fd, &st);
+	if (!open_commit_graph_chain(chain_file, &fd, &st, repo->hash_algo)) {
+		if (errno == ENOENT)
+			ret = 1;
+		else
+			ret = error_errno(_("could not open commit-graph chain '%s'"),
+					  chain_file);
+		goto out;
 	}
 
+	/* ownership of fd is taken over by load function */
+	*out = load_commit_graph_chain_fd_st(repo->objects, fd, &st);
+	ret = *out ? 0 : -1;
+
+out:
 	free(chain_file);
-	return g;
+	return ret;
 }
 
-static struct commit_graph *read_commit_graph_one(struct repository *repo,
-						  const char *dir)
+int odb_source_files_read_commit_graph_dir(struct odb_source_files *files,
+					   struct odb_files_dir *dir,
+					   struct commit_graph **out)
 {
-	struct commit_graph *g = load_commit_graph_v1(repo, dir);
+	struct repository *repo = files->base.odb->repo;
+	int ret;
 
-	if (!g)
-		g = load_commit_graph_chain(repo, dir);
+	ret = load_commit_graph_v1(repo, dir->abspath, out);
+	if (ret > 0)
+		ret = load_commit_graph_chain(repo, dir->abspath, out);
 
-	return g;
+	return ret;
 }
 
 static int odb_source_files_read_commit_graph(struct odb_source *source,
 					      struct commit_graph **out)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	bool error = false;
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		struct commit_graph *g = read_commit_graph_one(files->base.odb->repo,
-							       dir->abspath);
-		if (!g)
+		int ret = odb_source_files_read_commit_graph_dir(files, dir, out);
+		if (ret) {
+			if (ret < 0)
+				error = true;
 			continue;
-		*out = g;
+		}
 		return 0;
 	}
 
-	return 1;
+	return error ? -1 : 1;
 }
 
 static void mark_commit_graphs(struct commit_graph *tip,
@@ -1482,17 +1507,18 @@ static void expire_commit_graphs(const char *dirpath,
 	strbuf_release(&path);
 }
 
-int commit_graph_write(struct repository *r,
-		       const char *dir,
-		       const struct commit_graph_write_options *opts)
+int odb_source_files_write_commit_graph_dir(struct odb_source_files *files,
+					    struct odb_files_dir *dir,
+					    const struct commit_graph_write_options *opts)
 {
+	struct repository *r = files->base.odb->repo;
 	struct string_list chain_hashes = STRING_LIST_INIT_DUP;
 	struct string_list kept = STRING_LIST_INIT_DUP;
 	struct tempfile *graph_layer = NULL;
 	struct lock_file lk = LOCK_INIT;
 	struct commit_graph *g, *chain, *base = NULL;
 	char *base_rename_from = NULL, *base_rename_to = NULL;
-	char *graph_name = NULL, *abs_dir = NULL, *new_path = NULL;
+	char *graph_name = NULL, *new_path = NULL;
 	size_t mergeable_layers = 0, chainable_layers = 0;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	bool mergeable = true;
@@ -1503,8 +1529,6 @@ int commit_graph_write(struct repository *r,
 	if (!commit_graph_write_allowed(r))
 		return 0;
 
-	abs_dir = absolute_pathdup(dir);
-
 	g = prepare_commit_graph(r);
 
 	/*
@@ -1520,7 +1544,7 @@ int commit_graph_write(struct repository *r,
 	for (struct commit_graph *layer = g; layer; layer = layer->base_graph) {
 		char *path = get_commit_graph_filename(layer->dir);
 		bool is_split = !!strcmp(layer->filename, path);
-		bool is_local = !strcmp(layer->dir, abs_dir);
+		bool is_local = !strcmp(layer->dir, dir->abspath);
 
 		free(path);
 
@@ -1535,9 +1559,9 @@ int commit_graph_write(struct repository *r,
 	}
 
 	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		graph_name = xstrfmt("%s/info/commit-graphs/tmp_graph_XXXXXX", abs_dir);
+		graph_name = xstrfmt("%s/info/commit-graphs/tmp_graph_XXXXXX", dir->abspath);
 	} else {
-		graph_name = get_commit_graph_filename(abs_dir);
+		graph_name = get_commit_graph_filename(dir->abspath);
 	}
 
 	if (safe_create_leading_directories(r, graph_name)) {
@@ -1547,7 +1571,7 @@ int commit_graph_write(struct repository *r,
 	}
 
 	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		char *chain_name = get_commit_graph_chain_filename(abs_dir);
+		char *chain_name = get_commit_graph_chain_filename(dir->abspath);
 
 		repo_hold_lock_file_for_update_mode(r, &lk, chain_name,
 						    LOCK_DIE_ON_ERROR, 0444);
@@ -1586,7 +1610,7 @@ int commit_graph_write(struct repository *r,
 	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		const char *new_hash = hash_to_hex_algop(hash, r->hash_algo);
 
-		new_path = get_split_graph_filename(abs_dir, new_hash);
+		new_path = get_split_graph_filename(dir->abspath, new_hash);
 
 		string_list_append(&chain_hashes, new_hash);
 		for (chain = base; chain; chain = chain->base_graph)
@@ -1632,7 +1656,7 @@ int commit_graph_write(struct repository *r,
 				goto out;
 			}
 		} else if (!base) {
-			char *graph_name = get_commit_graph_filename(abs_dir);
+			char *graph_name = get_commit_graph_filename(dir->abspath);
 			unlink(graph_name);
 			free(graph_name);
 		}
@@ -1653,12 +1677,12 @@ int commit_graph_write(struct repository *r,
 	commit_lock_file(&lk);
 
 	if (!(opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
-		char *chain_name = get_commit_graph_chain_filename(abs_dir);
+		char *chain_name = get_commit_graph_chain_filename(dir->abspath);
 		unlink(chain_name);
 		free(chain_name);
 	}
 
-	expire_commit_graphs(abs_dir, &kept,
+	expire_commit_graphs(dir->abspath, &kept,
 			     opts->expire_time ? opts->expire_time : (timestamp_t) time(NULL));
 
 	ret = 0;
@@ -1672,7 +1696,6 @@ int commit_graph_write(struct repository *r,
 	free(base_rename_to);
 	free(graph_name);
 	free(new_path);
-	free(abs_dir);
 	return ret;
 }
 
@@ -1680,7 +1703,7 @@ static int odb_source_files_write_commit_graph(struct odb_source *source,
 					       const struct commit_graph_write_options *opts)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	return commit_graph_write(source->odb->repo, files->dirs->abspath, opts);
+	return odb_source_files_write_commit_graph_dir(files, files->dirs, opts);
 }
 
 static int fsck_commit_graph(struct odb_source_files *files,
diff --git a/odb/source-files.h b/odb/source-files.h
index f779e67a1db..71ccacd8d90 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -106,4 +106,16 @@ static inline struct odb_source_files *odb_source_files_downcast(struct odb_sour
  */
 struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Read and write a commit graph via a specific object directory. These
+ * functions should not be used, but we have to provide this ability to support
+ * the "--object-dir=" option for git-commit-graph(1).
+ */
+int odb_source_files_read_commit_graph_dir(struct odb_source_files *files,
+					   struct odb_files_dir *dir,
+					   struct commit_graph **out);
+int odb_source_files_write_commit_graph_dir(struct odb_source_files *files,
+					    struct odb_files_dir *dir,
+					    const struct commit_graph_write_options *opts);
+
 #endif

-- 
2.56.1.763.g16177fe143.dirty


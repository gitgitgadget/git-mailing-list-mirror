Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834505;
	b=Oly5lGbwfM4UuaB2tXZHND5nTw7Tcsj234SWHzC2NXBoHw4Zc6u/ivFT08KrlAHWQYw6
	 NIq/tnonVkVwQpl3SWAIviAPSLhW3H6amUt1rJpq1YfiAIb969tpub1C0mD577U58e0Zt
	 OLfI72o/jr9Vuo8xHjCf03ucaUdwaW/Za95EsFL/cgVF7BjFmLcniI1tPYNcXCI2rx7VF
	 YCM3FZD1679fh5rfB6VipaLUoGIQ4x+9THdbWvrzXXMhLaWfJjZ1orTlftr0NIqqlR0H1
	 W8dhphmloIxvpmV/xf9pMS9BmF4rO3jplmVVq4ZdD3hzCNOrBnxNb6r6aDeoejz4nuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834505;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=z5yu6L/mpwhC1WHdTTW+L1eLGezOyvomJ4A+LufJBpM=;
	b=drSUXMjf8k/3RAlFFDrrycsW49yurGwuz/w757OQCcNajyhaHK6/9lV8/xGNh82k/XcF
	 LqQFTOTqP2fEZPeOLZbh9UIWgdJ3/b52G3GJBecLfYZuAm5M/S8zOVne40EuMYUByzUOa
	 9qsrOIVNufVm+Yg20+FSSFASuPzlaLicva5JKUK4GwbJJqVluE2P84BpZtVJdQQY8+2ax
	 ODxQFduPw7n36zwKCnDNqcQ6A3Ug3L2D4N/8aR8nS120ZiPUzMO+Eie2w1qJZMrbavart
	 v2KYwVBGlbZFlDaJGx6RkplO1Rlosb0tBrgcr9+AA7btcyOtUQQ0qV1EokfTu3oYsYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CDVudABt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="52Qf/jKw";
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA65606A897
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA65606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CDVudABt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=52Qf/jKw
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F341DEC01D0
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 08:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834503;
	 x=1794920903; bh=z5yu6L/mpwhC1WHdTTW+L1eLGezOyvomJ4A+LufJBpM=; b=
	CDVudABtaQQsKZdLQBHYkznHEN6o6GRGQKIZ4toGd13jQLh+akeVINuYJCz2ePYZ
	QOZerQQPtxHdKR3P4LZRg6V/mw98XWHXe5iqs66iX3rSPqH9goiw6Iw2UOsC5I8b
	WnDx7dKyg0vCERwD0FlaN7iY/IpIcQNFlUOrndosLxgI/ic8D4Fr6eK4Tju0zMye
	tUp2AIK5kuEoscnJnFhJsXdTXv447W4aLs8k4cLppJqQ9F7DQtoTOcv6uA3RU4aT
	YwJdJRvyLHc4ID4ZV58td5vGDeXuksyMr81XjKmOVTUVtHPQ+i7bWXrKCMxVcBv3
	DFu+8lxHzyfMkz9JoHobAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834503; x=
	1794920903; bh=z5yu6L/mpwhC1WHdTTW+L1eLGezOyvomJ4A+LufJBpM=; b=5
	2Qf/jKwoFQJsVFOh/FTee3hhxC/KoYNpVycsCNJZtfAGXmgERmzK0Cj5jhV/xID/
	+jpI8g9nlvz8GFjAQu66CpALEBqXeWZn/Cs7S4Trd5wj7H8YBlbsK5D6YjkIberx
	UlrCbxcvd+qTxliKsegcMrv0Qr7x/HUIJIPpEKQ3xfS2Qztn+T9mqaO0KGAKGIzX
	VtAzsg3XD8/OIX6oE0jcuOfo/eWbjYBfMlCgFv+FlxygJBRhwKHR+WVKvupXHqRb
	icr23lDauEY3pIGKQXWyMz7n4QcYXcxDs34XgxnM13oFPITZkwEThYqRJL/A9tDE
	DRnLW1vcArJVaRXJSSkbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834503; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xlIvvHjcZW6i2XtjvscjlgaRTrobr8GdGNsw9eisJ4l6+wB
	lG9OczQw8yLfBNN+7OTVpHTA+e6J3MDJB4Oeont3YxO8t5SfbufZQAWrIFl3eO4M
	/WzoKe4GtQMhI3znAG+1x6djqWAna/pyvD7A/YAEOPgxyncwNU0FqEwqpp2ewJbl
	rXJ0+hjBCEy9rB8S8my5k+c3mSbSGqdx4KLYw9lUgmGMLzys2XL4YuBI00DLnLsn
	5vg/KWizjKp/W10s5QtlqPFt2vMpRls/vzWbI6LBMBVCaPzPPsDydEFJOwutGGgG
	D9Hp5J+hCp3S8/Zm18zkh5bMDE6R+4XxQqfHV3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fhr8AvTEjOTjqOLJZ6X22A/yXwpUGWU4yac4YBYKJhM=:Mi05fY7OCZdUSgLSlt0GyuJubGUWqpfAuD1ZrLgFyF8=;
X-ME-Sender: <xms:RwD7amhalaVeo1gy-1uwGukyPJs__-j6h2DF8uIclyxYe0oA30bhHw>
    <xme:RwD7at8CUd4TBvbT8rYAyvZr5ekV544swGT6d5B4SFsOjfIL9YkcPh-htXyxSTHxl
    pCH8jtM2fO7JoVxxOFU1XVrlVXL1Yy_-BDLVWinsznuMZb110s80Is>
X-ME-Received: <xmr:RwD7ajv-yPRDCr0Dcv6UEdjvjfTbFYO1fWOKR3lv99dKWQZDRSqj48PsdaWrmaQk_a6OJJI>
X-ME-Proxy-Cause: dmFkZTGQuWxQKzpljbCNLfDiP2FT3Kjhltbnabz27ajjc5yOwEpHZp3ywk5NULox4giTJd
    6RAO2IwfZoot3urzZUc270PeFFSAZJTRD01wWA/7NIfSYCO/+3OEZUSF1C4MOZLJ+6P6oN
    cutBtXa+w8Fb0ULotdjxXfQKh3V+usQPY9IHaqJWrx0diSSBCaM8mj9CDXWG97EOTPZ11T
    3mDIeCKD9hiuZrmnAjEBnoPVjmA7fS1IealA/NQwgJc+ltnKys/2EV/F12XivZ8FxNrarn
    612Cd6o5wsYVTIQ1rX3ly4oLcCMQ77JmIAZfP1Woym9ZxrAwfYDJeEWX1slpARwibMZ5NY
    yx+WbChe4V9MIpCdIUf125+9kVc/txZG0javxq0azO3ofZIQdhTa9Y+Je7WCBbj3FFfHhI
    aLvgM0lB1jDen64WY0AqSJfpURCdsNSTplnstC0UvgDz8yMREadrKpsPDzQnjQe7ZUXTHu
    5rpDoeokaCcKPElPBgo/vW0GPk8lwTaYlGZrt8x9Vu0AP5zTbyhdaey9LNdGXiTWiJq+hF
    c3DALvLzAMYjTiX7ywZg8F32W22MIXAJZy4jYZtPa07OX71TF6rrVhoMmhBnWQ4fvg1J7l
    E+P3hBWfA/SUgshcvEcXugCLZ5N7KDKFJwaacji+skTYKgISUb949YaH/wMg
X-ME-Proxy: <xmx:RwD7akbC1r4RomYiQiEQxrUt8N1-uJ2a2SIyxOXzurY_U_ZG9xDYRw>
    <xmx:RwD7ajqRqKFgyhumFrVd53JiAbxOvSPIRr8DJ1vq-YGHNakvYoqlvg>
    <xmx:RwD7ap_eYjYLgDVL_fCW-dL-FwskmqEqXs4owOKq63j4NOMR_KXYmQ>
    <xmx:RwD7ai-trieBmiu90OsUJDFpbf39yCQMA8JVtrt_Us1gN3br3RGexw>
    <xmx:RwD7ajgvuMtrke5oLGKTekSKn-MP17jok_Mfz4s2wcxCa7nJxJouUedg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dad05e09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:47 +0100
Subject: [PATCH 11/12] odb/source-files: move logic to derive commit graph
 paths
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-11-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move the logic that derives commit graph paths from the generic
commit-graph subsystem into the "files" backend.

This is mostly an exact move, and we still carry declarations in
"commit-graph.h", so that it becomes trivial to see that nothing else
has changed. The only exception are three sites where we now generate
warnings because of -Wsign-compare.

The next commit will refactor moved code so that we can drop those
declarations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c     | 437 -----------------------------------------------------
 commit-graph.h     |   2 -
 odb/source-files.c | 428 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 428 insertions(+), 439 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7fea94689a1..8daadf56e88 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,13 +1,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "abspath.h"
 #include "config.h"
 #include "csum-file.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "lockfile.h"
 #include "packfile.h"
 #include "commit.h"
 #include "object.h"
@@ -25,7 +23,6 @@
 #include "bloom.h"
 #include "commit-slab.h"
 #include "shallow.h"
-#include "string-list.h"
 #include "json-writer.h"
 #include "trace2.h"
 #include "tree.h"
@@ -201,23 +198,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-char *get_commit_graph_filename(const char *dir)
-{
-	return xstrfmt("%s/info/commit-graph", dir);
-}
-
-static char *get_split_graph_filename(const char *dir,
-				      const char *oid_hex)
-{
-	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", dir,
-		       oid_hex);
-}
-
-char *get_commit_graph_chain_filename(const char *dir)
-{
-	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", dir);
-}
-
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xcalloc(1, sizeof(*g));
@@ -246,18 +226,6 @@ static int commit_graph_compatible(struct repository *r)
 	return 1;
 }
 
-int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
-{
-	*fd = git_open(graph_file);
-	if (*fd < 0)
-		return 0;
-	if (fstat(*fd, st)) {
-		close(*fd);
-		return 0;
-	}
-	return 1;
-}
-
 struct commit_graph *commit_graph_read(struct repository *repo,
 				       int fd, struct stat *st)
 {
@@ -494,37 +462,6 @@ struct commit_graph *commit_graph_parse(struct repository *r,
 	return NULL;
 }
 
-static struct commit_graph *load_commit_graph_one(struct repository *repo,
-						  const char *dir,
-						  const char *graph_file)
-{
-	struct stat st;
-	int fd;
-	struct commit_graph *g;
-	int open_ok = open_commit_graph(graph_file, &fd, &st);
-
-	if (!open_ok)
-		return NULL;
-
-	g = commit_graph_read(repo, fd, &st);
-	if (g) {
-		g->dir = absolute_pathdup(dir);
-		g->filename = absolute_pathdup(graph_file);
-	}
-
-	return g;
-}
-
-static struct commit_graph *load_commit_graph_v1(struct repository *repo,
-						 const char *dir)
-{
-	char *graph_name = get_commit_graph_filename(dir);
-	struct commit_graph *g = load_commit_graph_one(repo, dir, graph_name);
-	free(graph_name);
-
-	return g;
-}
-
 /*
  * returns 1 if and only if all graphs in the chain have
  * corrected commit dates stored in the generation_data chunk.
@@ -625,120 +562,6 @@ int commit_graph_link_base(struct commit_graph *g,
 	return 0;
 }
 
-int open_commit_graph_chain(const char *chain_file,
-			    int *fd, struct stat *st,
-			    const struct git_hash_algo *hash_algo)
-{
-	*fd = git_open(chain_file);
-	if (*fd < 0)
-		return 0;
-	if (fstat(*fd, st)) {
-		close(*fd);
-		return 0;
-	}
-	if (st->st_size < hash_algo->hexsz) {
-		close(*fd);
-		if (!st->st_size) {
-			/* treat empty files the same as missing */
-			errno = ENOENT;
-		} else {
-			warning(_("commit-graph chain file too small"));
-			errno = EINVAL;
-		}
-		return 0;
-	}
-	return 1;
-}
-
-struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
-						   int fd, struct stat *st)
-{
-	struct commit_graph *graph_chain = NULL;
-	struct strbuf line = STRBUF_INIT;
-	int i = 0, valid = 1, count;
-	FILE *fp = xfdopen(fd, "r");
-
-	count = st->st_size / (odb->repo->hash_algo->hexsz + 1);
-
-	for (i = 0; i < count; i++) {
-		struct odb_source_files *files;
-		struct object_id oid;
-
-		if (strbuf_getline_lf(&line, fp) == EOF)
-			break;
-
-		if (get_oid_hex_algop(line.buf, &oid, odb->repo->hash_algo)) {
-			warning(_("invalid commit-graph chain: line '%s' not a hash"),
-				line.buf);
-			valid = 0;
-			break;
-		}
-
-		valid = 0;
-
-		files = odb_source_files_downcast(odb->source);
-		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-			char *graph_name = get_split_graph_filename(dir->abspath, line.buf);
-			struct commit_graph *g = load_commit_graph_one(odb->repo, dir->abspath, graph_name);
-
-			free(graph_name);
-
-			if (g) {
-				if (!commit_graph_link_base(g, graph_chain)) {
-					graph_chain = g;
-					valid = 1;
-				} else {
-					commit_graph_free(g);
-				}
-
-				break;
-			}
-		}
-
-		if (!valid) {
-			warning(_("unable to find all commit-graph files"));
-			break;
-		}
-	}
-
-	commit_graph_validate_chain(graph_chain);
-	if (graph_chain)
-		graph_chain->incomplete = !valid;
-
-	fclose(fp);
-	strbuf_release(&line);
-
-	return graph_chain;
-}
-
-static struct commit_graph *load_commit_graph_chain(struct repository *repo,
-						    const char *dir)
-{
-	char *chain_file = get_commit_graph_chain_filename(dir);
-	struct stat st;
-	int fd;
-	struct commit_graph *g = NULL;
-
-	if (open_commit_graph_chain(chain_file, &fd, &st, repo->hash_algo)) {
-		/* ownership of fd is taken over by load function */
-		g = load_commit_graph_chain_fd_st(repo->objects, fd, &st);
-	}
-
-	free(chain_file);
-	return g;
-}
-
-struct commit_graph *read_commit_graph_one(struct repository *repo,
-					   const char *dir)
-{
-	struct commit_graph *g = load_commit_graph_v1(repo, dir);
-
-	if (!g)
-		g = load_commit_graph_chain(repo, dir);
-
-	return g;
-}
-
 /*
  * Return 1 if commit_graph is non-NULL, and 0 otherwise.
  *
@@ -2078,12 +1901,6 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
-static void mark_commit_graphs(struct commit_graph *tip,
-			       struct commit_graph *base);
-static void expire_commit_graphs(const char *dirpath,
-				 struct string_list *kept,
-				 timestamp_t expire_time);
-
 static int write_commit_graph_file(struct write_commit_graph_context *ctx,
 				   int fd, const char *path,
 				   unsigned char *file_hash)
@@ -2160,200 +1977,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx,
 	return 0;
 }
 
-int commit_graph_write(struct repository *r,
-		       const char *dir,
-		       const struct commit_graph_write_options *opts)
-{
-	struct string_list chain_hashes = STRING_LIST_INIT_DUP;
-	struct string_list kept = STRING_LIST_INIT_DUP;
-	struct tempfile *graph_layer = NULL;
-	struct lock_file lk = LOCK_INIT;
-	struct commit_graph *g, *chain, *base = NULL;
-	char *base_rename_from = NULL, *base_rename_to = NULL;
-	char *graph_name = NULL, *abs_dir = NULL, *new_path = NULL;
-	size_t mergeable_layers = 0, chainable_layers = 0;
-	unsigned char hash[GIT_MAX_RAWSZ];
-	bool mergeable = true;
-	const char *out_path;
-	int out_fd;
-	int ret;
-
-	if (!commit_graph_write_allowed(r))
-		return 0;
-
-	abs_dir = absolute_pathdup(dir);
-
-	g = prepare_commit_graph(r);
-
-	/*
-	 * We only consider merging layers that belong to our own object
-	 * directory. Furthermore, we can only chain on top of either:
-	 *
-	 *   - A split commit graph layer, regardless of whether or not it is
-	 *     local.
-	 *
-	 *   - A local non-split commit graph, in which case we'll convert that
-	 *     layer into a split commit graph layer.
-	 */
-	for (struct commit_graph *layer = g; layer; layer = layer->base_graph) {
-		char *path = get_commit_graph_filename(layer->dir);
-		bool is_split = !!strcmp(layer->filename, path);
-		bool is_local = !strcmp(layer->dir, abs_dir);
-
-		free(path);
-
-		if (!is_local && !is_split)
-			break;
-		if (!is_local)
-			mergeable = false;
-
-		if (mergeable)
-			mergeable_layers++;
-		chainable_layers++;
-	}
-
-	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		graph_name = xstrfmt("%s/info/commit-graphs/tmp_graph_XXXXXX", abs_dir);
-	} else {
-		graph_name = get_commit_graph_filename(abs_dir);
-	}
-
-	if (safe_create_leading_directories(r, graph_name)) {
-		ret = error(_("unable to create leading directories of %s"),
-			    graph_name);
-		goto out;
-	}
-
-	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		char *chain_name = get_commit_graph_chain_filename(abs_dir);
-
-		repo_hold_lock_file_for_update_mode(r, &lk, chain_name,
-						    LOCK_DIE_ON_ERROR, 0444);
-		free(chain_name);
-
-		graph_layer = mks_tempfile_m(graph_name, 0444);
-		if (!graph_layer) {
-			ret = error(_("unable to create temporary graph layer"));
-			goto out;
-		}
-
-		if (adjust_shared_perm(r, get_tempfile_path(graph_layer))) {
-			ret = error(_("unable to adjust shared permissions for '%s'"),
-				    get_tempfile_path(graph_layer));
-			goto out;
-		}
-
-		out_fd = get_tempfile_fd(graph_layer);
-		out_path = get_tempfile_path(graph_layer);
-	} else {
-		repo_hold_lock_file_for_update_mode(r, &lk, graph_name,
-						    LOCK_DIE_ON_ERROR, 0444);
-		out_fd = get_lock_file_fd(&lk);
-		out_path = get_lock_file_path(&lk);
-	}
-
-	ret = commit_graph_write_layer(r, opts, mergeable_layers, chainable_layers,
-				       out_fd, out_path, &base, hash);
-	if (ret <= 0)
-		goto out;
-
-	/*
-	 * Snapshot everything we need from the current chain before closing
-	 * it, as we must not have any layers mapped when replacing them.
-	 */
-	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		const char *new_hash = hash_to_hex_algop(hash, r->hash_algo);
-
-		new_path = get_split_graph_filename(abs_dir, new_hash);
-
-		string_list_append(&chain_hashes, new_hash);
-		for (chain = base; chain; chain = chain->base_graph)
-			string_list_append(&chain_hashes, oid_to_hex(&chain->oid));
-
-		/*
-		 * In case we have a non-split commit graph we need to convert
-		 * it into the base layer of the new split commit graph by
-		 * renaming it.
-		 */
-		if (base) {
-			base_rename_to = get_split_graph_filename(base->dir, oid_to_hex(&base->oid));
-			if (strcmp(base->filename, base_rename_to))
-				base_rename_from = xstrdup(base->filename);
-			else
-				FREE_AND_NULL(base_rename_to);
-		}
-
-		for (chain = base; chain; chain = chain->base_graph) {
-			if (chain == base && base_rename_to)
-				string_list_append(&kept, base_rename_to);
-			else
-				string_list_append(&kept, chain->filename);
-		}
-		string_list_append(&kept, new_path);
-
-		mark_commit_graphs(g, base);
-	}
-
-	commit_graph_close(r->objects);
-
-	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		FILE *chainf = fdopen_lock_file(&lk, "w");
-
-		if (!chainf) {
-			ret = error(_("unable to open commit-graph chain file"));
-			goto out;
-		}
-
-		if (base_rename_from) {
-			if (rename(base_rename_from, base_rename_to)) {
-				ret = error(_("failed to rename base commit-graph file"));
-				goto out;
-			}
-		} else if (!base) {
-			char *graph_name = get_commit_graph_filename(abs_dir);
-			unlink(graph_name);
-			free(graph_name);
-		}
-
-		if (rename_tempfile(&graph_layer, new_path)) {
-			ret = error(_("failed to rename temporary commit-graph file"));
-			goto out;
-		}
-
-		/*
-		 * Chain hashes are ordered newest-first, but the chain file is
-		 * oldest-first so we iterate in reverse.
-		 */
-		for (size_t i = chain_hashes.nr; i; i--)
-			fprintf(chainf, "%s\n", chain_hashes.items[i - 1].string);
-	}
-
-	commit_lock_file(&lk);
-
-	if (!(opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
-		char *chain_name = get_commit_graph_chain_filename(abs_dir);
-		unlink(chain_name);
-		free(chain_name);
-	}
-
-	expire_commit_graphs(abs_dir, &kept,
-			     opts->expire_time ? opts->expire_time : time(NULL));
-
-	ret = 0;
-
-out:
-	rollback_lock_file(&lk);
-	delete_tempfile(&graph_layer);
-	string_list_clear(&chain_hashes, 0);
-	string_list_clear(&kept, 0);
-	free(base_rename_from);
-	free(base_rename_to);
-	free(graph_name);
-	free(new_path);
-	free(abs_dir);
-	return ret;
-}
-
 static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 				       struct commit_graph *graph_to_merge)
 {
@@ -2521,66 +2144,6 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx,
 	sort_and_scan_merged_commits(ctx);
 }
 
-static void mark_commit_graphs(struct commit_graph *tip,
-			       struct commit_graph *base)
-{
-	time_t now = time(NULL);
-
-	for (struct commit_graph *g = tip; g && g != base; g = g->base_graph) {
-		struct stat st;
-		struct utimbuf updated_time;
-
-		if (stat(g->filename, &st) < 0)
-			continue;
-
-		updated_time.actime = st.st_atime;
-		updated_time.modtime = now;
-		utime(g->filename, &updated_time);
-	}
-}
-
-static void expire_commit_graphs(const char *dirpath,
-				 struct string_list *kept,
-				 timestamp_t expire_time)
-{
-	struct strbuf path = STRBUF_INIT;
-	DIR *dir;
-	struct dirent *de;
-	size_t dirnamelen;
-
-	strbuf_addstr(&path, dirpath);
-	strbuf_addstr(&path, "/info/commit-graphs");
-	dir = opendir(path.buf);
-
-	if (!dir)
-		goto out;
-
-	strbuf_addch(&path, '/');
-	dirnamelen = path.len;
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
-
-		strbuf_setlen(&path, dirnamelen);
-		strbuf_addstr(&path, de->d_name);
-
-		if (stat(path.buf, &st) < 0)
-			continue;
-
-		if (st.st_mtime > expire_time)
-			continue;
-		if (path.len < 6 || strcmp(path.buf + path.len - 6, ".graph"))
-			continue;
-
-		if (!unsorted_string_list_has_string(kept, path.buf))
-			unlink(path.buf);
-	}
-
-out:
-	if (dir)
-		closedir(dir);
-	strbuf_release(&path);
-}
-
 bool commit_graph_write_allowed(struct repository *r)
 {
 	prepare_repo_settings(r);
diff --git a/commit-graph.h b/commit-graph.h
index 3b5e0eb2d73..3295498fd34 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -141,8 +141,6 @@ int commit_graph_link_base(struct commit_graph *g,
  * filters in case they aren't.
  */
 void commit_graph_validate_chain(struct commit_graph *g);
-struct commit_graph *read_commit_graph_one(struct repository *repo,
-					   const char *dir);
 
 struct repo_settings;
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 5ad27fd4bc7..90cda52b48b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1231,6 +1231,180 @@ static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
 	return 0;
 }
 
+char *get_commit_graph_filename(const char *dir)
+{
+	return xstrfmt("%s/info/commit-graph", dir);
+}
+
+static char *get_split_graph_filename(const char *dir,
+				      const char *oid_hex)
+{
+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", dir,
+		       oid_hex);
+}
+
+char *get_commit_graph_chain_filename(const char *dir)
+{
+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", dir);
+}
+
+int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
+{
+	*fd = git_open(graph_file);
+	if (*fd < 0)
+		return 0;
+	if (fstat(*fd, st)) {
+		close(*fd);
+		return 0;
+	}
+	return 1;
+}
+
+static struct commit_graph *load_commit_graph_one(struct repository *repo,
+						  const char *dir,
+						  const char *graph_file)
+{
+	struct stat st;
+	int fd;
+	struct commit_graph *g;
+	int open_ok = open_commit_graph(graph_file, &fd, &st);
+
+	if (!open_ok)
+		return NULL;
+
+	g = commit_graph_read(repo, fd, &st);
+	if (g) {
+		g->dir = absolute_pathdup(dir);
+		g->filename = absolute_pathdup(graph_file);
+	}
+
+	return g;
+}
+
+static struct commit_graph *load_commit_graph_v1(struct repository *repo,
+						 const char *dir)
+{
+	char *graph_name = get_commit_graph_filename(dir);
+	struct commit_graph *g = load_commit_graph_one(repo, dir, graph_name);
+	free(graph_name);
+
+	return g;
+}
+
+int open_commit_graph_chain(const char *chain_file,
+			    int *fd, struct stat *st,
+			    const struct git_hash_algo *hash_algo)
+{
+	*fd = git_open(chain_file);
+	if (*fd < 0)
+		return 0;
+	if (fstat(*fd, st)) {
+		close(*fd);
+		return 0;
+	}
+	if (st->st_size < (ssize_t) hash_algo->hexsz) {
+		close(*fd);
+		if (!st->st_size) {
+			/* treat empty files the same as missing */
+			errno = ENOENT;
+		} else {
+			warning(_("commit-graph chain file too small"));
+			errno = EINVAL;
+		}
+		return 0;
+	}
+	return 1;
+}
+
+struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
+						   int fd, struct stat *st)
+{
+	struct commit_graph *graph_chain = NULL;
+	struct strbuf line = STRBUF_INIT;
+	int i = 0, valid = 1, count;
+	FILE *fp = xfdopen(fd, "r");
+
+	count = st->st_size / (odb->repo->hash_algo->hexsz + 1);
+
+	for (i = 0; i < count; i++) {
+		struct odb_source_files *files;
+		struct object_id oid;
+
+		if (strbuf_getline_lf(&line, fp) == EOF)
+			break;
+
+		if (get_oid_hex_algop(line.buf, &oid, odb->repo->hash_algo)) {
+			warning(_("invalid commit-graph chain: line '%s' not a hash"),
+				line.buf);
+			valid = 0;
+			break;
+		}
+
+		valid = 0;
+
+		files = odb_source_files_downcast(odb->source);
+		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+			char *graph_name = get_split_graph_filename(dir->abspath, line.buf);
+			struct commit_graph *g = load_commit_graph_one(odb->repo, dir->abspath, graph_name);
+
+			free(graph_name);
+
+			if (g) {
+				if (!commit_graph_link_base(g, graph_chain)) {
+					graph_chain = g;
+					valid = 1;
+				} else {
+					commit_graph_free(g);
+				}
+
+				break;
+			}
+		}
+
+		if (!valid) {
+			warning(_("unable to find all commit-graph files"));
+			break;
+		}
+	}
+
+	commit_graph_validate_chain(graph_chain);
+	if (graph_chain)
+		graph_chain->incomplete = !valid;
+
+	fclose(fp);
+	strbuf_release(&line);
+
+	return graph_chain;
+}
+
+static struct commit_graph *load_commit_graph_chain(struct repository *repo,
+						    const char *dir)
+{
+	char *chain_file = get_commit_graph_chain_filename(dir);
+	struct stat st;
+	int fd;
+	struct commit_graph *g = NULL;
+
+	if (open_commit_graph_chain(chain_file, &fd, &st, repo->hash_algo)) {
+		/* ownership of fd is taken over by load function */
+		g = load_commit_graph_chain_fd_st(repo->objects, fd, &st);
+	}
+
+	free(chain_file);
+	return g;
+}
+
+static struct commit_graph *read_commit_graph_one(struct repository *repo,
+						  const char *dir)
+{
+	struct commit_graph *g = load_commit_graph_v1(repo, dir);
+
+	if (!g)
+		g = load_commit_graph_chain(repo, dir);
+
+	return g;
+}
+
 static int odb_source_files_read_commit_graph(struct odb_source *source,
 					      struct commit_graph **out)
 {
@@ -1248,6 +1422,260 @@ static int odb_source_files_read_commit_graph(struct odb_source *source,
 	return 1;
 }
 
+static void mark_commit_graphs(struct commit_graph *tip,
+			       struct commit_graph *base)
+{
+	time_t now = time(NULL);
+
+	for (struct commit_graph *g = tip; g && g != base; g = g->base_graph) {
+		struct stat st;
+		struct utimbuf updated_time;
+
+		if (stat(g->filename, &st) < 0)
+			continue;
+
+		updated_time.actime = st.st_atime;
+		updated_time.modtime = now;
+		utime(g->filename, &updated_time);
+	}
+}
+
+static void expire_commit_graphs(const char *dirpath,
+				 struct string_list *kept,
+				 timestamp_t expire_time)
+{
+	struct strbuf path = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *de;
+	size_t dirnamelen;
+
+	strbuf_addstr(&path, dirpath);
+	strbuf_addstr(&path, "/info/commit-graphs");
+	dir = opendir(path.buf);
+
+	if (!dir)
+		goto out;
+
+	strbuf_addch(&path, '/');
+	dirnamelen = path.len;
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st;
+
+		strbuf_setlen(&path, dirnamelen);
+		strbuf_addstr(&path, de->d_name);
+
+		if (stat(path.buf, &st) < 0)
+			continue;
+
+		if ((timestamp_t) st.st_mtime > expire_time)
+			continue;
+		if (path.len < 6 || strcmp(path.buf + path.len - 6, ".graph"))
+			continue;
+
+		if (!unsorted_string_list_has_string(kept, path.buf))
+			unlink(path.buf);
+	}
+
+out:
+	if (dir)
+		closedir(dir);
+	strbuf_release(&path);
+}
+
+int commit_graph_write(struct repository *r,
+		       const char *dir,
+		       const struct commit_graph_write_options *opts)
+{
+	struct string_list chain_hashes = STRING_LIST_INIT_DUP;
+	struct string_list kept = STRING_LIST_INIT_DUP;
+	struct tempfile *graph_layer = NULL;
+	struct lock_file lk = LOCK_INIT;
+	struct commit_graph *g, *chain, *base = NULL;
+	char *base_rename_from = NULL, *base_rename_to = NULL;
+	char *graph_name = NULL, *abs_dir = NULL, *new_path = NULL;
+	size_t mergeable_layers = 0, chainable_layers = 0;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	bool mergeable = true;
+	const char *out_path;
+	int out_fd;
+	int ret;
+
+	if (!commit_graph_write_allowed(r))
+		return 0;
+
+	abs_dir = absolute_pathdup(dir);
+
+	g = prepare_commit_graph(r);
+
+	/*
+	 * We only consider merging layers that belong to our own object
+	 * directory. Furthermore, we can only chain on top of either:
+	 *
+	 *   - A split commit graph layer, regardless of whether or not it is
+	 *     local.
+	 *
+	 *   - A local non-split commit graph, in which case we'll convert that
+	 *     layer into a split commit graph layer.
+	 */
+	for (struct commit_graph *layer = g; layer; layer = layer->base_graph) {
+		char *path = get_commit_graph_filename(layer->dir);
+		bool is_split = !!strcmp(layer->filename, path);
+		bool is_local = !strcmp(layer->dir, abs_dir);
+
+		free(path);
+
+		if (!is_local && !is_split)
+			break;
+		if (!is_local)
+			mergeable = false;
+
+		if (mergeable)
+			mergeable_layers++;
+		chainable_layers++;
+	}
+
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		graph_name = xstrfmt("%s/info/commit-graphs/tmp_graph_XXXXXX", abs_dir);
+	} else {
+		graph_name = get_commit_graph_filename(abs_dir);
+	}
+
+	if (safe_create_leading_directories(r, graph_name)) {
+		ret = error(_("unable to create leading directories of %s"),
+			    graph_name);
+		goto out;
+	}
+
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		char *chain_name = get_commit_graph_chain_filename(abs_dir);
+
+		repo_hold_lock_file_for_update_mode(r, &lk, chain_name,
+						    LOCK_DIE_ON_ERROR, 0444);
+		free(chain_name);
+
+		graph_layer = mks_tempfile_m(graph_name, 0444);
+		if (!graph_layer) {
+			ret = error(_("unable to create temporary graph layer"));
+			goto out;
+		}
+
+		if (adjust_shared_perm(r, get_tempfile_path(graph_layer))) {
+			ret = error(_("unable to adjust shared permissions for '%s'"),
+				    get_tempfile_path(graph_layer));
+			goto out;
+		}
+
+		out_fd = get_tempfile_fd(graph_layer);
+		out_path = get_tempfile_path(graph_layer);
+	} else {
+		repo_hold_lock_file_for_update_mode(r, &lk, graph_name,
+						    LOCK_DIE_ON_ERROR, 0444);
+		out_fd = get_lock_file_fd(&lk);
+		out_path = get_lock_file_path(&lk);
+	}
+
+	ret = commit_graph_write_layer(r, opts, mergeable_layers, chainable_layers,
+				       out_fd, out_path, &base, hash);
+	if (ret <= 0)
+		goto out;
+
+	/*
+	 * Snapshot everything we need from the current chain before closing
+	 * it, as we must not have any layers mapped when replacing them.
+	 */
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		const char *new_hash = hash_to_hex_algop(hash, r->hash_algo);
+
+		new_path = get_split_graph_filename(abs_dir, new_hash);
+
+		string_list_append(&chain_hashes, new_hash);
+		for (chain = base; chain; chain = chain->base_graph)
+			string_list_append(&chain_hashes, oid_to_hex(&chain->oid));
+
+		/*
+		 * In case we have a non-split commit graph we need to convert
+		 * it into the base layer of the new split commit graph by
+		 * renaming it.
+		 */
+		if (base) {
+			base_rename_to = get_split_graph_filename(base->dir, oid_to_hex(&base->oid));
+			if (strcmp(base->filename, base_rename_to))
+				base_rename_from = xstrdup(base->filename);
+			else
+				FREE_AND_NULL(base_rename_to);
+		}
+
+		for (chain = base; chain; chain = chain->base_graph) {
+			if (chain == base && base_rename_to)
+				string_list_append(&kept, base_rename_to);
+			else
+				string_list_append(&kept, chain->filename);
+		}
+		string_list_append(&kept, new_path);
+
+		mark_commit_graphs(g, base);
+	}
+
+	commit_graph_close(r->objects);
+
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		FILE *chainf = fdopen_lock_file(&lk, "w");
+
+		if (!chainf) {
+			ret = error(_("unable to open commit-graph chain file"));
+			goto out;
+		}
+
+		if (base_rename_from) {
+			if (rename(base_rename_from, base_rename_to)) {
+				ret = error(_("failed to rename base commit-graph file"));
+				goto out;
+			}
+		} else if (!base) {
+			char *graph_name = get_commit_graph_filename(abs_dir);
+			unlink(graph_name);
+			free(graph_name);
+		}
+
+		if (rename_tempfile(&graph_layer, new_path)) {
+			ret = error(_("failed to rename temporary commit-graph file"));
+			goto out;
+		}
+
+		/*
+		 * Chain hashes are ordered newest-first, but the chain file is
+		 * oldest-first so we iterate in reverse.
+		 */
+		for (size_t i = chain_hashes.nr; i; i--)
+			fprintf(chainf, "%s\n", chain_hashes.items[i - 1].string);
+	}
+
+	commit_lock_file(&lk);
+
+	if (!(opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
+		char *chain_name = get_commit_graph_chain_filename(abs_dir);
+		unlink(chain_name);
+		free(chain_name);
+	}
+
+	expire_commit_graphs(abs_dir, &kept,
+			     opts->expire_time ? opts->expire_time : (timestamp_t) time(NULL));
+
+	ret = 0;
+
+out:
+	rollback_lock_file(&lk);
+	delete_tempfile(&graph_layer);
+	string_list_clear(&chain_hashes, 0);
+	string_list_clear(&kept, 0);
+	free(base_rename_from);
+	free(base_rename_to);
+	free(graph_name);
+	free(new_path);
+	free(abs_dir);
+	return ret;
+}
+
 static int odb_source_files_write_commit_graph(struct odb_source *source,
 					       const struct commit_graph_write_options *opts)
 {

-- 
2.56.1.763.g16177fe143.dirty


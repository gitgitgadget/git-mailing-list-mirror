Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807875;
	b=Y6ujXBHfUEljOXREDloM0Yrc8iMAXgZFdRPdon6zOg1l+HZM83oVhz4Aq6sgcGDwb0ZW
	 WUWAMOUfr1BPfF4z98QaMBoZXZ9/eOwQS5UVLDwjVY3gOx/EVOioWMENVzeVA7E5bXjQl
	 MJm2+goCIiRsPO5fVUV8Cicgid9OF90uURk6xo2tIyR9PFSK5+X5y0OEsbK+bFE/rjEGB
	 +z+XmYKsl5iD3t5zFd+aS5c+0tUy4VDMiMjXdNuy227E5SmAL/5aQDZMM5hgaKB8nhWdq
	 IRJDGRVsWQ3kopJm0tn4DZhwklHHZ6JZ8nwjHQFm0wKbDEwJ9nMUyFfVFt9434fBAJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807875;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vfPjEyMQT5J/6u0v86XCaJpVYPLpeAAlaWhgv9qO0fw=;
	b=ZMdrSTTgM8U2CBNGHSRBEyjosceDh0BYCOxsUJfSFmj9NLQUsk20mqTHii4nXcY2H46E
	 vvU/IAdcFyWUuHBCpJSXYi2JrtQ8oRhP9DHPGEi6TcsVeUHNru1Dx24BfANnQvzRFr1yl
	 Z9JZwBRS8IwOLDjbK6YchDFWZHkoJg8Gm1OJvV5WoahaPxWps7Uy0Wjbrad7AYPeoIk0s
	 Sye9VDqZ5shR0jaBSrm75/FLiZIyBY3ifYpBP+D/UYZW3eRxa8XiIXEic4E7Ydkfoln0W
	 g8DXW5UYx9VgIc1zmWVTYxd8EBZj0gzpy5j/YIRMN6Zo6SParI+NRq04CNNwIPNJldw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jFb806k8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k8bXmL7G;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC7606EE9E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0AC7606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jFb806k8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k8bXmL7G
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 202111400176
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 04 Nov 2026 10:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807874;
	 x=1793894274; bh=vfPjEyMQT5J/6u0v86XCaJpVYPLpeAAlaWhgv9qO0fw=; b=
	jFb806k8wDJ2zlEiE/Jv3CUTNfCEAXMI2qE0DQZ5hzePJ8tY0Cjp0kVaFgUNYrzv
	r0Cck3T8c/yTuWXL+5fyWArhCdiNmSI7i6j4F3syLMcWFojNES00q88bkQQSpozP
	AK3pmRqDv4VLYfqbkSaRyoyhzbsLF3/JtHCnICe5xQXuo8chNJXdG8xMj65q0ZX2
	7iuhzcSkKkxWZbgwvV9zn3Z0ORybUXEGKTdbhmJ3Ync3llNXK0oKJp8eU4ve8BOt
	3KPqFhFRa0Ra9/+irn+q5VkhGowTbVB7crbnVX686/F6PiYDQDFkqCPMU5UoWo8K
	jgmzKdQTxk6wX/nz4VWjrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807874; x=
	1793894274; bh=vfPjEyMQT5J/6u0v86XCaJpVYPLpeAAlaWhgv9qO0fw=; b=k
	8bXmL7GVT345xQoD+5AVJWvpb0dOtAWRtY0Hjnf9RqW3aDhriG5RSY915Pjtnkde
	4i5A3VH8nXDWlOM1lMhL/sn2eFf9rRHzQxXRnB5Ge/0LhXyxz2H7i5jputuUbtLQ
	XH6VlwXq7YUZ3mbNz0nj8vtqUxg/AZBZRNIE68s9OiXYvf+JCqi7mp+MJ9VVd+uL
	27EtbVOBLDi8MiOlq3/9uS5hiISrZrjihFVbrcv9w20I3gOCp8CbbA3g+4iA2MM3
	V9aCe4r/l+xXXZ//DZe0grhVw1xVo59L1yx0FXqph/eyXyffSAUYf5ssAlAdXpqK
	PzBkZzmfLCOoMhEAvRR+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807874; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:CXZbU2+fITR3H1stm4lzXTs87iX3hAObKPtOKAQ4v5anE0x
	NFhNsys2vQ49hCSuaB3Nh1WtYH2HPKemNr25CsYwJBmMzNnYnFl/baCLgqbBUPfv
	5u/b05OaYaJVnEVZZWdJh/Q0eWjRwYvRD4lEjN3lYX5a+sRH41Y5OLM1b7V6/HeX
	7J/Amfo7P1NAaSjpLKW1g3vNuMKzJeRxVfMuLC53jmbzyNwpAi4PLrcyPhPN053b
	tn2KGYU9d4I5ecmtUFEYNtsAx1rysxbQAVbqLT9KD1l84I2XPGgYMGSvCfKGoq5z
	0uEPFXQG+5nwybi3jIMKvY6LCp/VNek2UIQ7m5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5LQr1z4uosoJZIyUbVE3tn++9FcEnZWUepYTZKdHN0w=:5VAzh7GoPhjuELEWANg7JWaecU6VmCN+/jpqvehLDrQ=;
X-ME-Sender: <xms:Albragy9EtUvCZ3t3XYJ7uvgt7LEt_6JRzJOnzuPwxXBZhFaNcHI6w>
    <xme:AlbrarNag-SntX4wUEH85xrIhWNhEb83mf9HnKKgxtQnIuqtwcekk5bAUI-hM7igZ
    6GeajdnphciYN4qUaRU1O2k0zbXQjAJoLr3IIY1zS1N1kkpuldQww>
X-ME-Received: <xmr:Albran_bkKLSo0nv1Eub0IDuxfBH6HKcVlCVfeulXnr-oblecqVYPGuU-c3stIHtr8LhqWA>
X-ME-Proxy-Cause: dmFkZTFP9F9oJWwJG85mnHzfFOqny0OiD5iiWGUykvkiOCtsZJx63XeSWFS5hvnOTWaXXM
    pVNW68EmUAqObsBxHEoTqZGxr1uInZq5ObL120XJ6obWw31M/SqAAh2FRln8SyYDsBRQAc
    XgLSwbTYIIRAuqer3KFyQcFJVx1upExtgeuk4+nospz6pknGbvTFoQtONK00uHdyGa71ei
    05eeKL8ZFbs8tu8jIH8bDRz+5s8LGUqkWAZAgjQZeduYIONS+s4caycfiuwagcsfkJCBbf
    gsJbttQXJ4DA/1KBEx2aj29+xUBhITr/+i7EpjG9SxzktIlj30krZRuziPbpuPiywKxRJm
    S9RHOLaMun43O8fKjR0UTJdY2Bv/AQz7j1ODXBbe/gerIq5PnBUDI+zQ4GWkrJKklXJz23
    kcdcJ7TVJUPc+0acdfcKhzyfXGJTAAXuyuprMw1pMi2TqTHv2z3xhACQobix1Tvq5h2gGy
    kApoPwtjIqMpRuvrEyoG2nBgrAyIJsD51Xo2yc0gBj5hw/Edlp5clJ8mAlEtDh5U72VY5L
    YhtgnVX0ekj/UPAXDaK2rMTrejlM0aFcMNyzD/rULIMmd9E19SuydS2q01S3kXNWXnN1x7
    svRRJkS0g/7YXdkgPjsi8aW5XX2ODVpEXMMbjE3a+w8W7dfrL3tUnw8Qhtnw
X-ME-Proxy: <xmx:AlbrajoQa0D0JLv7vS0G0svuV34TP-W-RulDrwaGfNwLqpgyarcpYA>
    <xmx:Albrah76xoB40Ws_ZkB-loH10znxvfxxfIeKqjMpIb8aUBc67IDI0A>
    <xmx:AlbrarNfwvIh06HvoZlKe-o8NkCUwlAmeEPndBJk8ajn865H-okNLA>
    <xmx:AlbrarOawIC_Kv7XNKH3kBx9VioYYJuchqJQhWkCMNxLlcyQmfCg4A>
    <xmx:Albraizii638eFfzu9IPEswK5w2cMEgysr9ZFLant9wTSU95pZKFqRf4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7495a97e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:28 +0100
Subject: [PATCH 06/10] commit-graph: move remaining write parameters into
 options
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-6-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move the remaining optional parameters that can be passed to
`write_commit_graph()` into its options structure to simplify the
function's calling convention.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  7 +++----
 builtin/fetch.c        | 15 +++++----------
 builtin/gc.c           |  2 +-
 commit-graph.c         | 14 ++++++--------
 commit-graph.h         |  4 ++--
 5 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 644f7736c91..f2c374d0176 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -319,6 +319,7 @@ static int cmd_commit_graph_write(int argc,
 			string_list_append(&pack_indexes, packname.buf);
 		}
 
+		write_opts.pack_indexes = &pack_indexes;
 		strbuf_release(&packname);
 	} else if (opts.stdin_commits) {
 		oidset_init(&commits, 0);
@@ -335,13 +336,11 @@ static int cmd_commit_graph_write(int argc,
 			}
 		}
 
+		write_opts.commits = &commits;
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(repo, dir->abspath,
-			       opts.stdin_packs ? &pack_indexes : NULL,
-			       opts.stdin_commits ? &commits : NULL,
-			       &write_opts))
+	if (write_commit_graph(repo, dir->abspath, &write_opts))
 		result = 1;
 
 cleanup:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 637d7ddaa06..7278cee8ca7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2943,20 +2943,15 @@ int cmd_fetch(int argc,
 			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 		if (graph_write_mode != GRAPH_WRITE_TIPS)
 			write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
+		else
+			write_opts.commits = &updated_tips;
 
 		if (graph_write_mode != GRAPH_WRITE_SKIP) {
 			trace2_region_enter("fetch", "write-commit-graph",
 					    the_repository);
-			if (graph_write_mode == GRAPH_WRITE_TIPS)
-				write_commit_graph(
-					the_repository,
-					the_repository->objects->source->path,
-					NULL, &updated_tips, &write_opts);
-			else
-				write_commit_graph(
-					the_repository,
-					the_repository->objects->source->path,
-					NULL, NULL, &write_opts);
+			write_commit_graph(the_repository,
+					   the_repository->objects->source->path,
+					   &write_opts);
 			trace2_region_leave("fetch", "write-commit-graph",
 					    the_repository);
 		}
diff --git a/builtin/gc.c b/builtin/gc.c
index 709789dbf2c..7bf88861df0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -742,7 +742,7 @@ int cmd_gc(int argc,
 			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 		write_commit_graph(the_repository, the_repository->objects->source->path,
-				   NULL, NULL, &write_opts);
+				   &write_opts);
 	}
 
 	if (!daemonized) {
diff --git a/commit-graph.c b/commit-graph.c
index 97be0f71484..077213b5336 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -41,7 +41,7 @@ void git_test_write_commit_graph_or_die(struct repository *repo)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph(repo, repo->objects->source->path, NULL, NULL, &opts))
+	if (write_commit_graph(repo, repo->objects->source->path, &opts))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -2544,8 +2544,6 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
 int write_commit_graph(struct repository *r,
 		       const char *dir,
-		       const struct string_list *const pack_indexes,
-		       struct oidset *commits,
 		       const struct commit_graph_write_options *opts)
 {
 	struct write_commit_graph_context ctx = {
@@ -2563,7 +2561,7 @@ int write_commit_graph(struct repository *r,
 	struct topo_level_slab topo_levels;
 	struct commit_graph *g;
 
-	if (!!pack_indexes + !!commits + !!(opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) > 1)
+	if (!!opts->pack_indexes + !!opts->commits + !!(opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) > 1)
 		BUG("attempting to write commit-graph with mutually incompatible options");
 
 	prepare_repo_settings(r);
@@ -2644,12 +2642,12 @@ int write_commit_graph(struct repository *r,
 		}
 	}
 
-	if (pack_indexes) {
+	if (opts->pack_indexes) {
 		ctx.order_by_pack = 1;
-		if ((res = fill_oids_from_packs(&ctx, pack_indexes)))
+		if ((res = fill_oids_from_packs(&ctx, opts->pack_indexes)))
 			goto cleanup;
-	} else if (commits) {
-		if ((res = fill_oids_from_commits(&ctx, commits)))
+	} else if (opts->commits) {
+		if ((res = fill_oids_from_commits(&ctx, opts->commits)))
 			goto cleanup;
 	} else if (opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) {
 		fill_oids_from_reachable(&ctx, &reachable_commits);
diff --git a/commit-graph.h b/commit-graph.h
index 4adbd5f18d9..0e03e82a04a 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -171,6 +171,8 @@ enum commit_graph_split_flags {
 
 struct commit_graph_write_options {
 	enum commit_graph_write_flags flags;
+	const struct string_list *pack_indexes;
+	struct oidset *commits;
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;
@@ -195,8 +197,6 @@ struct commit_graph_write_options {
  */
 int write_commit_graph(struct repository *r,
 		       const char *dir,
-		       const struct string_list *pack_indexes,
-		       struct oidset *commits,
 		       const struct commit_graph_write_options *opts);
 
 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)

-- 
2.56.0.500.g5d06dc02cd.dirty


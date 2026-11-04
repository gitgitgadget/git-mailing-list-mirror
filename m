Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807864;
	b=0P4PxY0ysdiLaOuY0dDUI5fDE8LG3XPiSVAt8gJeMqDA8sLrB3QWRXYrM7w6MH9Rr6xW
	 iqv/7jI+l5dfPydsNspnRTIquOPDrUtKq70ccl2wqS0pDwScgY0orx/r9g1MsEJktSDU6
	 pM4r2rnoIfbegldCJwiyX2ViWzrgoO2faIUeoFUaJ6sZR0ikYEmolY3PaHTFOHKmVA83k
	 r3cSP1x717ggxVc4fzPC3sx3D9OXUAgjF5CHkZfia2musUMnyg2a8yWV6SF7iEAIqpZjN
	 ZQnKFZeif+6aVOZ/owh7NYT62fiRQxIh0P4mwi/6cLROx/7eTPe6/L1gK6opcGJfoZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807864;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=O6MTWWgPsEM3H/IXjOffNo43k0KwaXTSHXXUk+d7IKc=;
	b=RbMkofrJuitdAye4cxVw/5B3Cx7Ka91zsSZqCpcjWYtE3Ehllju4hKQ9wFeKcXBSW8AR
	 SxiwLOhUgFc+IGKGUWv+VMdB3VsMLrt52ronZiXYYvLFePsa3Sv6bWKsEaTsDGjsd+Cdd
	 Y4bmltUMVnPgynOT/EuK9b+ppjgQugCxfvMjx4C5IkGUOeEznu/PCKtq0KAX9p5bba2YD
	 HdbrFLDCgqmNBSAQFxc+02y7+NWpX0jL21UjeYygOQHSzmjV9i68xgtCHnFOHAk3gk3Qo
	 g9Ks+ly7ISMIpyjUrjTW/dTN/Pnd3Q6+lzIfIwufahJ18DRhWfMXaDTcFZvHYmG0Yow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GyUeiPl+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0xq5oCOu;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5E606A33D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A5E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GyUeiPl+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0xq5oCOu
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F88AEC00D7
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 04 Nov 2026 10:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807863;
	 x=1793894263; bh=O6MTWWgPsEM3H/IXjOffNo43k0KwaXTSHXXUk+d7IKc=; b=
	GyUeiPl+LVnskVOXCMp5MWHuNdchkUjPeaIIivxVSNxEmh5cSvUgG2H0Hkbt6ZGB
	emp/FF8gmM5yp0HHN1Oaumwu63wc4RAgJJZwYVKBaIsX+cH6pRli9U3QsRvDrtSG
	7dMvbPpEEX9bAHn3rhZYLFNmSu6QVVIokCRIC1jnIjseR1pgaAqZ20LL0LYANsp+
	GeamblCQxl2AhoFb74rHEapa0BVQGCfYveM7JO6rRaStFoADgu020STHxDcmshkg
	5ntK6B/6umrcKmQdg97OB5kx8dQ5S1KzoXZ2s6Sw6mVkASGV0TArZ/a6GyD1FBjh
	2RKVizrDv5FgrEgoeljqWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807863; x=
	1793894263; bh=O6MTWWgPsEM3H/IXjOffNo43k0KwaXTSHXXUk+d7IKc=; b=0
	xq5oCOuo3I9NeRpeJK5nsJbWvYbqMi+ztLpMrbTEmln/xgeM5CEo18iLEVrZYhLZ
	vZL43CLnzSV91AcQ62xhJajShNodq+LPUgt6sYK+UmLAWAfZ7ZetG9aBuN9loshm
	/CrbZcY5DO2t7YVp500ddn0jNYvE578NGXLUU541LQJLs3d3+opkDpucZCg4gp1C
	sJULDB0Xjq0FORTb8UWwCSouZvNt+X4CPDEuk6CKMo7KlNHelziQcm/MX7obZWBH
	7Sfn/HWC6br0/h+F+Ey9AlyxpoiLLmd3et1vHVzNxrWIvNI9uNnC5lsY7l3fiHvG
	tJ2dHzuLQZYZLp0lPP7Ew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807863; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:u6l+JMrm7FX4ED9R7ZqgWR6Eip7pcLwOCDl0kD95Lm7fEQZ
	U/zg+mIXz7aZfPogsPpBzbc//8w9+DW+Nt3PDGAsUAB449CRE9+OC2rib6W2YkkR
	vLG3hvPFADJrsLSxCNr3UzCAcK5zLZxOE6fstvOsntjfBM1OL01IACAR18Tajr8u
	PlqdVucQOWpCySPSKSjmmARJN1hXWVZZcy4OXN9+iWdFY4m4RuBttG7jHea4BfMt
	iXUxn70GLH4WsTUGX1+eoDVJKLUQQ/shO6O9TXKwcQPZJYzsz4Tz25Fh5LvzZ1Vd
	31GmUniCZ90fK/DDFNkb1zVwNVJsJnif/psRJFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7oQKASxO8PVtYyMrL2XOmvV32fcw3gOpCyAPuLQFJAQ=:NFUI7ZHxNaoD+LFpZUZjdLxamiw2eElZXcYfJGeG8LE=;
X-ME-Sender: <xms:91Xrak7CrbcFtNFFp-p4iCs7CsxaqxhixwWz4ay7fSVsfgQ2xIeojg>
    <xme:91Xras3jFbxhprylrzb5E5OTac6KlPfEd1YCziBGx0h4TRsCg-BXGFwBVkTY8e-TJ
    _fjV9LxTJjIFdTZEa_bkfBeiDgbCbRe15I4G9s-D0CmaGMdScLRIw>
X-ME-Received: <xmr:91XrapGXGgM-wCuY8ZVA0zXLJgjP4bfYwp46hL9CoN4ewUPIJPcfJyLWIY50_MlGbjuNnHg>
X-ME-Proxy-Cause: dmFkZTFe/gsFzdCu8fIf4PCUUegXMCTZ/qNFfbORPSsq+Jcsc46iDssHmgdW2bzrh3Zv1f
    icDBUvFVE3Ods9gkc1BsaxsuXDZge83wljMpe5PhPjfZHV8Qym7XGHRSpJe1t/OrWKQ+jb
    zac+cQANHR7No+bgKd5T+q8aRFz2Q0vxbXp3qfOMKTq4hub2fIb3TGizgO5LY6KZYTeF9D
    8FLxi+ckLmA2YFjLsAWEY31dKAhgAOOMlduJHwSr9QCq8PvxIoV0Z5Z550CH5XgP80gIW9
    kZnsLiTMnJ6xUU/MuewfFMvVuhAno3O2f1GmPE1Gh3xMGxH+SkMY2yXsfjtJTK2UUYTLdJ
    5B/c2uB5KzNnCRmUs3UPKrIAqFS9y8rOZR9y3oY0LjkOnn0ZR75IljBiDU8KDmXH+RHcSq
    eD3W21h3e9YEUbq4VP27jra5HUU6IRLSso4XDXjEb0UNT4dQldTBPAlqs0xrNewayO0F8Y
    l+u8gbCmDa6A5hXCBc0GSJpN5U7BJbnc41dE1yjycKqE46jUsqgfEmD4OjESPYzUzdBmUx
    7TpfBBThFq6A6Dv2U3uIlAgECoEzyzvAPjB4Zb/S+MpAVG3zaub/3l1u8P4tPI/aA+KlPC
    B3+acXdfdRv6qIO1OmdDzioZJi/m9oQxR1IWOsq52Vav2xvnKu/kTHOolbQQ
X-ME-Proxy: <xmx:91XrauRPoBahjCBoJYJIBsIaJYg42aNsZ_VU0rOiUr8ZKVk0mX0RCQ>
    <xmx:91XraoDRXakncp-dmMMdnFgr7ACTJ9_BC8cl0PShE9x0q34C4osJBg>
    <xmx:91Xram0g1kqP4mMk9DdD-1EPCGiHIbTiAMHUrXQ9fkwSwKp7kWlQkQ>
    <xmx:91XrauXFyLdnbjKVomXjBvONV03VLStCr9_x1Q7rWRUz7a5XwtsuCg>
    <xmx:91XralZgmBSOisK_VF-E5Si-WuhL4nZTW59NNwxnwPN00cFGQVu0oEbv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b02aeb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:24 +0100
Subject: [PATCH 02/10] commit-graph: pass writer flags via options
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-2-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

While we already accept an options structure when writing commit graphs,
we expect the caller to also pass a couple of other optional parameters
that control how exactly we perform the write. This mix is somewhat
arbitrary though and makes for an awkward calling convention, where it
is not immediately obvious which parameters are required and which are
options.

As a first step, move flags into the options structure and adapt callers
accordingly. The other parameters will follow in subsequent commits.

Note that with this change, passing the options structure now becomes
mandatory. This isn't much of an issue though because all callers do in
fact pass one now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 14 ++++++--------
 builtin/fetch.c        | 11 +++++------
 builtin/gc.c           | 12 ++++++++----
 commit-graph.c         | 24 +++++++++++-------------
 commit-graph.h         |  3 +--
 5 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0445302ba8b..d49faf543b4 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -243,7 +243,6 @@ static int cmd_commit_graph_write(int argc,
 	struct oidset commits = OIDSET_INIT;
 	struct odb_files_dir *dir = NULL;
 	int result = 0;
-	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
 	struct option options[] = {
 		OPT_BOOL(0, "reachable", &opts.reachable,
@@ -290,23 +289,23 @@ static int cmd_commit_graph_write(int argc,
 	if (!opts.obj_dir)
 		opts.obj_dir = repo_get_object_directory(repo);
 	if (opts.append)
-		flags |= COMMIT_GRAPH_WRITE_APPEND;
+		write_opts.flags |= COMMIT_GRAPH_WRITE_APPEND;
 	if (opts.split)
-		flags |= COMMIT_GRAPH_WRITE_SPLIT;
+		write_opts.flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
-		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+		write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 	if (!opts.enable_changed_paths)
-		flags |= COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS;
+		write_opts.flags |= COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS;
 	if (opts.enable_changed_paths == 1 ||
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
-		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
+		write_opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
 	if (!dir)
 		die(_("could not find object directory matching %s"), opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(repo, dir->abspath, flags, &write_opts))
+		if (write_commit_graph_reachable(repo, dir->abspath, &write_opts))
 			result = 1;
 		goto cleanup;
 	}
@@ -346,7 +345,6 @@ static int cmd_commit_graph_write(int argc,
 	if (write_commit_graph(repo, dir->abspath,
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
-			       flags,
 			       &write_opts))
 		result = 1;
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 09966e5ce8d..b76e7725728 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2936,10 +2936,11 @@ int cmd_fetch(int argc,
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
 	     the_repository->settings.fetch_write_commit_graph)) {
-		int commit_graph_flags = COMMIT_GRAPH_WRITE_SPLIT;
+		struct commit_graph_write_options write_opts = COMMIT_GRAPH_WRITE_OPTIONS_INIT;
 
+		write_opts.flags |= COMMIT_GRAPH_WRITE_SPLIT;
 		if (progress)
-			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 		if (graph_write_mode != GRAPH_WRITE_SKIP) {
 			trace2_region_enter("fetch", "write-commit-graph",
@@ -2948,13 +2949,11 @@ int cmd_fetch(int argc,
 				write_commit_graph(
 					the_repository,
 					the_repository->objects->source->path,
-					NULL, &updated_tips,
-					commit_graph_flags, NULL);
+					NULL, &updated_tips, &write_opts);
 			else
 				write_commit_graph_reachable(
 					the_repository,
-					the_repository->objects->source->path,
-					commit_graph_flags, NULL);
+					the_repository->objects->source->path, &write_opts);
 			trace2_region_leave("fetch", "write-commit-graph",
 					    the_repository);
 		}
diff --git a/builtin/gc.c b/builtin/gc.c
index 81cecf6b6c3..a157909ed54 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -734,11 +734,15 @@ int cmd_gc(int argc,
 		clean_pack_garbage();
 	}
 
-	if (the_repository->settings.gc_write_commit_graph == 1)
+	if (the_repository->settings.gc_write_commit_graph == 1) {
+		struct commit_graph_write_options write_opts = COMMIT_GRAPH_WRITE_OPTIONS_INIT;
+
+		if (!opts.quiet && !daemonized)
+			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+
 		write_commit_graph_reachable(the_repository,
-					     the_repository->objects->source->path,
-					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
-					     NULL);
+					     the_repository->objects->source->path, &write_opts);
+	}
 
 	if (!daemonized) {
 		char *path = repo_git_path(the_repository, "gc.log");
diff --git a/commit-graph.c b/commit-graph.c
index 2f9bf7a44fd..9216d051c1f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -32,14 +32,15 @@
 
 void git_test_write_commit_graph_or_die(struct repository *repo)
 {
-	int flags = 0;
+	struct commit_graph_write_options opts = COMMIT_GRAPH_WRITE_OPTIONS_INIT;
+
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
 		return;
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
-		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
+		opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(repo, repo->objects->source->path, flags, NULL))
+	if (write_commit_graph_reachable(repo, repo->objects->source->path, &opts))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -1915,7 +1916,6 @@ static int add_ref_to_set(const struct reference *ref, void *cb_data)
 
 int write_commit_graph_reachable(struct repository *repo,
 				 const char *dir,
-				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_write_options *opts)
 {
 	struct oidset commits = OIDSET_INIT;
@@ -1926,7 +1926,7 @@ int write_commit_graph_reachable(struct repository *repo,
 	data.repo = repo;
 	data.commits = &commits;
 
-	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
+	if (opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		data.progress = start_delayed_progress(
 			repo,
 			_("Collecting referenced commits"), 0);
@@ -1936,8 +1936,7 @@ int write_commit_graph_reachable(struct repository *repo,
 
 	stop_progress(&data.progress);
 
-	result = write_commit_graph(repo, dir, NULL, &commits,
-				    flags, opts);
+	result = write_commit_graph(repo, dir, NULL, &commits, opts);
 
 	oidset_clear(&commits);
 	return result;
@@ -2564,14 +2563,13 @@ int write_commit_graph(struct repository *r,
 		       const char *dir,
 		       const struct string_list *const pack_indexes,
 		       struct oidset *commits,
-		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_write_options *opts)
 {
 	struct write_commit_graph_context ctx = {
 		.r = r,
-		.append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
-		.report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
-		.split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
+		.append = opts->flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
+		.report_progress = opts->flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
+		.split = opts->flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
 		.opts = opts,
 		.total_bloom_filter_data_size = 0,
 		.write_generation_data = (get_configured_generation_version(r) == 2),
@@ -2617,9 +2615,9 @@ int write_commit_graph(struct repository *r,
 	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
 		chain->topo_levels = &topo_levels;
 
-	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
+	if (opts->flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx.changed_paths = 1;
-	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
+	if (!(opts->flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
 			ctx.changed_paths = 1;
diff --git a/commit-graph.h b/commit-graph.h
index 513713ecb62..7461093a990 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -169,6 +169,7 @@ enum commit_graph_split_flags {
 };
 
 struct commit_graph_write_options {
+	enum commit_graph_write_flags flags;
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;
@@ -193,13 +194,11 @@ struct commit_graph_write_options {
  */
 int write_commit_graph_reachable(struct repository *repo,
 				 const char *dir,
-				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_write_options *opts);
 int write_commit_graph(struct repository *r,
 		       const char *dir,
 		       const struct string_list *pack_indexes,
 		       struct oidset *commits,
-		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_write_options *opts);
 
 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)

-- 
2.56.0.500.g5d06dc02cd.dirty


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807880;
	b=ZU5SGkILfuYxv85Bx+0saDhGfOVHPp6cKMoV3s41aR4qDlaVa0NaCDIbLnvCOdEq5uKD
	 nwzf7lpZjwKT4voBaYZcVfutoy189XJZbNHedkBx6qn/m1GhghzJGSAlsiC+QaE4LtssU
	 kDo3uSkqxYfzfuj5Zrhh18fxovynh2x5mtFknKkoWpKXRif8gUODaRkDqURax10C4QiQ4
	 BpFueqfDrP3v+y39h74iajU5O80LbYDk0bt05XrscCQqaixOx+CjhL5OxS7pZ5I4+knDy
	 Vd47G+d5q5x49aOdXS1R8iOp71+SG6Pgo4Ltf8XqdgNa+YonopQVj/6NRvxyn7g6TJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807880;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=DoXu/zXfHLoaB3R/BUi7W7AQxuB+YIUNj38BKut5LjI=;
	b=TFT7g1ux1W5ytKbku8m2f6pZTAI2NkVKflJo5Fid+CLI6/QqVqROkQ92lQfCdb9LqrZR
	 5K4tZwEOUQy2uZd8gU5nvUcGFe7os2Y0IOBVezUEti/PJaheCaLLBqVamXy+26fuQCBfx
	 OmjDDg0LawRSSMpoCA33eJgvRlfKt0RrI17O+o0N5Y+x+VEZnVhU6JyFal5AMXVZKJG6d
	 Qg2QfKOf11dRx1xz/j6ElmOi6KpCY6ApQQmykE52yedpHtBLtDm2TlLEVfOsPM9ju7UGu
	 3rtqHpAboStGX7bKFBvgy3KgWaWN4n+znBne73bSb/JjeflF1avitbejFl105nvJsvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NjwhHky9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=S4b6t0ra;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF36082BD6
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DF36082BD6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NjwhHky9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=S4b6t0ra
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 753BF1400171
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 10:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807879;
	 x=1793894279; bh=DoXu/zXfHLoaB3R/BUi7W7AQxuB+YIUNj38BKut5LjI=; b=
	NjwhHky9zDfUslVCSukNXfcAZr1pv7kbsYvLAyxsS/rypbDBW3ZGPtZLyhdL7idg
	aLSank2PFe5IOT9IAZYxXUyA4Zol5zv1CQZgNg3KIXxv8gTDkk/9gkzN0wf1EwXi
	1WwRQpVOc1oMNxxovWuwUXzduB3ACJCkXMSR87AUyBDmetfzi+NXwg6pRoTDyvWZ
	jW6VNdz8bsotVK91o0M1mSSqF7TxtWYApJciX1b3J6v+kJQwXn3KcuW0qeZnqIOy
	zQGKII/6+q6RgYOHqUAyLZ4NtbzQ18c7u10bRyIwDOw6O7AJL9uAh64xqMGUHqWx
	u3wFdC+caaCTi2RGwFIWGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807879; x=
	1793894279; bh=DoXu/zXfHLoaB3R/BUi7W7AQxuB+YIUNj38BKut5LjI=; b=S
	4b6t0rau6ssaYP7KpzXsr1UYJOZyG7Ou3leXle468tI/1x34CLZh1uXj+/bC2/J+
	9e2KWVcjicBB0Jphwcg6GZipL7M9/qeXCZCHtBvh3/BpYkjzayXBGuGNXtC5t1EC
	nBaqnlTXDydwgf8CaqtWI/NoiU/mpclOBqKyyinl+8cXMHKqdxsBWcyeOLU4HpIh
	JzEsdPd3iAqpyInF6/kcNFI+lndu1mCxl/1Z2PC01X/5aBB0gYTs8BUBK7h0Ht0H
	b6llWx5FAs/M1gpdgmDejmJgiHSVN9HQ5GCzeSFub0JOjr6zV+RnuCR0OnSQi7eL
	o0p8mInTi9ugm9UkW54nA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807879; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:uSu9Wd11fAXRjqKUI2Effgi4Z4x4gY632BlkcUgybk1DGTJ
	/voaRD7mN2G1kS/6tNnvxDY8wUCseXbpV55KIjXdD2KVRDIIvvmXS93sge7NIJ0W
	JGlErLOsk/7loMV4vjOjO/1TPrQtkDYynJmSv9v19BundZd6YQWqXJAFbS+Hq/GA
	P2HcYej1mtnZyGz7Kx3u0VrGzRJmEK/0I03vlm7JMTwE3jcb260h4fhGuRFP4ciF
	emeXMr5axecplbKg7cbSDBvK925S7eDaURsUB5dkBGXvEdMI4pRd0RRVFeeYoAIf
	oPKL5of90vRVvP2OsH6p1lW8WfA6PhPNkoopjbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/bZtdhhqC1TBgdL/wOVD4k/Weg9a/5BUS248XXsWARs=:cTZUZXaz1w1o3kscB3G5c2BwI98hBsi6IwIm4Gcw1eY=;
X-ME-Sender: <xms:B1bralPWcY0skbaUAhLK7Yu6XJCIJILTsi2eDrl1Eca_ISPdXT9GqA>
    <xme:B1brau7nKrUQBFMHmOHgnBlWSQr3b6eOl_CCMB3Ds-ZSUVzPr5qY2NPDEGyLYoNvI
    W7mBLb9dIFyD01V9Y4LjeUerWa_wZ0RQghJCHXXeF7yTrqllTwJ9o8>
X-ME-Received: <xmr:B1brap7_Ll8KTS14fWTVAqQeG67-O8KkeNXZ1uoXVdXM6Moko7bOJubXrQSW4vNH4jVk8B4>
X-ME-Proxy-Cause: dmFkZTEijChPbfh12L7GHgr1wrlICXQjT2WvPmwEzxfsGQeLnPBN5oSEwqQKp1JrSMf4h2
    DTN/FhucVO/TQWnw9AZiUtvh8J+fsiLopNU0yraxvKr/Q5k6FwxtXHmQHlwXcQwI9Lgxa2
    KpQciHVAjeQsDLrFiis2meieS5nomLtKrrgC2Bfp/5mKeU/162bo79wFoJ0Cq01G8nOoTz
    k5sL5HSaBb+b4flS4nj1fvAsLywsdoo6Dhiicp1vKE1NVHIIUp/v+/Aah8Go+J72JZTS+p
    B8AZs+BBkJIvGkshYWCxV+sfbpqUheUXpJxmAzqikWEJhVTHdVWlEIBaAQ/FD3Gk7XlqeC
    TJC6v0WfPcg66vPsRpcmAqJvJeRMcY4xbvFHLR4dDX8JMM0s9f3C5RoX5L2aiIikc6sB1s
    7Ln47EZ1+rYDx+BWjPWfC90Z9xic7AInFZaTGyJeA8g6WxqrHua5ULF0oaRFlV2DWGNzoi
    IKBtHcNVPTdM9P2TJEShXOgF8x5vgfBI64JxLhEuGuavGkqhgDVBX6qsPYh5R1nIYyTADE
    QOzkF1XWBdSMytOB/Od4bPBm0kxDtpWUq9P3xGPbREUpY4E6Csg7pbIi+awDMTIlkhaI1X
    ZvaGxUXeZ0dMOLHNO1So5nCwQUugAm69nR/iDPZXq4Se0VKxDLoXjmCvYMSA
X-ME-Proxy: <xmx:B1bram1LyNK-BzRre0Ojgca8hHeGnk5KG5Lp0mnU8cQCUpHBOOhyxA>
    <xmx:B1bratUArWK1qslljd1byOWuE84BvrZDJfv05QmyQTdtOqP6HPMdSA>
    <xmx:B1brap6lb6488Abe3AIW4SzBPWA20p5GDMa8h80V71Yt72sqVonPpQ>
    <xmx:B1brasKB_FQYvJyM1WNE8Y1O5YPBktm795xWJCzkNHElaPdHnP_Bww>
    <xmx:B1brah9QyoT7evagb5qmSa1fJcfR7tn9LWcP9wID_XjTvemAVVN64866>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71f55dd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:30 +0100
Subject: [PATCH 08/10] builtin/commit-graph: set flags directly
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-8-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have a bit of an unnecessary indirection when parsing flags for both
the "write" and "verify" subcommands: instead of setting the flags
directly via a local flags variable, we instead populate them into a
`struct opts_commit_graph` only to then set the flag. This is awkward
and unnecessarily verbose.

Drop the separate flags in `struct opts_commit_graph` and set them
directly via `OPT_BIT()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 54 ++++++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 09b09d6ac5c..218c30ed3ed 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -42,13 +42,8 @@ static char const * const builtin_commit_graph_usage[] = {
 
 struct opts_commit_graph {
 	const char *obj_dir;
-	int reachable;
 	int stdin_packs;
 	int stdin_commits;
-	int append;
-	int split;
-	int shallow;
-	int progress;
 	int enable_changed_paths;
 };
 
@@ -62,24 +57,23 @@ static int cmd_commit_graph_verify(int argc,
 				   const char *prefix,
 				   struct repository *repo)
 {
-	struct opts_commit_graph opts = {
-		.progress = isatty(2),
-	};
+	struct opts_commit_graph opts = { 0 };
 	struct commit_graph *graph = NULL;
 	struct odb_files_dir *dir = NULL;
 	char *graph_name;
 	char *chain_name;
 	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
-	enum commit_graph_verify_flags flags = 0;
+	enum commit_graph_verify_flags flags = isatty(2) ? COMMIT_GRAPH_VERIFY_PROGRESS : 0;
 	int fd;
 	struct stat st;
 	int incomplete_chain = 0;
 	int ret;
 	struct option options[] = {
-		OPT_BOOL(0, "shallow", &opts.shallow,
-			 N_("if the commit-graph is split, only verify the tip file")),
-		OPT_BOOL(0, "progress", &opts.progress,
-			 N_("force progress reporting")),
+		OPT_BIT(0, "shallow", &flags,
+			N_("if the commit-graph is split, only verify the tip file"),
+			COMMIT_GRAPH_VERIFY_SHALLOW),
+		OPT_BIT(0, "progress", &flags,
+			N_("force progress reporting"), COMMIT_GRAPH_VERIFY_PROGRESS),
 		COMMIT_GRAPH_COMMON_OPTIONS(&opts),
 		OPT_END(),
 	};
@@ -94,10 +88,6 @@ static int cmd_commit_graph_verify(int argc,
 
 	if (!opts.obj_dir)
 		opts.obj_dir = repo_get_object_directory(repo);
-	if (opts.shallow)
-		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
-	if (opts.progress)
-		flags |= COMMIT_GRAPH_VERIFY_PROGRESS;
 
 	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
 	if (!dir)
@@ -152,7 +142,7 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 
 	BUG_ON_OPT_NEG(unset);
 
-	data->opts->split = 1;
+	data->write_opts->flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (!arg)
 		return 0;
 
@@ -231,7 +221,6 @@ static int cmd_commit_graph_write(int argc,
 {
 	struct commit_graph_write_options write_opts = COMMIT_GRAPH_WRITE_OPTIONS_INIT;
 	struct opts_commit_graph opts = {
-		.progress = isatty(2),
 		.enable_changed_paths = -1,
 	};
 	struct commit_graph_write_config_data config_data = {
@@ -245,14 +234,15 @@ static int cmd_commit_graph_write(int argc,
 	int result = 0;
 	struct progress *progress = NULL;
 	struct option options[] = {
-		OPT_BOOL(0, "reachable", &opts.reachable,
-			N_("start walk at all refs")),
+		OPT_BIT(0, "reachable", &write_opts.flags,
+			N_("start walk at all refs"), COMMIT_GRAPH_WRITE_REACHABLE),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
 			N_("start walk at commits listed by stdin")),
-		OPT_BOOL(0, "append", &opts.append,
-			N_("include all commits already in the commit-graph file")),
+		OPT_BIT(0, "append", &write_opts.flags,
+			N_("include all commits already in the commit-graph file"),
+			COMMIT_GRAPH_WRITE_APPEND),
 		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
 			N_("enable computation for changed paths")),
 		OPT_CALLBACK_F(0, "split", &config_data, NULL,
@@ -268,14 +258,16 @@ static int cmd_commit_graph_write(int argc,
 		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
 			NULL, N_("maximum number of changed-path Bloom filters to compute"),
 			0, write_option_max_new_filters),
-		OPT_BOOL(0, "progress", &opts.progress,
-			 N_("force progress reporting")),
+		OPT_BIT(0, "progress", &write_opts.flags,
+			N_("force progress reporting"), COMMIT_GRAPH_WRITE_PROGRESS),
 		COMMIT_GRAPH_COMMON_OPTIONS(&opts),
 		OPT_END(),
 	};
 
 	trace2_cmd_mode("write");
 
+	write_opts.flags |= isatty(2) ? COMMIT_GRAPH_WRITE_PROGRESS : 0;
+
 	repo_config(repo, git_commit_graph_write_config, &config_data);
 
 	argc = parse_options(argc, argv, prefix,
@@ -284,23 +276,15 @@ static int cmd_commit_graph_write(int argc,
 	if (argc)
 		usage_with_options(builtin_commit_graph_write_usage, options);
 
-	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
+	if (!!(write_opts.flags & COMMIT_GRAPH_WRITE_REACHABLE) + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = repo_get_object_directory(repo);
-	if (opts.append)
-		write_opts.flags |= COMMIT_GRAPH_WRITE_APPEND;
-	if (opts.split)
-		write_opts.flags |= COMMIT_GRAPH_WRITE_SPLIT;
-	if (opts.progress)
-		write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 	if (!opts.enable_changed_paths)
 		write_opts.flags |= COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS;
 	if (opts.enable_changed_paths == 1 ||
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		write_opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
-	if (opts.reachable)
-		write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
 
 	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
 	if (!dir)
@@ -323,7 +307,7 @@ static int cmd_commit_graph_write(int argc,
 		strbuf_release(&packname);
 	} else if (opts.stdin_commits) {
 		oidset_init(&commits, 0);
-		if (opts.progress)
+		if (write_opts.flags & COMMIT_GRAPH_WRITE_PROGRESS)
 			progress = start_delayed_progress(
 				repo,
 				_("Collecting commits from input"), 0);

-- 
2.56.0.500.g5d06dc02cd.dirty


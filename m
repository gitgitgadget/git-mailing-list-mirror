Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96052356A6
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617729; cv=none; b=TZ98Npr50vaHISVlgXWwd0MmQpdvGvD4YNijqb/rc0TUD9J2WTeBxa8LrOSgdzHIVQgcbnuwxcDhWFUTr//fbgzAhwUdTQImkipYX3UlzlVHB3F3rbc8aq40NCY2Vd+PB+olti81hDvJSpTPZlI/VUoh62iaO+GimBE0bbuBPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617729; c=relaxed/simple;
	bh=W21/FVlmmqw25+L32eFNbRcIpJjPrpfZEyvbR+nrG3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMk1K1r8JRre/BftIp26ixZgok+lIzwHXiXdKyu26huStUXykerksbG6q2KKQhmLwBvlUmzwXq55A8OvICb0L/KSbDggEq065Ea6dSKpskyav5BXHoePLbCf7laWpcxINRHfpzAHwe34vLe3FRiQ0mp2e4sUEbT2O7dmEcQ2iBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TGG0xNRI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZbyTc5s; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TGG0xNRI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZbyTc5s"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19F42114018E;
	Fri, 30 May 2025 11:08:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 30 May 2025 11:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617727;
	 x=1748704127; bh=4UJMjAThErlw27qdbmbT/mXOHd17O5wMvcfUQ6XiSeg=; b=
	TGG0xNRIGWYygem4Ppgftx5c9R7sR8xuoUCohCrspGz9DNW1zWZewkHmRo3liUvs
	JgUjlrW5zyo/BEie1nu4/lTUmk++iud09u1gZUh/NbKD/CDVrHVjFHCZIY2PCpJq
	H9tYL+S8x8sAnOhdiDb+3yC1zbraj68lwfGpcEGpu1VSRE3iDIfALH0FJzO7pxmJ
	bi7Hb7ZBD1Wx7/vcaqnHld2+mvvrgs0M6lq83XZC6a47ydI6sMMMw2XkOPQ4Br0C
	jaRRlxp1d8QPlBeIBcam5hioo6H/uSfjUkg75nIeFMTnf/ADtZAGQdgakFux/CRd
	oo/g7t/Bc8sSyg3M4k9AmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617727; x=
	1748704127; bh=4UJMjAThErlw27qdbmbT/mXOHd17O5wMvcfUQ6XiSeg=; b=m
	ZbyTc5sY3opEJsbB9yxjWpa9Gg64NtZVQ8fQI23H6fU1c9IxMFRvEt738QbtMbfM
	ZjP/U9UmKQRGbI4PJ0sfVJAhozUnDJVhqj6hqtyjb5w0xxlLVNJkoCxmlqcDQ9yt
	NV1JW8e65d6XAzD9yrG1iqXSagJ6ejnTCdb7kANtR2Z45u9ziwaUI9Dk94tTeVp5
	VQ22ktnWlcqDIb9uXfPo2b4WurwE5TTmaJrrfzwg/1RCRNsO47hCCMOdvuUdTbbS
	XwLMIobJl/8bRZsDuIzsoRNvtv8Tcgwl4/Y8cctO2ex7C4IE8M936YOXjVSUEURr
	NFhMo+nMxPRTU8qk++5Tw==
X-ME-Sender: <xms:_sk5aO3NM4wACzU-4E9zjDtY59HUzgIOggEIzcuOA1v9WujFmcF0kQ>
    <xme:_sk5aBG4g-E0LNPakhEJ6RVjOG8yBecN7_oBsvssNutWwc-RQVR-iawD_xj8BstLX
    Pdf4gDtEeVXIR30Ug>
X-ME-Received: <xmr:_sk5aG79gMF1TOJnJxyfTZywsmkam1N8PB2MdRsv-B8hCdy8tX4MoqF8ETMJIhNUM3DXQ6qYUdrlURs9WaNaoTH_xjokhouoUrDnQeXZ3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgt
    phhtthhopeihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_sk5aP0n6JHPr9TGYwWlRmEzarJshHowKIipp1_JKzakMxz-NAkcqQ>
    <xmx:_sk5aBEZRjPgpuJ55-6VdFMW5HZfEqc1NvgTw4ovxzAW5PDM6o25nQ>
    <xmx:_sk5aI-O8CmAEsrjvRyty4SuouSEI9MVW3tKVYyahHATb66-PyEqJA>
    <xmx:_sk5aGm-8ttOVtuabIIL4akGRChwIZSt3y-njyfH_rSwTXJenrXUOg>
    <xmx:_8k5aGabXI6IV1u_XVqOLGLroA8z3bcF1JdM3WLdhsMGrYU1Xor9vxoL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba3e0710 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:34 +0200
Subject: [PATCH v2 08/12] builtin/maintenance: let tasks do maintenance
 before and after detach
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-8-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Both git-gc(1) and git-maintenance(1) have logic to daemonize so that
the maintenance tasks are performed in the background. git-gc(1) has
some special logic though to not perform _all_ housekeeping tasks in the
background: both references and reflogs are still handled synchronously
in the foreground.

This split exists because otherwise it may easily happen that git-gc(1)
keeps the "packed-refs" file locked for an extended amount of time,
where the next Git command that wants to modify any reference could now
fail. This was especially important in the past, where git-gc(1) was
still executed directly as part of our automatic maintenance: git-gc(1)
was invoked via `git gc --auto --detach`, so we knew to handle most of
the maintenance tasks in the background while doing those parts that may
cause locking issues in the foreground.

We have since moved to git-maintenance(1), which is a more flexible
replacement for git-gc(1). By default this command runs git-gc(1), only,
but it can be configured to run different tasks, as well. This command
does not know about the split between maintenance tasks that should run
before and after detach though, and this has led to several bug reports
about spurious locking errors for the "packed-refs" file.

Prepare for a fix by introducing this split for maintenance tasks. Note
that this commit does not yet change any of the tasks, so there should
not (yet) be a change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 447e5800846..f64bae0a825 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1545,74 +1545,86 @@ typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
-	maintenance_task_fn fn;
+	maintenance_task_fn before_detach;
+	maintenance_task_fn after_detach;
 	maintenance_auto_fn auto_condition;
 };
 
 static const struct maintenance_task tasks[] = {
 	[TASK_PREFETCH] = {
 		.name = "prefetch",
-		.fn = maintenance_task_prefetch,
+		.after_detach = maintenance_task_prefetch,
 	},
 	[TASK_LOOSE_OBJECTS] = {
 		.name = "loose-objects",
-		.fn = maintenance_task_loose_objects,
+		.after_detach = maintenance_task_loose_objects,
 		.auto_condition = loose_object_auto_condition,
 	},
 	[TASK_INCREMENTAL_REPACK] = {
 		.name = "incremental-repack",
-		.fn = maintenance_task_incremental_repack,
+		.after_detach = maintenance_task_incremental_repack,
 		.auto_condition = incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
 		.name = "gc",
-		.fn = maintenance_task_gc,
+		.after_detach = maintenance_task_gc,
 		.auto_condition = need_to_gc,
 	},
 	[TASK_COMMIT_GRAPH] = {
 		.name = "commit-graph",
-		.fn = maintenance_task_commit_graph,
+		.after_detach = maintenance_task_commit_graph,
 		.auto_condition = should_write_commit_graph,
 	},
 	[TASK_PACK_REFS] = {
 		.name = "pack-refs",
-		.fn = maintenance_task_pack_refs,
+		.after_detach = maintenance_task_pack_refs,
 		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
 		.name = "reflog-expire",
-		.fn = maintenance_task_reflog_expire,
+		.after_detach = maintenance_task_reflog_expire,
 		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {
 		.name = "worktree-prune",
-		.fn = maintenance_task_worktree_prune,
+		.after_detach = maintenance_task_worktree_prune,
 		.auto_condition = worktree_prune_condition,
 	},
 	[TASK_RERERE_GC] = {
 		.name = "rerere-gc",
-		.fn = maintenance_task_rerere_gc,
+		.after_detach = maintenance_task_rerere_gc,
 		.auto_condition = rerere_gc_condition,
 	},
 };
 
+enum task_phase {
+	TASK_PHASE_BEFORE_DETACH,
+	TASK_PHASE_AFTER_DETACH,
+};
+
 static int maybe_run_task(const struct maintenance_task *task,
 			  struct repository *repo,
 			  struct maintenance_run_opts *opts,
-			  struct gc_config *cfg)
+			  struct gc_config *cfg,
+			  enum task_phase phase)
 {
+	int before = (phase == TASK_PHASE_BEFORE_DETACH);
+	maintenance_task_fn fn = before ? task->before_detach : task->after_detach;
+	const char *region = before ? "maintenance before" : "maintenance";
 	int ret = 0;
 
+	if (!fn)
+		return 0;
 	if (opts->auto_flag &&
 	    (!task->auto_condition || !task->auto_condition(cfg)))
 		return 0;
 
-	trace2_region_enter("maintenance", task->name, repo);
-	if (task->fn(opts, cfg)) {
+	trace2_region_enter(region, task->name, repo);
+	if (fn(opts, cfg)) {
 		error(_("task '%s' failed"), task->name);
 		ret = 1;
 	}
-	trace2_region_leave("maintenance", task->name, repo);
+	trace2_region_leave(region, task->name, repo);
 
 	return ret;
 }
@@ -1641,6 +1653,11 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 	free(lock_path);
 
+	for (size_t i = 0; i < opts->tasks_nr; i++)
+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
+				   TASK_PHASE_BEFORE_DETACH))
+			result = 1;
+
 	/* Failure to daemonize is ok, we'll continue in foreground. */
 	if (opts->detach > 0) {
 		trace2_region_enter("maintenance", "detach", the_repository);
@@ -1649,7 +1666,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 
 	for (size_t i = 0; i < opts->tasks_nr; i++)
-		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
+				   TASK_PHASE_AFTER_DETACH))
 			result = 1;
 
 	rollback_lock_file(&lk);

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty


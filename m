Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C51C84A0
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848665; cv=none; b=mj0csW5VNSMG51z2dDWqEuQofEcMqj8SnfeJQfkK4veGPopZE4vPvygHRA0bGOy9SVR0iKA9KwBlud8Aw+dOBk5Qw+RU7ce+5P7XqbB1utX8Nq2MqJod+0LVFh60Ifyswpby0uFTAUn0WOgxirWCy2NbcTgYAPey6Q1dffp6Gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848665; c=relaxed/simple;
	bh=7CPWCWwglhvoL+0H6I1sFTqh8myG3TOMsehwcpJcqDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYF7Ty/GE1ah2t7nAlhxMBQ/3KipVK3Lc0nk+DVu4piJikQXsVaLpfnbLVnauZ3pOnJACf77Eyv9tOLxXkR+cPoU+pxohgUafnbV7sMb3DcUAUjWlzpKzDr26w0vt/sJUCUXl/LzSedIbC1yx+jjZuEjMQnGgNCj06i1ZdTOb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XvUg6bcT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bl6FmWlZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XvUg6bcT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bl6FmWlZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAFB625400D8;
	Mon,  2 Jun 2025 03:17:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Jun 2025 03:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848662;
	 x=1748935062; bh=k6VP387egON4tQZP+JuDiz0bGDhY5gTqQ08J2p/Dpb0=; b=
	XvUg6bcTG8c6l6Cw3VgKsX/3Q2hsYSLXgQkjR8SGWdqFABJMYyy6FZB770lrLRuC
	Vqouk9gBEroIVwc6RSA0QBYD/5dxiMFEiwNZRPcXZBis2JPu/FVQ/8403iUXUQRS
	ev/21adpG8L3U/SsDJE9ecKUSEPjcHfpE4Kv/DxahOvxmjI8oRG247GMV3m4YvqD
	NLgY4LEZDepwf720EQ/Jf5a3ZVKjgnK1jHEU7AtRyTl+lI6v4BW3hldL/ld948qa
	6YtZGTr4+ha8RuQyEdUOGKa1xCPxOK0wcPjdEjXvjFOgzugXTuPfA0+n+0zYOGZJ
	hgKW5DCGmaqtH+qAYJVFWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848662; x=
	1748935062; bh=k6VP387egON4tQZP+JuDiz0bGDhY5gTqQ08J2p/Dpb0=; b=b
	l6FmWlZ41Zjkn0NqfhxX4PD1iRA244ySP3IiYmwKWyo14JjDWiSf3h6e0k6Rh0b/
	ZinN7ccEHv3QgUm6MEupShkcnZ7nNck3ErBFn2QeRRI+/RQSM3dyxPlUTttunxN3
	kvh3Vn/dcdPJiC7Jjtd8ziKn+fgtt8HEAgq0K1djdvbbdwDCWOBomdSJ7KwSEdg5
	Q5RJilho65Hu3UOCcmb2hyidaXzan5BW+nckXh3q9yGCgVbo6it4KHktVHMBDC4V
	qDLrxUMIMoGhUoSu3QV+p3CnPsHTP8svo8HAvZkgoFgtWBoA1u+CKQG4jJuTJGkN
	bfziI0RGPDNVoiIwKOkFg==
X-ME-Sender: <xms:FlA9aBLclB-bMalweYE_v-984ffQ7o-jcfch7AYj47Gy1xkQ_YZ6SQ>
    <xme:FlA9aNL7p_Shl7xfXKiv45SNHdYJScZX-3-BEiOmxQbdkuCaSdgbxdCyPB-DYsSyo
    TYFNsNvToZjq_iwnQ>
X-ME-Received: <xmr:FlA9aJs8vVC4A3ybkVNPTuBE71D7h_cp-N0LNbxYSHIkDFKvdYsSCYvnRRo-rZzsEnpTJKgv_tj2iYSxB6omulZWgPJ79tMzkTa1qtdcNuPEwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgrshgrmhhufh
    hfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhk
    shdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FlA9aCZ8zfKC08XVXYJZL58ZXSShtKNT3OKuMGYKKUGx7_OZV6W7nQ>
    <xmx:FlA9aIbEU6KIJfQ0TEo0Hiax-2DbLXMGSSa38hb2LRecuM91wM3GQw>
    <xmx:FlA9aGCtqUDpRkNo0CDvf9vKif_4no8LcYddraULKKimKq_HL_qArw>
    <xmx:FlA9aGajIIFTuo2fKs7L1t3mphIv3-aiCAjnFyWPhoveB9JpHb1uFw>
    <xmx:FlA9aOMHUuFy0Sn24Z-Hm-OnOdKEvX2X_PfQDkmfxP8VsemNKpEBy-r_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e3adbf9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:38 +0200
Subject: [PATCH v3 12/12] builtin/maintenance: fix locking race when
 handling "gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-12-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The "gc" task has a similar locking race as the one that we have fixed
for the "pack-refs" and "reflog-expire" tasks in preceding commits. Fix
this by splitting up the logic of the "gc" task:

  - We execute `gc_before_repack()` in the foreground, which contains
    the logic that git-gc(1) itself would execute in the foreground, as
    well.

  - We spawn git-gc(1) after detaching, but with a new hidden flag that
    suppresses calling `gc_before_repack()`.

Like this we have roughly the same logic as git-gc(1) itself and know to
repack refs and reflogs before detaching, thus fixing the race.

Note that `gc_before_repack()` is renamed to `gc_foreground_tasks()` to
better reflect what this function does.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 41 +++++++++++++++++++++++++++--------------
 t/t7900-maintenance.sh | 12 ++++++------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4a5c4b20442..b5e6519d597 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -816,8 +816,8 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static int gc_before_repack(struct maintenance_run_opts *opts,
-			    struct gc_config *cfg)
+static int gc_foreground_tasks(struct maintenance_run_opts *opts,
+			       struct gc_config *cfg)
 {
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
 		return error(FAILED_RUN, "pack-refs");
@@ -837,6 +837,7 @@ int cmd_gc(int argc,
 	pid_t pid;
 	int daemonized = 0;
 	int keep_largest_pack = -1;
+	int skip_foreground_tasks = 0;
 	timestamp_t dummy;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
@@ -869,6 +870,8 @@ int cmd_gc(int argc,
 			 N_("repack all other packs except the largest pack")),
 		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_HIDDEN_BOOL(0, "skip-foreground-tasks", &skip_foreground_tasks,
+			   N_("skip maintenance tasks typically done in the foreground")),
 		OPT_END()
 	};
 
@@ -952,14 +955,16 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		if (lock_repo_for_gc(force, &pid)) {
-			ret = 0;
-			goto out;
-		}
+		if (!skip_foreground_tasks) {
+			if (lock_repo_for_gc(force, &pid)) {
+				ret = 0;
+				goto out;
+			}
 
-		if (gc_before_repack(&opts, &cfg) < 0)
-			die(NULL);
-		delete_tempfile(&pidfile);
+			if (gc_foreground_tasks(&opts, &cfg) < 0)
+				die(NULL);
+			delete_tempfile(&pidfile);
+		}
 
 		/*
 		 * failure to daemonize is ok, we'll continue
@@ -988,8 +993,8 @@ int cmd_gc(int argc,
 		free(path);
 	}
 
-	if (opts.detach <= 0)
-		gc_before_repack(&opts, &cfg);
+	if (opts.detach <= 0 && !skip_foreground_tasks)
+		gc_foreground_tasks(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;
@@ -1225,8 +1230,14 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
 	return 0;
 }
 
-static int maintenance_task_gc(struct maintenance_run_opts *opts,
-			       struct gc_config *cfg UNUSED)
+static int maintenance_task_gc_foreground(struct maintenance_run_opts *opts,
+					  struct gc_config *cfg)
+{
+	return gc_foreground_tasks(opts, cfg);
+}
+
+static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
+					  struct gc_config *cfg UNUSED)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
 	else
 		strvec_push(&child.args, "--no-quiet");
 	strvec_push(&child.args, "--no-detach");
+	strvec_push(&child.args, "--skip-foreground-tasks");
 
 	return run_command(&child);
 }
@@ -1571,7 +1583,8 @@ static const struct maintenance_task tasks[] = {
 	},
 	[TASK_GC] = {
 		.name = "gc",
-		.background = maintenance_task_gc,
+		.foreground = maintenance_task_gc_foreground,
+		.background = maintenance_task_gc_background,
 		.auto_condition = need_to_gc,
 	},
 	[TASK_COMMIT_GRAPH] = {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1ada5246606..ddd273d8dc2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -49,9 +49,9 @@ test_expect_success 'run [--auto|--quiet]' '
 		git maintenance run --auto 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
-	test_subcommand git gc --quiet --no-detach <run-no-auto.txt &&
-	test_subcommand ! git gc --auto --quiet --no-detach <run-auto.txt &&
-	test_subcommand git gc --no-quiet --no-detach <run-no-quiet.txt
+	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-no-auto.txt &&
+	test_subcommand ! git gc --auto --quiet --no-detach --skip-foreground-tasks <run-auto.txt &&
+	test_subcommand git gc --no-quiet --no-detach --skip-foreground-tasks <run-no-quiet.txt
 '
 
 test_expect_success 'maintenance.auto config option' '
@@ -154,9 +154,9 @@ test_expect_success 'run --task=<task>' '
 		git maintenance run --task=commit-graph 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
 		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
-	test_subcommand ! git gc --quiet --no-detach <run-commit-graph.txt &&
-	test_subcommand git gc --quiet --no-detach <run-gc.txt &&
-	test_subcommand git gc --quiet --no-detach <run-both.txt &&
+	test_subcommand ! git gc --quiet --no-detach --skip-foreground-tasks <run-commit-graph.txt &&
+	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-gc.txt &&
+	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-both.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
 	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt

-- 
2.50.0.rc0.629.g846fc57c9e.dirty


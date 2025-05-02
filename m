Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA422B8A7
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175461; cv=none; b=Tl4THDZCIgwLXaAgByzoeuVsU0KQfbc/U0YjGwc1gi3qRLrOTGW4FVTLfqPYQi37IWcGPoOzREUKzLsn+aBzT78i7cn9HCXeXNTGTV6iWvMUKXcmsEUctiGalDX8acSklQfRLWlpqltdPC6GdhX4MihXcPj0LM2llHxnCsaGyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175461; c=relaxed/simple;
	bh=EOtC4ZSa95En2DxPgjehmCuw3mezLmp3kvjzezziESs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pkz3lTbfq7PYvwPqphyR/glb4qhPgQL4zC8s4KF3xJiPLN4SdP1LxNnMgE3C7i+Ul9MsVwqjauotkwJc5qsJr19YkC2E3qe3AhCegnOv1wW1sLJNArfybXoCmf2cm/erISo7foBeBPQ3IRgw6UOo/9GY78zGc77UVxzaPEGyfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kIdHnVVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYKfeeZV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kIdHnVVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYKfeeZV"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97D4111401D1;
	Fri,  2 May 2025 04:44:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 02 May 2025 04:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175458;
	 x=1746261858; bh=4slpwhJDebVYmvaNj4BW0D1bWc2p7SU8wqGkIV/gVJc=; b=
	kIdHnVVRfBYY1irDyuzhgCAfCfqZbb2/NWFQkM2gk7nQuLEFG3Ta/fRUkhuwGbEn
	UpMliKQE60WkBJAcoQwe6IMKbp6Kq5ZtButd4uPuctfg0pBLmWogrECNztPanFzb
	/QdtcAIfUjrTQ2+ySBUkGg5ORhAx0793m53gd4+MPJpW1fUjYGXDCcteJ9Xb2k1Z
	9XIynlbXyB3TyCk4Pf/ju3NFm8Oos9p5Zpa9JTSw3tP7hOnf9yX/EJOCjIpV3Me4
	+gm03bGVTf8K9PWvcxYUUBA6WyG7pDTF0P9L+PgrvTXmHXdKak89FqU4wGjqbjIL
	qKqBCqtAf+NMm2FJJhtkTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175458; x=
	1746261858; bh=4slpwhJDebVYmvaNj4BW0D1bWc2p7SU8wqGkIV/gVJc=; b=V
	YKfeeZVj5vIaVuvswejJ71liknOABZsgDqKuifY3LgzMccKgoZctFWq/fNb6RAvg
	qHa4JR5BJePaloXWUmhH/gF3icTwtubt4CYQiGRpKyas2GpwaZtmgt22FegZNxBj
	Lsj/WzpkTXj6B3ZsY+Q9l3NvrXJLB5XeeIhoRI3Yg0GO2KfNNxlPXipfFp22EkZW
	JAj/cqAV03nGslyiF+EVkd9a4DlL/Y8lwnXzov8JooFXBKqpRrRn5r2OOzvdoK5Y
	JjMR01/cE/2aLX7/ucn9APt4gUVXoOmqiF3tKug62Vxr3ioAgzCJ9JB6HYPSvpn9
	62XlZDO9VUpiV8VwNNf4g==
X-ME-Sender: <xms:4oUUaEbMvKYZCaJV-5PK9e6Pj_jUXqLKpdgYbnT-9Ny2WBqOEYMrAw>
    <xme:4oUUaPb5Z-pkgF3huz_fZA7Mtomji6OlXGlkPrO88hSilOkJoth5DUF0JtmWTMPxq
    cFpoFSdtX1a3vyU0g>
X-ME-Received: <xmr:4oUUaO_JAPPAJswwkuhkaiQrHqtDDT9BHcA4wlmW3XnX5l4So0N4GLOZ8XpuZWUmxMxceEHGaCePgno0nxi-mxH5OPOGHl-f9nA7rfcVqpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeekueegieejheehueeftddugfevgeeuhffhgfeh
    fffhhedtkeevveetkedvudeugfenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdprhgvrhgvrhgvqdhgtgdr
    rghuthhopdifohhrkhhtrhgvvgdqphhruhhnvgdrrghuthhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4oUUaOog-tukXqWMcMiUrHAzoLKex8RAIlFniuLyhXzb-815ad7USg>
    <xmx:4oUUaPoDDuMP9NL_iDmD2jLre3jtSf48_pzxf6v119q9rrLyoMHa5Q>
    <xmx:4oUUaMTp6DuuW_jcTl30WjY-gdyvUI-hv2HXjKC5Z9BbxVnrkfPSdQ>
    <xmx:4oUUaPoxf68PAfyWJzG0OAJgCsAsk07wqx2Mo_44rEFNbeRp975IxA>
    <xmx:4oUUaDE1fRxqhpkE6e3V1Z8i49KqdwL_jjIG84g0A1uqWxokkGsLxAnX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9926f00f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 May 2025 10:44:04 +0200
Subject: [PATCH v3 7/7] builtin/maintenance: introduce "rerere-gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-7-13e130d36640@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While git-gc(1) knows to garbage collect the rerere cache,
git-maintenance(1) does not yet have a task for this cleanup. Introduce
a new "rerere-gc" task to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  8 +++++++
 Documentation/git-maintenance.adoc    |  4 ++++
 builtin/gc.c                          | 45 +++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh                | 43 +++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b36b62c1c47..2e8299dd15a 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -84,6 +84,14 @@ maintenance.reflog-expire.auto::
 	expired reflog entries in the "HEAD" reflog is at least the value of
 	`maintenance.loose-objects.auto`. The default value is 100.
 
+maintenance.rerere-gc.auto::
+	This integer config option controls how often the `rerere-gc` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `rerere-gc` task will not run with the `--auto` option. A negative
+	value will force the task to run every time. Otherwise, a positive
+	value implies the command should run when there are at least this many
+	directory entries in the "rr-cache" directory. The default value is 1.
+
 maintenance.worktree-prune.auto::
 	This integer config option controls how often the `worktree-prune` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 6f085a9cf8c..931f3e02e85 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -166,6 +166,10 @@ reflog-expire::
 	The `reflog-expire` task deletes any entries in the reflog older than the
 	expiry threshold. See linkgit:git-reflog[1] for more information.
 
+rerere-gc::
+	The `rerere-gc` task invokes garbage collection for stale entries in
+	the rerere cache. See linkgit:git-rerere[1] for more information.
+
 worktree-prune::
 	The `worktree-prune` task deletes stale or broken worktrees. See
 	linkit:git-worktree[1] for more information.
diff --git a/builtin/gc.c b/builtin/gc.c
index 3dd1d07cca4..7bba826c496 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -16,6 +16,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "date.h"
+#include "dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "config.h"
@@ -34,6 +35,7 @@
 #include "pack-objects.h"
 #include "path.h"
 #include "reflog.h"
+#include "rerere.h"
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
@@ -395,6 +397,43 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
 	return run_command(&rerere_cmd);
 }
 
+static int rerere_gc_condition(struct gc_config *cfg UNUSED)
+{
+	struct strbuf path = STRBUF_INIT;
+	int should_gc = 0, limit = 1;
+	DIR *dir = NULL;
+
+	git_config_get_int("maintenance.rerere-gc.auto", &limit);
+	if (limit <= 0) {
+		should_gc = limit < 0;
+		goto out;
+	}
+
+	/*
+	 * We skip garbage collection in case we either have no "rr-cache"
+	 * directory or when it doesn't contain at least as many directories as
+	 * indicated by "maintenance.rerere-gc.auto".
+	 */
+	repo_git_path_replace(the_repository, &path, "rr-cache");
+	dir = opendir(path.buf);
+	if (!dir)
+		goto out;
+
+	while (readdir_skip_dot_and_dotdot(dir)) {
+		if (--limit)
+			continue;
+
+		should_gc = 1;
+		goto out;
+	}
+
+out:
+	strbuf_release(&path);
+	if (dir)
+		closedir(dir);
+	return should_gc;
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -1502,6 +1541,7 @@ enum maintenance_task_label {
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
 	TASK_WORKTREE_PRUNE,
+	TASK_RERERE_GC,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1548,6 +1588,11 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_worktree_prune,
 		worktree_prune_condition,
 	},
+	[TASK_RERERE_GC] = {
+		"rerere-gc",
+		maintenance_task_rerere_gc,
+		rerere_gc_condition,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 530c56ae91e..f34322de320 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -564,6 +564,49 @@ test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
 	test_path_is_missing .git/worktrees/worktree
 '
 
+test_expect_rerere_gc () {
+	negate=
+	if test "$1" = "!"
+	then
+		negate="!"
+		shift
+	fi
+
+	rm -f "rerere-gc.txt" &&
+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" "$@" &&
+	test_subcommand $negate git rerere gc <rerere-gc.txt
+}
+
+test_expect_success 'rerere-gc task without --auto always collects garbage' '
+	test_expect_rerere_gc git maintenance run --task=rerere-gc
+'
+
+test_expect_success 'rerere-gc task with --auto only prunes with prunable entries' '
+	test_when_finished "rm -rf .git/rr-cache" &&
+	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
+	mkdir .git/rr-cache &&
+	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
+	: >.git/rr-cache/entry &&
+	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
+'
+
+test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.auto' '
+	test_when_finished "rm -rf .git/rr-cache" &&
+
+	# A negative value should always prune.
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
+
+	mkdir .git/rr-cache &&
+	: >.git/rr-cache/entry-1 &&
+	: >.git/rr-cache/entry-2 &&
+
+	# Zero should never prune.
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc &&
+	# A positive value should require at least this many stale rerere entries.
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=3 maintenance run --auto --task=rerere-gc &&
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=2 maintenance run --auto --task=rerere-gc
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

-- 
2.49.0.987.g0cc8ee98dc.dirty


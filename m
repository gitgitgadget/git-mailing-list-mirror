Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E443B4A7
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961059; cv=none; b=K6KRwx8LROjj48XZezO5FKjS7SP6bepwrJp2oz70nm6xMSZPpKBvhTW2hVCYv0BvQM+IJdPDEOUPartHLlWqakVJWf8iP7rUJBDSFqrBjdT2VhsstcLWXc1fqxajN7NUHsLM3VRS/Ls9Pl/PyC3NuYtOww7PZ9mYFOpcEUP9Q/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961059; c=relaxed/simple;
	bh=61UNoBGI1QP/5yc06xzUcBbEMiCh40zWynlHiyfgGR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGaYe/0ujP5XWwwFbElOR7d4i+EHsCovDJWYoo4fbdDShyTehBAXG0SnvHNSdv+BW0sDCuu5WfuMij/gEgE6iEzOXgTH0BaKCUmOvZeHYLJ9/tROquMaduIdpNDg3S+01y66en92SvqbSn3EeKvXR32gWy0jzOCHCcpozQht2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqSVcsns; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqSVcsns"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f45e206dso398145e9.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961055; x=1784565855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vZHs4KI3+tXkZ1ylLoCL40yq+B/xOblWaDiaasSOVHo=;
        b=PqSVcsnsKwbTNEPZiiZn0qC4vIh3iaT/hUYhOyrSP2O8QiNyc9M61+Kpxm4iynEDsi
         hUqXf4Xs8rH513TtAmGrrRsjC3b0BWXGCCn66Q4NwuoUTDY30EQ72s5H90StB9yGqnip
         HwL/GXhLtwzHGcLwwvjk9NkAY0dddKqmLiDxuBzj5AhSETVg2eL8FcZLvs0UKWUBcZbb
         Pj4TUdZ0jQRogd/9bCrfnMibGKX2yWt9T9p51ZvqXSCfjU2cqejHvBdhSH23483vlOx7
         p3SFR4bXLZp10Y3ilRJxjx0pcLzDrq0tLlDy+gT/OdMG4fDcCOyMYzqc9ibquk4cHJYA
         Y7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961055; x=1784565855;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZHs4KI3+tXkZ1ylLoCL40yq+B/xOblWaDiaasSOVHo=;
        b=Eu86T9/iqOWNRGGBBMxGNOLh0ZE37pExjHNz90XO/ay+vfls74WqqUbNXc/gsZ92Eg
         7w1W7ZjHSqmXfEL1Htvf95MYb0LwDjiMdlvoyy3gipSAvl707eBejR8GjQIxydZphnwm
         HYAhn8lQAlFM1N1FrDDQAUCxs/w2jANolDWoO08gRLu3ZtIEb+k+EtMHP8OX6UduoIiJ
         ims7fu3aXwiHWAjPU5dect80Qv6cOA+kH+StBvGN5XbD1iYzGsaKjj2a3VdN9q6kogUn
         md7MJmxd8IfQQRAdmcQ1LD54TDafNceIuhAiWQY036q76HAtj5B3pj9B43DhGllck/Mk
         398g==
X-Gm-Message-State: AOJu0YynLSPaYNd9iszq38k7ZY7SzOQT/L44pxiScdUnizPOXz4++cjS
	Heqcknd4aM7X8uz7LBqeE9y2guBXnvNsqRsU9rPX1IiRc4lGjBgl2oeYhvn/BgZ1
X-Gm-Gg: AfdE7cmj0QlVIGsAGCtbX5V5fmmJoLNOW/XJKP8wWdZbj4rVgsbnR0oo8SStJnUC2x/
	4b54hfk2lX/KxxYYakJD1HcKBirtaG2xzkjjnIrTWIhBRHR/ZqClCgmKGNR0TVnQIjnP/uE4z0a
	8ThmEejBA7XoIPOdj39/OQ0tIus1hSV2cfvJOLRGI1wWMaAbHEPpLgjR3Ynv6aqhk1j3Y4sdv37
	d9uxChncTCcAXDnCtJzg2intoGSnJyIcyoXQCPA5N+bcEHySm5zYMszx4ikeUlZ8fRLzUqdqNdU
	0UU++EraG7QrZE68Oz2b1AWprHt9LcM+pGWB144FCd2WoXRG83sPU9aiGvLqElwEMTi5tzV/Nt7
	mJ4xjS4AC1TKkiEOMvwgz8ZhCAAJbw5TzxRdBdk9EsVTBWDKP4uEm2lv2YX/kOhgDaAmPGHiQzJ
	AHqPLSIYwv/IL/y6NPdT6jKLkW1eBEFKyRiP47WOOAcNmx4dcLmGZNRT7Le6k3cOIhgGz8bGHxu
	x+GaFQPR497med8lJ2T7Ujiu1JlnZl+eZSynhcM8kM6ihGmkAtFbheqie4aUMgA+1wrJRhaAs8v
	WFsgJ+p6qN60NDiFmrRfs/sYY+lU8z657z3Eat0otEXTTWixZD13KWi9zrdZyI7oMO6X+dwCXII
	SppIrgcIZWw==
X-Received: by 2002:a05:6000:2382:b0:472:1424:fc7c with SMTP id ffacd0b85a97d-47ef695ba2fmr18186518f8f.10.1783961055360;
        Mon, 13 Jul 2026 09:44:15 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm653768f8f.24.2026.07.13.09.44.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 09:44:14 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v11 7/7] graph: add --[no-]graph-indent and log.graphIndent
Date: Mon, 13 Jul 2026 18:44:04 +0200
Message-ID: <20260713-ps-pre-commit-indent-v11-7-dcb65bc4ba99@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some users may prefer to not have graph indentation.

Add "log.graphIndent" config variable to graph_read_config() to read the
default preference. By default is graph indentation is true.

Add --graph-indent and --no-graph-indent options to overwrite the
default preference.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/config/log.adoc       |  4 +++
 Documentation/rev-list-options.adoc |  8 ++++++
 graph.c                             | 10 +++++--
 revision.c                          |  9 +++++++
 revision.h                          |  2 ++
 t/t4218-log-graph-indentation.sh    | 52 +++++++++++++++++++++++++++++++++++++
 6 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index 757a7be196..f7dfce69b5 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -59,6 +59,10 @@ This is the same as the `--decorate` option of the `git log`.
 	A list of colors, separated by commas, that can be used to draw
 	history lines in `git log --graph`.
 
+`log.graphIndent`::
+	If `true`, indent visual roots when rendering the graphs with `--graph`.
+	Set true by default. It can be overriden with `--[no-]graph-indent`.
+
 `log.showRoot`::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index eaee6ee839..af74f10bb4 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1269,6 +1269,14 @@ This implies the `--topo-order` option by default, but the
 	By default it is set to 0 (no limit), zero and negative values
 	are ignored and treated as no limit.
 
+`--no-graph-indent`::
+`--graph-indent`::
+	When used with `--graph`, indent visual roots (commits with no parents
+	or whose parents are not shown) to differentiate them from commits that
+	are vertically adjacent but unrelated. Enabled by default. Use
+	`--no-graph-indent` to disable or set `graph.indent` to set a deafault
+	preference.
+
 ifdef::git-rev-list[]
 `--count`::
 	Print a number stating how many commits would have been
diff --git a/graph.c b/graph.c
index c14be934a0..28bef1b88f 100644
--- a/graph.c
+++ b/graph.c
@@ -419,6 +419,8 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 
 static void graph_read_config(struct rev_info *revs)
 {
+	int val;
+
 	if (!column_colors) {
 		char *string;
 		if (repo_config_get_string(revs->repo, "log.graphcolors", &string)) {
@@ -435,6 +437,9 @@ static void graph_read_config(struct rev_info *revs)
 						custom_colors.nr - 1);
 		}
 	}
+
+	if (!repo_config_get_bool(revs->repo, "log.graphIndent", &val))
+		revs->no_graph_indent = !val;
 }
 
 struct git_graph *graph_init(struct rev_info *opt)
@@ -999,7 +1004,8 @@ static void graph_peek_next_visible(struct git_graph *graph,
 static int graph_needs_pre_root_line(struct git_graph *graph)
 {
 	return graph->commit_in_columns && graph->is_visual_root &&
-	       graph->num_columns > 0 && !graph->visual_root_cascade;
+	       graph->num_columns > 0 && !graph->visual_root_cascade &&
+	       !graph->revs->no_graph_indent;
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
@@ -1344,7 +1350,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
-			if (graph->is_visual_root) {
+			if (graph->is_visual_root && !graph->revs->no_graph_indent) {
 				int depth = graph->visual_root_depth;
 				/*
 				 * Each visual column is 2 characters wide.
diff --git a/revision.c b/revision.c
index 258c3cf782..215cf11071 100644
--- a/revision.c
+++ b/revision.c
@@ -2627,6 +2627,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->graph = NULL;
 	} else if (skip_prefix(arg, "--graph-lane-limit=", &optarg)) {
 		revs->graph_max_lanes = parse_count(optarg);
+	} else if (!strcmp(arg, "--graph-indent")) {
+		revs->no_graph_indent = 0;
+		revs->graph_indent_set = 1;
+	} else if (!strcmp(arg, "--no-graph-indent")) {
+		revs->no_graph_indent = 1;
+		revs->graph_indent_set = 1;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -3201,6 +3207,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->graph_max_lanes > 0 && !revs->graph)
 		die(_("the option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
 
+	if (revs->graph_indent_set > 0 && !revs->graph)
+		die(_("the option '%s' requires '%s'"), "--[no-]graph-indent", "--graph");
+
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 569b3fa1cb..acf6d06b24 100644
--- a/revision.h
+++ b/revision.h
@@ -314,6 +314,8 @@ struct rev_info {
 	/* Display history graph */
 	struct git_graph *graph;
 	int graph_max_lanes;
+	unsigned int no_graph_indent:1;
+	unsigned int graph_indent_set:1;
 
 	/* special limits */
 	int skip_count;
diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
index d4c850c0d4..b69730e7ba 100755
--- a/t/t4218-log-graph-indentation.sh
+++ b/t/t4218-log-graph-indentation.sh
@@ -540,4 +540,56 @@ test_expect_success 'visual root cascading gets wrapped after 4 columns' '
 	EOF
 '
 
+test_expect_success '--no-graph-indent disables indentation' '
+	lib_test_check_graph --no-graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	* 66_A
+	* 65_A
+	* 64_A
+	* 63_A
+	* 62_A
+	* 61_A
+	* 60_A
+	* 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+test_expect_success 'log.graphIndent config disables indentation' '
+	test_config log.graphIndent false &&
+	lib_test_check_graph _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	* 66_A
+	* 65_A
+	* 64_A
+	* 63_A
+	* 62_A
+	* 61_A
+	* 60_A
+	* 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+test_expect_success '--graph-indent forces indentation when graph.indent is unset' '
+	test_config log.graphIndent false &&
+	lib_test_check_graph --graph-indent _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-\EOF
+	* 67_A
+	  * 66_A
+	    * 65_A
+	      * 64_A
+	* 63_A
+	  * 62_A
+	    * 61_A
+	      * 60_A
+	  * 59_A
+	* 58_B
+	* 58_A
+	EOF
+'
+
+# graph.indent true and no --option is the default state.
+
 test_done

-- 
2.54.0

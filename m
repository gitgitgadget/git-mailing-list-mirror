Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63346248880
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505423; cv=none; b=BPgB4qbswFRHPeFl/IfYEXfTwrt/zBz0wlpThFGziyf89nWvDQy9VUh6nVHun57snoFFMquOh5o9LXYV/c0+va8aMQPt6bwk76Us+MzvDsTV8sdDuAJpFLof0yFthpX2hemjQsjTpxNkBoGefnOQ8xCT8z9T6pQC1N47ED2H1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505423; c=relaxed/simple;
	bh=NJALJXU+QSJJXSkMu5mmS1ECKN/VCucmqO1FW8ZBySI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KknC33uCyqfTX3AO5DLfhpBM3Pcm5LAaEKVE6ioWCEBorron0fbqVUeR7w/ungpvAg71jsjV9bshDJqQbMQ4hBN0RLyBlk1Oqa9nKL78o3qjO5W7x4/fFgJggAFUz6X/lXsNiA+KvVJkWceljQaQKFoOaMVjfia/C2zjF77uEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtfbjPlq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtfbjPlq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f2676bb21so1036635ad.0
        for <git@vger.kernel.org>; Thu, 11 Dec 2025 18:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765505420; x=1766110220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MED4UXclcTlitC/9lScY16o8F/K09XDRuu6jFcZCueA=;
        b=PtfbjPlqrML8zIkeVqvpGKoAl7knwakJZ5ICquo4PHZJEk4Ujmu9tmWlCGslAHXrpP
         n/aB9dlFiYrAzn5cdXSStPKkgTpaeGF7yHK2GNz4AVbb7sjug5hxBRQaSdYaOAtkcP41
         NJS6UIsKitp9JW9Y51fLY6X2FzVKGAKy0H+tHz/9h4QhOsNuUO4UHgiUfab4XV3fEMFY
         DhVhOEBa51vmt0XxffkHYnXnoO9tmi1y5M7Qt6OLt7SKu5Y1MoNsJZA2/u21E4mmKsfw
         P7EROYpPukt7E34NoWCYHXTprjkHS9dAvHRRSzPSjiyUAIVvVoJNNMK8WYPEejE4NozT
         Y5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505420; x=1766110220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MED4UXclcTlitC/9lScY16o8F/K09XDRuu6jFcZCueA=;
        b=FWkkpm+sP9elN6COOGWHg6e9++XcL8SHiDVooI+jQI30GtVBwNRo9VNr5pj4mLCGpy
         24wHfS+sps9cb43hMF6DRS2+YgtLGFKO4ItQqIPDxg2qLM/khd/G6Y2taefpDlvQqj2X
         2CwxnOLR8jQ2XZQtAwDvvkxAKL57SmR+uyyB9BO71dgH7Q7xz6W8d62Wut4EM0LAfofj
         w9PK+M597W9pGf3b1UOac/4WdLl0oFA591XXMl/7cJwe/iRTSYIhzTdn61BySqN3K/rd
         OjFEaAUpXryUM1w9s2ghfsBGPfknWcRyhweSVogNF86PrUsYvStNyWy58CqqruRYZyZ4
         KH0Q==
X-Gm-Message-State: AOJu0Ywg6pNnsB+KSILSX7s9o3c3Yyxe6C0hNs4S78DjYXGtVZ7cXjLR
	CGJW70mx+RS5YCs1ujRa7++xyCHpSRw4XVOynQ6M/kdlSYTyuy+3Di8Lrn9uGg==
X-Gm-Gg: AY/fxX4mjtp5nA3ZY50McgR8T7sCRwtRX4hp/XJZAcNuIsWbG3a/P/4RrUAaCXcILH3
	dJr/LJ0R/y7xgzMDpSbHvMJu2pM+SSw3nD0GfSg6b4oltZfdsa/o8dXcP7PR5CitXj8KNPux+V2
	9LQT4eQMhzCCJFulv/DmLnOd+DOTFsWbguKeX766jrDyzh3Ji3Glqq78pZj1AeoqMpiSHfOgcht
	NR8qkmNr+5+H7FP5iZCsqTvWIBDWPDHmIwEbu5y7DipXVDWZX7UgHyLDbgDcH9Mwtw5C5qlKv7E
	oyU5P0tsFHWz2bpNNARH0rAKCRfdOkyXhycnyOaT6XoaO9ijG/hC3qRDorKhUpQRoPECQqq42fN
	/aIuGwghdjkrmQf32Nqu8AqcFZuRF0LQl2Sq5uFZ2ItjjvtjqS4nV20FbamQbSR7XLBPR1SyAUk
	DffJm0PsHP2iz+l4G7EqHtRKfMQMUkc5rc
X-Google-Smtp-Source: AGHT+IGGcxKsriiXyxUqwksT8+a8ggcJ4S8eUQiUtcesqiJY9sZYy6nFpWwZD2NaBU6R4GvAur+2pA==
X-Received: by 2002:a17:902:c403:b0:295:39d9:8971 with SMTP id d9443c01a7336-29f23de599bmr5209135ad.1.1765505420262;
        Thu, 11 Dec 2025 18:10:20 -0800 (PST)
Received: from Fedora-Gink ([2405:201:c005:b959:acb7:a699:c03a:f9fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d36bf5sm36401095ad.24.2025.12.11.18.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:10:19 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com
Subject: [PATCH] Make pull.c match the structural conventions
Date: Fri, 12 Dec 2025 07:39:30 +0530
Message-ID: <20251212020930.11654-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The builtin sources follow a predictable structure, and pull.c departs
from that pattern by arranging its option table in a way that disrupts
the expected flow of the file. The irregular placement makes the file
harder to read, breaks the visual rhythm shared by other builtins, and
forces readers to jump around to understand how options are handled.
The lack of consistency makes pull.c feel like an outlier rather than
a peer alongside the other commands.

A consistent layout helps readers rely on established mental models,
so bringing pull.c into alignment improves clarity and makes the file
easier to navigate and maintain.

Pull.c, become structured like the other builtin/*.c files, keeping the
option definitions where the reader naturally expects them and restoring
the uniformity of the builtin command layout.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---

I was going through pull.c for a different bug hunt and found this out.
I thought there must be some issue pulling the options table locally to main but
git compiles and also passes the tests and also the CI/CD,
so I can't say if this part was intentional or not.

 builtin/pull.c | 285 ++++++++++++++++++++++++-------------------------
 1 file changed, 142 insertions(+), 143 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5ebd529620..97814edbc5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -119,148 +119,6 @@ static int opt_show_forced_updates = -1;
 static const char *set_upstream;
 static struct strvec opt_fetch = STRVEC_INIT;
 
-static struct option pull_options[] = {
-	/* Shared options */
-	OPT__VERBOSITY(&opt_verbosity),
-	OPT_PASSTHRU(0, "progress", &opt_progress, NULL,
-		N_("force progress reporting"),
-		PARSE_OPT_NOARG),
-	OPT_CALLBACK_F(0, "recurse-submodules",
-		   &recurse_submodules_cli, N_("on-demand"),
-		   N_("control for recursive fetching of submodules"),
-		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
-
-	/* Options passed to git-merge or git-rebase */
-	OPT_GROUP(N_("Options related to merging")),
-	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
-		"(false|true|merges|interactive)",
-		N_("incorporate changes by rebasing rather than merging"),
-		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
-		N_("do not show a diffstat at the end of the merge"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
-	OPT_PASSTHRU(0, "stat", &opt_diffstat, NULL,
-		N_("show a diffstat at the end of the merge"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "summary", &opt_diffstat, NULL,
-		N_("(synonym to --stat)"),
-		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
-	OPT_PASSTHRU(0, "compact-summary", &opt_diffstat, NULL,
-		N_("show a compact-summary at the end of the merge"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
-		N_("add (at most <n>) entries from shortlog to merge commit message"),
-		PARSE_OPT_OPTARG),
-	OPT_PASSTHRU(0, "signoff", &opt_signoff, NULL,
-		N_("add a Signed-off-by trailer"),
-		PARSE_OPT_OPTARG),
-	OPT_PASSTHRU(0, "squash", &opt_squash, NULL,
-		N_("create a single commit instead of doing a merge"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "commit", &opt_commit, NULL,
-		N_("perform a commit if the merge succeeds (default)"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
-		N_("edit message before committing"),
-		PARSE_OPT_NOARG),
-	OPT_CLEANUP(&cleanup_arg),
-	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
-		N_("allow fast-forward"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
-		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
-	OPT_PASSTHRU(0, "verify", &opt_verify, NULL,
-		N_("control use of pre-merge-commit and commit-msg hooks"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
-		N_("verify that the named commit has a valid GPG signature"),
-		PARSE_OPT_NOARG),
-	OPT_BOOL(0, "autostash", &opt_autostash,
-		N_("automatically stash/stash pop before and after")),
-	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
-		N_("merge strategy to use"),
-		0),
-	OPT_PASSTHRU_ARGV('X', "strategy-option", &opt_strategy_opts,
-		N_("option=value"),
-		N_("option for selected merge strategy"),
-		0),
-	OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
-		N_("GPG sign commit"),
-		PARSE_OPT_OPTARG),
-	OPT_SET_INT(0, "allow-unrelated-histories",
-		    &opt_allow_unrelated_histories,
-		    N_("allow merging unrelated histories"), 1),
-
-	/* Options passed to git-fetch */
-	OPT_GROUP(N_("Options related to fetching")),
-	OPT_PASSTHRU(0, "all", &opt_all, NULL,
-		N_("fetch from all remotes"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU('a', "append", &opt_append, NULL,
-		N_("append to .git/FETCH_HEAD instead of overwriting"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "upload-pack", &opt_upload_pack, N_("path"),
-		N_("path to upload pack on remote end"),
-		0),
-	OPT__FORCE(&opt_force, N_("force overwrite of local branch"), 0),
-	OPT_PASSTHRU('t', "tags", &opt_tags, NULL,
-		N_("fetch all tags and associated objects"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU('p', "prune", &opt_prune, NULL,
-		N_("prune remote-tracking branches no longer on remote"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
-		N_("number of submodules pulled in parallel"),
-		PARSE_OPT_OPTARG),
-	OPT_BOOL(0, "dry-run", &opt_dry_run,
-		N_("dry run")),
-	OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
-		N_("keep downloaded pack"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "depth", &opt_depth, N_("depth"),
-		N_("deepen history of shallow clone"),
-		0),
-	OPT_PASSTHRU_ARGV(0, "shallow-since", &opt_fetch, N_("time"),
-		N_("deepen history of shallow repository based on time"),
-		0),
-	OPT_PASSTHRU_ARGV(0, "shallow-exclude", &opt_fetch, N_("ref"),
-		N_("deepen history of shallow clone, excluding ref"),
-		0),
-	OPT_PASSTHRU_ARGV(0, "deepen", &opt_fetch, N_("n"),
-		N_("deepen history of shallow clone"),
-		0),
-	OPT_PASSTHRU(0, "unshallow", &opt_unshallow, NULL,
-		N_("convert to a complete repository"),
-		PARSE_OPT_NONEG | PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "update-shallow", &opt_update_shallow, NULL,
-		N_("accept refs that update .git/shallow"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "refmap", &opt_refmap, N_("refmap"),
-		N_("specify fetch refmap"),
-		PARSE_OPT_NONEG),
-	OPT_PASSTHRU_ARGV('o', "server-option", &opt_fetch,
-		N_("server-specific"),
-		N_("option to transmit"),
-		0),
-	OPT_PASSTHRU('4',  "ipv4", &opt_ipv4, NULL,
-		N_("use IPv4 addresses only"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
-		N_("use IPv6 addresses only"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
-		N_("report that we have only objects reachable from this object"),
-		0),
-	OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
-		 N_("check for forced-updates on all updated branches")),
-	OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
-		N_("set upstream for git pull/fetch"),
-		PARSE_OPT_NOARG),
-
-	OPT_END()
-};
-
 /**
  * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
  */
@@ -1008,7 +866,148 @@ int cmd_pull(int argc,
 	int can_ff;
 	int divergent;
 	int ret;
-
+	static struct option pull_options[] = {
+		/* Shared options */
+		OPT__VERBOSITY(&opt_verbosity),
+		OPT_PASSTHRU(0, "progress", &opt_progress, NULL,
+			N_("force progress reporting"),
+			PARSE_OPT_NOARG),
+		OPT_CALLBACK_F(0, "recurse-submodules",
+			   &recurse_submodules_cli, N_("on-demand"),
+			   N_("control for recursive fetching of submodules"),
+			   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
+
+		/* Options passed to git-merge or git-rebase */
+		OPT_GROUP(N_("Options related to merging")),
+		OPT_CALLBACK_F('r', "rebase", &opt_rebase,
+			"(false|true|merges|interactive)",
+			N_("incorporate changes by rebasing rather than merging"),
+			PARSE_OPT_OPTARG, parse_opt_rebase),
+		OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
+			N_("do not show a diffstat at the end of the merge"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+		OPT_PASSTHRU(0, "stat", &opt_diffstat, NULL,
+			N_("show a diffstat at the end of the merge"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "summary", &opt_diffstat, NULL,
+			N_("(synonym to --stat)"),
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
+		OPT_PASSTHRU(0, "compact-summary", &opt_diffstat, NULL,
+			N_("show a compact-summary at the end of the merge"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
+			N_("add (at most <n>) entries from shortlog to merge commit message"),
+			PARSE_OPT_OPTARG),
+		OPT_PASSTHRU(0, "signoff", &opt_signoff, NULL,
+			N_("add a Signed-off-by trailer"),
+			PARSE_OPT_OPTARG),
+		OPT_PASSTHRU(0, "squash", &opt_squash, NULL,
+			N_("create a single commit instead of doing a merge"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "commit", &opt_commit, NULL,
+			N_("perform a commit if the merge succeeds (default)"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
+			N_("edit message before committing"),
+			PARSE_OPT_NOARG),
+		OPT_CLEANUP(&cleanup_arg),
+		OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
+			N_("allow fast-forward"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
+			N_("abort if fast-forward is not possible"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+		OPT_PASSTHRU(0, "verify", &opt_verify, NULL,
+			N_("control use of pre-merge-commit and commit-msg hooks"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
+			N_("verify that the named commit has a valid GPG signature"),
+			PARSE_OPT_NOARG),
+		OPT_BOOL(0, "autostash", &opt_autostash,
+			N_("automatically stash/stash pop before and after")),
+		OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
+			N_("merge strategy to use"),
+			0),
+		OPT_PASSTHRU_ARGV('X', "strategy-option", &opt_strategy_opts,
+			N_("option=value"),
+			N_("option for selected merge strategy"),
+			0),
+		OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
+			N_("GPG sign commit"),
+			PARSE_OPT_OPTARG),
+		OPT_SET_INT(0, "allow-unrelated-histories",
+			    &opt_allow_unrelated_histories,
+			    N_("allow merging unrelated histories"), 1),
+
+		/* Options passed to git-fetch */
+		OPT_GROUP(N_("Options related to fetching")),
+		OPT_PASSTHRU(0, "all", &opt_all, NULL,
+			N_("fetch from all remotes"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU('a', "append", &opt_append, NULL,
+			N_("append to .git/FETCH_HEAD instead of overwriting"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "upload-pack", &opt_upload_pack, N_("path"),
+			N_("path to upload pack on remote end"),
+			0),
+		OPT__FORCE(&opt_force, N_("force overwrite of local branch"), 0),
+		OPT_PASSTHRU('t', "tags", &opt_tags, NULL,
+			N_("fetch all tags and associated objects"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU('p', "prune", &opt_prune, NULL,
+			N_("prune remote-tracking branches no longer on remote"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
+			N_("number of submodules pulled in parallel"),
+			PARSE_OPT_OPTARG),
+		OPT_BOOL(0, "dry-run", &opt_dry_run,
+			N_("dry run")),
+		OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
+			N_("keep downloaded pack"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "depth", &opt_depth, N_("depth"),
+			N_("deepen history of shallow clone"),
+			0),
+		OPT_PASSTHRU_ARGV(0, "shallow-since", &opt_fetch, N_("time"),
+			N_("deepen history of shallow repository based on time"),
+			0),
+		OPT_PASSTHRU_ARGV(0, "shallow-exclude", &opt_fetch, N_("ref"),
+			N_("deepen history of shallow clone, excluding ref"),
+			0),
+		OPT_PASSTHRU_ARGV(0, "deepen", &opt_fetch, N_("n"),
+			N_("deepen history of shallow clone"),
+			0),
+		OPT_PASSTHRU(0, "unshallow", &opt_unshallow, NULL,
+			N_("convert to a complete repository"),
+			PARSE_OPT_NONEG | PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "update-shallow", &opt_update_shallow, NULL,
+			N_("accept refs that update .git/shallow"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU(0, "refmap", &opt_refmap, N_("refmap"),
+			N_("specify fetch refmap"),
+			PARSE_OPT_NONEG),
+		OPT_PASSTHRU_ARGV('o', "server-option", &opt_fetch,
+			N_("server-specific"),
+			N_("option to transmit"),
+			0),
+		OPT_PASSTHRU('4',  "ipv4", &opt_ipv4, NULL,
+			N_("use IPv4 addresses only"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
+			N_("use IPv6 addresses only"),
+			PARSE_OPT_NOARG),
+		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
+			N_("report that we have only objects reachable from this object"),
+			0),
+		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
+			 N_("check for forced-updates on all updated branches")),
+		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
+			N_("set upstream for git pull/fetch"),
+			PARSE_OPT_NOARG),
+
+		OPT_END()
+	};
+	
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
-- 
2.52.0


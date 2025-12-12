Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C29255F52
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525509; cv=none; b=ajVdZM0A47p0OFetbda12nUcDXtkHeC06Fts9IiK77+xRBplfIxRyabvgEggIscMELZOFkIVitIOo0HMZKfzQlRd3HNeaOGM+DTbaUT8wSEUHZ5wqB3WXILmQERh0jtUP+SFWf55ilazzu4o33b/ysX7GC7C3q6PJBowXGxTaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525509; c=relaxed/simple;
	bh=bHeEm34Q+5wmSCwogu09O5NYAYpgsY7Pga+RwLJaCO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMD5zyA4IrfYjxhySr6e7cQ7JXESFavR55VuZMBHhvgYVLuQ4Nujp96jSFnrZJPJX3VtxvV/rAPo6sF08pINp50TPWJ3VYk8DTflAlVEoOKbOAtNnLOl4AiUnZiQh2FDivRdFDk4V/m0yQn2yXv3tbvCKCWCwK1Cdh6+nqU6pRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLKj5E7R; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLKj5E7R"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-349b711d106so771954a91.1
        for <git@vger.kernel.org>; Thu, 11 Dec 2025 23:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765525503; x=1766130303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTBmncVEKmKqXGdJXk1nQvMHt9VEgbwU/zAZ0XE/xNQ=;
        b=kLKj5E7RBY3b2bI4V8oJQI5u5nuCvNjqlOMLtnB3vtUmFr913edMtc3z3JtXULigzA
         KPKCM+CIn2WonZ8Fl2QNuNgECCv4lG9W1K3kfc8Cgo4+3Szsr289w7pYDkIiQzrdYBqP
         OBHSLJ6du8LBtIUs74VtVTpdoe0NXn44q5JhiUt1dsG+VpLEBhDszo45R+PfbzgLo4fx
         Uqu29muZi0155wBI6JSZCs6jnLDTdGQlGXuG54PXU55V15mrbM1vqeqIBGSHDHKrlsXi
         YL8sibPhW5CE1hNiTqghuc5lfszIGpHXq2nBeZvjpyVAqY25VJLqsQOGTLMt1ndz+RuP
         wTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765525503; x=1766130303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTBmncVEKmKqXGdJXk1nQvMHt9VEgbwU/zAZ0XE/xNQ=;
        b=W+uMKzG+FmtacXGEMsNZJr91GWmcYv23gZwDv+rzOc7Y1kHtpS+goAfRVSyuM8yzUi
         4HKIn7KTCaW5yJHsM45Npr7LnmbHMxZcNC0xgBBv1YHEP21NBii+daZc7rYfi6Ot3Wrl
         pLlgi34ftv1h4ZhUbWru9H/7yZUCZW9OSfIDnEPpDk746h8LmnyTzHO33gwNvEQxXwjW
         KDZgi3r0KOefm/1nL1CRxw881zbUmRhDRZsvHiY6cgwpEt19cUYq5Amq9PhW+9DH5A4e
         +5M50F2sj1Eooxsf6KNeozswaIjai1XsGR6y1dXBBoyEjUztYzuquq0TrB7D7kIiv1BQ
         8MoA==
X-Gm-Message-State: AOJu0Yym/I0p3sd08a0NjVgDHIKX14zR2SjkiKebp7SqCvetqoNxmAfx
	F2H2p6Xonu1Ee2pDQkPFiIiRZsDUW/KXI2V/4Mao1NzLD5SS/WPQmlUD4m/NuQ==
X-Gm-Gg: AY/fxX7PcjHz3W4r1jcjJPi+pLfA3Uy0Fs/82GwXUrflHR+qoDuLIchPbJSkAhvKMMp
	VSfQaIeUaKQpLENiM4wzVc9sXXjIETfopCXBVLqCFZ10AMLirPi0OzadoqfTRkEVlkx/psGpx0d
	aUXGnQb0omFSjuRE7iZxGjpUET++5mdio+HK3aB0JMIfSo3XEcX3jSTQ1fAvux9fd8ahzZ5oShH
	vpMSmXMG+7QDs0EZoIi9TS+uOs548uNbbZkB8pDyofv1mVAe2LNJdETMKIRN+iUcuEIy7Sier9p
	Rx/kZTH7J6eE6RVd223G5nShH8JnpGH8T4+Dhz+WX8ZUvjOGNPvzYTN4iY7TrIFj3qN1YcCCOcy
	8Xwm2z5CNMSLCcGuG58DCwhw7+hke3tY+oxI5OV2sUcfnjnftkiowf5mPB7LcpZugW6vW8XKefE
	77gCaGmNHShSj40azBb/obHxe2dbl1ivrL
X-Google-Smtp-Source: AGHT+IHCO7HUOEN/LOosKpE3cXHdJE1lm1+DG2MqzMIddph8rGZl2hu/yYGh+H7lpAlj/Cenmhl5zA==
X-Received: by 2002:a17:90b:2804:b0:341:124f:4746 with SMTP id 98e67ed59e1d1-34abd858b85mr984841a91.31.1765525502633;
        Thu, 11 Dec 2025 23:45:02 -0800 (PST)
Received: from Fedora-Gink ([2405:201:c005:b959:acb7:a699:c03a:f9fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3f4d43sm1072887a91.12.2025.12.11.23.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:45:01 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH v2] pull: move options[] array into function scope
Date: Fri, 12 Dec 2025 13:14:33 +0530
Message-ID: <20251212074433.38027-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqikeccnhx.fsf@gitster.g>
References: <xmqqikeccnhx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unless there are good reasons, it is customary to have the options[]
array used with the parse-options API declared in function scope rather
than at file scope.

Move builtin/pull.c:cmd_pull()’s options[] array into the function to
match that convention.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
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


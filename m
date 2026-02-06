Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E832DC772
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393288; cv=none; b=Ad1FdwWKCWUxi3PVluEEWGdxJwoIRZPHdz6ZR1/NK91Sinm6QzbVsdIVLziP3YVNGcGurME17UjbBCsRQSFmVKuujmNv2wqSyxBhX2j5Pyal5+57ash74tXeNVBWMKR3xErH1eJu7OzyXInZu9UbauKGyouKimYun3juB5W1gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393288; c=relaxed/simple;
	bh=v5qRFfJCOkDYme+Epjw+WDdBYQhAo4Z6grXJXmTwRZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0L7TYnJXfAe6XY+W3US86N9Bf+jTiPaKhRZtj4IFJmafQht+hLR9hwF661WrZCMJVqbgq9SfWLd37VDK3d9YqFbsRMbdIuInDuPY809rMdIwa61qMxG0xKd8o+osYdG+Ga+eSUeb5fq/KPF4C6VjkRd+ZKpjp2Q4dQJkY4Pfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0PBz/29; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0PBz/29"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so24260255e9.2
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 07:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393286; x=1770998086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozaeIqHlC5CWPelbsWAN2D5kE6dKg1pIKnzk7Ry7o0g=;
        b=W0PBz/29cyKrqLLCIq22FfGK9LCKQ14+d5/FahrnrOyVgJuKQIw3DMZOVbqMWGxqbc
         hs29bx9tepkMry1Rr/2xQsScVw+j0dipCVWVSBcHuf7v2xJMtGUdQ75yO8Zie2ebtRMf
         sa72RhuvZfrntXZwxGDWZIUIb8cMUtCcSOhhkyDunoJITeipwG3jLrENLEh4/+/JPZqm
         LhILs+YxEZq2QJFuZ+rJg8LvV/vYTuQ7k6Sp6EVe4mLUu99exwgd6phdShpfYsgAsAeN
         T/IghYm+TvmGyo54VjHRoKUnSgxHe0QYjNdjQKWRMC1N0E8dzgIGM2oi5UsFY4pfoDuq
         gvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393286; x=1770998086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozaeIqHlC5CWPelbsWAN2D5kE6dKg1pIKnzk7Ry7o0g=;
        b=XLpwoxKIOwR3h/W0ERZh7LtHBRLYkHIGyfgr8cORPEgruLHTSjR8hIrzgSLrWc8AZ3
         r+WxMoc9DJnSHTVZV60/3eSLibHTQxaL9sSCl0ALWLpdaE5F3gTTosm6ug/9l+OfO4x5
         od2TNEubVK6atHFbZlbFxAPJC2WkYB1qJGQwsu299tIBfyoMRurxkfZX7dhsma3kZJDg
         ULep93qO6KB/5yob5KmPpR9uXitX4rknCzGqmxoDV4703WVpBh0lfMIUzpBbcbhFZL32
         eiC6f0pa6ACbwlxnNmVeWfSRhPofYQOLffTr9dxllk8Q7+bSbSYY607f8SZIt8QZbT3E
         Mueg==
X-Gm-Message-State: AOJu0Yw621YLBOdmyuI8VCd+jwNCdDDBBgzY4Zj6Ny5LMGEG1cPhug8s
	DF2WVpCy5l5cz/6PydczrFUxhuQkn8ToaaBGRLdcDW8uAVRcaJP3L6HoFuT+IG7ej/c=
X-Gm-Gg: AZuq6aJeh8wBL0KQhFSdfvCGJ1m4RYDxL7igu+rGybEbJjbi6+4oinpDEPsHE2WM4Yc
	i5vaeg1ks9oPueUgFrUaL5VO11+MTaeTUG/mamcAOoWHnzBJ7Gm8b7CuI45hmepcnVsAhKYB0n4
	FRkc++BnDqm8rWwXhTppdcS2uXY6aARnLn5iOhgPyEHIexOxV0OSezl0JzJeQWqAgBP+MtmGv58
	3RVTiW4PFNYJple5g3AGQxQXtgoctn4MXY0ZfVc2YhPkBQ5QaqEBmt9I5bXaiK3hferCSR/gI92
	dgCo9JePP/vEd8taes+ft4omU3dCYpSIHuQfFdcufh/Es+Mw8GWuUR+rm4AzIzRugNQvFUGP6pC
	HJgSbjfB1GMVv1onzvHxAjAStwGzd9UqLj59mmuZTTcWHRt2Y2qiPpZvFdERnADNVDFpXLpq+Gr
	TOk2uPlMV7cBlnfC8Qbs3K
X-Received: by 2002:a05:600c:8b82:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-4832020f040mr46840165e9.16.1770393285897;
        Fri, 06 Feb 2026 07:54:45 -0800 (PST)
Received: from localhost ([102.91.81.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm170358255e9.0.2026.02.06.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:54:45 -0800 (PST)
Date: Fri, 6 Feb 2026 16:54:47 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/3] interactive -p: add new `--rework-with-file` flag to
 interactive machinery
Message-ID: <c0fa65b429b4a5c33c4a2092e0e8d014a61e4569.1770390576.git.abrahamadekunle50@gmail.com>
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770390576.git.abrahamadekunle50@gmail.com>

When using the interactive add, reset, stash or checkout machinery, we do
not have the option of reworking with a file because the session automatically
advances to the next file or ends if we have just one file, immediately all hunks
in a file are decided on.

Introduce the flag "--rework-with-file" when interactively selecting patches with the
'--patch' option, which does not auto advance, thereby allowing users the option
to rework with files.
This ensures the current auto-advance method stays as the default method.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-interactive.c     | 3 +++
 add-interactive.h     | 5 +++--
 builtin/add.c         | 4 ++++
 builtin/checkout.c    | 6 ++++++
 builtin/reset.c       | 4 ++++
 builtin/stash.c       | 8 ++++++++
 t/t9902-completion.sh | 1 +
 7 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 68fc09547d..4eda115da8 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -64,6 +64,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 	s->r = r;
 	s->context = -1;
 	s->interhunkcontext = -1;
+	s->no_auto_advance = 0;
 
 	s->use_color_interactive = check_color_config(r, "color.interactive");
 
@@ -124,6 +125,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 			die(_("%s cannot be negative"), "--inter-hunk-context");
 		s->interhunkcontext = add_p_opt->interhunkcontext;
 	}
+	if (add_p_opt->no_auto_advance)
+		s->no_auto_advance = 1;
 }
 
 void clear_add_i_state(struct add_i_state *s)
diff --git a/add-interactive.h b/add-interactive.h
index da49502b76..aef2feca56 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -6,9 +6,10 @@
 struct add_p_opt {
 	int context;
 	int interhunkcontext;
+	int no_auto_advance;
 };
 
-#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1, .no_auto_advance = 0 }
 
 struct add_i_state {
 	struct repository *r;
@@ -28,7 +29,7 @@ struct add_i_state {
 
 	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
-	int context, interhunkcontext;
+	int context, interhunkcontext, no_auto_advance;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r,
diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..408827cf54 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -256,6 +256,8 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
 	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
+	OPT_BOOL(0, "rework-with-file", &add_p_opt.no_auto_advance,
+		 N_("rework with files when selecting hunks interactively")),
 	OPT_DIFF_UNIFIED(&add_p_opt.context),
 	OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
@@ -418,6 +420,8 @@ int cmd_add(int argc,
 			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");
+		if (add_p_opt.no_auto_advance)
+			die(_("the option '%s' requires '%s'"), "--rework-with-file", "--interactive/--patch");
 	}
 
 	if (edit_interactive) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5..3e98d06be1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -63,6 +63,7 @@ struct checkout_opts {
 	int patch_mode;
 	int patch_context;
 	int patch_interhunk_context;
+	int no_auto_advance;
 	int quiet;
 	int merge;
 	int force;
@@ -549,6 +550,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		struct add_p_opt add_p_opt = {
 			.context = opts->patch_context,
 			.interhunkcontext = opts->patch_interhunk_context,
+			.no_auto_advance = opts->no_auto_advance
 		};
 		const char *rev = new_branch_info->name;
 		char rev_oid[GIT_MAX_HEXSZ + 1];
@@ -1747,6 +1749,8 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
+		OPT_BOOL(0, "rework-with-file", &opts->no_auto_advance,
+			 N_("rework with files when selecting hunks interactively")),
 		OPT_DIFF_UNIFIED(&opts->patch_context),
 		OPT_DIFF_INTERHUNK_CONTEXT(&opts->patch_interhunk_context),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
@@ -1801,6 +1805,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (opts->patch_interhunk_context != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (opts->no_auto_advance)
+			die(_("the option '%s' requires '%s'"), "--rework-with-file", "--patch");
 	}
 
 	if (opts->show_progress < 0) {
diff --git a/builtin/reset.c b/builtin/reset.c
index ed35802af1..1e7b93785d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -371,6 +371,8 @@ int cmd_reset(int argc,
 			       PARSE_OPT_OPTARG,
 			       option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
+		OPT_BOOL(0, "rework-with-file", &add_p_opt.no_auto_advance,
+			 N_("rework with files when selecting hunks interactively")),
 		OPT_DIFF_UNIFIED(&add_p_opt.context),
 		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
@@ -443,6 +445,8 @@ int cmd_reset(int argc,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (add_p_opt.no_auto_advance)
+			die(_("the option '%s' requires '%s'"), "--rework-with-file", "--patch");
 	}
 
 	/* git reset tree [--] paths... can be used to
diff --git a/builtin/stash.c b/builtin/stash.c
index 948eba06fb..1311707ea6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1849,6 +1849,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_BOOL(0, "rework-with-file", &add_p_opt.no_auto_advance,
+			 N_("rework with files when selecting hunks interactively")),
 		OPT_DIFF_UNIFIED(&add_p_opt.context),
 		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1911,6 +1913,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (add_p_opt.no_auto_advance)
+			die(_("the option '%s' requires '%s'"), "--rework-with-file", "--patch");
 	}
 
 	if (add_p_opt.context < -1)
@@ -1952,6 +1956,8 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_BOOL(0, "rework-with-file", &add_p_opt.no_auto_advance,
+			 N_("rework with files when selecting hunks interactively")),
 		OPT_DIFF_UNIFIED(&add_p_opt.context),
 		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1983,6 +1989,8 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (add_p_opt.no_auto_advance)
+			die(_("the option '%s' requires '%s'"), "--rework-with-file", "--patch");
 	}
 
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 964e1f1569..302534e92d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2601,6 +2601,7 @@ test_expect_success 'double dash "git checkout"' '
 	--ignore-skip-worktree-bits Z
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
+	--rework-with-file Z
 	--progress Z
 	--guess Z
 	--no-guess Z
-- 
2.39.5 (Apple Git-154)


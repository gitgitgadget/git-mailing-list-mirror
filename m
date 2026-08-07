Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9983384CD5
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088382; cv=none; b=a7IRu51bkjyLKv+1LQdWnRpVJHjMU1pQaB6CJdEwaq2ekTDdFIgTqXR8f5a/m/lXLCQZAlMoREsYZmUfb6KKFxEbouJ0LZTnxnphZ4OYZZqVeblnucJ3e5QpStjSE8FY/N/bkKTaJ1BPpKIzViY2J8ZBX3dP1Vtg2K7C0FQFuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088382; c=relaxed/simple;
	bh=dfoqkel8aBd/+R/5HKb2BeWbFLc308oCRyyxln9V8Uo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Afvz0V61yVZqz/rtUnTjeF17vKcuPm054SKFTIbflpCuZsfkBjWKYMff4bhyF5Sj6IalMaXd+P6aA9U6AtkoL6rjY2PCamv6HCa10U6jyMortl7XQ9I/Dx6HN54b6XX4dBLGaStYZ+YZLROEDYITVjhlLGJ3dUgTgvMGqw5V+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkEmHmFo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkEmHmFo"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cedda2ce6fso26893445ad.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088380; x=1786693180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dcBOixv4/3tUhcR5n98cww7+HBZ+MabIAf94Y6Y+xyc=;
        b=EkEmHmFo3cgO4u1vMUJv+Xnua8iteB/D88VzydOL8tLaZVXmUR7bz6AuaOrnrujbAp
         0Wd3GAccwC85cHPlknVMSdsX4V/tWYInBtyM4gCN2AD0SoMGiPR9bwYJtVrYrVWgryPc
         SlvyG/TrBPu8aN85KuXIgGykavPF4Xlgl6rujKQQ6cNPu7gSG4KETSTdg+TU412uzarJ
         oVcPphciQb/u6ZfuhffFYPEI+DkfvKCAsmMNEKdNuEZY6Y22HsRoK8aM1ThhSuvkUgF3
         F8lCxlIv+VjDIjFinV2nlDe8BW/OEqkYM5uxDn94C4gaOtqHl2UC3Y9/P9qp+ATk9HLr
         Jsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088380; x=1786693180;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcBOixv4/3tUhcR5n98cww7+HBZ+MabIAf94Y6Y+xyc=;
        b=PECyxhzmtyxL+HMynweHAIU8vMFraOeoZMw4pQZhB53zwTdBPYQVScpI+5UVPRFRUN
         Jpx1sjrm5vqIgPj09dpGSCsRvN2DA0W8/fa8yO/8r1oEvWhBRX5xn1my33laHCmVkaiu
         Ij47/lPlav2TkN/MDrysaK5a7MchZIcqBQbGG9hQTBzhgn2Ed82dmX/daPNCBKY2KCG8
         ZDhKAdBn7Cw5kx2Xo7Rz9pr4jgQCwbB/3zsaWW4vY3rqocWnN5ywN3IspSdxQ+2U2Vgr
         LvmIHYAil8jaGJ/wsbI99ShNbety0mxXvamVbzEIBBgnslrYZR5ajBrhgiWm1SCDmeSf
         3iSQ==
X-Gm-Message-State: AOJu0Yx211i96XMlyy2FWAdBb4MUIv13/qPQZhWBaXMyGmJKl2Qi0ILV
	/MpXOb1MeccwLAEXgjIOupzNKjccexTmvcufyYwkITgE5B2Nn88KCas3zdfe+bWk
X-Gm-Gg: AR+sD10l4Q3KsOZ3F3g4LqjmjOZ4OVUnrTgbGfjYqxbJCdB+o+bargeFMYt4AVimvBx
	gNvc22xzYu5U8oX7tiB5gBFiVEAaf7nbLWtldH+SoJBphNrUr8BaGQdBgNWcFwYESN9HAijKOhZ
	tMBVPDE5H47IXgj/ypmdWp692PQW3PVnrEMeBQeCe+sVWjfCw8DnvtkAcbzL+HOI2xJYnTUrGTJ
	XnABAcJwQOSQryxJYsdJlw3xeB4GCyfpl8n1Y7+/yeXNixmCxxjFteScTV8DfKyuNp9R3MATLWi
	TIbe1QUWZ6bmoCvRsLygqeZ82iUcO40BRSs/Q5YHaBDtODyH/FxHsWpzQ4CBHLZOkROmTL+3zeE
	nRS6zKA356D7Dmov4jrs5PK4QUdssjAwbAE7yCQfc4wYrfLF/sCynuy9NR1PgKCZPD2oLu+tYng
	E3jLhxahzwMJdsthjdeJF/QUPCldES/8minuty/DYCLaKzEown2jjqCkFaLuI21tE=
X-Received: by 2002:a17:90b:270e:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3903bb0cf61mr22520831a91.0.1786088379988;
        Fri, 07 Aug 2026 00:39:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6dab4sm1374577a91.3.2026.08.07.00.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:39 -0700 (PDT)
Message-Id: <f7d953b081ed312770dd03d827114bb3156195b8.1786088371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:27 +0000
Subject: [PATCH v13 4/8] history: add skeleton for squash subcommand
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add the entry point and option parsing for "git history squash". Pass
the remaining arguments through setup_revisions() so the command accepts
revision ranges and rev-list options, while restoring the ordering and
simplification settings required by the fold if an option changes them.

Require at least one BOTTOM revision. The squashed commit needs a commit
outside the selected range to serve as its base, so a single positive
revision is not a sufficient range.

Keep this step limited to defining the revision input contract so graph
validation and the rewrite can be added independently.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  1 +
 builtin/history.c              | 94 ++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 28b477cd37..b660baf94d 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,6 +12,7 @@ git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
 
 DESCRIPTION
 -----------
diff --git a/builtin/history.c b/builtin/history.c
index a60e8dbcd0..4f5a7a46ce 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -34,6 +34,8 @@
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+#define GIT_HISTORY_SQUASH_USAGE \
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -1004,6 +1006,96 @@ out:
 	return ret;
 }
 
+static int setup_squash_revisions(struct repository *repo,
+				  int argc, const char **argv,
+				  struct rev_info *revs)
+{
+	repo_init_revisions(repo, revs, NULL);
+	revs->reverse = 1;
+	revs->topo_order = 1;
+	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs->simplify_history = 0;
+	revs->ancestry_path = 1;
+	revs->limited = 1;
+	revs->ancestry_path_implicit_bottoms = 1;
+
+	argc = setup_revisions(argc, argv, revs, NULL);
+	if (argc > 1)
+		return error(_("unrecognized argument: %s"), argv[1]);
+
+	if (revs->reverse != 1 || revs->topo_order != 1 ||
+	    revs->sort_order != REV_SORT_IN_GRAPH_ORDER ||
+	    revs->simplify_history != 0 || revs->boundary == 1 ||
+	    revs->ancestry_path != 1 || revs->limited != 1 ||
+	    revs->ancestry_path_implicit_bottoms != 1) {
+		warning(_("ignoring rev-list options that would change how the "
+			  "range is walked"));
+		revs->reverse = 1;
+		revs->topo_order = 1;
+		revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
+		revs->simplify_history = 0;
+		revs->boundary = 0;
+		revs->ancestry_path = 1;
+		revs->limited = 1;
+		revs->ancestry_path_implicit_bottoms = 1;
+	}
+
+	/*
+	 * A squash needs a base to reparent onto, so the range has to exclude
+	 * something, as in "<base>..<tip>". A revision range with no such
+	 * bottom commit cannot be squashed.
+	 */
+	for (size_t i = 0; i < revs->cmdline.nr; i++)
+		if (revs->cmdline.rev[i].flags & BOTTOM)
+			return 0;
+
+	return error(_("not a '<base>..<tip>' revision range"));
+}
+
+static int cmd_history_squash(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_SQUASH_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	int dry_run = 0;
+	int edit = 1;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_BOOL('e', "edit", &edit,
+			 N_("edit the commit message")),
+		OPT_END(),
+	};
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
+	if (argc < 2) {
+		ret = error(_("command expects a revision range"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	if (ret < 0)
+		goto out;
+
+	ret = error(_("squashing commits is not implemented yet"));
+
+out:
+	release_revisions(&revs);
+	return ret;
+}
+
 static int update_worktree(struct repository *repo,
 			   const struct commit *old_head,
 			   const struct commit *new_head,
@@ -1192,6 +1284,7 @@ int cmd_history(int argc,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
+		GIT_HISTORY_SQUASH_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1200,6 +1293,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
 		OPT_END(),
 	};
 
-- 
gitgitgadget


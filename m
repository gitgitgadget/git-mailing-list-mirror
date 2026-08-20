Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B238F259
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249443; cv=none; b=S+ZOVfIEq66ADylBWxeDDLWglmIWypeAV8rsXVwR4L3G3dT6urNCGTY/wM92SmEaEOIfnDfjAQbIe7Lfe4SpYeSCExJQT6JWRSdIEAIOQ/5WWWYjnODzLhdmHWB4hKqyRy32QZKLpvN0DHOSEGJ1OSm8ZiXoRjAtDk4hJ4QpNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249443; c=relaxed/simple;
	bh=Mv+t0UcLOyCRoX9mHAMk123ibyvGM2UgbnAAj3zVNcY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d/HXi44IZkZ/kGKm9LbG/9L/B4R1Km45fSKgx1tCE/vXyY+FHceCcWYvQfKEVGZwksnDc0zETV5rwn3PSM4dPjGezjMLwI3mM/kTukKA9rq3Ukmdmqynq2XTXPRjAL3L1QChax5nTg67aPQ8zExOBxthbjI3/DQJChgJ5YeYkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBgDHr8L; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBgDHr8L"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ec1e9d3359so140768a34.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249441; x=1787854241; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gZwZSfuNoyme992PD93Mp6NJPJhnML4VLa62/VZWYss=;
        b=eBgDHr8LkNEirFxRnf08ZUWQk6yBHuX8XAdQtjbTW+7eL1mAo+YdSDJkuwiquahdMi
         bKPinsF3+0l+KVE/D1OfG9Sgqns6tgeg9pwTMVd+lJGIqeXF/ihSQ7vPeCqLMdul4lez
         /aKHN65mCMhK0DuiPy9j7WA+BytiM97x/Rcjrb8clB8AiS4+9tT7ShVSn0TWst48I6qo
         cEYMjLc9voxlNVQxRI3zX2seuE5qC5QMtHGoIRn/MgjjnmOHSH1uHhjbKFQA2hHjekHp
         oY6Hplgm9c1Pwn9wM8zReYPmPzTAFYB7Meg1PdT24Tyi8/grXB8A9hVwWxutu4m6Ng1D
         klGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249441; x=1787854241;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZwZSfuNoyme992PD93Mp6NJPJhnML4VLa62/VZWYss=;
        b=lK9f3ae4Tyf0P0AZhcxHcygGPQUolqY8I+vAe96PFoS4/T5G2IdBjgOEgTNKEHTLyu
         fZCIjrppy6FqOxvctDURvqq+2QTu4Oq2UQXAxGKRilJkJdd486On/KhXQCzFsG9UmbCJ
         CfLNplQspbeQnbdnjjWRjP5yzpfoB5QISTKInnocNX7V+QdVR6pL8O3PzY2mwElw5PUn
         nPpid2nZYuozoYURKd+2EfCl3d/M9Idswfii7WhGhuc9Jkc41QuebRT4qi4bXSUuEVno
         sML2p762AgeG/AunL49GIXsZyT1ZceTw1dUfc6Z9i6U9HiTA9BxMfmda3soxa81qQnFb
         2UXQ==
X-Gm-Message-State: AOJu0YyRwgjYodEX1RWqYUfju6PWzog6hepK1kqEzQuqyo70yrcxO/XO
	5/gm3Ttuf2uVY0d4ZemI1Y8I4gRRRbpOVXlDfwz720ipYFBt4mA+xg66M8BPtP90
X-Gm-Gg: AR+sD137GOC3jDImIFqoVuzNQUS+sJ/7wgV6kH2RPdPdmfhv2lCC0LT7BuVAsXnLaTy
	97ahliMN3pVXbMQzSHRjwS4c3roVLjstqdc0J611MIUlHW/DgbasrwApYDy2BzmIEUP6H+XBd2u
	Orfgr7y6zBnICr6SPjUkfZMaGOe2rU80GnJCvnFVL6GKecE40SMizKOZW4oTnxHC/v2K9AiJStw
	zkZy3eIGYH2hj+r6gZ5SDkNHTFMwSLxI+z9strsOELH+0zTbuiXvvgnoYiWpQGuhQk+xwu7musL
	COPB+FcRfOh7RF4g93IhSdisjq9E+r9xsxq/5e2t9ta6YsvL/I4B9XVfP6T9VNckEdtMuKWs2nq
	O3wugZaOceLFFgenEVhn6sgp/6QtnrnoLhYPhanRb+Qc7lTwdyQkWL1GEuBkWqvViUAQY/uouXX
	99wijTMqszg+WjKCNts9QFlJFqnLK9pbuUsK4b51j/RIJaOxy6/kOak2jUtCk5s0F0xFI7FFTvG
	xk=
X-Received: by 2002:a05:6830:67e5:b0:7f3:79f1:c468 with SMTP id 46e09a7af769-7f4614ec078mr344660a34.14.1787249440658;
        Thu, 20 Aug 2026 11:10:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.251.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm5123584a34.2.2026.08.20.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:10:39 -0700 (PDT)
Message-Id: <016ae0fd4286641cbff5117e26decf16cd60eddc.1787249432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 18:10:28 +0000
Subject: [PATCH v14 4/8] history: add skeleton for squash subcommand
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
    Tuomas Ahola <taahol@utu.fi>,
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

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
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


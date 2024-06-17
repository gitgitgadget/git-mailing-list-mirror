Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1ED171B0
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625714; cv=none; b=nuHlL5HRjdK5NqMLgM+sYUxhmlOIviEk6osVnTbUA3i82lRPbuhUciV5b3bIO3AF3wJbvFnR7N6rr+mi/Eeq0Wjo120pdH2Fj4quaaFVcmUAt01OPExWbAJFeDEeqW2SKczb3c2M5v3xwke/sC/abFgZG/h3cRkofurhSbv+R4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625714; c=relaxed/simple;
	bh=mFm5gEpKi7TM+6MFLnchUmgsoEsEszROGrRH8odwB+c=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZPZSO/3pFy+8s8NZPnTvThtrdv2EQktQcnbTfLrwJGzGCxtwbi8LcRAWyEl6y8hHYAIRcgULmN47crH84+l2LuU8MxgKPEGhZ9PdGq3bnHHdDxWMwl1zqNHTsoJw9jGb3nuQ11IGnABfcNfy6wabJvU4R/bZf4zNFDVhhvCgT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFF9AeX9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFF9AeX9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so3516641f8f.0
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 05:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718625709; x=1719230509; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vQcwxAJVdaXGFpYQ5JtZBiaqZolgntkmUvjr7ircU7o=;
        b=lFF9AeX9UmLbsMQI5Pdfnhid3/SwBP90e2vo28Rj78w/lAKdr4cMNxGEbD9vJnFFQf
         upLyuktSRbzuuoJqYnsxXyrdVW7VOVjv3FBM12N1IAiAHVKUBQ8zol1tKUHmqio3qd0V
         V0Jv88pDzGkJMVHYDQ4HkepCumuT+15lk6YlNgsb3oQIDLTOI6js7ZdcdtkrksvlfN7y
         uz3FLRO2S9UhqaGPtpqcY/g8K1saRS+vLygqHrB1RqQO70yKP/9MxQ0GdGkQ+32sktAp
         ju1rjayeQLV9EAXFzy1jndOqh8ocJEEMPbVm5eIIpMGBN/USjZGl1WXhavjWIMAX6eWV
         DRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625709; x=1719230509;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQcwxAJVdaXGFpYQ5JtZBiaqZolgntkmUvjr7ircU7o=;
        b=cunkHuM13S7ntv8hfo7FMVBCeihc5abqs9f64XAUiCxogZ6cNMZDJAQX89LVfB97uc
         nzHxLYVFVP4l0soKDHI87civhkh0YFm2WJ1/Y+3bcNQ5W6ldhY/PRJcOlJ6b5b+VQ94/
         eqGQT3YoXswcO5CdP+iNLwIYM3tirN//4pXlAL8GMRHS/z15A/FYdGcYqlvQi3Iy1dEY
         wq/Y1hJl8dlsDQgSq4/fABs/PJVNU94+H0YbGMXIbwuycPfPrdRPAB89fHOYilCIAADd
         aVGLzuLmjkdrW5EP160hjPqaWai4G3/jxuhwy3KMaF4+xlMgiQpAXy2re3xDEv1mvYhw
         OPiw==
X-Gm-Message-State: AOJu0YzCDMbvGIFKaSUPdvo8v73oiycqZ+QMZ96NxJjLO1MyU9F3krI7
	eVLGOUYwmzx3IJxiwkuLpJVpJInIkyFc86WvEutXH9xyIvkNmDfQfB6pvg==
X-Google-Smtp-Source: AGHT+IFpHYglR9uWbdB077+xPpUrjyCgTU9S5l/LWzJb4yd3sEv8fY1P8sS1r+V0MN7yw30p28psVw==
X-Received: by 2002:a5d:4ac6:0:b0:360:7453:fcaa with SMTP id ffacd0b85a97d-3607453fe59mr11759503f8f.0.1718625708870;
        Mon, 17 Jun 2024 05:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c79bsm11876379f8f.41.2024.06.17.05.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:01:48 -0700 (PDT)
Message-Id: <pull.1703.git.git.1718625706679.gitgitgadget@gmail.com>
From: "dark0dave via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 12:01:46 +0000
Subject: [PATCH] submodule: allow gitsubmodules to be pointed at tags
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
Cc: Revi Ewer <revi.ewer@example.com>,
    Ill Takalook <ill.takalook@example.net>,
    dark0dave <dark0dave@mykolab.com>,
    dark0dave <dark0dave@mykolab.com>

From: dark0dave <dark0dave@mykolab.com>

Intent: Enable git submodules to point at tags,
effectively freezing them

Context: There is a large repo with 50+ submodules, the goal is
to have some submodules update to HEAD but others to remain fixed.
The update command does this by recursing through
directories. This is very useful, however if an update is run,
all the submodules are updated to HEAD.

The goals:
- Be able to create a submodule from a fixed tag (complete)
- Be able to run git submodule update, with a flag to either update
or keep the submodule pointed at the supplied tag (complete)

Example:

git submodule add changes

git submodule add --tag v34.3
https://github.com/Gibberlings3/SwordCoastStratagems.git
cat .gitmodules
[submodule "SwordCoastStratagems"]
  path = SwordCoastStratagems
  url = https://github.com/Gibberlings3/SwordCoastStratagems.git
  tag = v34.3

git submodule update changes

git submodule update  --remote -f --checkout

No changes as we are fixed to the tag

git submodule update --remote -f --checkout --no-single-tag
Submodule path 'SwordCoastStratagems': checked out
'77426a2e14dbe584af811f922a6da3a48d74c074'

Checks out to HEAD of remote

CC: Revi Ewer <revi.ewer@example.com>,
Ill Takalook <ill.takalook@example.net>

Signed-off-by: dark0dave <dark0dave@mykolab.com>
---
    submodule: allow gitsubmodules to be pointed at tags @dark0dave
    
    I want to enable users freezing their submodules to a tag.
    
    Example:
    
    
    Add
    ===
    
    git submodule add changes
    
    git submodule add --tag v34.3 https://github.com/Gibberlings3/SwordCoastStratagems.git
    cat .gitmodules
    [submodule "SwordCoastStratagems"]
      path = SwordCoastStratagems
      url = https://github.com/Gibberlings3/SwordCoastStratagems.git
      tag = v34.3
    
    
    
    Update
    ======
    
    git submodule update changes
    
    
    Single tag
    ==========
    
    git submodule update  --remote -f --checkout
    $
    
    
    No changes as we are fixed to the tag
    
    
    No Single tag
    =============
    
    git submodule update --remote -f --checkout --no-single-tag
    Submodule path 'SwordCoastStratagems': checked out '77426a2e14dbe584af811f922a6da3a48d74c074'
    
    
    Checks out to HEAD of remote

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1703%2Fdark0dave%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1703/dark0dave/master-v1
Pull-Request: https://github.com/git/git/pull/1703

 builtin/submodule--helper.c            | 119 +++++++++++++++++++++++--
 contrib/completion/git-completion.bash |   8 +-
 git-submodule.sh                       |  59 +++++++++++-
 submodule-config.c                     |  14 +++
 submodule-config.h                     |   1 +
 5 files changed, 189 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 880ab4456ee..e7f150230e9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1541,9 +1541,11 @@ struct module_clone_data {
 	unsigned int dissociate: 1;
 	unsigned int require_init: 1;
 	int single_branch;
+	int single_tag;
 };
 #define MODULE_CLONE_DATA_INIT { \
 	.single_branch = -1, \
+	.single_tag = -1, \
 }
 
 struct submodule_alternate_setup {
@@ -1754,6 +1756,10 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 			strvec_push(&cp.args, clone_data->single_branch ?
 				    "--single-branch" :
 				    "--no-single-branch");
+		if (clone_data->single_tag >= 0)
+			strvec_push(&cp.args, clone_data->single_tag ?
+				    "--single-branch" :
+				    "--no-single-branch");
 
 		strvec_push(&cp.args, "--");
 		strvec_push(&cp.args, clone_data->url);
@@ -1981,6 +1987,7 @@ struct update_data {
 	int depth;
 	int max_jobs;
 	int single_branch;
+	int single_tag;
 	int recommend_shallow;
 	unsigned int require_init;
 	unsigned int force;
@@ -2004,6 +2011,7 @@ struct update_data {
 	.recommend_shallow = -1, \
 	.references = STRING_LIST_INIT_DUP, \
 	.single_branch = -1, \
+	.single_tag = -1, \
 	.max_jobs = 1, \
 }
 
@@ -2151,6 +2159,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		strvec_push(&child->args, suc->update_data->single_branch ?
 					      "--single-branch" :
 					      "--no-single-branch");
+	if (suc->update_data->single_tag >= 0)
+		strvec_push(&child->args, suc->update_data->single_tag ?
+					      "--single-tag" :
+					      "--no-single-tag");
 
 cleanup:
 	free(displaypath);
@@ -2297,6 +2309,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 	cp.dir = module_path;
 
 	strvec_push(&cp.args, "fetch");
+
 	if (quiet)
 		strvec_push(&cp.args, "--quiet");
 	if (depth)
@@ -2434,6 +2447,30 @@ static int run_update_procedure(const struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
+static int remote_submodule_tag(const char *path, const char **tag)
+{
+	const struct submodule *sub;
+	char *key;
+	*tag = NULL;
+
+	sub = submodule_from_path(the_repository, null_oid(), path);
+	if (!sub)
+		return die_message(_("could not initialize submodule at path '%s'"),
+				   path);
+
+	key = xstrfmt("submodule.%s.tag", sub->name);
+	if (repo_config_get_string_tmp(the_repository, key, tag))
+		*tag = sub->tag;
+	free(key);
+
+	if (!*tag) {
+		/* No tag found */
+		return 1;
+	}
+
+	return 0;
+}
+
 static int remote_submodule_branch(const char *path, const char **branch)
 {
 	const struct submodule *sub;
@@ -2579,6 +2616,10 @@ static void update_data_to_args(const struct update_data *update_data,
 		strvec_push(args, update_data->single_branch ?
 				    "--single-branch" :
 				    "--no-single-branch");
+	if (update_data->single_tag >= 0)
+		strvec_push(args, update_data->single_tag ?
+				    "--single-branch" :
+				    "--no-single-branch");
 }
 
 static int update_submodule(struct update_data *update_data)
@@ -2606,16 +2647,22 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->remote) {
 		char *remote_name;
 		const char *branch;
+		const char *tag;
 		char *remote_ref;
 		int code;
 
 		code = get_default_remote_submodule(update_data->sm_path, &remote_name);
 		if (code)
 			return code;
-		code = remote_submodule_branch(update_data->sm_path, &branch);
-		if (code)
-			return code;
-		remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+		code = remote_submodule_tag(update_data->sm_path, &tag);
+		if (!code && update_data->single_tag) {
+				remote_ref = xstrfmt("refs/tags/%s", tag);
+		} else {
+			code = remote_submodule_branch(update_data->sm_path, &branch);
+			if (code)
+				return code;
+			remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+		}
 
 		free(remote_name);
 
@@ -2781,6 +2828,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			   N_("disallow cloning into non-empty directory, implies --init")),
 		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
+		OPT_BOOL(0, "single-tag", &opt.single_tag,
+			 N_("clone only one tag, --tag")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
@@ -2790,7 +2839,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		" [-N|--no-fetch] [-f|--force]"
 		" [--checkout|--merge|--rebase]"
 		" [--[no-]recommend-shallow] [--reference <repository>]"
-		" [--recursive] [--[no-]single-branch] [--] [<path>...]"),
+		" [--recursive] [--[no-]single-branch] [--[no-]single-tag] [--] [<path>...]"),
 		NULL
 	};
 
@@ -3058,6 +3107,52 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
+
+static int module_set_tag(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	const char *opt_tag = NULL;
+	const char *path;
+	char *config_name;
+	struct option options[] = {
+		/*
+		 * We accept the `quiet` option for uniformity across subcommands,
+		 * though there is nothing to make less verbose in this subcommand.
+		 */
+		OPT_NOOP_NOARG('q', "quiet"),
+
+		OPT_STRING('t', "tag", &opt_tag, N_("tag"),
+			N_("set the tracking tag")),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule set-tag [-q|--quiet] (-t|--tag) <tag> <path>"),
+		NULL
+	};
+	const struct submodule *sub;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (!opt_tag)
+		die(_("--tag required"));
+
+	if (argc != 1 || !(path = argv[0]))
+		usage_with_options(usage, options);
+
+	sub = submodule_from_path(the_repository, null_oid(), path);
+
+	if (!sub)
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		    path);
+
+	config_name = xstrfmt("submodule.%s.tag", sub->tag);
+	ret = config_set_in_gitmodules_file_gently(config_name, opt_tag);
+
+	free(config_name);
+	return !!ret;
+}
+
 static int module_create_branch(int argc, const char **argv, const char *prefix)
 {
 	enum branch_track track;
@@ -3098,6 +3193,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 struct add_data {
 	const char *prefix;
 	const char *branch;
+	const char *tag;
 	const char *reference_path;
 	char *sm_path;
 	const char *sm_name;
@@ -3219,7 +3315,9 @@ static int add_submodule(const struct add_data *add_data)
 		 */
 		strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
 
-		if (add_data->branch) {
+		if (add_data->tag) {
+			strvec_pushf(&cp.args, "%s", add_data->tag);
+		} else if (add_data->branch) {
 			strvec_pushl(&cp.args, "-B", add_data->branch, NULL);
 			strvec_pushf(&cp.args, "origin/%s", add_data->branch);
 		}
@@ -3272,7 +3370,11 @@ static void configure_added_submodule(struct add_data *add_data)
 	    config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo))
 		die(_("Failed to register submodule '%s'"), add_data->sm_path);
 
-	if (add_data->branch) {
+	if (add_data->tag) {
+		if (config_submodule_in_gitmodules(add_data->sm_name,
+						"tag", add_data->tag))
+			die(_("Failed to register submodule '%s'"), add_data->sm_path);
+	} else if (add_data->branch) {
 		if (config_submodule_in_gitmodules(add_data->sm_name,
 						   "branch", add_data->branch))
 			die(_("Failed to register submodule '%s'"), add_data->sm_path);
@@ -3371,6 +3473,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
+		OPT_STRING('t', "tag", &add_data.tag, N_("tag"),
+			   N_("tag of repository to add as submodule")),
 		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT__QUIET(&quiet, N_("print only error messages")),
@@ -3506,6 +3610,7 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
 		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
 		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
+		OPT_SUBCOMMAND("set-tag", &fn, module_set_tag),
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60a22d619a8..5e087bc443a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3057,6 +3057,9 @@ _git_remote ()
 	set-head,--*)
 		__gitcomp_builtin remote_set-head
 		;;
+	set-tag,--*)
+		__gitcomp_builtin remote_set-tag
+		;;
 	set-branches,--*)
 		__gitcomp_builtin remote_set-branches
 		;;
@@ -3471,7 +3474,7 @@ _git_submodule ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add status init deinit update set-branch set-url summary foreach sync absorbgitdirs"
+	local subcommands="add status init deinit update set-branch set-tag set-url summary foreach sync absorbgitdirs"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
@@ -3502,6 +3505,9 @@ _git_submodule ()
 			--force --rebase --merge --reference --depth --recursive --jobs
 		"
 		;;
+	set-tag,--*)
+		__gitcomp "--tag"
+		;;
 	set-branch,--*)
 		__gitcomp "--default --branch"
 		;;
diff --git a/git-submodule.sh b/git-submodule.sh
index 7f9582d9234..bbb17244d73 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,12 +6,13 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] [--cached]
-   or: $dashless [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+   or: $dashless [--quiet] add [-b <branch>] [-t <tag>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
+   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--[no-]single-tag] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
+   or: $dashless [--quiet] set-tag (--tag <tag>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
@@ -49,6 +50,7 @@ depth=
 progress=
 dissociate=
 single_branch=
+single_tag=
 jobs=
 recommend_shallow=
 filter=
@@ -77,6 +79,11 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		-t | --tag)
+			case "$2" in '') usage ;; esac
+			tag=$2
+			shift
+			;;
 		-f | --force)
 			force=$1
 			;;
@@ -129,7 +136,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"}  ${tag:+--tag "$tag"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -316,6 +323,12 @@ cmd_update()
 		--no-single-branch)
 			single_branch="--no-single-branch"
 			;;
+		--single-tag)
+			single_tag="--single-tag"
+			;;
+		--no-single-tag)
+			single_tag="--no-single-tag"
+			;;
 		--filter)
 			case "$2" in '') usage ;; esac
 			filter="--filter=$2"
@@ -355,6 +368,7 @@ cmd_update()
 		${require_init:+--require-init} \
 		${dissociate:+"--dissociate"} \
 		$single_branch \
+		$single_tag \
 		$recommend_shallow \
 		$jobs \
 		$filter \
@@ -402,6 +416,43 @@ cmd_set_branch() {
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${quiet:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
 }
 
+#
+# Configures a submodule's default tag
+#
+# $@ = requested path
+#
+cmd_set_tag() {
+	default=
+	tag=
+
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			# we don't do anything with this but we need to accept it
+			;;
+		-t|--tag)
+			case "$2" in '') usage ;; esac
+			tag=$2
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-tag ${quiet:+--quiet} ${tag:+--tag "$tag"} -- "$@"
+}
+
 #
 # Configures a submodule's remote url
 #
@@ -571,7 +622,7 @@ cmd_absorbgitdirs()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
+	add | foreach | init | deinit | update | set-branch | set-tag | set-url | status | summary | sync | absorbgitdirs)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/submodule-config.c b/submodule-config.c
index ec45ea67b95..a258406cced 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -93,6 +93,7 @@ static void free_one_config(struct submodule_entry *entry)
 	free((void *) entry->config->branch);
 	free((void *) entry->config->url);
 	free((void *) entry->config->ignore);
+	free((void *) entry->config->tag);
 	free((void *) entry->config->update_strategy.command);
 	free(entry->config);
 }
@@ -415,6 +416,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 	submodule->branch = NULL;
+	submodule->tag = NULL;
 	submodule->recommend_shallow = -1;
 
 	oidcpy(&submodule->gitmodules_oid, gitmodules_oid);
@@ -660,6 +662,8 @@ static int parse_config(const char *var, const char *value,
 	} else if (!strcmp(item.buf, "branch")) {
 		if (!value)
 			ret = config_error_nonbool(var);
+		else if (submodule->branch && submodule->tag)
+			die(_("can not specify both tag and branch '%s'"), var);
 		else if (!me->overwrite && submodule->branch)
 			warn_multiple_config(me->treeish_name, submodule->name,
 					     "branch");
@@ -667,6 +671,16 @@ static int parse_config(const char *var, const char *value,
 			free((void *)submodule->branch);
 			submodule->branch = xstrdup(value);
 		}
+	} else if (!strcmp(item.buf, "tag")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->tag)
+			warn_multiple_config(me->treeish_name, submodule->name,
+					     "tag");
+		else {
+			free((void *)submodule->tag);
+			submodule->tag = xstrdup(value);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index b6133af71b0..522683cc130 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -38,6 +38,7 @@ struct submodule {
 	enum submodule_recurse_mode fetch_recurse;
 	const char *ignore;
 	const char *branch;
+	const char *tag;
 	struct submodule_update_strategy update_strategy;
 	/* the object id of the responsible .gitmodules file */
 	struct object_id gitmodules_oid;

base-commit: d63586cb314731c851f28e14fc8012988467e2da
-- 
gitgitgadget

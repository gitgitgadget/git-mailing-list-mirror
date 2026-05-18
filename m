Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003F3E0745
	for <git@vger.kernel.org>; Mon, 18 May 2026 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091488; cv=none; b=CDvYmNNiW+605N8Bo2NP2ScxT8f3DpbK8e7DzKHUjMFE+0d2aF2gPbEjbHhnd9yg3PDqUq6HEWECKPlQwNEVrwFplWQG9jL9hY6UMaUpvNrqbw7G472w7q7BwR5lEwQAd+edaVgANhuzeUnhIvuurlJLOFlX1PzrQdlaBM9ppKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091488; c=relaxed/simple;
	bh=jR4rvehq+bo9mFMDCmcywhi9ADV2Vsa8zIACZCMTet4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WN3DZwfOhBb0dN74RM8p1577uspkPHaIdywmxV/eJCTr6v1ck9MhAvfQOYJOEB/LEKMbbexrc6HgxcJI9iuz/NDtpAxF2+NaQqTOIu4b+CoNtgh2xBwuGRctIjBRRyE/JiEzdOEoF1PLUqWluvQ4wFPDz3Urnt2LMDbaq6oKFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9MvQs1F; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9MvQs1F"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90ca6f20872so393745285a.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779091485; x=1779696285; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UxDNz92uJSNjC68qV1FzFrcf6uW67mqVXR4FSg8BMg=;
        b=H9MvQs1FVQeC4VR13/KNEjLGY1baDl4Acpy3i9+aC6lsctOxnnWAKGnB//16MSHYTG
         LBa6HUen0wvqOXxCfWXxGCumk54MFxN/GrOclot9ppRMezXsoRSC3zMZoCykI6qjL6uv
         KpFXvKqq3/kBUX5cnwlH7dgjQLvpcVMw9aDqxr34VUiyrj6kZLHAjJ5MbuOhFcEqUz/Y
         CzHJVD2DFYbshctVZsF7jux7gzhl5XdB+zwjWKDASj5OugCGLHuG65AALvncURGtJ1Dk
         46i8WKErTtbfa1yXOXc/3j9yuISk2EqdgcH3PUsRf1IMFjKctzpZggXyLRkeH9hSxU7X
         Zsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779091485; x=1779696285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UxDNz92uJSNjC68qV1FzFrcf6uW67mqVXR4FSg8BMg=;
        b=A1s4b/q51tDrVQ1uc/GnxEyuEUN6dtPqDPmtO96NSbF05kGMCpYant7w5Z2LsrxV2T
         1VkjjuXJNRtFiAeKd2WVBA4vB8TJ5n/IsUvhn0Lu0CNET4+RFvGW5P09CWvxrw7WFt4Q
         IEss849qliHEdmtdbTvoMK/7qzxs3oKMsx4PUAhkfAeXFnpuQTvQJ0yAc048WfH9PEC4
         akyXxSYRvF8/v7PrjJzpkXh4uDM1dxg1yhjdbV06iuDxb8lOICECGBl/I+iu60FRHlco
         Qn0PBL1C6uB9bFzDgurFdwSr1jbO0fAzxG6emM8ccl3IbnbVf1jeauizu/wUiLj8TyjA
         A03Q==
X-Gm-Message-State: AOJu0YzTlclPny5wpAqeT9WOg76PEvUcNT1xc+e8Q/BFEUPIuVqWi7YN
	MgQTXlZl+IBG9at3cMvFyMUj/p5maXmDpLliyIVHLngMq2PsGd1bfpd3LPPbWQ==
X-Gm-Gg: Acq92OHFQ/jiXxukFkzghGliEI9LduCHs3sSDAX6/kcTWDfg6M9aNfDZ326TEWjBiu9
	gUsSibHQI5v9ORTM7uEedVaLqL9jyhAOO1UXBqdHdSJ5hLWS8nUfIFhRcT8+PwbYtahTsBUWtiV
	w22CnAA5yAOWU99A6OtkMXBCX/eKg8CJaGs6DpKJnu4Mxt4ypqf91auBGKq2w/qbt6E8zQYY2Dr
	XjuXNaKoGkYcRH8AJqO30JAnkHXD8O9Ve2fwq0JVzZ77fE5efs7/X2X0iIXGLuuxrSzgsv7MpJM
	Wm9xRIu8rJqAUVREEZA1oo72NTGXjGOZcLoDjPlDctyANMeHlT7RlYKi6g2RKii5quZgHRxL5Ti
	S+IlIsQ9ZGUrjyRKGd05mlNy5J+J1/hqxykCJ3/dm2gq7WnT0dhGmqxqVHlGWSAt++jIVPDQRrI
	0Kk79IS8JQYoFtlTVsyVrkzKIxDVrMClufb6O5
X-Received: by 2002:a05:620a:3941:b0:8cd:aa61:ad8f with SMTP id af79cd13be357-911cf3f9237mr1875475685a.14.1779091484528;
        Mon, 18 May 2026 01:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.70.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e638sm1422262285a.9.2026.05.18.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:04:43 -0700 (PDT)
Message-Id: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v9.git.git.1778583307774.gitgitgadget@gmail.com>
References: <pull.2281.v9.git.git.1778583307774.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 08:04:43 +0000
Subject: [PATCH v10] checkout: extend --track with a "fetch" mode to refresh
 start-point
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Marc Branchaud <marcnarc@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

If you want to fork your topic branch from the very latest of the
tip of a branch your remote has, you would do:

    git fetch origin some-branch
    git checkout -b new_branch --track origin/some-branch

Extend the "--track" option of "git checkout" and allow users to
write

    git checkout -b new_branch --track=fetch origin/some-branch

to (1) fetch 'some-branch' from the remote 'origin', updating the
remote-tracking branch 'origin/some-branch', (2) arrange subsequent
'git pull' on 'new_branch' to interact with 'origin/some-branch' and
(3) fork 'new_branch' from it.

In the value of the '--track' option, 'fetch' can be combined with
the existing 'direct' (default) and 'inherit' modes via a
comma-separated list. Examples:

    git checkout -b new_branch --track=fetch,inherit some_local_branch
    git switch -c new_branch --track=fetch origin/some-branch

When "fetch" is requested and <start-point> is in <remote>/<branch>
form, run "git fetch <remote> <branch>" before resolving the ref, so
that other remote-tracking branches are left untouched. If
<start-point> is a bare remote name like "origin" (which resolves to
that remote's default branch), "git fetch <remote>" is run instead,
since the target branch is not known up front. Abort the checkout if
the fetch fails.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: --track=fetch
    
    Rebased to fix merge conflict with master.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v10
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v9:

 1:  021375e4cc ! 1:  a773fb6bdf checkout: extend --track with a "fetch" mode to refresh start-point
     @@ Documentation/git-checkout.adoc: of it").
       the refspec configured for the corresponding remote, and then stripping
      
       ## Documentation/git-switch.adoc ##
     -@@ Documentation/git-switch.adoc: should result in deletion of the path).
     +@@ Documentation/git-switch.adoc: variable.
       	attached to a terminal, regardless of `--quiet`.
       
       `-t`::
     @@ builtin/checkout.c
       #include "resolve-undo.h"
       #include "revision.h"
      +#include "run-command.h"
     + #include "sequencer.h"
       #include "setup.h"
       #include "strvec.h"
     - #include "submodule.h"
      @@ builtin/checkout.c: struct checkout_opts {
       	int count_checkout_paths;
       	int overlay_mode;


 Documentation/git-checkout.adoc |  13 ++-
 Documentation/git-switch.adoc   |  13 ++-
 builtin/checkout.c              | 168 +++++++++++++++++++++++++++++++-
 t/t7201-co.sh                   | 144 +++++++++++++++++++++++++++
 4 files changed, 332 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a8b3b8c2e2..ec63434159 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -158,11 +158,22 @@ of it").
 	resets _<branch>_ to the start point instead of failing.
 
 `-t`::
-`--track[=(direct|inherit)]`::
+`--track[=(direct|inherit|fetch)[,...]]`::
 	When creating a new branch, set up "upstream" configuration. See
 	`--track` in linkgit:git-branch[1] for details. As a convenience,
 	--track without -b implies branch creation.
 +
+The argument is a comma-separated list. `direct` (the default) and
+`inherit` select the tracking mode and are mutually exclusive. Adding
+`fetch` requests that the remote be fetched before _<start-point>_ is
+resolved, so the new branch starts from a fresh tip: when
+_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
+updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
+only the remote's default branch is updated. If the fetch fails and the
+corresponding remote-tracking ref already exists, a warning is printed
+and the checkout proceeds from the existing tip; otherwise the checkout
+is aborted.
++
 If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
 the refspec configured for the corresponding remote, and then stripping
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index d6c4f229a5..b5e79435cd 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -155,11 +155,22 @@ variable.
 	attached to a terminal, regardless of `--quiet`.
 
 `-t`::
-`--track[ (direct|inherit)]`::
+`--track[=(direct|inherit|fetch)[,...]]`::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
 +
+The argument is a comma-separated list. `direct` (the default) and
+`inherit` select the tracking mode and are mutually exclusive. Adding
+`fetch` requests that the remote be fetched before _<start-point>_ is
+resolved, so the new branch starts from a fresh tip: when
+_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
+updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
+only the remote's default branch is updated. If the fetch fails and the
+corresponding remote-tracking ref already exists, a warning is printed
+and the switch proceeds from the existing tip; otherwise the switch is
+aborted.
++
 If no `-c` option is given, the name of the new branch will be derived
 from the remote-tracking branch, by looking at the local part of the
 refspec configured for the corresponding remote, and then stripping
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1345e8574a..fc58456546 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -25,10 +25,12 @@
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "refspec.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "run-command.h"
 #include "sequencer.h"
 #include "setup.h"
 #include "strvec.h"
@@ -62,6 +64,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int fetch;
 	int discard_changes;
 	int accept_ref;
 	int accept_pathspec;
@@ -115,6 +118,158 @@ struct branch_info {
 	char *checkout;
 };
 
+static int resolve_fetch_target(const char *arg, char **remote_out,
+				char **src_ref_out, char **existing_ref_out)
+{
+	const char *slash;
+	char *remote_name = NULL;
+	struct remote *remote = NULL;
+	struct refspec_item query = { 0 };
+	struct strbuf dst = STRBUF_INIT;
+	struct object_id oid;
+	const char *rest = NULL;
+	const char *head_target = NULL;
+	const char *short_target;
+
+	*remote_out = NULL;
+	*src_ref_out = NULL;
+	*existing_ref_out = NULL;
+
+	if (!arg || !*arg || *arg == '/')
+		return -1;
+
+	slash = arg + strlen(arg);
+	while (1) {
+		free(remote_name);
+		remote_name = xstrndup(arg, slash - arg);
+		remote = remote_get(remote_name);
+		if (remote && remote_is_configured(remote, 1))
+			break;
+		while (slash > arg && *--slash != '/')
+			;
+		if (slash == arg) {
+			free(remote_name);
+			return -1;
+		}
+	}
+
+	if (*slash == '/' && slash[1])
+		rest = slash + 1;
+	if (!rest) {
+		strbuf_addf(&dst, "refs/remotes/%s/HEAD", remote_name);
+		head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						      dst.buf,
+						      RESOLVE_REF_READING |
+						      RESOLVE_REF_NO_RECURSE,
+						      &oid, NULL);
+		if (head_target) {
+			*existing_ref_out = xstrdup(dst.buf);
+			if (skip_prefix(head_target, "refs/remotes/", &short_target) &&
+			    skip_prefix(short_target, remote_name, &short_target) &&
+			    *short_target == '/')
+				rest = short_target + 1;
+		}
+		strbuf_reset(&dst);
+	}
+
+	if (rest) {
+		strbuf_addf(&dst, "refs/remotes/%s/%s", remote_name, rest);
+		query.dst = dst.buf;
+		if (!remote_find_tracking(remote, &query) && query.src) {
+			*src_ref_out = xstrdup(query.src);
+			free(query.src);
+		} else {
+			*src_ref_out = xstrdup(rest);
+		}
+		if (!*existing_ref_out) {
+			strbuf_reset(&dst);
+			strbuf_addf(&dst, "refs/remotes/%s", arg);
+			if (!refs_read_ref(get_main_ref_store(the_repository),
+					   dst.buf, &oid))
+				*existing_ref_out = xstrdup(dst.buf);
+		}
+	}
+
+	strbuf_release(&dst);
+	*remote_out = remote_name;
+	return 0;
+}
+
+static void fetch_remote_for_start_point(const char *arg)
+{
+	char *remote_name = NULL;
+	char *src_ref = NULL;
+	char *existing_ref = NULL;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	if (resolve_fetch_target(arg, &remote_name, &src_ref, &existing_ref))
+		return;
+
+	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
+	if (src_ref)
+		strvec_push(&cmd.args, src_ref);
+	cmd.git_cmd = 1;
+	if (run_command(&cmd)) {
+		if (existing_ref)
+			warning(_("failed to fetch start-point '%s'; "
+				  "using existing '%s'"),
+				arg, existing_ref);
+		else
+			die(_("failed to fetch start-point '%s'"), arg);
+	}
+
+	free(remote_name);
+	free(src_ref);
+	free(existing_ref);
+}
+
+static int parse_opt_checkout_track(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct checkout_opts *opts = opt->value;
+	struct string_list tokens = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	int saw_direct = 0, saw_inherit = 0;
+	int ret = 0;
+
+	opts->fetch = 0;
+
+	if (unset) {
+		opts->track = BRANCH_TRACK_NEVER;
+		return 0;
+	}
+
+	opts->track = BRANCH_TRACK_EXPLICIT;
+	if (!arg)
+		return 0;
+
+	string_list_split(&tokens, arg, ",", -1);
+	for_each_string_list_item(item, &tokens) {
+		if (!strcmp(item->string, "fetch")) {
+			opts->fetch = 1;
+		} else if (!strcmp(item->string, "direct")) {
+			saw_direct = 1;
+			opts->track = BRANCH_TRACK_EXPLICIT;
+		} else if (!strcmp(item->string, "inherit")) {
+			saw_inherit = 1;
+			opts->track = BRANCH_TRACK_INHERIT;
+		} else {
+			ret = error(_("option `%s' expects \"%s\", \"%s\", "
+				      "or \"%s\""),
+				    "--track", "direct", "inherit", "fetch");
+			goto out;
+		}
+	}
+
+	if (saw_direct && saw_inherit)
+		ret = error(_("option `%s' cannot combine \"%s\" and \"%s\""),
+			    "--track", "direct", "inherit");
+
+out:
+	string_list_clear(&tokens, 0);
+	return ret;
+}
+
 static void branch_info_release(struct branch_info *info)
 {
 	free(info->name);
@@ -1733,10 +1888,10 @@ static struct option *add_common_switch_branch_options(
 {
 	struct option options[] = {
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
-		OPT_CALLBACK_F('t', "track",  &opts->track, "(direct|inherit)",
+		OPT_CALLBACK_F('t', "track",  opts, "(direct|inherit|fetch)[,...]",
 			N_("set branch tracking configuration"),
 			PARSE_OPT_OPTARG,
-			parse_opt_tracking_mode),
+			parse_opt_checkout_track),
 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unborn branch")),
@@ -1941,8 +2096,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
-					     &new_branch_info, opts, &rev);
+		int n;
+
+		if (opts->fetch)
+			fetch_remote_for_start_point(argv[0]);
+
+		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
+					 &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7613b1d2a4..75b46494c0 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -870,4 +870,148 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'setup upstream for --track=fetch tests' '
+	git checkout main &&
+	git init fetch_upstream &&
+	test_commit -C fetch_upstream u_main &&
+	git remote add fetch_upstream fetch_upstream &&
+	git fetch fetch_upstream &&
+	git -C fetch_upstream checkout -b fetch_new &&
+	test_commit -C fetch_upstream u_new
+'
+
+test_expect_success 'checkout --track=fetch -b picks up branch created upstream after clone' '
+	git checkout main &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
+	git checkout --track=fetch -b local_new fetch_upstream/fetch_new &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD &&
+	test_cmp_config fetch_upstream branch.local_new.remote &&
+	test_cmp_config refs/heads/fetch_new branch.local_new.merge
+'
+
+test_expect_success 'checkout --track=fetch <remote>/<branch> leaves other tracking branches untouched' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_target &&
+	test_commit -C fetch_upstream u_target_pre &&
+	git -C fetch_upstream checkout -b fetch_other &&
+	test_commit -C fetch_upstream u_other_pre &&
+	git fetch fetch_upstream &&
+	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
+	git -C fetch_upstream checkout fetch_target &&
+	test_commit -C fetch_upstream u_target_post &&
+	git -C fetch_upstream checkout fetch_other &&
+	test_commit -C fetch_upstream u_other_post &&
+	git checkout --track=fetch -b local_target fetch_upstream/fetch_target &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
+'
+
+test_expect_success 'checkout --track=fetch with bare remote name fetches only <remote>/HEAD target' '
+	git checkout main &&
+	git -C fetch_upstream checkout main &&
+	git remote set-head fetch_upstream main &&
+	git -C fetch_upstream checkout -b fetch_unrelated &&
+	test_commit -C fetch_upstream u_unrelated_pre &&
+	git fetch fetch_upstream fetch_unrelated &&
+	unrelated_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated) &&
+	git -C fetch_upstream checkout main &&
+	test_commit -C fetch_upstream u_main_post &&
+	git -C fetch_upstream checkout fetch_unrelated &&
+	test_commit -C fetch_upstream u_unrelated_post &&
+	git checkout --track=fetch -b local_from_remote fetch_upstream &&
+	test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated)" = "$unrelated_before"
+'
+
+test_expect_success 'checkout --track=fetch aborts and does not create branch when no existing ref' '
+	git checkout main &&
+	test_might_fail git branch -D bogus &&
+	test_must_fail git checkout --track=fetch -b bogus fetch_upstream/does_not_exist &&
+	test_must_fail git rev-parse --verify refs/heads/bogus
+'
+
+test_expect_success 'checkout --track=fetch warns and proceeds when fetch fails but ref exists' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_offline &&
+	test_commit -C fetch_upstream u_offline &&
+	git fetch fetch_upstream fetch_offline &&
+	saved_url=$(git config remote.fetch_upstream.url) &&
+	test_when_finished "git config remote.fetch_upstream.url \"$saved_url\"" &&
+	git config remote.fetch_upstream.url ./does-not-exist &&
+	git checkout --track=fetch -b local_offline fetch_upstream/fetch_offline 2>err &&
+	test_grep "failed to fetch" err &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_offline HEAD
+'
+
+test_expect_success 'checkout --track=fetch resolves through configured fetch refspec' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_refspec &&
+	test_commit -C fetch_upstream u_refspec &&
+	git fetch fetch_upstream fetch_refspec &&
+	git remote add fetch_custom ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_custom" &&
+	git config --replace-all remote.fetch_custom.fetch \
+		"+refs/heads/*:refs/remotes/custom-ns/*" &&
+	git fetch fetch_custom &&
+	test_commit -C fetch_upstream u_refspec_post &&
+	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
+	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
+'
+
+test_expect_success 'checkout --track=fetch handles hierarchical remote name' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_hier &&
+	test_commit -C fetch_upstream u_hier &&
+	git remote add nested/remote ./fetch_upstream &&
+	test_when_finished "git remote remove nested/remote" &&
+	git fetch nested/remote fetch_hier &&
+	test_commit -C fetch_upstream u_hier_post &&
+	git checkout --track=fetch -b local_hier nested/remote/fetch_hier &&
+	test_cmp_rev refs/remotes/nested/remote/fetch_hier HEAD
+'
+
+test_expect_success 'checkout --track=inherit,direct is rejected' '
+	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
+	test_grep "cannot combine" err
+'
+
+test_expect_success 'checkout --track=fetch then --track=direct drops fetch (last-one-wins)' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_lastwin &&
+	test_commit -C fetch_upstream u_lastwin &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin &&
+	test_must_fail git checkout --track=fetch --track=direct \
+		-b local_lastwin fetch_upstream/fetch_lastwin &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin
+'
+
+test_expect_success 'checkout --track=fetch,inherit fetches and inherits' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_inherit &&
+	test_commit -C fetch_upstream u_inherit &&
+	git fetch fetch_upstream fetch_inherit &&
+	git checkout -b base_inherit fetch_upstream/fetch_inherit &&
+	test_commit -C fetch_upstream u_inherit2 &&
+	git checkout main &&
+	git checkout --track=fetch,inherit -b local_inherit base_inherit &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD &&
+	test_cmp_config fetch_upstream branch.local_inherit.remote &&
+	test_cmp_config refs/heads/fetch_inherit branch.local_inherit.merge
+'
+
+test_expect_success 'checkout --track=bogus reports an error' '
+	git checkout main &&
+	test_must_fail git checkout --track=bogus -b bogus_branch fetch_upstream/fetch_new 2>err &&
+	test_grep "expects" err
+'
+
+test_expect_success 'switch --track=fetch -c picks up branch created upstream after clone' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_switch &&
+	test_commit -C fetch_upstream u_switch &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
+	git switch --track=fetch -c local_switch fetch_upstream/fetch_switch &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
+'
+
 test_done

base-commit: 68aca6b91299738150f71035d0033af6987fe455
-- 
gitgitgadget

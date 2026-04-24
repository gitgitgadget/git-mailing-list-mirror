Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AABA34
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024996; cv=none; b=a40xqvrbGHATIkYyXsDmi2hD5SFYcabzjcUCJZJRTY5g4+O+Wu+ktk3KZEKinMC/GI+ea4Op6+4Vf5PJKPxZyKXgKj4kmIWkVkFDaUJiqQn/xUATTHqP4WHuQhAmWxZw15y9eHlSbgvb9evh4w6gQH1tZgdyiyf3lkm517dDLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024996; c=relaxed/simple;
	bh=EM2MN5n+cLcZECSaKPATBYSGPlFuhBhFRVam7nvkHHY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bDmbscZMbpb/dYkJwV7alTZdK2zlOnposccKaTanE73leALUp42pFlID6GcovYucjhWdS9wr4XXJsWPx6stRmu0PVRb8VABjzWbu282Mp+EgRRSgE4XVAFqelvtB747DkeG67o7cOVrfHHncpADuKpZmYXcpzJu34tYVYyXn81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0dpjNTV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0dpjNTV"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d933da14f0so720097785a.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777024993; x=1777629793; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nWbZ9UCPRWP43PAn0oB8E6cUQoHRZGLhquelL7wQXZM=;
        b=a0dpjNTVZgLEtZemQFMtTIiRFc9b2NY9Gn4FEWr8GbXGIksAieusKcThki1ohs23cc
         X1De8Ml3/fjQZmZsorypThex26zWVgBX9YvqSDzXRdvxSOuJ44Jou/WgWl2Bc/mY03ZG
         mL3/npNSTZIv3VK63Pzaf7DLhN/rtQ3DDzlqfWNwukbaWvqGVW6x/10EEJfaGEKRIZ+d
         LHKhE0NGk/cSl4A2dhZ319qM/dTajkrZfAHugx5p1mFDCoa0+Vy0klhCjRtULKoZqXD1
         h3C4gO0KEOGP0JwuaKPuBNbJEAVAAkhuVVxxrDaIMIG13cSiFEImExcSX1BuEmb2eSHP
         gnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024993; x=1777629793;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWbZ9UCPRWP43PAn0oB8E6cUQoHRZGLhquelL7wQXZM=;
        b=USgUstMbpsg3jOFtmcaP7nQWxZoSpYq5CaaF2mOJxZnP92v8uwqYu68uhEML4P+bkz
         8S/H3VVwf6M16d80JbwxmC/BHCnJMDznwxCijv6Hz/b1ySYdhcTRyWZMJsa1I7XLyzK5
         lU2aaqnqJkOcR1VoSn4TRTn8dz01T5h8HwI0Jn8zdLs4Fksuu5f88McWjUENBLw+E3Ek
         dHrWbL/Ss/9luCU5PCpaB7jYa+fFbqOHrC5BckrvtVRIXVOS7DS4g9vhe4KJyXVjjTOh
         xnsARfM8svyxydlrQShFc2c5aMl/Lazh2GzVrIUbpgG+/Pxsaf6FxTY1ocep2BtjbbdE
         nJXw==
X-Gm-Message-State: AOJu0YwJowm/COUXOQlIle7KA771zwxQPJuzDSZBdxt/ODevOFySFv2q
	fw3BkQHsqXHCEuH53WP8Ug1C3JhKH/uLNRLQZgvjb8CM7HdypEjA9kGKe5tDPA==
X-Gm-Gg: AeBDieu4z/qswUKyqTyeN0iNQio9t3qIiKcK74R3A1AMiTZ13y3/AydnylP2TTPngfO
	ibAihQNna5GYm0Bgq5ksBjP1qUCKJ3ZemmFLNAqBfYf4FJEbPSE9z76ShugzMHjz0pP/wv/I4Ny
	h/5PTdMYQMfMpCTPmQEvpoz8D3WSQLcEwFEi/Ffe0vJ96H3Ugasj0N39mxSfiW9spxcO7EtIvNv
	rQ2NbGH7+8gxfZjQc+cCAU683sMU3yd7wsMQ7WN2W12teu17XC1kwDiie/stbWn3ChhMAFV3Op2
	ct86ZvrvSVZxkAbE+QJMaZlXAd14gV5DNZtM+3V1JzjvBifWWwIo+KbnbVa3fg5zD76nxxsG//P
	NAD+fjsYhoC7Wm0d9OGDb2So5VwmDzSIncPuJI81eC426ryGRBYITNOKK8ZsAviq5sZ40/F9XqZ
	EW9UHVxlz1duXtpV7Pg1dP+SIQ288GVstT56cP
X-Received: by 2002:a05:622a:4b19:b0:50e:601a:2183 with SMTP id d75a77b69052e-50e601a24f2mr283269111cf.41.1777024992880;
        Fri, 24 Apr 2026 03:03:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.29.102])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e393ffe64sm215939621cf.14.2026.04.24.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 03:03:12 -0700 (PDT)
Message-Id: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 10:03:11 +0000
Subject: [PATCH] checkout: add --fetch to fetch remote before resolving
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a --fetch option to git checkout and git switch, plus a
checkout.autoFetch config to enable it by default. When set and the
start-point argument names a configured remote (either bare, like
"origin", or prefixed, like "origin/foo"), fetch that remote before
resolving the ref. Aborts the checkout if the fetch fails.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: add --fetch to fetch remote before resolving start-point
    
    A workflow I run several times a day looks like:
    
    git fetch origin
    git checkout -b new_branch origin/some-branch
    
    
    The first command exists purely to make the second one see an up-to-date
    view of the remote. If I forget it, origin/some-branch points at a stale
    commit, and I end up creating a local branch from the wrong starting
    point.
    
    This series teaches git checkout (and git switch) a new --fetch flag
    that folds the two steps into one:
    
    git checkout --fetch -b new_branch origin/some-branch
    
    
    When the start-point argument names a configured remote — either bare
    (origin, which resolves to the remote's default branch) or in / form —
    git fetch is run before the start-point is resolved. If the fetch fails,
    the checkout aborts and no local branch is created.
    
    A new checkout.autoFetch config option enables the same behavior by
    default, for users who always want it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v1
Pull-Request: https://github.com/git/git/pull/2281

 builtin/checkout.c    | 48 ++++++++++++++++++++++++++++++++++++++--
 t/t7201-co.sh         | 51 +++++++++++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh |  1 +
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..c8fbc4923b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -30,7 +30,9 @@
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "run-command.h"
 #include "setup.h"
+#include "strvec.h"
 #include "submodule.h"
 #include "symlinks.h"
 #include "trace2.h"
@@ -61,6 +63,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int auto_fetch;
 	int discard_changes;
 	int accept_ref;
 	int accept_pathspec;
@@ -112,6 +115,34 @@ struct branch_info {
 	char *checkout;
 };
 
+static void fetch_remote_for_start_point(const char *arg)
+{
+	const char *slash;
+	char *remote_name;
+	struct remote *remote;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	if (!arg || !*arg)
+		return;
+
+	slash = strchr(arg, '/');
+	if (slash == arg)
+		return;
+	remote_name = slash ? xstrndup(arg, slash - arg) : xstrdup(arg);
+
+	remote = remote_get(remote_name);
+	if (!remote || !remote_is_configured(remote, 1)) {
+		free(remote_name);
+		return;
+	}
+
+	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
+	cmd.git_cmd = 1;
+	free(remote_name);
+	if (run_command(&cmd))
+		die(_("failed to fetch start-point '%s'"), arg);
+}
+
 static void branch_info_release(struct branch_info *info)
 {
 	free(info->name);
@@ -1237,6 +1268,10 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.autofetch")) {
+		opts->auto_fetch = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
@@ -1942,8 +1977,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
-					     &new_branch_info, opts, &rev);
+		int n;
+
+		if (opts->auto_fetch)
+			fetch_remote_for_start_point(argv[0]);
+
+		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
+					 &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -2052,6 +2092,8 @@ int cmd_checkout(int argc,
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
 			 N_("auto advance to the next file when selecting hunks interactively")),
+		OPT_BOOL(0, "fetch", &opts.auto_fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking ref")),
 		OPT_END()
 	};
 
@@ -2102,6 +2144,8 @@ int cmd_switch(int argc,
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
+		OPT_BOOL(0, "fetch", &opts.auto_fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking ref")),
 		OPT_END()
 	};
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..60ddebd9c3 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -801,4 +801,55 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'setup upstream for --fetch tests' '
+	git checkout main &&
+	git init fetch_upstream &&
+	test_commit -C fetch_upstream u_main &&
+	git remote add fetch_upstream fetch_upstream &&
+	git fetch fetch_upstream &&
+	git -C fetch_upstream checkout -b fetch_new &&
+	test_commit -C fetch_upstream u_new
+'
+
+test_expect_success 'checkout --fetch -b picks up branch created upstream after clone' '
+	git checkout main &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
+	git checkout --fetch -b local_new fetch_upstream/fetch_new &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD
+'
+
+test_expect_success 'checkout --fetch with bare remote name fetches the remote' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_new2 &&
+	test_commit -C fetch_upstream u_new2 &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2 &&
+	git checkout --fetch -b local_from_remote fetch_upstream &&
+	git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2
+'
+
+test_expect_success 'checkout --fetch aborts and does not create branch on fetch failure' '
+	git checkout main &&
+	test_might_fail git branch -D bogus &&
+	test_must_fail git checkout --fetch -b bogus fetch_upstream/does_not_exist &&
+	test_must_fail git rev-parse --verify refs/heads/bogus
+'
+
+test_expect_success 'checkout.autoFetch=true enables fetching without --fetch' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_cfg &&
+	test_commit -C fetch_upstream u_cfg &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
+	git -c checkout.autoFetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_cfg HEAD
+'
+
+test_expect_success 'switch --fetch -c picks up branch created upstream after clone' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_switch &&
+	test_commit -C fetch_upstream u_switch &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
+	git switch --fetch -c local_switch fetch_upstream/fetch_switch &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..dc1d63669f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2602,6 +2602,7 @@ test_expect_success 'double dash "git checkout"' '
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
 	--auto-advance Z
+	--fetch Z
 	--progress Z
 	--guess Z
 	--no-guess Z

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget

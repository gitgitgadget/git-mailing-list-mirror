Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887936682A
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140761; cv=none; b=lyaQUPsPpTmAz4c3RLWIsa+OZlH6cR8lj0HTwl44mdlunLXVE8Lm7PCP6Ud/CSoudrotwMO73RxWU8p52DYkyn6FNtRSEb6pKDSpARdhCjyxCVo5QQJfNOeYn4h82TcyVi9/eQdkxaf77RVm7T3QDf9duAyULY6qgqKOw9mY1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140761; c=relaxed/simple;
	bh=P2fY9EOlMLNq1LZgfAv/BppGWKZEHPu/qQflMICs+ww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aabj+FA8U0ILR+t5CdyUXYBtK5AkvNMCEvxgOCCX/odi2iK/AFswqEvW+ZjtBiZxynm5qv3hoR1S6py5+WzVGbFGQmY+WW1INelImiZhJYl+gWV1Xc8y4TqiMWAskiCrNSYrw5nYvohxlSjKAbKr/OIlP+B3UNOpghrkYKHM+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0H2kSwu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0H2kSwu"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso140710466d6.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777140758; x=1777745558; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjBOTDJT5LHC25XAPT6lxLu4ZiSap1fR4JjVsWoamo4=;
        b=X0H2kSwuqTPIczn04nZi0+HIa62JFirg25QHOAz/IEPhPmLdADIYnFR/FhZPnDk3eF
         0NKhLhkaBG56LcvLqV6KMw+fh4lDmY/rGUGI+/Ed+cCu9MpVrku/A2VU+KShh8eSqYDS
         Ep/z+Wa15tNv23BvckHrk06b305DCxrUWoyIjYmEWVB/8G4nYcWRUzRNqEFLdFw1KPlW
         BpyLXMlN1rpais/L0ZzrRo5tpM7mkc7jkvNSXnxBa1kkfCZY3/p0UPP5L9HXXwbuAd8j
         +Eaaeh4c/V7T0pHBbc5E2yeyjbtUIuoUqrP+Ur26F+wQFPtQS+FHS9ERGOPAYsgccsiI
         VVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777140758; x=1777745558;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjBOTDJT5LHC25XAPT6lxLu4ZiSap1fR4JjVsWoamo4=;
        b=QaR6Pp7gaZ6rb4mRVHKxHW1fjWSRSXQB4NPIiFFAyD3mgG74p9iMB0Hxg286RGFQGu
         dQYXRybbgRJ8VmxNqhxlCATka2N5W7M4QwbCLJv7p5gSfyj81RTOMUGL1crBbjtwzw4o
         w8AYT4szPOfePUoocoMjsqU+Ffgb1cZ0UB0bzNpLWIcaQ6LaApIAyL/yqKhA8lkDqoeR
         XOlBSU3iIPgGjY2H49zB/9+S041RMS6VN0TkTHyRTaHRkQBZI3cv6+scKfy12P6eiFst
         2wzl31d7gOPM/WxnIco9HL/xLrUvQwdBmE7AF8ppXugT+4UzoHxzLI20tkxJCpmGxwji
         Ekgw==
X-Gm-Message-State: AOJu0YwyJz2U0X8IliVE+0/6SdD2Rd36CuB1OkCPNN5M0HkHgKM2eDRw
	ts90i8Hq6Dq/2dhoU7Jm7i1Db2PVydv6GFJN2MH/zuEHDp9KxgwjqzAUcGIqT+iP
X-Gm-Gg: AeBDiesan/VFzB8vVY1TULAUSDWJsqJ2tTNAsPNurE9wRtCcDImoiRp3Xza4Br8JYEQ
	GkUCM9OfwIx/WXZm6ToPf1AhkSLPis7aWnPV4HH1twWQmG5p1AJBINtqG9Iv4Aeberv2RZm+URA
	ETnn9MJq7rpLNfoV7tcq+hGZUf26O8FGI1/+UftwqO/pXAVyATUtBCNhjsVe3lzrJ2pwN99dJo4
	Zsdg0hcEL+lV1skpht6dd0v07BI4/9gYHYAE3jVXonplY1YmrAbAQSts6P87nZshYcxctbLq0CK
	dQTbkKqATzhHw46p5LqwOz0c6rw1zdBbO+AgINCbwe07d82kfB2ZkVNFL4V4d6Q+v+BDKhuXxQJ
	9j8uxvVYQgZmK525v7J8Zbnznp0GxJAqHRsYrMKhXeCfyC0/KjSQmU2ytqkkuSb8bwnF4jZi2qP
	qPxIO3Cz6Wfq5cOSMEMydVhWBSPQ3I9Y8NpkU=
X-Received: by 2002:a05:6214:27ee:b0:8ac:b1ad:3a29 with SMTP id 6a1803df08f44-8b02816b33emr568619746d6.35.1777140758071;
        Sat, 25 Apr 2026 11:12:38 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.37.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae97d89sm220436106d6.42.2026.04.25.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:12:36 -0700 (PDT)
Message-Id: <pull.2281.v2.git.git.1777140755373.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 18:12:35 +0000
Subject: [PATCH v2] checkout: add --fetch to fetch remote before resolving
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A common workflow is:

    git fetch origin
    git checkout -b new_branch origin/some-branch

The first command exists purely so the second sees an up-to-date view
of the remote. If it is forgotten, origin/some-branch points at a stale
commit and the new local branch is created from the wrong start point.

Teach checkout (and switch) a --fetch flag that folds the two steps
into one:

    git checkout --fetch -b new_branch origin/some-branch

When --fetch is given and <start-point> names a configured remote
(either bare, like "origin", or prefixed, like "origin/foo"), fetch
that remote before resolving the ref. Abort the checkout if the fetch
fails.

Also add a checkout.fetch config to enable this by default.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: add --fetch to fetch remote before resolving start-point
    
     * Rename the config from checkout.autoFetch to checkout.fetch, so it
       matches the --fetch option name.
    
     * Rename the internal struct field from auto_fetch to fetch for
       consistency with the option and config names.
    
     * Reword the commit message to lead with the problem (forgetting 'git
       fetch' and ending up with a stale start-point) before describing the
       solution.
    
     * Document --fetch / --no-fetch in git-checkout and git-switch, and
       document checkout.fetch in the config reference.
    
     * Use "remote-tracking branch" instead of "remote-tracking ref" in the
       option help text.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v2
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v1:

 1:  e2fa50ff40 ! 1:  13074c9fea checkout: add --fetch to fetch remote before resolving start-point
     @@ Metadata
       ## Commit message ##
          checkout: add --fetch to fetch remote before resolving start-point
      
     -    Add a --fetch option to git checkout and git switch, plus a
     -    checkout.autoFetch config to enable it by default. When set and the
     -    start-point argument names a configured remote (either bare, like
     -    "origin", or prefixed, like "origin/foo"), fetch that remote before
     -    resolving the ref. Aborts the checkout if the fetch fails.
     +    A common workflow is:
     +
     +        git fetch origin
     +        git checkout -b new_branch origin/some-branch
     +
     +    The first command exists purely so the second sees an up-to-date view
     +    of the remote. If it is forgotten, origin/some-branch points at a stale
     +    commit and the new local branch is created from the wrong start point.
     +
     +    Teach checkout (and switch) a --fetch flag that folds the two steps
     +    into one:
     +
     +        git checkout --fetch -b new_branch origin/some-branch
     +
     +    When --fetch is given and <start-point> names a configured remote
     +    (either bare, like "origin", or prefixed, like "origin/foo"), fetch
     +    that remote before resolving the ref. Abort the checkout if the fetch
     +    fails.
     +
     +    Also add a checkout.fetch config to enable this by default.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## Documentation/config/checkout.adoc ##
     +@@ Documentation/config/checkout.adoc: commands or functionality in the future.
     + 	option in `git checkout` and `git switch`. See
     + 	linkgit:git-switch[1] and linkgit:git-checkout[1].
     + 
     ++`checkout.fetch`::
     ++	Provides the default value for the `--fetch` or `--no-fetch`
     ++	option in `git checkout` and `git switch`. See
     ++	linkgit:git-switch[1] and linkgit:git-checkout[1].
     ++
     + `checkout.workers`::
     + 	The number of parallel workers to use when updating the working tree.
     + 	The default is one, i.e. sequential execution. If set to a value less
     +
     + ## Documentation/git-checkout.adoc ##
     +@@ Documentation/git-checkout.adoc: linkgit:git-config[1].
     + The default behavior can be set via the `checkout.guess` configuration
     + variable.
     + 
     ++`--fetch`::
     ++`--no-fetch`::
     ++	If _<start-point>_ names a configured remote -- either bare,
     ++	like `origin` (which resolves to the remote's default branch),
     ++	or in _<remote>/<branch>_ form -- run `git fetch` on that
     ++	remote before resolving _<start-point>_. If the fetch fails,
     ++	the checkout is aborted and no local branch is created.
     +++
     ++The default behavior can be set via the `checkout.fetch` configuration
     ++variable.
     ++
     + `-l`::
     + 	Create the new branch's reflog; see linkgit:git-branch[1] for
     + 	details.
     +
     + ## Documentation/git-switch.adoc ##
     +@@ Documentation/git-switch.adoc: ambiguous but exists on the 'origin' remote. See also
     + The default behavior can be set via the `checkout.guess` configuration
     + variable.
     + 
     ++`--fetch`::
     ++`--no-fetch`::
     ++	If _<start-point>_ names a configured remote -- either bare,
     ++	like `origin` (which resolves to the remote's default branch),
     ++	or in _<remote>/<branch>_ form -- run `git fetch` on that
     ++	remote before resolving _<start-point>_. If the fetch fails,
     ++	the switch is aborted and no local branch is created.
     +++
     ++The default behavior can be set via the `checkout.fetch` configuration
     ++variable.
     ++
     + `-f`::
     + `--force`::
     + 	An alias for `--discard-changes`.
     +
       ## builtin/checkout.c ##
      @@
       #include "repo-settings.h"
     @@ builtin/checkout.c: struct checkout_opts {
       	int count_checkout_paths;
       	int overlay_mode;
       	int dwim_new_local_branch;
     -+	int auto_fetch;
     ++	int fetch;
       	int discard_changes;
       	int accept_ref;
       	int accept_pathspec;
     @@ builtin/checkout.c: static int git_checkout_config(const char *var, const char *
       		opts->dwim_new_local_branch = git_config_bool(var, value);
       		return 0;
       	}
     -+	if (!strcmp(var, "checkout.autofetch")) {
     -+		opts->auto_fetch = git_config_bool(var, value);
     ++	if (!strcmp(var, "checkout.fetch")) {
     ++		opts->fetch = git_config_bool(var, value);
      +		return 0;
      +	}
       
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
      -					     &new_branch_info, opts, &rev);
      +		int n;
      +
     -+		if (opts->auto_fetch)
     ++		if (opts->fetch)
      +			fetch_remote_for_start_point(argv[0]);
      +
      +		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
     @@ builtin/checkout.c: int cmd_checkout(int argc,
       		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
       		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
       			 N_("auto advance to the next file when selecting hunks interactively")),
     -+		OPT_BOOL(0, "fetch", &opts.auto_fetch,
     -+			 N_("fetch from the remote first if <start-point> is a remote-tracking ref")),
     ++		OPT_BOOL(0, "fetch", &opts.fetch,
     ++			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
       		OPT_END()
       	};
       
     @@ builtin/checkout.c: int cmd_switch(int argc,
       			 N_("second guess 'git switch <no-such-branch>'")),
       		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
       			 N_("throw away local modifications")),
     -+		OPT_BOOL(0, "fetch", &opts.auto_fetch,
     -+			 N_("fetch from the remote first if <start-point> is a remote-tracking ref")),
     ++		OPT_BOOL(0, "fetch", &opts.fetch,
     ++			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
       		OPT_END()
       	};
       
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_must_fail git rev-parse --verify refs/heads/bogus
      +'
      +
     -+test_expect_success 'checkout.autoFetch=true enables fetching without --fetch' '
     ++test_expect_success 'checkout.fetch=true enables fetching without --fetch' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_cfg &&
      +	test_commit -C fetch_upstream u_cfg &&
      +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
     -+	git -c checkout.autoFetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
     ++	git -c checkout.fetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
      +	test_cmp_rev refs/remotes/fetch_upstream/fetch_cfg HEAD
      +'
      +


 Documentation/config/checkout.adoc |  5 +++
 Documentation/git-checkout.adoc    | 11 +++++++
 Documentation/git-switch.adoc      | 11 +++++++
 builtin/checkout.c                 | 48 ++++++++++++++++++++++++++--
 t/t7201-co.sh                      | 51 ++++++++++++++++++++++++++++++
 t/t9902-completion.sh              |  1 +
 6 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/checkout.adoc
index e35d212969..c95f72b38e 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -22,6 +22,11 @@ commands or functionality in the future.
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
 
+`checkout.fetch`::
+	Provides the default value for the `--fetch` or `--no-fetch`
+	option in `git checkout` and `git switch`. See
+	linkgit:git-switch[1] and linkgit:git-checkout[1].
+
 `checkout.workers`::
 	The number of parallel workers to use when updating the working tree.
 	The default is one, i.e. sequential execution. If set to a value less
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..f20e2f4c8c 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -201,6 +201,17 @@ linkgit:git-config[1].
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
+`--fetch`::
+`--no-fetch`::
+	If _<start-point>_ names a configured remote -- either bare,
+	like `origin` (which resolves to the remote's default branch),
+	or in _<remote>/<branch>_ form -- run `git fetch` on that
+	remote before resolving _<start-point>_. If the fetch fails,
+	the checkout is aborted and no local branch is created.
++
+The default behavior can be set via the `checkout.fetch` configuration
+variable.
+
 `-l`::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..3826ed9066 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -110,6 +110,17 @@ ambiguous but exists on the 'origin' remote. See also
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
+`--fetch`::
+`--no-fetch`::
+	If _<start-point>_ names a configured remote -- either bare,
+	like `origin` (which resolves to the remote's default branch),
+	or in _<remote>/<branch>_ form -- run `git fetch` on that
+	remote before resolving _<start-point>_. If the fetch fails,
+	the switch is aborted and no local branch is created.
++
+The default behavior can be set via the `checkout.fetch` configuration
+variable.
+
 `-f`::
 `--force`::
 	An alias for `--discard-changes`.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..b2a34f0f00 100644
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
+	int fetch;
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
+	if (!strcmp(var, "checkout.fetch")) {
+		opts->fetch = git_config_bool(var, value);
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
+		if (opts->fetch)
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
+		OPT_BOOL(0, "fetch", &opts.fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
 		OPT_END()
 	};
 
@@ -2102,6 +2144,8 @@ int cmd_switch(int argc,
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
+		OPT_BOOL(0, "fetch", &opts.fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
 		OPT_END()
 	};
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..f5729f0831 100755
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
+test_expect_success 'checkout.fetch=true enables fetching without --fetch' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_cfg &&
+	test_commit -C fetch_upstream u_cfg &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
+	git -c checkout.fetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
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

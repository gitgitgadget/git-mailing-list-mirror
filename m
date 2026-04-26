Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0241552FD
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777228352; cv=none; b=JFNASnxcnmCmhTUEVGKF0B0wIw0UmPQIdJ+tRzFqvJEBVW9ykp0zaKYL9QBLbGSbwPvVpcgMa9brSSpmCxBnD94PfjK779Xlb7B1Db9cGrJbybz5wqQDiswj+z1uRxuxnds5dzwhe1td4mzHsteRalQkerQXAXxQczPf8zNJRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777228352; c=relaxed/simple;
	bh=UYQoMdSAbaFMrBGcmKmN05k6PRE7xucDRDWf1HE/78I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V+I7jm7+VOOcwPxeVWTN6uoegPdolcCuapB24WRPX9zzsevkYWfdiOkHa2rpDTYpLLxMsC563Hdmyd4LQg8pZSsMkOPGPJwjOd8qQI7B3q8k40oDZNs49a8kZj0tJssERzlPj98e/spCubdIDTz5368gkhGbV3ukHdcoaJA9V00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrLVy9Nz; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrLVy9Nz"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d1872504cbso8106650a34.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777228349; x=1777833149; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oc2Q2qZpDuDy9iATSAXi2ciXRGjLJpFv4HKCmtjyOM=;
        b=jrLVy9NzszazM6LACaFEsXIBacSyfEl+mcMIkI05fLN3GkfIIdkactxtlogaJDnZzQ
         whAc47eJcOHcSrn/MqM85IfIhc0bf+22Y4VTTPhmaZ31lCHXvR5+czl1fidTxkGm+bjT
         Yp/OjxIqzL114vyvUP0n2FiALSSpSvlJsVEIupide1DBoxCa/oiwbDw/cyVq/tMeeg+O
         lS2HZlnmZU86hKC9b79kSKr+nHpJWA3+IVKF4NvSt6rCe0pZC49MYI0nJ9I5Crcz05nZ
         1F92VsCY+4Nfv67PHU935gP29effXNK/f0YdhAr1vnVmra+XoXxgjEFmld2nw85NR1go
         V7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777228349; x=1777833149;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+oc2Q2qZpDuDy9iATSAXi2ciXRGjLJpFv4HKCmtjyOM=;
        b=SrzXvQ9p0ywtsflMz6enggV2ATfvKBZArQNL3wKu9UhvMKrL/a2I7sX+OFil2X05GH
         jhf+MJQvApPzsnTXD0n9ajbs34cbSf3uqX4yASAFMxT8/XkSoZrHF0Fa+pKfA+GD55xc
         KSxhOLNq3rkbKvGEC3RCilTxlgmosY1HaddUa0jVPJrGrBO79FXKBZrkqp4MLJhSYiD1
         yzdwln7QZXj/OPbGhPCxUakbZI4HC6jIqR+u5aXySKGKDpp53F5Y3gSH1abq4y0PeHU4
         gFSox3qMuyWoATLx9QxOVXai1k0If+DbX5i4Ri04vHWFxd191uVhcSG+RZY4r5IXwe+f
         oHPg==
X-Gm-Message-State: AOJu0YxXOeXln57AUD7cI0MZ0AcHobrpE5+Rl0HjSh00UvBGGk9IPw4p
	alo4bcdTUxWDGArvzBHFy3A3DnxCga8605heE2rnvfqGJSwNh5WvZLjDnPuzlw==
X-Gm-Gg: AeBDieurpdYQBWHCAg3qa6fIVSMIBa7/whVb//JdqsEVHY1/ud+EnTU84e76Y8+y2Ot
	R5yHeeUbwrxgYxt+C4TvKlqQsPfGC5FeH4ahucS/TXg8xbYCSaRdEC9EvHponmLGrzjkYptjcSV
	bMLHrAg3vYr7cGKBU3WStJh3SKzFc2uCOXSOaLCnhRQEXFGiEbP14r8EL2RLHs9a73+lhMNjc0t
	mYqrLIg02prZ4BtJRGb3nC4K0LK5TMzPzABWTvW795byUZHZF1+xqXmwNbT2NsTXmwi6X3jXT8k
	/6fMpbi+xtnhFikaXgcRzbZtWTkDWqiRAwCcE2SoU6x4lf7/xmne978TNyU0/rbE968Jl7jEviC
	+o/CA9UVGBybdx/pWF3/DVd9YAVyoPq/Rc8YvgrV3VhJwRzVBT6gUtpbCnr2LPc1pNSNs3H2AMK
	m+ZnSDfRC3YVVgpaKYadhqryn2FSULndQA4OW1
X-Received: by 2002:a05:6830:850b:20b0:7db:d6c8:a21a with SMTP id 46e09a7af769-7dc954acef1mr14158583a34.3.1777228348707;
        Sun, 26 Apr 2026 11:32:28 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.35.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc892c515sm18690966a34.21.2026.04.26.11.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 11:32:27 -0700 (PDT)
Message-Id: <pull.2281.v4.git.git.1777228346809.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v3.git.git.1777188295021.gitgitgadget@gmail.com>
References: <pull.2281.v3.git.git.1777188295021.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 18:32:26 +0000
Subject: [PATCH v4] checkout: add --fetch to fetch remote before resolving
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

When --fetch is given and <start-point> is in <remote>/<branch> form,
run "git fetch <remote> <branch>" before resolving the ref. This
narrows the fetch to the requested branch so that other
remote-tracking branches are left untouched -- many tools rely on the
stability of remote-tracking refs between explicit fetches. If
<start-point> is a bare remote name like "origin" (which resolves to
that remote's default branch), "git fetch <remote>" is run instead,
since the target branch is not known up front. Abort the checkout if
the fetch fails.

Also add a checkout.fetch config to enable this by default.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: add --fetch to fetch remote before resolving start-point
    
    Adding tests to confirm that '--no-fetch' can countermand the config.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v4
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v3:

 1:  df7b63862c ! 1:  150ccbb621 checkout: add --fetch to fetch remote before resolving start-point
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_cmp_rev refs/remotes/fetch_upstream/fetch_cfg HEAD
      +'
      +
     ++test_expect_success '--no-fetch overrides checkout.fetch=true' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_nofetch &&
     ++	test_commit -C fetch_upstream u_nofetch &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_nofetch &&
     ++	test_must_fail git -c checkout.fetch=true checkout --no-fetch \
     ++		-b local_nofetch fetch_upstream/fetch_nofetch &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_nofetch &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_nofetch
     ++'
     ++
     ++test_expect_success '--no-fetch overrides earlier --fetch on command line' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_override &&
     ++	test_commit -C fetch_upstream u_override &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_override &&
     ++	test_must_fail git checkout --fetch --no-fetch \
     ++		-b local_override fetch_upstream/fetch_override &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_override &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_override
     ++'
     ++
      +test_expect_success 'switch --fetch -c picks up branch created upstream after clone' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_switch &&


 Documentation/config/checkout.adoc |  5 ++
 Documentation/git-checkout.adoc    | 11 ++++
 Documentation/git-switch.adoc      | 11 ++++
 builtin/checkout.c                 | 50 ++++++++++++++++-
 t/t7201-co.sh                      | 90 ++++++++++++++++++++++++++++++
 t/t9902-completion.sh              |  1 +
 6 files changed, 166 insertions(+), 2 deletions(-)

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
index 43ccf47cf6..f5cc1ced74 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -201,6 +201,17 @@ linkgit:git-config[1].
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
+`--fetch`::
+`--no-fetch`::
+	If _<start-point>_ refers to a remote-tracking branch, fetch
+	from that remote before resolving it. When _<start-point>_ is
+	in _<remote>/<branch>_ form, only that branch is updated; when
+	it is a bare remote name (e.g. `origin`), the whole remote is
+	fetched. If the fetch fails, the checkout is aborted.
++
+The default behavior can be set via the `checkout.fetch` configuration
+variable.
+
 `-l`::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..29743bafea 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -110,6 +110,17 @@ ambiguous but exists on the 'origin' remote. See also
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
+`--fetch`::
+`--no-fetch`::
+	If _<start-point>_ refers to a remote-tracking branch, fetch
+	from that remote before resolving it. When _<start-point>_ is
+	in _<remote>/<branch>_ form, only that branch is updated; when
+	it is a bare remote name (e.g. `origin`), the whole remote is
+	fetched. If the fetch fails, the switch is aborted.
++
+The default behavior can be set via the `checkout.fetch` configuration
+variable.
+
 `-f`::
 `--force`::
 	An alias for `--discard-changes`.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..8d810fe2fa 100644
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
@@ -112,6 +115,36 @@ struct branch_info {
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
+	if (slash && slash[1])
+		strvec_push(&cmd.args, slash + 1);
+	cmd.git_cmd = 1;
+	free(remote_name);
+	if (run_command(&cmd))
+		die(_("failed to fetch start-point '%s'"), arg);
+}
+
 static void branch_info_release(struct branch_info *info)
 {
 	free(info->name);
@@ -1237,6 +1270,10 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.fetch")) {
+		opts->fetch = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
@@ -1942,8 +1979,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
@@ -2052,6 +2094,8 @@ int cmd_checkout(int argc,
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
 			 N_("auto advance to the next file when selecting hunks interactively")),
+		OPT_BOOL(0, "fetch", &opts.fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
 		OPT_END()
 	};
 
@@ -2102,6 +2146,8 @@ int cmd_switch(int argc,
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
+		OPT_BOOL(0, "fetch", &opts.fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
 		OPT_END()
 	};
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..731be2680a 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -801,4 +801,94 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
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
+test_expect_success 'checkout --fetch <remote>/<branch> leaves other tracking branches untouched' '
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
+	git checkout --fetch -b local_target fetch_upstream/fetch_target &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
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
+test_expect_success '--no-fetch overrides checkout.fetch=true' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_nofetch &&
+	test_commit -C fetch_upstream u_nofetch &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_nofetch &&
+	test_must_fail git -c checkout.fetch=true checkout --no-fetch \
+		-b local_nofetch fetch_upstream/fetch_nofetch &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_nofetch &&
+	test_must_fail git rev-parse --verify refs/heads/local_nofetch
+'
+
+test_expect_success '--no-fetch overrides earlier --fetch on command line' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_override &&
+	test_commit -C fetch_upstream u_override &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_override &&
+	test_must_fail git checkout --fetch --no-fetch \
+		-b local_override fetch_upstream/fetch_override &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_override &&
+	test_must_fail git rev-parse --verify refs/heads/local_override
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

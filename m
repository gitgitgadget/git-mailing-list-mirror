Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC012147E5
	for <git@vger.kernel.org>; Sun,  3 May 2026 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777847492; cv=none; b=WjLvf2yCBkmN7U5hM75ci3b70Z09nDz9ZBuFRQ3v88hKDbitoXWokuK+Vgm/35otqcYMC9oANKbTwmAQOIujnuZbk5mZHBl68gt1U1x0hSjFFU/9lgn8mPuI1wvKx9WLiIkillroj1YPiOb/juThAmWgxZR3NdEG/eBqciyjkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777847492; c=relaxed/simple;
	bh=Gk1hJAFRaWtVSSMNCcBd9lIuykW8cm+ObLDKTVlpJrY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rBtXkWhwdfexpiJgcRavNGfro7H6Qi+NxjFrXkriyO/xf2ii1JiMJmH5y6FigZDnK1+6znhFQFTUlnfXns6naTUVO4BLhC698jssqjPkuvMS9VGi96BX0WmLHTF6kg4DoMYFkxNHWjarSxv1HahpxfsDQeZLWoDOi6xvMVQW9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6r1vdzK; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6r1vdzK"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eb5ad01402so393331285a.2
        for <git@vger.kernel.org>; Sun, 03 May 2026 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777847489; x=1778452289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/1LCpUuHUuksDv6SRZK8f8HKmKBSMl3Ay7avhPdr3A=;
        b=F6r1vdzKGQukQqunqvPksXsv43R2RGeBVVKLoZZP+1sBuZjNDSNcXhndftdL32o7MU
         qoLII02ZRiRP99wAvmgL5oD8Q1VWzq73yTHBTg6pmHLYtaD0Ta7QF4IO4WhSgzBUU7/V
         mn5S15rCjBriq75XMurAqRo3wzMHw7yGFQPKZkzXy0A3SiFn4YKJ6Znp4WqIpWQHR1p+
         FnZZs0ZxpBRWxsBeUJAbytX9JOOZnUBvLZJ7eWctdmBGBSbBJpWPC0oht4gKryLRjxaR
         b3E2NBw7BwydXL9NoRD4HVDI9+rU0kY4Et6MOU2zNrWZX3CcPodDnFxbOvVNEK4jnS3K
         0Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777847489; x=1778452289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/1LCpUuHUuksDv6SRZK8f8HKmKBSMl3Ay7avhPdr3A=;
        b=FSTZWzOeMk4PT+t7OBpkb7ZbyfhQfnNUbAUd/tAu2m4/NqB3mtu6Nfk4ye4M4fOQtN
         0RspZ8cji4EhldVzKhJogue27spAGH7V8R2yB/gFcRYkd3FLgr/hCm0Kxi3/iY/ofH9I
         ezPJH+nJZGEg5OQ3p3kXjTsHUEre+nEIp0f5ulPECD+YvH/evvpEGbppSF+K3Yiyww5D
         +6QJQTMbw4kTfarjS63sbFrL6446F+HXq6B3pIZIcXnMb6SdX2hYnJHwGZgN8OpoF+12
         HoIL+o6hmqxIO+ZWs/KFMBmo2DoC3h1S0VSVdkCNgoS/qnax1ulJAbNwdyYvPdulc6/v
         V/Dw==
X-Gm-Message-State: AOJu0YytHR67BNO6rhenL3VXBrTC+eACpFslttmv73w+dcZ368xygnnY
	T1efdZvh+Ul0+ruVS8TbH3s4qb4WAObCAnUyg2ZOqPd8tjpgtxmSCSvq7evusw==
X-Gm-Gg: AeBDiesfrm2SZhengOHr2fq1eDOYWmgESsfGutOolrwXVAyTcYF5TmZYkkc+4TuCmjG
	CSiNExFDmWg0kl3CmWCurAqZ72lQ1iiy+V5AitcEQRS+iJwPJxwFValnE3qfnSncBY42FbVOS68
	DaneDCyOZwoevhVy9u8eDncDpaUK6eVQ1KJMPGDbuYVCcrsF87kkxsRWRtwAQmB0Xn0SQLe41oE
	yyWhRC4Uwv00LZuIRnzvYCcdw6bf8qCRXjYjcos3ip90FW4KW9lmPFI20BiCT76a+eLz+2V131W
	UFX2TTZalSMaIC9Z2DYlFJ2X89fCMdjJyfeh/L7iSGa79kMu1la959YDbftjGdhb4lYypR52b6t
	a2hVyBjVoGI/67NpR0X6D11e17eXGjes4a59LgLqDdnWTgKLXcH2mWFVb/ynxKaTEBfq4hfZ/zz
	mLSMOa3tyNsKX2V0eS8Cv+Lw6hjyn1RpDC4oh37fk=
X-Received: by 2002:a05:620a:2590:b0:8cf:d804:456a with SMTP id af79cd13be357-8fd15fc8315mr1147764785a.20.1777847488824;
        Sun, 03 May 2026 15:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.196.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29380dffsm828076485a.2.2026.05.03.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 15:31:28 -0700 (PDT)
Message-Id: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v5.git.git.1777367012441.gitgitgadget@gmail.com>
References: <pull.2281.v5.git.git.1777367012441.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 May 2026 22:31:27 +0000
Subject: [PATCH v6] checkout: extend --track with a "fetch" mode to refresh
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
    checkout: add --fetch to fetch remote before resolving start-point
    
    Commit message only, no code/doc/test changes. Restructured the opening
    around the user-visible workflow before introducing '--track=fetch',
    reordered all example invocations to ' -b/-c --track[=...] ', dropped
    the "wrong/stale start-point" and "arbitrary commit" framings, and
    trimmed the over-explanation of the narrowed fetch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v6
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v5:

 1:  8ebc2f94b9 ! 1:  1b42c648b9 checkout: extend --track with a "fetch" mode to refresh start-point
     @@ Metadata
       ## Commit message ##
          checkout: extend --track with a "fetch" mode to refresh start-point
      
     -    A common workflow is:
     +    If you want to fork your topic branch from the very latest of the
     +    tip of a branch your remote has, you would do:
      
     -        git fetch origin
     +        git fetch origin some-branch
              git checkout -b new_branch --track origin/some-branch
      
     -    The first command exists so the second sees an up-to-date view of the
     -    remote. If it is forgotten, origin/some-branch points at a stale
     -    commit and the new local branch is created from the wrong start
     -    point. This only matters when the user is setting up tracking and
     -    expects the new branch to start at the freshest tip; for a one-off
     -    checkout of an arbitrary commit there is no reason to "freshen" the
     -    start-point.
     +    Extend the "--track" option of "git checkout" and allow users to
     +    write
      
     -    Tie the new behavior to --track for that reason: extend its argument
     -    to take a comma-separated list, where "fetch" can be combined with the
     -    existing "direct" (default) and "inherit" modes. Examples:
     +        git checkout -b new_branch --track=fetch origin/some-branch
      
     -        git checkout --track=fetch -b new_branch origin/some-branch
     -        git checkout --track=fetch,inherit -b new_branch some_local_branch
     -        git switch --track=fetch -c new_branch origin/some-branch
     +    to (1) fetch 'some-branch' from the remote 'origin', updating the
     +    remote-tracking branch 'origin/some-branch', (2) arrange subsequent
     +    'git pull' on 'new_branch' to interact with 'origin/some-branch' and
     +    (3) fork 'new_branch' from it.
     +
     +    In the value of the '--track' option, 'fetch' can be combined with
     +    the existing 'direct' (default) and 'inherit' modes via a
     +    comma-separated list. Examples:
     +
     +        git checkout -b new_branch --track=fetch,inherit some_local_branch
     +        git switch -c new_branch --track=fetch origin/some-branch
      
          When "fetch" is requested and <start-point> is in <remote>/<branch>
     -    form, run "git fetch <remote> <branch>" before resolving the ref. This
     -    narrows the fetch to the requested branch so that other
     -    remote-tracking branches are left untouched -- many tools rely on the
     -    stability of remote-tracking refs between explicit fetches. If
     +    form, run "git fetch <remote> <branch>" before resolving the ref, so
     +    that other remote-tracking branches are left untouched. If
          <start-point> is a bare remote name like "origin" (which resolves to
          that remote's default branch), "git fetch <remote>" is run instead,
          since the target branch is not known up front. Abort the checkout if


 Documentation/git-checkout.adoc | 10 +++-
 Documentation/git-switch.adoc   | 10 +++-
 builtin/checkout.c              | 85 +++++++++++++++++++++++++++++++--
 t/t7201-co.sh                   | 81 +++++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..3b8292612d 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -158,11 +158,19 @@ of it").
 	resets _<branch>_ to the start point instead of failing.
 
 `-t`::
-`--track[=(direct|inherit)]`::
+`--track[=(direct|inherit|fetch)[,...]]`::
 	When creating a new branch, set up "upstream" configuration. See
 	`--track` in linkgit:git-branch[1] for details. As a convenience,
 	--track without -b implies branch creation.
 +
+The argument is a comma-separated list. `direct` (the default) and
+`inherit` select the tracking mode. Adding `fetch` requests that the
+remote be fetched before _<start-point>_ is resolved, so the new branch
+starts from a fresh tip: when _<start-point>_ is in
+_<remote>/<branch>_ form, only that branch is updated; when it is a
+bare remote name (e.g. `origin`), the whole remote is fetched. If the
+fetch fails, the checkout is aborted.
++
 If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
 the refspec configured for the corresponding remote, and then stripping
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..35a03e8a52 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -154,11 +154,19 @@ should result in deletion of the path).
 	attached to a terminal, regardless of `--quiet`.
 
 `-t`::
-`--track[ (direct|inherit)]`::
+`--track[=(direct|inherit|fetch)[,...]]`::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
 +
+The argument is a comma-separated list. `direct` (the default) and
+`inherit` select the tracking mode. Adding `fetch` requests that the
+remote be fetched before _<start-point>_ is resolved, so the new branch
+starts from a fresh tip: when _<start-point>_ is in
+_<remote>/<branch>_ form, only that branch is updated; when it is a
+bare remote name (e.g. `origin`), the whole remote is fetched. If the
+fetch fails, the switch is aborted.
++
 If no `-c` option is given, the name of the new branch will be derived
 from the remote-tracking branch, by looking at the local part of the
 refspec configured for the corresponding remote, and then stripping
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..de4d7c00c7 100644
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
@@ -112,6 +115,74 @@ struct branch_info {
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
+static int parse_opt_checkout_track(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct checkout_opts *opts = opt->value;
+	struct string_list tokens = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	int ret = 0;
+
+	if (unset) {
+		opts->track = BRANCH_TRACK_NEVER;
+		opts->fetch = 0;
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
+			opts->track = BRANCH_TRACK_EXPLICIT;
+		} else if (!strcmp(item->string, "inherit")) {
+			opts->track = BRANCH_TRACK_INHERIT;
+		} else {
+			ret = error(_("option `%s' expects \"%s\", \"%s\", "
+				      "or \"%s\""),
+				    "--track", "direct", "inherit", "fetch");
+			break;
+		}
+	}
+
+	string_list_clear(&tokens, 0);
+	return ret;
+}
+
 static void branch_info_release(struct branch_info *info)
 {
 	free(info->name);
@@ -1237,7 +1308,6 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
-
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
 
@@ -1734,10 +1804,10 @@ static struct option *add_common_switch_branch_options(
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
@@ -1942,8 +2012,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
index 9bcf7c0b40..39236dca12 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -801,4 +801,85 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
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
+test_expect_success 'checkout --track=fetch with bare remote name fetches the remote' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_new2 &&
+	test_commit -C fetch_upstream u_new2 &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2 &&
+	git checkout --track=fetch -b local_from_remote fetch_upstream &&
+	git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2
+'
+
+test_expect_success 'checkout --track=fetch aborts and does not create branch on fetch failure' '
+	git checkout main &&
+	test_might_fail git branch -D bogus &&
+	test_must_fail git checkout --track=fetch -b bogus fetch_upstream/does_not_exist &&
+	test_must_fail git rev-parse --verify refs/heads/bogus
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

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget

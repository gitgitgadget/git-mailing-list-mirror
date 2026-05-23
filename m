Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0636342C9E
	for <git@vger.kernel.org>; Sat, 23 May 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779565723; cv=none; b=J+P4vMLBS4fpiCjGRGTOqjxVtGz+2SsNxPnhdZnJUPtdr5DPU+vImPVcSb+G0lGXMNmHMWDmgShs2BCL5lzLgPqlIZmSsYt44uGzKMqO4rGcLQwnTCTm01b+i70RX8xzdZ6SzovflsfKFqh9kjm2l6qdX/HtygBq2o6fhD8XDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779565723; c=relaxed/simple;
	bh=jZs/q4Lil+DIvLoyKy/9n2RIuLY+A5s5RMVEjgLgh+4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PyYKn51SBIdB8TeQJUCq7s9RWs5GVtuaZwFVTQG1/A5wXn61WJqcfOS+DKEpVvc3AIqCG+i4N0C48lQht9/yfIqmanbtjEtB/WkyY2dD5lz+aLnzIvGoCn8oe/e0Eky1hmAFeNq5MLli9hnVBkTVIrMzI8AuSdQAwV87NK7u/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUlCu2u4; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUlCu2u4"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8c7154725easo97999736d6.0
        for <git@vger.kernel.org>; Sat, 23 May 2026 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779565721; x=1780170521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9smCM+VYZ7PA/QhU5uEzHRpeUI9V3dxbMt2kQoumC0=;
        b=UUlCu2u4+AlTwu72CLRj/gplygYrKqfEOQfXFLjdO2nRCrw389CzhFrWKkyt2bYu1X
         QSrcBiyWP/okmxTHlLqZw5C61+7qm0i2DPJaEJVrpwyezKFh2PYidwISbHBubJTpQU2n
         9/7diq7+PHG8jXCSFJmLgoZj3hEigKrp5Za3Z8u/UvwhCePMdQYpNVF8BEWOOfk2abzt
         FncomNLgXmeeU5k9TGiFDGA8H64+BKvHSf4CXxgZLEgNhADtoKENbtlYWGq+uqOm8wAW
         o2lCXsbr/UYHI89b/GL9/rS8ut06ntr9QVPWiRoFC+7E6X4zAzkqYIuDDrFbFl1+uGIL
         0teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779565721; x=1780170521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9smCM+VYZ7PA/QhU5uEzHRpeUI9V3dxbMt2kQoumC0=;
        b=ml++U6Mc+/jUhwwZaR/P4B0kKLZTPoKQBAdkchDQ36rJaMyeeeHj25XtOFSAhWDkgk
         1sVGTsTSAU0rphFF1ORbaOu/hsPZwaadIUkckuigEz4jLmQfb4kZgwdaQ2eBs0LXHTxC
         B9NtMrn1IZ+puOifZcYAWV++0UWvyi5l3LIEIjFeEXxfjJBtjKdXQjzJaZ3PGZO+SDzb
         Xc7BnoauODcLtFQU2MPQLP+rnsBspgqcsf5pXgiwqStZS6jHZzfd3bLPiO7NbrHTq3BG
         GoyBtdoLnFraxiwnMvA6/UgDL7xYweSV8qFngtgmOlj6A10R6V62/onggpYQvQNMJJi6
         aQDA==
X-Gm-Message-State: AOJu0YzSG3SzPS64s8s4BP5RwbCyg+caAbvtXF1VoPZXsXCYNxFvNUlm
	QSC6gfeq9TMuhrrjS/JMHq9xUYz5K3z+yDRVh42Y/N3vXQPDobE1WeOm4jc89A==
X-Gm-Gg: Acq92OHgPGZ5zBerMY8ENnUgHs4ihOehYD2KMvPWzkHyzkQYrM/dZF5Li0Z3Fjbg8K8
	JOXrw0tJxZcjaakxpzPDIutWK+swJCPceLH7vM/DijtWocj4AGoP6/IxMu11k9wk8h55ictnBfd
	tgCyCXxgb8N+58JwdiWwmYK7wG2301JlNmBPk3bsyUHVuaryS2XOPxG7PmFZn9qdI0kChveZbXn
	KpnLrTblK29HbY8QrmBXqRQPxJUPf5/Dmh3PKff2YthEq0Ygvk8EMgZe968vyATVvRZUdAi/l9k
	a7pTSww14VYQExpKb8uHi99XgilwkRYKOkPldhBRDBnmHRj4CM+5BWa8kS5ng0hXMtQSjviEdf7
	+bv1OHMZerkjiYy7mp0FiOQPV6AD35qC4/TpBeywCJ02SyKr+yAEpakzyJRjSmxlTvSsAAUJzN7
	J8cBiLi+4HgMOc9IOjHUiH2cLhdGyqwIfEWQhPuQ==
X-Received: by 2002:a05:622a:550e:b0:50d:a987:89b2 with SMTP id d75a77b69052e-516d459292cmr115007641cf.31.1779565720566;
        Sat, 23 May 2026 12:48:40 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b00143sm46560851cf.3.2026.05.23.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 12:48:39 -0700 (PDT)
Message-Id: <60adf0e67d97a1162e8c2e27e7a01fa8a8345d27.1779565714.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
References: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
	<pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 May 2026 19:48:34 +0000
Subject: [PATCH v13 2/2] checkout: extend --track with a "fetch" mode to
 refresh start-point
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

Add a "fetch" mode to the "--track" option of "git checkout" / "git
switch" that refreshes <start-point> before checking it out:

    git checkout -b new_branch --track=fetch origin/some-branch

is shorthand for

    git fetch origin some-branch
    git checkout -b new_branch --track origin/some-branch

Identify the remote whose configured fetch refspec maps to
<start-point> using find_tracking_remote_for_ref() (the same lookup
"--track" uses to pick which remote to record in
branch.<name>.remote), then run "git fetch <remote> <src-ref>" for
just that ref so other remote-tracking branches are left untouched.
When <start-point> is a bare <remote> (e.g. "origin"), follow
refs/remotes/<remote>/HEAD to learn which branch to refresh. If
"git fetch" fails but the remote-tracking ref already exists locally,
warn and proceed from the existing tip; otherwise abort.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-checkout.adoc |  17 +-
 Documentation/git-switch.adoc   |   5 +-
 builtin/checkout.c              | 139 +++++++++++++++-
 t/t7201-co.sh                   | 276 ++++++++++++++++++++++++++++++++
 4 files changed, 430 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a8b3b8c2e2..20b6cae60e 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -158,11 +158,26 @@ of it").
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
+updated; when _<start-point>_ is a bare _<remote>_ (e.g. `origin`), the
+branch named by _<remote>/HEAD_ is updated, and the checkout fails
+with a hint to configure that symref if it is not set. The checkout
+also fails if no configured remote's fetch refspec maps to
+_<start-point>_, or if more than one does (in which case the `fetch`
+cannot be unambiguously routed). If the fetch itself fails and the
+corresponding remote-tracking ref already exists, a warning is printed
+and the checkout proceeds from the existing tip; otherwise the checkout
+is aborted.
++
 If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
 the refspec configured for the corresponding remote, and then stripping
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index d6c4f229a5..a8730b1da8 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -155,10 +155,11 @@ variable.
 	attached to a terminal, regardless of `--quiet`.
 
 `-t`::
-`--track[ (direct|inherit)]`::
+`--track[=(direct|inherit|fetch)[,...]]`::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
-	details.
+	details, and `--track` in linkgit:git-checkout[1] for the
+	`fetch` mode.
 +
 If no `-c` option is given, the name of the new branch will be derived
 from the remote-tracking branch, by looking at the local part of the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1345e8574a..25b511f22a 100644
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
@@ -115,6 +118,129 @@ struct branch_info {
 	char *checkout;
 };
 
+static void fetch_remote_for_start_point(const char *arg, int quiet)
+{
+	struct strbuf dst = STRBUF_INIT;
+	struct tracking tracking;
+	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
+	struct string_list ambiguous_remotes = STRING_LIST_INIT_DUP;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct object_id oid;
+	struct remote *named_remote;
+	int bare_ns;
+
+	strbuf_addf(&dst, "refs/remotes/%s", arg);
+	if (check_refname_format(dst.buf, 0))
+		die(_("cannot fetch start-point '%s': not a valid "
+		      "remote-tracking name"), arg);
+
+	named_remote = remote_get(arg);
+	bare_ns = !strchr(arg, '/') ||
+		(named_remote && remote_is_configured(named_remote, 1));
+	if (bare_ns) {
+		char *head_path = xstrfmt("refs/remotes/%s/HEAD", arg);
+		const char *head_target =
+			refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						head_path,
+						RESOLVE_REF_READING |
+						RESOLVE_REF_NO_RECURSE,
+						&oid, NULL);
+		if (head_target &&
+		    starts_with(head_target, dst.buf) &&
+		    head_target[dst.len] == '/' &&
+		    !check_refname_format(head_target, 0)) {
+			strbuf_reset(&dst);
+			strbuf_addstr(&dst, head_target);
+			bare_ns = 0;
+		}
+		free(head_path);
+	}
+
+	memset(&tracking, 0, sizeof(tracking));
+	tracking.spec.dst = dst.buf;
+	tracking.srcs = &tracking_srcs;
+	find_tracking_remote_for_ref(&tracking, &ambiguous_remotes);
+
+	if (tracking.matches > 1) {
+		int status = die_message(_("cannot fetch start-point '%s': "
+					   "fetch refspecs of multiple remotes "
+					   "map to '%s'"), arg, dst.buf);
+		advise_ambiguous_fetch_refspec(dst.buf, &ambiguous_remotes);
+		exit(status);
+	}
+
+	if (!tracking.matches) {
+		if (bare_ns && named_remote &&
+		    remote_is_configured(named_remote, 1))
+			die(_("cannot fetch start-point '%s': "
+			      "'refs/remotes/%s/HEAD' is not set; run "
+			      "'git remote set-head %s --auto' to set it"),
+			    arg, arg, arg);
+		die(_("cannot fetch start-point '%s': no configured remote's "
+		      "fetch refspec matches it"), arg);
+	}
+
+	strvec_push(&cmd.args, "fetch");
+	if (quiet)
+		strvec_push(&cmd.args, "--quiet");
+	strvec_pushl(&cmd.args, tracking.remote,
+		     tracking_srcs.items[0].string, NULL);
+	cmd.git_cmd = 1;
+	if (run_command(&cmd)) {
+		if (!refs_read_ref(get_main_ref_store(the_repository),
+				   dst.buf, &oid))
+			warning(_("failed to fetch start-point '%s'; "
+				  "using existing '%s'"), arg, dst.buf);
+		else
+			die(_("failed to fetch start-point '%s'"), arg);
+	}
+
+	string_list_clear(&tracking_srcs, 0);
+	string_list_clear(&ambiguous_remotes, 0);
+	strbuf_release(&dst);
+}
+
+static int parse_opt_checkout_track(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct checkout_opts *opts = opt->value;
+	struct string_list tokens = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	int saw_direct = 0;
+	int ret = 0;
+
+	opts->fetch = 0;
+	if (unset) {
+		opts->track = BRANCH_TRACK_NEVER;
+		return 0;
+	}
+	opts->track = BRANCH_TRACK_EXPLICIT;
+	if (!arg)
+		return 0;
+
+	string_list_split(&tokens, arg, ",", -1);
+	for_each_string_list_item(item, &tokens) {
+		if (!strcmp(item->string, "fetch"))
+			opts->fetch = 1;
+		else if (!strcmp(item->string, "direct"))
+			saw_direct = 1;
+		else if (!strcmp(item->string, "inherit"))
+			opts->track = BRANCH_TRACK_INHERIT;
+		else {
+			ret = error(_("option `%s' expects \"%s\", \"%s\", "
+				      "or \"%s\""),
+				    "--track", "direct", "inherit", "fetch");
+			goto out;
+		}
+	}
+	if (saw_direct && opts->track == BRANCH_TRACK_INHERIT)
+		ret = error(_("option `%s' cannot combine \"%s\" and \"%s\""),
+			    "--track", "direct", "inherit");
+out:
+	string_list_clear(&tokens, 0);
+	return ret;
+}
+
 static void branch_info_release(struct branch_info *info)
 {
 	free(info->name);
@@ -1733,10 +1859,10 @@ static struct option *add_common_switch_branch_options(
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
@@ -1941,8 +2067,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
-					     &new_branch_info, opts, &rev);
+		int n;
+
+		if (opts->fetch)
+			fetch_remote_for_start_point(argv[0], opts->quiet);
+
+		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
+					 &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7613b1d2a4..1e321b1512 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -870,4 +870,280 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
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
+	git remote add fetch_custom ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_custom" &&
+	git config --replace-all remote.fetch_custom.fetch \
+		"+refs/heads/*:refs/remotes/custom-ns/*" &&
+	git -C fetch_upstream checkout -b fetch_refspec &&
+	test_commit -C fetch_upstream u_refspec &&
+	test_must_fail git rev-parse --verify refs/remotes/custom-ns/fetch_refspec &&
+	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
+	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
+'
+
+test_expect_success 'checkout --track=fetch on namespace bare name follows <ns>/HEAD' '
+	git checkout main &&
+	git remote add fetch_ns ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_ns" &&
+	test_when_finished "git update-ref -d refs/remotes/ns_alias/HEAD" &&
+	git config --replace-all remote.fetch_ns.fetch \
+		"+refs/heads/*:refs/remotes/ns_alias/*" &&
+	git fetch fetch_ns &&
+	git symbolic-ref refs/remotes/ns_alias/HEAD refs/remotes/ns_alias/main &&
+	git -C fetch_upstream checkout main &&
+	test_commit -C fetch_upstream u_ns_post &&
+	git checkout --track=fetch -b local_ns ns_alias &&
+	test_cmp_rev refs/remotes/ns_alias/main HEAD &&
+	test_cmp_config fetch_ns branch.local_ns.remote &&
+	test_cmp_config refs/heads/main branch.local_ns.merge
+'
+
+test_expect_success '--track=fetch on bare hierarchical remote name follows <ns>/HEAD' '
+	git checkout main &&
+	git remote add nested/bare ./fetch_upstream &&
+	test_when_finished "git remote remove nested/bare" &&
+	test_when_finished "git update-ref -d refs/remotes/nested/bare/HEAD" &&
+	git fetch nested/bare &&
+	git symbolic-ref refs/remotes/nested/bare/HEAD \
+		refs/remotes/nested/bare/main &&
+	git -C fetch_upstream checkout main &&
+	test_commit -C fetch_upstream u_nested_bare_post &&
+	git checkout --track=fetch -b local_nested_bare nested/bare &&
+	test_cmp_rev refs/remotes/nested/bare/main HEAD
+'
+
+test_expect_success 'checkout --track=fetch handles hierarchical remote name' '
+	git checkout main &&
+	git remote add nested/remote ./fetch_upstream &&
+	test_when_finished "git remote remove nested/remote" &&
+	git -C fetch_upstream checkout -b fetch_hier &&
+	test_commit -C fetch_upstream u_hier &&
+	test_must_fail git rev-parse --verify refs/remotes/nested/remote/fetch_hier &&
+	git checkout --track=fetch -b local_hier nested/remote/fetch_hier &&
+	test_cmp_rev refs/remotes/nested/remote/fetch_hier HEAD
+'
+
+test_expect_success 'checkout --track=fetch dies on bare remote name with no <ns>/HEAD' '
+	git checkout main &&
+	git remote add fetch_nohead ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_nohead" &&
+	test_might_fail git symbolic-ref -d refs/remotes/fetch_nohead/HEAD &&
+	test_must_fail git checkout --track=fetch -b local_nohead fetch_nohead 2>err &&
+	test_grep "refs/remotes/fetch_nohead/HEAD" err &&
+	test_grep "git remote set-head fetch_nohead --auto" err &&
+	test_must_fail git rev-parse --verify refs/heads/local_nohead
+'
+
+test_expect_success 'checkout --track=fetch on bare unknown name does not suggest set-head' '
+	git checkout main &&
+	test_must_fail git rev-parse --verify refs/remotes/no_such_ns/HEAD &&
+	test_must_fail git config --get remote.no_such_ns.url &&
+	test_must_fail git checkout --track=fetch -b local_unknown no_such_ns 2>err &&
+	test_grep "no configured remote" err &&
+	test_grep ! "set-head" err &&
+	test_must_fail git rev-parse --verify refs/heads/local_unknown
+'
+
+test_expect_success 'checkout --track=fetch rejects <ns>/HEAD pointing outside namespace' '
+	git checkout main &&
+	git remote add fetch_crossns ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_crossns" &&
+	test_when_finished "git update-ref -d refs/remotes/fetch_crossns/HEAD" &&
+	git fetch fetch_crossns &&
+	git symbolic-ref refs/remotes/fetch_crossns/HEAD \
+		refs/remotes/fetch_upstream/u_main &&
+	test_must_fail git checkout --track=fetch -b local_crossns fetch_crossns 2>err &&
+	test_grep "refs/remotes/fetch_crossns/HEAD" err &&
+	test_must_fail git rev-parse --verify refs/heads/local_crossns
+'
+
+test_expect_success 'checkout --track=fetch dies on ambiguous fetch refspec match' '
+	git checkout main &&
+	git remote add fetch_ambig_a ./fetch_upstream &&
+	git remote add fetch_ambig_b ./fetch_upstream &&
+	test_when_finished "git remote remove fetch_ambig_a" &&
+	test_when_finished "git remote remove fetch_ambig_b" &&
+	git config --replace-all remote.fetch_ambig_a.fetch \
+		"+refs/heads/*:refs/remotes/ambig_ns/*" &&
+	git config --replace-all remote.fetch_ambig_b.fetch \
+		"+refs/heads/*:refs/remotes/ambig_ns/*" &&
+	git -C fetch_upstream checkout -b fetch_ambig &&
+	test_commit -C fetch_upstream u_ambig &&
+	test_must_fail git checkout --track=fetch -b local_ambig ambig_ns/fetch_ambig 2>err &&
+	test_grep "fetch_ambig_a" err &&
+	test_grep "fetch_ambig_b" err &&
+	test_grep "tracking namespaces" err &&
+	test_must_fail git rev-parse --verify refs/heads/local_ambig
+'
+
+test_expect_success 'checkout --track=fetch rejects invalid refname components' '
+	git checkout main &&
+	test_must_fail git checkout --track=fetch -b local_invalid "foo..bar" 2>err &&
+	test_grep "valid" err &&
+	test_must_fail git rev-parse --verify refs/heads/local_invalid
+'
+
+test_expect_success 'checkout --track=fetch,inherit rejects invalid refname components' '
+	git checkout main &&
+	test_must_fail git checkout --track=fetch,inherit -b local_invalid \
+		"foo..bar" 2>err &&
+	test_grep "valid" err &&
+	test_must_fail git rev-parse --verify refs/heads/local_invalid
+'
+
+test_expect_success 'checkout --track=inherit,direct is rejected' '
+	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
+	test_grep "cannot combine" err
+'
+
+test_expect_success 'checkout --track=direct,inherit is rejected' '
+	test_must_fail git checkout --track=direct,inherit -b bad fetch_upstream/fetch_new 2>err &&
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
+test_expect_success 'checkout --track=fetch then --no-track drops fetch' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_notrack &&
+	test_commit -C fetch_upstream u_notrack &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack &&
+	test_must_fail git checkout --track=fetch --no-track \
+		-b local_notrack fetch_upstream/fetch_notrack &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack
+'
+
+test_expect_success 'checkout --track=fetch,inherit fetches remote-tracking start-point' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_inherit &&
+	test_commit -C fetch_upstream u_inherit &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_inherit &&
+	git checkout --track=fetch,inherit -b local_inherit \
+		fetch_upstream/fetch_inherit &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD
+'
+
+test_expect_success 'checkout --track=fetch,inherit errors when start-point does not map to a remote' '
+	git checkout main &&
+	test_must_fail git checkout --track=fetch,inherit -b bad main 2>err &&
+	test_grep "no configured remote" err &&
+	test_must_fail git rev-parse --verify refs/heads/bad
+'
+
+test_expect_success 'checkout --track=fetch on local start-point errors' '
+	git checkout main &&
+	test_must_fail git checkout --track=fetch -b bad main 2>err &&
+	test_grep "no configured remote" err &&
+	test_must_fail git rev-parse --verify refs/heads/bad
+'
+
+test_expect_success 'checkout --track=bogus reports an error' '
+	git checkout main &&
+	test_must_fail git checkout --track=bogus -b bogus_branch fetch_upstream/fetch_new 2>err &&
+	test_grep "expects" err
+'
+
+test_expect_success 'checkout -q --track=fetch silences the fetch output' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_quiet &&
+	test_commit -C fetch_upstream u_quiet &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_quiet &&
+	git checkout -q --track=fetch -b local_quiet \
+		fetch_upstream/fetch_quiet 2>err &&
+	test_grep ! "-> fetch_upstream/fetch_quiet" err &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_quiet HEAD
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
-- 
gitgitgadget

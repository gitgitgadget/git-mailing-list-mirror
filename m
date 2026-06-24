Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034802BD033
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338107; cv=none; b=HcnNN95clR1ZCd7npvukZ0EjKhxLtQ3QfEDV+FF22KAcv77CdNSUfhR6u81Xk4Hz2lcrjpZGpLfu6mV0psnPdw2Hon3uhjlRGGwi3qd58+UFtw3UC/cYGtQYGiAV747c4ahiMEuKVmu/PGXEbSMqMFJkJhyV35RXOCya2XrDaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338107; c=relaxed/simple;
	bh=jPKx0HYPuNE5uvugsG7lyZd8pBB0qMD0oc6+gjjcEAI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NEXxbRfoX8KO/NVLRqWlf9XIaa1nvWXrTEGMmLlWOsVsp7ulpRmpgMoG69eqSSWZqGT43Z6gY1saemOgjezUUHQoSKCoKhIHLrEE8Z2Odv6PkUXKOEr+MX8sTyI3ed1670i5dsOpa4hlYwZN5uwWfsV2BheojoXpVf737PD2Ib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl6wAYYS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl6wAYYS"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8de412e58edso17223416d6.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338104; x=1782942904; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR4N4J2Qk6GbxLoOdxUVhHLk/Wfsp2YHMJR1bS5FGiY=;
        b=kl6wAYYSzDENsB5jyPv4qLSlFdP8b1y0gEDV6EBp1iYFCaBK1IMbPk2y6tgGnWOQGT
         iL5HsNEH/4NUNyJo5r48Hw4slDSwpUBEVo4FzRcuVSMSD1YGViqH+vSCFrsMjPNgpyQE
         A8jl6DNfoWBEPtJU40HKodyZuEIrpU5K50Mn6mfWlkgJa846f2rNA2GIlYfg7XdLyJmD
         P9SkSda4dPKAoU2kj8FPk8ACNGhImdXka15ypzkbCUP+4GwVO8mlqCcopQj2/J8EDUlS
         Ku/v0Kk5mMO9cMuAphG/0M7GC8SZuclGKpNd7hMT6ATCrZ+ZOJQ/94y7WsWwUyAPUcXV
         Mwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338104; x=1782942904;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jR4N4J2Qk6GbxLoOdxUVhHLk/Wfsp2YHMJR1bS5FGiY=;
        b=GNKjbtq+4Q4KeHBBkyMMN0h8182Yr40PVgdnxwh2BaxDvxbqNtSavL02gP6E1M1TUY
         oHbmgtH0dYttaNt3eMJjCGUA0ULMU/b8AHIXNo23LI94YYNuzCjBdhaQVpHEKZCFtvQh
         SUEBzntXYE0dsfGTYGyQkXII1whmMZWDVU/qOuEOBscx3KvVjShG2zOtAuTwwF6PP50K
         ZJVdgCK1ZXDM5ajnpUFGxnE1BQAbDK2fAsvVcPoYRdIxBs7B6nGF9YIqTrs13R/UFlhk
         PnmkYxlrOUP7krd51l4mMiD2lHkhmfD8AD//4UVtpa4AXZFy7Of5s7bGtT6nRLekGkQQ
         0Mfw==
X-Gm-Message-State: AOJu0Yx4xT1YCVbs1zt6jBb0nnmf7Mw0Ov2BZ2fi8NK9qXew1WFNdQ/0
	qwH9N7oNXQ+thtqJpTfuS/Iv054gTX/UIOasA7+w0UYCLemw6nkA2nnHobQqHfsv
X-Gm-Gg: AfdE7cmI/SLbyHJomvr9HZLmfORCO7RQIuryEAmgFl9Fv9rBoYDX/DjaeCBcmPs9SzR
	kAL0h58NqEz4D0owCgwT7F0FAIj1VWXDohn5EsK8EljD+oSaLbWxCUjcZ1ZXaIquDbw1m9byjY9
	VBfWM1kbT0+cHPSuVSnX0YB39Po8fLhUegBfNnxUKqcDi0CKU/48DsFj7HmLc8iDPQetH7Uh09W
	jgdJT65yVKhypTmEWT8QVo67wsxy8+hFqrzm+oPi083EYnhJkyr59FYFR5jmiiMjRM6/nDEUUVv
	0pHYlfCyYC1KQgZx4En7Oxpkcog/tvQI5SwY2myavlWFVWs/OlJlnQnrWk3+ujQMfMyFiu8j9KN
	aME8Ql9hjHM8SRw4Te0Iijezu6OSEh+rmiAW4wW7+jPkJjQdYYePewiZKXZ7MdGuESAAc5zyQTz
	jd0QAU52KxyVkp3Eq8
X-Received: by 2002:a05:6214:c6a:b0:8de:a916:6226 with SMTP id 6a1803df08f44-8e6d28fc743mr663776d6.6.1782338103930;
        Wed, 24 Jun 2026 14:55:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0180d3sm163187536d6.3.2026.06.24.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:02 -0700 (PDT)
Message-Id: <b7e387f1239de376a7934c84e4b60b331b212321.1782338098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com>
References: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
	<pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:54:58 +0000
Subject: [PATCH v15 2/2] checkout: extend --track with a "fetch" mode to
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

Forking from an existing remote branch without refreshing first often
has consequences: you start work that has already been done, or you
build on an old version of the code which causes big conflicts later
when you pull. The workaround is two commands ("git fetch <remote>
<branch> && git checkout -b <topic> <remote>/<branch>"), and when
the fetch is skipped the checkout silently starts from a stale tip.

Users may already expect "<remote>/<branch>" to refer to the latest
tip on the remote. While this blurs the line between fetch and
checkout, git already does this in places where it pays off: "git
clone" fetches and checks out, and "git pull" fetches and merges.

Add a "fetch" mode to "--track" that refreshes <start-point> before
checking it out:

    git checkout -b new_branch --track=fetch origin/some-branch

Only the requested branch is fetched so other remote-tracking
branches are left untouched. When <start-point> is a bare <remote>
(e.g. "origin"), follow refs/remotes/<remote>/HEAD to learn which
branch to refresh. If "git fetch" fails but the remote-tracking ref
already exists locally, warn and proceed from the existing tip,
otherwise abort.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-checkout.adoc |  17 ++-
 Documentation/git-switch.adoc   |   5 +-
 builtin/checkout.c              | 138 +++++++++++++++++++-
 t/t7201-co.sh                   | 222 ++++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+), 7 deletions(-)

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
index b78b3a1d16..c6154fbbb0 100644
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
 #include "sparse-index.h"
@@ -63,6 +65,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int fetch;
 	int discard_changes;
 	int accept_ref;
 	int accept_pathspec;
@@ -116,6 +119,128 @@ struct branch_info {
 	char *checkout;
 };
 
+static void fetch_remote_for_start_point(const char *arg, int quiet)
+{
+	struct strbuf dst = STRBUF_INIT;
+	struct tracking tracking = { 0 };
+	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
+	struct string_list ambiguous_remotes = STRING_LIST_INIT_DUP;
+	struct child_process cmd = CHILD_PROCESS_INIT;
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
+						RESOLVE_REF_READING,
+						NULL, NULL);
+		if (head_target &&
+		    starts_with(head_target, dst.buf) &&
+		    head_target[dst.len] == '/') {
+			strbuf_reset(&dst);
+			strbuf_addstr(&dst, head_target);
+			bare_ns = 0;
+		}
+		free(head_path);
+	}
+
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
+		    remote_is_configured(named_remote, 1)) {
+			int status = die_message(_("cannot fetch start-point '%s' "
+						   "because 'refs/remotes/%s/HEAD' "
+						   "does not exist."), arg, arg);
+			advise(_("To create it run\n"
+				 "\n"
+				 "    git remote set-head %s --auto\n"), arg);
+			exit(status);
+		}
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
+		if (refs_ref_exists(get_main_ref_store(the_repository), dst.buf))
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
@@ -1786,10 +1911,10 @@ static struct option *add_common_switch_branch_options(
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
@@ -1994,8 +2119,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
index 7613b1d2a4..bc0c72c49d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -870,4 +870,226 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
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
+	git update-ref refs/heads/snapshot_other refs/remotes/fetch_upstream/fetch_other &&
+	git -C fetch_upstream checkout fetch_target &&
+	test_commit -C fetch_upstream u_target_post &&
+	git -C fetch_upstream checkout fetch_other &&
+	test_commit -C fetch_upstream u_other_post &&
+	git checkout --track=fetch -b local_target fetch_upstream/fetch_target &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_other snapshot_other
+'
+
+test_expect_success 'checkout --track=fetch with bare remote name fetches only <remote>/HEAD target' '
+	git checkout main &&
+	git -C fetch_upstream checkout main &&
+	git remote set-head fetch_upstream main &&
+	git -C fetch_upstream checkout -b fetch_unrelated &&
+	test_commit -C fetch_upstream u_unrelated_pre &&
+	git fetch fetch_upstream fetch_unrelated &&
+	git update-ref refs/heads/snapshot_unrelated \
+		refs/remotes/fetch_upstream/fetch_unrelated &&
+	git -C fetch_upstream checkout main &&
+	test_commit -C fetch_upstream u_main_post &&
+	git -C fetch_upstream checkout fetch_unrelated &&
+	test_commit -C fetch_upstream u_unrelated_post &&
+	git checkout --track=fetch -b local_from_remote fetch_upstream &&
+	test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_unrelated snapshot_unrelated
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
+test_expect_success 'checkout --track=fetch on bare remote-tracking prefix follows <prefix>/HEAD' '
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
+test_expect_success 'checkout --track=fetch rejects <ns>/HEAD pointing outside the tracking prefix' '
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

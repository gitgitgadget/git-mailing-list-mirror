Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB53F23DB
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786659; cv=none; b=lKWN5yWTPhuLDsJ0cBfY+ycuxf+M8lJ4s4PJlYG/WqUgxQMa1koydaAwsK40GsljLLnx0SvCk+IpVQxpDnnEDu6JhlGpXGNSbQHRo/lqo7+BzprMKlbvS4fKMG4MFK527VZNmL7hJhcZ51u+yu5Yzk6VXy9HfvtueDZJ0D+lT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786659; c=relaxed/simple;
	bh=rBLFeKdOrxwmMiPF0N08iAteZbqo1OhUF+QdHb1DmEM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CvLawCcEillHvvFTDzQ8wYhnIXgfRwnuvNdCsImZdn+ao02V6uox/8TOHUUCjPPjeuTUM4r6LzxjNrXCkZaLoIXnKm5JEHm09sN1azc4ByYgYmEAF0tO3q4ASri9rg//j/mUzE5xVdGt84NhV0aRyw2veKzJSm/5hbY2joQD49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFlKE/5Z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFlKE/5Z"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9157f7c1c0eso88948985a.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786656; x=1782391456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se1m+X55xAiq5rNtyu6oD8WGyYy8gYhqav7rcWfx+4w=;
        b=FFlKE/5ZkEMDyhK3z9jGyLyAaFfEggh+4N4Klqo3vt2DXyCWBicntX2JQxrH5q9Uux
         2GoXnbjxC2X9t8udAhSVlCztWvOX7pYuXmDp0+eCnQJcCtxxYKQuHrxQenU62j6YkAQx
         AtV1n+pVZrr7puk5JfpNjcA3R8LWQlIHu5jTO5QTfcDeqsxteE26lzoVVF0hcBs3JHUO
         XlPvIgAnauvJwUbIHtLxaCsiC/dsawkvcpF+7nkp6WvgWcny5AO8fmW+SW3gKSMvwGMs
         jUciCfrzQMcXPDBCM8eEkvoJ3mTk6el5l/P1EOCydkfGNZviE35ig+VGqZTHnFFEdlua
         pE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786656; x=1782391456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=se1m+X55xAiq5rNtyu6oD8WGyYy8gYhqav7rcWfx+4w=;
        b=OzfoWHORFs8aUk//RP2VarpAdZ+7KGAvuutiM59GGe38bgzLDVmUc5y4bKdZMVL6XO
         wzZsYlUr9h4UWxVBKzqXq0lTAeQ6b3weKmagbQhAsgA+H4cwK2LWgKU3dvM3EisNqyUa
         qZj+xujoR9F0/px6rG9j+Kx+eKkI6m+Bv59Tz13OnKEC5/4CjT1/cts6UV4Mbf+BQ2HK
         Ajmdr30lQuEDgtmrjHjy2vdifMghRGG9Fm90UG5BVIfk+kA0NsmASyXURQmc/JzHAn8t
         QKCbCEsIVFBnZIAcLr8KS9InN9AhTloLmF5UYPmS3MfVQe0eoGvrogxw1rixPhAd3PME
         bdFA==
X-Gm-Message-State: AOJu0YxHvLKcTFL3rjdzsT1IC7r7ORp4174PsTiZKoxk5DHWAznkHe4Z
	Fh2uNAKIFWVXzXvgrl8e2/Fx6TgYfhO7If9QwnzbwtWv22cWhRaCpxdTiKgN7MxR
X-Gm-Gg: AfdE7cmxjUFWQDLf+3dKjLsuUg7Kj5XJeD9bZwsK+0ChGqzpeHhxUxTqdlMv3hxtIlD
	RHOFoxBZHEMjJSB+9Ephsqwwlx8hQzo3hfpKKHf+O9A4ZIMXY0AZDwvgkxRnds3gDo28k9G9B2+
	jriQDMnShzFZSUOBqw7lGccZioSUFC8kCwxcBq5l1UgyjSss+2KV7R3dA5y6cRlglhGbvy7ygW7
	WcVWWNY3JDQ5OgFAHvT3HodhMBwIZjeq2bL/W0JBnvRSDUo0BT91zJdV2DYHUfl1rdxtlY2atM+
	Vqf/iA8R/cpnwjl3XUzd6Lr/nLP9vl+T1XPOoy8aOSVgA1TFK8Mn9Ml+TqzehNSmxh95FJrXN7b
	MW2EGZyyctOowJUacxAZb2RM805PnLmL6ExNwrp74zs/eVIit4/9XIidrFsk6If5DExgCBPf2xC
	4H3wDJsyJ2cGjPMp4L
X-Received: by 2002:a05:620a:4485:b0:919:5376:ff7c with SMTP id af79cd13be357-91d8add3bf5mr1339172485a.5.1781786655764;
        Thu, 18 Jun 2026 05:44:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f1c851sm2065556785a.16.2026.06.18.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:44:14 -0700 (PDT)
Message-Id: <8518f090b1069a02d40c710975528ad118776b67.1781786652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
References: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
	<pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 12:44:12 +0000
Subject: [PATCH v14 2/2] checkout: extend --track with a "fetch" mode to
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
index b78b3a1d16..37caceaefd 100644
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
@@ -116,6 +119,129 @@ struct branch_info {
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
@@ -1786,10 +1912,10 @@ static struct option *add_common_switch_branch_options(
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
@@ -1994,8 +2120,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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

Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5A3F0A8C
	for <git@vger.kernel.org>; Mon, 11 May 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507231; cv=none; b=Sl+5C48a4//AWBQClWC5VhVB+Z1VmYNOUcpinlc1Gl5XOraGCYjfdDpk1/IojSvcwKXsF84NZ6S4fzsJqSxYReWcQGXkAy9K+oydtweSwh2Ij0Tqx4KJLxPULHK9zKR/6vggKif7GEgy5ysqY0ohKzkp3fXL+4PXbIoZWGAY320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507231; c=relaxed/simple;
	bh=GB4R3u+7gHXvyKdhfNofmLj4yn9v/8h8TdaIYcRc+ug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yq011EsPRqByw49JEPEGYHBX1VyyKmLKL0Kcov29mXTV1Jle8cXMrhfxpTvVZ7GV/2gZx6tP6kVd47xgJmkT563RMcYIzmnQUtrldxDtqHCXBlSCsAkgTSjMfi5fUENPmKu5GE/e/IgYTRhxU/wALep1BUbGe+jfl4wZ1uWNZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFiMlT/Z; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFiMlT/Z"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c156c4a9efso5720763eec.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507228; x=1779112028; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb4X5TG2Cy25yD3TwWu7sZLVyTHmzDV9zGi0YTj8WGQ=;
        b=CFiMlT/ZIbv6s/UBmmAqpkuOFJqucY7NUO7p8bQVeY7CE1Ls4xYlL4ATvvHBLKx7d3
         jybWw9+lDcfifzrfmI2GmqBywN6PUytF8w4bC8ar2UaRfH8Ki9zr/7UNXeMguG456Zzz
         f9Ac6DTVkXb521jCuNUjo66K85ePZxBNJUidDftHXKtj0j8csa/9pu+pwJH1F9XsUhpV
         1Cvntj0m/9tyJlSDIOZH2U0tkezioa3y5+3BkzAVwc/xWhlVR710lgUQLeCnWhv3NzLJ
         pJhB2Ypb+Tc2ndmWFyo8LmDjnhizcL+nOM+fIf8bOIHQmbi8f0IzcgxuOZnrbX9AtMwP
         J0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507228; x=1779112028;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jb4X5TG2Cy25yD3TwWu7sZLVyTHmzDV9zGi0YTj8WGQ=;
        b=pbDfy3BNd2F6ay0D12PUkml+eTjFRw/sehrjC0y6+YlHe3CRPSqbZ6bk89CWbIzq0g
         NmGENSh+XKIhqaaLXQJQPgb4H82JJX/S9hqxdtrLtelb0kvPb5OnhE/SrkQNQtcakrxe
         esSuqte1C4RFVibssP/HLLBe/xr7V00JFi5WchbBED9YDJWcWYcbKlfZIy480IzK4QWJ
         pbqOi991xHeqNJECAtYwONlaHXguDjMAUkbG2Ojx1+BuP+5rpIBIkVnzEST5xTMOkGLN
         VCZFYlkmJ8MzDdsvChexHY5Qn3I37H/QisqiYZP0rN1U4ZeOwRuteBe2iQIL24Uhkjkp
         n2oA==
X-Gm-Message-State: AOJu0YzMFZmxKHZn/SZfd1MPzIFwuoudg9rFfseE2wVEo0wFAxU9iwAo
	+ZEQLiMyMlQm5SHICzU9kEojAEEt0OV6ABU8pa5XXYrl4Eu1/3bBz4+n22NgdZnL
X-Gm-Gg: Acq92OEeG9/+uwEkOSB2DzvRAJLlxQNeGpCtZ6umOSZrsz5/NT5TZI6e2HEKyeiOhXh
	3TSuiqzMzZfVTWT/OYhhntSG7JADx/SxII+EsMRKKrW2Jj3ShThPsf1OWuo9JLOBqMdcU7w3698
	3TkbndGv3Ai23KUMWv+J6XNwFbse/KjVLHgV9k8uCHfKTpQvnkMh1fa2U2KnBote3HGFQyOB3ak
	nPbDx6pZDfM9tjivLQPzH3e/8vaRsK9/5mjaFp2PSAL6YHloW39PY/Yklcg/hL2hL4PByYQgdCz
	Rp8HAJIfKEldSvzFchPf4XzjkKLWHllM4YKneDoSteDC7l09J0kfJlPIx8KYY6MPprnwPQlA48i
	hFASzRd3GR/d2QSkVomP58x2Qw0G/3AK3W4pWGPfFo7irfarpmSnm/gfLV7ARfbJ+82eGxIWFxT
	vQ9oj5HWxa/nkQRaj+r78jEvpnkHs=
X-Received: by 2002:a05:693c:394c:b0:2df:71f0:e5b3 with SMTP id 5a478bee46e88-2f54f9447a6mr11080506eec.20.1778507228058;
        Mon, 11 May 2026 06:47:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8860ce1bfsm13924403eec.9.2026.05.11.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:47:06 -0700 (PDT)
Message-Id: <pull.2281.v8.git.git.1778507225500.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v7.git.git.1778280727849.gitgitgadget@gmail.com>
References: <pull.2281.v7.git.git.1778280727849.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 13:47:05 +0000
Subject: [PATCH v8] checkout: extend --track with a "fetch" mode to refresh
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
    
    Check the fallback ref using arg directly instead of reconstructing it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v8
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v7:

 1:  de375d55f1 ! 1:  61c2199fd5 checkout: extend --track with a "fetch" mode to refresh start-point
     @@ builtin/checkout.c
       #include "revision.h"
      +#include "run-command.h"
       #include "setup.h"
     -+#include "strvec.h"
     + #include "strvec.h"
       #include "submodule.h"
     - #include "symlinks.h"
     - #include "trace2.h"
      @@ builtin/checkout.c: struct checkout_opts {
       	int count_checkout_paths;
       	int overlay_mode;
     @@ builtin/checkout.c: struct branch_info {
      +	if (resolve_fetch_target(arg, &remote_name, &src_ref))
      +		return;
      +
     -+	if (src_ref) {
     -+		const char *short_src = src_ref;
     ++	{
      +		struct object_id oid;
      +
     -+		skip_prefix(short_src, "refs/heads/", &short_src);
     -+		strbuf_addf(&dst_ref, "refs/remotes/%s/%s", remote_name, short_src);
     ++		if (strchr(arg, '/'))
     ++			strbuf_addf(&dst_ref, "refs/remotes/%s", arg);
     ++		else
     ++			strbuf_addf(&dst_ref, "refs/remotes/%s/HEAD", arg);
      +		if (!refs_read_ref(get_main_ref_store(the_repository),
      +				   dst_ref.buf, &oid))
      +			have_existing_ref = 1;


 Documentation/git-checkout.adoc |  13 ++-
 Documentation/git-switch.adoc   |  13 ++-
 builtin/checkout.c              | 168 +++++++++++++++++++++++++++++++-
 t/t7201-co.sh                   | 132 +++++++++++++++++++++++++
 4 files changed, 319 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..28f17f427e 100644
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
index 87707e9265..3f54cf39e9 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -154,11 +154,22 @@ should result in deletion of the path).
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
index ac0186a33e..157242bc9f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -26,10 +26,12 @@
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "refspec.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "run-command.h"
 #include "setup.h"
 #include "strvec.h"
 #include "submodule.h"
@@ -62,6 +64,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int fetch;
 	int discard_changes;
 	int accept_ref;
 	int accept_pathspec;
@@ -113,6 +116,157 @@ struct branch_info {
 	char *checkout;
 };
 
+static int resolve_fetch_target(const char *arg, char **remote_out,
+				char **src_ref_out)
+{
+	const char *slash;
+	char *remote_name;
+	struct remote *remote;
+	struct refspec_item query = { 0 };
+	struct strbuf dst = STRBUF_INIT;
+	const char *rest;
+
+	*remote_out = NULL;
+	*src_ref_out = NULL;
+
+	if (!arg || !*arg)
+		return -1;
+
+	slash = strchr(arg, '/');
+	if (slash == arg)
+		return -1;
+	remote_name = slash ? xstrndup(arg, slash - arg) : xstrdup(arg);
+
+	remote = remote_get(remote_name);
+	if (!remote || !remote_is_configured(remote, 1)) {
+		free(remote_name);
+		return -1;
+	}
+
+	rest = (slash && slash[1]) ? slash + 1 : NULL;
+	if (!rest) {
+		struct object_id oid;
+		const char *head_target;
+		const char *short_target;
+
+		strbuf_addf(&dst, "refs/remotes/%s/HEAD", remote_name);
+		head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						      dst.buf,
+						      RESOLVE_REF_READING |
+						      RESOLVE_REF_NO_RECURSE,
+						      &oid, NULL);
+		strbuf_reset(&dst);
+		if (head_target &&
+		    skip_prefix(head_target, "refs/remotes/", &short_target) &&
+		    skip_prefix(short_target, remote_name, &short_target) &&
+		    *short_target == '/')
+			rest = short_target + 1;
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
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf dst_ref = STRBUF_INIT;
+	int have_existing_ref = 0;
+
+	if (resolve_fetch_target(arg, &remote_name, &src_ref))
+		return;
+
+	{
+		struct object_id oid;
+
+		if (strchr(arg, '/'))
+			strbuf_addf(&dst_ref, "refs/remotes/%s", arg);
+		else
+			strbuf_addf(&dst_ref, "refs/remotes/%s/HEAD", arg);
+		if (!refs_read_ref(get_main_ref_store(the_repository),
+				   dst_ref.buf, &oid))
+			have_existing_ref = 1;
+	}
+
+	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
+	if (src_ref)
+		strvec_push(&cmd.args, src_ref);
+	cmd.git_cmd = 1;
+	if (run_command(&cmd)) {
+		if (have_existing_ref)
+			warning(_("failed to fetch start-point '%s'; "
+				  "using existing '%s'"),
+				arg, dst_ref.buf);
+		else
+			die(_("failed to fetch start-point '%s'"), arg);
+	}
+
+	free(remote_name);
+	free(src_ref);
+	strbuf_release(&dst_ref);
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
@@ -1244,7 +1398,6 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
-
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
 
@@ -1741,10 +1894,10 @@ static struct option *add_common_switch_branch_options(
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
@@ -1949,8 +2102,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
index 9bcf7c0b40..19ac6a1a2e 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -801,4 +801,136 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
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

base-commit: 7760f83b59750c27df653c5c46d0f80e44cfe02c
-- 
gitgitgadget

Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438473E51E3
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367019; cv=none; b=kVwS0DgCqiabuxBHL/ncieZZeAxOKl0evjqALbglx//kUBKgSP7XmCwOzF8Ge360MqqXyObBkva16v1Taq6J1QuTPGu1ayaHxzZFSX2cznkU5Mt9edW/4L2co3Rj5bw7YWQ1o9L5XG9Q2jpag6kFcWSpkDi6KsrJFQHwSM9gdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367019; c=relaxed/simple;
	bh=+N9JAeYQU1Wj9nTVl9JKahp/hWsGGISdHsytFg7Fpjk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MQvyeogy2Gv86IDN/4A7tIYXfmaGwKpO6+Di3BcieXTfCJMRX4E3raFRMsgfQeFaNdSW4JQCWhNmOy1swxT4+C75fDxy0SpL2NsECtSnBplWSsmgq4Di4o1HIstUJ78IdTVSrELCNixz3F27bR9xjC16c6Q7j/ZQUP/WX1JgCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TceKS+Dy; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TceKS+Dy"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12dca45ca21so4414852c88.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777367015; x=1777971815; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK1rn0AGj9rxhY2lcL5V7GGKYE9Mn1shbxMqb1nNsxI=;
        b=TceKS+Dyt6Ik8a/EQw6SDKeqOjNlXcmtqKotFCyKUYCIVKbW8SDpwlQVWxcHcS77kZ
         cE7fNNmvo+3aML3I3iQ8+ZOMot/sbyAD0+9agecR2accXzVdIdn+m/jkjyCWuJ21Y2FM
         1+wVJLTrZLFnF1tVc0poqTlFwFR14VDSxPZmpK0iWC1uZImCoSCXBrFiF2ObL653pxP4
         SPFDjv8N0Mc7U7p9egRxu1VIqQ5CezRIY/AoRTQwsH2o8wDwVU1mBiEn6j+4A8Kq8dCs
         Kj8BKuIwUlL1EnauKxU5qQMXKZr5uwhqir5pVPwFo/0KCJjZ0iOt57DWMGvWtM5R85+h
         TRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367015; x=1777971815;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lK1rn0AGj9rxhY2lcL5V7GGKYE9Mn1shbxMqb1nNsxI=;
        b=N4A8BHKQ1+fr42GNdgX4AnTVGPICQwe0GR7STAMAqYSZ/eg56eQau1aGmBnhuHrOQw
         iDawxpGumZPY3GXJaMh7vwFBoZDO4icpmnfW7XDivrQBOtU8bnOlTJ6bl2XaSATHwPOj
         JG/f3umXfI7bT66TuFDxPkD6dSnA40iixFyZaa2Nwf9DXOc6RQirufv993R6pLPyV2PD
         t6sNrR23fst/VC3QNUx0YpabA4SAfN79Wkwit4hLwLv+H2ZTnZcan4uinqtEFzF69TG/
         5R3iGK5aKz5vxs9atTpi6zH9BmKli1jdanZv1pw4hpmdOh4u4FBiU0YINXfRTYFU3CGl
         dOZw==
X-Gm-Message-State: AOJu0YwkYXGb+DnDqGbkpw9fEa2PH/e0jtRAVcuIKONBmLbXX/Dbz22R
	F7x13NAyFDtrm2O3uze4TI6AWT+4MKgU6zJBj0rVFDWlKUwyhBZJPiPKYLYCYA==
X-Gm-Gg: AeBDievYs++QcrG+/GpD1Q5KIebYV92820Pa5zNHc47mcKJC9zxO5oDBUS+r1xkHg/A
	pi73veX9HIoBXAC7QJnOcYeUHQzxqDTh2S3G/9gPXhZgfqV50X3Y1de8Z5vBglKVJkb0EFAbfSf
	hwfyBNpxwO8+gcEVua3EdSg6yJA84ikP1A1uLQ6xuvZksv7o4JS11mnd5zg+NiBiBOPcbOwTEoK
	vxxQ3mrStDYm3jeJr7JzLb/enDGuY2xEmRHS1POE5us5g/jKMXBJKpa6RWrzxHeOdVNGPn2eBtC
	IgMtI4IjfnP9RpDgUXkC8/o10WJsQwyrsTpA7ynTYgE2Hu2wOz6GvgtNT9UDqL+31YnH2wu3dOJ
	unqRedVhWcoMJechZstRoro6oSuU+209tc2fR3B4v/KfINjdAKE9UhX1J0Jl6IA1wWLW7/lohhl
	fwyC68KI5NyyCNNOk4E57V5dtIkEZ1v44yJwkK
X-Received: by 2002:a05:7022:61a7:b0:128:d29a:3d45 with SMTP id a92af1059eb24-12ddd9d1e97mr838351c88.22.1777367015200;
        Tue, 28 Apr 2026 02:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.234])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd93c1c0sm1663139c88.7.2026.04.28.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:03:34 -0700 (PDT)
Message-Id: <pull.2281.v5.git.git.1777367012441.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v4.git.git.1777228346809.gitgitgadget@gmail.com>
References: <pull.2281.v4.git.git.1777228346809.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 09:03:32 +0000
Subject: [PATCH v5] checkout: extend --track with a "fetch" mode to refresh
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
    git checkout -b new_branch --track origin/some-branch

The first command exists so the second sees an up-to-date view of the
remote. If it is forgotten, origin/some-branch points at a stale
commit and the new local branch is created from the wrong start
point. This only matters when the user is setting up tracking and
expects the new branch to start at the freshest tip; for a one-off
checkout of an arbitrary commit there is no reason to "freshen" the
start-point.

Tie the new behavior to --track for that reason: extend its argument
to take a comma-separated list, where "fetch" can be combined with the
existing "direct" (default) and "inherit" modes. Examples:

    git checkout --track=fetch -b new_branch origin/some-branch
    git checkout --track=fetch,inherit -b new_branch some_local_branch
    git switch --track=fetch -c new_branch origin/some-branch

When "fetch" is requested and <start-point> is in <remote>/<branch>
form, run "git fetch <remote> <branch>" before resolving the ref. This
narrows the fetch to the requested branch so that other
remote-tracking branches are left untouched -- many tools rely on the
stability of remote-tracking refs between explicit fetches. If
<start-point> is a bare remote name like "origin" (which resolves to
that remote's default branch), "git fetch <remote>" is run instead,
since the target branch is not known up front. Abort the checkout if
the fetch fails.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: add --fetch to fetch remote before resolving start-point
    
     * Folded --fetch into --track. The standalone --fetch/--no-fetch flags
       are gone; the same behavior is now requested via --track=fetch
       (combinable as --track=fetch,inherit).
     * Removed the checkout.fetch config. Since fetching is tied to --track,
       there's no separate config knob anymore.
     * Docs reworked accordingly. --track's syntax is now
       (direct|inherit|fetch)[,...] in both git-checkout and git-switch man
       pages, with the fetch behavior described under it. The old --fetch
       and checkout.fetch sections are deleted.
     * New parser callback in checkout.c. A small parse_opt_checkout_track
       splits the comma-separated argument with string_list_split and sets
       opts->track and opts->fetch together.
     * Tests updated and trimmed. All test invocations switched from --fetch
       to --track=fetch. Dropped the checkout.fetch=true and --no-fetch
       override tests (those features no longer exist). Added a
       --track=fetch,inherit test, a --track=bogus error test, and stronger
       config-assertion checks on the basic test. Two redundant tests
       (fetch,direct and order-insensitivity) were removed.
     * Completion list cleaned up. --fetch removed from the expected git
       checkout option list.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v5
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v4:

 1:  150ccbb621 ! 1:  8ebc2f94b9 checkout: add --fetch to fetch remote before resolving start-point
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    checkout: add --fetch to fetch remote before resolving start-point
     +    checkout: extend --track with a "fetch" mode to refresh start-point
      
          A common workflow is:
      
              git fetch origin
     -        git checkout -b new_branch origin/some-branch
     +        git checkout -b new_branch --track origin/some-branch
      
     -    The first command exists purely so the second sees an up-to-date view
     -    of the remote. If it is forgotten, origin/some-branch points at a stale
     -    commit and the new local branch is created from the wrong start point.
     +    The first command exists so the second sees an up-to-date view of the
     +    remote. If it is forgotten, origin/some-branch points at a stale
     +    commit and the new local branch is created from the wrong start
     +    point. This only matters when the user is setting up tracking and
     +    expects the new branch to start at the freshest tip; for a one-off
     +    checkout of an arbitrary commit there is no reason to "freshen" the
     +    start-point.
      
     -    Teach checkout (and switch) a --fetch flag that folds the two steps
     -    into one:
     +    Tie the new behavior to --track for that reason: extend its argument
     +    to take a comma-separated list, where "fetch" can be combined with the
     +    existing "direct" (default) and "inherit" modes. Examples:
      
     -        git checkout --fetch -b new_branch origin/some-branch
     +        git checkout --track=fetch -b new_branch origin/some-branch
     +        git checkout --track=fetch,inherit -b new_branch some_local_branch
     +        git switch --track=fetch -c new_branch origin/some-branch
      
     -    When --fetch is given and <start-point> is in <remote>/<branch> form,
     -    run "git fetch <remote> <branch>" before resolving the ref. This
     +    When "fetch" is requested and <start-point> is in <remote>/<branch>
     +    form, run "git fetch <remote> <branch>" before resolving the ref. This
          narrows the fetch to the requested branch so that other
          remote-tracking branches are left untouched -- many tools rely on the
          stability of remote-tracking refs between explicit fetches. If
     @@ Commit message
          since the target branch is not known up front. Abort the checkout if
          the fetch fails.
      
     -    Also add a checkout.fetch config to enable this by default.
     -
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## Documentation/config/checkout.adoc ##
     -@@ Documentation/config/checkout.adoc: commands or functionality in the future.
     - 	option in `git checkout` and `git switch`. See
     - 	linkgit:git-switch[1] and linkgit:git-checkout[1].
     - 
     -+`checkout.fetch`::
     -+	Provides the default value for the `--fetch` or `--no-fetch`
     -+	option in `git checkout` and `git switch`. See
     -+	linkgit:git-switch[1] and linkgit:git-checkout[1].
     -+
     - `checkout.workers`::
     - 	The number of parallel workers to use when updating the working tree.
     - 	The default is one, i.e. sequential execution. If set to a value less
     -
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: linkgit:git-config[1].
     - The default behavior can be set via the `checkout.guess` configuration
     - variable.
     +@@ Documentation/git-checkout.adoc: of it").
     + 	resets _<branch>_ to the start point instead of failing.
       
     -+`--fetch`::
     -+`--no-fetch`::
     -+	If _<start-point>_ refers to a remote-tracking branch, fetch
     -+	from that remote before resolving it. When _<start-point>_ is
     -+	in _<remote>/<branch>_ form, only that branch is updated; when
     -+	it is a bare remote name (e.g. `origin`), the whole remote is
     -+	fetched. If the fetch fails, the checkout is aborted.
     + `-t`::
     +-`--track[=(direct|inherit)]`::
     ++`--track[=(direct|inherit|fetch)[,...]]`::
     + 	When creating a new branch, set up "upstream" configuration. See
     + 	`--track` in linkgit:git-branch[1] for details. As a convenience,
     + 	--track without -b implies branch creation.
     + +
     ++The argument is a comma-separated list. `direct` (the default) and
     ++`inherit` select the tracking mode. Adding `fetch` requests that the
     ++remote be fetched before _<start-point>_ is resolved, so the new branch
     ++starts from a fresh tip: when _<start-point>_ is in
     ++_<remote>/<branch>_ form, only that branch is updated; when it is a
     ++bare remote name (e.g. `origin`), the whole remote is fetched. If the
     ++fetch fails, the checkout is aborted.
      ++
     -+The default behavior can be set via the `checkout.fetch` configuration
     -+variable.
     -+
     - `-l`::
     - 	Create the new branch's reflog; see linkgit:git-branch[1] for
     - 	details.
     + If no `-b` option is given, the name of the new branch will be
     + derived from the remote-tracking branch, by looking at the local part of
     + the refspec configured for the corresponding remote, and then stripping
      
       ## Documentation/git-switch.adoc ##
     -@@ Documentation/git-switch.adoc: ambiguous but exists on the 'origin' remote. See also
     - The default behavior can be set via the `checkout.guess` configuration
     - variable.
     +@@ Documentation/git-switch.adoc: should result in deletion of the path).
     + 	attached to a terminal, regardless of `--quiet`.
       
     -+`--fetch`::
     -+`--no-fetch`::
     -+	If _<start-point>_ refers to a remote-tracking branch, fetch
     -+	from that remote before resolving it. When _<start-point>_ is
     -+	in _<remote>/<branch>_ form, only that branch is updated; when
     -+	it is a bare remote name (e.g. `origin`), the whole remote is
     -+	fetched. If the fetch fails, the switch is aborted.
     + `-t`::
     +-`--track[ (direct|inherit)]`::
     ++`--track[=(direct|inherit|fetch)[,...]]`::
     + 	When creating a new branch, set up "upstream" configuration.
     + 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
     + 	details.
     + +
     ++The argument is a comma-separated list. `direct` (the default) and
     ++`inherit` select the tracking mode. Adding `fetch` requests that the
     ++remote be fetched before _<start-point>_ is resolved, so the new branch
     ++starts from a fresh tip: when _<start-point>_ is in
     ++_<remote>/<branch>_ form, only that branch is updated; when it is a
     ++bare remote name (e.g. `origin`), the whole remote is fetched. If the
     ++fetch fails, the switch is aborted.
      ++
     -+The default behavior can be set via the `checkout.fetch` configuration
     -+variable.
     -+
     - `-f`::
     - `--force`::
     - 	An alias for `--discard-changes`.
     + If no `-c` option is given, the name of the new branch will be derived
     + from the remote-tracking branch, by looking at the local part of the
     + refspec configured for the corresponding remote, and then stripping
      
       ## builtin/checkout.c ##
      @@
     @@ builtin/checkout.c: struct branch_info {
      +	if (run_command(&cmd))
      +		die(_("failed to fetch start-point '%s'"), arg);
      +}
     ++
     ++static int parse_opt_checkout_track(const struct option *opt,
     ++				    const char *arg, int unset)
     ++{
     ++	struct checkout_opts *opts = opt->value;
     ++	struct string_list tokens = STRING_LIST_INIT_DUP;
     ++	struct string_list_item *item;
     ++	int ret = 0;
     ++
     ++	if (unset) {
     ++		opts->track = BRANCH_TRACK_NEVER;
     ++		opts->fetch = 0;
     ++		return 0;
     ++	}
     ++
     ++	opts->track = BRANCH_TRACK_EXPLICIT;
     ++	if (!arg)
     ++		return 0;
     ++
     ++	string_list_split(&tokens, arg, ",", -1);
     ++	for_each_string_list_item(item, &tokens) {
     ++		if (!strcmp(item->string, "fetch")) {
     ++			opts->fetch = 1;
     ++		} else if (!strcmp(item->string, "direct")) {
     ++			opts->track = BRANCH_TRACK_EXPLICIT;
     ++		} else if (!strcmp(item->string, "inherit")) {
     ++			opts->track = BRANCH_TRACK_INHERIT;
     ++		} else {
     ++			ret = error(_("option `%s' expects \"%s\", \"%s\", "
     ++				      "or \"%s\""),
     ++				    "--track", "direct", "inherit", "fetch");
     ++			break;
     ++		}
     ++	}
     ++
     ++	string_list_clear(&tokens, 0);
     ++	return ret;
     ++}
      +
       static void branch_info_release(struct branch_info *info)
       {
     @@ builtin/checkout.c: static int git_checkout_config(const char *var, const char *
       		opts->dwim_new_local_branch = git_config_bool(var, value);
       		return 0;
       	}
     -+	if (!strcmp(var, "checkout.fetch")) {
     -+		opts->fetch = git_config_bool(var, value);
     -+		return 0;
     -+	}
     - 
     +-
       	if (starts_with(var, "submodule."))
       		return git_default_submodule_config(var, value, NULL);
     + 
     +@@ builtin/checkout.c: static struct option *add_common_switch_branch_options(
     + {
     + 	struct option options[] = {
     + 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
     +-		OPT_CALLBACK_F('t', "track",  &opts->track, "(direct|inherit)",
     ++		OPT_CALLBACK_F('t', "track",  opts, "(direct|inherit|fetch)[,...]",
     + 			N_("set branch tracking configuration"),
     + 			PARSE_OPT_OPTARG,
     +-			parse_opt_tracking_mode),
     ++			parse_opt_checkout_track),
     + 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
     + 			   PARSE_OPT_NOCOMPLETE),
     + 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unborn branch")),
      @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
       			opts->dwim_new_local_branch &&
       			opts->track == BRANCH_TRACK_UNSPECIFIED &&
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       		argv += n;
       		argc -= n;
       	} else if (!opts->accept_ref && opts->from_treeish) {
     -@@ builtin/checkout.c: int cmd_checkout(int argc,
     - 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
     - 		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
     - 			 N_("auto advance to the next file when selecting hunks interactively")),
     -+		OPT_BOOL(0, "fetch", &opts.fetch,
     -+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
     - 		OPT_END()
     - 	};
     - 
     -@@ builtin/checkout.c: int cmd_switch(int argc,
     - 			 N_("second guess 'git switch <no-such-branch>'")),
     - 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
     - 			 N_("throw away local modifications")),
     -+		OPT_BOOL(0, "fetch", &opts.fetch,
     -+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
     - 		OPT_END()
     - 	};
     - 
      
       ## t/t7201-co.sh ##
      @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
       	test_cmp_config "" --default "" branch.main2.merge
       '
       
     -+test_expect_success 'setup upstream for --fetch tests' '
     ++test_expect_success 'setup upstream for --track=fetch tests' '
      +	git checkout main &&
      +	git init fetch_upstream &&
      +	test_commit -C fetch_upstream u_main &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_commit -C fetch_upstream u_new
      +'
      +
     -+test_expect_success 'checkout --fetch -b picks up branch created upstream after clone' '
     ++test_expect_success 'checkout --track=fetch -b picks up branch created upstream after clone' '
      +	git checkout main &&
      +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
     -+	git checkout --fetch -b local_new fetch_upstream/fetch_new &&
     -+	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD
     ++	git checkout --track=fetch -b local_new fetch_upstream/fetch_new &&
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD &&
     ++	test_cmp_config fetch_upstream branch.local_new.remote &&
     ++	test_cmp_config refs/heads/fetch_new branch.local_new.merge
      +'
      +
     -+test_expect_success 'checkout --fetch <remote>/<branch> leaves other tracking branches untouched' '
     ++test_expect_success 'checkout --track=fetch <remote>/<branch> leaves other tracking branches untouched' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_target &&
      +	test_commit -C fetch_upstream u_target_pre &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_commit -C fetch_upstream u_target_post &&
      +	git -C fetch_upstream checkout fetch_other &&
      +	test_commit -C fetch_upstream u_other_post &&
     -+	git checkout --fetch -b local_target fetch_upstream/fetch_target &&
     ++	git checkout --track=fetch -b local_target fetch_upstream/fetch_target &&
      +	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
      +	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
      +'
      +
     -+test_expect_success 'checkout --fetch with bare remote name fetches the remote' '
     ++test_expect_success 'checkout --track=fetch with bare remote name fetches the remote' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_new2 &&
      +	test_commit -C fetch_upstream u_new2 &&
      +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2 &&
     -+	git checkout --fetch -b local_from_remote fetch_upstream &&
     ++	git checkout --track=fetch -b local_from_remote fetch_upstream &&
      +	git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2
      +'
      +
     -+test_expect_success 'checkout --fetch aborts and does not create branch on fetch failure' '
     ++test_expect_success 'checkout --track=fetch aborts and does not create branch on fetch failure' '
      +	git checkout main &&
      +	test_might_fail git branch -D bogus &&
     -+	test_must_fail git checkout --fetch -b bogus fetch_upstream/does_not_exist &&
     ++	test_must_fail git checkout --track=fetch -b bogus fetch_upstream/does_not_exist &&
      +	test_must_fail git rev-parse --verify refs/heads/bogus
      +'
      +
     -+test_expect_success 'checkout.fetch=true enables fetching without --fetch' '
     ++test_expect_success 'checkout --track=fetch,inherit fetches and inherits' '
      +	git checkout main &&
     -+	git -C fetch_upstream checkout -b fetch_cfg &&
     -+	test_commit -C fetch_upstream u_cfg &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
     -+	git -c checkout.fetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
     -+	test_cmp_rev refs/remotes/fetch_upstream/fetch_cfg HEAD
     -+'
     -+
     -+test_expect_success '--no-fetch overrides checkout.fetch=true' '
     ++	git -C fetch_upstream checkout -b fetch_inherit &&
     ++	test_commit -C fetch_upstream u_inherit &&
     ++	git fetch fetch_upstream fetch_inherit &&
     ++	git checkout -b base_inherit fetch_upstream/fetch_inherit &&
     ++	test_commit -C fetch_upstream u_inherit2 &&
      +	git checkout main &&
     -+	git -C fetch_upstream checkout -b fetch_nofetch &&
     -+	test_commit -C fetch_upstream u_nofetch &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_nofetch &&
     -+	test_must_fail git -c checkout.fetch=true checkout --no-fetch \
     -+		-b local_nofetch fetch_upstream/fetch_nofetch &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_nofetch &&
     -+	test_must_fail git rev-parse --verify refs/heads/local_nofetch
     ++	git checkout --track=fetch,inherit -b local_inherit base_inherit &&
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD &&
     ++	test_cmp_config fetch_upstream branch.local_inherit.remote &&
     ++	test_cmp_config refs/heads/fetch_inherit branch.local_inherit.merge
      +'
      +
     -+test_expect_success '--no-fetch overrides earlier --fetch on command line' '
     ++test_expect_success 'checkout --track=bogus reports an error' '
      +	git checkout main &&
     -+	git -C fetch_upstream checkout -b fetch_override &&
     -+	test_commit -C fetch_upstream u_override &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_override &&
     -+	test_must_fail git checkout --fetch --no-fetch \
     -+		-b local_override fetch_upstream/fetch_override &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_override &&
     -+	test_must_fail git rev-parse --verify refs/heads/local_override
     ++	test_must_fail git checkout --track=bogus -b bogus_branch fetch_upstream/fetch_new 2>err &&
     ++	test_grep "expects" err
      +'
      +
     -+test_expect_success 'switch --fetch -c picks up branch created upstream after clone' '
     ++test_expect_success 'switch --track=fetch -c picks up branch created upstream after clone' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_switch &&
      +	test_commit -C fetch_upstream u_switch &&
      +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
     -+	git switch --fetch -c local_switch fetch_upstream/fetch_switch &&
     ++	git switch --track=fetch -c local_switch fetch_upstream/fetch_switch &&
      +	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
      +'
      +
       test_done
     -
     - ## t/t9902-completion.sh ##
     -@@ t/t9902-completion.sh: test_expect_success 'double dash "git checkout"' '
     - 	--ignore-other-worktrees Z
     - 	--recurse-submodules Z
     - 	--auto-advance Z
     -+	--fetch Z
     - 	--progress Z
     - 	--guess Z
     - 	--no-guess Z


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

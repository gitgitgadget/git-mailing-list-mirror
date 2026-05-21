Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C743955C4
	for <git@vger.kernel.org>; Thu, 21 May 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358811; cv=none; b=Zmt9hWlBj3YZ/ys2vPOEU4W2jGkV3yX2z8wS8ssQWwmS1iOylnwz3g0UTT/rLiLmwcAhKffgziZ987eTk+wTq52gE1+ReGw41Rfmm4J5DOxAbhfGPxtj90cNVxDJ4LuT9urHmSrroh09p4Yg32Q7/A1aGaeVQMxiuh1EPmto9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358811; c=relaxed/simple;
	bh=PGnBVytSlmObjGtlGpS+cu4/pDfrRGZusVxtE7lYXEw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=djP/7ASyvw5+hJpRTQZPk5Kxk2bsU3RGcXML2/LIdwqGjtKMpHrugij5XJiTWSKIH6gZiIORMhUMvshrAIUPoOUjCVjOc/PQ0BHC7Bk9OT9bCN9OzM9JuX55dWqWug3vp8y4o4pLTWm4Ij4ClfbTBb51+eI4gd8Y+SUeySqgDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TisQBPqi; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TisQBPqi"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-484ba8bc89eso4008462b6e.2
        for <git@vger.kernel.org>; Thu, 21 May 2026 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358807; x=1779963607; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CprCqtWlNt8fqJ0KstMTvegjB7y9lRqYsVWu8QPit08=;
        b=TisQBPqibJJaVKpI2ATEMYb5f010JIW31PzfduUt9lu0vdIl6QnykrJBWjRpQVx3MW
         bYPHBEIszP6aNMcq2YDTUnPTbNwzrxwhM3C30IuWuXtACRG4Orl79ubRHYEW2+YPCjue
         eQ+uidErJq6q5SxSN1QnmhgLaDhG9JDQpCow4jiODc2pzpCPBwnvCElEybhXHIj57qIL
         WLs9qF/Z/HYB0RDfOI+3qN8ARh+G2DHI54wF12tgigkH6Cr1CWdxVMWmYdzxTPA2C2KQ
         g5vjNZ4YaHnsM6f7OX6Uob8X4K9ZTc4deDY3NEMXFCVT7zo9jSfd6pbmjDdZunk317Gv
         Yv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358807; x=1779963607;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CprCqtWlNt8fqJ0KstMTvegjB7y9lRqYsVWu8QPit08=;
        b=qYF9TyJt3bu3aKA+Wa81kL45OLgIkpcM+R+FTSMySI7WuKfJHf9pXUChqSLstDi0Lw
         kOJyWgxZkZy0IPJJBsbRWrFInYXHRzkV8CvvJtIHfobWPvw+esttxE2I9pELYtp3WXDK
         JLVeAYgSKvPaUaK6mxYu88Na8ZUgEUXLKbVKWop9SJtovlQsL2yQn69sHaafMG1rJB+6
         K5+vwPvZnPX78MXoTO6TbL6mPj61aWO1eyWW0PFqAh0eP52dVoDAoSMlRNMluVXXvhIh
         BPEEtR0dfbUwItGpeYesv8HhZgi5U+kfOX1S0igOHVDfLY2jpcfJVdmoTUZsH04uXXFd
         VDMA==
X-Gm-Message-State: AOJu0YxLDwRGEgs25MFXD+zMO6JNOMgqweUR9yXRv2kn5sbWN24BN0FD
	mehgt3LWK/2jwjmDtXqycr740/D7RfPadQBDJzIyOwYuGkvVvqy3RdC34UU+Ug==
X-Gm-Gg: Acq92OG5/p3VI7zTx2fVqJKoYUEqPro64z+txizvjS2lnEopZ1hN4msii0fkO/FNI27
	Zf+k4FCdJWZHsDrjXgVbST5Rg0pGS35bsvb2Bg8hVD0PgklhSOoLPhBu9LVHTCmeZZF0dmHLic7
	djRTbpvh/AO0euRAJVkdZlg8rj4PbMEAUOSODIPh73XYY+H0feICpKdRrB1wD5Bhq3XsW81rtAo
	CVBPPAbB+B3wy2qeJ1Sbr6shB03g8T7vmyMUSNJWDZglNTqQoEpD6fhzKDt22SvVG1cAM7jYto/
	PKkA1epkZCQLpht6yOGR5+PVMYeg5lRbfDqj3MbVE2pGAC9x/iDH9xpuwO6W0phcPZiqBYa/znG
	B96HnilDaH19cr+jFNBa/STeUHZXuY+ELC1/Y0DbRT4+LL8Yl4JkaWGQAp6y0fRRLFHkf33ZIvm
	qWw+zCui7gS4nwuyO7p2RZS9CTy7Aufrb+pE7A04kh+wmM+bE=
X-Received: by 2002:a05:6808:4703:b0:479:f58a:c5d5 with SMTP id 5614622812f47-4852ee66556mr1187656b6e.45.1779358806988;
        Thu, 21 May 2026 03:20:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.213.18])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b448607e1sm328066fac.4.2026.05.21.03.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:20:05 -0700 (PDT)
Message-Id: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
References: <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 10:20:03 +0000
Subject: [PATCH v12] checkout: extend --track with a "fetch" mode to refresh
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

Add a "fetch" mode to the "--track" option of "git checkout" / "git
switch" that refreshes <start-point> before checking it out:

    git checkout -b new_branch --track=fetch origin/some-branch

is shorthand for

    git fetch origin some-branch
    git checkout -b new_branch --track origin/some-branch

Identify the remote whose configured fetch refspec maps to
<start-point>, then run "git fetch <remote> <src-ref>" for just that
ref so other remote-tracking branches are left untouched. When
<start-point> is a bare <remote> (e.g. "origin"), follow
refs/remotes/<remote>/HEAD to learn which branch to refresh. If
"git fetch" fails but the remote-tracking ref already exists locally,
warn and proceed from the existing tip; otherwise abort.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: --track=fetch
    
     * Find the right remote by matching fetch refspecs. Instead of assuming
       the start-point begins with a remote's name, ask each configured
       remote whether its fetch refspec maps to refs/remotes/<start-point>.
     * Die clearly when no remote matches. Previously, if we couldn't figure
       out the remote we'd silently skip the fetch and fall through to a
       confusing later error.
     * Die clearly when more than one remote matches. If two remotes both
       map their fetches into the same refs/remotes/<ns>/* namespace, there
       is no unambiguous choice.
     * Bare-namespace form (--track=fetch origin) requires <ns>/HEAD. When
       the user passes just a namespace, we now follow
       refs/remotes/<ns>/HEAD to learn which branch to refresh. If that
       symref is missing, die with a hint to run git remote set-head <ns>
       --auto instead of guessing or fetching everything. If <ns>/HEAD
       points outside the namespace, reject it.
     * Validate the refname before doing anything. Reject obviously invalid
       start-points like foo..bar up front, so we don't run a fetch we know
       cannot succeed.
     * Forward --quiet to the underlying fetch. checkout -q --track=fetch
       ... now suppresses the fetch progress output, matching the user's
       intent.
     * More tests coverage.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v12
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v11:

 1:  d0c9e3e879 ! 1:  bcd034dbed checkout: extend --track with a "fetch" mode to refresh start-point
     @@ Metadata
       ## Commit message ##
          checkout: extend --track with a "fetch" mode to refresh start-point
      
     -    If you want to fork your topic branch from the very latest of the
     -    tip of a branch your remote has, you would do:
     -
     -        git fetch origin some-branch
     -        git checkout -b new_branch --track origin/some-branch
     -
     -    Extend the "--track" option of "git checkout" and allow users to
     -    write
     +    Add a "fetch" mode to the "--track" option of "git checkout" / "git
     +    switch" that refreshes <start-point> before checking it out:
      
              git checkout -b new_branch --track=fetch origin/some-branch
      
     -    to (1) fetch 'some-branch' from the remote 'origin', updating the
     -    remote-tracking branch 'origin/some-branch', (2) arrange subsequent
     -    'git pull' on 'new_branch' to interact with 'origin/some-branch' and
     -    (3) fork 'new_branch' from it.
     -
     -    In the value of the '--track' option, 'fetch' can be combined with
     -    the existing 'direct' (default) and 'inherit' modes via a
     -    comma-separated list. Examples:
     +    is shorthand for
      
     -        git checkout -b new_branch --track=fetch,inherit some_local_branch
     -        git switch -c new_branch --track=fetch origin/some-branch
     +        git fetch origin some-branch
     +        git checkout -b new_branch --track origin/some-branch
      
     -    When "fetch" is requested and <start-point> is in <remote>/<branch>
     -    form, run "git fetch <remote> <branch>" before resolving the ref, so
     -    that other remote-tracking branches are left untouched. If
     -    <start-point> is a bare remote name like "origin" (which resolves to
     -    that remote's default branch), "git fetch <remote>" is run instead,
     -    since the target branch is not known up front. Abort the checkout if
     -    the fetch fails.
     +    Identify the remote whose configured fetch refspec maps to
     +    <start-point>, then run "git fetch <remote> <src-ref>" for just that
     +    ref so other remote-tracking branches are left untouched. When
     +    <start-point> is a bare <remote> (e.g. "origin"), follow
     +    refs/remotes/<remote>/HEAD to learn which branch to refresh. If
     +    "git fetch" fails but the remote-tracking ref already exists locally,
     +    warn and proceed from the existing tip; otherwise abort.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-checkout.adoc: of it").
      +`fetch` requests that the remote be fetched before _<start-point>_ is
      +resolved, so the new branch starts from a fresh tip: when
      +_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
     -+updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
     -+only the remote's default branch is updated. If the fetch fails and the
     ++updated; when _<start-point>_ is a bare _<remote>_ (e.g. `origin`), the
     ++branch named by _<remote>/HEAD_ is updated, and the checkout fails
     ++with a hint to configure that symref if it is not set. The checkout
     ++also fails if no configured remote's fetch refspec maps to
     ++_<start-point>_, or if more than one does (in which case the `fetch`
     ++cannot be unambiguously routed). If the fetch itself fails and the
      +corresponding remote-tracking ref already exists, a warning is printed
      +and the checkout proceeds from the existing tip; otherwise the checkout
      +is aborted.
     @@ Documentation/git-switch.adoc: variable.
      +`--track[=(direct|inherit|fetch)[,...]]`::
       	When creating a new branch, set up "upstream" configuration.
       	`-c` is implied. See `--track` in linkgit:git-branch[1] for
     - 	details.
     +-	details.
     ++	details, and `--track` in linkgit:git-checkout[1] for the
     ++	`fetch` mode.
       +
     -+The argument is a comma-separated list. `direct` (the default) and
     -+`inherit` select the tracking mode and are mutually exclusive. Adding
     -+`fetch` requests that the remote be fetched before _<start-point>_ is
     -+resolved, so the new branch starts from a fresh tip: when
     -+_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
     -+updated; when _<start-point>_ is a bare remote name (e.g. `origin`),
     -+only the remote's default branch is updated. If the fetch fails and the
     -+corresponding remote-tracking ref already exists, a warning is printed
     -+and the switch proceeds from the existing tip; otherwise the switch is
     -+aborted.
     -++
       If no `-c` option is given, the name of the new branch will be derived
       from the remote-tracking branch, by looking at the local part of the
     - refspec configured for the corresponding remote, and then stripping
      
       ## builtin/checkout.c ##
      @@
     @@ builtin/checkout.c: struct branch_info {
       };
       
      +struct fetch_target_cb {
     -+	struct refspec_item query;
     -+	const char *remote_name;
     -+	int matches;
     ++	char *dst;
     ++	struct string_list matches;
      +};
      +
      +static int match_fetch_target(struct remote *remote, void *priv)
      +{
      +	struct fetch_target_cb *cb = priv;
     -+	struct refspec_item q = { .dst = cb->query.dst };
     -+
     -+	if (!remote_find_tracking(remote, &q) && q.src) {
     -+		if (++cb->matches == 1) {
     -+			cb->remote_name = remote->name;
     -+			free(cb->query.src);
     -+			cb->query.src = q.src;
     -+		} else {
     -+			free(q.src);
     -+		}
     -+	}
     ++	struct refspec_item q = { .dst = cb->dst };
     ++
     ++	if (!remote_find_tracking(remote, &q) && q.src)
     ++		string_list_append(&cb->matches, remote->name)->util = q.src;
      +	return 0;
      +}
      +
     -+static int resolve_fetch_target(const char *arg, char **remote_out,
     -+				char **src_ref_out, char **existing_ref_out)
     ++static void fetch_remote_for_start_point(const char *arg, int quiet)
      +{
      +	struct strbuf dst = STRBUF_INIT;
     -+	struct strbuf head_path = STRBUF_INIT;
     -+	struct fetch_target_cb cb = { 0 };
     ++	struct fetch_target_cb cb = { .matches = STRING_LIST_INIT_NODUP };
     ++	struct child_process cmd = CHILD_PROCESS_INIT;
      +	struct object_id oid;
     -+	const char *head_target;
     -+
     -+	*remote_out = NULL;
     -+	*src_ref_out = NULL;
     -+	*existing_ref_out = NULL;
     -+
     -+	if (!arg || !*arg)
     -+		return -1;
     -+
     -+	strbuf_addf(&head_path, "refs/remotes/%s/HEAD", arg);
     -+	head_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     -+					      head_path.buf,
     -+					      RESOLVE_REF_READING |
     -+					      RESOLVE_REF_NO_RECURSE,
     -+					      &oid, NULL);
     -+	if (head_target)
     -+		strbuf_addstr(&dst, head_target);
     -+	else
     -+		strbuf_addf(&dst, "refs/remotes/%s", arg);
     -+
     -+	cb.query.dst = dst.buf;
     -+	for_each_remote(match_fetch_target, &cb);
     -+
     -+	if (cb.matches != 1) {
     -+		free(cb.query.src);
     -+		strbuf_release(&dst);
     -+		strbuf_release(&head_path);
     -+		return -1;
     ++	struct remote *named_remote;
     ++	int bare_ns;
     ++	size_t i;
     ++
     ++	strbuf_addf(&dst, "refs/remotes/%s", arg);
     ++	if (check_refname_format(dst.buf, 0))
     ++		die(_("cannot fetch start-point '%s': not a valid "
     ++		      "remote-tracking name"), arg);
     ++
     ++	named_remote = remote_get(arg);
     ++	bare_ns = !strchr(arg, '/') ||
     ++		(named_remote && remote_is_configured(named_remote, 1));
     ++	if (bare_ns) {
     ++		char *head_path = xstrfmt("refs/remotes/%s/HEAD", arg);
     ++		const char *head_target =
     ++			refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     ++						head_path,
     ++						RESOLVE_REF_READING |
     ++						RESOLVE_REF_NO_RECURSE,
     ++						&oid, NULL);
     ++		if (head_target &&
     ++		    starts_with(head_target, dst.buf) &&
     ++		    head_target[dst.len] == '/' &&
     ++		    !check_refname_format(head_target, 0)) {
     ++			strbuf_reset(&dst);
     ++			strbuf_addstr(&dst, head_target);
     ++			bare_ns = 0;
     ++		}
     ++		free(head_path);
      +	}
      +
     -+	*remote_out = xstrdup(cb.remote_name);
     -+	*src_ref_out = cb.query.src;
     -+	if (head_target)
     -+		*existing_ref_out = strbuf_detach(&head_path, NULL);
     -+	else if (!refs_read_ref(get_main_ref_store(the_repository),
     -+				dst.buf, &oid))
     -+		*existing_ref_out = strbuf_detach(&dst, NULL);
     -+
     -+	strbuf_release(&dst);
     -+	strbuf_release(&head_path);
     -+	return 0;
     -+}
     ++	cb.dst = dst.buf;
     ++	for_each_remote(match_fetch_target, &cb);
      +
     -+static void fetch_remote_for_start_point(const char *arg)
     -+{
     -+	char *remote_name = NULL;
     -+	char *src_ref = NULL;
     -+	char *existing_ref = NULL;
     -+	struct child_process cmd = CHILD_PROCESS_INIT;
     ++	if (cb.matches.nr > 1) {
     ++		struct strbuf msg = STRBUF_INIT;
     ++
     ++		strbuf_addf(&msg,
     ++			    _("cannot fetch start-point '%s': fetch refspecs "
     ++			      "of multiple remotes map to the same destination:"),
     ++			    arg);
     ++		for (i = 0; i < cb.matches.nr; i++)
     ++			strbuf_addf(&msg, "\n  %s", cb.matches.items[i].string);
     ++		strbuf_addstr(&msg,
     ++			      _("\nadjust 'remote.<name>.fetch' so only one "
     ++				"remote maps there, or omit '=fetch'"));
     ++		die("%s", msg.buf);
     ++	}
      +
     -+	if (resolve_fetch_target(arg, &remote_name, &src_ref, &existing_ref))
     -+		return;
     ++	if (!cb.matches.nr) {
     ++		if (bare_ns && named_remote &&
     ++		    remote_is_configured(named_remote, 1))
     ++			die(_("cannot fetch start-point '%s': "
     ++			      "'refs/remotes/%s/HEAD' is not set; run "
     ++			      "'git remote set-head %s --auto' to set it"),
     ++			    arg, arg, arg);
     ++		die(_("cannot fetch start-point '%s': no configured remote's "
     ++		      "fetch refspec matches it"), arg);
     ++	}
      +
     -+	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
     -+	if (src_ref)
     -+		strvec_push(&cmd.args, src_ref);
     ++	strvec_push(&cmd.args, "fetch");
     ++	if (quiet)
     ++		strvec_push(&cmd.args, "--quiet");
     ++	strvec_pushl(&cmd.args, cb.matches.items[0].string,
     ++		     (char *)cb.matches.items[0].util, NULL);
      +	cmd.git_cmd = 1;
      +	if (run_command(&cmd)) {
     -+		if (existing_ref)
     ++		if (!refs_read_ref(get_main_ref_store(the_repository),
     ++				   dst.buf, &oid))
      +			warning(_("failed to fetch start-point '%s'; "
     -+				  "using existing '%s'"),
     -+				arg, existing_ref);
     ++				  "using existing '%s'"), arg, dst.buf);
      +		else
      +			die(_("failed to fetch start-point '%s'"), arg);
      +	}
      +
     -+	free(remote_name);
     -+	free(src_ref);
     -+	free(existing_ref);
     ++	for (i = 0; i < cb.matches.nr; i++)
     ++		free(cb.matches.items[i].util);
     ++	string_list_clear(&cb.matches, 0);
     ++	strbuf_release(&dst);
      +}
      +
      +static int parse_opt_checkout_track(const struct option *opt,
     @@ builtin/checkout.c: struct branch_info {
      +	struct checkout_opts *opts = opt->value;
      +	struct string_list tokens = STRING_LIST_INIT_DUP;
      +	struct string_list_item *item;
     -+	int saw_direct = 0, saw_inherit = 0;
     ++	int saw_direct = 0;
      +	int ret = 0;
      +
      +	opts->fetch = 0;
     -+
      +	if (unset) {
      +		opts->track = BRANCH_TRACK_NEVER;
      +		return 0;
      +	}
     -+
      +	opts->track = BRANCH_TRACK_EXPLICIT;
      +	if (!arg)
      +		return 0;
      +
      +	string_list_split(&tokens, arg, ",", -1);
      +	for_each_string_list_item(item, &tokens) {
     -+		if (!strcmp(item->string, "fetch")) {
     ++		if (!strcmp(item->string, "fetch"))
      +			opts->fetch = 1;
     -+		} else if (!strcmp(item->string, "direct")) {
     ++		else if (!strcmp(item->string, "direct"))
      +			saw_direct = 1;
     -+			opts->track = BRANCH_TRACK_EXPLICIT;
     -+		} else if (!strcmp(item->string, "inherit")) {
     -+			saw_inherit = 1;
     ++		else if (!strcmp(item->string, "inherit"))
      +			opts->track = BRANCH_TRACK_INHERIT;
     -+		} else {
     ++		else {
      +			ret = error(_("option `%s' expects \"%s\", \"%s\", "
      +				      "or \"%s\""),
      +				    "--track", "direct", "inherit", "fetch");
      +			goto out;
      +		}
      +	}
     -+
     -+	if (saw_direct && saw_inherit)
     ++	if (saw_direct && opts->track == BRANCH_TRACK_INHERIT)
      +		ret = error(_("option `%s' cannot combine \"%s\" and \"%s\""),
      +			    "--track", "direct", "inherit");
     -+
      +out:
      +	string_list_clear(&tokens, 0);
      +	return ret;
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
      +		int n;
      +
      +		if (opts->fetch)
     -+			fetch_remote_for_start_point(argv[0]);
     ++			fetch_remote_for_start_point(argv[0], opts->quiet);
      +
      +		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
      +					 &new_branch_info, opts, &rev);
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	git checkout main &&
      +	git remote add fetch_ns ./fetch_upstream &&
      +	test_when_finished "git remote remove fetch_ns" &&
     ++	test_when_finished "git update-ref -d refs/remotes/ns_alias/HEAD" &&
      +	git config --replace-all remote.fetch_ns.fetch \
      +		"+refs/heads/*:refs/remotes/ns_alias/*" &&
      +	git fetch fetch_ns &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_cmp_config refs/heads/main branch.local_ns.merge
      +'
      +
     ++test_expect_success '--track=fetch on bare hierarchical remote name follows <ns>/HEAD' '
     ++	git checkout main &&
     ++	git remote add nested/bare ./fetch_upstream &&
     ++	test_when_finished "git remote remove nested/bare" &&
     ++	test_when_finished "git update-ref -d refs/remotes/nested/bare/HEAD" &&
     ++	git fetch nested/bare &&
     ++	git symbolic-ref refs/remotes/nested/bare/HEAD \
     ++		refs/remotes/nested/bare/main &&
     ++	git -C fetch_upstream checkout main &&
     ++	test_commit -C fetch_upstream u_nested_bare_post &&
     ++	git checkout --track=fetch -b local_nested_bare nested/bare &&
     ++	test_cmp_rev refs/remotes/nested/bare/main HEAD
     ++'
     ++
      +test_expect_success 'checkout --track=fetch handles hierarchical remote name' '
      +	git checkout main &&
     -+	git -C fetch_upstream checkout -b fetch_hier &&
     -+	test_commit -C fetch_upstream u_hier &&
      +	git remote add nested/remote ./fetch_upstream &&
      +	test_when_finished "git remote remove nested/remote" &&
     -+	git fetch nested/remote fetch_hier &&
     -+	test_commit -C fetch_upstream u_hier_post &&
     ++	git -C fetch_upstream checkout -b fetch_hier &&
     ++	test_commit -C fetch_upstream u_hier &&
     ++	test_must_fail git rev-parse --verify refs/remotes/nested/remote/fetch_hier &&
      +	git checkout --track=fetch -b local_hier nested/remote/fetch_hier &&
      +	test_cmp_rev refs/remotes/nested/remote/fetch_hier HEAD
      +'
      +
     ++test_expect_success 'checkout --track=fetch dies on bare remote name with no <ns>/HEAD' '
     ++	git checkout main &&
     ++	git remote add fetch_nohead ./fetch_upstream &&
     ++	test_when_finished "git remote remove fetch_nohead" &&
     ++	test_might_fail git symbolic-ref -d refs/remotes/fetch_nohead/HEAD &&
     ++	test_must_fail git checkout --track=fetch -b local_nohead fetch_nohead 2>err &&
     ++	test_grep "refs/remotes/fetch_nohead/HEAD" err &&
     ++	test_grep "git remote set-head fetch_nohead --auto" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_nohead
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch on bare unknown name does not suggest set-head' '
     ++	git checkout main &&
     ++	test_must_fail git rev-parse --verify refs/remotes/no_such_ns/HEAD &&
     ++	test_must_fail git config --get remote.no_such_ns.url &&
     ++	test_must_fail git checkout --track=fetch -b local_unknown no_such_ns 2>err &&
     ++	test_grep "no configured remote" err &&
     ++	test_grep ! "set-head" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_unknown
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch rejects <ns>/HEAD pointing outside namespace' '
     ++	git checkout main &&
     ++	git remote add fetch_crossns ./fetch_upstream &&
     ++	test_when_finished "git remote remove fetch_crossns" &&
     ++	test_when_finished "git update-ref -d refs/remotes/fetch_crossns/HEAD" &&
     ++	git fetch fetch_crossns &&
     ++	git symbolic-ref refs/remotes/fetch_crossns/HEAD \
     ++		refs/remotes/fetch_upstream/u_main &&
     ++	test_must_fail git checkout --track=fetch -b local_crossns fetch_crossns 2>err &&
     ++	test_grep "refs/remotes/fetch_crossns/HEAD" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_crossns
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch dies on ambiguous fetch refspec match' '
     ++	git checkout main &&
     ++	git remote add fetch_ambig_a ./fetch_upstream &&
     ++	git remote add fetch_ambig_b ./fetch_upstream &&
     ++	test_when_finished "git remote remove fetch_ambig_a" &&
     ++	test_when_finished "git remote remove fetch_ambig_b" &&
     ++	git config --replace-all remote.fetch_ambig_a.fetch \
     ++		"+refs/heads/*:refs/remotes/ambig_ns/*" &&
     ++	git config --replace-all remote.fetch_ambig_b.fetch \
     ++		"+refs/heads/*:refs/remotes/ambig_ns/*" &&
     ++	git -C fetch_upstream checkout -b fetch_ambig &&
     ++	test_commit -C fetch_upstream u_ambig &&
     ++	test_must_fail git checkout --track=fetch -b local_ambig ambig_ns/fetch_ambig 2>err &&
     ++	test_grep "fetch_ambig_a" err &&
     ++	test_grep "fetch_ambig_b" err &&
     ++	test_grep "remote.<name>.fetch" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_ambig
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch rejects invalid refname components' '
     ++	git checkout main &&
     ++	test_must_fail git checkout --track=fetch -b local_invalid "foo..bar" 2>err &&
     ++	test_grep "valid" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_invalid
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch,inherit rejects invalid refname components' '
     ++	git checkout main &&
     ++	test_must_fail git checkout --track=fetch,inherit -b local_invalid \
     ++		"foo..bar" 2>err &&
     ++	test_grep "valid" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/local_invalid
     ++'
     ++
      +test_expect_success 'checkout --track=inherit,direct is rejected' '
      +	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
      +	test_grep "cannot combine" err
      +'
      +
     ++test_expect_success 'checkout --track=direct,inherit is rejected' '
     ++	test_must_fail git checkout --track=direct,inherit -b bad fetch_upstream/fetch_new 2>err &&
     ++	test_grep "cannot combine" err
     ++'
     ++
      +test_expect_success 'checkout --track=fetch then --track=direct drops fetch (last-one-wins)' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_lastwin &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin
      +'
      +
     -+test_expect_success 'checkout --track=fetch,inherit fetches and inherits' '
     ++test_expect_success 'checkout --track=fetch then --no-track drops fetch' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_notrack &&
     ++	test_commit -C fetch_upstream u_notrack &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack &&
     ++	test_must_fail git checkout --track=fetch --no-track \
     ++		-b local_notrack fetch_upstream/fetch_notrack &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch,inherit fetches remote-tracking start-point' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_inherit &&
      +	test_commit -C fetch_upstream u_inherit &&
     -+	git fetch fetch_upstream fetch_inherit &&
     -+	git checkout -b base_inherit fetch_upstream/fetch_inherit &&
     -+	test_commit -C fetch_upstream u_inherit2 &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_inherit &&
     ++	git checkout --track=fetch,inherit -b local_inherit \
     ++		fetch_upstream/fetch_inherit &&
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch,inherit errors when start-point does not map to a remote' '
      +	git checkout main &&
     -+	git checkout --track=fetch,inherit -b local_inherit base_inherit &&
     -+	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD &&
     -+	test_cmp_config fetch_upstream branch.local_inherit.remote &&
     -+	test_cmp_config refs/heads/fetch_inherit branch.local_inherit.merge
     ++	test_must_fail git checkout --track=fetch,inherit -b bad main 2>err &&
     ++	test_grep "no configured remote" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/bad
     ++'
     ++
     ++test_expect_success 'checkout --track=fetch on local start-point errors' '
     ++	git checkout main &&
     ++	test_must_fail git checkout --track=fetch -b bad main 2>err &&
     ++	test_grep "no configured remote" err &&
     ++	test_must_fail git rev-parse --verify refs/heads/bad
      +'
      +
      +test_expect_success 'checkout --track=bogus reports an error' '
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_grep "expects" err
      +'
      +
     ++test_expect_success 'checkout -q --track=fetch silences the fetch output' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_quiet &&
     ++	test_commit -C fetch_upstream u_quiet &&
     ++	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_quiet &&
     ++	git checkout -q --track=fetch -b local_quiet \
     ++		fetch_upstream/fetch_quiet 2>err &&
     ++	test_grep ! "-> fetch_upstream/fetch_quiet" err &&
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_quiet HEAD
     ++'
     ++
      +test_expect_success 'switch --track=fetch -c picks up branch created upstream after clone' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_switch &&


 Documentation/git-checkout.adoc |  17 +-
 Documentation/git-switch.adoc   |   5 +-
 builtin/checkout.c              | 159 +++++++++++++++++-
 t/t7201-co.sh                   | 276 ++++++++++++++++++++++++++++++++
 4 files changed, 450 insertions(+), 7 deletions(-)

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
index 1345e8574a..9c5c4f1c2e 100644
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
@@ -115,6 +118,149 @@ struct branch_info {
 	char *checkout;
 };
 
+struct fetch_target_cb {
+	char *dst;
+	struct string_list matches;
+};
+
+static int match_fetch_target(struct remote *remote, void *priv)
+{
+	struct fetch_target_cb *cb = priv;
+	struct refspec_item q = { .dst = cb->dst };
+
+	if (!remote_find_tracking(remote, &q) && q.src)
+		string_list_append(&cb->matches, remote->name)->util = q.src;
+	return 0;
+}
+
+static void fetch_remote_for_start_point(const char *arg, int quiet)
+{
+	struct strbuf dst = STRBUF_INIT;
+	struct fetch_target_cb cb = { .matches = STRING_LIST_INIT_NODUP };
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct object_id oid;
+	struct remote *named_remote;
+	int bare_ns;
+	size_t i;
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
+	cb.dst = dst.buf;
+	for_each_remote(match_fetch_target, &cb);
+
+	if (cb.matches.nr > 1) {
+		struct strbuf msg = STRBUF_INIT;
+
+		strbuf_addf(&msg,
+			    _("cannot fetch start-point '%s': fetch refspecs "
+			      "of multiple remotes map to the same destination:"),
+			    arg);
+		for (i = 0; i < cb.matches.nr; i++)
+			strbuf_addf(&msg, "\n  %s", cb.matches.items[i].string);
+		strbuf_addstr(&msg,
+			      _("\nadjust 'remote.<name>.fetch' so only one "
+				"remote maps there, or omit '=fetch'"));
+		die("%s", msg.buf);
+	}
+
+	if (!cb.matches.nr) {
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
+	strvec_pushl(&cmd.args, cb.matches.items[0].string,
+		     (char *)cb.matches.items[0].util, NULL);
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
+	for (i = 0; i < cb.matches.nr; i++)
+		free(cb.matches.items[i].util);
+	string_list_clear(&cb.matches, 0);
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
@@ -1733,10 +1879,10 @@ static struct option *add_common_switch_branch_options(
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
@@ -1941,8 +2087,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
index 7613b1d2a4..c4a165cb1d 100755
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
+	test_grep "remote.<name>.fetch" err &&
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

base-commit: aec3f587505a472db67e9462d0702e7d463a449d
-- 
gitgitgadget

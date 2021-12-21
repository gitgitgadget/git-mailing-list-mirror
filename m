Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA08C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhLUSN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbhLUSN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:13:56 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40918C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:13:56 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p4-20020a17090a348400b001b103a13f69so2135653pjb.8
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D7zqMGPfUasHMdkLEzVf3tjSbPvqeL7yFYbCL06yG6E=;
        b=s2hyeqz8shfcv/lG1tUVm+6fncp6pe+IUrFwL02uZmAZT81MF7HtZYkt5GKOnIG5qS
         SY5EunbHwwkUPzCy2tQ/tFR6w4/97PheZieUijLAZmONtSLhm3Ge+wvxlBnJ0yMUQ6UK
         Sjw6zbkloaqE/cgjTb2Xpi+LaQuCil+1F1P2rsVyU1Y/JUYX1klBU9PAiWvZGYmf9JyC
         h1Gsxtz0fHdT41RvetcTYNyIPwV0VjWhoWSKQAtjqCXJQOTEvSphoqHVbCNb0JMr2kXA
         h4lvIZJEfbVdqPT+irzr9494CMjvAFrTDMySsZmmmkcZuz6Yb7/Yq5Srx5W7a7BJOTcw
         mcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D7zqMGPfUasHMdkLEzVf3tjSbPvqeL7yFYbCL06yG6E=;
        b=ZZI7l73HgCvp5YqNHtTaZ8xqIxr9981cMiQrzUSyyyFN6q2drw3nHn4zhek1kDh79j
         ckvmW/AZN3OTlALrkN1xyH2mpbsLCjTG4DlbYsR3fmXPsS12sJSzRJPGJ64hJWkxddMJ
         hj+Jqwx/nETM0XHvQw/6plH9UvYWWkUJrRcAF+g9UaC2lLVPAqBOKJifiCpNWCfMoarD
         mpPkcWqavUv1UgqSjcJbE66I5gpD5efK144P67rQ2gD+lLxOh6+PQZ56aK+Vunq6uAhL
         GQCYU+ixBraThUfZu603jNFv5cvshLGY94JIsA7kGmYjv3NA4hc926GNrK8qvgoXcmnd
         f9tA==
X-Gm-Message-State: AOAM530veCc2FmnRdKQ8LZHK+b2IOq6gK4y2hOy9gPiiXAk3Tr7j0b2E
        bUUHtY5jVZLvxlVyGzN0n5x7e/gQgE+iuA==
X-Google-Smtp-Source: ABdhPJy+9NMYgHb/kBIThCzpdNYvtdiMtZ+gyGqku0eREWfxNoRnQyu+R5qI6osEzD/bJOP5D/SjOr+tYpuMng==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8482:b0:148:a2e8:2c48 with SMTP
 id c2-20020a170902848200b00148a2e82c48mr4487670plo.151.1640110435737; Tue, 21
 Dec 2021 10:13:55 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:13:54 -0800
In-Reply-To: <cover.1640039978.git.steadmon@google.com>
Message-Id: <kl6l7dbxzuzh.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
Subject: Re: [PATCH v8 0/3] branch: inherit tracking configs
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Changes since V7:
> * Further simplify verbose output by adding an "<origin>/" prefix for
>   remote-tracking upstream refs.
> * Add a comment explaining the self-tracking check & early exit.
>
> Changes since V6:
> * Strip the refs/heads/ prefix in the verbose output when we have only a
>   single upstream branch.
> * Improve the fatal error message to note that rebasing is only
>   incompatible with multiple upstream refs.
> * Also note that `branch.<name>.remote` should be set in the manual
>   recovery advice.
> * Simplify the logic in setup_tracking() when no tracking sources match.
> * Make the difference in test cases in t2027 more obvious.
>
> Changes since V5:
> * Greatly simplified BRANCH_CONFIG_VERBOSE output to not require nearly
>   so many conditionals.
> * Note that rebasing is not compatible with inheriting multiple upstream
>   branches.
> * Moved the change to case-sensitivity for branch.autosetupmerge to its
>   own commit.
> * Improve advice on failed tracking setup when multiple branches are
>   involved.
> * Make better use of string_list API.
> * Make better use of config API.
> * More straight-forward use of the `struct tracking` API.
> * Numerous style fixes.
>
> Changes since V4:
> * Add new patch (1/2) to refactor branch.c:install_branch_config() to
>   accept multiple upstream refs
> * When multiple upstream branches are set in the parent branch, inherit
>   them all, instead of just the first
> * Break out error string arguments for easier translation
> * Don't ignore case for values of branch.autosetupmerge
> * Move reference to git-pull out of usage string for --track into
>   git-branch.txt
> * Use test_config instead of `git config` in t2027
> * Style fixes: add single-quotes around warning string arguments, remove
>   unnecessary braces
>
> Changes since V3:
> * Use branch_get() instead of git_config_get_string() to look up branch
>   configuration.
> * Remove unnecessary string formatting in new error message in
>   parse-options-cb.c.
>
> Josh Steadmon (3):
>   branch: accept multiple upstream branches for tracking
>   branch: add flags and config to inherit tracking
>   config: require lowercase for branch.*.autosetupmerge
>
>  Documentation/config/branch.txt |   3 +-
>  Documentation/git-branch.txt    |  24 ++--
>  Documentation/git-checkout.txt  |   2 +-
>  Documentation/git-switch.txt    |   2 +-
>  branch.c                        | 192 ++++++++++++++++++++++++--------
>  branch.h                        |   3 +-
>  builtin/branch.c                |   6 +-
>  builtin/checkout.c              |   6 +-
>  config.c                        |   5 +-
>  parse-options-cb.c              |  16 +++
>  parse-options.h                 |   2 +
>  t/t2017-checkout-orphan.sh      |  11 +-
>  t/t2027-checkout-track.sh       |  23 ++++
>  t/t2060-switch.sh               |  28 +++++
>  t/t3200-branch.sh               |  39 ++++++-
>  t/t7201-co.sh                   |  17 +++
>  16 files changed, 312 insertions(+), 67 deletions(-)
>
> Range-diff against v7:
> 1:  9152367ba9 ! 1:  a5265e1c7f branch: accept multiple upstream branches for tracking
>     @@ branch.c: static int should_setup_rebase(const char *origin)
>      +		die(_("cannot inherit upstream tracking configuration of "
>      +		      "multiple refs when rebasing is requested"));
>      +
>     ++	/*
>     ++	 * If the new branch is trying to track itself, something has gone
>     ++	 * wrong. Warn the user and don't proceed any further.
>     ++	 */
>      +	if (!origin)
>      +		for_each_string_list_item(item, remotes)
>      +			if (skip_prefix(item->string, "refs/heads/", &shortname)
>     @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
>       
>       	if (flag & BRANCH_CONFIG_VERBOSE) {
>      -		if (shortname) {
>     -+		const char *name;
>     -+		struct strbuf ref_string = STRBUF_INIT;
>     -+
>     -+		for_each_string_list_item(item, remotes) {
>     -+			name = item->string;
>     -+			skip_prefix(name, "refs/heads/", &name);
>     -+			strbuf_addf(&ref_string, "  %s\n", name);
>     -+		}
>     -+
>     -+		if (remotes->nr == 1) {
>     -+			struct strbuf refname = STRBUF_INIT;
>     -+
>     - 			if (origin)
>     +-			if (origin)
>      -				printf_ln(rebasing ?
>      -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
>      -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
>     @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
>      -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
>      -					  _("Branch '%s' set up to track local branch '%s'."),
>      -					  local, shortname);
>     -+				strbuf_addf(&refname, "%s/", origin);
>     -+			skip_prefix(remotes->items[0].string, "refs/heads/", &name);
>     -+			strbuf_addstr(&refname, name);
>     ++		struct strbuf tmp_ref_name = STRBUF_INIT;
>     ++		struct string_list friendly_ref_names = STRING_LIST_INIT_DUP;
>      +
>     ++		for_each_string_list_item(item, remotes) {
>     ++			shortname = item->string;
>     ++			skip_prefix(shortname, "refs/heads/", &shortname);
>     ++			if (origin) {
>     ++				strbuf_addf(&tmp_ref_name, "%s/%s",
>     ++					    origin, shortname);
>     ++				string_list_append_nodup(
>     ++					&friendly_ref_names,
>     ++					strbuf_detach(&tmp_ref_name, NULL));
>     ++			} else {
>     ++				string_list_append(
>     ++					&friendly_ref_names, shortname);
>     ++			}
>     ++		}
>     ++
>     ++		if (remotes->nr == 1) {
>      +			/*
>      +			 * Rebasing is only allowed in the case of a single
>      +			 * upstream branch.
>     @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
>      +			printf_ln(rebasing ?
>      +				_("branch '%s' set up to track '%s' by rebasing.") :
>      +				_("branch '%s' set up to track '%s'."),
>     -+				local, refname.buf);
>     -+
>     -+			strbuf_release(&refname);
>     -+		} else if (origin) {
>     -+			printf_ln(_("branch '%s' set up to track from '%s':"),
>     -+				local, origin);
>     -+			printf("%s", ref_string.buf);
>     ++				local, friendly_ref_names.items[0].string);
>       		} else {
>      -			if (origin)
>      -				printf_ln(rebasing ?
>     @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
>      -					  _("Branch '%s' set up to track local ref '%s'."),
>      -					  local, remote);
>      +			printf_ln(_("branch '%s' set up to track:"), local);
>     -+			printf("%s", ref_string.buf);
>     ++			for_each_string_list_item(item, &friendly_ref_names)
>     ++				printf_ln("  %s", item->string);
>       		}
>      +
>     -+		strbuf_release(&ref_string);
>     ++		string_list_clear(&friendly_ref_names, 0);
>       	}
>       
>       	return 0;
> 2:  afeb84539e = 2:  dcba40e2c4 branch: add flags and config to inherit tracking
> 3:  a818a6561b = 3:  ae7d27b4be config: require lowercase for branch.*.autosetupmerge
>
> base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
> -- 
> 2.34.1.307.g9b7440fafd-goog

These changes look good to me. I'll leave some suggestions on the
patches, but those are optional.

I still think it would be nice to get more thoughts on the help message
changes, but that's Junio's call to make :)

Reviewed-by: Glen Choo <chooglen@google.com>

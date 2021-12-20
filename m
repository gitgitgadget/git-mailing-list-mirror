Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC8FC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhLTVFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhLTVFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:05:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF7FC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 13:05:06 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w5-20020a17090a380500b001b112521410so564877pjb.8
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=25AAOIyt1/bp0MxCFWvz9ZSh7tZq7DOELvLi/K7I9lM=;
        b=eO8IxY3NjPH3eQkK3sdEjmSmo+faXVljpoCcRjhjUSi359Y3px6wt9wnH6nWGS9H6u
         runMtJAEHC98DTVSAoRburIUOywRF3b9rqj/W2sI4Vg+OsAHDLUs+4Z/oGVu3BzZcGd+
         KvCcC1o94uvFzY7LcmHfbmNC3qCeH3w5NGG7OIQWTENmBqA5XB1Ad07MDsAa2xcKvibA
         WE151utJQbHzsSmpa9iqojJ0kKmZmXisuEakxLrzdBTjIYkeklrTBd9L37nZzOSXGXeV
         VIEJkV3hQ8tmlhoIeHxXmayCBzjslE00NFjDwpYCsbTtn3Lc1KTPzBhtxt7F0zs2TWtW
         ZzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=25AAOIyt1/bp0MxCFWvz9ZSh7tZq7DOELvLi/K7I9lM=;
        b=KSPdbx7EdVvxgqYCcftgeZkfmjt27dL/JhWGghub8ftrpgo4dF92amfVSxr7dn7+FN
         5XnvrV+NmCS81KYqj8AEabZgk+gvJUD6JoOwpstziH8G0gpJ/WRpndvcIDjYhuEpuPRq
         zoowGt9LCtQA79/7eoUDaWR1F+oqZg3FtlRCT3xWB5U6o/LO6IvOwwZblxFDU05/CKJ6
         qSO1bIiiW5Rq8/NZNWCZci6kuehGApCEjFXaCYzd3xWfsFe8OuPkWC03yWM9VSt9eOis
         iMWOyVNy9S/SSHewoNOVekmpAe09GzmEf8Qafqp0bZVP5XStdIdSNqc+SbCqlbjjF2aX
         eRgg==
X-Gm-Message-State: AOAM5336iq9xKVU/0GMHA83wzFYKh/mydb5j6dVotJxzU12VTW+MKQ0n
        Ql91lK+dL+FLS4nBa4XqrvjVs4sTWhioOA==
X-Google-Smtp-Source: ABdhPJz+a2WYZXAV1IBoEsZ3PoiIm02ED4wQLYkzoxaSTO1sMebuorhzm/ClXz75AzfozRKMtKI1c+jPBTpiqQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:517:: with SMTP id
 r23mr22583pjz.152.1640034306058; Mon, 20 Dec 2021 13:05:06 -0800 (PST)
Date:   Mon, 20 Dec 2021 13:05:04 -0800
In-Reply-To: <cover.1639717481.git.steadmon@google.com>
Message-Id: <kl6llf0fyolb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639717481.git.steadmon@google.com>
Subject: Re: [PATCH v7 0/3] branch: inherit tracking configs
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

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
>  branch.c                        | 189 ++++++++++++++++++++++++--------
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
>  16 files changed, 310 insertions(+), 66 deletions(-)
>
> Range-diff against v6:
> 1:  43d6f83fed ! 1:  9152367ba9 branch: accept multiple upstream branches for tracking
>     @@ branch.c: static int should_setup_rebase(const char *origin)
>      +	if (!remotes->nr)
>      +		BUG("must provide at least one remote for branch config");
>      +	if (rebasing && remotes->nr > 1)
>     -+		die(_("cannot inherit upstream tracking configuration when rebasing is requested"));
>     ++		die(_("cannot inherit upstream tracking configuration of "
>     ++		      "multiple refs when rebasing is requested"));
>      +
>      +	if (!origin)
>      +		for_each_string_list_item(item, remotes)
>     @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
>      -					  _("Branch '%s' set up to track local branch '%s'."),
>      -					  local, shortname);
>      +				strbuf_addf(&refname, "%s/", origin);
>     -+			strbuf_addstr(&refname, remotes->items[0].string);
>     ++			skip_prefix(remotes->items[0].string, "refs/heads/", &name);
>     ++			strbuf_addstr(&refname, name);
>      +
>      +			/*
>      +			 * Rebasing is only allowed in the case of a single
>     @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
>      +			origin ? origin : "",
>      +			origin ? "/" : "",
>      +			remotes->items[0].string);
>     -+	else
>     ++	else {
>     ++		advise("  git config --add branch.\"%s\".remote %s",
>     ++			local, origin ? origin : ".");
>      +		for_each_string_list_item(item, remotes)
>      +			advise("  git config --add branch.\"%s\".merge %s",
>      +				local, item->string);
>     ++	}
>       
>       	return -1;
>       }
> 2:  57e57e6e6a ! 2:  afeb84539e branch: add flags and config to inherit tracking
>     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
>       
>      -	if (install_branch_config(config_flags, new_ref, tracking.remote,
>      -			      tracking.src ? tracking.src : orig_ref) < 0)
>     -+	if (tracking.srcs->nr < 1 && track != BRANCH_TRACK_INHERIT)
>     ++	if (tracking.srcs->nr < 1)
>      +		string_list_append(tracking.srcs, orig_ref);
>     -+	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
>     -+			      tracking.srcs) < 0)
>     ++	if (install_branch_config_multiple_remotes(config_flags, new_ref,
>     ++				tracking.remote, tracking.srcs) < 0)
>       		exit(-1);
>       
>      -	free(tracking.src);
>     @@ t/t2027-checkout-track.sh: test_expect_success 'checkout --track -b rejects an e
>      +test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
>      +	# Set up tracking config on main
>      +	test_config branch.main.remote origin &&
>     -+	test_config branch.main.merge refs/heads/main &&
>     ++	test_config branch.main.merge refs/heads/some-branch &&
>      +	test_config branch.autoSetupMerge inherit &&
>      +	# With --track=inherit, we copy the tracking config from main
>      +	git checkout --track=inherit -b b1 main &&
>      +	test_cmp_config origin branch.b1.remote &&
>     -+	test_cmp_config refs/heads/main branch.b1.merge &&
>     ++	test_cmp_config refs/heads/some-branch branch.b1.merge &&
>      +	# With branch.autoSetupMerge=inherit, we do the same
>      +	git checkout -b b2 main &&
>      +	test_cmp_config origin branch.b2.remote &&
>     -+	test_cmp_config refs/heads/main branch.b2.merge &&
>     ++	test_cmp_config refs/heads/some-branch branch.b2.merge &&
>      +	# But --track overrides this
>      +	git checkout --track -b b3 main &&
>      +	test_cmp_config . branch.b3.remote &&
> 3:  f79d27dc24 = 3:  a818a6561b config: require lowercase for branch.*.autosetupmerge
>
> base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
> -- 
> 2.34.1.173.g76aa8bc2d0-goog

Thanks! As noted in v6, I don't have strong opinions about omitting
'local/remote' from the help message, but I suspect others might. It
would be nice to get more opinions here.

v7 looks pretty good, it addresses all of the feedback on v6.
Unfortunately, I spotted some things _after_ you had already sent out v7
(my bad). That feedback is in [1].

We can ignore my feedback on 'simplifying' the conditional with a
format string. The more I think about it, the more impossible i18n
seems.

This just leaves the feedback on the message when inheriting from
multiple remote-tracking branches, i.e. prepending 'origin/' to the refs
in:

  branch 'main' set up to track from 'origin':
    main
    topic1
    topic2
 
[1] https://lore.kernel.org/git/kl6lzgovyvt7.fsf@chooglen-macbookpro.roam.corp.google.com

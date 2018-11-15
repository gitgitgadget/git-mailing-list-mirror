Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCB81F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 22:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeKPIcz (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 03:32:55 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:34650 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIcy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 03:32:54 -0500
Received: by mail-ed1-f43.google.com with SMTP id w19-v6so18079302eds.1
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 14:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgdpmOc3Xc+UfwFWfrrZVzfZ70SKF6KnwIar5cJweJQ=;
        b=MCWNN9Bye1v7mOJ0jdwh6VrLeaH3DswszMpMGv+C7PAJ5+5yylXXOpmNjTia0WFl5D
         vg3ZkMJL5MJThb9mzkDxZa+bxkqgu8inG9pHKQp/kJBNEMpkr38T0SkrgCZWr6ql0oBe
         f8A9uuUGBVepDCkCp8nh3O82cmuKcAav0g/CNtj3JjVOfZysY3HB0cWqca7L1DOnhSQo
         Po6e1Jzi0qeTrxjZdENP7hgX2SLsF5KTQQWD/j50zvXQ4VuUgg/NcdcUsyaHZyAyg5qw
         FZroS8xLFbplpsgHv9W+SRzCe/KaSYHEETTTGmw/btmrU7lJpQ1EuBOIlxx5zkdLFLsU
         SMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgdpmOc3Xc+UfwFWfrrZVzfZ70SKF6KnwIar5cJweJQ=;
        b=WmPar5u3LUh6oUmcnUYNManBqSIalpxniFpkX2SwNaj7UwPRP0GQx9IaeAhKIyw3QH
         PQj0JyR7B1od8vdHrF3M8os8d6l3zmUHvFNmigzx6sZLOgIdZBY/aQMlCe0J1iOltnLm
         YVDNbLMNtZL8HAxFi2oGyt3Hkd+7F2owKHwgbmXG65XDDEooEwDpdR7SWJlOnMQsU0hA
         X/5MQCgrKetbIhxsq3D5Qo1+s0pZKTWLNlLJrmIIp8B9CghY6V1ZcpA3kIHwRj7i27sR
         9JszPcGE0uXx1zPTgGF2yTxyDbOot8lA8qRjz1fjhrjPLR0LG9SOqUkMxS4cNyjAr39g
         zR2g==
X-Gm-Message-State: AGRZ1gL+A+ruP0AiYOHwkkeygsRMQIHcVG/jySQs1Gr+QpNv3LbnvHje
        +UyVAObXgzuXoV0GfXaqGa8C1gHdnXFwmupTCX/q6Q==
X-Google-Smtp-Source: AJdET5e5O9ybnr6lJJrfOos5VM+ljAjWh14Z3Lu3x0297MLTkMzvukMScoEQfhYOMufurcpV4/UtKx04LyUGXlutG7A=
X-Received: by 2002:a50:bac6:: with SMTP id x64mr7429506ede.191.1542320591401;
 Thu, 15 Nov 2018 14:23:11 -0800 (PST)
MIME-Version: 1.0
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
 <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
 <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
 <CAGw6cBth+j+vAjhrQutxBXAkuJrBfHKG4GdCu1jpvAAXOwudEA@mail.gmail.com>
 <CAGZ79kYiWnciitwTQCXR5bHOj7nhHWr40xBiS5sPCH5W4_yQ5w@mail.gmail.com> <CAGw6cBvLGZKcf1em0d47hcCuKau2QVbX4wfb0yN+m4umbNLaRg@mail.gmail.com>
In-Reply-To: <CAGw6cBvLGZKcf1em0d47hcCuKau2QVbX4wfb0yN+m4umbNLaRg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Nov 2018 14:23:00 -0800
Message-ID: <CAGZ79ka-8a5Uqe21SdHiSG-8eQdbey60R_G=A6th64ow=vqfNg@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Michael Forney <mforney@mforney.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 1:33 PM Michael Forney <mforney@mforney.org> wrote:
>
> On 2018-11-15, Stefan Beller <sbeller@google.com> wrote:
> > On Wed, Nov 14, 2018 at 10:05 PM Michael Forney <mforney@mforney.org>
> > wrote:
> >> Looking at ff6f1f564c, I don't really see anything that might be
> >> related to git-add, git-reset, or git-diff, so I'm guessing that this
> >> only worked before because the submodule config wasn't getting loaded
> >> during `git add` or `git reset`. Now that the config is loaded
> >> automatically, submodule.<name>.ignore started taking effect where it
> >> shouldn't.
> >>
> >> Unfortunately, this doesn't really get me much closer to finding a fix.
> >
> > Maybe selectively unloading or overwriting the config?
> >
> > Or we can change is_submodule_ignored() in diff.c
> > to be only applied selectively whether we are running the
> > right command? For this approach we'd have to figure out the
> > set of commands to which the ignore config should apply or
> > not (and come up with a more concise documentation then)
> >
> > This approach sounds appealing to me as it would cover
> > new commands as well and we'd only have a central point
> > where the decision for ignoring is made.
>
> Well, currently the submodule config can be disabled in diff_flags by
> setting override_submodule_config=1. However, I'm thinking it may be
> simpler to selectively *enable* the submodule config in diff_flags
> where it is needed instead of disabling it everywhere else (i.e.
> use_submodule_config instead of override_submodule_config).

This sounds like undoing the good(?) part of the series that introduced
this regression, as before that we selectively loaded the submodule
config, which lead to confusion when you forgot it. Selectively *enabling*
the submodule config sounds like that state before?

Or do we *only* talk about enabling the ignore flag, while loading the
rest of the submodule config automatic?

> I'm also starting to see why this is tricky. The only difference that
> diff.c:run_diff_files sees between `git add inner` and `git add --all`
> is whether the index entry matched the pathspec exactly or not.

Unrelated to the trickiness, I think we'd need to document the behavior
of the -a flag in git-add and git-commit better as adding the diff below
will depart from the "all" rule again, which I thought was a strong
motivator for Brandons series (IIRC).

> Here is a work-in-progress diff that seems to have the correct
> behavior in all cases I tried. Can you think of any cases that it
> breaks? I'm not quite sure of the consequences of having diff_change
> and diff_addremove always ignore the submodule config; git-diff and
> git-status still seem to work correctly.
>
> diff --git a/builtin/add.c b/builtin/add.c
> index f65c17229..9902f7742 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -117,7 +117,6 @@ int add_files_to_cache(const char *prefix,
>         rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>         rev.diffopt.format_callback = update_callback;
>         rev.diffopt.format_callback_data = &data;
> -       rev.diffopt.flags.override_submodule_config = 1;

This line partially reverts 5556808, taking 02f2f56bc377c28
into account.

> diff --git a/diff-lib.c b/diff-lib.c
> index 83fce5151..fbb048cca 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -68,12 +68,13 @@ static int check_removed(const struct cache_entry
> *ce, struct stat *st)
>  static int match_stat_with_submodule(struct diff_options *diffopt,
>                                      const struct cache_entry *ce,
>                                      struct stat *st, unsigned ce_option,
> -                                    unsigned *dirty_submodule)
> +                                    unsigned *dirty_submodule,
> +                                    int exact)
> [...];

This is an interesting take so far as it is all about *detecting* change
here via stat information and not like the previous (before the regression)
where it was about correcting output.

match_stat_with_submodule would grow its documentation to be
slightly more complicated as a result.

> diff --git a/diff.c b/diff.c
> index e38d1ecaf..73dc75286 100644
> --- a/diff.c
> +++ b/diff.c
> [...]
> -static int is_submodule_ignored(const char *path, struct diff_options *options)
> -{
> [...]
> -       if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
> +       if (S_ISGITLINK(mode) && options->flags.ignore_submodules)
>                 return;

This basically inlines the function is_submodule_ignored,
except for the part:

    if (!options->flags.override_submodule_config)
        set_diffopt_flags_from_submodule_config(options, path);

but that was taken care off in match_stat_with_submodule in diff-lib?

This WIP looks really promising, thanks for looking into this!
Stefan

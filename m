Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05D41F404
	for <e@80x24.org>; Mon, 16 Apr 2018 21:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeDPVWj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 17:22:39 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36232 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPVWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 17:22:37 -0400
Received: by mail-yw0-f180.google.com with SMTP id c9so4365395ywb.3
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lHQ0PnH4Icvh5ahjOQnruKm+Kfn09ZGPeycuqGPktPk=;
        b=JNDHk8GxG+kPRKDrZVykYYEPIRBYvBD7JaPdOIpq8VNm/pKSvThxpkllprMzOOmtPs
         8v/TWTLBNn1OJYJNC6nOyzgoInxq9fU/rb1wDt7+nBLu/WkFFbp1wgM6cSUndjdSxRXQ
         9lHuV3aWuEhaEElBWOLxtcXlcBWN80Vnx5QByZGRR3mgLRVpaOqQhOBeoOdV/lyTBh0G
         Seo+E49/sJ2KrdHTQA5tA6auL0c7tDjB9KZHDQHJadc95IV2GtXllrGHVP4iHklWGe5r
         hJTmXKRY/0ByHuK8Yinz1xelEYIOBDfdwykoL36Pm8ZUxHa/pCR+T6zDoe8VCMMHFtQI
         forQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lHQ0PnH4Icvh5ahjOQnruKm+Kfn09ZGPeycuqGPktPk=;
        b=oEeSjUT+xoFAz3fAXp+8N4hhPsnTLbvZFQGKkDmORKwYBQxvpBw8NlanHCNoWDCT1q
         zIAbv3zvzei68xx7GPYCTRIs4ebGhHwlGHOn0lAS2+iU8Cb2N80r4xReFHh441YgDqLg
         4fcXwbEKdbl2ny4LL8Fh+RUH13MjlEvta7h3z4vGIRjV9jrZKeEJ+yoLX1tv9WyCvP63
         Eo4oXX6bHXrS7ekoDdR9jF6bArGS1jQW7+eTRsUPb9RyNl+tv2ObtrwIsTgvfolET4MT
         cVD2eJ0zszxgj3GPLZy0Z+31EBhQ6VJ7qmv5TOw96XW1GJQIOdvaZPYJKiehuc5zI8rF
         VWwg==
X-Gm-Message-State: ALQs6tDyhvg2fg4nKDa6o44Rb06+45rNELDFZMEqJJSKDaXPlB21eg6s
        xJ4Ly2FyzHnOmAL8Ih3LXjSYP6oEl12aprOpp9KpkQ==
X-Google-Smtp-Source: AIpwx4+I02apYKZlaLmZAl0kKcWIbrkp16YD0EJllplN1v7omHzxRQnCJ+jJBBwCJEpy52Z6SvnRZmGiYqqae7UeuFU=
X-Received: by 10.129.232.5 with SMTP id a5mr12282374ywm.421.1523913756048;
 Mon, 16 Apr 2018 14:22:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 16 Apr 2018 14:22:35
 -0700 (PDT)
In-Reply-To: <20180416183742.032530a4d44faccd44189ea6@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it> <20180412222047.5716-2-ao2@ao2.it>
 <CAGZ79kZV+MLaVp4AM77bJkT=MeBvDSHTxZCni8dkqq4VLWZ0AA@mail.gmail.com> <20180416183742.032530a4d44faccd44189ea6@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Apr 2018 14:22:35 -0700
Message-ID: <CAGZ79kajTdkPKpcjH3NXBE75qWnNCCq_OefAjQsw17hK_VEyCw@mail.gmail.com>
Subject: Re: [RFC 01/10] submodule: add 'core.submodulesFile' to override the
 '.gitmodules' path
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 9:37 AM, Antonio Ospite <ao2@ao2.it> wrote:
> On Thu, 12 Apr 2018 16:50:03 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> Hi Antonio,
>>
>> On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
>> > When multiple repositories with detached work-trees take turns using the
>> > same directory as their work-tree, and more than one of them want to use
>> > submodules, there will be conflicts about the '.gitmodules' file.
>>
>> unlike other files which would not conflict?
>> There might be file names such as LICENSE, Readme.md etc,
>> which are common enough that they would produce conflicts as well?
>> I find this argument on its own rather weak. ("Just delete everything in
>> the working dir before using it with another repository"). I might be
>> missing a crucial bit here?
>>
>
> All the vcsh repositories _share_ the same work-tree; they may control
> it taking turns but, in general, all files are meant to be checked out
> at all times as the basic use case is: *distinct* sets of config files.
>
> Maybe saying that the repositories "take turns" is confusing.
> It's an unnecessary information, so I will omit that part form the
> commit message.

So they all have the same workdir, do they track the same set of files
or do they track a disjoint set of files, and ignoring the other repositories
files via the ignore mechanism?

This sounds like an interesting setup. I never though of that as something
useful (in either configuration).

> After your question I've done some research and I've seen other vcsh
> users managing conflicting LICENSE and README files using git
> sparse-checkouts, to have these files in the single repositories but
> not checked out in the shared work-tree:
> https://github.com/RichiH/vcsh/issues/120#issuecomment-42639619
> https://github.com/jwhitley/vcsh-root/commit/30b0d495c2cbe47ae9617ace9c2c14720d961d78
>
> However I guess that my point here is that the gitmodules file is
> something that influences git behavior so it should not be on the user's
> shoulder to manage conflicts for it, and most importantly it needs to
> be checked out for git to access it, doesn't it?

Good point! I wonder if the cleaner solution would be to just
tell git to use HEAD:.gitmodules and not check out the file?
then you would not need to come up with a namespace for names
of the .gitmodules files and scatter them into the worktree as well?


>> > -               value=$(git config -f .gitmodules submodule."$name"."$option")
>> > +               gitmodules_file=$(git config core.submodulesfile)
>> > +               : ${gitmodules_file:=.gitmodules}
>> > +               value=$(git config -f "$gitmodules_file" submodule."$name"."$option")
>>
>> I wonder if it would be cheaper to write a special config lookup now, e.g.
>> in builtin/submodule--helper.c we could have a "config-from-gitmodules"
>> subcommand that is looking up the modules file and then running the config
>> on that file.
>>
>
> Can you give an example from the user point of view of such a
> "config-from-gitmodules" command?
>

    git submodule config <name> <option>

as an 'alias' for

               gitmodules_file=$(git config core.submodulesfile)
               : ${gitmodules_file:=.gitmodules}
               value=$(git config -f "$gitmodules_file"
submodule."$name"."$option")

The helper would figure out which config file to load form
(.gitmodules in tree, HEAD:.gitmodules, your new proposed gitmodules file,
.git/config... or the special ref) and then return the <option> for <name>

So maybe:

    $ git clone https://gerrit.googlesource.com/gerrit && cd gerrit
    # ^ My goto-repo with submodules

    $ git submodule config "plugins/hooks" URL
    ../plugins/hooks



> I might look into it, but that can also be a followup change.


>> > diff --git a/submodule.c b/submodule.c
>> > index 9a50168b2..2afbdb644 100644
>> > --- a/submodule.c
>> > +++ b/submodule.c
>> > @@ -36,13 +36,13 @@ static struct oid_array ref_tips_after_fetch;
>> >   */
>> >  int is_gitmodules_unmerged(const struct index_state *istate)
>> >  {
>> > -       int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
>> > +       int pos = index_name_pos(istate, submodules_file, strlen(submodules_file));
>>
>> Ah, regarding the coverletter: This clearly assumes the modules
>> file is in the tree. So at least here we would make an exception
>> for files outside the tree to either not check for un-merged-ness or
>> disallow that case entirely.
>>
>
> Sorry I am not sure I follow what you are saying here, keep in mind
> that I am new to git internals.
>
> Do you mean that, even if we ensure (in
> config.c::git_default_core_config) that only paths relative to
> the work-tree are allowed, we still have to check here that the
> constraint is respected? And is so, why?

index_name_pos looks up a position of a file in the index,
which would fail for any file not in the index.

So if we give a path outside the tree, the lookup would fail
and we'd treat it as no .gitmodules file would be found,
which implies is_gitmodules_unmerged = false.

That sounds about right, but I think we could make the
distinction clearer, i.e. out-of-tree .gitmodule files *cannot*
be "unmerged" as that requires them to be part of a git
repository with a merge in progress.

>> There are quite a few functions in submodule.c which access the new global. :/
>> So moving them to the_repository should be fine, but eventually (not
>> in this series)
>> all these functions would would want to take a repository argument as well
>> such that they work on more than the_repository.
>>
>
> I will surely get rid of the global variable, but about changing the
> functions signatures I don't feel like promising anything just yet.

Yes, I would just use the_repository->... for now and as said by
"(not in this series)" we can do that later. It was more of a reminder
to myself, sorry for the confusion.

Thanks,
Stefan

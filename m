Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D5820A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 21:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGVza (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 16:55:30 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42167 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGVza (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 16:55:30 -0500
Received: by mail-ed1-f54.google.com with SMTP id j6so4849805edp.9
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 13:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/g/dFM0swcwURYJUna/0lqS3ztCgP0O2unBajbP6ksc=;
        b=D/458aexuo3m0m9KmIr2DyKZolo7Ecc+leb/1Y11VbY4Vyrdm0yMRrzg1mypvRWEhQ
         X8q9E6twkeMw0JOgjQxVcGATvAwP7fbcD7GfBsEiU1GQGXaOxQOkn5ZyZA6jYTP0J/L+
         91N6Sjh/ppMGj54y42u4K+7c+UXJR6dh72fkMJrWRh9CAc8JBAidhQ0k9YFE62bue4dp
         rqXG62QrqvVAsL7rivLvy3gaVNKHcbcPolIJ8kTrQYA98A6rQSk0XL+M99y8abh0JPXZ
         8Kid2HGwr891MZZC+Q2JrFjQ9mmGTl7+ZEX2pvOkjwEqC1eyt4QqwJRCRk7k9Li4U5b8
         FmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/g/dFM0swcwURYJUna/0lqS3ztCgP0O2unBajbP6ksc=;
        b=tSi6y7GwrcbTVJmzWgR8xow0ZehWcIQP9lCZnEexGOYF61T1d3E6W76PkOePKioFg4
         xZAf10lTpXbRWSVqN0DEWFfFh47pM++2ECU1H4T9lhsllbLyHK6+LTg7/KoV76nICZE9
         QgEpKK+6o4d8zBtNDOtFFQkGPuq3nDL1azop9QB7fKI/XN7tujTVuN46VnnnVE6ZQzuk
         BK+XhvbMZBnmVDidVHB+0pfWgmZMj0S3OdJBFeVqNdni31avksxtz6putz7j8UkYlZP7
         nrMeEU1nN1OukUvs6VUL9wV2mEtGU5I+I/ElzOE8Os7YyCXwGTo2oQDvHxjxHDqVGzce
         2VIQ==
X-Gm-Message-State: AA+aEWYTF1JIu7zJdYGCwsaI7z3d0OOzwdZT7otLFv4B7qyImAQaW5Ly
        YWt4tGf6UoBVA/ltwzVGYhd15nxKBGTQ5ZNVYoCY6Vih3B+4Ag==
X-Google-Smtp-Source: AFSGD/WMeV8WPkEQgeDpm5aliv7ay0lS00jjH4DGcJLRitrjGNdp01h9edj3kYu9ceGPZzBjY8+7oGliUj7J9+RMmvk=
X-Received: by 2002:a50:f70a:: with SMTP id g10mr3440956edn.25.1544219726793;
 Fri, 07 Dec 2018 13:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
 <20181206212459.GN4633@hopa.kiewit.dartmouth.edu> <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com>
 <20181207012256.GR4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181207012256.GR4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Dec 2018 13:55:15 -0800
Message-ID: <CAGZ79kbeAd1C-ySnJye-QU5FFf2jygksUsWtEmbvPZ_dQy_3uA@mail.gmail.com>
Subject: Re: [wishlist] git submodule update --reset-hard
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 5:23 PM Yaroslav Halchenko <yoh@onerussian.com> wrote:

> > There was a proposal to "re-attach HEAD" in the submodule, i.e.
> > if the branch branch points at the same commit, we don't need
> > a detached HEAD, but could go with the branch instead.
>
> if I got the idea right, if we are talking about any branch, it
> would also non-deterministic since who knows what left over branch(es)
> point to that commit.  Not sure if I would have used that ;)

I would think we'd rather want to have it deterministic, i.e. something like
1) record branch name of the submodule
2) update submodules HEAD to to superprojects gitlink
3) if recorded branch (1) matches the sha1 of detached HEAD,
  have HEAD point to the branch instead.

You notice a small inefficiency here as we write HEAD twice, so it
could be reworded as:
1) compare superprojects gitlink with the submodules branch
2a) if equal, set submodules HEAD to branch
2b) if unequal set HEAD to gitlink value, resulting in detached HEAD

Note that this idea of reattaching reflects the idea (a) below.


> > a) "stay on submodule branch (i.e. HEAD still points at $branch), and
> > reset --hard" such that the submodule has a clean index and at that $branch
> > or
> > b) "stay on submodule branch (i.e. HEAD still points at $branch), but $branch is
> >    set to the gitlink from the superproject, and then a reset --hard
> >    will have the worktree set to it as well.


> NB "gitlink" -- just now discovered the thing for me.  Thought it would be
> called a  subproject  echoing what git diff/log -p shows for submodule commits.

The terminology is messy:
The internal representation in Gits object model is a "gitlink" entry in a tree
object. Once we have a .gitmodules entry, we call it submodule.

The term 'subproject' is a historic artifact and will likely not be changed
in the diff output (or format-patch), because these diffs can be applied using
git-am for example. That makes the diff output effectively a transport
protocol, and changing protocols is hard if you have no versioning in them.

More in https://git-scm.com/docs/gitsubmodules (a rather recent new write
of a man page, going into concepts).

> > > right -- I meant the local changes and indeed reset --recurse-submodules
> > > indeed seems to recurse nicely.  Then the undesired effect remaining only
> > > the detached HEAD
>
> > For that we may want to revive discussions in
> > https://public-inbox.org/git/20170501180058.8063-5-sbeller@google.com/
>
> well, isn't that one requires a branch to be specified in .gitmodules?

Ah good point.

> >   git reset --hard --recursive=hard,keep-branch PREVIOUSPOINT
>
> 'keep-branch' (given aforementioned keeping the specified in .gitmodules
> branch) might be confusing.  Also what if a submodule already in a
> detached HEAD?  IMHO --recursive=hard, and just saying that it would do
> "reset --hard", is imho sufficient.  (that is why I like pure
> --reset hard   since it doesn't care and neither does anything to the
> branch)

For that we might want to first do the

  git submodule update --reset-hard

which runs reset --hard inside the submodule, no matter which
branch the submodule is on (if any) and resets to the given
superproject sha1.

See git-submodule.sh in git.git[1] in cmd_update.
We'd need to add a command line flag (`--reset-hard`
would be the obvious choice?) which would set the `update`
variable, which then is evaluated to what needs to be done in
the submodule, which in that case would be the hard reset.

https://github.com/git/git/blob/master/git-submodule.sh#L606

Once that is done we'd want to add a test case, presumably
in t/t7406-submodule-update.sh

> > > I would have asked for
>
> > >    git revert --recursive <commit>...
> > >    git rebase --recursive [-i] ...
>
> > > which I also frequently desire (could elaborate on the use cases etc).
>
> > These would be nice to have. It would be nice if you'd elaborate on the
> > use cases for future reference in the mailing list archive. :-)
>
> ok, will try to do so ;-) In summary: they are just a logical extension
> of git support for submodules for anyone actively working with
> submodules to keep entire tree in sync.  Then quite often the need for
> reverting a specific commit (which also has changes reflected in
> submodules) arises.  The same with rebase, especially to trim away some
> no longer desired changes reflected in submodules.
>
> the initial "git submodule update --reset-hard" is pretty much a
> crude workaround for some of those cases, so I would just go earlier in
> the history, and redo some things, whenever I could just drop or revert
> some selected set of commits.

That makes sense.
Do you want to give the implementation a try for the --reset-hard switch?

> ah... so it is only   submodule  command which has --recursive, and the
> rest have --recurse-submodules   when talking about recursing into
> submodules?

I don't think we were that cautious in development as it was done by
different people at different times. There is also just `--submodule` for
the diff family, for reference:
https://public-inbox.org/git/20180905225828.17782-1-sbeller@google.com/

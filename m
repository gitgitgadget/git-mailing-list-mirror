Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174491F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 00:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeKPKmI (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 05:42:08 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33078 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeKPKmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 05:42:08 -0500
Received: by mail-oi1-f176.google.com with SMTP id c206so12813100oib.0
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 16:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3xChnQD4ePCh7l+LnrK3Ts7VkYZDbNI2+haTRJ5/03o=;
        b=IQb8DBMfNKC0RDuM5zsUoHqHtkx4y3rVwJGynWZMbtXCpNdjkb6wsBlxgJc+n1vfqy
         OffTEg26ImMxLYHjsOB4FFx+F87ROvi6kxjpQAIE/RfdO5ar3toPrYhuxSpWHW5qf3RN
         hH/DzpzrSZv5zVxv6/MaUnikFjVMOa0VYRplTNW7QiCFaGWixVUEkO9vseNJPO30YaAi
         q3lwhN0u7U7RDJ96ONtQX/LYn7kqWVXVV0HzCaZvigI9gs6Q4RcKZElx7fLvGyVr4kYO
         t16Sh6Mh45RkuNCN5j1YUtRzAzHZGPvNHvcJeog51y8Wmvb6BYIXBxHUiVMxucgMJ2Lp
         D/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3xChnQD4ePCh7l+LnrK3Ts7VkYZDbNI2+haTRJ5/03o=;
        b=GZzweYeXtrdELh25mYDdOM6D62XvGMR4tVt6ze9SenJDlpkJE8w2JYMn8jsCSBNTH2
         1AN1g8qgjEGtr+Plw2rPsQpoKCFiyhCUS/B2GTfN5GNN8sRBubUcFolPiU4v64Bv6LK9
         iUwWtsFPR7E1jrCHXALa5+IgzvvyvC3r9H7Ff31zrijEzAiSxRV3mjM1mEEwygeMntvu
         wm2A/UfZ3iygIW02NQ9EJZ4f8/YacqA1qrnV5j2yLY6lKsCbt3G+O6nFAqyUCENFE5RP
         tuDIPXtx0PnXGwxHveyLqzyhpur3v0T+CON71Nmgc+uDeeqEqlBU8dKu01eo+cVfWDhe
         Jt3A==
X-Gm-Message-State: AGRZ1gJ3GfoFA0rgQIZDkw1EDJIBIoCys3iqcTlJ0H4SbolTfxQT4rCZ
        jpUGkGvyhlHFijm5wGxO+XulUBElDRy1DJJlyMH30pim7SMO9Q==
X-Google-Smtp-Source: AJdET5fRQZM89V3rJScMPyLBozZD3lKOoCJoUyFD0ofzWbZF0OXY2vSt9FMF8ea/us3iWKMN0/GsjP52FJt5WQYSD0A=
X-Received: by 2002:aca:ddc3:: with SMTP id u186-v6mr23604oig.204.1542328317633;
 Thu, 15 Nov 2018 16:31:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:d182:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 16:31:56
 -0800 (PST)
X-Originating-IP: [2601:647:5180:35d7::13ed]
In-Reply-To: <CAGZ79ka-8a5Uqe21SdHiSG-8eQdbey60R_G=A6th64ow=vqfNg@mail.gmail.com>
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
 <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
 <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
 <CAGw6cBth+j+vAjhrQutxBXAkuJrBfHKG4GdCu1jpvAAXOwudEA@mail.gmail.com>
 <CAGZ79kYiWnciitwTQCXR5bHOj7nhHWr40xBiS5sPCH5W4_yQ5w@mail.gmail.com>
 <CAGw6cBvLGZKcf1em0d47hcCuKau2QVbX4wfb0yN+m4umbNLaRg@mail.gmail.com> <CAGZ79ka-8a5Uqe21SdHiSG-8eQdbey60R_G=A6th64ow=vqfNg@mail.gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Thu, 15 Nov 2018 16:31:56 -0800
Message-ID: <CAGw6cBvsiW7nwkJ_DBhXOYkgh7ba+rm+pwd4tOAt1ohRvcCY=A@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-11-15, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Nov 15, 2018 at 1:33 PM Michael Forney <mforney@mforney.org> wrote:
>> Well, currently the submodule config can be disabled in diff_flags by
>> setting override_submodule_config=1. However, I'm thinking it may be
>> simpler to selectively *enable* the submodule config in diff_flags
>> where it is needed instead of disabling it everywhere else (i.e.
>> use_submodule_config instead of override_submodule_config).
>
> This sounds like undoing the good(?) part of the series that introduced
> this regression, as before that we selectively loaded the submodule
> config, which lead to confusion when you forgot it. Selectively *enabling*
> the submodule config sounds like that state before?
>
> Or do we *only* talk about enabling the ignore flag, while loading the
> rest of the submodule config automatic?

Yes, that is what I meant. I believe the automatic loading of
submodule config is the right thing to do, it just uncovered cases
where the current handling of override_submodule_config is not quite
sufficient.

My suggestion of replacing override_submodule_config with
use_submodule_config is because it seems like there are fewer places
where we want to apply the ignore config than not. I think it should
only apply in diffs against the working tree and when staging changes
to the index (unless specified explicitly). The documentation just
mentions the "diff family", but all but one of the possible values for
submodule.<name>.ignore ("all") don't make sense unless comparing with
the working tree. This is also how show/log -p behaved in git <2.15.
So I think that clarifying that it is about modifications *to the
working tree* would be a good idea.

>> I'm also starting to see why this is tricky. The only difference that
>> diff.c:run_diff_files sees between `git add inner` and `git add --all`
>> is whether the index entry matched the pathspec exactly or not.
>
> Unrelated to the trickiness, I think we'd need to document the behavior
> of the -a flag in git-add and git-commit better as adding the diff below
> will depart from the "all" rule again, which I thought was a strong
> motivator for Brandons series (IIRC).

Can you explain what you mean by the "all" rule?

>> Here is a work-in-progress diff that seems to have the correct
>> behavior in all cases I tried. Can you think of any cases that it
>> breaks? I'm not quite sure of the consequences of having diff_change
>> and diff_addremove always ignore the submodule config; git-diff and
>> git-status still seem to work correctly.
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index f65c17229..9902f7742 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -117,7 +117,6 @@ int add_files_to_cache(const char *prefix,
>>         rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>>         rev.diffopt.format_callback = update_callback;
>>         rev.diffopt.format_callback_data = &data;
>> -       rev.diffopt.flags.override_submodule_config = 1;
>
> This line partially reverts 5556808, taking 02f2f56bc377c28
> into account.

Correct. The problem with 55568086 is that add_files_to_cache is used
by both git-add and git-commit, regardless of whether --all was
specified. So, while it made it possible to stage ignored submodules,
it also made it so the submodule ignore config was overridden in all
uses of git-add and git-commit.

So, this diff attempts to make it so the ignore config is only applied
when the pathspec matches exactly rather than just always overriding
the ignore config.

>> diff --git a/diff-lib.c b/diff-lib.c
>> index 83fce5151..fbb048cca 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -68,12 +68,13 @@ static int check_removed(const struct cache_entry
>> *ce, struct stat *st)
>>  static int match_stat_with_submodule(struct diff_options *diffopt,
>>                                      const struct cache_entry *ce,
>>                                      struct stat *st, unsigned ce_option,
>> -                                    unsigned *dirty_submodule)
>> +                                    unsigned *dirty_submodule,
>> +                                    int exact)
>> [...];
>
> This is an interesting take so far as it is all about *detecting* change
> here via stat information and not like the previous (before the regression)
> where it was about correcting output.
>
> match_stat_with_submodule would grow its documentation to be
> slightly more complicated as a result.

Yes, this is one part I'm not quite happy with. I wonder if instead
match_stat_with_submodule could be made simpler by moving the
ie_match_stat call up to the two call sites, and then it could be
selectively called by run_diff_files depending on the value of
matched.

>> diff --git a/diff.c b/diff.c
>> index e38d1ecaf..73dc75286 100644
>> --- a/diff.c
>> +++ b/diff.c
>> [...]
>> -static int is_submodule_ignored(const char *path, struct diff_options
>> *options)
>> -{
>> [...]
>> -       if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath,
>> options))
>> +       if (S_ISGITLINK(mode) && options->flags.ignore_submodules)
>>                 return;
>
> This basically inlines the function is_submodule_ignored,
> except for the part:
>
>     if (!options->flags.override_submodule_config)
>         set_diffopt_flags_from_submodule_config(options, path);
>
> but that was taken care off in match_stat_with_submodule in diff-lib?

Yeah, since run_diff_files already skips ignored submodules (except if
given by name), and we still want the changes to be applied to the
index. Like I said, I'm not really sure if there are any other uses of
diff_change and diff_addremove where we actually do want the .ignore
config applied.

But, maybe if I instead left
`rev.diffopt.flags.override_submodule_config = 1` in builtin/add.c and
changed the condition in match_stat_with_submodule from `&& !exact` to
`|| !exact`, these functions would not need to be changed. In other
words, we relax the behavior when override_submodule_config is
specified, rather than making it stricter when it is not specified.

Testing this out, it looks like it fixes the behavior with add/commit
--all, but still omits ignored submodules in diffs between commits
(which is not the behavior I expect, see above). So, without the
changes to diff_change/diff_addremove we probably would need to add
override_submodule_config=1 to even more places.

Too many negatives are making this difficult to reason about.

> This WIP looks really promising, thanks for looking into this!

Thanks for taking the time to help me!

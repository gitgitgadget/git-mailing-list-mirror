Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CAFB1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 18:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIFXEb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:04:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44759 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIFXEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:04:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so9634247edb.11
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3e0eo5Dj2fvGNJ5j6buBE5CQtG2PXQWseBgkbGcjXo=;
        b=Sa7sO5fEL4Bz6ChIBlNxgDJnNLqOwtBFue/KZ46gG5WI2F1Zu3+jEi9zY10hnCjM1T
         xGmzr6jX6Zf8gsUIX4AJxLAtvqwZGqDcpAGSQdWIvibzqrbFnlc9tnlqIlnw2Ua+kTDS
         Nh4R3g4ZEGqI2Qw0Z0DMptFX+PCTtSnTHk1KmH2YoBIe9M6jJ87VPtOh/hz9JkDVhx2K
         BtVDffQGnmFDbAahe65kwkdRKyM7U9Az+0X8ODL7IrtSoasgh4g7ijbL9SxbDtHLSANm
         mKvRQjy6qHrKQCitZzv7MG6rfSU2iw61zXgDNRSIX04qVLLIVlopx96QnpM3la1QpBNC
         45fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3e0eo5Dj2fvGNJ5j6buBE5CQtG2PXQWseBgkbGcjXo=;
        b=pvx10S2vZDYraNT1TZQ2iDj5AFH7XFwGMH7TS5zjDevpCfRwa/TBg1jflRLIPD0qkA
         XYrCu4q7OeyvqNBt7Wr4aDCvn23UErHDFSWgG9r4mHq0QmUfzXHssKX49DyRnYVMeeHl
         32s1MtZqKhIbMeQ2kiQgzd9FmaX1XE93gsytmycajYhrac90qTvTSUgqHd7gWsLq5iQ1
         sInLIhJsNlZd7lmZgHlC+MYnJ2PiRGJp7NLor4Tvl9RKAB1a0JkzF03c9DrZhktg4ENk
         3bPsIJgnuhUzOa17bsy9o8TbroJfLedw43MnmhLzS3w0OULkTDpY8/S7AWSdUB2EFJx3
         ikoQ==
X-Gm-Message-State: APzg51CeDWgT6SVN0OK0HXM/b74sFsdl7MTAaLYX7zfSfASPVXH9I6ni
        UnOmULM5sl2JqvVxTEIBUlPNgsMDuWTv1nhY1Na/ag==
X-Google-Smtp-Source: ANB0VdaHsr6XGAIlNCSpD0hCpUVVdrdI2MCYqYcvb7SRfhD2kFsYp2TzdYJrkrofaKIeceF7lXiVaDO5Gjr+RwX6yyU=
X-Received: by 2002:a50:b410:: with SMTP id b16-v6mr5165886edh.190.1536258468421;
 Thu, 06 Sep 2018 11:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180905225828.17782-1-sbeller@google.com> <20180905231258.GD120842@aiede.svl.corp.google.com>
In-Reply-To: <20180905231258.GD120842@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 11:27:37 -0700
Message-ID: <CAGZ79kbBC9OxiMhOCjB61pQXaMa-_tXJdkPq_6JnzC+gDzRuAw@mail.gmail.com>
Subject: Re: [PATCH] diff: allow --recurse-submodules as an synonym for --submodule
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 4:13 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Stefan Beller wrote:
>
> > Many commands have flags to recurse into submodules, which is named
> > --recurse-submodules. The diff family also has a submodule recursion flag,
> > but that is named differently. Add a synonym --recurse-submodules, which
> > means the same as the --submodule flag, such that across all git commands
> > supporting submodules we have the --recurse-submodules flag available.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  Documentation/diff-options.txt | 1 +
> >  diff.c                         | 2 ++
> >  2 files changed, 3 insertions(+)
>
> Makes sense.
>
> [...]
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -227,6 +227,7 @@ linkgit:git-config[1]).
> >       of the `--diff-filter` option on what the status letters mean.
> >
> >  --submodule[=<format>]::
> > +--recurse-submodules[=<format>]::
> >       Specify how differences in submodules are shown.  When specifying
> >       `--submodule=short` the 'short' format is used.  This format just
> >       shows the names of the commits at the beginning and end of the range.
> > diff --git a/diff.c b/diff.c
> > index 145cfbae592..d3d5a989bd1 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -5023,6 +5023,8 @@ int diff_opt_parse(struct diff_options *options,
> >               handle_ignore_submodules_arg(options, arg);
> >       } else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
> >               return parse_submodule_opt(options, arg);
> > +     else if (skip_to_optional_arg_default(arg, "--recurse-submodules", &arg, "log"))
> > +             return parse_submodule_opt(options, arg);
>
> It seems like various commands are gaining --recurse-submodules options
> taking different kinds of arguments:
>
> - clone takes --recurse-submodules=<pathspec>
> - fetch takes --recurse-submodules=<mode>
> - after this patch, diff takes --recurse-submodules=<mode>
>
> Is there a unifying principle?  Can Documentation/gitsubmodules.txt
> say a word or two about what kind of argument values the user should
> expect to be accepted by these options?

I don't think there is a unifying principle deep down.
Everything but clone is specifying a mode (you could imagine
that we extend "git reset --recurse-submodules" as well to take
some sort of mode, either the hard/soft differentiation or how to treat
dirty submodules or a mode that could differentiate between superprojects
sha1 and branch of the same name)

Care to send a patch on top to talk about these issues in
Documentation/gitsubmodules.txt ?

Thanks,
Stefan

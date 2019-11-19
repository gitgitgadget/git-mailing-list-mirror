Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A532D1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 04:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfKSENN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 23:13:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfKSENN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 23:13:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so22124577wrr.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 20:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKWFIIu5f/1leU+ASnLuWEkTREPaarJMhNpwPgYEmQM=;
        b=XbYmxTvR7wlxZZVm3JR3PCMXH5nZOghV1ZNmxGEA6jtjjwkkft74EM+AGPNO6L+KQY
         v9zjc5Fqf2klMWE1IUiW/7mHu1heLj27UrxAC9B0Il+/y1XABl5m4rtCmT7alhDvSSb4
         RDRoVVfSbUXh+HPY2kbRobflyZoEF4aikIN7lxL/iSK/tH59lfmk8vhnwZdop37xCUfy
         y0KXu8Txhreue1ozWuxQzsi5q/G2M1ycOfinqwcSR6DAoIAI4hlEtCbArJ4Yt5tvGBzX
         w362SAABxmmLwAHLk6WDVy/bXkWDKK/+L4Zy3LDTJXjyY/9kGs7LpVHaZ4LXXn1y1Mf0
         1CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKWFIIu5f/1leU+ASnLuWEkTREPaarJMhNpwPgYEmQM=;
        b=tbhJpQbdqiYffKGZ+d95JQFH61QjY0LIqcp992SMDZzpsDSxBJuUXNs78mUnmu0Bj3
         BvL1OwjO+wjkFEu88w6GQ4Qqs5GrXj9NmpFeOz48BrJ3ODvulQ15iplDV5WLNj0IRDBF
         8fIoQ+w12V6DyV1PB6jl7q2QnlQLWBTLEr9X8bkbLEFDENtTsYEyeksHwKEegp6d+zDj
         +MWBCUrj0fPX4tIP9Fp8UJ7vPnMd0ClqIWhadjx4D2udwh8jUD6yhdzB1UEd4HJsM+Yz
         Yh2fg8o8c+O7qxYsT3kMzztdRosEemXrgPWKRLC9MvGjDuyQ9As2D9B+Fr4CM8ri1RWX
         iGsQ==
X-Gm-Message-State: APjAAAUA7TvQx58UIPqTarHmU8W1T45WTtRlvGBB9wttl7tPjaQhXKkj
        HvKr9+BYkDA/mt5MvYP0aBZDtahRADYNEoNMdWXEsg==
X-Google-Smtp-Source: APXvYqxThfbq3tvovl/ee2YhmwHTZYwMRTeXLapVsz+UQZZl7uCQGjsTQhj5QcriiXYTbU+f1IFDiuU9ICgag9ulpyg=
X-Received: by 2002:a5d:6607:: with SMTP id n7mr31535259wru.133.1574136791153;
 Mon, 18 Nov 2019 20:13:11 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEBmrMavFJeyPSQr2wA9kFZwz_Kfr6PFBLRfLJ-EuCVXJnA@mail.gmail.com>
 <xmqqk17wziex.fsf@gitster-ct.c.googlers.com> <20191119033311.GA18613@sigill.intra.peff.net>
In-Reply-To: <20191119033311.GA18613@sigill.intra.peff.net>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 18 Nov 2019 20:13:02 -0800
Message-ID: <CA+dzEBmekzDVdqy=4GDF+Wm8e-YTPEdbh0oVowZNQYO67vEhEg@mail.gmail.com>
Subject: Re: git rev-parse --show-toplevel inside `.git` returns 0 and prints nothing
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 7:33 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 19, 2019 at 11:52:54AM +0900, Junio C Hamano wrote:
>
> > If I were designing the feature today, with today's rest-of-git in
> > mind, I would say
> >
> >  - In a bare repository, exit with non-zero status after giving an
> >    error message "no working tree".
> >
> >  - In a repository that has a single associated working tree, show
> >    the path to the top-level of that working tree and exit with zero
> >    status.
>
> Do you mean to do this even in when the cwd is inside .git?
>
> I think that's confusing, because you don't actually have a working tree
> at all. E.g.:
>
>   $ git rev-parse --show-toplevel
>   /home/peff/tmp
>   $ git status -b --short
>   ## No commits yet on master
>
>   $ cd .git
>   $ git rev-parse --show-toplevel
>   $ git status -b --short
>   fatal: this operation must be run in a work tree
>
> So internal commands like status accept that we have no working tree in
> this situation. But "--show-toplevel" just prints nothing. I'd amend
> your second point to be "If we are in the working tree of a repository,
> show the path to the top-level of that working tree and exit with zero
> status".
>
> And then that leaves another case: we are not in the working tree of the
> repository. In which case I think it should be the same as the bare
> repository.
>
> And from that, your multi-working-tree case falls out naturally:
>
> > In a repository that has more than one working trees (which is one
> > of the things "todasy's rest-of-git" has that did not exist back
> > when --show-prefix/--show-toplevel etc. were invented), then what?
> > Would it make sense to show the primary working tree?  What if the
> > worktree(s) were made off of a bare repository, in which case nobody
> > is the primary?
>
> There may be multiple working trees, but we can only be in one of them
> at a time. So that's the one that we show.
>
> And the only real change here is that "--show-toplevel" prints an error
> and exits non-zero when we won't have a working tree. Something like:
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 3857fd1b8a..81161f2dfb 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -805,6 +805,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                                 const char *work_tree = get_git_work_tree();
>                                 if (work_tree)
>                                         puts(work_tree);
> +                               else
> +                                       die("this operation must be run in a work tree");
>                                 continue;
>                         }
>                         if (!strcmp(arg, "--show-superproject-working-tree")) {
>
>
> I think the reason this hasn't come up until now is callers are expected
> to use require_work_tree() or "rev-parse --is-inside-work-tree" first.
>
> It would probably make sense for the rev-parse documentation to also
> clarify what "the top-level directory" is.
>
> -Peff

I realize I forgot to include the X to my Y :) -- this was a totally
silly case that I got as a bug report:
https://github.com/pre-commit/pre-commit/issues/1219

I *expected* an error case but didn't get one

Anthony

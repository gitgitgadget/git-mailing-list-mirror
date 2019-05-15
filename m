Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D681F461
	for <e@80x24.org>; Wed, 15 May 2019 12:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEOMi5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 08:38:57 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45282 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEOMi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 08:38:56 -0400
Received: by mail-ot1-f52.google.com with SMTP id t24so2041505otl.12
        for <git@vger.kernel.org>; Wed, 15 May 2019 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1tkwHlBi5dAm76lQJw1QLOlL1AXOGpGAg/+UB4GTE8=;
        b=QNHE9YLpijMaMyStuL2w4SW2SwHmSCNVIA8wAHkP+lpffqOwlVnP+Evz2NX37QROgM
         jRzpSHLPwD8KDMGQJACwxJ/qUaMnZ6X64h54ZA+vKef8hNpHmWuUIJ2aYhJA1nGuwhTi
         huOgvJh5f6eMEAz8W6BjbTdjDSQHZJ5m/8v05BuPdmnPK0uVyRS2/XK0B38SdEJxhgam
         pPK5dtlN/BGY1m4IJMbwQ+pvSu9t+scoi2va2nKszFvtyFK8ww3xQWG2ijOvTBcUNvI6
         lTb/li/GCmwwnRVxE+eTF222smAP3E4gtpO2xwn+n36x1At9G6tS4sO6tuKmmWD1V8Sk
         ca8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1tkwHlBi5dAm76lQJw1QLOlL1AXOGpGAg/+UB4GTE8=;
        b=ncalisAXP8OJ66XuHSus+kexh4UyGbpkOx0fCYPSL+ZoHTnpwppy99rM87mwfu+3GU
         HEqGHLTMz1ckUGv+XHz1kBsDAdDlKaxHeWkJS1MFOh3wl2hqiPDJCaBK8kZBgUZNdyle
         OXHdwc1y7taURPlcPI7GSLXT+upQwxgI9wT0m2j04yHAuO0oSdNU6ozNPNnIOtKL0iRq
         xSu7Xmpxxvkg06CAtp9jtHyMk3633K+gsNOOstpKQnf8khDgMt6t15JnX8NCrc7xF3SV
         +e+aJeQ1dfUlaRY1IJ1CreD6cDOQoKp7QzicCMggawbEGzcBq6giLW4EhFt/RY3TVUuC
         v1fg==
X-Gm-Message-State: APjAAAXmRQHjKMIHUXT2cG1hnckhj0wREaL9uhAKc4DqOnfVXoqyHQMF
        jjH3JxWkdnk5Ww8fwdkBUuURZynBastCnGJ0uOOnCA==
X-Google-Smtp-Source: APXvYqzO/2mxTHQmqtnxphQJ9qsBJiwoG5E6zxAYm9AK399v1X81fZvve1oJG70ELrX8+SJfezum/aLolU7w/5FJZEs=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr24570586otf.243.1557923935997;
 Wed, 15 May 2019 05:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CAGyf7-GtnCqfqPWVpBAELB4xAE6syn7+DfKXgfhL0UoMfvbn4A@mail.gmail.com>
In-Reply-To: <CAGyf7-GtnCqfqPWVpBAELB4xAE6syn7+DfKXgfhL0UoMfvbn4A@mail.gmail.com>
From:   Cosmin Polifronie <oppturbv@gmail.com>
Date:   Wed, 15 May 2019 15:38:44 +0300
Message-ID: <CAJFQqNJsnkdwqk0+kCp6j5aL9BaXd=-JaXC9K5kSBSed+=V3xg@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Bryan,

My project contains a Gradle build that is dependent on a
configuration found in a file called build.gradle. What I need to do
is run Gradle with a proper build.gradle file, meaning: if a new
build.gradle is staged, I will use that for my Gradle build, if not I
will use the latest approved commit's one (as in a commit that has
already passed the pre-commit check). The problem is that build.gradle
can be modified and not be staged, and Gradle cannot know that, it
will use whatever is available on disk. I want to avoid that.

This is why I needed a copy of my current repo with the file versions
already approved (already staged at a previous date). This is why I am
using 'git worktree add'.

Now, I have found another solution using stashes, and those might
work, but I am still curious about this situation.

On Wed, May 15, 2019 at 3:46 AM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Tue, May 14, 2019 at 7:53 AM Cosmin Polifronie <oppturbv@gmail.com> wrote:
> >
> > Hello! I am trying to run 'git worktree add <path> HEAD' in the
> > 'pre-commit' hook, more specifically in a Python script that is being
> > called from the hook. When doing so, I am greeted with the following
> > error:
> >
> > On Windows 10:
> > Preparing worktree (detached HEAD cbfef18)
> > fatal: Unable to create 'C:/Users/meh/Desktop/abc/.git/index.lock': No
> > such file or directory
> >
> > On Arch Linux:
> > Preparing worktree (detached HEAD cbfef18)
> > fatal: Unable to create '/home/cosmin/Downloads/abc/.git/index.lock':
> > Not a directory
> >
> > Is it forbidden to call this command from a hook? If yes, what kind of
> > alternatives do I have? I need to make a copy of the repo in its HEAD
> > state, process it and then decide if I will pass the current commit or
> > not.
>
> I can't speak to whether `git worktree add` should succeed or fail
> inside a `pre-commit` hook, but...
>
> Why do you need a new work tree, versus whatever working copy you're
> running `git commit` in? Is there a reason whatever validation needs
> to be done can't be done in the existing working copy? `HEAD` is the
> _previous, existing commit_, not the new, currently-being-created
> commit, so your validation in the new work tree, if you actually
> managed to create one, would be applied to the _latest existing
> commit_, not the new changes you're trying to commit. Even trying to
> copy the changes over wouldn't necessarily result in the same state,
> because there may be unstaged changes.
>
> What type of validation are you trying to do? I think the failure
> you're running into is an alarm bell indicating what you're trying to
> do may not make sense. However, without any insight into what "process
> it and then decide if I will pass the current commit or not" actually
> looks like, it's hard to offer you much help.
>
> Bryan
>
> >
> > Thanks! :)

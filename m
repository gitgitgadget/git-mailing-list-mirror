Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD8D1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfGATs2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 15:48:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36904 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGATs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 15:48:28 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so31587421iok.4
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytGZRZhBsD9RAqys8GtNzSMdWvh1Iy+HMn14LzsKN94=;
        b=avqMY/7uhDdUoXpmJTWOo16kmd4UL/K9GPbfAKmq1HhIkeXKgMOaeQAsoRjkg1QTwF
         fxDRl8uv7LzlZRLJUcfD28IxpbNHDtvpySKzG2gkEGytdiL1bKfeAlzYmi5XOBM0FHzm
         ZKoeUH9x22L/2QJD5WTYL4vJR0/xFD17hliXM8ctJzNSfGakr2vLa1TxD6+00UxNBJGt
         CWHa0X6y8yLv9mO4Y96nVm/5j0RWymtupEdLusaGQVH6P0fWBT0gnvkO8HpxUUF5Lt39
         h4OR6MLn7vAKnHfUrbljM0YBiJYcZVz5oXQ0wenbVqdtPiAqcZQHSMN/Rydz+F85Kzz6
         R9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytGZRZhBsD9RAqys8GtNzSMdWvh1Iy+HMn14LzsKN94=;
        b=ECknBvAnoOyVgz2wIWXTkNuXa5B6ULO3EDvOyvUNSi/AaQLc0TkX/oheGWBsjeH3NI
         FS2muTK+wcN4qN7RZHSSABk388J97lmxYHUvP7AlnE+IzdIf1dy1QZH5UEDbiO+vm1PR
         bo1eEEabpydYYNfitH0wji6qiCDL2E6GA2phlhGNd3wOJpKIvOPfhjgWvz403NRRoy0F
         StqUMrpoGTRwJ7dtdIIesuP+QRoX7j8GpBAoOMiHZaUaomVKpGIicOKDL8EzCLfuxagV
         5ZdlqTk2uNQQbA2/+viJvrFIfmAuRbahaAC/XjEIRtOdIVmNQKqhqtrclxE5crTPIW24
         5oDg==
X-Gm-Message-State: APjAAAXksGA+IUmbEmaNSljkznOu8vlrJBD+8I9viWn+V/TLHib0bbwM
        wFNCq9Mef9KYaPmC67y3e1Upy18GG3PLksNJoVf/Lw==
X-Google-Smtp-Source: APXvYqwgSbB41nehWdUimx+svznPiLqTwcGh9T2HO7pWMfzaMRx40r730ebFy0yRtC5qs7ZoaxntL+97yxfMAQ7/lOE=
X-Received: by 2002:a5d:9c4d:: with SMTP id 13mr16474824iof.47.1562010507580;
 Mon, 01 Jul 2019 12:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 1 Jul 2019 12:48:16 -0700
Message-ID: <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
Subject: Re: Tracking parent branches in Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Kulcyk <Eric.kulcyk@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 1, 2019 at 12:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Kulcyk <Eric.kulcyk@microsoft.com> writes:
>
> [Overly long lines are not appreciated around here.]
>
> > We would like to track parent branches so that creating pull
> > requests can automatically determine the correct branch to merge
> > against.  I understand that this would require tracking more
> > information than is currently available right now in git.  Also,
> > it seems that if some cases, it is not possible to determine a
> > parent branch, in which case it would just be empty/null.
>
> Do you mean by "parent branch" what people usually call "upstream
> branch" (i.e. when that branch on the other side gains more commits
> independent from what you have been working on, then you would want
> to rebase your work on top of the updated state of that branch on
> the other side) around here?

I suspect the question is in regards to "What branch did I create my
local branch from?", especially given the pull request reference.

In other words, when I locally do:
git checkout --no-track -b bturner-some-bugfix origin/release/5.16

release/5.16 is the "parent branch" of my bugfix branch and, when I
push my branch and try to open a pull request, release/5.16 is a
_likely_ target for where I'd want to merge it. There may be a remote
in the name, a la "origin" in my example, or it might be created on
top of some other local branch. It's a common feature request for
Bitbucket Server[1], for example, to automatically select the "right"
target branch for a new pull request based on the ancestry of the
branch in question--except branches have no ancestry. (This sort of
metadata could potentially offer some benefits for building commit
graphs (referring to UI treatments for visualizing the DAG, rather
than Git's "commit-graph" functionality), depending on how it was
implemented, since it would make branch points more stable.)

Since branches are ephemeral names and have no intrinsic metadata of
their own (unlike, say, annotated tags or commits), I suspect
implementing something like this may be more complicated than it might
initially appear, especially if said metadata needs to be communicated
to remote repositories (which implies it might require changes to the
wire protocol as well).

Best regards,
Bryan Turner

[1] https://jira.atlassian.com/browse/BSERV-7116

>
> Perhaps "git help glossary", look
> for "upstream branch" and start from there?  The entry mentions the
> configuration variables used to keep track of that information,
> which are described in "git help config", I think.
>
> > If I made a change to track the parent branch for each branch,
> > would this feature be accepted/welcomed as part of git, even if it
> > off by default?
>
> Regardless of what is being proposed, this is often not a very
> useful question.  Something worth doing for yourself is worth doing
> whether others also find it useful ;-)  And others usually do not
> have enough information to judge if such a change is welcome until
> seeing it in a bit more concrete form.
>
> Thanks.
>

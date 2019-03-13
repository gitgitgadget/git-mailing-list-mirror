Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B72A20248
	for <e@80x24.org>; Wed, 13 Mar 2019 14:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCMOgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 10:36:17 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37642 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMOgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 10:36:16 -0400
Received: by mail-ua1-f65.google.com with SMTP id x1so729717uaj.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gt/KQwHizUKSVIZ54YnNDBPHe4tm1sTrBQbqpSX/TnA=;
        b=Amc0Mc08XuKCV3JiqWuRwDYky+UnapKO70FrO6Ax3uDt/Ww3DMjJFYnX2S2ZKq5Wqy
         FsO34HTUNf4B5x210V8jyrJb4uinpWCL5xdBEziSMeTlS04i9248PbxRL4CRrZwP4DBL
         Zy+Y/vUZdOZz/IBgI/89D7fUU/n0YsEmwk0prbuwKtbJ4ImXiZT8is7AP99T4jbX5a4V
         yy9vvDnPxgLywLISosOfnNooQspo8rEMrfLugVRSJRQg4oFArz+h4C1zDYyOD/vnR+BH
         Y4ADT17oZmASa90OvGc3PMOZcLDo4qJSGES0ErOAzBcdctaFw3jYsZsojE/PzpVNXU3F
         8XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gt/KQwHizUKSVIZ54YnNDBPHe4tm1sTrBQbqpSX/TnA=;
        b=RU5XWmMT3bTqG1PFvMRD5P5VK0icCxfLywOjwJjNA7FdOXJS3/5Z5/q8b4ZkXFmN7Z
         RJjYjOMlliB5QZB8kvoGssYOfkeK5ggmDRnrnKSDGUPFxX411/HIHd2FMmJiuEefdxqO
         TTFuzLVx5TVUK/GL0LFwmAPojdn3t5pxzpmnljsZVW9f/ZhjO+P6456JrRD7c1ckBnSG
         CZkapRhXcFIrfTN/aNAFozZ2uLCCVwQ5MPGtkqwsMO06siV58psJNvB1ruKXsYbKWvx/
         1jdC3ok5v4Ju6NZZTmJClx4y/csk+Tx27L+XWpFILUw20DAoHtV0j95IjtfnSlHv+Xue
         APeg==
X-Gm-Message-State: APjAAAVxY3lUlmO+G9igNe6ufyzfxKplyl03CoNxjOQH5w8mhAzBTz3Z
        YX/beTwBfe4M0ehBX8LXj15YP8kp1k7va6FtYVw=
X-Google-Smtp-Source: APXvYqynzqHoDWWjOx0SZAig+3n07KqsK2Ka7Su11+AOdGFSB7ilTNIbHEulqzU5yxS5+AvsAYZs49teADYDlexAwyU=
X-Received: by 2002:ab0:7191:: with SMTP id l17mr21659780uao.28.1552487775281;
 Wed, 13 Mar 2019 07:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
 <CACsJy8BkdUN=KNGxRi-4jGcw3EQTAuu_2eKcNRDv0uwP5L4=Nw@mail.gmail.com>
In-Reply-To: <CACsJy8BkdUN=KNGxRi-4jGcw3EQTAuu_2eKcNRDv0uwP5L4=Nw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 13 Mar 2019 07:36:01 -0700
Message-ID: <CABPp-BG8cW0mbyM7zboR8rLWae2Yq7TXuGBDYSmY4synA9KMDQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 4:05 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Mar 12, 2019 at 12:54 AM Elijah Newren <newren@gmail.com> wrote:
> > > +--progress::
> > > +--no-progress::
> > > +       Progress status is reported on the standard error stream
> > > +       by default when it is attached to a terminal, unless `--quiet`
> > > +       is specified. This flag enables progress reporting even if not
> > > +       attached to a terminal, regardless of `--quiet`.
> >
> > This again makes me curious what --quiet actually supresses; in the
> > case of branch switching, are there any non-warning informational
> > messages other than progress reports that are printed?
>
> One big thing git-checkout and git-switch will print when not --quiet
> is "git diff --name-status" to highlight local changes since we allow
> switching branches when the worktree is not clean. Should it be
> mentioned in --quiet description?

Nah, that all makes sense.  It was more a curiosity (I tend to have a
clean working tree most the time when switching branches, I guess;
maybe I also filtered out messages I was used to seeing and couldn't
remember seeing them) and also I had a small concern that perhaps this
bit of documentation was relevant for one part of git-checkout and not
the other, and thus shouldn't appear in both git-switch and
git-restore.

> We could also occasionally print advice, branch tracking info, and
> one-liner summary like "Switched to (new) branch 'master'".

Thanks for the explanations.  This all makes sense.  However, all
these answers are specific to git-switch; perhaps the detailed
explanation of --progress can be shorted for git-restore?  Or does it
too have reasons to print non-progress informational messages?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9268EC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 17:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9E6113D
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 17:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhD0Rmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 13:42:32 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:33407 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbhD0Rmc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 13:42:32 -0400
Received: by mail-ej1-f43.google.com with SMTP id t4so7399952ejo.0
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 10:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUfZL1YJ42JWmMjx0FTkgxeWT5KWkuK/teUkq13DUbc=;
        b=jpsWYSQr2A/sqHyAnMemrK1WZ9PghyaBR6+rVmIBxn5Eve9BKfgXvc3y7y71d8kYQr
         1t6GjK4ysfHHZS6cPqLEfCMyRNLA1zdh6DNJcImEmPGRK87sWEQX+FVZZPer2928wpO7
         Ah9cdVwjSdD7zKrRVSyXZBILpcOy8X/+Y6tgFuEFVoqUtnOfjQ07KmeuL9XL0ymqgJOJ
         CUJ4DBkprmxmy3tFCjSrU1mzdorDc5LamnJmy18NvQ9iqoh0v0AKda75rIh8a51skC3p
         DYR1xLG5FDsOInZz2ThujlbOBWiEJCzo+/+LhgFaTTFsBZMvLbEnXbrGJHkC5Y/FRGvF
         Ni2Q==
X-Gm-Message-State: AOAM531JwcVdADUEAxjQvKkXcB8jO2ep5ztCUnImDqkbaFpO4FjAHXPr
        N7sgJNyDbvCJ7rGE4+5uqkLnWBGCO0m9CjFG6Q8=
X-Google-Smtp-Source: ABdhPJyPaypXiYNPsoGxh0U+GtZugZSJuOE5gMOhi3mJkuwNumWA4Qvis3NIIZGS1pCO2qobVEOTdFd1JtRsE9AoVso=
X-Received: by 2002:a17:906:edcf:: with SMTP id sb15mr8319060ejb.202.1619545308047;
 Tue, 27 Apr 2021 10:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <a57ddb3bc7cc2de9a48472c4faff32ef46132f73.1617291666.git.gitgitgadget@gmail.com>
 <4b0066f5-5962-e57e-5987-5358f3d394f7@gmail.com>
In-Reply-To: <4b0066f5-5962-e57e-5987-5358f3d394f7@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Apr 2021 13:41:36 -0400
Message-ID: <CAPig+cR8RUATo0cVZE5fQYOJjs+5v9-JfWdrz+A93Q5_Qr-ZpQ@mail.gmail.com>
Subject: Re: [PATCH 13/23] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 27, 2021 at 1:22 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> > +     // TODO If an external <gitdir> is deleted, the above returns an error.
> > +     // TODO I'm not sure that there's anything that we can do here other
> > +     // TODO than failing -- the <worktree>/.git link file would be broken
> > +     // TODO anyway.  We might try to check for that and return a better
> > +     // TODO error message.
>
> These are not fit C-style comments. This situation can be handled
> by a later patch series, if valuable enough.

In this project, a comment like this would normally be prefixed by
NEEDSWORK rather than TODO, and only the first line would carry the
prefix line, not all of them.

    /* NEEDSWORK: the foinkster blorps the wooz */

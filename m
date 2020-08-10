Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A8C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 11:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CACB206C3
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 11:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHJLBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:01:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41378 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgHJLBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 07:01:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id v22so6334349qtq.8
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 04:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Wv09eHUOmy1qoaoLNmBYCP6QAf1mFkQxqflyVE7Y+2w=;
        b=mVRjndazWSB3SVL/uXLS9bAdqvtfgGG9rfwrK9qIkKEQWr+R+RxcPoBgk71FNGWvRc
         vP44gnoO4LDmw6tQ7we7/65pXH8LDij+qZOoz4NkZaf8+BmPyauythxBaGyGecSdmO8A
         jK037tevktDXSWPfmOtcoFI5epEk2I6SrW8n/ByuNForEsWRh5X84DgaiZ37In+vTb6u
         u5OU0fl4B6m0O0pFD5fD8ojXD6XQa+s1TwfRH66Re7gZ7juRnSEWku/9ZbnQg5/mG393
         5jRiK9h0N5nWFQE0M/5N4wmE1DITvo2JarFe6GTYiifXMn26mTz5iZ3RVgfGnlw8IMQE
         OwoQ==
X-Gm-Message-State: AOAM531NZBxOWvN/quGYo7zwPtYOZnQN7zKmWI+XZcT8jWRPW7S9YtPW
        IS2qVWQlT4BTyDizRMxO+X5adpSCeuYy2g073OnyJWZE
X-Google-Smtp-Source: ABdhPJywa7iowhE36qkeapyxkP5F8lJtKtMZeIS/N9kHLd2r06u87P15npVHSWtmIwfjT+S4fOI2VcCfXHHBzZrP7tU=
X-Received: by 2002:aed:2793:: with SMTP id a19mr26817921qtd.168.1597057311091;
 Mon, 10 Aug 2020 04:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <2639321.dTF8K4C05n@alien.lan>
In-Reply-To: <2639321.dTF8K4C05n@alien.lan>
From:   Tilman Vogel <tilman.vogel@web.de>
Date:   Mon, 10 Aug 2020 13:01:39 +0200
Message-ID: <CAAbQbbBAjhgGLCJ4C_jxf3Byk+pL3Bh8CjUPaBngM25p38OkuA@mail.gmail.com>
Subject: Re: [BUG] git-cherry false-positive on upstream new-line change at end-of-file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Because there was not a single reply to my report, I wonder whether
anybody read it. May I ping for attention, please?

Best regards,

Tilman


Am Do., 23. Juli 2020 um 16:42 Uhr schrieb Tilman Vogel <tilman.vogel@web.de>:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I was working on two branches "master" and "feature". On "master" I
> "git cherry-pick feature" in order to pick the latest commit from
> "feature".
>
> What did you expect to happen? (Expected behavior)
>
> When I run "git cherry master feature" the picked commit is
> marked with "-".
>
> What happened instead? (Actual behavior)
>
> When I run "git cherry master feature" the picked commit is
> marked with "+".
>
> What's different between what you expected and what actually happened?
>
> Because the commit has just been picked, it should be marked as "-".
> The actual behavior claims the commit had not been picked.
>
> Anything else you want to add:
>
> It is important to note that the only change, I did on master after
> branching "feature", was to add a missing newline at the end of the
> file that I changed on "feature".
>
> If I replay the same scenario with a file that has a newline at the end
> and I am only adding a newline at the beginning of it on master, cherry
> gives the expected "-" after cherry-picking.
>
> Please see this simple example:
>
> > git clone https://github.com/tvogel/cherry-broken.git
> > cd cherry-broken
>
> # see broken behaviour:
> > git cherry origin/master origin/feature
> + 26f77def8f1380cc3fd08ebc3f70652da79f1a2e
>
> # check that patch-id is actually the same:
> > git show --patch origin/master | git patch-id
> ca5d666a572ec32bff9cec17b97d611316f89236
> 0725b090dd82f2e6f9949ce853778391e60b08d1
> > git show --patch origin/feature | git patch-id
> ca5d666a572ec32bff9cec17b97d611316f89236
> 26f77def8f1380cc3fd08ebc3f70652da79f1a2e
>
> # see OK behaviour:
> > git cherry origin/master-ok origin/feature-ok
> - 7ce2c0ecd3024c04bcf7b78d332841b2e791e06f
>
> In the "*-ok" branches, the file has newline at the end from the beginning
> and "master" only inserts a newline at the beginning of the file. "feature-ok"
> has the same change as "feature" (content-wise).
>
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.27.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> uname: Linux 5.7.5-1-default #1 SMP Tue Jun 23 06:00:46 UTC 2020 (a1775d0)
> x86_64
> compiler info: gnuc: 10.1
> libc info: glibc: 2.31
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
>
>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B8C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 02:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiBOC3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:29:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiBOC3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 21:29:30 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF1AC07F
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 18:29:21 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s185so19430786oie.3
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 18:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQEHsLPIslTRPas5hc2YlR7KTKJCi/1+y7SctUYp++M=;
        b=n1j/x0uDogfpDan0PjEOoVWpmuV85zNu6UHnlYvvVkaBpK7MSGR3d1XLdcQCS+fAk0
         f0vLsuo2VYvRdegETjpJJIeJ1br/Q1DTHJNrsJUqeo90mo6XcocNJFBaYEB2paTczbwX
         a3XRxv+7nur13IZsoqH1WGwroRLa9/8iWOlTeF0LQyWCjWQTt9M2KPZCsztTS04YfCJC
         OWi3iRWY3Uk+/g8IG31oUDLfdAdkwk91ZfB0umVfCsnQEMH6F3BqByNlL3l1LB5kc/vx
         82dT8WEOZDesSuSPmnnAO8dJaae6eqvjE6KvDTv8/dSNdr5rnMkVjYllwXOI0e//0Q8G
         V/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQEHsLPIslTRPas5hc2YlR7KTKJCi/1+y7SctUYp++M=;
        b=fizfvrial6KDzqZs6u/jqGtpqztZgDfAooGmq6MrC4zWwe18QxyQE8wwnZfCzDIR7Y
         R3vQloLDpsmJ2phbY2s+trwEYymvk/uYz+fmGM23+n91kVGWetfCYytZponx7Rcsny7q
         PMTBXsUjoAsTSo3/bYPLfGteCBg93DYSsCNE2H0oY3NFPkZ823lm/0HYcEZXofwDlS2j
         kF9yMTUpjq/XnBb7gHiZbnr+5PLNqfOnxCx4Gju7NiQUPxmL8pxc6QtSYpu7fa5WpYyA
         6302WPIn18cX8mnZFTAcvNZwUcOzIvjgFWeetbB++Cp8Omm1lVZCQ5WkkRiHMv3jvztq
         pgIQ==
X-Gm-Message-State: AOAM530VFxmm5YegYNFOzNbNhYLYvXCRG4emJ4HpSgj5jLAoZpkYNUeV
        hXPUzsqVUytRfRA2AeTiU9O2BnPvOlh4VTiJI5Y=
X-Google-Smtp-Source: ABdhPJynUcRj98bd+s/Ys6+Qwl2RfMxWFwmvLAGGaVDL/fW6JObppTRTXsyicJsD9OiA3uWg48F9u2QM6PYiRq/Cv0o=
X-Received: by 2002:a05:6808:229f:b0:2bc:7f42:891b with SMTP id
 bo31-20020a056808229f00b002bc7f42891bmr798602oib.78.1644892160186; Mon, 14
 Feb 2022 18:29:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJyCBOTuNn24_WvHv-xQsCdtr9-4_fdrMrOC7ZApg1xFp4RNWQ@mail.gmail.com>
 <d6286f84-642d-7448-0d2e-dd4c20bdb289@gmail.com>
In-Reply-To: <d6286f84-642d-7448-0d2e-dd4c20bdb289@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 15 Feb 2022 10:29:09 +0800
Message-ID: <CAJyCBOSnJNFUV3CWBaBXLw521TLCHifZcrpCro3fPmw41YheoA@mail.gmail.com>
Subject: Re: [GSoC] Interest in "More Sparse Index Integrations" project idea
To:     Derrick Stolee <stolee@gmail.com>
Cc:     vdye@github.com, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 10:38 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/14/2022 7:44 AM, Shaoxuan Yuan wrote:
> > Hi Stolee, Victoria, and Community,
> >
> > The self-intro was done during my first practice patch [1].
>
> Welcome!
>
> > I've been paying attention to the updates to the SoC 2022 ideas
> > page. And find your sparse index integrations project quite interesting.
>
> ...
>
> > And the main purpose of this message is to first, show my interest
> > about this project idea and second, use it as a thread so I can follow up
> > some questions during the research process.
> >
> > Question: It is a good idea to start looking into the commands listed
> > in the idea doc [3] and make some practice patches about sparse index
> > integrations?
> >
> > [1] https://lore.kernel.org/git/20220123060318.471414-1-shaoxuan.yuan02@gmail.com/
> > [2] https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/
> > [3] https://git.github.io/SoC-2022-Ideas/#more-sparse-index-integrations
>
> One thing you can do is look at the history of t1092, which is used by
> every patch series that performs these integrations.
>
> $ git log -20 --oneline --graph --show-pulls origin/master -- t/t1092-sparse-checkout-compatibility.sh
> * 3c0e4178277 Merge branch 'ds/fetch-pull-with-sparse-index'
> * 3a9a6ac5d9d t1092: replace 'read-cache --table' with 'ls-files --sparse'
> * 78087097b8b ls-files: add --sparse option
> * 5a4e0547e23 fetch/pull: use the sparse index
> *   8d2c37320bd Merge branch 'ld/sparse-diff-blame'
> |\
> | * add4c864b60 blame: enable and test the sparse index
> | * 51ba65b5c35 diff: enable and test the sparse index
> | * 338e2a9acc8 diff: replace --staged with --cached in t1092 tests
> | *   ea6ae410bed Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
> | |\
> * | \   e1d92882676 Merge branch 'ds/sparse-deep-pattern-checkout-fix'
> |\ \ \
> | * | | 8c5de0d2657 unpack-trees: use traverse_path instead of name
> | * | | 1b38efc7a03 t1092: add deeper changes during a checkout
> * | | |   62329d336f5 Merge branch 'ds/trace2-regions-in-tests'
> |\ \ \ \
> | * | | | 8c4cbad6a3a t/t*: remove custom GIT_TRACE2_EVENT_NESTING
> | |/ / /
> * | | |   f0850875fd4 Merge branch 'vd/sparse-reset'
> |\ \ \ \
> | | |_|/
> | |/| |
> | * | | 4d1cfc1351f reset: make --mixed sparse-aware
> | * | | 20ec2d034cd reset: make sparse-aware (except --mixed)
> | * | | 291d77eb3e2 reset: expand test coverage for sparse checkouts
> | * | | 86609db9dae sparse-index: update command for expand/collapse test
> | * | | 71471b2a7c7 reset: preserve skip-worktree bit in mixed reset
>
> But of course, this doesn't show the full history of the work in
> each of these branches, so you can do a history walk from each
> merge to get a picture of the full series:
>
> $ git log --oneline --graph 3c0e4178277 -6
> *   3c0e4178277 Merge branch 'ds/fetch-pull-with-sparse-index'
> |\
> | * 408c51f0b4b test-read-cache: remove --table, --expand options
> | * c2a29405105 t1091/t3705: remove 'test-tool read-cache --table'
> | * 3a9a6ac5d9d t1092: replace 'read-cache --table' with 'ls-files --sparse'
> | * 78087097b8b ls-files: add --sparse option
> | * 5a4e0547e23 fetch/pull: use the sparse index
>
> $ git log --oneline --graph 8d2c37320bd -8
> *   8d2c37320bd Merge branch 'ld/sparse-diff-blame'
> |\
> | * add4c864b60 blame: enable and test the sparse index
> | * 51ba65b5c35 diff: enable and test the sparse index
> | * 338e2a9acc8 diff: replace --staged with --cached in t1092 tests
> | * 44c7e62e51e repo-settings: prepare_repo_settings only in git repos
> | * 27a443b8208 test-read-cache: set up repo after git directory
> | * 0803f9c7cdf commit-graph: return if there is no git directory
> | * e5b17bda8b6 git: ensure correct git directory setup with -h
>
> These are just a couple examples of merged work in this area. Be
> sure to look at the full commit messages and diffs to get a feel
> for the area. Then, playing around with the list of commands in
> the project idea document is a good idea.

Thanks for the examples and suggestions! Working on them :)

>
> There is also a series that is currently waiting to merge [4], for
> even more examples.
>
> [4] https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
>
> Thanks,
> -Stolee

-- 
Thanks & Regards,
Shaoxuan

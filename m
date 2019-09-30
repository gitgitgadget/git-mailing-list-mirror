Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D021F463
	for <e@80x24.org>; Mon, 30 Sep 2019 07:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfI3HeT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 03:34:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44450 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3HeS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 03:34:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id q11so6207504lfc.11
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXvucinoDQtsO1OpLNAXaK8wWjGCzZSsQ3v++RJqcJY=;
        b=XRYJhlqRQ4GwbYm5W+6hAtWtD1KpwnKb7Vu4xR1gKP2dCgPLxVPIuJ4HLUoAikJT+W
         GdqBfmmDuZXryx+jSkZr7+k9zc0W0LOo4+DI0/IOYMZhXAkbqDfCVGez/JTan+VAZQnI
         9IfdykuCJxss950hacQMJiij3LsHKIDGxYrLRGP4ld7Tt/EciHoJrJeiOmI5VuZIQC4Z
         RxI1WNCviUDMNQoCFtB10tvzaBbnX0Xs6jtL/RjFoZXImoPBDw4ieLXdx0Atfys5vWLf
         29paLa2efXZNyykac3ICTuUuJTAisCoq3J8hJq9yS+ObycQDW0bBo6VEbghRmFwJ35Go
         7imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXvucinoDQtsO1OpLNAXaK8wWjGCzZSsQ3v++RJqcJY=;
        b=SsIdzX+5srWsQ+CDDWcuEk2hVGPCmCihDRJpr3mSo4YH8r2uebNf2+rPLqtCrt8s6s
         qODwwRiGTacwM76aLQTwYs3lFs4y7dBQm1UUrjqG+UPK+uRdAq14VrClTFmlDPgQf7Sc
         ICIWqIhDegF2FCDLVPzPfoFepkEwcnbx0g8/xob9iSZPNlA9L2Ihy7lC3h7yWQCArBts
         DRNLuFxLV+aGWzuN7088Hw3HJlDScmgUGHvRet62bVKWslCbZ0p13xRr/2Uj85SKHWaR
         VmMzUNVyUzNp0gajhAaQNG+3LzNJLgoOah89bHbwHwvbE4uXXQ5DniDfDeAt80ubFr3q
         dkIQ==
X-Gm-Message-State: APjAAAUWi5Yg+LCFgr5VggBFgwFdFXAItBArgCzWq39OZx5X6TPC/Umj
        8jFn1lzerRArwxRJI+M/SbHi5lja0iUKvtOoHFxk7b4U
X-Google-Smtp-Source: APXvYqyXWe3GzAXeUsDdBmkHx+IeAQEY6tcpr1tgwtHGSYLI7XUhmoCCtPrB8fRgJB3kxg5kapPjrKSHZPPpZOxdVwk=
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr10813339lfc.28.1569828855114;
 Mon, 30 Sep 2019 00:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190929005558.733699-1-alexhenrie24@gmail.com> <xmqqimpainmj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimpainmj.fsf@gitster-ct.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 30 Sep 2019 01:34:03 -0600
Message-ID: <CAMMLpeSY9DJbJJDExS2RcdyXbr8dEW5S67zSyNeCHsr5h2upTg@mail.gmail.com>
Subject: Re: [PATCH v3] commit-graph: remove a duplicate assignment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, dstolee@microsoft.com,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 29, 2019 at 7:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > The variable g was being set to the same value both at the beginning of
> > the function and before the loop. The assignment before the loop was
> > kept because it helps clarify what the loop does, and the redundant
> > assignment at the beginning of the function was removed.
>
> Writing these mostly in the past tense is misleading to those who
> are used to read "git log" from this project.  Give orders to the
> codebase to "become like so" instead.  Perhaps like
>
>         Leave the variable 'g' uninitialized before it is set just
>         before its first use in front of a loop, which is a lot more
>         appropriate place to indicate what it is used for.

Okay, thanks for the guidance. I'll use your text on the next version
of the patch.

> >  static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
> >  {
> > -     struct commit_graph *g = ctx->r->objects->commit_graph;
> > +     struct commit_graph *g;
> >       uint32_t num_commits = ctx->commits.nr;
>
> Stepping back a bit, doesn't the same justification you gave to this
> change apply to 'num_commits'?  If you make it uninitialized before
> its first use and assign ctx->commits.nr to it near where 'g' is
> given its first value, wouldn't it make it even clearer that these
> two variables are almost always used together and how they are used
> in the loop?

Yes, that makes sense. I'll send a revised patch that includes that
change as well.

-Alex

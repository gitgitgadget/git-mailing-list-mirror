Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DD71FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 06:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbdBHGkL (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 01:40:11 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33100 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753599AbdBHGkI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 01:40:08 -0500
Received: by mail-lf0-f65.google.com with SMTP id x1so8462185lff.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 22:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5P726X4xNgcTupuehTGacaHGhQG1n0XK1umyS4jDDSE=;
        b=lnWFZt+/FMjZH33KVflb1LC88wtQkr2OzkBonToCnGb3GkstTsrjJp+o1i+jUmMerE
         7CgbXzv3kQl6YchSO9KejZzpezqK59AsWJ3Mu6joTPP1MbV9UWWTPJBhoEJ2JORr6FoM
         odGOC109zYhld2veZn9qYU0SjKPZO507W4lsAwL6qWw/i9qhfXy4x/awRnC4w7vRYz43
         oP/dKcNZBghRxFBEN0ycInlGJLzC/9VVyEaMlhBeS4He9xFxbxpBIn1IeXESjFHS34Ej
         KvTlJ7YXlOaZHs93I8rl2Rj6EaNAByntykOM+0F2kJ+CV1f67nIgrcWMvdFmKxwpyZgy
         W0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5P726X4xNgcTupuehTGacaHGhQG1n0XK1umyS4jDDSE=;
        b=DnLP+6a6QgavaDnlMTXxL4ZLzZWR175W7h38sVBquLkhe2/5Hytr1KitPVnAep2GFf
         /jXFEVthPf4EgcekrfrXfyGfJr8ApF0rffIevjcTyCGK29nIZNoewpIsWfwkSYcskYsF
         dMDkAHdKj3pf0wwDrpTo3uRh+1Cx15rwNBLzC3q9TgzjyAf/SO6d6AF86S6vdhxGd+N/
         Glb3ZuwF+gxhuYC/hDDANjOfD/jwLf9N/USt1CeSZVt9OeXI0SCINETEenCExOmyUFpt
         rrComS4jLWMUHyG5N3GLH981K3FoE4TwyS/LqQEr+tTEwelrcwsBCh0ZkIjct1FACuKS
         yxgg==
X-Gm-Message-State: AIkVDXLhNWDpmnQWgdHuioYKQqSKrlcv16fx7MLjJ+qMQoCWhJL1DJJTTYARaqdmr+uKZK3IwRTNMJUafMkInQ==
X-Received: by 10.46.69.215 with SMTP id s206mr7725690lja.26.1486535454256;
 Tue, 07 Feb 2017 22:30:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Tue, 7 Feb 2017 22:30:33 -0800 (PST)
In-Reply-To: <CACsJy8CWJvwSnmdpMg=atu+M8=4ksrTAYTgZyF5U7JnOCnPAkg@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
 <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
 <CAJZjrdWbqvBRtyyfhgAt1E9ZdTUaz+Zpk7iGasNoeSuFJbsKog@mail.gmail.com>
 <CA+P7+xoZHOtURfbBbHHTpC3DsGxaGOVToqmW5wTg2EniRpL-Cg@mail.gmail.com> <CACsJy8CWJvwSnmdpMg=atu+M8=4ksrTAYTgZyF5U7JnOCnPAkg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 7 Feb 2017 22:30:33 -0800
Message-ID: <CA+P7+xqg9b+49P6bO65E0q4a87BkNL76XGiUjcMg+UmDcU=WPg@mail.gmail.com>
Subject: Re: Request re git status
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>, Phil Hord <phil.hord@gmail.com>,
        Ron Pero <rpero@magnadev.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 10:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Feb 8, 2017 at 2:18 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Personally, I think that the fact that Git forces the user to think
>> about it in terms of "oh I have to fetch" instead of that happening
>> automatically, it helps teach the model to the user. If it happened in
>> the background then the user might not be confronted with the
>> distributed nature of the tool.
>
> I agree. But I think there is some room for improvement. Do we know
> when the last fetch of the relevant upstream is? If we do, and if it's
> been "a while" (configurable), then we should make a note suggesting
> fetching again in git-status.
>
> This is not exactly my own idea. Gentoo's portage (i.e. friends with
> apt-get, yum... if you're not familiar) also has this explicit "fetch"
> operation, which is called sync. If you haven't sync'd in a while and
> try to install new package, you get a friendly message (that helps me
> a couple times).
> --
> Duy

That seems reasonable.

Thanks,
Jake

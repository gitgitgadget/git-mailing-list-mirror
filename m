Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED60C1F424
	for <e@80x24.org>; Sun, 24 Dec 2017 14:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdLXON2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 09:13:28 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:40460 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdLXON1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 09:13:27 -0500
Received: by mail-lf0-f52.google.com with SMTP id u84so15938096lff.7
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+RTVXRveCNLLKTDAnEfPiQnOLk8cczofp99noGMuFDo=;
        b=YTOxnpzTvqa26mWD+wFmyrStfggSITTQ3aqZ+GHug1zE4g48GKIqZ1xKZstsIR2Zy8
         0cIM6/3C7Sp3YhGqnkVUFTZ3LQ7DxCbI0Zsp19L0mocJe9d6ay67x7FivWYcPUGttHmS
         ElIK/74PK9C9wPJrGevr8NMSpH20FKHKm+4P6vtd6vo7TOzqW9zsCx+OZiKx9UlZLKb6
         Dp6yl0HlayuSwWezFEBhnHCB8C5DjiWa0jz4KBcLZ0sQvqOoFMg91Nh2s4i7M3ZMLq66
         PaeyIX+a/K4um9YsxwZPtzMhUvY4g6GvqcdsQts+hENj6KwclJ1Ru1Kj1gF12oQgIJSO
         vwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+RTVXRveCNLLKTDAnEfPiQnOLk8cczofp99noGMuFDo=;
        b=qZjJnqy5ooZanE7aRUpeJz9LCcXjuwi+4WHpuiSD/2gV3g2GGZhtwU2dHihx/ezs4I
         ypQ3y4cK9NO83L7l4O5+VZgNz7A9WhtJKcoz088wIdNn4Lv/0upEHZvh1yEdRHiLFYrR
         KzS1FTTV5hOrpK9CIgufkDnUb1wdmYoymzqw0TQSdmgZzRep2UdJnla5H4rqjI2koWWl
         Gakfvxovo3rsY0J6vxQRkQqBWqMXqE4kJ8jgqDfIsQqpSBfnc0CrL++hnyW0RU8bNQF7
         kQrflTxuKwZHBqn0g6/GGUkFQ3KL/FFppP/WFmYvFmbUDPWGM+/v16oeEDvkZBQO6ESD
         Acxw==
X-Gm-Message-State: AKGB3mLU/lcuHhp+hzyNPjYrOk1WAeQw/TRmJIXq6NHy2GODeaqg6sSr
        fMKYBv8m+EQmAEuPio/sigU=
X-Google-Smtp-Source: ACJfBouDOdwiGoucdrl0UD5n9fo/zjaxZzt8o9IUdrlawLyrP0+5Pjs8004M6KNWx9LDKakSDi4m9A==
X-Received: by 10.46.34.196 with SMTP id i187mr12412761lji.106.1514124805533;
        Sun, 24 Dec 2017 06:13:25 -0800 (PST)
Received: from [192.168.88.241] ([46.98.137.84])
        by smtp.gmail.com with ESMTPSA id r90sm5300317lje.80.2017.12.24.06.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 06:13:24 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Bring together merge and rebase
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
In-Reply-To: <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
Date:   Sun, 24 Dec 2017 16:13:23 +0200
Cc:     Carl Baldwin <carl@ecbaldwin.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <16725929-1BD2-44D3-8E71-E97C4A2C4034@gmail.com>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
 <20171223210141.GA24715@hpz.ecbaldwin.net>
 <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 24, 2017, at 01:01, Johannes Schindelin wrote:
> 
> Hi Carl,
> 
> On Sat, 23 Dec 2017, Carl Baldwin wrote:
> 
>> I imagine that a "git commit --amend" would also insert a "replaces"
>> reference to the original commit but I failed to mention that in my
>> original post.
> 
> And cherry-pick, too, of course.

Why would it? In my mind, cherry-picking does not 'replace' or 'refine'
commits, it copies them into other, unrelated branches (usually something
like stable branches maintained separately from the mainline). If anything,
cherry-pick could add a separate "cherry-picked from" reference which may
be useful, I guess, for conflict resolution if two branches with the same
commit are merged.

> Of course, that is only my wish, other users in similar situations may
> want that information. Demonstrating that you would be better served with
> an opt-in feature that uses notes rather than a baked-in commit header.

Using notes also allows to test and evaluate this new feature without
any changes to core git, using it as an extension at first.

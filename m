Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7911FAE2
	for <e@80x24.org>; Tue,  9 Jan 2018 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935138AbeAITB7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:01:59 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:45620 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeAITB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:01:57 -0500
Received: by mail-qk0-f175.google.com with SMTP id o126so19847479qke.12
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4W6n8WwTGXjeN/rOEezh+2rwHrx7ja3v56qFMXHMBsk=;
        b=KpzcAjpwku/drXG7jtzKnZnMuhYdNwapuLZOlWO/i5u1qUoI8Iv93ozvgG5+bl6wSt
         oFK7Japyyffjp5IONNnY0JlSxl46PvUmxWeBxzUgMrXgSPozGxXD/ZouO+ciGqBzFF8l
         J5iiv4eJzzPa/8+lz80EudxAwkHkx1DpwRfplvSBnuho6GVuGFrVglBqMw3HGlcknE3+
         EpJ3cBuAg5xgLKHI9SEe/86kYBaOXgCs9W52ATVPWprcmoAygzKVHTBBVpONiwMnvwMI
         4eVyjSjUn1ckAIwMOdQbVU9+TRszXIPvnovss51igGLaUWmeTI9qIL4POTOV7vZ4635t
         6CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4W6n8WwTGXjeN/rOEezh+2rwHrx7ja3v56qFMXHMBsk=;
        b=Cej9oZbgvymRyaAc8qEt6HfLqu2uLtoFIaqYO+IrmmTdjRBdkpVH1x8muiI7mMeJ7D
         b4xwobLakkYN/e2zOy4vWX/cnWmJR/dPgzdR8BIQ3HqCMHJmMXAPM/oVGjBwus+AesYk
         4PcV3pnlHwUdeFbJqrEOXQHJ9SITLLrG7O0ZYXPlV4aqGnf7bMdPG8TfPYSDucaByTrX
         wXAAeBsoGYFnrN3SohThB2FYwkobTN+CtCPwEyDU6xGoh2lNM0V7lE+ZrUE4wqYMz35/
         Wl4jQLYi3eo5RygphsLltDyjNJdDOfGyAGmoEnFLznz3ZV4EDp0zSm7CP3/oU/MAuGDR
         Cbbg==
X-Gm-Message-State: AKwxytdK1FJJT6UCg/NAptt1t/fec3gbj3Mv7LlnBUxy4NEbP7JT+8Ps
        S+nmsDzktmlBbB/2VwT4s6yHlYYB7Yfnm7k7s0LqbA==
X-Google-Smtp-Source: ACJfBotJQFX6YSe8nZ93ueuuXFeIakP2D7fxeiUFWMYP/a5Pt1iZJ2uuAdmts6M8WE7fEOTXQOOMRfquSBH6UkR57nM=
X-Received: by 10.55.77.142 with SMTP id a136mr22072092qkb.320.1515524516941;
 Tue, 09 Jan 2018 11:01:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 9 Jan 2018 11:01:56 -0800 (PST)
In-Reply-To: <3d85256e-4f19-b9d6-323a-d683dbfd8cf7@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-4-kaartic.sivaraam@gmail.com> <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>
 <3d85256e-4f19-b9d6-323a-d683dbfd8cf7@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Jan 2018 11:01:56 -0800
Message-ID: <CAGZ79kZkM1jEg4qcTz9CCkOzUx-PX5BOyeprWOht6_hNfYvkjg@mail.gmail.com>
Subject: Re: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in
 reduced size
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 8:01 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Tuesday 09 January 2018 12:08 AM, Stefan Beller wrote:
>>> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
>>> index cb795c6b6..3f73983d5 100644
>>> --- a/Documentation/gitsubmodules.txt
>>> +++ b/Documentation/gitsubmodules.txt
>>> @@ -63,6 +63,9 @@ Submodules can be used for at least two different use cases:
>>>      * Transfer size:
>>>        In its current form Git requires the whole working tree present. It
>>>        does not allow partial trees to be transferred in fetch or clone.
>>> +      If you have your project as multiple repositories tied together as
>>> +      submodules in a superproject, you can avoid fetching the working
>>> +      trees of the repositories you are not interested in.
>>
>> You do not fetch a working tree, but a whole repository?
>>
>
> Maybe I misunderstood submodules when I wrote that example. Could you
> help out with a better and precise replacement?

If your project consists of multiple repositories tied together, some submodules
may not be of interest for all users, who do not need to fetch such submodule
repositories.

> Just putting in some context as to why I did this change, I thought this
> was the only thing that lacked an example and wanted to make it consistent.

Oh, sure I like the example; I was just worried about the wording, as a worktree
is part of a repository, and the repository is the whole thing. In the
current situation
you can only fetch all-or-nothing, specifically you cannot fetch "just
the worktree"
(a shallow clone/fetch is the closest to that, but that still has the
same amount of
information the .git dir, than in the working tree)

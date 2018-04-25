Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC821F424
	for <e@80x24.org>; Wed, 25 Apr 2018 01:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbeDYBaM (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 21:30:12 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:56135 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDYBaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 21:30:11 -0400
Received: by mail-wm0-f42.google.com with SMTP id a8so4360371wmg.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 18:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lqd+jXPDOs6PPw+CYj2HluzlB88t2gTqMp4TP+LBVl0=;
        b=ZVcXWC65LglyYQw8DAYvJ1XjT7q6gnEf4ZJbj9+YdCOiOXRDnNhU4MMBm1nOdGNPuh
         PiuaCmdGXP8rhK1wtxmpe/e5OFBm+xkFd9M5C5LEhAgfvcy00JAEQxJ3hiNnzSAr8iqM
         pvabqxWGBOCNIwbWrl+3BRgzSYE12Kp3kwf08FoP524jFQlxqpHAK6XGNs3TeZE9n2I/
         zrm7qTMubH+NeY6l+nvqa3zdfMC+MkhChij+cPH1Hn2OmuMbIA6/FSPEPV8U4LsXIxM2
         RczbRPY8QzJRn7IDhNiTpi1HixKHBFUS6voam5MMeIyQ4Rh10Ra5AjQtz0dlusXHnbsd
         vZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lqd+jXPDOs6PPw+CYj2HluzlB88t2gTqMp4TP+LBVl0=;
        b=Y3Im+JW8e8uRNUFAdc5K03nlgJsWtZiYsCtaH68ZC8tvPXdtu/hT+Qm402rDmTQzJG
         lHPLUXaF/wjN/28L9z+9N6A83THoMDGlNm5q53qjO0Yu6RhMwsUdEOGzohYpTPXJlBhg
         NP85dDtcgpKGf5DhHfjhM3suXjEGFXSygZ34sauqTzaau5N7p/neTg8SgC/RTtXUmPPv
         TP9ooEY7cAhmyikAB45iYCBdKw5MQC6XoNCphJUT307ZufrjIBG4APEjznalTsr4KvP5
         i0pLmePOvwA94UdYB6D6HUGML3o6ZlILP8H8lB2E0uSy5FR83lEVvGGqOIP3ozVcFP/d
         tCBw==
X-Gm-Message-State: ALQs6tA7/VuXRsNqJceu5NA0iwRMo7M/kdSkzZzEJhzmpJtCRl7xeF0O
        zwtE2QgUjMsUuPOBCjA8Z29rujxDcO+XNy9AT2aH2g==
X-Google-Smtp-Source: AIpwx4+Cq3bBAhmDUz4ZWRVNnJS9BX48J6vHjZXqT2uiqN0PmBq7xx9tdz0Eylm8SFJm11Yz4yWhtVDnd1wuZ19Vwbw=
X-Received: by 10.80.175.2 with SMTP id g2mr35933180edd.84.1524619810592; Tue,
 24 Apr 2018 18:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Tue, 24 Apr 2018 18:29:50 -0700 (PDT)
In-Reply-To: <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
 <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 24 Apr 2018 18:29:50 -0700
Message-ID: <CA+P7+xr3cdLB+s+6A81Y9WzZUYupSECjQ1bAOKTHsUJjQQi90A@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> Ideally I would have liked the tags fetched from gbenchmark to have a prefix
>> of gbenchmark/, like the branches have, maybe something like:
>>
>> $ git fetch --tags gbenchmark
>> ...
>>  * [new branch]      v2              -> gbenchmark/v2
>>  * [new tag]         v0.0.9          -> gbenchmark/v0.0.9
>>  * [new tag]         v0.1.0          -> gbenchmark/v0.1.0
>>  * [new tag]         v1.0.0          -> gbenchmark/v1.0.0
>>  * [new tag]         v1.1.0          -> gbenchmark/v1.1.0
>>  * [new tag]         v1.2.0          -> gbenchmark/v1.2.0
>>  * [new tag]         v1.3.0          -> gbenchmark/v1.3.0
>>  * [new tag]         v1.4.0          -> gbenchmark/v1.4.0
>
> The tag namespace (refs/tags/) is considered a shared resource (I am
> not saying that that is the only valid world model---I am merely
> explaining why things are like they are), hence the auto-following
> tags will bring them to refs/tags/ (and I do not think there is no
> way to configure auto-following to place them elsewhere).
>
> But you could configure things yourself.
>
>     $ git init victim && cd victim
>     $ git remote add origin ../git.git
>     $ git config --add remote.origin.fetch \
>       "+refs/tags/*:refs/remote-tags/origin/*"
>     $ tail -n 4 .git/config
>     [remote "origin"]
>         url = ../git.git/
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = +refs/tags/*:refs/remote-tags/origin/*
>     $ git fetch --no-tags
>
> The "--no-tags" option serves to decline the auto-following tags to
> refs/tags/ hierarchy; once your repository is configured this way,
> your initial and subsequent "git fetch" will copy refs it finds in
> refs/tags/ hierarchy over there to your refs/remote-tags/origin/
> hierarchy locally.

It should be noted, that remote-tags would not be integrated into "git
tag" or many other places in git commands, so it may be significantly
less visible.

Thanks,
Jake

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1C71F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeIKVsc (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:48:32 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40508 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKVsc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:48:32 -0400
Received: by mail-wr1-f46.google.com with SMTP id n2-v6so26777021wrw.7
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6soKONfAgAQqnl6Jeua/MHBOmVZDbJnCos7oZejhsvA=;
        b=alAFR45/HVvyWmWayL6FKFWuSeoR4y+u/NfdkxUk3hqeykpgpGAaRwPM8MuEV7ZL/m
         AIHQmu3VRGJpRKkLtr39fd7qgJXoqB43fV8fta4NRZGCKwSfpjMhJF7OTWU5EOkfmSTV
         p5FUjX9RvFRC72ZKdDVKugN41RJvfjwEPTABKLZyjVqOxxLgkR+G0nhWX2/ALRwQgSyB
         ssy3NoO3MDNdfj5NxQ9vWasMMhsgbrnep3wGJFW+HDTFB/MxCkIrs8dk/hP+/Tb0uDzs
         lcaLV7koqOc+bYGvOXHuYXIdqFrGOkKAQ66SPHtEHAX8PDkrcCslCpNJTFWNuFDrPzKX
         GFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6soKONfAgAQqnl6Jeua/MHBOmVZDbJnCos7oZejhsvA=;
        b=BO/THZDcOGpWCxE4/Kh0NfLgjh0DymICyL/YQinagEI4wIEx03DQj7YLjNwWEmhJWC
         XbNks/pnWFXqtTr16zE3AcxTpGTsxxUlLDtt8yR71FzAmwetGQPYh0W2+S0h/Dv7GifT
         kKWrUhh4DahYsdOupGrXD+NnrWn4LYpARns+DceaZ3d2ha1A5QVJkpciHQRK4SF/vSuR
         Hclgd9d4lY2aywcf3aURAMxMYLwTfVcXM7v0fUGTzeSNN2bKtFA1D6WbUcrl1wyjWmI6
         qUw2P0W0+GXCvFaltY9Ph3KWVuE5cJfHL14U4xR+5iSGoewAIFT+zbH7ZUoOUV7hJ/HR
         afKg==
X-Gm-Message-State: APzg51BPUyn/M/54v2f9UvYFZLRt741aEAB2Xr8pN8pgZY3+I1mwQ4QH
        7e55uXc3Yv5kns3pFqA032Q=
X-Google-Smtp-Source: ANB0VdZK6OkUSJbAggJKfpGhbTJfqvEZb+d+rR7AfgDJq7hCZ7ghsQpX/ByM6/8pzvAjp2XBXDSrkQ==
X-Received: by 2002:adf:c751:: with SMTP id b17-v6mr20055811wrh.134.1536684501166;
        Tue, 11 Sep 2018 09:48:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 72-v6sm25914044wrb.48.2018.09.11.09.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 09:48:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
        <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
        <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
        <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
Date:   Tue, 11 Sep 2018 09:48:19 -0700
In-Reply-To: <fd241679-2283-4e01-315b-db27be8a794c@gmail.com> (Derrick
        Stolee's message of "Tue, 11 Sep 2018 12:13:42 -0400")
Message-ID: <xmqqa7ooq8to.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/11/2018 12:04 PM, Derrick Stolee wrote:
>
>> The patch below includes a test that fails on Mac OSX with a segfault.
> ...
> Sorry, nevermind. The test failed for a different reason:

Even if it is for a different reason, segfaulting is not acceptable,
but it seems it is failing quite normally.

Shucks.  It sounded too easy to get a reproduction like so X-<.

> 2018-09-11T16:02:20.2680990Z ++ git range-diff changed-message
> 'HEAD@{2}' HEAD
> 2018-09-11T16:02:20.2779250Z fatal: Log for 'HEAD' only has 2 entries.
> 2018-09-11T16:02:20.2802520Z error: could not parse log for
> 'changed-message..HEAD@{2}'
> 2018-09-11T16:02:20.2817470Z error: last command exited with $?=255
> 2018-09-11T16:02:20.2832300Z not ok 12 - amend and check
>
> Ryenus, it would help if you could create and push the following
> branches based on your local repro:
>
>     git branch base HEAD@{2}
>
>     git branch topic HEAD
>
>     git push origin base topic
>
> Also, does the following command fail, after creating the branches?
>
>     git range-diff origin/master base topic

Yup, that is a very sensible way to get a reliable reproduction.

Thanks for helping.


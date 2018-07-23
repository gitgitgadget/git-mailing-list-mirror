Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A001F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbeGWTOi (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:14:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37085 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388136AbeGWTOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:14:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so1618262wrd.4
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LtKwnk+XRSooHnnAhjnaTYRdDJ8vxHDhmFNQaS78MM8=;
        b=pcRiZImQJbGErq2NvTy1TAZz9Db1a3X8eAdj+VGsBpiB72iZwe0B1wULzBxREDZQDK
         wgQJh/JQwyhI1w+pRoUIhJAPKMPwU2jvgUrct0Xe4uRZuqQnWcR6Lxss44gRnZ4M3WMq
         vMydKFFU53vDSMRS5R6J+cJwDZN53pjtlRD3Evo1cGaXvhzfeXzzEw5PA/Vbm2NE+AVv
         99AR3/Pt8ZZogElSFpWzyHGBeff2wMgoSM3F6BsrJul6vS/YrIF8Rv3c+FLVJu0RD/kN
         o+SzN3ES4Yb7RmZA36fAK3bsiQt7CV4+n14MMe4yfwOq/6iEI27YKfAJtG8OLngtPd1D
         0M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LtKwnk+XRSooHnnAhjnaTYRdDJ8vxHDhmFNQaS78MM8=;
        b=lX2uRA6ATYnVWEaf0RMoDE02n4Zlk2AKKyE06RdaGfcSl1LfIfysxSpPNtpQT3iifo
         O6FzM4lK3kCuqEIIokcIlnOMhV9ZAH4j/m6xHj/zr30AO3dKs141SatI4oYUVnznQVF0
         H8zzSfs9LRL0hMaEdk7gn68jbu1udbgTnrpKW57iivEnqFVtY9gscK/DyddXdXChGL8w
         ghICDTLF8Val6u30TzXYAre4VePddSmEGRwFCDwmzQ2aBQFKrObWeDi15WwncByaTgri
         f/Qyt/YLz9yIrxW5xjFLw4K3AqdSyv1wVtfrWtxQxm9ENAZkvvLy+FbQoEVOgd8O23Xa
         yCMw==
X-Gm-Message-State: AOUpUlEKscPT5O7heHXQ0ul6JwaZV9B/e9N/tHFRwp32W67p0hRiVmXY
        wlBjzt279a9Mo35dsD3ovQc=
X-Google-Smtp-Source: AAOMgpc0T9Zhb0Mvmu2Sp+RZPqynCJ4rOJaty0af4tZK2HDcGfk3OlI5OuAmXKoKDdE6I2TYgVkqgA==
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr9801697wrr.227.1532369531893;
        Mon, 23 Jul 2018 11:12:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f8-v6sm16521153wrj.9.2018.07.23.11.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 11:12:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, kewillf@microsoft.com
Subject: Re: [PATCH 1/2] t3507: add a testcase showing failure with sparse checkout
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
        <20180721063428.20518-1-newren@gmail.com>
        <20180721063428.20518-2-newren@gmail.com>
        <5250481c-f6a1-0784-28e7-f34a9d6d3c93@gmail.com>
Date:   Mon, 23 Jul 2018 11:12:11 -0700
In-Reply-To: <5250481c-f6a1-0784-28e7-f34a9d6d3c93@gmail.com> (Ben Peart's
        message of "Sat, 21 Jul 2018 09:02:47 -0400")
Message-ID: <xmqq4lgp7res.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 7/21/2018 2:34 AM, Elijah Newren wrote:
>> From: Ben Peart <peartben@gmail.com>
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> Testcase provided by Ben, so committing with him as the author.  Just need
>> a sign off from him.
>
> Thanks Elijah, consider it
>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>

Thanks; I'll also tweak the in-body From: line while applying to
match the Sign-off.


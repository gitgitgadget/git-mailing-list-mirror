Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9062A1F45F
	for <e@80x24.org>; Fri, 10 May 2019 19:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfEJTyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 15:54:17 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39396 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfEJTyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 15:54:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id w21so5653796ywd.6
        for <git@vger.kernel.org>; Fri, 10 May 2019 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CMbDxAJ2c2Mpropfy/o3zxJP329MHPLJO1HLQBLjzbA=;
        b=H39CFUa4z/m5hDEZ00b+tgmJQdGY7uudCcV26DilsH2+0ee+mxzu1Yv5PiDpnqPBqo
         V8ARQQIuH1qVeGRb2/dhxVPkdJbfVqP5TmzualvAwoRStUFzlsovAujNonXczcJ9n51X
         lkmZcjiKYc0If2SwAWCweZ+0lX+tvoIgum8q6HAhhRAkNRbT7/ysR2Kndl0dSy0LObFp
         sHohFN/iXnWKLvOMYfix13c1cnNl0+tAoIHNch6yU/W6duFPYH5DtKtUUFajpH69fcWz
         E/93PTbtX9BEB8OA79gp6Mp9uX9jJLzAwyEwVgNrus2Y3LRdJ4RjFeulgWWoNUfDVTvE
         CNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMbDxAJ2c2Mpropfy/o3zxJP329MHPLJO1HLQBLjzbA=;
        b=HfklN2owcdHx9TEBNy9sNOioOuPnWoUCp/BjHI0HS0RRRnXz8+Gnic6/ep4CG5mXe5
         3EY8jMZoPiH6TFdfttpDp554prGgO8oknREqBam5eDMbHkB5Ky8LHjlx8FGmHRI7ONjy
         TiKImzVGJ/ORTgeIo4m9yH+SxnCOvQWyrK4B11e+slAUs7//2xJ+iqG75jnTaaGDM5up
         mel9WkS23I3zY2unHrcaZ1xJL+gNWQzjNFtIPqyKUBFlXSiz0uNyVDwcT0WKjF+hM51O
         vxcthCsAftgmdeeZlanbt1dwBc30t34fePkoMMn3GmKb9x0V7UpG4+8vGx09DebCGopH
         Y/DA==
X-Gm-Message-State: APjAAAWmZX+2Grqst686BGh5S5JBql8S99+XwJYqgHcejG5L2NdUoQHG
        Q4K2FMLBSbbwwKOLMMxJ41tadLpEC2w=
X-Google-Smtp-Source: APXvYqx5wLZGUd98pgbgBRwp2Pa7qdvurfcGjBjFdGa0bSVImFv8Szz1NXxntEfqp3Chgdb7SprbmQ==
X-Received: by 2002:a25:5285:: with SMTP id g127mr6986608ybb.202.1557518055565;
        Fri, 10 May 2019 12:54:15 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id y127sm1520507ywe.84.2019.05.10.12.54.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 12:54:14 -0700 (PDT)
Subject: Re: [PATCH v7 02/15] trace2: create new combined trace facility
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
 <pull.108.v7.git.gitgitgadget@gmail.com>
 <90e4e6af9300751fd2e7e98601ed0e60ca048e05.1550874298.git.gitgitgadget@gmail.com>
 <20190510172824.GR14763@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2cbc8e41-fe0e-ea2e-5550-0df30f15b293@gmail.com>
Date:   Fri, 10 May 2019 15:54:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190510172824.GR14763@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2019 1:28 PM, SZEDER Gábor wrote:
> On Fri, Feb 22, 2019 at 02:25:01PM -0800, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> * GIT_TR2_EVENT is a new structured format. It writes event data as a
>>   series of JSON records.
> 
> Please document these new environment variables in
> 'Documentation/git.txt', where the other environment variables,
> including GIT_TRACE_*, are already documented.

Thanks for the report!
 
> While doing so, please note that the description about the possible
> values of these variables and of GIT_TRACE above is incomplete,
> because it's not just "1" or an absolute pathname.  Quoting the
> description of GIT_TRACE:
> 
>   If this variable is set to "1", "2" or "true" (comparison is case
>   insensitive), trace messages will be printed to stderr.
>   
>   If the variable is set to an integer value greater than 2 and lower
>   than 10 (strictly) then Git will interpret this value as an open
>   file descriptor and will try to write the trace messages into this
>   file descriptor.
> 
> The way I see it in tr2_dst_get_trace_fd() below, this applies to
> GIT_TRACE2* as well, and it even offers the possibility to specify a
> Unix Domain Socket, too.


Please see [1] for a possible direction here.

[1] https://public-inbox.org/git/pull.189.git.gitgitgadget@gmail.com/


> And sorry for barging in with a big bucket of paint this late, but,
> really...  why GIT_TR2 instead of GIT_TRACE2?

I did not do anything in response to this. I'll leave that discussion
to others.

Thanks,
-Stolee

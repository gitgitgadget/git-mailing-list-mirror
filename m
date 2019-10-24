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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2D81F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 17:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410063AbfJXREG (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 13:04:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35469 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410060AbfJXREG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 13:04:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so24097397qkf.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dSGoTZ8q3GGEskejcAoWxTClFMl8DwR+kNntJtsqUA0=;
        b=SGZ4xjpTRfuJTVcEHAqGFt6A31a3CjJp3gNd81EQ8wPQIYOvekP8V/X7078nje02Za
         0PE9+XdLWLrbCjXM/YQ8BauWm3nCbzcX2kmhA2pJCBZVXyQLj/alclQ1GZutLzq+SOui
         u0rwOyZm27QW5xxvIafzen+jlMxS3ANSw0eScFE5QUgPQUMI3p4SMRtJE83hmTCclc+G
         gAMIz6W7JdB632Em3FIJdLv4bUTzvqWAecQDjOXqAn0kY1CpulcrTVuGWuEUSsmTr4M+
         ATwH2TcaBcPWKU84k6Sm5q9XOL634yZ7g4BV+PSwrMH28piPK6dZnzsAS0VCcf6CIWil
         vEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSGoTZ8q3GGEskejcAoWxTClFMl8DwR+kNntJtsqUA0=;
        b=ESchY+GGEl1HjPFr83gGddkoc7tq10sQzcbgxAoYxai+zNjwce3z+gcf4fChgbH1mc
         iGv4IuwPJjWAMkOt1kcWyJp+hzXzeWRVCCXuw8Sx6Bg0bS9Q22Kjn3CB6PS9vcbfILCd
         xpXnN3BXjOnCEi56D0Pe4iXb7v2cppg27T+Aa/U89M6uU2nJaa9DqPITopBTsc3i5LDu
         EqyU6QVsLNK4qVxbu6mZKEtXFRp7kSF9VI32MjxYBJ7s58fPlDDb0zHFp7s4rqmeqWFl
         UAlg83cXgzEjBPauOjSnyDxvC6KkW0OaX1ksu+hRS4R0z0qY7nH12dW/MO4aHoEm5+18
         MqfA==
X-Gm-Message-State: APjAAAXbqzl/FkkgNLTjkZ1veRwiDx3d1Fr/zQ15E5kty/bKZshHQ5GT
        nqDoOM/EBS3mn1gbs36ns4E=
X-Google-Smtp-Source: APXvYqxMGXDg7yRQkFSOYmtUod3vhie3dl+p1bml3mwKT0dz12sVSt13hW2puTZ7vUGoaYxO3OcZcQ==
X-Received: by 2002:a37:8ec7:: with SMTP id q190mr4266038qkd.46.1571936645230;
        Thu, 24 Oct 2019 10:04:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:745d:45a1:7d20:d88c? ([2001:4898:a800:1010:2593:45a1:7d20:d88c])
        by smtp.gmail.com with ESMTPSA id p7sm14719046qkc.21.2019.10.24.10.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:04:04 -0700 (PDT)
Subject: Re: Git Test Coverage Report (October 11)
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
 <20191023170049.hnzb22iiflrigyfs@tb-raspi4>
 <ebe33082-976d-7146-1450-925e4785faf1@gmail.com>
 <20191024152508.a6vr7nh62wsqzy6u@tb-raspi4>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b0caf237-6580-0b63-5cad-7b1ecf8a1710@gmail.com>
Date:   Thu, 24 Oct 2019 13:04:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191024152508.a6vr7nh62wsqzy6u@tb-raspi4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2019 11:25 AM, Torsten Bögershausen wrote:
> On Wed, Oct 23, 2019 at 02:07:20PM -0400, Derrick Stolee wrote:
>> On 10/23/2019 1:00 PM, Torsten Bögershausen wrote:
>>> On Fri, Oct 11, 2019 at 09:33:11AM -0400, Derrick Stolee wrote:
>>>> Here is today's test coverage report. The usual report format is
>>>> available online [1], [2]. The report listed below is a new format
>>>> that groups lines by the commit that introduced them [3]. Thanks
>>>> Peff for the feedback on that idea.
>>>>
>>>
>>> []
>>>>
>>>> Torsten Bögershausen	ebb8d2c9 mingw: support UNC in git clone file://server/share/repo
>>>> connect.c
>>>> ebb8d2c9 921) path = host - 2; /* include the leading "//" */
>>>>
>>>
>>> I actually looked into this one, and my understanding is that the code path
>>> makes only sense for windows and is only tested on Windows in t5500.
>>> (Linux/Unix/POSIX don't use UNC path names starting with "//" )
>>>
>>> How can we avoid those "not covered by test" warnings?
>>>
>>> One solution could be to use
>>>
>>> #ifndef has_dos_drive_prefix
>>> #define has_dos_drive_prefix(a) 0
>>> #endif
>>>
>>> in git-compat-util.h and hope that the compiler is smart enough
>>> to optimize away that line of code.
>>>
>>> Another way could be to have #ifdefs in connect.c, so that it
>>> is clear "this is Windows only".
>>>
>>> Or make a comment for the "cover report" saying "not covered".
>>>
>>> Are there any good or better thoughts on this ?
>>
>> One way to avoid this is to add ignored lines to the test-coverage
>> repo [1]. These only work if the exact contents match on a specific
>> line number, but can be a way to stop noise in the short-term.
>>
>> For example, I added a few lines to ignore in commit-graph.c [2],
>> but I haven't added ignored lines in a while.
>>
>> I'm happy to take a PR including the lines you want to ignore, or
>> I could take inventory of the lines in the current report before regenerating
>> a test for -rc1.
>>
>> Thanks,
>> -Stolee
>>
>> [1] https://github.com/derrickstolee/git-test-coverage
>>
>> [2] https://github.com/derrickstolee/git-test-coverage/blob/master/ignored/commit-graph.c
> 
> I added a PR as suggested.
> One thing, that came into my mind:
> 
> Would it make sense to loosen the condition:
> 921:path = host - 2; /* include the leading "//" */
> 
> Remove the line number:
> host - 2; /* include the leading "//" */
> 
> That would assume, that the line is unique within the file,
> (can be checked with unique) .
> It can give a more robust handling
> when lines are added in the file and file numbers change,
> but the content is the same.

I'll consider making the line number optional. The reason I put
the numbers there was so we could have

	994:return 1;

and that would check a particular error-check path, but not
ALL places with "return 1;".

Your line is particularly unique, so ignoring all lines with
that text should be fine.

Thanks!
-Stolee


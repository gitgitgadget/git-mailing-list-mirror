Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360911FD09
	for <e@80x24.org>; Wed, 31 May 2017 13:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdEaNhg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 09:37:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33429 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdEaNhg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 09:37:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id a46so1885337qte.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U4dVoi4UNHN1LeBkXAILFAMwVvzegNPYWD3feuvv8fk=;
        b=pgxfxGm9RG3VqoYGrf3Ln8TWQFTlwfWku/GbZReryHsu6i2pTrnxrLGz4/YMLdyMl2
         YqdYo534gnVLWrlUc4XnxFoAE9BqdfrKxpry8WrGvGMsr0paXCstnwbXEzeZ/8bTWJ3p
         x6d/6mOmQq2wOQ/9hPzwlCNN5uA0uozfsI/UmQHAmFj22FJP457PguqxORRDv9pkc7Gt
         8f0WgDdqVDb54z2ABO5FkquH+6SS1R/E7ntifRyCTqDi/S3Zh1OfX3rcUPbQ5ng0GtSs
         Hzur+w2hussNEww/6RSsc2gfTJUuJXqDusad/7Tu04qQdulJpqStIK2vSBcIBwOsHGTm
         Da3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4dVoi4UNHN1LeBkXAILFAMwVvzegNPYWD3feuvv8fk=;
        b=Oz0y/gCbKd5+gyVYBAHwx9Y/tVpzck/HTeyKBO6CwjxSX4U72Et3ECCOYPG5YGYSYU
         8AcVykebY2LVrD0M5VB4c7QQfQLEmZQv4UIE3y9ZSvf54ES4kxyCwXmFIOCsfivMP9NU
         TO7RoH+BSd5EjQHNUc7I69u62liUewNjZoFcXoyjgZnH+LlDU3a2GgtSc1AFajLje0tS
         +KX1GNTIAfI0SISacgRcHIzCRVymIP4riMySbS2dM4I2Mk7QY9kpXaU6xHOOVxQEv5+k
         4VSGuQh4HA60h4v3gWO5S3AvWVJC9eQPnhXBKTtLS8sQHGuhwK8/A+o8ZMzEsALUoiIw
         9+BQ==
X-Gm-Message-State: AODbwcBRevZ/g9WcHSbZAnXSNKJV5o3OzJq5x6UJWWzCDKxc3vENRH3w
        zmJnqLtu/hwksg==
X-Received: by 10.237.57.170 with SMTP id m39mr29461181qte.235.1496237855129;
        Wed, 31 May 2017 06:37:35 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id x53sm10661438qta.36.2017.05.31.06.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 06:37:34 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
 <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
 <CAP8UFD3R0dEsX7BtzYoSmvaKTZYsm9=bpQsu0jEk2aKm83z-2A@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f2c21d3e-9892-bdcb-2686-341de87ee15d@gmail.com>
Date:   Wed, 31 May 2017 09:37:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3R0dEsX7BtzYoSmvaKTZYsm9=bpQsu0jEk2aKm83z-2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/31/2017 3:59 AM, Christian Couder wrote:
> On Thu, May 25, 2017 at 3:55 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>> On 5/24/2017 6:54 AM, Christian Couder wrote:
>>>>
>>>> A new git hook (query-fsmonitor) must exist and be enabled
>>>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>>>> outputs to stdout all files that have been modified since the requested
>>>> time.
>>>
>>> Is there a reason why there is a new hook, instead of a
>>> "core.fsmonitorquery" config option to which you could pass whatever
>>> command line with options?
>>
>> A hook is a simple and well defined way to integrate git with another
>> process.  If there is some fixed set of arguments that need to be passed to
>> a file system monitor (beyond the timestamp stored in the index extension),
>> they can be encoded in the integration script like I've done in the Watchman
>> integration sample hook.
> 
> Yeah, but a hook must also be called everytime git wants to
> communicate with the file system monitor. And we could perhaps get a
> speed up if we could have only one long running process to communicate
> with the file system monitor.
> 

In this particular case a long running background processes isn't 
helpful because refresh_by_fsmonitor() already has logic to ensure the 
file system monitor is only called once per git process.

The overhead of that one call isn't significant as demonstrated by the 
performance numbers I sent out in the cover letter.  Even with the cost 
of the hook and all the associated post-processing, this patch series 
still results in a nice performance win (even on Windows where spawning 
processes is typically more expensive than on other platforms).

I appreciate the close look at this patch series!  Even when I'm pushing 
back, I'm glad someone is asking questions and making sure I've thought 
through things.

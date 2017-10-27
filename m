Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEC620560
	for <e@80x24.org>; Fri, 27 Oct 2017 03:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdJ0Dkg (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 23:40:36 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:53278 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdJ0Dkf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 23:40:35 -0400
Received: by mail-qk0-f195.google.com with SMTP id y23so6863975qkb.10
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hz2Fdlj9Fp1+BWopZliF1Fx6R2bknK9j7blMkmOKHlo=;
        b=spMd1oBNRzY6ksg2mj5o53w75Q/vSd5La4QIypx8JQwLtkpX4YDs6XNmOmuyZjjkR6
         BqJwaHC2bnM0RCiT3PHVjBh0xIqyU26Yofs9ZKPUHk0l1f9H65OOC/Gq3RNNU/ghY0FR
         e7FUehKYc5ojL+srnNOMaIOIPkvm8eOY95kgcL/dRlM+Xn4dp+IZlLA+G54Jzugd5Noc
         CsMaAWhqJ+At2OEufdc9rpiPxQQkoFbci+lCW6KdiM1okzh72Yi6lZXQYN0gFENsZg5E
         AfN4le40bHj05aud9T/2wX6Orz2T2ZpWT2LoghTRna4bmzPC/jbBmTLWzunizsR9mxGB
         kHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hz2Fdlj9Fp1+BWopZliF1Fx6R2bknK9j7blMkmOKHlo=;
        b=r3qP68uyPh/umqPocljwYnLXUsNKTqqnX05uG3RZeSGfZD/96QKMCeqE1XFkRS/Qae
         s17CobUJ4lOjgT5gcGjQ5uZaq9puwgikme6zSTp5rGraSKx+pc/RUf+HSc7/P3gQzgZG
         4NzSvhwAZQqbNgfOJZtexb4tKFd6uR9/OGnBxBmbZLwK8x4bFsX4wY3LLOfhi7GJiDh3
         W30fX0t0co9gX53PPiSbcN6FTRZgurN+nXAUplbKJ+WrtuelopWIYzCbK8q8x7fABR48
         nFWJin7Olu1xDQtg1frDGfzesONP3NLZ0ezjNgrS4nLsjzHP+MARmiWGN9ahM6+xwTSI
         cskA==
X-Gm-Message-State: AMCzsaWBlb1bMBc1O6ddqmjc4AEF5T6ROcFPOn4VZp+F93Z5YZpXJnkq
        GfGciR6JTWd5A0DbQTQD5RU=
X-Google-Smtp-Source: ABhQp+QNtFjPdqbBlZEM6jmnfdh9IvKacSxbtZLDLZIq44suemH0o2Wd0yKH+gqSOfCwSRRJa+cfWA==
X-Received: by 10.55.109.131 with SMTP id i125mr10819830qkc.219.1509075635102;
        Thu, 26 Oct 2017 20:40:35 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t4sm4684572qtj.9.2017.10.26.20.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 20:40:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] fsmonitor: Set the PWD to the top of the working
 tree
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171026013117.30034-1-alexmv@dropbox.com>
 <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
 <5a389621-961d-48e3-339a-ef182d3ed628@gmail.com>
 <alpine.DEB.2.10.1710261425390.9817@alexmv-linux>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <16467d0e-b585-17d7-fb22-3eed7efe6747@gmail.com>
Date:   Thu, 26 Oct 2017 23:40:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710261425390.9817@alexmv-linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/26/2017 5:27 PM, Alex Vandiver wrote:
> On Thu, 26 Oct 2017, Ben Peart wrote:
>> On 10/25/2017 9:31 PM, Alex Vandiver wrote:
>>> diff --git a/fsmonitor.c b/fsmonitor.c
>>> index 7c1540c05..0d26ff34f 100644
>>> --- a/fsmonitor.c
>>> +++ b/fsmonitor.c
>>> @@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t
>>> last_update, struct strbuf *que
>>>    	argv[3] = NULL;
>>>    	cp.argv = argv;
>>>    	cp.use_shell = 1;
>>> +        cp.dir = get_git_work_tree();
>>>    
>>
>> I'm not sure what would trigger this problem but I don't doubt that it is
>> possible.  Better to be safe than sorry. This is a better/faster solution than
>> you're previous patch.  Thank you!
> 
> See my response on the v1 of this series -- I'm curious how you're
> _not_ seeing it, actually.  Can  you not replicate just by running
> `git status` from differing parts of the working tree?
>   - Alex
> 

I saw your response but actually can't replicate it locally.  I've been 
running with Watchman integration on all my repos for months and my 
"watchman watch-list" command only shows the root of the various working 
directories - no subdirectories.

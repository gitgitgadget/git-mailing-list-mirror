Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174A1202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 03:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdJ0DgQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 23:36:16 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43924 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdJ0DgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 23:36:16 -0400
Received: by mail-qt0-f182.google.com with SMTP id j58so6925758qtj.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 20:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oj79Fi/EG/s/V2y6i7Po3UjLkoDICPCGQ8Zn6vVlsBU=;
        b=WZtXhuhTnGvDXP0dDf3UIz1gcGBCvrNi8YVEvRpuwznLHyEhFz382yfUX1Z4r+b/cq
         5YWucX+0LHY5IRqcn9noQw9u1moQOTlak/ZofLiRoWAHsACgKJCYCSFUj+Qd7ewHL+0T
         OMN4IBM2MYXy5pfN1pISUxdSs/+5ib0tAwizLZf/4hL35CpCHmAZoEdR9etTItTEcxzh
         kTqPgmVvuOtf+0dGa+TGnBxp0sfK/Gyi6Y/2TYVeK6uqkfNl+x4foIyqbec8KmmCB4Xm
         peeOhhxgoxGaYuujLFeoFDzGm1KG4In363isUBGDrqohcVz79X+wnbX2+bG0hD2onUeB
         yXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oj79Fi/EG/s/V2y6i7Po3UjLkoDICPCGQ8Zn6vVlsBU=;
        b=bjHL2IzwVPDLcC/JcwmgZsPpa4B4N83rmBhGSdjCupCnNrN6RYMzJtKHpX8rciDmAd
         MICSjnPUwzNxVgpnLjYlC0Cvu9OQ1lTtcGzqAQlO6Vuh9zRmKw5OP9fKOxOWYShh0tXG
         MaLTe/3TPHEGEuQiwnvkHD7z6BE4bod1P8pAk08gFpPBk9vnDUPeAvgqzhe9bfrZda9e
         /E/t2edI+zWczGSrRqxAyfsV9C3k0NmSNezJ2iPmeck/I3S+SsulvHTLCMffq5lDnJ82
         js+Q5OU87oNrYIk9LnjTdi1/lIank8RBJOqquyiQT5ckVIfh51V4WJgFN3zQG6GsaY+D
         X9kg==
X-Gm-Message-State: AMCzsaULwVca4nGpIW3BUPUIt9KMZCefgzywz9HhfRvcYzoH7Rsz9fJt
        Uvsl/NsK1izk9KKIV9UwuAY=
X-Google-Smtp-Source: ABhQp+Sb+GMOnjE19MjyTDhcEPBQxEFsoMlAUtZ3KJMUvnH42uKgj1FGKFj59wDaAR11bo+Sfamvzw==
X-Received: by 10.200.25.78 with SMTP id g14mr38775421qtk.225.1509075375179;
        Thu, 26 Oct 2017 20:36:15 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id a17sm4613363qth.46.2017.10.26.20.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 20:36:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171026013117.30034-1-alexmv@dropbox.com>
 <42fd8bccb78992a2894e711e057230a673891628.1508981451.git.alexmv@dropbox.com>
 <9bd24b15-6232-1afd-abbe-02870c51c7ad@gmail.com>
 <alpine.DEB.2.10.1710261427300.9817@alexmv-linux>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <11f3e539-1a4f-0572-a712-9f1c50359389@gmail.com>
Date:   Thu, 26 Oct 2017 23:36:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710261427300.9817@alexmv-linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/26/2017 5:29 PM, Alex Vandiver wrote:
> On Thu, 26 Oct 2017, Ben Peart wrote:
>> On 10/25/2017 9:31 PM, Alex Vandiver wrote:
>>> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
>>> index a3e30bf54..79f24325c 100755
>>> --- a/t/t7519/fsmonitor-watchman
>>> +++ b/t/t7519/fsmonitor-watchman
>>> @@ -50,7 +50,7 @@ launch_watchman();
>>>      sub launch_watchman {
>>>    -	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
>>> +	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
>>
>> Since this is a test script performance isn't critical.  This version of the
>> integration script logs the response to a file in .git/watchman-response.json
>> and is much more human readable without the "--no-pretty."  As such, I'd leave
>> this one pretty.
> 
> This would be the first delta between the test file and the template
> file.  It seems quite important to me to attempt to ensure that we're
> testing the _same_ contents that we're suggesting users set up.  In
> fact, it makes more sense to me to just turn this into a symlink to the
> sample template.
>   - Alex
> 

If you look closer (actually diff the two files) you will see that the 
test version includes logging that the sample doesn't include.  I found 
the logging very helpful during testing of the feature and debugging 
Watchman issues but don't want end users to pay the performance penalty 
of the logging.

t/t7519/fsmonitor-watchman isn't actually used by any of the automated 
tests as they can't assume Watchman is available. It is just provided as 
a convenience to enable manual testing and debugging.

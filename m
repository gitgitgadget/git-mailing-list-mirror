Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBBF20357
	for <e@80x24.org>; Fri,  7 Jul 2017 19:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbdGGTHe (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 15:07:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33381 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbdGGTHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 15:07:33 -0400
Received: by mail-qt0-f193.google.com with SMTP id c20so5384397qte.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOxYUqHm4Ti6x4/dErtqWh6TD4j3BTvVNn9be3m79Y0=;
        b=RwEnBqjAyGEAwGBmIz9d0+mS2w8GDLCJe5FD4fx2mvmyg0eDxMxE899Lp2/F5AOD+3
         PzEhkgY53CyKNw+HyK27ar/dcc2K3z8K6K0IgQksGqIdMd3vi8oP/1GEJhNB/f/aqYUs
         KfYMlmWKfdIFMeUiymqux4JzIKF9U4XK1U41fKCRLHCI2NFwrHYnRiy9p6TmVJ5e+xaZ
         XYS4vz/R7D91s063OHfNlqy25CdANHxYc/pvsTi4E43eMto4ZrJjD4LvzV7+jnh+OBBV
         PE6zhkaE/fdBdBhrgYT4GVC9zCmAnQwSpPhqkID4w0bRVRtL6HHTBZF4fT6QtJz6pZq9
         NxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOxYUqHm4Ti6x4/dErtqWh6TD4j3BTvVNn9be3m79Y0=;
        b=oga3sgJ1g0PU/gfO+k5xqV/X8M7dGBE17yhVsu/5WTyEMplzQMQ6PbLvpvWmnDlNVH
         eTMw9xkx5jlQBrSWoLXK8Pzw/aGIfqOFsk4GDPL6dxOLKMhNQO92VuqB+iinghp/EPZg
         IOX9qbHgJ6aLgOBh5/KFdMnml6NPeKfQxoqfbI158XoXXSgIhAZkGNelTUTcAkXKVFJI
         RpeHBwg6dQlhunfAnFRzOQaYf4/2lXsWvJVm2YXW7U8dBRUdoHCiiWey0OREzv0thXF2
         6wPx8+YCGCGBAqtSFMGOQVXA92gzATc2FFM8HTZIdcwMc0I3NzGSBi0z6/qn2pp6NMsC
         YXVA==
X-Gm-Message-State: AKS2vOwGo7jNwNR5dH7bJNXpaSgj2WJntCsMpvEaH90l2A3A25mo58ZZ
        tYjyVkxs18Xg1w==
X-Received: by 10.237.47.132 with SMTP id m4mr72815976qtd.200.1499454452707;
        Fri, 07 Jul 2017 12:07:32 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id n67sm3109286qte.41.2017.07.07.12.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 12:07:31 -0700 (PDT)
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170610134026.104552-8-benpeart@microsoft.com>
 <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
 <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com>
 <xmqqvany2z84.fsf@gitster.mtv.corp.google.com>
 <7ec36d90-7fbc-c30f-e15e-f06d39e1f206@gmail.com>
 <xmqqeftsayeg.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <bade1166-e646-b05a-f65b-adb8da8ba0a7@gmail.com>
Date:   Fri, 7 Jul 2017 15:07:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqeftsayeg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/7/2017 2:35 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> On 6/14/2017 2:36 PM, Junio C Hamano wrote:
>>> Ben Peart <peartben@gmail.com> writes:
>>>
>>>>> Having said all that, I think you are using this ONLY on windows;
>>>>> perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
>>>>> the above and arrange Makefile to build test-drop-cache only on that
>>>>> platform, or something?
>>>>
>>>> I didn't find any other examples of Windows only tools.  I'll update
>>>> the #ifdef to properly dump the file system cache on Linux as well and
>>>> only error out on other platforms.
>>>
>>> If this will become Windows-only, then I have no problem with
>>> platform specfic typedef ;-) I have no problem with CamelCase,
>>> either, as that follows the local convention on the platform
>>> (similar to those in compat/* that are only for Windows).
>>>
>>> Having said all that.
>>>
>>> Another approach is to build this helper on all platforms, ...
> 
> ... and having said all that, I think it is perfectly fine to do
> such a clean-up long after the series gets more exposure to wider
> audiences as a follow-up patch.  Let's get the primary part that
> affects people's everyday use of Git right and then worry about the
> test details later.
> 
> A quick show of hands to the list audiences.  How many of you guys
> actually tried this series on 'pu' and checked to see its
> performance (and correctness ;-) characteristics?

TLDR: the current version isn't correct.

One of the things I did was hack up the test script to enable running 
all the tests with fsmonitor enabled.  I found a number of bugs in 
Watchman on Windows and have been working with Wez to get them fixed.

Just last week Watchman got to the point where I could run the complete 
git test suite.  As a result, I found that fsmonitor is overly 
aggressive in marking things with ce_mark_uptodate.  Submodules are 
currently broken as are commands that pass "--ignore-missing."

I started reworking the logic to fix these bugs and realized I was 
duplicating the set of tests that already exist in preload_thread. I'm 
currently working on integrating the logic into preload_thread so that 
both options can be used in combination and so I can avoid doing the 
(nearly identical) loop twice.

> 
> Do you folks like it?  Rather not have such complexity in the core
> part of the system?  A good first step to start adding more
> performance improvements?  No opinion?
> 
> 

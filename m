Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1D81F462
	for <e@80x24.org>; Thu, 30 May 2019 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfE3S33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 14:29:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43339 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3S33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 14:29:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so4534077qka.10
        for <git@vger.kernel.org>; Thu, 30 May 2019 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8FBk/vQwMrbQM9Ji4At58+tDPJjf642kaeYLAyjCJQ=;
        b=r1gEIiTXxTdoKhhTK2kTgXcX8LZUaMXuOcGb72uO9uA/ZbOwVlys2Wujise1fat/Nw
         2aCnFYfIJrrgeR/rerK/AB/79MgQOGCDTwpJquzJREW36G4UpLeSFKV8csdVf9Z+pw+k
         IQ5jy9zRCxcr1oeJVLg7MCrFlqvULNKmz4NT8DwScUPzmy8JzHXJd7+HBMmcLW86dxg+
         6B0DbCyXs0yNY+CfaSNVbiwZSZKd5DKTxb4DknSYx/aT4WZeyrLREMbEyWljo2pc2OKv
         LUdt7hjMraqciORs192x2UH1XrvXvuRw5PNM0pnh1Myh4jG1SsSI+BGMsHijeHDc9kwf
         VpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8FBk/vQwMrbQM9Ji4At58+tDPJjf642kaeYLAyjCJQ=;
        b=D1XqduWyVh48+7NsfsJJGtqpIpm2hSmjBVjU0a0ezzKtssmqjwSF8zexQQi2r+sXiD
         ow7LdYbE7lPMq0w56Muik8fxFPqRM70j6kZ14F/Ond2dcD5rF36NvIebA4lgpO1JNyL7
         2MGDVJSDPmgC4AZoBwauwqjhGq+cFTEunFbw2+Miunvugo6vs6ycp5flKl4KdIDeAKGz
         nZtJitX10bya5i9Fkt8pMxKoxAQqGykUtokLV0mPb6cxDCa3zJAWoJ4njQx8aJAHsCT4
         0y4YUdQF/BUlvfnYRoP4BlBoRSBVzjxDk8lhaZ8b+wdnWXzjNPTDetzZ6QDy0WD7tzkn
         kyLQ==
X-Gm-Message-State: APjAAAWehIIjo3BH6TPWkmArL9YWIbrYp1CtjqzeneCxPHzLHfKpXTKY
        PbaH++OYtQVH3Oi8rS7yzpMoFuvyTIA=
X-Google-Smtp-Source: APXvYqz2TRCs35CnuJ+WB9DDevS6MQJQQVvXASpmYlc8kTiOp5B6ylRJ8rrEgbBOGlwB1J/pOB3Z4g==
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr4641794qke.171.1559240968381;
        Thu, 30 May 2019 11:29:28 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id j62sm1642454qte.89.2019.05.30.11.29.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:29:27 -0700 (PDT)
Subject: Re: What's cooking in git.git (May 2019, #04; Tue, 28)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com>
 <20190528222604.GA14921@sigill.intra.peff.net>
 <xmqqlfypyzfr.fsf@gitster-ct.c.googlers.com>
 <20190530115122.GA31607@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905301659070.44@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1e11ced6-092f-c7e5-479f-ac871bb3acb4@gmail.com>
Date:   Thu, 30 May 2019 14:29:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1905301659070.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/30/2019 11:01 AM, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Thu, 30 May 2019, Jeff King wrote:
> 
>> On Wed, May 29, 2019 at 09:53:44AM -0700, Junio C Hamano wrote:
>>
>>>>> * ds/object-info-for-prefetch-fix (2019-05-28) 1 commit
>>>>>  - sha1-file: split OBJECT_INFO_FOR_PREFETCH
>>>>>
>>>>>  Code cleanup.
>>>>>
>>>>>  Will merge to 'next'.
>>>>
>>>> I think this one is actually a bug-fix (we are refusing to prefetch for
>>>> "QUICK" calls even though was not the intent), and it is new in this
>>>> release.
>>>>
>>>> I'm not sure of the user-visible impacts, though. There are a lot of
>>>> QUICK calls, and I'm not sure for which ones it is important to fetch.
>>>
>>> Hmph.  I took it as primarily futureproofing, as I didn't find a way
>>> to trigger bad behaviour from within the current codebase.
>>
>> Hmm. Looking over the uses of OBJECT_INFO_QUICK, they all seem to be in
>> either index-pack or as part of a fetch operation. And in both of those
>> cases, we'd disable the whole feature anyway with fetch_if_missing.
>>
>> So I _think_ you are right, and there isn't a way to trigger it.
> 
> FWIW that was also my impression, but then, I did not look very closely.
> 
> In an attempt to find regressions (and to fix them) during the -rc phase,
> we rebased VFSforGit's patches on top of current `master`, and saw this
> issue. But yeah, the issue fixed by Stolee's patch seems to be caused by
> the interaction between current `master` and the VFSforGit patches.

Just to complete the circle, I found this *possible bug* while investigating
test failures with VFS for Git, but it turns out it was related to a
behavior change in the multi-pack-index and the test we were running only
worked by accident before as it was testing a scenario that never occurs
in practice.

The fix required a change to our VFS for Git test. See [1] for full details
if you are interested.

So I agree, this is not a priority to ship in 2.22.0.

Thanks,
-Stolee

[1] https://github.com/microsoft/VFSForGit/pull/1213
 


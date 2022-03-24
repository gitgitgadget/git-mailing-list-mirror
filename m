Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EDAC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 20:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353604AbiCXUoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353597AbiCXUoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 16:44:20 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA8EB0A77
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:42:47 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 41E603F49D5;
        Thu, 24 Mar 2022 16:42:47 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DA3BC3F49E5;
        Thu, 24 Mar 2022 16:42:46 -0400 (EDT)
Subject: Re: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
To:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        'Jeff Hostetler via GitGitGadget' <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, 'Bagas Sanjaya' <bagasdotme@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Eric Sunshine' <sunshine@sunshineco.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Tao Klerks' <tao@klerks.biz>,
        'Jeff Hostetler' <jeffhost@microsoft.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
 <c8709da9457eb303132b5cad6a204a1de27aabc0.1648140586.git.gitgitgadget@gmail.com>
 <xmqqils3gort.fsf@gitster.g> <075d01d83fb2$1506ded0$3f149c70$@nexbridge.com>
 <0deea44e-b919-81cb-d8bf-ebea4c9ba426@jeffhostetler.com>
 <076101d83fbe$e6ce5e50$b46b1af0$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cd5dd46d-fc47-1af8-6ba7-ddf1617a7b2b@jeffhostetler.com>
Date:   Thu, 24 Mar 2022 16:42:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <076101d83fbe$e6ce5e50$b46b1af0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/24/22 4:36 PM, rsbecker@nexbridge.com wrote:
> On March 24, 2022 4:28 PM, Jeff Hostetler wrote:
>> On 3/24/22 3:05 PM, rsbecker@nexbridge.com wrote:
>>> On March 24, 2022 3:00 PM, Junio C Hamano wrote:
>>>> Subject: Re: [PATCH v8 21/30] t7527: create test for
>>>> fsmonitor--daemon
>>>>
>>>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>
>>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]
>>>
>>> May I request a bit of extra time on the -rc0 to -rc1 cycle for this? I have a feeling
>> that while testing this is probably going to go well, I would like to have a bit of
>> extra time for anything that might come up. There are a lot of moving parts to this
>> series. Not being critical, but debugging scripts on my platforms can be a bit rough
>> at times.
>>>
>>> Thanks,
>>> Randall
>>>
>>
>> I'll simplify the `start_daemon()` function as Junio suggests, so hopefully that'll
>> reduce the amount of debugging that you need.
> Thanks.
> 
>> BTW, which platforms are you worried about?
> I'm worried about NonStop ia64 and x86. It's not just this series but also the fsync series. I think it's going to be a bit of a rid this time, but hoping not.
> --Randall
> 

I currently only have drivers/backends for Windows and MacOS for the
builtin FSMonitor daemon feature.  Since it relies on platform-specific
code to read whatever filesystem journal or event stream that the
the platform provides.

So t7527 should do a skip_all on NonStop IIUC.

Jeff

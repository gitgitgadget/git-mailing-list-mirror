Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7903C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8021F64E60
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhBZUV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:21:26 -0500
Received: from siwi.pair.com ([209.68.5.199]:17110 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhBZUTL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 15:19:11 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 60BC83F40DA;
        Fri, 26 Feb 2021 15:18:27 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1E4A53F40B7;
        Fri, 26 Feb 2021 15:18:27 -0500 (EST)
Subject: Re: [PATCH v4 00/12] Simple IPC Mechanism
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <xmqq8s7cuebo.fsf@gitster.g> <YDiqeaNX/BeROFGf@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ff2eb93c-9b96-6fec-961b-adbe0fbda6fb@jeffhostetler.com>
Date:   Fri, 26 Feb 2021 15:18:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YDiqeaNX/BeROFGf@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/26/21 2:59 AM, Jeff King wrote:
> On Thu, Feb 25, 2021 at 11:39:39AM -0800, Junio C Hamano wrote:
> 
>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> Here is V4 of my "Simple IPC" series. It addresses Gábor's comment WRT
>>> shutting down the server to make unit tests more predictable on CI servers.
>>> (https://lore.kernel.org/git/20210213093052.GJ1015009@szeder.dev)
>>>
>>> Jeff
>>>
>>> cc: Ævar Arnfjörð Bjarmason avarab@gmail.com cc: Jeff Hostetler
>>> git@jeffhostetler.com cc: Jeff King peff@peff.net cc: Chris Torek
>>> chris.torek@gmail.com
>>
>> It seems that the discussions around the topic has mostly done
>> during the v2 review, and has quieted down since then.
>>
>> Let's merge it down to 'next'?
> 
> Sorry, I hadn't gotten around to looking at the latest version. I left
> another round of comments. Some of them are arguably bikeshedding, but
> there's at least one I think we'd want to address (the big stack buffer
> in patch 1).
> 
> I also haven't carefully looked at the simple-ipc design at all; my
> focus has just been on the details of socket and pktline code being
> touched. Since there are no simple-ipc users yet, and since it's
> internal and would be easy to change later, I'm mostly content for Jeff
> to proceed as he sees fit and iterate on it as necessary.
> 
> -Peff
> 

We can wait until next week on moving this 'next' if you want.
I'll attend to the buffer alloc in patch 1.  I'm still reading the
other comments and will see where that takes me.

I'm about ready to push an RFC for my fsmonitor--daemon series that
sits on top of this simple-ipc series, so you can see an actual use
case if that would help understand (my madness).

Thanks
Jeff


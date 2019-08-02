Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C161F731
	for <e@80x24.org>; Fri,  2 Aug 2019 20:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436897AbfHBUNS (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 16:13:18 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:48301 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406942AbfHBUNR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 16:13:17 -0400
X-Originating-IP: 1.186.12.38
Received: from localhost.localdomain (unknown [1.186.12.38])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4473DFF80A;
        Fri,  2 Aug 2019 20:13:13 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
 <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet>
 <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
 <xmqqftmjldjx.fsf@gitster-ct.c.googlers.com>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <a143dcfd-8067-34f7-97f3-c4482dca5819@yadavpratyush.com>
Date:   Sat, 3 Aug 2019 01:43:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqftmjldjx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/19 10:17 PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
>> +Junio
> 
> I do not have a strong opinion on this one---a Meh by default means
> a moderately strong preference for status-quo.
> 
>> All right, the patch in its current state can't fly. So what is the
>> correct way to do this? I see the following options:
>>
>> 1. Add this as an option that is disabled by default, but people who
>> don't mind it can enable it. This is the easiest to implement. But I
>> leave it to you and Junio (and anyone else who wants to pitch in :))
>> to decide if it is a good idea.
> 
> I think this is a good first step.  As I said already, I am not
> convinced that "focus in" is a good heuristics for triggering auto
> rescan, and I suspect that you or others may come up with and
> replace it with a better heuristic over time.  During that
> experiment, it would be better to allow interested others to opt
> into the feature to help, while not disturbing ordinary users who
> are OK with the current behaviour.
> 

All right. I'll look a bit more to see if I can figure something better. 
I suggested using filesystem watches. I'll wait a bit to hear from 
Johannes on what he thinks about it. He doesn't like the idea of using 
Watchman apparently.

Otherwise, I'll send in an updated patch with this feature as opt-in.

-- 
Regards,
Pratyush Yadav

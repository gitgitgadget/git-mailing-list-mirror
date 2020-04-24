Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B53C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32BD20724
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDXRcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:32:07 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:53518 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgDXRcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:32:06 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jS2BJ-0007Un-A3; Fri, 24 Apr 2020 18:32:05 +0100
Subject: Re: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
To:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1587559135.git.congdanhqx@gmail.com>
 <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
 <xmqqk127jvrh.fsf@gitster.c.googlers.com> <20200423011812.GA1930@danh.dev>
 <xmqqmu72gfxu.fsf@gitster.c.googlers.com>
 <1861c472-7756-d433-9185-d83c03d72b9b@iee.email>
 <20200424000707.GB1949@danh.dev> <xmqqh7x9emn7.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <2db49b07-8244-269a-368b-63f6890e31d5@iee.email>
Date:   Fri, 24 Apr 2020 18:32:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7x9emn7.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio is correct.
On 24/04/2020 01:46, Junio C Hamano wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
>
>> On 2020-04-23 21:41:49+0100, Philip Oakley <philipoakley@iee.email> wrote:
>>> On 23/04/2020 20:28, Junio C Hamano wrote:
>>>> Danh Doan <congdanhqx@gmail.com> writes:
>>> Would is_hhmmss() and is_yyyymmdd() be more obvious abbreviations for
>>> most readers?
>>>
>>> Now that I type them, they do feel that bit too long... , as naming is
>>> hard, maybe stick with the yms and hms, though I do keep wanting to type
>>> ytd for the former..
>> Not sure if I interpret your opinion correctly,
>> Did you mean s/yms/ymd/ and s/ytd/ymd/?
>>
>> Even that, I couldn't grasp the meaning of the last phase?
> Here is how I understood it.
>
> Philip thinks, and I admit I have to agree with, that HMS would not
> be understood as hour-minute-seconds by most people, and YMD would
> not be as yearh-month-day, either.
>
> His "yms" in "stick with the yms and hms" is a typo of "ymd".  He is
> saying that even though YYMMDD and HHMMSS would look a lot more
> natural, it is too long to type so YMD and HMS may not be so
> terrible a compromise.
>
> With the "ytd" in the last one, he is saying that another downside
> of saying "ymd" (other than that it is not how we usually spell
> year-month-date), even though "ymd" might be an acceptable
> compromise, is that it is too easy to get confused with year-to-date
> that is commonly abbreviated as "YTD".
True.
--
Philip

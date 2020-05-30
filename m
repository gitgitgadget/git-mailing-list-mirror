Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7B9C433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B852F2077D
	for <git@archiver.kernel.org>; Sat, 30 May 2020 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgE3QSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 12:18:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:53638 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgE3QSW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 12:18:22 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jf4Bg-0003gW-3k; Sat, 30 May 2020 17:18:20 +0100
Subject: Re: [PATCH 0/4] Selectively show only blamed limes
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
References: <20200525215751.1735-1-philipoakley@iee.email>
 <20200527072318.GA4006199@coredump.intra.peff.net>
 <0da84168-3d81-fb14-32ad-010ef2436958@iee.email>
 <20200528164533.GA1223132@coredump.intra.peff.net>
 <xmqq4krz52vb.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <58ce3749-d3ef-a9fe-be94-d5373cf70f15@iee.email>
Date:   Sat, 30 May 2020 17:18:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <xmqq4krz52vb.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/05/2020 19:30, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, May 27, 2020 at 11:24:54AM +0100, Philip Oakley wrote:
>>
>>>> I'm not convinced this is a useful thing to do in general. Lines don't
>>>> always stand on their own, and you'd lack context for deciphering them.
>>>> So a real example from "git blame -b --since=1.year.ago Makefile", for
>>>> example (pardon the long lines):
>>> My contention is that there is a lot of effort needed _beforehand_ to
>>> reach that point. We've already had to page down 2700 line to get there,
>>> and then had to carefully select the differing before and after context
>>> lines.
>> I think:
>>
>>   git blame -b --since=1.year.ago ... | less "+/^[^ ]"
>>
>> works pretty well to get you to the right spot, with context (and then
>> "/<enter>" within less takes you to the next line).
> Yup.  I think this is mostly about knowing how to use the tools that
> already exist.  I am not interested in this new "feature", either.
>
> Thanks.
Is the presumption of knowing the *nix tools something that should
documented, or is that an over simplification?

I'll trim this series to just the '^' documentation change and the '-b'
option test (after v2.27.0)

Philip

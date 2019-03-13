Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD4D20248
	for <e@80x24.org>; Wed, 13 Mar 2019 07:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCMHBr (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 03:01:47 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:13108 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfCMHBq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 03:01:46 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44K2nh1Khvz5tlR;
        Wed, 13 Mar 2019 08:01:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C06AE207F;
        Wed, 13 Mar 2019 08:01:42 +0100 (CET)
Subject: Re: Deprecating git diff ..; dealing with other ranges
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190311093751.GA31092@archbookpro.localdomain>
 <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com> <87va0orop4.fsf@igel.home>
 <87wol3bydp.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <07998a4f-b5a7-dc27-efdc-d12f99a8306f@kdbg.org>
Date:   Wed, 13 Mar 2019 08:01:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87wol3bydp.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.03.19 um 22:01 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Tue, Mar 12 2019, Andreas Schwab wrote:
> 
>> On Mär 12 2019, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> I however think it may be worth making sure that our docs do not
>>> encourage "diff A..B" and teach "diff A B" when comparing two
>>> endpoints.  That can be done without changing anything in the code.
>>
>> The nice thing about "diff A..B" is that you can c&p the output from the
>> fetch run without the need to edit it.
> 
> Not to shoot down this effort, just to add another similar thing I do
> regularly for ff-branches:
> 
>  1. Copy/paste A..B fetch output
>  2. git log A..B
>  3. ^log^diff
> 
> I.e. I just need to tell my terminal to re-run the same "log" command
> with "diff" instead of "log".
> 
> Of course as covered in the linked thread it doesn't work for some
> (non-ff) cases, and I'll sometimes end up cursing it and swapping around
> ".." for "..." with log/diff.

Still, your and Andreas's use-case is reason enough *not* to deprecate
diff A..B, IMO.

We wouldn't be able to remove .. wholesale anyway because diff A.. and
diff ..B, where the missing endpoints are filled in with HEAD would have
to live on.

-- Hannes

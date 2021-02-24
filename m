Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF4C43381
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B4E64F0A
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhBXRN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:13:59 -0500
Received: from [93.83.142.38] ([93.83.142.38]:58542 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S235838AbhBXRNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 12:13:55 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 414082A9D8;
        Wed, 24 Feb 2021 18:13:31 +0100 (CET)
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-10-avarab@gmail.com>
 <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
 <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
 <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
 <87h7mba3h3.fsf@evledraar.gmail.com> <xmqqk0r6ldrn.fsf@gitster.g>
 <877dmz7wtv.fsf@evledraar.gmail.com>
 <1c5f8cb8-2d99-4279-ba61-4f7720ece277@kdbg.org>
 <87y2fd7m90.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b8c26fac-85e7-8565-7469-6b3fe965a570@kdbg.org>
Date:   Wed, 24 Feb 2021 18:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87y2fd7m90.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 12:12 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Tue, Feb 23 2021, Johannes Sixt wrote:
>> I could live with a version of Junio's suggestion that is not opt-in,
>> i.e., the checks are mandatory and exact. The important point is that
>> there is only one file per test case; that would still count as
>> "sufficiently simple" in my book.
> 
> So something where the tests in 14-15,17,19/27 would need to go back to
> having the config that's part of the test driven by setup in
> t/t4018-diff-funcname.sh,

I'm afraid, I don't understand what you mean by this sentence. Do you
mean "not do the refactoring like in those patches"? Yes, that would
likely be unnecessary churn.

> and the contents of a test file being e.g. (to
> take the test from 25/27):
> 
>     # HEADER |package main|
>     package main
> 
>     import "fmt"
>     // ChangeMe
> 
> ?
> 

Yes. Except that I would move the "expected text" part to the end of the
file so that there is no danger that it is mistaken as a hunk header (in
case that a pattern is so loose that it matches that line).

-- Hannes

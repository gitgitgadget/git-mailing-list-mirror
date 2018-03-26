Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CEED1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeCZSWl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:22:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:13504 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752146AbeCZSWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:22:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id ACF8C3F4085;
        Mon, 26 Mar 2018 14:22:40 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 61EDE3F4025;
        Mon, 26 Mar 2018 14:22:40 -0400 (EDT)
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1521779249.git.wink@saville.com>
 <cover.1521839546.git.wink@saville.com>
 <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
 <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
 <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
 <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
 <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
 <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
 <xmqqh8p2d8jh.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d56a60a8-e735-b147-a2e6-4e48461ad701@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 14:22:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8p2d8jh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 1:57 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> I defined that routine to take a uint64_t because I wanted to
>> pass a nanosecond value received from getnanotime() and that's
>> what it returns.
> 
> Hmph, but the target format does not have different representation
> of inttypes in different sizes, no?
> 
> I personally doubt that we would benefit from having a group of
> functions (i.e. format_int{8,16,32,64}_to_json()) that callers have
> to choose from, depending on the exact size of the integer they want
> to serialize.  The de-serializing side would be the same story.
> 
> Even if the variable a potential caller of the formetter is a sized
> type that is different from uintmax_t, the caller shouldn't have to
> add an extra cast.
> 
> Am I missing some obvious merit for having these separate functions
> for explicit sizes?
> 

I did the uint64_t for the unsigned ns times.

I did the other one for the usual signed ints.

I could convert them both to a single signed 64 bit typed function
if we only want to have one function.

Jeff


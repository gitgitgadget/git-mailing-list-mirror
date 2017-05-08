Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698581FC44
	for <e@80x24.org>; Mon,  8 May 2017 18:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdEHSA5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 14:00:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:55047 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdEHSA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 14:00:56 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BB081844B5;
        Mon,  8 May 2017 14:00:54 -0400 (EDT)
Subject: Re: [RFC 00/14] convert dir.c to take an index parameter
To:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170505195334.121856-1-bmwill@google.com>
 <xmqqmvaq702u.fsf@gitster.mtv.corp.google.com>
 <20170508171255.GE179149@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bf76dd64-0d4b-cadd-cf34-ec50e9d6e351@jeffhostetler.com>
Date:   Mon, 8 May 2017 14:00:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170508171255.GE179149@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/8/2017 1:12 PM, Brandon Williams wrote:
> On 05/06, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>>
>>> One of the things brought up on the list in the past few days has been
>>> migrating away from using the index compatibility macros.  One of the issues
>>> brought up in that thread was how simply doing that conversion doesn't
>>> eliminate the reliance on global state (specifically the_index).  If one day we
>>> want to have a 'repository object' passed around then we first need to convert
>>> different subsystems to be prepared to handle that.  This series provides a
>>> first step, converting the code in dir.c to take a 'struct index_state' and
>>> using that instead of implicitly using 'the_index'.
>>
>> Very nicely done (I only skimmed "dir.c" in the end result and didn't
>> go through the changes with fine toothed comb, though).
>>
>> I would have done this without the first step and then instead had a
>> final patch that only inserts a single
>>
>>     #define NO_THE_INDEX_COMPATIBILITY_MACROS
>>
>> at the beginning of dir.c once everybody in dir.c loses the
>> reference to all "cache" macros at the end, if I were doing this
>> series, but it is a personal taste.
>>
>> The resulting dir.c does not even refer to the_index, which is very
>> nice.
>
> Thanks! I'm glad there's a few people who see this as a positive change.

Agreed.  This looks like a nice start.
Jeff


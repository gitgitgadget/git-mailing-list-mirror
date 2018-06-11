Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A401F403
	for <e@80x24.org>; Mon, 11 Jun 2018 12:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932935AbeFKMQq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 08:16:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:52676 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbeFKMQp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 08:16:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2555B3F40DB;
        Mon, 11 Jun 2018 08:16:45 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E21663F40D5;
        Mon, 11 Jun 2018 08:16:44 -0400 (EDT)
Subject: Re: [PATCH v8 2/2] json-writer: t0019: add perl unit test
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-3-git@jeffhostetler.com>
 <CAPig+cS8MjQNKabrQwuWzO4DDYJcfP_81n9H37efgXOiRzv9TQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9aeac3a6-ea04-a43e-3851-1083792dfb5d@jeffhostetler.com>
Date:   Mon, 11 Jun 2018 08:16:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cS8MjQNKabrQwuWzO4DDYJcfP_81n9H37efgXOiRzv9TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/7/2018 1:13 PM, Eric Sunshine wrote:
> On Thu, Jun 7, 2018 at 10:12 AM,  <git@jeffhostetler.com> wrote:
>> Test json-writer output using perl script.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>> diff --git a/t/t0019/parse_json.perl b/t/t0019/parse_json.perl
>> @@ -0,0 +1,52 @@
>> +#!/usr/bin/perl
>> +use strict;
>> +use warnings;
>> +use JSON;
> 
> This new script is going to have to be protected by a prerequisite
> since the JSON module is not part of the standard Perl installation,
> thus will not necessarily be installed everywhere (it isn't on any of
> my machines, for instance). Something like:
> 
>      test_lazy_prereq PERLJSON '
>          perl -MJSON -e "exit 0"
>      '
> 
> which would be used like this:
> 
>      test_expect_success PERLJSON 'parse JSON using Perl' '
>          ...
>      '
> 

will do.  thanks!
Jeff

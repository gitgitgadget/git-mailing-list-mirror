Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7281F462
	for <e@80x24.org>; Sat,  1 Jun 2019 10:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfFAKa4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 06:30:56 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:53904 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfFAKa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 06:30:56 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id X0OJhlUVzdraxX0OJhIv7j; Sat, 01 Jun 2019 10:33:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1559381612;
        bh=adKbcNeASs7pZYpOXe4eR1mKXPN1eERoVlT1Sl/97EE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ETaLW9qzneTrjjfpBGTHXRToR9qMZnAeYEVm9Rma8hZo9mvNJyb3u9tFdI55yzI1A
         NySC79yAhk8rITAigsELmk4kVu8bEnbxe1bh1PGzhcjxQYXAOK5EvXEY/SGzo93X28
         veXqUx7hNrZli346ORjESBi8clcIWAi2xOhOVXqc=
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=DJtvU433w79QAxWKeHEA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] make slash-rules more readable
To:     Junio C Hamano <gitster@pobox.com>,
        "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
References: <20190531074426.6810-1-admin@in-ici.net>
 <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <979f6497-5e26-4a93-c345-f61b31c736c6@talktalk.net>
Date:   Sat, 1 Jun 2019 10:33:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDtXIxNnn13wnboSjB1+dIk7RVEkxY5r67nXYxk+Vq4/Yb+VCrmIErYmRGRKW027Qt+lqoxNp83mL+cmLrcNvviwT6QLc+aPwbXj/TYJewWIKDjGjahG
 SnbhF8r4fGU9vKVpHDxLdlG8VWaFWOSSq7f/u/Nx1T8ee0o6jI22QxMxSDHvVXZ5lEa9J7tTKOotS6c8AakOEfrraRf6qb/2fT4RVhFTlQd3Vb/xinfsTn++
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
On 31/05/2019 17:30, Junio C Hamano wrote:
> I think the updated text is readable, except for one nit.
>
> Specifically, if you took my suggestion in an earlier review to
> explicitly say that leading slash is merely a workaround for a
> string without slash to anchor the pattern to the directory and
> it should be treated as if it does not exist otherwise, then ...
 From a user perspective, implementation issues shouldn't be part of the 
description unless absolutely essential.

Most user aren't aware of the implementation so don't grok/understand 
what the fuss is about and ignore it...
>> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
>> +   in any `.gitignore` file. Both pattern contain a non-trailing
>> +   slash and thus match relative to the location of the
>> +   `.gitignore` file.
> ... this paragraph wouldn't have been necessary.
...leading to that user mistake having to be explained in numerous Q&A 
threads - Why can't we an explicit explanation of this common user 
mistake? Arguably the issue is the special trailing slash rule getting 
users confused..

--
Philip

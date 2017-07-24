Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B971F89D
	for <e@80x24.org>; Mon, 24 Jul 2017 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbdGXJwJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 05:52:09 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:5874 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdGXJwH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 05:52:07 -0400
Received: from [192.168.2.201] ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id Za1ydCnFHQ527Za20dZ6nK; Mon, 24 Jul 2017 10:52:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1500889925; bh=9RyWvHWaUu8XXkf02Sd+XR+6YDMX5u3Ah54tRistttw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L98VaVplm5DDgrG6Sgv5iE4wysUZSJR41wKFv7j96iZmMZkyDx8/PLBQFZo/zoFd8
         DEbOff+TY9TYzTnX0jniu9C5v82r2UEr4+GBOrI4FiIzt5uinfuoHQpBatWPKvlSkN
         ZdBHKMgTZBCrMeWPgUxvQTdqhA7QjjyQ9sxBSOz4=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=ZFtLV_ceKORR_y8P5J8A:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH/RFC] rebase: make resolve message clearer for
 inexperienced users
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        William Duclot <william.duclot@gmail.com>
Cc:     git@vger.kernel.org
References: <20170709202520.21739-1-william.duclot@gmail.com>
 <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com> <20170710183101.GA13122@Haydn>
 <xmqq4luh1gzw.fsf@gitster.mtv.corp.google.com>
 <7E67FF115BB146A49D486E77404882F2@PhilipOakley>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <fd665e9d-e46a-c9f1-f4ec-3407dd18ab36@talktalk.net>
Date:   Mon, 24 Jul 2017 10:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <7E67FF115BB146A49D486E77404882F2@PhilipOakley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJO+q4kN9fjzE4VdbDmRzgu7z40Xj7xmadJiLVRZ0hiJrG9qaQB0kPIZZYaT6aUBT/T5UOY8IxeQsTytcE3O4OnUX+WUEa9fzopohW9mNqfdjX1Ooz0K
 x5oq8n5O9O19hqK9GQk1KJtUqyp/E7bsL8JsoE7ug9c1s5ByEIiCsJZpM8XTGaj5zirUHv8SAHHGKcVzpgVRayPd+aCnxY7GLlvRf2YD47oaaCbtuwazid+Z
 LS6y/KkOIg6hJ7+pbQy0yMlG3p1L1WWersUflBOrzA8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/07/17 12:39, Philip Oakley wrote:
> 
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Wednesday, July 12, 2017 10:29 PM
>> William Duclot <william.duclot@gmail.com> writes:
>>
>>>>  - The original said "When you have resolved this problem", without
>>>>    giving a guidance how to resolve, and without saying what the
>>>>    problem is.  The updated one says "conflict" to clarify the
>>>>    "problem", and suggests "git add" as the tool to use after a
>>>>    manual resolition.
>>>>
>>>>    Modulo that there are cases where "git rm" is the right tool, the
>>>>    updated one is strict improvement.
>>>
>>> I also wrote "<conflicted_file>" when there could be several. Maybe
>>> 'mark it as resolved with "git add/rm"' would be a better (and shorter)
>>> formulation?
>>
>> Another potential source of confusion is if we are seeing "a"
>> conflict, or multiple ones.  I'd say it is OK to treat the whole
>> thing as "a conflict" that Git needs help with by the user editing
>> multiple files and using multiple "git add" or "git rm".  So "mark
>> it as resolved with 'git add/rm'" is fine, I would think, but
>> anything that I say about UI's understandability to new people needs
>> to be taken with a large grain of salt ;-).
>>
>>> ... I feel like a lot of git messages could be improved this way
>>> to offer a UI more welcoming to inexperienced user (which is a
>>> *broad* segment of users). But I am not aware of the cost of
>>> translation of this kind of patch: would several patches like this
>>> one be welcomed?
>>
>> Surely, as long as I can depend on other reviewers who are more
>> passionate about end-user experience than I am, I'll take such
>> patches with their help.
>>
>> Thanks.
> 
> One of the other confusions I had / have (and I have a saved note to
> remind me) is when rebase stops with a conflict, and asks the user to
> "fix" it, then ues "--continue".
> 
> I always expect that Git will do the 'add' of the resolved conflict
> because that is what it would do normally as the next step after the merge.
> 
> I also had a similar issue with the --allow-empty case of 'nothing added
> to commit but untracked files present' where I had been expecting the
> commit to be simply omitted. You have to go through a reset dance before
> continuing.
> 
> Philip
> [I'll be off line till Friday]

git rebase --continue requiring one to git add first confuses/annoys me
too. I started a patch to autostage unstaged changes if they don't
contain conflict markers a couple of weeks ago, I'll clean it up and
post it later this week.

I also find it confusing that it asks me to edit the commit message for
picks, fixups and non-final squashes after conflicts. I can see that
perhaps one might want to amend the message to reflect any changes that
were made while resolving the conflicts but I've never had too. I'd
rather be able to pass --edit to rebase --continue if I needed to edit
the message in those cases. Looking through the code I think it would
require saving some extra state when rebase bails out on conflicts so
rebase --continue could tell if it should be asking the user to amend
the message.

Best Wishes

Phillip

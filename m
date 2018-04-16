Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916681F424
	for <e@80x24.org>; Mon, 16 Apr 2018 10:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeDPKCB (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 06:02:01 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:14374 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbeDPKCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 06:02:00 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 80xSfMiBeHCow80xTf8ENt; Mon, 16 Apr 2018 11:01:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523872919;
        bh=yiPsgGmZrRmPBKJFlVq+2P7KjexjKYqSIXmU3tT6OyQ=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M+OJfFsYQxBOWwdyu0naf9GemkL8Ta7GNtj/GHp3uA4/NI2sJ0kLuqKrkLER3OVjo
         afhYuGlyIipMpUBkPr8o36xUWZMb9jfJJE9JqiGapuOu6cHP9+3dDmUkFism/dAD3h
         iueIHk/js2zd5ZZh8qd1zoRyW7Gj4rhQygz7wFvA=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=SfXZiMZu c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=BuKuawrqAAAA:8
 a=IgnnhOHb_npwXpxIK0wA:9 a=QEXdDO2ut3YA:10 a=eKlGAUe3kD_U_C7IkE-G:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Regression in patch add?
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        mqudsi@neosmart.net
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
 <CAN0heSqCZWR1OD4k+-_OBdtCjCNW-UexLo4P-C5XyBqfU6KBEA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <aa2599d6-6349-0c98-6a31-f68c8b8bf0f8@talktalk.net>
Date:   Mon, 16 Apr 2018 11:01:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqCZWR1OD4k+-_OBdtCjCNW-UexLo4P-C5XyBqfU6KBEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP5p5gRoLvgGTXNq/n1MsHg6Ez85OC7RK/mpAYmnaXvdtafIj2mxX9s+SWRtrS31gJRMPdH1Bvt0k53m+BIOir+gRTdQ6C9Dqq8mFluq9l1N7O3JZgbR
 7hvXgQJhofGcAykSN2mRLzvfnAhLJX4B6rxjKWDrRQKub3b0a1WRKaghUc5H3H+fxxjNYmsA+f81Wux5qg/Qec9mo5sz/nsZ5Dfo+0bCnpUBWmHHm24LeV4m
 u1uSdnFQ+hSkDfoa0RvcHVewpRvoNyTxIvFoz2PF5HEs0imkWUo/5EXmCY2mMSun
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/04/18 14:59, Martin Ågren wrote:
> Hi Mahmoud
> 
> On 15 April 2018 at 14:21,  <mqudsi@neosmart.net> wrote:
>> I first run `git add -p`, then manually edit a chunk (after hitting `s`
>> once, if it matters). The chunk originally contains the following:
> 
> [...]
> 
>> Under git 2.7.4, I can edit it to the following, which is accepted
>> without a problem:
>>
>> ```diff
>> # Manual hunk edit mode -- see bottom for a quick guide
>> @@ -20,7 +20,7 @@
>>         "call dein#add('Shougo/dein.vim', {'rev': 'master'})
>>
>>         " Add or remove your plugins here:
>> -       " call dein#add('flazz/vim-colorschemes')
>> -       call dein#add('Haron-Prime/evening_vim')
>> +       call dein#add('flazz/vim-colorschemes')
>> +       call dein#add('Haron-Prime/evening_vim')
>>
>>         "core plugins that change the behavior of vim and how we use it globally
>> ```
>>
>> All I did here was remove one `+` line and manually add another (which
>> is a variant of the second `-` line).
> 
> So the line is identical (sans s/^-/+/). Interesting.
> 
>> Under git 2.17.0.252.gfe0a9ea, the same piece is opened in $VISUAL for
>> editing (and if left unmodified applies OK), but when modified in the
>> to the same exact value, after exiting the editor I receive the
>> following error from git:
>>
>>     error: patch fragment without header at line 15: @@ -25,7 +25,8 @@
> 
> I can't seem to reproduce this with some very simple testing. Are you
> able to share your files? Or even better, derive a minimal reproduction
> recipe?
> 
> What happens if you do not do a "remove this line, then add it again",
> but instead turn that unchanged line into context? That is, you edit the
> hunk into something like this (but without white-space damage):
> 
> ...
> -       " call dein#add('flazz/vim-colorschemes')
> +       call dein#add('flazz/vim-colorschemes')
>         call dein#add('Haron-Prime/evening_vim')
> ...

That's a good idea to try

> Adding Phillip to cc, since he was recently working in this area

Thanks for cc-ing me

> and might have an idea.

I wish I did!

Best Wishes

Phillip
> 
> Martin
> 


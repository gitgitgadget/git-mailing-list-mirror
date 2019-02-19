Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AD61F453
	for <e@80x24.org>; Tue, 19 Feb 2019 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBSJ73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 04:59:29 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:21210 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfBSJ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 04:59:29 -0500
Received: from [192.168.2.240] ([92.22.15.194])
        by smtp.talktalk.net with SMTP
        id w2BRgTnKC2CiLw2BRg9DeM; Tue, 19 Feb 2019 09:59:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550570366;
        bh=NBErZhz3ArSIH00vbUSAa6GFuygeaKxaZAV4ay5EA5A=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VlzA/zOseso/4/U7YcLoKffQI5a9Ex+6VzO53Yn8nqIvkm7MloHfuNKMrgsX/nZQN
         LFosfZmM4dYe7LoZzDMiE9b060vPPAyzdBHzu8Yy9HKRuhlvIF2wD/78czREpyvBB2
         XNdLbfc7pBflEOYZ11gjaaaLPJr3yiqzswoCpNII=
X-Originating-IP: [92.22.15.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0 a=SbQTfhO/oL0pg4h8lvBCaA==:117
 a=SbQTfhO/oL0pg4h8lvBCaA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=pGLkceISAAAA:8 a=7cJx0I7WwtomyTNB2RAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase --continue after solving conflicts doesn't work
 anymore
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Sebasti=c3=a1n_Mancilla?= <smancill.m@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
 <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
 <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <317468c6-40cc-9f26-8ee3-3392c3908efb@talktalk.net>
Date:   Tue, 19 Feb 2019 09:59:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOMCTj3t7iVrOyb+m6y7xtejL2OFbDseWOJkmLUYtIC7yKZgjx063aCBzsuYEm0zT1jA27VkS3O3nVtn45O6O3r/ElV8c1bkh0sgG03waCY1d2XQoQqa
 ScSMxCGf76gLVzgrpswoNdsIN9RUETmmvXW31GuAAGkun/PWEdXlJxJxQ5pFftu4BxO4RWYimDj/QpFb7wjwHRLcQGrqJAJCIQWQkbyd7gMaY2oAAlTTfaxs
 woY/5ajfmbBTSssCFbTfTOSQn+nul/b0aPr1s+Jq7zcd2mUGnvKYQOo+OWWWfmxn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Sebastián

On 19/02/2019 07:22, Eric Sunshine wrote:
> [cc:+phillip.wood@talktalk.net]

Thanks Eric

> On Tue, Feb 19, 2019 at 1:45 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Tue, Feb 19, 2019 at 5:20 AM Sebastián Mancilla <smancill.m@gmail.com> wrote:
>>> But since Git 2.20.x it doesn't work anymore. Now after solving the conflicts
>>> and running "git rebase --continue" I get this error most of the time:
>>>
>>>      error: unable to dequote value of 'GIT_AUTHOR_DATE'
>>
>> It looks like this can happen only when an "author-script" file (most
>> likely .git/rebase-merge/author-script)

or it could be .git/rebase-apply/author-script depending on the options 
passed to rebase when it started (the sequencer and am use the same code 
for reading the author script now)

>> is read by the sequencer
>> mechanism. Could you show us the content of this file on your machine?
> 
> A very good suggestion considering that there have been changes
> recently specifically related to the parsing of GIT_AUTHOR_DATE in C
> code.

That would be very helpful, without seeing that it's hard to know what 
the problem is.

Best Wishes

Phillip


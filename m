Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B111F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 11:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeJLSlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 14:41:50 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:59130 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJLSlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 14:41:50 -0400
Received: from [192.168.2.201] ([92.22.37.149])
        by smtp.talktalk.net with SMTP
        id AvKJgpQv2whzSAvKJgof0o; Fri, 12 Oct 2018 12:09:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539342592;
        bh=0EEgqIUwOT5d53FPZLFRLxLbCdCYEgVQr4CUIusyP+w=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NrFDplITLCPV61BDwRyIsCyKlw1+q8E4neuVIteXRfvUNcuxAD4cHP4AayinWwVaE
         RiAzl0lH97kwXzqExbRx871etzh7q2FPT5LZDwqmmDO0wPfy7rLA9R4a8td/Kt8X1b
         ytAu6j0b3O7nNo1yCMfkIbE1Cgdev0LBls7T2Q7o=
X-Originating-IP: [92.22.37.149]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=nqOWhaM9XRsRdUafe8zwgQ==:117
 a=nqOWhaM9XRsRdUafe8zwgQ==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=xWCtVjafHelC0wMDnX8A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase -i: introduce the 'break' command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.43.git.gitgitgadget@gmail.com>
 <pull.43.v2.git.gitgitgadget@gmail.com>
 <c74e02c4b643652d43108c1a5a675df0fae5f059.1539161632.git.gitgitgadget@gmail.com>
 <fd14c00f-65d5-f5d6-5f0e-ee0de7593a38@talktalk.net>
 <nycvar.QRO.7.76.6.1810121035190.45@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <3e2f9343-8b01-c6e5-9425-1665920cc920@talktalk.net>
Date:   Fri, 12 Oct 2018 12:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1810121035190.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFhHxNM3xJPKLxuQsW7eM95S0irAh0WzTTJNkm6qJprCtBDVmEP43R1rd0ypihFLqQ5mQKOiOub2qYOtqul5lN4IFV4YdVhNQfTkTlGesDmFHwK7P8Gy
 qURGtXMRsgbWR4MPcHXDmEYZebOMSWXb0vljmJJuNX1Q40E7grXsE4XRsVODsCDN8xQrgPw4n1Hr1yaDwdwQkng9LUvVmip09MqdlGt4ixCmzb63tJ47/XIn
 fCCsXaFdGhGLwcJ3xW/LtQL0slxOzvBEDUwJXfg2ODoDnH8FP/tT45jotzpYqhuWHrLECwNtpAPLLjOZIIj0/HAeaqmVNqcDO8GIx1uXmypXFdvgUVjF+hrU
 uhGJ9Uyj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes
On 12/10/2018 09:35, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 11 Oct 2018, Phillip Wood wrote:
> 
>> I think this would be a useful addition to rebase, there's one small
>> comment below.
>>
>> On 10/10/2018 09:53, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> The 'edit' command can be used to cherry-pick a commit and then
>>> immediately drop out of the interactive rebase, with exit code 0, to let
>>> the user amend the commit, or test it, or look around.
>>>
>>> Sometimes this functionality would come in handy *without*
>>> cherry-picking a commit, e.g. to interrupt the interactive rebase even
>>> before cherry-picking a commit, or immediately after an 'exec' or a
>>> 'merge'.
>>>
>>> This commit introduces that functionality, as the spanking new 'break'
>>> command.
>>>
>>> Suggested-by: Stefan Beller <sbeller@google.com>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---

>>> diff --git a/sequencer.c b/sequencer.c
>>> index 8dd6db5a01..b209f8af46 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c

>>> @@ -3293,6 +3295,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>>>  			unlink(rebase_path_stopped_sha());
>>>  			unlink(rebase_path_amend());
>>>  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
>>> +
>>> +			if (item->command == TODO_BREAK)
>>> +				break;
>>
>> Normally when rebase stops it prints a message to say where it has got
>> to and how to continue, it might be useful to do the same here
> 
> That's a very valid point. I'll think of something.

I'm not sure what gets left on the screen from the previous picks but
something to say what the last pick/exec was and maybe what the current
HEAD is would be useful I think. One thing has just occurred to me -
what does git status say (and does it still work - I'm not sure how much
parsing it does on the todo and done files) if it is run while rebase is
stopped on a break command?

Best Wishes

Phillip

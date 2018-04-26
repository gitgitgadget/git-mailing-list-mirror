Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA321F404
	for <e@80x24.org>; Thu, 26 Apr 2018 10:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbeDZKw6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 06:52:58 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:8253 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755150AbeDZKw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 06:52:57 -0400
Received: from [192.168.2.201] ([92.22.38.249])
        by smtp.talktalk.net with SMTP
        id BeWDfAdln4ZqzBeWEfojNi; Thu, 26 Apr 2018 11:52:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524739975;
        bh=60WsiFyD6cp9omsTRNDKwN6PeNSF8GLVN32GE37l8Eo=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BrluzbVNe5yCKO1UQbfm15C/eqfcUvxtlR5m6MPYdfBQJoR5gwFUHDHDaCMZhVZ2K
         ji7XK54GeuueWHyvPIlIFyqGG/LKB/dLAf/38lALuZMeGSqK9UyfM2aqLWHZieFvwg
         VBvnZWHq5h3NXy1xV2T/nECJNsb55rKGUT0hDtrU=
X-Originating-IP: [92.22.38.249]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=wtPHZgyFiCiZjBlnDI9PZA==:117
 a=wtPHZgyFiCiZjBlnDI9PZA==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=nN7BH9HXAAAA:8 a=2HmYsfA4WFtQpRLxnS8A:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combinationof"
 in commit messages
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524296064.git.johannes.schindelin@gmx.de>
 <CAGZ79kbK7j0njrZ8-d_Da6+XyH_RVRhBu=hcpzr7EFsOCSFJVQ@mail.gmail.com>
 <12fa9a1f-9dc2-9108-132f-48b75ae5a8d3@talktalk.net>
 <nycvar.QRO.7.76.6.1804251442510.4978@tvgsbejvaqbjf.bet>
 <949b5749-d721-31ea-77a1-ec6406f3083a@talktalk.net>
 <nycvar.QRO.7.76.6.1804261135530.4978@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <3e1d2e06-a415-24c8-ad6c-02ab707cc52e@talktalk.net>
Date:   Thu, 26 Apr 2018 11:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804261135530.4978@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF+ICzAqEgp0atH9nsCsscnG1DNx7/0I3y3EbFskmbelArGMbPRCK+NwdWFXIzIUwbL4BLGrocXAzh51Yk3gZ5v1TwdyZoVvRz40wvkIgyqlVWe55kA3
 2lO1SZcRz/C79TYQFIR1uSgXq2h04Y/eNhWKyaAuCs37swwGJ/1hVvoZKL+8k7dhOsDHfMim5aqyzH4BBuvaEgfKIL6hUHAdd8vOfwZxbNhtaFVen569m0cO
 JcjJghNSkCL9tk5UB/EUTzJ9FUFbVM1m7BhPjQr4Dedf/m0R33QsY0Bzjr8EIgFzHIC6DrtvsmI+aC/ALS5Wo1SNAaAlVooXIfXtxDT4JKdtkTwOSDsvUHvD
 8nEl4IZi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/04/18 10:51, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 25 Apr 2018, Phillip Wood wrote:
> 
>> On 25/04/18 13:48, Johannes Schindelin wrote:
>>>
>>> On Mon, 23 Apr 2018, Phillip Wood wrote:
>>>
>>>> On 23/04/18 19:11, Stefan Beller wrote:
>>>>>
>>>>> On Sat, Apr 21, 2018 at 12:34 AM, Johannes Schindelin
>>>>> <johannes.schindelin@gmx.de> wrote:
>>>>>> Eric Sunshine pointed out that I had such a commit message in
>>>>>> https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
>>>>>> and I went on a hunt to figure out how the heck this happened.
>>>>>>
>>>>>> Turns out that if there is a fixup/squash chain where the *last*
>>>>>> command fails with merge conflicts, and we either --skip ahead
>>>>>> or resolve the conflict to a clean tree and then --continue, our
>>>>>> code does not do a final cleanup.
>>>>>>
>>>>>> Contrary to my initial gut feeling, this bug was not introduced
>>>>>> by my rewrite in C of the core parts of rebase -i, but it looks
>>>>>> to me as if that bug was with us for a very long time (at least
>>>>>> the --skip part).
>>>>>>
>>>>>> The developer (read: user of rebase -i) in me says that we would
>>>>>> want to fast-track this, but the author of rebase -i in me says
>>>>>> that we should be cautious and cook this in `next` for a while.
>>>>>
>>>>> I looked through the patches again and think this series is good
>>>>> to go.
>>>>
>>>> I've just realized I commented on an outdated version as the new
>>>> version was posted there rather than as a reply to v1. I've just
>>>> looked through it and I'm not sure it addresses the unnecessary
>>>> editing of the commit message of the previous commit if a single
>>>> squash command is skipped as outlined in
>>>> https://public-inbox.org/git/b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net/
>>>
>>> I have not forgotten about this! I simply did not find the time yet,
>>> is all...
>>
>> I wondered if that was the case but I wanted to check as I wasn't sure
>> if you'd seen the original message as it was on an obsolete version of
>> the series
>>
>>> The patch series still has not been merged to `next`, but I plan on
>>> working on your suggested changes as an add-on commit anyway. I am not
>>> quite sure yet how I want to handle the "avoid running commit for the
>>> first fixup/squash in the series" problem, but I think we will have to
>>> add *yet another* file that is written (in the "we already have
>>> comments in the commit message" conditional block in
>>> error_failed_squash())...
>>
>> I wonder if creating the file in update_squash_messages() rather than
>> error_failed_squash() would be a better approach as then it is easy to
>> only create rebase_path_amend_type() when there has already been a
>> squash or fixup.  The file is removed in the loop that picks commits in
>> pick_commits() so it would be cleaned up at the beginning of the next
>> pick if it's not needed.
> 
> That would be a good idea in general, but I think we have to take care of
> the following scenario:
> 
> 	pick	<- succeeds
> 	squash	<- succeeds
> 	fixup	<- fails, will be skipped
> 
> In this case, we do need to open the editor. But in this scenario, we do
> not:
> 
> 	pick	<- succeeds
> 	fixup	<- succeeds
> 	squash	<- fails, will be skipped
> 
> If we write the amend-type file in update_squash_messages(), we would
> write "squash" into it in both cases. My hope was to somehow avoid that.

Good point, I'd not thought of that

> I just realized that the current iteration does not fulfill that goal, as
> the message-fixup file would be long gone by the time
> error_failed_squash() was called in the latter example.
> 
> Also, I realized something else: my previous work-around for the
> GETTEXT_POISON case (where I fail gently when a commit message does not
> contain the "This is a combination of #<count> commits" count in ASCII)
> would be much superior if it simply would not abuse the comment in the
> commit message, but had a robust, non-l18ned way to count the fixup/squash
> commits.
> 
> My current thinking is to reconcile both problems by shunning the
> amend-type and instead just record the sequence of fixup/squash commits
> that went into HEAD, in a new file, say, current-fixups.
> 
> To answer the question how many commit messages are combined, I then
> simply need to count the lines in that file.
> 
> To answer the question whether a skipped fixup/squash requires the editor
> to be launched, I can simply look whether there is a "squash" line
> (ignoring the last line).

That sounds like a good plan, keeping count of the fixup/squash without
having to parse the last message is a good idea.

> Oh, and I also forgot to test whether this is the "final fixup". If we are
> skipping a "fixup" in the middle of a chain, there is no need to clean the
> commit message to begin with.
> 
> This will take a while... ;-)

Yes, it sounds like quite a bit of work, but it will be a very
worthwhile improvement.

Thanks

Phillip

> Ciao,
> Dscho
> 


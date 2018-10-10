Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFF31F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJJWth (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 18:49:37 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:41756 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJWth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 18:49:37 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AGNygqcoKoI6LAGNygYi5v; Wed, 10 Oct 2018 16:26:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539185215;
        bh=A2hYcUuX4B9jM1tKcSmpu+WEPMsoh5PDRdN4213NOY8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y54aoT4faYAHMbeIAMojbe/f5bVs/pZezkMcQdlrEmqrgcrg3n8MzgOVuS4KOD0lu
         lCYNoS7wc2LBUmVCBuICi5HFrcgWECs8V+YHsutFRof1rHEj6mtB93OX/hWD4SnnFu
         XV27My6ssb+mD2ZBPBeGkH9BxKvEHxeAk1sedUhk=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=r1BMsFCKjyBjh_b7YOYA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 3/3] diff: add
 --color-moved-ws=allow-mixed-indentation-change
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20180924100604.32208-4-phillip.wood@talktalk.net>
 <CAGZ79kZjAaLE7G=q9sBeEL_+Q2ufYBTn6p9TDCF8cYFd3k+0oQ@mail.gmail.com>
 <b3d29d34-616d-5d12-bb86-19ea488a766d@talktalk.net>
 <CAGZ79kYjeqME-tt89Fp=Wt0hAW0FVAyZ00ftN5XTOkFSn7Kq9A@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <fb500556-adb0-fbd8-0119-443455915eab@talktalk.net>
Date:   Wed, 10 Oct 2018 16:26:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYjeqME-tt89Fp=Wt0hAW0FVAyZ00ftN5XTOkFSn7Kq9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPJ+qu9y8L3lR35+jeeSsPbPsUSaYtZ3rNq1n+C9ZYP9hG1yFQg2Yih70qD3/iycr/Fs72mbVPCD/kNhsVtfcIyiutiSCJlVZ/ptoE2hRTm3Er5IfGFr
 5YkQBWEgeJoGGf0wyKiQSCUQ6odJ6upf7Famd3ZI1UKRnTiNsJzMcGYt78pPf7cxHVjdZ/j4sJjzsr1cA+MP+BhOoome9Y0bmhaHoV6dTUcvgCEFadsKGb+v
 M4LIFS54ytJWrKu3GQ4LCAZcMNn7lM3tMapnDAJHBxMlWMqD6HC/Crtl71YPiK2G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/10/2018 22:10, Stefan Beller wrote:
>> As I said above I've more or less come to the view that the correctness
>> of pythonic indentation is orthogonal to move detection as it affects
>> all additions, not just those that correspond to moved lines.
> 
> Makes sense.

Right so are you happy for we to re-roll with a single 
allow-indentation-change mode based on my RFC?

> 
>>> What is your use case, what kind of content do you process that
>>> this patch would help you?
>>
>> I wrote this because I was re-factoring some shell code than was using a
>> indentation step of four spaces but with tabs in the leading indentation
>> which the current mode does not handle.
> 
> Ah that is good to know.
> 
> I was thinking whether we want to generalize the move detection into a more
> generic "detect and fade out uninteresting things" and not just focus on white
> spaces (but these are most often the uninteresting things).
> 
> Over the last year we had quite a couple of large refactorings, that
> would have helped by that:
> * For example the hash transition plan had a lot of patches that
>    were basically s/char *sha1/struct object oid/ or some variation thereof.
> * Introducing struct repository
> 
> I used the word diff to look at those patches, which helped a lot, but
> maybe a mode that would allow me to mark this specific replacement
> uninteresting would be even better.
> Maybe this can be done as a piggyback on top of the move detection as
> a "move in place, but with uninteresting pattern". The problem of this
> is that the pattern needs to be accounted for when hashing the entries
> into the hashmaps, which is easy when doing white spaces only.

Yes the I like the idea. Yesterday I was looking at Alban's patches to 
refactor the todo list handling for rebase -i and there are a lot of '.' 
to '->' changes which weren't particularly interesting though at least 
diff-highlight made it clear if that was the only change on a line. 
Incidentally --color-moved was very useful for looking at that series.

>>>> +       if (a->s == DIFF_SYMBOL_PLUS)
>>>> +               *delta = la - lb;
>>>> +       else
>>>> +               *delta = lb - la;
>>>
>>> When writing the original feature I had reasons
>>> not to rely on the symbol, as you could have
>>> moved things from + to - (or the other way round)
>>> and added or removed indentation. That is what the
>>> `current_longer` is used for. But given that you only
>>> count here, we can have negative numbers, so it
>>> would work either way for adding or removing indentation.
>>>
>>> But then, why do we need to have a different sign
>>> depending on the sign of the line?
>>
>> The check means that we get the same delta whichever way round the lines
>> are compared. I think I added this because without it the highlighting
>> gets broken if there is increase in indentation followed by an identical
>> decrease on the next line.
> 
> But wouldn't we want to get that highlighted?
> I do not quite understand the scenario, yet. Are both indented
> and dedented part of the same block?

With --color-moved=zebra the indented lines and the de-indented lines 
should be different colors, without the test they both ended up in the 
same block.

Best Wishes

Phillip
>>>
>>>> +       } else {
>>>> +               BUG("no color_moved_ws_allow_indentation_change set");
>>>
>>> Instead of the BUG here could we have a switch/case (or if/else)
>>> covering the complete space of delta->have_string instead?
>>> Then we would not leave a lingering bug in the code base.
>>
>> I'm not sure what you mean, we cover all the existing
>> color_moved_ws_handling values, I added the BUG() call to pick up future
>> omissions if another mode is added. (If we go for a single mode none of
>> this matters)
> 
> Ah, makes sense!
> 


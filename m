Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048B620248
	for <e@80x24.org>; Tue, 12 Mar 2019 10:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfCLK6n (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 06:58:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35388 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLK6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 06:58:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id y15so2122140wma.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmsI/j9X0/dalcMxLxSpu0SvpSK5BLzz2/Zytk/tWUk=;
        b=EO8jzvNc14RgfIMXQAEc/X38QpIBL4m0bNREx3R8CXmB52KAOa86im1W8zHrCE1BTn
         hnArFVEQkyKddg8btsr/XRUDeROPVvlxquPUymqGdm9CqY+o7Qg3uN6I7TDp0zBG8bRZ
         kgMKhwObKeHQ3UngKjZRYwb6/cEcn85SDV7Dii3qG0LDzx/sE5VWUG1W8Mij2ClgOzOt
         dvwsXEcX0lxGRlw+Ay8o2clZ1rjN9VnNtEcZPQUCHDD8IqKogVDjp9Xp/RLCNSQUcF9H
         8CAWT1N+WttIdijpqbTqxIz5Pa/xEfFohEB4FqVTP6sRsKi+HjjfyLFViaiv/Idd8aAr
         7KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HmsI/j9X0/dalcMxLxSpu0SvpSK5BLzz2/Zytk/tWUk=;
        b=pDvljlF+EueuHMvEUvex3nyzuIifMQ/OjCsNUQwQ8XbrWmT58mp16TMtVw8zhmyQ10
         8Y4QfAKsBOvX9jSTQnjliD5MZ2E4f528wpQE6J4BEyY7YGROufbzeyIQG2zlR1UfiUq1
         9Pu+eJm9PpG9/VvrZjVC3tAxDLdMKOk22rS4dBy7EMYbWyaJGzKdKt7rEqFdFTHIfWHK
         S0HoUfYMFFvDNPGtsKBQLla765KuAFmU2EwQX98qjfZAnBIRrvLVP+7Nb57PJh3Pf4pu
         Ue9XpxNZqSGSY398xuM83nfReB9zaiknvxOCPrNSil7WTu+M3V8N4rrFnWlIngdcRBsk
         am1w==
X-Gm-Message-State: APjAAAVS5WmTest0g0eUVecjqP/Ol+YQgtzElzR7D9q/87Ny7Ujz0XQv
        mhASdc+88QDgiMz1p/QH5YE=
X-Google-Smtp-Source: APXvYqwBLY53dv+JXSCq96uWmcneTauCXGh5r1UB86WEJN2e9jiMW4UHcYEhBqLlabBbtbgproJwVQ==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr1838360wma.57.1552388320786;
        Tue, 12 Mar 2019 03:58:40 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-27-66.as13285.net. [92.22.27.66])
        by smtp.gmail.com with ESMTPSA id u4sm3431415wmb.25.2019.03.12.03.58.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 03:58:39 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
 <CABPp-BH8FjK9LrZoctpxsuKW13FW_2qfk9wx=VXCZ5U+3B8b+Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <47d1d587-9c75-cc97-3006-6cc22707a70a@gmail.com>
Date:   Tue, 12 Mar 2019 10:58:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BH8FjK9LrZoctpxsuKW13FW_2qfk9wx=VXCZ5U+3B8b+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 11/03/2019 22:04, Elijah Newren wrote:
> On Mon, Mar 11, 2019 at 1:51 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 11/03/2019 17:24, Elijah Newren wrote:
>>> On Mon, Mar 11, 2019 at 4:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>>> On 08/03/2019 09:57, Nguyễn Thái Ngọc Duy wrote:
>>>>>> "git checkout" doing too many things is a source of confusion for many
>>>>>> users (and it even bites old timers sometimes). To remedy that, the
>>>>>> command will be split into two new ones: switch and
>>>>>> something-to-checkout-paths.
>>>>>
>>>>> I think this is a good idea, thanks for working on it. I wonder if it
>>>>> would be a good idea to have the new command refuse to checkout a new
>>>>> branch if there is a cherry-pick/revert/merge/rebase in progress (with
>>>>> an option to override the check) as switching branches in the middle of
>>>>> one of those is likely to be confusing to users (if I do it it is
>>>>> normally because I've forgotten that I've not run 'git whatever
>>>>> --continue').
>>>>
>>>> Interesting. I think this would be a good default if we have an escape
>>>> hatch (which could even come later). I often wander off to some other
>>>> branch and go back. But then half the time I end up forgetting I'm in
>>>> a middle of something and just "git rebase --quit" :P
>>>>
>>>> Of course with git-stash (*) and git-worktree, I guess there's little
>>>> reason to just switch away from a something-in-progress worktree. I'll
>>>> try to implement this in the next round, unless someone objects.
>>>
>>> No objection here; I like this idea.
>>>
> 
> Keeping this hunk since it's now relevant to the comment below...
> 
>>>>>> +-f::
>>>>>> +--force::
>>>>>> +     Proceed even if the index or the working tree differs from
>>>>>> +     HEAD. Both the index and working tree are restored to match
>>>>>> +     the switching target. This is used to throw away local
>>>>>> +     changes.
>>>>>
>>>>> I'd always thought that --force meant "throw away my local changes if
>>>>> they conflict with the new branch" not "throw them away regardless"
>>>>> (which is better as it is deterministic). Maybe we can come up with a
>>>>> clearer name here --discard-changes? At the moment --force does not
>>>>> throw away conflicts properly (see the script below in my comments about
>>>>> --merge).
>>>>
>>>> Yeah if you want to redefine --force, now is a very good time.
>>>> Personally I'd rather have separate options than the "one catch all"
>>>> --force (or worse, multiple of --force). I'll leave this for the
>>>> community to decide.
>>>>
>>>> Adding Elijah too. He also had some concern about "git restore
>>>> --force". Maybe he's interested in this as well.
>>>
>>> I like Phillip's suggestion of --discard-changes.  I also like how he
>>> came up with a simple testcase showing one bug each with checkout's
>>> current -m and -f handling; we should fix those.
>>
>> With regard to discarding conflicts, do we want it to clear up any state
>> associated with the conflicts (like reset)? They rarely happen in
>> isolation, there's a MERGE_HEAD or CHERRY_PICK_HEAD etc. I'm not sure
>> what it should do in the middle of a rebase or when cherry-picking a
>> range of commits. I think it would be surprising if it was the
>> equivalent of rebase/cherry-pick --quit but just clearing the conflicts
>> in those contexts may not be very useful in practice.
> 
> You already suggested above (outside the context of --discard-changes)
> that we should just error out if there is some special mid-operation
> state (be it from a merge, cherry-pick, rebase, or bisect).  The user
> can then manually resolve the operation first, or, perhaps use a
> special override to force the switch command to proceed despite the
> presence of mid-operation state.
> 
> Personally, I'm leaning towards --discard-changes operating within
> that same context; I think that mid-operation special state should
> require a more explicit and operation-specific step to remove (e.g.
> rebase --quit).

I think that makes sense, I was wondering if --discard-changes should 
remove the state of a conflicted merge/single cherry-pick/revert but it 
is probably simpler and easier to understand just to error out. I think 
it should still clean up conflicts from other checkouts and applying 
stashes though as there is no other state in those cases.

Best Wishes

Phillip

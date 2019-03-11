Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214F920248
	for <e@80x24.org>; Mon, 11 Mar 2019 20:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCKUvf (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 16:51:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51699 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfCKUvf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 16:51:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id n19so507775wmi.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l+mNJqKOjNUfl92qGVyXgWw0lRDWVxik9KoHDlTzrSQ=;
        b=hYvzWieVw6y1Su4sCvNJZrfpTaT6oTpJSgKnuei/hDQlJRhZDmz2VR3QYGeOlDFa00
         eZLTR/oeSL4reGmlQKV4u8aTWiG7pBH7WaIFD75xdws8W39o/cChBXJx7/gyJdVsoL12
         YN1rSn5hio+NqWT9gBt9VP5TVnfq8Vvt5EK4KFe4VXBIQW0BISxgZrnvvC8KlfTH55Ya
         7XPJj0zsR702v1Ik1g75/sJ5x7AUTpLO7Q1eaaMqkWFg13LtQkn7locRiuhujWpCg9KN
         7DIhUHtUPe68hvvnaoJpxSBKWw/1tiRI/CdAahWRnIderYDSvf8a4n6ECQ+cUBdQABLh
         fNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l+mNJqKOjNUfl92qGVyXgWw0lRDWVxik9KoHDlTzrSQ=;
        b=iq00OFttfsY5301Ki2J88/gk7lTNli+SY4H83Nrsp+2yMjLrekQkbW9MVujB2n3ifb
         BpWH2VqCHJCkdryHiUUEHUpSMS+7aeop4MGKx+WUqHR9oROWaIc8LyZF8/u6gTc2MB+5
         AD+uF2zVHKjHQzIEbcUNCJGRWRCoW3Lq7k4ZYL0VE82NfmlzPvbEYZGAZvVSH3z820Ox
         AdhNJQWu+dl9zrbOtNMfIxbIcy2LcSj+tpfszW1+nAFpbF1fAfh/MdReWqX9PrEHutQe
         o3xyLepSeL3+sUIDFFZGiwdJ1X+QYLlsJGBFpHL4TG1iyblohjRgBU9gYbx4um8TqcWy
         jN9w==
X-Gm-Message-State: APjAAAUwvjlQ4k8sS1Z+gjzl3qu9rmRdxvohhwlhvPYRQvtFGuGoOQJl
        ezN5sQRK31Q7b8afNlbJ3sA=
X-Google-Smtp-Source: APXvYqz/5P3XXFrFqNyHj0iML6LJFvfEjqtHNsS71gBSaha6p45Xqjo42Tuvl54B3xqnQer3Br95DQ==
X-Received: by 2002:a1c:f502:: with SMTP id t2mr82254wmh.124.1552337493313;
        Mon, 11 Mar 2019 13:51:33 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-27-66.as13285.net. [92.22.27.66])
        by smtp.gmail.com with ESMTPSA id z10sm6813012wrs.11.2019.03.11.13.51.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 13:51:32 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Elijah Newren <newren@gmail.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
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
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
Date:   Mon, 11 Mar 2019 20:51:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03/2019 17:24, Elijah Newren wrote:
> On Mon, Mar 11, 2019 at 4:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> Hi Duy
>>>
>>> On 08/03/2019 09:57, Nguyễn Thái Ngọc Duy wrote:
>>>> "git checkout" doing too many things is a source of confusion for many
>>>> users (and it even bites old timers sometimes). To remedy that, the
>>>> command will be split into two new ones: switch and
>>>> something-to-checkout-paths.
>>>
>>> I think this is a good idea, thanks for working on it. I wonder if it
>>> would be a good idea to have the new command refuse to checkout a new
>>> branch if there is a cherry-pick/revert/merge/rebase in progress (with
>>> an option to override the check) as switching branches in the middle of
>>> one of those is likely to be confusing to users (if I do it it is
>>> normally because I've forgotten that I've not run 'git whatever
>>> --continue').
>>
>> Interesting. I think this would be a good default if we have an escape
>> hatch (which could even come later). I often wander off to some other
>> branch and go back. But then half the time I end up forgetting I'm in
>> a middle of something and just "git rebase --quit" :P
>>
>> Of course with git-stash (*) and git-worktree, I guess there's little
>> reason to just switch away from a something-in-progress worktree. I'll
>> try to implement this in the next round, unless someone objects.
> 
> No objection here; I like this idea.
> 
>> (*) I hope git-stash remembers and restores "something-in-progress"
>> status. Dunno. Never used it much.
>>
>>>> +-C <new-branch>::
>>>> +--force-create <new-branch>::
>>>> +     Similar to `--create` except that if `<new-branch>` already
>>>> +     exists, it will be reset to `<start-point>`. This is a
>>>> +     convenient shortcut for:
>>>
>>> If we're renaming the options to be more meaningful then maybe we should
>>> consider a different name for this one - it has nothing to do with
>>> creating a branch. Maybe --reset or --update?
>>
>> -C can also create a new branch like -c though. --reset or --update
>> does not convey that (and --update sounds a bit too safe). Another
>> option is --recreate.
> 
> Maybe --recreate, but I don't see as much of a problem with the
> original name you gave the option.  Which name is better probably
> depends on how you envision its usage.  If you view this option as
> only being used if/when '-c' fails (perhaps Phillip sees it that
> way?), 

Yes I was thinking it was used to reset an existing branch in order to 
reuse the name, --recreate is a good suggestion in that context.

> then it'd make sense to use --recreate instead.  But if you
> think some might adopt a workflow where they just use -C without first
> trying -c ("create this branch, and I don't care if I made it before
> just create it here"), then --force-create makes sense.
> 
> Another option, possibly showing my lack of understanding why this
> flag was useful in the first place: just drop this set of flags from
> this command.  People can switch to the branch and then use reset
> --hard <startpoint>, right?  Or (if they don't care about the reflog,
> which they probably don't) delete the branch first and then recreate
> it?  Not sure why we need to give another way to do these operations.
> (In contrast, I see -c as being used frequently enough to have merit
> even if it could be implemented as two separate commands.)

I tend to agree with this but that's probably because I don't really use 
checkout -B. I'm not sure if it's widely used or not. I do find checkout 
-b convenient though.

> I don't have much of an opinion about which of these three is the best
> option here (I'm slightly biased towards just jettisoning the option,
> but I understand there might be a good reason for it even if I don't
> know what it is), so really I'm just giving some food for thought on
> this one.
> 
>>>> +-f::
>>>> +--force::
>>>> +     Proceed even if the index or the working tree differs from
>>>> +     HEAD. Both the index and working tree are restored to match
>>>> +     the switching target. This is used to throw away local
>>>> +     changes.
>>>
>>> I'd always thought that --force meant "throw away my local changes if
>>> they conflict with the new branch" not "throw them away regardless"
>>> (which is better as it is deterministic). Maybe we can come up with a
>>> clearer name here --discard-changes? At the moment --force does not
>>> throw away conflicts properly (see the script below in my comments about
>>> --merge).
>>
>> Yeah if you want to redefine --force, now is a very good time.
>> Personally I'd rather have separate options than the "one catch all"
>> --force (or worse, multiple of --force). I'll leave this for the
>> community to decide.
>>
>> Adding Elijah too. He also had some concern about "git restore
>> --force". Maybe he's interested in this as well.
> 
> I like Phillip's suggestion of --discard-changes.  I also like how he
> came up with a simple testcase showing one bug each with checkout's
> current -m and -f handling; we should fix those.

With regard to discarding conflicts, do we want it to clear up any state 
associated with the conflicts (like reset)? They rarely happen in 
isolation, there's a MERGE_HEAD or CHERRY_PICK_HEAD etc. I'm not sure 
what it should do in the middle of a rebase or when cherry-picking a 
range of commits. I think it would be surprising if it was the 
equivalent of rebase/cherry-pick --quit but just clearing the conflicts 
in those contexts may not be very useful in practice.

Best Wishes

Phillip

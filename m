Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B0D20248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfC1QXS (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:23:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42679 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1QXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:23:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so20186185wrx.9
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u0rYJt+8hJuXz8B0S3jwq86ZmizaRBxjCVZc/5sm3rI=;
        b=ZoLQ3hwbs2cHpAGnOJa8+mUapzx1Zbkc2r87/5ebL4Io05VP6HeeXGPntPWTQVCXCG
         wBDJmAhodOm0NXbt0/GCy6R8M0OR1F3WmqNvrWWkaQE8ZRArkiKBfjBFVhG1mhxtellL
         Kxg61JEx4QiTZRlgX04IXvVKsQMFa7ZrQK9hYLDb+hJsbt3oLBws0bvviFk249ksgcCU
         7Csq9v1eGcdSuGP32FO4ZrxSNS0DlFjK/XXy5ZwIez09l/XNu+pATQ6WXR0CO3rl09b9
         2H9s8a9PceEIDA8fEbYSi/Ksj1wo/oQ4QThFbcRQoh7Ye2iflPN0+vcjyJoV83xFZHIR
         Dqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u0rYJt+8hJuXz8B0S3jwq86ZmizaRBxjCVZc/5sm3rI=;
        b=ammesIk1Zw7zTXi4szW7RN4/a8xVkC8KjSBRGuJywvAPd50JdH9yLikPARB2G5VFNW
         UA1ZjTike9haKjWn4ydQpoxu2w+8v6gYTAJ/5kfiIc3M7hoe0ZjWXn9QrzJYre/WFAsI
         TItkpDvzCGiErbyIXgVoskCKdvqowB/QV3yt++XWz+KOE7g2xjRyjLUF155XdmsAMsbM
         nj0bTD3rEluTh85Fn+StYfr90r82HtWgaOVvRNZqAVW2FP2im+67OL8zdIk2I0bk4FfA
         HpX+iLuw8ufRqfFtS8a+XNIhXJQ1UO4q4AErPxNL9vseBlSfTSU89qSo/SSPcyLXPNg5
         4ogw==
X-Gm-Message-State: APjAAAUm8MyCs0Ndi8kOazHkPa1ljxtMO5tFVme3yYejpa5P1Ku/jsAL
        jydTQBmgwq876o+h/L/Qx+o=
X-Google-Smtp-Source: APXvYqxejBdGr7/it1Mny/nFihOppqly3YhBmWr2rJDh6ywVUTFOnC6GFldjLdg2yqnmaBUEKjt0Bw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr29217894wrp.72.1553790196333;
        Thu, 28 Mar 2019 09:23:16 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-192.as13285.net. [92.22.10.192])
        by smtp.gmail.com with ESMTPSA id p3sm20010751wrx.71.2019.03.28.09.23.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:23:15 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
 <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
 <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com>
 <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a68ce0b4-81c5-e889-fc90-ed8b17a10d4a@gmail.com>
Date:   Thu, 28 Mar 2019 16:23:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/03/2019 11:04, Duy Nguyen wrote:
> On Wed, Mar 27, 2019 at 5:24 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 26/03/2019 15:48, Elijah Newren wrote:
>>> On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:
>>>
>>>> Yeah.. --ignore-in-process does not necessarily mean aborting
>>>> something when you just want to get out to examine some other commit.
>>>> And I agree doing nothing seems like the best (or least
>>>> confusing/surprising) option.
>>>>
>>>> There will be some funny thing. Like if you commit after switching
>>>> away and MERGE_HEAD is there, I think you will be creating a merge
>>>> commit.
>>>
>>> Yes, and in the middle of a cherry-pick with a range you've added some
>>> commits to one branch and some to another.  In the middle of a revert
>>> you're doing similar.  It sounds like crazytown to me (and maybe we
>>> shouldn't provide the --ignore-in-process flag unless users clamor for
>>> it
> 
> I missed this part in my last reading. I think if we could safely
> switch away and get back to resume, then --ignore-in-process could
> still be useful.

If we can get back safely then that makes sense, I'm not sure about 
switching while there are conflicts or staged changes though, it feels 
like there's more potential for things to go wrong there.

> I sometimes switch to another commit to check out
> stuff then back. For interactive rebase with "edit" command for
> example, it's quite safe to do so. (yes the other option is "git
> worktree add", but that could be a heavy hammer sometimes) >
>> I think that could be the way to go for merges and cherry-picks, or
> 
> Just so we're clear, what is your "the way" to go? to remove
> CHERRY_HEAD_PICK and MERGE_HEAD (and other MERGE_* as well) if
> --ignore-in-process is specified? Or to leave MERGE_* and
> CHERRY_PICK_HEAD alone and delete other stuff?

I was agreeing with Elijah about dropping --ignore-in-progress unless 
there's a demand for it or at least restricting it so that it requires 
--discard-changes and aborts in-progress merges and single in-progress 
cherry-picks/reverts. (I'm worried about people switching branches when 
cherry-picking more than one commit, though as you say it can make sense 
during a rebase.)

Best Wishes

Phillip

>> possibly require --discard-changes as well. The only time I use checkout
>> like this is during a rebase if I want to rewind it - I edit the todo
>> list with the output of 'git log --pretty="pick %h %s" --reverse' and do
>> 'git checkout' followed by 'git rebase --continue' Though these days I
>> could add a 'reset' line to the todo list and skip the checkout.

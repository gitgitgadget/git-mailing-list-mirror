Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040291F462
	for <e@80x24.org>; Mon, 10 Jun 2019 10:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfFJKjt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 06:39:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43154 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388708AbfFJKjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 06:39:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id r18so8621345wrm.10
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 03:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OPyYd3sC7ahbZxn/iei/mC2dxwSPiSEzDZlu0dLW61g=;
        b=gVXqv4OKXNrM3fSbnJQmriZh4YpJr9J4kNsk5FJPoMZ1DDsxwloO8HuRvXO1KiKHzl
         G2yQSus1R7A2OXlztwTSXo9zcFbqZFOReBIQB2/oJ8SIXOEzcE4yNYfjs+ImL0rs/B2C
         2f2HNFQeqBrq4pdV+mKr3/t3pD7tFKAKx+CYe+Z5b9vero7sV478OcHmWhnKi+qVyG31
         TcX5G/wGPgmMocpbc4VtRducjSqi9yw8KCzYZ+nOQGjNL00cJ4RyuVsbSw96GzgtFlNG
         4krCHTVoCc3uJpPzEh5qWBv1O8RCAP0qkJaWjcdAV93qXTcbMJjR60V8RuLil+U0WNJp
         6wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OPyYd3sC7ahbZxn/iei/mC2dxwSPiSEzDZlu0dLW61g=;
        b=aEe3QU9/QySXN33XQV724dK2VI+xglcdLZghx+VKKUeoh0RliDibWB0JgxHLmtkHMp
         kBywLOquY2lJ7ty1/TPjlcFq0wSZBR1fk5TuVe/+gCqya8GiZ6BG2WjjcRWGvMqiaMmD
         maYlimoZ2J7AHLfo9fTcVQybLsBEaFTUJX/v9zRcHMXLKV+U1wmSWjVVfNCfmVNnwSYX
         CphCEPSOIY02iKqqMI3Q26O19ki0lQz+iba3fFIAonR+QEb7ydDpYF2/aBwhwR1z2Dw8
         kKaPD9JevTb/pGf/3eYTg1X7onalFKutY/CzYJOHDXNuUq7jk+xzhqUWGgY9FQSo8lWV
         jz3Q==
X-Gm-Message-State: APjAAAWyFrKKMd0jlfkVOyPDMxGQLEKLmXYpP174Bdx2tRDbYBBH/vnV
        l8Xn7ACpe/uRL1dvEYAoVjQ=
X-Google-Smtp-Source: APXvYqypDtSvZE7aScEwDExkwEnxywzq2hwIJF+b+WVYPEXKfXVNT9v5heSxpXceL7hz0LXVXZN2fw==
X-Received: by 2002:adf:f709:: with SMTP id r9mr12431976wrp.281.1560163186942;
        Mon, 10 Jun 2019 03:39:46 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id u11sm7619282wrn.1.2019.06.10.03.39.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:39:46 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/3] sequencer: add advice for revert
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com
References: <2007ef79-1791-4f77-f9e4-34c59b4f0c36@gmail.com>
 <20190610051313.16222-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d59c078c-61da-1c3a-d215-80c9e3d08896@gmail.com>
Date:   Mon, 10 Jun 2019 11:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610051313.16222-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 10/06/2019 06:13, Rohit Ashiwal wrote:
> Hi Philip
> 
> On 2019-06-09 17:52 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Rohit
>>
>> Congratulations on your first GSoC patch series!
> 
> Thank you very much :)
> 
>> On 08/06/2019 20:19, Rohit Ashiwal wrote:
>>> [...]
>>> @@ -2655,6 +2655,7 @@ static int create_seq_dir(void)
>>>  	if (file_exists(git_path_seq_dir())) {
>>>  		error(_("a cherry-pick or revert is already in progress"));
>>>  		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
>>> +		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
>>
>> I agree that it's a good idea to add advice for revert as well, but it
>> would be better to call sequencer_get_last_command() to find out if
>> we're running cherry-pick or revert and tailor the advice appropriately.
> 
> Firstly, signature of `create_seq_dir` doesn't allow us to call
> `sequencer_get_last_command()`. Changing that for the sake of a
> better error message is too much task for this patch as it is a
> subject of discussion on its own.

There is only one caller and it already has a struct repository pointer
so it is a two line change, one of which is the insertion of a single
character to change create_seq_dir() so it can call
sequencer_get_last_command(). It is normal to change function signatures
(especially for static functions like this) when making changes, it is
part of improving the code base. The quality of error messages is
important to the overall user experience. It's when things go wrong that
users need accurate advice about what to do.

> (Also changing signature only
> makes sense if this patch series gets merged). FWIW, I think we
> should left this to further discussions for now and decide what
> to do later on.

It is only a small change so why not do it now rather than putting it
off for another series which will be more work in the long run.

Best Wishes

Phillip

> 
>> Best Wishes
>>
>> Phillip
> 
> Thanks
> Rohit
> 


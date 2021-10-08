Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC32DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEDD60F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJHJLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhJHJLo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:11:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC914C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 02:09:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s15so27662088wrv.11
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sWPP6vWfoIZX7ih3tcHVj39Ovmiga1ioR6BG9/HgBl4=;
        b=RocZtw30FmLiFqJNbR11KS6e4TSFR0K7sYOpIXsCAn1Egp1Zwtsv9r86+aY2iWcm6Z
         bHcm4xCsVRgSDQLs7/0ltD1sVa3GCIHjUR8utUY96ItGxotxND8GCqJZdvPu7jJIbI+u
         5iryIEtaM73TSfyJL0/D+UlMdDtodH9POchWnVZspAPOc4dc5pERP8XpeOs5pA7iw0HD
         Lucbc8DhLuPW9pWbUvsh3wrp0C0/y6SEz7t3BtpKxURLXQNQhJ4Rl3pa9tyhvp9FtU06
         1oCz99ChlA8iID/g3gvkzYZayguXvhd4xKR7bL4+fnphHxwIDo8JJdRZQNE/XxprOrFS
         K77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sWPP6vWfoIZX7ih3tcHVj39Ovmiga1ioR6BG9/HgBl4=;
        b=F6UAPkzL0F9u5WXG7sgAvdKRlOlW0CbYV6ys/dnqcp5E3TqEraBPAfikQc9dm6tt3u
         Q16T9icMZ8oCai1KmdHgPKNZ1mfGaTIFQB3fsqUSKvH3jirZq7zGM5jZYVfj7Af6G8a0
         VEe2B0v+GSCwROoRlS9HGURjwgV91nTCjSYP9YeBZ+zOsPgHo3h7RrFKufuD3Phk0pR1
         Zy2jbZJi7q8g6ZKtYVax1s7LD97UMs8EDTTvUPTEpeadxtoqfV0744McPWD+rhxM1sf8
         uC2iXu6qqlI0AcN9cChfL4v960AVGX+5TuQKrwWcEpsLPpdWTHTSRmR9lwPeFo+sVz0T
         /eww==
X-Gm-Message-State: AOAM532A1ZW3PVMoQQtegTesrYskXRC8M8ie35nO8ERQwFgEpTdKcuME
        vta0NUW8CFbvII06Bq62ZZk=
X-Google-Smtp-Source: ABdhPJwdBn9fgNBtB/OFZ34SDIIsUQuuKlA3FuVYbxcMgh4HbxDcrdHvQzi0bXPwEd6WKH0i1HLvjQ==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr2486943wrp.117.1633684187518;
        Fri, 08 Oct 2021 02:09:47 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id h17sm1900920wrx.55.2021.10.08.02.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 02:09:47 -0700 (PDT)
Message-ID: <4ccaad06-a1ae-bd1b-f25d-bfa899ffa98f@gmail.com>
Date:   Fri, 8 Oct 2021 10:09:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
 <xmqqee8wpm0u.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqee8wpm0u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/2021 22:23, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>       * Fixed the spelling of Stolee's name (sorry Stolee)
>>       * Added "-q" to the test to prevent a failure on Microsoft's fork[1]
>>      
>>      [1]
>>      https://lore.kernel.org/git/ebbe8616-0863-812b-e112-103680f7298b@gmail.com/
> 
> I've seen the exchange, but ...
> 
>> -	for OPERATION in "merge -m merge" cherry-pick rebase
>> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
>>   	do
> 
> ... it looks too strange that only one of them requires a "--quiet"
> option.  Is it a possibility to get whoever's fork corrected so that
> it behaves sensibly without requiring the "-q" option only for the
> particular rebase backend?

The issue is caused by a patch that Microsoft is carrying that stops 
apply from creating paths with the skip-worktree bit set. As they're 
upstreaming their sparse index and checkout work I expect it will show 
up on the list sooner or later. I agree the "-q" is odd and it also 
means the test is weaker but I'm not sure what else we can do.

> In the meantime, I'll queue the patch as-is (I actually queued the
> previous round with namefix already).

Thanks

Phillip

> Thanks.
> 


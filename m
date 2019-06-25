Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0E51F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfFYNZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:25:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53646 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYNZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:25:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so2824856wmj.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMA+zDl5WVxKxfQwW+K0o4wfl2enAzs+H1Gt296h2mU=;
        b=BOHFkq72GcawtmdyJ1joySJbziV/nAD+Pp5zMWh0dn32ZvaNHA8GRrNwQqOOWF9mnZ
         C8rW4TGVfM+21+8RgHKnVFjjxD84Ms+VGrM7onv0TV9+2qj5+Ev44Kbq94QLc1jjS1ie
         QLBE1gmIOVEPzihBNvMG6MOIuo4J3pSiviZx+ff3XqyqSGb9dijJdWolxRQvmC2UC8tt
         DIDHwIpajMpjiqgi81EluwGGn0y5G/JIQ7+Su5mw3N/XxMQyegE8LqG/nJB+E/mNimxf
         g8KH7IO0nK26Cp5q9PSA+UM7xdKghi6cNUGL7g90qAF24t0UJofjMj6ngAGCPmbIMM4R
         mwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMA+zDl5WVxKxfQwW+K0o4wfl2enAzs+H1Gt296h2mU=;
        b=qPVyvR+4+5im3jfrYaSyNbL6rbm5RGpad4eRrv18P64tGeMo2M8M+gD3Pu6IIbg4Xn
         mF7CW2gyUUMKgvX5p7RO4XEeBZrfxZVeKQPt2NvUVW8PNGEZYTcH5mxlwEaCX0mq8R1l
         owRL4AEpls846uVP0PbLa0VdgzVMSYftAzUAIfVVNv/EVRsxXGmYLSOU6+mW0XpxZeEc
         EswbBtX2uOT9l92cRcvsCMsyh4NMvood+t2LnvLFNSZ5cxDZoTsy7F+3iyii9wO23GPh
         QBbprG8GD2qNSRbmZVYyVVELdSdv+zQX+WZJlmRSS1tbA5OuyYmvzs2aRBEhDDJq9e1d
         FiFQ==
X-Gm-Message-State: APjAAAXywjnmGegWKjUlY0cZ/NYGef//u9pP7Xn+0aLoAxKIEx9KnOMo
        SHYs8pgYqUKY9PCddC79L4n7L/oFAKM=
X-Google-Smtp-Source: APXvYqy+CD6xCep/jVX1C0zhIh/Ra6S0wKDYeZY/qbUp+0YGW75jsp5MXyMnEaftiHrVdNMcYyibfQ==
X-Received: by 2002:a1c:c6:: with SMTP id 189mr11381851wma.112.1561469127999;
        Tue, 25 Jun 2019 06:25:27 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id j189sm3134116wmb.48.2019.06.25.06.25.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:25:27 -0700 (PDT)
Subject: Re: Git status parse error after v.2.22.0 upgrade
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     aleksandrs@ledovskis.lv,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190613093023.GA3919@ariake.ledovskis.lv>
 <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
 <20190613162432.GA12128@sigill.intra.peff.net>
 <8981e6c8-eb20-fde7-2b4c-1fbf2057caef@gmail.com>
Message-ID: <82f4aa37-51fa-4d1a-8221-d6dd37113c70@gmail.com>
Date:   Tue, 25 Jun 2019 14:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8981e6c8-eb20-fde7-2b4c-1fbf2057caef@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/06/2019 18:43, Phillip Wood wrote:
> On 13/06/2019 17:24, Jeff King wrote:
>> On Thu, Jun 13, 2019 at 09:05:16AM -0700, Junio C Hamano wrote:
>>>
>>> Two issues "the sequencer" folks may want to address are
>>>
>>>   (1) make the one that reads an irrelevant/stale 'todo' file more
>>>       careful to ignore errors in such a file;
>>>
>>>   (2) make the sequencer machinery more careful to clean up after it
>>>       is done or it is aborted  (for example, "git reset --hard"
>>>       could remove these state files preemptively even when a rebase
>>>       is not in progress, I would think).
>>>
>>> I think we already had some patches toward the latter recently.
>>
>> Maybe I am not understanding it correctly, but do you mean in (2) that
>> "git reset --hard" would always clear sequencer state?
> 
> I think the commit Junio is referring to is
> b07d9bfd17 ("commit/reset: try to clean up sequencer state", 2019-04-16)
> which will only remove the sequencer directory if it stops after the
> pick was the last one in the series. The idea is that if cherry-pick
> stops for a conflict resolution on the last pick user commits the result
> directly or run reset without running `cherry-pick --continue`
> afterwards the sequencer state gets cleaned up properly.
> 
>> That seems
>> undesirable to me, as I often use "git reset" to move the head around
>> during a rebase. (e.g., when using "rebase -i" to split apart I commit,
>> I stop on that commit, "git reset" back to the parent, and then
>> selectively "add -p" the various parts).
>>
>> Direction (1) seems quite sensible to me, though.
> 
> Now that we try harder to clean up the sequencer state I wonder if that
> would just cover up bugs where the state has not been removed when it
> should have been.

When I wrote that it hadn't dawned on me that if there is an error the 
status will not tell the user that a cherry-pick is in progress which is 
what we really want so they are alerted to the stale sequencer state. 
I've posted a series [1] to address this (sadly gitgitgadget wont let me 
post it on this thread).

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/pull.275.git.gitgitgadget@gmail.com/T/#mf57a4ab95ba907fbf2d06ec64e9b676db158eace


> That can lead to unpleasant problems if the user
> aborts a single revert/cherry-pick when there is stale sequencer state
> around as it rewinds HEAD to the commit when the stale
> cherry-pick/revert was started as explained in the message to b07d9bfd17
> ("commit/reset: try to clean up sequencer state", 2019-04-16)
> 
> If we do want to do something then maybe teaching gc not to collect
> commits listed in .git/sequencer/todo and
> .git/rebase-merge/git-rebase-todo would be useful.
> 
> Best Wishes
> 
> Phillip
> 
>> -Peff
>>
> 

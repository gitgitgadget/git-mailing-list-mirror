Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235C21F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeEaTd1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:33:27 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55111 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754210AbeEaTdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:33:21 -0400
Received: by mail-wm0-f52.google.com with SMTP id f6-v6so55949976wmc.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZx9CgPMpFTkt+CTufj8zDSZxRvAV71WykmfHDTqk9k=;
        b=oHbChd9YP3IqfP7L6GLyyTqZXMAIjV0KccFvRMnC60HffzxxNQumnO+m2QaRpz2Pw8
         o8lElFKrvBPdoGQblllmzTS5VDr+WVtbIkW3dBLY2NWY1+RAfm5cYrmHACdxvO4PnfR9
         W1c2U+NZ7Dr98e0Cx7X4m2DKV/lYVL/1vtX+jx7ziQP3FjIUlF3fIj2BWx/GvcIqqlRm
         PRAjdD3am3PQCu1HheguSGks3EclQoFzFZ828oYoTWdhQKX4u+TwJKz612yQewQsWceJ
         4pdFnHXPXG8nBt8UOpfDW6IhNemmC/YPl8XvLcyuwAre31FuclOsDx35Zcm+uqM+Xi2a
         4uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZx9CgPMpFTkt+CTufj8zDSZxRvAV71WykmfHDTqk9k=;
        b=SLVHHVXdOrtqkxoDduqAlOW0pVmEAnGd/jutsACsf4J57wbrUBqTQeTLkFM8Od+O1B
         6wD/pR7JlOXcPuVFh2lj0nXg7BsCMNitd9MSl/9rGHwXCQd7yntASpbOtsv/hMibaBrY
         PqTEtj9AFka3HMUCZAXNgPuAzXaMYiR1VBF9vluCIJLrl8/E2es5ho+1gypjbUS4a8v9
         WxCgTWKcMhVHVynjbhHkz4I5fCTBj0jzTbQzKFjWUrNB85yXc45hKx0uwwDkIVzF3+ok
         Ox6oMnQh+cwjcZb65z5ZjR1p8oVC6rRdip0VYT0tY8nLCYvIRWn6wzrvcJWb/GIm5H68
         MsOw==
X-Gm-Message-State: ALKqPwfTRpQofpzxAcg9oLTXPRoy2Bs88R/sIDRUgUrehTc0wTDI/ipT
        zDuBm4B4V693k7J5Hav/s2txyzS8
X-Google-Smtp-Source: ADUXVKJ9ediF4xjWy+dx1Wl4n6Niy3egwb9AVSwvbceyruBaIA2lQQIPdAjc+DTX1t09B+Lp/520gw==
X-Received: by 2002:a50:aec8:: with SMTP id f8-v6mr9110655edd.72.1527795200099;
        Thu, 31 May 2018 12:33:20 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.gmail.com with ESMTPSA id z44-v6sm10574038edb.72.2018.05.31.12.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:33:19 -0700 (PDT)
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
 <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
 <CAGZ79kZ7HiyZTS40XPwpjN3PBbdW0ETN=dfzeE-90Rp+irXnSA@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2bf2d178-d286-c566-f68e-79c70fe66dbf@gmail.com>
Date:   Thu, 31 May 2018 21:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ7HiyZTS40XPwpjN3PBbdW0ETN=dfzeE-90Rp+irXnSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Le 31/05/2018 à 20:44, Stefan Beller a écrit :
> On Thu, May 31, 2018 at 10:48 AM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
>> Hi Alban, it's great to see you working on this
>>
>> On 31/05/18 12:01, Alban Gruin wrote:
>>> This series rewrites append_todo_help() from shell to C. This is part
>>> of the effort to rewrite interactive rebase in C.
>>>
>>> The first commit rewrites append_todo_help() in C (the C version
>>> covers a bit more than the old shell version), adds some parameters to
>>> rebase--helper, etc.
>>
>> I've had a read of the first patch and I think it looks fine, my only
>> comment would be that the help for '--edit-todo' is a bit misleading at
>> the moment as currently it's just a flag to tell rebase-helper that the
>> todo list is being edited rather than actually implementing the
>> functionality to edit the list (but hopefully that will follow in the
>> future).
> 
> Would you have better suggestions for the name of the flag?
> Of the top of my head:
>   --write-edit-todo
>   --hint-todo-edit
>   --include-todo-edit-hint
> not sure I like these names, though they seem to reflect the
> nature of that flag a little bit better.
> 

As my next patch series will probably be about rewriting edit-todo in C,
do you really think I should rename the flag?

> If you feel strongly, I'd rather see Alban drop this second patch and
> move on instead of waiting for our argument to settle. ( I do not feel
> strongly about it, but put it out as a suggestion as that seemed like
> it would lead to a better end state for the project).
> 

Okay, so I drop this patch and reroll the other?


Cheers,
Alban


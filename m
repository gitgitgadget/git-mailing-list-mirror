Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241C61F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeEaTld (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:41:33 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:41343 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbeEaTlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:41:32 -0400
Received: by mail-yw0-f173.google.com with SMTP id s201-v6so6193597ywg.8
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zI+JgtZpuOYVCcEqS7GEbcSfssYXIcm7yeEQjg+/TDY=;
        b=rbA4wQ4RWO0dIlMa1hC2ZltA4LJDJ0R5GshXchpP7g8f8O0Fd2xGInknPVTT1w3ZHu
         Go59/Zo3/TqU+diMxg1KrahPAyCDgqwaXopDS6ecDx0CGz5knBzb0X2WDjLMGAY3KADl
         YIr0R8Ke71naCggQCojMLxXzfIN/F1iu9nNEMcr6+Ia/UmKQKHDAwLxchIvLj608uhpe
         E4TqScVHwm2/OHIIaOZdqTIPR+W+27FqEjaBLBoiAaY3JcFjaASY7yDFZI9XuS3amZI7
         kejvyRPKILz69FsGOUYh9+Q7ndF68DAl7thk0Uz8Ee72MWHs4LBRk9cXQ/1kuO/F8YiY
         SmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zI+JgtZpuOYVCcEqS7GEbcSfssYXIcm7yeEQjg+/TDY=;
        b=ia9H3L0ckRarYcFp/+0PXXUFUPi6vRrvjpBeJQn0u+Ps26RP4Sj7Ql1kyTAjQ07w7i
         MGMeLZUIFpbtokTDBbKgET/XNdvpgPHn6inhmOg+QUWzhVTyoHNgpIfsseU0jRXW0KVx
         xgrOO1C1vMKqRls+lq5whU0Wj7jEPPnCBFMbfe6gjt4h6YNoRAOqefPLk9mqJwj4k3bf
         jvxoSO/yrnaK5j5UPo/O4piGRqraXaTN7j/h8QrTxkQWWLBGn6tlTiMVgMDyz07X6FbI
         TKDYUkQ5Y2CQ1lb0Xk82e9ZYJxdGuLQmnRrt7cfuc5JUZJuya4pzcMQl+tVK3oR0Ue0u
         eS2g==
X-Gm-Message-State: APt69E3bvdi78vXWtPuEdmhwXIr3TSmlLra9LEoapCGqSvcs5BEHlHfS
        usLVlWa22sfJwTYWx7vB+MamETaz6m5zts/1pPgBM0X2
X-Google-Smtp-Source: ADUXVKIfrImU6kcuLXdajX/FT5hkUsHrSS5H2aTSlaDrVbvlL60uZJ1Vv5AvigW5pC/tOLmY6S5MKTvAeYCrQYW5s8s=
X-Received: by 2002:a81:4d43:: with SMTP id a64-v6mr1255597ywb.33.1527795691257;
 Thu, 31 May 2018 12:41:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 12:41:30 -0700 (PDT)
In-Reply-To: <2bf2d178-d286-c566-f68e-79c70fe66dbf@gmail.com>
References: <20180531110130.18839-1-alban.gruin@gmail.com> <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
 <CAGZ79kZ7HiyZTS40XPwpjN3PBbdW0ETN=dfzeE-90Rp+irXnSA@mail.gmail.com> <2bf2d178-d286-c566-f68e-79c70fe66dbf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 12:41:30 -0700
Message-ID: <CAGZ79kbj=6FPHYR==kwWyv8DaA5SkhO6jGffAXOi=8Wcn5pL5Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 12:33 PM, Alban Gruin <alban.gruin@gmail.com> wrote=
:
> Hi Stefan,
>
> Le 31/05/2018 =C3=A0 20:44, Stefan Beller a =C3=A9crit :
>> On Thu, May 31, 2018 at 10:48 AM, Phillip Wood
>> <phillip.wood@talktalk.net> wrote:
>>> Hi Alban, it's great to see you working on this
>>>
>>> On 31/05/18 12:01, Alban Gruin wrote:
>>>> This series rewrites append_todo_help() from shell to C. This is part
>>>> of the effort to rewrite interactive rebase in C.
>>>>
>>>> The first commit rewrites append_todo_help() in C (the C version
>>>> covers a bit more than the old shell version), adds some parameters to
>>>> rebase--helper, etc.
>>>
>>> I've had a read of the first patch and I think it looks fine, my only
>>> comment would be that the help for '--edit-todo' is a bit misleading at
>>> the moment as currently it's just a flag to tell rebase-helper that the
>>> todo list is being edited rather than actually implementing the
>>> functionality to edit the list (but hopefully that will follow in the
>>> future).
>>
>> Would you have better suggestions for the name of the flag?
>> Of the top of my head:
>>   --write-edit-todo
>>   --hint-todo-edit
>>   --include-todo-edit-hint
>> not sure I like these names, though they seem to reflect the
>> nature of that flag a little bit better.
>>
>
> As my next patch series will probably be about rewriting edit-todo in C,
> do you really think I should rename the flag?

If you reroll, you could think of doing that. If you have the next series
prepared already that build on top, it may not be worth it.

>> If you feel strongly, I'd rather see Alban drop this second patch and
>> move on instead of waiting for our argument to settle. ( I do not feel
>> strongly about it, but put it out as a suggestion as that seemed like
>> it would lead to a better end state for the project).
>>
>
> Okay, so I drop this patch and reroll the other?

Sure, but maybe give Philip some time to react?

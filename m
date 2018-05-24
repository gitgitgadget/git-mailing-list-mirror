Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EBE1F42D
	for <e@80x24.org>; Thu, 24 May 2018 22:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935907AbeEXWuC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 18:50:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43453 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935803AbeEXWt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 18:49:57 -0400
Received: by mail-qk0-f193.google.com with SMTP id h19-v6so2664319qkj.10
        for <git@vger.kernel.org>; Thu, 24 May 2018 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=p0eoHkLZ8Y/mokAcADX6VfR3dwteOgj7KbpZzYLV8Nw=;
        b=CH+BO9qN8C08eNqPRDcWIKTsDYTFQiEfT1ThDvfu5a4TN/ODTtEhoVaX3M08FF00Nq
         Kyf+TaI4p67XHI4fztzA4DkmZLdEkxa98qql+UPRwQlpG6G4DQTaM/0Ys36wNn1+TC7z
         YuLZvdl7LOjm/JbsmV9dg33xXxzL7Cp4aav4VX7n9Rsi9UtCQbQ3w4SnquO+Rbktb+Tf
         rZu7x/9VF1CkuVbJKp7Th76sakfscfKweW2DrqcZOxjR/SPl6Ycf7bikmkaUcgi0p9tR
         vRScCiA3/1FLSPeg7J/duYsNojI0XJCYLhdcMy4Jzw4M+N6M8oYOQ7dJN/J9Ncx7tE3n
         3qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=p0eoHkLZ8Y/mokAcADX6VfR3dwteOgj7KbpZzYLV8Nw=;
        b=G+qr6gD3azg+5jc3xSTTCER+fpobqtPm+bAm2rvWsmFNZMLaC+2GuBUGYdkpqVEk+t
         gCWCgSWfVvxu5z/Ak+4w9tB3YCYSZbF80AAbgCx77jGtGu3Yh6G5VW4+u7cSCJvV3pKb
         H3ItFTQPv/sYeVx/iTCD7Xk0ltXmDYXt3en3D5hB55W+DjOGmeI+JYW49VbDm09h6258
         AXEzltOYU3sRZwRks4Muft2izH64KlWjEid2oteFg0svENqP3An7RTKsr2HHPIPyxKFu
         PbJlBN0oMMRwtVVNJLzg1nbAURwAiX3mhOIb0KnT1aI1iILgCQV2YUjZAEUp6rL4h883
         xZeA==
X-Gm-Message-State: ALKqPwcFfH8CCex/ucFahRtXtGRvhhAPvYLJTDBblZwWF2/B8lsRsV+Q
        Bs3xCImxtLDxvjTsr89KT6kpWY+MLAA6kAAkfx0=
X-Google-Smtp-Source: ADUXVKJi77BDnqQsCq3CPkQI6GlaWL6OlLNNbQqnyZU8WFHlaB3j3HyxLYIiEmPVfptapbNnrfwJ7OA8wrT/xeslyio=
X-Received: by 2002:a37:71c7:: with SMTP id m190-v6mr8390040qkc.91.1527202196349;
 Thu, 24 May 2018 15:49:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Thu, 24 May 2018 15:49:55
 -0700 (PDT)
In-Reply-To: <87r2m07qz6.fsf@evledraar.gmail.com>
References: <20180524190214.GA21354@sigill.intra.peff.net> <20180524193516.28713-1-avarab@gmail.com>
 <20180524193516.28713-3-avarab@gmail.com> <CAPig+cTr2J6yj39NNdV1vT8CQP2qyPxNB1ggaE9bGgXukuq1yQ@mail.gmail.com>
 <87r2m07qz6.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 24 May 2018 18:49:55 -0400
X-Google-Sender-Auth: ugJyqN0Nw-95xEX-9U8Pc-V9UL8
Message-ID: <CAPig+cQeNDfkwJXNVB0xP50KUPFMKTmJhrCSdsAOJTqcNFegAA@mail.gmail.com>
Subject: Re: [PATCH 2/4] config doc: unify the description of fsck.* and receive.fsck.*
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, May 24 2018, Eric Sunshine wrote:
>> On Thu, May 24, 2018 at 3:35 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>  fsck.skipList::
>>> +       Like `fsck.<msg-id>` this variable has a corresponding
>>> +       `receive.fsck.skipList` variant.
>>> ++
>>> +The path to a sorted list of object names (i.e. one SHA-1 per line)
>>> +that are known to be broken in a non-fatal way and should be
>>> +ignored. This feature is useful when an established project should be
>>> +accepted despite early commits containing errors that can be safely
>>> +ignored such as invalid committer email addresses. Note: corrupt
>>> +objects cannot be skipped with this setting.
>>
>> Nit: This organization seems backward. Typically, one would describe
>> what the option is for and then add the incidental note ("Like
>> fsck.<...>, this variable...") at the end. It's not clear why this
>> patch demotes the description to a secondary paragraph and considers
>> the incidental note as primary.
>
> I could change it like that. I was thinking that later in the series
> fetch.fsck.* is going to be first in the file, and then the user is told
> to look at this variable, so it made sense to note from the outset that
> we're describing several variables here.
> What do you think?

I see where you're coming from, however, I would think that readers
arriving at this topic (generally) do so as a result of actively
looking for it (as opposed to happening upon it), in which case they
probably are directly seeking information about it; the incidental
information is just a bonus after reading what they came to learn.

Anyhow, I don't care too strongly about it (it was just a "nit", after all)=
.

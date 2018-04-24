Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623721F424
	for <e@80x24.org>; Tue, 24 Apr 2018 22:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeDXW7A (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:59:00 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:37817 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeDXW67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:58:59 -0400
Received: by mail-yb0-f179.google.com with SMTP id i13-v6so7586095ybl.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0qeyBreYUf2FLbmI7MFPmJglJ4atJ+lT6qxRbbVCzvw=;
        b=b2kkig4tGHyAKaG8+IMpw8A9mjb0cmHP1PMGlb6S5Wplka08WbCQ46PXFsLpgL562i
         Eo89n0GitQmW6rhP0eYI8yRTRGbvW0B0t6tluFeytNXgnHxkOS3lfGrfB0SS7s6mSWvM
         WsdWgRQL7XLuX44215vO5in9cHpESwUXiqbDcA6osF+UHDo/6Ask6PPHxS03ynplOv1f
         0Ek/swB5joJEXKXGp+2P12NUZC7AXMesGEbKJvv757IOd07jY+p+5PL9Wvcf5C2Q7qz9
         Bh23HiqF3fMt0XG9EG3/z9fmHGHIAN2CbCnimLUo2GwCiwAYGp7jIdO/vFtarCqcywuY
         gggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0qeyBreYUf2FLbmI7MFPmJglJ4atJ+lT6qxRbbVCzvw=;
        b=sI4TPGsWX8Tt+PoOSz/N1Src8Cs5bEk0E3IIFiVPmJ6QDeEVpOJOYOHhm3WXVELz/q
         zjEnOuE1f/57S26Y/BZJE5u3O9TVls7TugnJ2Ei2ogmWwN1XnQ19xiY6RBMD1z5kHjOc
         +zFo/OfjIHFwQn6eEAASiQiO6YC+Vii9PF2glQQnoSNQk7rsBWguOAZ/LQ4QA7kWZYMi
         R/8JlLAQBFCAL0Y7rQrNgjnMeRexu0mpnieymE75/g27pbvExWoqBECwC49MGE1eJZDv
         CR3hG/vAww6oxpDn6wDV6MW0ZbIWOtYfR8r3xWz7k4eNw27DNmfO/MlRxi8ZQxvSofN1
         D6Tg==
X-Gm-Message-State: ALQs6tAZoRu0Zi2rUzhv70rMC41bGLosMkb/1rsH0p8w4lFOC7CYbjJ5
        azkAv8hl2RcGud1JBEqDlYr5vpkKjGedtRV+d3+h3A==
X-Google-Smtp-Source: AIpwx48NpftYFb7dkEdRM+tcVYeNHJY7a9pZdd3aijKf5E5acckeOyrtwr2h1RS5g+wObmUMuvepmzDmcsP5kTmHZ/I=
X-Received: by 2002:a0d:d0c7:: with SMTP id s190-v6mr13745392ywd.33.1524610738441;
 Tue, 24 Apr 2018 15:58:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 15:58:57
 -0700 (PDT)
In-Reply-To: <20180424153736.480b609d0af412ec46311eb6@google.com>
References: <20180424210330.87861-1-sbeller@google.com> <20180424153736.480b609d0af412ec46311eb6@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Apr 2018 15:58:57 -0700
Message-ID: <CAGZ79kZSMURd_s6yxUCJoDjQzu-NjnFzp+740GFnYZurnw_2yw@mail.gmail.com>
Subject: Re: [PATCHv2 0/7] Moved code detection: ignore space on uniform indentation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 3:37 PM, Jonathan Tan <jonathantanmy@google.com> wr=
ote:
> On Tue, 24 Apr 2018 14:03:23 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> v2:
>> I think I have addressed Jonathans feedback
>> * by using a string instead of counting the first character only.
>> * refined tests slightly (easier to read)
>> * moved white space handling for moved blocks into its own flag field,
>>   keeping the enum for the actual mode of move detection.
>
> For reference, v1 is here:
> https://public-inbox.org/git/20180402224854.86922-1-sbeller@google.com/
>
>> Stefan Beller (7):
>>   xdiff/xdiff.h: remove unused flags
>>   xdiff/xdiffi.c: remove unneeded function declarations
>>   diff.c: do not pass diff options as keydata to hashmap
>>   diff.c: adjust hash function signature to match hashmap expectation
>>   diff.c: add a blocks mode for moved code detection
>>   diff.c: decouple white space treatment from move detection algorithm
>>   diff.c: add --color-moved-ignore-space-delta option
>
> I'm not sure if we should add a new "blocks" mode, or if we should
> modify the existing plain mode to have the minimum block length instead.
> I reviewed the code as if we want the new "blocks" mode.

Thanks for the review!

I think keeping plain is useful, see 176841f0c9 (diff.c: color
moved lines differently, plain mode, 2017-06-30)

    diff.c: color moved lines differently, plain mode

    Add the 'plain' mode for move detection of code. This omits the checkin=
g
    for adjacent blocks, so it is not as useful. If you have a lot of the
    same blocks moved in the same patch, the 'Zebra' would end up slow as i=
t
    is O(n^2) (n is number of same blocks). So this may be useful there and
    is generally easy to add. Instead be very literal at the move detection=
,
    do not skip over short blocks here.


Although if we do not care about that use case we can just add heuristics t=
o
plain.

As eluded to in =C3=86vars email, we might want to break it up into multipl=
e
options as well?

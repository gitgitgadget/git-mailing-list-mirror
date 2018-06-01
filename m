Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1421F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 09:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeFAJ5F (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 05:57:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52987 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeFAJ5C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 05:57:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id 18-v6so1885902wml.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=y1ymiGbNNBTl6YTZ//ccHmg+dPdXZm4nAWMw7V9Py8I=;
        b=N5+vfi17vuw9sXaTRmQ58SoOcuBKyD5xNrRrSN5WZFnQ2Jpxgn704ZSu6A+ttSeREr
         s4Y5MMqp1Ipo6GHodSTSc+BM4YdxMQyqLiLaudNM1GqLk626q/MV+Qga+scVPWr+vsuP
         0HWN3EXAPJ/XgtdK/9NTSn24wQlV7dLijSGsK3S/3DUGULq/aJIbkJE/+XukDm3Zhyue
         rpW3BrXhy/gUpjZcWgsaYn2dR3wDIG1BMtCKLGSTVlR0tnibCPOHJJLS9TCmAVbWpw2t
         TLHWVwYvjEEzRtVWha4ygFjkRNFIUKoD3mrDHGfUNPSsvaRpdmT16O/DgK6pAVV6UdFc
         9OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=y1ymiGbNNBTl6YTZ//ccHmg+dPdXZm4nAWMw7V9Py8I=;
        b=ZHO5t0KgVojZSuoB6/gnh08YltpdNAvZloq+/c5rSymDmIn24TA0P7lP1M8/8/kUAI
         MmFMIKpwUjxQY/FILEeVLelGFTsiUw7rlnwO885NV27vyOSkaIOztlP5oMC/Ox5Pke92
         9yrhxgCGN+jYitQVoNwXvvAxJGSNlK0ERsXJUVIBgDZG0e+VhAnldaLY4EBkAweYd+D0
         ssgx3Xdu4MCNoSrmt9s3DLz0tOt9mMeM32obU9WLPJ7P8R+ymqE9ZTVEgVxLctnH+/5Y
         wUIx3jm4EN4p/OZjldxjt5BkoNwKlZX4r/m7fuWRLj2UMsCaIEWb/Ttl7+X2AEdyZb3t
         9YGQ==
X-Gm-Message-State: ALKqPwcYWPgDEikHXqY9+i4iYP2qcLBviNUxg2Bz8tEOisWGmNFs/Lpj
        OpJbBTIUr0XABrmrPmESz25n8jgt
X-Google-Smtp-Source: ADUXVKIYSFwWcc98ZzxEg9Jz9QpzkkyDUi2lnCbDi/ApUY0+IAHHVKbgqB2y4doscT5mVZce2sOL4w==
X-Received: by 2002:a50:9642:: with SMTP id y60-v6mr11587717eda.125.1527847021721;
        Fri, 01 Jun 2018 02:57:01 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y63-v6sm23015216edy.63.2018.06.01.02.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 02:57:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/9] checkout.[ch]: move struct declaration into *.h
References: <87a7sg9sjz.fsf@evledraar.gmail.com> <20180531195252.29173-4-avarab@gmail.com> <20180531214546.GC26159@hank.intra.tgummerer.com> <xmqqpo1b9rs8.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqpo1b9rs8.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 01 Jun 2018 11:56:59 +0200
Message-ID: <87zi0e96dw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 01 2018, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> We seem to have plenty of structs defined in '.c' files, if they are
>> only needed there.  Its use also seems to be single purpose for the
>> callback data, so I'm a bit puzzled how having this in a header file
>> instead of the .c file would be helpful?
>>
>> I feel like having only the "public" part in the header file also
>> helps developers that are just looking for documentation of the
>> functions they are looking at, by having less things to go through,
>> that they wouldn't necessarily care about.
>
> Yup, sounds like a sensible criterion to choose between <*.h> and
> <*.c>.

Yes this makes sense. Thanks both. I misunderstood the idiom. Makes
sense in hindsight (& with both of your advices) only to put structs in
the *.h if it's actually used outside of that API. Will move this around
in v5.

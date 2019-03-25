Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DAC20248
	for <e@80x24.org>; Mon, 25 Mar 2019 02:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfCYCWE (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 22:22:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36079 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfCYCWE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 22:22:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so8302567wrd.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=D8X2nnZs5mDq1zsYJoGunCGHUCHFYwUjBI2bI9cNQ7k=;
        b=cbYRdLWT/MePfY+vZ/lfTJ7p6ou1rJ2c7dh+epD6jxRuETxgtJTDtGnezXtNe6A8My
         cz1o9mbkBAyg+RjAm6Ud/uj1REvkQp3ovKfvAfAe2gWuTA/YWUt9EaPYeVujOykmDqE2
         VsPdJKA0qL9FObcDT7zMJKy6f7iyOjtUon8TjJvStcoKlShHkQ0Mg6iUixHuf1YUDXia
         otXHPc46xm3ZXhbsBMO7mh34ojkfDONpHCsUwXlBrdL6zYXs5ESuRmq92/eVY+0z6abn
         2hrmoyq+lYCCRuHTwy9PZN+QTG8MqJKsz2/13x3yxM+vJqDSVq2L02pMsOb1F53Fd5IF
         cirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=D8X2nnZs5mDq1zsYJoGunCGHUCHFYwUjBI2bI9cNQ7k=;
        b=ldVxDTYRcxKt/5lkIThbk18/qtxOvk/r2IeKFlr0MFawQvm/AsivaCONsJUjz7GERB
         LerHmXJx2aXFQxNXSDvxtNVcgajru2+eWQt//mQqHwg05xDW8UDykzv+h3+Sbzs5eWpi
         v+zJX0GKtMJod1pp4c6f47FLGBjzxwbPnvBszQ7KVaPM3ed9mSeXy33S3zA8rBItAoaZ
         AbEfPCpq6sXPTjoOroYv+nA8KvgsotkFeRZIxFVMdK3utw/yOvSK+rR/QkpAlHYf5fN0
         rl8BUF8EzFS7BrcXfBIimbYJxxvpQQviXjI1j8Y+9av7+1okeX8gTZE5VMbiKa8f8F2N
         5ROg==
X-Gm-Message-State: APjAAAX1wq8pwItHTFr9Jfm8hLFY1s8ZS5PRo2XFTqc+Ly2Ac9JlnkT7
        dIZE9PZeS39XgHMxSKKFUUY=
X-Google-Smtp-Source: APXvYqwuiqOOgQNZMcmBlPH9FKbN3Gw/r8J160Bm04Ht4edo5acMDTEKZ9DhFb7pqUhFM57TdHuxgg==
X-Received: by 2002:adf:b6a3:: with SMTP id j35mr14032956wre.25.1553480522441;
        Sun, 24 Mar 2019 19:22:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l3sm11481846wrr.25.2019.03.24.19.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 19:22:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v3 1/1] trace2: write to directory targets
References: <cover.1552519463.git.steadmon@google.com>
        <cover.1553202340.git.steadmon@google.com>
        <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com>
        <87bm21coco.fsf@evledraar.gmail.com>
        <xmqqlg14pi2x.fsf@gitster-ct.c.googlers.com>
        <87a7hkcome.fsf@evledraar.gmail.com>
Date:   Mon, 25 Mar 2019 11:21:59 +0900
In-Reply-To: <87a7hkcome.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 24 Mar 2019 15:51:05 +0100")
Message-ID: <xmqqlg13ofqw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sun, Mar 24 2019, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> The reason I'm raising this is that it seems like sweeping an existing
>>> issue under the rug. We document that the "sid" is "unique", and it's just:
>>>
>>>     <nanotime / 1000 (i.e. *nix time in microseconds)>-<pid>
>>
>> If it is just that, then it cannot be unique, can it?
>>
>> Let's just fix the wrong doc and move on.
>
> I don't see why we wouldn't just fix the SID generation & move on if
> we're already carrying code purely as a work-around for it not being
> unique enough.

The thing is, the yardstick to determine "unique enough" depends on
the caller.  In this codepath, we want the uniqueness within the
directory that was given to us, and one reasonable way, among the
most sensible ones, is to ask open(O_CREAT|O_EXCL) and it makes 100%
sense to fall back with suffix when "enough" thought by the callee
turns out to be insufficient when judged by the caller.

So I do not see the .%d suffix a work-around at all.  I view it as
an integral part of the whole package.

By the way, is the "nanotime" implementation that may be in compat/
fine grained enough?

> Of course nothing is *guaranteed* to be unique, not even a 128-bit
> UUID. The point is to pick something that's "unique enough" given the
> problem space, which is already one where we'll ignore I/O errors on
> writing the file unless you opt-in to a warning.

Yes, the point is to pick something that is unique enough and then
give a reasonable fallback when it turns out insufficient.  I think
".%d" suffix is one reasonable fallback, but I realize that it is
not the only reasonable fallback.  Another reasonable fallback could
be "upon seeing a failure of open(O_CREAT|O_EXCL), we give up and do
not leave a logfile, because this should be a rare enough event as
our assumption is sid is unique enough for everyday operation".

I could buy that, especially if the ".%d" suffix fallback is too
expensive to carry and maintain into the future.  And in such a
case, it indeed would be a more reasonable workaround for a rare
non-unique sid problem to ignore and discard the log.

I just did not think the ".%d" suffix fallback is too expensive to
carry.

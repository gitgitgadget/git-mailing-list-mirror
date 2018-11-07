Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3C51F453
	for <e@80x24.org>; Wed,  7 Nov 2018 12:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbeKGWIs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 17:08:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39461 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKGWIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 17:08:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so17220420wrv.6
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 04:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5KkgFg66VB6ox8Tr+yi5UYhpO1TQwgOrCDwiSnlQ7h4=;
        b=Q4FNALyZSDkl9ezkXRcCMu/Rv37bOJ4maqX3QTI5oRLaTr2NwjniTDPBvkyexztZ1I
         O/hf1yoj9yzH+ihFV7qc3nis8op9AP3fhy6gwYQOYG/CLm3xsErUF0NSCBbwEjpKGwqc
         6xRkKMa32HRB9aJeUI4RRTBmtnK15nIGTnsvxUGdpyj7GQRPhzLiqO9/8RbE0l0bZY1j
         642qzRnZWM+QLMqq1M/01Z7UdQ1Gtcp5O1vyBYc+77F4VxzQEStwi+1+4tLodriKcrxK
         N0bMpzVVyhR4xHBKWDcQh47ZED9qD10O4T1W5FK/t+PC4m9gYDY8W6lMEiQFBg9OZU7J
         8T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5KkgFg66VB6ox8Tr+yi5UYhpO1TQwgOrCDwiSnlQ7h4=;
        b=QLDzA1d7w3WB+oWYBtkGhG2yjDGVtbmae5zOeoCVUWELj1l6s9WEp6vOCgS63GX3Jd
         B6HS3Qp/T1eiuo257nrL002HAEt3JZWxu/jFHQGXZMAARwnQSWNcopQA6MDjVyvIHXwq
         y8LAWYzR7HpooKQcTvEuJ4keAvv6WsWYxAe7hZDESu878UnjUE9OmMPcvTvr73RtYHTT
         uW6G9MHpulOV8EJgxipDgOwR73eRAzhVUTEKWeoFXyGpBfwqhPHR9iMiGi4Q3Po3oAsl
         ge0l0upexMg/yCmk5Ob2KRQHruuRvPtAg5P6yflbkIhoABMlvCHbeBfkCBMXfiP6vs+R
         heOg==
X-Gm-Message-State: AGRZ1gKI3rqJzC4vXNln29u/tHGAIJ8oJrT7sA36cG2csifxHujYic/Z
        f89UMNDa1F8whomBttSruXM=
X-Google-Smtp-Source: AJdET5eCgR67xbuMjq/J7eDNP86Em/Nuwh08X6KJUaA21v7BPiw2V7sYx2/gy0u0qtEkf3SEuFxmlw==
X-Received: by 2002:a5d:570d:: with SMTP id a13-v6mr10742wrv.289.1541594312617;
        Wed, 07 Nov 2018 04:38:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l186-v6sm2040728wma.13.2018.11.07.04.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 04:38:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
        <87sh0d5av3.fsf@evledraar.gmail.com>
Date:   Wed, 07 Nov 2018 21:38:30 +0900
In-Reply-To: <87sh0d5av3.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 07 Nov 2018 13:29:52 +0100")
Message-ID: <xmqqtvktawqh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 07 2018, Junio C Hamano wrote:
>
>> * ab/range-diff-no-patch (2018-11-07) 1 commit
>>  - range-diff: add a --no-patch option to show a summary
>>
>>  "range-diff" learns the "--no-patch" option, which can be used to
>>  get a high-level overview without the actual line-by-line patch
>>  difference shown.
>>
>>  Will merge to 'next'.
>
> Per <20181107122202.1813-1-avarab@gmail.com> it turns out this whole
> thing should have been a bugfix instead, sent a v2.

Thanks.

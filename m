Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E4D1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeCHXoh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 18:44:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34406 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCHXog (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 18:44:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so1213767wmd.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zkqpY6j6ToYuVnVqFq+xCIvmQ8BzuLC3whYySG4Lwec=;
        b=Xode+gUWmrY4Yhf8iEBMmdipxHGBxqGvzhBQd9swgTahqHB4JKO6NlFzongyYWlHYY
         cOgMpVi4XWcaLrLQEVcHtZIunI32fKhXS0T2u5KhcSU7dSQBs5j04IOhYUS7OCXmdIkz
         w4j41ntEs6KmrZoyqE8fG+5yJwhFVy4Q10FhvZx9rvsPEnyQTMnG6Dy0+/s18NaNV0WD
         YmIomcO0Orw99B2HYYgZkNU2xmNN/GSLHAbdPkl+6vSwupN/yTkd7kFOtgxGLcbSpD4H
         vItJQw70/kVYNmb0Ws0lQkrV+pmsCALMNE/S14LqPY20Y/uWlTQA/EaKolAX2BIPjvfO
         n1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zkqpY6j6ToYuVnVqFq+xCIvmQ8BzuLC3whYySG4Lwec=;
        b=gdPfs0V6bfxebyVFQxEr+ZCr8qFebu0rolTEzR062cfbgjw83MYZpoMQqXcy9xL86X
         OyknfGHowIO+Lhpgphj5C6AAFVH6kIs4hTWxwrKJGYkOQSUHivmwfUDr22UEMw/0CBKV
         Av5HOr4nePnLQtth2WhbFLpRXolNAXIpW/YOwRgki5Ftud6IgTRI7AtlzXpuPD+6zVmg
         duu5PjrCvumEiAuLOq5Wnw6BsJey7WNndXBl6fgb/ZeePF9atqv8oZY4pih61h2POvvw
         v9Aiirb3Rx0+pGuSXdj+B3bQRY6AZkVkC1fAvOXjZq2frgbDZHDPFNYdB3pN1aaPHTTW
         fkEQ==
X-Gm-Message-State: AElRT7HtCXSXWTZNWakFCdOOmNcw2wFeDtKXjWruUzEep9Rq0lGeBTBg
        9PBT+GPLacypSEBvm28/nHM=
X-Google-Smtp-Source: AG47ELtLEN6jBPevr3br13Y7eSyVX2SUXnQ3Ec1kNvZR6vEpQtApNlGL3+wqN3o+boely7d2FX2vNA==
X-Received: by 10.28.231.6 with SMTP id e6mr431242wmh.51.1520552674796;
        Thu, 08 Mar 2018 15:44:34 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u20sm20971607wru.94.2018.03.08.15.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 15:44:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1.1 1/2] t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'
References: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
        <20180308224458.5730-1-szeder.dev@gmail.com>
        <xmqqzi3i6t2v.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjkkFR-zVQMMqp0pJn489bV1uqEHZkB8Mo789J0K+qO3vA@mail.gmail.com>
Date:   Thu, 08 Mar 2018 15:44:33 -0800
In-Reply-To: <CAM0VKjkkFR-zVQMMqp0pJn489bV1uqEHZkB8Mo789J0K+qO3vA@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 9 Mar 2018 00:41:48
 +0100")
Message-ID: <xmqqvae66ske.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Mar 9, 2018 at 12:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>
>>> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
>>> index c30660d606..5ff3789199 100755
>>> --- a/t/t9400-git-cvsserver-server.sh
>>> +++ b/t/t9400-git-cvsserver-server.sh
>>> @@ -449,10 +449,9 @@ test_expect_success 'cvs update (-p)' '
>>>      GIT_CONFIG="$git_config" cvs update &&
>>>      rm -f failures &&
>>>      for i in merge no-lf empty really-empty; do
>>> -        GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out
>>> -     test_cmp $i.out ../$i >>failures 2>&1
>>> -    done &&
>>> -    test -z "$(cat failures)"
>>> +     GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out &&
>>> +     test_cmp $i.out ../$i || return 1
>>> +    done
>>>  '
>>
>> This makes "rm -f failures &&" unnecessary, no?
>
> Indeed, it does.

OK, no need to resend, as I'll amend it locally before queuing
(unless there is something else that needs updating, that is).

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A1B1F42D
	for <e@80x24.org>; Mon, 28 May 2018 21:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934348AbeE1VqA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 17:46:00 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55824 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934340AbeE1Vp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 17:45:59 -0400
Received: by mail-wm0-f42.google.com with SMTP id a8-v6so35142516wmg.5
        for <git@vger.kernel.org>; Mon, 28 May 2018 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0D1O+amQaa1DjUe6WbuBG7igvatswjlFROzI/PWN0gU=;
        b=IeGFCCc67VwBGAEbgg5tf14keLFu0mCeIF04jfr5IkUXaGceImrmVi8G3OBx793vCJ
         wM3p+MvOpHxcFPWntqxC0IeJc+3tYKYsoHTcasS2QRZWsNcpDjGFHhWTBurv945W/HVX
         1sh7Zy2U+U8om/2VWIDZLzdvrXE3j620cnL4xxE6dzCrrXAttkbrqB6BF5oR6IZrAK7k
         59inPwhoy1U8fwVfzH3u8I6HekcGT8xUJnaNoHsElakWfqCfomIlkPsQ79IVQOM3y3YG
         OSODgCIZMjakUFZrcwy2A9FkD0LY3L5Hryy6YGLjtd/4cnitsGV7AxYLSwoOzM1iZtrW
         8tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0D1O+amQaa1DjUe6WbuBG7igvatswjlFROzI/PWN0gU=;
        b=YhM7ChYowOoeCHZhVpd4OrvM19JG1fFCiwUC65CqjcWHnNQPYZpMCQTXGQt1Cm8yut
         FyL+cs+YIzmHrngEplVuadpfHiyHNjRQncJmCBhjEfrYP8q9A3tfJTfrgeA/9Xw07ltI
         ZCmhYTUlvX8wevpz+oxuo3T2uXAyA6LIl3r2CHOhDb+kTCTXYmYe6jd42akMmpbH9eeu
         bbR4qwFp3vxB+h3agrBVH4FbWzLISSsDmXrLHJv+IizvgqgkJMem6I1jVYVSs/Y8aAuM
         K/fTbFBWvv+lYb/Ox2MDIKcxxUJAtfRqBDGjdeTNCdUWPbSpK2xTL+9Qhm60As57ojMP
         KDAA==
X-Gm-Message-State: ALKqPwd/nIF3eLrPcuHBnse3kB6IiQvH1yiM0j5r03B94oBmo0EnGb12
        Gdh8/hcU6FQXKgNaxVrsC64=
X-Google-Smtp-Source: AB8JxZp0s4dRRMKn0n2rGpJUJeVLz3owKarfpay5Md2ytA/cQ6RI5+15wVFc3t+cuV4D1tqyRZXH2Q==
X-Received: by 2002:a1c:d810:: with SMTP id p16-v6mr10594976wmg.133.1527543957560;
        Mon, 28 May 2018 14:45:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f15-v6sm18242252wrm.52.2018.05.28.14.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 14:45:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just the first
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <cover.1527279322.git.martin.agren@gmail.com>
        <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
        <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
Date:   Tue, 29 May 2018 06:45:56 +0900
In-Reply-To: <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 28 May 2018 20:45:19 +0200")
Message-ID: <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>> +error:       sub/added
>>> +error:       sub/addedtoo
>>> +error: Please move or remove them before you switch branches.
>>>  Aborting
>>>  EOF
>>
>> This shows the typical effect of this series, which (I subjectively
>> think) gives us a more pleasant end-user experience.
>
> Also, very subjectively, I'm torn about this. To me, just one
> "error/warning/fatal" at the start of the first paragraph feels much
> better. If we have to somehow mark the second paragraph that "this is
> also part of the error message" then it's probably better to rephrase.

I personally can go either way.  If you prefer less noisy route, we
could change the function signature of vreportf() to take a prefix
for the first line and another prefix for the remaining lines and
pass that through down to the "split and print with prefix" helper.

That way, we can

 - allow callers to align 1st prefix (e.g. "error: ") with the
   leading indent for the second and subsequent lines by passing the
   second prefix with appropriate display width.

 - allow translators to grow or shrink number of lines a given
   message takes, and to decide where in the translated string to
   wrap lines.

Even though step 3/3 may become a bit awkward (the second prefix
would most likely be only whitespace, and you'd need to write
something silly like _("\t")), we can still keep the alignment if we
wanted to.


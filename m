Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC6C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbiAEOFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 09:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiAEOFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 09:05:20 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41010C061761
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 06:05:20 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p65so48600272iof.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 06:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nUQPQ07Fz0CEo20W3b6CzfWQ7kZi/rdjcZYDm4+1sSU=;
        b=Bok9LR7mBEMrK1ZwKtS1t7l6ii6ssmbsKpvSLBrIOU+Y5mrbVEbvf/fEMqAvDt9Vbi
         yHz2/7kTwFRZjSjpuSuLA67qJ7MjNeG7cbsgQZcRT2FxeK9xSUWtG2s6TRuSnlZrD088
         vbrbOs75RsOKDVngZ8T+UKRQuP0Ppo3+ju9PRrksFyVN7lFu/ZNek2V+Q2ilJDrVGynF
         RZDy6ktnliKH5LgbAEunlZIYvNO9opFto/i4zH4yamRRe/u+tcJkh/6ZfMR7ksTX+g1g
         jCxMKewiTJnR8jhhwsYBqvNvyv1H3eiUeO+1kGSbh73os1cZq0wmDPIdfEvUfl+dioCB
         E6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nUQPQ07Fz0CEo20W3b6CzfWQ7kZi/rdjcZYDm4+1sSU=;
        b=H2FnrgsPx9gYjSts8qRo+IqVYxoXwmIqCSA7KM/mzH2MeBfjCb7NDNfmyTe+D1TpZx
         CYLVnRCcil+zRABwVJV5MWvAcF9OijCrZuh+fnWzhnmUbE2JXDWBCl2DN20OcWbaqG1F
         HYt9GUyz8XwiCPTBCyNSOGhBaKcpnj1aYTouuWQEb+mgXBcQgcHGH1prDcdrsLveDNJz
         S93pcYmalOgZNnswiYlMDucs+2MN+0HhFYKw7VSfNYO2tPLq5tHNerqNO6XeQuyDcsEj
         EoGLFCQdNhO9cj33XtIemwwC04YQuC/hqUiDKjp5+AZPUgsMZgdCvRfb0k+EWsTUovYS
         frnA==
X-Gm-Message-State: AOAM531idX79avo7MMf8XY+yZv3s3w9YHYhupRkOygYAQzQvPLA7fOQ9
        Hx7gb6ljGkVryWqtQv2PAOs=
X-Google-Smtp-Source: ABdhPJxVEsJ0I8W7zZ4CGDagQpvR3qREAUSNxqI08ujspXIJa/eoBKt0banCGXokN72ESCLgos7+Iw==
X-Received: by 2002:a05:6638:1302:: with SMTP id r2mr23877614jad.37.1641391519671;
        Wed, 05 Jan 2022 06:05:19 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id v23sm25727990ioj.4.2022.01.05.06.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 06:05:19 -0800 (PST)
Message-ID: <52d638fc-e7e7-1b0a-482b-cff7c9500b92@gmail.com>
Date:   Wed, 5 Jan 2022 08:05:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
 <xmqqy240l8l1.fsf@gitster.g> <d65bf6bf-8f60-31c2-7d01-e57ea6f4a5e3@gmail.com>
 <CABPp-BGSVzEwk83EzhPn3+5jOt5q6=CQ2W_Uz6GfUR=2=AhgNg@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BGSVzEwk83EzhPn3+5jOt5q6=CQ2W_Uz6GfUR=2=AhgNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/4/22 2:25 PM, Elijah Newren wrote:
> On Tue, Jan 4, 2022 at 11:26 AM Lessley Dennington
> <lessleydennington@gmail.com> wrote:
>>
>>
>>
>> On 12/31/21 4:20 PM, Junio C Hamano wrote:
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>>> Second, and this item is unrelated to your series but your comment
>>>> made me realize it....sparse-checkout unfortunately ignores prefix and
>>>> creates a bad .git/info/sparse-checkout file.  For example:
>>>> ...
>>>> I think the loss of the current working directory will be fixed by the
>>>> en/keep-cwd directory (currently in next and marked for merging to
>>>> master), but the fact that the wrong paths end up in the
>>>> sparse-checkout file is unfortunate.  It basically means that the
>>>> `set` and `add` subcommands of `sparse-checkout` can only be safely
>>>> run from the toplevel directory.
>>>
>>> You made it sound as if this is a fundamental limitation, but it
>>> sounds more like a bug that needs to be fixed (outside the
>>> completion series, of course) to me.
>>>
>> I can file a bug report if that's the correct way to proceed.
> 
> We don't really have a bug tracker.
> 
> We often just file an email, and add additional searchable strings
> (e.g. #leftoverbits, though that doesn't apply here), and then search
> via https://lore.kernel.org/git/.
> 
> There is 'git bugreport', but it just generates an email to send to
> the mailing list...but we already have the emails in this thread.
> 
> There is https://bugs.chromium.org/p/git/issues/list, which is used by
> a few folks, but I suspect I'm the only one who has looked at it that
> touches sparse-checkout related stuff.
> 
> There is https://github.com/git-for-windows/git/issues, but this isn't
> Windows specific.  (Sometimes they'll track stuff that isn't windows
> specific, but I've seen Dscho close out issues after being reported to
> this list.)
> 
> I've also kept private files with lists of things to work on.  Doesn't
> help anyone else track it.  (Which is why I'll sometimes use one of
> the two above trackers instead.)
> 
> ...not sure if that helps, but that's the basic state of our "bug tracking".

This is actually great context - thanks for providing! I'll go with the
email strategy for visibility and will base my format off [1].

[1]: 
https://lore.kernel.org/git/CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com/

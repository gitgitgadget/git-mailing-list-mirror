Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA2C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165E061A88
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbhKPTrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbhKPTrh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:47:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F70C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:44:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w29so39689442wra.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=42BE+qdXBEWEDWh2Nala2YbODXku4QabUXveFxh8yL4=;
        b=g69reRCZ6K1E7WzOWUi8BICQ1vgpIxpwwkopjKew2iCQGK18gAFC8fQFYdqyVF4bMz
         IZOPdaVRog/3Lb5VPP/qWeL8OYC99SPC5XyEomg22nEEfZ05gz2Dp/Noem1oRUpYHYg7
         86W+kj8IGRL+jLRTnwI89xyO4Dc9RGf7ZaWMHoVWHDYK83HHhWNEXs0bPJFk124nPIco
         RGw2hL4dOQgmYvZZzJiABYIvUNVrxySlE6vZbalDJhDV/5QmCM3quMvI6F+dg0DY/vHq
         xFOqLcKxYO1PGsmV+kmrEgampkVCU27RyjnvcvxBkOLuwOQVVaT4S84u1YVzuxXN0uFz
         aFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=42BE+qdXBEWEDWh2Nala2YbODXku4QabUXveFxh8yL4=;
        b=ZrU/rihmv7TwdbVbv1xmF0HZvXtHmnHI5BmDoxUnNWBos9WA/APSEuWrraLnFyPBN8
         f6ov8XY29i4OdMzOaigqPdsVcxtb8EnEsUsnFfAoEFL1SXUDWf1IP3+h/J680kawrXLy
         fjYj511KIv3cRHaCDG0tmr+nshoDwa8dV/y7+jY1X/KarSiO3n665c4xuW0SoFzvlEJC
         qcVSbMXmcqGvCjoJjQ7tfPbSW43WYIbkJ3ld1F2ZBqFZ+c69q/bczdeHiKahdBtNbHgU
         WX4vOpFZ5g0nQRwrfmv4NCnk+hryG/aaeQXoJABzJuHx+auRug1Jd0NbrUa9OjMmjHjW
         0xxA==
X-Gm-Message-State: AOAM530g5cxUfnJJU9He0dzw62Qy19SM1RANyjqbwdd+jkF6XsgJldRf
        5YNHUm/1ldSE/9b3r/mstIw=
X-Google-Smtp-Source: ABdhPJyudDoDMeK/eEkUObC9bAExWPd088y2Kj8sgsI21dvQiaKtuwqOUwSRda5p6hu3nS1HQpqWgQ==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr12097692wrs.437.1637091878286;
        Tue, 16 Nov 2021 11:44:38 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id s8sm5707689wra.9.2021.11.16.11.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 11:44:37 -0800 (PST)
Message-ID: <a1961817-27d4-5be5-3b6f-231b77d3b916@gmail.com>
Date:   Tue, 16 Nov 2021 19:44:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Content-Language: en-GB-large
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YZOh370ZMMqSADUE@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/11/2021 12:19, Jeff King wrote:
> On Tue, Nov 16, 2021 at 02:12:41AM +0000, brian m. carlson wrote:
> 
>> The C99 standard was released in January 1999, now 22 years ago.  It
>> provides a variety of useful features, including variadic arguments for
>> macros, declarations after statements, variable length arrays, and a
>> wide variety of other useful features, many of which we already use.
> 
> I like the idea of being able to assume C99. And I know this list is
> just "here are some things we could do". But I'd like to express caution
> over variable length arrays. We've already had problems with alloca()
> causing stack exhaustion, and VLAs are basically the same thing. And the
> worst part is there's no way to recover; you just get a segfault.

I agree with this, also C11 and later make variable length array support 
an optional compiler feature which is another reason not to rely on them.

Best Wishes

Phillip

>> Let's add a test balloon to git-compat-util.h to see if anyone is using
>> an older compiler.  We'll add a comment telling people how to enable
>> this functionality on GCC and Clang, even though modern versions of both
>> will automatically do the right thing, and ask people still experiencing
>> a problem to report that to us on the list.
>>
>> Note that C89 compilers don't provide the __STDC_VERSION__ macro, so we
>> use a well-known hack of using "- 0".  On compilers with this macro, it
>> doesn't change the value, and on C89 compilers, the macro will be
>> replaced with nothing, and our value will be 0.
> 
> This part makes sense to me. The macro check will complain if any
> compiler isn't C99. But this hunk seems like it is going to cause
> headaches:
> 
>> diff --git a/Makefile b/Makefile
>> index 12be39ac49..893d533d22 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1204,7 +1204,7 @@ endif
>>   # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>>   # tweaked by config.* below as well as the command-line, both of
>>   # which'll override these defaults.
>> -CFLAGS = -g -O2 -Wall
>> +CFLAGS = -g -O2 -Wall -std=gnu99
>>   LDFLAGS =
>>   CC_LD_DYNPATH = -Wl,-rpath,
>>   BASIC_CFLAGS = -I.
> 
> Do most compilers understand -std=gnu99? It seems like we're breaking
> the out-of-the-box build for everything that isn't gcc or clang.
> 
> I understand that older versions of gcc (prior to 5.1.0, from my
> digging) default to gnu89, and so they would be broken _without_ this.
> So it is a tradeoff one way or the other. But somehow this seems
> backwards to me. We should assume that modern compilers support C99 out
> of the box, and put the burden on older ones to trigger C99 support in
> whatever non-portable way they need.
> 
> I also checked clang, and it looks like it has defaulted to gnu11 since
> clang-7 (I'm not sure about clang-6; its documentation wasn't clear).
> 
> -Peff
> 

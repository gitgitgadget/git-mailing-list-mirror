Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482AC1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbeHAR2N (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:28:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40674 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389698AbeHAR2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:28:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so7582122wma.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uOord+kfHsh3G2k0acV0n6jUJxNppObvJZgTTMmJf1I=;
        b=kdBQLgo0IXPciFSMxl3UqRXPAUDXfnJhddUw/FLUq0dE3abIFws8w/P0FfvQhCWIuY
         OiyeqMs9kyVZ0KXy1UWdVYNvJsTN/payZsFxbc9gmNLIWZHoU4f3hEVPXraMEKQVF6DL
         ZhJCdhM8Nr7vWQd5XM5PBKnbFQUhtqWa8nuKWqB5EDG5z7t1niLizY9AFm/3kO7+AmXa
         rD0VXDA3pRDSrrxFkcMynY3GIVuRG17tgTOkmMCLxFCKexa5DUlFCaweaDtcwEaUV7ly
         YCRcij5P+Cu8LmX8uyig5ExJiJIt7T4YjCXX2T6mWqMQBnlwzm/uCvJ9Rf3zHWAc3qNm
         Mq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uOord+kfHsh3G2k0acV0n6jUJxNppObvJZgTTMmJf1I=;
        b=bNrl2PSzlpIIn4zfo/v56OUxLVjnCGRjyKcXXWMBXPfIah9eGQe+pB8ja7SGt8Tz7r
         Q2eYiGP/iZ2GipbDobJqCXVucK1AdEjH3T8y0d37817jdroT3uveOGnpBJMAWLt7UVz1
         U5yKPG2o+kheS0563lMFogtwTh2GXKsjHjm/ViSoiIhIyFHZkSRGwI/BgkuQqVaD1K22
         aQYze3bIa2VvJKqwRKJ3z2zYMVubJI+OcaF2L09HvZGRm82XnSojHRO7MOmMWwNJSeOH
         /9HDbfnO2dduDMtoy7KRHwCTBdTT1mnZ+2UmNupHmAY12OsVqTV3za4ERhVggBj8AwS+
         OJuQ==
X-Gm-Message-State: AOUpUlEdSgd05zcplYbaqS7t3W3GSRLffojoqrjgQY/6vHeANt9CJLco
        WxKaQwZwTijqtnOAdFurN2PVNUD9
X-Google-Smtp-Source: AAOMgpd0iCzRemmqgs6Mx+dtg+u06XEGuOL5hzTZ7f1C0rJmGChqff/iz6jTFVUyWe2Gt8h8/oZAJg==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr3285205wmt.94.1533138114122;
        Wed, 01 Aug 2018 08:41:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n7-v6sm18496025wrr.35.2018.08.01.08.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:41:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
References: <20180731173651.184716-1-hanwen@google.com>
        <20180731173651.184716-3-hanwen@google.com>
        <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
Date:   Wed, 01 Aug 2018 08:41:52 -0700
In-Reply-To: <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 31 Jul 2018 16:21:24 -0400")
Message-ID: <xmqqeffi856n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jul 31, 2018 at 1:37 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
>> Highlight keywords in remote sideband output.
>
> Prefix with the module you're touching, don't capitalize, and drop the
> period. Perhaps:
>
>     sideband: highlight keywords in remote sideband output

Yup (I locally did something similar when queued it).

>> The highlighting is done on the client-side. Supported keywords are
>> "error", "warning", "hint" and "success".
>>
>> The colorization is controlled with the config setting "color.remote".
>
> What's the motivation for this change? The commit message should say
> something about that and give an explanation of why this is done
> client-side rather than server-side.

Good suggestion.

>
>> Co-authored-by: Duy Nguyen <pclouds@gmail.com>
>
> Helped-by: is more typical.
>
>> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>> ---
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> @@ -1229,6 +1229,15 @@ color.push::
>> +color.remote::
>> +       A boolean to enable/disable colored remote output. If unset,
>> +       then the value of `color.ui` is used (`auto` by default).
>
> If this is "boolean", what does "auto" mean? Perhaps update the
> description to better match other color-related options.

Existing `color.branch` is already loose in the same way, but others
like color.{diff,grep,interactive} read better.  No, past mistakes
by others is not a good excuse to make things worse, but I'd say it
also is OK to clean this up, together with `color.branch`, after this
change on top.

>> +               if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
>
> So, the strncasecmp() is checking if one of the recognized keywords is
> at the 'src' position, and the !isalnum() ensures that you won't pick
> up something of which the keyword is merely a prefix. For instance,
> you won't mistakenly highlight "successful". It also works correctly
> when 'len' happens to reference the end-of-string NUL. Okay.

Hmm, do we actually say things like "Error: blah"?  I am not sure if
I like this strncasecmp all that much.

>> +                       strbuf_addstr(dest, p->color);
>> +                       strbuf_add(dest, src, len);
>> +                       strbuf_addstr(dest, GIT_COLOR_RESET);
>> +                       n -= len;
>> +                       src += len;
>> +                       break;
>> +               }
>
> So, despite the explanation in the commit message, this function isn't
> _generally_ highlighting keywords in the sideband. Instead, it is
> highlighting a keyword only if it finds it at the start of string
> (ignoring whitespace). Perhaps the commit message could be more clear
> about that.

Sounds good.

I didn't comment on other parts of your review posed as questions
(that require some digging and thinking), but I think they are all
worthwhile thing to think about.

Thanks.

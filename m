Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B6C1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbcIDQp5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:45:57 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36519 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbcIDQp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 12:45:56 -0400
Received: by mail-wm0-f45.google.com with SMTP id c133so92642588wmd.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kXhAIx/69THeXTizM4p3SqLs/ID5IET7psKb7+Jh+LQ=;
        b=N8jUBbtRdJyUjwBUBU949wxZMjivt96RuxTQ+UfYseCSklGarl0khA0NQ383+ZyRkp
         Mg5XgD5VccKW+SDh6ftdVFfnN8tCQgXQcmiPqFNQVxV68IbMkwm9YghL4NCTd0ltv24P
         y0hMXOSL7qvFReexUHZseYIrUU09s435lTRt7+zEkf5fsWV6vT+69XTqQRIMoAoBXqTb
         scPxnC613XQ7hLd98XlB4WZgTo19FVJghWtMhFxhEhu1ECE8d5+RHTAA2SNTm5oSwOlG
         Dv7kHX2EnmcsflgseCcU9RV06W7aaxYqeeO/0qiKUk30tQQpD8RwdSS4JEDdV2cKWdB3
         Zijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kXhAIx/69THeXTizM4p3SqLs/ID5IET7psKb7+Jh+LQ=;
        b=j29OHKa/0Ke+Gr4i4CmDvjQjrjnTPYaLr4w0AKY0YhLcehX+kpqPlmGJBLma9Gd9Se
         HaSE/HxjiSlEsF+cmh4AqCk3DdPMjV/1BOZJ6bqSQ+GWqKAAq/2cO4o6Zpsw8gXeQA/1
         h5LSeaIjuYV/nOfjDobPxEYQIOV8NxTpiWvLSvoYSxseRhaC552zib4Bc9mJLxMyJgq7
         Rx5CXYdY0T1q4hLmF4wzMftChFHhyuGbUBt1vxPTlalGCS13+SrN2rJs6aQSPDmgSMBP
         yFp5eXeEql7hIfRifJAV0R5n8EqCtXB5UWQFmjKrrU7LztJn6C5MxrmuxA+RjsOnCvi2
         xxIA==
X-Gm-Message-State: AE9vXwMWi8AKdTE7EM2pfospaZG8fAEBBjEzX99IK3OX1aD9FdnrlT14K4IAnXuFNoJ3sBoipx1w7rDBuGGsEw==
X-Received: by 10.28.175.79 with SMTP id y76mr12106972wme.98.1473007554527;
 Sun, 04 Sep 2016 09:45:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Sun, 4 Sep 2016 09:45:53 -0700 (PDT)
In-Reply-To: <e39d9b83-949b-075c-07f6-60118dc24961@ramsayjones.plus.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-11-chriscool@tuxfamily.org> <CAGZ79kbdoF-1=ZBZG8y3sEz6LVaNP4Ou+KVk+=M7y9PSzQ1J0Q@mail.gmail.com>
 <CAP8UFD2Lwd_1+cWT702deF8=iFmBRKCi9gLSOizPbyLmeKepsw@mail.gmail.com>
 <CAP8UFD38CC-Ah9zVcnU3a4nGH2CzOn74Adx=42pmckjPv=e_Bg@mail.gmail.com> <e39d9b83-949b-075c-07f6-60118dc24961@ramsayjones.plus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 4 Sep 2016 18:45:53 +0200
Message-ID: <CAP8UFD1Dssiw9=ME-084nXWd56X30vt1yEPYgyUnUjPsNcOVOw@mail.gmail.com>
Subject: Re: [PATCH v13 10/14] apply: change error_routine when silent
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 4, 2016 at 6:31 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 04/09/16 11:54, Christian Couder wrote:
>> On Thu, Sep 1, 2016 at 10:19 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> On Thu, Sep 1, 2016 at 12:20 AM, Stefan Beller <sbeller@google.com> wro=
te:
>>>>>
>>>>> +static void mute_routine(const char *bla, va_list params)
>>>>
>>>> Instead of 'bla' you could go with 'format' as the man page for
>>>> [f]printf puts it.
>>>> Or you could leave it empty, i.e.
>>>>
>>>>     static void mute_routine(const char *, va_list)
>>>>     ...
>>>
>>> Ok to do that.
>>
>> Actually I get the following error when doing that:
>>
>> apply.c: In function =E2=80=98mute_routine=E2=80=99:
>> apply.c:115:1: error: parameter name omitted
>>  static void mute_routine(const char *, va_list)
>>  ^
>> apply.c:115:1: error: parameter name omitted
>> make: *** [apply.o] Error 1
>
> Yes, this is not C++. ;-)
>
>> So I will leave it as is.
>
> I think I would prefer to see:
>
>     static void mute_routine(const char *msg, va_list params)
>
> given that it would either be an error-msg or a warning-msg.

Ok for "msg".

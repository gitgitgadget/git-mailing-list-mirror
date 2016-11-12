Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12281F40E
	for <e@80x24.org>; Sat, 12 Nov 2016 09:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbcKLJTw (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 04:19:52 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35753 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbcKLJTu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 04:19:50 -0500
Received: by mail-yb0-f196.google.com with SMTP id d59so1073935ybi.2
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6ZBJAXHkoIIzSJL8thC68aniQcpYUB+nKlOJm8OuHME=;
        b=u06l4HaXG6zEUGnvhjxDDGzVymxXL9Ywnx+RgzlTtp/whdFRcclHljZ7oKcRCesdQa
         /iWRgWYd0m96gskUZTjaZ7SnWUbHnKlVuwXD8WHu8+BOLFOo1115/2y9VGrU7z0np5+H
         52t1RJrNuEYS/6DsXivE/Bd9eN+0lPBI3qsBosUIQIBNzlhK+8VI0UtVk5hYEEIGvFNK
         7WIVYcHs8p3BW41Cc8xqV4fhkprQrZ03c/HLwTD044gz0Uu0E6gZESOOss+2SGAOnTIx
         YSqj8cxlFi/Vrg8uzaU32EyVNDJ01ILar8lff8TA8LxXxuqaoCL03JbJcEZanypPQ9Ba
         eTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6ZBJAXHkoIIzSJL8thC68aniQcpYUB+nKlOJm8OuHME=;
        b=KnIMGaPslTFSfDIpPw6JePHwMpmjAlvekDwVCXbYKiXDdcbIMSNIgbWiZomPp4aURn
         XhzVbLDE0A/CNX3uxa2Kj9mNzvquZuhtf6atfiyYy3vqvf0XGnye+XOtrp8aAzLEflkL
         wAK96ch9szxIPQLcnQ8UbdWHxuaWqQaBoOr3SAA5GC12a4b9OZGyss+aCxibiAZzRjYl
         A23IkaVPZJicqWW5inEhryoO3ffW001EZxFyZC7/M2BTdzCx+GJWVGAUFkHvA+Pcx77j
         jogi91wUxZ8y2z2lrNcLhtYMRbcelmMBokiSLAR6P8n6M987+OLSMVimv1wT41HqLSMz
         DAsg==
X-Gm-Message-State: ABUngveh4VkBIsVz/EfQxcKdYizM+kXih+K1zrFjUddM2U2e+58gsl7V7FYDwvUzJbiblPsjgfJmjF+iZmXpjQ==
X-Received: by 10.37.172.230 with SMTP id x38mr5989955ybd.96.1478942389884;
 Sat, 12 Nov 2016 01:19:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 12 Nov 2016 01:19:19 -0800 (PST)
In-Reply-To: <xmqqoa1m5335.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-4-Karthik.188@gmail.com>
 <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com> <xmqqoa1m5335.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 12 Nov 2016 14:49:19 +0530
Message-ID: <CAOLa=ZQqe3vEj_428d41vd_4kfjzsm87Wam6Zm2dhXWkPdJ8Rw@mail.gmail.com>
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, Nov 11, 2016 at 4:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> @@ -49,6 +51,10 @@ static struct used_atom {
>>>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>>>                         unsigned int nlines;
>>>                 } contents;
>>> +               struct {
>>> +                       const char *if_equals,
>>> +                               *not_equals;
>>
>>
>> Same here, why do we need both strings here stored separately? Could
>> we instead store which state to check and store the string once? I'm
>> not sure that really buys us any storage.
>
> I am not sure if storage is an issue, but I tend to agree that it
> would be semantically cleaner if this was done as a pair of <what
> operation uses this string constant?, the string constant>, and the
> former would be enum { COMPARE_EQUAL, COMPARE_UNEQUAL}.
>
> You could later enhance the comparison operator more easily with
> such an arrangement (e.g. if-equals-case-insensitively).

That's a rather good point you make there, I think using an enum with a string
constant would be ideal for future extensibility too. Thanks for the
explanation,
I shall change it.

-- 
Regards,
Karthik Nayak

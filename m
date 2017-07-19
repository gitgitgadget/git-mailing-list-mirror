Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5416F20356
	for <e@80x24.org>; Wed, 19 Jul 2017 00:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdGSA5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 20:57:19 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34765 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdGSA5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 20:57:18 -0400
Received: by mail-qt0-f181.google.com with SMTP id 32so29654579qtv.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RIAaRwNcKwvSgkySWHeI01PAcY3dtIFGwoL14xkf6b8=;
        b=W8DK3AlDpilyjZ+AKD0axOkqle2+APdX1j6UkTloCblArcUclswKpJsxcSSBTDecA5
         g4etv6EulzqR4YFX4dcQrvC8byp3ozHKwSONzAQH1hhGgFiqZV6l9lYuEdCa2FO4NYR2
         KhbYGXsco8bShBei7N5b7gDvX+ePaONaDAOhEKnV4iUJqmx8oJrilaJnD2BWKCsWUrlf
         wCHH6IYtv76IQiVXxgtaHNLMoCXxVy589tmZ8DfoF89tUC/LCmC579BerA2rrMTdITbG
         GIBU5d84o5ZcshFvAMAImbWA4DRrLxGWQXJHp9dqiDk/SH49EGxREo151QMO7QxmtVwp
         Tivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RIAaRwNcKwvSgkySWHeI01PAcY3dtIFGwoL14xkf6b8=;
        b=ILGsxB/oCkFzKSldkbKuFIX6bQuX5y1iVDfzvbwkVPi0bZmQ/UyehIjMIUQvj/RyF+
         hRtJpd2KVk0htMptGwm8WpJutTzkafFiJ8bkX2rpCy13D9BIix8WvWiVXKh6cz2bbGBb
         XgUaSiT+N7EiDoYONi28Ioro5/EXZ7rWKOWSsn4TegBpKt2T3QOCJUNHNTFc7FEStMkH
         4P8TD8K71MiDyCvmbIDMzszPFOGrYNbxSSn0hE49MV2PEuxMgqfXSB2xtDqxo+aiP7G8
         1ENc0IquLJlIutEq5Nfb19oJCWGBC55E6P7dM4UsaOvJdqkk8c9Fkq/JFmqMFYkAXUmH
         RvPg==
X-Gm-Message-State: AIVw111M6+IMih7XZc6MIe/yldLI5ps1g/LGH0SKaYNVIDiZshArtvBX
        pYNYLq+JjcllnB+SN3PcMQsW/rG6xZ3qkL9DTA==
X-Received: by 10.237.52.227 with SMTP id x90mr423813qtd.144.1500425838237;
 Tue, 18 Jul 2017 17:57:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Tue, 18 Jul 2017 17:57:17 -0700 (PDT)
In-Reply-To: <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 19 Jul 2017 08:57:17 +0800
Message-ID: <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-19 1:35 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>>> Two potential issues are:
>>>
>>>  - After this patch, there still are quite a many
>>>
>>>         printf("time is %"PRItime" ...\n", timestamp)
>>>
>>>    so the burden on the programmers having to remember when it is
>>>    required to use format_raw_time() becomes unclear, and makes the
>>>    change/churn larger when an existing message needs to be marked
>>>    for translation.
>>>
>>>  - The static struct strbuf here is a cheap way to avoid leaks, but
>>>    at the same time it is unfriendly to threaded code.  We could
>>>    instead do:
>>>
>>>         void append_PRItime(struct strbuf *buf, timestamp_t time);
>>>
>>>    to fix that trivially, but the damage to the caller obviously is
>>>    much larger going this way.
>>>
>>
>> I wonder if we can replace the original %lu for timestamp with PRIuMAX
>> instead.  PRIuMAX works fine with gettext utils.
>
> I think the question can better be answered if we know how gettext
> tools special case PRIuMAX.  One thing that may be problematic is
> that timestamp can later become a signed type and use of one level
> of redirection in the current code via PRItime and via timestamp_t
> is a good way to keep such a transition much easier.  Reverting it
> to use PRIuMAX would make such a transition much harder.

Gettext handles macros such as PRIuMAX in commit 8b45c5df1 ("Add
support for ISO C 99 <inttypes.h> format string directive macros.",
2002-07-23 12:33:13 +0000).

Macros such as PRIuMAX are hard coded, and we can not hack gettext
easily and directly.

For example, some code in commit 8b45c5df1 (see: See:
http://git.savannah.gnu.org/cgit/gettext.git/commit/?id=8b45c5df18e1976a1275297db73978bfe6144c7e):

    +/* 8a. Convert ISO C 99 section 7.8.1 format string directives to string
    +   literal placeholders.  */
    +
    +/* Test for an ISO C 99 section 7.8.1 format string directive.  */
    +static bool
    +is_inttypes_macro (name)
    +     const char *name;
    +{
    +  /* Syntax:
    +     P R I { d | i | o | u | x | X }
    +     { { | LEAST | FAST } { 8 | 16 | 32 | 64 } | MAX | PTR }  */
    +  if (name[0] == 'P' && name[1] == 'R' && name[2] == 'I')
    +    {
    +      name += 3;
    +      if (name[0] == 'd' || name[0] == 'i' || name[0] == 'o' ||
name[0] == 'u'
    +          || name[0] == 'x' || name[0] == 'X')
    +        {
    +          name += 1;
    +          if (name[0] == 'M' && name[1] == 'A' && name[2] == 'X'
    +              && name[3] == '\0')
    +            return true;
    +          if (name[0] == 'P' && name[1] == 'T' && name[2] == 'R'
    +              && name[3] == '\0')
    +            return true;
    +          if (name[0] == 'L' && name[1] == 'E' && name[2] == 'A'
    +              && name[3] == 'S' && name[4] == 'T')
    +            name += 5;
    +          else if (name[0] == 'F' && name[1] == 'A' && name[2] == 'S'
    +                   && name[3] == 'T')
    +            name += 4;
    +          if (name[0] == '8' && name[1] == '\0')
    +            return true;
    +          if (name[0] == '1' && name[1] == '6' && name[2] == '\0')
    +            return true;
    +          if (name[0] == '3' && name[1] == '2' && name[2] == '\0')
    +            return true;
    +          if (name[0] == '6' && name[1] == '4' && name[2] == '\0')
    +            return true;
    +        }
    +    }
    +  return false;
    +}


    + if (*format == '<')
        {
    -     if (*format == 'h')
    +     spec.c99_directives =
    +       (const char **)
    +       xrealloc (spec.c99_directives,
    +                 2 * (spec.c99_directives_count + 1)
    +                 * sizeof (const char *));
    +     spec.c99_directives[2 * spec.c99_directives_count] = format;
    +
    +     format++;
    +     /* Parse ISO C 99 section 7.8.1 format string directive.
    +        Syntax:
    +        P R I { d | i | o | u | x | X }
    +        { { | LEAST | FAST } { 8 | 16 | 32 | 64 } | MAX | PTR }  */
    +     if (*format != 'P')
    +       goto bad_format;
    +     format++;
    +     if (*format != 'R')
    +       goto bad_format;
    +     format++;
    +     if (*format != 'I')
    +       goto bad_format;
    +     format++;
    +
    +     switch (*format)
    +       {
    +       case 'i': case 'd':
    +         type = FAT_INTEGER;
    +         break;
    +       case 'u': case 'o': case 'x': case 'X':
    +         type = FAT_INTEGER | FAT_UNSIGNED;
    +         break;
    +       default:
    +         goto bad_format;
    +       }
    +     format++;
    +
    +     if (format[0] == 'M' && format[1] == 'A' && format[2] == 'X')
    +       {
    +         type |= FAT_SIZE_INTMAX_T;
    +         format += 3;
    +       }
    +     else if (format[0] == 'P' && format[1] == 'T' && format[2] == 'R')

-- 
Jiang Xin

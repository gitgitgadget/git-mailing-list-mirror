Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4241F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbeADTMR (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:12:17 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:36706 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbeADTMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:12:17 -0500
Received: by mail-io0-f174.google.com with SMTP id i143so3304307ioa.3
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ek/L7FjIIJU8sQuAQlR5RvEP+36SNdepUiWbDjhhlT4=;
        b=exPoj00Kcfx5UdU36DUBZ8HDyjXanGU6G6gAmV/59fSGBCj9DDfJIg9PJ3UsjyYnba
         TJe/fWRELyq1YuZohww5fe2kVkOaFEzY4h3569bSOtN+YnS/8IJxhzs5Xmn8yXXcb/ye
         E0rWB1Yi15Qt7tsypgeQlZTA09hI4TOnVnwNh4+7UQ2lwRKeLdRDDdUji6vqaLfpZCDJ
         Y9ioPAa2lOJDj3ywCLm0jrQ4vZ2eZY+QZ0bnP9Il4AF10nSMUd0ViW6RVM3AVdECVCOH
         E/Ay11fn68mkbksm24wuIVOwtlGI2TUdtp36Uldcg5EjiqtID8t1/nYgFS0iQmqo1weq
         FBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ek/L7FjIIJU8sQuAQlR5RvEP+36SNdepUiWbDjhhlT4=;
        b=uQKEKVTgExogtXKnkG4ek34msJMfe0IcOi6Gt89XDN2kVQtMa6zxLlAiH9pwaBnUry
         tzH9i0E3wNlCUvEXgJ4AIxOMbi5grhHZRTqRYHeuuvHJ84TRoYgfedzft9u9ivWn91NL
         lOAzeEQjpoKBCtjKoMU2idB/HHCmRAvg4pttUnmIcCyIaK8lXuSbNnLTb8w7pootu/g6
         6ggayzk0INOwBZy1/7LdktjpM8ahH4LRlp+so3HfYMTkRrJFdSBEY8hVSFsCpnLwx0uq
         rft3ObfLmAPFqMkZd3/5KBL84hddTwgccg0oFmDQwLC4qAuVW0d93WQfutrMzHvyyPTK
         X9qQ==
X-Gm-Message-State: AKGB3mLxf0bTJIoGUE3oOdtIOHzV/+zniUhOLwFwr3mtff7QnS2A8DA5
        Jb97TrWTeF4PHvVNbfhip5/fM5pIhXBEg2h3vxtgeg==
X-Google-Smtp-Source: ACJfBouMNzOCix4PnF635179luxe+UwWDAoWawlHVqDfB0jkbEBbROA+3Z7POHQr2kjQW6H5vnjrb/aVpLLuLCeTGvE=
X-Received: by 10.107.5.12 with SMTP id 12mr687832iof.54.1515093136185; Thu,
 04 Jan 2018 11:12:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.62.3 with HTTP; Thu, 4 Jan 2018 11:11:55 -0800 (PST)
In-Reply-To: <xmqq1sj5fnkt.fsf@gitster.mtv.corp.google.com>
References: <CAJzZBAT--X8GXg_knege_pZ8A=_Qk9nyMCLaoRMvjhUFGQYsZA@mail.gmail.com>
 <xmqqvagifqj8.fsf@gitster.mtv.corp.google.com> <CAJzZBAQ_T3JDqsxy=s7gbrRQjDsdZODB8XsBb4TUCs1K1Bmnjw@mail.gmail.com>
 <20180104164941.GB18376@sigill.intra.peff.net> <xmqq1sj5fnkt.fsf@gitster.mtv.corp.google.com>
From:   John Cheng <johnlicheng@gmail.com>
Date:   Thu, 4 Jan 2018 11:11:55 -0800
Message-ID: <CAJzZBARFyadScz_ovhtDrh3NFJwD=RSTMNRtLXj9DRDFGYVd3A@mail.gmail.com>
Subject: Re: Misleading documentation for git-diff-files (diff-filter)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the clarification! I also didn't realize that diff-files -R
will show added files. You learn something new everyday ;)

On Thu, Jan 4, 2018 at 11:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 9d1586b956..743af97b06 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -469,6 +469,12 @@ ifndef::git-format-patch[]
>>  +
>>  Also, these upper-case letters can be downcased to exclude.  E.g.
>>  `--diff-filter=ad` excludes added and deleted paths.
>> ++
>> +Note that not all diffs can feature all types. For instance, diffs
>> +from the index to the working tree can never have Added entries
>> +(because the set of paths included in the diff is limited by what is in
>> +the index).  Similarly, copied and renamed entries cannot appear if
>> +detection for those types is disabled.
>
> Makes sense; thanks.



-- 
---
John L Cheng

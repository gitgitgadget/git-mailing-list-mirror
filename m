Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69BA1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeHIX4R (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:56:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeHIX4R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:56:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so6358415wrv.12
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=m70FXyOFKfhC0hosbsNVKBHrCFwFmOlOkCQXGfHS4kg=;
        b=kz8rvQ46rDet7etJ+GmuVra8p52Dc36A2HxSby61ZrozEgVqZC1f74liKC0IrYd/L3
         VC4q2glyrwY+k/9mAHgqf/NvoD2i5x+Myq/m/VZ/lYp27EML1Bop/YwuoT45vI4QGxRD
         GgX7LWXYctT3I36j1VWsBjUIdaFNl+RRj7ss0p1iCNhHpgMCFKajARiqZQzQC/NVlAQp
         vJH19Lc0/c3JGCuZjkyM65yg+dPs4eVhNaduXgFxB1jVenbqX5Ey2nM5SuehQnMy8vQ9
         6Nkx8DhoyVJCLK2+W7ZfS34RlgXJFGotq15aaIU6BN9bKM4UMaieg3eHZmLq+s+smNYf
         ZgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=m70FXyOFKfhC0hosbsNVKBHrCFwFmOlOkCQXGfHS4kg=;
        b=hcA64lT94gIPzoFv2i+avT8UeuMkcEjeAd+oS2i/JFIEkL1zF6ODFi3nbOhu6I7owW
         7+1wdjPsnOz334mfJKWh/70qXTBsXxcYYXwXFuGcmJtmxDv0vWySQF2Z4Q7YrQnqaYC1
         hvYwnODU21347OMe5pOLul8LW06m2500MBF53OH4PO0Gr0LYQ6sKQeHoMmbjADfpUgnd
         2RMnEPqVQujftpLCaHMVCdB8ruTCxMFvBf9FJAFqjvpOpj0dQ8CoPYsBJLGVsnz2ecSM
         82XfjY8q5yQShNKBl1PIOsERFI+1q6dWNN9UcRxs9JfbAixDbpNt3MDfKSh3+w71lqwU
         VT7Q==
X-Gm-Message-State: AOUpUlEdH4Qu1lmTNtV9NBeX46sooy0kT497TBn+tTTShCBgnXa1ANyG
        /ULUnmlFAU92ze6MgY7+Mi4=
X-Google-Smtp-Source: AA+uWPxQcSy3IWFAqGvRWjgzxF4WWXe6VCxEpvWfdwFbxbFUtxtHwhyq9THoUqR4v4+L5McwZ1Wr7A==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13-v6mr2365979wru.80.1533850174010;
        Thu, 09 Aug 2018 14:29:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y18-v6sm6700573wrh.85.2018.08.09.14.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:29:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>, hvoigt@hvoigt.net
Subject: Re: [PATCH 02/10] string-list.h: add string_list_pop function.
References: <20180808221752.195419-1-sbeller@google.com>
        <20180808221752.195419-3-sbeller@google.com>
        <CAN0heSqjazimYu4de=xCQ9epSxezVyKPQQ16amZZvoaBh_SKdQ@mail.gmail.com>
Date:   Thu, 09 Aug 2018 14:29:32 -0700
In-Reply-To: <CAN0heSqjazimYu4de=xCQ9epSxezVyKPQQ16amZZvoaBh_SKdQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 9 Aug 2018 09:35:51
 +0200")
Message-ID: <xmqqzhxv9qkj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> On 9 August 2018 at 00:17, Stefan Beller <sbeller@google.com> wrote:
>> A string list can be used as a stack, but should we? A later patch shows
>> how useful this will be.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  string-list.c | 8 ++++++++
>>  string-list.h | 6 ++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/string-list.c b/string-list.c
>> index 9f651bb4294..ea80afc8a0c 100644
>> --- a/string-list.c
>> +++ b/string-list.c
>> @@ -80,6 +80,14 @@ void string_list_remove(struct string_list *list, const char *string,
>>         }
>>  }
>>
>> +struct string_list_item *string_list_pop(struct string_list *list)
>> +{
>> +       if (list->nr == 0)
>> +               return 0;
>
> return NULL, not 0.

It is OK to return NULL, which may make the caller a bit simpler,
i.e.

	while (item = list_pop(list))
		work_on(item);

but if we consider it a good discipline for the caller to see if
there are still things on the stack before attempting to pop, then
instead of returning NULL, we can have BUG("") there, which requires
the caller to be more like this:

	while (list->nr)
		work_on(list_pop(list));

which is not so bad.

>> +/**
>> + * Returns the last item inserted and removes it from the list.
>> + * If the list is empty, return NULL.
>> + */
>> +struct string_list_item *string_list_pop(struct string_list *list);
>> +
>
> The memory ownership is now with the caller. That is, the caller needs
> to check/know `list->strdup_strings` and know `free_util` to be able to
> properly free all memory.

> OTOH, the pointer returned by this function is only guaranteed to be
> valid until you start inserting into the list (well, you can do one
> insertion per pop without worrying, but that's quite detailed
> implementation knowledge).

Yes, it is a more grave limitation when using string_list as a
stack.  A single realloc() and you are dead X-<.


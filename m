Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB9D1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 23:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeDQXlF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 19:41:05 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:40176 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeDQXlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 19:41:04 -0400
Received: by mail-vk0-f53.google.com with SMTP id x204so12975717vkd.7
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MHpv0py/P5fXS+1i5992NrtT9cr8C2ftEiDUxstwZGU=;
        b=IdqT+vC3tbZTL+AWbOaiRwUb8gfflJ9Y/od9UuWtIsGgOU7PXg/3CfsVtIr13Rs2hc
         7gegCZwcmijlUW5YbtUfMzFgBF/HF/vw7+87ZlsuGE4fpAjR2qXHt97suSFdC5fjidQh
         7IR8KosEtiZVBKqw5T47nJdq5irGH2KJ62vpDQTOvmo+27l+qcSUD2jfNDQGdmOSl6gJ
         4ctI34/iV6MTJsOkNjlkwyTzbUAQKdPwcLveorvSjh44/NnNCIs7XOtZrgRzCaxPS6WC
         wXQiEU5pMDvoKjzfYQBjLcYV2zjr2qPtGLzBkwrCfA3Kc3ZxSgjWxywLxnp+4aIIsf7h
         3FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MHpv0py/P5fXS+1i5992NrtT9cr8C2ftEiDUxstwZGU=;
        b=jFjThSflahVzml8OsRjfCTrYpqKtpHQuvsl+UVkQRzroghepmt7cM+RZojcBJZCrmU
         BCKtcvQfoZgIjIJ9JJbvUsDrTwYgacm71kJHaquXnC6yOMv+NYpCOa8xFbI5xKEsI7eh
         PvE+YVKEe6mfQKUUB8CbRX9KZVFPiKrzNxHZ/o/co4vIepIPR04kyGv2knQ43IdAgRN1
         gD0TUgyISAyGHnXezIExmQz/Jsc7pUulaYHbec34TBKjLwjIkpS5cAoHwTmoUNL1iKdU
         vEaMQE71yEJ1fFtEaZWjzWdHjYgQ4XOLqMTCNmYFaA3s1Dmi2HIDzHApjRBu+W9oTtun
         5vNA==
X-Gm-Message-State: ALQs6tCW1IH1me8hsDJi/pmnQYN/suVltWiMbdXw1Q7oBRd/AYKwMG5p
        8akRHlWuh92iLo/kL+gacKCCxDyiAp5wjUWgqDI=
X-Google-Smtp-Source: AIpwx4/69E3l4U4Q+b8mPkN70w1ZeJDgoLPa7fzSbzIB2DxMR/DV5e1Z8IurX7YfP8IhvluD6zoUP07bxFv8sItiYJw=
X-Received: by 10.31.64.8 with SMTP id n8mr3171247vka.113.1524008463477; Tue,
 17 Apr 2018 16:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Tue, 17 Apr 2018 16:41:03 -0700 (PDT)
In-Reply-To: <CAM0VKjk=JtdoduywJ4t5OPhLGgt90yxJA_Zif6R803XHA=Sfbg@mail.gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com> <20180416224113.16993-1-szeder.dev@gmail.com>
 <20180416224113.16993-2-szeder.dev@gmail.com> <xmqq7ep6v6ft.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjk=JtdoduywJ4t5OPhLGgt90yxJA_Zif6R803XHA=Sfbg@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 18 Apr 2018 01:41:03 +0200
Message-ID: <CAM0VKj=LGON7C-kb6uPykqiX-wLeZsoYpt+-4ktfQ6Fvb_C7Rw@mail.gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues
 with quoted pathnames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 1:32 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Tue, Apr 17, 2018 at 5:48 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>
>>>     Do any more new tests need FUNNYNAMES* prereq?
>>
>> Hmph, all of these look like they involve some funnynames ;-)
>
> Well, I can' create a directory with a '|' in its name on FAT32 (on
> Linux), so this needs FUNNYNAMES prereq, too.

Or, on second thought, using a different, more widely usable character
would be better, so the test can be run on more platforms.


>> Do we want to test a more common case of a filename that is two
>> words with SP in between, i.e.
>>
>>         $ >'hello world' && git add hel<TAB>
>>
>> or is it known to work just fine without quoting/escaping (because
>> the funny we care about is output from ls-files and SP is not special
>> in its one-item-at-a-time-on-a-line output) and not worth checking?
>
> This particular case already works, even without this patch series.
>
> The problems start when you want to complete the filename after a space,
> e.g. 'hello\ w<TAB', as discussed in detail in patch 5.  Actually, this
> was the first thing I tried to write a test for, but it didn't work out:
> inside the 'test_completion' helper function the space acts as
> separator, and the completion script then sees 'hello\' and 'w' as two
> separate words.

On another second thought, a test for the already working 'hel<TAB>'
case could make sure that we won't mess up the value of IFS when filling
COMPREPLY.

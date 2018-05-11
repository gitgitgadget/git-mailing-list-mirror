Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BABC1F406
	for <e@80x24.org>; Fri, 11 May 2018 06:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeEKGUb (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 02:20:31 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:40633 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeEKGUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 02:20:30 -0400
Received: by mail-oi0-f41.google.com with SMTP id c203-v6so3838812oib.7
        for <git@vger.kernel.org>; Thu, 10 May 2018 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aCb+Stmy46Hr204iOHu1Y3c5pnCAdZqUlOl+XOqgIP4=;
        b=aKlgRP0vt2KZ6baWoiasZpYAfdHCSnQTUw9ZAG57ORbbxVNKoQPlU5Nb/5bvsCbBgO
         OuMRb9F5c4ghUwTPmNQLxqiHH+jdNZ+KRgiy2pgvCTYfm1a+AWVZW/Jmhk9P3YYQoeEU
         4eL6x0BAasHuvpm8U8N7QMsoH/cg9i3LhBZHeiIAgzI4hIdijXWWax9wREJaqMTsq7hW
         YP0+YmESi2E3SskOtw7BGf4XdrFnGcwWzofWf91w71fh5zf3lPWkZjnekbkmYnj33Btz
         kfsFFDSkIrun5cnFRzQPMrvuxxZpkwwsaxFx908Ym3bCddrEggKm/Nbilr6GAOEyE9j/
         cyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aCb+Stmy46Hr204iOHu1Y3c5pnCAdZqUlOl+XOqgIP4=;
        b=VmFjjk23ZC3aI7pEoPUIHadKU7cY2iDVGzis6yWFZf1K8auLGSRzs3T9KmP0DGMiL5
         zg1ZqaqFhzKCd8lsBXcMj3G3abgIZhwu11lS5jya8ghRdyNFlH8VEPvIiFeq/ACYU+BS
         nSPGh9vzCsNkbZKdt+/2aJuYISySqN2AuVbMheQ25r0WddVRcDHi7ojiPh7TMJF0Q4W6
         jm+fO4u/d+Ptg+7x8lBlNpdZeMpHsCaY0iumtiDIfyTFkepL8RlkF492RU9aE78MA0B5
         ncBT4Ob5TVunT/QRK++Iyd2QHDiTv94XDr+5RAhXQ57SSyg9oK6dF1r5ETBvTU2UUZUh
         dVmA==
X-Gm-Message-State: ALKqPweKri8KHT4OaTDZSNfzY96l1ls1NcldOdugkROStaijTR4Vhwmb
        Z2lBQFoKDgb6omlBqkdzARtq1dtez/YzNEUsGC4=
X-Google-Smtp-Source: AB8JxZrABnysVjIhU/pAKW/rPUxdnMNYSJvXtScfokJ1RbZBA1V9CG3SDmAYpKcgklpXy5qP6OtPEZEhPyafdNo0DeE=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr2612607oie.30.1526019630058;
 Thu, 10 May 2018 23:20:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 10 May 2018 23:19:59 -0700 (PDT)
In-Reply-To: <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de> <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com> <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com> <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 08:19:59 +0200
Message-ID: <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 6:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>>> But it somehow feels backwards in spirit to me, as the reason why we
>>>> use "void *" there in the decoration field is because we expect that
>>>> we'd have a pointer to some struture most of the time, and we have
>>>> to occasionally store a small integer there.
>>>
>>> Yes, fast-export seems to be the only place that stores an integer as
>>> a decoration.
>>
>> With the decoration subsystem that might be the case, but I think
>> we have other codepaths where "void * .util" field in the structure
>> is used to store (void *)1, expecting that a normal allocation will
>> never yield a pointer that is indistinguishable from that value.
>
> I was looking at a different topic and noticed that bisect.c uses
> commit->util (which is of type "void *") to always store an int (it
> never stores a pointer and there is no mixing).  This one is equally
> unportable as fast-export after your fix.
>

In both cases we should be able to use commit-slab instead of
commit->util. We could go even further and kill "util" pointer but
that's more work.
--=20
Duy

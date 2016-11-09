Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3962021E
	for <e@80x24.org>; Wed,  9 Nov 2016 14:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbcKIOrf (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 09:47:35 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33574 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbcKIOrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 09:47:33 -0500
Received: by mail-lf0-f67.google.com with SMTP id 98so10102859lfs.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rn/tbcGwSJTpN3ycU5Z82pT45NlGq8zPGtQxgvBqHpw=;
        b=RhlHc0qZ5OjorGbaID0RmxWVFDS3jmFT6nEBeNMIGmLetPR+NGf4Zf44Y9E7B5nEi+
         PlzKtlLzWhySYjCCD7DniDEYCYyEqG1us8b5nn/FDlOstyGSkH+542u8dg9f+4aqUAhK
         9+n2UVp6jMZqaOTw4IrVpBwHsbaYVkCsZZF6iJzOhgMU8mzAqpMcHntkO3mieQacr+E1
         tJqv6/51ycMxlcAMg8uYBs3kfr09zsXcmgXbCNoLSzY8H3gZdRFP9E2T5JwuyWBhwwcj
         1PyPst0wJsdssuPsWjt7ZbHUfMao8w1fAUZQDgBEDgBiL8L2XJd57unqntW82th5B20n
         Beaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rn/tbcGwSJTpN3ycU5Z82pT45NlGq8zPGtQxgvBqHpw=;
        b=YxbKzKBzpJ0ckwN9dU3FgKenpxVhKiTMFTimAndScWsmdLkyEDF8l/HHi27u1zSDup
         gKx79Ao2otYHch5Zc8jcXTDOxhzaXSD7Iv9IUeVuEU5wL5S6fJv/C+JInLrmM1HrwWbf
         DNfHkVby06t8y4coCAqo7FZM3ZmDJ5x7X95oY0HJcfzp+Bxq07SkPZQz2sR9Izq2lpPr
         QQIPAdr6+7ojDenAd58k6hSVzgcdXOCW9syTzilz21XJT9PqDQR1Xn0lRPQbauvwSZs2
         e1ji+7nq2XGQjHSbfYLgVt7wlSC+AfHuQUtb7Cm6gmmrCW0+V4jGBm/a6erMmEf2K4XW
         h9mQ==
X-Gm-Message-State: ABUngvcTP9JUekKQZYw1U/+MNaFWlgW2ofkjMGpPGprBZBWEek5i7FZZ3r63/0Fh9Up0WBXYd7IsSN8Bx865yA==
X-Received: by 10.25.74.85 with SMTP id x82mr8968247lfa.154.1478702850948;
 Wed, 09 Nov 2016 06:47:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Wed, 9 Nov 2016 06:47:30 -0800 (PST)
In-Reply-To: <CACsJy8AisF2ZVs7JdnVFp5wdskkbVQQQ=DBq5UzE1MOsCfBMtQ@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-4-chriscool@tuxfamily.org> <CACsJy8DPt3EJoSTVEZFbH6xXbh78MbLZ4h+50K4eoFxPYSaN=Q@mail.gmail.com>
 <CAP8UFD3hNEU_UeVizU6SVJTt4hqJPag9XWqZOM3FKCGJZXOthg@mail.gmail.com>
 <CACsJy8DjXrOgB-_-t47uSdCQFg9s_o+Oj9NBmAhDFZ3aYvjBgg@mail.gmail.com> <CACsJy8AisF2ZVs7JdnVFp5wdskkbVQQQ=DBq5UzE1MOsCfBMtQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 9 Nov 2016 15:47:30 +0100
Message-ID: <CAP8UFD1M3juG2Dz8caFqexNC=7_730-w+y8miVmDPKPF0th80g@mail.gmail.com>
Subject: Re: [PATCH v1 03/19] split-index: add {add,remove}_split_index() functions
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 10:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Nov 7, 2016 at 5:08 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Oct 30, 2016 at 5:06 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> On Tue, Oct 25, 2016 at 11:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
>>>> <christian.couder@gmail.com> wrote:
>>>>> +void remove_split_index(struct index_state *istate)
>>>>> +{
>>>>> +       if (istate->split_index) {
>>>>> +               /*
>>>>> +                * can't discard_split_index(&the_index); because that
>>>>> +                * will destroy split_index->base->cache[], which may
>>>>> +                * be shared with the_index.cache[]. So yeah we're
>>>>> +                * leaking a bit here.
>>>>
>>>> In the context of update-index, this is a one-time thing and leaking
>>>> is tolerable. But because it becomes a library function now, this leak
>>>> can become more serious, I think.
>>>>
>>>> The only other (indirect) caller is read_index_from() so probably not
>>>> bad most of the time (we read at the beginning of a command only).
>>>> sequencer.c may discard and re-read the index many times though,
>>>> leaking could be visible there.
>>>
>>> So is it enough to check if split_index->base->cache[] is shared with
>>> the_index.cache[] and then decide if discard_split_index(&the_index)
>>> should be called?
>>
>> It's likely shared though. We could un-share cache[] by duplicating
>> index entries in the_index.cache[] if they point back to
>> split_index->base
>
> I have a patch for this. So don't have to do anything else in this
> area. I'll probably just pile my patch on top of your series, or post
> it once the series graduates to master.

Great, thanks!

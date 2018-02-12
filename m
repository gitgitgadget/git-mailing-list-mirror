Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280AE1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 19:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeBLTIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 14:08:46 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:44566 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeBLTIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 14:08:45 -0500
Received: by mail-yw0-f181.google.com with SMTP id y187so3204466ywg.11
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7DCW0twy5jppCi5XUMU7ilfhYzbSEl3dBvo7k99UHiA=;
        b=lN+4AjJhc8a0PpP6+UyL9AWibQAM3OF2L1qOwyjqs9sxEav0P4DZbuMroIUazT68Ki
         vQfpW247SRfgATKUZSYwBMPCywciXQEFLD7/dW1RGNQops+uRz2NJ/jadXChGYYJ9Xo6
         OOYcq5ksS4t9/xlXAzRYIZhyqvEGQEASc7VcJ2nEWyxGrhhHOLhPc+uKmpp+zA3AMgxJ
         CzCrO3ewaLz/tSM1zjCuXVteQQGoaHtuVIyIewUeNwzxx/KIzIEX8jnD8KoiV8yPakIu
         n/BxztrBN8DAinuTlMY6KdaujvXd7rgsHhJ8P1QVZdeKblCMSbPbnVku+xzTPqosm7QF
         WmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7DCW0twy5jppCi5XUMU7ilfhYzbSEl3dBvo7k99UHiA=;
        b=TA5c1MyYG63sWlF34Cw7vD9NArCZ6wuBac3OyRqUqYP1G2H6apgH4VnDQVqEu8v2LX
         fCQE9xA4EGDgZbbNgV8jEqzybboqS3JPzWWStkm6dX1h8lRkjQBDLFEiqeD3Ltc93fqz
         k8YFMChWHzpHq5OIG363DbW06GvQgRYixvfbiZ31kiJXCrMrHBG9WcAnDYiXOL3NXf7g
         gS4ot3beq8+kPktc1iCJ7rIp/4mJ1v4eXeJLB5ImeskWZNCd9ti2JGiy0fSRHWyOCxqy
         4qxMYmmJuIr0ErDQoKEo0TBQWQ56/RK4h8JmEnzEuwcWCcDsOp5IGBvJo/RVR/ikELia
         pcsQ==
X-Gm-Message-State: APf1xPD8Rn/bvraUT5IRu9wX6KHVDzDCs/RvY9ujufNwb7RriiYyI8fK
        42VcHxnNr5LaSwaWA2DZjK9cbJCo4nOAxDButV6XBTF3Ttk=
X-Google-Smtp-Source: AH8x225T5nhYZV9M8M1ucxGR9p6++OyGRofIfkmzR1w5Y22icw7Y3CDBmrhnPoaiLQ88UjSjpvXgHAoBM5Nw6Zk1myI=
X-Received: by 10.37.101.11 with SMTP id z11mr8448850ybb.201.1518462524104;
 Mon, 12 Feb 2018 11:08:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Mon, 12 Feb 2018 11:08:43 -0800 (PST)
In-Reply-To: <xmqqzi4hu53x.fsf@gitster-ct.c.googlers.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-26-sbeller@google.com> <xmqqzi4hu53x.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Feb 2018 11:08:43 -0800
Message-ID: <CAGZ79kbFc6fsajRtUQYtNxPq05cb=U+juHDESGoJMRrZuKVsqQ@mail.gmail.com>
Subject: Re: [PATCH 046/194] object-store: move replace_objects back to object-store
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -32,7 +31,15 @@ struct object_store {
>>        * Objects that should be substituted by other objects
>>        * (see git-replace(1)).
>>        */
>> -     struct replace_objects replacements;
>> +     struct replace_objects {
>> +             /*
>> +              * An array of replacements.  The array is kept sorted by the original
>> +              * sha1.
>> +              */
>> +             struct replace_object **items;
>> +
>> +             int alloc, nr;
>> +     } replacements;
>>
>>       /*
>>        * A fast, rough count of the number of objects in the repository.
>> @@ -49,7 +56,7 @@ struct object_store {
>>       unsigned packed_git_initialized : 1;
>>  };
>>  #define OBJECT_STORE_INIT \
>> -     { NULL, MRU_INIT, ALTERNATES_INIT, REPLACE_OBJECTS_INIT, 0, 0, 0 }
>> +     { NULL, MRU_INIT, ALTERNATES_INIT, { NULL, 0, 0 }, 0, 0, 0 }

Maybe we can move the REPLACE_OBJECTS_INIT just before the
definition of OBJECT_STORE_INIT, so we'd not need to touch this line here.

>
> Not the primary thrust of this topic, but we may want to convert
> these to use designated initializers after this series is done.

I agree.

I feel cbc0f81d96 (strbuf: use designated initializers in STRBUF_INIT,
2017-07-10)
may need longer cooking until all the interesting architectures have
tried picking up
the latest release, though.

Stefan

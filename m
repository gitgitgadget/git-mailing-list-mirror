Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973831F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeDWRiC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:38:02 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:42958 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbeDWRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:38:00 -0400
Received: by mail-oi0-f46.google.com with SMTP id t27-v6so15054625oij.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r4C9qXo6t/DA8zbPHH+owkrWPKJ+jDXWM44jEQoe9WE=;
        b=FxGAmHmlqv48qcnQYy2ljbd7CEgC7sFPRGIid1xeVJuLTzwDyHGE3aZmKArBH1eulJ
         8t42gdcuL/Q7fIYeGm/Tu1WJQ9Fnz6gkBewOxNI7w+pUsm8jd8SFKmSmWatoFrYfNO6e
         Cx3GrJjIYDQlLfk5WoFHRCDJK9Q66mzR0jim4X5mfPLmykWkv0KwMlibl59E4AxjczcA
         /8pEsifLaEKxSLJ+wumG/eloZkwXyryC8jGkL+TDlY9FVqG8wnUwWZeC4f06HaUogEm6
         g7JsulYXsVz1it7VlVZd/5hgOw6/qIbwoilonRxHI6D4DXcMKQXEqSo1Ekvw+7T4MEcd
         o3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r4C9qXo6t/DA8zbPHH+owkrWPKJ+jDXWM44jEQoe9WE=;
        b=RBABTyK9RLTC1wKNF0qnZYAjZOHoELmz1E4deWRFks9AT5LfV9K1R0HHGZ4sY74Nng
         1nE2zPmqPh+ie5LGC1mwz/GoCDgQque6cF3bL8Ak1QEw8YkslkfhQLu3vxl8YtsRR99U
         43KiF1VDUtxM/C+ez8LXGP4GmMG1ob8ykG9GBhAE5dD8fISyokweb5jjOVU/3vqDwHsQ
         eClOSIQwYzERcJGquQ4xnSIrOuCsCTCOeETi/EgnRKEGWSyBV6ipJU5BT3qeIu9b12/z
         YvFUtsrfqHNR+ipfxmlcCbLqoW4J3/rJ/oPU/hisaI6PM1jbn0T11LfhxOlg5KugIHKi
         qi5w==
X-Gm-Message-State: ALQs6tAws4HOpsUEeqyux7AmzkYpL1Ja+YmqitXP3HUlTstCt7WNJYMU
        jxrknAFPHpvNHtCixHkBd41UftRABPYChS2+cZo=
X-Google-Smtp-Source: AIpwx4/d+NJ7XKeWW/nIP9UhMSLyKai0HJKv2OilyURt3mLoz6SLM6743oEuuVx+Sao3crn9eLfRU+4sBQuEt3SYcDM=
X-Received: by 2002:aca:1217:: with SMTP id 23-v6mr9283778ois.228.1524505079841;
 Mon, 23 Apr 2018 10:37:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 23 Apr 2018 10:37:29 -0700 (PDT)
In-Reply-To: <CABPp-BFuuywXrJuzfb4V1bRLb9eVZpLKiCDwQWetHk8bymC6EQ@mail.gmail.com>
References: <20180420122355.21416-1-szeder.dev@gmail.com> <20180421193736.12722-1-newren@gmail.com>
 <CACsJy8D4OYphLG5vStr+M9qkiqyH_LR517M-JOPS2wJeTFNGRg@mail.gmail.com> <CABPp-BFuuywXrJuzfb4V1bRLb9eVZpLKiCDwQWetHk8bymC6EQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Apr 2018 19:37:29 +0200
Message-ID: <CACsJy8Bmr+rSasRJRbhPUStUjBdVE59M97cGx5_Atii_XSDXaA@mail.gmail.com>
Subject: Re: [RFC PATCH v10 32.5/36] unpack_trees: fix memory corruption with
 split_index when src != dst
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 7:09 PM, Elijah Newren <newren@gmail.com> wrote:
> Hi,
>
> On Sun, Apr 22, 2018 at 5:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>   - there's a better, more performant fix or there is some way to actually
>>>     share a split_index between two independent index_state objects.
>>
>> A cleaner way of doing this would be something to the line [1]
>>
>>     move_index_extensions(&o->result, o->dst_index);
>>
>> near the end of this function. This could be where we compare the
>> result index with the source index's shared file and see if it's worth
>> keeping the shared index or not. Shared index is designed to work with
>> huge index files though, any operations that go through all index
>> entries will usually not be cheap. But at least it's safer.
>
> Yeah, it looks like move_index_extensions() currently has no logic for
> the split_index.  Adding it sounds to me like a patch series of its
> own, and I'm keen to limit additional changes since my patch series
> already broke things pretty badly once already.

Oh I'm not suggesting that you do it. I was simply pointing out
something I saw while I looked at this patch and surrounding area. And
it's definitely should be done separately (by whoever) since merge
logic is quite twisted as I understand it (then top it off with rename
logic)

>> [1] To me the second parameter should be src_index, not dst_index.
>> We're copying entries from _source_ index to "result" and we should
>> also copy extensions from the source index. That line happens to work
>> only when dst_index is the same as src_index, which is the common use
>> case so far.
>
> That makes sense; this sounds like another fix that should be
> submitted.  Did you want to submit a patch making that change?  Do you
> want me to?

I did not look careful enough to make sure it was right and submit a
patch. But it sounds like it could be another regression if dst_index
is now not the same as src_index (sorry I didn't look at your whole
stories and don't if dst_index != src_index is a new thing or not). If
dst_index is new, moving extensions from that to result index is
basically no-op, in other words we fail to copy necessary extensions
over.
-- 
Duy

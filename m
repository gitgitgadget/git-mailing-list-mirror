Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034C22022C
	for <e@80x24.org>; Mon,  7 Nov 2016 10:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbcKGKJS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 05:09:18 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36580 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbcKGKJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 05:09:16 -0500
Received: by mail-it0-f65.google.com with SMTP id n68so874458itn.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 02:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F7gvlHDpvtlbuyItFSwi9FFIfJTGKIlJ5aVwQr2gtFY=;
        b=jxC141YdQHtDQg/RKUWv65gOrV9h+1oW/RnhN+UCAvcl1Lc7a13r+vupSr1CQWiMzF
         5UtHR4DoxoEg5WfZDalFHmRepH5AbYvptSe3AyxTo/GkXHZP58N3P0O8fTrzg6gmCI+0
         16fJ7smrjylw+V+WfDCDR5z4XLxAzDpTQ9+Ppi0gQP/uUippU5jOIy3+KLJ4bojU61ov
         R4R+aYXTQ9hbnHPcTCsQkt5x0taLfgBUB8LAnR6Gx4R9hxrsiCGo5IW2DMBADjrArPn9
         AudANlslx4Iwdz9yC7vX/4icHHaVA8EZtm/N1BPEYmLHFKnCdA6C7HhzUUJv1OftCu0o
         vVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F7gvlHDpvtlbuyItFSwi9FFIfJTGKIlJ5aVwQr2gtFY=;
        b=dWzo7KBFxloYOF3iwo+4w5ZASyCO0vuRifITBs4E3VLib+VguMKC1Dz7/u3KW35ti4
         fER4MLzzNUUdk64dxhLPno0hLBUyx/phOp81rJqxVmR3TZMO9w2Ar+Bm5g/wmsXWe5eU
         VVa1kcyRRvBBpx/ao090Yo/IV3t63Zxcw1CNAUCG+0XtkXvKQGSRPucTZIXAXkZ9X3G4
         JITWwRw7N1iLC0TQYzVR/vEBtJV960B3L4S/z/BKisAdEX2O7tHc3mjUO+1wkY2+dTQd
         Wp8x6ZGsTTuwDdBtRxbb8X6dZ43kIWUwH2y0nF86DlI6hssruK1Y3uWEiBdk+3Gd8ERE
         AZyA==
X-Gm-Message-State: ABUngvdLtLC0cEE9Qgn3+yga1wgJMxMieu5E/L/ZS45ouTWPNbMd51/a3Nv2OuTmViCvrOPyraV2oVPig5N7sA==
X-Received: by 10.36.26.78 with SMTP id 75mr6387566iti.74.1478513356201; Mon,
 07 Nov 2016 02:09:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 7 Nov 2016 02:08:45 -0800 (PST)
In-Reply-To: <CAP8UFD3hNEU_UeVizU6SVJTt4hqJPag9XWqZOM3FKCGJZXOthg@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-4-chriscool@tuxfamily.org> <CACsJy8DPt3EJoSTVEZFbH6xXbh78MbLZ4h+50K4eoFxPYSaN=Q@mail.gmail.com>
 <CAP8UFD3hNEU_UeVizU6SVJTt4hqJPag9XWqZOM3FKCGJZXOthg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 Nov 2016 17:08:45 +0700
Message-ID: <CACsJy8DjXrOgB-_-t47uSdCQFg9s_o+Oj9NBmAhDFZ3aYvjBgg@mail.gmail.com>
Subject: Re: [PATCH v1 03/19] split-index: add {add,remove}_split_index() functions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2016 at 5:06 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Oct 25, 2016 at 11:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> +void remove_split_index(struct index_state *istate)
>>> +{
>>> +       if (istate->split_index) {
>>> +               /*
>>> +                * can't discard_split_index(&the_index); because that
>>> +                * will destroy split_index->base->cache[], which may
>>> +                * be shared with the_index.cache[]. So yeah we're
>>> +                * leaking a bit here.
>>
>> In the context of update-index, this is a one-time thing and leaking
>> is tolerable. But because it becomes a library function now, this leak
>> can become more serious, I think.
>>
>> The only other (indirect) caller is read_index_from() so probably not
>> bad most of the time (we read at the beginning of a command only).
>> sequencer.c may discard and re-read the index many times though,
>> leaking could be visible there.
>
> So is it enough to check if split_index->base->cache[] is shared with
> the_index.cache[] and then decide if discard_split_index(&the_index)
> should be called?

It's likely shared though. We could un-share cache[] by duplicating
index entries in the_index.cache[] if they point back to
split_index->base (we know what entries are shared by examining the
"index" field). Once we do that, we can discard_split_index()
unconditionally. There's another place that has similar leak:
move_cache_to_base_index(), which could receive the same treatment.
-- 
Duy

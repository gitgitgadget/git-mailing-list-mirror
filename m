Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B838B20229
	for <e@80x24.org>; Wed,  9 Nov 2016 09:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbcKIJYv (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 04:24:51 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36646 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbcKIJYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 04:24:48 -0500
Received: by mail-it0-f65.google.com with SMTP id n68so13850006itn.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 01:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RAGauJ6ZEC+r3Esqd0QarKOfVAziGmluCtjJT+Ek4nI=;
        b=ObnQbpmappd/k9MP3ft/ulw28bjoYInrm0J9/Mri24VDbLX9IT46PL6cLwYh5MlvB3
         ikyUDdVTFvMYxO2ri5kd18ag6cYuTeQ4/53oC0A8yrEoRjAdmtiPMRSdVcLdI80RelmR
         pPJbam4cMVdbKFuCzIzqRxW3Ef3+fFE4nvUvso1O6Nl5fOyuNwuBwmUnyRTWcEcnO94Z
         /o1MrvstpU4x8gO+dzfYSPOrSNM4wdy+10AQH2zUu2pBpZIqdWBeVkSRSdVgx7VsI3Ky
         ovf2WRuYjzGWazqo2jf1YVYxDlXF0eBuGCMgASUkMCQCjM78l5qrrZawkSuUuOLy4Tvz
         F4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RAGauJ6ZEC+r3Esqd0QarKOfVAziGmluCtjJT+Ek4nI=;
        b=X+SgIlaBXyDE5/aUrKar3zABDTgWvqrcyU4r6yUlERFecuTjhs7ouCkwUfg5dNEGKz
         crgTZiPz1lW0sLIOUWTJf9rlVoLrLft8zSIyEhZkuZ2m3sNN6pORnPD7znYQCoF0I6qI
         lvl26meBY6N8atjO8X5fbNDMBx/SXWPwcSobjXU0ki1Tu10N08m8PjBcCh/IVOwKMbD0
         /6nnSlI9WlC/fC45x/Pmb2iTS3RAc7bQyujgk2ouw36MylvmNJNBnsnVE8OWgHAt3ukU
         d75ei8OsUOZTDBPiJqOaXdz4qrIndje5RVhhw+k6WwI4+6WCT5S0PVCyROSc0hzO2RPw
         ftNQ==
X-Gm-Message-State: ABUngveVlDBWRpcsFrNiyN5JN/PGz+dl123H37U8sHyUi6Sx8DJKWQ7RZGhf+EqyR8az1EgtwalVT8XzeOuLzg==
X-Received: by 10.107.59.9 with SMTP id i9mr13868811ioa.176.1478683487195;
 Wed, 09 Nov 2016 01:24:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 9 Nov 2016 01:24:16 -0800 (PST)
In-Reply-To: <CACsJy8DjXrOgB-_-t47uSdCQFg9s_o+Oj9NBmAhDFZ3aYvjBgg@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-4-chriscool@tuxfamily.org> <CACsJy8DPt3EJoSTVEZFbH6xXbh78MbLZ4h+50K4eoFxPYSaN=Q@mail.gmail.com>
 <CAP8UFD3hNEU_UeVizU6SVJTt4hqJPag9XWqZOM3FKCGJZXOthg@mail.gmail.com> <CACsJy8DjXrOgB-_-t47uSdCQFg9s_o+Oj9NBmAhDFZ3aYvjBgg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 Nov 2016 16:24:16 +0700
Message-ID: <CACsJy8AisF2ZVs7JdnVFp5wdskkbVQQQ=DBq5UzE1MOsCfBMtQ@mail.gmail.com>
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

On Mon, Nov 7, 2016 at 5:08 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 30, 2016 at 5:06 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Tue, Oct 25, 2016 at 11:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>> +void remove_split_index(struct index_state *istate)
>>>> +{
>>>> +       if (istate->split_index) {
>>>> +               /*
>>>> +                * can't discard_split_index(&the_index); because that
>>>> +                * will destroy split_index->base->cache[], which may
>>>> +                * be shared with the_index.cache[]. So yeah we're
>>>> +                * leaking a bit here.
>>>
>>> In the context of update-index, this is a one-time thing and leaking
>>> is tolerable. But because it becomes a library function now, this leak
>>> can become more serious, I think.
>>>
>>> The only other (indirect) caller is read_index_from() so probably not
>>> bad most of the time (we read at the beginning of a command only).
>>> sequencer.c may discard and re-read the index many times though,
>>> leaking could be visible there.
>>
>> So is it enough to check if split_index->base->cache[] is shared with
>> the_index.cache[] and then decide if discard_split_index(&the_index)
>> should be called?
>
> It's likely shared though. We could un-share cache[] by duplicating
> index entries in the_index.cache[] if they point back to
> split_index->base

I have a patch for this. So don't have to do anything else in this
area. I'll probably just pile my patch on top of your series, or post
it once the series graduates to master.
-- 
Duy

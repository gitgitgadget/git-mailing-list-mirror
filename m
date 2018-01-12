Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490161F406
	for <e@80x24.org>; Fri, 12 Jan 2018 13:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933669AbeALNmF (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 08:42:05 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:37538 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeALNmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 08:42:03 -0500
Received: by mail-ot0-f176.google.com with SMTP id a24so5060205otd.4
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 05:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A9jHlptbpmI2kFvJeAPVPU8F7lWBl2yj8ZY9+4vYWjY=;
        b=C26SVDkgFc8QflzrBBueF6h/WEysUV0aHgrGaKopPZraq46v7G8T7lkvaMfNZW2Er0
         9iql6p7kq0L+p4F6n+ZRoBFXNr6TxeiLBuY3xjAAGIPCgS7PtXIkWc2fHYCi+H9wMDnE
         vO4j7sY+tE4RVcfFEj9VxzaGzCO2f8Rb9EYDwM8Yx+q34kIhxFgu2us4PPfc9wdTu/i9
         7Er16f8lDyh4xJCeEYq2bGT7eD2mOalMyXENhs81WCoYOPo/5bde/8fh7x2336t3koW9
         mNPgvceSJuBB52E4O2uuhV9lyIWJIDkaZ8KQFTVDKkDjxtQN0KZr2kDuzhTxLxsAdgwL
         n1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A9jHlptbpmI2kFvJeAPVPU8F7lWBl2yj8ZY9+4vYWjY=;
        b=R1VNzxEt6jxo4HOfRw1T1Ro5lpuR3+a/m3xFAA974iXec2oLz4G0dpgIMRkSkpglAW
         +9NyK7pfWMlDAFH6764Sm9qW0/05xGaQhm0Mes/LTH+ZEOmrSbjktM3CTIra95wnXD5o
         ICYT9rdJQ2u5wC/mQioW1z7GY2kFtirEnqPnDjMHm2wG3YSSNqv2sFQBRsGnETKB/6PB
         SMXDGSie2C/qEF59WmY0LV8qlXJUT81FAQMW6EG+5kTauXK6nBH1vIJ2hceqXkxtyu/k
         xRpyXEKqO7pm8ceUzUVVN+7QbmXcAA3Y02Ay1wgu614J/OdCOoX0Y8tE2e6y2GpMcWo2
         RqMw==
X-Gm-Message-State: AKwxytfi/TWXsBZVw39u6/qxvgm9rT34b2ipkpNt+wtTe/bP2dowbLwl
        fVx6bDzF02SjE0idJLaYZToWIpdBw+KlqS/dVEg=
X-Google-Smtp-Source: ACJfBouEXp1Y0/0UFx2zYdDFpPBI4kAi8Pxu3NqvvcFquapjUmb924dHQqHYsnmBjSwYsoNkhpnSHmGHmMlN/k5TOsI=
X-Received: by 10.157.53.12 with SMTP id o12mr10290115otc.181.1515764522675;
 Fri, 12 Jan 2018 05:42:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Fri, 12 Jan 2018 05:41:32 -0800 (PST)
In-Reply-To: <CACsJy8AWO5Vk-Qz3VVBUezWL=oAd9YkeGq=_TXGSb0GSs5bLcg@mail.gmail.com>
References: <87inc89j38.fsf@evledraar.gmail.com> <CACsJy8AWO5Vk-Qz3VVBUezWL=oAd9YkeGq=_TXGSb0GSs5bLcg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 12 Jan 2018 20:41:32 +0700
Message-ID: <CACsJy8CUYosOGK5tn0C=t=SkbS-fyaSxp536zx+9jh_O+WNaEQ@mail.gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has
 >6700 loose objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 7:07 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> More generally, these hard limits seem contrary to what the user cares
>> about. E.g. I suspect that most of these loose objects come from
>> branches since deleted in upstream, whose objects could have a different
>> retention policy.
>
> Er.. what retention policy? I think gc.pruneExpire is the only thing
> that can keep loose objects around?

Er... I think I know what you meant now. Loose objects can come from
three sources: worktree (git-hash-object and friends),
git-unpack-objects and unreachable objects in packs released back by
git-repack.

The last one could be a result of a branch deletion like you said.
Depending on the branch size, you could release back a large amount of
objects in loose form at the same time. This really skews my "create
time distributed equally" model and the new estimation in
too_many_objects() probably won't help you much either. If only we
have a way to count all these objects as "one"... but putting these
back in a pack hurts obj lookup performance...
-- 
Duy
